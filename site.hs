--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Hakyll
import           Control.Applicative (empty)
import           Data.List           (isInfixOf)
import           Text.Pandoc
-- import           Hakyll.Metadata (setFiled, getField)
-- For slug title
import           Data.Maybe    (fromMaybe)
import qualified Data.Text     as T
import           System.FilePath
import           System.Process

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "main_pages/nav.md" $ do
        route $ mainPagesRoute
        compile $ myPandocCompiler
            >>= loadAndApplyTemplate "templates/nav.html" defaultCtx

    match "main_pages/index.md" $ do
        route $ mainPagesRoute
        compile $ myPandocCompiler
            >>= loadAndApplyTemplate "templates/index.html" defaultCtx
            >>= loadAndApplyTemplate "templates/default.html" defaultCtx
            >>= relativizeUrls

    match "main_pages/sicp.md" $ do
        route $ mainPagesRoute
        compile $ myPandocCompiler
            >>= loadAndApplyTemplate "templates/sicp.html" defaultCtx
            >>= loadAndApplyTemplate "templates/default.html" defaultCtx
            >>= relativizeUrls

    match "main_pages/*" $ do
        route $ mainPagesRoute
        compile $ myPandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultCtx
            >>= relativizeUrls

    match "sicp/*/*.md" $ do
        let sicpCtx = setTitleFromExNumber "title" <>
                      setExNumberFromPath "ex" <>
                      defaultCtx
        route $ sicpRoute
        compile $ myPandocCompiler
            >>= loadAndApplyTemplate "templates/sicp_exercise.html" sicpCtx
            >>= loadAndApplyTemplate "templates/default.html" sicpCtx
            >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler

    match ("images/*" .||. "static/*") $ do
        route   idRoute
        compile copyFileCompiler

--------------------------------------------------------------------------------
-- Adds MathJax JS if there is a math class in html body
mathCtx :: Context String
mathCtx = field "math" (\i -> if "class=\"math" `isInfixOf` (itemBody i)
            then return $ unlines
            ["<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>",
             "<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>"]
            else empty)

--------------------------------------------------------------------------------
-- Adds code.css to style sheets if there is sourceCode tag in body
codeCtx :: Context String
codeCtx = field "code" (\i -> if "sourceCode" `isInfixOf` (itemBody i)
            then return "<link rel=\"stylesheet\" href=\"/css/code.css\">\n"
            else empty)

--------------------------------------------------------------------------------
-- Makes "custom_css" metadata field available in templates
customCssCtx :: Context a
customCssCtx = field "custom_css" $ \item -> do
    metadata <- getMetadata (itemIdentifier item)
    return $ fromMaybe "" $ lookupString "custom_css" metadata

--------------------------------------------------------------------------------
defaultCtx :: Context String
defaultCtx = mathCtx <> codeCtx <> customCssCtx <> defaultContext

--------------------------------------------------------------------------------
dropMainPagesPrefix :: Routes
dropMainPagesPrefix = gsubRoute "main_pages/" $ const ""

--------------------------------------------------------------------------------
mainPagesRoute :: Routes
mainPagesRoute = dropMainPagesPrefix `composeRoutes` setExtension "html"

--------------------------------------------------------------------------------
myPandocCompiler :: Compiler (Item String)
myPandocCompiler =
  pandocCompilerWith
  defaultHakyllReaderOptions {readerExtensions = disableExtension Ext_auto_identifiers (readerExtensions defaultHakyllReaderOptions)}
  defaultHakyllWriterOptions { writerHTMLMathMethod = MathJax "" }

--------------------------------------------------------------------------------
-- Ex: if file is /a/b/1.1.md
--     route becomes /a/b/sicp-ex-1.1-solution.html
-- Looks ugly, but leads to better SEO on google for people to find these solutions
sicpRoute :: Routes
sicpRoute = customRoute createSicpRoute
    where
        createSicpRoute ident = takeDirectory (takeDirectory p) </> "sicp-ex-" ++ takeBaseName p ++ "-solution.html"
                            where p = toFilePath ident

--------------------------------------------------------------------------------
-- Ex: if file is /a/b/1.1.md
--     $ex$ will be 1.1
-- Avoids having to write ex as a metadata field for each SICP exercise
setExNumberFromPath :: String -> Context a
setExNumberFromPath key = mapContext transform (pathField key)
    where
        transform path = takeBaseName path

--------------------------------------------------------------------------------
-- Ex: if file is /a/b/1.1.md
--     $title$ will be SICP Ex 1.1 Solution
-- Avoids having to write title as a metadata field for each SICP exercise
setTitleFromExNumber :: String -> Context a
setTitleFromExNumber key = mapContext transform (pathField key)
    where
        transform path = "SICP Ex " ++ takeBaseName path ++ " Solution"
