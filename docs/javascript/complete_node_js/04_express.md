# The Complete Node.js Course: Building RESTful APIs Using Express

## Introduction

This chapter will introduce the [express npm module](https://www.npmjs.com/package/express)
for building scalable web applications.

Recall that in [the HTTP module introduction](02_node_module_system.md/#http-module),
we had this code to implement a simple web app that implemented responses for
`/` and `/friends`:

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

As this web app is extended, a new `if` block would need to be added for each route.
This is not scalable or maintainable.

The express framework is a fast, minimalist web framework for node that helps
build maintainable web applications.

## RESTful Service

REST is an implementation of the client server architecture.

REST is short for "REpresentational State Transfer". It is a convention for building
HTTP services. It defines a protocol to Create, Read, Update, and Delete data. These
operations are know as CRUD operations.

In REST, you expose data objects as URL end points. For example, you might use the
following URL might be the end point to access customers:

```url
http://example.com/api/customers
```

All operations on customer objects are implemented as an HTTP request to this end
point. The type of HTTP request defines the kind of operation to perform.

| HTTP Request Type | Operation |
| ----------------- | --------- |
| GET | Reads objects |
| POST | Creates new objects |
| PUT | Updates objects |
| DELETE | Deletes Objects |

A RESTful application is a web application that follows these conventions:

* It exposes resources (aka objects) using a simple meaningful address (like `/api/customers`
  for customers)
* It supports various operations on those resources such as creating or updating those resources
* It implements calling those operations via a set of standard HTTP methods
* It represents data received or data sent as JSON

Here is how a RESTful application might expose customer resources:

| Operation | HTTP Method & URL | Request<br/>Body | Response<br/>Body |
| --------- | ------- | -------- | -------- |
| Get customers | `GET /api/customers` | N/A | List of customers |
| Get a customer | `GET /api/customers/{id}` | N/A | A single customer |
| Update a customer | `PUT /api/customers/{id}` | Customer properties to update | The updated customer |
| Delete a customer | `DELETE /api/customers/{id}` | N/A | The deleted customer |
| Create a customer | `POST /api/customers` | A customer | The new customer with its id |

## Introducing Express

[Express](https://www.npmjs.com/package/express) is a framework gives our web application
structure so that we can easily add new routes while keeping our application maintainable.

Create a project and install express:

1. Create a project directory

    ```shell
    Projects $ mkdir express-demo
    Projects $ cd express-demo
    express-demo $
    ```

2. Run `npm init`

    ```shell
    express-demo $ npm init --yes
    Wrote to /Users/couballj/SynologyDrive/Documents/Projects/express-demo/package.json:

    {
      "name": "express-demo",
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


    express-demo $
    ```

3. Install `express`

    ```shell
    express-demo $ npm install express

    added 57 packages, and audited 58 packages in 2s

    7 packages are looking for funding
      run `npm fund` for details

    found 0 vulnerabilities
    express-demo $
    ```

## Building Your First Web Server

Add an `index.js` file as follows:

```javascript
const express = require('express');
const app = express();

 app.get('/', (req, res) => {


 });

```

## Nodemon

## Environment Variables

## Route Parameters

## Handling HTTP GET Requests

## Handling HTTP POST Requests

## Calling Endpoints Using Postman

## Input Validation

## Handling HTTP PUT Requests

## Handling HTTP DELETE Requests

## Build the Genres API App

## Recap
