# Ultimate JavaScript Mastery: ES6 Tooling

## Modules

Modules allow you to split code across different files. Each file is a module.

Using modules increases maintainability, reusability, and abstraction.

## CommonJS Modules

CommonJS modules are used in node.

`circle.js`

```javascript
// Implementation Detail
const _radius = new WeakMap();

// Public Interface
class Circle {
  constructor(radius) {
    _radius.set(this, radius);
  }

  draw() {
    console.log(`Circle with radius ${_radius.get(this)}`);
  }
}

// Add a property to module.exports for exported items.
// These are the only symbols that other modules will be able to access.
module.exports.Circle = Circle;

// If you only have one thing to export, you can set module.exports to that
module.exports = Circle;
```

`index.js`

```javascript
const Circle = require('./circle');

const c = new Circle(10);

console.log(c); // Circle {}
c.draw(); // Circle with radius 10
```

## ES6 Modules

ES6 Modules are used in browser.

`circle.js`

Use the `export` keyword to identify symbols that are to be made available outside the module:

```javascript
// Implementation Detail
const _radius = new WeakMap();

// Public Interface
export class Circle {
  constructor(radius) {
    _radius.set(this, radius);
  }

  draw() {
    console.log(`Circle with radius ${_radius.get(this)}`);
  }
}
```

`index.js`

Use the `import` keyword to expose exported symbols from a module

```javascript
import {Circle} from './circle';

const c = new Circle(10);
c.draw(); // Circle with radius 10
```

## Tools

### NPM

NPM is the Javascript package manager.

Initialize your node project by running `npm init`.  This creates a `package.json` file
for the project.

### Babel

Babel is a traspiler that takes modern Javascript code and convert it into ES5

`npm install babel-cli babel-core babel-preset-env --save-dev`

Every feature added on top of ES5 has a babel plugin. Installing `babel-preset-env` is
a plugin that installs all plugins available.

### Webpack

Webpack is a Javascript bundlers. It will combine all our Javascript source code and
the source code of our dependencies into one file and then minify the result.

`npm install -g webpack-cli`

`webpack-cli init`
