#!/usr/bin/ruby

Dir.foreach("sicp/") { |chapter|
  next if chapter == "." or chapter == ".."
  File.open("static/sicp_#{chapter}_table.html", "w") { |f|
    f.puts "<table>"
    f.puts "<tbody>"
    f.puts "<tr class=\"odd\">"
    f.puts "<td style=\"text-align: right;\"></td>"
    chapter_nb = chapter[/\d+/]
    even = true
    rel_ex_num = 1
    count = Dir.glob("sicp/#{chapter}/*.md").count
    for i in (1..count) do
      if i.modulo(10) == 0 then
        if even then
          f.puts "</tr>"
          f.puts "<tr class=\"even\">"
        else
          f.puts "</tr>"
          f.puts "<tr class=\"odd\">"
        end
        even = !even
      end
      f.puts "<td style=\"text-align: right;\"><a href=\"/sicp/sicp-ex-#{chapter_nb}.#{i}-solution.html\">#{i}</a></td>"
    end
    f.puts "</tr>"
    f.puts "</tbody>"
    f.puts "</table>"
  }
}

