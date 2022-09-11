# Ultimate JavaScript Mastery: Prototypical Inheritance

```javascript
function extend(Child, Parent) {
  Child.prototype = Object.create(Parent.prototype);
  Child.prototype.constructor = Child;
}

function Creature(name) {
  this.name = name;
}

Creature.prototype.move = function() { console.log(this.name + ' moved') }

function Person(name) {
  Creature.call(this, name);
}
extend(Person, Creature);

Person.prototype.move = function() {
  console.log('<<walking>>');
  Creature.prototype.move.call(this);
}

function Bird(name) {
  Creature.call(this, name);
}
extend(Bird, Creature);

Bird.prototype.move = function() {
  console.log('<<flying>>');
  Creature.prototype.move.call(this);
}

function Fish(name) {
  Creature.call(this, name);
}
extend(Fish, Creature);

Fish.prototype.move = function() {
  console.log('<<swimming>>');
  Creature.prototype.move.call(this);
}

creatures = [
  new Person('John'),
  new Bird('Polly'),
  new Fish('Nemo')
];

for (let creature of creatures) {
  creature.move();
}

```

## Creating Your Own Prototypical Inheritance

## Resetting the Constructor

## Calling the Super Constructor

## Intermediate Function Inheritance

## Method Overriding

## Polymorphism

## When to Use Inheritance

## Mixins

Use `Object.assign` to copy members from one or more sources to a target prototype. In the following example, the canEat and canWalk mixins are created and the `mixin` function adds their members to Person.

```javascript
function mixin(target, ...sources) {
  Object.assign(target.prototype, ...sources);
}

const canEat = {
  eat: function() {
    console.log('eating');
    this.hunger--;
  }
};

const canWalk = {
  walk: function() {
    console.log('walking');
  }
};

function Person() { }

mixin(Person, canEat, canWalk);

const person = new Person();
console.log(person); // Person {}
person.eat(); // eating
person.walk(); // walking
```
