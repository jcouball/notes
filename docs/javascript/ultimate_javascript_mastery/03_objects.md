# Ultimate JavaScript Mastery: Objects

## Objects

By convention, factory functions are named create____ using camel case.

## Object Literal

```javascript
const person = { name: 'James', age: 29 };
console.log(person);
```

## Factory Functions

```javascript
function createPerson(name, age) {
  { name, age };
  // Equilavent to:
  // { name: name, age: age }
}
const person = createPerson('James', 29);
console.log(person);
```

## Constructor Functions

```javascript
function Person(name, age) {
  this.name = name;
  this.age = 29
}
const person = new Person('James', 29);
console.log(person);
```

## Functions are Objects

Functions are objects with their own properties and methods

```javascript
function Person(name, age) {
  this.name = name;
  this.age = 29;
}
console.log(Person.name);
console.log(Person.length); // # of properties
console.log(Person.constructor);
```

There is a function construction function:

```javascript
new Function(...args, body)
```

To define the `Person` function with `new Function`:

```javascript
const Person = new Function('name', 'age', `
  this.name = name;
  this.age = age;
`);
const person = new Person('James', 29);
console.log(person);
```

You can call a function using `.call`:

```javascript
function call(this, ...args);
```

Here is an example:

```javascript
function Person(name, age) {
  this.name = name;
  this.age = 29;
  return this;
}
const person = Person.call({}, 'James', 29);
console.log(person);
```

If you already have arguments in an array, use `.apply` instead:

```javascript
function Person(name, age) {
  this.name = name;
  this.age = 29;
  return this;
}
const args = ['James', 29];
const person = Person.apply({}, args);
console.log(person);
```

## Enumerating Object Properties

Use a `for... in` loop to iterate properties:

```javascript
const person = { name: 'James', age: 29 }
for (let key in person)
  console.log(key, person[key]);
```

Using a `for... of` loop will not work because an object is not iterable:

```javascript
const person = { name: 'James', age: 29 };
for (let propertyValue of person) // TypeError: person is not iterable
  console.log(propertyValue);
```

Instead, use a `for.. of` loop with `Object.keys`:

```javascript
const person = { name: 'James', age: 29 };
for (let key of Object.keys(person))
  console.log(key, person[key]);
```

or `Object.entries`:

```javascript
const person = { name: 'James', age: 29 };
for (let kv of Object.entries(person))
  console.log(kv[0], kv[1]);
```

To see if a property exists, use the `in` operator:

```javascript
const person = { name: 'James', age: 29 };

if ('name' in person) console.log('yes')
else console.log('no');

if ('id' in person) console.log('yes')
else console.log('no');
```

## Cloning an Object

Copy an object by copying it's properties to a new object.

```javascript
const person = { name: 'James', age: 29 };
const other = {};
for (let key in person)
  other[key] = person[key];
console.log(other);
```

The more modern way:

```javascript
const person = { name: 'James', age: 29 };
const other = Object.assign({}, person);
console.log(other);
```

Using the Spread Operator:

```javascript
const person = { name: 'James', age: 29 };
const other = { ...person };
console.log(other);
```

## Math Object

Important properties / methods:

- `Math.PI`, …
- `Math.abs(x)`, `Math.floor(x)`, `Math.round(x)`, `Math.random()`

## String Object

A primitive type DOES NOT have properties and methods.

In JavaScript there are two kinds of strings:

```javascript
// String primitive
const str1 = 'hi';
console.log(typeof str1); // string

// String object
const str2 = new String('hi');
console.log(typeof str2); // object
```

When the dot notation is used with a String primitive, JavaScript internally
converts the String primitive to a String object.

Important String methods:

- const message = ‘This is my first message’;
- message.length
- message[0]
- message.includes(substr);
- message.startsWith(str);
- message.endsWith(str);
- message.indexOf(‘my’); //=> 8
- message.replace(replaceThis, withThat);
- message.toUpperCase();
- message.toLowerCase();
- message.trim(); // also trimLeft and trimRight

Escape notation

- \0, \’, \”, \\, \n, \r, \v, \t

## Template Literal

An alternate way to create a String that avoids quoting, escaping, and concatenation.

```javascript
const fullName = 'Frank';

// Without string template
const str1 = 'Hi ' + fullName +',\n\nThank you for signing up.\n\nSincerely,\nJames';
console.log(str1);

// With string template
const str2 = `Hi ${fullName},

Thank you for signing up.

Sincerely,
James.`;
console.log(str2);
```

## Date Object

Represents a time by giving date and time of day.

```javascript
const now = new Date(); // Current date & time
console.log(now);

const date1 = new Date('March 15 1967 3:15 AM');
console.log(date1);

const year = 1967;
const month = 2; // 0-base month # for March
const day = 15;
// also takes the following optional arguments: hour, min, sec, ms (default is 0)
const date2 = new Date(year, month, day);
console.log(date2);
```

MONTH IS ZERO BASED!

Interesting Date methods:

```javascript
now.toDateString(); // "Thu May 11 2017"
now.toTimeString(); // "11:35:01 GMT-0700 (PDT)"
now.toISOString(); // "2017-05-11T18:35:01.212Z"
```
