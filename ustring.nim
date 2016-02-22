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

type ustring* = distinct string

when defined(ustringPythonic):
    const oneOff = 1
        ## Constant that provides easy switching between inclusive and non-inclusive slice handling.
else:
    const oneOff = 0

proc utf8seek(text: cstring, textSize: csize, textStart: cstring, offset: csize, direction: csize): cstring {.importc.}
    ## UTF8_API const char* utf8seek(const char* text, size_t textSize, const char* textStart, off_t offset, int direction);

proc utf8len(text: cstring): csize {.importc.}
    ## UTF8_API size_t utf8len(const char* text);

proc utf8casefold(input: cstring, inputSize: csize, target: cstring, targetSize: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8casefold(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8toupper(input: cstring, inputSize: csize, target: cstring, targetSize: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8toupper(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8tolower(input: cstring, inputSize: csize, target: cstring, targetSize: csize, errors: ptr csize): csize {.importc.}
    ## UTF8_API size_t utf8tolower(const char* input, size_t inputSize, char* target, size_t targetSize, int32_t* errors);

proc utf8totitle(input: cstring, inputSize: csize, target: cstring, targetSize: csize, errors: ptr csize): csize {.importc.}
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

proc utf8iscategory(input: cstring, inputSize: csize, flags: csize): csize {.importc.}
  ## UTF8_API size_t utf8iscategory(const char* input, size_t inputSize, size_t flags);

proc `$`*(x: ustring): string {.magic: "StrToStr", noSideEffect.}
    ## Converts ustring to string

proc len*(x: ustring): int = utf8len(cstring(x))
    ## Gets length of ustring in characters

proc uhigh*(x: ustring): int = string(x).low() + x.len() - 1
    ## Returns highest possible utf-8 character index

proc offset(x: ustring, oft: int=high(int)): int =
    if oft == high(int):
        result = x.len - 1
    elif oft < 0:
        result = x.len + oft - oneOff
    else:
        result = oft

proc blen*(x: ustring): int = string(x).len
    ## Gets length of ustring in bytes

proc getRefcount*(x: ustring): int = getRefcount(string(x))
    ## retrieves the reference count of an heap-allocated object. The
    ## value is implementation-dependent.

proc isNil*(x: ustring): bool = string(x).isNil
    ## Fast check whether ``x`` is nil. This is sometimes more efficient than
    ## ``== nil``.

proc GC_ref*(x: ustring) = GC_ref(string(x))
    ## marks the object ``x`` as referenced, so that it will not be freed until
    ## it is unmarked via ``GC_unref``. If called n-times for the same object ``x``,
    ## n calls to ``GC_unref`` are needed to unmark ``x``.

proc GC_unref*(x: ustring) = GC_unref(string(x))
    ## see the documentation of ``GC_ref``.

converter toUString*(x: string): ustring = ustring(x)
    ## Converts ``string`` type to ``ustring``

converter toUString*(x: cstring): ustring = ustring($x)
    ## Converts ``cstring`` type to ``ustring``

converter toUString*(x: char): ustring = ustring($x)
    ## Converts ``cstring`` type to ``ustring``

converter toString(x: ustring): string = string(x)
    ## Converts ``ustring`` type to ``string``

converter toCString(x: ustring): cstring = cstring(x)
    ## Converts ``ustring`` type to ``cstring``

proc u*[T](x: T): ustring = x.toUString()
    ## Converts supported types to ``ustring``

proc posBytes(c: cstring, pos: int): int =
    ## Returns byte position of character ``pos``
    var s = utf8seek(c, csize(c.len), c, csize(pos), 0)
    return c.len - s.len

proc slice*(x: ustring, startPos: int=0, endPos: int=high(int)): ustring =
    ## Returns string slice ``[startPos, endPos)``. ``startPos`` and ``endPos`` can be
    ## negative. If they are negative position is counted from the end of string.
    ## ``startPos`` = 0 means start of the string. ``endPos`` = 0 means end of the string.
    var c = cstring(x)
    var e = endPos
    var s = startPos
    if startPos < 0:
        s = x.len + startPos
    if endPos < 0:
        e = x.len + endPos
    elif endPos == high(int):
        e = x.len
    when not defined(ustringPythonic):
        e += 1
    if e < s:
        raise (ref ValueError)()
    var sub = if s > 0: utf8seek(c, csize(c.len), c, csize(s), 0) else: c
    return ($sub).substr(0, sub.posBytes(e - s) - 1)

proc `&`*(x, y: ustring): ustring = string(x) & string(y)
    ## Concatenates ``string``/``char`` to ustring

proc `&=`*(x: var ustring, y: ustring) = string(x) &= string(y)
    ## Concatenates ``string``/``char`` to ustring

proc `==`*(x, y: ustring): bool = string(x) == string(y)
    ## Checks for equality between ``ustring`` and ``string`` variables

proc `==`*(x: ustring, y: string): bool = string(x) == y
    ## Checks for equality between ``ustring`` and ``string`` variables

proc `[]`*(x: ustring, s: Slice[int]): ustring {.inline.} = x.slice(s.a, s.b)
    ## Returns slice of string ``[s.a, s.b)``

proc splice*(x: ustring, startPos: int, endPos: int, r: ustring): ustring =
    ## Replaces ``[startPos, endPos)`` with ``r``
    when defined(ustringPythonic):
        return x.slice(0, startPos) & $r & x.slice(endPos)
    else:
        var a: ustring
        if startPos == 0:
            a = ""
        elif startPos > 0:
            a = x.slice(0, startPos - 1)
        else:
            a = x.slice(0, startPos)
        return a & $r & x.slice(endPos + 1)

proc `[]=`*(x: var ustring, s: Slice[int], r: ustring) {.inline.} =
    ## Replaces ``[startPos, endPos)`` with ``r`` in ``x``
    x = x.splice(s.a, s.b, $r)

proc `[]=`*(x: var ustring, i: int, r: ustring) {.inline.} =
    ## Replaces ``[startPos, endPos)`` with ``r`` in ``x``
    x = x.splice(i, i + oneOff, $r)

proc `~`*[T](a, b: T): Slice[T] {.noSideEffect, inline.} =
    ## Returns interval ``Slice[T]``. Interval is open or closed based on how
    ## procedure taking interval treats it. Both values of interval can be
    ## positive or negative. Roof (``^``) operator restrictions do not apply.
    result.a = a
    result.b = b

proc `~-`*[T](a, b: T): Slice[T] {.noSideEffect, inline.} =
    ## Returns interval ``Slice[T]``. Interval is open or closed based on how
    ## procedure taking interval treats it. Both values of interval can be
    ## positive or negative. Roof (``^``) operator restrictions do not apply.
    result.a = a
    result.b = -b

proc `~`*[T](b: T): Slice[T] {.noSideEffect, inline.} =
    ## Returns interval ``Slice[T]`` ``default(T), b``. Interval is open or closed
    ## based on how procedure taking interval treats it. Both values of interval
    ## can be positive or negative. Roof (``^``) operator restrictions do not apply.
    ## ``slice``:idx: operator that constructs an interval
    result.b = b

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

    converter toWString(x: ustring): WideCString =
        var errors: csize = 0
        var need_count = utf8towide(cstring(x), csize(x.blen), nil, 0, addr(errors))
        if need_count == 0 or errors != 0:
            raise (ref ValueError)()
        unsafeNew(result, need_count * sizeof(Utf16Char))
        var got_count = utf8towide(cstring(x), csize(x.blen), result, need_count, addr(errors))
        if errors != 0:
            raise (ref ValueError)()
        assert got_count == need_count
        result[need_count] = Utf16Char(0)

    converter fromWString(x: WideCString): ustring =
        var errors: csize = 0
        var need_count = widetoutf8(x, csize(x.len), nil, 0, addr(errors))
        if need_count == 0 or errors != 0:
            raise (ref ValueError)()
        result = newString(need_count)
        var got_count = widetoutf8(x, csize(x.len), addr(result), need_count, addr(errors))
        if errors != 0:
            raise (ref ValueError)()
        assert got_count == need_count
        result[need_count] = '\0'

proc upper*(x: ustring): ustring =
    ## Converts utf-8 string to upper case.
    result = newString(x.blen).toUString()
    var errors: csize = 0
    discard utf8toupper(cstring(x), csize(x.blen), cstring(result), csize(x.blen), addr(errors))
    if errors != 0:
        raise (ref ValueError)()

proc lower*(x: ustring): ustring =
    ## Converts utf-8 string to lower case.
    result = newString(x.blen).toUString()
    var errors: csize = 0
    discard utf8tolower(cstring(x), csize(x.blen), cstring(result), csize(x.blen), addr(errors))
    if errors != 0:
        raise (ref ValueError)()

proc title*(x: ustring): ustring =
    ## Converts utf-8 string to titlecase
    result = newString(x.blen).toUString()
    var errors: csize = 0
    discard utf8totitle(cstring(x), csize(x.blen), cstring(result), csize(x.blen), addr(errors))
    if errors != 0:
        raise (ref ValueError)()

proc casefold*(x: ustring): ustring =
    ## Eliminates differences between code points case mapping.
    result = newString(x.blen).toUString()
    var errors: csize = 0
    discard utf8casefold(cstring(x), csize(x.blen), cstring(result), csize(x.blen), addr(errors))
    if errors != 0:
        raise (ref ValueError)()

proc isNormalized*(x: ustring, flags: int): bool =
    ## Checks if utf-8 string is normalized.
    var errors: csize = 0
    result = utf8isnormalized(cstring(x), csize(x.blen), csize(flags), addr(errors)) != 0
    if errors != 0:
        raise (ref ValueError)()

proc normalize*(x: ustring, flags: int): ustring =
    ## Normalizes utf-8 string.
    var errors: csize = 0
    var need_count = utf8normalize(cstring(x), csize(x.blen), nil, 0, csize(flags), addr(errors))
    if need_count == 0 or errors != 0:
        raise (ref ValueError)()
    result = newString(need_count).toUString()
    var got_count = utf8normalize(cstring(x), csize(x.blen), cstring(result),  need_count, csize(flags), addr(errors))
    if errors != 0:
        raise (ref ValueError)()
    assert got_count == need_count

iterator items*(x: ustring): ustring =
    ## Loops ut-8 characters from the start.
    for i in 0 .. x.len-1:
        yield x.slice(i, i + oneOff)

proc `[]`*(x: ustring, i: int): ustring =
    ## Returns utf-8 char at specified index ``i``
    if i < 0:
        raise (ref ValueError)()
    result = x.slice(i, i + oneOff)

iterator ritems*(x: ustring): ustring =
    ## Loops utf-8 characters from the end.
    for i in countdown(x.len - 1, 0):
        yield x.slice(i, i + oneOff)

proc reversed*(x: ustring): ustring =
    ## Returns reversed string.
    result = newStringOfCap(x.len)
    for c in ritems(x):
        result &= c

proc isCategory*(x: ustring, flags: int): bool =
    ## Returns ``true`` if all characters of string fall into category specified
    ## by ``flags``, ``false`` otherwise.
    return utf8iscategory(cstring(x), csize(x.blen), csize(flags)) == x.blen

proc isLower*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISLOWER)
    ## Returns ``true`` if ``x`` is lower case, ``false`` otherwise.

proc isUpper*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISUPPER)
    ## Returns ``true`` if ``x`` is upper case, ``false`` otherwise.

proc isAlpha*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISALPHA)
    ## Returns ``true`` if ``x`` is made of alpha characters, ``false`` otherwise.

proc isNumeric*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISDIGIT)
    ## Returns ``true`` if ``x`` is made of numeric characters, ``false`` otherwise.

proc isAlphaNumeric*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISALNUM)
    ## Returns ``true`` if ``x`` is made of alpha and/or numeric, ``false`` otherwise.

proc isWhitespace*(x: ustring): bool = isCategory(x, UTF8_CATEGORY_ISSPACE)
    ## Returns ``true`` if ``x`` is made of whitespace characters, ``false`` otherwise.

proc startsWith*(x: ustring, sub: ustring): bool = x[0..sub.uhigh + oneOff] == sub
    ## Returns ``true`` if ``x`` starts with substring ``sub``, ``false`` otherwise.

proc endsWith*(x: ustring, sub: ustring): bool = x[x.len - sub.len..high(int)] == sub
    ## Returns ``true`` if ``x`` starts with substring ``sub``, ``false`` otherwise.

proc find*(x: ustring, sub: ustring, start: int=0): int =
    ## Returns index of first occurrence of ``sub`` in ``x``, -1 if ``sub`` is not found. Search starts from beginning of string.
    for i in x.offset(start) .. x.len - sub.len:
        if x[i..i + sub.uhigh + oneOff] == sub:
            return i
    return -1

proc rfind*(x: ustring, sub: ustring, start: int=high(int)): int =
    ## Returns index of first occurrence of ``sub`` in ``x``, -1 if ``sub`` is not found. Search starts from end of string.
    for i in countdown(x.offset(start), 0):
        if x[i..i + sub.uhigh + oneOff] == sub:
            return i
    return -1

proc contains*(x: ustring, sub: ustring): bool {.inline.} = x.find(sub) >= 0
    ## Returns ``true`` if ``x`` contains substring ``sub``, ``false`` otherwise.

proc replace*(x: ustring, find: ustring, replacement: ustring): ustring =
    ## Replaces all occourences of ``find`` in ``x`` with ``replacement``.
    result = x
    var i = result.find(find)
    while i >= 0:
        result = result.splice(i, i + find.uhigh + oneOff, replacement)
        i = result.find(find)

proc count*(x: ustring, sub: ustring, overlapping: bool = false): int =
    ## Count the occurrences of a substring ``sub`` in the string ``s``.
    ## Overlapping occurrences of ``sub`` only count when ``overlapping``
    ## is set to true.
    var i = 0
    while true:
        i = x.find(sub, i)
        if i < 0:
            break
        if overlapping:
            inc i
        else:
            i += sub.len
        inc result

iterator split*(x, sub: ustring): ustring =
    var i, p = 0
    while true:
        p = i
        i = x.find(sub, i)
        if i < 0:
            yield x[p..high(int)]
            break
        yield x[p..i - 1 + oneOff]
        i += sub.len


when isMainModule:
    import future

proc doTests() =
    # var s = "ąčęėįšųū„“"
    # var u: ustring = s
    when defined(ustringPythonic):
        doAssert u"ąčęėįšųū„“".offset(1) == 1
        doAssert u"ąčęėįšųū„“".offset(-1) == 8
        doAssert u"ąčęėįšųū„“".offset(-2) == 7
        doAssert u"ąčęėįšųū„“".offset() == 9
    else:
        doAssert u"ąčęėįšųū„“".offset(1) == 1
        doAssert u"ąčęėįšųū„“".offset(-1) == 9
        doAssert u"ąčęėįšųū„“".offset(-2) == 8
        doAssert u"ąčęėįšųū„“".offset() == 9
    doAssert "ąčęėįšųū„“" == $(u"ąčęėįšųū„“")
    doAssert u"ąčęėįšųū„“".len == 10
    doAssert u"ąčęėįšųū„“".blen == "ąčęėįšųū„“".len
    block:
        var x = u"ąčęėįšųū„“"
        var refcount = x.getRefcount()
        x.GC_ref()
        doAssert x.getRefcount() == (refcount + 1)
        x.GC_unref()
        doAssert x.getRefcount() == refcount

    doAssert u"ąčęėįšųū„“".slice(2) == "ęėįšųū„“"
    when defined(ustringPythonic):
        doAssert u"ąčęėįšųū„“".slice(4, -2) == "įšųū"
        doAssert u"ąčęėįšųū„“".slice(-4, -2) == "ųū"
        try:
            discard u"ąčęėįšųū„“".slice(-4, -6)
            doAssert false, "slice() invalid parameter check failed"
        except ValueError:
            discard
        doAssert u"ąčęėįšųū„“"[1..^1] == "čęėįšųū„"
        doAssert u"ąčęėįšųū„“"[1~-1] == "čęėįšųū„"
        doAssert u"ąčęėįšųū„“".splice(2, 4, "?") == "ąč?įšųū„“"
    else:
        doAssert u"ąčęėįšųū„“".slice(4, -3) == "įšųū"
        doAssert u"ąčęėįšųū„“".slice(-4, -3) == "ųū"
        try:
            discard u"ąčęėįšųū„“".slice(-4, -7)
            doAssert false, "slice() invalid parameter check failed"
        except ValueError:
            discard
        doAssert u"ąčęėįšųū„“"[1..^2] == "čęėįšųū„"
        doAssert u"ąčęėįšųū„“"[1~-2] == "čęėįšųū„"
        doAssert u"ąčęėįšųū„“".splice(2, 3, "?") == "ąč?įšųū„“"

    doAssert u"ąčęėįšųū„“" == "ąčęėįšųū„“"
    doAssert u"ąčęėįšųū„“" == cstring("ąčęėįšųū„“")
    doAssert "a".toUString() == 'a'
    doAssert u"ąčęėįšųū„“" & u"ąčęėįšųū„“" == "ąčęėįšųū„“ąčęėįšųū„“"
    block:
        var x = u"ąčęėįšųū„“"
        when defined(ustringPythonic):
            x[-5 ~ -1] = "!!!"
        else:
            x[-6 ~ -2] = "!!!"
        doAssert x == "ąčęėį!!!“"
        x[1] = "我"
        doAssert x == "ą我ęėį!!!“"
        doAssert x[1] == "我"
    doAssert "ąčęėįšųū".toUString().upper() == "ĄČĘĖĮŠŲŪ"
    doAssert "ĄČĘĖĮŠŲŪ".toUString().lower() == "ąčęėįšųū"
    doAssert u"ąčęėįšųū„“".title() == "Ąčęėįšųū„“"
    doAssert "ĄČĘĖĮŠŲŪ".toUString().casefold() == "ąčęėįšųū"
    doAssert "διαφορετικούς".toUString().normalize(UTF8_NORMALIZE_COMPOSE) == "διαφορετικούς"
    doAssert u"ąčęėįšųū„“".reversed() == "“„ūųšįėęčą"
    doAssert "ūųšįėęčą".toUString().isLower() == true
    doAssert "Ąūųšįėęčą".toUString().isLower() == false
    doAssert "ĄČĘĖĮŠŲŪ".toUString().isUpper() == true
    doAssert "Ąūųšįėęčą".toUString().isUpper() == false
    doAssert "Ąūųšįėęčą".toUString().isAlpha() == true
    doAssert "12345".toUString().isNumeric() == true
    doAssert "Ąūųšįėęčą12345".toUString().isNumeric() == false
    doAssert "\r\t\n ".toUString().isWhitespace() == true
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().find("š") == 3
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().find("Ą", 1) == 9
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("š") == 12
    when defined(ustringPythonic):
        doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("ą") == 17
        doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("ą", -1) == 8
    else:
        doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("ą", -1) == 17
        doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("ą", -2) == 8
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().find("Ą") == 0
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("ą") == 17
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().rfind("測") == -1
    doAssert "ėįš" in u"ąčęėįšųū„“"
    doAssert u"ąčęėįšųū„“".replace("ėįš", "δια") == "ąčęδιαųū„“"
    doAssert u"ąčęėįšųū„“".replace("ū„“", "δια") == "ąčęėįšųδια"
    doAssert u"ąčęėįšųū„“".replace("ąčę", "δια") == "διαėįšųū„“"
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().count("ę") == 2
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().count("šį") == 2
    doAssert "ĄūųšįėęčąĄūųšįėęčą".toUString().count("δια") == 0
    doAssert u"ąčęėįšųū„“".startsWith("ąčęė") == true
    doAssert u"ąčęėįšųū„“".startsWith("šųū„“") == false
    doAssert u"ąčęėįšųū„“".endsWith("ąčęė") == false
    doAssert u"ąčęėįšųū„“".endsWith("šųū„“") == true
    doAssert lc[p | (p <- u"ąčęėįšųū„“".split("ėį")), ustring] == @[u"ąčę", u"šųū„“"]
    doAssert lc[c | (c <- u"ąčęėįšųū„“".items()), ustring] == @[u"ą", u"č", u"ę", u"ė", u"į", u"š", u"ų", u"ū", u"„", u"“"]
    doAssert lc[c | (c <- u"ąčęėįšųū„“".ritems()), ustring] == @[u"“", u"„", u"ū", u"ų", u"š", u"į", u"ė", u"ę", u"č", u"ą"]
    echo "Tests ok", (when defined(ustringPythonic): " (pythonic)" else: "")


when isMainModule:
    doTests()
