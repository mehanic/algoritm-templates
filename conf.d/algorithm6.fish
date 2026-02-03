function algoP.ArrayCore1
    set output_file "main.py"

    set template_content '
import array
import unittest
from typing import Union

class Array:
    def __init__(self, size: int, typecode: str = "l"):
        if size <= 0:
            raise ValueError(f"Invalid array size (must be positive): {size}")
        self._size = size
        self._array = array.array(typecode, [0] * size)

    def __len__(self):
        return self._size

    def __getitem__(self, index: int) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError("array index out of range")
        return self._array[index]

    def __setitem__(self, index: int, val: Union[int, float]) -> None:
        if index < 0 or index >= self._size:
              raise IndexError("array assignment index out of range")
    
        # Get the expected type from the typecode
        expected_type = self._get_type_from_code()
        #print(f"Setting value: {val}, Expected type: {expected_type}, Actual type: {type(val)}")

        # Check if val is of the expected type
        if not isinstance(val, expected_type):
              raise TypeError(f"Expected value of type {expected_type}, got {type(val)}")
    
        # If the type is correct, assign the value to the array
        self._array[index] = val


    def __repr__(self):
        return repr(self._array)

    def _get_type_from_code(self):
        # Corrected dictionary syntax for typecode to Python type mapping
        type_mapping = {
            "b": int,   # signed char
            "B": int,   # unsigned char
            "h": int,   # signed short
            "H": int,   # unsigned short
            "i": int,   # signed int
            "I": int,   # unsigned int
            "l": int,   # signed long
            "L": int,   # unsigned long
            "q": int,   # signed long long
            "Q": int,   # unsigned long long
            "f": float, # float
            "d": float  # double
        }
        return type_mapping.get(self._array.typecode, object)  # default to object if typecode is not found




class TestArray(unittest.TestCase):
    # __init__
    def test_init_valid(self):
        """Test initializing Array with valid arguments"""
        arr = Array(5)
        self.assertEqual(len(arr), 5)
        self.assertEqual(arr[0], 0)
        arr = Array(3, "f")
        self.assertEqual(len(arr), 3)
        self.assertEqual(arr[0], 0.0)

    def test_init_invalid_size(self):
        """Test initializing Array with invalid size"""
        with self.assertRaises(ValueError):
            Array(-1)

    def test_init_invalid_typecode(self):
        """Test initializing Array with invalid typecode"""
        with self.assertRaises(ValueError):
            Array(5, "x")

    # __get_item__
    def test_get_item_valid(self):
        """Test getting an item with a valid index"""
        arr = Array(5)
        self.assertEqual(arr[0], 0)
        self.assertEqual(arr[1], 0)
        self.assertEqual(arr[2], 0)
        self.assertEqual(arr[3], 0)
        self.assertEqual(arr[4], 0)

        arr = Array(3, "d")
        self.assertEqual(arr[0], 0.0)
        self.assertEqual(arr[1], 0.0)
        self.assertEqual(arr[2], 0.0)


    def test_get_item_invalid(self):
        """Test getting an item with an invalid index"""
        arr = Array(5)
        with self.assertRaises(IndexError):
            arr[-1]
        with self.assertRaises(IndexError):
            arr[5]

    # __set_item__
    def test_set_item_valid(self):
        """Test setting an item with a valid index"""
        arr = Array(5)
        arr[0] = -1
        arr[1] = 3
        arr[2] = 33
        arr[3] = 42
        arr[4] = -1000
        self.assertEqual(arr[0], -1)
        self.assertEqual(arr[1], 3)
        self.assertEqual(arr[2], 33)
        self.assertEqual(arr[3], 42)
        self.assertEqual(arr[4], -1000)

    def test_set_item_invalid_value(self):
        """Test setting an element with an invalid value"""
        arr = Array(5)

        #with self.assertRaises(TypeError) as context:
        with self.assertRaises(Exception):
            arr[0] = 1.3
        #self.assertTrue("Expected value of type <class 'int'>" in str(context.exception))
        #self.assertTrue("got <class 'float'>" in str(context.exception)) 
        #self.assertTrue("Expected value of type <class 'int'>" in str(context.exception))
        #with self.assertRaises(TypeError) as context:
        with self.assertRaises(Exception):
            arr[1] = '1'
        #self.assertTrue("Expected value of type <class 'int'>" in str(context.exception))
        #self.assertTrue("got <class 'str'>" in str(context.exception))
        #self.assertTrue("Expected value of type <class 'int'>" in str(context.exception))
    
    def test_set_item_invalid_index(self):
        """Test setting an item with an invalid index"""
        arr = Array(5)
        with self.assertRaises(IndexError):
            arr[-1] = 1
        with self.assertRaises(IndexError):
            arr[5] = 1

    # __len__
    def test_len(self):
        """Test getting the length of the array"""
        arr = Array(5)
        self.assertEqual(len(arr), 5)

        arr = Array(31, "d")
        self.assertEqual(len(arr), 31)

    # __repr__
    def test_repr(self):
        """Test getting the string representation of the array"""
        arr = Array(5)
        arr[0] = 1
        arr[1] = 2
        arr[3] = -2
        #self.assertEqual(repr(arr), "array("l", [1, 2, 0, -2, 0])")
        repr_string = repr(arr)  # Get the actual repr string
        # Print actual repr for debugging
        print(f"Actual repr: {repr_string}")
        # Check if 'l' (typecode) is in the repr string
        self.assertIn("l", repr_string)
        # Check if the array values are correctly included in the repr string
        self.assertIn("[1, 2, 0, -2, 0]", repr_string)


if __name__ == "__main__":
    unittest.main(exit=False)

arr = Array(5)
print(len(arr))  # Output: 5
print(arr[0])  # Output: 0 (initial value)
print(arr[4])  # Output: 0 (initial value)

arr[2] = 10
print(arr[2])  # Output: 10

# Create an array of size 3
arr = Array(3)

# Set values at specific indices
arr[0] = 5
arr[1] = 10
arr[2] = 15

# Get values from specific indices
print(arr[0])  # Output: 5
print(arr[1])  # Output: 10
print(arr[2])  # Output: 15


# Create an array of size 3
arr = Array(3)

# Try assigning a value to an out-of-range index (this will raise an IndexError)
try:
    arr[3] = 20  # Should raise an IndexError
except IndexError as e:
    print(e)  # Output: array assignment index out of range

# Create an array of size 4
arr = Array(4)

# Set some values
arr[0] = 1
arr[1] = 2
arr[2] = 3
arr[3] = 4

# Print the array (using the __repr__ method)
print(arr)

# Create an array of size 3 with float typecode
arr = Array(3, "f")

# Set values (using floating-point numbers)
arr[0] = 1.1
arr[1] = 2.2
arr[2] = 3.3

print(arr)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ArrayDynamic2
    set output_file "main.py"

    set template_content '
import array
from typing import Union
import unittest

class Array:
    def __init__(self, size: int, typecode: str = "l"):
        if size <= 0:
            raise ValueError(f"Invalid array size (must be positive): {size}")
        self._size = size
        self._array = array.array(typecode, [0] * size)

    def __len__(self):
        return self._size

    def __getitem__(self, index: int) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError("array index out of range")
        return self._array[index]

    def __setitem__(self, index: int, val: Union[int, float]) -> None:
        if index < 0 or index >= self._size:
            raise IndexError("array assignment index out of range")
        self._array[index] = val

    def __repr__(self):
        return repr(self._array)


class DynamicArray:
    def __init__(self, initial_capacity: int = 1, typecode: str = "l") -> None:
        self._array = Array(initial_capacity, typecode)
        self._capacity = initial_capacity
        self._size = 0
        self._typecode = typecode

    def __len__(self) -> int:
        return self._size

    def __getitem__(self, index) -> Union[int, float]:
        if index >= self._size:
            raise IndexError(f"Index out of bound: {index}")
        return self._array[index]

    def __repr__(self) -> str:
        return repr(self._array._array[: self._size])

    def __iter__(self):
        for i in range(self._size):
            yield self._array[i]

    def _is_full(self):
        return self._size >= self._capacity

    def _double_size(self):
        assert (
            self._capacity == self._size
        )  # Invariant: this is called only when capacity == size
        old_array = self._array
        self._array = Array(self._capacity * 2, self._typecode)
        self._capacity *= 2
        for i in range(self._size):
            self._array[i] = old_array[i]

        assert (
            self._array._size == self._capacity
        )  # Invariant: the size of the new static array should be equal to the new capacity

    def _halve_size(self):
        assert (
            self._capacity > 1 and self._size <= self._capacity / 4
        )  # Invariant: this is called only when capacity > 1 and size <= capacity/4
        old_array = self._array
        self._array = Array(self._capacity // 2, self._typecode)
        self._capacity //= 2
        for i in range(self._size):
            self._array[i] = old_array[i]

        assert (
            self._array._size == self._capacity
        )  # Invariant: the size of the new static array should be equal to the new capacity

    def is_empty(self):
        return len(self) == 0

    def insert(self, value: Union[int, float]) -> None:
        if self._is_full():
            self._double_size()

        # By now, we are sure that self._size < len(self._array)
        self._array[self._size] = value
        self._size += 1

    def find(self, target: Union[int, float]) -> Union[int, None]:
        for i in range(self._size):
            if self._array[i] == target:
                return i
        # Element not found, reached the end of the array
        return None

    def delete(self, target: Union[int, float]) -> None:
        index = self.find(target)
        if index is None:
            raise ValueError(
                f"Unable to delete element {target}: the entry is not in the array"
            )

        # Must shift all the elements after the position of the target
        for i in range(index, self._size - 1):
            self._array[i] = self._array[i + 1]
        self._size -= 1

        # Check if we should shrink the array
        if self._capacity > 1 and self._size <= self._capacity / 4:
            self._halve_size()




class TestDynamicArray(unittest.TestCase):
    # __init__    
    def test_init(self):
        """Test initialization of DynamicArray."""
        array = DynamicArray(5)
        self.assertEqual(len(array), 0)

        array = DynamicArray(3, "f")
        self.assertEqual(len(array), 0)

    def test_init_capacity(self):
        """Test that the right capacity is set on initialization of DynamicArray."""
        array = DynamicArray()
        self.assertEqual(len(array), 0)
        self.assertEqual(array._capacity, 1)

        array = DynamicArray(3, "f")
        self.assertEqual(len(array), 0)
        self.assertEqual(array._capacity, 3)


    def test_init_invalid_size(self):
        """Test initializing Array with invalid size"""
        with self.assertRaises(ValueError):
            DynamicArray(-1)

    def test_init_invalid_typecode(self):
        """Test initializing Array with invalid typecode"""
        with self.assertRaises(ValueError):
            DynamicArray(5, "x")


    # __len__
    def test_len(self):
        """Test length property."""
        array = DynamicArray(5, "i")
        self.assertEqual(len(array), 0)
        array.insert(1)
        self.assertEqual(len(array), 1)


    # __get_item__
    def test_getitem(self):
        """Test indexing into array."""
        array = DynamicArray(5, "i")
        array.insert(1)
        array.insert(2)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 2)

    def test_index_out_of_bounds(self):
        """Test that indexing past the end of the array raises an error."""
        array = DynamicArray(5, "i")
        array.insert(1)
        with self.assertRaises(IndexError):
            array[2]

    def test_negative_index(self):
        """Test that indexing with a negative index raises an error."""
        array = DynamicArray(3, "i")
        array.insert(431)
        with self.assertRaises(IndexError):
            array[-1]                    

    # __repr__
    def test_repr(self):
        """Test string representation."""
        array = DynamicArray(5, "i")
        array.insert(1)
        array.insert(2)
        # self.assertEqual(repr(array), "array("i", [1, 2])")
        # Get the repr of the array
        repr_string = repr(array)

        # Check if 'i' is in the repr string
        self.assertIn("i", repr_string)
        # Check if '[1, 2]' is in the repr string
        self.assertIn("[1, 2]", repr_string)


    # __iter__
    def test_iter(self):
        """Test iteration over values in the array."""
        array = DynamicArray(8, "i")
        array.insert(1)
        array.insert(2)
        array.insert(3)
        iterated_values = []
        for value in array:
            iterated_values.append(value)
        expected_values = [1, 2, 3]
        self.assertEqual(iterated_values, expected_values)

    def test_iter_empty(self):
        """Test that iteration over an empty array raises StopIteration."""
        array = DynamicArray(3, "i")
        with self.assertRaises(StopIteration):
            next(iter(array))

    # insert
    def test_insert_full(self):
        """Test that insert resizes the array correctly"""
        array = DynamicArray(typecode = "i")
        array.insert(1)
        self.assertEqual(array._capacity, 1)
        array.insert(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 2)
        array.insert(3)
        self.assertEqual(3, len(array))
        self.assertEqual(array._capacity, 4)
        self.assertEqual([v for v in array], [1,2,3])

        array = DynamicArray(3, "i")
        array.insert(1)
        self.assertEqual(array._capacity, 3)
        array.insert(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 3)
        array.insert(3)
        self.assertEqual(3, len(array))
        self.assertEqual(array._capacity, 3)
        array.insert(4)
        self.assertEqual(4, len(array))
        self.assertEqual(array._capacity, 6)
        self.assertEqual([v for v in array], [1,2,3,4])

    # search
    def test_find_found(self):
        """Test searching for a value that is in the array."""
        array = DynamicArray(4, "i")
        array.insert(2)
        array.insert(1)
        array.insert(3)
        self.assertEqual(array.find(2), 0)
        array.insert(-43)
        self.assertEqual(array.find(-43), 3)
        array = DynamicArray(3, "d")
        array.insert(21.3)
        array.insert(3.1415)
        self.assertEqual(array.find(3.1415), 1)

    def test_find_not_found(self):
        """Test searching for a value that is not in the array."""
        array = DynamicArray(5, "i")
        array.insert(3)
        array.insert(1)
        array.insert(2)
        self.assertEqual(array.find(4), None)

    def test_find_empty(self):
        """Test searching an empty array."""
        array = DynamicArray(2, "i")
        self.assertEqual(array.find(1), None)

    def test_find_empty_chunk_not_included(self):
        """Test that only the filled portion of the array is searched."""
        array = DynamicArray(5, "i")
        array.insert(3)
        array.insert(1)
        array.insert(2)
        self.assertEqual(array.find(0), None)
        array.insert(0)
        self.assertEqual(array.find(0), 3)
        array = DynamicArray(5, "d")
        array.insert(-1.0)
        array.insert(-3)
        array.insert(-2)
        self.assertEqual(array.find(0), None)
        self.assertEqual(array.find(0.0), None)
        array.insert(0)
        self.assertEqual(array.find(0), 3)
        self.assertEqual(array.find(-2), 2)
        self.assertEqual(array.find(-1), 0)
        array.delete(-2)
        self.assertEqual(array.find(-2), None)
        array.delete(-1)
        self.assertEqual(array.find(-1), None)

    # is_empty
    def test_is_empty(self):
        """Test the is_empty method."""
        array = DynamicArray(2, "i")
        self.assertTrue(array.is_empty())
        array.insert(1)
        self.assertFalse(array.is_empty())
        array.insert(3)
        array.insert(2)
        self.assertFalse(array.is_empty())

    # delete
    def test_delete_found(self):
        """Test deleting a value that is in the array."""
        array = DynamicArray(5, "i")
        array.insert(1)
        array.insert(2)
        array.insert(3)
        self.assertEqual(len(array), 3)

        array.delete(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 3)

        array = DynamicArray(7, "i")
        array.insert(3)
        array.insert(1)
        array.insert(3)
        array.insert(2)
        array.insert(2)
        self.assertEqual(len(array), 5)

        array.delete(2)
        self.assertEqual(len(array), 4)
        self.assertEqual(array[0], 3)
        self.assertEqual(array[1], 1)
        self.assertEqual(array[2], 3)
        self.assertEqual(array[3], 2)

        array.delete(3)
        self.assertEqual(len(array), 3)
        array.delete(1)
        self.assertEqual(len(array), 2)
        self.assertEqual(array[0], 3)
        self.assertEqual(array[1], 2)

        array.insert(0)
        array.insert(-3)
        array.insert(2)
        self.assertEqual(len(array), 5)

        array.delete(-3)
        self.assertEqual(len(array), 4)
        self.assertEqual(array[0], 3)
        self.assertEqual(array[1], 2)
        self.assertEqual(array[2], 0)
        self.assertEqual(array[3], 2)

        array.delete(2)
        self.assertEqual(len(array), 3)

        array.delete(2)
        array.delete(0)
        self.assertEqual(len(array), 1)
        self.assertEqual(array[0], 3)

        array.delete(3)
        self.assertEqual(len(array), 0)

    def test_delete_not_found(self):
        """Test deleting a value that is not in the array."""
        array = DynamicArray(15, "i")
        array.insert(1)
        array.insert(3)
        array.insert(2)
        with self.assertRaises(ValueError):
            array.delete(4)

    def test_delete_empty(self):
        """Test deleting from an empty array."""
        array = DynamicArray(5, "i")
        with self.assertRaises(ValueError):
            array.delete(1)

    # resize (internal)
    def test_resizing(self):
        array = DynamicArray()
        self.assertEqual(len(array), 0)
        self.assertEqual(array._capacity, 1)
        array.insert(1)
        self.assertEqual(len(array), 1)
        self.assertEqual(array._capacity, 1)
        array.insert(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 2)
        array.insert(3)
        self.assertEqual(len(array), 3)
        self.assertEqual(array._capacity, 4)

        array.delete(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 4)
        array.delete(1)
        self.assertEqual(len(array), 1)
        self.assertEqual(array._capacity, 2)

        # Initial capacity > 1
        array = DynamicArray(3, "i")
        self.assertEqual(len(array), 0)
        self.assertEqual(array._capacity, 3)
        array.insert(3)
        self.assertEqual(len(array), 1)
        self.assertEqual(array._capacity, 3)
        array.insert(1)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 3)
        array.insert(3)
        self.assertEqual(len(array), 3)
        self.assertEqual(array._capacity, 3)
        array.insert(2)
        self.assertEqual(len(array), 4)
        self.assertEqual(array._capacity, 6)
        array.insert(2)
        self.assertEqual(len(array), 5)
        self.assertEqual(array._capacity, 6)
        array.insert(21)
        self.assertEqual(len(array), 6)
        self.assertEqual(array._capacity, 6)
        array.insert(-31)
        self.assertEqual(len(array), 7)
        self.assertEqual(array._capacity, 12)

        array.delete(2)
        self.assertEqual(len(array), 6)
        self.assertEqual(array._capacity, 12)
        array.delete(21)
        self.assertEqual(len(array), 5)
        self.assertEqual(array._capacity, 12)
        array.delete(2)
        self.assertEqual(len(array), 4)
        self.assertEqual(array._capacity, 12)
        array.delete(3)
        self.assertEqual(len(array), 3)
        self.assertEqual(array._capacity, 6)
        array.delete(1)
        self.assertEqual(len(array), 2)
        self.assertEqual(array._capacity, 6)
        array.delete(-31)
        self.assertEqual(len(array), 1)
        self.assertEqual(array._capacity, 3)
        array.delete(3)
        self.assertEqual(len(array), 0)
        self.assertEqual(array._capacity, 1)

if __name__ == "__main__":
    unittest.main(exit=False)

# Create a dynamic array
dynamic_arr = DynamicArray()

# Insert elements
dynamic_arr.insert(1)
dynamic_arr.insert(2)
dynamic_arr.insert(3)

# Print the array
print(dynamic_arr)  # Output: DynamicArray([1, 2, 3])

# Insert more elements to trigger resizing
dynamic_arr.insert(4)
dynamic_arr.insert(5)

# Print the array after resizing
print(dynamic_arr)  # Output: DynamicArray([1, 2, 3, 4, 5])

# Create a dynamic array and insert some elements
dynamic_arr = DynamicArray()
dynamic_arr.insert(1)
dynamic_arr.insert(2)
dynamic_arr.insert(3)
dynamic_arr.insert(4)
dynamic_arr.insert(5)

# Delete an element
dynamic_arr.delete(3)

# Print the array after deletion
print(dynamic_arr)  # Output: DynamicArray([1, 2, 4, 5])

# Try deleting an element that is not in the array
try:
    dynamic_arr.delete(10)  # This will raise an exception
except ValueError as e:
    print(e)  # Output: Unable to delete element 10: the entry is not in the array

# Create a dynamic array and insert some elements
dynamic_arr = DynamicArray()
dynamic_arr.insert(10)
dynamic_arr.insert(20)
dynamic_arr.insert(30)

# Find an element
index = dynamic_arr.find(20)
print(index)  # Output: 1 (because 20 is at index 1)

# Try finding an element that doesnt exist
index = dynamic_arr.find(40)
print(index)  # Output: None (because 40 is not in the array)

# Create an empty dynamic array
empty_arr = DynamicArray()

# Check if the array is empty
print(empty_arr.is_empty())  # Output: True

# Insert an element
empty_arr.insert(100)

# Check again if the array is empty
print(empty_arr.is_empty())  # Output: False

# Create a dynamic array with small initial capacity
dynamic_arr = DynamicArray(initial_capacity=2)

# Insert elements to trigger resizing
dynamic_arr.insert(1)
dynamic_arr.insert(2)
dynamic_arr.insert(3)  # This will trigger a resize

# Print the array after resizing
print(dynamic_arr)  # Output: DynamicArray([1, 2, 3])

# Delete elements and potentially trigger halving of capacity
dynamic_arr.delete(2)
dynamic_arr.delete(3)  # This should reduce the array size

# Print the array after deletion
print(dynamic_arr)  # Output: DynamicArray([1])

# Create a dynamic array and insert some elements
dynamic_arr = DynamicArray()
dynamic_arr.insert(10)
dynamic_arr.insert(20)
dynamic_arr.insert(30)

# Iterate over the array
for value in dynamic_arr:
    print(value)  # Output: 10, 20, 30



'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ArraySorted3
    set output_file "main.py"

    set template_content '
import array
from typing import Union
import unittest

class Array:
    def __init__(self, size: int, typecode: str = "l"):
        if size <= 0:
            raise ValueError(f"Invalid array size (must be positive): {size}")
        self._size = size
        self._array = array.array(typecode, [0] * size)
    def __len__(self):
        return self._size
    def __getitem__(self, index: int) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError("array index out of range")
        return self._array[index]
    def __setitem__(self, index: int, val: Union[int, float]) -> None:
        if index < 0 or index >= self._size:
            raise IndexError("array assignment index out of range")
        self._array[index] = val
    def __repr__(self):
        return repr(self._array)


class SortedArray:
    def __init__(self, max_size: int, typecode: str = "l"):
        self._array = Array(max_size, typecode)
        self._max_size = max_size
        # The actual number of elements stored in the array
        self._size = 0

    def __len__(self) -> int:
        return self._size

    def __getitem__(self, index) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError(f"Index out of bound: {index}")
        return self._array[index]

    def __repr__(self) -> str:
        return f"SortedArray({repr(self._array._array[:self._size])})"

    def __iter__(self):
        for i in range(self._size):
            yield self._array[i]

    def max_size(self) -> int:
        return self._max_size

    def insert(self, value: Union[int, float]) -> None:
        if self._size >= self._max_size:
            raise ValueError(
                f"The array is already full, maximum size: {self._max_size}"
            )
        for i in range(self._size, 0, -1):
            if self._array[i - 1] <= value:
                # Found the right place for the element
                self._array[i] = value
                self._size += 1
                return
            else:
                self._array[i] = self._array[i - 1]
        # If it gets here, it means we need to add the new value as the first entry
        self._array[0] = value
        self._size += 1

    def linear_search(self, target: Union[int, float]) -> Union[int, None]:
        for i in range(self._size):
            if self._array[i] == target:
                return i
            elif self._array[i] > target:
                # The array is sorted, we cant find the target in the rest of the array
                return None
        # Element not found, reached the end of the array
        return None

    def binary_search(self, target: Union[int, float]) -> Union[int, None]:
        left = 0
        right = self._size - 1
        while left <= right:
            mid_index = (left + right) // 2
            mid_val = self._array[mid_index]
            if mid_val == target:
                return mid_index
            elif mid_val > target:
                right = mid_index - 1
            else:
                left = mid_index + 1
        return None

    def delete(self, target: Union[int, float]) -> None:
        index = self.binary_search(target)
        if index is None:
            raise ValueError(
                f"Unable to delete element {target}: the entry is not in the array"
            )

        # Must shift all the elements after the position of the target
        for i in range(index, self._size - 1):
            self._array[i] = self._array[i + 1]
        self._size -= 1



class TestSortedArray(unittest.TestCase):
    # __init__

    def test_init(self):
        """Test initialization of SortedArray."""
        array = SortedArray(5)
        self.assertEqual(len(array), 0)

        array = SortedArray(3, "f")
        self.assertEqual(len(array), 0)

    def test_init_invalid_size(self):
        """Test initializing Array with invalid size"""
        with self.assertRaises(ValueError):
            SortedArray(-1)

    def test_init_invalid_typecode(self):
        """Test initializing Array with invalid typecode"""
        with self.assertRaises(ValueError):
            SortedArray(5, "x")


    # __len__

    def test_len(self):
        """Test length property."""
        array = SortedArray(5, "i")
        self.assertEqual(len(array), 0)
        array.insert(1)
        self.assertEqual(len(array), 1)


    # __get_item__

    def test_getitem(self):
        """Test indexing into array."""
        array = SortedArray(5, "i")
        array.insert(1)
        array.insert(2)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 2)

    def test_index_out_of_bounds(self):
        """Test that indexing past the end of the array raises an error."""
        array = SortedArray(5, "i")
        array.insert(1)
        with self.assertRaises(IndexError):
            array[2]

    def test_negative_index(self):
        """Test that indexing with a negative index raises an error."""
        array = SortedArray(3, "i")
        array.insert(431)
        with self.assertRaises(IndexError):
            array[-1]                    

    # __repr__
    def test_repr(self):
        """Test string representation."""
        array = SortedArray(5, "i")  
        array.insert(1)
        array.insert(2)
        #self.assertEqual(repr(array), "SortedArray(array("i", [1, 2]))")
        # Get the repr of the SortedArray
        repr_string = repr(array)
        # Check if 'i' (signed integer typecode) is in the repr string
        self.assertIn("i", repr_string)
        # Check if '[1, 2]' is in the repr string (the inserted values)
        self.assertIn("[1, 2]", repr_string)



    # __iter__

    def test_iter(self):
        """Test iteration over values in the array."""
        array = SortedArray(8, "i")
        array.insert(1)
        array.insert(2)
        array.insert(3)
        iterated_values = []
        for value in array:
            iterated_values.append(value)
        expected_values = [1, 2, 3]
        self.assertEqual(iterated_values, expected_values)

    def test_iter_empty(self):
        """Test that iteration over an empty array raises StopIteration."""
        array = SortedArray(3, "i")
        with self.assertRaises(StopIteration):
            next(iter(array))


    # max_size

    def test_max_size(self):
        """Test the max_size method."""
        array = SortedArray(7, "i")
        self.assertEqual(array.max_size(), 7)
        array.insert(1)
        self.assertEqual(array.max_size(), 7)
        array.insert(-2)
        self.assertEqual(array.max_size(), 7)       


    # insert

    def test_insert_full(self):
        """Test that insert raises an error if the array is full."""
        array = SortedArray(2, "i")
        array.insert(1)
        array.insert(2)
        with self.assertRaises(ValueError):
            array.insert(3)

    def test_insert_sorted(self):
        """Test that insert places values in the correct sorted position."""
        array = SortedArray(6, "i")
        array.insert(3)
        self.assertEqual(len(array), 1)        
        self.assertEqual(array[0], 3)
        array.insert(1)
        self.assertEqual(len(array), 2)        
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 3)
        array.insert(2)
        self.assertEqual(len(array), 3)        
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 2)
        self.assertEqual(array[2], 3)

    def test_insert_first(self):
        """Test that insert places the first value at index 0."""
        array = SortedArray(5, "i")
        array.insert(1)
        self.assertEqual(array[0], 1)
        array.insert(-1)
        self.assertEqual(array[0], -1)
        self.assertEqual(len(array), 2)


    # search (linear)

    def test_linear_search_found(self):
        """Test searching for a value that is in the array."""
        array = SortedArray(4, "i")
        array.insert(2)
        array.insert(1)
        array.insert(3)
        self.assertEqual(array.linear_search(2), 1)
        array.insert(-43)
        self.assertEqual(array.linear_search(-43), 0)
        array = SortedArray(3, "d")
        array.insert(21.3)
        array.insert(3.1415)
        self.assertEqual(array.linear_search(3.1415), 0)

    def test_linear_search_not_found(self):
        """Test searching for a value that is not in the array."""
        array = SortedArray(5, "i")
        array.insert(3)
        array.insert(1)
        array.insert(2)
        self.assertEqual(array.linear_search(4), None)

    def test_linear_search_empty(self):
        """Test searching an empty array."""
        array = SortedArray(2, "i")
        self.assertEqual(array.linear_search(1), None)

    def test_linear_search_empty_chunk_not_included(self):
        """Test that only the filled portion of the array is searched."""
        array = SortedArray(5, "i")
        array.insert(3)
        array.insert(1)
        array.insert(2)
        self.assertEqual(array.linear_search(0), None)
        array.insert(0)
        self.assertEqual(array.linear_search(0), 0)
        array = SortedArray(5, "d")
        array.insert(-1.0)
        array.insert(-3)
        array.insert(-2)
        self.assertEqual(array.linear_search(0), None)
        self.assertEqual(array.linear_search(0.0), None)
        array.insert(0)
        self.assertEqual(array.linear_search(0), 3)


    # search (binary search)

    def test_find_found(self):
        """Test finding a value that is in the array."""
        array = SortedArray(7, "i")
        array.insert(1)
        array.insert(3)
        array.insert(2)
        self.assertEqual(array.binary_search(2), 1)
        array.insert(-1)
        array.insert(23)
        array.insert(-2)
        self.assertEqual(array.binary_search(2), 3)
        self.assertEqual(array.binary_search(-1), 1)
        self.assertEqual(array.binary_search(-2), 0)
        self.assertEqual(array.binary_search(23), 5)

    def test_find_not_found(self):
        """Test finding a value that is not in the array."""
        array = SortedArray(5, "i")
        array.insert(1)
        array.insert(2)
        array.insert(3)
        self.assertEqual(array.binary_search(4), None)
        self.assertEqual(array.binary_search(-10), None)

    def test_find_empty_chunk_not_included(self):
        """Test that only the filled portion of the array is searched."""
        array = SortedArray(5, "i")
        array.insert(3)
        array.insert(1)
        array.insert(2)
        self.assertEqual(array.binary_search(0), None)
        array.insert(0)
        self.assertEqual(array.binary_search(0), 0)
        array = SortedArray(5, "d")
        array.insert(-1.0)
        array.insert(-3)
        array.insert(-2)
        self.assertEqual(array.binary_search(0), None)
        self.assertEqual(array.binary_search(0.0), None)
        array.insert(0)
        self.assertEqual(array.binary_search(0), 3)        

    def test_find_empty(self):
        """Test finding a value in an empty array."""
        array = SortedArray(5, "i")
        self.assertEqual(array.binary_search(1), None)
        self.assertEqual(array.binary_search(0), None)


    # delete

    def test_delete_found(self):
        """Test deleting a value that is in the array."""
        array = SortedArray(5, "i")
        array.insert(1)
        array.insert(2)
        array.insert(3)
        self.assertEqual(len(array), 3)

        array.delete(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 3)

        array = SortedArray(7, "i")
        array.insert(3)
        array.insert(1)
        array.insert(3)
        array.insert(2)
        array.insert(2)
        self.assertEqual(len(array), 5)

        array.delete(2)
        self.assertEqual(len(array), 4)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 2)
        self.assertEqual(array[2], 3)
        self.assertEqual(array[3], 3)

        array.delete(3)
        self.assertEqual(len(array), 3)
        array.delete(1)
        self.assertEqual(len(array), 2)
        self.assertEqual(array[0], 2)
        self.assertEqual(array[1], 3)

        array.insert(0)
        array.insert(-3)
        array.insert(2)
        self.assertEqual(len(array), 5)

        array.delete(-3)
        self.assertEqual(len(array), 4)
        self.assertEqual(array[0], 0)
        self.assertEqual(array[1], 2)
        self.assertEqual(array[2], 2)
        self.assertEqual(array[3], 3)

        array.delete(2)
        self.assertEqual(len(array), 3)

        array.delete(2)
        array.delete(0)
        self.assertEqual(len(array), 1)
        self.assertEqual(array[0], 3)

        array.delete(3)
        self.assertEqual(len(array), 0)

    def test_delete_not_found(self):
        """Test deleting a value that is not in the array."""
        array = SortedArray(15, "i")
        array.insert(1)
        array.insert(3)
        array.insert(2)
        with self.assertRaises(ValueError):
            array.delete(4)

    def test_delete_empty(self):
        """Test deleting from an empty array."""
        array = SortedArray(5, "i")
        with self.assertRaises(ValueError):
            array.delete(1)

if __name__ == "__main__":
     unittest.main(exit=False)

# Create a sorted array with max size 5
sorted_arr = SortedArray(5)

# Insert elements
sorted_arr.insert(3)
sorted_arr.insert(1)
sorted_arr.insert(5)
sorted_arr.insert(2)
sorted_arr.insert(4)

# Print the sorted array
print(sorted_arr)  # Output: SortedArray([1, 2, 3, 4, 5])

# # Try inserting another element into a full array
# try:
#     sorted_arr.insert(6)
# except ValueError as e:
#     print(e)  # Output: The array is already full, maximum size: 5

# Create a sorted array and insert elements
sorted_arr = SortedArray(5)
sorted_arr.insert(3)
sorted_arr.insert(1)
sorted_arr.insert(5)
sorted_arr.insert(2)
sorted_arr.insert(4)

# Linear search
index = sorted_arr.linear_search(3)
print(f"Linear search index of 3: {index}")  # Output: 2

# Linear search for an element that doesnt exist
index = sorted_arr.linear_search(6)
print(f"Linear search index of 6: {index}")  # Output: None

# Binary search
index = sorted_arr.binary_search(4)
print(f"Binary search index of 4: {index}")  # Output: 3

# Binary search for an element that doesnt exist
index = sorted_arr.binary_search(6)
print(f"Binary search index of 6: {index}")  # Output: None

# Create a sorted array and insert elements
sorted_arr = SortedArray(5)
sorted_arr.insert(3)
sorted_arr.insert(1)
sorted_arr.insert(5)
sorted_arr.insert(2)
sorted_arr.insert(4)

# Delete an element
sorted_arr.delete(3)
print(sorted_arr)  # Output: SortedArray([1, 2, 4, 5])

# Try deleting an element that doesnt exist
try:
    sorted_arr.delete(6)
except ValueError as e:
    print(e)  # Output: Unable to delete element 6: the entry is not in the array

# Create a sorted array with max size 3
sorted_arr = SortedArray(3)

# Insert elements
sorted_arr.insert(1)
sorted_arr.insert(2)
sorted_arr.insert(3)

# Print the array
print(sorted_arr)  # Output: SortedArray([1, 2, 3])

# Try inserting an element into a full array
try:
    sorted_arr.insert(4)
except ValueError as e:
    print(e)  # Output: The array is already full, maximum size: 3


# Create a sorted array and insert elements
sorted_arr = SortedArray(5)
sorted_arr.insert(3)
sorted_arr.insert(1)
sorted_arr.insert(5)
sorted_arr.insert(2)
sorted_arr.insert(4)

# Iterate over the array using a for loop
for value in sorted_arr:
    print(value)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ArrayUnsorted4
    set output_file "main.py"

    set template_content '
import array
from typing import Union
import unittest

class Array:

    def __init__(self, size: int, typecode: str = "l"):
        if size <= 0:
            raise ValueError(f"Invalid array size (must be positive): {size}")
        self._size = size
        self._array = array.array(typecode, [0] * size)

    def __len__(self):
        return self._size

    def __getitem__(self, index: int) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError("array index out of range")
        return self._array[index]

    def __setitem__(self, index: int, val: Union[int, float]) -> None:
        if index < 0 or index >= self._size:
            raise IndexError("array assignment index out of range")
        self._array[index] = val

    def __repr__(self):
        return repr(self._array)


class UnsortedArray:
    def __init__(self, max_size: int, typecode: str = "l"):
        self._array = Array(max_size, typecode)
        self._max_size = max_size
        # The actual number of elements stored in the array
        self._size = 0

    def __len__(self) -> int:
        return self._size

    def __getitem__(self, index) -> Union[int, float]:
        if index < 0 or index >= self._size:
            raise IndexError(f"Index out of bound: {index}")
        return self._array[index]

    def __repr__(self) -> str:
        return f"UnsortedArray({repr(self._array._array[:self._size])})"

    def max_size(self) -> int:
        return self._max_size

    def insert(self, new_entry) -> None:
        if self._size >= len(self._array):
            raise ValueError("The array is already full")
        else:
            self._array[self._size] = new_entry
            self._size += 1

    def delete(self, index) -> None:
        if self._size == 0:
            raise ValueError("Delete from an empty array")
        elif index < 0 or index >= self._size:
            raise ValueError(f"Index {index} out of range.")
        else:
            self._array[index] = self._array[self._size - 1]
            self._size -= 1

    def find(self, target) -> int:
        for index in range(0, self._size):
            if self._array[index] == target:
                return index
        # Couldnt find the target
        return None

    def traverse(self, callback):
        for index in range(self._size):
            callback(self._array[index])



class TestArray(unittest.TestCase):
    """Tests for class UnsortedArray
        This test class contains unit tests for the UnsortedArray class.
    """

    # __repr__
    def test_repr(self):
        """Test string representation."""
        array = UnsortedArray(5, "i")
        array.insert(1)
        array.insert(2)
        #self.assertEqual(repr(array), "UnsortedArray(array('i', [1, 2]))")
        repr_string = repr(array)
        self.assertIn("i", repr_string)
        # Check if '[1, 2]' is in the repr string (the inserted values)
        self.assertIn("[1, 2]", repr_string)

    # __get_item__
    def test_getitem_valid_index(self):
        array = UnsortedArray(5, "f")
        array.insert(1)
        array.insert(2)  
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 2)

    def test_getitem_invalid_index(self):
        array = UnsortedArray(3, "i")
        with self.assertRaises(IndexError):
            array[3]
        with self.assertRaises(IndexError):
            array[-1]

    # max_size    
    def test_max_size(self):
        array = UnsortedArray(3, "i")
        self.assertEqual(array.max_size(), 3)
        array.insert(2)
        self.assertEqual(array.max_size(), 3)
        array = UnsortedArray(6, "f")
        self.assertEqual(array.max_size(), 6)

    # __insert__
    def test_insert_valid(self):
        """Test inserting into an array with space"""
        array = UnsortedArray(5)
        array.insert(1)
        self.assertEqual(len(array), 1)
        self.assertEqual(array[0], 1)

    def test_insert_in_full_array(self):
        """Test inserting into a full array"""
        array = UnsortedArray(1)
        array.insert(1)
        with self.assertRaises(ValueError):
            array.insert(2)

    # delete
    def test_delete_valid(self):
        """Test deleting from an array with elements"""
        array = UnsortedArray(5)
        array.insert(1)
        array.insert(2)
        array.insert(3)
        array.insert(4)
        array.delete(1)
        self.assertEqual(len(array), 3)
        self.assertEqual(array[1], 4)
        array.delete(2)
        self.assertEqual(len(array), 2)
        self.assertEqual(array[0], 1)
        self.assertEqual(array[1], 4)
        array.delete(0)
        self.assertEqual(len(array), 1)
        self.assertEqual(array[0], 4)
        array.delete(0)
        self.assertEqual(len(array), 0)

    def test_delete_invalid_empty(self):
        """Test deleting from an empty array"""
        array = UnsortedArray(3)
        with self.assertRaises(ValueError):
            array.delete(0)

    def test_delete_invalid_index(self):
        """Test deleting with an invalid index"""
        array = UnsortedArray(5)
        array.insert(1)
        with self.assertRaises(ValueError):
            array.delete(1)
        with self.assertRaises(ValueError):
            array.delete(-1)

    # find
    def test_find_present(self):
        """Test finding an entry that is present in the array"""
        array = UnsortedArray(7)
        array.insert(4)
        array.insert(-2)
        array.insert(55)
        self.assertEqual(array.find(-2), 1)
        self.assertEqual(array.find(55), 2)
        self.assertEqual(array.find(4), 0)

    def test_find_absent(self):
        """Test finding an entry that is absent from the array"""
        array = UnsortedArray(5)
        array.insert(1)
        array.insert(2)
        array.insert(3)
        index = array.find(4)
        self.assertEqual(index, None)

    # traverse
    def test_traverses_entire_array(self):
        result = []
        def test_callback(i: int):
            result.append(i + 1 )
        array = UnsortedArray(5)
        array.insert(1)
        array.insert(2)
        array.insert(3)
        array.insert(4)
        array.insert(5)
        array.traverse(test_callback)
        self.assertEqual(result, [2, 3, 4, 5, 6])


if __name__ == "__main__":
     unittest.main(exit=False)

# Create an unsorted array with max size 5
unsorted_arr = UnsortedArray(5)

# Insert elements into the unsorted array
unsorted_arr.insert(10)
unsorted_arr.insert(20)
unsorted_arr.insert(30)
unsorted_arr.insert(40)

# Print the array after insertion
print(unsorted_arr)  # Output: UnsortedArray([10, 20, 30, 40])

# Delete an element at index 2 (the value 30)
unsorted_arr.delete(2)

# Print the array after deletion
print(unsorted_arr)  # Output: UnsortedArray([10, 20, 40])

# Try deleting from an empty array
try:
    unsorted_arr.delete(5)  # Invalid index
except ValueError as e:
    print(e)  # Output: Index 5 out of range.


# Create an unsorted array and insert elements
unsorted_arr = UnsortedArray(5)
unsorted_arr.insert(5)
unsorted_arr.insert(10)
unsorted_arr.insert(15)

# Find an element in the array
index = unsorted_arr.find(10)
print(f"Element 10 found at index: {index}")  # Output: Element 10 found at index: 1

# Try finding an element that doesnt exist
index = unsorted_arr.find(20)
print(f"Element 20 found at index: {index}")  # Output: Element 20 found at index: None

# Create an unsorted array and insert elements
unsorted_arr = UnsortedArray(5)
unsorted_arr.insert(100)
unsorted_arr.insert(200)
unsorted_arr.insert(300)

# Define a callback function that prints each element
def print_element(element):
    print(f"Element: {element}")

# Traverse the array and apply the callback
unsorted_arr.traverse(print_element)

# Create an unsorted array with max size 3
unsorted_arr = UnsortedArray(3)

# Insert elements
unsorted_arr.insert(1)
unsorted_arr.insert(2)
unsorted_arr.insert(3)

# # Print the array after insertion
# print(unsorted_arr)  # Output: UnsortedArray([1, 2, 3])

# # Try inserting an element when the array is full
# try:
#     unsorted_arr.insert(4)  # This will raise an error
# except ValueError as e:
#     print(e)  # Output: The array is already full


# Create an unsorted array and insert elements
unsorted_arr = UnsortedArray(5)
unsorted_arr.insert(10)
unsorted_arr.insert(20)
unsorted_arr.insert(30)
unsorted_arr.insert(40)

# Print the array before deletion
print(unsorted_arr)  # Output: UnsortedArray([10, 20, 30, 40])

# Delete the last element (index 3)
unsorted_arr.delete(3)

# Print the array after deleting the last element
print(unsorted_arr)  # Output: UnsortedArray([10, 20, 30])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HashTableCore5
    set output_file "main.py"

    set template_content '
from math import floor, sqrt
from decimal import Decimal
import copy
from typing import Any, Callable, List, Optional
import unittest


class HashTable:

    __A__ = Decimal((sqrt(5) - 1) / 2)
    def __init__(self, buckets: int, extract_key: Callable[..., Any] = hash) -> None:
        if buckets <= 0:
            raise ValueError(
                f"Invalid size for the hash table (must be positive): {buckets}"
            )
        self._m = buckets
        self._data = [SinglyLinkedList() for _ in range(buckets)]
        self._extract_key = extract_key

    def __len__(self):
        return sum((len(bucket) for bucket in self._data))

    def _hash(self, key: int):
        return floor(abs(self._m * ((Decimal(key) * HashTable.__A__) % 1)))

    def is_empty(self) -> int:
        return len(self) == 0

    def search(self, key: int) -> Any:
        index = self._hash(key)
        value_matches_key = lambda v: self._extract_key(v) == key
        return self._data[index].search(value_matches_key)

    def insert(self, value: Any) -> None:
        index = self._hash(self._extract_key(value))
        self._data[index].insert_in_front(value)

    def contains(self, value: Any) -> bool:
        return self.search(self._extract_key(value)) is not None

    def delete(self, value: Any) -> None:
        index = self._hash(self._extract_key(value))
        try:
            self._data[index].delete(value)
        except ValueError as exc:
            raise ValueError(
                f"No element with value {value} was found in the hash table."
            ) from exc

class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data



class TestHashTable(unittest.TestCase):

    def test_init_invalid_size(self):
        """Test initializing a HashTable with an invalid size"""
        with self.assertRaises(ValueError):
            HashTable(-1)

    def test_len(self):
        hash_table = HashTable(2)
        self.assertEqual(len(hash_table), 0)

        hash_table.insert("a")
        self.assertEqual(len(hash_table), 1)

        hash_table.insert("beta")
        hash_table.insert("delta")
        self.assertEqual(len(hash_table), 3)
        hash_table.insert("c")
        self.assertEqual(len(hash_table), 4)
        hash_table.insert("Jsut some random string")
        self.assertEqual(len(hash_table), 5)

    def test_is_empty(self):
        hash_table = HashTable(22)
        self.assertTrue(hash_table.is_empty())

        hash_table.insert("a")
        self.assertFalse(hash_table.is_empty())

        hash_table.insert("bba")
        self.assertFalse(hash_table.is_empty())

    def test_contains(self):
        hash_table = HashTable(3)
        self.assertFalse(hash_table.contains("a"))
        self.assertFalse(hash_table.contains("b"))
        self.assertFalse(hash_table.contains("c"))
        self.assertFalse(hash_table.contains("d"))
        self.assertFalse(hash_table.contains("Z"))

        hash_table.insert("a")
        self.assertTrue(hash_table.contains("a"))
        self.assertFalse(hash_table.contains("b"))
        self.assertFalse(hash_table.contains("c"))
        self.assertFalse(hash_table.contains("d"))
        self.assertFalse(hash_table.contains("Z"))

        hash_table.insert("b")
        hash_table.insert("d")
        self.assertTrue(hash_table.contains("a"))
        self.assertTrue(hash_table.contains("b"))
        self.assertFalse(hash_table.contains("c"))
        self.assertTrue(hash_table.contains("d"))        
        self.assertFalse(hash_table.contains("Z"))

        hash_table.insert("c")
        self.assertTrue(hash_table.contains("c"))
        hash_table.insert("Z")
        self.assertTrue(hash_table.contains("Z"))
        hash_table.insert("A")
        self.assertTrue(hash_table.contains("A"))

    def test_search(self):
        hash_table = HashTable(3)
        self.assertIsNone(hash_table.search(hash("a")))
        self.assertIsNone(hash_table.search(hash("b")))
        self.assertIsNone(hash_table.search(hash("c")))
        self.assertIsNone(hash_table.search(hash("d")))
        self.assertIsNone(hash_table.search(hash("Z")))

        hash_table.insert("a")
        self.assertEqual(hash_table.search(hash("a")), "a")
        self.assertIsNone(hash_table.search(hash("b")))
        self.assertIsNone(hash_table.search(hash("c")))
        self.assertIsNone(hash_table.search(hash("d")))
        self.assertIsNone(hash_table.search(hash("Z")))

        hash_table.insert("b")
        hash_table.insert("d")
        self.assertEqual(hash_table.search(hash("a")), "a")
        self.assertEqual(hash_table.search(hash("b")), "b")
        self.assertIsNone(hash_table.search(hash("c")))
        self.assertEqual(hash_table.search(hash("d")), "d")
        self.assertIsNone(hash_table.search(hash("Z")))

        hash_table.insert("c")
        self.assertEqual(hash_table.search(hash("c")), "c")
        hash_table.insert("XYZ")
        self.assertEqual(hash_table.search(hash("XYZ")), "XYZ")
        hash_table.insert(1)
        self.assertEqual(hash_table.search(hash(1)), 1)

        # Custom hash function
        key = lambda x: x * x * x
        hash_table = HashTable(5, extract_key=key)

        hash_table.insert(-1)
        hash_table.insert(0)
        hash_table.insert(1)
        hash_table.insert(2)
        self.assertEqual(hash_table.search(key(-1)), -1)
        self.assertEqual(hash_table.search(key(1)), 1)
        self.assertEqual(hash_table.search(key(0)), 0)
        self.assertEqual(hash_table.search(key(2)), 2)
        self.assertIsNone(hash_table.search(key(-2)))
        self.assertIsNone(hash_table.search(key(-3)))
        self.assertIsNone(hash_table.search(key(3)))
        self.assertIsNone(hash_table.search(key(0.4)))


    def test_insert_delete(self):
        hash_table = HashTable(5)

        # Delete from an empty hash_table
        with self.assertRaises(ValueError):
            hash_table.delete(6)

        hash_table.insert(6)
        hash_table.insert(4)
        hash_table.insert(7)
        hash_table.insert(5)
        hash_table.insert(2)
        hash_table.insert(3)
        hash_table.insert(9)
        hash_table.insert(1)
        hash_table.insert(6)
        hash_table.insert(8)
        hash_table.insert(11)

        self.assertEqual(len(hash_table), 11)

        # Value to be deleted not found
        with self.assertRaises(ValueError):
            hash_table.delete(0)

        self.assertTrue(hash_table.contains(1))
        self.assertTrue(hash_table.contains(8))
        hash_table.delete(1)
        hash_table.delete(8)
        self.assertEqual(len(hash_table), 9)
        self.assertFalse(hash_table.contains(1))
        self.assertTrue(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertTrue(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertTrue(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.delete(9)
        self.assertEqual(len(hash_table), 8)
        self.assertFalse(hash_table.contains(1))
        self.assertTrue(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertTrue(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.delete(2)
        self.assertEqual(len(hash_table), 7)
        self.assertFalse(hash_table.contains(1))
        self.assertFalse(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertTrue(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.delete(4)
        self.assertEqual(len(hash_table), 6)
        self.assertFalse(hash_table.contains(1))
        self.assertFalse(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertFalse(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.delete(6)
        self.assertEqual(len(hash_table), 5)
        self.assertFalse(hash_table.contains(1))
        self.assertFalse(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertFalse(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))

        # There are two occurrences of the value 6!
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.delete(6)
        self.assertEqual(len(hash_table), 4)
        self.assertFalse(hash_table.contains(1))
        self.assertFalse(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertFalse(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertFalse(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))

        hash_table.insert(1)
        hash_table.insert(2)
        hash_table.insert(6)
        self.assertEqual(len(hash_table), 7)
        self.assertTrue(hash_table.contains(1))
        self.assertTrue(hash_table.contains(2))
        self.assertTrue(hash_table.contains(3))
        self.assertFalse(hash_table.contains(4))
        self.assertTrue(hash_table.contains(5))
        self.assertTrue(hash_table.contains(6))
        self.assertTrue(hash_table.contains(7))
        self.assertFalse(hash_table.contains(8))
        self.assertFalse(hash_table.contains(9))
        self.assertFalse(hash_table.contains(10))
        self.assertTrue(hash_table.contains(11))


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a HashTable with 10 buckets
hash_table = HashTable(10)
print("Initial size:", len(hash_table))  # Expected Output: 0 (empty hash table)

# Step 1: Insert elements into the hash table
hash_table.insert(10)
print("After inserting 10:", len(hash_table))  # Expected Output: 1 (one element in the table)

hash_table.insert(20)
print("After inserting 20:", len(hash_table))  # Expected Output: 2 (two elements in the table)

hash_table.insert(30)
print("After inserting 30:", len(hash_table))  # Expected Output: 3 (three elements in the table)

# Step 2: Check if a value exists in the hash table
print("Does the hash table contain 20?", hash_table.contains(20))  # Expected Output: True
print("Does the hash table contain 50?", hash_table.contains(50))  # Expected Output: False

# Step 3: Search for a value
search_result = hash_table.search(20)  # Expected Output: 20 (since we inserted it earlier)
print("Search result for key 20:", search_result)

# Step 4: Delete a value
hash_table.delete(20)
print("After deleting 20:", len(hash_table))  # Expected Output: 2 (since we deleted one element)

# Step 5: Try to search for the deleted element
search_result_after_delete = hash_table.search(20)
print("Search result for key 20 after deletion:", search_result_after_delete)  # Expected Output: None

# Step 6: Insert more values and check table size
hash_table.insert(40)
hash_table.insert(50)
print("After inserting 40 and 50:", len(hash_table))  # Expected Output: 4 (total elements)

# Step 7: Check if table is empty
print("Is the hash table empty?", hash_table.is_empty())  # Expected Output: False (its not empty)

# Step 8: Delete another element
hash_table.delete(10)
print("After deleting 10:", len(hash_table))  # Expected Output: 3 (deleted one element)

# Final check for all elements
print("Final size of the hash table:", len(hash_table))  # Expected Output: 3

'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BagCore6
    set output_file "main.py"
    
    set template_content '
from typing import Any, Callable, List, Optional
from math import floor, sqrt
from decimal import Decimal
import copy
import unittest

class Bag:
    def __init__(self) -> None:
        self._data = SinglyLinkedList()

    def __iter__(self):
        return iter(self._data)

    def __len__(self):
        return len(self._data)

    def __str__(self):
        return str("," . join(map(str, self)))

    def __repr__(self):
        return "Bag(" + ", ".join(map(str, self._data)) + ")"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def insert(self, value: Any) -> None:
        self._data.insert_in_front(value)

class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data

class TestBag(unittest.TestCase):

    def test_init(self):
        bag = Bag()
        self.assertEqual(len(bag), 0)

    def test_len(self):
        bag = Bag()
        self.assertEqual(len(bag), 0)

        bag.insert(1)
        self.assertEqual(len(bag), 1)

        bag.insert(2)
        self.assertEqual(len(bag), 2)

        bag.insert(2)
        self.assertEqual(len(bag), 3)


    def test_repr(self):
        bag = Bag()
        self.assertEqual(repr(bag), "Bag()")

        bag.insert(1)
        self.assertEqual(repr(bag), "Bag(1)")

        bag.insert(2)
        bag.insert(3.14)
        # When more than one element is in the bag, we cant put constraints on the order
        self.assertTrue(repr(bag).startswith("Bag("))
        self.assertSetEqual(set(repr(bag).replace("Bag(", "").replace(")", "").split(",")), {"1", "2", "3.14"})


    def test_str(self):
        bag = Bag()
        self.assertEqual(str(bag), "")

        bag.insert("a")
        self.assertEqual(str(bag), "a")

        bag.insert("b")
        bag.insert("c")
        # When more than one element is in the bag, we cant put constraints on the order
        self.assertEqual(set(str(bag).split(",")), {"c", "b", "a"})


    def test_iter(self):
        bag = Bag()

        # Iterate over empty list
        self.assertEqual(list(bag), [])

        # Iterate over non-empty list
        bag.insert(1)
        bag.insert(2)
        bag.insert(3.14)
        bag.insert("AC")

        expected = {1, 2, 3.14, "AC"}
        self.assertSetEqual(set(bag), expected)


    def test_is_empty(self):
        bag = Bag()

        # Check empty bag
        self.assertTrue(bag.is_empty())

        # Check non-empty bag
        bag.insert(1)
        self.assertFalse(bag.is_empty())

if __name__ == "__main__":
     unittest.main(exit=False)

# Create an empty Bag
bag = Bag()

# Insert some values into the Bag
bag.insert(10)
bag.insert(20)
bag.insert(30)

# Print the Bag (it should show the contents)
print("Bag contents:", bag)
# Expected output: Bag(10, 20, 30) (order of elements may vary due to the nature of a linked list)

# Check the size of the Bag (number of elements)
print("Bag size:", len(bag))
# Expected output: 3


# Create a new Bag
bag = Bag()

# Check if the Bag is empty
print("Is the Bag empty?", bag.is_empty())  # Expected output: True

# Insert an element
bag.insert(100)

# Check again
print("Is the Bag empty?", bag.is_empty())  # Expected output: False


# Create a new Bag and insert elements
bag = Bag()
bag.insert(5)
bag.insert(15)
bag.insert(25)

# Iterate through the Bag and print each item
print("Bag items:")
for item in bag:
    print(item)

# Create a new Bag and insert some items
bag = Bag()
bag.insert(10)
bag.insert(20)
bag.insert(30)

# Print the Bag using __str__ (called automatically when you use `print`)
print(str(bag))  # Output: 10, 20, 30 (order may vary)

# Use the __repr__ method (useful for debugging or development)
print(repr(bag))  # Output: Bag(10, 20, 30) (order may vary)


# Create a SinglyLinkedList and insert elements
linked_list = SinglyLinkedList()
linked_list.insert_in_front(100)
linked_list.insert_to_back(200)
linked_list.insert_to_back(300)

# Print the list
print(str(linked_list))  # Expected output: 100->200->300


# Create a SinglyLinkedList and insert some elements
linked_list = SinglyLinkedList()
linked_list.insert_in_front(10)
linked_list.insert_to_back(20)
linked_list.insert_to_back(30)

# Get the element at index 1 (second element)
print("Element at index 1:", linked_list.get(1))
# Expected output: 20


# Create a new Bag and insert some values
bag = Bag()
bag.insert(10)
bag.insert(20)
bag.insert(30)

# Delete a value
bag._data.delete(20)

# Print the updated Bag
print("Updated Bag:", bag)  # Expected output: Bag(10, 30)

'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Graph7
    set output_file "main.py"

    set template_content '
from typing import Any, Type, Tuple, Optional, Callable, List
import unittest
class Graph:

    class Vertex:
        def __init__(self, key: Any):
            self.id = key
            self._adj_list = SinglyLinkedList()

        def __eq__(self, other: "Graph.Vertex"):
            return self.id == other.id

        def __hash__(self) -> int:
            return hash(repr(self))  # pragma: no cover

        def __repr__(self) -> str:
            return f"Vertex({repr(self.id)})"

        def __str__(self) -> str:
            return f"<{str(self.id)}>"

        def has_edge_to(self, destination_vertex: "Graph.Vertex") -> bool:
            return self._adj_list.search(lambda v: v == destination_vertex) is not None

        def add_edge_to(self, destination_vertex: "Graph.Vertex") -> None:
            if self.has_edge_to(destination_vertex):
                raise ValueError(f"Edge already exists: {self} -> {destination_vertex}")
            self._adj_list.insert_in_front(destination_vertex)

        def delete_edge_to(self, destination_vertex: "Graph.Vertex"):
            try:
                self._adj_list.delete(destination_vertex)
            except ValueError as e:
                raise ValueError(
                    f"Edge does not exist: {self} -> {destination_vertex}"
                ) from e

        def outgoing_edges(self) -> list[Tuple[Any, Any]]:
            return [(self.id, v.id) for v in self._adj_list]

    def __init__(self):
        self._adj = {}

    def __repr__(self) -> str:
         
        def edges_repr(edges):
            return "[" + ", ".join("->" + str(u) for (_, u) in edges) + "]"

        adj_lst_repr = (
            
            repr(v) + ": " + edges_repr(v.outgoing_edges()) for v in self._adj.values()
        )
        # Join elements with " | " and wrap it inside "Graph()"
        return "Graph(" + " | ".join(adj_lst_repr) + ")"

    def _get_vertex(self, key: Any) -> "Graph.Vertex":
        if key not in self._adj:
            raise ValueError(f"Vertex {key} does not exist!")
        return self._adj[key]

    def insert_vertex(self, key: Any) -> None:
        if key in self._adj:
            raise ValueError(f"Vertex {key} already exists!")
        self._adj[key] = Graph.Vertex(key)

    def has_vertex(self, key: Any) -> bool:
        return key in self._adj

    def delete_vertex(self, key: Any) -> None:
        v = self._get_vertex(key)
        for u in self._adj.values():
            if u != v and u.has_edge_to(v):
                u.delete_edge_to(v)
        del self._adj[key]

    def get_vertices(self) -> set[Any]:
        return set(self._adj.keys())

    def vertex_count(self) -> int:
        return len(self._adj)

    def insert_edge(self, key1: Any, key2: Any) -> None:
        v1 = self._get_vertex(key1)
        v2 = self._get_vertex(key2)
        v1.add_edge_to(v2)

    def has_edge(self, key1: Any, key2: Any) -> bool:
        v1 = self._get_vertex(key1)
        v2 = self._get_vertex(key2)
        return v1.has_edge_to(v2)

    def delete_edge(self, key1: Any, key2: Any) -> None:
        v1 = self._get_vertex(key1)
        v2 = self._get_vertex(key2)
        v1.delete_edge_to(v2)

    def get_edges(self) -> set[tuple[Any, Any]]:
        return set(e for v in self._adj.values() for e in v.outgoing_edges())

    def edge_count(self) -> int:
        return sum(len(v.outgoing_edges()) for v in self._adj.values())

    def bfs(self, start_vertex: Any, target_vertex: Any) -> list[Any]:
        if not self.has_vertex(start_vertex):
            raise ValueError(f"Start vertex {start_vertex} does not exist!")
        if not self.has_vertex(target_vertex):
            raise ValueError(f"Target vertex {target_vertex} does not exist!")

        def reconstruct_path(pred: dict[Any, Any], target: Any) -> list[Any]:
            # Reconstruct the path from start to target by going back until it finds a vertex
            # without predecessor: That can only be the start vertex
            path = []
            while target:
                path.append(target)
                target = pred[target]
            return path[::-1]

        distance = {v: float("inf") for v in self._adj}
        predecessor = {v: None for v in self._adj}

        queue = Queue(self.vertex_count())
        # Initially, we add the start vertex to the queue
        queue.enqueue(start_vertex)
        distance[start_vertex] = 0

        while not queue.is_empty():
            u = queue.dequeue()
            if u == target_vertex:
                # We have found the shortest path to the target
                return reconstruct_path(predecessor, target_vertex)

            # For each of  neighbors, we check if there was already a shorter path to them
            for _, v in self._get_vertex(u).outgoing_edges():
                if distance[v] == float("inf"):
                    distance[v] = distance[u] + 1
                    predecessor[v] = u
                    queue.enqueue(v)

        # At this point, we know there is no path from the start to the target vertex
        return None

    def dfs(
        self, start_vertex: Any, color: dict[Any, str] = None
    ) -> Tuple[bool, dict[Any, str]]:
        if not self.has_vertex(start_vertex):
            raise ValueError(f"Start vertex {start_vertex} does not exist!")
        if color is None:
            color = {v: "white" for v in self._adj}
        acyclic = True
        stack = Stack()
        stack.push((False, start_vertex))
        while not stack.is_empty():
            (mark_as_black, v) = stack.pop()
            col = color.get(v, "white")
            if mark_as_black:
                color[v] = "black"
            elif col == "grey":
                acyclic = False
            elif col == "white":
                color[v] = "grey"
                stack.push((True, v))
                for _, w in self._get_vertex(v).outgoing_edges():
                    stack.push((False, w))
        return acyclic, color

class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data

class Queue:

    def __init__(self, max_size):
        if max_size <= 1:
            raise ValueError()
        self._data = [None] * max_size
        self._max_size = max_size
        self._front = 0
        self._rear = 0
        self._size = 0

    def __len__(self):
        return self._size

    def __iter__(self):
        while not self.is_empty():
            yield self.dequeue()

    def __str__(self):

        def iterate():
            # We dont normally allow iterating on the elements of a queue without dequeueing them
            if self.is_empty():
                return
            front = self._front
            if front > self._rear:
                while front < self._max_size:
                    yield self._data[front]
                    front += 1
                front = 0
            while front < self._rear:
                yield self._data[front]
                front += 1

        return str([x for x in iterate()])

    def __repr__(self):
        return f"Queue({str(self)})"

    def is_empty(self) -> bool:
        return len(self) == 0

    def is_full(self) -> bool:
        return len(self) == self._max_size

    def enqueue(self, value: Any) -> None:
        if self.is_full():
            raise ValueError("The queue is already full!")
        self._data[self._rear] = value
        self._rear = (self._rear + 1) % self._max_size
        self._size += 1

    def dequeue(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot dequeue from an empty queue")

        value = self._data[self._front]
        self._front = (self._front + 1) % self._max_size
        self._size -= 1
        return value

class Stack:
    def __init__(self) -> None:
        self._data = SinglyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Stack({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def push(self, value: Any) -> None:
        self._data.insert_in_front(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.delete_from_front()

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot peek at an empty stack")
        # We need to deepcopy the data from the list, otherwise
        # anyone with a reference can change the underlying data.
        return copy.deepcopy(self._data._head.data())

class TestGraph(unittest.TestCase):

    def create_test_graph(self):
        graph = Graph()
        graph.insert_vertex(1)
        graph.insert_vertex(0.23)
        graph.insert_vertex("ABC")
        graph.insert_vertex("WXYZ")
        graph.insert_edge("ABC", "WXYZ")
        graph.insert_edge(1, "ABC")
        graph.insert_edge(1, "WXYZ")
        graph.insert_edge(1, 0.23)
        graph.insert_edge(0.23, "ABC")
        graph.insert_edge(0.23, 1)

        self.assertEqual(graph.vertex_count(), 4)
        self.assertEqual(graph.edge_count(), 6)
        self.assertTrue(graph.has_edge("ABC", "WXYZ"))
        self.assertTrue(graph.has_edge(1, "ABC"))
        self.assertTrue(graph.has_edge(1, "WXYZ"))
        self.assertTrue(graph.has_edge(1, 0.23))
        self.assertTrue(graph.has_edge(0.23, 1))
        self.assertTrue(graph.has_edge(0.23, "ABC"))
        return graph


    def create_bfs_disconnected_graph(self):
        graph = Graph()
        graph.insert_vertex(1)
        graph.insert_vertex(2)
        graph.insert_vertex(3)
        graph.insert_vertex(4)
        graph.insert_vertex(5)
        graph.insert_edge(1, 2)
        graph.insert_edge(1, 3)
        graph.insert_edge(2, 3)
        graph.insert_edge(2, 4)
        graph.insert_edge(3, 5)
        graph.insert_edge(4, 1)

        graph.insert_vertex(6)
        graph.insert_vertex(7)
        graph.insert_vertex(8)
        graph.insert_edge(6, 7)

        self.assertEqual(graph.vertex_count(), 8)
        self.assertEqual(graph.edge_count(), 7)
        return graph


    def test_repr(self):
        graph = Graph()
        self.assertEqual(repr(graph), "Graph()")
        graph.insert_vertex("A")
        self.assertEqual(repr(graph), "Graph(Vertex(\"A\"): [])")


    def test_insert_vertex(self):
        graph = Graph()
        self.assertEqual(graph.vertex_count(), 0)
        self.assertEqual(graph.edge_count(), 0)
        self.assertFalse(graph.has_vertex(1))
        self.assertFalse(graph.has_vertex("ABC"))
        graph.insert_vertex(1)
        self.assertEqual(graph.vertex_count(), 1)
        graph.insert_vertex("ABC")
        self.assertEqual(graph.vertex_count(), 2)
        self.assertTrue(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex("ABC"))


    def test_insert_existing_vertex(self):
        graph = Graph()
        self.assertEqual(graph.vertex_count(), 0)
        self.assertFalse(graph.has_vertex(1))
        graph.insert_vertex(1)
        self.assertTrue(graph.has_vertex(1))
        with self.assertRaises(ValueError):
            graph.insert_vertex(1)
        self.assertEqual(graph.vertex_count(), 1)
        self.assertTrue(graph.has_vertex(1))


    def test_insert_edge(self):
        graph = Graph()
        self.assertEqual(graph.vertex_count(), 0)
        self.assertEqual(graph.edge_count(), 0)
        graph.insert_vertex(1)
        graph.insert_vertex(0.23)
        graph.insert_vertex("ABC")
        graph.insert_vertex("WXYZ")
        self.assertEqual(graph.vertex_count(), 4)
        self.assertEqual(graph.edge_count(), 0)
        self.assertFalse(graph.has_edge("ABC", "WXYZ"))
        self.assertFalse(graph.has_edge(1, "ABC"))
        self.assertFalse(graph.has_edge(1, "WXYZ"))
        self.assertFalse(graph.has_edge(1, 0.23))
        self.assertFalse(graph.has_edge(0.23, 1))
        self.assertFalse(graph.has_edge(0.23, "ABC"))

        graph.insert_edge("ABC", "WXYZ")
        graph.insert_edge(1, "ABC")
        graph.insert_edge(1, "WXYZ")
        graph.insert_edge(1, 0.23)
        graph.insert_edge(0.23, "ABC")
        graph.insert_edge(0.23, 1)

        self.assertTrue(graph.has_edge("ABC", "WXYZ"))
        self.assertEqual(graph.edge_count(), 6)
        self.assertTrue(graph.has_edge(1, "ABC"))
        self.assertTrue(graph.has_edge(1, "WXYZ"))
        self.assertTrue(graph.has_edge(1, 0.23))
        self.assertTrue(graph.has_edge(0.23, 1))
        self.assertTrue(graph.has_edge(0.23, "ABC"))


    def test_insert_edge_invalid_source(self):
        graph = Graph()
        graph.insert_vertex(1)
        self.assertTrue(graph.has_vertex(1))
        self.assertFalse(graph.has_vertex(2))
        with self.assertRaises(ValueError):
            graph.insert_edge(2, 1)

    def test_insert_edge_invalid_destination(self):
        graph = Graph()
        graph.insert_vertex(1)
        self.assertTrue(graph.has_vertex(1))
        self.assertFalse(graph.has_vertex(2))
        with self.assertRaises(ValueError):
            graph.insert_edge(1, 2)

    def test_insert_existing_edge(self):
        graph = Graph()
        graph.insert_vertex(1)
        graph.insert_vertex(2)
        self.assertTrue(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex(2))
        self.assertFalse(graph.has_edge(1,2))

        graph.insert_edge(1, 2)
        self.assertEqual(graph.edge_count(), 1)
        self.assertTrue(graph.has_edge(1,2))

        with self.assertRaises(ValueError):
            graph.insert_edge(1, 2)

        self.assertEqual(graph.edge_count(), 1)
        self.assertTrue(graph.has_edge(1,2))

    def test_delete_edge(self):
        graph = self.create_test_graph()

        graph.delete_edge(1, "ABC")
        self.assertEqual(graph.edge_count(), 5)
        self.assertFalse(graph.has_edge(1, "ABC"))
        self.assertTrue(graph.has_edge("ABC", "WXYZ"))
        self.assertTrue(graph.has_edge(1, "WXYZ"))
        self.assertTrue(graph.has_edge(1, 0.23))
        self.assertTrue(graph.has_edge(0.23, 1))
        self.assertTrue(graph.has_edge(0.23, "ABC"))

        graph.delete_edge(0.23, 1)
        self.assertEqual(graph.edge_count(), 4)
        self.assertFalse(graph.has_edge(0.23, 1))
        self.assertFalse(graph.has_edge(1, "ABC"))
        self.assertTrue(graph.has_edge("ABC", "WXYZ"))
        self.assertTrue(graph.has_edge(1, "WXYZ"))
        self.assertTrue(graph.has_edge(1, 0.23))
        self.assertTrue(graph.has_edge(0.23, "ABC"))


    def test_delete_invalid_edge(self):
        graph = Graph()
        graph.insert_vertex(1)
        graph.insert_vertex(3.14)
        graph.insert_edge(1, 3.14)
        self.assertTrue(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex(3.14))
        self.assertFalse(graph.has_vertex(2))

        with self.assertRaises(ValueError):
            graph.delete_edge(1, 2)

        with self.assertRaises(ValueError):
            graph.delete_edge(2, 3.14)

        with self.assertRaises(ValueError):
            graph.delete_edge(3.14, 1)

    def test_delete_vertex(self):
        graph = self.create_test_graph()
        self.assertTrue(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex(0.23))
        self.assertTrue(graph.has_vertex("ABC"))
        self.assertTrue(graph.has_vertex("WXYZ"))
        graph.delete_vertex(1)
        self.assertEqual(graph.vertex_count(), 3)
        self.assertFalse(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex(0.23))
        self.assertTrue(graph.has_vertex("ABC"))
        self.assertTrue(graph.has_vertex("WXYZ"))
        self.assertEqual(graph.edge_count(), 2)
        with self.assertRaises(ValueError):
            self.assertFalse(graph.has_edge(0.23, 1))
        self.assertTrue(graph.has_edge("ABC", "WXYZ"))
        self.assertTrue(graph.has_edge(0.23, "ABC"))

        graph.delete_vertex("WXYZ")
        self.assertEqual(graph.vertex_count(), 2)
        self.assertFalse(graph.has_vertex(1))
        self.assertTrue(graph.has_vertex(0.23))
        self.assertTrue(graph.has_vertex("ABC"))
        self.assertFalse(graph.has_vertex("WXYZ"))
        self.assertEqual(graph.edge_count(), 1)
        self.assertTrue(graph.has_edge(0.23, "ABC"))

        graph.delete_vertex(0.23)
        self.assertEqual(graph.vertex_count(), 1)
        self.assertFalse(graph.has_vertex(1))
        self.assertFalse(graph.has_vertex(0.23))
        self.assertTrue(graph.has_vertex("ABC"))
        self.assertFalse(graph.has_vertex("WXYZ"))
        self.assertEqual(graph.edge_count(), 0)

        graph.delete_vertex("ABC")
        self.assertEqual(graph.vertex_count(), 0)
        self.assertFalse(graph.has_vertex(1))
        self.assertFalse(graph.has_vertex(0.23))
        self.assertFalse(graph.has_vertex("ABC"))
        self.assertFalse(graph.has_vertex("WXYZ"))

        with self.assertRaises(ValueError):
            graph.delete_vertex(1)

        with self.assertRaises(ValueError):
            graph.delete_vertex("Quack")


    def test_get_vertices(self):
        graph = self.create_test_graph()
        self.assertSetEqual(graph.get_vertices(), set([1, 0.23, "ABC", "WXYZ"]))


    def test_get_edges(self):
        graph = self.create_test_graph()
        expected_edges = set([(1, 0.23), (0.23, 1), (1, "ABC"), (1, "WXYZ"), ("ABC", "WXYZ"), (0.23, "ABC")])
        self.assertSetEqual(graph.get_edges(), expected_edges)


    def test_bfs(self):
        graph = self.create_bfs_disconnected_graph()
        result = graph.bfs(4, 3)
        self.assertListEqual(result, [4, 1, 3])

        result = graph.bfs(4, 5)
        self.assertListEqual(result, [4, 1, 3, 5])

        result = graph.bfs(2, 1)
        self.assertListEqual(result, [2, 4, 1])

        result = graph.bfs(1, 6)
        self.assertIsNone(result)


    def test_bfs_invalid_arguments(self):
        graph = self.create_test_graph()
        with self.assertRaises(ValueError):
            graph.bfs("Invalid", 1)

        with self.assertRaises(ValueError):
            graph.bfs(1, "Invalid")


    def test_dfs_invalid_arguments(self):
        graph = self.create_test_graph()
        with self.assertRaises(ValueError):
            graph.dfs("Invalid")

        with self.assertRaises(ValueError):
            graph.dfs("Invalid", {})


    def test_dfs(self):
        graph = self.create_bfs_disconnected_graph()
        acyclic, color = graph.dfs(4)
        self.assertFalse(acyclic)
        self.assertEqual(color, {1: "black",
                                 2: "black",
                                 3: "black",
                                 4: "black",
                                 5: "black",
                                 6: "white",
                                 7: "white",
                                 8: "white"})

        acyclic, color = graph.dfs(2)
        self.assertFalse(acyclic)
        self.assertEqual(color, {1: "black",
                                 2: "black",
                                 3: "black",
                                 4: "black",
                                 5: "black",
                                 6: "white",
                                 7: "white",
                                 8: "white"})

        acyclic, color = graph.dfs(3)
        self.assertTrue(acyclic)
        self.assertEqual(color, {1: "white",
                                 2: "white",
                                 3: "black",
                                 4: "white",
                                 5: "black",
                                 6: "white",
                                 7: "white",
                                 8: "white"})

        acyclic, color = graph.dfs(6)
        self.assertTrue(acyclic)
        self.assertEqual(color, {1: "white",
                                 2: "white",
                                 3: "white",
                                 4: "white",
                                 5: "white",
                                 6: "black",
                                 7: "black",
                                 8: "white"})

        acyclic, color = graph.dfs(3)
        self.assertTrue(acyclic)
        self.assertEqual(color, {1: "white",
                                 2: "white",
                                 3: "black",
                                 4: "white",
                                 5: "black",
                                 6: "white",
                                 7: "white",
                                 8: "white"})

        # Test passing the color dictionary as second argument
        acyclic, color = graph.dfs(2)
        self.assertFalse(acyclic)
        acyclic, color = graph.dfs(6, color)
        # Note that the result refers only to what could be learned in the last call of dfs!
        self.assertTrue(acyclic)
        self.assertEqual(color, {1: "black",
                                 2: "black",
                                 3: "black",
                                 4: "black",
                                 5: "black",
                                 6: "black",
                                 7: "black",
                                 8: "white"})

        acyclic, color = graph.dfs(6)
        self.assertTrue(acyclic)
        acyclic, color = graph.dfs(2, color)
        self.assertFalse(acyclic)
        self.assertEqual(color, {1: "black",
                                 2: "black",
                                 3: "black",
                                 4: "black",
                                 5: "black",
                                 6: "black",
                                 7: "black",
                                 8: "white"})

        graph.delete_edge(4, 1)
        acyclic, color = graph.dfs(3)
        self.assertTrue(acyclic)
        acyclic, color = graph.dfs(2, color)
        self.assertTrue(acyclic)
        self.assertEqual(color, {1: "white",
                                 2: "black",
                                 3: "black",
                                 4: "black",
                                 5: "black",
                                 6: "white",
                                 7: "white",
                                 8: "white"})


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a graph
g = Graph()

# Insert vertices (nodes)
g.insert_vertex("A")
g.insert_vertex("B")
g.insert_vertex("C")

# Insert edges (directed edges from one vertex to another)
g.insert_edge("A", "B")  # A -> B
g.insert_edge("B", "C")  # B -> C
g.insert_edge("A", "C")  # A -> C

# Check if a vertex exists
print(g.has_vertex("A"))  # True
print(g.has_vertex("D"))  # False

# Check if an edge exists
print(g.has_edge("A", "B"))  # True
print(g.has_edge("A", "C"))  # True
print(g.has_edge("C", "A"))  # False

# Get all edges
print(g.get_edges())  # {("A", "B"), ("B", "C"), ("A", "C")}

# Perform BFS to find the shortest path
print(g.bfs("A", "C"))  # ["A", "C"]

# Perform DFS to check if the graph is acyclic
acyclic, color = g.dfs("A")
print(acyclic)  # True (if the graph is acyclic)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DoublyLinkedListCore8
    set output_file "main.py"

    set template_content '
from __future__ import annotations
import copy
from typing import Any, Callable, List, Optional
import unittest

class DoublyLinkedList:
    class Node:
        def __init__(self, data: Any) -> None:
            self._data = data
            self._next = None
            self._prev = None

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> DoublyLinkedList.Node:
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional[DoublyLinkedList.Node]) -> None:
            self._next = next_node
            if next_node is not None:
                next_node._prev = self

        def prev(self) -> DoublyLinkedList.Node:
            return self._prev

        def has_prev(self) -> bool:
            return self._prev is not None

        def prepend(self, prev_node: Optional[DoublyLinkedList.Node]) -> None:
            self._prev = prev_node
            if prev_node is not None:
                prev_node._next = self

    # --- DoublyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None
        self._tail = None

    def __len__(self):
        return len(self.traverse(lambda x: x))

    def __repr__(self) -> str:
        return f"DoublyLinkedList({"<->".join(self.traverse(repr))})"

    def __str__(self) -> str:
        return "<->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        if self._head is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_head = self._head
            self._head = DoublyLinkedList.Node(data)
            self._head.append(old_head)

    def insert_to_back(self, data: Any) -> None:
        if self._tail is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_tail = self._tail
            self._tail = DoublyLinkedList.Node(data)
            self._tail.prepend(old_tail)

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def _search(self, target: Any) -> Optional[DoublyLinkedList.Node]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        """ """
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        node = self._search(target)
        if node is None:
            raise ValueError(f"No element with value {target} was found in the list.")

        if node.prev() is None:
            # Delete node from front
            self._head = node.next()
            if self._head is None:
                self._tail = None
            else:
                self._head.prepend(None)
        elif node.next() is None:
            # Delete node from back
            self._tail = node.prev()
            self._tail.append(None)
        else:
            node.prev().append(node.next())
            del node

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        if self._head is None:
            self._tail = None
        else:
            self._head.prepend(None)
        return data

    def delete_from_back(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._tail.data()
        self._tail = self._tail.prev()
        if self._tail is None:
            self._head = None
        else:
            self._tail.append(None)
        return data


class TestDoublyLinkedList(unittest.TestCase):

    def test_init(self):
        linked_list = DoublyLinkedList()
        self.assertIsNone(linked_list._head)


    def test_len(self):
        linked_list = DoublyLinkedList()
        self.assertEqual(len(linked_list), 0)

        linked_list.insert_in_front(1)
        self.assertEqual(len(linked_list), 1)

        linked_list.insert_in_front(2)
        self.assertEqual(len(linked_list), 2)

        linked_list.insert_to_back(2)
        self.assertEqual(len(linked_list), 3)


    def test_repr(self):
        linked_list = DoublyLinkedList()
        self.assertEqual(repr(linked_list), "DoublyLinkedList()")

        linked_list.insert_in_front(1)
        self.assertEqual(repr(linked_list), "DoublyLinkedList(1)")

        linked_list.insert_in_front(2)
        self.assertEqual(repr(linked_list), "DoublyLinkedList(2<->1)")

        linked_list.insert_to_back(3.14)
        self.assertEqual(repr(linked_list), "DoublyLinkedList(2<->1<->3.14)")


    def test_str(self):
        linked_list = DoublyLinkedList()
        self.assertEqual(str(linked_list), "")

        linked_list.insert_in_front("a")
        self.assertEqual(str(linked_list), "a")

        linked_list.insert_in_front("b")
        self.assertEqual(str(linked_list), "b<->a")

        linked_list.insert_to_back("c")
        self.assertEqual(str(linked_list), "b<->a<->c")


    def test_iter(self):
        linked_list = DoublyLinkedList()

        # Iterate over empty list
        self.assertEqual(list(linked_list), [])

        # Iterate over non-empty list
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_to_back(3.14)
        linked_list.insert_to_back("AC")

        expected = [2, 1, 3.14, "AC"]
        self.assertEqual(list(linked_list), expected)


    def test_size(self):
        linked_list = DoublyLinkedList()
        self.assertEqual(linked_list.size(), 0)

        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.size(), 1)

        linked_list.insert_in_front(2)
        self.assertEqual(linked_list.size(), 2)


    def test_is_empty(self):
        linked_list = DoublyLinkedList()
        self.assertTrue(linked_list.is_empty())
        linked_list.insert_in_front(1)
        self.assertFalse(linked_list.is_empty())
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(3)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(2)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(1)
        self.assertTrue(linked_list.is_empty())


    def test_add_in_front(self):
        linked_list = DoublyLinkedList()

        # Add to empty list
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list._head.data(), 1)

        # Add to non-empty list
        linked_list.insert_in_front(2)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)


    def test_add_to_back(self):
        linked_list = DoublyLinkedList()

        # Add to empty list
        linked_list.insert_to_back(1)
        self.assertEqual(linked_list._head.data(), 1)

        # Add to non-empty list
        linked_list.insert_in_front(2)
        linked_list.insert_to_back(3)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)
        self.assertEqual(linked_list._head.next().next().data(), 3)
        self.assertIsNone(linked_list._head.next().next().next())


    def test_get_valid_index(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        self.assertEqual(linked_list.get(0), 3)
        self.assertEqual(linked_list.get(1), 2)
        self.assertEqual(linked_list.get(2), 1)

    def test_get_invalid_index(self):
        linked_list = DoublyLinkedList()

        with self.assertRaises(IndexError):
            linked_list.get(-1)

        with self.assertRaises(IndexError):
            linked_list.get(0) # index out of bounds

    def test_get_returns_deep_copy(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front([["a", "b"], 1, 2])

        retrieved = linked_list.get(0)
        retrieved.append(3)
        retrieved[0].append("c")
        self.assertEqual(linked_list.get(0), [["a", "b"], 1, 2])


    def test_internal_search(self):
        linked_list = DoublyLinkedList()

        # Search empty list
        self.assertIsNone(linked_list._search(1))

        # Search when not found
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        self.assertIsNone(linked_list._search(3))

        # Search when found
        linked_list.insert_in_front(3)
        found = linked_list._search(3)
        self.assertEqual(found.data(), 3)


        found = linked_list._search(2)
        self.assertEqual(found.data(), 2)


    def test_search_empty_list(self):
        linked_list = DoublyLinkedList()
        result = linked_list.search(lambda x: x == 1)
        self.assertIsNone(result)


    def test_search_not_found(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)
        result = linked_list.search(lambda x: x == 1)
        self.assertIsNone(result)


    def test_search_found(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(3)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        result = linked_list.search(lambda x: x == 1)
        self.assertEqual(result, 1)
        result = linked_list.search(lambda x: x == 2)
        self.assertEqual(result, 2)
        result = linked_list.search(lambda x: x == 3)
        self.assertEqual(result, 3)


    def test_search_multiple_matches(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front("AB")
        linked_list.insert_in_front("C")
        linked_list.insert_in_front("ABC")
        linked_list.insert_in_front("B")
        result = linked_list.search(lambda x: x[0] == "A")
        self.assertEqual(result, "ABC")


    def test_delete(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        linked_list.delete(2)

        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 3)
        self.assertEqual(linked_list._head.next().data(), 1)


    def test_delete_head(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        linked_list.delete(3)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)

        linked_list.delete(2)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 1)
        self.assertIsNone(linked_list._head.next())

        linked_list.delete(1)
        self.assertEqual(len(linked_list), 0)

    def test_delete_tail(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        linked_list.delete(1)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 3)
        self.assertEqual(linked_list._head.next().data(), 2)

        linked_list.delete(2)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 3)
        self.assertIsNone(linked_list._head.next())

        linked_list.delete(3)
        self.assertEqual(len(linked_list), 0)
        self.assertIsNone(linked_list._head)
        self.assertIsNone(linked_list._tail)

    def test_delete_invalid(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(3)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)

        with self.assertRaises(ValueError):
            linked_list.delete(4)

    def test_delete_and_insert(self):
        linked_list = DoublyLinkedList()
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)
        linked_list.insert_to_back(1)

        linked_list.delete(2)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 3)
        self.assertEqual(linked_list._head.next().data(), 1)

        linked_list.insert_to_back(5)
        self.assertEqual(len(linked_list), 3)
        self.assertEqual(linked_list._head.next().next().data(), 5)
        self.assertIsNone(linked_list._head.next().next().next())

        linked_list.delete(3)
        linked_list.delete(5)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 1)
        self.assertIsNone(linked_list._head.next())

        linked_list.insert_in_front(6)
        linked_list.insert_to_back(7)
        linked_list.insert_to_back(8)

        self.assertEqual(len(linked_list), 4)
        self.assertIsNone(linked_list._head.prev())
        self.assertIsNone(linked_list._head.next().next().next().next())
        self.assertEqual(str(linked_list), "6<->1<->7<->8")


    def test_delete_from_front(self):
        linked_list = DoublyLinkedList()

        # Delete from empty list
        with self.assertRaises(ValueError):
            linked_list.delete_from_front()

        # Delete from list with one element
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.delete_from_front(), 1)
        self.assertTrue(linked_list.is_empty())

        # Delete from list with multiple elements
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(4)
        self.assertEqual(linked_list.delete_from_front(), 4)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 1)
        self.assertIsNone(linked_list._head.prev())

        self.assertEqual(linked_list.delete_from_front(), 1)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertIsNone(linked_list._head.prev())


    def test_delete_from_back(self):
        linked_list = DoublyLinkedList()

        # Delete from empty list
        with self.assertRaises(ValueError):
            linked_list.delete_from_back()

        # Delete from list with one element
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.delete_from_back(), 1)
        self.assertTrue(linked_list.is_empty())

        # Delete from list with multiple elements
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(3)
        self.assertEqual(linked_list.delete_from_back(), 2)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._tail.data(), 1)
        self.assertIsNone(linked_list._tail.next())
        self.assertEqual(linked_list.delete_from_back(), 1)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._tail.data(), 3)
        self.assertIsNone(linked_list._tail.next())


class TestNode(unittest.TestCase):

    def test_init(self):
        data = "test"
        node = DoublyLinkedList.Node(data)
        self.assertEqual(node.data(), data)
        self.assertIsNone(node.next())

    def test_str(self):
        data = "test"
        node = DoublyLinkedList.Node(data)
        self.assertEqual(str(node), str(data))

    def test_repr(self):
        data = "test"
        node = DoublyLinkedList.Node(data)
        self.assertEqual(repr(node), repr(data))

    def test_append(self):
        node1 = DoublyLinkedList.Node(1)
        node2 = DoublyLinkedList.Node(2)
        node1.append(node2)
        self.assertEqual(node1.next(), node2)
        self.assertEqual(node2.prev(), node1)

        node1.append(None)
        self.assertIsNone(node1.next())

    def test_has_next(self):
        node = DoublyLinkedList.Node(1)
        self.assertFalse(node.has_next())

        new_node = DoublyLinkedList.Node(2)
        new_node.append(node)
        self.assertTrue(new_node.has_next())

    def test_prepend(self):
        node1 = DoublyLinkedList.Node(1)
        node2 = DoublyLinkedList.Node(2)
        node1.prepend(node2)
        self.assertEqual(node1.prev(), node2)
        self.assertEqual(node2.next(), node1)

        node1.prepend(None)
        self.assertIsNone(node1.prev())

    def test_has_prev(self):
        node = DoublyLinkedList.Node(1)
        self.assertFalse(node.has_prev())

        new_node = DoublyLinkedList.Node(2)
        new_node.prepend(node)
        self.assertTrue(new_node.has_prev())


if __name__ == "__main__":
     unittest.main(exit=False)
    
# Create an empty DoublyLinkedList
dll = DoublyLinkedList()

# Print the list (should print an empty list)
print(dll)  # Output: ""

# Check if the list is empty
print(dll.is_empty())  # Output: True

# Insert elements in front of the list
dll.insert_in_front(10)
dll.insert_in_front(20)

# Insert elements at the back of the list
dll.insert_to_back(30)
dll.insert_to_back(40)

# Print the list after insertions
print(dll)  # Output: "20<->10<->30<->40"


# Access elements using get() (by index)
print(dll.get(0))  # Output: 20
print(dll.get(1))  # Output: 10
print(dll.get(2))  # Output: 30
print(dll.get(3))  # Output: 40


# Traverse the list with a function that squares each element
squared_elements = dll.traverse(lambda x: x**2)
print(squared_elements)  # Output: [400, 100, 900, 1600]


# Delete an element from the list (delete by value)
dll.delete(30)

# Print the list after deletion
print(dll)  # Output: "20<->10<->40"

# Delete from the front
dll.delete_from_front()

# Print the list after deleting from the front
print(dll)  # Output: "10<->40"

# Delete from the back
dll.delete_from_back()

# Print the list after deleting from the back
print(dll)  # Output: "10"


# Check the size of the list
print(len(dll))  # Output: 1 (only "10" remains)

# Check if the list is empty
print(dll.is_empty())  # Output: False

# Delete the last element
dll.delete_from_front()

# Check if the list is empty again
print(dll.is_empty())  # Output: True


# Insert more elements
dll.insert_in_front(5)
dll.insert_in_front(15)
dll.insert_to_back(25)

# Search for an element using a predicate
found = dll.search(lambda x: x == 15)
print(found)  # Output: 15 (since 15 is in the list)

# Search for an element that doesnt exist (will return None)
found = dll.search(lambda x: x == 100)
print(found)  # Output: None


# Print the string representation of the list
print(str(dll))  # Output: "15<->5<->10<->25"

# Print the official representation of the list
print(repr(dll)) 

# Iterating through the list using a for loop
for value in dll:
    print(value, end=" ")  # Output: 15 5 10 25

# Create an empty list and try to delete an element
empty_dll = DoublyLinkedList()

try:
    empty_dll.delete(10)  # Will raise ValueError as 10 is not in the list
except ValueError as e:
    print(e)  # Output: No element with value 10 was found in the list.

try:
    empty_dll.delete_from_front()  # Will raise ValueError as the list is empty
except ValueError as e:
    print(e)  # Output: Delete on an empty list.



'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SortedSinglyLinkedListCore9
    set output_file "main.py"

    set template_content '
from typing import Any
from math import floor, sqrt
from decimal import Decimal
import copy
from typing import Any, Callable, List, Optional
import unittest


class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data

class SortedSinglyLinkedList(SinglyLinkedList):
    def insert_in_front(self, data: Any) -> None:
        raise NotImplementedError("This method is not available for sorted lists")

    def insert_to_back(self, data: Any) -> None:
        raise NotImplementedError("This method is not available for sorted lists")

    def insert(self, new_data: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() >= new_data:
                if previous is None:
                    self._head = SinglyLinkedList.Node(
                        new_data, current
                    )  # Add the element at the beginning of the list
                else:
                    previous.append(
                        SinglyLinkedList.Node(new_data, current)
                    )  # General case
                return
            previous = current
            current = current.next()
        if previous is None:
            self._head = SinglyLinkedList.Node(new_data)  # The list is empty
        else:
            previous.append(
                SinglyLinkedList.Node(new_data, None)
            )  # Add the element at the end of the list

class TestSortedSinglyLinkedList(unittest.TestCase):

    def test_insert(self):
        sorted_list = SortedSinglyLinkedList()

        # Insert into empty list
        sorted_list.insert(6)
        self.assertEqual(sorted_list._head.data(), 6)

        # Insert at head
        sorted_list.insert(3) 
        self.assertEqual(sorted_list._head.data(), 3)

        # Insert in middle
        sorted_list.insert(5)
        self.assertEqual(sorted_list._head.next().data(), 5)
        sorted_list.insert(4)
        self.assertEqual(sorted_list._head.next().data(), 4)

        # Insert at tail
        self.assertEqual(sorted_list._head.next().next().next().data(), 6)
        sorted_list.insert(7)
        self.assertEqual(sorted_list._head.next().next().next().data(), 6)
        self.assertEqual(sorted_list._head.next().next().next().next().data(), 7)

    def test_insert_in_front(self):
        sorted_list = SortedSinglyLinkedList()
        with self.assertRaises(NotImplementedError):
            sorted_list.insert_in_front(10)


    def test_insert_to_back(self):
        sorted_list = SortedSinglyLinkedList()
        with self.assertRaises(NotImplementedError):
            sorted_list.insert_to_back(10)


    def test_search(self):
        linked_list = SortedSinglyLinkedList()

        # Search empty list
        self.assertIsNone(linked_list._search(1))

        # Search when not found
        linked_list.insert(2)
        linked_list.insert(1)
        self.assertIsNone(linked_list._search(3))

        # Search when found
        linked_list.insert(3)
        found = linked_list._search(3)
        self.assertEqual(found.data(), 3)


        found = linked_list._search(2)
        self.assertEqual(found.data(), 2)


    def test_delete(self):
        linked_list = SortedSinglyLinkedList()
        linked_list.insert(1)
        linked_list.insert(2)
        linked_list.insert(3)

        linked_list.delete(2)

        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 1)
        self.assertEqual(linked_list._head.next().data(), 3)


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a singly linked list
linked_list = SinglyLinkedList()

# Insert elements at the front and back
linked_list.insert_in_front(10)
linked_list.insert_to_back(20)
linked_list.insert_to_back(30)

print("List after insertions:")
print(linked_list)  # Output: 10 -> 20 -> 30

# Check the size of the list
print("Size of the list:", len(linked_list))  # Output: 3

# Get element at index 1
print("Element at index 1:", linked_list.get(1))  # Output: 20

# Delete element
linked_list.delete(20)
print("List after deleting 20:")
print(linked_list)  # Output: 10 -> 30

# Delete from front
linked_list.delete_from_front()
print("List after deleting from front:")
print(linked_list)  # Output: 30

# Create a sorted singly linked list
sorted_list = SortedSinglyLinkedList()

# Insert elements in sorted order
sorted_list.insert(5)
sorted_list.insert(3)
sorted_list.insert(8)
sorted_list.insert(1)

print("Sorted list after insertions:")
print(sorted_list)  # Output: 1 -> 3 -> 5 -> 8

# Insert more elements and print
sorted_list.insert(4)
sorted_list.insert(7)
print("Sorted list after more insertions:")
print(sorted_list)  # Output: 1 -> 3 -> 4 -> 5 -> 7 -> 8


# Create a linked list
linked_list = SinglyLinkedList()

# Insert elements
linked_list.insert_in_front(10)
linked_list.insert_to_back(20)
linked_list.insert_to_back(30)

# Traverse and print each element
print("Traverse using lambda:")
for item in linked_list.traverse(str):
    print(item)  # Output: 10, 20, 30


# Create a linked list
linked_list = SinglyLinkedList()

# Insert elements
linked_list.insert_in_front(10)
linked_list.insert_to_back(20)
linked_list.insert_to_back(30)

# Search for an element using a predicate
result = linked_list.search(lambda x: x == 20)
print("Search result:", result)  # Output: 20

# Search for an element that doesnt exist
result = linked_list.search(lambda x: x == 40)
print("Search result:", result)  # Output: None

# Create an empty linked list
empty_list = SinglyLinkedList()

# Try deleting from an empty list
try:
    empty_list.delete_from_front()
except ValueError as e:
    print(e)  # Output: Delete on an empty list.

# Create a sorted list
sorted_list = SortedSinglyLinkedList()

# Insert elements
sorted_list.insert(15)
sorted_list.insert(5)
sorted_list.insert(10)

# The list will be automatically sorted
print("Sorted list after insertions:")
print(sorted_list)  # Output: 5 -> 10 -> 15


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SinglyLinkedListCore10
    set output_file "main.py"

    set template_content '
from typing import Any
from math import floor, sqrt
from decimal import Decimal
import copy
from typing import Any, Callable, List, Optional
import unittest


class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data



class TestSinglyLinkedList(unittest.TestCase):

    def test_init(self):
        linked_list = SinglyLinkedList()
        self.assertIsNone(linked_list._head)


    def test_len(self):
        linked_list = SinglyLinkedList()
        self.assertEqual(len(linked_list), 0)

        linked_list.insert_in_front(1)
        self.assertEqual(len(linked_list), 1)

        linked_list.insert_in_front(2)
        self.assertEqual(len(linked_list), 2)

        linked_list.insert_to_back(2)
        self.assertEqual(len(linked_list), 3)


    def test_repr(self):
        linked_list = SinglyLinkedList()
        self.assertEqual(repr(linked_list), "SinglyLinkedList()")

        linked_list.insert_in_front(1)
        self.assertEqual(repr(linked_list), "SinglyLinkedList(1)")

        linked_list.insert_in_front(2)
        self.assertEqual(repr(linked_list), "SinglyLinkedList(2->1)")

        linked_list.insert_to_back(3.14)
        self.assertEqual(repr(linked_list), "SinglyLinkedList(2->1->3.14)")


    def test_str(self):
        linked_list = SinglyLinkedList()
        self.assertEqual(str(linked_list), "")

        linked_list.insert_in_front("a")
        self.assertEqual(str(linked_list), "a")

        linked_list.insert_in_front("b")
        self.assertEqual(str(linked_list), "b->a")

        linked_list.insert_to_back("c")
        self.assertEqual(str(linked_list), "b->a->c")


    def test_iter(self):
        linked_list = SinglyLinkedList()

        # Iterate over empty list
        self.assertEqual(list(linked_list), [])

        # Iterate over non-empty list
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_to_back(3.14)
        linked_list.insert_to_back("AC")

        expected = [2, 1, 3.14, "AC"]
        self.assertEqual(list(linked_list), expected)


    def test_size(self):
        linked_list = SinglyLinkedList()
        self.assertEqual(linked_list.size(), 0)

        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.size(), 1)

        linked_list.insert_in_front(2)
        self.assertEqual(linked_list.size(), 2)


    def test_is_empty(self):
        linked_list = SinglyLinkedList()
        self.assertTrue(linked_list.is_empty())
        linked_list.insert_in_front(1)
        self.assertFalse(linked_list.is_empty())
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(3)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(2)
        self.assertFalse(linked_list.is_empty())

        linked_list.delete(1)
        self.assertTrue(linked_list.is_empty())


    def test_add_in_front(self):
        linked_list = SinglyLinkedList()

        # Add to empty list
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list._head.data(), 1)

        # Add to non-empty list
        linked_list.insert_in_front(2)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)


    def test_add_to_back(self):
        linked_list = SinglyLinkedList()

        # Add to empty list
        linked_list.insert_to_back(1)
        self.assertEqual(linked_list._head.data(), 1)

        # Add to non-empty list
        linked_list.insert_in_front(2)
        linked_list.insert_to_back(3)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)
        self.assertEqual(linked_list._head.next().next().data(), 3)
        self.assertIsNone(linked_list._head.next().next().next())


    def test_get_valid_index(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        self.assertEqual(linked_list.get(0), 3)
        self.assertEqual(linked_list.get(1), 2)
        self.assertEqual(linked_list.get(2), 1)

    def test_get_invalid_index(self):
        linked_list = SinglyLinkedList()

        with self.assertRaises(IndexError):
            linked_list.get(-1)

        with self.assertRaises(IndexError):
            linked_list.get(0) # index out of bounds

    def test_get_returns_deep_copy(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front([["a", "b"], 1, 2])

        retrieved = linked_list.get(0)
        retrieved.append(3)
        retrieved[0].append("c")
        self.assertEqual(linked_list.get(0), [["a", "b"], 1, 2])


    def test_internal_search(self):
        linked_list = SinglyLinkedList()

        # Search empty list
        self.assertIsNone(linked_list._search(1))

        # Search when not found
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        self.assertIsNone(linked_list._search(3))

        # Search when found
        linked_list.insert_in_front(3)
        found = linked_list._search(3)
        self.assertEqual(found.data(), 3)


        found = linked_list._search(2)
        self.assertEqual(found.data(), 2)


    def test_search_empty_list(self):
        linked_list = SinglyLinkedList()
        result = linked_list.search(lambda x: x == 1)
        self.assertIsNone(result)

    def test_search_not_found(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)
        result = linked_list.search(lambda x: x == 1)
        self.assertIsNone(result)

    def test_search_found(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(3)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        result = linked_list.search(lambda x: x == 1)
        self.assertEqual(result, 1)
        result = linked_list.search(lambda x: x == 2)
        self.assertEqual(result, 2)
        result = linked_list.search(lambda x: x == 3)
        self.assertEqual(result, 3)

    def test_search_multiple_matches(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front("AB")
        linked_list.insert_in_front("C")
        linked_list.insert_in_front("ABC")
        linked_list.insert_in_front("B")
        result = linked_list.search(lambda x: x[0] == "A")
        self.assertEqual(result, "ABC")

    def test_delete(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        linked_list.delete(2)

        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 3)
        self.assertEqual(linked_list._head.next().data(), 1)


    def test_delete_head(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(1)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(3)

        linked_list.delete(3)
        self.assertEqual(len(linked_list), 2)
        self.assertEqual(linked_list._head.data(), 2)
        self.assertEqual(linked_list._head.next().data(), 1)

        linked_list.delete(2)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 1)
        self.assertIsNone(linked_list._head.next())

        linked_list.delete(1)
        self.assertEqual(len(linked_list), 0)


    def test_delete_invalid(self):
        linked_list = SinglyLinkedList()
        linked_list.insert_in_front(3)
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)

        with self.assertRaises(ValueError):
            linked_list.delete(4)


    def test_delete_from_front(self):
        linked_list = SinglyLinkedList()

        # Delete from empty list
        with self.assertRaises(ValueError):
            linked_list.delete_from_front()

        # Delete from list with one element
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.delete_from_front(), 1)
        self.assertTrue(linked_list.is_empty())

        # Delete from list with multiple elements
        linked_list.insert_in_front(2)
        linked_list.insert_in_front(1)
        self.assertEqual(linked_list.delete_from_front(), 1)
        self.assertEqual(len(linked_list), 1)
        self.assertEqual(linked_list._head.data(), 2)


class TestNode(unittest.TestCase):

    def test_init(self):
        data = "test"
        node = SinglyLinkedList.Node(data)
        self.assertEqual(node.data(), data)
        self.assertIsNone(node.next())

    def test_str(self):
        data = "test"
        node = SinglyLinkedList.Node(data)
        self.assertEqual(str(node), str(data))

    def test_repr(self):
        data = "test"
        node = SinglyLinkedList.Node(data)
        self.assertEqual(repr(node), repr(data))

    def test_next(self):
        node1 = SinglyLinkedList.Node(1)
        node2 = SinglyLinkedList.Node(2, node1)
        self.assertEqual(node2.next(), node1)

    def test_append(self):
        node1 = SinglyLinkedList.Node(1)
        node2 = SinglyLinkedList.Node(2)
        node1.append(node2)
        self.assertEqual(node1.next(), node2)

        node1.append(None)
        self.assertIsNone(node1.next())

    def test_has_next(self):
        node = SinglyLinkedList.Node(1)
        self.assertFalse(node.has_next())

        new_node = SinglyLinkedList.Node(2, node)
        self.assertTrue(new_node.has_next())


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert elements at the front
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# The list should now be: 30 -> 20 -> 10
print("List after inserting at front:", sll)

# Insert an element at the back
sll.insert_to_back(40)

# The list should now be: 30 -> 20 -> 10 -> 40
print("List after inserting at back:", sll)


# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Delete an element from the list
sll.delete(20)  # This should delete the element with value 20

# The list should now be: 30 -> 10
print("List after deleting 20:", sll)

# Try deleting an element from the front
sll.delete_from_front()  # This should delete 30

# The list should now be: 10
print("List after deleting from front:", sll)



# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Search for an element
found = sll.search(lambda x: x == 20)
print("Search for 20:", found)  # Output: 20

# Search for a non-existent element
found = sll.search(lambda x: x == 40)
print("Search for 40:", found)  # Output: None



# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Traverse and print the list using a lambda
traversed_data = sll.traverse(lambda x: x)
print("Traversed list:", traversed_data)  # Output: [30, 20, 10]



# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Traverse and print the list using a lambda
traversed_data = sll.traverse(lambda x: x)
print("Traversed list:", traversed_data)  # Output: [30, 20, 10]


# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Get an element at a specific index
element = sll.get(1)  # Should return the second element, which is 20
print("Element at index 1:", element)

# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Insert some elements
sll.insert_in_front(10)
sll.insert_in_front(20)
sll.insert_in_front(30)

# Check the size of the list
print("List size:", len(sll))  # Output: 3

# Create a new SinglyLinkedList instance
sll = SinglyLinkedList()

# Check if the list is empty
print("Is the list empty?", sll.is_empty())  # Output: True

# Insert some elements
sll.insert_in_front(10)

# Check again
print("Is the list empty?", sll.is_empty())  # Output: False

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.StackProfilingCore11
    set output_file "main.py"

    set template_content '
import cProfile
import pstats
from pstats import SortKey
import random
import copy
from typing import Any, Type

ITERATIONS = 10000000
RUNS = 1


# Singly Linked List Implementation (from previous code)
class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def append(self, next_node: "SinglyLinkedList.Node") -> None:
            self._next = next_node

    def __init__(self) -> None:
        self._head = None

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete from empty list")
        data = self._head.data()
        self._head = self._head.next()
        return data


# Stack backed by SinglyLinkedList
class Stack:
    def __init__(self) -> None:
        self._data = SinglyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Stack({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def push(self, value: Any) -> None:
        self._data.insert_in_front(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.delete_from_front()


# Array-based Stack
class ArrayStack:
    def __init__(self) -> None:
        self._data = []

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"ArrayStack({str(self._data)})"

    def is_empty(self) -> bool:
        return len(self._data) == 0

    def push(self, value: Any) -> None:
        self._data.append(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.pop()


def random_actions(
    prof, actions: int, stack: Type[Stack], array_stack: Type[ArrayStack]
) -> None:
    for i in range(actions):
        action = random.choice(["push", "pop"])  # Pushing more frequently
        if action == "push":
            val = random.randint(0, 100)
            prof.runcall(stack.push, val)
            prof.runcall(array_stack.push, val)
        else:
            try:
                prof.runcall(stack.pop)
                prof.runcall(array_stack.pop)
            except ValueError:
                pass  # Ignore empty pop errors


def start_profiling(prof, iterations: int) -> None:
    stack = Stack()
    array_stack = ArrayStack()
    random_actions(prof, iterations, stack, array_stack)


if __name__ == "__main__":
    pro = cProfile.Profile()
    for _ in range(RUNS):
        start_profiling(pro, ITERATIONS)
        st = (
            pstats.Stats(pro)
            .sort_stats(SortKey.FILENAME, SortKey.CUMULATIVE)
            .strip_dirs()
        )
        # Print the profiling stats
        print(st.print_stats("push"))
        print(st.print_stats("pop"))
        print(st.print_stats("stack"))
        print(st.print_stats("linked_list"))


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HeapCore12
    set output_file "main.py"

    set template_content '
from typing import Any, List, Optional
import unittest
import random

class Heap:

    def __init__(
        self, elements: List[Any] = None, element_priority=lambda x: x
    ) -> None:
        self._priority = element_priority
        if elements is not None and len(elements) > 0:
            self._heapify(elements)
        else:
            self._elements = []

    def __len__(self) -> int:
        return len(self._elements)

    def _has_lower_priority(self, element_1: Any, element_2: Any) -> bool:
        return self._priority(element_1) < self._priority(element_2)

    def _has_higher_priority(self, element_1: Any, element_2: Any) -> bool:
        return self._priority(element_1) > self._priority(element_2)

    def _validate(self) -> bool:
        current_index = 0
        first_leaf = self._first_leaf_index()
        while current_index < first_leaf:
            current_element: float = self._elements[current_index]
            first_child = self._left_child_index(current_index)
            last_child_guard = min(first_child + 2, len(self))
            for child_index in range(first_child, last_child_guard):
                if self._has_lower_priority(
                    current_element, self._elements[child_index]
                ):
                    return False  # pragma: no cover
            current_index += 1
        return True

    def _left_child_index(self, index) -> int:
        return index * 2 + 1

    def _parent_index(self, index: int) -> int:
        return (index - 1) // 2

    def _highest_priority_child_index(self, index: int) -> Optional[int]:
        first_index = self._left_child_index(index)

        if first_index >= len(self):
            # The current element has no children
            return None

        if first_index + 1 >= len(self):
            # The current element only has one child
            return first_index

        if self._has_higher_priority(
            self._elements[first_index], self._elements[first_index + 1]
        ):
            return first_index
        else:
            return first_index + 1

    def _first_leaf_index(self):
        return len(self) // 2

    def _push_down(self, index: int) -> None:

        # INVARIANT: 0 <= index < n
        assert 0 <= index < len(self._elements)
        element = self._elements[index]
        current_index = index
        while True:
            child_index = self._highest_priority_child_index(current_index)
            if child_index is None:
                break
            if self._has_lower_priority(element, self._elements[child_index]):
                self._elements[current_index] = self._elements[child_index]
                current_index = child_index
            else:
                break

        self._elements[current_index] = element

    def _bubble_up(self, index: int) -> None:
        # INVARIANT: 0 <= index < n
        assert 0 <= index < len(self._elements)
        element = self._elements[index]
        while index > 0:
            parent_index = self._parent_index(index)
            parent = self._elements[parent_index]
            if self._has_higher_priority(element, parent):
                self._elements[index] = parent
                index = parent_index
            else:
                break

        self._elements[index] = element

    def _heapify(self, elements: List[Any]) -> None:
        self._elements = elements[:]
        last_inner_node_index = self._first_leaf_index() - 1
        for index in range(last_inner_node_index, -1, -1):
            self._push_down(index)

    def is_empty(self) -> bool:
        return len(self) == 0

    def top(self) -> Any:
        if self.is_empty():
            raise ValueError("Method top called on an empty heap.")
        if len(self) == 1:
            element = self._elements.pop()
        else:
            element = self._elements[0]
            self._elements[0] = self._elements.pop()
            self._push_down(0)

        return element

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Method peek called on an empty heap.")
        return self._elements[0]

    def insert(self, element: Any) -> None:
        self._elements.append(element)
        self._bubble_up(len(self._elements) - 1)


class HeapTest(unittest.TestCase):
    def test_init(self):
        heap = Heap()
        self.assertEqual(0, len(heap))

        heap = Heap(elements=["A", "B", "C", "D"])

        self.assertEqual(4, len(heap))
        self.assertTrue(heap._validate())

        heap = Heap(elements=["A", "B", "C", "D"], element_priority=lambda x: -ord(x))

        self.assertEqual(4, len(heap))
        self.assertTrue(heap._validate())


    def test_heapify(self):
        size = 4 + random.randint(0, 20)
        elements = [chr(i) for i in range(ord("A"), ord("Z"))[:size]]
        heap = Heap(elements=elements)

        self.assertEqual(size, len(heap))
        self.assertTrue(heap._validate())


        heap = Heap(elements=["A", "B", "C", "D"])

        self.assertEqual(4, len(heap))
        self.assertEqual("D", heap.peek())

        heap = Heap(elements=["A", "B", "C", "D"], element_priority=lambda x: -ord(x))        

        self.assertEqual(4, len(heap))
        self.assertEqual("A", heap.peek())


    def test_heapify_duplicates(self):
        # An heap populated with pairs, where the second element in the pair is the priority
        heap = Heap(elements=["A", "A", "A", "D", "D"])

        self.assertEqual(5, len(heap))
        self.assertEqual("D", heap.top())
        self.assertEqual("D", heap.top())
        self.assertEqual("A", heap.top())
        self.assertEqual(2, len(heap))

        heap = Heap(elements=["A", "A", "A", "A"])

        self.assertEqual(4, len(heap))
        self.assertEqual("A", heap.top())


    def test_insert_top(self):
        heap = Heap([3, 1, 4, 11, -1, 2, 10])
        self.assertEqual(7, len(heap))
        heap.insert(7)
        heap.insert(5)
        self.assertEqual(9, len(heap))
        self.assertTrue(heap._validate())
        heap.top()
        heap.top()
        heap.top()
        self.assertEqual(6, len(heap))
        self.assertTrue(heap._validate())

        # An heap populated with pairs, where the second element in the pair is the priority
        heap = Heap(None, element_priority=lambda x: x[1])

        self.assertTrue(heap.is_empty())

        heap.insert(("First", -1e14))

        self.assertEqual("First", heap.top()[0])
        self.assertTrue(heap.is_empty())

        heap.insert(("b", 0))
        heap.insert(("c", 0.99))
        heap.insert(("second", 1))
        heap.insert(("a", -11))

        self.assertEqual("second", heap.top()[0])
        self.assertEqual(3, len(heap))

        for i in range(0, 10):
            heap.insert((str(i), random.random()))

        while not heap.is_empty():
            self.assertTrue(heap._validate())
            heap.top()

    def test_top_empty(self):
        heap = Heap()

        with self.assertRaises(ValueError):
            heap.top()

        with self.assertRaises(ValueError):
            heap.peek()

if __name__ == "__main__":
     unittest.main(exit=False)

heap = Heap([10, 20, 5, 30, 15])
print("Heap after insertion:", heap._elements)

# The top of the heap should be the minimum value
print("Top of heap:", heap.top())  # Expected: 5

heap.insert(3)
print("Heap after inserting 3:", heap._elements)
print("Top of heap:", heap.top())  # Expected: 3


heap = Heap([10, 20, 5, 30, 15], element_priority=lambda x: -x)
print("Heap after insertion:", heap._elements)

# The top of the heap should now be the maximum value
print("Top of heap:", heap.top())  # Expected: 30

heap.insert(35)
print("Heap after inserting 35:", heap._elements)
print("Top of heap:", heap.top())  # Expected: 35


heap = Heap([("A", 3), ("B", 1), ("C", 2)], element_priority=lambda x: x[1])
print("Heap after insertion:", heap._elements)

# The top should be the element with the smallest priority (B, 1)
print("Top of heap:", heap.top())  # Expected: ("B", 1)

heap.insert(("D", 0))
print("Heap after inserting (\"D\", 0):", heap._elements)
print("Top of heap:", heap.top())  # Expected: ("D", 0)

heap = Heap()

try:
    print(heap.top())
except ValueError as e:
    print(e)  # Expected: "Method top called on an empty heap."


heap = Heap([7, 9, 3, 1, 5, 6])
print("Heap after heapify:", heap._elements)
print("Top of heap:", heap.top())  # Expected: 1


heap = Heap([5, 5, 5, 5, 5, 5])
print("Heap after heapify:", heap._elements)
print("Top of heap:", heap.top())  # Expected: 5

heap.insert(3)
print("Heap after inserting 3:", heap._elements)
print("Top of heap:", heap.top())  # Expected: 3


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueLinkedListCore13
    set output_file "main.py"

    set template_content '
from __future__ import annotations
import copy
from typing import Any, Callable, List, Optional
import unittest

class Queue:

    def __init__(self):
        self._data = DoublyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.dequeue()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Queue({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def enqueue(self, value: Any) -> None:
        self._data.insert_to_back(value)

    def dequeue(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot dequeue from an empty queue")
        return self._data.delete_from_front()


class DoublyLinkedList:
    class Node:
        def __init__(self, data: Any) -> None:
            self._data = data
            self._next = None
            self._prev = None

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> DoublyLinkedList.Node:
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional[DoublyLinkedList.Node]) -> None:
            self._next = next_node
            if next_node is not None:
                next_node._prev = self

        def prev(self) -> DoublyLinkedList.Node:
            return self._prev

        def has_prev(self) -> bool:
            return self._prev is not None

        def prepend(self, prev_node: Optional[DoublyLinkedList.Node]) -> None:
            self._prev = prev_node
            if prev_node is not None:
                prev_node._next = self

    # --- DoublyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None
        self._tail = None

    def __len__(self):
        return len(self.traverse(lambda x: x))

    def __repr__(self) -> str:
        return f"DoublyLinkedList({"<->".join(self.traverse(repr))})"

    def __str__(self) -> str:
        return "<->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        if self._head is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_head = self._head
            self._head = DoublyLinkedList.Node(data)
            self._head.append(old_head)

    def insert_to_back(self, data: Any) -> None:
        if self._tail is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_tail = self._tail
            self._tail = DoublyLinkedList.Node(data)
            self._tail.prepend(old_tail)

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def _search(self, target: Any) -> Optional[DoublyLinkedList.Node]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        """ """
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        node = self._search(target)
        if node is None:
            raise ValueError(f"No element with value {target} was found in the list.")

        if node.prev() is None:
            # Delete node from front
            self._head = node.next()
            if self._head is None:
                self._tail = None
            else:
                self._head.prepend(None)
        elif node.next() is None:
            # Delete node from back
            self._tail = node.prev()
            self._tail.append(None)
        else:
            node.prev().append(node.next())
            del node

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        if self._head is None:
            self._tail = None
        else:
            self._head.prepend(None)
        return data

    def delete_from_back(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._tail.data()
        self._tail = self._tail.prev()
        if self._tail is None:
            self._head = None
        else:
            self._tail.append(None)
        return data


if __name__ == "__main__":
     unittest.main(exit=False)

queue = Queue()
print("Initial Queue:", queue)

queue.enqueue(10)
queue.enqueue(20)
queue.enqueue(30)
print("Queue after enqueuing 10, 20, and 30:", queue)

dequeued_item = queue.dequeue()
print("Dequeued item:", dequeued_item)  # Expected: 10
print("Queue after dequeuing:", queue)

# Re-enqueue some items
queue.enqueue(40)
queue.enqueue(50)

print("Queue after re-enqueueing:", queue)

# Iterate through the queue
print("Iterating through the queue:")
for item in queue:
    print(item)

# Dequeue all items
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.dequeue()

try:
    queue.dequeue()  # This will raise an error because the queue is empty
except ValueError as e:
    print(e)  # Expected: Cannot dequeue from an empty queue

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueCore14
    set output_file "main.py"

    set template_content '
import copy
from typing import Any, Callable, List, Optional
import unittest

class Queue:

    def __init__(self, max_size):
        if max_size <= 1:
            raise ValueError()
        self._data = [None] * max_size
        self._max_size = max_size
        self._front = 0
        self._rear = 0
        self._size = 0

    def __len__(self):
        return self._size

    def __iter__(self):
        while not self.is_empty():
            yield self.dequeue()

    def __str__(self):

        def iterate():
            # We dont normally allow iterating on the elements of a queue without dequeueing them
            if self.is_empty():
                return
            front = self._front
            if front > self._rear:
                while front < self._max_size:
                    yield self._data[front]
                    front += 1
                front = 0
            while front < self._rear:
                yield self._data[front]
                front += 1

        return str([x for x in iterate()])

    def __repr__(self):
        return f"Queue({str(self)})"

    def is_empty(self) -> bool:
        return len(self) == 0

    def is_full(self) -> bool:
        return len(self) == self._max_size

    def enqueue(self, value: Any) -> None:
        if self.is_full():
            raise ValueError("The queue is already full!")
        self._data[self._rear] = value
        self._rear = (self._rear + 1) % self._max_size
        self._size += 1

    def dequeue(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot dequeue from an empty queue")

        value = self._data[self._front]
        self._front = (self._front + 1) % self._max_size
        self._size -= 1
        return value

class QueueWithLinkedList:

    def __init__(self):
        self._data = DoublyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.dequeue()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Queue({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def enqueue(self, value: Any) -> None:
        self._data.insert_to_back(value)

    def dequeue(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot dequeue from an empty queue")
        return self._data.delete_from_front()



class DoublyLinkedList:
    class Node:
        def __init__(self, data: Any) -> None:
            self._data = data
            self._next = None
            self._prev = None

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "DoublyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["DoublyLinkedList.Node"]) -> None:
            self._next = next_node
            if next_node is not None:
                next_node._prev = self

        def prev(self) -> "DoublyLinkedList.Node":
            return self._prev

        def has_prev(self) -> bool:
            return self._prev is not None

        def prepend(self, prev_node: Optional["DoublyLinkedList.Node"]) -> None:
            self._prev = prev_node
            if prev_node is not None:
                prev_node._next = self

    # --- DoublyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None
        self._tail = None

    def __len__(self):
        return len(self.traverse(lambda x: x))

    def __repr__(self) -> str:
        return f"DoublyLinkedList({"<->".join(self.traverse(repr))})"

    def __str__(self) -> str:
        return "<->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        if self._head is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_head = self._head
            self._head = DoublyLinkedList.Node(data)
            self._head.append(old_head)

    def insert_to_back(self, data: Any) -> None:
        if self._tail is None:
            self._tail = self._head = DoublyLinkedList.Node(data)
        else:
            old_tail = self._tail
            self._tail = DoublyLinkedList.Node(data)
            self._tail.prepend(old_tail)

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def _search(self, target: Any) -> Optional["DoublyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        node = self._search(target)
        if node is None:
            raise ValueError(f"No element with value {target} was found in the list.")

        if node.prev() is None:
            # Delete node from front
            self._head = node.next()
            if self._head is None:
                self._tail = None
            else:
                self._head.prepend(None)
        elif node.next() is None:
            # Delete node from back
            self._tail = node.prev()
            self._tail.append(None)
        else:
            node.prev().append(node.next())
            del node

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        if self._head is None:
            self._tail = None
        else:
            self._head.prepend(None)
        return data

    def delete_from_back(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._tail.data()
        self._tail = self._tail.prev()
        if self._tail is None:
            self._head = None
        else:
            self._tail.append(None)
        return data

class TestQueueTemplate():
    def new_queue(self): # pragma: no cover
        raise NotImplementedError()

    def test_init(self):
        queue = self.new_queue()
        self.assertEqual(len(queue), 0)

    def test_enqueue_dequeue(self):
        queue = self.new_queue()
        self.assertEqual(len(queue), 0)

        # Dequeue from empty queue
        with self.assertRaises(ValueError):
            queue.dequeue()

        queue.enqueue("A")
        self.assertEqual(len(queue), 1)
        self.assertEqual(queue.dequeue(), "A")
        self.assertEqual(len(queue), 0)

        # Dequeue from empty queue
        with self.assertRaises(ValueError):
            queue.dequeue()

        queue.enqueue("A")
        queue.enqueue("BB")
        queue.enqueue("CCC")
        self.assertEqual(len(queue), 3)
        self.assertEqual(queue.dequeue(), "A")
        queue.enqueue(4)
        self.assertEqual(queue.dequeue(), "BB")
        self.assertEqual(queue.dequeue(), "CCC")
        self.assertEqual(queue.dequeue(), 4)


    def test_len(self):
        queue = self.new_queue()
        self.assertEqual(len(queue), 0)

        queue.enqueue(1)
        self.assertEqual(len(queue), 1)

        queue.enqueue(2)
        self.assertEqual(len(queue), 2)

        queue.enqueue(2)
        self.assertEqual(len(queue), 3)


    def test_is_empty(self):
        queue = self.new_queue()

        # Check empty queue
        self.assertTrue(queue.is_empty())

        # Check non-empty queue
        queue.enqueue(1)
        self.assertFalse(queue.is_empty())


    def test_iter(self):
        queue = self.new_queue()
        queue.enqueue(1)
        queue.enqueue(2)
        queue.enqueue(3)
        queue.dequeue()
        queue.enqueue(4)
        queue.enqueue(5)
        queue.dequeue()
        queue.enqueue(6)

        iterated = [x for x in queue]
        self.assertEqual(iterated, [3, 4, 5, 6])
        self.assertTrue(queue.is_empty())


class TestQueue(TestQueueTemplate, unittest.TestCase):
    """Tests a circular queue implemented with static arrays."""
    def new_queue(self, size=10):
        return Queue(size)


    # Tests specific to the array implementation
    def test_init_with_invalid_size(self):
        # Negative
        with self.assertRaises(ValueError):
            Queue(-1)
        # Null
        with self.assertRaises(ValueError):
            Queue(0)
        # Just one element
        with self.assertRaises(ValueError):
            Queue(1)


    def test_init_with_valid_size(self):
        queue = self.new_queue(2)
        queue.enqueue(1)
        queue.enqueue(2)
        with self.assertRaises(ValueError):
            queue.enqueue(3)
        self.assertEqual(queue.dequeue(), 1)
        queue.enqueue(3)
        self.assertEqual(queue.dequeue(), 2)
        self.assertEqual(queue.dequeue(), 3)
        with self.assertRaises(ValueError):
            queue.dequeue()
        queue.enqueue(4)
        self.assertEqual(len(queue), 1)
        self.assertEqual(queue.dequeue(), 4)


    def test_enqueue_to_a_full_queue(self):
        queue = self.new_queue(4)

        queue.enqueue(1)
        queue.enqueue("a")
        queue.enqueue(3)
        queue.enqueue("d")
        self.assertEqual(len(queue), 4)

        with self.assertRaises(ValueError):
            queue.enqueue("one too many")


    def test_repr(self):
        queue = self.new_queue()
        self.assertEqual(repr(queue), "Queue([])")

        queue.enqueue(1)
        self.assertEqual(repr(queue), "Queue([1])")

        queue.enqueue(2)
        queue.enqueue(3.14)

        self.assertEqual(repr(queue), "Queue([1, 2, 3.14])")


    def test_str(self):
        queue = self.new_queue(5)
        self.assertEqual(str(queue), "[]")

        queue.enqueue("a")
        self.assertEqual(str(queue), "['a']")

        queue.enqueue("b")
        queue.enqueue("c")
        self.assertEqual(str(queue), "['a', 'b', 'c']")

        queue.dequeue()
        queue.enqueue("d")
        queue.enqueue("e")
        queue.dequeue()
        queue.enqueue("f")

        self.assertEqual(str(queue), "['c', 'd', 'e', 'f']")



class TestQueueLinkedList(TestQueueTemplate, unittest.TestCase):
    """Runs the tests for a queue implemented with linked lists."""
    def new_queue(self):
        return QueueWithLinkedList()
    
    def test_repr(self):
        queue = self.new_queue()
        self.assertEqual(repr(queue), "Queue()")

        queue.enqueue(1)
        self.assertEqual(repr(queue), "Queue(1)")

        queue.enqueue(2)
        queue.enqueue(3.14)

        self.assertEqual(repr(queue), "Queue(1<->2<->3.14)")


    def test_str(self):
        queue = self.new_queue()
        self.assertEqual(str(queue), "")

        queue.enqueue("a")
        self.assertEqual(str(queue), "a")

        queue.enqueue("b")
        queue.enqueue("c")

        self.assertEqual(str(queue), "a<->b<->c")


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a Queue with a maximum size of 5
queue = Queue(5)

# Check if the queue is empty
print(queue.is_empty())  # Output: True

# Enqueue some elements
queue.enqueue(1)
queue.enqueue(2)
queue.enqueue(3)

# Check the size of the queue
print(len(queue))  # Output: 3

# Print the current elements in the queue (using __str__)
print(str(queue))  # Output: ['1', '2', '3']

# Dequeue an element and print it
print(queue.dequeue())  # Output: 1

# Enqueue more elements
queue.enqueue(4)
queue.enqueue(5)

# Print the queue after more elements are added
print(str(queue))  # Output: ['2', '3', '4', '5']

# Dequeue all elements
print(queue.dequeue())  # Output: 2
print(queue.dequeue())  # Output: 3
print(queue.dequeue())  # Output: 4
print(queue.dequeue())  # Output: 5

# Check if the queue is empty again
print(queue.is_empty())  # Output: True


# Create a Queue with a Linked List (no size limit)
queue_ll = QueueWithLinkedList()

# Check if the queue is empty
print(queue_ll.is_empty())  # Output: True

# Enqueue some elements
queue_ll.enqueue("apple")
queue_ll.enqueue("banana")
queue_ll.enqueue("cherry")

# Print the current elements in the queue
print(str(queue_ll))  # Output: apple<->banana<->cherry

# Dequeue an element and print it
print(queue_ll.dequeue())  # Output: apple

# Enqueue more elements
queue_ll.enqueue("date")
queue_ll.enqueue("elderberry")

# Print the queue after more elements are added
print(str(queue_ll))  # Output: banana<->cherry<->date<->elderberry

# Dequeue all elements
print(queue_ll.dequeue())  # Output: banana
print(queue_ll.dequeue())  # Output: cherry
print(queue_ll.dequeue())  # Output: date
print(queue_ll.dequeue())  # Output: elderberry

# Check if the queue is empty again
print(queue_ll.is_empty())  # Output: True


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.StackCore15
    set output_file "main.py"

    set template_content '
import copy
from typing import Any, Callable, List, Optional
import unittest



class Stack:
    def __init__(self) -> None:
        self._data = SinglyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Stack({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def push(self, value: Any) -> None:
        self._data.insert_in_front(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.delete_from_front()

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot peek at an empty stack")
        # We need to deepcopy the data from the list, otherwise
        # anyone with a reference can change the underlying data.
        return copy.deepcopy(self._data._head.data())



class StackWithArray:
    def __init__(self) -> None:
        self._data = []

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data[::-1])

    def __repr__(self):
        return f"Stack({str(self._data[::-1])})"

    def is_empty(self) -> bool:
        return len(self._data) == 0

    def push(self, value: Any) -> None:
        self._data.append(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.pop()

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot peek at an empty stack")
        # We need to deepcopy the data from the list, otherwise
        # anyone with a reference can change the underlying data.
        return copy.deepcopy(self._data[-1])


class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data



class TestStackTemplate():
    def new_stack(self): # pragma: no cover
        raise NotImplementedError()

    def test_init(self):
        stack = self.new_stack()
        self.assertEqual(len(stack), 0)

    def test_push_pop(self):
        stack = self.new_stack()
        self.assertEqual(len(stack), 0)

        # Pop from empty stack
        with self.assertRaises(ValueError):
            stack.pop()

        stack.push("A")
        self.assertEqual(len(stack), 1)
        self.assertEqual(stack.pop(), "A")
        self.assertEqual(len(stack), 0)

        # Pop from empty stack
        with self.assertRaises(ValueError):
            stack.pop()

        stack.push("A")
        stack.push("BB")
        stack.push("CCC")
        self.assertEqual(len(stack), 3)
        self.assertEqual(stack.pop(), "CCC")
        stack.push(4)
        self.assertEqual(stack.pop(), 4)
        self.assertEqual(stack.pop(), "BB")
        self.assertEqual(stack.pop(), "A")


    def test_peek(self):
        stack = self.new_stack()
        self.assertEqual(len(stack), 0)

        # Peek at empty stack
        with self.assertRaises(ValueError):
            stack.peek()

        stack.push("A")
        self.assertEqual(len(stack), 1)
        self.assertEqual(stack.peek(), "A")
        self.assertEqual(len(stack), 1)

        stack.push("BB")
        stack.push("CCC")
        self.assertEqual(len(stack), 3)
        self.assertEqual(stack.peek(), "CCC")
        self.assertEqual(stack.pop(), "CCC")
        self.assertEqual(stack.peek(), "BB")


    def test_len(self):
        stack = self.new_stack()
        self.assertEqual(len(stack), 0)

        stack.push(1)
        self.assertEqual(len(stack), 1)

        stack.push(2)
        self.assertEqual(len(stack), 2)

        stack.push(2)
        self.assertEqual(len(stack), 3)


    def test_repr(self):
        stack = self.new_stack()
        self.assertEqual(repr(stack), "Stack()")

        stack.push(1)
        self.assertEqual(repr(stack), "Stack(1)")

        stack.push(2)
        stack.push(3.14)
        # When more than one element is in the stack, we cant put constraints on the order
        self.assertEqual(repr(stack), "Stack(3.14->2->1)")


    def test_str(self):
        stack = self.new_stack()
        self.assertEqual(str(stack), "")

        stack.push("a")
        self.assertEqual(str(stack), "a")

        stack.push("b")
        stack.push("c")
        # When more than one element is in the stack, we cant put constraints on the order
        self.assertEqual(str(stack),"c->b->a")


    def test_is_empty(self):
        stack = self.new_stack()

        # Check empty stack
        self.assertTrue(stack.is_empty())

        # Check non-empty stack
        stack.push(1)
        self.assertFalse(stack.is_empty())


    def test_iter(self):
        stack = self.new_stack()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.pop()
        stack.push(4)
        stack.push(5)
        stack.pop()
        stack.push(6)

        iterated = [x for x in stack]
        self.assertEqual(iterated, [6, 4, 2, 1])
        self.assertTrue(stack.is_empty())


class TestStack(TestStackTemplate, unittest.TestCase):
    """Tests a stack implemented with linked lists."""
    def new_stack(self):
        return Stack()


class TestStackArray(TestStackTemplate, unittest.TestCase):
    """Runs the tests for a stack implemented with arrays Python lists."""
    def new_stack(self):
        return StackWithArray()

    # Additional tests specific to stack implemented with arrays
    def test_repr(self):
        stack = self.new_stack()
        self.assertEqual(repr(stack), "Stack([])")

        stack.push(1)
        self.assertEqual(repr(stack), "Stack([1])")

        stack.push(2)
        stack.push(3.14)
        self.assertEqual(repr(stack), "Stack([3.14, 2, 1])")


    def test_str(self):
        stack = self.new_stack()
        self.assertEqual(str(stack), "[]")

        stack.push("a")
        self.assertEqual(str(stack), "['a']")

        stack.push("b")
        stack.push("c")
        self.assertEqual(str(stack), "['c', 'b', 'a']")



if __name__ == "__main__":
     unittest.main(exit=False)

stack_ll = Stack()

# Stack using Singly Linked List
stack_ll = Stack()

print("Pushing values onto stack_ll:")
stack_ll.push(10)
print(f"Stack after pushing 10: {stack_ll}")

stack_ll.push(20)
print(f"Stack after pushing 20: {stack_ll}")

stack_ll.push(30)
print(f"Stack after pushing 30: {stack_ll}")

# Peek at the top item (without removing it)
print(f"Peek at top item: {stack_ll.peek()}")

# Pop items from the stack
print(f"Popping top item: {stack_ll.pop()}")
print(f"Stack after popping: {stack_ll}")

print(f"Popping next item: {stack_ll.pop()}")
print(f"Stack after popping: {stack_ll}")

# Checking if the stack is empty
print(f"Is stack_ll empty? {stack_ll.is_empty()}")

# Pop the last item
print(f"Popping the last item: {stack_ll.pop()}")
print(f"Stack after popping last item: {stack_ll}")

# Check if the stack is empty
print(f"Is stack_ll empty after popping all items? {stack_ll.is_empty()}")

# Trying to pop from an empty stack will raise an error
try:
    print(f"Trying to pop from empty stack_ll: {stack_ll.pop()}")
except ValueError as e:
    print(f"Error: {e}")


# Stack using Array
stack_array = StackWithArray()

print("\nPushing values onto stack_array:")
stack_array.push(5)
print(f"Stack after pushing 5: {stack_array}")

stack_array.push(15)
print(f"Stack after pushing 15: {stack_array}")

stack_array.push(25)
print(f"Stack after pushing 25: {stack_array}")

# Peek at the top item
print(f"Peek at top item: {stack_array.peek()}")

# Pop items from the stack
print(f"Popping top item: {stack_array.pop()}")
print(f"Stack after popping: {stack_array}")

print(f"Popping next item: {stack_array.pop()}")
print(f"Stack after popping: {stack_array}")

# Checking if the stack is empty
print(f"Is stack_array empty? {stack_array.is_empty()}")

# Pop the last item
print(f"Popping the last item: {stack_array.pop()}")
print(f"Stack after popping last item: {stack_array}")

# Check if the stack is empty
print(f"Is stack_array empty after popping all items? {stack_array.is_empty()}")

# Trying to pop from an empty stack will raise an error
try:
    print(f"Trying to pop from empty stack_array: {stack_array.pop()}")
except ValueError as e:
    print(f"Error: {e}")


# Singly Linked List
linked_list = SinglyLinkedList()

print("\nInserting items to the front of the linked list:")
linked_list.insert_in_front(10)
print(f"Linked list after inserting 10 at the front: {linked_list}")

linked_list.insert_in_front(20)
print(f"Linked list after inserting 20 at the front: {linked_list}")

linked_list.insert_in_front(30)
print(f"Linked list after inserting 30 at the front: {linked_list}")

# Insert items at the back of the list
print("\nInserting items to the back of the linked list:")
linked_list.insert_to_back(40)
print(f"Linked list after inserting 40 at the back: {linked_list}")

linked_list.insert_to_back(50)
print(f"Linked list after inserting 50 at the back: {linked_list}")

# Get an item at a specific index
print(f"Getting item at index 2: {linked_list.get(2)}")

# Delete an item from the list
print("\nDeleting item 20 from the list:")
linked_list.delete(20)
print(f"Linked list after deleting 20: {linked_list}")

# Search for a value in the list
print(f"Searching for value 40 in the list: {linked_list.search(lambda x: x == 40)}")

# Check if the list is empty
print(f"Is the linked list empty? {linked_list.is_empty()}")

# Deleting from the front of the list
print("\nDeleting from the front of the linked list:")
print(f"Deleted value: {linked_list.delete_from_front()}")
print(f"Linked list after deleting from front: {linked_list}")


# Iterating through the Stack using Singly Linked List
print("\nIterating through stack_ll:")
for item in stack_ll:
    print(f"Item: {item}")

# Iterating through the Stack using Array
print("\nIterating through stack_array:")
for item in stack_array:
    print(f"Item: {item}")


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTTreesCore16
    set output_file "main.py"

    set template_content '
import copy
from typing import Any, Callable, List, Optional
import unittest

class BinarySearchTree:

    class Node:
        @staticmethod
        def _node_str(node: "BinarySearchTree.Node") -> str:
            return str(node) if node is not None else ""

        def __init__(
            self,
            value: any,
            left: type["BinarySearchTree.Node"] = None,
            right: type["BinarySearchTree.Node"] = None,
        ) -> None:
            self._value = value
            self._left = left
            self._right = right

        def __str__(self) -> str:
            left_str = BinarySearchTree.Node._node_str(self._left)
            right_str = BinarySearchTree.Node._node_str(self._right)
            return f"{self._value} ({left_str})({right_str})"

        def value(self) -> any:
            return self._value

        def left(self) -> type["BinarySearchTree.Node"]:
            return self._left

        def right(self) -> type["BinarySearchTree.Node"]:
            return self._right

        def set_left(self, node: type["BinarySearchTree.Node"]) -> None:
            self._left = node

        def set_right(self, node: type["BinarySearchTree.Node"]) -> None:
            self._right = node

        def find_min_in_subtree(
            self,
        ) -> tuple[type["BinarySearchTree.Node"], type["BinarySearchTree.Node"]]:
            parent = None
            node = self
            while node.left() is not None:
                parent = node
                node = node.left()
            return node, parent

        def find_max_in_subtree(
            self,
        ) -> tuple[type["BinarySearchTree.Node"], type["BinarySearchTree.Node"]]:
            parent = None
            node = self
            while node.right() is not None:
                parent = node
                node = node.right()
            return node, parent

    def __init__(self) -> None:
        self._root = None

    def __repr__(self) -> str:
        return f"BinarySearchTree({str(self)})"

    def __str__(self) -> str:
        return BinarySearchTree.Node._node_str(self._root)

    def __len__(self) -> bool:
        # This version of the traversal algorithm uses an explicit stack, instead of recursion.
        stack = Stack()
        stack.push(self._root)
        size = 0
        while len(stack) > 0:
            node = stack.pop()
            if node is not None:
                size += 1
                stack.push(node.right())
                stack.push(node.left())
        return size

    def __iter__(self):
        current = self._root
        stack = Stack()
        while current is not None or len(stack) > 0:
            if current is None:
                current = stack.pop()
                yield current.value()
                current = current.right()
            else:
                while current.left() is not None:
                    stack.push(current)
                    current = current.left()
                yield current.value()
                current = current.right()

    def _search(
        self, value: any
    ) -> tuple[Optional[type["BinarySearchTree.Node"]], type["BinarySearchTree.Node"]]:
        parent = None
        node = self._root
        while node is not None:
            node_val = node.value()
            if node_val == value:
                return node, parent
            elif value < node_val:
                parent = node
                node = node.left()
            else:
                parent = node
                node = node.right()
        return None, None

    def contains(self, value: any) -> bool:
        return self._search(value)[0] is not None

    def insert(self, value: any) -> None:
        node = self._root
        if node is None:
            # Empty tree
            self._root = BinarySearchTree.Node(value)
        else:
            while True:  # node can never be None here
                if value <= node.value():
                    if node.left() is None:
                        # We have found the right spot for value
                        node.set_left(BinarySearchTree.Node(value))
                        break
                    else:
                        # We keep traversing the left branch
                        node = node.left()
                elif node.right() is None:
                    # We have found the right spot for value
                    node.set_right(BinarySearchTree.Node(value))
                    break
                else:
                    # We keep traversing the right branch
                    node = node.right()

    def delete(self, value: any) -> None:
        if self._root is None:
            raise ValueError("Delete on an empty tree")
        node, parent = self._search(value)
        if node is None:
            raise ValueError("Value not found")

        if node.left() is None or node.right() is None:
            maybe_child = node.right() if node.left() is None else node.left()
            # The node has at most only one child
            if parent is None:
                # The node is the root
                self._root = maybe_child
            elif value <= parent.value():
                parent.set_left(maybe_child)
            else:
                parent.set_right(maybe_child)
        else:  # The node N has two children.
            # Find and remove the node M with the largest value in the left subtree of N.
            max_node, max_node_parent = node.left().find_max_in_subtree()
            if max_node_parent is None:  # M is the left child of N.
                new_node = BinarySearchTree.Node(
                    max_node.value(), max_node.left(), node.right()
                )
            else:
                new_node = BinarySearchTree.Node(
                    max_node.value(), node.left(), node.right()
                )
                max_node_parent.set_right(max_node.left())
            # Then  replace the node to be deleted with a new node with M.value(),
            # and the same subtrees as N.
            if parent is None:
                # The node is the root
                self._root = new_node
            elif value <= parent.value():
                parent.set_left(new_node)
            else:
                parent.set_right(new_node)



class Stack:
    def __init__(self) -> None:
        self._data = SinglyLinkedList()

    def __len__(self):
        return len(self._data)

    def __iter__(self):
        while not self.is_empty():
            yield self.pop()

    def __str__(self):
        return str(self._data)

    def __repr__(self):
        return f"Stack({str(self._data)})"

    def is_empty(self) -> bool:
        return self._data.is_empty()

    def push(self, value: Any) -> None:
        self._data.insert_in_front(value)

    def pop(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot pop from an empty stack")
        return self._data.delete_from_front()

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Cannot peek at an empty stack")
        # We need to deepcopy the data from the list, otherwise
        # anyone with a reference can change the underlying data.
        return copy.deepcopy(self._data._head.data())


class SinglyLinkedList:
    class Node:
        def __init__(self, data: Any, next_node: "SinglyLinkedList.Node" = None) -> None:
            self._data = data
            self._next = next_node

        def __str__(self) -> str:
            return str(self.data())

        def __repr__(self) -> str:
            return repr(self.data())

        def data(self) -> Any:
            return self._data

        def next(self) -> "SinglyLinkedList.Node":
            return self._next

        def has_next(self) -> bool:
            return self._next is not None

        def append(self, next_node: Optional["SinglyLinkedList.Node"]) -> None:
            self._next = next_node

    # --- SinglyLinkedList methods ---

    def __init__(self) -> None:
        self._head = None

    def __len__(self):
        return len(self.traverse(lambda x: x))
    def __repr__(self) -> str:
        return f"SinglyLinkedList({"->".join(map(repr, self))})"
    def __str__(self) -> str:
        return "->".join(self.traverse(str))

    def __iter__(self):
        current = self._head
        while current is not None:
            data = current.data()
            current = current.next()
            yield data

    def size(self) -> int:
        size = 0
        current = self._head
        while current is not None:
            size += 1
            current = current.next()
        return size

    def is_empty(self) -> bool:
        return self._head is None

    def insert_in_front(self, data: Any) -> None:
        old_head = self._head
        self._head = SinglyLinkedList.Node(data, old_head)

    def insert_to_back(self, data: Any) -> None:
        current = self._head
        if current is None:
            self._head = SinglyLinkedList.Node(data)
        else:
            while current.next() is not None:
                current = current.next()
            current.append(SinglyLinkedList.Node(data))

    def get(self, index):
        if index < 0:
            raise IndexError("Index must be non-negative")
        current = self._head
        current_index = 0
        while current_index < index and current is not None:
            current = current.next()
            current_index += 1
        if current is None:
            raise IndexError("Index out of bounds")
        # Here we know that we are at the right index
        return copy.deepcopy(current.data())

    def traverse(self, functor: Callable[..., Any]) -> List[Any]:
        current = self._head
        result = []
        while current is not None:
            result.append(functor(current.data()))
            current = current.next()
        return result

    def _search(self, target: Any) -> Optional["SinglyLinkedList.Node"]:
        current = self._head
        while current is not None:
            if current.data() == target:
                return current
            current = current.next()
        return None

    def search(self, predicate: Callable[..., Any]) -> Optional[Any]:
        current = self._head
        while current is not None:
            if predicate(current.data()):
                return current.data()
            current = current.next()
        return None

    def delete(self, target: Any) -> None:
        current = self._head
        previous = None
        while current is not None:
            if current.data() == target:
                if previous is None:
                    self._head = current.next()
                else:
                    previous.append(current.next())
                return
            previous = current
            current = current.next()
        raise ValueError(f"No element with value {target} was found in the list.")

    def delete_from_front(self) -> Any:
        if self.is_empty():
            raise ValueError("Delete on an empty list.")
        data = self._head.data()
        self._head = self._head.next()
        return data



class TestBinarySearchTree(unittest.TestCase):

    def test_repr(self):
        bst = BinarySearchTree()
        self.assertEqual(repr(bst), "BinarySearchTree()")

        bst.insert(1)
        self.assertEqual(repr(bst), "BinarySearchTree(1 ()())")

        bst.insert(2)
        bst.insert(-3.14)
        self.assertEqual(repr(bst), "BinarySearchTree(1 (-3.14 ()())(2 ()()))")


    def test_str(self):
        bst = BinarySearchTree()
        self.assertEqual(str(bst), "")

        bst.insert("a")
        self.assertEqual(str(bst), "a ()()")

        bst.insert("b")
        bst.insert("d")
        self.assertEqual(str(bst), "a ()(b ()(d ()()))")
        bst.insert("c")
        self.assertEqual(str(bst), "a ()(b ()(d (c ()())()))")
        bst.insert("Z")
        self.assertEqual(str(bst), "a (Z ()())(b ()(d (c ()())()))")

    def test_len(self):
        bst = BinarySearchTree()
        self.assertEqual(len(bst), 0)

        bst.insert("a")
        self.assertEqual(len(bst), 1)

        bst.insert("b")
        bst.insert("d")
        self.assertEqual(len(bst), 3)
        bst.insert("c")
        self.assertEqual(len(bst), 4)
        bst.insert("Z")
        self.assertEqual(len(bst), 5)

    def test_contains(self):
        bst = BinarySearchTree()
        self.assertFalse(bst.contains("a"))
        self.assertFalse(bst.contains("b"))
        self.assertFalse(bst.contains("c"))
        self.assertFalse(bst.contains("d"))
        self.assertFalse(bst.contains("Z"))

        bst.insert("a")
        self.assertTrue(bst.contains("a"))
        self.assertFalse(bst.contains("b"))
        self.assertFalse(bst.contains("c"))
        self.assertFalse(bst.contains("d"))
        self.assertFalse(bst.contains("Z"))

        bst.insert("b")
        bst.insert("d")
        self.assertTrue(bst.contains("a"))
        self.assertTrue(bst.contains("b"))
        self.assertFalse(bst.contains("c"))
        self.assertTrue(bst.contains("d"))        
        self.assertFalse(bst.contains("Z"))

        bst.insert("c")
        self.assertTrue(bst.contains("c"))
        bst.insert("Z")
        self.assertTrue(bst.contains("Z"))
        bst.insert("A")
        self.assertTrue(bst.contains("A"))

    def test_insert_delete(self):
        bst = BinarySearchTree()

        # Delete from an empty BST
        with self.assertRaises(ValueError):
            bst.delete(6)

        bst.insert(6)
        bst.insert(4)
        bst.insert(7)
        bst.insert(5)
        bst.insert(2)
        bst.insert(3)
        bst.insert(9)
        bst.insert(1)
        bst.insert(6)
        bst.insert(8)
        bst.insert(11)

        self.assertEqual(len(bst), 11)

        # Value to be deleted not found
        with self.assertRaises(ValueError):
            bst.delete(0)

        # Delete a node with no children
        self.assertTrue(bst.contains(1))
        self.assertTrue(bst.contains(8))
        bst.delete(1)
        bst.delete(8)
        self.assertEqual(len(bst), 9)
        self.assertFalse(bst.contains(1))
        self.assertTrue(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertTrue(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertTrue(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # Delete a node with only a left child
        bst.delete(9)
        self.assertEqual(len(bst), 8)
        self.assertFalse(bst.contains(1))
        self.assertTrue(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertTrue(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # Delete a node with only a right child
        bst.delete(2)
        self.assertEqual(len(bst), 7)
        self.assertFalse(bst.contains(1))
        self.assertFalse(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertTrue(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # Delete a node with both children
        bst.delete(4)
        self.assertEqual(len(bst), 6)
        self.assertFalse(bst.contains(1))
        self.assertFalse(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertFalse(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # Delete the root node
        bst.delete(6)
        self.assertEqual(len(bst), 5)
        self.assertFalse(bst.contains(1))
        self.assertFalse(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertFalse(bst.contains(4))
        self.assertTrue(bst.contains(5))
        # There are two occurrences of the value 6!
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # It must have replaced the old root with
        # the other occurrence of the same value
        self.assertEqual(bst._root._value, 6)

        bst.delete(6)
        self.assertEqual(len(bst), 4)
        self.assertFalse(bst.contains(1))
        self.assertFalse(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertFalse(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertFalse(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        self.assertEqual(bst._root._value, 5)
        bst.insert(1)
        bst.insert(2)
        bst.insert(6)
        self.assertEqual(len(bst), 7)
        self.assertTrue(bst.contains(1))
        self.assertTrue(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertFalse(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(6))
        self.assertTrue(bst.contains(7))
        self.assertFalse(bst.contains(8))
        self.assertFalse(bst.contains(9))
        self.assertFalse(bst.contains(10))
        self.assertTrue(bst.contains(11))

        # Delete a node with both children, with the successor of the node having a left subtree
        bst = BinarySearchTree()

        bst.insert("H")
        bst.insert("F")
        bst.insert("I")
        bst.insert("G")
        bst.insert("B")
        bst.insert("E")
        bst.insert("K")
        bst.insert("A")
        bst.insert("J")
        bst.insert("L")
        bst.insert("C")
        bst.insert("D")
        self.assertEqual(len(bst), 12)

        bst.delete("F")
        self.assertEqual(len(bst), 11)
        self.assertTrue(bst.contains("A"))
        self.assertTrue(bst.contains("B"))
        self.assertTrue(bst.contains("C"))
        self.assertTrue(bst.contains("D"))
        self.assertTrue(bst.contains("E"))
        self.assertFalse(bst.contains("F"))
        self.assertTrue(bst.contains("G"))
        self.assertTrue(bst.contains("H"))
        self.assertTrue(bst.contains("I"))
        self.assertTrue(bst.contains("J"))
        self.assertTrue(bst.contains("K"))
        self.assertTrue(bst.contains("L"))


    def test_delete_edge_case(self):
        bst = BinarySearchTree()

        bst.insert(6)
        bst.insert(5)
        bst.insert(4)
        bst.insert(7)
        bst.insert(3)
        bst.insert(2)
        bst.insert(1)
        bst.insert(8)
        bst.insert(9)

        self.assertEqual(len(bst), 9)

        bst.delete(6)
        self.assertEqual(len(bst), 8)
        self.assertFalse(bst.contains(6))
        self.assertTrue(bst.contains(1))
        self.assertTrue(bst.contains(2))
        self.assertTrue(bst.contains(3))
        self.assertTrue(bst.contains(4))
        self.assertTrue(bst.contains(5))
        self.assertTrue(bst.contains(7))
        self.assertTrue(bst.contains(8))
        self.assertTrue(bst.contains(9))


    def test_iterate(self):
        bst = BinarySearchTree()

        self.assertEqual([v for v in bst], [])

        bst.insert(6)

        self.assertEqual([v for v in bst], [6])

        bst.insert(4)

        self.assertEqual([v for v in bst], [4, 6])

        bst.insert(7)
        bst.insert(5)
        bst.insert(2)
        bst.insert(3)
        bst.insert(9)
        bst.insert(1)
        bst.insert(6)
        bst.insert(8)
        bst.insert(11)

        self.assertEqual([v for v in bst], [1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 11])


if __name__ == "__main__":
     unittest.main(exit=False)

# Create a Binary Search Tree
bst = BinarySearchTree()

# Insert nodes into the tree
print("Inserting nodes into BST:")
bst.insert(10)
print(f"BST after inserting 10: {bst}")
bst.insert(20)
print(f"BST after inserting 20: {bst}")
bst.insert(5)
print(f"BST after inserting 5: {bst}")
bst.insert(15)
print(f"BST after inserting 15: {bst}")

# Check if a value is in the tree
print("\nChecking if values are present in BST:")
print(f"Does BST contain 10? {bst.contains(10)}")  # Expected: True
print(f"Does BST contain 30? {bst.contains(30)}")  # Expected: False

# Find the size of the tree
print(f"\nSize of BST (number of nodes): {len(bst)}")  # Expected: 4

# Delete a node with no children (leaf node)
print("\nDeleting leaf node (5) from BST:")
bst.delete(5)
print(f"BST after deleting 5: {bst}")

# Delete a node with one child
print("\nDeleting node with one child (15) from BST:")
bst.delete(15)
print(f"BST after deleting 15: {bst}")

# Delete a node with two children
print("\nDeleting node with two children (10) from BST:")
bst.delete(10)
print(f"BST after deleting 10: {bst}")

# Use the iterator to traverse the tree in in-order
print("\nIn-order traversal of BST:")
for value in bst:
    print(value)  # Expected output: 15, 20


# Create a stack
stack = Stack()

# Push elements onto the stack
print("\nPushing values onto the stack:")
stack.push(1)
print(f"Stack after pushing 1: {stack}")
stack.push(2)
print(f"Stack after pushing 2: {stack}")
stack.push(3)
print(f"Stack after pushing 3: {stack}")

# Pop elements from the stack
print("\nPopping values from the stack:")
print(f"Popped value: {stack.pop()}")  # Expected: 3
print(f"Stack after popping: {stack}")
print(f"Popped value: {stack.pop()}")  # Expected: 2
print(f"Stack after popping: {stack}")
print(f"Popped value: {stack.pop()}")  # Expected: 1
print(f"Stack after popping: {stack}")

# Try popping from an empty stack (this will raise an error)
print("\nTrying to pop from an empty stack:")
try:
    print(stack.pop())
except ValueError as e:
    print(f"Error: {e}")  # Expected output: Cannot pop from an empty stack


# Create a singly linked list
sll = SinglyLinkedList()

# Insert elements at the front
print("\nInserting elements at the front of the linked list:")
sll.insert_in_front(10)
print(f"Linked list after inserting 10 at the front: {sll}")
sll.insert_in_front(20)
print(f"Linked list after inserting 20 at the front: {sll}")

# Insert an element at the back
sll.insert_to_back(30)
print(f"Linked list after inserting 30 at the back: {sll}")

# Print the list
print(f"\nCurrent state of the linked list: {sll}")  # Expected output: 20->10->30

# Get the size of the list
print(f"Size of the linked list: {len(sll)}")  # Expected output: 3

# Delete an element
print("\nDeleting element 10 from the linked list:")
sll.delete(10)
print(f"Linked list after deleting 10: {sll}")  # Expected output: 20->30

# Get the element at index 0
print(f"Element at index 0: {sll.get(0)}")  # Expected output: 20

# Check if the list is empty
print(f"Is the linked list empty? {sll.is_empty()}")  # Expected output: False

# Iterate through the list
print("\nIterating through the linked list:")
for value in sll:
    print(value)  # Expected output: 20, 30

# Create a new singly linked list and insert elements
print("\nCreating a new linked list and inserting values:")
sll = SinglyLinkedList()
sll.insert_in_front(1)
sll.insert_in_front(2)
sll.insert_in_front(3)
print(f"Linked list after inserting 1, 2, 3: {sll}")

# Delete an element from the list
print("\nDeleting element 2 from the linked list:")
sll.delete(2)
print(f"Linked list after deleting 2: {sll}")  # Expected output: 3->1

# Traverse the list and apply a custom function
print("\nApplying custom function to double the values in the list:")
result = sll.traverse(lambda x: x * 2)
print(f"Result after applying function: {result}")  # Expected output: [6, 2]


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BubbleSort17
    set output_file "main.py"

    set template_content '
def bubble_sort_pass1(arr):
    lastElementIndex = len(arr) - 1
    print(0, arr)
    for idx in range(lastElementIndex):
        if arr[idx] > arr[idx + 1]:
            arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
        print(idx + 1, arr)


nums = [5, 1, 4, 2, 8]
bubble_sort_pass1(nums)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.bubble_sort18
    set output_file "main.py"

    set template_content '
def bubble_sort(arr1):
    n = len(arr1)
    for i in range(n):
        for j in range(0, n - i - 1):
            if arr1[j + 1] < arr1[j]:
                arr1[j + 1], arr1[j] = arr1[j], arr1[j + 1]


# Example usage
L = [5, 4, 6, 1, 3, 2, 9, 7]
bubble_sort(L)
print(L)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.InsertionSort19
    set output_file "main.py"

    set template_content '
def insertion_sort(arr):
    for i in range(1, len(arr)):
        j = i - 1
        element_next = arr[i]

        while j >= 0 and arr[j] > element_next:
            arr[j + 1] = arr[j]
            j -= 1

        arr[j + 1] = element_next

    return arr


nums = [9, 5, 1, 4, 3]
print(insertion_sort(nums))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeSort20
    set output_file "main.py"

    set template_content '
def merge_sort(arr, start, end):
    if start < end:
        mid = (start + end) // 2

        merge_sort(arr, start, mid)
        merge_sort(arr, mid + 1, end)
        merge(arr, start, mid, end)


def merge(arr, start, mid, end):
    left = arr[start:mid + 1]
    right = arr[mid + 1:end + 1]

    i = j = 0
    k = start

    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            arr[k] = left[i]
            i += 1
        else:
            arr[k] = right[j]
            j += 1
        k += 1

    while i < len(left):
        arr[k] = left[i]
        i += 1
        k += 1

    while j < len(right):
        arr[k] = right[j]
        j += 1
        k += 1



nums = [38, 27, 43, 3, 9, 82, 10]
merge_sort(nums, 0, len(nums) - 1)
print(nums)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ShellSort21
    set output_file "main.py"

    set template_content '
def shell_sort(arr):
    gap = len(arr) // 2

    while gap > 0:
        for i in range(gap, len(arr)):
            temp = arr[i]
            j = i

            while j >= gap and arr[j - gap] > temp:
                arr[j] = arr[j - gap]
                j -= gap

            arr[j] = temp

        gap //= 2

    return arr

nums = [23, 12, 1, 8, 34, 54, 2, 3]
print(shell_sort(nums))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SelectionSort22
    set output_file "main.py"

    set template_content '
def selection_sort(arr):
    for fill_slot in range(len(arr) - 1, 0, -1):
        max_index = 0
        for location in range(1, fill_slot + 1):
            if arr[location] > arr[max_index]:
                max_index = location

        arr[fill_slot], arr[max_index] = arr[max_index], arr[fill_slot]

    return arr


nums = [64, 25, 12, 22, 11]
print(selection_sort(nums))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.LinearSearch23
    set output_file "main.py"

    set template_content '
index = 0
    found = False

    while index < len(arr) and not found:
        if arr[index] == item:
            found = True
        else:
            index += 1

    return found


nums = [10, 23, 45, 70, 11, 15]
print(linear_search(nums, 70))
print(linear_search(nums, 99))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch24
    set output_file "main.py"

    set template_content '
def binary_search(arr, item):
    first = 0
    last = len(arr) - 1
    found = False

    while first <= last and not found:
        midpoint = (first + last) // 2

        if arr[midpoint] == item:
            found = True
        elif item < arr[midpoint]:
            last = midpoint - 1
        else:
            first = midpoint + 1

    return found


nums = [1, 3, 5, 7, 9, 11, 13]
print(binary_search(nums, 7))
print(binary_search(nums, 8))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InterpolationSearch25
    set output_file "main.py"

    set template_content '
idx0 = 0
    idxn = len(arr) - 1
    found = False

    while idx0 <= idxn and x >= arr[idx0] and x <= arr[idxn]:
        mid = idx0 + int(
            ((idxn - idx0) / (arr[idxn] - arr[idx0])) * (x - arr[idx0])
        )

        if arr[mid] == x:
            found = True
            return found
        elif arr[mid] < x:
            idx0 = mid + 1
        else:
            idxn = mid - 1

    return found


nums = [10, 20, 30, 40, 50, 60, 70, 80]
print(interpolation_search(nums, 50))
print(interpolation_search(nums, 55))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.InterpolationSearch26
    set output_file "main.py"

    set template_content 'def interpolation_search(arr, x):
    idx0 = 0
    idxn = len(arr) - 1
    found = False

    while idx0 <= idxn and x >= arr[idx0] and x <= arr[idxn]:
        mid = idx0 + int(
            ((idxn - idx0) / (arr[idxn] - arr[idx0])) * (x - arr[idx0])
        )

        if arr[mid] == x:
            found = True
            return found
        elif arr[mid] < x:
            idx0 = mid + 1
        else:
            idxn = mid - 1

    return found

nums = [10, 20, 30, 40, 50, 60, 70, 80]
print(interpolation_search(nums, 50))
print(interpolation_search(nums, 55))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SinglyLinkedList27
    set output_file "main.py"

    set template_content 'class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
    
    def __str__(self):
        return str(self.data)

class SinglyLinkedList:
    separator = ' '

    def __init__(self, data=None):
        if data is None:
            self.head = None
        else:
            self.head = Node(data)
    
    def __str__(self):
        nodes = []
        current = self.head
        while current:
            nodes.append(current)
            current = current.next
        return self.separator.join(str(node) for node in nodes)
    
    def __len__(self):
        count = 0
        current = self.head
        while current:
            count += 1
            current = current.next
        return count
    
    def __getitem__(self, key):
        if key < 0 or key >= len(self):
            raise IndexError(\"SinglyLinkedList index out of range\")
        current = self.head
        for _ in range(key):
            current = current.next
        return current.data

    def insertAtBeginning(self, data):
        newnode = Node(data)
        newnode.next = self.head
        self.head = newnode
    
    def insertAtEnd(self, data):
        newnode = Node(data)
        if self.head is None:
            self.head = newnode
        else:
            current = self.head
            while current.next:
                current = current.next
            current.next = newnode
    
    def deleteFromBeginning(self):
        if self.head is None:
            return \"LinkedList is empty\"
        deleted_data = self.head.data
        self.head = self.head.next
        return deleted_data
    
    def deleteFromEnd(self):
        if self.head is None:
            return \"LinkedList is empty\"
        current = self.head
        if current.next is None:
            deleted_data = current.data
            self.head = None
        else:
            while current.next.next:
                current = current.next
            deleted_data = current.next.data
            current.next = None
        return deleted_data
    
    def toList(self):
        current = self.head
        while current:
            yield current.data
            current = current.next
    
    def setSeparator(self, separator=' '):
        self.separator = separator
    
    def getSeparator(self):
        return self.separator
    
    @property
    def isEmpty(self):
        return self.head is None

a = SinglyLinkedList(5)
print(\"Initial list:\", a)
print(\"Length:\", len(a))
print(\"Is Empty:\", a.isEmpty)

# Insert elements at the beginning
a.insertAtBeginning(3)
a.insertAtBeginning(1)
print(\"After insertAtBeginning:\", a)

# Insert elements at the end
a.insertAtEnd(10)
a.insertAtEnd(15)
print(\"After insertAtEnd:\", a)

# Access elements by index
print(\"Element at index 2:\", a[2])

# Delete elements
deleted = a.deleteFromBeginning()
print(\"Deleted from beginning:\", deleted)
print(\"List now:\", a)

deleted = a.deleteFromEnd()
print(\"Deleted from end:\", deleted)
print(\"List now:\", a)

# Convert to Python list
print(\"As Python list:\", list(a.toList()))

# Change separator
a.setSeparator(\" -> \")
print(\"Custom separator:\", a)



print(\"Length:\", len(a)) 
print(\"Is Empty:\", a.isEmpty)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DoublyLinkedList28
    set output_file "main.py"

    set template_content 'class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None
    
    def __str__(self):
        return str(self.data)

class DoublyLinkedList:
    separator = ' '

    def __init__(self, data=None):
        if data is None:
            self.head = self.tail = None
        else:
            self.head = self.tail = Node(data)
    
    def __str__(self):
        nodes = []
        current = self.head
        while current:
            nodes.append(current)
            current = current.next
        return self.separator.join(str(node) for node in nodes)
    
    def __len__(self):
        count = 0
        current = self.head
        while current:
            count += 1
            current = current.next
        return count
    
    def __getitem__(self, key):
        if key < 0 or key >= len(self):
            raise IndexError(\"DoublyLinkedList index out of range\")
        current = self.head
        for _ in range(key):
            current = current.next
        return current.data

    def insertAtBeginning(self, data):
        newnode = Node(data)
        if self.head is None:
            self.head = self.tail = newnode
        else:
            newnode.next = self.head
            self.head.prev = newnode
            self.head = newnode
    
    def insertAtEnd(self, data):
        newnode = Node(data)
        if self.head is None:
            self.head = self.tail = newnode
        else:
            self.tail.next = newnode
            newnode.prev = self.tail
            self.tail = newnode
    
    def deleteFromBeginning(self):
        if self.head is None:
            return \"List is empty\"
        to_delete = self.head
        if self.head.next is None:
            self.head = self.tail = None
        else:
            self.head = self.head.next
            self.head.prev = None
        deleted_data = to_delete.data
        del to_delete
        return deleted_data
    
    def deleteFromEnd(self):
        if self.head is None:
            return \"List is empty\"
        to_delete = self.tail
        if self.tail.prev is None:
            self.head = self.tail = None
        else:
            self.tail = self.tail.prev
            self.tail.next = None
        deleted_data = to_delete.data
        del to_delete
        return deleted_data
    
    def toList(self):
        current = self.head
        while current:
            yield current.data
            current = current.next
    
    def setSeparator(self, separator=' '):
        self.separator = separator
    
    def getSeparator(self):
        return self.separator
    
    @property
    def isEmpty(self):
        return self.head is None

# Example usage
a = DoublyLinkedList()
print(\"Is Empty:\", a.isEmpty)
a.insertAtBeginning(5)
a.insertAtEnd(6)
print(\"First and Last:\", a[0], a[len(a)-1])


a = DoublyLinkedList()

# Check if the list is empty initially
print(\"Is Empty:\", a.isEmpty)  # True

# Insert at the beginning
a.insertAtBeginning(5)
print(\"After insertAtBeginning:\", a)  # 5

# Insert at the end
a.insertAtEnd(6)
print(\"After insertAtEnd:\", a)  # 5 -> 6

# Access elements by index
print(\"Element at index 0:\", a[0])  # 5
print(\"Element at index 1:\", a[1])  # 6

# Delete elements from the beginning
deleted = a.deleteFromBeginning()
print(\"Deleted from beginning:\", deleted)  # 5
print(\"List now:\", a)  # 6

# Delete elements from the end
deleted = a.deleteFromEnd()
print(\"Deleted from end:\", deleted)  # 6
print(\"List now:\", a)  # (empty)

# Re-insert to test more functionality
a.insertAtEnd(8)
a.insertAtEnd(10)
a.insertAtBeginning(3)
print(\"After insertions:\", a)  # 3 -> 8 -> 10

# Convert to Python list
print(\"As Python list:\", list(a.toList()))  # [3, 8, 10]

# Change separator for printing
a.setSeparator(\" -> \")
print(\"Custom separator:\", a)  # 3 <-> 8 <-> 10

# Check empty property
print(\"Is empty now?\", a.isEmpty)  # False

# Delete all elements to check empty list behavior
a.deleteFromBeginning()
a.deleteFromEnd()
print(\"List after deletions:\", a)  # (empty)
print(\"Is empty now?\", a.isEmpty)  # True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearchTree29
    set output_file "main.py"

    set template_content 'class Node:
    def __init__(self, data: int):
        self.data = data
        self.left = None
        self.right = None
    
    def __str__(self):
        return f"{self.data}"

class BinarySearchTree:
    def __init__(self, data=None):
        if data is None:
            self.root = None
        else:
            self.root = Node(data)

    def insert(self, data: int) -> None:
        new_node = Node(data)
        if self.root is None:
            self.root = new_node
            return

        current = self.root
        while True:
            if data <= current.data:
                if current.left is None:
                    current.left = new_node
                    return
                current = current.left
            else:
                if current.right is None:
                    current.right = new_node
                    return
                current = current.right

    def find(self, data: int) -> bool:
        current = self.root
        while current is not None:
            if current.data == data:
                return True
            elif data < current.data:
                current = current.left
            else:
                current = current.right
        return False

    def inorder(self, node=None):
        if node is None:
           return []
        return (
        self.inorder(node.left)
        + [node.data]
        + self.inorder(node.right)
    )



if __name__ == '__main__':
    tree = BinarySearchTree(23)
    tree.insert(20)
    tree.insert(30)
    tree.insert(10)
    tree.insert(15)
    print("order:", tree.inorder(tree.root))
    print("Find 15:", tree.find(15))
    print("Find 25:", tree.find(25))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.FindMax30
    set output_file "main.py"

    set template_content '
from typing import List

def find_max(L):
    if len(L) == 1:
        return L[0]
    else:
        rest = find_max(L[1:])
        return L[0] if L[0] > rest else rest


if __name__ == "__main__":
    numbers = [2, 3, 4, 5, 6]
    result = find_max(numbers)

    print("List:", numbers)
    print("Maximum:", result)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.FindMax31
    set output_file "main.py"

    set template_content '
def find_max(arr, n):
    max1 = arr[0]  
    for i in range(1, n): 
        if arr[i] > max1:
            max1 = arr[i]
    return max1

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Max:', find_max(arr, n))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.FindMin32
    set output_file "main.py"

    set template_content '
def find_min(arr, n):
    min1 = arr[0]  
    for i in range(1, n):  
        if arr[i] < min1:
            min1 = arr[i] 
    return min1

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Min:', find_min(arr, n))  
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_sum33
    set output_file "main.py"

    set template_content '
def find_sum(arr, n):
    sum1 = 0
    for i in range(n):
        sum1 += arr[i]
    return sum1

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Sum:', find_sum(arr, n))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_prod34
    set output_file "main.py"

    set template_content '
def find_prod(arr, n):
    prod1 = 1
    for i in range(n):
        prod1 *= arr[i]
    return prod1

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Product:', find_prod(arr, n))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.linear_search35
    set output_file "linear_search_Python.py"

    set template_content "
# Function to perform linear search on the array
def linear_search(arr, n, item):
    flag = 0
    for i in range(n):
        if arr[i] == item:  # Check if the item matches the element
            print('Found at index:', i)
            flag = 1
            break  # Exit the loop once the item is found
    if flag == 0:
        print('Not found')

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

linear_search(arr, n, 7)  # Output: Found at index: 1
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_mean36
    set output_file "find_mean_Python.py"

    set template_content "
# Function to find the mean of the array
def find_mean(arr, n):
    sum1 = find_sum(arr, n)
    mean1 = sum1 / n  # Calculate mean as sum of elements divided by number of elements
    return mean1

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Mean:', find_mean(arr, n))  # Output: Mean: 4.5
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_median37
    set output_file "main.py"

    set template_content '
def find_median(arr, n):
    arr1 = sorted(arr)  
    print(arr1)
    if n % 2 != 0:  
        return arr1[n // 2]
    else:
        return (arr1[(n // 2) - 1] + arr1[n // 2]) / 2

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Median:', find_median(arr, n))  # Output: Median: 4
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_quartiles38
    set output_file "main.py"

    set template_content '
def find_quartiles(arr, n):
    arr1 = sorted(arr) 
    print(arr1)
    q1 = arr1[(n + 1) 
    q3 = arr1[3 * (n + 1)
    return q1, q3

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Quartiles:', find_quartiles(arr, n))  
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_quart_devition39
    set output_file "main.py"

    set template_content '
def find_quart_devition(arr, n):
    q1, q3 = find_quartiles(arr, n)
    qd = q3 - q1
    return qd

arr = [5, 7, 1, 3, 9, 2]
n = len(arr)

print('Quartile Deviation:', find_quart_devition(arr, n))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.move_odds_to_front40
    set output_file "main.py"
    
    set template_content '
import numpy as np

def move_odds_to_front(arr):
    k = 0
    arr1 = np.zeros(arr.shape[0])

    for i in range(arr.shape[0]):
        if arr[i] % 2 != 0:  
            arr1[k] = arr[i]
            k += 1

    for i in range(arr.shape[0]):
        if arr[i] % 2 == 0: 
            arr1[k] = arr[i]
            k += 1

    return arr1

arr = np.array([2, 4, 6, 7, 10, 3, 8, 5])
print('Original array:', arr)
arr1 = move_odds_to_front(arr)
print('Array after moving odd numbers to the front:', arr1)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_pairs_with_sum41
    set output_file "main.py"
    
    set template_content '
import numpy as np

def find_pairs_with_sum(arr, val):
    L = [] 
    for i in range(arr.shape[0]):
        for j in range(i + 1, arr.shape[0]):
            if arr[i] + arr[j] == val:
                L.append((arr[i], arr[j]))
    L = set(L)
    return L

arr = np.array([1, 2, 3, 4, 5, 6, 7])
val = 8
print('Pairs with sum equal to', val, ':', find_pairs_with_sum(arr, val))
'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.array_wave42
    set output_file "main.py"
    
    set template_content '
import numpy as np

def wave(arr, n):
    if n == 0 or n == 1: 
        return arr
    else:
        arr = np.sort(arr)  
        if n % 2 == 0:
            for i in range(0, n, 2):
                arr[i + 1], arr[i] = arr[i], arr[i + 1]
        else:
            for i in range(0, n - 1, 2):
                arr[i + 1], arr[i] = arr[i], arr[i + 1]
        return arr

arr = [1, 5, 3, 4, 2]
n = len(arr)
print('Original Array:', arr)
arr = wave(arr, n)
print('Wave Array:', arr)
'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.array_wave43
    set output_file "main.py"
    
    set template_content '
def wave_temp(arr):
    a = arr[0]
    b = arr[1]
    c = arr[2]
  
    if(a < b and a < c and b < c):
        arr[0], arr[1] = arr[1], arr[0]
  
    elif(a < b and b > c and a < c):
        arr[0], arr[1], arr[2] = c, a, b
    
    elif(a > b and a < c and b < c):
        pass
   
    elif(a < b and a > c and b > c):
        arr[0], arr[1], arr[2] = a, c, b
   
    elif(a > b and a > c and b < c):
        arr[0], arr[1], arr[2] = c, b, a
   
    elif(a > b and a > c and b > c):
        arr[0], arr[1], arr[2] = b, c, a
    return arr

def wave1(arr, n):
    if n == 0 or n == 1:
        return arr
    elif n == 2:
        if arr[1] > arr[0]:
            arr[0], arr[1] = arr[1], arr[0]
        return arr
    elif n == 3:
        arr = wave_temp(arr)
    if n >= 5:
        arr[:3] = wave_temp(arr[:3])
        i = 2
        while i + 3 < n:
            d = arr[i]
            if d > arr[i+1]:
                arr[i+1], arr[i] = arr[i], arr[i+1]
            arr[i:i+3] = wave_temp(arr[i:i+3])
            i += 2
        else:
            if i + 2 < n:
                if arr[i+1] > arr[i]:
                    arr[i], arr[i+1] = arr[i+1], arr[i]
            if (n % 2 != 0) and (arr[n-1] > arr[n-2]):
                arr[n-1], arr[n-2] = arr[n-2], arr[n-1]
    return arr

arr = [1, 5, 3, 4, 2]
n = len(arr)
print("Original Array:", arr)
arr = wave1(arr, n)
print("Wave Array:", arr)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.linked_list_operations44
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
    
    def display_node(self):
        print(self.data, end='')

class LinkedList:
    def __init__(self, data1):
        self.first = Node(data1)
    
    def insert_beg(self, data):
        temp = Node(data)
        temp.next = self.first
        self.first = temp
    
    def display(self):
        print('List:', end='')
        ptr = self.first
        while(ptr != None):
            ptr.display_node()
            ptr = ptr.next
        print()
    
    def insert_end(self, data):
        temp = Node(data)
        ptr = self.first
        while(ptr.next != None):
            ptr = ptr.next
        ptr.next = temp
    
    def insert_after(self, data, data1):
        flag = 0
        temp = Node(data)
        ptr = self.first
        while(ptr != None):
            if(ptr.data == data1):
                flag = 1
                break
            ptr = ptr.next
        if(flag == 0):
            print('Search Failed!')
        else:
            temp.next = ptr.next
            ptr.next = temp
    
    def del_first(self):
        if(self.first != None):
            temp1 = self.first.data
            self.first = self.first.next
            return temp1
        else:
            print('Underflow')
    
    def del_end(self):
        ptr = self.first
        if(ptr == None):
            print('Underflow')
        elif(ptr.next == None):
            temp1 = ptr.data
            self.first = None
            return temp1
        else:
            while(ptr.next.next != None):
                ptr = ptr.next
            temp1 = ptr.next.data
            ptr.next = None
            return temp1
    
    def del_after(self, data1):
        if(self.first == None):
            print('Underflow')
        else:
            flag = 0
            ptr = self.first
            while(ptr != None):
                if(ptr.data == data1):
                    flag = 1
                    break
                ptr = ptr.next
            if(flag == 0):
                print('Search Failed')
            else:
                if(ptr.next == None):
                    print('Nothing after', data1)
                else:
                    temp1 = ptr.next.data
                    ptr.next = ptr.next.next
                    return temp1

linked_list = LinkedList(10)
linked_list.insert_beg(5)
linked_list.insert_end(15)
linked_list.insert_after(12, 10)

linked_list.display()

# Delete operations
print("Deleted First:", linked_list.del_first())
linked_list.display()

print("Deleted Last:", linked_list.del_end())
linked_list.display()

print("Deleted After 10:", linked_list.del_after(10))
linked_list.display()  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.doubly_linked_list_operations45
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
        self.prev = None

    def display_node(self):
        print(self.data, end="")

class DoublyLinkedList:
    def __init__(self, data1):
        self.first = Node(data1)

    def insert_beg(self, data):
        temp = Node(data)
        temp.next = self.first
        self.first.prev = temp
        self.first = temp

    def display(self):
        print("List:", end="")
        ptr = self.first
        while ptr != None:
            ptr.display_node()
            ptr = ptr.next
        print()

    def insert_end(self, data):
        temp = Node(data)
        ptr = self.first
        while ptr.next != None:
            ptr = ptr.next
        ptr.next = temp
        temp.prev = ptr

    def insert_after(self, data, data1):
        flag = 0
        temp = Node(data)
        ptr = self.first
        while ptr != None:
            if ptr.data == data1:
                flag = 1
                break
            ptr = ptr.next
        if flag == 0:
            print("Search Failed")
        else:
            temp.next = ptr.next
            if ptr.next != None:
                ptr.next.prev = temp
            ptr.next = temp
            temp.prev = ptr

    def del_first(self):
        if self.first != None:
            temp1 = self.first.data
            self.first = self.first.next
            if self.first != None:
                self.first.prev = None
            return temp1
        else:
            print("Underflow")

    def del_end(self):
        ptr = self.first
        if ptr == None:
            print("Underflow")
        elif ptr.next == None:
            temp1 = ptr.data
            self.first = None
            return temp1
        else:
            while ptr.next != None:
                ptr = ptr.next
            temp1 = ptr.data
            ptr.prev.next = None
            return temp1

    def del_after(self, data1):
        if self.first == None:
            print("Underflow")
        else:
            flag = 0
            ptr = self.first
            while ptr != None:
                if ptr.data == data1:
                    flag = 1
                    break
                ptr = ptr.next
            if flag == 0:
                print("Search Failed")
            else:
                if ptr.next == None:
                    print("Nothing after", data1)
                else:
                    temp1 = ptr.next.data
                    ptr.next = ptr.next.next
                    if ptr.next != None:
                        ptr.next.prev = ptr
                    return temp1

dll = DoublyLinkedList(10)
dll.insert_beg(5)
dll.insert_end(15)
dll.insert_after(12, 10)

dll.display()
print("Deleted First:", dll.del_first())
dll.display()

print("Deleted Last:", dll.del_end())
dll.display()

print("Deleted After 10:", dll.del_after(10))
dll.display()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.stack_operations46
    set output_file "main.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

    def display_node(self):
        print(self.data, end="")

class Stack:
    def __init__(self, data1):
        self.first = Node(data1)

    def display(self):
        print("Stack:", end="")
        ptr = self.first
        while ptr is not None:
            ptr.display_node()
            ptr = ptr.next
        print()

    def insert_end(self, data):
        temp = Node(data)
        ptr = self.first
        while ptr.next is not None:
            ptr = ptr.next
        ptr.next = temp

    def del_end(self):
        ptr = self.first
        if ptr is None:
            print("Underflow")
        elif ptr.next is None:
            temp1 = ptr.data
            self.first = None
            return temp1
        else:
            while ptr.next.next is not None:
                ptr = ptr.next
            temp1 = ptr.next.data
            ptr.next = None
            return temp1

s = Stack(34)
s.insert_end(45)
s.insert_end(56)
s.insert_end(67)
s.insert_end(78)

s.display()

temp1 = s.del_end()
print("Popped:", temp1)

temp1 = s.del_end()
print("Popped:", temp1)

s.display()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.stack_operations47
    set output_file "main.py"

    set template_content '
def push(S, item, top, MAX):
    if top == MAX - 1:
        print('Overflow')
        return top
    else:
        top += 1
        S.append(item)
        return top

def pop(S, top, MAX):
    if top == -1:
        return (-1, -1)
    else:
        temp = S[top]  
        top -= 1  
        del S[-1]
        return (temp, top)

def disp(S, top):
    print("Stack:")
    for i in range(top + 1):
        print(S[i], end="")
    print()

def init():
    S = []
    MAX = 5 
    top = -1
    return S, MAX, top

S, MAX, top = init()

while True:
    print("1\\t:Push")
    print("2\\t:Pop")
    print("3\\t:Traverse")
    print("4\\t:Exit")

    ch = int(input("Enter your choice\\t:"))

    if ch == 1:
        item = int(input("Enter item\\t:"))
        top = push(S, item, top, MAX)

    elif ch == 2:
        val, top = pop(S, top, MAX)
        if top == -1:
            print("Underflow") 
        else:
            print("Popped item", val)
    elif ch == 3:
        disp(S, top)
    elif ch == 4:
        print("Program ends")
        break 
    else:
        print("Incorrect input")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.two_stack_operations48
    set output_file "main.py"

    set template_content '
def push1(S, item, top1, top2, MAX):
    if top1 + 1 == top2:
        print("Overflow")
        return top1
    else:
        top1 += 1
        S[top1] = item
        return top1

def push2(S, item, top1, top2, MAX):
    if top1 + 1 == top2:
        print("Overflow")
        return top2
    else:
        top2 -= 1
        S[top2] = item
        return top2

def pop1(S, top1, top2, MAX):
    if top1 == -1:
        return (-1, -1)
    else:
        temp = S[top1]
        S[top1] = 0
        top1 -= 1
        return (temp, top1)

def pop2(S, top1, top2, MAX):
    if top2 == MAX:
        return (-1, -1)  
    else:
        temp = S[top2]
        S[top2] = 0 
        top2 += 1
        return (temp, top2)

def disp(S):
    print("Stack1:", end="")
    for i in range(len(S)):
        if S[i] != 0:
            print(S[i], end="")
    print()

def init():
    MAX = 5
    S = MAX * [0]
    top1 = -1
    top2 = MAX
    return S, MAX, top1, top2

S, MAX, top1, top2 = init() 

while True:
    print("1\\t:Push in Stack1")
    print("2\\t:Pop from Stack1")
    print("3\\t:Push in Stack2")
    print("4\\t:Pop from Stack2")
    print("5\\t:Traverse")
    print("6\\t:Exit")

    ch = int(input("Enter your choice\\t:"))

    if ch == 1:
        item = int(input("Enter item\\t:"))
        top1 = push1(S, item, top1, top2, MAX)

    elif ch == 2:
        val, top1 = pop1(S, top1, top2, MAX)
        if top1 == -1:
            print("Underflow")
        else:
            print("Popped item:", val) 

    elif ch == 3:
        item = int(input("Enter item\\t:"))  
        top2 = push2(S, item, top1, top2, MAX)

    elif ch == 4:
        val, top2 = pop2(S, top1, top2, MAX)
        if top2 == MAX:
            print("Underflow")
        else:
            print("Popped item:", val)

    elif ch == 5:
        disp(S)

    elif ch == 6:
        print("Program ends")  
        break  

    else:
        print("Incorrect input")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.CountingSort49
    set output_file "main.py"

    set template_content 'input1 = [2, 14, 3, 5, 8, 2, 6, 3, 2]

max1 = max(input1)
count = [0] * (max1 + 1)
for i in input1:
    count[i - 1] += 1 
for i in range(1, len(count)):
    count[i] += count[i - 1]

final = [0] * len(input1)

for i in range(len(input1) - 1, -1, -1):
    final[count[input1[i] - 1] - 1] = input1[i]
    count[input1[i] - 1] -= 1

print(final)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SelectionSort50
    set output_file "main.py"

    set template_content 'def sel_sort(arr1):
    n = len(arr1)
    for i in range(n):
        for j in range(i + 1, n):
            if arr1[j] < arr1[i]:
                arr1[i], arr1[j] = arr1[j], arr1[i]


L = [5, 4, 6, 1, 3, 2, 9, 7]
sel_sort(L)
print(L)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SelectionSortNumpy51
    set output_file "main.py"

    set template_content 'import numpy as np

def sel_sort1(arr1):
    n = arr1.shape[0] 
    for i in range(n - 1):
        m1 = np.argmin(arr1[i+1:]) + i + 1
        if arr1[m1] < arr1[i]:
            temp = arr1[i]
            arr1[i] = arr1[m1]
            arr1[m1] = temp

arr = np.array([5, 4, 6, 1, 3, 2, 9, 7])
sel_sort1(arr)
print(arr)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RadixSort52
    set output_file "main.py"

    set template_content 'import math
input1 = [2, 14, 3, 65, 8, 78, 900, 32, 11]

n = max(input1)
d1 = math.floor(math.log10(n)) + 1
for d in range(d1):
    L = [[] for _ in range(10)]
    for num in input1:
        p = (num // (10 ** d)) % 10
        L[p].append(num)
    input1 = [num for bucket in L for num in bucket]

print(input1)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Merge53
    set output_file "main.py"

    set template_content 'def merge(L1, L2):
    L = [] 
    n1 = len(L1)
    n2 = len(L2)

    i = 0 
    j = 0 
    k = 0

    while i < n1 and j < n2:
        if L1[i] < L2[j]:
            L.append(L1[i])
            i += 1
            k += 1
        elif L2[j] < L1[i]:
            L.append(L2[j])
            j += 1
            k += 1
        else:
            L.append(L1[i])
            i += 1
            j += 1
            k += 1

    while i < n1:
        L.append(L1[i])
        i += 1
        k += 1

    while j < n2:
        L.append(L2[j])
        j += 1
        k += 1

    return L
print(merge([1, 3, 5], [2, 4, 6]))

print(merge([1, 2, 2], [2, 3]))

print(merge([], [1, 2]))

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MergeSort54
    set output_file "main.py"

    set template_content 'def merge(L1, L2):
    L = [] 
    n1 = len(L1)
    n2 = len(L2)

    i = 0  
    j = 0 
    k = 0

    while i < n1 and j < n2:
        if L1[i] < L2[j]:
            L.append(L1[i])
            i += 1
        elif L2[j] < L1[i]:
            L.append(L2[j])
            j += 1
        else: 
            L.append(L1[i])
            i += 1
            j += 1

    while i < n1:
        L.append(L1[i])
        i += 1

    while j < n2:
        L.append(L2[j])
        j += 1

    return L  


def mergesort(L):
    if len(L) <= 1: 
        return L
    else:
        mid = len(L) // 2
        L1 = mergesort(L[:mid])
        L2 = mergesort(L[mid:])

        L_ = merge(L1, L2)
        return L_

if __name__ == "__main__":
    arr = [5, 2, 9, 1, 5, 6]
    print("Original:", arr)
    print("Sorted:", mergesort(arr))
    print(mergesort([3, 2, 1]))
    print(mergesort([4, 4, 4]))
    print(mergesort([]))
    print(mergesort([10]))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.Partition55
    set output_file "main.py"

    set template_content 'def partition(L):
    if L == []:
        return 0
    
    low = 0
    high = len(L) - 1
    pivot = L[high]
    
    i = low - 1
    
    for j in range(low, high):
        if L[j] < pivot:
            i += 1
            L[i], L[j] = L[j], L[i]
    
    L[i + 1], L[high] = L[high], L[i + 1]
    
    return i + 1

L = [10, 80, 30, 90, 40, 50, 70]
idx = partition(L)
print(L)
print(idx)

L = [1, 2, 3, 4, 5]
partition(L)
print(L)

L = [5, 4, 3, 2, 1]
partition(L)
print(L)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Rearrange56
    set output_file "main.py"

    set template_content 'import numpy as np

def rearrange(arr):
    num_last_col = len(arr) % 5
    remaining_arr = arr[:len(arr) - num_last_col]

    arr1 = np.reshape(remaining_arr, (len(remaining_arr)//5, 5))
    arr1 = arr1.T
    print("Initial matrix:")
    print(arr1)

    if num_last_col != 0:
        up = (5 - num_last_col) // 2
        arr3 = arr[len(remaining_arr):]
        arr3 = np.sort(arr3)

        last_col = (
            [0] * up +
            list(arr3) +
            [0] * (5 - len(arr3) - up)
        )

        print("Last column:")
        print(last_col)

        arr1 = np.hstack((arr1, np.array(last_col).reshape(5, 1)))
        print("After adding last column:")
        print(arr1)

    arr1 = np.sort(arr1, axis=0)
    print("Column-wise sorted:")
    print(arr1)

    arr2 = np.sort(arr1[arr1.shape[0] // 2, :])
    print("Middle row sorted:")
    print(arr2)

    if arr2.shape[0] % 2 == 0:
        median = (arr2[arr2.shape[0]//2 - 1] +
                  arr2[arr2.shape[0]//2]) / 2
    else:
        median = arr2[arr2.shape[0]//2]

    print("Median:", median)


arr = [2, 7, 6, 8, 10, 1, 3, 5, 4, 9, 11, 15]
print(arr)
rearrange(arr)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMedianHeap57
    set output_file "main.py"

    set template_content 'from heapq import heappush, heappop

def FindMedian_Heap(arr, N):
    if N == 0:
        return

    heapL = []
    heapR = []

    heappush(heapL, -arr[0])
    print("Median:", arr[0])
    print("Left:", heapL)
    print("Right:", heapR)
    print()

    for i in range(1, N):
        x = arr[i]

        if x <= -heapL[0]:
            heappush(heapL, -x)
        else:
            heappush(heapR, x)

        if len(heapL) > len(heapR) + 1:
            heappush(heapR, -heappop(heapL))
        elif len(heapR) > len(heapL):
            heappush(heapL, -heappop(heapR))

        if len(heapL) > len(heapR):
            median = -heapL[0]
        else:
            median = (-heapL[0] + heapR[0]) / 2

        print("Median:", median)
        print("Left :", heapL)
        print("Right:", heapR)
        print()


if __name__ == '__main__':
    arr = [14, 17, 21, 89, 2, 3, 78, 90, 23, 90, 12, 65, 23]
    n = len(arr)
    FindMedian_Heap(arr, n)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMedianQuickselect58
    set output_file "main.py"

    set template_content 'def partition(l, r, arr):
    pivot = arr[r]
    ptr = l

    for i in range(l, r):
        if arr[i] <= pivot:
            arr[i], arr[ptr] = arr[ptr], arr[i]
            ptr += 1

    arr[ptr], arr[r] = arr[r], arr[ptr]
    return ptr


def FindMedian(arr):
    l = 0
    r = len(arr) - 1
    mid = len(arr) // 2

    while True:
        ptr = partition(l, r, arr)

        if ptr == mid:
            print("Median:", arr[ptr])
            break
        elif ptr < mid:
            l = ptr + 1
        else:
            r = ptr - 1

        print('l =', l, 'r =', r, 'ptr =', ptr)


if __name__ == '__main__':
    arr = [2, 4, 6, 8, 10, 1, 3, 5, 7, 9]
    FindMedian(arr)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountDuplicates59
    set output_file "main.py"

    set template_content 'import numpy as np

arr = np.random.randint(1, 100, 200)
count1 = {}
i = 0
arr2 = np.copy(arr)

for x in arr2:
    if x == -1:
        i += 1
        continue

    for j in range(i + 1, arr2.shape[0]):
        item = arr2[j]

        if item == x:
            if x in count1:
                count1[x] += 1
            else:
                count1[x] = 1

            arr2[j] = -1
            print(j)

    i += 1

print("Counts:", count1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountDuplicates_Unique60
    set output_file "CountDuplicates_Unique.py"

    set template_content "import numpy as np

arr = np.random.randint(1, 100, 200)
values, counts = np.unique(arr, return_counts=True)

count = dict(zip(values, counts))
print(count)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountDuplicates_Counter61
    set output_file "main.py"

    set template_content 'from collections import Counter
import numpy as np

arr = np.random.randint(1, 100, 200)
count = Counter(arr)

print(count)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountDuplicates_Sort62
    set output_file "main.py"

    set template_content 'import numpy as np

arr = np.random.randint(1, 100, 200)
arr1 = np.sort(arr)

count = {}
count[arr1[0]] = 1

for i in range(1, arr1.shape[0]):
    if arr1[i] == arr1[i - 1]:
        count[arr1[i]] += 1
    else:
        count[arr1[i]] = 1

print(count)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CountDuplicates_Hash63
    set output_file "main.py"

    set template_content 'import numpy as np
from collections import defaultdict

arr = np.random.randint(1, 100, 200)

table1 = defaultdict(int)
count2 = {}

for x in arr:
    index = hash(x) % arr.shape[0]

    if x not in count2:
        table1[index] = x
        count2[x] = 1
    else:
        count2[x] += 1

print("Hash Table:", dict(table1))
print("Counts:", count2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CompareArrays_Hash64
    set output_file "main.py"

    set template_content 'import numpy as np
from collections import defaultdict

X = np.random.randint(1, 100, 200)
Y = np.random.randint(1, 100, 200)

table1 = defaultdict(int)
countX = {}
countY = {}

for x in X:
    index = hash(x) % X.shape[0]
    if x not in table1:
        table1[index] = x
        countX[x] = 1
    else:
        countX[x] += 1

for y in Y:
    if y in table1:
        if y in countY:
            countY[y] += 1
        else:
            countY[y] = 1
    else:
        print('Not same')

if countX == countY:
    print("Same")
else:
    print("Different")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.HashTables_Offset65
    set output_file "main.py"

    set template_content 'import numpy as np
from collections import defaultdict

X = np.random.randint(1, 100, 200)
Y = np.random.randint(1, 100, 200)

tableX = defaultdict(int)
for x in X:
    index = hash(x) % X.shape[0]
    if x not in tableX:
        tableX[x] = index  # store value as key, index as value

tableY = defaultdict(int)
for y in Y:
    index = hash(y) % Y.shape[0]
    if y not in tableY:
        tableY[y] = index  # store value as key, index as value

k = 50
for x in tableX:
    if k + x in tableY:
       print('\(', x, ',', k + x, '\)')

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MatchBruteForce66
    set output_file "main.py"

    set template_content 'def matchBrute(T, P):
    n = len(T)
    m = len(P)
    for i in range(n - m + 1):
        j = 0
        while j < m:
            if T[i + j] != P[j]:
                break
            j += 1
        if j == m:
            print('Match at', i)

T = 'babbababbababbabbab'
P = 'abba'
matchBrute(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HashPatternMatch67
    set output_file "main.py"

    set template_content 'def findHash(P):
    h = 0
    for i in P:
        h += ord(i)
    return h

def findHash1(P):
    h = 0
    j = 0
    for i in P:
        h += ord(i) * (2 ** j)
        j += 1
    return h

def findPattern(T, P):
    h2 = findHash(P)
    for i in range(len(T) - len(P) + 1):
        str1 = T[i:i+len(P)]
        h1 = findHash(str1)
        if h1 == h2:
            print("Hit at", i)

T = "aabbbaababbababbaab"
P = "abab"
findPattern(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.HashPatternMatchWeighted68
    set output_file "main.py"

    set template_content 'def findHash1(P):
    h = 0
    j = 0
    for i in P:
        h += ord(i) * (2 ** j)
        j += 1
    return h

def findPattern(T, P):
    h2 = findHash1(P)
    for i in range(len(T) - len(P) + 1):
        str1 = T[i:i+len(P)]
        h1 = findHash1(str1)
        if h1 == h2:
            print("Hit at", i)

T = "aabbbaababbababbaab"
P = "abab"
findPattern(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ComputePi69
    set output_file "main.py"

    set template_content 'def computePi(P, Pi):
    l = 0
    m = len(P)
    Pi[0] = 0
    i = 1

    while i < m:
        print("i =", i, ", l =", l, ", P[i] =", P[i], ", P[l] =", P[l])
        if P[i] == P[l]:
            print("\\tP[i] = P[l] =", P[i], "; Increment l, set Pi[i] = l, then increment i")
            l += 1
            Pi[i] = l
            i += 1
        else:
            if l != 0:
                print("\\tP[i] != P[l] =", P[i], "!=", P[l], "; l != 0, set l = Pi[l-1] =", Pi[l-1])
                l = Pi[l-1]
            else:
                print("\\tP[i] != P[l] =", P[i], "!=", P[l], "; l = 0, set Pi[i] = 0, increment i")
                Pi[i] = 0
                i += 1


P = "abaababb"
Pi = [0] * len(P)
computePi(P, Pi)
print("Pi array:", Pi)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KMPMatch70
    set output_file "main.py"

    set template_content 'def computePi(P, Pi):
    l = 0
    m = len(P)
    Pi[0] = 0
    i = 1
    while i < m:
        if P[i] == P[l]:
            l += 1
            Pi[i] = l
            i += 1
        else:
            if l != 0:
                l = Pi[l-1]
            else:
                Pi[i] = 0
                i += 1

def KMP(T, P):
    m = len(P)
    n = len(T)
    Pi = [0] * m
    computePi(P, Pi)
    print("Pi array:", Pi)

    i = 0  
    j = 0 

    while (n - i) >= (m - j):
        print("i =", i, "j =", j, "T[i] =", T[i], "P[j] =", P[j])
        if P[j] == T[i]:
            print("  Match: P[j] = T[i], increment i and j")
            i += 1
            j += 1
            if j == m:
                print("  Found pattern at", i - j)
                j = Pi[j-1]
        else:
            if j != 0:
                print("  Mismatch: j != 0, set j = Pi[j-1] =", Pi[j-1])
                j = Pi[j-1]
            else:
                print("  Mismatch: j = 0, increment i")
                i += 1

T = "babbababbababbabbab"
P = "abba"
KMP(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MatchBruteForce71
    set output_file "main.py"

    set template_content 'def matchBrute(T, P):
    n = len(T)
    m = len(P)
    for i in range(n - m + 1):
        j = 0
        while j < m:
            if T[i + j] != P[j]:
                break
            j += 1
        if j == m:
            print("Match at", i)

T = "babbababbababbabbab"
P = "abba"
matchBrute(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SubstringSearch72
    set output_file "main.py"

    set template_content 'def findPattern(P, T):
    m = len(P)
    original_T = T  
    offset = 0  

    while len(T) >= m:
        try:
            index = T.index(P[0])
        except ValueError:
            break
        if T[index:index+m] == P:
            print('Found at', offset + index)
            T = T[index + 1:]
            offset += index + 1
        else:
            T = T[index + 1:]
            offset += index + 1

P = "defg"
T = "abcdefghdj"
findPattern(P, T)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.HashPatternSearch73
    set output_file "main.py"

    set template_content 'def findHash(P):
    h = 0
    for i in P:
        h += ord(i)
    return h

def findHash1(P):
    h = 0
    j = 0
    for i in P:
        h += ord(i) * (2 ** j)
        j += 1
    return h

def findPattern(T, P):
    h2 = findHash1(P)
    m = len(P)
    for i in range(len(T) - m + 1):
        str1 = T[i:i+m]
        h1 = findHash1(str1)
        if h1 == h2:
            print("Hit at", i)

T = "aabbbaababbababbaab"
P = "abab"
findPattern(T, P)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FloydWarshall74
    set output_file "main.py"

    set template_content 'def floyd_warshall(graph):
    n = len(graph)
    dist = [row[:] for row in graph]
    
    for k in range(n):
        for i in range(n):
            for j in range(n):
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
    return dist

INF = float("inf")
graph = [
    [0, 3, INF, 7],
    [8, 0, 2, INF],
    [5, INF, 0, 1],
    [2, INF, INF, 0]
]

shortest_paths = floyd_warshall(graph)
for row in shortest_paths:
    print(row)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.WordOccurrence75
    set output_file "main.py"

    set template_content 'from collections import defaultdict

def word_occurrence(sentence: str) -> dict:
    occurrence: defaultdict = defaultdict(int)
    for word in sentence.split():
        occurrence[word] += 1
    return occurrence


if __name__ == "__main__":
    test_sentence = "a b A b c b d b d e f e g e h e i e j e 0"
    for word, count in word_occurrence(test_sentence).items():
        print(f"{word}: {count}")

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RegexMatch76
    set output_file "main.py"

    set template_content '


def match_pattern(input_string: str, pattern: str) -> bool:
    len_string = len(input_string) + 1
    len_pattern = len(pattern) + 1

    dp = [[0 for i in range(len_pattern)] for j in range(len_string)]
    dp[0][0] = 1

    for i in range(1, len_string):
        dp[i][0] = 0

    for j in range(1, len_pattern):
        dp[0][j] = dp[0][j - 2] if pattern[j - 1] == "*" else 0

    for i in range(1, len_string):
        for j in range(1, len_pattern):
            if input_string[i - 1] == pattern[j - 1] or pattern[j - 1] == ".":
                dp[i][j] = dp[i - 1][j - 1]
            elif pattern[j - 1] == "*":
                if dp[i][j - 2] == 1:
                    dp[i][j] = 1
                elif pattern[j - 2] in (input_string[i - 1], "."):
                    dp[i][j] = dp[i - 1][j]
                else:
                    dp[i][j] = 0
            else:
                dp[i][j] = 0

    return bool(dp[-1][-1])


if __name__ == \"__main__\":
    import doctest
    doctest.testmod()

    input_string = \"aab\"
    pattern = \"c*a*b\"

    if match_pattern(input_string, pattern):
        print(f\"{input_string} matches the given pattern {pattern}\")
    else:
        print(f\"{input_string} does not match with the given pattern {pattern}\")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end








function algoP.generate_brute_force_file77
    set output_file "main.py"

    set template_content '
def brute_force_duplicate_search(array):
    for i in range(len(array)-1):
        for j in range(i+1,len(array)):
            if array[i] == array[j]:
                return True
    return False

array = [1,2,46,32,98,61,34,46]
print(brute_force_duplicate_search(array))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_better_duplicate_file78
    set output_file "main.py"

    set template_content '
def better_duplicate_search(array):
    array.sort()
    for i in range(len(array)-1):
        if array[i] == array[i+1]:
            return True
    return False

array = [1,2,46,32,98,61,34,46]
print(better_duplicate_search(array))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.generate_smart_duplicate_file79
    set output_file "main.py"

    set template_content '
def smart_duplicate_search(array):
    dictionary = dict()
    if len(array) < 2:
        return False
    else:
        for i in range(len(array)):
            if array[i] in dictionary:
                return True
            else:
                dictionary[array[i]] = True
    return False

array = [1,2,46,32,98,61,34,46]
print(smart_duplicate_search(array))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.GenerateArrayFile80
    set output_file "main.py"
    set template_content '
class my_array():
    def __init__(self):
        self.length = 0 
        self.data = {} 

    def __str__(self):
        print(self.data.values())
        return str(self.__dict__) 

    def get(self, index):
        return self.data[index]

    def push(self, item):
        self.length += 1
        self.data[self.length - 1] = item

    def pop(self):
        last_item = self.data[self.length-1] 
        del self.data[self.length - 1] 
        self.length -= 1
        return last_item

    def insert(self, index, item):
        self.length += 1
        for i in range(self.length-1, index, -1):
            self.data[i] = self.data[i-1] 
        self.data[index] = item

    def delete(self, index):
        for i in range(index, self.length-1):
            self.data[i] = self.data[i+1]
        del self.data[self.length - 1]
        self.length -= 1

arr = my_array()
print(arr)
arr.push(6)
print(arr)  
arr.push(2)
print(arr)  
arr.push(9)
print(arr)  
arr.pop()
arr.push(45)
print(arr)  
arr.push(12)
print(arr)  
arr.push(67)
print(arr)  
arr.insert(3, 10)
print(arr)  
arr.delete(4)
print(arr)  
print(arr.get(1)) 
print(arr)  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.generate_array_operations_file81
    set output_file "main.py"
    set template_content '

array = [5,8,2,9,17,43,25,10]

first_element = array[0]  
sixth_element = array[5]
array.pop()
print(array)
print(array)

array.pop(0) 
print(array)
array.remove(17)
print(array)
del array[2:4]
print(array)
array.insert(11, "shushrut")
print(array)

l = [5,8,2,9,17,43,25,10]
print(len(l))
l.insert(9, "shushrut")
len = len(l)
print(len)

a = 15
b = 15
c = 300
d = 300
print(a is b, c is d)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.generate_max_subarray_file82
    set output_file "main.py"

    set template_content '

def brute_force_max_subarray(array):
    maximum = 0 
    if len(array) == 0:
        return None
    for i in range(len(array)):
        cum_sum = 0  
        for j in range(i, len(array)): 
            cum_sum += array[j] 
            maximum = max(maximum, cum_sum)
    return maximum 

array = [-2, 1, -3, 4, -1, 2, 1, -5, 4] #Sum = 4 − 1 + 2 + 1 = 6
print(brute_force_max_subarray(array))

' 

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.generate_kadane_file83
    set output_file "main.py"

    set kadane_template_content '

def kadane(array):
    maximum = maxarray = array[0]
    for i in range(1, len(array)):
        maxarray = max(array[i], maxarray + array[i])
        maximum = max(maxarray, maximum) 
    return maximum

array = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
print(kadane(array))
'
    echo "$kadane_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_max_subarray_file84
    set output_file "main.py"

    set max_subarray_template_content '

def brute_force_max_subarray(array):
    maximum = 0
    if len(array) == 0:
        return None
    for i in range(len(array)):
        cum_sum = 0 
        for j in range(i, len(array)):
            cum_sum += array[j]
            maximum = max(maximum, cum_sum)
    return maximum

array = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
print(brute_force_max_subarray(array))
'  
    echo "$max_subarray_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_zero_mover_file85
    set output_file "main.py"

    set zero_mover_template_content '

def naive_zero_mover(array):
    l = len(array)
    for i in range(l):
        if array[i] == 0:
            array.append(0)
    j = 0
    c = 0
    while c < l:
        if array[j] != 0:
            j += 1
        else:
            array.pop(j)
        c += 1
    return array

def swap_move(array):
    z = 0
    for i in range(len(array)):
        if array[i] != 0:
            array[i], array[z] = array[z], array[i]
            z += 1
    return array

array = [0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 12, 9, 7]
print("Naive Zero Mover Output:")
print(naive_zero_mover(array))

print("Swap Move Output:")
print(swap_move(array))
'

    echo "$zero_mover_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_reverse_file86
    set output_file "main.py"

    set reverse_template_content '
def simple_reverse(string):
    new_string = []
    for i in range(len(string)-1, -1, -1): 
        new_string.append(string[i])
    return "".join(new_string)

string = "Hello"
print(simple_reverse(string))
' 
    echo "$reverse_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_smarter_reverse_file87
    set output_file "smarter_reverse.py"

    set reverse_template_content '

def swap(string, a, b):
    string = list(string)
    temp = string[a]
    string[a] = string[b]
    string[b] = temp
    return ''.join(string)

def smarter_reverse(string):
    for i in range(len(string)//2):
        string = swap(string, i, len(string)-i-1)
    return string

string = "Hello"
print(smarter_reverse(string))
'
    echo "$reverse_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_reverse_file88
    set output_file "reverse_string.py"

    set reverse_template_content '
string1 = "abcde"
string2 = reversed(string1)
print("Reversed using reversed(): " + "".join(string2))

list1 = list(string1)
list1.reverse()
print("Reversed using reverse(): " + "".join(list1))
'  
    echo "$reverse_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_rotation_file89
    set output_file "rotation.py"

    set rotation_template_content '

def naive_rotation(array, k):
    new_array = []
    for i in range(k % len(array)):
        new_array.append(array[len(array) - k + i])
    for i in range(len(array) - k % len(array)):
        new_array.append(array[i])
    return new_array

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
k = 11
print(naive_rotation(array, k))
'  
    echo "$rotation_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_brute_force_rotation90
    set output_file "brute_force_rotation.py"

    set rotation_template_content '

def brute_force_rotation(array, k):
    for i in range(k):  
        temp = array[-1]
        for i in range(len(array) - 1, 0, -1):
            array[i] = array[i - 1]
        array[0] = temp
    return array

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
k = 3
print(brute_force_rotation(array, k)) 
'  
    echo "$rotation_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_reverse_install91
    set output_file "main.py"

    set reverse_template_content '

def reverse(array, start, end):
    while start < end:
        print(start, end)
        array[start], array[end] = array[end], array[start]
        start += 1
        end -= 1
    return array

array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
start = 2
end = 6
print(reverse(array, start, end))
'  
    echo "$reverse_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_reverse_rotate_file92
    set output_file "main.py"

    set reverse_rotate_template_content '
def reverse(array, start, end):
    while start < end:
        array[start], array[end] = array[end], array[start]
        start += 1
        end -= 1
    return array

def reverse_rotate(array, k):
    array = reverse(array, 0, len(array) - 1) 
    print(array)
    
    array = reverse(array, 0, k % len(array) - 1)
    print(array)  
    array = reverse(array, k % len(array), len(array) - 1)
    print(array)
    
    return array

a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
k = 3
print(reverse_rotate(a, k)) 
'  
    echo "$reverse_rotate_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


#not work
function algoP.generate_graph_file93
    set output_file "main.py"

    set graph_template_content "
class Graph():
    def __init__(self):
        self.number_of_nodes = 0 
        self.adjacency_list = {}

    def insert_node(self, data):
        if data not in self.adjacency_list:
            self.adjacency_list[data] = []
            self.number_of_nodes += 1
            return

    def insert_edge(self, vertex1, vertex2):
        if vertex2 not in self.adjacency_list[vertex1]:
            self.adjacency_list[vertex1].append(vertex2)
            self.adjacency_list[vertex2].append(vertex1)
            return
        return \"Edge already exists\"

    def show_connections(self):
        for node in self.adjacency_list:
            print(f'{node} -->> {\" \".join(map(str, self.adjacency_list[node]))}')

my_graph = Graph()
my_graph.insert_node(1) 
my_graph.insert_node(2)
my_graph.insert_node(3)

my_graph.insert_edge(1, 2)
my_graph.insert_edge(1, 3)
my_graph.insert_edge(2, 3)
my_graph.show_connections() 
print(my_graph.adjacency_list)
print(my_graph.number_of_nodes)
"

    echo "$graph_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_hashtable_file94
    set output_file "main.py"
    set hashtable_template_content '
class AlgoHashTable:

    def __init__(self, size):
        self.size = size
        self.hash_table = self.create_buckets()

    def create_buckets(self):
        return [[] for _ in range(self.size)]

    def __str__(self):
        return "".join(str(item) for item in self.hash_table)

    def set_val(self, key, value):
        hashed_key = hash(key) % self.size
        bucket = self.hash_table[hashed_key]

        found_key = False

        for index, record in enumerate(bucket):
            record_key, record_value = record
            if record_key == key:
                found_key = True
                break

        if found_key:
            bucket[index] = (key, value)
        else:
            bucket.append((key, value))

    def get_val(self, key):
        hashed_key = hash(key) % self.size
        bucket = self.hash_table[hashed_key]
        found_key = False

        for index, record in enumerate(bucket):
            record_key, record_value = record
            if record_key == key:
                found_key = True
                break

        if found_key:
            return record_value
        else:
            return f"{key} not found"
hash_table = AlgoHashTable(10)

hash_table.set_val("apple", 5)
hash_table.set_val("banana", 3)
hash_table.set_val("orange", 10)
print("Hash Table Buckets:")
print(hash_table)

print("Value for 'apple':", hash_table.get_val("apple"))
print("Value for 'banana':", hash_table.get_val("banana"))
print("Value for 'grape':", hash_table.get_val("grape"))  # Not in table


hash_table.set_val("banana", 7)
print("Updated Value for 'banana':", hash_table.get_val("banana"))
print("Updated Hash Table Buckets:")
print(hash_table)
               
'


# hash_table = AlgoHashTable(200)
# file = open('data.txt')
# lines = file.readline().strip().split(':')
# for line in file:
#     key, value = line.split(':')
#     hash_table.set_val(key, value)
# print(hash_table)
# print('-' * 100)
# print(hash_table.get_val('ahlrdmukjn@yaexample.com'))
# "

    echo "$hashtable_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedElementFinder95
    set output_file "main.py"

    set template_content '
def simple_frc(array):
    dictionary = dict()
    for item in array:
        if item in dictionary:
            return item
        else:
            dictionary[item] = True
    return None

array = [2, 1, 4, 1, 5, 2, 6]
print(simple_frc(array))


def simple_frc(array):
    dictionary = dict()
    for item in array:
        if item in dictionary:
            return item
        else:
            dictionary[item] = True
    return None

array = [2, 1, 4, 1, 5, 2, 6]
print(simple_frc(array))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedElementFinder96
    set output_file "main.py"

    set template_content '
def naive_frc(array):
    l = len(array)
    i = 0
    frc = None
    while(i < l):
        j = i + 1
        while(j < l):
            if array[i] == array[j]:
                l = j
                frc = array[j]
                continue
            else:
                j += 1
        i += 1
    return frc

array = [2, 1, 4, 1, 5, 2, 6]
print(naive_frc(array))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_hashtable_file97
    set output_file "main.py"
    set template_content '
class hash_table():
    def __init__(self, size):
        self.size = size
        self.data = [None]*self.size

    def __str__(self):
        return str(self.__dict__)

    def _hash(self, key):
        hash = 0
        for i in range(len(key)):
            hash = (hash + ord(key[i])*i) % self.size
        return hash

    def get(self, key):
        hash = self._hash(key)
        if self.data[hash]:
            for i in range(len(self.data[hash])):
                if self.data[hash][i][0] == key:
                    return self.data[hash][i][1]
        return None

    def set(self, key, value):
        hash = self._hash(key)
        if not self.data[hash]:
            self.data[hash] = [[key, value]]
        else:
            self.data[hash].append([key, value])
        print(self.data)

    def keys(self):
        keys_array = []
        for i in range(self.size):
            if self.data[i]:
                if len(self.data[i]) > 1:
                    for j in range(len(self.data[i])):
                        keys_array.append(self.data[i][j][0])
                else:
                    keys_array.append(self.data[i][0][0])
        return keys_array

    def values(self):
        values_array = []
        for i in range(self.size):
            if self.data[i]:
                for j in range(len(self.data[i])):
                    values_array.append(self.data[i][j][1])
        return values_array


new_hash = hash_table(2)
print(new_hash)

new_hash.set("one", 1)
new_hash.set("two", 2)
new_hash.set("three", 3)
new_hash.set("four", 4)
new_hash.set("five", 5)

print(new_hash)
print(new_hash.get("one"))
print(new_hash.keys())
print(new_hash.values())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_dictionary_file98
    set output_file "main.py"
    set template_content '
dictionary = dict()
dictionary = {"one": 1, "two": 2, "three": 3, "four": 4, "five": 5}
print(dictionary)

# Access dictionary keys
print(dictionary.keys())  

print(dictionary.values()) 
print(dictionary.items())

print(dictionary["one"])
dictionary["six"] = 6
print(dictionary)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_pattern_matching_file99
    set output_file "main.py"
    set template_content '

def naive_pattern_matching(string, pattern):
    matched_indices = [] 
    l = len(pattern)
    flag = 0 
    for i in range(len(string) - l + 1):  
        k = 0
        for j in range(i, i + l):  
            if pattern[k] != string[j]:
                flag = 1
                break
            else:
                k += 1
        if flag == 0:
            matched_indices.append(i)
        flag = 0

    if matched_indices:
        return matched_indices
    else:
        return None

string = "AABAACAADAABAABA"
pattern = "AABA"
print(f"Pattern found at {naive_pattern_matching(string, pattern)}")
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_linked_list_file100
    set output_file "main.py"
    set template_content '
class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None
    def __str__(self):
        return f"{self.data}"

class LinkedList:
    def __init__(self):
       self.head = None
       self.tail = None
    
    def __str__(self):
        to_print = ""
        curr = self.head
        while curr is not None:
            to_print += str(curr.data) + "->"
            curr = curr.next
        if to_print:
            return "[" + to_print[:-2] + "]"
        return "[]"
   
    def append_val(self, x):
        if not isinstance(x, Node):
            x = Node(x)
        if self.head is None:
            self.head = x
        else:
            self.tail.next = x
        self.tail = x

    def add_to_start(self, x):
        if not isinstance(x, Node):
            x = Node(x)
        temp = self.head
        x.next = temp
        self.head = x

    def search_val(self, x):
        current = self.head
        i = 0
        while current is not None:
            if current.data == x:
                print(f"{x} value found at index {i}")
                return
            current = current.next
            i += 1
        print(f"{x} value not found")

    def remove_val_by_index(self, key):
        temp = self.head
        if temp is not None:
            if temp.data == key:
                self.head = temp.next
                temp = None
                return
        while temp is not None:
            if temp.data == key:
                break
            prev = temp
            temp = temp.next
        if temp is None:
            return
        prev.next = temp.next
        temp = None
    def length(self):
        temp = self.head
        count = 0
        while temp:
            count += 1
            temp = temp.next
        return count

    def reverse_list_recur(self, current, previous):
        if self.head is None:
            return
        elif current.next is None:
            self.tail = self.head
            current.next = previous
            self.head = current
        else:
            next = current.next
            current.next = previous
            self.reverse_list_recur(next, current)

node1 = Node(1)
node2 = Node(2)
node3 = Node(3)
node4 = Node(4)
node5 = Node(5)

my_list = LinkedList()
my_list.append_val(node1)
my_list.append_val(node2)
my_list.append_val(node3)
my_list.append_val(node4)
my_list.append_val(node5)
my_list.append_val(6)
my_list.add_to_start(9)
my_list.search_val(3)

print(my_list)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_doubly_linked_list101
    set output_file "main.py"
    set template_content '
class Node():
    def __init__(self, data):
        self.data = data
        self.next = None
        self.previous = None


class DoublyLinkedList():
    def __init__(self):
        self.head = None
        self.tail = self.head
        self.length = 0

    def print_list(self):
        if self.head == None:
            print("Empty")
        else:
            current_node = self.head
            while current_node != None:
                print(current_node.data, end=" ")
                current_node = current_node.next
        print()

    def append(self, data):
        new_node = Node(data)
        if self.head == None:
            self.head = new_node
            self.tail = self.head
            self.length += 1
            return
        else:
            new_node.previous = self.tail
            self.tail.next = new_node
            self.tail = new_node
            self.length += 1
            return

    def prepend(self, data):
        new_node = Node(data)
        if self.head == None:
            self.head = new_node
            self.tail = self.head
            self.length += 1
            return
        else:
            new_node.next = self.head
            self.head.previous = new_node
            self.head = new_node
            self.length += 1
            return

    def insert(self, position, data):
        if position == 0:
            self.prepend(data)
            return
        if position >= self.length:
            self.append(data)
            return
        else:
            new_node = Node(data)
            current_node = self.head
            for i in range(position - 1):
                current_node = current_node.next
            new_node.previous = current_node
            new_node.next = current_node.next
            current_node.next = new_node
            new_node.next.previous = new_node
            self.length += 1
            return
    def delete_by_value(self, data):
        if self.head == None:
            print("Linked List is empty. Nothing to delete.")
            return
        current_node = self.head
        if current_node.data == data:
            self.head = self.head.next
            if self.head == None or self.head.next == None:
                self.tail = self.head
            if self.head != None:
                self.head.previous = None
            self.length -= 1
            return
        try:
            while current_node != None and current_node.next.data != data:
                current_node = current_node.next
            if current_node != None:
                current_node.next = current_node.next.next
                if current_node.next != None:
                    current_node.next.previous = current_node
                else:
                    self.tail = current_node
                self.length -= 1
                return
        except AttributeError:
            print("Given value not found.")
            return
    def delete_by_position(self, position):
        if self.head == None:
            print("Linked List is empty. Nothing to delete.")
            return
        if position == 0:
            self.head = self.head.next
            if self.head == None or self.head.next == None:
                self.tail = self.head
            if self.head != None:
                self.head.previous = None
            self.length -= 1
            return
        if position >= self.length:
            position = self.length - 1
        current_node = self.head
        for i in range(position - 1):
            current_node = current_node.next
        current_node.next = current_node.next.next
        if current_node.next != None:
            current_node.next.previous = current_node
        else:
            self.tail = current_node
        self.length -= 1
        return


my_linked_list = DoublyLinkedList()
my_linked_list.print_list()

my_linked_list.append(5)
my_linked_list.append(2)
my_linked_list.append(9)
my_linked_list.print_list()

my_linked_list.prepend(4)
my_linked_list.print_list()

my_linked_list.insert(2, 7)
my_linked_list.print_list()

my_linked_list.insert(0, 0)
my_linked_list.insert(6, 0)
my_linked_list.insert(9, 3)
my_linked_list.print_list()
my_linked_list.delete_by_value(3)
my_linked_list.print_list()
my_linked_list.delete_by_value(0)
my_linked_list.print_list()

my_linked_list.delete_by_position(3)
my_linked_list.print_list()

my_linked_list.delete_by_position(0)
my_linked_list.print_list()

my_linked_list.delete_by_position(8)
my_linked_list.print_list()

my_linked_list.delete_by_value(3)
my_linked_list.print_list()

print(my_linked_list.length)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_linked_list102
    set output_file "main.py"
    set template_content '
class Node():
    def __init__(self, data):
        self.data = data
        self.next = None


class LinkedList():
    def __init__(self):
        self.head = None
        self.tail = self.head
        self.length = 0

    def append(self, data):
        new_node = Node(data)
        if self.head == None:
            self.head = new_node
            self.tail = self.head
            self.length = 1
        else:
            self.tail.next = new_node
            self.tail = new_node
            self.length += 1

    def prepend(self, data):
        new_node = Node(data)
        if self.head == None:
            self.head = new_node
            self.tail = self.head
            self.length += 1
        else:
            new_node.next = self.head
            self.head = new_node
            self.length += 1

    def print_list(self):
        if self.head == None:
            print("Empty")
        else:
            current_node = self.head
            while current_node != None:
                print(current_node.data, end=" ")
                current_node = current_node.next
        print()

    def insert(self, position, data):
        if position >= self.length:
            if position > self.length:
                print("This position is not available. Inserting at the end of the list")
            new_node = Node(data)
            self.tail.next = new_node
            self.tail = new_node
            self.length += 1
        elif position == 0:
            new_node = Node(data)
            new_node.next = self.head
            self.head = new_node
            self.length += 1
        else:
            new_node = Node(data)
            current_node = self.head
            for i in range(position - 1):
                current_node = current_node.next
            new_node.next = current_node.next
            current_node.next = new_node
            self.length += 1

    def delete_by_value(self, data):
        if self.head == None:
            print("Linked List is empty. Nothing to delete.")
            return
        current_node = self.head
        if current_node.data == data:
            self.head = self.head.next
            if self.head == None or self.head.next == None:
                self.tail = self.head
            self.length -= 1
            return
        while current_node.next != None and current_node.next.data != data:
            current_node = current_node.next
        if current_node.next != None:
            current_node.next = current_node.next.next
            if current_node.next == None:
                self.tail = current_node
            self.length -= 1
            return
        else:
            print("Given value not found.")

    def delete_by_position(self, position):
        if self.head == None:
            print("Linked List is empty. Nothing to delete.")
            return
        if position == 0:
            self.head = self.head.next
            if self.head == None or self.head.next == None:
                self.tail = self.head
            self.length -= 1
            return
        if position >= self.length:
            position = self.length - 1
        current_node = self.head
        for i in range(position - 1):
            current_node = current_node.next
        current_node.next = current_node.next.next
        self.length -= 1
        if current_node.next == None:
            self.tail = current_node
        return

if __name__ == '__main__':
    my_linked_list = LinkedList()
    my_linked_list.print_list()

    my_linked_list.append(5)
    my_linked_list.append(2)
    my_linked_list.append(9)
    my_linked_list.print_list()

    my_linked_list.prepend(4)
    my_linked_list.print_list()

    my_linked_list.insert(2, 7)
    my_linked_list.print_list()

    my_linked_list.insert(0, 0)
    my_linked_list.insert(6, 0)
    my_linked_list.insert(9, 3)
    my_linked_list.print_list()

    my_linked_list.delete_by_value(3)
    my_linked_list.print_list()

    my_linked_list.delete_by_value(0)
    my_linked_list.print_list()

    my_linked_list.delete_by_position(3)
    my_linked_list.print_list()

    my_linked_list.delete_by_position(0)
    my_linked_list.print_list()

    my_linked_list.delete_by_position(8)
    my_linked_list.print_list()
    print(my_linked_list.length)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_reverse_linked_list103
    set output_file "main.py"
    set template_content '
from Implementation import LinkedList, Node

my_linked_list = LinkedList()
my_linked_list.append(2)
my_linked_list.append(3)
my_linked_list.append(4)
my_linked_list.append(5)
my_linked_list.append(6)
my_linked_list.print_list()

def reverse(linked_list):
    if linked_list.length <= 1:
        return linked_list
    else:
        first = linked_list.head
        second = first.next
        linked_list.tail = linked_list.head
        while second:
            temp = second.next
            second.next = first
            first = second
            second = temp
        linked_list.head.next = None
        linked_list.head = first
        return linked_list

reversed_linked_list = reverse(my_linked_list)
reversed_linked_list.print_list()

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_queue104
    set output_file "main.py"
    set template_content '
import time
class Node:

    def __init__(self, data=None):
        self.data = data
        self.next = None

class Queue:

    def __init__(self):
        print("Queue created")
        self.head = None
        self.tail = None

    def add(self, x):
        if not isinstance(x, Node):
            x = Node(x)
        print(f"Appending {x.data} to the tail of the Queue")
        if self.is_empty():
            self.head = x
        else:
            self.tail.next = x
        self.tail = x

    def remove(self):
        if not self.is_empty():
            print(f"Removing node at head of the Queue")
            curr = self.head
            self.head = self.head.next
            curr.next = None
            return curr.data
        else:
            return "Queue is empty"

    def is_empty(self):
        return self.head == None

    def peek(self):
        if not self.is_empty():
            return self.head.data

    def __str__(self):
        print("Printing Queue state...")
        to_print = ""
        curr = self.head
        while curr is not None:
            to_print += str(curr.data) + "->"
            curr = curr.next
        if to_print:
            if len(to_print) > 4:
                print("Head", " "*(len(to_print)-9),"Tail")
                print(" |", " "*(len(to_print)-6), "|")
                print(" V", " "*(len(to_print)-6), "V")
                return "[" + to_print[:-2] + "]"
            else:
                print("Head & Tail")
                print(" |")
                print(" V")
                return "[" + to_print[:-2] + "]"
        return "[]"

my_queue = Queue()
print("Checking if Queue is empty:", my_queue.is_empty())
time.sleep(2)
my_queue.add(1)
print(my_queue)
time.sleep(2)
my_queue.add(2)
my_queue.add(3)
print(my_queue)
time.sleep(2)
my_queue.add(4)
my_queue.add(5)
time.sleep(2)
print("Checking node at head of Queue:", my_queue.peek())
time.sleep(2)
my_queue.add(6)
print(my_queue)
time.sleep(2)
print(my_queue.remove())
time.sleep(2)
print(my_queue.remove())
time.sleep(2)
print(my_queue)
time.sleep(2)
my_queue.add(4)
time.sleep(2)
print(my_queue)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_queue105
    set output_file "queue_implementation.py"
    set template_content '
class Node():
    def __init__(self, data):
        '''initialize node with data and next pointer'''
        self.data = data
        self.next = None


class Queue():
    def __init__(self):
        self.first = None
        self.last = None
        self.length = 0

    def peek(self):
        return self.first.data

    def enqueue(self, data):
        new_node = Node(data)
        if self.last == None:
            self.last = new_node
            self.first = self.last
            self.length += 1
            return
        else:
            self.last.next = new_node
            self.last = new_node
            self.length += 1
            return

    def dequeue(self):
        if self.last == None:
            print("Queue Empty")
            return
        if self.last == self.first:
            self.last = None
        self.first = self.first.next
        self.length -= 1
        return

    def print_queue(self):
        if self.length == 0:
            print("Queue Empty")
            return
        else:
            current_pointer = self.first
            while current_pointer != None:
                if current_pointer.next == None:
                    print(current_pointer.data)
                else:
                    print(f'"{current_pointer.data}  <<--  "', end="")
                current_pointer = current_pointer.next
            return


my_queue = Queue()
my_queue.enqueue("This")
my_queue.enqueue("is")
my_queue.enqueue("a")
my_queue.enqueue("Queue")
my_queue.print_queue()

print(my_queue.peek())


my_queue.dequeue()
my_queue.dequeue()
my_queue.print_queue()
print(my_queue.__dict__)

print(my_queue.first)

print(my_queue.first.data)
my_queue.dequeue()
my_queue.dequeue()
my_queue.print_queue()
    '
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_queue_using_stacks106
    set output_file "queue_using_stacks.py"
    set queue_template_content '
class Queue():
    def __init__(self):
        '''initialize two stacks s1 and s2'''
        self.s1 = []
        self.s2 = []

    def peek(self):
        '''return the front item of the queue'''
        if len(self.s1) == 0:
            print("Queue empty")
        else:
            return self.s1[len(self.s1)-1]

    def enqueue(self, data):
        '''add an item to the queue'''
        for i in range(len(self.s1)):
            item = self.s1.pop()
            self.s2.append(item)
        self.s1.append(data)
        for i in range(len(self.s2)):
            item = self.s2.pop()
            self.s1.append(item)
        return

    def dequeue(self):
        '''remove the front item of the queue'''
        if len(self.s1) == 0:
            print("Queue Empty")
            return
        else:
            return self.s1.pop()

    def print_queue(self):
        '''prints the queue'''
        if len(self.s1) == 0:
            print("Queue Empty")
            return
        for i in range(len(self.s1) - 1, 0, -1):
            print(f'"{self.s1[i]} <<-- "', end="")
        print(self.s1[0])
        return


# Example usage of Queue class using stacks
my_queue = Queue()
my_queue.enqueue(2)
my_queue.enqueue(5)
my_queue.enqueue(0)
my_queue.print_queue()
# 2 <<-- 5 <<-- 0

my_queue.dequeue()
my_queue.print_queue()
# 5 <<-- 0

print(my_queue.peek())
# 5

my_queue.enqueue(9)
my_queue.print_queue()
# 5 <<-- 0 <<-- 9

my_queue.dequeue()
my_queue.dequeue()
my_queue.dequeue()
my_queue.print_queue()
# Queue Empty


class Queue2():
    '''Queue implementation where dequeue operation is costly'''
    def __init__(self):
        '''initialize the stack s1'''
        self.s1 = []

    def peek(self):
        '''return the front item of the queue'''
        if len(self.s1) == 0:
            print("Queue empty")
        else:
            return self.s1[0]

    def enqueue(self, data):
        '''add an item to the queue'''
        self.s1.append(data)
        return

    def dequeue(self):
        '''remove the front item of the queue'''
        if len(self.s1) == 0:
            print("Queue Empty")
            return
        else:
            while len(self.s1) > 1:
                self.s2.append(self.s1.pop())
            item = self.s1.pop()  # this is the element to be dequeued
            while len(self.s2) > 0:
                self.s1.append(self.s2.pop())
            return item

    def print_queue(self):
        '''prints the queue'''
        if len(self.s1) == 0:
            print("Queue Empty")
            return
        for i in range(len(self.s1) - 1, 0, -1):
            print(f'"{self.s1[i]} <<-- "', end="")
        print(self.s1[0])
        return


# Example usage of the Queue2 class
my_queue2 = Queue2()
my_queue2.enqueue(3)
my_queue2.enqueue(7)
my_queue2.enqueue(1)
my_queue2.print_queue()

print(my_queue2.dequeue())

my_queue2.print_queue()

my_queue2.enqueue(10)
my_queue2.print_queue()
print(my_queue2.dequeue())
    '

    echo "$queue_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_stack_using_linked107
    set output_file "main.py"
    set template_content '
import time

class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None

class Stack:

    def __init__(self):
        print("Stack created")
        self.stack_pointer = None

    def push(self, x):
        if not isinstance(x, Node):
            x = Node(x)
        print(f"Adding {x.data} to the top of stack")
        if self.is_empty():
            self.stack_pointer = x
        else:
            x.next = self.stack_pointer
            self.stack_pointer = x

    def pop(self):
        if not self.is_empty():
            print(f"Removing node on top of stack")
            curr = self.stack_pointer
            self.stack_pointer = self.stack_pointer.next
            curr.next = None
            return curr.data
        else:
            return "Stack is empty"

    def is_empty(self):
        return self.stack_pointer == None

    def peek(self):
        if not self.is_empty():
            return self.stack_pointer.data

    def __str__(self):
        print("Printing Stack state...")
        to_print = ""
        curr = self.stack_pointer
        while curr is not None:
            to_print += str(curr.data) + "->"
            curr = curr.next
        if to_print:
            print("Stack Pointer")
            print(" |")
            print(" V")
            return "[" + to_print[:-2] + "]"
        return "[]"

my_stack = Stack()
print("Checking if stack is empty:", my_stack.is_empty())
time.sleep(2)

my_stack.push(1)
time.sleep(2)
my_stack.push(2)
print(my_stack)
time.sleep(2)

my_stack.push(3)
time.sleep(2)
my_stack.push(4)
time.sleep(2)

print("Checking item on top of stack:", my_stack.peek())
time.sleep(2)

my_stack.push(5)
print(my_stack)
time.sleep(2)

print(my_stack.pop())
time.sleep(2)
print(my_stack.pop())
print(my_stack)
time.sleep(2)

my_stack.push(4)
print(my_stack)
time.sleep(2)
    '
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_stack_with_array108
    set output_file "main.py"

    set template_content '
class Stack:
    def __init__(self):
        self.array = []

    def peek(self):
        return self.array[len(self.array)-1] if len(self.array) > 0 else None

    def push(self, data):
        self.array.append(data)

    def pop(self):
        if len(self.array) != 0:
            self.array.pop()
        else:
            print("Stack Empty")

    def print_stack(self):
        for i in range(len(self.array)-1, -1, -1):
            print(self.array[i])

my_stack = Stack()
my_stack.push("Andrei")
my_stack.push("Courses")
my_stack.push("Are")
my_stack.push("Awesome")
print("Stack after pushing 4 elements:")
my_stack.print_stack()

my_stack.pop()
my_stack.pop()
print("Stack after popping 2 elements:")
my_stack.print_stack()

print("Peek top element:", my_stack.peek())

print("Internal structure of the stack array:", my_stack.__dict__)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_stack_with_linked_list109
    set output_file "main.py"
    set stack_template_content '
class Node():
    def __init__(self, data):
        self.data = data
        self.next = None

class Stack():
    def __init__(self):
        self.top = None
        self.bottom = None
        self.length = 0

    def peek(self):
        if self.top is None:
            return None
        return self.top.data

    def push(self, data):
        new_node = Node(data)
        if self.top is None:
            self.top = new_node
            self.bottom = new_node
        else:
            new_node.next = self.top
            self.top = new_node
        self.length += 1

    def pop(self):
        if self.top is None:
            print("Stack empty")
        else: 
            self.top = self.top.next
            self.length -= 1
            if self.length == 0:
                self.bottom = None

    def print_stack(self):
        if self.top is None:
            print("Stack empty")
        else:
            current_pointer = self.top
            while current_pointer is not None:
                print(current_pointer.data)
                current_pointer = current_pointer.next

my_stack = Stack()
print(my_stack.peek())
my_stack.push('google')
my_stack.push('udemy')
my_stack.push('discord')

print("Stack after pushing 3 elements:")
my_stack.print_stack()

print("Top element:", my_stack.top.data)
print("Bottom element:", my_stack.bottom.data)

my_stack.pop()
my_stack.pop()
print("\nStack after popping 2 elements:")
my_stack.print_stack()

my_stack.pop()
my_stack.print_stack()
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_bst110
    set output_file "main.py"
    set template_content '
class Node:
    def __init__(self, key):
        self.data = key
        self.left_child = None
        self.right_child = None

class BSTDemo:
    def __init__(self):
        self.root = None

    def insert(self, key):
        if not isinstance(key, Node):
            key = Node(key)
        if self.root == None:
            self.root = key
        else:
            self._insert(self.root, key)

    def _insert(self, curr, key):
        if key.data > curr.data:
            if curr.right_child == None:
                curr.right_child = key
            else:
                self._insert(curr.right_child, key)
        elif key.data < curr.data:
            if curr.left_child == None:
                curr.left_child = key
            else:
                self._insert(curr.left_child, key)

    def in_order(self):
        self._in_order(self.root)
        print("")

    def _in_order(self, curr):
        if curr:
            self._in_order(curr.left_child)
            print(curr.data, end=" ")
            self._in_order(curr.right_child)

    def pre_order(self):
        self._pre_order(self.root)
        print("")

    def _pre_order(self, curr):
        if curr:
            print(curr.data, end=" ")
            self._pre_order(curr.left_child)
            self._pre_order(curr.right_child)

    def post_order(self):
        self._post_order(self.root)
        print("")

    def _post_order(self, curr):
        if curr:
            self._post_order(curr.left_child)
            self._post_order(curr.right_child)
            print(curr.data, end=" ")

    def find_val(self, key):
        return self._find_val(self.root, key)

    def _find_val(self, curr, key):
        if curr:
            if key == curr.data:
                return "Value found in tree"
            elif key < curr.data:
                return self._find_val(curr.left_child, key)
            else:
                return self._find_val(curr.right_child, key)
        return "Value not found in tree"

    def min_right_subtree(self, curr):
        if curr.left_child == None:
            return curr
        else:
            return self.min_right_subtree(curr.left_child)

    def delete_val(self, key):
        self._delete_val(self.root, None, None, key)

    def _delete_val(self, curr, prev, is_left, key):
        if curr:
            if key == curr.data:
                if curr.left_child and curr.right_child:
                    min_child = self.min_right_subtree(curr.right_child)
                    curr.data = min_child.data
                    self._delete_val(curr.right_child, curr, False, min_child.data)
                elif curr.left_child == None and curr.right_child == None:
                    if prev:
                        if is_left:
                            prev.left_child = None
                        else:
                            prev.right_child = None
                    else:
                        self.root = None
                elif curr.left_child == None:
                    if prev:
                        if is_left:
                            prev.left_child = curr.right_child
                        else:
                            prev.right_child = curr.right_child
                    else:
                        self.root = curr.right_child
                else:
                    if prev:
                        if is_left:
                            prev.left_child = curr.left_child
                        else:
                            prev.right_child = curr.left_child
                    else:
                        self.root = curr.left_child
            elif key < curr.data:
                self._delete_val(curr.left_child, curr, True, key)
            elif key > curr.data:
                self._delete_val(curr.right_child, curr, False, key)
        else:
            print(f"{key} not found in Tree")

tree = BSTDemo()
tree.insert("F")
tree.insert("C")
print("Test deleting leaf node which is left child of parent")
tree.in_order()
tree.delete_val("C")
tree.in_order()
tree.insert("G")
print("Test deleting leaf node which is right child of parent")
tree.in_order()
tree.delete_val("G")
tree.in_order()
tree.insert("A")
print("Test deleting parent/root node which has one child")
tree.in_order()
tree.delete_val("F")
tree.in_order()
print("Test deleting root node which has no children")
tree.in_order()
tree.delete_val("A")
tree.in_order()
tree.insert("F")
tree.insert("C")
tree.insert("G")
tree.insert("A")
tree.insert("B")
tree.insert("K")
tree.insert("E")
tree.insert("H")
tree.insert("D")
tree.insert("I")
tree.insert("M")
tree.insert("J")
tree.insert("L")
tree.in_order()
tree.delete_val("F")
tree.in_order()
tree.in_order()
tree.delete_val("K")
tree.in_order()
tree.in_order()
tree.delete_val("C")
tree.in_order()
tree.delete_val("Z")
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_bst111
    set output_file "main.py"
    set template_content '
class Node():
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None


class BST():
    def __init__(self):
        self.root = None
        self.number_of_nodes = 0

    def insert(self, data):
        new_node = Node(data)
        if self.root == None:
            self.root = new_node
            self.number_of_nodes += 1
            return
        else:
            current_node = self.root
            while(current_node.left != new_node) and (current_node.right != new_node):
                if new_node.data > current_node.data:
                    if current_node.right == None:
                        current_node.right = new_node
                    else:
                        current_node = current_node.right
                elif new_node.data < current_node.data:
                    if current_node.left == None:
                        current_node.left = new_node
                    else:
                        current_node = current_node.left
            self.number_of_nodes += 1
            return

    def search(self, data):
        if self.root == None:
            return "Tree Is Empty"
        else:
            current_node = self.root
            while True:
                if current_node == None:
                    return "Not Found"
                if current_node.data == data:
                    return "Found"
                elif current_node.data > data:
                    current_node = current_node.left
                elif current_node.data < data:
                    current_node = current_node.right

    def remove(self, data):
        if self.root == None:
            return "Tree Is Empty"
        current_node = self.root
        parent_node = None
        while current_node != None:
            if current_node.data > data:
                parent_node = current_node
                current_node = current_node.left
            elif current_node.data < data:
                parent_node = current_node
                current_node = current_node.right
            else:  # Match is found. Different cases to be checked
                # Node has left child only
                if current_node.right == None:
                    if parent_node == None:
                        self.root = current_node.left
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.left
                            return
                        else:
                            parent_node.right = current_node.left
                            return
                # Node has right child only
                elif current_node.left == None:
                    if parent_node == None:
                        self.root = current_node.right
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.right
                            return
                        else:
                            parent_node.right = current_node.right
                            return
                elif current_node.left == None and current_node.right == None:
                    if parent_node == None:
                        current_node = None
                        return
                    if parent_node.data > current_node.data:
                        parent_node.left = None
                        return
                    else:
                        parent_node.right = None
                        return
                elif current_node.left != None and current_node.right != None:
                    del_node = current_node.right
                    del_node_parent = current_node.right
                    while del_node.left != None:
                        del_node_parent = del_node
                        del_node = del_node.left
                    current_node.data = del_node.data
                    if del_node == del_node_parent:
                        current_node.right = del_node.right
                        return
                    if del_node.right == None:
                        del_node_parent.left = None
                        return
                    else:
                        del_node_parent.left = del_node.right
                        return
        return "Not Found"

my_bst = BST()
my_bst.insert(5)
my_bst.insert(3)
my_bst.insert(7)
my_bst.insert(1)
my_bst.insert(13)
my_bst.insert(65)
my_bst.insert(0)
my_bst.insert(10)
my_bst.remove(13)
my_bst.remove(5)
my_bst.remove(3)
my_bst.remove(7)
my_bst.remove(1)
my_bst.remove(0)
my_bst.remove(10)
my_bst.remove(65)
my_bst.insert(10)
print(my_bst.root.data)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.generate_max_heap112
    set output_file "max_heap.py"
    set template_content '
import sys

class MaxHeap:
    def __init__(self, maxsize):
        self.maxsize = maxsize
        self.size = 0
        self.Heap = [0] * (self.maxsize + 1)
        self.Heap[0] = sys.maxsize
        self.FRONT = 1

    def parent(self, pos):
        return pos // 2

    def left_child(self, pos):
        return (2 * pos) + 1

    def right_child(self, pos):
        return (2 * pos) + 2

    def is_leaf(self, pos):
        if pos >= (self.size // 2) and pos <= self.size:
            return True
        return False

    def swap(self, fpos, spos):
        self.Heap[fpos], self.Heap[spos] = self.Heap[spos], self.Heap[fpos]

    def max_heapify(self, pos):
        if not self.is_leaf(pos):
            if (self.Heap[pos] < self.Heap[self.left_child(pos)] or
                    self.Heap[pos] < self.Heap[self.right_child(pos)]):

                if self.Heap[self.left_child(pos)] > self.Heap[self.right_child(pos)]:
                    self.swap(pos, self.left_child(pos))
                    self.max_heapify(self.left_child(pos))
                else:
                    self.swap(pos, self.right_child(pos))
                    self.max_heapify(self.right_child(pos))

    def insert(self, element):
        if self.size >= self.maxsize:
            return
        self.size += 1
        self.Heap[self.size] = element
        current = self.size
        while self.Heap[current] > self.Heap[self.parent(current)]:
            self.swap(current, self.parent(current))
            current = self.parent(current)

    def print_heap(self):
        for i in range(1, (self.size // 2) + 1):
            print(" PARENT : " + str(self.Heap[i]) + " LEFT CHILD : " +
                  str(self.Heap[(2 * i) + 1]) + " RIGHT CHILD : " +
                  str(self.Heap[(2 * i) + 2]))

    def extract_max(self):
        popped = self.Heap[self.FRONT]
        self.Heap[self.FRONT] = self.Heap[self.size]
        self.size -= 1
        self.max_heapify(self.FRONT)
        return popped


if __name__ == "__main__":
    my_heap = MaxHeap(15)
    my_heap.insert(5)
    my_heap.insert(3)
    my_heap.insert(17)
    my_heap.insert(10)
    my_heap.insert(84)
    my_heap.insert(19)
    my_heap.insert(6)
    my_heap.insert(22)
    my_heap.insert(9)
    my_heap.print_heap()

    print("The Max val is " + str(my_heap.extract_max()))
    my_heap.print_heap()
    my_heap.insert(100)
    my_heap.print_heap()
    print(my_heap.Heap[0])
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_priority_queue113
    set output_file "main.py"
    set template_content '
import heapq
li = [5, 7, 9, 1, 3]
heapq.heapify(li)
print("The created heap is : ", end="")
print(list(li))
heapq.heappush(li, 4)

print("The modified heap after push is : ", end="")
print(list(li))
print("The popped and smallest element is : ", end="")
print(heapq.heappop(li))
li1 = [5, 7, 9, 4, 3]
li2 = [5, 7, 9, 4, 3]
heapq.heapify(li1)
heapq.heapify(li2)
print("The popped item using heappushpop() is : ", end="")
print(heapq.heappushpop(li1, 2))
print("The popped item using heapreplace() is : ", end="")
print(heapq.heapreplace(li2, 2))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_trie114
    set output_file "main.py"
    set template_content '
class TrieNode():
    def __init__(self):
        self.children = [None]*26
        self.is_end_of_word = False
class Trie():
    def __init__(self):
        self.root = TrieNode()

    def _character_index(self, char):
        if char.isupper():
            return ord(char) - ord("A")
        else:
            return ord(char) - ord("a")

    def insert(self, string):
        pointer = self.root
        for character in string:
            index = self._character_index(character)
            if not pointer.children[index]:
                pointer.children[index] = TrieNode()
            pointer = pointer.children[index]
        pointer.is_end_of_word = True

    def search(self, string):
        pointer = self.root
        for character in string:
            index = self._character_index(character)
            if not pointer.children[index]:
                return False
            pointer = pointer.children[index]
        return pointer and pointer.is_end_of_word

my_trie = Trie()
my_trie.insert("Data")
my_trie.insert("Structures")
my_trie.insert("and")
my_trie.insert("Algorithms")

print(my_trie.search("and"))        
print(my_trie.search("Data"))       
print(my_trie.search("woohoo"))     
print(my_trie.search("STructures"))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_karatsuba115
    set template_content "main.py"
    set template_content '

def k_multiply(x, y):
    if len(x) > 1 and len(y) > 1:
        a, b = x[:len(x)//2], x[len(x)//2:]
        c, d = y[:len(y)//2], y[len(y)//2:]
        print(a, b, c, d)
        ac = k_multiply(a, c)
        bd = k_multiply(b, d)
        bc = k_multiply(b, c)
        ad = k_multiply(a, d)
        n = len(x)
        n2 = n // 2
        prod = (ac * pow(10, n)) + bd + ((bc + ad) * pow(10, n2))
        return prod
    else:
        return x[0] * y[0]

if __name__ == "__main__":
    try:
        first_integer = [int(x) for x in input("first integer: ")]
        second_integer = [int(x) for x in input("second integer: ")]
        if len(first_integer) != len(second_integer):
            raise ValueError("Integers must be of equal length")

        result = k_multiply(first_integer, second_integer)
        print(result)
    except ValueError:
        print("Invalid Inputs")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_fibonacci_dp116
    set output_file "fibonacci_dp.py"

    set python_code '
import time

def fibonacci(n):
    if n < 2:
        return n
    else:
        return fibonacci(n-1) + fibonacci(n-2)

cache = {}
def dynamic_fibonacci(n):
    if n in cache:
        return cache[n]
    if n < 2:
        return n
    cache[n] = dynamic_fibonacci(n-1) + dynamic_fibonacci(n-2)
    return cache[n]

if __name__ == "__main__":
    t1 = time.time()
    print(fibonacci(30))
    t2 = time.time()
    print("Recursive time:", t2-t1)

    t1 = time.time()
    print(dynamic_fibonacci(30))
    t2 = time.time()
    print("DP time:", t2-t1)

    t1 = time.time()
    print(dynamic_fibonacci(60))
    t2 = time.time()
    print("DP time for 60:", t2-t1)

    t1 = time.time()
    print(dynamic_fibonacci(100))
    t2 = time.time()
    print("DP time for 100:", t2-t1)

    t1 = time.time()
    print(dynamic_fibonacci(1000))
    t2 = time.time()
    print("DP time for 1000:", t2-t1)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_memoization117
    set output_file "main.py"
    set template_content '
import time, random
from functools import lru_cache

times = []
def squaring_without_memoization(number):
    return number**2

array = [random.randint(1,10) for _ in range(100000)]
t1 = time.time()
for i in range(len(array)):
    squaring_without_memoization(array[i])
t2 = time.time()
times.append(t2-t1)

cache = {}
def squaring_with_memoization(number):
    if number in cache:
        return cache[number]
    cache[number] = number**2
    return cache[number]

t1 = time.time()
for i in range(len(array)):
    squaring_with_memoization(array[i])
t2 = time.time()
times.append(t2-t1)

@lru_cache(maxsize=10000)
def squaring(number):
    return number**2

t1 = time.time()
for i in range(len(array)):
    squaring(array[i])
t2 = time.time()
times.append(t2-t1)

print("Execution times (seconds):", times)
print("Manual cache contents:", cache)
print("LRU Cache info:", squaring.cache_info())
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_factorial118
    set output_file "main.py"
    set template_content '

def iterative_factorial(number):
    f = 1
    for i in range(1, number+1):
        f = f * i
    return f

print("Iterative Factorial:")
print("0! =", iterative_factorial(0))
print("5! =", iterative_factorial(5))
print("50! =", iterative_factorial(50))

def recursive_factorial(number):
    if number <= 1:
        return 1
    return number * recursive_factorial(number-1)

print("\\nRecursive Factorial:")
print("0! =", recursive_factorial(0))
print("5! =", recursive_factorial(5))
print("50! =", recursive_factorial(50))
# Warning: Very large numbers may cause recursion limit error
try:
    print("1000! =", recursive_factorial(1000))
except RecursionError:
    print("1000! exceeds recursion depth")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_fibonacci119
    set output_file "fibonacci_demo.py"
    set python_code '

def iterative_fibonacci(index):
    first_number = 0
    second_number = 1
    if index == 0:
        return first_number
    if index == 1:
        return second_number
    for i in range(2, index + 1):
        third_number = first_number + second_number
        first_number = second_number
        second_number = third_number
    return third_number

print("Iterative Fibonacci:")
print("Fibonacci(0) =", iterative_fibonacci(0))  
print("Fibonacci(1) =", iterative_fibonacci(1))  
print("Fibonacci(5) =", iterative_fibonacci(5))  
print("Fibonacci(7) =", iterative_fibonacci(7))  
print("Fibonacci(10) =", iterative_fibonacci(10))  
print("Fibonacci(12) =", iterative_fibonacci(12))


def recursive_fibonacci(index):
    if index == 0:
        return 0
    if index == 1:
        return 1
    return recursive_fibonacci(index - 1) + recursive_fibonacci(index - 2)  # Fibonacci relation

print("\\nRecursive Fibonacci:")
print("Fibonacci(0) =", recursive_fibonacci(0))
print("Fibonacci(1) =", recursive_fibonacci(1))
print("Fibonacci(5) =", recursive_fibonacci(5))
print("Fibonacci(7) =", recursive_fibonacci(7))
print("Fibonacci(10) =", recursive_fibonacci(10))
print("Fibonacci(12) =", recursive_fibonacci(12))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_reverse_string120
    set output_file "main.py"
    set template_content '

def iterative_reverse(string): 
    reversed_string = ""
    for i in range(len(string)):
        reversed_string = reversed_string + string[len(string) - i - 1]
    return reversed_string

print("Iterative Reverse:")
print(iterative_reverse("Zero To Mastery"))

def second_iterative_reverse(string):
    original_length = len(string)
    for i in range(original_length):
        string = string + string[original_length - i - 1]
    string = string[original_length:]
    return string

print("\\nSecond Iterative Reverse:")
print(second_iterative_reverse("Zero To Mastery"))


def recursive_reverse(string):
    if len(string) == 0:
        return string
    else:
        return recursive_reverse(string[1:]) + string[0]

print("\\nRecursive Reverse:")
print(recursive_reverse("Zero To Mastery"))  # yretsaM oT oreZ
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_bsearch_alt121
    set output_file "bsearch_alt.py"
    set python_code '

def bsearch_alt(target, arr):
    n = len(arr)
    k = 0
    i = n // 2
    while (i >= 1):
        while (k + i < n) and (arr[k + i] <= target):
            k = k + 1
        i = i // 2
    return k if arr[k] == target else -1

print(bsearch_alt(4, [1, 2, 3, 4, 5]))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_bubble_sort122
    set output_file "main.py"
    set template_content '

def bubble_sort(arr):
    swap_happened = True
    while swap_happened:
        print("bubble sort status:", arr)
        swap_happened = False
        for num in range(len(arr)-1):
            if arr[num] > arr[num+1]:
                swap_happened = True
                arr[num], arr[num+1] = arr[num+1], arr[num]

l = [6, 8, 1, 4, 10, 7, 8, 9, 3, 2, 5]
# l = [10, 9, 8, 8, 7, 6, 5, 4, 3, 2, 1]
# l = [1, 2, 3, 4, 5, 6, 7, 8, 8, 9, 10]
bubble_sort(l)
print("Sorted list:", l)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_insertion_sort123
    set output_file "insertion_sort.py"
    set python_code '

def insertion_sort(arr):
    for key in range(1, len(arr)):
        if arr[key] < arr[key-1]:
            j = key
            while j > 0 and arr[j] < arr[j-1]:
                arr[j], arr[j-1] = arr[j-1], arr[j]
                j -= 1

l = [6, 1, 8, 4, 10]
insertion_sort(l)
print("Sorted list:", l)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.generate_merge_sort124
    set output_file "main.py"
    set python_code '
def merge_sorted(arr1, arr2):
    print("Merge function called with lists below:")
    print(f"left: {arr1} and right: {arr2}")
    sorted_arr = []
    i, j = 0, 0

    while i < len(arr1) and j < len(arr2):
        if arr1[i] < arr2[j]:
            sorted_arr.append(arr1[i])
            i += 1
        else:
            sorted_arr.append(arr2[j])
            j += 1

    while j < len(arr2):
        sorted_arr.append(arr2[j])
        j += 1 

    while i < len(arr1):
        sorted_arr.append(arr1[i])
        i += 1  

    return sorted_arr

def divide_arr(arr):
    if len(arr) < 2:
        return arr[:]
    else:
        middle = len(arr)//2
        l1 = divide_arr(arr[:middle])
        l2 = divide_arr(arr[middle:])
        return merge_sorted(l1, l2)

l = [8, 6, 2, 5, 10, 13, 4, 55, 61, 23, 100]
print(divide_arr(l))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created!"
    set_color normal
    cat $output_file
end




function algoP.generate_quicksort125
    set output_file "main.py"
    set python_code '

def quicksort(arr):
    if len(arr) < 2:
        return arr
    else:
        pivot = arr[-1]
        smaller, equal, larger = [], [], []
        
        for num in arr:
            if num < pivot:
                smaller.append(num)
            elif num == pivot:
                equal.append(num)
            else:
                larger.append(num)
        
        return quicksort(smaller) + equal + quicksort(larger)

if __name__ == "__main__":
    arr = [6, 8, 1, 4, 10, 7, 8.9, 3, 2, 5]
    print("Sorted array:", quicksort(arr))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Quicksort algorithm!"
    set_color normal
    cat $output_file
end

function algoP.generate_selection_sort126
    set output_file "selection_sort.py"
    set python_code '
def selection_sort(arr):
    spot_marker = 0
    while spot_marker < len(arr):
        for num in range(spot_marker, len(arr)):
            if arr[num] < arr[spot_marker]:
                arr[spot_marker], arr[num] = arr[num], arr[spot_marker]
        spot_marker += 1

if __name__ == "__main__":
    arr = [6, 8, 1, 4, 10, 7, 8, 9, 3, 2, 5]  # Example list
    print("Original list:", arr)
    selection_sort(arr)
    print("Sorted list:", arr)
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_bubble_sort127
    set output_file "bubble_sort.py"
    set python_code '

def bubble_sort(array):
    count = 0
    for i in range(len(array)-1):
        print(array)
        for j in range(len(array)-i-1):
            count += 1
            if array[j] > array[j+1]:
                array[j], array[j+1] = array[j+1], array[j]
    return (f"{array} \nNumber of comparisons = {count}")

if __name__ == "__main__":
    array = [5, 9, 3, 10, 45, 2, 0]
    print(bubble_sort(array))

    sorted_array = [5, 6, 7, 8, 9]
    print(bubble_sort(sorted_array))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Bubble Sort algorithm!"
    set_color normal
    cat $output_file
end



function algoP.generate_optimized_bubble_sort128
    set output_file "main.py"
    set python_code '
def optimized_bubble_sort(array):
    count = 0
    for i in range(len(array) - 1):
        swap = False
        print(array)
        for j in range(len(array) - i - 1):
            count += 1
            if array[j] > array[j+1]:
                array[j], array[j+1] = array[j+1], array[j]
                swap = True
        if swap==False:
            return (f"{array} \nNumber of comparisons = {count}")
    return (f"{array} Number of comparisons = {count}")

if __name__ == "__main__":
    array1 = [5, 9, 3, 10, 45, 2, 0]
    print(optimized_bubble_sort(array1))

    sorted_array1 = [5, 6, 7, 8, 9]
    print(optimized_bubble_sort(sorted_array1))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Optimized Bubble Sort algorithm!"
    set_color normal
    cat $output_file
end



function algoP.generate_heap_sort129
    set output_file "main.py"
    set python_code '

count = 0

def max_heapify(array, heap_size, i):
    left = 2 * i + 1
    right = 2 * i + 2
    largest = i
    global count
    if left < heap_size:
        count += 1
        if array[left] > array[largest]:
            largest = left
    if right < heap_size:
        count += 1
        if array[right] > array[largest]:
            largest = right
    if largest != i:
        array[i], array[largest] = array[largest], array[i]
        max_heapify(array, heap_size, largest)

def build_heap(array):
    heap_size = len(array)
    for i in range((heap_size//2), -1, -1):
        max_heapify(array, heap_size, i)

def heap_sort(array):
    heap_size = len(array)
    build_heap(array)
    print(f"Heap: {array}")
    for i in range(heap_size - 1, 0, -1):
        array[0], array[i] = array[i], array[0]
        heap_size -= 1
        max_heapify(array, heap_size, 0)

if __name__ == "__main__":
    array = [5, 9, 3, 10, 45, 2, 0]
    heap_sort(array)
    print(f"Sorted Array: {array}")
    print(f"Number of comparisons: {count}")

    sorted_array = [5, 6, 7, 8, 9]
    heap_sort(sorted_array)
    print(f"Sorted Array: {sorted_array}")
    print(f"Number of comparisons: {count}")

    reverse_sorted_array = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
    heap_sort(reverse_sorted_array)
    print(f"Sorted Array: {reverse_sorted_array}")
    print(f"Number of comparisons: {count}")
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Heap Sort algorithm!"
    set_color normal
    cat $output_file
end



function algoP.generate_insertion_sort130
    # Name of the output Python file
    set output_file "insertion_sort.py"

    # Python code for Insertion Sort with comparison counting
    set python_code '
"""
Insertion Sort Algorithm:
1. The array is traversed starting from the second element.
2. Each element is compared to the elements in the sorted part of the array.
3. If the current element is smaller than any sorted element, the sorted elements are shifted to the right, and the current element is inserted into its correct position.

Time Complexity: O(n^2) in all cases.
Space Complexity: O(1)
"""

def insertion_sort(array):
    count = 0
    for i in range(1, len(array)):
        print(array)
        last_sorted_position = array[i-1]  # Store the last element which is sorted
        count += 1
        if array[i] < last_sorted_position:  # Check if the current element is less than the last sorted element
            temp = array[i]  # Store the current element in a temporary variable
            for j in range(i-1, -1, -1):  # Loop backwards through the sorted part of the array
                count += 1
                if temp < array[j]:  # Shift elements greater than the current element to the right
                    if j == 0:
                        array[j+1] = array[j]
                        array[j] = temp
                    else:
                        array[j+1] = array[j]
                else:
                    array[j+1] = temp  # Place the current element in its correct position
                    break
    return (f'{array} \nNumber of comparisons = {count}')

if __name__ == "__main__":
    # Example usage
    array = [5, 9, 3, 10, 45, 2, 0]
    print(insertion_sort(array))

    sorted_array = [5, 6, 7, 8, 9]
    print(insertion_sort(sorted_array))

    reverse_sorted_array = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
    print(insertion_sort(reverse_sorted_array))
'

    # Write the Python code to the file
    echo "$python_code" > $output_file

    # Notify the user
    set_color green
    echo "$output_file has been created with the Insertion Sort algorithm!"
    set_color normal

    # Show the contents of the generated Python file
    cat $output_file
end





function algoP.generate_merge_sort131
    # Name of the output Python file
    set output_file "merge_sort.py"

    # Python code for Merge Sort with counting comparisons
    set python_code '
"""
Merge Sort Algorithm:
1. The array is divided into two halves recursively.
2. Each half is sorted and then merged back together in a sorted manner.
3. This continues until the whole array is sorted.

Time Complexity: O(n log n)
Space Complexity: O(n)
"""

count = 0

def merge_sort(array):
    if len(array) == 1:
        return array
    else:
        mid = len(array)//2
        left_array = array[:mid]
        right_array = array[mid:]
        print(f"Left: {left_array}")
        print(f"Right: {right_array}")
        return merge(merge_sort(left_array), merge_sort(right_array))

def merge(left, right):
    l = len(left)
    r = len(right)
    left_index = 0
    right_index = 0
    sorted_array = []
    
    while left_index < l and right_index < r:
        global count
        count += 1  # Increment comparison count
        if left[left_index] < right[right_index]:
            sorted_array.append(left[left_index])
            left_index += 1
        else:
            sorted_array.append(right[right_index])
            right_index += 1
    
    # Debug output showing the merged array with remaining elements
    print(sorted_array + left[left_index:] + right[right_index:])
    return sorted_array + left[left_index:] + right[right_index:]

if __name__ == "__main__":
    array = [5, 9, 3, 10, 45, 2, 0]
    print("Sorted array:", merge_sort(array))
    print(f"Number of comparisons = {count}")

    reverse_sorted_array = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
    print("Sorted array:", merge_sort(reverse_sorted_array))
    print(f"Number of comparisons = {count}")
'

    # Write Python code to the file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file has been created with the Merge Sort algorithm!"
    set_color normal

    # Show the contents of the generated Python file
    cat $output_file
end




function algoP.generate_selection_sort132
    set output_file "main.py"
    set python_code '
count = 0

def selection_sort(array):
    count = 0
    for i in range(len(array)-1): 
        print(array)
        minimum = array[i]
        minimum_index = i
        for j in range(i+1, len(array)):
            count += 1
            if array[j] < minimum:
                minimum = array[j]
                minimum_index = j
        if minimum_index != i:
            array[minimum_index], array[i] = array[i], array[minimum_index]
    return f"{array} \nNumber of comparisons = {count}"

if __name__ == "__main__":
    array = [5, 9, 3, 10, 45, 2, 0]
    print(selection_sort(array))

    sorted_array = [5, 6, 7, 8, 9]
    print(selection_sort(sorted_array))

    reverse_sorted_array = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]
    print(selection_sort(reverse_sorted_array))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Selection Sort algorithm!"
    set_color normal
    cat $output_file
end


function algoP.generate_bfs_bst133
    set output_file "main.py"
    set python_code '
class Node():
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None


class BST():
    def __init__(self):
        self.root = None
        self.number_of_nodes = 0

    def insert(self, data):
        new_node = Node(data)
        if self.root == None:
            self.root = new_node
            self.number_of_nodes += 1
            return
        else:
            current_node = self.root
            while(current_node.left != new_node) and (current_node.right != new_node):
                if new_node.data > current_node.data:
                    if current_node.right == None:
                        current_node.right = new_node
                    else:
                        current_node = current_node.right
                elif new_node.data < current_node.data:
                    if current_node.left == None:
                        current_node.left = new_node
                    else:
                        current_node = current_node.left
            self.number_of_nodes += 1
            return

    def search(self, data):
        if self.root == None:
            return "Tree Is Empty"
        else:
            current_node = self.root
            while True:
                if current_node == None:
                    return "Not Found"
                if current_node.data == data:
                    return "Found"
                elif current_node.data > data:
                    current_node = current_node.left
                elif current_node.data < data:
                    current_node = current_node.right

    def remove(self, data):
        if self.root == None:
            return "Tree Is Empty"
        current_node = self.root
        parent_node = None
        while current_node != None:
            if current_node.data > data:
                parent_node = current_node
                current_node = current_node.left
            elif current_node.data < data:
                parent_node = current_node
                current_node = current_node.right
            else:
                if current_node.right == None:
                    if parent_node == None:
                        self.root = current_node.left
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.left
                            return
                        else:
                            parent_node.right = current_node.left
                            return
                elif current_node.left == None:
                    if parent_node == None:
                        self.root = current_node.right
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.right
                            return
                        else:
                            parent_node.right = current_node.right
                            return
                elif current_node.left == None and current_node.right == None:
                    if parent_node == None:
                        current_node = None
                        return
                    if parent_node.data > current_node.data:
                        parent_node.left = None
                        return
                    else:
                        parent_node.right = None
                        return
                elif current_node.left != None and current_node.right != None:
                    del_node = current_node.right
                    del_node_parent = current_node.right
                    while del_node.left != None:
                        del_node_parent = del_node
                        del_node = del_node.left
                    current_node.data = del_node.data
                    if del_node == del_node_parent:
                        current_node.right = del_node.right
                        return
                    if del_node.right == None:
                        del_node_parent.left = None
                        return
                    else:
                        del_node_parent.left = del_node.right
                        return
        return "Not Found"

    # BFS Traversal (Iterative)
    def BFS(self):
        current_node = self.root
        BFS_result = []
        queue = []
        queue.append(current_node)
        while len(queue) > 0:
            current_node = queue.pop(0)
            BFS_result.append(current_node.data)
            if current_node.left:
                queue.append(current_node.left)
            if current_node.right:
                queue.append(current_node.right)
        return BFS_result

    # BFS Traversal (Recursive)
    def Recursive_BFS(self, queue, BFS_list):
        if len(queue) == 0:
            return BFS_list
        current_node = queue.pop(0)
        BFS_list.append(current_node.data)
        if current_node.left:
            queue.append(current_node.left)
        if current_node.right:
            queue.append(current_node.right)
        return self.Recursive_BFS(queue, BFS_list)


if __name__ == "__main__":
    my_bst = BST()
    my_bst.insert(5)
    my_bst.insert(3)
    my_bst.insert(7)
    my_bst.insert(1)
    my_bst.insert(13)
    my_bst.insert(65)
    my_bst.insert(0)
    my_bst.insert(10)

    print(my_bst.BFS())
    print(my_bst.Recursive_BFS([my_bst.root], []))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the BFS and BST implementation!"
    set_color normal
    cat $output_file
end


function algoP.generate_dfs_bst134
    set output_file "main.py"
    set python_code '

class Node():
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

class BST():
    def __init__(self):
        self.root = None
        self.number_of_nodes = 0

    def insert(self, data):
        new_node = Node(data)
        if self.root == None:
            self.root = new_node
            self.number_of_nodes += 1
            return
        else:
            current_node = self.root
            while(current_node.left != new_node) and (current_node.right != new_node):
                if new_node.data > current_node.data:
                    if current_node.right == None:
                        current_node.right = new_node
                    else:
                        current_node = current_node.right
                elif new_node.data < current_node.data:
                    if current_node.left == None:
                        current_node.left = new_node
                    else:
                        current_node = current_node.left
            self.number_of_nodes += 1
            return

    def search(self, data):
        if self.root == None:
            return "Tree Is Empty"
        else:
            current_node = self.root
            while True:
                if current_node == None:
                    return "Not Found"
                if current_node.data == data:
                    return "Found"
                elif current_node.data > data:
                    current_node = current_node.left
                elif current_node.data < data:
                    current_node = current_node.right

    def remove(self, data):
        if self.root == None:
            return "Tree Is Empty"
        current_node = self.root
        parent_node = None
        while current_node != None:
            if current_node.data > data:
                parent_node = current_node
                current_node = current_node.left
            elif current_node.data < data:
                parent_node = current_node
                current_node = current_node.right
            else:
                if current_node.right == None:
                    if parent_node == None:
                        self.root = current_node.left
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.left
                            return
                        else:
                            parent_node.right = current_node.left
                            return
                elif current_node.left == None:
                    if parent_node == None:
                        self.root = current_node.right
                        return
                    else:
                        if parent_node.data > current_node.data:
                            parent_node.left = current_node.right
                            return
                        else:
                            parent_node.right = current_node.right
                            return
                elif current_node.left == None and current_node.right == None:
                    if parent_node == None:
                        current_node = None
                        return
                    if parent_node.data > current_node.data:
                        parent_node.left = None
                        return
                    else:
                        parent_node.right = None
                        return
                elif current_node.left != None and current_node.right != None:
                    del_node = current_node.right
                    del_node_parent = current_node.right
                    while del_node.left != None:
                        del_node_parent = del_node
                        del_node = del_node.left
                    current_node.data = del_node.data
                    if del_node == del_node_parent:
                        current_node.right = del_node.right
                        return
                    if del_node.right == None:
                        del_node_parent.left = None
                        return
                    else:
                        del_node_parent.left = del_node.right
                        return
        return "Not Found"

    # DFS Traversals
    def DFS_Inorder(self):
        return inorder_traversal(self.root, [])

    def DFS_Preorder(self):
        return preorder_traversal(self.root, [])

    def DFS_Postorder(self):
        return postorder_traversal(self.root, [])


def inorder_traversal(node, DFS_list):
    if node.left:
        inorder_traversal(node.left, DFS_list)
    DFS_list.append(node.data)
    if node.right:
        inorder_traversal(node.right, DFS_list)
    return DFS_list


def preorder_traversal(node, DFS_list):
    DFS_list.append(node.data)
    if node.left:
        preorder_traversal(node.left, DFS_list)
    if node.right:
        preorder_traversal(node.right, DFS_list)
    return DFS_list


def postorder_traversal(node, DFS_list):
    if node.left:
        postorder_traversal(node.left, DFS_list)
    if node.right:
        postorder_traversal(node.right, DFS_list)
    DFS_list.append(node.data)
    return DFS_list


if __name__ == "__main__":
    my_bst = BST()
    my_bst.insert(5)
    my_bst.insert(3)
    my_bst.insert(7)
    my_bst.insert(1)
    my_bst.insert(13)
    my_bst.insert(65)
    my_bst.insert(0)
    my_bst.insert(10)


    print(my_bst.DFS_Inorder())
    print(my_bst.DFS_Preorder())
    print(my_bst.DFS_Postorder())
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the DFS and BST implementation!"
    set_color normal
    cat $output_file
end



function algoP.generate_bisection135
    set output_file "main.py"
    set python_code '
def bisection_iter(n, arr):
    start = 0
    stop = len(arr)-1

    while start <= stop: 
        mid = (start + stop)//2
        if n == arr[mid]:
            return (f"{n} found at index {mid}")  

        elif n > arr[mid]:
            start = mid+1

        else:
            stop = mid-1

    return (f"{n} not found in list")

def create_list(max_val):
    arr = []
    for num in range(1, max_val+1):
        arr.append(num)

    return arr

if __name__ == "__main__":
    max = int(input("Enter the maximum length of the list: "))
    num_to_search = int(input("Enter the number you want to search for: "))
    l = create_list(max)
    print(bisection_iter(num_to_search, l))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Bisection (Binary Search) implementation!"
    set_color normal
    cat $output_file
end


function algoP.generate_recursive_bisection136
    set output_file "recursive_bisection_search.py"
    set python_code '
def bisection_recur(n, arr, start, stop):
    if start > stop: 
        return f"{n} not found in list" 
    else:
        mid = (start+stop)//2
        if n == arr[mid]:
            return f"{n} is found at index {mid}"
        
        elif n > arr[mid]:
            start = mid+1
            return bisection_recur(n, arr, start, stop)

        else:
            stop = mid-1
            return bisection_recur(n, arr, start, stop)

def create_list(max_val):
    arr = []
    for num in range(1, max_val+1):
        arr.append(num)

    return arr

if __name__ == "__main__":
    max = int(input("Enter the maximum length of the list: "))
    num_to_search = int(input("Enter the number you want to search for: "))
    l = create_list(max)
    print(l)
    print(bisection_recur(num_to_search, l, 0, len(l)-1))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created"
    set_color normal
    cat $output_file
end


function algoP.generate_student_script137
    set output_file "main.py"
    set python_code '
class Student:
    
    def __init__(self, first, last, courses=None):
        self.first_name = first
        self.last_name = last
        if courses == None:
            self.courses = []
        else:
            self.courses = courses

    def add_course(self, course):
        if course not in self.courses:
            self.courses.append(course)
        else:
            print(f"{self.first_name} is already enrolled in the {course} course")

    def remove_course(self, course):
        if course in self.courses:
            self.courses.remove(course)
        else:
            print(f"{course} not found")

    def find_in_file(self, filename):
        with open(filename) as f:
            for line in f:
                first_name, last_name, course_details = Student.prep_record(line.strip())
                student_read_in = Student(first_name, last_name, course_details)
                if self == student_read_in:
                    return True
            return False

    def add_to_file(self, filename):
        if self.find_in_file(filename):
            return "Record already exists"
        else:
            record_to_add = Student.prep_to_write(self.first_name, self.last_name, self.courses)
            with open(filename, "a+") as to_write:
                to_write.write(record_to_add+"\n")
            return "Record added"

    @staticmethod
    def prep_record(line):
        line = line.split(":")
        first_name, last_name = line[0].split(",")
        course_details = line[1].rstrip().split(",")
        return first_name, last_name, course_details


    def prep_to_write(first_name, last_name, courses):
        full_name = first_name + ',' + last_name
        courses = ",".join(courses)
        return full_name + ':' + courses

    def __eq__(self, other):
        return self.first_name == other.first_name and self.last_name == other.last_name

    def __len__(self):
        return len(self.courses)

    def __repr__(self):
        return f"Student('{self.first_name}','{self.last_name}',{self.courses})"

    def __str__(self):
        return f"First name: {self.first_name.capitalize()}\nLast name: {self.last_name.capitalize()}\
        \nCourses: {', '.join(map(str.capitalize, self.courses))}"

class StudentAthlete(Student):

    def __init__(self, first, last, courses=None, sport=None):
        super().__init__(first, last, courses)
        self.sport = sport

courses = ["python","ruby","javascript"]
jane = StudentAthlete("jane","doe",courses,"hockey")
print(jane.sport)
print(isinstance(jane, Student))

'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the Student and StudentAthlete classes!"
    set_color normal
    cat $output_file
end




function algoP.generate_dictionary138
    set output_file "main.py"

    set python_code '
my_dict = {num: num**2 for num in range(1, 11)}
print(my_dict)

random_dict = {
    "a": 1,
    "b": 2,
    "c": 3,
    "d": 4
}

my_new_dict = {k: v**2 for k, v in random_dict.items()}
print(my_new_dict)

my_new_dict2 = {k: v**2 for k, v in random_dict.items() if v % 2 == 0}
print(my_new_dict2)
'
    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.generate_enumerate139
    set output_file "enumerate_example.py"

    set python_code '
fruits = ["apple", "banana", "cherry", "grape"]
for index, fruit in enumerate(fruits, 1):
    print(index, fruit)
'
    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.generate_filter_map140
    set output_file "filter_map_example.py"
    set python_code '
def only_even(item):
    return item % 2 == 0

my_list = [5, 8, 9, 2, 5, 6, 98, 56, 62]

print(filter(only_even, my_list))
print(list(filter(only_even, my_list)))
print(list(map(only_even, my_list)))
print(my_list)
'
    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.generate_lambda_map_filter141
    set output_file "lambda_map_filter_reduce.py"

    set python_code '
import functools

my_list = [1, 2, 3, 4, 5]

print(list(map(lambda item: item * 2, my_list)))
print(list(filter(lambda item: item % 2 != 0, my_list)))
print(functools.reduce(lambda acc, item: acc + item, my_list))
'

    echo "$python_code" > $output_file
    echo "$output_file created successfully"
end


function algoP.generate_lambda_sort142
    set output_file "main.py"

    set python_code '
a = [(0,2), (4,4), (10,-1), (5,3)]

a.sort(key=lambda x: x[1], reverse=False)
print(a)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.enerate_list_comprehensions143
    set output_file "list_comprehensions_example.py"

    set python_code '
my_list = []

for item in "hello":
    my_list.append(item)

print(my_list)
my_list1 = [item for item in "Saurabh"]
print(my_list1)

my_list2 = [num**2 for num in range(1,11)]
print(my_list2)

my_set = {num**2 for num in range(1,11) if num**2 % 2 == 0}
print(my_set)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.multiply_by2_template144
    set output_file "multiply_by2_example.py"

    set python_code '
def multiply_by2(item):
    return item*2

my_list = [5,8,9]

print(map(multiply_by2, my_list))
print(list(map(multiply_by2, my_list)))
print(my_list)


def multiply_by2(li):
    new_li = []
    for item in li:
        new_li.append(item)
    return new_li

print(multiply_by2([5,6,8]))
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.accumulator145
    set output_file "accumulator_example.py"

    set python_code '
from functools import reduce

def accumulator(acc, item):
    print(f"acc: {acc}, item: {item}")
    return acc + item

my_list = [1, 2, 3, 4, 5]
print(reduce(accumulator, my_list))
print(reduce(accumulator, my_list, 10))
print(my_list)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.zip146
    set output_file "main.py.py"

    set python_code '
li1 = [1, 2, 3]
set1 = {4, 5, 6}
tuple1 = (7, 8, 9)

print(zip(li1, set1, tuple1))
print(list(zip(li1, set1, tuple1)))     # combines the items sequence wise into a sequence of tuples
print(li1, set1, tuple1)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.authenticated147
    set output_file "authenticated_example.py"

    set python_code '
user1 = {
    "name": "Sorna",
    "valid": True
}

def authenticated(fn):
    def wrapper(user, *args, **kwargs):
        if user.get("valid"):
            return fn(user, *args, **kwargs)
        else:
            print(f"User {user.get("name")} is not authorized!")
    return wrapper

@authenticated
def message_friends(user):
    print(f"Message has been sent by {user["name"]}")

message_friends(user1)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.decorator148
    set output_file "decorator_example.py"

    set python_code '
def my_decorator(func):
    def wrap_func():
        print("***********")
        func()
        print("***********")
    return wrap_func
@my_decorator
def hello():
    print("Hello!")

hello()
# my_decorator(hello)()
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.decorator_args149
    set output_file "decorator_args_example.py"

    set python_code '
def my_decorator(func):
    def wrap_func(*args, **kwargs):
        print("*********** Before Function ***********")
        func(*args, **kwargs)
        print("*********** After Function ***********")
    return wrap_func

@my_decorator
def hello(name, age):
    print(f"Hello {name}, your age is {age}.")

@my_decorator   
def logged_in(username):
    print(f"{username} is logged in.")

hello("saurabh", 21)
logged_in("saurabh")

# my_decorator(hello)("saurabh", 21)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.function_reference150
    set output_file "main.py"

    set python_code '
def hello():
    print("hello!")
greet = hello

del hello
print(greet)
greet()
'
    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.function_argument151
    set output_file "main.py"
    set python_code '

def hello(func):
    print("Calling the passed function...")
    func()

def greet():
    print("Hello!")

hello(greet)
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.bead_sort152
    set output_file "main.py"
    set python_code '


def bead_sort(sequence: list) -> list:
    if any(not isinstance(x, int) or x < 0 for x in sequence):
        raise TypeError("Sequence must be list of non-negative integers")
    for _ in range(len(sequence)):
        for i, (rod_upper, rod_lower) in enumerate(zip(sequence, sequence[1:])):
            if rod_upper > rod_lower:
                sequence[i] -= rod_upper - rod_lower
                sequence[i + 1] += rod_upper - rod_lower
    return sequence

if __name__ == "__main__":
    assert bead_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]
    assert bead_sort([7, 9, 4, 3, 5]) == [3, 4, 5, 7, 9]
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.binary_insertion_sort153
    set output_file "main.py"

    set python_code '
def binary_insertion_sort(collection: list) -> list:
    n = len(collection)
    for i in range(1, n):
        value_to_insert = collection[i]
        low = 0
        high = i - 1

        while low <= high:
            mid = (low + high) // 2
            if value_to_insert < collection[mid]:
                high = mid - 1
            else:
                low = mid + 1
        for j in range(i, low, -1):
            collection[j] = collection[j - 1]
        collection[low] = value_to_insert
    return collection


if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\\n").strip()
    try:
        unsorted = [int(item) for item in user_input.split(",")]
    except ValueError:
        print("Invalid input. Please enter valid integers separated by commas.")
        raise
    print(f"{binary_insertion_sort(unsorted) = }")
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.bitonic_sort154
    set output_file "main.py"

    set python_code '

from __future__ import annotations
def comp_and_swap(array: list[int], i: int, j: int, direction: int) -> None:
    if (direction == 1 and array[i] > array[j]) or (
        direction == 0 and array[i] < array[j]
    ):
        array[i], array[j] = array[j], array[i]

def bitonic_merge(array: list[int], low: int, length: int, direction: int) -> None:
    if length > 1:
        mid = length // 2
        for i in range(low, low + mid):
            comp_and_swap(array, i, i + mid, direction)
        bitonic_merge(array, low, mid, direction)
        bitonic_merge(array, low + mid, mid, direction)

def bitonic_sort(array: list[int], low: int, length: int, direction: int) -> None:
    if length > 1:
        mid = length // 2
        bitonic_sort(array, low, mid, 1)
        bitonic_sort(array, low + mid, mid, 0)
        bitonic_merge(array, low, length, direction)

if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\\n").strip()
    try:
        unsorted = [int(item.strip()) for item in user_input.split(",")]
    except ValueError:
        print("Invalid input. Please enter valid integers separated by commas.")
        raise

    if len(unsorted) & (len(unsorted) - 1) != 0:
        raise ValueError("Input size must be a power of 2.")

    bitonic_sort(unsorted, 0, len(unsorted), 1)
    print("Sorted array in ascending order:", unsorted)

    bitonic_sort(unsorted, 0, len(unsorted), 0)
    print("Sorted array in descending order:", unsorted)
'
    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.bubble_sort155
    set output_file "main.py"

    set python_code '
from typing import Any

def bubble_sort_iterative(collection: list[Any]) -> list[Any]:
    length = len(collection)
    for i in reversed(range(length)):
        swapped = False
        for j in range(i):
            if collection[j] > collection[j + 1]:
                swapped = True
                collection[j], collection[j + 1] = collection[j + 1], collection[j]
        if not swapped:
            break
    return collection

def bubble_sort_recursive(collection: list[Any]) -> list[Any]:
    length = len(collection)
    swapped = False
    for i in range(length - 1):
        if collection[i] > collection[i + 1]:
            collection[i], collection[i + 1] = collection[i + 1], collection[i]
            swapped = True
    return collection if not swapped else bubble_sort_recursive(collection)

if __name__ == "__main__":
    import doctest
    from random import sample
    from timeit import timeit

    doctest.testmod()
    num_runs = 10_000

    unsorted = sample(range(-50, 50), 100)
    timer_iterative = timeit(
        "bubble_sort_iterative(unsorted[:])",
        globals=globals(),
        number=num_runs,
    )
    print("\\nIterative bubble sort:")
    print(*bubble_sort_iterative(unsorted), sep=", ")
    print(f"Processing time (iterative): {timer_iterative:.5f}s for {num_runs:,} runs")

    unsorted = sample(range(-50, 50), 100)
    timer_recursive = timeit(
        "bubble_sort_recursive(unsorted[:])",
        globals=globals(),
        number=num_runs,
    )
    print("\\nRecursive bubble sort:")
    print(*bubble_sort_recursive(unsorted), sep=", ")
    print(f"Processing time (recursive): {timer_recursive:.5f}s for {num_runs:,} runs")
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.bucket_sort156
    set output_file "bucket_sort_example.py"
    set python_code '
from __future__ import annotations

def bucket_sort(my_list: list, bucket_count: int = 10) -> list:
    if len(my_list) == 0 or bucket_count <= 0:
        return []

    min_value, max_value = min(my_list), max(my_list)
    if min_value == max_value:
        return my_list

    bucket_size = (max_value - min_value) / bucket_count
    buckets: list[list] = [[] for _ in range(bucket_count)]

    for val in my_list:
        index = min(int((val - min_value) / bucket_size), bucket_count - 1)
        buckets[index].append(val)
    return [val for bucket in buckets for val in sorted(bucket)]


if __name__ == "__main__":
    from doctest import testmod
    testmod()
    assert bucket_sort([4, 5, 3, 2, 1]) == [1, 2, 3, 4, 5]
    assert bucket_sort([0, 1, -10, 15, 2, -2]) == [-10, -2, 0, 1, 2, 15]
    assert bucket_sort([1.1, 1.2, -1.2, 0, 2.4]) == [-1.2, 0, 1.1, 1.2, 2.4]
    assert bucket_sort([5, 5, 5, 5, 5]) == [5, 5, 5, 5, 5]
    assert bucket_sort([-5, -1, -6, -2]) == [-6, -5, -2, -1]
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.FirstRepeatedElementFinder157
    set output_file "main.py"
    set python_code '

def circle_sort(collection: list) -> list:
    if len(collection) < 2:
        return collection

    def circle_sort_util(collection: list, low: int, high: int) -> bool:
        swapped = False
        if low == high:
            return swapped

        left = low
        right = high

        while left < right:
            if collection[left] > collection[right]:
                collection[left], collection[right] = (
                    collection[right],
                    collection[left],
                )
                swapped = True
            left += 1
            right -= 1

        if left == right and collection[left] > collection[right + 1]:
            collection[left], collection[right + 1] = (
                collection[right + 1],
                collection[left],
            )
            swapped = True

        mid = low + (high - low) // 2
        left_swap = circle_sort_util(collection, low, mid)
        right_swap = circle_sort_util(collection, mid + 1, high)
        return swapped or left_swap or right_swap

    is_not_sorted = True
    while is_not_sorted:
        is_not_sorted = circle_sort_util(collection, 0, len(collection) - 1)
    return collection

arr = [5, 3, 8, 4, 2, 7, 1, 6]
sorted_arr = circle_sort(arr)
print("Sorted Array:", sorted_arr)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.cocktail_shaker_sort158
    set output_file "cocktail_shaker_sort_example.py"
    set python_code '

def cocktail_shaker_sort(arr: list[int]) -> list[int]:
    start, end = 0, len(arr) - 1

    while start < end:
        swapped = False
        for i in range(start, end):
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True

        if not swapped:
            break
        end -= 1

        for i in range(end, start, -1):
            if arr[i] < arr[i - 1]:
                arr[i], arr[i - 1] = arr[i - 1], arr[i]
                swapped = True

        if not swapped:
            break
        start += 1
    return arr

arr = [5, 3, 8, 4, 2, 7, 1, 6]
sorted_arr = cocktail_shaker_sort(arr)
print("Sorted Array:", sorted_arr)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.comb_sort159
    set output_file "main.py"

    set python_code '
def comb_sort(data: list) -> list:
    shrink_factor = 1.3
    gap = len(data)
    completed = False

    while not completed:
        gap = int(gap / shrink_factor)
        if gap <= 1:
            completed = True

        index = 0
        while index + gap < len(data):
            if data[index] > data[index + gap]:
                data[index], data[index + gap] = data[index + gap], data[index]
                completed = False
            index += 1

    return data
data = [5, 1, 7, 3, 2, 4, 6]
sorted_data = comb_sort(data)
print(sorted_data)

arr = [100, 50, 75, 25, 60, 30]
sorted_arr = comb_sort(arr)
print("Sorted Array:", sorted_arr)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.counting_sort160
    set output_file "main.py"

    set python_code '
def counting_sort(collection):
    if collection == []:
        return []

    coll_len = len(collection)
    coll_max = max(collection)
    coll_min = min(collection)

    counting_arr_length = coll_max + 1 - coll_min
    counting_arr = [0] * counting_arr_length

    for number in collection:
        counting_arr[number - coll_min] += 1
    for i in range(1, counting_arr_length):
        counting_arr[i] = counting_arr[i] + counting_arr[i - 1]
    ordered = [0] * coll_len
    for i in reversed(range(coll_len)):
        ordered[counting_arr[collection[i] - coll_min] - 1] = collection[i]
        counting_arr[collection[i] - coll_min] -= 1

    return ordered


def counting_sort_string(string):
    return "".join([chr(i) for i in counting_sort([ord(c) for c in string])])

arr = [4, 2, 2, 8, 3, 3, 1, 7]
sorted_arr = counting_sort(arr)
print("Sorted Array:", sorted_arr)


string = "dcbaabcd"
sorted_string = counting_sort_string(string)
print("Sorted String:", sorted_string)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
end


function algoP.cycle_sort161
    set output_file "main.py"

    set python_code '
def cycle_sort(array: list) -> list:
    array_len = len(array)
    for cycle_start in range(array_len - 1):
        item = array[cycle_start]

        pos = cycle_start
        for i in range(cycle_start + 1, array_len):
            if array[i] < item:
                pos += 1

        if pos == cycle_start:
            continue

        while item == array[pos]:
            pos += 1

        array[pos], item = item, array[pos]
        while pos != cycle_start:
            pos = cycle_start
            for i in range(cycle_start + 1, array_len):
                if array[i] < item:
                    pos += 1

            while item == array[pos]:
                pos += 1

            array[pos], item = item, array[pos]

    return array

arr = [5, 3, 8, 4, 2, 7, 1]
sorted_arr = cycle_sort(arr)
print("Sorted Array:", sorted_arr)

arr = [100, 50, 75, 25, 60, 30]
sorted_arr = cycle_sort(arr)
print("Sorted Array:", sorted_arr)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.cyclic_sort162
    set output_file "cyclic_sort.py"

    set python_code '

def cyclic_sort(nums: list[int]) -> list[int]:
    index = 0
    while index < len(nums):
        correct_index = nums[index] - 1
        if index != correct_index:
            nums[index], nums[correct_index] = nums[correct_index], nums[index]
        else:
            index += 1

    return nums


if __name__ == "__main__":
    import doctest

    doctest.testmod()
    user_input = input("Enter numbers separated by a comma:\n").strip()
    unsorted = [int(item) for item in user_input.split(",")]
    print(*cyclic_sort(unsorted), sep=",")
'

    echo "$python_code" > $output_file
    echo "$output_file created"
end



function algoP.bitonic_sort163
    set output_file "bitonic_sort_example.py"
    set python_code '
from __future__ import annotations


def comp_and_swap(array: list[int], i: int, j: int, direction: int) -> None:
    if (direction == 1 and array[i] > array[j]) or (
        direction == 0 and array[i] < array[j]
    ):
        array[i], array[j] = array[j], array[i]


def bitonic_merge(array: list[int], low: int, length: int, direction: int) -> None:
    if length > 1:
        mid = length // 2
        for i in range(low, low + mid):
            comp_and_swap(array, i, i + mid, direction)
        bitonic_merge(array, low, mid, direction)
        bitonic_merge(array, low + mid, mid, direction)


def bitonic_sort(array: list[int], low: int, length: int, direction: int) -> None:
    if length > 1:
        mid = length // 2
        bitonic_sort(array, low, mid, 1)
        bitonic_sort(array, low + mid, mid, 0)
        bitonic_merge(array, low, length, direction)


if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\\n").strip()
    try:
        unsorted = [int(item.strip()) for item in user_input.split(",")]
    except ValueError:
        print("Invalid input. Please enter valid integers separated by commas.")
        raise

    if len(unsorted) & (len(unsorted) - 1) != 0:
        raise ValueError("Input size must be a power of 2.")

    bitonic_sort(unsorted, 0, len(unsorted), 1)
    print("Sorted array in ascending order:", unsorted)

    bitonic_sort(unsorted, 0, len(unsorted), 0)
    print("Sorted array in descending order:", unsorted)
'
    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_dnf_sort164
    set output_file "dutch_national_flag_sort.py"
    set python_code '
red = 0  
white = 1 
blue = 2
colors = (red, white, blue)


def dutch_national_flag_sort(sequence: list) -> list:
   
    if not sequence:
        return []
    if len(sequence) == 1:
        return list(sequence)
    low = 0
    high = len(sequence) - 1
    mid = 0
    while mid <= high:
        if sequence[mid] == colors[0]:
            sequence[low], sequence[mid] = sequence[mid], sequence[low]
            low += 1
            mid += 1
        elif sequence[mid] == colors[1]:
            mid += 1
        elif sequence[mid] == colors[2]:
            sequence[mid], sequence[high] = sequence[high], sequence[mid]
            high -= 1
        else:
            msg = f"The elements inside the sequence must contains only {colors} values"
            raise ValueError(msg)
    return sequence


if __name__ == "__main__":
    import doctest

    doctest.testmod()

    user_input = input("Enter numbers separated by commas:\n").strip()
    unsorted = [int(item.strip()) for item in user_input.split(",")]
    print(f"{dutch_national_flag_sort(unsorted)}")
'

    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_exchange_sort165
    set output_file "exchange_sort.py"
    set python_code '
def exchange_sort(numbers: list[int]) -> list[int]:
   
    numbers_length = len(numbers)
    for i in range(numbers_length):
        for j in range(i + 1, numbers_length):
            if numbers[j] < numbers[i]:
                numbers[i], numbers[j] = numbers[j], numbers[i]
    return numbers

numbers = [5, 3, 8, 4, 2]
sorted_numbers = bubble_sort(numbers)
print(sorted_numbers)

'
    
    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_gnome_sort166
    set output_file "gnome_sort.py"

    set python_code '
def gnome_sort(lst: list) -> list:
    if len(lst) <= 1:
        return lst

    i = 1

    while i < len(lst):
        if lst[i - 1] <= lst[i]:
            i += 1
        else:
            lst[i - 1], lst[i] = lst[i], lst[i - 1]
            i -= 1
            if i == 0:
                i = 1

    return lst
numbers = [5, 3, 8, 4, 2]
sorted_numbers = gnome_sort(numbers)
print(sorted_numbers)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_heap_sort167
    set output_file "heap_sort.py"

    set python_code '
def heapify(unsorted: list[int], index: int, heap_size: int) -> None:
    largest = index
    left_index = 2 * index + 1
    right_index = 2 * index + 2
    if left_index < heap_size and unsorted[left_index] > unsorted[largest]:
        largest = left_index

    if right_index < heap_size and unsorted[right_index] > unsorted[largest]:
        largest = right_index

    if largest != index:
        unsorted[largest], unsorted[index] = (unsorted[index], unsorted[largest])
        heapify(unsorted, largest, heap_size)


def heap_sort(unsorted: list[int]) -> list[int]:
    n = len(unsorted)
    for i in range(n // 2 - 1, -1, -1):
        heapify(unsorted, i, n)
    for i in range(n - 1, 0, -1):
        unsorted[0], unsorted[i] = unsorted[i], unsorted[0]
        heapify(unsorted, 0, i)
    return unsorted

numbers = [5, 3, 8, 4, 2]
sorted_numbers = heap_sort(numbers)
print(sorted_numbers)

numbers = [10, 7, 7, 3, 1]
sorted_numbers = heap_sort(numbers)
print(sorted_numbers)

numbers = [1, 2, 3, 4, 5]
sorted_numbers = heap_sort(numbers)
print(sorted_numbers)

'

    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_insertion_sort168
    set output_file "insertion_sort.py"

    set python_code '
from collections.abc import MutableSequence
from typing import Any, Protocol, TypeVar


class Comparable(Protocol):
    def __lt__(self, other: Any, /) -> bool: ...


T = TypeVar("T", bound=Comparable)

def insertion_sort[T: Comparable](collection: MutableSequence[T]) -> MutableSequence[T]:
    for insert_index in range(1, len(collection)):
        insert_value = collection[insert_index]
        while insert_index > 0 and insert_value < collection[insert_index - 1]:
            collection[insert_index] = collection[insert_index - 1]
            insert_index -= 1
        collection[insert_index] = insert_value
    return collection

numbers = [5, 3, 8, 4, 2]
sorted_numbers = insertion_sort(numbers)
print(sorted_numbers)

words = ["apple", "orange", "banana", "pear", "grape"]
sorted_words = insertion_sort(words)
print(sorted_words)

numbers = [1, 2, 3, 4, 5]
sorted_numbers = insertion_sort(numbers)
print(sorted_numbers)


'
    echo "$python_code" > $output_file
    echo "$output_file created"
    python3 $output_file
end


function algoP.create_introsort169
    set output_file "introsort.py"

    set python_code '
import math

def insertion_sort(array: list, start: int = 0, end: int = 0) -> list:
    end = end or len(array)
    for i in range(start, end):
        value = array[i]
        j = i
        while j > start and value < array[j - 1]:
            array[j] = array[j - 1]
            j -= 1
        array[j] = value
    return array

array = [5, 3, 8, 4, 2]
sorted_sublist = insertion_sort(array, start=1, end=4)
print("Partially Sorted Array:", sorted_sublist)

array = [1, 2, 3, 4, 5]
sorted_array = insertion_sort(array)
print("Sorted Array:", sorted_array)


def heapify(array: list, index: int, heap_size: int) -> None:
    largest = index
    left = 2 * index + 1
    right = 2 * index + 2

    if left < heap_size and array[left] > array[largest]:
        largest = left
    if right < heap_size and array[right] > array[largest]:
        largest = right

    if largest != index:
        array[index], array[largest] = array[largest], array[index]
        heapify(array, largest, heap_size)

array = [4, 10, 3, 5, 1]
heapify(array, 0, len(array))
print("Max-Heap:", array)


def heap_sort(array: list) -> list:
    n = len(array)

    for i in range(n // 2, -1, -1):
        heapify(array, i, n)

    for i in range(n - 1, 0, -1):
        array[0], array[i] = array[i], array[0]
        heapify(array, 0, i)

    return array

array = [4, 10, 3, 5, 1]
sorted_array = heap_sort(array)
print("Sorted Array:", sorted_array)

def median_of_3(array: list, a: int, b: int, c: int):
    if (array[a] > array[b]) != (array[a] > array[c]):
        return array[a]
    elif (array[b] > array[a]) != (array[b] > array[c]):
        return array[b]
    else:
        return array[c]

array = [5, 2, 9, 8, 3]
pivot = median_of_3(array, 0, 2, 4)
print("Median of 3:", pivot)

def partition(array: list, low: int, high: int, pivot):
    i = low
    j = high
    while True:
        while array[i] < pivot:
            i += 1
        j -= 1
        while pivot < array[j]:
            j -= 1
        if i >= j:
            return i
        array[i], array[j] = array[j], array[i]
        i += 1


array = [3, 7, 1, 8, 5, 9, 2]
pivot = 5
low = 0
high = len(array) - 1
partition_index = partition(array, low, high, pivot)
print("Array after Partitioning:", array)
print("Partition Index:", partition_index)

# Example 2: Partitioning around Pivot 9
array = [3, 7, 1, 8, 5, 9, 2]
pivot = 9
low = 0
high = len(array) - 1
partition_index = partition(array, low, high, pivot)
print("Array after Partitioning:", array)
print("Partition Index:", partition_index)


def intro_sort(array: list, start: int, end: int, threshold: int, max_depth: int):
    while end - start > threshold:
        if max_depth == 0:
            return heap_sort(array)
        max_depth -= 1

        mid = start + (end - start) // 2
        pivot = median_of_3(array, start, mid, end - 1)
        p = partition(array, start, end, pivot)

        intro_sort(array, p, end, threshold, max_depth)
        end = p

    return insertion_sort(array, start, end)


def sort(array: list) -> list:
    if len(array) < 2:
        return array
    max_depth = 2 * math.ceil(math.log2(len(array)))
    return intro_sort(array, 0, len(array), 16, max_depth)


sorted_list_already = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
sorted_output = intro_sort(sorted_list_already, 0, len(sorted_list_already) - 1, 3, 2)
print("Already Sorted List:", sorted_output)

small_list = [4, 2, 7, 1, 3]
sorted_small_list = intro_sort(small_list, 0, len(small_list) - 1, 2, 2)
print("Sorted Small List:", sorted_small_list)

random_list = random.sample(range(1, 100), 15)
print("Original List:", random_list)

sorted_list = intro_sort(random_list, 0, len(random_list) - 1, 4, 2)
print("Sorted List:", sorted_list)
'

    echo "$python_code" > $output_file
    echo "$output_file created"

    python3 $output_file
end


function algoP.run_graphic_simulated_annealing170
    set python_file "simulated_annealing_fish.py"

    set python_code '
import math
import random
from matplotlib import pyplot as plt

class SearchProblem:
    def __init__(self, x, y, step_size, function_to_optimize):
        self.x = x
        self.y = y
        self.step_size = step_size
        self.function = function_to_optimize

    def score(self):
        return self.function(self.x, self.y)

    def get_neighbors(self):
        step = self.step_size
        neighbors = [
            (self.x-step, self.y-step), (self.x-step, self.y), (self.x-step, self.y+step),
            (self.x, self.y-step),                 (self.x, self.y+step),
            (self.x+step, self.y-step), (self.x+step, self.y), (self.x+step, self.y+step)
        ]
        return [SearchProblem(nx, ny, step, self.function) for nx, ny in neighbors]

def simulated_annealing(search_prob, find_max=True, max_x=math.inf, min_x=-math.inf,
                        max_y=math.inf, min_y=-math.inf, visualization=False,
                        start_temperate=100, rate_of_decrease=0.01, threshold_temp=1):
    current_state = search_prob
    current_temp = start_temperate
    best_state = current_state
    scores = []
    iterations = 0

    while current_temp > threshold_temp:
        scores.append(current_state.score())
        iterations += 1
        neighbors = current_state.get_neighbors()
        next_state = None
        while neighbors and next_state is None:
            index = random.randint(0, len(neighbors)-1)
            neighbor = neighbors.pop(index)
            if neighbor.x < min_x or neighbor.x > max_x or neighbor.y < min_y or neighbor.y > max_y:
                continue
            change = neighbor.score() - current_state.score()
            if not find_max:
                change *= -1
            if change > 0:
                next_state = neighbor
            else:
                if random.random() < math.exp(change/current_temp):
                    next_state = neighbor
        if next_state is None:
            break
        current_state = next_state
        if current_state.score() > best_state.score():
            best_state = current_state
        current_temp -= current_temp * rate_of_decrease

    if visualization:
        plt.plot(range(iterations), scores)
        plt.xlabel("Iterations")
        plt.ylabel("Function values")
        plt.show()
    return best_state

if __name__ == "__main__":
    def f1(x, y):
        return x**2 + y**2

    prob = SearchProblem(12, 47, 1, f1)
    min_state = simulated_annealing(prob, find_max=False, max_x=100, min_x=5, max_y=50, min_y=-5, visualization=True)
    print("Minimum score:", min_state.score())

    max_state = simulated_annealing(prob, find_max=True, max_x=100, min_x=5, max_y=50, min_y=-5, visualization=True)
    print("Maximum score:", max_state.score())
'

    # write to file and run
    echo "$python_code" > $python_file
    python3 $python_file
end




function algoP.run_ternary_search171
    set python_file "ternary_search_fish.py"

    set python_code '
from __future__ import annotations
precision = 10

def lin_search(left: int, right: int, array: list[int], target: int) -> int:
    for i in range(left, right):
        if array[i] == target:
            return i
    return -1

def ite_ternary_search(array: list[int], target: int) -> int:
    left = 0
    right = len(array)
    while left <= right:
        if right - left < precision:
            return lin_search(left, right, array, target)
        one_third = (left + right)//3 + 1
        two_third = 2*(left + right)//3 + 1
        if array[one_third] == target: return one_third
        elif array[two_third] == target: return two_third
        elif target < array[one_third]: right = one_third - 1
        elif array[two_third] < target: left = two_third + 1
        else: left = one_third + 1; right = two_third - 1
    return -1

def rec_ternary_search(left: int, right: int, array: list[int], target: int) -> int:
    if left < right:
        if right - left < precision: return lin_search(left, right, array, target)
        one_third = (left + right)//3 + 1
        two_third = 2*(left + right)//3 + 1
        if array[one_third] == target: return one_third
        elif array[two_third] == target: return two_third
        elif target < array[one_third]: return rec_ternary_search(left, one_third-1, array, target)
        elif array[two_third] < target: return rec_ternary_search(two_third+1, right, array, target)
        else: return rec_ternary_search(one_third+1, two_third-1, array, target)
    else: return -1

array = [1, 3, 4, 6, 8, 10, 13, 15, 17, 20, 22, 30]
target = 15
result = ite_ternary_search(array, target)
print(result)  # Output: 7 (index of 15)

result = rec_ternary_search(0, len(array)-1, array, target)
print(result)  # Output: 7 (index of 15)

large_array = list(range(1, 101))  # Array from 1 to 100
target = 47
precision = 5  # Set precision to 5 for faster convergence to linear search

result = ite_ternary_search(large_array, target)
print(result)  # Output: 46 (index of 47)

small_array = [10, 20, 30, 40, 50]
target = 30
precision = 2 

result = rec_ternary_search(0, len(small_array)-1, small_array, target)
print(result)

'

    echo "$python_code" > $python_file
    python3 $python_file
end



function algoP.run_binary172
    set python_file "main.py"

    set python_code '
def binary_and(a: int, b: int) -> str:
    if a < 0 or b < 0:
        raise ValueError("the value of both inputs must be positive")
    a_binary = format(a, "b")
    b_binary = format(b, "b")
    max_len = max(len(a_binary), len(b_binary))
    return "0b" + "".join(
        str(int(char_a == "1" and char_b == "1"))
        for char_a, char_b in zip(a_binary.zfill(max_len), b_binary.zfill(max_len))
    )
a = 5  # Binary: 101
b = 3  # Binary: 011
result = binary_and(a, b)
print(result)

a = 10  # Binary: 1010
b = 6   # Binary: 0110
result = binary_and(a, b)
print(result)

a = 1  # Binary: 1
b = 1  # Binary: 1
result = binary_and(a, b)
print(result)

a = 4  # Binary: 100
b = 0  # Binary: 0
result = binary_and(a, b)
print(result)


try:
    a = -5
    b = 3
    result = binary_and(a, b)
    print(result)
except ValueError as e:
    print(e)

a = 7  # Binary: 111
b = 7  # Binary: 111
result = binary_and(a, b)
print(result)

'
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_bcd173
    set python_file "binary_coded_decimal_fish.py"

    set python_code '
def binary_coded_decimal(number: int) -> str:
    return "0b" + "".join(
        str(bin(int(digit)))[2:].zfill(4) for digit in str(max(0, number))
    )

number = 123
bcd_representation = binary_coded_decimal(number)
print(bcd_representation)

'

    # write python code to file and execute
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_count_bits174
    set python_file "binary_count_setbits_fish.py"

    set python_code '
def binary_count_setbits(a: int) -> int:
    if a < 0:
        raise ValueError("Input value must be a positive integer")
    elif isinstance(a, float):
        raise TypeError("Input value must be a '\''int'\'' type")
    return bin(a).count("1")

a = 13  # Binary representation: 1101
result = binary_count_setbits(a)
print(result)  # Output: 3

a = 0  # Binary representation: 0
result = binary_count_setbits(a)
print(result)  # Output: 0

try:
    a = -10
    result = binary_count_setbits(a)
except ValueError as e:
    print(e)  # Output: Input value must be a positive integer

a = 255  # Binary representation: 11111111
result = binary_count_setbits(a)
print(result)  # Output: 8

'

    # Write the Python code to a file and execute it
    echo "$python_code" > $python_file
    python3 $python_file
end



function algoP.run_trailing_zeros175
    set python_file "binary_count_trailing_zeros_fish.py"

    set python_code '
from math import log2

def binary_count_trailing_zeros(a: int) -> int:
    if a < 0:
        raise ValueError("Input value must be a positive integer")
    elif isinstance(a, float):
        raise TypeError("Input value must be a '\''int'\'' type")
    return 0 if (a == 0) else int(log2(a & -a))

a = 8  # Binary representation: 1000
result = binary_count_trailing_zeros(a)
print(result)  # Output: 3

a = 16  # Binary representation: 10000
result = binary_count_trailing_zeros(a)
print(result)  # Output: 4

'
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_binary_or176
    set python_file "binary_or_fish.py"

    set python_code '
def binary_or(a: int, b: int) -> str:
    if a < 0 or b < 0:
        raise ValueError("the value of both inputs must be positive")
    a_binary = str(bin(a))[2:]  # remove the leading "0b"
    b_binary = str(bin(b))[2:]
    max_len = max(len(a_binary), len(b_binary))
    return "0b" + "".join(
        str(int("1" in (char_a, char_b)))
        for char_a, char_b in zip(a_binary.zfill(max_len), b_binary.zfill(max_len))
    )

a = 5  # Binary representation: 101
b = 3  # Binary representation: 011
result = binary_or(a, b)
print(result)  # Output: 0b111

a = 10  # Binary representation: 1010
b = 6   # Binary representation: 0110
result = binary_or(a, b)
print(result)  # Output: 0b1110

a = 0  # Binary representation: 0
b = 5  # Binary representation: 101
result = binary_or(a, b)
print(result)  # Output: 0b101

'
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_binary_shifts177
    set python_file "binary_shifts_fish.py"

    set python_code '
def logical_left_shift(number: int, shift_amount: int) -> str:
    if number < 0 or shift_amount < 0:
        raise ValueError("both inputs must be positive integers")
    binary_number = str(bin(number))
    binary_number += "0" * shift_amount
    return binary_number

def logical_right_shift(number: int, shift_amount: int) -> str:
    if number < 0 or shift_amount < 0:
        raise ValueError("both inputs must be positive integers")
    binary_number = str(bin(number))[2:]
    if shift_amount >= len(binary_number):
        return "0b0"
    shifted_binary_number = binary_number[: len(binary_number) - shift_amount]
    return "0b" + shifted_binary_number

def arithmetic_right_shift(number: int, shift_amount: int) -> str:
    if number >= 0:
        binary_number = "0" + str(bin(number)).strip("-")[2:]
    else:
        binary_number_length = len(bin(number)[3:])
        binary_number = bin(abs(number) - (1 << binary_number_length))[3:]
        binary_number = "1" + "0" * (binary_number_length - len(binary_number)) + binary_number
    if shift_amount >= len(binary_number):
        return "0b" + binary_number[0] * len(binary_number)
    return "0b" + binary_number[0] * shift_amount + binary_number[: len(binary_number) - shift_amount]

a = 5
shift = 2
print(logical_left_shift(a, shift))  # Output: 0b10100

logical_right_shift(13, 2)
a = 13
shift = 2
print(logical_right_shift(a, shift))  # Output: 0b11
arithmetic_right_shift(-8, 2)

a = 5  # Binary: 101
shift_amount = 2
result = logical_left_shift(a, shift_amount)
print(result)  # Output: 0b10100

a = 13  # Binary: 1101
shift_amount = 2
result = logical_right_shift(a, shift_amount)
print(result)  # Output: 0b11

a = -8  # Binary: -1000
shift_amount = 2
result = arithmetic_right_shift(a, shift_amount)
print(result)  # Output: 0b11100

'
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_two_complement178
    set python_file "main.py"

    set python_code '
def twos_complement(number: int) -> str:
    if number > 0:
        raise ValueError("input must be a negative integer")
    if number == 0:
        return "0b0"
    binary_number_length = len(bin(number)[3:])
    twos_complement_number = bin(abs(number) - (1 << binary_number_length))[3:]
    twos_complement_number = "1" + "0" * (binary_number_length - len(twos_complement_number)) + twos_complement_number
    return "0b" + twos_complement_number

print(twos_complement(-8))  # Output: 0b11111000
print(twos_complement(0))   # Output: 0b0

'
    echo "$python_code" > $python_file
    python3 $python_file
end



function algoP.k_largest_elements179
    set output_file "main.py"

    set template_content '


class Heap:

    def __init__(
        self, elements: List[Any] = None, element_priority=lambda x: x
    ) -> None:
        self._priority = element_priority
        if elements is not None and len(elements) > 0:
            self._heapify(elements)
        else:
            self._elements = []

    def __len__(self) -> int:
        return len(self._elements)

    def _has_lower_priority(self, element_1: Any, element_2: Any) -> bool:
        return self._priority(element_1) < self._priority(element_2)

    def _has_higher_priority(self, element_1: Any, element_2: Any) -> bool:
        return self._priority(element_1) > self._priority(element_2)

    def _validate(self) -> bool:
        current_index = 0
        first_leaf = self._first_leaf_index()
        while current_index < first_leaf:
            current_element: float = self._elements[current_index]
            first_child = self._left_child_index(current_index)
            last_child_guard = min(first_child + 2, len(self))
            for child_index in range(first_child, last_child_guard):
                if self._has_lower_priority(
                    current_element, self._elements[child_index]
                ):
                    return False  # pragma: no cover
            current_index += 1
        return True

    def _left_child_index(self, index) -> int:
        return index * 2 + 1

    def _parent_index(self, index: int) -> int:
        return (index - 1) // 2

    def _highest_priority_child_index(self, index: int) -> Optional[int]:
        first_index = self._left_child_index(index)

        if first_index >= len(self):
            # The current element has no children
            return None

        if first_index + 1 >= len(self):
            # The current element only has one child
            return first_index

        if self._has_higher_priority(
            self._elements[first_index], self._elements[first_index + 1]
        ):
            return first_index
        else:
            return first_index + 1

    def _first_leaf_index(self):
        return len(self) // 2

    def _push_down(self, index: int) -> None:

        # INVARIANT: 0 <= index < n
        assert 0 <= index < len(self._elements)
        element = self._elements[index]
        current_index = index
        while True:
            child_index = self._highest_priority_child_index(current_index)
            if child_index is None:
                break
            if self._has_lower_priority(element, self._elements[child_index]):
                self._elements[current_index] = self._elements[child_index]
                current_index = child_index
            else:
                break

        self._elements[current_index] = element

    def _bubble_up(self, index: int) -> None:
        # INVARIANT: 0 <= index < n
        assert 0 <= index < len(self._elements)
        element = self._elements[index]
        while index > 0:
            parent_index = self._parent_index(index)
            parent = self._elements[parent_index]
            if self._has_higher_priority(element, parent):
                self._elements[index] = parent
                index = parent_index
            else:
                break

        self._elements[index] = element

    def _heapify(self, elements: List[Any]) -> None:
        self._elements = elements[:]
        last_inner_node_index = self._first_leaf_index() - 1
        for index in range(last_inner_node_index, -1, -1):
            self._push_down(index)

    def is_empty(self) -> bool:
        return len(self) == 0

    def top(self) -> Any:
        if self.is_empty():
            raise ValueError("Method top called on an empty heap.")
        if len(self) == 1:
            element = self._elements.pop()
        else:
            element = self._elements[0]
            self._elements[0] = self._elements.pop()
            self._push_down(0)

        return element

    def peek(self) -> Any:
        if self.is_empty():
            raise ValueError("Method peek called on an empty heap.")
        return self._elements[0]

    def insert(self, element: Any) -> None:
        self._elements.append(element)
        self._bubble_up(len(self._elements) - 1)

def k_largest_elements(arr, k):
    heap = Heap(element_priority=lambda x: -x[1])
    for i in range(len(arr)):
        if len(heap) >= k:
            if heap.peek()[1] < arr[i]:
                heap.top()
                heap.insert((i, arr[i]))
                heap._validate()
        else:
            heap.insert((i, arr[i]))
    return [heap.top() for _ in range(k)]

if __name__ == '__main__':
    arr = [55, 71, 43, 59, 10, 20, 15, 44, 11, 234, 23,-45]
    print(k_largest_elements(arr, 6))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GroupAnagrams180
    set output_file "main.py"

    set template_content '
class Solution(object):
    def groupAnagrams(self, strs):
        result = {}
        for i in strs:
            key = ''.join(sorted(i))    
            try:
                result[key].append(i)
            except:
                result[key] = [i]
        return result.values()
strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
solution = Solution()
print(solution.groupAnagrams(strs))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HammingDistance181
    set output_file "main.py"

    set template_content '
class Solution(object):
    def hammingDistance(self, x, y):
        return str(bin(x ^ y)).count('1')
x = 1
y = 4

solution = Solution()
print(solution.hammingDistance(x, y)) 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobber182
    set output_file "main.py"

    set template_content '
class Solution(object):
    def rob(self, nums):
       
        if not nums:
            return 0
        
        if len(nums) <= 2:
            return max(nums)
        
        robber = [nums[0], nums[1], nums[2] + nums[0]]
        
        for i in range(3, len(nums)):
            robber.append(max(nums[i] + robber[i-2], nums[i] + robber[i-3]))

        return max(robber)
nums = [2, 7, 9, 3, 1]
solution = Solution()
print(solution.rob(nums))  # Output: 12

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HouseRobberII_183
    set output_file "main.py"

    set template_content '
class Solution(object):
    def rob(self, nums):
      
        if not nums:
            return 0
        
        if len(nums) <= 3:
            return max(nums)
        
        if len(nums) <= 4:
            return max(max(nums), nums[1]+nums[-1], nums[2]+nums[0])
        
        robber = [nums[0], nums[1], nums[2]+nums[0]]
        
        for i in range(3, len(nums)-1):
            robber.append(max(nums[i] + robber[i-2], nums[i] + robber[i-3]))
        
        maxes = max(robber)
        
        nums = [nums[-1]] + nums
        nums.pop()

        robber = [nums[0], nums[1], nums[2]+nums[0]]
        
        for i in range(3, len(nums)-1):
            robber.append(max(nums[i] + robber[i-2], nums[i] + robber[i-3]))
        
        
        return max(robber+[maxes])

nums = [2, 3, 2]
solution = Solution()
print(solution.rob(nums))  # Output: 3

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ImplementQueueUsingStack184
    set output_file "main.py"

    set template_content '
from GetMinStack import Stack


class Queue:

    def __init__(self):
        self.stack_one = Stack()
        self.stack_two = Stack()

    def push(self, value):
        if self.stack_two.empty():
            self.stack_two.push(value)
        else:
            self.stack_one.push(value)

    def pop(self):

        pop_result = self.stack_two.pop()
        if self.stack_two.empty():
            while 1:
                if self.stack_one.empty():
                    break

                self.stack_two.push(self.stack_one.pop())

        return pop_result

    def peek(self):

        return self.stack_two.get_top()


queue = Queue()

queue.push(1)
queue.push(2)
queue.push(3)

print(queue.pop())
queue.push(4)
print(queue.pop())
print(queue.pop())
print(queue.pop())

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ImplementStr185
    set output_file "main.py"

    set template_content '
class Solution(object):
    def strStr(self, haystack, needle):
        
        if not needle:
            return 0
        
        lengthHaystack = len(haystack)
        lengthNeedle = len(needle)
        
        if lengthNeedle > lengthHaystack:
            return -1
        
        if lengthNeedle == lengthHaystack:
            return 0 if haystack == needle else -1
        
        for i, d in enumerate(haystack):
            if lengthHaystack - i < lengthNeedle:
                return -1
            
            if d == needle[0]:
                if haystack[i:i+lengthNeedle] == needle:
                    return i
# Example usage
haystack = "hello"
needle = "ll"
solution = Solution()
print(solution.strStr(haystack, needle))  # Output: 2

# Case where needle is empty
haystack = "hello"
needle = ""
print(solution.strStr(haystack, needle))  # Output: 0

# Case where needle is not in haystack
haystack = "hello"
needle = "world"
print(solution.strStr(haystack, needle))  # Output: -1

# Case where needle is the same as haystack
haystack = "hello"
needle = "hello"
print(solution.strStr(haystack, needle))  # Output: 0

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IncreasingTripletSubsequence186
    set output_file "main.py"

    set template_content '
class Solution(object):
    def increasingTriplet(self, nums):
       
        
        if len(nums) < 3:
            return False
        
        one = None
        two = None
        for i, d in enumerate(nums):
            if one:
                if d <= one[1]:
                    one = (i, d)
                    continue
                    
                if two:
                    if d <= two[1]:
                        two = (i, d)
                    else:
                        return True
                else:
                    two = (i, d)
            else:
                one = (i, d)
        return False


nums = [1, 2, 3, 4, 5]
solution = Solution()
print(solution.increasingTriplet(nums))  # Output: True

nums = [5, 4, 3, 2, 1]
print(solution.increasingTriplet(nums))  # Output: False

nums = [1, 2]
print(solution.increasingTriplet(nums))  # Output: False

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InsertDeleteGetRandom187
    set output_file "main.py"

    set template_content '
import random

class RandomizedSet(object):

    def __init__(self):
     
        self.data_dict = {}
        self.data_list = []
        self.length = 0

    def insert(self, val):
     
        if self.data_dict.get(val) is not None:
            return False
        
        self.data_dict[val] = self.length
        self.length += 1
        self.data_list.append(val)
        
        return True
    
    def remove(self, val):
       
        
        if self.data_dict.get(val) is not None:
            x = self.data_dict.pop(val)
            y = self.data_list[-1]
            if y != val:

                self.data_dict[y] = x
            self.data_list[-1], self.data_list[x] = self.data_list[x], self.data_list[-1]
            
            self.data_list.pop()
            self.length -= 1

            return True
        
        return False
        
    def getRandom(self):
      
        
        return self.data_list[random.randint(0, self.length-1)]


obj = RandomizedSet()
param_1 = obj.insert(val)
param_2 = obj.remove(val)
param_3 = obj.getRandom()

print(param_1) 
print(param_2) 
print(param_3)

obj = RandomizedSet()

print(obj.insert(1))  # Output: True (1 inserted)
print(obj.insert(2))  # Output: True (2 inserted)
print(obj.insert(3))  # Output: True (3 inserted)

print(obj.remove(2))  # Output: True (2 removed)

print(obj.getRandom())  # Output: Random number (either 1 or 3)

print(obj.remove(1))  # Output: True (1 removed)

print(obj.getRandom())  # Output: 3

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.insert_interval_188
    set output_file "main.py"

    set template_content '
class Interval(object):
     def __init__(self, s=0, e=0):
         self.start = s
         self.end = e

class Solution(object):
    def insert(self, _sentences, newInterval):
        _sentences.append(newInterval)
        _sentences = sorted(_sentences, key=lambda x: x.start)

        if not _sentences:
            return []

        result = []

        head = _sentences[0].start
        tail = _sentences[0].end
        length = len(_sentences)
        for x in range(1, length):
            i = _sentences[x]
            if tail >= i.start:
                tail = max(tail, i.end)
            else:
                result.append([head, tail])
                head = i.start
                tail = i.end

        result.append([head, tail])
        return result
sol = Solution()

intervals = [Interval(1, 3), Interval(6, 9)]
new_interval = Interval(2, 5)

result = sol.insert(intervals, new_interval)
for interval in result:
    print(interval)

intervals = [Interval(1, 3), Interval(6, 9)]
new_interval = Interval(2, 5)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InterleavingString189
    set output_file "main.py"

    set template_content '
class Solution(object):
    def isInterleave(self, s1, s2, s3): 
        if len(s3) != len(s1) + len(s2):
            return False
        
        if not s3:
            return True
        
        dp = {}
        
        # s3 index, s1, s2
        for i, d in enumerate(s3):
            if i == 0:
                temp = []
                if s1 and s1[0] == d:
                    temp.append((s1[1:], s2))
                if s2 and s2[0] == d:
                    temp.append((s1, s2[1:]))
                dp[str(i)] = temp
                continue
                
            temp = []
            if dp[str(i-1)]:
                for j in dp[str(i-1)]:
                    s1, s2 = j[0], j[1]
                    if s1 and s1[0] == d:
                        if (s1[1:], s2) not in temp:
                            temp.append((s1[1:], s2))
                    if s2 and s2[0] == d:
                        if (s1, s2[1:]) not in temp:
                            temp.append((s1, s2[1:]))
                    dp[str(i)] = temp
            else:
                return False
            # print(len(dp[str(i-1)]))
            del dp[str(i-1)]

            # print(dp)
        try:
            for i in dp[str(len(s3)-1)]:
                if not any(i):
                    return True
            else:
                return False
        except KeyError:
            return False

print(Solution().isInterleave('c'*500+'d', 'c'*500+'d', 'c'*1000+'dd'))
sol = Solution()
print(sol.isInterleave('c'*500+'d', 'c'*500+'d', 'c'*1000+'dd'))  # Should return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IntersectionOfTwoArrays190
    set output_file "main.py"

    set template_content '
class Solution(object):
    def intersection(self, nums1, nums2):
      
        return list(set(nums1) & set(nums2))

solution = Solution()
nums1 = [1, 2, 2, 1]
nums2 = [2, 2]
print(solution.intersection(nums1, nums2))  # Output: [2]


nums1 = [4, 9, 5]
nums2 = [9, 4, 9, 8, 4]
print(solution.intersection(nums1, nums2))  # Output: [9, 4]

nums1 = []
nums2 = [1, 2, 3]
print(solution.intersection(nums1, nums2))  # Output: []

nums1 = [1, 2, 3]
nums2 = [4, 5, 6]
print(solution.intersection(nums1, nums2))  # Output: []
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.IntersectionOfTwoArraysII_191
    set output_file "main.py"

    set template_content '
class Solution(object):
    def intersect(self, nums1, nums2):
        result = []
    
    
        nums1.sort()
        nums2.sort()
        
        _n1 = 0
        _n2 = 0
        
        _n1_length = len(nums1)
        _n2_length = len(nums2)
        
        while _n1 < _n1_length and _n2 < _n2_length:
            if nums1[_n1] == nums2[_n2]:
                result.append(nums1[_n1])
                _n1 += 1
                _n2 += 1
            
            elif nums1[_n1] < nums2[_n2]:
                _n1 += 1
            else:
                _n2 += 1
        
        return result

solution = Solution()
nums1 = [1, 2, 2, 1]
nums2 = [2, 2]
print(solution.intersect(nums1, nums2))  # Output: [2, 2]

nums1 = [4, 9, 5]
nums2 = [9, 4, 9, 8, 4]
print(solution.intersect(nums1, nums2))  # Output: [4, 9]       
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IntersectionOfTwoLinkedLists192
    set output_file "main.py"

    set template_content '
class ListNode(object):
    __slots__ = ('val', 'next')
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution(object):
    def getIntersectionNode(self, headA, headB):
        a = headA
        b = headB
        
        if not a or not b:
            return None
        
        while a != b:
            
            a = headB if a is None else a.next
            b = headA if b is None else b.next
        
        return a

# Example 1: Intersection at node with value 8
# List A: 4 -> 1 -> 8 -> 4 -> 5
# List B: 5 -> 6 -> 1 -> 8 -> 4 -> 5
# Intersection at node with value 8

headA = ListNode(4)
headA.next = ListNode(1)
headA.next.next = ListNode(8)
headA.next.next.next = ListNode(4)
headA.next.next.next.next = ListNode(5)

headB = ListNode(5)
headB.next = ListNode(6)
headB.next.next = ListNode(1)
headB.next.next.next = headA.next.next  # Intersection starts at node with value 8

solution = Solution()
intersection = solution.getIntersectionNode(headA, headB)
print(intersection.val)  # Output: 8

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.IsomorphicStrings193
    set output_file "main.py"

    set template_content '
class Solution(object):
    def isIsomorphic(self, s, t):
      
        s_k = 0
        t_k = 0
        s_d = {}
        t_d = {}
        new_s = ''
        new_t = ''
        for i in s:
            if s_d.get(i):
                new_s += s_d.get(i)
            else:
                s_d[i] = str(s_k)
                s_k += 1
        for i in t:
            if t_d.get(i):
                new_t += t_d.get(i)
            else:
                t_d[i] = str(t_k)
                t_k += 1
        
        return new_s == new_t


return len(set(zip(s, t))) == len(set(s)) and len(set(zip(t, s))) == len(set(t))

class Solution(object):
    def isIsomorphic(self, s, t):
        
        s_k = 0
        t_k = 0
        s_d = {}
        t_d = {}
        for i in zip(s, t):
            if s_d.get(i[0]):
                s_k2 = s_d.get(i[0])
            else:
                s_k2 = s_d[i[0]] = str(s_k)
                s_k += 1

            if t_d.get(i[1]):
                t_k2 = t_d.get(i[1])
            else:
                t_k2 = t_d[i[1]] = str(t_k)
                # t_k2 = t_d.get(i[1])
                t_k += 1
                
            if s_k2 != t_k2:
                return False
        return True

s = "egg"
t = "add"

solution = Solution()
print(solution.isIsomorphic(s, t))  # Output: True

s = "foo"
t = "bar"

solution = Solution()
print(solution.isIsomorphic(s, t))  # Output: False


class Solution1(object):
    def isIsomorphic(self, s, t):
        return len(set(zip(s, t))) == len(set(s)) and len(set(zip(t, s))) == len(set(t))

s = "egg"
t = "add"

solution = Solution1()
print(solution.isIsomorphic(s, t))  # Output: True

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JewelsAndStones194
    set output_file "main.py"

    set template_content '
class Solution(object):
    def numJewelsInStones(self, J, S):
       
        S_dict = {i:S.count(i) for i in set(S)}
        
        return sum((S_dict.get(i, 0) for i in J))

J = "aA"   # Jewels (characters that are considered as jewels)
S = "aAAbbbb"  # Stones (characters that may contain jewels)

solution = Solution()
print(solution.numJewelsInStones(J, S))  # Output: 3

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.JumpGame195
    set output_file "main.py"

    set template_content '
class Solution(object):
    def canJump(self, nums):
        dp = [nums[0]]
        current_index = 0
        
        while 1:
            if current_index + dp[-1] >= len(nums)-1:
                return True
            base = 0
            index = current_index
            for i in range(current_index, current_index+dp[-1]+1):
                if nums[i] + i > base:
                    base = nums[i] + i
                    index = i
            
            if current_index == index:
                return False
            
            current_index = index
            dp.append(base-index)

class Solution(object):
    def canJump(self, nums):
        farthest = 0
        for i in range(len(nums)):
            if i > farthest:
                return False
            farthest = max(farthest, i + nums[i])
        return True


nums = [2, 3, 1, 1, 4]
solution = Solution()
print(solution.canJump(nums))  # Output: True

nums = [3, 2, 1, 0, 4]
solution = Solution()
print(solution.canJump(nums))  # Output: False

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JumpGameII_196
    set output_file "main.py"

    set template_content '
class Solution(object):
    def jump(self, nums):
     
        if len(nums) == 1:
            return 0
        
        # dp = [nums[0]]
        maxes = nums[0]
        count = 1
        current_index = 0
        length = len(nums) - 1
        while 1:
            if current_index + maxes >= length:
                return count
            base = 0
            index = current_index
            for i in xrange(current_index, current_index+maxes+1):
                if nums[i] + i > base:
                    base = nums[i] + i
                    index = i
                      
            current_index = index
            maxes = base-index
            count += 1

nums = [2, 3, 1, 1, 4]
solution = Solution()
print(solution.canJump(nums))  # Output: True

nums = [3, 2, 1, 0, 4]
solution = Solution()
print(solution.canJump(nums))  # Output: False

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthLargestElementInArray197
    set output_file "main.py"

    set template_content '
class Solution(object):

    def quickSort(self, unsorted_list):
        if len(unsorted_list) <= 1:
            return unsorted_list

        left = []
        right = []

        meta = self._getMiddle(unsorted_list)
        for i in unsorted_list[:meta] + unsorted_list[meta+1:]:
            if i <= unsorted_list[meta]:
                left.append(i)
                continue
            right.append(i)

        return self.quickSort(left) + [unsorted_list[meta]] + self.quickSort(right)

    def _getMiddle(self, unsorted_list):
        
        if len(unsorted_list) < 3:
            return 0

        left = unsorted_list[0]
        right = unsorted_list[-1]
        middle = unsorted_list[len(unsorted_list) // 2]
        l, r, m = [(0, left), (len(unsorted_list) - 1, right), (len(unsorted_list) // 2, middle)]
        return sorted([l, r, m], key=lambda x: x[1])[1][0]


    def mergeSort(self, unsorted_list, key=None):
        if len(unsorted_list) <= 1:
            return unsorted_list

        break_point = len(unsorted_list) // 2

        left = self.mergeSort(unsorted_list[:break_point])
        right = self.mergeSort(unsorted_list[break_point:])

        return self._decomposeAndMerge(left, right, key=key)

    def _decomposeAndMerge(self, unsorted_list_A, unsorted_list_B, key):
        sorted_list = []
        a = 0
        b = 0
        length_A = len(unsorted_list_A)
        length_B = len(unsorted_list_B)
        while a < length_A and b < length_B:

            if unsorted_list_A[a] <= unsorted_list_B[b]:
                sorted_list.append(unsorted_list_A[a])
                a += 1
            else:
                sorted_list.append(unsorted_list_B[b])
                b += 1            
        if a < length_A:
            sorted_list.extend(unsorted_list_A[a:])
        else:
            sorted_list.extend(unsorted_list_B[b:])

        return sorted_list


    def findKthLargest(self, nums, k):
        return sorted(nums, reverse=True)[k-1]

sol = Solution()
print(sol.quickSort([3, 6, 8, 10, 1, 2, 1]))
# [1, 1, 2, 3, 6, 8, 10]
print(sol.quickSort([5]))
# [5]
print(sol.quickSort([]))
# []
print(sol.quickSort([9, -3, 5, 2, 6, 8, -6, 1, 3]))
# [-6, -3, 1, 2, 3, 5, 6, 8, 9]


print(sol.mergeSort([38, 27, 43, 3, 9, 82, 10]))
# [3, 9, 10, 27, 38, 43, 82]
print(sol.mergeSort([5, 4, 3, 2, 1]))
# [1, 2, 3, 4, 5]
print(sol.mergeSort([1]))
# [1]

print(sol.findKthLargest([3,2,1,5,6,4], 2))
# 5
print(sol.findKthLargest([3,2,3,1,2,4,5,5,6], 4))
# 4
print(sol.findKthLargest([1], 1))
# 1

# s = Solution()
# a = list(range(50000))
# print(s.quickSort(a))

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthSmallestElementInABST_198
    set output_file "main.py"

    set template_content '
class TreeNode(object):
    def __init__(self, x):
         self.val = x
         self.left = None
         self.right = None

class Solution:

    def find_data(self, root: TreeNode):

        if root is None:
            return
        Solution.find_data(self,root.left)
        self.data.append(root.val)
        Solution.find_data(self,root.right)
        return
    
    def kthSmallest(self, root: TreeNode, k: int) -> int:
        self.data = []
        Solution.find_data(self, root)
        return self.data[k-1]

root = TreeNode(3)
root.left = TreeNode(1)
root.right = TreeNode(4)
root.left.right = TreeNode(2)

solution = Solution()
print(solution.kthSmallest(root, 2))  # Output: 2

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LargestNumber199
    set output_file "main.py"

    set template_content '
class Solution(object):
    def largestNumber(self, nums):
        
        if not any(nums):
            return '0'
        
        max_nums = len(str(max(nums)))
        
        def mycmp(x, y):
            if x + y > y + x:
                return 1
            else:
                return -1

     
        def makeEqual(s, length=max_nums):
            
            if len(s) == length:
                return s
            x = max(s) * (length - len(s))                
            return s+x
        
       
        return ''.join(sorted(map(str, nums), cmd=mycmp, reverse=True))
        return ''.join(sorted(map(str, nums), key=makeEqual, reverse=True))

solution = Solution()
print(solution.largestNumber([3, 30, 34, 5, 9]))  # Output: "9534330"
print(solution.largestNumber([0, 0]))  # Output: "0"

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.greatest_divisor_strings200
    set output_file "main.py"

    set template_content '
class Solution(object):
    def gcdOfStrings(self, str1, str2):
       
        def check(s, common):
            i = 0
            for c in s:
                if c != common[i]:
                    return False
                i = (i+1)%len(common)
            return True
    
        def gcd(a, b):  # Time: O(log(min(a, b)))
            while b:
                a, b = b, a % b
            return a
        
        if not str1 or not str2:
            return ""
        c = gcd(len(str1), len(str2))
        result = str1[:c]
        return result if check(str1, result) and check(str2, result) else ""

str1 = "ABCABC"
str2 = "ABC"
solution = Solution()
print(solution.gcdOfStrings(str1, str2))  # Output: "ABC"

str1 = "ABABAB"
str2 = "ABAB"
solution = Solution()
print(solution.gcdOfStrings(str1, str2))  # Output: "AB"

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.greatest_divisor_traversal_201
    set output_file "main.py"

    set template_content '
def linear_sieve_of_eratosthenes(n):  # Time: O(n), Space: O(n)
    primes = []
    spf = [-1]*(n+1)  # the smallest prime factor
    for i in xrange(2, n+1):
        if spf[i] == -1:
            spf[i] = i
            primes.append(i)
        for p in primes:
            if i*p > n or p > spf[i]:
                break
            spf[i*p] = p
    return primes


MAX_NUM = 10**5
PRIMES = linear_sieve_of_eratosthenes(int(MAX_NUM**0.5))
class Solution(object):
    def canTraverseAllPairs(self, nums):
    
        def prime_factors(x):
            factors = collections.Counter()
            for p in PRIMES:
                if p*p > x:
                    break
                while x%p == 0:
                    factors[p] += 1
                    x //= p
            if x != 1:
                factors[x] += 1
            return factors

        def bfs():
            lookup = [False]*len(nums)
            lookup[0] = True
            q = [0]
            while q:
                new_q = []
                for u in q:
                    for v in adj[u]:
                        if lookup[v]:
                            continue
                        lookup[v] = True
                        new_q.append(v)
                q = new_q
            return all(lookup)

        adj = [[] for _ in xrange(len(nums))]
        lookup = {}
        for i, x in enumerate(nums):
            for p in prime_factors(x):
                if p not in lookup:
                    lookup[p] = i
                    continue
                adj[i].append(lookup[p])
                adj[lookup[p]].append(i)
        return bfs()

solution = Solution()
nums = [3, 9, 12, 6]
print(solution.canTraverseAllPairs(nums))  # Output: True

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.document_search_file202
    set output_file "main.py"

    set template_content '
import os
import string
import platform
req_file=input("Enter your file name to search: ")

if platform.system()=="Windows":
	pd_names=string.ascii_uppercase
	vd_names=[]
	for each_drive in pd_names:
		if os.path.exists(each_drive+":\\"):
			#print(each_drive)
			vd_names.append(each_drive+":\\")
	print(vd_names)
	for each_drive in vd_names:
		for r,d,f in os.walk(each_drive):
			for each_f in f:
				if each_f==req_file:
					print(os.path.join(r,each_f))
else:
	for r,d,f in os.walk("/"):
		for each_file in f:
			if each_file==req_file:
				print(os.path.join(r,each_file))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.check_given_path_file_dir_path203
    set output_file "main.py"

    set template_content '
import os
import string
import platform
req_file=input("Enter your file name to search: ")

if platform.system()=="Windows":
	pd_names=string.ascii_uppercase
	vd_names=[]
	for each_drive in pd_names:
		if os.path.exists(each_drive+":\\"):
			#print(each_drive)
			vd_names.append(each_drive+":\\")
	print(vd_names)
	for each_drive in vd_names:
		for r,d,f in os.walk(each_drive):
			for each_f in f:
				if each_f==req_file:
					print(os.path.join(r,each_f))
else:
	for r,d,f in os.walk("/"):
		for each_file in f:
			if each_file==req_file:
				print(os.path.join(r,each_file))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.read_path_identify_files_dirs204
    set output_file "main.py"

    set template_content '

import os
import sys
path=input("Enter your directory path: ")
if os.path.exists(path):
	df_l=os.listdir(path)
else:
	print("please provide valid path")
	sys.exit()
	

print(df_l)
p1=os.path.join(path,df_l[0])
p2=os.path.join(path,df_l[1])

if os.path.isfile(p1):
	print(f"{p1} is a file")
else:
	print(f"{p1} is a directory")

if os.path.isfile(p2):
	print(f"{p2} is a file")
else:
	print(f"{p2} is a directory")


import os
import sys
path=input("Enter your directory path: ")
if os.path.exists(path):
	df_l=os.listdir(path)
else:
	print("please provide valid path")
	sys.exit()


list_of_files_dir=os.listdir(path)
print("all files and dirs: ",list_of_files_dir)
for each_file_or_dir in list_of_files_dir:
	f_d_p=os.path.join(path,each_file_or_dir)
	if os.path.isfile(f_d_p):
		print(f'{f_d_p} is a file')
	else:
		print(f'{f_d_p} is a directory')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.read_string_with_index_values205
    set output_file "main.py"

    set template_content '
usr_str=input("Enter your string: ")

index=0
for each_char in usr_str:
	print(f"{each_char} -->{index}")
	index=index+1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.find_all_files206
    set output_file "main.py"

    set template_content '
import os
req_path=input("Enter your directory path: ")
#req_ex=input("Enter the required files extention .py/.sh/.log/.txt: ")

if os.path.isfile(req_path):
  print(f"The given path {req_path} is a file. Please pass only directory path")
else:
  all_f_ds=os.listdir(req_path)
  if len(all_f_ds)==0:
     print(f"The given path is {req_path} an empty path")
  else:
     req_ex=input("Enter the required files extention .py/.sh/.log/.txt: ")
     req_files=[]
     for each_f in all_f_ds:
        if each_f.endswith(req_ex):
           req_files.append(each_f)
     if len(req_files)==0:
        print(f"There are no {req_ex} files in the logcation of {req_path}")
     else:
        print(f"There are {len(req_files)} files in the location of {req_path} with an extention of {req_ex}")
        print(f"So, the files are: {req_files}")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.delete_files_older207
    set output_file "main.py"

    set template_content '
import os
import sys
import datetime
req_path=input("Enter your path: ")
age=3
if not os.path.exists(req_path):
   print("Please provide valid path ")
   sys.exit(1)
if os.path.isfile(req_path):
   print("Please provide directory path ")
   sys.exit(2)
today=datetime.datetime.now()
for each_file in os.listdir(req_path):
   each_file_path=os.path.join(req_path,each_file)
   if os.path.isfile(each_file_path):
      file_cre_date=datetime.datetime.fromtimestamp(os.path.getctime(each_file_path))
      #print(dir(today-file_cre_date))
      dif_days=(today-file_cre_date).days
      if dif_days > age:
         print(each_file_path,dif_days)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.find_java208
    set output_file "main.py"

    set template_content '
import subprocess
cmd="java -version"
sp=subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
o,e=sp.communicate()
if rc==0:
    if bool(o)==True:
        print(o)
    #print(bool(o),bool(e))
    
    #if bool(o)==False and bool(e)==True:
    #    print(e.splitlines()[0].split()[2].strip("\""))
    
    if bool(o)==False:
        if bool(e)==True:
            print(e.splitlines()[0].split()[2].strip("\""))
else:
    print(e)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.get_bash_version209
    set output_file "main.py"

    set template_content "
import subprocess
cmd=["bash","--version"]
sp=subprocess.Popen(cmd,shell=False,stdout=subprocess.PIPE,stderr=subprocess.PIPE,universal_newlines=True)
rc=sp.wait()
o,e=sp.communicate()

if rc==0:
   for each_line in o.splitlines():
      if "version" in each_line  and "release" in each_line:
         print(each_line.split()[3].split('(')[0])
else:
   print("Command was failed and error is: ",e)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.create_file210
    set output_file "main.py"

    set template_content '
fo=open('newdemo.txt','w')
print(fo.mode)
print(fo.readable())
print(fo.writable())
fo.close()

my_content=["This is a data -1\n","This is a data-2\n","This is a data-3"]
fo=open("random.txt",'w')
fo.write("This is a first line\n")
fo.write("This is a second line\n")
fo.write("This is a third line")
#fo.writelines(my_content)
fo.close()

my_content=['This is using loop-iteratioin-1','This is using loop-iterantion-2','This is using loop-iteratioin-3']

fo=open("with_loop.txt",'a')

for each_line in my_content:
	fo.write(each_line+"\n")
fo.close()


fo=open("with_loop.txt","r")
data=fo.read()
fo.close()

print(data)

fo=open("with_loop.txt","r")
print(fo.readline())
print(fo.readline())
fo.close()


fo=open("with_loop.txt","r")
data=fo.readlines()
fo.close()

for each in range(3):
	print(data[each])   #data[0], data[1],data[2]

print(data[-1])

#sfile="C:\\Users\\Automation\\Desktop\\random.txt"
#dfile="C:\\Users\\Automation\\Downloads\\newrandom.txt"
sfile=input("Enter your source file: ")
dfile=input("Enter your destination file: ")
sfo=open(sfile,'r')
content=sfo.read()
sfo.close()

dfo=open(dfile,'w')
dfo.write(content)
dfo.close()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.read_csv_file211
    set output_file "main.py"

    set template_content '
import csv 
req_file="C:\\Users\\Automation\\Desktop\\hi\\new_info.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter="|")
for each in content:
	print(each)

fo.close()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.read_header_finding_no_rows212
    set output_file "main.py"

    set template_content '
import csv 
req_file="C:\\Users\\Automation\\Desktop\\hi\\new_info.csv"

fo=open(req_file,"r")
content=csv.reader(fo,delimiter="|")
print(list(content))
print(f'The header is:\n {list(content)[0]}')
#header=next(content)
#print("The header is: ",header)
print("The no of rows are: ",len(list(content))-1)

for each in content:
	print(each)
fo.close()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.working_with_json_files213
    set output_file "main.py"

    set template_content '
import json 

req_file="myjson.json"
fo=open(req_file,'r')
#print(fo.read())
print(json.load(fo))
fo.close()

#Write data(dictionary data) into a json file
my_dict={'Name':'Narendra','skills':['Python','shell','yaml','AWS']}
req_file="myinfo.json"

fo=open(req_file,'w')
json.dump(my_dict,fo,indent=4)

fo.close()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.working_with_exceptions214
    set output_file "main.py"

    set template_content '
print("Welcome to exceptions concept")
print("Now it is fine")
fo=open("nari.txt")

try:
	fo=open("nari.txt")
	print(fo.read())
	fo.close()
except Exception as e:
	print(e)

my_list=[3,4,5]

try:
	print(my_list[4])
except Exception as e:
	print(e)

print(my_list[4])

try:
	import fabric
except Exception as e:
	print(e)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.handling_known_exceptions215
    set output_file "main.py"

    set template_content '
try:
	print("This is try block")
	import fabric
	print(a)
	#print(4+"hi")
	#open('asdfas.txt')
	#print(5/0)
	
except FileNotFoundError:
	print("File is not present to open it")
except NameError:
	print("Variable is not defined")
except TypeError:
	print("Adding number and string is not possible")
except ZeroDivisionError:
	print("Division with zero is not possible")
except ModuleNotFoundError:
	print("Please install fabric to use it")
except Exception as e:
	print(e)
finally:
	print("Finally this will executes")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.differce_finally_esle216
    set output_file "main.py"

    set template_content '
try:
	a=9
	print(a)
except NameError:
	print("Variable is not defined")
except Exception as e:
	print("Exception occured:",e)
else:
	print("This will execute if there is no exceptions in try block")
finally:
	print("This will executes always")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.custom_exceptions217
    set output_file "main.py"

    set template_content '
age=23

if age>30:
	print("Valid age")
else:
	raise ValueError("Age is less than 30")
age=20
try:
	assert age>30
	print("Valid age")
except AssertionError:
	print("Raised with assert because age is lessthan 30")
except:
	print("Exception occured")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.run_commands218
    set output_file "main.py"

    set template_content '
import os
import time
import platform
def mycode(cmd1,cmd2):
	print("Please wait. Cleaning the screen....")
	time.sleep(2)
	os.system(cmd1)
	print("Please wait finding the list of dir and files")
	time.sleep(2)
	os.system(cmd2)
if platform.system()=="Windows":
	mycode("cls","dir")
else:
	mycode('clear','ls -lrt')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.variable_leng_keyword219
    set output_file "main.py"

    set template_content '
def display(p,**karg):
	print(p)
	print(karg)
	return None
#display(4,5)
#display(b=5,a=4)
#display(a=4,b=5,c=6)
display(56,x=5,y="Hi",z=6.7,user="root")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.change_working_dir220
    set output_file "main.py"

    set template_content '
def main():
  req_path=input("Enter path to change working dir: ")
  print("The current working dir is: ",os.getcwd())
  try:
    os.chdir(req_path)
    print("Now your new working dir is: ",os.getcwd())
  except FileNotFoundError:
    print("Given path is not a valid path. So cant change working directory")
  except NotADirectoryError:
    print("Given path is a file path. So cant change working directory")
  except PermissionError:
    print("Sorry you dont have access for the given path. So cant chagne working directory")
  except Exception as e:
    print(e)
  return None

if __name__=="__main__":
   main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.scope_variables221
    set output_file "main.py"

    set template_content '
def welcome_msg():
	print("Welcome to Python Scripting")
	print("Python is easy to learn")
	return None
def known_concepts():
	print("Now we are good with bascis")
	print("We are about to start functions concepts in python")
	return None
def learning_concepts():
	print("Function are very easy in python")
	print("Now we are writing simple functions")
	return None

def myfunction1():
	x=60  #This is local variable
	print("Welcome to functions")
	print("x value from fun1: ",x)
	#myfunction2()
	return None

def myfunction2(y):  #Parameter
	print("Thank you!!")
	print("x value from fun2: ",y)
	return None

def main():
	#global x
	x=10 
	myfunction1()
	myfunction2(x)  #Argument
	return None


main()
welcome_msg()
known_concepts()
learning_concepts()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function_with_simple_arguments222
    set output_file "main.py"

    set template_content '

def get_result(value):
	result=value+10
	print(f'Your result is: {result}')
	return None
def main():
	#global num
	num=eval(input("Enter your number: "))
	get_result(num)  #Arguments
	return None

main()

def get_add(p,q):
	aresult=p+q
	print(f'The addition of {p} and {q} is: {aresult}')
	return None
def get_sub(m,n):
	sresult=m-n
	print(f'The sub of {m} and {n} is: {sresult}')
	return None

def main():
	a=eval(input("Enter your first num: "))
	b=eval(input("Enter your second num: "))
	get_add(a,b)
	get_sub(a,b)
	#x=50
	#get_sub(19,x)
	return None
main()
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function_with_arg_return_values223
    set output_file "main.py"

    set template_content '
def get_addition(a,b):
	result=a+b
	#print(f"The addition of {a} and {b} is: {result}")
	return result
def main():
	a=eval(input("Enter your first number: "))
	b=eval(input("Enter your second number :"))
	result=get_addition(a,b)
	print(f"The addition of {a} and {b} is: {result}")
	return None
main()

def multiply_num_10(value):
	#result=value*10
	#return result
	return value*10

def main():
	num=eval(input("Enter your number: "))
	result=multiply_num_10(num)
	print("The result is: ",result)
main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-with-default-arguments224
    set output_file "main.py"

    set template_content '
def display(a=1):
	print("The value of a is: ",a)
	return None

display(4)
display(5)
display()

def add_numbers(a,b=0):
	result=a+b
	print("The result is: ",result)
	return None
add_numbers(4,5)
add_numbers(5)
add_numbers(7)


def working_on_some(user="root"):
	print(f"working with {user}")
	return None

working_on_some("weblogic_admin")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-with-keyword-based225
    set output_file "main.py"

    set template_content '
def display(a,b):
	print(f'a={a}')
	return None

display(3,4)
display(a=3,b=4)
display(b=4,a=3)

def display(*arg):
	for each in arg:
		print(type(each))
	return None
#display()
#display(4)
display(4,5,67)
print('-------------')
display("hi",4.65)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-regexe226
    set output_file "main.py"

    set template_content '
import re
text="This . is a python and it is easy to learn and it is popular one for dev and automation"

my_pat= 'i[ston]' #is,it,io,in
#print(len(re.findall(my_pat,text)))
print(re.findall(my_pat,text))


#my_pat="x[abcdeflmnopq]y" ==> xay,xby.....xqy
#      ="x[a-fl-q]y"

my_pat="\."
print(re.findall(my_pat,text))

text="This is a ip address of my db1 server: 255.255.255.255  2456234512341234"

my_pat="\d\d\d\.\d\d\d\.\d\d\d\.\d\d\d"
print(re.findall(my_pat,text))

text="This is python @ 345 _ - ("
print(re.findall('\w',text))
#print(re.findall('.',text))
print(re.findall("\W",text))

text="456 90 this is about deciaml re98gex"
print(re.findall('\d\d',text))


text='isa python l	earn and \n itis easy 	to'
#my_pat='^i[ts]'
#my_pat="learn$"
#my_pat=r"\blearn\b"
#my_pat=r"\Blearn\B"
my_pat=r"\n"
print(re.findall(my_pat,text))


text="This is a pythonnnn and python aaa haaaafd xyzaaaaaaaa"
#my_pat=r'\bpython{4}\b'
my_pat=r'\bxyza{8}\b'
print(re.findall(my_pat,text))

text="xaz asdfa sdf xaaz xaaaaaaaz xaaaaz  xz"
#my_pat=r'\bxa{2,}z\b'
#my_pat=r'xa{1,}z'
#my_pat=r'xa*z'   
my_pat=r'xa?z'
print(re.findall(my_pat,text))


text="this is a string ThIs is a new staring THIS"
my_pat=r'this'
print(re.findall(my_pat,text,re.I))

text="""this is a string EnD
this is second line enD
This is third line end
asfasd this end"""
#print(text)

#my_pat=r'^this'
my_pat=r'end\$'

print(re.findall(my_pat,text,re.M|re.I))


text="""This  is for
python2 and there are two major
vers python3 and python in future python4"""

pat=r"\bpython[23]?\b"

#print(re.findall(pat,text))
match_ob=re.search(pat,text)
#rint(match_ob)
if match_ob:
	print("match from ur pattern: ",match_ob.group())
	print('Starting index: ',match_ob.start())
	print('Ending index: ',match_ob.end()-1)
	print("Length: ",match_ob.end()-match_ob.start())
else:
	print("No match found")

text="""PYTHON2 and there are two major
vers python3 and python in future python4"""

pat=r'\bpython[23]?\b'
match_ob=re.match(pat,text,re.I)
if match_ob:
	print("match from ur pattern: ",match_ob.group())
	print('Starting index: ',match_ob.start())
	print('Ending index: ',match_ob.end()-1)
	print("Length: ",match_ob.end()-match_ob.start())
else:
	print("No match found")


my_str="This is python and we are having python2 and python3 version"
my_pat=r'\bpython[23]?\b'
#print(re.search(my_pat,my_str))
#print(len(re.findall(my_pat,my_str)))
#print(re.findall(my_pat,my_str))

for each_ob in re.finditer(my_pat,my_str):
	print(f'The match is: {each_ob.group()} starting index: {each_ob.start()}, ending index {each_ob.end()-1}')

my_str="This is about python. Python is easy to learn  and we have two major versions: python2 and python3 "

my_pat=r'\bPython[23]?\b'

#print(re.search(my_pat,my_str))
#print(re.findall(my_pat,my_str,flags=re.I))
#print(re.split(my_pat,my_str))


pat_ob=re.compile(my_pat,flags=re.I)
print(pat_ob)
print(pat_ob.search(my_str))
print(pat_ob.findall(my_str))


#re.findall(my_pat,my_str)===> re.complie(my_pat).findall(my_str)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.transfer_files227
    set output_file "main.py"

    set template_content '

import paramiko
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='54.165.97.91',username='ec2-user',password='paramiko123',port=22)
sftp_client=ssh.open_sftp()

#sftp_client.get('/home/ec2-user/paramiko_download.txt','paramiko_downloaded_file.txt')
#sftp_client.chdir("/home/ec2-user")
#print(sftp_client.getcwd())
#sftp_client.get('demo.txt','C:\\Users\\Automation\\Desktop\\download_file.txt')
sftp_client.put("transfer_files.py",'/home/ec2-user/transfer_files.py')
sftp_client.close()
ssh.close()


ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
#ssh.connect(hostname='3.92.79.119',username='ec2-user',password='paramiko123',port=22)
ssh.connect(hostname='3.92.79.119',username='ec2-user',key_filename='/home/Automation/.ssh/id_rsa',port=22)
#stdin, stdout, stderr = ssh.exec_command('whoami')
#stdin, stdout, stderr = ssh.exec_command('uptime')
stdin, stdout, stderr = ssh.exec_command('free -m')
print("The output is: ")
print(stdout.readlines())


print("THe error is: ")
print(stderr.readlines())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.oop-introduction228
    set output_file "main.py"

    set template_content '
import os
class Tomcat:
	def get_details_for_each_tomcat(self,server_xml):
		self.tcf=server_xml
		self.th=os.path.dirname(os.path.dirname(server_xml))
		return None

	def display_details(self):
		print(f'The tomcat config file is: {self.tcf}\nThe tomcat home is: {self.th}')
		return None		

def main():
	tomcat7=Tomcat()
	tomcat9=Tomcat()

	tomcat7.get_details_for_each_tomcat("/home/Automation/tomcat7/conf/server.xml")
	#get_details_for_each_tomcat('tomcat7',"/home/Automation/tomcat7/conf/server.xml")
	tomcat9.get_details_for_each_tomcat("/home/Automation/tomcat9/conf/server.xml")
	#get_details_for_each_tomcat('tomcat9',"/home/Automation/tomcat9/conf/server.xml")
	#print(tomcat9.tcf)
	#print(tomcat7.th)
	#print(tomcat9.th)
	#print(tomcat7.tcf)
	tomcat9.display_details()
	tomcat7.display_details()
	#display_details('tomcat7')
	tomcat9.display_details()
 
	return None

if __name__=="__main__":
	main()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.oop229
    set output_file "main.py"

    set template_content '
class emp:
	count=0
	def get_name_age_salary(self,name,age,salary):
		self.name=name
		self.age=age 
		self.salary=salary
		self.increase_count_for_emp()
		#self.display_details()
		return None
	def increase_count_for_emp(self):
		emp.count=emp.count+1
		return None
	def display_details(self):
		print(f'The name is: {self.name}\nThe age is: {self.age}\nThe salary is: {self.salary}')
		return None

emp1=emp()
emp2=emp()

emp1.get_name_age_salary('John',34,45000)
#emp1.increase_count_for_emp()
emp2.get_name_age_salary('Cliton',25,54000)
#emp2.increase_count_for_emp()

print(emp.count)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.oop230
    set output_file "main.py"
    set template_content '

class emp: 
	count=1


emp.count=emp.count+1
print(emp.count)

---

class Emp(object):
	def __init__(self,name,salary):
		self.name=name
		self.salary=salary
		return None
	def display(self):
		print(f"The name is: {self.name}\nThe salary is: {self.salary}")
		return None		


emp1=Emp('Ramu',56000)
emp2=Emp("Naren",90000)

emp1.display()
emp2.display()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.oop231
    set output_file "main.py"
    set template_content '
#without oop
def get_all_tomcats():
    list_of_config_files=[]
    for r,d,f in os.walk("/"):
        for each_file in f:
            if each_file=='server.xml':
                list_of_config_files.append(os.path.join(r,each_file))
    return list_of_config_files
def display_details(home_cnf_files):
    for each_key in home_cnf_files.keys():
        print(f'The Tomcat home is: {home_cnf_files[each_key][0]}')
        print(f'The Tomcat config file is:{home_cnf_files[each_key][1]}' )
    return None

def main():
    print("Finding list of tomcats...")
    list_of_tomcats=get_all_tomcats()
    #print(list_of_tomcats)
    cnt=1
    home_cnf_files={}
    for each_config_file in list_of_tomcats:
        t_home=os.path.dirname(os.path.dirname(each_config_file))
        t_cnf_file=each_config_file
        home_cnf_files['tomcat'+str(cnt)]=[t_home,t_cnf_file]
        cnt+=1
    #print(home_cnf_files)
    display_details(home_cnf_files)
    return None


if __name__ == '__main__':
    main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.oop232
    set output_file "main.py"
    set template_content '
class Person(object):
	def __init__(self,name,age):
		print("an object has been created")
		self.name=name
		self.age=age		
		return None
	def __del__(self):
		print("object has been deleted")
		return None

per1=Person('Jhon',26)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.oop233
    set output_file "main.py"

    set template_content '
#polimorphizm

class Tomcat(object):
	def __init__(self,home,ver):
		self.home=home
		self.version=ver
		return None 
	def display(self):
		print("This is from tocmat class")
		print(self.home)
		print(self.version)
		return None 
class Apache(object):
	def __init__(self,home,ver):
		self.home=home
		self.version=ver
		return None 
	def display(self):
		print("This is from apache class")
		print(self.home)
		print(self.version)
		return None 

tom_ob=Tomcat('/home/tomcat9','7.6')
apa_ob=Apache("/etc/httpd",'2.4')

tom_ob.display()
apa_ob.display()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.oop234
    set output_file "main.py"

    set template_content '
#incapsulation
class Person(object):
	def assing_name_and_age(self,name,age):
		self.name=name
		self.__age=age
		self.__display()
		return None
	def __display(self):
		print(self.name,self.__age)
		return None

per1=Person()
per1.assing_name_and_age('John',32)

#per1.__display()
#print(per1.name)
#print(per1.__age)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.oop235
    set output_file "main.py"

    set template_content '


#inheritance

class Tomcat(object):
	def __init__(self,home,ver):
		self.home=home
		self.version=ver
		return None 
	def display(self):
		print(self.home)
		print(self.version)
		return None 
class Apache(Tomcat):
	def __init__(self,home,ver):
		self.home=home
		self.version=ver
		return None 
tom_ob=Tomcat('/home/tomcat9','7.6')
apa_ob=Apache("/etc/httpd",'2.4')


tom_ob.display()
apa_ob.display()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-directory236
    set output_file "main.py"

    set template_content '
import os

def display_cwd():
	cwd = os.getcwd()
	print("Current Working Directory: ", cwd)

def up_one_directory_level():
	os.chdir("../")

def display_entries_in_directory(directory):
	# os.listdir()
	with os.scandir(directory) as entries:
		for entry in entries:
			print(entry.name)

if __name__ == "__main__":
	display_cwd()
	up_one_directory_level()
	display_cwd()
	display_entries_in_directory("images/")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-datatime237
    set output_file "main.py"

    set template_content '
from datetime import datetime
import os

def format_datetime(timestamp):
	utc_timestamp = datetime.utcfromtimestamp(timestamp)
	formated_date = utc_timestamp.strftime("%d %b %Y %H %M %S")
	return formated_date

def display_entries_in_directory(directory):
	with os.scandir(directory) as entries:
		for entry in entries:
			print("Name: ", entry.name)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-datatime238
    set output_file "main.py"
    set template_content '
from datetime import datetime
import os

def format_datetime(timestamp):
	utc_timestamp = datetime.utcfromtimestamp(timestamp)
	formated_date = utc_timestamp.strftime("%d %b %Y %H %M %S")
	return formated_date

def display_entries_in_directory(directory):
	with os.scandir(directory) as entries:
		for entry in entries:
			print("Name: ", entry.name)
			info = entry.stat()
			print("Creation Time:", format_datetime(info.st_birthtime))
			# Windows: print("Creation Time: ", info.st_ctime)
			print("Last Access Time:", format_datetime(info.st_atime))
			print("Size:", info.st_size)

def display_directories(directory):
	with os.scandir(directory) as entries:
		for entry in entries:
			if entry.is_dir():
				print("Directory Name:", entry.name)

def display_files(directory):
	with os.scandir(directory) as entries:
		for entry in entries:
			if entry.is_file():
				print("File Name:", entry.name)

if __name__ == "__main__":
	# display_entries_in_directory("artwork/")
	display_directories('data/')
	display_files('data/')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-glob239
    set output_file "main.py"

    set template_content '
import glob

def display_pngs():
	png_files = glob.glob('*.png')
	print(png_files)

def find_monster_one():
	filtered_items = glob.glob('*monster01*')
	print(filtered_items)

def find_monster_one_in_subdirs():
	for file in glob.iglob('**/*monster01*', recursive=True):
		print(file)

if __name__ == "__main__":
	# display_pngs()
	# find_monster_one()
	find_monster_one_in_subdirs()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-directory240
    set output_file "main.py"

    set template_content '
import os

def top_down_walk():
	for dirpath, dirnames, files in os.walk('artwork/'):
		print("Directory:", dirpath)
		print("Includes these directories")
		for dirname in dirnames:
			print(dirname)
		print("Includes these files")
		for filename in files:
			print(filename)
		print()

def bottom_up_walk():
	for dirpath, dirnames, files in os.walk('artwork/', topdown=False):
		print("Directory:", dirpath)
		print("Includes these directories")
		for dirname in dirnames:
			print(dirname)
		print("Includes these files")
		for filename in files:
			print(filename)
		print()

if __name__ == "__main__":
	# top_down_walk()
	bottom_up_walk()
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-print-directory241
    set output_file "main.py"

    set template_content '
from pathlib import Path

def print_directory_contents():
	entries = Path.cwd()

	# entries = Path('images/')
	# entries = Path.home()

	for entry in entries.iterdir():
		print(entry.name)
		print(entry.parent)
		print(entry.parent.parent)
		print(entry.stem)
		print(entry.suffix)
		print(entry.stat())
		print()

if __name__ == "__main__":
	print_directory_contents()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-logs242
    set output_file "main.py"

    set template_content '
import os
from pathlib import Path

def make_logs_dir():
	try:
		os.mkdir("logs/")
	except FileExistsError as ex:
		print("Logs directory already exists")

def make_output_dir():
	dir_path = Path("output/")
	dir_path.mkdir(exist_ok=True)

if __name__ == "__main__":
	# make_logs_dir()
	make_output_dir()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-countFiles243
    set output_file "main.py"
    set template_content '
import os
from pathlib import Path

def count_files_with_os_walk(path):
	total = 0
	for base, subdirs, files in os.walk(path):
		for file in files:
			total += 1
	return total

def count_files_with_scandir(path):
	total = 0
	for entry in os.scandir(path):
		if entry.is_file():
			total += 1
		else:
			total += count_files_with_scandir(entry)
	return total

def count_files_with_pathlib(path):
	total = 0
	for entry in Path(path).iterdir():
		if entry.is_file():
			total += 1
		else:
			total += count_files_with_pathlib(entry)
	return total

if __name__ == "__main__":
	print(count_files_with_os_walk('.'))
	print(count_files_with_scandir('.'))
	print(count_files_with_pathlib('.'))

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-print244
    set output_file "main.py"

    set template_content '
def print_content():
	with open('descriptions/description-01.txt', 'r') as f:
		contents = f.read()
		print(contents)

def write_new_content():
	with open('descriptions/description-01.txt', 'w') as f:
		f.write("Yodel grew up in a family of singers and loud talkers and could never get a word in edgewise")

if __name__ == "__main__":
	write_new_content()
	print_content()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-print_file_content245
    set output_file "main.py"

    set template_content '

def print_file_content():
	with open('descriptions/description-01.txt', 'r') as f:
		print(f.read())

if __name__ == "__main__":
	print_file_content()
----

def print_file_content():
	with open('descriptions/description-01.txt', 'r') as f:
		print(f.read(10))

def print_file_content_readlines():
	with open('descriptions/description-01.txt', 'r') as f:
		lines = f.readlines()
		print(lines[1])

def print_file_content_one_line_at_time():
	with open('descriptions/description-01.txt', 'r') as f:
		line = f.readline()
		while line != '':
			print(line, end='')
			line = f.readline()

if __name__ == "__main__":
	print_file_content_one_line_at_time()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-json246
    set output_file "main.py"

    set template_content '
import json

def display_json():
	with open('monster.json') as f:
		content_json = json.load(f)
		print(content_json)

def display_name_from_json():
	with open('monster.json') as f:
		content_json = json.load(f)
		print("Welcome", content_json['monsterName'])

if __name__ == "__main__":
	# display_json()
	display_name_from_json()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-pandas247
    set output_file "main.py"

    set template_content '
import csv
import pandas as pd

def display_csv_reader():
	with open('monsters.csv') as f:
		reader = csv.reader(f, delimiter=',')
		for row in reader:
			print(row[1])

def display_csv_reader_dict():
	with open('monsters.csv') as f:
		dictReader = csv.DictReader(f, delimiter=',')
		for row in dictReader:
			print(row["monsterName"] + " is priced at " + row["price"])

def display_csv_pandas():
	df = pd.read_csv('monsters.csv')
	print(df)

if __name__ == "__main__":
	display_csv_pandas()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-displaypdf248
    set output_file "main.py"

    set template_content '
import PyPDF2

def read_pdf():
	with open('recipe-book.pdf', 'r+b') as f:
		reader = PyPDF2.PdfFileReader(f)
		# print(reader.numPages)
		# print(reader.getDocumentInfo())

		for page in range(0, reader.numPages):
			pageObj = reader.getPage(page)
			print("\n" + pageObj.extractText())

if __name__ == "__main__":
	read_pdf()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.function-commonWord249
    set output_file "main.py"

    set template_content '
import glob

def find_most_common_word():
	txt_files = glob.glob('*.txt')
	tracker = dict()
	print(f"Number of Txt Files: {len(txt_files)}")

	for txt in txt_files:
		with open(txt) as f:
			line = f.readline()
			while line != '':
				words = line.split()
				for word in words:
					word = word.replace(',','').replace('.', '').lower()
					if word not in tracker:
						tracker[word] = 1
					else:
						tracker[word] = tracker[word] + 1
				line = f.readline()

	maxKey = max(tracker, key=tracker.get)
	maxValue = max(tracker.values())

	print(f"Most common word: {maxKey}")
	print(f"How many times: {maxValue}")
	print(f"Dictionary: {tracker}")

if __name__ == "__main__":
	find_most_common_word()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-writeContent250
    set output_file "main.py"

    set template_content '
def write_content():
	with open('num-series.txt', 'w') as writer:
		for x in range(50):
			content = f'{x}\n'
			writer.write(content)

def append_content():
	with open('num-series.txt', 'a') as writer:
		for x in range(50, 100):
			content = f'{x}\n'
			writer.write(content)

if __name__ == "__main__":
	write_content()
	append_content()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-shutil251
    set output_file "main.py"

    set template_content '
import os
from pathlib import Path
import shutil

def rename_os():
	os.rename('images/monster01.png', 'images/monster_01.png')

def rename_pathlib():
	file = Path('images/monster02.png')
	file.rename('images/monster_02.png')

def move_files():
	shutil.move('images/', 'png/')

def move_file():
	os.mkdir('svg')
	shutil.move('png/monster03.svg', 'svg/')

if __name__ == "__main__":
	# rename_os()
	# rename_pathlib()
	move_files()
	move_file()

----

def copy_file():
	shutil.copy('monster01.png', 'images/png')

def copy_file_with_metadata():
	shutil.copy2('monster02.png', 'images/png')

def copy_directory():
	shutil.copytree('images/', 'back-up-images/')

if __name__ == "__main__":
	# copy_file()
	# copy_file_with_metadata()
	copy_directory()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-delete252
    set output_file "main.py"

    set template_content '
import os
from pathlib import Path
import shutil

def delete_file_os():
	os.remove('screenshots/screenshot1.png')
	# os.unlink('screenshots/screenshot1.png')

def delete_file_pathlib():
	file = Path("screenshots/screenshot2.png")
	file.unlink()

def delete_directory_os():
	os.rmdir("screenshots/")

def delete_directory_pathlib():
	directory = Path("other-screenshots/")
	directory.rmdir()

def delete_directory_including_subdir():
	shutil.rmtree('old-images/')

if __name__ == "__main__":
	# delete_file_os()
	# delete_file_pathlib()
	# delete_directory_os()
	# delete_directory_pathlib()
	delete_directory_including_subdir()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-writoCSV253
    set output_file "main.py"

    set template_content '
import csv

def write_to_csv_list():
	with open('products.csv', 'w') as file:
		writer = csv.writer(file)
		writer.writerow(["ID", "Category", "Name", "Quantity", "Price"])
		writer.writerow([41, "Furnishings", "Office Chair", 10, 85])
		writer.writerow([20, "Office Supplies", "Pens", 30, 10])
		writer.writerow([13, "Housekeeping", "Bed Sheet (Double)", 15, 20])

def write_to_csv_dictionary():
	with open('products.csv', 'a') as file:
		headers = ['id', 'category', 'name','quantity', 'price']
		writer = csv.DictWriter(file, fieldnames=headers)
		# writer.writeheader()
		item = {'id':65, 'category': 'maintenance', 'name':'ladder', 'quantity':33, 'price':50}
		writer.writerow(item)

if __name__ == "__main__":
	write_to_csv_dictionary()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-dictionary254
    set output_file "main.py"

    set template_content '
import json

def generate_dictionary(monster_name, title, price, scariness):
	return {'monster_name': monster_name, 'title': title, 
	'price': price, 'scariness': scariness}

def write_to_json(dictionary_data):
	with open('monsters.json', 'w') as file:
		json.dump(dictionary_data, file)

if __name__ == "__main__":
	monster_one = generate_dictionary("Filo", "Baker by Day, Techie by Night",
		29, 3)
	monster_two = generate_dictionary("Timber", "Database Expert", 19, 2)
	monster_three = generate_dictionary("Blade", "Monster APPetite", 29, 5)
	write_to_json([monster_one, monster_two, monster_three])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-date255
    set output_file "main.py"

    set template_content '
from pathlib import Path
from datetime import datetime

def generate_creation_date(path):
	stat_result = path.stat()
	creation_date = stat_result.st_birthtime
	utc_timestamp = datetime.utcfromtimestamp(creation_date)
	return utc_timestamp.strftime('%Y_%m_%d_')

def organize_images(image_folder):
	file_types = ['.png', '.svg']
	for path in Path(image_folder).iterdir():
		if path.is_file() and path.suffix in file_types:
			print(f"Renaming file {path.stem}")
			date = generate_creation_date(path)
			new_path = Path(image_folder + date + path.stem + path.suffix)
			path.rename(new_path)

if __name__ == "__main__":
	organize_images('./images/')

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-zip256
    set output_file "main.py"

    set template_content '
import zipfile
import shutil

def create_zip(files):
	with zipfile.ZipFile('archive.zip', 'w') as archive:
		for file in files:
			archive.write(file)

def append_zip(files):
	with zipfile.ZipFile('archive.zip', 'a') as archive:
		for file in files:
			archive.write(file)

def create_zip_nested_dir(directory_path):
	shutil.make_archive('directory_archive', 'zip', directory_path)

if __name__ == "__main__":
	#files = ["png/monster01.png", "png/monster02.png", "png/monster03.png"]
	#create_zip(files)
	create_zip_nested_dir("svg")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-zip257
    set output_file "main.py"

    set template_content '
import zipfile

def read_zip():
	with zipfile.ZipFile('archive.zip', 'r') as archive:
		print(archive.namelist())

def retrieve_file_info_zip():
	with zipfile.ZipFile('archive.zip', 'r') as archive:
		file_info = archive.getinfo('description01.txt')
		print(file_info)

def read_file_in_zip():
	with zipfile.ZipFile('archive.zip', 'r') as archive:
		with archive.open('description01.txt') as file:
			print(file.read())

def extract_file(archive, file_to_extract):
	with zipfile.ZipFile(archive, 'r') as my_archive:
		my_archive.extract(file_to_extract)

def extract_all():
	with zipfile.ZipFile('archive.zip', 'r') as archive:
		archive.extractall("extracted_files")

if __name__ == "__main__":
	#read_zip()
	#retrieve_file_info_zip()
	#read_file_in_zip()
	#extract_file('archive.zip', 'description01.txt')
	extract_all()
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.function-read258
    set output_file "main.py"

    set template_content '
import tarfile

def read_tarfile():
	with tarfile.open('archive.tar.gz', 'r:gz') as tar:
		# print(tar.getnames())
		# file = tar.getmember("descriptions/description01.txt")
		for member in tar.getmembers():
			print(member.name)
			print(member.size)
			print(member.mode)

def read_file_in_tar():
	with tarfile.open('archive.tar.gz', 'r:gz') as tar:
		with tar.extractfile('descriptions/description01.txt') as file:
			print(file.read())

if __name__ == "__main__":
	#read_tarfile()
	read_file_in_tar()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-tar259
    set output_file "main.py"

    set template_content '
import tarfile

def create_tar_archive():
	files = ['monsters.csv', 'Monster_contact_sheet.pdf']
	# gz, bz2, or xz
	with tarfile.open('archive.tar', 'w') as tar:
		for file in files:
			tar.add(file)

def add_to_tar_archive():
	with tarfile.open('archive.tar', 'a') as tar:
		tar.add('monsters_card03.png')

def extract_tar():
	with tarfile.open('archive.tar') as tar:
		tar.extract('monsters_card03.png')

def extract_all():
	with tarfile.open('archive.tar') as tar:
		tar.extractall('extracted_monster_files')

if __name__ == "__main__":
	# create_tar_archive()
	# add_to_tar_archive()
	# extract_tar()
	extract_all()

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.function-temporary260
    set output_file "main.py"

    set template_content '
import tempfile

def work_with_temporary_file():
	with tempfile.TemporaryFile('w+') as tf:
		tf.write("Order Id 93827, Account Id 286438273")
		tf.seek(0)
		print(tf.read())
		print(tempfile.gettempdir())

if __name__ == "__main__":
	work_with_temporary_file()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Exceptions261
    set output_file "main.py"

    set template_content '
try:
    fhandle = open("myfile", "w")
    fhandle.write("This is some data to dump into the file")
    print("Wrote some data to the file")
except IOError as e:
    print("Exception caught: Unable to write to myfile ", e)
except Exception as e:
    print("Another error occurred ", e)
else:
    print("File written to successfully")
    fhandle.close()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.count-odd-letters-from-number262
    set output_file "main.py"

    set template_content '
class Solution(object):
    def countOddLetters(self, n):
        lookup = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        cnt = [0]*26
        while n:
            n, d = divmod(n, 10)
            for x in lookup[d]:
                cnt[ord(x) - ord("a")] += 1
        return sum(v%2 for v in cnt)

sol = Solution()
result = sol.countOddLetters(123)  # 123 → "one", "two", "three"
print(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.count_connected_number263
    set output_file "main.py"

    set template_content '
def dfs(source,visited,adjacency_list):
    

    visited[source] = True
    for child in adjacency_list[source]:
        if not visited[child]:
            dfs(child,visited,adjacency_list)

def count_components(adjacency_list,size):
   

    count = 0
    visited = [False]*(size+1)
    for i in range(1,size+1):
        if not visited[i]:
            dfs(i,visited,adjacency_list)
            count+=1
    return count

def main():
    
    node_count,edge_count = map(int, input("Enter the Number of Nodes and Edges \n").split(' '))
    adjacency = [[] for _ in range(node_count+1)]
    for _ in range(edge_count):
        print("Enter the edges Nodes in form of source target\n")
        source,target = map(int,input().split(' '))
        adjacency[source].append(target)
        adjacency[target].append(source)
    print("Total number of Connected Components are : ", count_components(adjacency,node_count))

if __name__ == '__main__':
    main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
