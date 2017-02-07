## The MIT License (MIT)
##
## Copyright (c) 2016 Rokas Kupstys
## Copyright (C) 2014-2016 Quinten Lansu
## Copyright (C) 2006-2015 Andreas Rumpf and other contributors
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
##
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.

when not defined(ustringExternalUtf8Rewind):
    when defined(ustringNoNimble):
        const ustringPath = "."
    else:
        const ustringPath = gorge("nimble path ustring")
    const ustringUtf8RewindPath {.strdefine.}: string = ustringPath & "/utf8rewind"
    when defined(vcc) or (defined(icl) and defined(windows)):
        const prefix = "/"
    else:
        const prefix = "-"
    {.passC: prefix & "I" & ustringUtf8RewindPath & "/include/utf8rewind".}
    {.compile: ustringUtf8RewindPath & "/source/utf8rewind.c".}
    {.compile: ustringUtf8RewindPath & "/source/unicodedatabase.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/casemapping.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/codepoint.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/composition.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/database.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/decomposition.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/seeking.c".}
    {.compile: ustringUtf8RewindPath & "/source/internal/streaming.c".}

import macros

type ustring* = distinct string

type UnicodeError* = ref object of ValueError
    error: int

const UTF8_VERSION_MAJOR* = 1
    ## The major version number of this release.

const UTF8_VERSION_MINOR* = 5
    ## The minor version number of this release.

const UTF8_VERSION_BUGFIX* = 1
    ## The bugfix version number of this release.

const UTF8_VERSION* = UTF8_VERSION_MAJOR * 10000 + UTF8_VERSION_MINOR * 100 + UTF8_VERSION_BUGFIX
    ## The version number as an integer.

const UTF8_VERSION_STRING* = $UTF8_VERSION_MAJOR & "." & $UTF8_VERSION_MINOR & "." & $UTF8_VERSION_BUGFIX
    ## The verion number as a string.

template `..-`(a, b: untyped): untyped = a .. (if b == 0: int.high else: -b)
    ## a shortcut for '.. -' to avoid the common gotcha that a space between
    ## '..' and '-' is required. It also adds shortcut for slices. Negative
    ## number as second slice parameter means "end of string", and ``0..-0``
    ## will match entire string.

proc utf8seek(text: cstring, textSize: csize, textStart: cstring, offset: csize, direction: csize): cstring {.importc.}
    ## UTF8_API const char* utf8seek(const char* text, size_t textSize, const char* textStart, off_t offset, int direction);

proc utf8len(text: cstring): csize {.importc.}
    ## UTF8_API size_t utf8len(const char* text);

proc utf8envlocale(): csize {.importc.}
    ## Returns the environment's locale as an enum value.

proc utf8casefold(input: cstring, inputSize: csize, target: cstring, targetSize: csize, locale: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8casefold(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8toupper(input: cstring, inputSize: csize, target: cstring, targetSize: csize, locale: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8toupper(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8tolower(input: cstring, inputSize: csize, target: cstring, targetSize: csize, locale: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8tolower(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8totitle(input: cstring, inputSize: csize, target: cstring, targetSize: csize, locale: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8totitle(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

const UTF8_NORMALIZE_COMPOSE* = 0x00000001
    ## Normalize input to Normalization Form C (NFC).

const UTF8_NORMALIZE_DECOMPOSE* = 0x00000002
    ## Normalize input to Normalization Form D (NFD).

const UTF8_NORMALIZE_COMPATIBILITY* = 0x00000004
    ## Change Normalization Form from NFC to NFKC or from NFD to NFKD.

proc utf8isnormalized(input: cstring, inputSize: csize, flags: csize, errors: ptr csize): cushort {.importc.}
    ## UTF8_API uint8_t utf8isnormalized(const char* input, size_t inputSize, size_t flags, size_t* offset);

proc utf8normalize(input: cstring, inputSize: csize, target: cstring, targetSize: csize, flags: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8normalize(const char* input, size_t inputSize, char* target, size_t targetSize, size_t flags, int32_t* errors);

const UTF8_CATEGORY_LETTER_UPPERCASE* = 0x00000001
    ## Uppercase letter code points, Lu in the Unicode database.

const UTF8_CATEGORY_LETTER_LOWERCASE* = 0x00000002
    ## Lowercase letter code points, Ll in the Unicode database.

const UTF8_CATEGORY_LETTER_TITLECASE* = 0x00000004
    ## Titlecase letter code points, Lt in the Unicode database.

const UTF8_CATEGORY_LETTER_MODIFIER* = 0x00000008
    ## Modifier letter code points, Lm in the Unicode database.

const UTF8_CATEGORY_LETTER_OTHER* = 0x00000010
    ## Other letter code points, Lo in the Unicode database.

const UTF8_CATEGORY_LETTER* =
    (UTF8_CATEGORY_LETTER_UPPERCASE or UTF8_CATEGORY_LETTER_LOWERCASE or
    UTF8_CATEGORY_LETTER_TITLECASE or UTF8_CATEGORY_LETTER_MODIFIER or
    UTF8_CATEGORY_LETTER_OTHER)
    ## Combined flag for all letter categories.

const UTF8_CATEGORY_CASE_MAPPED* =
    (UTF8_CATEGORY_LETTER_UPPERCASE or UTF8_CATEGORY_LETTER_LOWERCASE or
    UTF8_CATEGORY_LETTER_TITLECASE)
    ## Combined flag for all letter categories with case mapping.

const UTF8_CATEGORY_MARK_NON_SPACING* = 0x00000020
    ## Non-spacing mark code points, Mn in the Unicode database.

const UTF8_CATEGORY_MARK_SPACING* = 0x00000040
    ## Spacing mark code points, Mc in the Unicode database.

const UTF8_CATEGORY_MARK_ENCLOSING* = 0x00000080
    ## Enclosing mark code points, Me in the Unicode database.


const UTF8_CATEGORY_MARK* =
    (UTF8_CATEGORY_MARK_NON_SPACING or UTF8_CATEGORY_MARK_SPACING or
    UTF8_CATEGORY_MARK_ENCLOSING)
    ## Combined flag for all mark categories.

const UTF8_CATEGORY_NUMBER_DECIMAL* = 0x00000100
    ## Decimal number code points, Nd in the Unicode database.

const UTF8_CATEGORY_NUMBER_LETTER* = 0x00000200
    ## Letter number code points, Nl in the Unicode database.

const UTF8_CATEGORY_NUMBER_OTHER* = 0x00000400
    ## Other number code points, No in the Unicode database.

const UTF8_CATEGORY_NUMBER* =
    (UTF8_CATEGORY_NUMBER_DECIMAL or UTF8_CATEGORY_NUMBER_LETTER or
    UTF8_CATEGORY_NUMBER_OTHER)
    ## Combined flag for all number categories.

const UTF8_CATEGORY_PUNCTUATION_CONNECTOR* = 0x00000800
    ## Connector punctuation category, Pc in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_DASH* = 0x00001000
    ## Dash punctuation category, Pd in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_OPEN* = 0x00002000
    ## Open punctuation category, Ps in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_CLOSE* = 0x00004000
    ## Close punctuation category, Pe in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_INITIAL* = 0x00008000
    ## Initial punctuation category, Pi in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_FINAL* = 0x00010000
    ## Final punctuation category, Pf in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION_OTHER* = 0x00020000
    ## Other punctuation category, Po in the Unicode database.

const UTF8_CATEGORY_PUNCTUATION* =
    (UTF8_CATEGORY_PUNCTUATION_CONNECTOR or UTF8_CATEGORY_PUNCTUATION_DASH or
    UTF8_CATEGORY_PUNCTUATION_OPEN or UTF8_CATEGORY_PUNCTUATION_CLOSE or
    UTF8_CATEGORY_PUNCTUATION_INITIAL or UTF8_CATEGORY_PUNCTUATION_FINAL or
    UTF8_CATEGORY_PUNCTUATION_OTHER)
    ## Combined flag for all punctuation categories.

const UTF8_CATEGORY_SYMBOL_MATH* = 0x00040000
    ## Math symbol category, Sm in the Unicode database.

const UTF8_CATEGORY_SYMBOL_CURRENCY* = 0x00080000
    ## Currency symbol category, Sc in the Unicode database.

const UTF8_CATEGORY_SYMBOL_MODIFIER* = 0x00100000
    ## Modifier symbol category, Sk in the Unicode database.

const UTF8_CATEGORY_SYMBOL_OTHER* = 0x00200000
    ## Other symbol category, So in the Unicode database.

const UTF8_CATEGORY_SYMBOL* =
    (UTF8_CATEGORY_SYMBOL_MATH or UTF8_CATEGORY_SYMBOL_CURRENCY or
    UTF8_CATEGORY_SYMBOL_MODIFIER or UTF8_CATEGORY_SYMBOL_OTHER)
    ## Combined flag for all symbol categories.

const UTF8_CATEGORY_SEPARATOR_SPACE* = 0x00400000
    ## Space separator category, Zs in the Unicode database.

const UTF8_CATEGORY_SEPARATOR_LINE* = 0x00800000
    ## Line separator category, Zl in the Unicode database.

const UTF8_CATEGORY_SEPARATOR_PARAGRAPH* = 0x01000000
    ## Paragraph separator category, Zp in the Unicode database.

const UTF8_CATEGORY_SEPARATOR* =
    (UTF8_CATEGORY_SEPARATOR_SPACE or UTF8_CATEGORY_SEPARATOR_LINE or
    UTF8_CATEGORY_SEPARATOR_PARAGRAPH)
    ## Combined flag for all separator categories.

const UTF8_CATEGORY_CONTROL* = 0x02000000
    ## Control category, Cc in the Unicode database.

const UTF8_CATEGORY_FORMAT* = 0x04000000
    ## Format category, Cf in the Unicode database.

const UTF8_CATEGORY_SURROGATE* = 0x08000000
    ## Surrogate category, Cs in the Unicode database.

const UTF8_CATEGORY_PRIVATE_USE* = 0x10000000
    ## Private use category, Co in the Unicode database.

const UTF8_CATEGORY_UNASSIGNED* = 0x20000000
    ## Unassigned category, Cn in the Unicode database.

const UTF8_CATEGORY_COMPATIBILITY* = 0x40000000
    ## Flag used for maintaining backwards compatibility with POSIX
    ## functions, not found in the Unicode database.


const UTF8_CATEGORY_IGNORE_GRAPHEME_CLUSTER* = 0x80000000
    ## Flag used for checking only the general category of code points at
    ## the start of a grapheme cluster.

const UTF8_CATEGORY_ISCNTRL* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_CONTROL)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``iscntrl`` function.

const UTF8_CATEGORY_ISPRINT* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER or UTF8_CATEGORY_NUMBER or
    UTF8_CATEGORY_PUNCTUATION or UTF8_CATEGORY_SYMBOL or
    UTF8_CATEGORY_SEPARATOR)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isprint`` function.

const UTF8_CATEGORY_ISSPACE* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_SEPARATOR_SPACE)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isspace`` function.

const UTF8_CATEGORY_ISBLANK* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_SEPARATOR_SPACE or UTF8_CATEGORY_PRIVATE_USE)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isblank`` function.

const UTF8_CATEGORY_ISGRAPH* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER or UTF8_CATEGORY_NUMBER or
    UTF8_CATEGORY_PUNCTUATION or UTF8_CATEGORY_SYMBOL)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isgraph`` function.

const UTF8_CATEGORY_ISPUNCT* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_PUNCTUATION or UTF8_CATEGORY_SYMBOL)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``ispunct`` function.

const UTF8_CATEGORY_ISALNUM* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER or UTF8_CATEGORY_NUMBER)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isalnum`` function.

const UTF8_CATEGORY_ISALPHA* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isalpha`` function.

const UTF8_CATEGORY_ISUPPER* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER_UPPERCASE)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isupper`` function.

const UTF8_CATEGORY_ISLOWER* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_LETTER_LOWERCASE)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``islower`` function.

const UTF8_CATEGORY_ISDIGIT* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_NUMBER)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isdigit`` function.


const UTF8_CATEGORY_ISXDIGIT* =
    (UTF8_CATEGORY_COMPATIBILITY or
    UTF8_CATEGORY_NUMBER or UTF8_CATEGORY_PRIVATE_USE)
    ## Flag used for maintaining backwards compatibility with POSIX
    ## ``isxdigit`` function.


const UTF8_ERR_NONE* = 0
    ## No errors.

const UTF8_ERR_INVALID_DATA* = -1
    ## Input data is invalid.

const UTF8_ERR_INVALID_FLAG* = -2
    ## Input flag is invalid.

const UTF8_ERR_NOT_ENOUGH_SPACE* = -3
    ## Not enough space in buffer to store result.

const UTF8_ERR_OVERLAPPING_PARAMETERS* = -4
    ## Input and output buffers overlap in memory.

const UTF8_ERR_INVALID_LOCALE* = -5
    ## Invalid locale specified.

const UTF8_LOCALE_DEFAULT* = 0
    ## Used for text unaffected by changes in locale.

const UTF8_LOCALE_LITHUANIAN* = 1
    ## Changes behavior of the case mapping implementation when processing
    ## specific code points. For more information, see here:
    ## ftp://ftp.unicode.org/Public/UNIDATA/SpecialCasing.txt

const UTF8_LOCALE_TURKISH_AND_AZERI_LATIN* = 2
    ## Changes behavior of the case mapping implementation when processing
    ## specific code points. For more information, see here:
    ## ftp://ftp.unicode.org/Public/UNIDATA/SpecialCasing.txt

const UTF8_LOCALE_MAXIMUM* = 3
    ## Terminal value for locales. Valid locales do not exceed this value.

proc utf8iscategory(input: cstring, inputSize: csize, flags: csize): csize {.importc.}
  ## UTF8_API size_t utf8iscategory(const char* input, size_t inputSize, size_t flags);

proc `$`*(s: ustring): string {.magic: "StrToStr", noSideEffect.}
    ## Converts ustring to string

proc len*(s: ustring): int = utf8len(cstring(s))
    ## Gets length of ustring in characters

proc uhigh*(s: ustring): int = string(s).low + s.len - 1
    ## Returns highest possible utf-8 character index

proc offset(s: ustring, oft: int=int.high): int =
    if oft == int.high:
        result = s.len
    elif oft < 0:
        result = s.len + oft
    else:
        result = oft

proc blen*(s: ustring): int = string(s).len
    ## Gets length of ustring in bytes

proc getRefcount*(s: ustring): int = getRefcount(string(s))
    ## retrieves the reference count of an heap-allocated object. The
    ## value is implementation-dependent.

proc isNil*(s: ustring): bool = string(s).isNil
    ## Fast check whether ``s`` is nil. This is sometimes more efficient than
    ## ``== nil``.

proc GC_ref*(s: ustring) = GC_ref(string(s))
    ## marks the object ``s`` as referenced, so that it will not be freed until
    ## it is unmarked via ``GC_unref``. If called n-times for the same object ``s``,
    ## n calls to ``GC_unref`` are needed to unmark ``s``.

proc GC_unref*(s: ustring) = GC_unref(string(s))
    ## see the documentation of ``GC_ref``.

converter toUString*(s: string): ustring = ustring(s)
    ## Converts ``string`` type to ``ustring``

converter toUString*(s: cstring): ustring = $s
    ## Converts ``cstring`` type to ``ustring``

converter toUString*(c: char): ustring = $c
    ## Converts ``cstring`` type to ``ustring``

converter toString*(s: ustring): string = string(s)
    ## Converts ``ustring`` type to ``string``

converter toCString*(s: ustring): cstring = cstring(s)
    ## Converts ``ustring`` type to ``cstring``

template addSymbol(c: untyped): untyped =
    unescaped.add(c)
    inc i

proc unescapeRawString(x: string): string {.compileTime.} =
    ## Converts string litteral to ``ustring``.
    ## Since string litteral prefixed with ``u`` is treated as raw string we unescape escaped characters at compile time.
    var unescaped = newStringOfCap(x.blen)
    var i = 0
    while i < x.len:
        if x[i] == '\\':
            if i >= x.high:
                error("closing \" expected")
                break
            case x[i + 1]
            of 'n', 'N':
                addSymbol("\n")
            of 'r', 'R', 'c', 'C':
                addSymbol('\r')
            of 'l', 'L':
                addSymbol('\l')
            of 'f', 'F':
                addSymbol('\f')
            of 'e', 'E':
                addSymbol('\e')
            of 'a', 'A':
                addSymbol('\a')
            of 'b', 'B':
                addSymbol('\b')
            of 'v', 'V':
                addSymbol('\v')
            of 't', 'T':
                addSymbol('\t')
            of '\\':
                addSymbol('\\')
            of 'x', 'X':
                addSymbol('\x')
            of '0'..'9':
                if (i + 2) < x.len:
                    if x[i + 1] == '0' and x[i + 2] in {'0'..'9'}:
                        warning("octal escape sequences do not exist; leading zero is ignored")
                inc(i)
                var xi = 0
                while i <= x.high and x[i] in {'0'..'9'}:
                    xi = (xi * 10) + (ord(x[i]) - ord('0'))
                    inc(i)

                if xi <= 255:
                    unescaped.add(chr(xi))
                else:
                    error("invalid character constant")
            else:
                error("invalid character constant")
        else:
            unescaped.add(x[i])
        inc i
    return unescaped.toUString()

macro u*(x: typed): untyped =
    var s: string
    if x.kind == nnkRStrLit:
        s = unescapeRawString($x)
    else:
        s = $x
    # Call
    #   DotExpr
    #     StrLit asd
    #     Ident !"toUString
    return newStmtList(
        newNimNode(nnkCall).add(
            newNimNode(nnkDotExpr).add(
                newStrLitNode(s),
                newIdentNode("toUString")
            )
        )
    )

proc posBytes*(c: cstring, pos: int): int =
    ## Returns byte position of character ``pos``
    var s = utf8seek(c, csize(c.len), c, csize(pos), 0)
    return c.len - s.len

proc charLen*(c: cstring, pos: int): int =
    var s1 = utf8seek(c, csize(c.len), c, csize(pos), 0)
    var s2 = utf8seek(s1, csize(s1.len), s1, csize(1), 0)
    return s1.len - s2.len

proc `&`*(a, b: ustring): ustring = string(a) & string(b)
    ## Concatenates ``string``/``char`` to ustring

proc `&=`*(a: var ustring, b: ustring) = string(a) &= string(b)
    ## Concatenates ``string``/``char`` to ustring

proc `==`*(a, b: ustring): bool = string(a) == string(b)
    ## Checks for equality between ``ustring`` and ``string`` variables

proc `==`*(a: ustring, b: string): bool = string(a) == b
    ## Checks for equality between ``ustring`` and ``string`` variables

proc slice*(s: ustring, first: int): ustring = s.substr(s.posBytes(s.offset(first)), s.high)
    ## Returns string slice ``[fist, s.high]``. ``first`` can be negative in which case it will count positions from
    ## the end, ``-1`` being ``s.len - 1``.

proc slice*(s: ustring, first: int, last: int): ustring =
    ## Returns string slice ``[first, last]``. ``first`` and ``last`` can be
    ## negative. If they are negative position is counted from the end of string.
    var st = s.offset(first)
    var e = s.offset(last)
    if last < 0:
        e -= 1
    if e < st:
        raise UnicodeError(msg: "Start position is further than end position")
    return s.substr(s.posBytes(st), s.posBytes(e) + s.charLen(e) - 1)

proc slice*(s: ustring, slice: Slice[int]): ustring {.inline.} = s.slice(slice.a, slice.b)
    ## Returns string slice ``[slice.a, slice.b]``. ``first`` and ``last`` can be
    ## negative. If they are negative position is counted from the end of string.


proc substr*(s: ustring, first = 0): string =
    ## copies a slice of `s` into a new string and returns this new
    ## string. The bounds `first` and `last` denote the indices of
    ## the first and last characters that shall be copied. If ``last``
    ## is omitted, it is treated as ``high(s)``. If ``last >= s.len``, ``s.len``
    ## is used instead: This means ``substr`` can also be used to `cut`:idx:
    ## or `limit`:idx: a string's length.
    return s.slice(first)

proc substr*(s: ustring, first, last: int): string =
    ## copies a slice of `s` into a new string and returns this new
    ## string. The bounds `first` and `last` denote the indices of
    ## the first and last characters that shall be copied. If ``last``
    ## is omitted, it is treated as ``high(s)``. If ``last >= s.len``, ``s.len``
    ## is used instead: This means ``substr`` can also be used to `cut`:idx:
    ## or `limit`:idx: a string's length.
    return s.slice(first, last)

proc `[]`*(s: ustring, slice: Slice[int]): ustring {.inline.} = s.slice(slice)
    ## Returns string slice ``[slice.a, slice.b]``.

proc `[]`*(s: ustring, i: int): ustring =
    ## Returns character index ``i``.
    let o = s.offset(i)
    result = s.slice(o, o)

proc splice*(s: ustring, first: int, last: int, replacement: ustring): ustring {.inline.} =
    ## Replaces ``[first, last]`` with ``replacement``.
    result = ""
    if first > 0:
        result &= s.slice(0, first - 1)
    elif first < 0:
        result &= s.slice(0, first)
    result &= replacement
    if last == int.high or last > s.uhigh:
        discard
    elif last > 0:
        result &= s.slice(last + 1)
    else:
        result &= s.slice(last)

proc splice*(s: ustring, slice: Slice[int], replacement: ustring): ustring {.inline.} = s.splice(slice.a, slice.b, replacement)
    ## Replaces ``[slice.a, slice.b]`` with ``replacement``.

proc `[]=`*(s: var ustring, slice: Slice[int], replacement: ustring) {.inline.} = s = s.splice(slice, replacement)
    ## Replaces ``[slice.a, slice.b]`` with ``replacement`` in ``s``.

proc `[]=`*(s: var ustring, i: int, replacement: ustring) {.inline.} = s = s.splice(i, i, replacement)
    ## Replaces character at position ``i`` with ``replacement`` in ``s``.

proc upper*(s: ustring, locale: int=utf8envlocale()): ustring =
    ## Converts utf-8 string to upper case.
    result = newString(s.blen).toUString()
    var errors: csize = 0
    discard utf8toupper(cstring(s), csize(s.blen), cstring(result), csize(s.blen), locale, addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)

proc lower*(s: ustring, locale: int=utf8envlocale()): ustring =
    ## Converts utf-8 string to lower case.
    result = newString(s.blen).toUString()
    var errors: csize = 0
    discard utf8tolower(cstring(s), csize(s.blen), cstring(result), csize(s.blen), locale, addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)

proc title*(s: ustring, locale: int=utf8envlocale()): ustring =
    ## Converts utf-8 string to titlecase.
    result = newString(s.blen).toUString()
    var errors: csize = 0
    discard utf8totitle(cstring(s), csize(s.blen), cstring(result), csize(s.blen), locale, addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)

proc casefold*(s: ustring, locale: int=utf8envlocale()): ustring =
    ## Eliminates differences between code points case mapping.
    result = newString(s.blen).toUString()
    var errors: csize = 0
    discard utf8casefold(cstring(s), csize(s.blen), cstring(result), csize(s.blen), locale, addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)

proc isNormalized*(s: ustring, flags: int): bool =
    ## Checks if utf-8 string is normalized.
    var errors: csize = 0
    result = utf8isnormalized(cstring(s), csize(s.blen), csize(flags), addr(errors)) != 0
    if errors != 0:
        raise UnicodeError(error: errors)

proc normalize*(s: ustring, flags: int): ustring =
    ## Normalizes utf-8 string.
    var errors: csize = 0
    var need_count = utf8normalize(cstring(s), csize(s.blen), nil, 0, csize(flags), addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)
    if need_count == 0:
        return ""
    result = newString(need_count).toUString()
    var got_count = utf8normalize(cstring(s), csize(s.blen), cstring(result),  need_count, csize(flags), addr(errors))
    if errors != 0:
        raise UnicodeError(error: errors)
    assert got_count == need_count

iterator items*(s: ustring): ustring =
    ## Loops ut-8 characters from the start.
    for i in 0 .. s.uhigh:
        yield s.slice(i, i)

iterator ritems*(s: ustring): ustring =
    ## Loops utf-8 characters from the end.
    for i in countdown(s.uhigh, 0):
        yield s.slice(i, i)

proc reversed*(s: ustring): ustring =
    ## Returns reversed string.
    result = newStringOfCap(s.len)
    for c in ritems(s):
        result &= c

proc isCategory*(s: ustring, flags: int): bool =
    ## Returns ``true`` if all characters of string fall into category specified
    ## by ``flags``, ``false`` otherwise.
    return utf8iscategory(cstring(s), csize(s.blen), csize(flags)) == s.blen

proc isLower*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISLOWER)
    ## Returns ``true`` if ``s`` is lower case, ``false`` otherwise.

proc isUpper*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISUPPER)
    ## Returns ``true`` if ``s`` is upper case, ``false`` otherwise.

proc isAlpha*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISALPHA)
    ## Returns ``true`` if ``s`` is made of alpha characters, ``false`` otherwise.

proc isNumeric*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISDIGIT)
    ## Returns ``true`` if ``s`` is made of numeric characters, ``false`` otherwise.

proc isAlphaNumeric*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISALNUM)
    ## Returns ``true`` if ``s`` is made of alpha and/or numeric, ``false`` otherwise.

proc isWhitespace*(s: ustring): bool = isCategory(s, UTF8_CATEGORY_ISSPACE)
    ## Returns ``true`` if ``s`` is made of whitespace characters, ``false`` otherwise.

proc startsWith*(s: ustring, substring: ustring): bool = s[0..substring.uhigh] == substring
    ## Returns ``true`` if ``s`` starts with substring ``substring``, ``false`` otherwise.

proc endsWith*(s: ustring, substring: ustring): bool = s[s.len - substring.len..int.high] == substring
    ## Returns ``true`` if ``s`` starts with substring ``substring``, ``false`` otherwise.

proc find*(s: ustring, substring: ustring, start: int=0): int =
    ## Returns index of first occurrence of ``substring`` in ``s``, -1 if ``substring`` is not found. Search starts from beginning of string.
    for i in s.offset(start) .. s.len - substring.uhigh:
        if s[i..i + substring.uhigh] == substring:
            return i
    return -1

proc rfind*(s: ustring, substring: ustring, start: int=int.high): int =
    ## Returns index of first occurrence of ``substring`` in ``s``, -1 if ``substring`` is not found. Search starts from end of string.
    for i in countdown(s.offset(start) - substring.len, 0):
        if s[i..i + substring.uhigh] == substring:
            return i
    return -1

proc contains*(s: ustring, substring: ustring): bool {.inline.} = s.find(substring) >= 0
    ## Returns ``true`` if ``s`` contains substring ``substring``, ``false`` otherwise.

proc replace*(s: ustring, find: ustring, replacement: ustring): ustring =
    ## Replaces all occourences of ``find`` in ``s`` with ``replacement``.
    result = s
    var i = result.find(find)
    while i >= 0:
        result = result.splice(i, i + find.uhigh, replacement)
        i = result.find(find)

proc count*(s: ustring, substring: ustring, overlapping: bool = false): int =
    ## Count the occurrences of a substring ``substring`` in the string ``s``.
    ## Overlapping occurrences of ``substring`` only count when ``overlapping``
    ## is set to true.
    var i = 0
    while true:
        i = s.find(substring, i)
        if i < 0:
            break
        if overlapping:
            inc i
        else:
            i += substring.len
        inc result

iterator split*(s, substring: ustring): ustring =
    ## Splits string ``s`` into parts by ``substring`` substring.
    var i, p = 0
    while true:
        p = i
        i = s.find(substring, i)
        if i < 0:
            yield s[p..int.high]
            break
        yield s[p..i - 1]
        i += substring.len

when defined(windows) and not defined(useWinAnsi):
    # Untested
    # type
    #     Utf16Char* = distinct int16
    #     WideCString* = ref array[0.. 1_000_000, Utf16Char]
    #
    # proc len*(w: WideCString): int =
    #       ## returns the length of a widestring. This traverses the whole string to
    #       ## find the binary zero end marker!
    #       while int16(w[result]) != 0'i16: inc result

    proc utf8towide(input: cstring, inputSize: csize, target: WideCString, targetSize: csize, errors: ptr csize): csize {.importc.}
        ## UTF8_API size_t utf8towide(const char* input, size_t inputSize, wchar_t* target, size_t targetSize, int32_t* errors);

    proc widetoutf8(input: WideCString, inputSize: csize, target: ptr ustring, targetSize: csize, errors: ptr csize): csize {.importc.}
        ## UTF8_API size_t widetoutf8(const wchar_t* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

    converter toWString(s: ustring): WideCString =
        var errors: csize = 0
        var need_count = utf8towide(cstring(s), csize(s.blen), nil, 0, addr(errors))
        if errors != 0:
            raise UnicodeError(error: errors)
        if need_count == 0:
            return ""
        unsafeNew(result, need_count * sizeof(Utf16Char))
        var got_count = utf8towide(cstring(s), csize(s.blen), result, need_count, addr(errors))
        if errors != 0:
            raise UnicodeError(error: errors)
        assert got_count == need_count
        result[need_count] = Utf16Char(0)

    converter fromWString(x: WideCString): ustring =
        var errors: csize = 0
        var need_count = widetoutf8(x, csize(s.len), nil, 0, addr(errors))
        if errors != 0:
            raise UnicodeError(error: errors)
        if need_count == 0:
            return ""
        result = newString(need_count)
        var got_count = widetoutf8(x, csize(s.len), addr(result), need_count, addr(errors))
        if errors != 0:
            raise UnicodeError(error: errors)
        assert got_count == need_count
        result[need_count] = '\0'


when isMainModule:
    import future
    doAssert u"abc".charLen(1) == 1
    doAssert u"ačc".charLen(1) == 2
    doAssert "abcdefgh"[1..^2] == u"abcdefgh"[1..^2]
    doAssert u"ąčęėįšųū„“".offset(1) == 1
    doAssert u"ąčęėįšųū„“".offset(-1) == 9
    doAssert u"ąčęėįšųū„“".offset(-2) == 8
    doAssert u"ąčęėįšųū„“".offset() == 10
    doAssert "ąčęėįšųū„“" == $(u"ąčęėįšųū„“")
    doAssert u"ąčęėįšųū„“".len == 10
    doAssert u"ąčęėįšųū„“".blen == "ąčęėįšųū„“".len
    doAssert u"ąčęėįšųū„“" == "ąčęėįšųū„“"
    doAssert u"ąčęėįšųū„“" == cstring("ąčęėįšųū„“")
    doAssert "a".toUString() == 'a'
    doAssert u"ąčęėįšųū„“" & u"ąčęėįšųū„“" == "ąčęėįšųū„“ąčęėįšųū„“"
    block:
        var s = u"ąčęėįšųū„“"
        var refcount = s.getRefcount()
        s.GC_ref()
        doAssert s.getRefcount() == (refcount + 1)
        s.GC_unref()
        doAssert s.getRefcount() == refcount
    doAssert u"ąčęėįšųū„“"[2..int.high] == "ęėįšųū„“"
    doAssert u"ąčęėįšųū„“"[-1..int.high] == u"“"
    doAssert u"ąčęėįšųū„“"[4..-2] == "įšųū"
    doAssert u"ąčęėįšųū„“"[-4..-2] == "ųū"
    doAssert u"ąčęėįšųū„“"[1..^2] == "čęėįšųū„"
    doAssert u"ąčęėįšųū„“"[1..-1] == "čęėįšųū„"
    doAssert u"ąčęėįšųū„“"[1..-0] == "čęėįšųū„“"
    try:
        discard u"ąčęėįšųū„“".slice(-4, -6)
        doAssert false, "slice() invalid parameter check failed"
    except UnicodeError:
        discard

    doAssert u"ąčęėįšųū„“".splice(0, 4, "?") == "?šųū„“"
    doAssert u"ąčęėįšųū„“".splice(2, 4, "?") == "ąč?šųū„“"
    doAssert u"ąčęėįšųū„“".splice(-8, 4, "?") == "ąč?šųū„“"
    block:
        var x = u"ąčęėįšųū„“"
        x[-5..-1] = "!!!"
        doAssert x == "ąčęėį!!!“"
        x[1] = "我"
        doAssert x == "ą我ęėį!!!“"
        doAssert x[1] == "我"
    doAssert u"ąčęėįšųū".upper() == "ĄČĘĖĮŠŲŪ"
    doAssert u"ĄČĘĖĮŠŲŪ".lower() == "ąčęėįšųū"
    doAssert u"ąčęėįšųū„“".title() == "Ąčęėįšųū„“"
    doAssert u"ĄČĘĖĮŠŲŪ".casefold() == "ąčęėįšųū"
    doAssert u"διαφορετικούς".normalize(UTF8_NORMALIZE_COMPOSE) == "διαφορετικούς"
    doAssert u"ąčęėįšųū„“".reversed() == "“„ūųšįėęčą"
    doAssert u"ūųšįėęčą".isLower() == true
    doAssert u"Ąūųšįėęčą".isLower() == false
    doAssert u"ĄČĘĖĮŠŲŪ".isUpper() == true
    doAssert u"Ąūųšįėęčą".isUpper() == false
    doAssert u"Ąūųšįėęčą".isAlpha() == true
    doAssert u"12345".isNumeric() == true
    doAssert u"Ąūųšįėęčą12345".isNumeric() == false
    doAssert u"\r\t\n ".isWhitespace() == true
    doAssert u"\r\n\t \\\64" == "\r\n\t \\\64"
    doAssert u"\r\n\t \\\64" == "\r\n\t \\\64".u
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".find("š") == 3
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".find("Ą", 1) == 9
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".rfind("š") == 12
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".rfind("ą") == 17
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".rfind("ą", -1) == 8
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".find("Ą") == 0
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".rfind("ą") == 17
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".rfind("測") == -1
    doAssert "ėįš" in u"ąčęėįšųū„“"
    doAssert u"ąčęėįšųū„“".replace("ėįš", "δια") == "ąčęδιαųū„“"
    doAssert u"ąčęėįšųū„“".replace("ū„“", "δια") == "ąčęėįšųδια"
    doAssert u"ąčęėįšųū„“".replace("ąčę", "δια") == "διαėįšųū„“"
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".count("ę") == 2
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".count("šį") == 2
    doAssert u"ĄūųšįėęčąĄūųšįėęčą".count("δια") == 0
    doAssert u"ąčęėįšųū„“".startsWith("ąčęė") == true
    doAssert u"ąčęėįšųū„“".startsWith("šųū„“") == false
    doAssert u"ąčęėįšųū„“".endsWith("ąčęė") == false
    doAssert u"ąčęėįšųū„“".endsWith("šųū„“") == true
    doAssert lc[p | (p <- u"ąčęėįšųū„“".split("ėį")), ustring] == @[u"ąčę", u"šųū„“"]
    doAssert lc[c | (c <- u"ąčęėįšųū„“".items()), ustring] == @[u"ą", u"č", u"ę", u"ė", u"į", u"š", u"ų", u"ū", u"„", u"“"]
    doAssert lc[c | (c <- u"ąčęėįšųū„“".ritems()), ustring] == @[u"“", u"„", u"ū", u"ų", u"š", u"į", u"ė", u"ę", u"č", u"ą"]
    doAssert u"ąčęėįšųū„“".slice(1, -1) == u"ąčęėįšųū„“"[1..^2]
    doAssert u"ąčęėįšųū„“"[-3..-1] == u"ąčęėįšųū„“"[-3..^2]
    doAssert substr(u"abcdefgh", 3) == substr("abcdefgh", 3)
    doAssert substr(u"abcdefgh", 1, 3) == substr("abcdefgh", 1, 3)
    doAssert substr(u"ąčęėįšųū„“", 3) == "ėįšųū„“"
    doAssert substr(u"ąčęėįšųū„“", 1, 3) == "čęė"
    echo "Tests ok"
