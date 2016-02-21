
This is utf-8 string implementation for [Nim](http://nim-lang.org). It is based on excellent
battle-tested [utf8rewind](https://bitbucket.org/knight666/utf8rewind) library
In order to use this library project must link to utf8rewind.

Notable differences from default Nim string behavior:
ustring follows python string slicing behavior.
`s.slice(1, -1)` is same as `s[1:-1]`` in python, that is first and last characters
will be removed.

Operator `~` introduced for string slicing with negative indexes.
`s[1 ~ -1]` == `s[1..^1]` == `s.slice(1, -1)`
Note that roof operator `^` can be used but it differs from nim default behavior.
`string[1..^2]` == `ustring[1..^1]`

Start and end positions are also non-inclusive. For example in `splice()`. Same is true for all `[]` and `[]=` operators.

Warning:
This is little-tested unfinished code which probably is inefficient and has bugs. Use at your own risk.
