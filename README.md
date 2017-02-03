
ustring
=======

This is utf-8 string implementation for [Nim](http://nim-lang.org). It is based on excellent
battle-tested [utf8rewind](https://bitbucket.org/knight666/utf8rewind) library
In order to use this library project must link to utf8rewind.

Features
========

* Common string manipulation functions
* Converters to and from `string`, `cstring`, `char`
* Nim string slicing with roof (^) operator
* Pythonic string slicing with negative indexes
* String manipulation functions using inclusive ranges

Usage
=====

* `nimble install ustring`
* Download [utf8rewind](https://bitbucket.org/knight666/utf8rewind) and extract.
* Build your project with `-d:ustringUtf8rewindPath=/path/to/utf8rewind`

Warning:
This is little-tested unfinished code which probably is inefficient, has bugs and is subject to change. Use at your own risk.
