# Getting Started

## What is Node?

Node is a runtime environment for executing JavaScript code outside of a browser.

Usually used to build highly-scalable, data intensive, real time applications and backend APIs.

Advantages:

* Great for prototypeing and agile development
* Superfast and highly scalable services.
* Build sites faster with less people, less code, and less files.
* Use JavaScript both on the frontend and the backend which keeps code cleaner and
  more consistent.
* Huge ecosystem of opensource libraries.

## Node Architecture

Node is a JS Engine/runtime that runs JavaScript code. Originally based on the v8
Browser JS Engine.

Node provides an environment of objects. This environment is different than the browser
environmnet.

Chrome and Node provide the same JS Engine with a different runtime environment.

Node is not a programming language. Node is not a framework (like Rails). It is
a runtime environment for executing JavaScript code.

## How Node Works

Node is highly scalable because it is non-blocking / asynchronuous.

Node application as asynchronuous by default. Node has an event queue which it
uses to free up threads when they are waiting on external devices like a
file system.

Node is not well suited for CPU-intensive applications where a thread
is performing a long running calculation.

## Install Node

On a Mac:

`brew install node`

## Your First Node Program

In `app.js` write the following program:

```javascript
function sayHello(name) {
  console.log('Hello ' + name);
}

sayHello('James');
```

and then execute:

```shell
$ node app.js
Hello James
$
```
