# My Personal Tech Docs

These notes can be viewed on [GitHub pages](https://jcouball.github.io/notes/).

These are my personal notes I have taken on many different technical and musical
subjects.

* [Getting Started](#getting-started)
  * [Without a devcontainer](#without-a-devcontainer)
  * [In VS Code](#in-vs-code)
  * [Deploying](#deploying)

## Getting Started

You can edit these notes by:
* [Opening in a GitHub Codespace](https://codespaces.new/jcouball/notes)
* Cloning this repo locally and opening in VS Code

  You can do this by opening the following link in your browser:

  `vscode://vscode.git/clone?url=https://github.com/jcouball/notes`

* Use your own editor or IDE

### Without a devcontainer

If you choose to edit these notes without a devcontainer you must do the following:

1. Make sure that BOTH nodejs and python are installed and in your path

2. In this project's root directory run `npm run setup` to install the required node
and python packages to lint, build, and serve the documentation

The following npm scripts are available to lint, build and serve the docs:
* `npm run lint`: run the markdown linter configured in `.markdownlint.yml`
* `npm run build`: run the markdown linter and build the mkdocs site
* `npm run serve`: run the markdown linter, build the mkdocs site, and serve the site
  for testing

### In VS Code

If you use VS Code (locally, in a devcontainer, or in a GitHub Codespace), you can
run the document server by selecting "Run without Debugging" from the VS Code "Run"
menu (or use the Ctrl-F5 shortcut).

### Deploying

The deployment is configured with these files:

* config/provision.yaml: Proxmox provisioning configuration
* Dockerfile: creates the production deployment image which is deployed to docker hub
  to [jcouball/notes](https://hub.docker.com/repository/docker/jcouball/notes/general)
  * docker-build: a script to build the docker image locally
  * docker-run: a script to run the docker image locally
* config/deploy.yaml: Kamal 2 deployment configuration

Currently, Proxmox configuration must be done manaully (see the commands at the
bottom of the file).

For deployment, use kamal 2 commands.
