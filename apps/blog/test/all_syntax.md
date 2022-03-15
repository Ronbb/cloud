# Title

## Header 2

### Header 3

#### Header 4

##### Header 5

###### Header 6

body

body

_This text will be italic_
_This will also be italic_

**This text will be bold**
**This will also be bold**

_You **can** combine them_

~~This text will be strikethrough~~

[GitHub](https://github.com)

As Kanye West said:

> We're living the future so
> the present is our past.

---

I think you should use an
`<addr>` element here instead.

---

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

---

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

---

30^th^
:smile:
:fa-car:
H~2~O
Content [^1]

[^1]: Hi! This is a footnote

*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
The HTML specification
is maintained by the W3C.

==marked==

$f(x) = sin(x)$

---

list1:

- list1
- list1
  - list1
  - list1

list2:

- list2
- list2

list3:

1. list3
1. list3
1. list3
   1. list3
   1. list3

list4:

- [x] list4
- [ ] list4
- [ ] list4
