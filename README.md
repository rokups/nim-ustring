
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

If you wish to use custom utf8rewind library:

* Build your project with `-d:ustringUtf8RewindPath=/path/to/utf8rewind-source`

If you wish to use external utf8rewind library (provided by your package manager for example):

* Build with `-d:ustringExternalUtf8Rewind`
