# Ultimate JavaScript Mastery: Control Flow

## if…else
```javascript
if (condition) {
 statement
}
else if (anotherCondition) {
 statement
}
else if (yetAnotherCondition) {
 statement
}
else {
}
```

Curley braces can be left off for only a single statement.

## switch…case
```javascript
let role;
switch (role) {
 case ‘guest’:
  console.log(‘Guest User’)
  break;
 case ‘moderator’:
  console.log(‘Moderator User’);
  break;
 default:
  console.log(‘Unknown User’);
}
```

## for loop

```javascript
for (init ; cond; inc) {
 statement
}
```

```javascript
for (let i = 0; i < 5 ; i++) {
 console.log(i);
}
```

Just like the ‘if’ statement, Curley braces can be left off if statement is a single statement

## while loop

```javascript
while (cond) {
  statements
}
```

Equalivent to the for loop above:

```javascript
let i = 0;
while (i < 5) {
  console.log(i);
  i++;
}
```

## do... while loop

```javascript
do {
  statements
} while (cond);
```

Equalivent to the for loop above:

```javascript
let i = 0;
do {
  console.log(i);
  i++;
} while (i < 5);
```

## for... in loop

Iterate over properties in an object

```javascript
const person = {
 name: ‘James’,
 age: 19
};
for (let propertyName in person)
 console.log(propertyName, person[propertyName]);
```

Can be used to iterate over an array as follows:

```javascript
const colors = [‘red’, ‘green’, ‘blue’];
for (let index in colors)
 console.log(index, colors[index]);
```

## for... of loop

Iterate over elements in an array

```javascript
const colors = [‘red’, ‘green’, ‘blue’];
for (let color of colors)
 console.log(color);
```

## break and continue

Changes how the loop behaves

Use `break` to exit the loop:

```javascript
let i = 0;
while (i <= 10) {
  if (i === 5) break; // break out of the loop when i is 5
  console.log(i);
  i++;
}
```

Use `continue` to jump to the next iteration. The following only prints odd numbers:

```javascript
// Write odd numbers to the console log

let i = 0;
while (i <= 10) {
  if (i % 2) === 0) {
   i++;
   continue;
  }
  console.log(i);
  i++;
}
```
