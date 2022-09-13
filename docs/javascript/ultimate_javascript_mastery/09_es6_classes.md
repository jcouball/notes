# Ultimate JavaScript Mastery: ES6 Classes

## ES6 Classes

Syntatical sugar over prototypical inheritance. So this:

```javascript
function Circle(radius) {
  this.radius = radius;
  this.draw = function() {
    console.log('draw');
  }
}

circle = new Circle(10);
```

Is equivalent to this:

```javascript
class Circle {
  constructor(radius) {
    this.radius = radius;
    // methods defined here end up directly on `this`
    this.move = function() {}
  }
  // methods defined here end up on the prototype
  draw() {
    console.log('draw');
  }
}

circle = new Circle(10);
```

## Hoisting

In Javascript there are two syntaxes for defining a function:

```javascript
// Function Declaration
function sayHello() {}

// Function Expression
const sayGoodbye = function() {};
```

***Function declarations*** are said to be `hoisted` since they act as if all function
declarations happened before code is actually run. This means you can use the function
before the line on which it is defined.

***Function expressions*** are not hoisted. This means the function definition must
come before it's use in a file.

The same thing applies to class definitions:

```javascript
// Class Declaration
class Circle { }

// Class Expression
const Square = class { };
```

Class declarations are hoisted and class expressions are not.

## Static Methods

An ***instance method*** is behavior attached to an instance of a class (aka an object).

A ***static method*** is behavior attached to a class.

```javascript
class Circle {
  constructor(radius) {
    this.radius = radius;
  }

  // Instance Method
  draw() { }

  // Static Methods
  static parse(str) {
    // this is the Circle constructor function
    console.log(this);
    const radius = JSON.parse(str).radius;
    return new Circle(radius);
  }
}

const circle1 = new Circle(10);
console.log(circle1); // Circle { radius: 10 }

// Call the static method `parse`
const circle2 = Circle.parse('{ "radius": 5 }');
console.log(circle2); // Circle { radius: 5 }
```

## The `this` keyword

A ***Method Call*** is when you run a function using dot notation `<object>.method()`.
This call has a 'receiver' identified by `<object>`.  Within the method, `this` is set
to refer to this object.

A ***Function Call*** is when you call a function without a receiver. Within this
function, `this` is set to the global object (or `undefined` if strict mode is on).

```javascript
const Circle = function() {
  this.draw = function() { console.log(this) }
};

const c = Circle();
// Method Call
// has a receiver -- `this` inside the function is set to `c`
c.draw();

// Get a reference to the draw method
const draw = c.draw;

// Function Call
// without a receiver -- `this` inside the function is set to the global object
draw();
```

Use the `.call` method to call the function and set `this`.

```javascript
draw.call(c);
```

## Private Members Using Symbols

By default all attributes are public.

```javascript
class Circle {
  constructor(radius) {
    this.radius = radius;
  }
}

const c = new Circle(10);
c.radius;
```

Sometimes people name their properties beginning with an underscore in order to
communicate the property is private. This is convention.  There is a better way using
ES6 Symbols.

A Symbol is an opaque, unique identifier.  The `Symbol()` function (do not use `new`)
returns a new Symbol. Everytime you call `Symbol()` you get a different symbol.

To create a private property, fetch a value for the property's identifier (`_radius` in
the example below) and then store the attribute value in `this[_radius]`.  An array of
Properties keyed by Symbols can be fetched using `Object.getOwnPropertySymbols`.

```javascript
const _radius = Symbol('radius');

class Circle {
  constructor(radius) {
    this[_radius] = radius;
  }
}

const c = new Circle(10);
console.log(c); // Circle { [Symbol(radius): 10 }

// You can still get at the private property using `Object.getOwnPropertySumbols`
const key = Object.getOwnPropertySymbols(c)[0];
console.log(c[key]); // 10
```

Similarly, a method can be made private:

```javascript
const _radius = Symbol('radius');
const _draw = Symbol('draw method');

class Circle {
  constructor(radius) {
    this[_radius] = radius;
  }

  // Use a ***computed property name*** for the method
  [_draw]() { console.log('draw'); }
}

const c = new Circle(10);
console.log(c); // Circle { [Symbol(radius): 10 }
```

## Private Members Using WeakMaps

Make the `radius` property private:

```javascript
const _radius = new WeakMap();

class Circle {
  constructor(radius) {
    // Write the property
    _radius.set(this, radius);
  }

  draw() {
    // Read the property
    const radius = _radius.get(this);
    console.log(radius);
  }
}

const c = new Circle(99);
c.draw(); // 99
```

Make the `move` method private:

```javascript
const _radius = new WeakMap();
const _move = new WeakMap();

class Circle {
  constructor(radius) {
    // Write the property
    _radius.set(this, radius);
    // Set the reference to the method -- use an arrow function so this is set
    _move.set(this, () => console.log('move', this));
  }

  draw() {
    // Read the private property `radius`
    const radius = _radius.get(this);
    console.log(radius);

    // Call the private method `move`
    _move.get(this)();
    console.log('draw');
  }
}

const c = new Circle(99);
c.draw(); // 10\nmove - undefined\ndraw
```

## Getters and Setters

Use the `get` keyword to dynamically create a property getter on an object. This is
useful to expose a private property or a computed property.

Use the `set` keyword to dynamically create a property setter on an object.

```javascript
const _radius = new WeakMap();

class Circle {
  constructor(radius) {
    _radius.set(this, radius);
  }

  get radius() { return _radius.get(this); }
  set radius(value) { _radius.set(this, value) }
}

const c = new Circle(10);
console.log(c.radius); // 10

c.radius = 99;
console.log(c.radius); // 99
```

## Inheritance

Use the `extends` in a class definition to define inheritance:

```javascript
class Shape {
  move() {
    console.log('move');
  }
}

// Circle inherits from Shape by using the `extends` keyword
class Circle extends Shape {
  constructor(radius) {
    // Must call super constructor in derived class before accessing 'this' or
    // returning from derived constructor
    super();
    this.radius = radius;
  }

  draw() {
    console.log('draw');
  }
}

const c = new Circle(99, 'red');
console.log(c); // Circle { color: 'red', radius: 99 }
c.draw(); // draw -- defined by Circle
c.move(); // move -- defined by Shape
```

## Method Overriding

A derived class can use `super` to call methods in base class. `super` is set to the
base class.

```javascript
// Accessing super class properties
super.property;
super[expr];

// Calling super class methods
super([arguments]); // calls the parent constructor
super.functionOnParent([arguments]); // calls a parent method
```

An example:

```javascript
class Shape {
  move() {
    console.log('move');
  }
}

// Circle inherits from Shape by using the `extends` keyword
class Circle extends Shape {
  constructor(radius) {
    // Must call super constructor in derived class before accessing 'this' or
    // returning from derived constructor
    super();
    this.radius = radius;
  }

  draw() {
    console.log('draw');
  }

  // Override Shape.move() and call the super method
  move() {
    super.move();
    console.log('circle move');
  }
}

const c = new Circle(99, 'red');
console.log(c); // Circle { color: 'red', radius: 99 }
c.draw(); // draw
c.move(); // move\ncircle move
```
