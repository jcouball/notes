# My Personal Tech Docs

[My notes hosted on GitHub Pages](https://jcouball.github.io/notes)

## Getting Started

It is assumed that you have node and python installed and in the path.

In this project's root directory run `npm run setup` to install the required node and
python packages to lint, build, and serve the documentation.

## Available Scripts

The following scripts are available via `npm run`:

* `npm run setup`: install required node and python packages for markdownlint and
  mkdocs
* `npm run lint`: run the markdown linter configured by `.markdownlint.yml`
* `npm run build`: run the markdown linter and build the mkdocs site
* `npm run serve`: run the markdown linter, build the mkdocs site, and serve the site
  for testing
