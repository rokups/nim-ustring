## Introduction ##

`utf8rewind` is a system library written in C designed to extend the default string handling functions with support for UTF-8 encoded text.

## Example ##

```
#!c
	#include "utf8rewind.h"

	int main(int argc, char** argv)
	{
		/*
			"Ἀριστοτέλης" (Aristotle) encoded in UTF-8 using hexadecimal notation
		*/

		const char* input =
			"\xE1\xBC\x88\xCF\x81\xCE\xB9\xCF\x83\xCF\x84\xCE\xBF\xCF\x84"
			"\xCE\xAD\xCE\xBB\xCE\xB7\xCF\x82";

		static const size_t output_size = 255;
		char output[output_size + 1];
		wchar_t output_wide[output_size + 1];
		const char* input_seek;
		size_t converted_size;
		int32_t errors;

		memset(output, 0, sizeof(output));
		memset(output_wide, 0, sizeof(output_wide));

		/*
			Convert input to uppercase:
		
			"Ἀριστοτέλης" -> "ἈΡΙΣΤΟΤΈΛΗΣ"
		*/

		converted_size = utf8toupper(input, strlen(input), output, output_size, UTF8_LOCALE_DEFAULT, &errors);
		if (converted_size == 0 ||
			errors != UTF8_ERR_NONE)
		{
			return -1;
		}

		/*
			Convert UTF-8 input to wide (UTF-16 or UTF-32) encoded text:
			
			"ἈΡΙΣΤΟΤΈΛΗΣ" -> L"ἈΡΙΣΤΟΤΈΛΗΣ"
		*/

		converted_size = utf8towide(output, strlen(output), output_wide, output_size * sizeof(wchar_t), &errors);
		if (converted_size == 0 ||
			errors != UTF8_ERR_NONE)
		{
			return -1;
		}

		/*
			Seek in input:
		
			"Ἀριστοτέλης" -> "τέλης"
		*/

		input_seek = utf8seek(input, strlen(input), input, 6, SEEK_SET);

		return 0;
	}
```

## Features ##

* **Cross-platform** - `utf8rewind` is written in plain C, which means it can be used on any platform with a compliant C compiler. Currently, Windows, Linux and Mac versions are available.

* **Conversion to and from UTF-8** - `utf8rewind` provides functions for converting to and from wide, UTF-16 and UTF-32 encoded text.

* **Case mapping** - The library provides functionality for converting text to uppercase, lowercase and titlecase.

* **Case folding** - Using `utf8casefold`, you can erase case distinctions in strings and compare them in a case-insensitive manner.

* **Normalization** - With `utf8normalize`, you can normalize UTF-8 encoded text to NFC, NFD, NFKC or NFKD without converting the text to UTF-32 first.

* **Seeking** - Using `utf8seek`, you can seek forwards and backwards in any UTF-8 encoded strings.

* **Easy to integrate** - The library consists of only 15 public functions and requires *no* initialization. Any C or C++ project can add `utf8rewind` without breaking existing code.

* **Simple bindings** - No structs are used in the public interface, only pointers. Even if you don't use C, if the language of your choice allows bindings to C functions, you can benefit from integrating `utf8rewind` into your project.

* **No heap allocations** - All allocations in `utf8rewind` happen on the stack. *You* provide the memory, without having to override `malloc`. This makes the library perfectly tailored to game engines, integrated systems and other performance-critical or memory-constrained projects.

* **Safety** - Almost 2500 automated unit, integration, property and performance tests guarantee the safety, security and speed of the library.

## Licensing ##

This project is licensed under the MIT license, a full copy of which should have been provided with the project.

## Download ##

[utf8rewind-1.5.0.zip (7.71 MB)](https://bitbucket.org/knight666/utf8rewind/downloads/utf8rewind-1.5.0.zip)

### Clone in Mercurial ###
 
	hg clone https://bitbucket.org/knight666/utf8rewind utf8rewind

## Building the project ##

All supported platforms use [GYP](http://code.google.com/p/gyp/) to generate a solution. This generated solution can be used to compile the project and its dependencies.

### Building on Windows with Visual Studio ###

	You will need to have Visual Studio 2010 or above installed.

Open a command window at the project's root.

If you have multiple versions of Visual Studio installed, you must first specify the version you want to use:

	set GYP_MSVS_VERSION=2012

Use GYP to generate a solution:

	tools\gyp\gyp --depth utf8rewind.gyp

Open the solution in Visual Studio. You can use the different build configurations to generate a static library.

### Building on Linux with GCC ###

Open a command window at the project's root.

Ensure you have all dependencies installed using your preferred package manager:

	sudo apt-get install gcc g++ gyp doxygen

Use GYP to generate a Makefile:

	gyp --depth=. utf8rewind.gyp

Build the project using `make`:

	make

For a release build, specify the build type:

	make BUILDTYPE=Release

Note that the generated Makefile does not contain a "clean" target. In order to do a full rebuild, you must delete the files in the "output" directory manually.

### Building on Mac OS X with XCode ###

Open a command window at the project's root.

Use GYP to generate a solution:

	tools\gyp\gyp --depth utf8rewind.gyp

Open the solution in XCode and you can build the library and tests.

### Running the tests ###

After generating a solution, build and run the "tests-rewind" project. Verify that all tests pass on your system configuration before continuing.

## Helping out ##

As a user, you can help the project in a number of ways, in order of difficulty:

* **Use it** - By using the library, you are helping the project spread. It is very important to us to have the project be used by as many different projects as possible. This will allow us to create better public interfaces.

* **Spread the word** - If you find `utf8rewind` useful, recommend it to your friends or coworkers.

* **Complain** - No library is perfect and `utf8rewind` is no exception. If you find a fault but lack the means (time, resources, etc.) to fix it, sending complaints to the proper channels can help the project out a lot.

* **Write a failing test** - If a feature is not working as intended, you can prove it by writing a failing test. By sending the test to us, we can make the adjustments necessary for it to pass.

* **Write a patch** - Patches include a code change that help tests to pass. A patch must always include a set of tests that fail to pass without the patch. All patches will be reviewed and possibly cleaned up before being accepted.

## Contact ##

For inquiries, complaints and patches, please contact `{quinten}{lansu} {at} {gmail}.{com}`. Remove the brackets to get a valid e-mail address.