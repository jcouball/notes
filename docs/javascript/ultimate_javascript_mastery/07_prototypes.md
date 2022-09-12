# Ultimate JavaScript Mastery: Prototypes

## Inheritance

Inheritance is a mechanism for sharing code.

Common code is put into a super class and inherit to reuse code into a subclass.

There are two types of inheritance: Classical vs. Prototypical Inheritance.

## Prototypes and Prototypical Inheritance

Every object in Javascript (except one, the ***common object ancestor***), has a
prototype or parent.  An object 'inherits' all the members of the its prototype.

Prototypes themselves have a prototype and are thus chained together. An object
'inherits' all the members members of the entire prototype chain.

Every object created in Javascript inherits from a common object ancestor. This is the
last prototype in an object's ***prototype chain***. This common ancestor does not
itself have a prototype.

When accessing a object's member, first the object is checked.  If the member is not
found on the object, then its prototype is checked. If not found there, the prototype's
prototype is checked and so on through the prototype chain.

Use `Object.getPrototypeOf(obj)` to get the prototype of any object or
`Object.setPrototypeOf(obj)`. The `__proto__` property is the deprecated way getting
and setting an object's prototype.

```javascript
let x = {}
let y = {}

console.log(Object.getPrototypeOf(x));
console.log(Object.getPrototypeOf(x) === Object.getPrototypeOf(y)); // true
```

## Multilevel Inheritance

Objects created by a given constructor will have the same prototype.

```javascript
function Person(name) {
  this.name = name
}

person1 = new Person('Bob Smith');
person2 = new Person('Jane Doe');

console.log(getPrototypeOf(person1) === getPrototypeOf(person2));
```

## Property Descriptors

Properties have descriptors that define if the object is ritable, enumerable, or configurable.

Use `Object.getOwnPropertyDescriptor(obj, propertyName)` to get a property's descriptor object.

```javascript
let person = { name: 'James' };
let nameDescriptor = Object.getOwnPropertyDescriptor(person, 'name');
console.log(nameDescriptor);
// {value: 'James', writable: true, enumerable: true, configurable: true}

let objectBase = Object.getPrototypeOf(person);
let toStringDescriptor = Object.getOwnPropertyDescriptor(objectBase, 'toString');
console.log(toStringDescriptor);
// {writable: true, enumerable: false, configurable: true, value: ƒ}
```

The descriptor can be set with `Object.defineProperty(obj, propertyName, descriptor)`.
The default for `writable`, `enumerable`, and `configurable` are all `true`.

```javascript
let person = { name: 'James' };

Object.defineProperty(person, 'name', {
  writable: false, // the property is now read only
  enumerable: false, // the property won't show up in Object.keys or in for... in loops
  configurable: false, // the property won't be able to be deleted
  // get: <<getter function>>,
  // set: <<setter function>>,
});

// Writable
person.name = 'Bob'; // not being writable doesn't throw an error
console.log(person.name); // James

// Enumerable
console.log(Object.keys(person)); // []
for ( let key in person) console.log(key, person[key]); // nothing will be logged
console.log(person); // { name: 'James' } - name still shows up here

// Configurable
delete person.name;
console.log(person); // { name: 'James' } - still has the name property
```

## Constructor Prototypes

Set a constructor function's `prototype` property to define what object another object
should inherit from.

```javascript
function Creature(name) {
  this.name = name
}

function Person(name) {
  this.prototype = Creature
  this.move = function
}

function Fish(name) {
  this.prototype = Creature

}

function Bird(name) {
  this.prototype = Creature
}
```

## Prototype vs Instance Members

```javascript
function Person(name) {
  this.name = name
}

Person.prototype.firstName = function() { return this.name.split(' ')[0] }
Person.prototype.lastName = function() { return this.name.split(' ')[1] }

const p1 = new Person('James Couball');
const p2 = new Person('Bob Smith');

// Methods defined in the prototype can be called
console.log(p1.firstName()); // James
console.log(p1.lastName()); // Couball

// The prototypes are the same for p1 and p2:
console.log(Object.getPrototypeOf(p1) === Object.getPrototypeOf(p2)); // true

// A method in the prototype can override an ancestor method
console.log(p1.toString()); // [object Object]
Person.prototype.toString = function() { return `A person named ${this.name}` }
console.log(p1.toString()); // A person named James Couball
```

## Iterating Instance and Prototype Members

`Object.keys` only returns ***instance members***.  This does not include members
defined by this object's prototype chain.

`for... in` loop returns ***all members*** defined in the instance and by the prototype
chain.

The `hasOwnProperty(propertyName)` (defined in the root object) returns `true` if the
`propertyName` is an instance member.

```javascript
function Person(name) {
  this.name = name
}

Person.prototype.firstName = function() { return this.name.split(' ')[0] }
Person.prototype.lastName = function() { return this.name.split(' ')[1] }

const p1 = new Person('James Couball');

console.log(p1.hasOwnProperty('firstName')); // false
```

## Avoid Extending the Built-in Objects

***Do not modify objects you do not own!***

Avoid doing something like this that extends a built-in object:

```javascript
Array.prototype.shuffle = function() {
  // ...
}
const array = [1, 2, 3, 4, 5];
array.shuffle();
```
