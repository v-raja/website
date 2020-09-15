#!/usr/bin/ruby

for i in 10..20
  name = "../sicp/ch2/2.#{i}.md"
  File.open(name, "w") { |f|
    f.write(
      "Q.

```scheme

```")
  }
end
