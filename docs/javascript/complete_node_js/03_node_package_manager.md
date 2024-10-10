# The Complete Node.js Course: Node Package Manager (NPM)

## Introduction

NPM is the Node Package Manager.

There is a command line tool (`npm`) and a package repository
([npmjs.com](https://npmjs.com)).

`npm` is used to create, publish, and install Node packages.

```shell
$ npm -v
8.18.0
$
```

```shell
$ npm install commander
added 1 package, and audited 2 packages in 432ms

found 0 vulnerabilities
$
```

The NPM repository stores Node packages available for public use at
[npmjs.com](https://npmjs.com).

Anyone can create NPM packages and publish them on [npmjs.com](https://npmjs.com)
for others to find and use.

## Package.json

The `package.json` file includes the basic information about your application / project.

Run `npm init` to create a package.json for a project and interactively ask for
the project information:

```shell
npm-demo $ npm init
This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See `npm help init` for definitive documentation on these fields
and exactly what they do.

Use `npm install <pkg>` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
package name: (npm-demo)
version: (1.0.0)
description:
entry point: (app.js)
test command:
git repository:
keywords: demo
author: James Couball
license: (ISC) MIT
About to write to /Users/couballj/SynologyDrive/Documents/Projects/npm-demo/package.json:

{
  "name": "npm-demo",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [
    "demo"
  ],
  "author": "James Couball",
  "license": "MIT"
}


Is this OK? (yes)
npm-demo $
```

`npm init --yes` will create `package.json` accepting defaults:

```shell
npm-demo $ npm init --yes
Wrote to /Users/couballj/SynologyDrive/Documents/Projects/npm-demo/package.json:

{
  "name": "npm-demo",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}


npm-demo $
```

Flags can be passed to `npm init` to set all the values. See `npm help init`
for details.

## Installing a Node Packages

The `npm install` (or its shortcut `npm i`) command installs npm packages to be
used by a project. Here is an example of installing the `underscore` package:

```shell
npm-demo $ npm install underscore

added 1 package, and audited 2 packages in 912ms

found 0 vulnerabilities
npm-demo $
```

Packages installed this way are added to the `dependencies` section of the
`package.json` file:

```json
"dependencies": {
  "underscore": "^1.13.4"
}
```

By default, any version of `underscore` in the 1.x line will be accepted.

## Using a Package

Load a module using the `require` function. To load the `mongoose` module:

```javascript
var mongoose = require('mongoose');
```

The `require` function looks for the file to load by checking for
[File Modules](#file-modules), [Core Modules](#core-modules), and
[Installed Modules](#installed-modules).

A complete high-level pseudocode algorithm can be found on
[the Node.js Modules page](https://nodejs.org/api/modules.html#all-together).

### File Modules

If the module is a path that begins with './', '.', or '../', node will do the following:

* **If a file with the given name exists** (or the given name plus the extensions .js,
  .json, or .node exists), Node will load that file
* **If a directory with the given name exists**:
  * And that directory contains a file named `package.json`, Node will try to load
    the file named in the `main` property.
  * And that directory contains a file named `index.js` or `index.node`, Node will
    load that file.
* **Otherwise**, Node will throw a `MODULE_NOT_FOUND` error

### Core Modules

Node.js will check to see if the module is a core module. Core modules take
presedence over installed modules.

```javascript
const http = require('http')
```

Core modules can be explicitly identified using the `node:` prefix which bypasses
the `require` cache to ensure the built in module is loaded.

```javascript
const http = require('node:http')
```

### Installed Modules

Node will search the paths in the `module.paths` array in the order they appear.

```shell
npm-demo $ node
Welcome to Node.js v18.8.0.
Type ".help" for more information.
> module.paths
[
  '/Users/couballj/npm-demo/repl/node_modules',
  '/Users/couballj/npm-demo/node_modules',
  '/Users/couballj/node_modules',
  '/Users/node_modules',
  '/node_modules',
  '/Users/couballj/.node_modules',
  '/Users/couballj/.node_libraries',
  '/usr/local/Cellar/node/18.8.0/lib/node'
]
>
npm-demo $
```

The paths list is a list of `node_modules` directories under every
directory from the current directory to the root directory. It also includes
a few legacy directories whose use is not recommended.

To find the file to include, Node will check for the following in each path:

* **If a file with the given name exists** (or the given name plus the extensions .js,
  .json, or .node exists), Node will load that file
* **If a directory with the given name exists**:
  * And that directory contains a file named `package.json`, Node will try to load
    the file named in the `main` property.
  * And that directory contains a file named `index.js` or `index.node`, Node will
    load that file.

Node will process the paths in the order they appear in `module.paths` and return the first
match.

If no match is found an any path, Node will throw a `MODULE_NOT_FOUND` error.

## NPM Packages and Source Control

Since the `package.json` file lists the project's dependencies, you should exclude
the `node_modues` folder and the `package-lock.json` file from git by adding it
to the `.gitignore` file as follows:

```text
node_modules/
package-lock.json
```

## Semantic Versioning

Semantic Versioning (or SemVer) is a method of constructing meaningful version numbers.

SevVer version numbers have three components `x.y.z` where:

* `x` is the major version. It is incremented when there is a breaking change is made.
* `y` is the minor version. It is incremented when new features are added.
* `z` is the patch version. It is incremented when a bug fix is made.

You can take advantage of SemVer in the `dependencies` property of `package.json`. Here
is am example `dependencies`:

```json
"dependenies": {
  "mongoose": "6.6.1",
  "underscore": "^1.13.4",
  "commander": "~9.4.4"
}

```

When a dependency is listed with a **non-prefixed version**, NPM will only install
that exact version of the package. In the this example, only version `6.6.1` of
`mongoose` will be installed.

When a dependency's version is **prefixed with a caret (`^`)**, NPM will install any
version of the depenency where (1) the MAJOR version is the same as the given
version AND (2) the version is no less than the given version.

In the example above, any version of `underscore` may be installed so long as the MAJOR
version is `1` and the version is no less than `1.13.4`.

When a dependency's version is **prefixed with a tilde (`~`)**, NPM will install any
version of the dependency where (1) the MAJOR and MINOR version components are the same
as the given version AND (2) the version is no less than the given version.

In the example above, any version of `commander` matching 9.4.x may be installed so long
as the version is not less than `9.4.4`.

## Listing the Installed Packages

To tell what version of a package is actually installed, you can:

* **Inspect Node Modules**

    Within the `node_modules` directory, find the version number in the `version` property
    within the package's `package.json` files.

    ```shell
    npm-demo $ cat node_modules/commander/package.json | jq '.version'
    "9.4.0"
    npm-demo $
    ```

* **Use the `npm` Command**

    `npm list` shows all dependencies and their version:

    ```shell
    npm-demo $ npm list
    npm-demo@1.0.0 /Users/couballj/npm-demo
    ├── commander@9.4.0
    ├── mongoose@6.6.1
    └── underscore@1.13.4

    npm-demo $
    ```

    You can list the transitives dependencies (e.g. packages that these packages
    depend on) by using the `--all` flag or to any arbitrary depth of dependencies
    using the `--depth n` flag.

## Viewing Registry Info for a Package

Display all the metadata for a package using the `npm view` command.

```shell
npm-demo $ npm view mongoose

mongoose@6.6.1 | MIT | deps: 7 | versions: 744
Mongoose MongoDB ODM
https://mongoosejs.com

keywords: mongodb, document, model, schema, database, odm, data, datastore, query, nosql, orm, db

dist
.tarball: https://registry.npmjs.org/mongoose/-/mongoose-6.6.1.tgz
.shasum: 8aec30924b1a524924d9de4eb4746951f6aadd26
.integrity: sha512-hPDamnn6quL9TjIrOudqUS5sMilENmP/gfxoCIb+rDmlzawtM7+MVCAWrM9930fzD20N7qAema/zE9QIDuifhQ==
.unpackedSize: 2.2 MB

dependencies:
bson: ^4.6.5   mongodb: 4.9.1 mquery: 4.0.3  sift: 16.0.0
kareem: 2.4.1  mpath: 0.9.0   ms: 2.1.3

maintainers:
- aaron <aaron.heckmann+github@gmail.com>
- rauchg <rauchg@gmail.com>
- tjholowaychuk <tj@vision-media.ca>
- vkarpov15 <val@karpov.io>

dist-tags:
latest: 6.6.1    legacy: 5.13.15  next: 6.0.0-rc2  unstable: 3.9.7

published 6 days ago by vkarpov15 <val@karpov.io>
npm-demo $
```

To view a specific metadata property, specify the property name on the command
line after the package name:

```shell
npm-demo $ npm view mongoose dependencies
{
  bson: '^4.6.5',
  kareem: '2.4.1',
  mongodb: '4.9.1',
  mpath: '0.9.0',
  mquery: '4.0.3',
  ms: '2.1.3',
  sift: '16.0.0'
}
npm-demo $
```

```shell
npm-demo $ npm view mongoose keywords
[
  'mongodb',  'document',
  'model',    'schema',
  'database', 'odm',
  'data',     'datastore',
  'query',    'nosql',
  'orm',      'db'
]
npm-demo $
```

## Installing a Specific Version of a Package

Install a specific version of a package with `npm install`:

```shell
npm-demo $ npm install mongoose@2.4.2

added 2 packages, removed 27 packages, changed 2 packages, and audited 6 packages in 2s

1 critical severity vulnerability

To address all issues (including breaking changes), run:
  npm audit fix --force

Run `npm audit` for details.
npm-demo $
```

Use the `npm outdated` command to list the installed packages
where an updated version is available.

## Updating Local Packages

List the packages whose versions are out of date with the `npm outdated`
command.

If the `package.json` dependencies are:

```json
"dependencies": {
  "commander": "^9.2.0",
  "mongoose": "^2.4.2"
}
```

The list of outdated packages might look like this:

```shell
npm-demo $ npm outdated
Package    Current  Wanted  Latest  Location                Depended by
commander    9.2.0   9.4.0   9.4.0  node_modules/commander  npm-demo
mongoose     2.4.2  2.9.10   6.6.1  node_modules/mongoose   npm-demo
npm-demo $
```

In this output:

* `Wanted` is the latest version that matches the criteria given in `package.json`.
* `Latest` is the latest version available even if it does not match the criteria
given in `package.json`.

Update out-of-date packages using the `npm update` command.

This command updates the version of each outdated package to the `Wanted` version
reported by `npm outdated`. In the example above, `npm outdated` would update as
follows:

```shell
npm-demo $ npm update
npm WARN deprecated bson@0.1.8: Fixed a critical issue with BSON serialization documented in CVE-2019-2391, see https://bit.ly/2KcpXdo for more details
npm WARN deprecated mongodb@1.2.14: Please upgrade to 2.2.19 or higher

added 1 package, removed 1 package, changed 4 packages, and audited 6 packages in 11s

found 0 vulnerabilities
npm-demo $
```

Now `npm outdated` will show the updates, but still report `mongoose` since `package.json`
is pinned to the `2.x` major version. There latest major version is `6`.

```shell
npm-demo $ npm outdated
Package   Current  Wanted  Latest  Location               Depended by
mongoose   2.9.10  2.9.10   6.6.1  node_modules/mongoose  npm-demo
npm-demo $
```

The `npm-check-updates` command can be used to automatically update the `package.json`
file to the latest version for each dependency.

This command must be installed separately. It is best to install it in the global packages
so it is available in all projects (use `sudo` when running on MacOS): `npm install npm-check-updates`

To view the outdated dependency specifications in `package.json`:

```script
npm-demo $ npm-check-updates
Checking /Users/couballj/npm-demo/package.json
[====================] 2/2 100%

 commander  ^9.2.0  →  ^9.4.0
 mongoose   ^2.4.2  →  ^6.6.1

Run ncu -u to upgrade package.json
npm-demo $ npm outdated
Package   Current  Wanted  Latest  Location               Depended by
mongoose   2.9.10  2.9.10   6.6.1  node_modules/mongoose  npm-demo
npm-demo $
```

Update `package.json` to the latest versions using the `-u` flag:

```script
npm-demo $ npm-check-updates -u
Upgrading /Users/couballj/npm-demo/package.json
[====================] 2/2 100%

 commander  ^9.2.0  →  ^9.4.0
 mongoose   ^2.4.2  →  ^6.6.1

Run npm install to install new versions.
npm-demo $
```

This updates `package.json` dependencies to:

```json
"dependencies": {
  "commander": "^9.4.0",
  "mongoose": "^6.6.1"
}
```

This updates `package.json` but does not install the updated version. Do that with
`npm update`:

```shell
npm-demo $ npm update

added 25 packages, removed 1 package, changed 3 packages, and audited 30 packages in 2s

4 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
npm-demo $
```

Now `npm outdated` should not list any outdated packages:

```shell
npm-demo $ npm outdated
npm-demo $
```

And `npm-check-updates` should not list any outdated packages:

```shell
npm-demo $ npm-check-updates
Checking /Users/couballj/npm-demo/package.json
[====================] 2/2 100%

All dependencies match the latest package versions :)
npm-demo $
```

## DevDependencies

Some dependencies are only used when developing the application. These include tools
for testing, linting, or other developer tasks.

Install a development dependency using the `--save-dev` flag. Here is an example of
installing the `jshint` linter:

```shell
npm-demo $ npm install jshint --save-dev

added 31 packages, and audited 61 packages in 2s

7 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
npm-demo $
```

This command adds a `devDependencies` property to the project's `package.json` file:

```json
"devDependencies": {
  "jshint": "^2.13.5"
}
```

## Uninstalling a Package

The `npm uninstall {name}` command uninstalls one or more versions of a package. To
uninstall the `mongoose` package:

```shell
npm-demo $ npm uninstall mongoose

removed 28 packages, and audited 33 packages in 1s

3 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
npm-demo $
```

This also removes `mongoose` from `package.json`:

```json
"dependencies": {
  "commander": "^9.4.0"
},
"devDependencies": {
  "jshint": "^2.13.5"
}
```

To uninstall all packages:

```shell
$ rm -rf node_modules
$ rm package-lock.json
$
```

## Working with Global Packages

Node packages that are not specific to an application. This is mostly command line tools that
you might use from anywhere.

Use the `--global` or `-g` flag with `npm install` to install global packages.

```shell
npm-demo $ npm install --global npm

changed 39 packages, and audited 212 packages in 2s

11 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
npm-demo $
```

Global node packages can be listed with `npm list --global`.

```shell
npm-demo $ npm list --global
/usr/local/lib
├── angular@1.8.3
├── markdownlint-cli2@0.5.1
├── npm-check-updates@16.2.1
├── npm@8.18.0
└── webpack-cli@4.9.2

npm-demo $
```

Global packages are installed in `/usr/local/lib/node_modules` on my computer.

## Publishing a Packages

Publishing a package to npmjs.com for others to find and use is very easy.

1. **Create a new project**

    Create the new project folder. Within that folder, create the project's
    `package.json` using `npm init --yes`:

    ```shell
    jcouball $ mkdir jcouball_node_demo
    jcouball $ cd jcouball_node_demo
    jcouball_node_demo $ npm init --yes
    Wrote to /Users/couballj/jcouball_node_demo/package.json:

    {
      "name": "jcouball_node_demo",
      "version": "1.0.0",
      "description": "",
      "main": "index.js",
      "scripts": {
        "test": "echo \"Error: no test specified\" && exit 1"
      },
      "keywords": [],
      "author": "",
      "license": "ISC"
    }

    jcouball_node_demo $
    ```

2. **Create an `index.js` file**

    `index.js` is the entrypoint to your package. This is set in `package.json` using
    the `main` property (see above). This file is what is loaded when the package is
    required.

    Let's start by defining a function which adds two numbers:

    ```javascript
    module.exports.add = function(a, b) { a + b };
    ```

    Users of this module will call the `add` functions like this:

    ```javascript
    demo = require('jcouball_node_demo');
    demo.add(1, 3); // the result is 4
    ```

3. **Login to npmjs.com**

    Use the `npm login` command to log into npmjs.com.

4. **Publish the new package**

    Use the `npm publish` command to push this package to npmjs.com. After running this command,
    the package can be found on npmjs.com.

5. **Use the new package in another project**

    Create a new directory and install the newly created pacakge:

    ```javascript
    # Starting from my home directory again
    jcouball $ mkdir test
    jcouball $ cd test
    test $ npm install jcouball_node_demo

    added 1 package, and audited 2 packages in 686ms

    found 0 vulnerabilities
    test $
    ```

    In this directory, create a `test.js` which contains the following:

    ```javascrtip
    var demo = require('jcouball_node_demo');
    console.log("4 + 5 = " + demo.add(4, 5));
    ```

    And then run the test script:

    ```shell
    test $ node test.js
    4 + 5 = 9
    test $
    ```

## Updating a Published Package

Let's say we want to add a `multiply` function to our node module. Back in the
`jcouball_node_demo` project, change the `index.js` to
export the `multiply` function:

```javascript
module.exports.add = function(a, b) { return a + b };

module.exports.multiply = function(a, b) { return a * b };
```

Trying to publish this change will result in an error because the version
has not been changed:

```shell
jcouball_node_demo $ npm publish
...
npm notice Publishing to https://registry.npmjs.org/
npm ERR! code E403
npm ERR! 403 403 Forbidden - PUT https://registry.npmjs.org/jcouball_node_demo - You cannot publish over the previously published versions: 1.0.0.
npm ERR! 403 In most cases, you or one of your dependencies are requesting
npm ERR! 403 a package version that is forbidden by your security policy, or
npm ERR! 403 on a server you do not have access to.

npm ERR! A complete log of this run can be found in:
npm ERR!     /Users/couballj/.npm/_logs/2022-09-22T15_41_50_014Z-debug-0.log
jcouball_node_demo $
```

The version in the `package.json` file is still `1.0.0`. In order to publish a
different version, we need to update the `version` property.

What should the new version be? Keeping in mind [Semantic Versioning](semantic-versioning),
the major version should not be updated since there are no backward
incompatible changes. Since we ARE adding a new feature we should increment
the minor version.

Update the `version` in `package.json` using the `npm version {part}` command where
part is the part of the version that needs to be updated: `major`, `minor`, or `patch`.
In this case, `minor` should be specified:

```shell
jcouball_node_demo $ npm version minor
v1.1.0
jcouball_node_demo $
```

Now, publishing the new version of the package should succeed:

```shell
jcouball_node_demo $ npm publish
npm notice
npm notice 📦  jcouball_node_demo@1.1.0
npm notice === Tarball Contents ===
npm notice 114B index.js
npm notice 252B package.json
npm notice === Tarball Details ===
npm notice name:          jcouball_node_demo
npm notice version:       1.1.0
npm notice filename:      jcouball_node_demo-1.1.0.tgz
npm notice package size:  351 B
npm notice unpacked size: 366 B
npm notice shasum:        5513293a2e4400f1b35ed534766bfadf7f64315b
npm notice integrity:     sha512-Ta9fCoYW1jyTE[...]V9p3kmb/neBZw==
npm notice total files:   2
npm notice
npm notice Publishing to https://registry.npmjs.org/
+ jcouball_node_demo@1.1.0
jcouball_node_demo $
```

Now let's update the `test.js` script to use the new `multiply` function:

```javascript
var demo = require('jcouball_node_demo');
console.log("4 + 5 = " + demo.add(4, 5));
console.log("4 * 5 = " + demo.multiply(4, 5));
```

An error will result if this script is run before the package is updated:

```shell
test $ node test.js
4 + 5 = 9
/Users/couballj/test/test.js:3
console.log("4 * 5 = " + demo.multiply(4, 5));
                              ^

TypeError: demo.multiply is not a function
    at Object.<anonymous> (/Users/couballj/test/test.js:3:31)
    at Module._compile (node:internal/modules/cjs/loader:1119:14)
    at Module._extensions..js (node:internal/modules/cjs/loader:1173:10)
    at Module.load (node:internal/modules/cjs/loader:997:32)
    at Module._load (node:internal/modules/cjs/loader:838:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:81:12)
    at node:internal/main/run_main_module:18:47

Node.js v18.8.0
test $
```

`npm list` will tell report that the old version of `jcouball_node_demo` is still
being used:

```shell
test $ npm list
test@ /Users/couballj/test
└── jcouball_node_demo@1.0.0

test $
```

Update to the new version of `jcouball_node_demo`:

```shell
test $ npm update

changed 1 package, and audited 2 packages in 651ms

found 0 vulnerabilities
test $ npm list
```

Check that the new version is installed:

```shell
```

Make sure that `test.js` works now:

```shell
```

One last thing. Currently, in the `test` directory, `pacakge.json` still
lists the dependency on any version 1.x of `jcouball_node_demo`:

```json
{
  "dependencies": {
    "jcouball_node_demo": "^1.0.0"
  }
}
```

While we manually updated `jcouball_node_demo` to version `1.1.0`,
`package.json` should be updated to indicate any 1.x version *greater than `1.1.0`*
is required.

This can be done by either modifying `pacakge.json` by hand or by running `npm install`
specifying the exact version number:

```shell
test $ cat package.json
{
  "dependencies": {
    "jcouball_node_demo": "^1.0.0"
  }
}
test $ npm install jcouball_node_demo@1.1.0

changed 1 package, and audited 2 packages in 555ms

found 0 vulnerabilities
test $ cat package.json
{
  "dependencies": {
    "jcouball_node_demo": "^1.1.0"
  }
}
test $
```

## Recap

* Every Node application has a `package.json` file that includes metadata
  about the application. This includes the application's name, version,
  dependencies, etc.
* Use the `npm` command to create, publish, and use non-core packages from npmjs.com
* All installed packages and their dependencies are stored in the `node_modules` folder
* Node packages follow semantic versioning and have a version number in the form:
  `{major}.{minor}.{patch}` (i.e. `1.0.0`).

The following `npm` commands were discussed:

| NPM Command | Description |
| ----------- | ----------- |
| `npm init` | creates `package.json` file in the current directory |
| `npm install NAME` | install a package |
| `npm install NAME@VERSION` |  install a specific version of a package |
| `npm install NAME {--save-dev \| -D}` | install a package as a development dependency |
| `npm uninstall NAME` | uninstall a package |
| `npm list` | list locally installed packages |
| `npm view NAME` | view the registry metadata for a package |
| `npm outdated` | list outdated packages |
| `npm-check-updates` | updates the version for all dependencies in `package.json` |
| `npm update` | update install packages to their latest version that satisify the criteria in `package.json` |
| `npm version [<newversion> \| major \| minor \| patch]` | update the version given in `package.json` |

Use the `--global` or `-g` flag to operate on global packages instead of local packages.
