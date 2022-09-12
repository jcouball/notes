# Homebrew Tips

[Homebrew Documentation](https://docs.brew.sh)

## Glossary

[Homebrew Terminology](https://docs.brew.sh/Manpage#terminology)

### Formula

Homebrew package definition built from upstream sources

Formulae are the definitions of how to install the various command line packages/
applications available through Homebrew. These are the things that make brew install
work.

### Tap

A directory (and usually Git repository) of formulae, casks and/or external commands

The default tap is “homebrew/core”

### Casks

Essentially Casks are Homebrew packages for GUI applications. Casks allow you to
leverage the command line to install applications such as Google Chrome and (at the
time of writing) 3,381 other applications.

### Brewfile

Similar to Ruby's Gemfile (a way to list Ruby gems necessary for a project), a Brewfile
allows you to list Homebrew packages, Casks, taps, and even App Store applications to
install on your system.

### Keg

Installation destination directory of a given formula version e.g. `/usr/local/Cellar/foo/0.1`

### Rack

A directory containing one or more versioned kegs e.g. `/usr/local/Cellar/foo`

### Keg-only

A formula is keg-only if it is not symlinked into Homebrew’s prefix (e.g. `/usr/local`)

### Cellar

A directory containing one or more named racks e.g. `/usr/local/Cellar`

### Caskroom

A directory containing one or more named casks e.g. `/usr/local/Caskroom`

### External command

A brew subcommand defined outside of the Homebrew/brew GitHub repository

### Bottle

A pre-built keg poured into the cellar/rack instead of building from upstream sources

## List Formula

`brew list`

## Install Formula

[How to Install an Older Brew Package](https://itnext.io/how-to-install-an-older-brew-package-add141e58d32?gi=a7405a224729)

## Uninstall Formula

## Search for Formula

`brew search <searchterm>`

## Search for Mac Apps

`mas search <searchterm>`

## Search Cask Tokens and Formula Names

## Show Formula Information

`brew info ffmpeg`

## Show Dependency Tree of Installed Formulas

`brew deps --tree --installed`

## Show Leaf Formulas and their Dependencies

```shell
brew leaves | xargs brew deps --installed --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
```

## Update Brew

Update home-brew itself:
`brew update`

Update all individual packagers and formula:
`brew upgrade`

## Bundle/Brewfile

[Brew Bundle Brewfile Tips](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f)

Create .Brewfile: `brew bundle dump --describe --global --all --mas`

Install from .Brewfile: `brew bundle install --global`