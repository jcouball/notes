# My Personal Tech Docs

These notes can be viewed on [GitHub pages](https://jcouball.github.io/notes/).

These are my personal notes I have taken on many different technical and musical
subjects.

## Getting Started

You can edit these notes by:
* [Opening in a GitHub Codespace](https://codespaces.new/jcouball/notes)
* Cloning this repo locally and opening in VS Code

  You can do this by opening the following link in your browser:

  `vscode://vscode.git/clone?url=https://github.com/jcouball/notes`

* Use your own editor or IDE

If you choose to edit these notes without a devcontainer you must do the following:

1. Make sure that BOTH nodejs and python are installed and in your path

2. In this project's root directory run `npm run setup` to install the required node
and python packages to lint, build, and serve the documentation

The following npm scripts are available to lint, build and serve the docs:
* `npm run lint`: run the markdown linter configured in `.markdownlint.yml`
* `npm run build`: run the markdown linter and build the mkdocs site
* `npm run serve`: run the markdown linter, build the mkdocs site, and serve the site
  for testing
