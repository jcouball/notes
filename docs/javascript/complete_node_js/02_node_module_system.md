# The Complete Node.js Course: Node Module System

## Introduction

In this module we will learn:

* What are modules?
* Why do we need them?
* How do they work?
* How do are modules created?

## Global Object

`console` is a global object

Part of standard Javascript: can be used in browser and Node.

```javascript
console.log('message'); //console is a global object

setTimeout(); // these are global functions
clearTimeout();
setInterval();
clearInterval();
```

In a **browser**, the `window` object represents the global scope. All global variables
and functions are accessed through this object.

```javascript
// In a browser, these are equivalent
window.console.log('message');
console.log('message');
```

In **Node**, the `global` object represents the global scope. Like the `window` object
in the browser, all global varaibles and functions are accessed through this object.

```javascript
// In Node, these are equivalent
global.console.log('message');
console.log('message');
```

In a browser, `var` creates global varaibles and adds them to the `window` object.

In Node, `var` scopes variables to the file they are declared in which means they
are not global and are not added to the `global` object.

## Modules

In Node, every file is considered a Module. Variables and functions
defined in that file/module using `var` are scoped to that file. they are private to
that module).

If you want to use a variable or function outside the module it is declared in, you
have to export it to make it public.

Every app in Node has a main module.

Every module gets its own `module` object. It is not a global object. It has
the following properties:

```shell
echo "console.log(module);" | node
Module {
  id: '[stdin]',
  path: '.',
  exports: {},
  filename: '/Users/couballj/SynologyDrive/Documents/Projects/notes/[stdin]',
  loaded: false,
  children: [],
  paths: [
    '/Users/couballj/SynologyDrive/Documents/Projects/notes/node_modules',
    '/Users/couballj/SynologyDrive/Documents/Projects/node_modules',
    '/Users/couballj/SynologyDrive/Documents/node_modules',
    '/Users/couballj/SynologyDrive/node_modules',
    '/Users/couballj/node_modules',
    '/Users/node_modules',
    '/node_modules'
  ]
}
```

## Creating a Module

Say you want to have a module that implements logging to a service. The service has
a url and function to log messages. Let's create a `logger.js` file to implement
this service that contains:

```javascript
var url = 'http://example.com/log';

function log(message) {
  // Send an HTTP request
  console.log(message);
}

module.exports.log = log;
module.exports.endPoint = url;
```

In this module, `url` and `log` (which would normally be private) are made public
by exporting them by adding them to the `module.exports` object.

Note that the thing being exported can be renamed as is the case above where
the private variable `url` is exported with the name `endPoint`. In the real
world, you might not export the url since you want it to stay private.

## Loading a Module

Use the `require` function to load a module. `require` returns an object
whose properties are the exported variables and functions from the
imported module.

```javascript
var logger = require('./logger')
console.log(logger) // what is logger?
```

```shell
$ node app.js
{ log: [Function: log] }
$
```

To log a message using this module, change `app.js`:

```javascript
var logger = require('./logger');
logger.log('Hello world!');
```

```shell
$ node app.js
Hello world!
$
```

When loading a module, it is a best practice to store the result of `require` in
a constant. This ensures that the required module is not changed
accidentally.

```javascript
// Use 'const' instead of 'var'
const logger = require('./logger');
logger.log('Hello world!');
```

If you want to only export a single function from a module instead of
an object, you could change `logger.js` as follows:

```javascript
var url = 'http://example.com/log';

function log(message) {
  // Send an HTTP request
  console.log(message);
}

// Note the difference in how the exports is set... it is set
// to a function.
module.exports = log;
```

In `app.js`, the `require(...)` returns `module.exports` which is now a function.
Call it as follows:

```javascript
const log = require('./logger.js');
log('Hello world!');
```

When run, it should have the same result as before:

```shell
$ node app.js
Hello world!
$
```

## Module Wrapper Function

When a module is required, Node actually wraps the whole file in a *Module Wrapper
Function* like this:

```javascript
(function (exports, require, module, __filename, __dirname) {
  // Module code actually lives in here
})
```

Effectively, the `logger.js`, when required becomes this:

```javascript
(function (exports, require, module, __filename, __dirname) {
  var url = 'http://example.com/log';

  function log(message) {
    // Send an HTTP request
    console.log(message);
  }

  // Note the difference in how the exports is set... it is set
  // to a function.
  module.exports = log;
})
```

The args for the module wrapper function are:

* **exports** - a shortcut to `module.exports`
* **require** - the require function that can be used to require other modules
* **module** - the module object for this module
* **__filename** - the name of the file containing the module
* **__dirname** - the path to the file containing the module

To you can inspect these args in the module.  You can, for example, log
`__filename` and `__dirname` in `logger.js` as follows:

```javascript
console.log(__dirname);
console.log(__filename);

var url = 'http://example.com/log';

function log(message) {
  // Send an HTTP request
  console.log(message);
}

// Note the difference in how the exports is set... it is set
// to a function.
module.exports = log;
```

When run, the output is:

```shell
$ node app.js
/Users/couballj/SynologyDrive/Documents/Projects/test4
/Users/couballj/SynologyDrive/Documents/Projects/test4/logger.js
$
```

## Path Module

Node has many built in modules.

Find the documentation for built in modules by going to [nodejs.org](https://nodejs.org),
clicking on the [Docs](https://nodejs.org/en/docs/) link in the top navigation bar,
and then selecting the Node version in the left navigation menu.

Interesting modules include `FileSystem`, `HTTP`, `Path`, `Process`, `QueryStrings`,
and `Stream`.

In the documentation for each module, it shows how to use the module. For the
[Path](https://nodejs.org/dist/latest/docs/api/path.html), the documentation says
to require the module as follows:

```javascript
const path = require('node:path');
```

Here is an example `app.js` which uses path:

```javascript
const path = require('path');

var pathObject = path.parse(__filename);
console.log(pathObject);
```

```shell
$ node app.js
{
  root: '/',
  dir: '/Users/couballj/SynologyDrive/Documents/Projects/test4',
  base: 'app.js',
  ext: '.js',
  name: 'app'
}
$
```

## OS Module

The [OS Module](https://nodejs.org/dist/latest/docs/api/os.html) tells you interesting
things about the current OS: the amount of free memory, the total memory, the OS name,
uptime, and so on.

```javascript
const os = require('os')

var totalMemory = os.totalmem();
var freeMemory = os.freemem();

// using tempalte string
console.log(`Total memory: ${totalMemory}`);
console.log(`Free memory: ${freeMemory}`);
```

Running results in:

```shell
node app.js
Total memory: 34359738368
Free memory: 1683660800
```

## File System Module

The [File System Module](https://nodejs.org/dist/latest/docs/api/fs.html) has a bunch
of functions to work with files and directories.

Most functions come in a synchronous and asynchronous flavors. e.g. `access` vs.
`accessSync`. You should avoid synchronous functions if possible.

Let's consider `readdir` looking at both synchronous and asynchronous forms. First,
the synchronous form:

```javascript
const fs = require('fs');

const files = fs.readdirSync('./');
console.log(files);
```

```shell
$ node app.js
[ 'app.js', 'logger.js' ]
$
```

Now the non-synchronous form:

```javascript
const fs = require('fs');

fs.readdir('./', function(err, files) {
  if (err) console.log('Error', err);
  else console.log('Result', files)
});
```

When successful:

```shell
$ node app.js
Result [ 'app.js', 'logger.js' ]
$
```

When there is an error:

```shell
$ node app.js
Error [Error: ENOENT: no such file or directory, scandir '$'] {
  errno: -2,
  code: 'ENOENT',
  syscall: 'scandir',
  path: '$'
}
$
```

## Events Module

The [Events Module](https://nodejs.org/dist/latest/docs/api/events.html) defines
the EventEmitter class.

Super simple emitter example:

```javascript
// Require for the events moduile returns a class
// Class names use class case
const EventEmitter = require('events')
const emitter = new EventEmitter;

// Register a listener
// Your listener must be registered before the event is emitted
emitter.on('messageLogged', function (){
  console.log('Listener called');
});

// Use emit to signal that an event has happened (aka raise an event)
emitter.emit('messageLogged');
```

```shell
$ node app.js
Listener called
$
```

## Event Arguments

Additional arguments can be sent to an event handler by adding
those arguments EventEmitter.emit.

```javascript
const EventEmitter = require('events')
const emitter = new EventEmitter;

emitter.on('messageLogged', function (arg){
  console.log('Listener called', arg);
});

// Add arguments to be sent to the handler
emitter.emit('messageLogged', { id: 1, to: 'http://...', message: 'Log Message' });
```

While multiple values can be sent, it is the best practice to wrap multiple
values in an object like was done above.

The result is:

```script
$ node app.js
Listener called { id: 1, to: 'http://...', message: 'Log Message' }
$
```

Here is the same thing with an arrow function:

```javascript
emitter.on('messageLogged', (arg) => {
  console.log('Listener called', arg);
});
```

## Extending EventEmitter

Mostly, you wouldn't work with the EventEmitter class directly as we
did in the last section. Instead, you would work with a class that
has all the capabilities of the EventEmitter class.

Here is an example of adding the EventEmitter capabilities to the Logger
module:

logger.js:

```javascript
var url = 'http://example.com/log';

// Create a class that extends the EventEmitter class
class Logger extends EventEmitter {
  // Don't use the 'function' keyword in a class
  log(message) {
    // Send an HTTP request
    console.log(message);
    // Raise an event
    this.emit('messageLogged', {id: 1, url: url, message: message});
  }
}

module.exports = Logger;
```

app.js:

```javascript
const Logger = require('./logger');
const logger = new Logger();

logger.on('messageLogged', (arg) => {
  console.log('Listener called', arg);
});

logger.log('message to log');
```

Result:

```shell
$ node app.js
message to log
Listener called { id: 1, url: 'http://example.com/log', message: 'message to log' }
$
```

## HTTP Module

The [HTTP module](https://nodejs.org/dist/latest/docs/api/http.html) is Used for
creating networking application like a web server. Used to create backend web or
mobile applications.

Code to create an HTTP server listening on port 3000 with a callback to report
when a connection is made:

```javascript
const http = require('http');
const server = http.createServer();

server.on('connection', (socket) => {
  console.log('New connection...');
});

server.listen(3000);

console.log('Listening on port 3000...');
```

Result after running, connecting with browser to `127.0.0.1:3000`, and then exiting
with control-C:

```shell
$ node app.js
Listening on port 3000...
New connection...
^C
$
```

An HTTP service would normally be implemented by sending a callback funtion to the
`http.createServer` function.

```javascript
const http = require('http');
const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.write('Hello World');
    res.end();
  }
});

server.on('connection', (socket) => {
  console.log('New connection...');
});

server.listen(3000);

console.log('Listening on port 3000...');
```

When run, you will see that the server is listening and a message each time the
browser makes a request. In the browser, you will see the string 'Hello World'.

```shell
$ node app.js
Listening on port 3000...
New connection...
New connection...
New connection...
^C
$
```

If you want to build a full backend application, you need to handle various
routes.

Let's say you want to return a list of friends names when a request is made
to `/friends`.

```javascript
const http = require('http');
const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.write('Hello World');
    res.end();
  }

  if (req.url === '/friends') {
    res.write(JSON.stringify(
      ['James', 'Frank', 'Ittai', 'Stas']
    ))
  }
});

server.on('connection', (socket) => {
  console.log('New connection...');
});

server.listen(3000);

console.log('Listening on port 3000...');
```

## Recap

In this section, I learned:

* In Node:
    * the `window` object does not exist
    * The global object in Node is `global`
    * Variables defined are not global

* Every file in a Node application is a module
    * Node automatically wraps the code in each file with an IIFE (Immediately-invoked
        Function Expression) to create scope.
    * Variables and functions defined in one file are only scoped to that file and not
        visible to other files unless explicitly exported.

* To export a variable or function from a module, you need to add them to
  `module.exports`:

    `module.exports.sayHello = sayHello;`

* To load a module, use the require function. This function returns the `module.exports`
  object exported from the target module:

    `const logger = require(‘./logger’);`

* Node has a few built-in modules that enable us to work with the file system, path
  objects, network, operating system, etc.

* EventEmitter is one of the core classes in Node that allows us to raise (emit) and
  handle events.
    * Several built-in classes in Node derive from EventEmitter.

    * To create a class with the ability to raise events, we should extend EventEmitter:

        `class Logger extends EventEmitter { }`
