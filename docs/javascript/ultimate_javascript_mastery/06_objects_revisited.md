# Ultimate JavaScript Mastery: Objects Revisited

## Object Oriented Programming

The purpose of OOP is to give you tools to more effectively manage complexity with your code.

OOP groups related pieces of data together with the functions that operate on that data.

The four core concepts of OOP:

* **Encapsulation**: encapsulation describes the idea of bundling data and methods that
  work on that data within one unit, like a Javascript object. This concept is also
  often used to hide the internal representation, or state of an object from the
  outside. This is called information hiding. Benefits: reduce complexity, increase
  reusability.
* **Abstraction**: hiding the details of how things work and focusing attention on
  details of greater importance. Benefits: reduce complexity, isolate impact of change
* **Inheritance**: a mechanism that allows you to remove duplicate code. Benefits:
  eliminate redundant code.
* **Polymorphism**: the provision of a single interface to entities of different types.
  This mechanism can be used to eliminate long if-then-else or switch blocks. Benefits:
  reduce complexity, reduce code dependencies

In Javascript, the `class` is syntatic sugar over Prototypes and Prototypical
Inheritance.

## Creating Objects

There are three ways to create objects in Javascript: with object lIterals, a factory
function, or a constructor function.

### Object Literals

```javascript
person = {
  id: 1, name: 'James Couball',
  firstName: function() {
    return this.name.split(' ')[0];
  },
  lastName: function () {
    return this.name.split(' ')[1];
  }
}

console.log(person);
console.log(person.firstName());
console.log(person.lastName());
```

### Factory Function

By convention, factory functions are named `create____` using camel case.

```javascript
function createPerson(id, name) {
  return {
    // id: id, name: name, // if key and value variable name are the same, drop the value
    id, name,
    firstName: function() {
      return this.name.split(' ')[0];
    },
    lastName: function () {
      return this.name.split(' ')[1];
    }
  }
}

let person = createPerson(1, 'James Couball');
console.log(person);
console.log(person.firstName());
console.log(person.lastName());

person = createPerson(2, 'Frank Throckmorton');
console.log(person);
console.log(person.firstName());
console.log(person.lastName());
```

### Constructor Function

By convention, a constructor function is named after the type of object being created
using Pascal case.

```javascript
function Person(id, name) {
  // `new Person(...)` sets the `this` reference
  this.id = id;
  this.name = name;
  this.firstName = function () { return this.name.split(' ')[0] }
  this.lastName = function () { return this.name.split(' ')[1] }
  // No explicit return needed
}

let person = new Person(1, 'James Couball');
console.log(person);
console.log(person.firstName());
console.log(person.lastName());

person = new Person(2, 'Frank Throckmorton');
console.log(person);
console.log(person.firstName());
console.log(person.lastName());
```

## Constructor Property

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
  this.firstName = function () { return this.name.split(' ')[0] }
  this.lastName = function () { return this.name.split(' ')[1] }
}

let person = new Person(1, 'James Couball');

console.log(person.constructor);
```

## Functions are Objects

A function is an object with properties and methods:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
  this.firstName = function () { return this.name.split(' ')[0] }
  this.lastName = function () { return this.name.split(' ')[1] }
}

console.log(Person.name);
console.log(Person.lenght);
console.log(Person.constructor);
```

A function can be created dynamically using the `Function` constructor:

```javascript
const Person = new Function('id', 'name', `
  this.id = id;
  this.name = name;
  this.firstName = function () { return this.name.split(' ')[0] }
  this.lastName = function () { return this.name.split(' ')[1] }
`)

console.log(new Person(1, 'Jane Doe'));
```

You can call a function programatically using the `call` method. Note that in the case
of calling a constructor function, the constructor function will have to explitly
return `this` in order to work as expected.

```javascript
const Person = new Function('id', 'name', `
  this.id = id;
  this.name = name;
  this.firstName = function () { return this.name.split(' ')[0] }
  this.lastName = function () { return this.name.split(' ')[1] }
  return this; // when a constructor is called with .call, you have to return this explicitly.
`)

const person = Person.call({}, 1, 'James Couball');

console.log(person);
```

## Value vs. Reference Types

When ***primitives*** are copied, their value is copied and the copy is independent of
the original.

When ***objects*** are copied, the reference to the object is copied. This is known as
a *shallow copy*. The copy is NOT independent of the original since they refer to the
same underlying object.

| Primitive / Value Types                                      | Reference Types                 |
| ------------------------------------------------------------ | ------------------------------- |
| Number<br />String<br />Boolean<br />Symbol<br />undefined<br />null | Object<br />Function<br />Array |

Value types are always copied when assigned.  Two different variables with the
same value are independent.

```javascript
let x = 10;
let y = x;

x = 20;

console.log(y); // still 10.  x and y are independent.
```

A reference refers to some other location in memory that might be shared
between two different variables.

```javascript
let x = { value: 10 };
let y = x;

x.value = 20;

console.log(y); // { value: 20 } y points to the SAME object in memory as x
```

Primitives are copied when passed to a function:

```javascript
let number = 10;

function increase(number) {
  // This number is independent of the outer number (it shadows that number)
  number++;
}

increase(number);

console.log(number); // 10
```

## Adding or Removing Properties

Javascript is a dynamic language.  Properties can be added whenever you need
them simply by setting them with dot notation:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const person = new Person(1, "James Couball");
person.age = 39;

console.log(person); //Person {id: 1, name: "James Couball", age: 39}
```

Bracket notation can be used if you don't know the name ahead of time or if
the property name is not a valid identifier:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const newPropertyName = 'age';
const newPropertyValue = 39;

person = new Person(1, "James Couball");
person[newPropertyName] = newPropertyValue;

console.log(person); //Person {id: 1, name: "James Couball", age: 39}
```

A property can be removed using the `delete` operator:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

person = new Person(1, "James Couball");

delete person.name

console.log(person); //Person {id: 1}
```

## Enumerating Properties

Use a `for... in` loop to iterate over an object's properties:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const person = new Person(1, "James Couball");

for (let propertyName in person) {
  // Use bracket notation to get the property value
  const propertyValue = person[propertyName];
  console.log(propertyName, propertyValue);
}
```

An alternate way to get the properties is via `Object.keys`:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const person = new Person(1, "James Couball");

// Note the use of a `for... of` loop instead of a `for... in` loop
for (let propertyName of Object.keys(person)) {}
  // Use bracket notation to get the property value
  const propertyValue = person[propertyName];
  console.log(propertyName, propertyValue);
}
```

To see if a property exists for an object, use the `in` keyword:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const person = new Person(1, "James Couball");

if ('id' in person) console.log('Person has an id');
```

or the `Object.keys` and the `includes` functions:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;
}

const person = new Person(1, "James Couball");

if (Object.keys(person).includes('id')) console.log('Person has an id');
```

## Private Properties and Methods

Hide the details and complexity and show only the essential features.

Properties and methods that are part of the implementation details should be
made private so they can not be used by users of the object.

Make properties private by declaring them as block-scope variables (using
`let` or `const`) in the Constructor function:

```javascript
function Person(id, name) {
  this.id = id;
  this.name = name;

  // nameSeparator is a private variable
  let nameSeparator = ' ';

  // parseName is a private method
  //
  // `this` within the function would be the global object unless
  // set to something else with `bind`
  //
  let parseName = function() {
    return this.name.split(nameSeparator);
  }.bind(this);

  this.firstName = function() { return parseName()[0] }
  this.lastName = function() { return parseName()[1] }
}

person = new Person(1, 'James Couball');

console.log(person.firstName()); // James
console.log(person.lastName()); // Couball
```

## Getters and Setters

Use `defineProperty` to define a property with a getter and/or setter.

Getters can be used to calculate the value dynamically.

Setters can be used to validate the new value before storing it.

```javascript
function Person(id, name) {
  this.id = id;
  let privateName = name

  Object.defineProperty(this, 'name', {
    get: function() { return privateName },
    set: function(value) { privateName = value }
  });
}

person = new Person(1, 'James Couball');
console.log(person.name)

person.name = 'Jane Doe';
console.log(person.name);
```
