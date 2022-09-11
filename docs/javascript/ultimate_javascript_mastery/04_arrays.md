# Ultimate JavaScript Mastery: Arrays

## Adding Elements

Use `push` and `unshift`:

```javascript
const numbers = [3, 4];
numbers.push(5, 6);
numbers.unshift(1, 2);
console.log(numbers);
```

Use `splice` to add elements to the middle of an array:

```javascript
Array.splice(startIndex, deleteCount, ...itemsToAdd);
```

```javascript
const numbers = [1, 2, 3, 4, 5, 6];
numbers.splice(2, 0, 2.25, 2.5, 2.75);
console.log(numbers);
```

## Finding Elements

### Primitives

To find primitives in an array, use `indexOf`.  This method uses the strict equality operator (`===`) for comparisons.

```javascript
Array.indexOf(searchElement, fromIndex);
```

```javascript
const numbers = [1, 2, 3, 1, 4];
console.log(numbers.indexOf('a')) // -1
console.log(numbers.indexOf(1)) // 0
console.log(numbers.indexOf('1')) // -1 (since '1' is a string)
console.log(numbers.indexOf(1, 1)) // 3 (since startIndex skips the first entry)
```

or `lastIndexOf`:

```javascript
Array.lastIndexOf(searchElement, fromIndex);
```

```javascript
const numbers = [1, 2, 3, 1, 4];
console.log(numbers.lastIndexOf(1)); // 3
console.log(numbers.lastIndexOf(1, 2)); // 0 (since searching backwards from index 2)
console.log(numbers.lastIndexOf(1, -2)); // 3
console.log(numbers.lastIndexOf(1, -3)); // 0 (since searching backards from index 2)
```

or `includes`:

```javascript
const numbers = [1, 2, 3, 4];
console.log(numbers.includes(9)); // false
console.log(numbers.includes(1)); // true
```

### Reference Types

Since `indexOf`, `lastIndexOf`, and `includes` uses the strict comparison operator, array elements can not be found based on their attribute values.

```javascript
const people = [
  { id: 1, name: 'James' },
  { id: 2, name: 'Frank' }
];
console.log(people.includes({ id: 3, name: 'Frank' })); // false!
```

Instead, for reference types, use `find`. `find` returns `undefined` if an element is not found:

```javascript
const people = [
  { id: 1, name: 'James' },
  { id: 2, name: 'Frank' }
];

person = people.find (function(p) {
  return p.name == 'Frank';
});
console.log(person); // { id: 2, name: 'Frank' }

person = people.find (function(p) {
  return p.name == 'Margaret';
});
console.log(person); // undefined
```

There is a similar methods called `findIndex` which returns the index or -1 if an matching item could not be found.

## Arrow Functions

Normally, when passing a function, you define the function like this:

```javascript
const letters = ['a', 'b', 'c', 'd'];
index = letters.findIndex(function(l) {
  return l === 'c';
});
console.log(index); // 2
```

Arrow functions are a shortcut for passing functions:

```javascript
const letters = ['a', 'b', 'c', 'd'];
index = letters.findIndex(l => l == 'c');
console.log(index); // 2
```

## Removing Elements

Use `pop` to remove an item from the end of an array;

```javascript
const numbers = [1, 2, 3, 4];
console.log(numbers.pop()); // 4
console.log(numbers); // [1, 2, 3]
```

Use `shift` to remove an item from the beginning of an array:

```javascript
const numbers = [1, 2, 3, 4];
console.log(numbers.shift()); // 1
console.log(numbers); // [2, 3, 4]
```

Use `splice` to remove items from the middle of an array. `splice` returns the elements removed:

```javascript
const numbers = [1, 2, 3, 4];
// Remove the middle two elements
console.log(numbers.splice(1, 2)); // [2, 3]
console.log(numbers); // [1, 4]
```

## Emptying an Array

There are several solutions.  Go with solution #1 or #2 if possible.

Solution 1 (only works if array isn't a `const`):

```javascript
let numbers = [1, 2, 3, 4];
numbers = [];
console.log(numbers); // [ ]
```

Solution 2 (setting the length to zero):

```javascript
const numbers = [1, 2, 3, 4]
numbers.length = 0;
console.log(numbers); // [ ]
```

Solution 3 (using `slice`):

```javascript
const numbers = [1, 2, 3, 4]
numbers.splice(0, numbers.lenght);
console.log(numbers); // [ ]
```

Solution 4 (using a `while` loop and `pop`/`shift`):

```javascript
const numbers = [1, 2, 3, 4];
while (numbers.length > 0) numbers.pop();
console.log(numbers); // [ ]
```

## Combining and Slicing Arrays

Use `Array.concat` which returns a copy of the array:

```javascript
const first = [1, 2, 3];
const second = [4, 5, 6];
result = first.concat(second);
console.log(first, second, result); // [1, 2, 3] [4, 5, 6] [1, 2, 3, 4, 5, 6]
```

Use `slice` to slice an array. `slice` returns a shallow copy of the array.

```javascript
const numbers = [1, 2, 3, 4, 5, 6];
console.log(numbers.slice()); // [1, 2, 3, 4, 5, 6]
console.log(numbers.slice(2)); // [3, 4, 5, 6]
console.log(numbers.slice(2, 4)); // [3, 4]
// the original array is not changed
console.log(numbers); // [1, 2, 3, 4, 5, 6]
```

## The Spread Operator

The spread operator (`...`) can be used to concatenate mutiple arrays.  It also allows mixing in other new elements too.

```javascript
const first = [1, 2, 3];
const second = [4, 5, 6];
const combined = [0, ...first, ...second, 7];
console.log(combined); // [0, 1, 2, 3, 4, 5, 6, 7]
```

The spread operator can be used to do a shallow copy of an array:

```javascript
const numbers = [1, 2, 3];
const copy = [...numbers];
console.log(copy); // [1, 2, 3]
console.log(numbers === copy); // false
```

## Iterating an Array

Iterating with a `for... of` loop:

```javascript
const numbers = [1, 2, 3];
for (let number of numbers)
  console.log(number);
```

or use the `forEach` method:

```javascript
const numbers = [1, 2, 3];
numbers.forEach((n, i) => console.log(i, n));
```

## Joining Arrays

The `join` method concatenates each element into a string with an optional separator:

```javascript
const numbers = [1, 2, 3];
console.log(numbers.join(', ')); // '1, 2, 3'
```

This method is the opposite of the `String` `split` method:

```javascript
const str = '1, 2, 3';
console.log(str.split(', ')); // ['1', '2', '3']
```

## Sorting Arrays

The `sort` method converts each array element to a string and then sorts the result:

```javascript
const numbers = [2, 3, 1];
numbers.sort(1, 2, 3);
```

Provide your own comparison function to `sort` to control the sort order:

```javascripts
const people = [
  { id: 1, name: 'James' },
  { id: 2, name: 'alfred' }
];

// Case insensative sort
function compare(a, b) {
	const aName = a.name.toLowerCase();
	const bName = b.name.toLowerCase();
	if (aName < bName) return -1;
	if (aName > bName) return 1;
	return 0;
}

people.sort((a, b) => compare(a, b));
console.log(people); // [ { id: 2, 'Alfred' }, { id: 1, 'James' } ]
```

## Reversing Arrays

Use `reverse` method to reverse the order of an array. Modifies the array in place.

```javascript
const numbers = [1, 2, 3];
numbers.reverse();
console.log(numbers); // [3, 2, 1]
```

## Testing the Elements of an Array

Use `every` to see if every element in an array meet some criteria:

```javascript
const numbers = [1, 2, 3];
const allPositive = numbers.every(value => value >= 0);
console.log(allPositive); // true
const allOdd = numbers.every(value => value % 2 != 0);
console.log(allOdd); // false
```

Use `some` to see if any element in an array meets some criteria:

```javascript
const numbers = [1, 2, 3];
const somePositive = numbers.some(value => value >= 0);
console.log(somePositive); // true
const someNegative = numbers.some(value => value < 0);
console.log(someNegative); // false
```

## Filtering an Array

Use `filter` to select only array elements that match some criteria. Returns a new array.

```javascript
const numbers = [1, -1, 2, 3];
const positiveNumbers = numbers.filter(num => num >= 0);
console.log(positiveNumbers); // [1, 2, 3]
```

An example working on objects instead of primitives:

```javascript
const people = [
  { name: 'James', age: 19 },
  { name: 'Bob', age 32 },
  { name: 'Mary', age: 50 }
];

const teenagers = people.filter(p => p.age >= 13 && p.age <= 19);
console.log(teenagers); // [ { name: 'James', age: 19 } ]
```

## Mapping an Array

Transform each element in one array into something else stored in another array. Returns a new array.

```javascript
const numbers = [1, 2, 3];
const doubledNumbers = numbers.map(n => ({ value: n }));
console.log(doubledNumbers); // [ { value: 1 }, { value: 2 }, { value: 3 } ]
```

## Reducing an Array

To sum the elements of an array:

```javascript
const numbers = [1, 2, 3, 4, 5];

let sum = 0;
for (let n of numbers) sum += n;

console.log(sum); // 15
```

Use the `reduce` method to reduce all elements of an array to a single value:

```javascript
const numbers = [1, 2, 3, 4, 5];
const sum = numbers.reduce((accumulator, currentValue) => accumulator + currentValue);
console.log(sum); // 15
```
