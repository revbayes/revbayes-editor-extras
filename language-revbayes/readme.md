This is a quick, simple, and incomplete RevBayes grammar for use in the Atom text editor. It uses TextMate naming conventions that should work with any proper Atom theme. It may even work in other editors if they support CoffeeScript grammars, but I haven't done any testing.

It should automatically recognize Rev source files by the file extensions .rb or .Rev.

#Easy Installation

You should be able to get this working simply by searching for 'language-revbayes' under the packages heading in the Atom settings and installing from there.

#Manual Installation

Alternatively, you can install the package manually by placing the `language-revabyes/` directory into `~/.atom/packages/`.

That would look something like this (double check the URL):
```
git clone https://github.com/revbayes/revbayes-editor-extra/atom
mkdir -p ~/.atom/packages && cp -r ./language-revbayes ~/.atom/packages/
```
