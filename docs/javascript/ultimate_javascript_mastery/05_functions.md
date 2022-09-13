# Ultimate JavaScript Mastery: Functions

## Function Declarations vs. Expressions

Functions are objects. The can be anonymous.

```javascript
// Function declaration
function walk() {
  console.log('walk');
}

// Anonymous function expression
let run = function() { console.log('run') };

// Named function expression
let run2 = function run2Function() { console.log('run') };

run(); // 'run'

let move = walk;
move(); // 'walk'
move = run;
move(); // 'run'
```

Function declarations can be used before it is defined. With function
expressions, the variable must be in-scope and set before calling the
function.

## Hoisting

Hoisting is the process of moving function declarations to the top of the
code. This is why functions defined with declarations can be used before
their defined.

## Arguments

The `arguments` function returns an array of the arguments passed to it.

```javascript
function sum(a, b) {
  return a + b;
}
console.log(sum(1, 2)); // 3
console.log(sum(1)); // NaN... trying to add 1 + undefined

function safeSum() {
  let total = 0;
  for (let n of arguments) { total += n; }
  return total;
}

console.log(safeSum(1)); // 1
console.log(safeSum(1, 2)); // 3
console.log(safeSum(1, 2, 3, 4, 5)); // 1
```

## The Rest Operator

The rest operator (`...`) can be used to collect the rest of the arguments
passed to a function as an array. It can only be used at the end of the
argument list.

```javascript
function safeSum(...args) {
  return args.reduce((a, n) => a + n);
}

console.log(safeSum(1)); // 1
console.log(safeSum(1, 2)); // 3
console.log(safeSum(1, 2, 3, 4, 5)); // 1
```

## Default Parameters

Set default values in the function definition. By default, the default value
for an argument is `undefined`.

```javascript
function interest(principal, rate = 3.5, years = 5) {
  return principal * rate / 100 * years
}

console.log(interest(10000, 3.5, 5)); // 1750
console.log(interest(10000)); // 1750

// Passing undefined will cause the default value to be used
console.log(interest(10000, undefined, 5)); // 1750
```

## Getters and Setters

Approach to creating a dynamic property with a method:

```javascript
const person = {
  firstName: 'James',
  lastName: 'Couball',
  fullName() { return `${person.firstName} ${person.lastName}` }
};

// Get the fullName 'property' using a method
console.log(person.fullName()); // 'James Couball'
```

Prefix the method with the `get` keyword to make a getter that is accessed
like a property. A setter is similarly create with the `set` keyword:

```javascript
const person = {
  firstName: 'James',
  lastName: 'Couball',
  get fullName() {
    return `${person.firstName} ${person.lastName}`
  },
  set fullName(value) {
    const parts = value.split(' ');
    this.firstName = parts[0];
    this.lastName = parts[1];
  }
};

// Looks like a property instead of a method call
person.fullName = 'John Smith';

// { firstName: 'John', lastName: 'Smith', fullName: [Getter/Setter] }
console.log(person);
```

## `try` / `catch` / `finally` / `throw`

A function can signal error conditions by throwing an error using the `throw` keyword.

```javascript
const person = {
  firstName: 'James',
  lastName: 'Couball',
  set fullName(value) {
    if (typeof value !== 'string')
      throw new Error('value must be a string');

    const parts = value.split(' ');
    if (parts.length != 2)
      throw new Error('value must include only a first and last name')

    this.firstName = parts[0];
    this.lastName = parts[1];
  }
};

try {
  person.fullName = null;
}
catch (e) {
  console.log(e.message); // 'value must be a string'
}

try {
  person.fullName = 'Madonna';
}
catch (e) {
  console.log(e.message); // 'value must include only a first and last name'
}
```

## Local vs Global Scope and `let` vs `var`

The scope of a variable deteremines where the variable is accessible.

`let` and  `const` define block-scoped variables: they are only accessible
in the block they are defined in.

 `var` defines function-scoped variables. Using `var` outside of a function
 creates a global variable and attaches it to the `window` object. This is
 could cause variables or functions to be overwritten in the `window` object.

Variables defined in a block take precedence (or shadow) variables defined
globally or in a scope outside the current block.

## The `this` Keyword

`this` is the **object** that is executing the current function.

For a method (a function of an object), `this` is a reference to the object
for which the method was called:

```javascript
const video = {
  title: 'a',
  play() {
    console.log(this); // { title: 'a', play: [Function: play] }
  }
};

video.stop = function() {
  console.log(this); // { title: 'a', play: [Function: play] }
}

video.play();
video.stop();
```

For a function (not part of an object), `this` is a reference to either
`window` (in browsers) or  `global` (in Node):

```javascript
const video = {
  title: 'a';
};

function playVideo() {
  console.log(this); // <ref *1> Object [global] { ... }
}

playVideo();
```

In a constructor function, `this` is set to the new object via the `new` keyword:

```javascript
function Video(title) {
  this.title = title;
  console.log(this); // Video { title: 'a' }
}

const v = new Video('a');
```

Inside a callback function, `this` is set to the global object. This can lead
to surprising results as the following use of `forEach` illustrates:

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3'],
  showTags() {
    this.tags.forEach(function(tag) {
      // `this` references the global object so video's `title` property is not available
      console.log(this.title, tag);
    })
  }
};

video.showTags();
```

results in the following output to the console:

```text
undefined t1
undefined t2
undefined t3
```

Many callback functions like `forEach` allow you to specify what `this` is
inside the callback function in a second argument after the callback function:

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3'],
  showTags() {
    this.tags.forEach(function(tag) {
      // now `this` references the video object
      console.log(this.title, tag);
    }, this)
  }
};

video.showTags();
```

results in the following output:

```javascript
a t1
a t2
a t3
```

## Changing `this`

`this` references the object that is executing.

Some callback functions do not allow `this` to be set.

One way to work around this it to set a block-scoped variable (you might name
it `that` or `self`) in a block that encloses the callback function. Here is
how it would work with the `forEach` example from the last section:

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3'],
  showTags() {
    const self = this;
    this.tags.forEach(function(tag) {
      // `this` references the global object
      // `self` references video
      console.log(self.title, tag);
    })
  }
};

video.showTags();
```

Function methods `call` and  `apply` allow `this` to be set for a function
call.  `bind` returns a new function where `this` is set for all future
function calls.

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3']
};

function playVideo() {
  console.log(this); // Output depends on how it is called
}

playVideo(); // Logs the global object
playVideo.call(video); // Sets `this` to video
playVideo.apply(video); // Also sets `this` to video
const fn = playVideo.bind(video); // Returns new funct where `this` is video
fn(); // Also sets `this` to video
```

So another solution is to use `bind` to set `this` on the callback function permanently:

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3'],
  showTags() {
    this.tags.forEach(function(tag) {
      console.log(this.title, tag);
    }.bind(this));
  }
};

video.showTags();
```

The third and best solution is to use arrow functions for callbacks instead of
the `function` keyword. Arrow functions inherit `this` from the containing
function:

```javascript
const video = {
  title: 'a',
  tags: ['t1', 't2', 't3'],
  showTags() {
    this.tags.forEach(tag => console.log(this.title, tag));
  }
};

video.showTags();
```
