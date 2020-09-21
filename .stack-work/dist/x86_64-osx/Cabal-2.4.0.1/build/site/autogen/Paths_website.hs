{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_website (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/bin"
libdir     = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/lib/x86_64-osx-ghc-8.6.3/website-0.1.0.0-ErurcNjDgS6JwcoWYPYzzQ-site"
dynlibdir  = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/lib/x86_64-osx-ghc-8.6.3"
datadir    = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/share/x86_64-osx-ghc-8.6.3/website-0.1.0.0"
libexecdir = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/libexec/x86_64-osx-ghc-8.6.3/website-0.1.0.0"
sysconfdir = "/Users/vivek/Desktop/vivek-website/.stack-work/install/x86_64-osx/614838d51d581d0e77ac2a1d53163111d246b0f440d58d3c76ede2859a3e9d4c/8.6.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "website_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "website_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "website_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "website_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "website_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "website_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
