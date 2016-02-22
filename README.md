
ustring
=======

This is utf-8 string implementation for [Nim](http://nim-lang.org). It is based on excellent
battle-tested [utf8rewind](https://bitbucket.org/knight666/utf8rewind) library
In order to use this library project must link to utf8rewind.

Features
========

* Common string manipulation functions
* Converters to and from `string`, `cstring`, `char`
* Pythonic string slicing

Pythonic string slicing
=======================

By default `ustring` follows Nim's default behavior. `slice()`, `splice()` and `[]=` use inclusive ranges. This can be changed by defining `--define:ustringPythonic`. Then said functions use non-inclusive ranges in order
`s.slice(1, -1)` is same as `s[1:-1]` in python, that is first and last characters
will be removed.

Operator `~` introduced for string slicing with negative indexes.
Note that roof operator `^` can be used but it differs from nim default behavior when this mode is enabled.

End positions are also non-inclusive. For example in `splice()`. Same is true for all `[]` and `[]=` operators.

`string[1..^2]` == `ustring[1..^1]`

`ustring[1 ~ -1]` == `ustring[1..^1]` == `ustring.slice(1, -1)` - remvoes first and last characters.

`ustring[-3 ~ -1]` == `string[len(string)-3 .. ^2]`

Default string slicing
======================
`string[1..^2]` == `ustring[1..^2]`

`ustring[1 ~ -2]` == `ustring[1..^2]` == `ustring.slice(1, -2)` - remvoes first and last characters.

Warning:
This is little-tested unfinished code which probably is inefficient and has bugs. Use at your own risk.
