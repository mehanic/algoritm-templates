function algoP.TSPHelpers264
    set output_file "main.py"

    set template_content 'import random
from itertools import permutations

alltours = permutations
def distance_points(first, second):
    return abs(first - second)

def distance_tour(aTour):
    return sum(
        distance_points(aTour[i - 1], aTour[i])
        for i in range(len(aTour))
    )

aCity = complex

def generate_cities(number_of_cities):
    seed = 111
    width = 500
    height = 300

    random.seed((number_of_cities, seed))

    return frozenset(
        aCity(
            random.randint(1, width),
            random.randint(1, height)
        )
        for _ in range(number_of_cities)
    )


cities = generate_cities(5)
print('Cities:', cities)
for tour in alltours(cities):
    print('Tour distance:', distance_tour(tour))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.swap_even_with_next265
    set output_file "main.py"
    
    set template_content '
import numpy as np

def swap_even_with_next(arr):
    for i in range(arr.shape[0] - 1):
        if arr[i] % 2 == 0 and i < (arr.shape[0] - 1):
            j = i + 1 
            while j < arr.shape[0] and arr[j] % 2 == 0:
                j += 1 
            if j < arr.shape[0]:
                arr[i], arr[j] = arr[j], arr[i]
    return arr

arr = np.array([2, 4, 6, 7, 10, 3, 8, 5])
print('Original array:', arr)
arr = swap_even_with_next(arr)
print('Array after swapping even with next odd:', arr)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.QueueOperations266
    set output_file "QueueOperations_Python.py"

    set template_content "def enqueue(Q, item, F, R, MAX):
    if R == MAX - 1:  # If the queue is full
        print('Overflow')
        return (F, R)
    elif R == -1:  # If the queue is empty
        F = 0
        R = 0
        Q[R] = item
        return (F, R)
    else:  # If the queue is not empty
        R += 1
        Q[R] = item
        return (F, R)

def dequeue(Q, F, R):
    if F == -1:  # If the queue is empty
        return (-1, F, R)
    elif F == R:  # If there is only one item left in the queue
        temp = Q[F]
        Q[F] = 0
        F = -1
        R = -1
        return (temp, F, R)
    else:  # If there are more items in the queue
        temp = Q[F]
        Q[F] = 0
        F += 1
        return (temp, F, R)

def disp(Q, F, R, MAX):
    for i in range(MAX):
        print(Q[i], end=' ')
    print('Front=', F, ' Rear=', R)

# Main program to demonstrate the queue operations
MAX = 5  # Size of the queue
Q = [0] * MAX  # Initializing the queue with 0s
F = -1  # Front pointer
R = -1  # Rear pointer

# Enqueue operation
item = int(input('Enter item to enqueue: '))
F, R = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

# Enqueue another item
item = int(input('Enter another item to enqueue: '))
F, R = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

# Dequeue operation
item, F, R = dequeue(Q, F, R)
if item == -1:
    print('Underflow')
else:
    print(f'Dequeued item: {item}')
disp(Q, F, R, MAX)

# Enqueue more items
item = int(input('Enter item to enqueue: '))
F, R = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueOperations267
    set output_file "QueueOperations_Python.py"

    set template_content "def enqueue(Q, item, F, R, MAX):
    if ((R+1) % MAX == F):  # If the queue is full
        print('Overflow')
        return (F, R)
    elif (R == -1):  # If the queue is empty
        F = 0
        R = 0
        Q[R] = item
        return (F, R)
    else:  # If the queue is not empty
        R = (R + 1) % MAX
        Q[R] = item
        return (F, R)

def dequeue(Q, F, R):
    if (F == -1):  # If the queue is empty
        return (-1, F, R)
    elif (F == R):  # If there is only one item left in the queue
        temp = Q[F]
        F = -1
        R = -1
        return (temp, F, R)
    else:  # If there are more items in the queue
        temp = Q[F]
        F = (F + 1) % MAX
        return (temp, F, R)

def disp(Q, F, R, MAX):
    for i in range(MAX):
        print(Q[i], end=' ')
    print('Front=', F, ' Rear=', R)

# Main program to demonstrate the queue operations
MAX = 5  # Size of the queue
Q = [0] * MAX  # Initializing the queue with 0s
F = -1  # Front pointer
R = -1  # Rear pointer

# Enqueue operations
item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)

item = int(input('Enter item\t:'))
(F, R) = enqueue(Q, item, F, R, MAX)
disp(Q, F, R, MAX)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueAndBinary268
    set output_file "main.py"

    set template_content '
Q = []          # Queue list
choice = 0      # Initialize choice
F = -1          # Front pointer
R = -1          # Rear pointer
MAX = 5         # Maximum size of the queue

# Menu-driven program for queue operations
while choice != 4:
    print(\"\\nQueue Operations\")
    print(\"1: Enqueue\")
    print(\"2: Dequeue\")
    print(\"3: Display\")
    print(\"4: Exit\")
    choice = int(input(\"Enter choice: \"))
    
    if choice == 1:
        item = int(input(\"Enter item to enqueue: \"))
        
        # If the queue is empty
        if R == -1:
            R += 1
            F += 1
            Q.append(item)
        
        # If theres space in the queue
        elif R != (MAX - 1):
            R += 1
            Q.append(item)
        
        # If the queue is full
        else:
            print(\"Overflow: Queue is full.\")
    
    elif choice == 2:
        # If the queue is empty
        if R == -1:
            print(\"Underflow: Queue is empty.\")
        
        # If theres only one item in the queue
        elif R == F:
            item = Q.pop(0)
            print(item, \"popped\")
            R = -1
            F = -1
        
        # If there are more items in the queue
        else:
            item = Q.pop(0)
            print(item, \"popped\")
            F += 1
    
    elif choice == 3:
        # Display the queue
        print(\"Queue: \")
        print(\"Front =\", F, \"Rear =\", R)
        print(\"Queue contents:\")
        for i in Q:
            print(i, end=\" \")
        print()  # For newline after the queue display
    
    elif choice == 4:
        print(\"Program ends...\")
    
    else:
        print(\"Incorrect choice! Please choose a valid option.\")

# Main program to generate n-bit binary numbers using the queue
Q = []  # Reinitialize the queue

n = int(input(\"Enter the number of bits: \"))
print(f\"{n}-bit binary numbers:\")

Q.append(\"1\")

for i in range(2**n - 1): 
    item = Q.pop(0) 
    print(item)
    
    Q.append(item + '0')
    Q.append(item + '1')
    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueAndBinary269
    set output_file "main.py"

    set template_content "# Implement Queue
Q = []          # Queue list
choice = 0      # Initialize choice
F = -1          # Front pointer
R = -1          # Rear pointer
MAX = 5         # Maximum size of the queue

while choice != 4:
    print(\"\\nQueue Operations\")
    print(\"1: Enqueue\")
    print(\"2: Dequeue\")
    print(\"3: Display\")
    print(\"4: Exit\")
    choice = int(input(\"Enter choice: \"))
    
    if choice == 1:
        item = int(input(\"Enter item to enqueue: \"))
        
        # If the queue is empty
        if R == -1:
            R += 1
            F += 1
            Q.append(item)
        
        elif R != (MAX - 1):
            R += 1
            Q.append(item)
        
        else:
            print(\"Overflow: Queue is full.\")
    
    elif choice == 2:
        # If the queue is empty
        if R == -1:
            print(\"Underflow: Queue is empty.\")
        
        # If there's only one item in the queue
        elif R == F:
            item = Q.pop(0)
            print(item, \"popped\")
            R = -1
            F = -1
        
        # If there are more items in the queue
        else:
            item = Q.pop(0)
            print(item, \"popped\")
            F += 1
    
    elif choice == 3:
        # Display the queue
        print(\"Queue: \")
        print(\"Front =\", F, \"Rear =\", R)
        print(\"Queue contents:\")
        for i in Q:
            print(i, end=\" \")
        print()  # For newline after the queue display
    
    elif choice == 4:
        print(\"Program ends...\")
    
    else:
        print(\"Incorrect choice! Please choose a valid option.\")

Q = []

n = int(input(\"Enter the number of bits: \"))
print(f\"{n}-bit binary numbers:\")

Q.append(\"1\")

for i in range(2**n - 1):
    item = Q.pop(0)
    print(item)
    Q.append(item + '0')
    Q.append(item + '1')"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.QueueWithPush270
    set output_file "QueueWithPush_Python.py"

    set template_content "def enqueue(Q, F, R, MAX, item):
    if F == -1:  # If the queue is empty
        R += 1
        F += 1
        Q.append(item)
    elif R != (MAX - 1):  # If there is space in the queue
        R += 1
        Q.append(item)
    else:  # If the queue is full
        print('Overflow')
    return (Q, F, R)

def dequeue(Q, F, R):
    if F == -1:  # If the queue is empty
        print('Underflow')
        item = -1
    elif R == F:  # If there is only one item in the queue
        R = -1
        F = -1
        item = Q.pop(0)
        print(item, 'popped')
    else:  # If there are more items in the queue
        F += 1
        item = Q.pop(0)
        print(item, 'popped')
    return (Q, F, R, item)

def push(Q, F, R, MAX, item):
    Q, F, R = enqueue(Q, F, R, MAX, item)
    n = R - F
    for i in range(n):
        Q, F, R, item1 = dequeue(Q, F, R)
        if item1 != -1:
            Q, F, R = enqueue(Q, F, R, MAX, item1)
    return (Q, F, R)

# Main program to demonstrate queue operations
Q = []  # Initialize the queue
choice = 0
F = -1  # Front pointer
R = -1  # Rear pointer
MAX = 10  # Maximum size of the queue

while choice != 4:
    print('Queue Operations')
    print('1: Enqueue')
    print('2: Dequeue')
    print('3: Display')
    print('4: Exit')
    choice = int(input('Enter choice: '))

    if choice == 1:
        item = int(input('Enter item to enqueue: '))
        Q, F, R = push(Q, F, R, MAX, item)
    
    elif choice == 2:
        Q, F, R, item2 = dequeue(Q, F, R)
    
    elif choice == 3:
        print('Front =', F, 'Rear =', R)
        print('Queue contents:')
        for i in Q:
            print(i, end=' ')
        print()  # For newline after the queue display
    
    elif choice == 4:
        print('Program ends...')
    
    else:
        print('Incorrect choice! Please choose a valid option.')"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.QueueWithPush271
    set output_file "main.py"

    set template_content "def enqueue(Q, F, R, MAX, item):
    if F == -1:  # If the queue is empty
        R += 1
        F += 1
        Q.append(item)
    elif R != (MAX - 1):  # If there is space in the queue
        R += 1
        Q.append(item)
    else:  # If the queue is full
        print('Overflow')
    return (Q, F, R)

def dequeue(Q, F, R):
    if F == -1:  # If the queue is empty
        print('Underflow')
        item = -1
    elif R == F:  # If there is only one item in the queue
        R = -1
        F = -1
        item = Q.pop(0)
        print(item, 'popped')
    else:  # If there are more items in the queue
        F += 1
        item = Q.pop(0)
        print(item, 'popped')
    return (Q, F, R, item)

def push(Q, F, R, MAX, item):
    Q, F, R = enqueue(Q, F, R, MAX, item)
    n = R - F
    for i in range(n):
        Q, F, R, item1 = dequeue(Q, F, R)
        if item1 != -1:
            Q, F, R = enqueue(Q, F, R, MAX, item1)
    return (Q, F, R)

# Main program to demonstrate queue operations
Q = []  # Initialize the queue
choice = 0
F = -1  # Front pointer
R = -1  # Rear pointer
MAX = 10  # Maximum size of the queue

while choice != 4:
    print('Queue Operations')
    print('1: Enqueue')
    print('2: Dequeue')
    print('3: Display')
    print('4: Exit')
    choice = int(input('Enter choice: '))

    if choice == 1:
        item = int(input('Enter item to enqueue: '))
        Q, F, R = push(Q, F, R, MAX, item)
    
    elif choice == 2:
        Q, F, R, item2 = dequeue(Q, F, R)
    
    elif choice == 3:
        print('Front =', F, 'Rear =', R)
        print('Queue contents:')
        for i in Q:
            print(i, end=' ')
        print()  # For newline after the queue display
    
    elif choice == 4:
        print('Program ends...')
    
    else:
        print('Incorrect choice! Please choose a valid option.')"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BinaryTree.Node272
    set output_file "main.py"

    set template_content "class Node:
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

    def getLeft(self):
        return self.left

    def getRight(self):
        return self.right

    def getData(self):
        return self.data

    def setData(self, val):
        self.data = val


class BinaryTree2:
    def __init__(self, rootData):
        self.root = Node(rootData)
        self.level = 0

    def preOrderTraversal(self, root, trav):
        if root is None:
            return
        else:
            stack_pre = []
            stack_pre.append(root)
            while stack_pre:
                ptr = stack_pre.pop()
                if ptr:
                    trav.append(ptr.data)
                    if ptr.right is not None:
                        stack_pre.append(ptr.right)
                    if ptr.left is not None:
                        stack_pre.append(ptr.left)

    def inOrderTraversal(self, root, trav):
        if root is None:
            return
        else:
            stack_in = []
            ptr = root
            while stack_in or ptr:
                if ptr is not None:
                    stack_in.append(ptr)
                    ptr = ptr.left
                else:
                    ptr = stack_in.pop()
                    trav.append(ptr.data)
                    ptr = ptr.right

    def postOrderTraversal(self, root, trav):
        if root is None:
            return
        else:
            stack_post = []
            ptr = root
            visited = set()
            while stack_post or ptr:
                if ptr:
                    stack_post.append(ptr)
                    ptr = ptr.left
                else:
                    ptr = stack_post.pop()
                    if ptr.right is not None and ptr.right not in visited:
                        stack_post.append(ptr)
                        ptr = ptr.right
                    else:
                        visited.add(ptr)
                        trav.append(ptr.data)
                        ptr = None

    def insertLeft(self, val):
        ptr = self.root
        if ptr.left is None:
            ptr.left = Node(val)
        else:
            temp = Node(val)
            temp.left = ptr.left
            ptr.left = temp

    def insertRight(self, val):
        ptr = self.root
        if ptr.right is None:
            ptr.right = Node(val)
        else:
            temp = Node(val)
            temp.right = ptr.right
            ptr.right = temp


# Example Usage
Tree1 = BinaryTree2(45)
inOrder = []
Tree1.inOrderTraversal(Tree1.root, inOrder)
print(inOrder)

Tree1.insertLeft(5)
Tree1.insertLeft(7)
Tree1.insertRight(90)
Tree1.insertRight(67)
Tree1.insertLeft(56)

inOrder = []
Tree1.inOrderTraversal(Tree1.root, inOrder)
print(inOrder)

preOrder = []
Tree1.preOrderTraversal(Tree1.root, preOrder)
print(preOrder)

postOrder = []
Tree1.postOrderTraversal(Tree1.root, postOrder)
print(postOrder)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxHeapInsert273
    set output_file "main.py"

    set template_content "
def insert(heap, val):
    # If the heap is empty, insert the value at index 0
    if heap[0] == 0:
        heap[0] = val
    else:
        # Find the next available index in the heap (first free spot)
        index = 0
        while heap[index] != 0:
            index += 1
        
        # Insert the new value at the found index
        heap[index] = val
        pos = index
        
        # Bubble up to maintain the max-heap property
        while pos != 0:
            parent_pos = (pos - 1) // 2  # Index of the parent node
            if heap[parent_pos] < heap[pos]:
                # Swap if the parent is smaller than the current node
                temp = heap[pos]
                heap[pos] = heap[parent_pos]
                heap[parent_pos] = temp
                pos = parent_pos  # Move up to the parent's position
            else:
                break  # No need to move up anymore if max-heap property is satisfied


# Example usage
heap = [0] * 10  # Initialize heap with 10 spots (first element is 0)

insert(heap, 10)
insert(heap, 20)
insert(heap, 15)
insert(heap, 30)

print(heap)  # Output the heap after insertions
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MaxHeapInsert274
    set output_file "main.py"

    set template_content "
def insert(heap, val):
    # If the heap is empty, insert the value at index 0
    if heap[0] == 0:
        heap[0] = val
    else:
        # Find the next available index in the heap (first free spot)
        index = 0
        while heap[index] != 0:
            index += 1
        
        # Insert the new value at the found index
        heap[index] = val
        pos = index
        
        # Bubble up to maintain the max-heap property
        while pos != 0:
            parent_pos = (pos - 1) // 2  # Index of the parent node
            if heap[parent_pos] < heap[pos]:
                # Swap if the parent is smaller than the current node
                temp = heap[pos]
                heap[pos] = heap[parent_pos]
                heap[parent_pos] = temp
                pos = parent_pos  # Move up to the parent's position
            else:
                break  # No need to move up anymore if max-heap property is satisfied


# Example usage
heap = [0] * 10  # Initialize heap with 10 spots (first element is 0)

insert(heap, 10)
insert(heap, 20)
insert(heap, 15)
insert(heap, 30)

print(heap)  # Output the heap after insertions
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MaxHeapDelete275
    set output_file "main.py"

    set template_content "
def delete(heap):
    # Index for the root node
    index = 0
    while heap[index] != 0:
        # Find the last element in the heap
        temp = heap[index]
        index += 1

    # If there is no element in the heap, return 0
    if index == 0:
        return 0

    # Save the root value to return later
    root_value = heap[0]
    heap[0] = heap[index - 1]  # Replace root with the last element
    heap[index - 1] = 0  # Set the last element to 0 (empty)

    # Reheapify the heap (heapify-down process)
    pos = 0
    while 2 * pos + 1 < index - 1:  # Check if there is a left child
        left_child_pos = 2 * pos + 1
        right_child_pos = 2 * pos + 2

        # Check if the left child exists and is greater than the current node
        if right_child_pos < index and heap[left_child_pos] < heap[right_child_pos]:
            largest_child_pos = right_child_pos
        else:
            largest_child_pos = left_child_pos

        # If the current node is smaller than the largest child, swap them
        if heap[pos] < heap[largest_child_pos]:
            heap[pos], heap[largest_child_pos] = heap[largest_child_pos], heap[pos]
            pos = largest_child_pos  # Move down to the largest child's position
        else:
            break  # The heap is restructured, break the loop

    return root_value

# Example usage
heap = [30, 20, 15, 10, 5, 6, 3, 2, 1, 0]
deleted_value = delete(heap)
print('Deleted Value:', deleted_value)
print('Updated Heap:', heap)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordPattern276
    set output_file "main.py"

    set template_content '
def get_word_pattern(word: str) -> str:
   
    word = word.upper()
    next_num = 0
    letter_nums = {}
    word_pattern = []

    for letter in word:
        if letter not in letter_nums:
            letter_nums[letter] = str(next_num)
            next_num += 1
        word_pattern.append(letter_nums[letter])
    return \".\".join(word_pattern)


if __name__ == \"__main__\":
    import pprint
    import time

    start_time = time.time()
    with open(\"dictionary.txt\") as in_file:
        word_list = in_file.read().splitlines()

    all_patterns: dict = {}
    for word in word_list:
        pattern = get_word_pattern(word)
        if pattern in all_patterns:
            all_patterns[pattern].append(word)
        else:
            all_patterns[pattern] = [word]

    with open(\"word_patterns.txt\", \"w\") as out_file:
        out_file.write(pprint.pformat(all_patterns))

    total_time = round(time.time() - start_time, 2)
    print(f\"Done!  {len(all_patterns):,} word patterns found in {total_time} seconds.\")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_python_script277
    set output_file "main.py"
    set python_code '
while True:
    try:
        age = int(input("Enter your age: "))
        age_in_dogs_year = 10/age
        
    except ZeroDivisionError:
        print("enter age greater than 0")
        continue
        
    except ValueError:
        print("Please enter a no.")
        break
    
    except ValueError:
        print("!!!!")
        
    else:
        print(f"thank you, and your age is {age}")
        break
        
    finally:
        print("I will always get printed no matter what :)")
    
    print("can you hear me??????")
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the age input handling script!"
    set_color normal
    cat $output_file
end



function algoP.generate_python_script278
    set output_file "division_script.py"
    set python_code '
def division_fn(num1, num2):
    try: 
        return num1 / num2
    except (ZeroDivisionError, TypeError) as err:
        print(f"error: {err}")

print(division_fn(1, "0"))
print(division_fn(1, 0))
print(division_fn(1, 4))
'
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file has been created with the division function script!"
    set_color normal
    cat $output_file
end



function algoP.run_binary_xor279
    set python_file "binary_xor_fish.py"

    set python_code '
def binary_xor(a: int, b: int) -> str:
    if a < 0 or b < 0:
        raise ValueError("the value of both inputs must be positive")
    a_binary = str(bin(a))[2:]
    b_binary = str(bin(b))[2:]
    max_len = max(len(a_binary), len(b_binary))
    return "0b" + "".join(str(int(char_a != char_b)) for char_a, char_b in zip(a_binary.zfill(max_len), b_binary.zfill(max_len)))

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    x = int(input("Enter first positive integer: ").strip())
    y = int(input("Enter second positive integer: ").strip())
    print("Binary XOR:", binary_xor(x, y))
'

    echo "$python_code" > $python_file
    python3 $python_file
end



function algoP.run_bitwise_addition280
    set python_file "bitwise_addition_fish.py"

    set python_code '
def bitwise_addition_recursive(number: int, other_number: int) -> int:
    if not isinstance(number, int) or not isinstance(other_number, int):
        raise TypeError("Both arguments MUST be integers!")
    if number < 0 or other_number < 0:
        raise ValueError("Both arguments MUST be non-negative!")
    bitwise_sum = number ^ other_number
    carry = number & other_number
    if carry == 0:
        return bitwise_sum
    return bitwise_addition_recursive(bitwise_sum, carry << 1)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    a = int(input("Enter first non-negative integer: ").strip())
    b = int(input("Enter second non-negative integer: ").strip())
    print("Bitwise sum:", bitwise_addition_recursive(a, b))
'

    echo "$python_code" > $python_file
    python3 $python_file
end



function algoP.run_get_1s_count281
    set python_file "get_1s_count_fish.py"

    set python_code '
def get_1s_count(number: int) -> int:
    if not isinstance(number, int) or number < 0:
        raise ValueError("Input must be a non-negative integer")
    count = 0
    while number:
        number &= number - 1
        count += 1
    return count

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    num = int(input("Enter a non-negative integer: ").strip())
    print("Number of 1s in binary:", get_1s_count(num))
'

    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_set_bits_benchmark282
    set python_file "main.py"

    set python_code '
from timeit import timeit

def get_set_bits_count_using_brian_kernighans_algorithm(number: int) -> int:
    if number < 0:
        raise ValueError("the value of input must not be negative")
    result = 0
    while number:
        number &= number - 1
        result += 1
    return result

def get_set_bits_count_using_modulo_operator(number: int) -> int:
    if number < 0:
        raise ValueError("the value of input must not be negative")
    result = 0
    while number:
        if number % 2 == 1:
            result += 1
        number >>= 1
    return result

def benchmark() -> None:
    def do_benchmark(number: int) -> None:
        setup = "import __main__ as z"
        print(f"Benchmark when {number = }:")
        print(f"{get_set_bits_count_using_modulo_operator(number) = }")
        timing = timeit(f"z.get_set_bits_count_using_modulo_operator({number})", setup=setup)
        print(f"timeit() runs in {timing} seconds")
        print(f"{get_set_bits_count_using_brian_kernighans_algorithm(number) = }")
        timing = timeit(f"z.get_set_bits_count_using_brian_kernighans_algorithm({number})", setup=setup)
        print(f"timeit() runs in {timing} seconds")

    for number in (25, 37, 58, 0):
        do_benchmark(number)
        print()

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    benchmark()
'

    echo "$python_code" > $python_file
    python3 $python_file
end




function algoP.run_excess_3_code283
    set python_code '
def excess_3_code(number: int) -> str:
    num = ""
    for digit in str(max(0, number)):
        num += str(bin(int(digit) + 3))[2:].zfill(4)
    return "0b" + num

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    for n in (0, 3, 2, 20, 120):
        print(f"excess_3_code({n}) = {excess_3_code(n)}")
'

    set python_file /tmp/excess_3_code.py
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_find_previous_power_of_two284
    set python_code '
def find_previous_power_of_two(number: int) -> int:
    if not isinstance(number, int) or number < 0:
        raise ValueError("Input must be a non-negative integer")
    if number == 0:
        return 0
    power = 1
    while power <= number:
        power <<= 1  # Equivalent to multiplying by 2
    return power >> 1 if number > 1 else 1

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print([find_previous_power_of_two(i) for i in range(18)])
'

    set python_file /tmp/find_previous_power_of_two.py
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_find_unique_number285
    set python_code '
def find_unique_number(arr: list[int]) -> int:
    if not arr:
        raise ValueError("input list must not be empty")
    if not all(isinstance(x, int) for x in arr):
        raise TypeError("all elements must be integers")

    result = 0
    for num in arr:
        result ^= num
    return result

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(find_unique_number([1, 1, 2, 2, 3]))
'
    set python_file /tmp/find_unique_number.py
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_gray_code286
    set python_code '
def gray_code(bit_count: int) -> list:
    if bit_count < 0:
        raise ValueError("The given input must be positive")

    sequence = gray_code_sequence_string(bit_count)
    for i in range(len(sequence)):
        sequence[i] = int(sequence[i], 2)
    return sequence


def gray_code_sequence_string(bit_count: int) -> list:
    if bit_count == 0:
        return ["0"]
    if bit_count == 1:
        return ["0", "1"]

    seq_len = 1 << bit_count
    smaller_sequence = gray_code_sequence_string(bit_count - 1)

    sequence = []
    for i in range(seq_len // 2):
        sequence.append("0" + smaller_sequence[i])
    for i in reversed(range(seq_len // 2)):
        sequence.append("1" + smaller_sequence[i])
    return sequence


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(gray_code(3))
'

    set python_file /tmp/gray_code.py
    echo "$python_code" > $python_file
    python3 $python_file
end


function algoP.run_highest_set_bit287
    set python_code '
def get_highest_set_bit_position(number: int) -> int:
    if not isinstance(number, int):
        raise TypeError("Input value must be an '\''int'\'' type")

    position = 0
    while number:
        position += 1
        number >>= 1

    return position


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(get_highest_set_bit_position(37))
'

    set python_file /tmp/highest_set_bit.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end



function algoP.run_rightmost_set_bit288
    # Python code stored as a variable
    set python_code '
def get_index_of_rightmost_set_bit(number: int) -> int:
    if not isinstance(number, int) or number < 0:
        raise ValueError("Input must be a non-negative integer")

    intermediate = number & ~(number - 1)
    index = 0
    while intermediate:
        intermediate >>= 1
        index += 1
    return index - 1


if __name__ == "__main__":
    import doctest
    doctest.testmod(verbose=True)

    # Example usage
    print(get_index_of_rightmost_set_bit(36))
'

    # Write Python code to a temporary file
    set python_file /tmp/rightmost_set_bit.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end



function algoP.run_is_even289
    # Python code stored as a variable
    set python_code '
def is_even(number: int) -> bool:
    return number & 1 == 0


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(is_even(40))
'

    # Write Python code to a temporary file
    set python_file /tmp/is_even.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end



function algoP.run_is_power_of_two290
    # Python code stored as a variable
    set python_code '
def is_power_of_two(number: int) -> bool:
    if number < 0:
        raise ValueError("number must not be negative")
    return number & (number - 1) == 0


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(is_power_of_two(16))
'

    # Write Python code to a temporary file
    set python_file /tmp/is_power_of_two.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_largest_pow_of_two_le_num291
    # Python code stored as a variable
    set python_code '
def largest_pow_of_two_le_num(number: int) -> int:
    if isinstance(number, float):
        raise TypeError("Input value must be a '\''int'\'' type")
    if number <= 0:
        return 0
    res = 1
    while (res << 1) <= number:
        res <<= 1
    return res


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    
    # Example usage
    print(largest_pow_of_two_le_num(178))
'

    # Write Python code to a temporary file
    set python_file /tmp/largest_pow_of_two_le_num.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_find_missing_number292
    # Python code stored as a variable
    set python_code '
def find_missing_number(nums: list[int]) -> int:
    low = min(nums)
    high = max(nums)
    missing_number = high

    for i in range(low, high):
        missing_number ^= i ^ nums[i - low]

    return missing_number


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    
    # Example usage
    print(find_missing_number([0, 1, 3, 4]))
'

    # Write Python code to a temporary file
    set python_file /tmp/find_missing_number.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end



function algoP.run_different_signs293
    # Python code stored as a variable
    set python_code '
def different_signs(num1: int, num2: int) -> bool:
    return num1 ^ num2 < 0


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(different_signs(1, -1))
    print(different_signs(1, 1))
'

    # Write Python code to a temporary file
    set python_file /tmp/different_signs.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_power294
    # Python code stored as a variable
    set python_code '
def power_of_4(number: int) -> bool:
    if not isinstance(number, int):
        raise TypeError("number must be an integer")
    if number <= 0:
        raise ValueError("number must be positive")
    if number & (number - 1) == 0:
        c = 0
        while number:
            c += 1
            number >>= 1
        return c % 2 == 1
    else:
        return False


if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print(power_of_4(1))
    print(power_of_4(4))
    print(power_of_4(8))
'

    # Write Python code to a temporary file
    set python_file /tmp/power_of_4.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_reverse_bits295
    set python_code '
def get_reverse_bit_string(number: int) -> str:
    if not isinstance(number, int):
        raise TypeError(f"operation can not be conducted on an object of type {type(number).__name__}")
    bit_string = ""
    for _ in range(32):
        bit_string += str(number % 2)
        number >>= 1
    return bit_string

def reverse_bit(number: int) -> int:
    if not isinstance(number, int):
        raise TypeError("Input value must be an "int" type")
    if number < 0:
        raise ValueError("The value of input must be non-negative")
    result = 0
    for _ in range(32):
        result <<= 1
        end_bit = number & 1
        number >>= 1
        result |= end_bit
    return result

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    # Example usage
    print("get_reverse_bit_string(9) =", get_reverse_bit_string(9))
    print("reverse_bit(25) =", reverse_bit(25))
'

    set python_file /tmp/reverse_bits.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_bit_operations296
    set python_code '
def set_bit(number: int, position: int) -> int:
    return number | (1 << position)

def clear_bit(number: int, position: int) -> int:
    return number & ~(1 << position)

def flip_bit(number: int, position: int) -> int:
    return number ^ (1 << position)

def is_bit_set(number: int, position: int) -> bool:
    return ((number >> position) & 1) == 1

def get_bit(number: int, position: int) -> int:
    return int((number & (1 << position)) != 0)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    
    # Example usage
    print("set_bit(0b1101, 1) =", set_bit(0b1101, 1))
    print("clear_bit(0b10010, 1) =", clear_bit(0b10010, 1))
    print("flip_bit(0b101, 1) =", flip_bit(0b101, 1))
    print("is_bit_set(0b1010, 1) =", is_bit_set(0b1010, 1))
    print("get_bit(0b1010, 3) =", get_bit(0b1010, 3))
'

    # Write Python code to a temporary file
    set python_file /tmp/bit_ops.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_swap_odd_even_bits297
    # Store Python code in a variable
    set python_code '
def show_bits(before: int, after: int) -> str:
    return f"{before:>5}: {before:08b}\n{after:>5}: {after:08b}"

def swap_odd_even_bits(num: int) -> int:
    even_bits = num & 0xAAAAAAAA
    odd_bits = num & 0x55555555
    return even_bits >> 1 | odd_bits << 1

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    for i in (-1, 0, 1, 2, 3, 4, 23, 24):
        print(show_bits(i, swap_odd_even_bits(i)), "\\n")
'

    # Write Python code to a temporary file
    set python_file /tmp/swap_bits.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_diophantine298
    set python_code '
from __future__ import annotations

def greatest_common_divisor(a: int, b: int) -> int:
    while b:
        a, b = b, a % b
    return a

def extended_gcd(a: int, b: int) -> tuple[int, int, int]:
    if b == 0:
        return (a, 1, 0)
    else:
        d, p, q = extended_gcd(b, a % b)
        x = q
        y = p - q * (a // b)
        return (d, x, y)

def diophantine(a: int, b: int, c: int) -> tuple[float, float]:
    assert c % greatest_common_divisor(a, b) == 0
    d, x, y = extended_gcd(a, b)
    r = c / d
    return (r * x, r * y)

def diophantine_all_soln(a: int, b: int, c: int, n: int = 2) -> None:
    x0, y0 = diophantine(a, b, c)
    d = greatest_common_divisor(a, b)
    p = a // d
    q = b // d
    for i in range(n):
        x = x0 + i * q
        y = y0 - i * p
        print(x, y)

if __name__ == "__main__":
    from doctest import testmod
    testmod(verbose=True)
    print("--- Examples ---")
    diophantine_all_soln(10, 6, 14, 4)
    diophantine_all_soln(391, 299, -69, 4)
'

    # Write Python code to a temporary file
    set python_file /tmp/diophantine.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


function algoP.run_game_of_life299
    set python_code '
from __future__ import annotations
from PIL import Image

GLIDER = [
    [0, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0],
]

def new_generation(cells: list[list[int]]) -> list[list[int]]:
    next_gen = []
    for i in range(len(cells)):
        row = []
        for j in range(len(cells[i])):
            count = sum(
                cells[x][y]
                for x in range(max(0,i-1), min(i+2,len(cells)))
                for y in range(max(0,j-1), min(j+2,len(cells[i])))
                if (x,y)!=(i,j)
            )
            alive = cells[i][j]==1
            row.append(1 if (alive and 2<=count<=3) or (not alive and count==3) else 0)
        next_gen.append(row)
    return next_gen

def generate_images(cells: list[list[int]], frames: int) -> list[Image.Image]:
    images = []
    for _ in range(frames):
        img = Image.new("RGB", (len(cells[0]), len(cells)))
        pixels = img.load()
        for x in range(len(cells)):
            for y in range(len(cells[0])):
                c = 255 - cells[y][x]*255
                pixels[x, y] = (c, c, c)
        images.append(img)
        cells = new_generation(cells)
    return images

if __name__ == "__main__":
    images = generate_images(GLIDER, 16)
    images[0].save("out.gif", save_all=True, append_images=images[1:])
'

    # Write Python code to a temporary file
    set python_file /tmp/game_of_life.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end

function algoP.run_langtons_ant300
    set python_code '
from functools import partial
from matplotlib import pyplot as plt
from matplotlib.animation import FuncAnimation

WIDTH = 80
HEIGHT = 80


class LangtonsAnt:
    def __init__(self, width: int, height: int) -> None:
        self.board = [[True] * width for _ in range(height)]
        self.ant_position = (width // 2, height // 2)
        # 0=up, 1=right, 2=down, 3=left
        self.ant_direction = 3

    def move_ant(self, axes, display, _frame):
        directions = {
            0: (-1, 0),
            1: (0, 1),
            2: (1, 0),
            3: (0, -1),
        }

        x, y = self.ant_position

        # Turn based on color
        if self.board[x][y]:
            self.ant_direction = (self.ant_direction + 1) % 4
        else:
            self.ant_direction = (self.ant_direction - 1) % 4

        # Move
        dx, dy = directions[self.ant_direction]
        self.ant_position = (x + dx, y + dy)

        # Flip color
        self.board[x][y] = not self.board[x][y]

        if display and axes:
            axes.clear()
            axes.set_xticks([])
            axes.set_yticks([])
            axes.imshow(self.board, cmap="gray", interpolation="nearest")

    def display(self, frames=100000):
        fig, ax = plt.subplots()
        self.animation = FuncAnimation(
            fig,
            partial(self.move_ant, ax, True),
            frames=frames,
            interval=1
        )
        plt.show()


if __name__ == "__main__":
    LangtonsAnt(WIDTH, HEIGHT).display()
'

    # Write Python code to a temporary file
    set python_file /tmp/langtons_ant.py
    echo "$python_code" > $python_file

    # Run the Python script
    python3 $python_file
end


# function algoP.run_game_of_life
#     if test (count $argv) -ne 1
#         echo "Usage: run_game_of_life <size_of_canvas:int>"
#         return 1
#     end

#     set canvas_size $argv[1]

#     # Store Python code in a temporary variable
#     set python_code "
# import random
# import sys
# import numpy as np
# from matplotlib import pyplot as plt
# from matplotlib.colors import ListedColormap

# def create_canvas(size: int):
#     return [[False for _ in range(size)] for _ in range(size)]

# def seed(canvas):
#     for i, row in enumerate(canvas):
#         for j, _ in enumerate(row):
#             canvas[i][j] = bool(random.getrandbits(1))

# def run(canvas):
#     current_canvas = np.array(canvas)
#     next_gen_canvas = np.array(create_canvas(current_canvas.shape[0]))

#     for r, row in enumerate(current_canvas):
#         for c, pt in enumerate(row):
#             next_gen_canvas[r][c] = judge_point(
#                 pt, current_canvas[r-1:r+2, c-1:c+2]
#             )

#     return next_gen_canvas.tolist()

# def judge_point(pt, neighbours):
#     alive = 0
#     dead = 0

#     for row in neighbours:
#         for status in row:
#             if status:
#                 alive += 1
#             else:
#                 dead += 1

#     # Remove center point
#     if pt:
#         alive -= 1
#     else:
#         dead -= 1

#     if pt:
#         if alive < 2:
#             return False
#         elif alive in (2, 3):
#             return True
#         else:
#             return False
#     else:
#         return alive == 3

# if __name__ == '__main__':
#     size = int(sys.argv[1])
#     canvas = create_canvas(size)
#     seed(canvas)

#     fig, ax = plt.subplots()
#     cmap = ListedColormap(['w', 'k'])

#     try:
#         while True:
#             canvas = run(canvas)
#             ax.matshow(canvas, cmap=cmap)
#             ax.set_xticks([])
#             ax.set_yticks([])
#             fig.canvas.draw()
#             ax.cla()
#     except KeyboardInterrupt:
#         pass
# "

#     # Write Python code to a temporary file
#     set python_file /tmp/game_of_life.py
#     echo "$python_code" > $python_file

#     # Run the Python script
#     python3 $python_file $canvas_size
# end


# function algoP.run_highway_simulation
#     if test (count $argv) -lt 4
#         echo "Usage: run_highway_simulation <cells> <frequency> <initial_speed> <updates> [probability] [max_speed]"
#         return 1
#     end

#     set cells $argv[1]
#     set frequency $argv[2]
#     set initial_speed $argv[3]
#     set updates $argv[4]
#     set probability (count $argv) -ge 5; and echo $argv[5]; or echo 0.1
#     set max_speed (count $argv) -ge 6; and echo $argv[6]; or echo 5

#     set python_code "
# from random import randint, random
# import sys

# def construct_highway(
#     number_of_cells,
#     frequency,
#     initial_speed,
#     random_frequency=False,
#     random_speed=False,
#     max_speed=5,
# ):
#     highway = [[-1] * number_of_cells]
#     i = 0
#     initial_speed = max(initial_speed, 0)
#     while i < number_of_cells:
#         highway[0][i] = randint(0, max_speed) if random_speed else initial_speed
#         i += randint(1, max_speed * 2) if random_frequency else frequency
#     return highway

# def get_distance(highway_now, car_index):
#     distance = 0
#     cells = highway_now[car_index + 1 :]
#     for cell in range(len(cells)):
#         if cells[cell] != -1:
#             return distance
#         distance += 1
#     return distance + get_distance(highway_now, -1)

# def update(highway_now, probability, max_speed):
#     number_of_cells = len(highway_now)
#     next_highway = [-1] * number_of_cells

#     for car_index in range(number_of_cells):
#         if highway_now[car_index] != -1:
#             speed = min(highway_now[car_index] + 1, max_speed)
#             dn = get_distance(highway_now, car_index) - 1
#             speed = min(speed, dn)
#             if random() < probability:
#                 speed = max(speed - 1, 0)
#             next_highway[car_index] = speed
#     return next_highway

# def simulate(highway, number_of_update, probability, max_speed):
#     number_of_cells = len(highway[0])

#     for _ in range(number_of_update):
#         next_speeds = update(highway[-1], probability, max_speed)
#         real_next = [-1] * number_of_cells

#         for car_index, speed in enumerate(next_speeds):
#             if speed != -1:
#                 index = (car_index + speed) % number_of_cells
#                 real_next[index] = speed

#         highway.append(real_next)

#     return highway

# if __name__ == '__main__':
#     cells = int(sys.argv[1])
#     frequency = int(sys.argv[2])
#     initial_speed = int(sys.argv[3])
#     updates = int(sys.argv[4])
#     probability = float(sys.argv[5])
#     max_speed = int(sys.argv[6])

#     highway = construct_highway(cells, frequency, initial_speed, max_speed=max_speed)
#     result = simulate(highway, updates, probability, max_speed)

#     for step, state in enumerate(result):
#         print(f\"{step:03}:\", state)
# "

#     set python_file /tmp/highway_simulation.py
#     echo "$python_code" > $python_file

#     python3 $python_file $cells $frequency $initial_speed $updates $probability $max_speed
# end



function algoP.run_elementary301
    if test (count $argv) -ne 1
        echo "Usage: run_elementary_ca <rule_number (0–255)>"
        return 1
    end

    set rule_number $argv[1]

    set python_code "
from __future__ import annotations
from PIL import Image
import sys

CELLS = [[
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
]]

def format_ruleset(ruleset: int) -> list[int]:
    return [int(c) for c in f\"{ruleset:08}\"[:8]]

def new_generation(cells: list[list[int]], rule: list[int], time: int) -> list[int]:
    population = len(cells[0])
    next_generation = []
    for i in range(population):
        left = 0 if i == 0 else cells[time][i - 1]
        right = 0 if i == population - 1 else cells[time][i + 1]
        situation = 7 - int(f\"{left}{cells[time][i]}{right}\", 2)
        next_generation.append(rule[situation])
    return next_generation

def generate_image(cells: list[list[int]]) -> Image.Image:
    img = Image.new(\"RGB\", (len(cells[0]), len(cells)))
    pixels = img.load()
    for w in range(img.width):
        for h in range(img.height):
            color = 255 - int(255 * cells[h][w])
            pixels[w, h] = (color, color, color)
    return img

if __name__ == '__main__':
    rule_num = int(sys.argv[1])
    rule = format_ruleset(rule_num)

    for t in range(16):
        CELLS.append(new_generation(CELLS, rule, t))

    img = generate_image(CELLS)
    img.show()
"

    set python_file /tmp/elementary_ca.py
    echo "$python_code" > $python_file

    python3 $python_file $rule_number
end


function algoP.one_dimensional302
    # Set the output file name
    set output_file "cellular_automata_example.py"

    # Python code template
    set automata_template_content '

from __future__ import annotations
from PIL import Image

# Define the first generation of cells
CELLS = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]

def format_ruleset(ruleset: int) -> list[int]:
    return [int(c) for c in f"{ruleset:08}"[:8]]

def new_generation(cells: list[list[int]], rule: list[int], time: int) -> list[int]:
    population = len(cells[0])
    next_generation = []

    for i in range(population):
        left_neighbor = 0 if i == 0 else cells[time][i - 1]
        right_neighbor = 0 if i == population - 1 else cells[time][i + 1]
        situation = 7 - int(f"{left_neighbor}{cells[time][i]}{right_neighbor}", 2)
        next_generation.append(rule[situation])

    return next_generation

def generate_image(cells: list[list[int]]) -> Image.Image:
    img = Image.new("RGB", (len(cells[0]), len(cells)))
    pixels = img.load()

    for w in range(img.width):
        for h in range(img.height):
            color = 255 - int(255 * cells[h][w])
            pixels[w, h] = (color, color, color)

    return img

if __name__ == "__main__":
    rule_num = bin(int(input("Rule:\\n").strip()))[2:]
    rule = format_ruleset(int(rule_num))

    for time in range(16):
        CELLS.append(new_generation(CELLS, rule, time))

    img = generate_image(CELLS)
    img.show()
'

    echo "$automata_template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.generate_wator_algorithm303
    # Set the output file name
    set output_file "wator_algorithm.py"

    # Python code template
    set wator_template_content '

from collections.abc import Callable
from random import randint, shuffle
from time import sleep
from typing import Literal

WIDTH = 50
HEIGHT = 50

PREY_INITIAL_COUNT = 30
PREY_REPRODUCTION_TIME = 5

PREDATOR_INITIAL_COUNT = 50
PREDATOR_INITIAL_ENERGY_VALUE = 15
PREDATOR_FOOD_VALUE = 5
PREDATOR_REPRODUCTION_TIME = 20

MAX_ENTITIES = 500
DELETE_UNBALANCED_ENTITIES = 50


class Entity:
    def __init__(self, prey: bool, coords: tuple[int, int]) -> None:
        self.prey = prey
        self.coords = coords
        self.remaining_reproduction_time = (
            PREY_REPRODUCTION_TIME if prey else PREDATOR_REPRODUCTION_TIME
        )
        self.energy_value = None if prey else PREDATOR_INITIAL_ENERGY_VALUE
        self.alive = True

    def reset_reproduction_time(self) -> None:
        self.remaining_reproduction_time = (
            PREY_REPRODUCTION_TIME if self.prey else PREDATOR_REPRODUCTION_TIME
        )

    def __repr__(self) -> str:
        repr_ = (
            f"Entity(prey={self.prey}, coords={self.coords}, "
            f"remaining_reproduction_time={self.remaining_reproduction_time}"
        )
        if self.energy_value is not None:
            repr_ += f", energy_value={self.energy_value}"
        return f"{repr_})"


class WaTor:
    time_passed: Callable[["WaTor", int], None] | None

    def __init__(self, width: int, height: int) -> None:
        self.width = width
        self.height = height
        self.time_passed = None
        self.planet = [[None] * width for _ in range(height)]

        for _ in range(PREY_INITIAL_COUNT):
            self.add_entity(prey=True)
        for _ in range(PREDATOR_INITIAL_COUNT):
            self.add_entity(prey=False)

    def add_entity(self, prey: bool) -> None:
        while True:
            r, c = randint(0, self.height - 1), randint(0, self.width - 1)
            if self.planet[r][c] is None:
                self.planet[r][c] = Entity(prey, (r, c))
                return

    def get_entities(self):
        return [e for row in self.planet for e in row if e]

    def get_surrounding_prey(self, entity: Entity):
        r, c = entity.coords
        adjacent = [(r-1,c),(r+1,c),(r,c-1),(r,c+1)]
        return [
            self.planet[x][y]
            for x,y in adjacent
            if 0 <= x < self.height and 0 <= y < self.width
            and self.planet[x][y] and self.planet[x][y].prey
        ]

    def move_and_reproduce(self, entity, directions):
        r, c = old = entity.coords
        for d in directions:
            nr, nc = {
                "N": (r-1,c), "S": (r+1,c),
                "W": (r,c-1), "E": (r,c+1)
            }[d]
            if 0 <= nr < self.height and 0 <= nc < self.width:
                if self.planet[nr][nc] is None:
                    self.planet[nr][nc] = entity
                    self.planet[r][c] = None
                    entity.coords = (nr, nc)
                    break

        if old != entity.coords and entity.remaining_reproduction_time <= 0:
            if len(self.get_entities()) < MAX_ENTITIES:
                self.planet[r][c] = Entity(entity.prey, old)
                entity.reset_reproduction_time()
        else:
            entity.remaining_reproduction_time -= 1

    def run(self, iteration_count: int):
        for i in range(iteration_count):
            entities = self.get_entities()
            shuffle(entities)

            for entity in entities:
                if not entity.alive:
                    continue
                dirs = ["N","E","S","W"]
                shuffle(dirs)

                if entity.prey:
                    self.move_and_reproduce(entity, dirs)
                else:
                    prey = self.get_surrounding_prey(entity)
                    if prey:
                        p = prey[0]
                        self.planet[p.coords[0]][p.coords[1]] = entity
                        self.planet[entity.coords[0]][entity.coords[1]] = None
                        entity.coords = p.coords
                        entity.energy_value += PREDATOR_FOOD_VALUE
                    else:
                        self.move_and_reproduce(entity, dirs)
                    entity.energy_value -= 1
                    if entity.energy_value <= 0:
                        self.planet[entity.coords[0]][entity.coords[1]] = None

            if self.time_passed:
                self.time_passed(self, i)


def visualise(wt, i):
    print("\\033[H\\033[J")
    for row in wt.planet:
        print("".join(" # " if e and e.prey else " x " if e else " . " for e in row))
    sleep(0.05)


if __name__ == "__main__":
    wt = WaTor(WIDTH, HEIGHT)
    wt.time_passed = visualise
    wt.run(100_000)
'

    # Write to file
    echo "$wator_template_content" > $output_file

    # Notify user
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display contents
    cat $output_file
end

function algoP.generate_and_gate304
    # Set the output file name
    set output_file "and_gate.py"

    # Python code template
    set and_gate_template_content '


def and_gate(input_1: int, input_2: int) -> int:
    return int(input_1 and input_2)


def n_input_and_gate(inputs: list[int]) -> int:
    return int(all(inputs))


if __name__ == "__main__":
    import doctest
    doctest.testmod()
'

    # Write the Python code to file
    echo "$and_gate_template_content" > $output_file

    # Notify user
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display file contents
    cat $output_file
end


function algoP.generate_imply_gate305
    # Set the output file name
    set output_file "imply_gate.py"

    # Python code template
    set imply_gate_template_content '


def imply_gate(input_1: int, input_2: int) -> int:
    return int(input_1 == 0 or input_2 == 1)


def recursive_imply_list(input_list: list[int]) -> int:
    if len(input_list) < 2:
        raise ValueError("Input list must contain at least two elements")
    first_implication = imply_gate(input_list[0], input_list[1])
    if len(input_list) == 2:
        return first_implication
    new_list = [first_implication, *input_list[2:]]
    return recursive_imply_list(new_list)


if __name__ == "__main__":
    import doctest
    doctest.testmod()
'

    # Write the Python code to file
    echo "$imply_gate_template_content" > $output_file

    # Notify user
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display file contents
    cat $output_file
end


function algoP.generate_nand_gate306
    # Output Python file
    set output_file "nand_gate.py"

    # Python code template
    set python_code '

def nand_gate(input_1: int, input_2: int) -> int:
    return int(not (input_1 and input_2))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end


function algoP.generate_nimply_gate307
    # Output Python file
    set output_file "nimply_gate.py"

    # Python code template
    set python_code '

def nimply_gate(input_1: int, input_2: int) -> int:
    return int(input_1 == 1 and input_2 == 0)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end


# function algoP.generate_nor_gate_template
#     # Output Python file
#     set output_file "nor_gate.py"

#     # Python code template
#     set python_code '

# from collections.abc import Callable


# def nor_gate(input_1: int, input_2: int) -> int:
#     return int(input_1 == input_2 == 0)


# def truth_table(func: Callable) -> str:

#     def make_table_row(items: list | tuple) -> str:
#         return f"| {' | '.join(f\'{item:^8}\' for item in items)} |"

#     return "\n".join(
#         (
#             "Truth Table of NOR Gate:",
#             make_table_row(("Input 1", "Input 2", "Output")),
#             *[make_table_row((i, j, func(i, j))) for i in (0, 1) for j in (0, 1)],
#         )
#     )


# if __name__ == "__main__":
#     import doctest

#     doctest.testmod()
#     print(truth_table(nor_gate))
# '

#     # Write the Python code to file
#     echo "$python_code" > $output_file

#     # Notify user
#     set_color green
#     echo "$output_file created successfully"
#     set_color normal

#     # Display file contents
#     cat $output_file
# end


function algoP.generate_not_gate308
    # Output Python file
    set output_file "not_gate.py"

    # Python code template
    set python_code '


def not_gate(input_1: int) -> int:
    return 1 if input_1 == 0 else 0


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file 
end




function algoP.generate_qm309
    # Output Python file
    set output_file "quine_mccluskey.py"

    # Python code template
    set python_code '
from __future__ import annotations

from collections.abc import Sequence
from typing import Literal


def compare_string(string1: str, string2: str) -> str | Literal[False]:
    list1 = list(string1)
    list2 = list(string2)
    count = 0
    for i in range(len(list1)):
        if list1[i] != list2[i]:
            count += 1
            list1[i] = "_"
    if count > 1:
        return False
    else:
        return "".join(list1)


def check(binary: list[str]) -> list[str]:
    pi = []
    while True:
        check1 = ["$"] * len(binary)
        temp = []
        for i in range(len(binary)):
            for j in range(i + 1, len(binary)):
                k = compare_string(binary[i], binary[j])
                if k is False:
                    check1[i] = "*"
                    check1[j] = "*"
                    temp.append("X")
        for i in range(len(binary)):
            if check1[i] == "$":
                pi.append(binary[i])
        if len(temp) == 0:
            return pi
        binary = list(set(temp))


def decimal_to_binary(no_of_variable: int, minterms: Sequence[float]) -> list[str]:

    temp = []
    for minterm in minterms:
        string = ""
        for _ in range(no_of_variable):
            string = str(minterm % 2) + string
            minterm //= 2
        temp.append(string)
    return temp


def is_for_table(string1: str, string2: str, count: int) -> bool:
    list1 = list(string1)
    list2 = list(string2)
    count_n = sum(item1 != item2 for item1, item2 in zip(list1, list2))
    return count_n == count


def selection(chart: list[list[int]], prime_implicants: list[str]) -> list[str]:
    temp = []
    select = [0] * len(chart)
    for i in range(len(chart[0])):
        count = sum(row[i] == 1 for row in chart)
        if count == 1:
            rem = max(j for j, row in enumerate(chart) if row[i] == 1)
            select[rem] = 1
    for i, item in enumerate(select):
        if item != 1:
            continue
        for j in range(len(chart[0])):
            if chart[i][j] != 1:
                continue
            for row in chart:
                row[j] = 0
        temp.append(prime_implicants[i])
    while True:
        counts = [chart[i].count(1) for i in range(len(chart))]
        max_n = max(counts)
        rem = counts.index(max_n)

        if max_n == 0:
            return temp

        temp.append(prime_implicants[rem])

        for j in range(len(chart[0])):
            if chart[rem][j] != 1:
                continue
            for i in range(len(chart)):
                chart[i][j] = 0


def prime_implicant_chart(prime_implicants: list[str], binary: list[str]) -> list[list[int]]:
 
    chart = [[0 for x in range(len(binary))] for x in range(len(prime_implicants))]
    for i in range(len(prime_implicants)):
        count = prime_implicants[i].count("_")
        for j in range(len(binary)):
            if is_for_table(prime_implicants[i], binary[j], count):
                chart[i][j] = 1
    return chart


def main() -> None:
    no_of_variable = int(input("Enter the no. of variables\n"))
    minterms = [float(x) for x in input("Enter the decimal representation of Minterms \\" \
        "'Spaces Separated'\n").split()]
    binary = decimal_to_binary(no_of_variable, minterms)

    prime_implicants = check(binary)
    print("Prime Implicants are:")
    print(prime_implicants)
    chart = prime_implicant_chart(prime_implicants, binary)

    essential_prime_implicants = selection(chart, prime_implicants)
    print("Essential Prime Implicants are:")
    print(essential_prime_implicants)


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    main()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end


function algoP.generate_xnor310
    # Output Python file
    set output_file "xnor_gate.py"

    # Python code template
    set python_code '

def xnor_gate(input_1: int, input_2: int) -> int:
    return 1 if input_1 == input_2 else 0


if __name__ == "__main__":
    import doctest
    doctest.testmod()
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_xor311
    # Output Python file
    set output_file "xor_gate.py"

    # Python code template
    set python_code '


def xor_gate(input_1: int, input_2: int) -> int:
    return (input_1, input_2).count(1) == 1

if __name__ == "__main__":
    import doctest
    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end

function algoP.generate_boyer_moore312
    # Output Python file
    set output_file "boyer_moore.py"

    # Python code template
    set python_code '


class BoyerMooreSearch:

    def __init__(self, text: str, pattern: str):
        self.text, self.pattern = text, pattern
        self.textLen, self.patLen = len(text), len(pattern)

    def match_in_pattern(self, char: str) -> int:
        """Return last index of char in pattern, or -1 if not found"""
        for i in range(self.patLen - 1, -1, -1):
            if char == self.pattern[i]:
                return i
        return -1

    def mismatch_in_text(self, current_pos: int) -> int:
        """Return index of mismatch in text or -1 if pattern matches"""
        for i in range(self.patLen - 1, -1, -1):
            if self.pattern[i] != self.text[current_pos + i]:
                return current_pos + i
        return -1

    def bad_character_heuristic(self) -> list[int]:
        """Return list of starting positions where pattern matches text"""
        positions = []
        i = 0
        while i <= self.textLen - self.patLen:
            mismatch_index = self.mismatch_in_text(i)
            if mismatch_index == -1:
                positions.append(i)
                i += 1
            else:
                match_index = self.match_in_pattern(self.text[mismatch_index])
                i += max(1, mismatch_index - match_index)
        return positions


if __name__ == "__main__":
    import doctest
    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end


function algoP.generate_sri_lankan_phone_checker313
    # Output Python file
    set output_file "sri_lankan_phone.py"

    # Python code template
    set python_code '
import re

def is_sri_lankan_phone_number(phone: str) -> bool:
    pattern = re.compile(r"^(?:0|94|\+94|0{2}94)7(0|1|2|4|5|6|7|8)(-| |)?\d{7}$")
    return bool(re.search(pattern, phone))

if __name__ == "__main__":
    phone = "0094702343221"
    print(is_sri_lankan_phone_number(phone))
    import doctest
    doctest.testmod()
'

    # Write the Python code to file
    echo "$python_code" > $output_file

    # Notify user
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display file contents
    cat $output_file
end




function algoP.generate_jaro_winkler314
    set output_file "jaro_winkler.py"

    set python_code '
def jaro_winkler(str1: str, str2: str) -> float:

    def get_matched_characters(_str1: str, _str2: str) -> str:
        matched = []
        limit = min(len(_str1), len(_str2)) // 2
        for i, char in enumerate(_str1):
            left = int(max(0, i - limit))
            right = int(min(i + limit + 1, len(_str2)))
            if char in _str2[left:right]:
                matched.append(char)
                _str2 = f"{_str2[0:_str2.index(char)]} {_str2[_str2.index(char)+1:]}"
        return "".join(matched)

    matching_1 = get_matched_characters(str1, str2)
    matching_2 = get_matched_characters(str2, str1)
    match_count = len(matching_1)

    transpositions = len([(c1,c2) for c1,c2 in zip(matching_1, matching_2) if c1 != c2]) // 2

    if not match_count:
        jaro = 0.0
    else:
        jaro = 1/3 * (match_count/len(str1) + match_count/len(str2) + (match_count-transpositions)/match_count)

    prefix_len = 0
    for c1, c2 in zip(str1[:4], str2[:4]):
        if c1 == c2:
            prefix_len += 1
        else:
            break

    return jaro + 0.1 * prefix_len * (1 - jaro)


if __name__ == "__main__":
    import doctest
    doctest.testmod()
    print("Jaro-Winkler similarity between \"hello\" and \"world\" =", jaro_winkler("hello", "world"))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




# function algoP.generate_z_function
#     set output_file "z_function.py"

#     set python_code '
# def z_function(input_str: str) -> list[int]:
 
#     z_result = [0] * len(input_str)
#     left_pointer, right_pointer = 0, 0

#     for i in range(1, len(input_str)):
#         if i <= right_pointer:
#             z_result[i] = min(right_pointer - i + 1, z_result[i - left_pointer])

#         while go_next(i, z_result, input_str):
#             z_result[i] += 1

#         if i + z_result[i] - 1 > right_pointer:
#             left_pointer, right_pointer = i, i + z_result[i] - 1

#     return z_result


# def go_next(i: int, z_result: list[int], s: str) -> bool:
#     return i + z_result[i] < len(s) and s[z_result[i]] == s[i + z_result[i]]


# def find_pattern(pattern: str, input_str: str) -> int:
#     answer = 0
#     z_result = z_function(pattern + input_str)

#     for val in z_result:
#         if val >= len(pattern):
#             answer += 1

#     return answer


# if __name__ == "__main__":
#     import doctest
#     doctest.testmod()
#     print("Pattern \'abr\' appears", find_pattern("abr", "abracadabra"), "times")
# '

#     echo "$python_code" > $output_file
#     set_color green
#     echo "$output_file created successfully"
#     set_color normal
#     cat $output_file
# end



function algoP.generate_bogo_sort315
    set output_file "bogo_sort.py"

    set python_code '


import random

def bogo_sort(collection):
    def is_sorted(collection):
        for i in range(len(collection) - 1):
            if collection[i] > collection[i + 1]:
                return False
        return True

    while not is_sorted(collection):
        random.shuffle(collection)
    return collection

if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\\n").strip()
    unsorted = [int(item) for item in user_input.split(",")]
    print(bogo_sort(unsorted))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_double_sort316
    set output_file "double_sort.py"

    set python_code '
from typing import Any

def double_sort(collection: list[Any]) -> list[Any]:
    no_of_elements = len(collection)
    for _ in range(int(((no_of_elements - 1) / 2) + 1)):
        for j in range(no_of_elements - 1):
            if collection[j + 1] < collection[j]:
                collection[j], collection[j + 1] = collection[j + 1], collection[j]
            if collection[no_of_elements - 1 - j] < collection[no_of_elements - 2 - j]:
                collection[no_of_elements - 1 - j], collection[no_of_elements - 2 - j] = \
                    collection[no_of_elements - 2 - j], collection[no_of_elements - 1 - j]
    return collection

if __name__ == "__main__":
    unsorted = [int(x) for x in input("Enter the list to be sorted: ").split() if x]
    print("the sorted list is")
    print(f"{double_sort(unsorted) = }")
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end


function algoP.generate_intro_sort317
    set output_file "intro_sort.py"

    set python_code '

import math

def insertion_sort(array: list, start: int = 0, end: int = 0) -> list:
    end = end or len(array)
    for i in range(start, end):
        temp_index = i
        temp_index_value = array[i]
        while temp_index != start and temp_index_value < array[temp_index - 1]:
            array[temp_index] = array[temp_index - 1]
            temp_index -= 1
        array[temp_index] = temp_index_value
    return array

def heapify(array: list, index: int, heap_size: int) -> None:
    largest = index
    left_index = 2 * index + 1
    right_index = 2 * index + 2

    if left_index < heap_size and array[largest] < array[left_index]:
        largest = left_index
    if right_index < heap_size and array[largest] < array[right_index]:
        largest = right_index
    if largest != index:
        array[index], array[largest] = array[largest], array[index]
        heapify(array, largest, heap_size)

def heap_sort(array: list) -> list:
    n = len(array)
    for i in range(n // 2, -1, -1):
        heapify(array, i, n)
    for i in range(n - 1, 0, -1):
        array[i], array[0] = array[0], array[i]
        heapify(array, 0, i)
    return array

def median_of_3(array: list, first_index: int, middle_index: int, last_index: int) -> int:
    if (array[first_index] > array[middle_index]) != (array[first_index] > array[last_index]):
        return array[first_index]
    elif (array[middle_index] > array[first_index]) != (array[middle_index] > array[last_index]):
        return array[middle_index]
    else:
        return array[last_index]

def partition(array: list, low: int, high: int, pivot: int) -> int:
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

def sort(array: list) -> list:
    if len(array) == 0:
        return array
    max_depth = 2 * math.ceil(math.log2(len(array)))
    size_threshold = 16
    return intro_sort(array, 0, len(array), size_threshold, max_depth)

def intro_sort(array: list, start: int, end: int, size_threshold: int, max_depth: int) -> list:
    while end - start > size_threshold:
        if max_depth == 0:
            return heap_sort(array)
        max_depth -= 1
        pivot = median_of_3(array, start, start + ((end - start) // 2) + 1, end - 1)
        p = partition(array, start, end, pivot)
        intro_sort(array, p, end, size_threshold, max_depth)
        end = p
    return insertion_sort(array, start, end)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    user_input = input("Enter numbers separated by a comma : ").strip()
    unsorted = [float(item) for item in user_input.split(",")]
    print(f"{sort(unsorted) = }")
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_iterative_merge_sort318
    set output_file "iterative_merge_sort.py"

    set python_code '

from __future__ import annotations

def merge(input_list: list, low: int, mid: int, high: int) -> list:
    result = []
    left, right = input_list[low:mid], input_list[mid : high + 1]
    while left and right:
        result.append((left if left[0] <= right[0] else right).pop(0))
    input_list[low : high + 1] = result + left + right
    return input_list

def iter_merge_sort(input_list: list) -> list:
    if len(input_list) <= 1:
        return input_list
    input_list = list(input_list)
    p = 2
    while p <= len(input_list):
        for i in range(0, len(input_list), p):
            low = i
            high = i + p - 1
            mid = (low + high + 1) // 2
            input_list = merge(input_list, low, mid, high)
        if p * 2 >= len(input_list):
            mid = i
            input_list = merge(input_list, 0, mid, len(input_list) - 1)
            break
        p *= 2
    return input_list

if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\n").strip()
    if user_input == "":
        unsorted = []
    else:
        unsorted = [int(item.strip()) for item in user_input.split(",")]
    print(iter_merge_sort(unsorted))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_merge_insertion_sort319
    set output_file "merge_insertion_sort.py"

    set python_code '


from __future__ import annotations

def binary_search_insertion(sorted_list, item):
    left = 0
    right = len(sorted_list) - 1
    while left <= right:
        middle = (left + right) // 2
        if left == right:
            if sorted_list[middle] < item:
                left = middle + 1
            break
        elif sorted_list[middle] < item:
            left = middle + 1
        else:
            right = middle - 1
    sorted_list.insert(left, item)
    return sorted_list

def merge(left, right):
    result = []
    while left and right:
        if left[0][0] < right[0][0]:
            result.append(left.pop(0))
        else:
            result.append(right.pop(0))
    return result + left + right

def sortlist_2d(list_2d):
    length = len(list_2d)
    if length <= 1:
        return list_2d
    middle = length // 2
    return merge(sortlist_2d(list_2d[:middle]), sortlist_2d(list_2d[middle:]))

def merge_insertion_sort(collection: list[int]) -> list[int]:
    if len(collection) <= 1:
        return collection
    two_paired_list = []
    has_last_odd_item = False
    for i in range(0, len(collection), 2):
        if i == len(collection) - 1:
            has_last_odd_item = True
        else:
            if collection[i] < collection[i + 1]:
                two_paired_list.append([collection[i], collection[i + 1]])
            else:
                two_paired_list.append([collection[i + 1], collection[i]])
    sorted_list_2d = sortlist_2d(two_paired_list)
    result = [i[0] for i in sorted_list_2d]
    result.append(sorted_list_2d[-1][1])
    if has_last_odd_item:
        pivot = collection[-1]
        result = binary_search_insertion(result, pivot)
    is_last_odd_item_inserted_before_this_index = False
    for i in range(len(sorted_list_2d) - 1):
        if result[i] == collection[-1] and has_last_odd_item:
            is_last_odd_item_inserted_before_this_index = True
        pivot = sorted_list_2d[i][1]
        if is_last_odd_item_inserted_before_this_index:
            result = result[: i + 2] + binary_search_insertion(result[i + 2 :], pivot)
        else:
            result = result[: i + 1] + binary_search_insertion(result[i + 1 :], pivot)
    return result

if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\n").strip()
    unsorted = [int(item) for item in user_input.split(",")]
    print(merge_insertion_sort(unsorted))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_msd_radix_sort320
    set output_file "msd_radix_sort.py"

    set python_code '


from __future__ import annotations

def msd_radix_sort(list_of_ints: list[int]) -> list[int]:
    if not list_of_ints:
        return []
    if min(list_of_ints) < 0:
        raise ValueError("All numbers must be positive")
    most_bits = max(len(bin(x)[2:]) for x in list_of_ints)
    return _msd_radix_sort(list_of_ints, most_bits)

def _msd_radix_sort(list_of_ints: list[int], bit_position: int) -> list[int]:
    if bit_position == 0 or len(list_of_ints) in [0, 1]:
        return list_of_ints
    zeros = []
    ones = []
    for number in list_of_ints:
        if (number >> (bit_position - 1)) & 1:
            ones.append(number)
        else:
            zeros.append(number)
    zeros = _msd_radix_sort(zeros, bit_position - 1)
    ones = _msd_radix_sort(ones, bit_position - 1)
    res = zeros
    res.extend(ones)
    return res

def msd_radix_sort_inplace(list_of_ints: list[int]):
    length = len(list_of_ints)
    if not list_of_ints or length == 1:
        return
    if min(list_of_ints) < 0:
        raise ValueError("All numbers must be positive")
    most_bits = max(len(bin(x)[2:]) for x in list_of_ints)
    _msd_radix_sort_inplace(list_of_ints, most_bits, 0, length)

def _msd_radix_sort_inplace(list_of_ints: list[int], bit_position: int, begin_index: int, end_index: int):
    if bit_position == 0 or end_index - begin_index <= 1:
        return
    bit_position -= 1
    i = begin_index
    j = end_index - 1
    while i <= j:
        changed = False
        if not (list_of_ints[i] >> bit_position) & 1:
            i += 1
            changed = True
        if (list_of_ints[j] >> bit_position) & 1:
            j -= 1
            changed = True
        if changed:
            continue
        list_of_ints[i], list_of_ints[j] = list_of_ints[j], list_of_ints[i]
        j -= 1
        if j != i:
            i += 1
    _msd_radix_sort_inplace(list_of_ints, bit_position, begin_index, i)
    _msd_radix_sort_inplace(list_of_ints, bit_position, i, end_index)

if __name__ == "__main__":
    import doctest
    doctest.testmod()
    user_input = input("Enter positive integers separated by commas:\n").strip()
    if user_input:
        numbers = [int(x) for x in user_input.split(",")]
        print(msd_radix_sort(numbers))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_natural_sort321
    set output_file "natural_sort.py"

    set python_code '
from __future__ import annotations
import re

def natural_sort(input_list: list[str]) -> list[str]:
   
    def alphanum_key(key):
        return [int(s) if s.isdigit() else s.lower() for s in re.split("([0-9]+)", key)]

    return sorted(input_list, key=alphanum_key)

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    user_input = input("Enter strings separated by commas:\n").strip()
    if user_input:
        strings = [x.strip() for x in user_input.split(",")]
        print(natural_sort(strings))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end


function algoP.generate_odd_even_sort322
    set output_file "odd_even_sort.py"

    set python_code '

def odd_even_sort(input_list: list) -> list:
 
    is_sorted = False
    while not is_sorted:  # Until all the indices are traversed keep looping
        is_sorted = True
        for i in range(0, len(input_list) - 1, 2):  # iterating over even indices
            if input_list[i] > input_list[i + 1]:
                input_list[i], input_list[i + 1] = input_list[i + 1], input_list[i]
                is_sorted = False

        for i in range(1, len(input_list) - 1, 2):  # iterating over odd indices
            if input_list[i] > input_list[i + 1]:
                input_list[i], input_list[i + 1] = input_list[i + 1], input_list[i]
                is_sorted = False
    return input_list

if __name__ == "__main__":
    user_input = input("Enter numbers separated by spaces:\n").strip()
    if user_input:
        input_list = [int(x) for x in user_input.split()]
        print("Sorted list:")
        print(odd_even_sort(input_list))
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end


function algoP.generate_odd_even_transposition_sort323
    set output_file "odd_even_transposition_sort.py"

    set python_code '


import multiprocessing as mp

def oe_process(position, value, l_send, r_send, lr_cv, rr_cv, result_pipe, multiprocessing_context):
    process_lock = multiprocessing_context.Lock()
    for i in range(10):
        if (i + position) % 2 == 0 and r_send is not None:
            with process_lock:
                r_send[1].send(value)
            with process_lock:
                temp = rr_cv[0].recv()
            value = min(value, temp)
        elif (i + position) % 2 != 0 and l_send is not None:
            with process_lock:
                l_send[1].send(value)
            with process_lock:
                temp = lr_cv[0].recv()
            value = max(value, temp)
    result_pipe[1].send(value)

def odd_even_transposition(arr):
    multiprocessing_context = mp.get_context("spawn")
    process_array_ = []
    result_pipe = [multiprocessing_context.Pipe() for _ in arr]

    temp_rs = multiprocessing_context.Pipe()
    temp_rr = multiprocessing_context.Pipe()
    process_array_.append(
        multiprocessing_context.Process(
            target=oe_process,
            args=(0, arr[0], None, temp_rs, None, temp_rr, result_pipe[0], multiprocessing_context)
        )
    )
    temp_lr = temp_rs
    temp_ls = temp_rr

    for i in range(1, len(arr) - 1):
        temp_rs = multiprocessing_context.Pipe()
        temp_rr = multiprocessing_context.Pipe()
        process_array_.append(
            multiprocessing_context.Process(
                target=oe_process,
                args=(i, arr[i], temp_ls, temp_rs, temp_lr, temp_rr, result_pipe[i], multiprocessing_context)
            )
        )
        temp_lr = temp_rs
        temp_ls = temp_rr

    process_array_.append(
        multiprocessing_context.Process(
            target=oe_process,
            args=(len(arr) - 1, arr[-1], temp_ls, None, temp_lr, None, result_pipe[-1], multiprocessing_context)
        )
    )

    for p in process_array_:
        p.start()

    for i in range(len(result_pipe)):
        arr[i] = result_pipe[i][0].recv()
        process_array_[i].join()
    return arr

def main():
    arr = list(range(10, 0, -1))
    print("Initial List")
    print(*arr)
    arr = odd_even_transposition(arr)
    print("Sorted List\n")
    print(*arr)

if __name__ == "__main__":
    main()
'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_odd_even_transposition_sort324
    set output_file "odd_even_transposition_sort_non_parallel.py"

    set python_code '


def odd_even_transposition(arr: list) -> list:

    arr_size = len(arr)
    for _ in range(arr_size):
        for i in range(_ % 2, arr_size - 1, 2):
            if arr[i + 1] < arr[i]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]

    return arr

if __name__ == "__main__":
    arr = list(range(10, 0, -1))
    print(f"Original: {arr}. Sorted: {odd_even_transposition(arr)}")
'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_pancake_sort325
    set output_file "pancake_sort.py"

    set python_code '


def pancake_sort(arr):

    cur = len(arr)
    while cur > 1:
        # Find the maximum number in arr
        mi = arr.index(max(arr[0:cur]))
        # Reverse from 0 to mi
        arr = arr[mi::-1] + arr[mi + 1 : len(arr)]
        # Reverse whole list
        arr = arr[cur - 1 :: -1] + arr[cur : len(arr)]
        cur -= 1
    return arr

'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end





function algoP.generate_patience_sort326
    set output_file "patience_sort.py"

    set python_code '
from __future__ import annotations

from bisect import bisect_left
from functools import total_ordering
from heapq import merge



@total_ordering
class Stack(list):
    def __lt__(self, other):
        return self[-1] < other[-1]

    def __eq__(self, other):
        return self[-1] == other[-1]


def patience_sort(collection: list) -> list:

    stacks: list[Stack] = []
    # sort into stacks
    for element in collection:
        new_stacks = Stack([element])
        i = bisect_left(stacks, new_stacks)
        if i != len(stacks):
            stacks[i].append(element)
        else:
            stacks.append(new_stacks)

    # use a heap-based merge to merge stack efficiently
    collection[:] = merge(*(reversed(stack) for stack in stacks))
    return collection


'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_pigeon_sort327
    set output_file "pigeon_sort.py"

    set python_code '
from __future__ import annotations


def pigeon_sort(array: list[int]) -> list[int]:

    if len(array) == 0:
        return array

    _min, _max = min(array), max(array)

    # Compute the variables
    holes_range = _max - _min + 1
    holes, holes_repeat = [0] * holes_range, [0] * holes_range

    # Make the sorting.
    for i in array:
        index = i - _min
        holes[index] = i
        holes_repeat[index] += 1

    # Makes the array back by replacing the numbers.
    index = 0
    for i in range(holes_range):
        while holes_repeat[i] > 0:
            array[index] = holes[i]
            index += 1
            holes_repeat[i] -= 1

    # Returns the sorted array.
    return array



'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_pigeonhole_sort328
    set output_file "pigeonhole_sort.py"

    set python_code '
def pigeonhole_sort(a):

    min_val = min(a)  # min() finds the minimum value
    max_val = max(a)  # max() finds the maximum value

    size = max_val - min_val + 1  # size is difference of max and min values plus one

    # list of pigeonholes of size equal to the variable size
    holes = [0] * size

    # Populate the pigeonholes.
    for x in a:
        assert isinstance(x, int), "integers only please"
        holes[x - min_val] += 1

    # Putting the elements back into the array in an order.
    i = 0
    for count in range(size):
        while holes[count] > 0:
            holes[count] -= 1
            a[i] = count + min_val
            i += 1


def main():
    a = [8, 3, 2, 7, 4, 6, 8]
    pigeonhole_sort(a)
    print("Sorted order is:", " ".join(map(str, a)))


if __name__ == "__main__":
    main()
'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_quick_sort329
    set output_file "quick_sort.py"

    set python_code '
from __future__ import annotations

from random import randrange


def quick_sort(collection: list) -> list:
    
    # Base case: if the collection has 0 or 1 elements, it is already sorted
    if len(collection) < 2:
        return collection

    # Randomly select a pivot index and remove the pivot element from the collection
    pivot_index = randrange(len(collection))
    pivot = collection.pop(pivot_index)

    # Partition the remaining elements into two groups: lesser or equal, and greater
    lesser = [item for item in collection if item <= pivot]
    greater = [item for item in collection if item > pivot]

    # Recursively sort the lesser and greater groups, and combine with the pivot
    return [*quick_sort(lesser), pivot, *quick_sort(greater)]



'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_quick_sort_scripts330
    set output_file "quick_sort_algorithms.py"

    set python_code '
from __future__ import annotations

def quick_sort_3partition(sorting: list, left: int, right: int) -> None:

    if right <= left:
        return
    a = i = left
    b = right
    pivot = sorting[left]
    while i <= b:
        if sorting[i] < pivot:
            sorting[a], sorting[i] = sorting[i], sorting[a]
            a += 1
            i += 1
        elif sorting[i] > pivot:
            sorting[b], sorting[i] = sorting[i], sorting[b]
            b -= 1
        else:
            i += 1
    quick_sort_3partition(sorting, left, a - 1)
    quick_sort_3partition(sorting, b + 1, right)

def quick_sort_lomuto_partition(sorting: list, left: int, right: int) -> None:
   
    if left < right:
        pivot_index = lomuto_partition(sorting, left, right)
        quick_sort_lomuto_partition(sorting, left, pivot_index - 1)
        quick_sort_lomuto_partition(sorting, pivot_index + 1, right)

def lomuto_partition(sorting: list, left: int, right: int) -> int:
    pivot = sorting[right]
    store_index = left
    for i in range(left, right):
        if sorting[i] < pivot:
            sorting[store_index], sorting[i] = sorting[i], sorting[store_index]
            store_index += 1
    sorting[right], sorting[store_index] = sorting[store_index], sorting[right]
    return store_index

def three_way_radix_quicksort(sorting: list) -> list:
  
    if len(sorting) <= 1:
        return sorting
    return (
        three_way_radix_quicksort([i for i in sorting if i < sorting[0]])
        + [i for i in sorting if i == sorting[0]]
        + three_way_radix_quicksort([i for i in sorting if i > sorting[0]])
    )

'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_recursive_insertion_sort_script331
    set output_file "rec_insertion_sort.py"

    set python_code '
from __future__ import annotations

def rec_insertion_sort(collection: list, n: int):
   
    # Checks if the entire collection has been sorted
    if len(collection) <= 1 or n <= 1:
        return

    insert_next(collection, n - 1)
    rec_insertion_sort(collection, n - 1)


def insert_next(collection: list, index: int):
   
    # Checks order between adjacent elements
    if index >= len(collection) or collection[index - 1] <= collection[index]:
        return

    # Swaps adjacent elements since they are not in ascending order
    collection[index - 1], collection[index] = (
        collection[index],
        collection[index - 1],
    )

    insert_next(collection, index + 1)


if __name__ == "__main__":
    numbers = input("Enter integers separated by spaces: ")
    number_list: list[int] = [int(num) for num in numbers.split()]
    rec_insertion_sort(number_list, len(number_list))
    print(number_list)
'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end


function algoP.generate_recursive_insertion_sort_script332
    set output_file "rec_insertion_sort.py"

    set python_code '
from __future__ import annotations

def rec_insertion_sort(collection: list, n: int):
    
    # Checks if the entire collection has been sorted
    if len(collection) <= 1 or n <= 1:
        return

    insert_next(collection, n - 1)
    rec_insertion_sort(collection, n - 1)


def insert_next(collection: list, index: int):
   
    # Checks order between adjacent elements
    if index >= len(collection) or collection[index - 1] <= collection[index]:
        return

    # Swaps adjacent elements since they are not in ascending order
    collection[index - 1], collection[index] = (
        collection[index],
        collection[index - 1],
    )

    insert_next(collection, index + 1)


'
    
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_merge_sort_script333
    set output_file "merge_sort.py"

    set python_code '
def merge(arr: list[int]) -> list[int]:
   
    if len(arr) > 1:
        middle_length = len(arr) // 2  # Finds the middle of the array
        left_array = arr[
            :middle_length
        ]  # Creates an array of the elements in the first half.
        right_array = arr[
            middle_length:
        ]  # Creates an array of the elements in the second half.
        left_size = len(left_array)
        right_size = len(right_array)
        merge(left_array)  # Starts sorting the left.
        merge(right_array)  # Starts sorting the right
        left_index = 0  # Left Counter
        right_index = 0  # Right Counter
        index = 0  # Position Counter
        while (
            left_index < left_size and right_index < right_size
        ):  # Runs until the lowers size of the left and right are sorted.
            if left_array[left_index] < right_array[right_index]:
                arr[index] = left_array[left_index]
                left_index += 1
            else:
                arr[index] = right_array[right_index]
                right_index += 1
            index += 1
        while (
            left_index < left_size
        ):  # Adds the left over elements in the left half of the array
            arr[index] = left_array[left_index]
            left_index += 1
            index += 1
        while (
            right_index < right_size
        ):  # Adds the left over elements in the right half of the array
            arr[index] = right_array[right_index]
            right_index += 1
            index += 1
    return arr

if __name__ == "__main__":

'

    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_quick_sort_script334
    set output_file "quick_sort.py"

    set python_code '
def quick_sort(data: list) -> list:
    if len(data) <= 1:
        return data
    else:
        return [
            *quick_sort([e for e in data[1:] if e <= data[0]]),
            data[0],
            *quick_sort([e for e in data[1:] if e > data[0]]),
        ]

if __name__ == "__main__":
    import doctest

    doctest.testmod()
'
    
    # Create the Python script with the provided content
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_selection_sort_script335
    set output_file "selection_sort.py"

    set python_code '
def selection_sort(collection: list[int]) -> list[int]:

    length = len(collection)
    for i in range(length - 1):
        min_index = i
        for k in range(i + 1, length):
            if collection[k] < collection[min_index]:
                min_index = k
        if min_index != i:
            collection[i], collection[min_index] = collection[min_index], collection[i]
    return collection


if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\n").strip()
    unsorted = [int(item) for item in user_input.split(",")]
    sorted_list = selection_sort(unsorted)
    print("Sorted List:", sorted_list)
'
    
    # Create the Python script with the provided content
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end



function algoP.generate_shell_sort_script336
    set output_file "shell_sort.py"

    set python_code '
def shell_sort(collection: list) -> list:


    # Choose an initial gap value
    gap = len(collection)

    # Set the gap value to be decreased by a factor of 1.3
    # after each iteration
    shrink = 1.3

    # Continue sorting until the gap is 1
    while gap > 1:
        # Decrease the gap value
        gap = int(gap / shrink)

        # Sort the elements using insertion sort
        for i in range(gap, len(collection)):
            temp = collection[i]
            j = i
            while j >= gap and collection[j - gap] > temp:
                collection[j] = collection[j - gap]
                j -= gap
            collection[j] = temp

    return collection


if __name__ == "__main__":

'
    
    # Create the Python script with the provided content
    echo "$python_code" > $output_file
    set_color green
    echo "$output_file created successfully"
    set_color normal
    cat $output_file
end




function algoP.generate_slowsort_script337
    # Define the output Python file name
    set output_file "slowsort.py"

    # Define the Python code that will be written to the file
    set python_code '
from __future__ import annotations

def slowsort(sequence: list, start: int | None = None, end: int | None = None) -> None:
    if start is None:
        start = 0

    if end is None:
        end = len(sequence) - 1

    if start >= end:
        return

    mid = (start + end) // 2

    slowsort(sequence, start, mid)
    slowsort(sequence, mid + 1, end)

    if sequence[end] < sequence[mid]:
        sequence[end], sequence[mid] = sequence[mid], sequence[end]

    slowsort(sequence, start, end - 1)


if __name__ == "__main__":

'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end




function algoP.generate_stalin_sort_script338
    # Define the output Python file name
    set output_file "stalin_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
def stalin_sort(sequence: list[int]) -> list[int]:

    result = [sequence[0]]
    for element in sequence[1:]:
        if element >= result[-1]:
            result.append(element)

    return result


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end



function algoP.generate_stooge_sort_script339
    # Define the output Python file name
    set output_file "stooge_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
def stooge_sort(arr: list[int]) -> list[int]:
    stooge(arr, 0, len(arr) - 1)
    return arr


def stooge(arr: list[int], i: int, h: int) -> None:
    if i >= h:
        return

    # If first element is smaller than the last then swap them
    if arr[i] > arr[h]:
        arr[i], arr[h] = arr[h], arr[i]

    # If there are more than 2 elements in the array
    if h - i + 1 > 2:
        t = (int)((h - i + 1) / 3)

        # Recursively sort first 2/3 elements
        stooge(arr, i, (h - t))

        # Recursively sort last 2/3 elements
        stooge(arr, i + t, (h))

        # Recursively sort first 2/3 elements
        stooge(arr, i, (h - t))


if __name__ == "__main__":'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end




function algoP.generate_strand_sort_script340
    # Define the output Python file name
    set output_file "strand_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
import operator


def strand_sort(arr: list, reverse: bool = False, solution: list | None = None) -> list:
    _operator = operator.lt if reverse else operator.gt
    solution = solution or []

    if not arr:
        return solution

    sublist = [arr.pop(0)]
    for i, item in enumerate(arr):
        if _operator(item, sublist[-1]):
            sublist.append(item)
            arr.pop(i)

    #  merging sublist into solution list
    if not solution:
        solution.extend(sublist)
    else:
        while sublist:
            item = sublist.pop(0)
            for i, xx in enumerate(solution):
                if not _operator(item, xx):
                    solution.insert(i, item)
                    break
            else:
                solution.append(item)

    strand_sort(arr, reverse, solution)
    return solution


if __name__ == "__main__":
    assert strand_sort([4, 3, 5, 1, 2]) == [1, 2, 3, 4, 5]
    assert strand_sort([4, 3, 5, 1, 2], reverse=True) == [5, 4, 3, 2, 1]
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end



function algoP.generate_tim_sort_script341
    # Define the output Python file name
    set output_file "tim_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
def binary_search(lst, item, start, end):
    if start == end:
        return start if lst[start] > item else start + 1
    if start > end:
        return start

    mid = (start + end) // 2
    if lst[mid] < item:
        return binary_search(lst, item, mid + 1, end)
    elif lst[mid] > item:
        return binary_search(lst, item, start, mid - 1)
    else:
        return mid


def insertion_sort(lst):
    length = len(lst)

    for index in range(1, length):
        value = lst[index]
        pos = binary_search(lst, value, 0, index - 1)
        lst = [*lst[:pos], value, *lst[pos:index], *lst[index + 1 :]]

    return lst


def merge(left, right):
    if not left:
        return right

    if not right:
        return left

    if left[0] < right[0]:
        return [left[0], *merge(left[1:], right)]

    return [right[0], *merge(left, right[1:])]


def tim_sort(lst):

    length = len(lst)
    runs, sorted_runs = [], []
    new_run = [lst[0]]
    sorted_array = []
    i = 1
    while i < length:
        if lst[i] < lst[i - 1]:
            runs.append(new_run)
            new_run = [lst[i]]
        else:
            new_run.append(lst[i])
        i += 1
    runs.append(new_run)

    for run in runs:
        sorted_runs.append(insertion_sort(run))
    for run in sorted_runs:
        sorted_array = merge(sorted_array, run)

    return sorted_array


def main():
    lst = [5, 9, 10, 3, -4, 5, 178, 92, 46, -18, 0, 7]
    sorted_lst = tim_sort(lst)
    print(sorted_lst)


if __name__ == "__main__":
    main()
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end

function algoP.generate_tree_sort_script342
    # Define the output Python file name
    set output_file "tree_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
from __future__ import annotations

from collections.abc import Iterator
from dataclasses import dataclass


@dataclass
class Node:
    val: int
    left: Node | None = None
    right: Node | None = None

    def __iter__(self) -> Iterator[int]:
        if self.left:
            yield from self.left
        yield self.val
        if self.right:
            yield from self.right

    def __len__(self) -> int:
        return sum(1 for _ in self)

    def insert(self, val: int) -> None:
        if val < self.val:
            if self.left is None:
                self.left = Node(val)
            else:
                self.left.insert(val)
        elif val > self.val:
            if self.right is None:
                self.right = Node(val)
            else:
                self.right.insert(val)


def tree_sort(arr: list[int]) -> tuple[int, ...]:

    if len(arr) == 0:
        return tuple(arr)
    root = Node(arr[0])
    for item in arr[1:]:
        root.insert(item)
    return tuple(root)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
    print(f"{tree_sort([5, 6, 1, -1, 4, 37, -3, 7]) = }")
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end

function algoP.generate_tree_sort_script343
    # Define the output Python file name
    set output_file "tree_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
from __future__ import annotations

from collections.abc import Iterator
from dataclasses import dataclass


@dataclass
class Node:
    val: int
    left: Node | None = None
    right: Node | None = None

    def __iter__(self) -> Iterator[int]:
        if self.left:
            yield from self.left
        yield self.val
        if self.right:
            yield from self.right

    def __len__(self) -> int:
        return sum(1 for _ in self)

    def insert(self, val: int) -> None:
        if val < self.val:
            if self.left is None:
                self.left = Node(val)
            else:
                self.left.insert(val)
        elif val > self.val:
            if self.right is None:
                self.right = Node(val)
            else:
                self.right.insert(val)


def tree_sort(arr: list[int]) -> tuple[int, ...]:

    if len(arr) == 0:
        return tuple(arr)
    root = Node(arr[0])
    for item in arr[1:]:
        root.insert(item)
    return tuple(root)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
    print(f"{tree_sort([5, 6, 1, -1, 4, 37, -3, 7]) = }")
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end




function algoP.generate_merge_sort_script344
    # Define the output Python file name
    set output_file "merge_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
def merge_sort(collection):
    start, end = [], []
    while len(collection) > 1:
        min_one, max_one = min(collection), max(collection)
        start.append(min_one)
        end.append(max_one)
        collection.remove(min_one)
        collection.remove(max_one)
    end.reverse()
    return start + collection + end


if __name__ == "__main__":
    user_input = input("Enter numbers separated by a comma:\n").strip()
    unsorted = [int(item) for item in user_input.split(",")]
    print(*merge_sort(unsorted), sep=",")
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end


function algoP.generate_wiggle_sort_script345
    # Define the output Python file name
    set output_file "wiggle_sort.py"

    # Define the Python code that will be written to the file
    set python_code '
def wiggle_sort(nums: list) -> list:
   
    for i, _ in enumerate(nums):
        if (i % 2 == 1) == (nums[i - 1] > nums[i]):
            nums[i - 1], nums[i] = nums[i], nums[i - 1]

    return nums


if __name__ == "__main__":
    print("Enter the array elements:")
    array = list(map(int, input().split()))
    print("The unsorted array is:")
    print(array)
    print("Array after Wiggle sort:")
    print(wiggle_sort(array))
'

    # Create the Python script with the provided content
    echo "$python_code" > $output_file

    # Notify the user that the file has been created
    set_color green
    echo "$output_file created successfully"
    set_color normal

    # Display the content of the Python file
    cat $output_file
end

function algoP.BisectAndSearchAlgorithms346
    set output_file "BisectAndSearchAlgorithms_Python.py"
    
    set template_content '
from __future__ import annotations

import bisect


def bisect_left(
    sorted_collection: list[int], item: int, lo: int = 0, hi: int = -1
) -> int:
    if hi < 0:
        hi = len(sorted_collection)

    while lo < hi:
        mid = lo + (hi - lo) // 2
        if sorted_collection[mid] < item:
            lo = mid + 1
        else:
            hi = mid

    return lo


def bisect_right(
    sorted_collection: list[int], item: int, lo: int = 0, hi: int = -1
) -> int:
    if hi < 0:
        hi = len(sorted_collection)

    while lo < hi:
        mid = lo + (hi - lo) // 2
        if sorted_collection[mid] <= item:
            lo = mid + 1
        else:
            hi = mid

    return lo


def insort_left(
    sorted_collection: list[int], item: int, lo: int = 0, hi: int = -1
) -> None:
    sorted_collection.insert(bisect_left(sorted_collection, item, lo, hi), item)


def insort_right(
    sorted_collection: list[int], item: int, lo: int = 0, hi: int = -1
) -> None:
    sorted_collection.insert(bisect_right(sorted_collection, item, lo, hi), item)


def binary_search(sorted_collection: list[int], item: int) -> int:
    left = 0
    right = len(sorted_collection) - 1

    while left <= right:
        midpoint = left + (right - left) // 2
        current_item = sorted_collection[midpoint]
        if current_item == item:
            return midpoint
        elif item < current_item:
            right = midpoint - 1
        else:
            left = midpoint + 1
    return -1


def binary_search_std_lib(sorted_collection: list[int], item: int) -> int:
    index = bisect.bisect_left(sorted_collection, item)
    if index != len(sorted_collection) and sorted_collection[index] == item:
        return index
    return -1


def binary_search_with_duplicates(sorted_collection: list[int], item: int) -> list[int]:
    def lower_bound(sorted_collection: list[int], item: int) -> int:
        left = 0
        right = len(sorted_collection)
        while left < right:
            midpoint = left + (right - left) // 2
            current_item = sorted_collection[midpoint]
            if current_item < item:
                left = midpoint + 1
            else:
                right = midpoint
        return left

    def upper_bound(sorted_collection: list[int], item: int) -> int:
        left = 0
        right = len(sorted_collection)
        while left < right:
            midpoint = left + (right - left) // 2
            current_item = sorted_collection[midpoint]
            if current_item <= item:
                left = midpoint + 1
            else:
                right = midpoint
        return left

    left = lower_bound(sorted_collection, item)
    right = upper_bound(sorted_collection, item)

    if left == len(sorted_collection) or sorted_collection[left] != item:
        return []
    return list(range(left, right))


def binary_search_by_recursion(
    sorted_collection: list[int], item: int, left: int = 0, right: int = -1
) -> int:
    if right < 0:
        right = len(sorted_collection) - 1
    if right < left:
        return -1

    midpoint = left + (right - left) // 2

    if sorted_collection[midpoint] == item:
        return midpoint
    elif sorted_collection[midpoint] > item:
        return binary_search_by_recursion(sorted_collection, item, left, midpoint - 1)
    else:
        return binary_search_by_recursion(sorted_collection, item, midpoint + 1, right)


def exponential_search(sorted_collection: list[int], item: int) -> int:
    bound = 1
    while bound < len(sorted_collection) and sorted_collection[bound] < item:
        bound *= 2
    left = bound // 2
    right = min(bound, len(sorted_collection) - 1)
    last_result = binary_search_by_recursion(
        sorted_collection=sorted_collection, item=item, left=left, right=right
    )
    return last_result if last_result is not None else -1


searches = (
    binary_search_std_lib,
    binary_search,
    exponential_search,
    binary_search_by_recursion,
)


if __name__ == "__main__":
    import doctest
    import timeit

    doctest.testmod()
    for search in searches:
        name = f"{search.__name__:>26}"
        print(f"{name}: {search([0, 5, 7, 10, 15], 10) = }")

    print("\nBenchmarks...")
    setup = "collection = range(1000)"
    for search in searches:
        name = search.__name__
        print(
            f"{name:>26}:",
            timeit.timeit(
                f"{name}(collection, 500)", setup=setup, number=5_000, globals=globals()
            ),
        )

    user_input = input("\nEnter numbers separated by comma: ").strip()
    collection = sorted(int(item) for item in user_input.split(","))
    target = int(input("Enter a single number to be found in the list: "))
    result = binary_search(sorted_collection=collection, item=target)
    if result == -1:
        print(f"{target} was not found in {collection}.")
    else:
        print(f"{target} was found at position {result} of {collection}.")
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end





function algoP.TreeTraversal347
    set output_file "TreeTraversal_Python.py"
    
    set template_content '


from __future__ import annotations

import queue


class TreeNode:
    def __init__(self, data):
        self.data = data
        self.right = None
        self.left = None


def build_tree() -> TreeNode:
    print("\n********Press N to stop entering at any point of time********\n")
    check = input("Enter the value of the root node: ").strip().lower()
    q: queue.Queue = queue.Queue()
    tree_node = TreeNode(int(check))
    q.put(tree_node)
    while not q.empty():
        node_found = q.get()
        msg = f"Enter the left node of {node_found.data}: "
        check = input(msg).strip().lower() or "n"
        if check == "n":
            return tree_node
        left_node = TreeNode(int(check))
        node_found.left = left_node
        q.put(left_node)
        msg = f"Enter the right node of {node_found.data}: "
        check = input(msg).strip().lower() or "n"
        if check == "n":
            return tree_node
        right_node = TreeNode(int(check))
        node_found.right = right_node
        q.put(right_node)
    raise ValueError("Something went wrong")


def pre_order(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    print(node.data, end=",")
    pre_order(node.left)
    pre_order(node.right)


def in_order(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    in_order(node.left)
    print(node.data, end=",")
    in_order(node.right)


def post_order(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    post_order(node.left)
    post_order(node.right)
    print(node.data, end=",")


def level_order(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    q: queue.Queue = queue.Queue()
    q.put(node)
    while not q.empty():
        node_dequeued = q.get()
        print(node_dequeued.data, end=",")
        if node_dequeued.left:
            q.put(node_dequeued.left)
        if node_dequeued.right:
            q.put(node_dequeued.right)


def level_order_actual(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    q: queue.Queue = queue.Queue()
    q.put(node)
    while not q.empty():
        list_ = []
        while not q.empty():
            node_dequeued = q.get()
            print(node_dequeued.data, end=",")
            if node_dequeued.left:
                list_.append(node_dequeued.left)
            if node_dequeued.right:
                list_.append(node_dequeued.right)
        print()
        for inner_node in list_:
            q.put(inner_node)


def pre_order_iter(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    stack: list[TreeNode] = []
    n = node
    while n or stack:
        while n:  # start from root node, find its left child
            print(n.data, end=",")
            stack.append(n)
            n = n.left
        n = stack.pop()
        n = n.right


def in_order_iter(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    stack: list[TreeNode] = []
    n = node
    while n or stack:
        while n:
            stack.append(n)
            n = n.left
        n = stack.pop()
        print(n.data, end=",")
        n = n.right


def post_order_iter(node: TreeNode) -> None:
    if not isinstance(node, TreeNode) or not node:
        return
    stack1, stack2 = [], []
    n = node
    stack1.append(n)
    while stack1:
        n = stack1.pop()
        if n.left:
            stack1.append(n.left)
        if n.right:
            stack1.append(n.right)
        stack2.append(n)
    while stack2:
        print(stack2.pop().data, end=",")


def prompt(s: str = "", width=50, char="*") -> str:
    if not s:
        return "\n" + width * char
    left, extra = divmod(width - len(s) - 2, 2)
    return f"{left * char} {s} {(left + extra) * char}"


if __name__ == "__main__":
    import doctest

    doctest.testmod()
    print(prompt("Binary Tree Traversals"))

    node: TreeNode = build_tree()
    print(prompt("Pre Order Traversal"))
    pre_order(node)
    print(prompt() + "\n")

    print(prompt("In Order Traversal"))
    in_order(node)
    print(prompt() + "\n")

    print(prompt("Post Order Traversal"))
    post_order(node)
    print(prompt() + "\n")

    print(prompt("Level Order Traversal"))
    level_order(node)
    print(prompt() + "\n")

    print(prompt("Actual Level Order Traversal"))
    level_order_actual(node)
    print("*" * 50 + "\n")

    print(prompt("Pre Order Traversal - Iteration Version"))
    pre_order_iter(node)
    print(prompt() + "\n")

    print(prompt("In Order Traversal - Iteration Version"))
    in_order_iter(node)
    print(prompt() + "\n")

    print(prompt("Post Order Traversal - Iteration Version"))
    post_order_iter(node)
    print(prompt())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.DoubleLinearSearch348
    set output_file "DoubleLinearSearch.py"
    
    set template_content '
from __future__ import annotations


def double_linear_search(array: list[int], search_item: int) -> int:
   
    # define the start and end index of the given array
    start_ind, end_ind = 0, len(array) - 1
    while start_ind <= end_ind:
        if array[start_ind] == search_item:
            return start_ind
        elif array[end_ind] == search_item:
            return end_ind
        else:
            start_ind += 1
            end_ind -= 1
    # returns -1 if search_item is not found in array
    return -1


if __name__ == "__main__":
    print(double_linear_search(list(range(100)), 40))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Search349
    set output_file "search_function.py"
    
    set template_content '
def search(list_data: list, key: int, left: int = 0, right: int = 0) -> int:
    
    right = right or len(list_data) - 1
    if left > right:
        return -1
    elif list_data[left] == key:
        return left
    elif list_data[right] == key:
        return right
    else:
        return search(list_data, key, left + 1, right - 1)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function generate_exponential_search350
    set output_file "exponential_search.py"
    
    set template_content '

from __future__ import annotations


def binary_search_by_recursion(
    sorted_collection: list[int], item: int, left: int = 0, right: int = -1
) -> int:
    
    if right < 0:
        right = len(sorted_collection) - 1
    if list(sorted_collection) != sorted(sorted_collection):
        raise ValueError("sorted_collection must be sorted in ascending order")
    if right < left:
        return -1

    midpoint = left + (right - left) // 2

    if sorted_collection[midpoint] == item:
        return midpoint
    elif sorted_collection[midpoint] > item:
        return binary_search_by_recursion(sorted_collection, item, left, midpoint - 1)
    else:
        return binary_search_by_recursion(sorted_collection, item, midpoint + 1, right)


def exponential_search(sorted_collection: list[int], item: int) -> int:
   
    if list(sorted_collection) != sorted(sorted_collection):
        raise ValueError("sorted_collection must be sorted in ascending order")

    if sorted_collection[0] == item:
        return 0

    bound = 1
    while bound < len(sorted_collection) and sorted_collection[bound] < item:
        bound *= 2

    left = bound // 2
    right = min(bound, len(sorted_collection) - 1)
    return binary_search_by_recursion(sorted_collection, item, left, right)


if __name__ == "__main__":
    import doctest

    doctest.testmod()

    # Manual testing
    user_input = input("Enter numbers separated by commas: ").strip()
    collection = sorted(int(item) for item in user_input.split(","))
    target = int(input("Enter a number to search for: "))
    result = exponential_search(sorted_collection=collection, item=target)
    if result == -1:
        print(f"{target} was not found in {collection}.")
    else:
        print(f"{target} was found at index {result} in {collection}.")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function generate_hill_climbing351
    set output_file "hill_climbing.py"

    set template_content '
import math


class SearchProblem:
   

    def __init__(self, x: int, y: int, step_size: int, function_to_optimize):
       
        self.x = x
        self.y = y
        self.step_size = step_size
        self.function = function_to_optimize

    def score(self) -> int:
       
        return self.function(self.x, self.y)

    def get_neighbors(self):
        step_size = self.step_size
        return [
            SearchProblem(x, y, step_size, self.function)
            for x, y in (
                (self.x - step_size, self.y - step_size),
                (self.x - step_size, self.y),
                (self.x - step_size, self.y + step_size),
                (self.x, self.y - step_size),
                (self.x, self.y + step_size),
                (self.x + step_size, self.y - step_size),
                (self.x + step_size, self.y),
                (self.x + step_size, self.y + step_size),
            )
        ]

    def __hash__(self):
        return hash(str(self))

    def __eq__(self, obj):
        if isinstance(obj, SearchProblem):
            return hash(str(self)) == hash(str(obj))
        return False

    def __str__(self):
        return f"x: {self.x} y: {self.y}"


def hill_climbing(
    search_prob,
    find_max: bool = True,
    max_x: float = math.inf,
    min_x: float = -math.inf,
    max_y: float = math.inf,
    min_y: float = -math.inf,
    visualization: bool = False,
    max_iter: int = 10000,
) -> SearchProblem:
    
    current_state = search_prob
    scores = []  # list to store the current score at each iteration
    iterations = 0
    solution_found = False
    visited = set()
    while not solution_found and iterations < max_iter:
        visited.add(current_state)
        iterations += 1
        current_score = current_state.score()
        scores.append(current_score)
        neighbors = current_state.get_neighbors()
        max_change = -math.inf
        min_change = math.inf
        next_state = None  # to hold the next best neighbor
        for neighbor in neighbors:
            if neighbor in visited:
                continue  # do not want to visit the same state again
            if (
                neighbor.x > max_x
                or neighbor.x < min_x
                or neighbor.y > max_y
                or neighbor.y < min_y
            ):
                continue  # neighbor outside our bounds
            change = neighbor.score() - current_score
            if find_max:  # finding max
                # going to direction with greatest ascent
                if change > max_change and change > 0:
                    max_change = change
                    next_state = neighbor
            elif change < min_change and change < 0:  # finding min
                # to direction with greatest descent
                min_change = change
                next_state = neighbor
        if next_state is not None:
            # we found at least one neighbor which improved the current state
            current_state = next_state
        else:
            # since we have no neighbor that improves the solution we stop the search
            solution_found = True

    if visualization:
        from matplotlib import pyplot as plt

        plt.plot(range(iterations), scores)
        plt.xlabel("Iterations")
        plt.ylabel("Function values")
        plt.show()

    return current_state


if __name__ == "__main__":
    import doctest

    doctest.testmod()

    def test_f1(x, y):
        return (x**2) + (y**2)

    # starting the problem with initial coordinates (3, 4)
    prob = SearchProblem(x=3, y=4, step_size=1, function_to_optimize=test_f1)
    local_min = hill_climbing(prob, find_max=False)
    print(
        "The minimum score for f(x, y) = x^2 + y^2 found via hill climbing: "
        f"{local_min.score()}"
    )

    # starting the problem with initial coordinates (12, 47)
    prob = SearchProblem(x=12, y=47, step_size=1, function_to_optimize=test_f1)
    local_min = hill_climbing(
        prob, find_max=False, max_x=100, min_x=5, max_y=50, min_y=-5, visualization=True
    )
    print(
        "The minimum score for f(x, y) = x^2 + y^2 with the domain 100 > x > 5 "
        f"and 50 > y > - 5 found via hill climbing: {local_min.score()}"
    )

    def test_f2(x, y):
        return (3 * x**2) - (6 * y)

    prob = SearchProblem(x=3, y=4, step_size=1, function_to_optimize=test_f1)
    local_min = hill_climbing(prob, find_max=True)
    print(
        "The maximum score for f(x, y) = x^2 + y^2 found via hill climbing: "
        f"{local_min.score()}"
    )
'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function generate_interpolation_search352
    set output_file "interpolation_search.py"

    set template_content '
def interpolation_search(sorted_collection: list[int], item: int) -> int | None:
    left = 0
    right = len(sorted_collection) - 1

    while left <= right:
        # avoid divided by 0 during interpolation
        if sorted_collection[left] == sorted_collection[right]:
            if sorted_collection[left] == item:
                return left
            return None

        point = left + ((item - sorted_collection[left]) * (right - left)) // (
            sorted_collection[right] - sorted_collection[left]
        )

        # out of range check
        if point < 0 or point >= len(sorted_collection):
            return None

        current_item = sorted_collection[point]
        if current_item == item:
            return point
        if point < left:
            right = left
            left = point
        elif point > right:
            left = right
            right = point
        elif item < current_item:
            right = point - 1
        else:
            left = point + 1
    return None


def interpolation_search_by_recursion(
    sorted_collection: list[int], item: int, left: int = 0, right: int | None = None
) -> int | None:
    
    if right is None:
        right = len(sorted_collection) - 1
    # avoid divided by 0 during interpolation
    if sorted_collection[left] == sorted_collection[right]:
        if sorted_collection[left] == item:
            return left
        return None

    point = left + ((item - sorted_collection[left]) * (right - left)) // (
        sorted_collection[right] - sorted_collection[left]
    )

    # out of range check
    if point < 0 or point >= len(sorted_collection):
        return None

    if sorted_collection[point] == item:
        return point
    if point < left:
        return interpolation_search_by_recursion(sorted_collection, item, point, left)
    if point > right:
        return interpolation_search_by_recursion(sorted_collection, item, right, left)
    if sorted_collection[point] > item:
        return interpolation_search_by_recursion(
            sorted_collection, item, left, point - 1
        )
    return interpolation_search_by_recursion(sorted_collection, item, point + 1, right)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function generate_jump_search353
    set output_file "jump_search.py"

    set template_content '
import math
from collections.abc import Sequence
from typing import Any, Protocol, TypeVar


class Comparable(Protocol):
    def __lt__(self, other: Any, /) -> bool: ...


T = TypeVar("T", bound=Comparable)


def jump_search(arr: Sequence[T], item: T) -> int:

    arr_size = len(arr)
    block_size = int(math.sqrt(arr_size))

    prev = 0
    step = block_size
    while arr[min(step, arr_size) - 1] < item:
        prev = step
        step += block_size
        if prev >= arr_size:
            return -1

    while arr[prev] < item:
        prev += 1
        if prev == min(step, arr_size):
            return -1
    if arr[prev] == item:
        return prev
    return -1


if __name__ == "__main__":
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function generate_linear_search354
    set output_file "linear_search.py"

    set template_content '
def linear_search(sequence: list, target: int) -> int:
    for index, item in enumerate(sequence):
        if item == target:
            return index
    return -1


def rec_linear_search(sequence: list, low: int, high: int, target: int) -> int:
    if not (0 <= high < len(sequence) and 0 <= low < len(sequence)):
        raise Exception("Invalid upper or lower bound!")
    if high < low:
        return -1
    if sequence[low] == target:
        return low
    if sequence[high] == target:
        return high
    return rec_linear_search(sequence, low + 1, high - 1, target)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function generate_median355
    set output_file "median_select.py"

    set template_content '
def median_of_five(arr: list) -> int:
   
    arr = sorted(arr)
    return arr[len(arr) // 2]


def median_of_medians(arr: list) -> int:

    if len(arr) <= 5:
        return median_of_five(arr)
    medians = []
    i = 0
    while i < len(arr):
        if (i + 4) <= len(arr):
            medians.append(median_of_five(arr[i:].copy()))
        else:
            medians.append(median_of_five(arr[i : i + 5].copy()))
        i += 5
    return median_of_medians(medians)


def quick_select(arr: list, target: int) -> int:
    # Invalid Input
    if target > len(arr):
        return -1

    # x is the estimated pivot by median of medians algorithm
    x = median_of_medians(arr)
    left = []
    right = []
    check = False
    for i in range(len(arr)):
        if arr[i] < x:
            left.append(arr[i])
        elif arr[i] > x:
            right.append(arr[i])
        elif arr[i] == x and not check:
            check = True
        else:
            right.append(arr[i])
    rank_x = len(left) + 1
    if rank_x == target:
        answer = x
    elif rank_x > target:
        answer = quick_select(left, target)
    elif rank_x < target:
        answer = quick_select(right, target - rank_x)
    return answer


if __name__ == "__main__":
    print(median_of_five([5, 4, 3, 2]))
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function generate_quick_select356
    set output_file "quick_select.py"

    set template_content '
import random


def _partition(data: list, pivot) -> tuple:
   
    less, equal, greater = [], [], []
    for element in data:
        if element < pivot:
            less.append(element)
        elif element > pivot:
            greater.append(element)
        else:
            equal.append(element)
    return less, equal, greater


def quick_select(items: list, index: int):
    # index = len(items) // 2 when trying to find the median
    #   (value of index when items is sorted)

    # invalid input
    if index >= len(items) or index < 0:
        return None

    pivot = items[random.randint(0, len(items) - 1)]
    count = 0
    smaller, equal, larger = _partition(items, pivot)
    count = len(equal)
    m = len(smaller)

    # index is the pivot
    if m <= index < m + count:
        return pivot
    # must be in smaller
    elif m > index:
        return quick_select(smaller, index)
    # must be in larger
    else:
        return quick_select(larger, index - (m + count))


def median(items: list):
   
    mid, rem = divmod(len(items), 2)
    if rem != 0:
        return quick_select(items=items, index=mid)
    else:
        low_mid = quick_select(items=items, index=mid - 1)
        high_mid = quick_select(items=items, index=mid)
        return (low_mid + high_mid) / 2
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function generate_sentinel_linear_search357
    set output_file "sentinel_linear_search.py"

    set template_content '
def sentinel_linear_search(sequence, target):
   
    sequence.append(target)

    index = 0
    while sequence[index] != target:
        index += 1

    sequence.pop()

    if index == len(sequence):
        return None

    return index


if __name__ == "__main__":

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function generate_simulated_annealing358
    set output_file "simulated_annealing.py"

    set template_content '
import math
import random
from typing import Any

from .hill_climbing import SearchProblem


def simulated_annealing(
    search_prob,
    find_max: bool = True,
    max_x: float = math.inf,
    min_x: float = -math.inf,
    max_y: float = math.inf,
    min_y: float = -math.inf,
    visualization: bool = False,
    start_temperate: float = 100,
    rate_of_decrease: float = 0.01,
    threshold_temp: float = 1,
) -> Any:

    search_end = False
    current_state = search_prob
    current_temp = start_temperate
    scores = []
    iterations = 0
    best_state = None

    while not search_end:
        current_score = current_state.score()
        if best_state is None or current_score > best_state.score():
            best_state = current_state
        scores.append(current_score)
        iterations += 1
        next_state = None
        neighbors = current_state.get_neighbors()
        while (
            next_state is None and neighbors
        ):  # till we do not find a neighbor that we can move to
            index = random.randint(0, len(neighbors) - 1)  # picking a random neighbor
            picked_neighbor = neighbors.pop(index)
            change = picked_neighbor.score() - current_score

            if (
                picked_neighbor.x > max_x
                or picked_neighbor.x < min_x
                or picked_neighbor.y > max_y
                or picked_neighbor.y < min_y
            ):
                continue  # neighbor outside our bounds

            if not find_max:
                change = change * -1  # in case we are finding minimum
            if change > 0:  # improves the solution
                next_state = picked_neighbor
            else:
                probability = (math.e) ** (
                    change / current_temp
                )  # probability generation function
                if random.random() < probability:  # random number within probability
                    next_state = picked_neighbor
        current_temp = current_temp - (current_temp * rate_of_decrease)

        if current_temp < threshold_temp or next_state is None:
            # temperature below threshold, or could not find a suitable neighbor
            search_end = True
        else:
            current_state = next_state

    if visualization:
        from matplotlib import pyplot as plt

        plt.plot(range(iterations), scores)
        plt.xlabel("Iterations")
        plt.ylabel("Function values")
        plt.show()
    return best_state


if __name__ == "__main__":

    def test_f1(x, y):
        return (x**2) + (y**2)

    # starting the problem with initial coordinates (12, 47)
    prob = SearchProblem(x=12, y=47, step_size=1, function_to_optimize=test_f1)
    local_min = simulated_annealing(
        prob, find_max=False, max_x=100, min_x=5, max_y=50, min_y=-5, visualization=True
    )
    print(
        "The minimum score for f(x, y) = x^2 + y^2 with the domain 100 > x > 5 "
        f"and 50 > y > - 5 found via hill climbing: {local_min.score()}"
    )

    # starting the problem with initial coordinates (12, 47)
    prob = SearchProblem(x=12, y=47, step_size=1, function_to_optimize=test_f1)
    local_min = simulated_annealing(
        prob, find_max=True, max_x=100, min_x=5, max_y=50, min_y=-5, visualization=True
    )
    print(
        "The maximum score for f(x, y) = x^2 + y^2 with the domain 100 > x > 5 "
        f"and 50 > y > - 5 found via hill climbing: {local_min.score()}"
    )

    def test_f2(x, y):
        return (3 * x**2) - (6 * y)

    prob = SearchProblem(x=3, y=4, step_size=1, function_to_optimize=test_f1)
    local_min = simulated_annealing(prob, find_max=False, visualization=True)
    print(
        "The minimum score for f(x, y) = 3*x^2 - 6*y found via hill climbing: "
        f"{local_min.score()}"
    )

    prob = SearchProblem(x=3, y=4, step_size=1, function_to_optimize=test_f1)
    local_min = simulated_annealing(prob, find_max=True, visualization=True)
    print(
        "The maximum score for f(x, y) = 3*x^2 - 6*y found via hill climbing: "
        f"{local_min.score()}"
    )
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TaskScheduling359
    # Define the output file where the Python code will be saved
    set output_file "task_scheduling.py"

    # Define the Python code template
    set template_content '
from dataclasses import dataclass
from operator import attrgetter

@dataclass
class Task:
    task_id: int
    deadline: int
    reward: int

def max_tasks(tasks_info: list[tuple[int, int]]) -> list[int]:
    tasks = sorted(
        (
            Task(task_id, deadline, reward)
            for task_id, (deadline, reward) in enumerate(tasks_info)
        ),
        key=attrgetter("reward"),
        reverse=True,
    )
    return [task.task_id for i, task in enumerate(tasks, start=1) if task.deadline >= i]

if __name__ == "__main__":
    import doctest
    doctest.testmod()

    print(f"{max_tasks([(4, 20), (1, 10), (1, 40), (1, 30)]) = }")
    print(f"{max_tasks([(1, 10), (2, 20), (3, 30), (2, 40)]) = }")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function algoP.ProcessScheduling360
    # Define the output file where the Python code will be saved
    set output_file "process_scheduling.py"

    # Define the Python code template
    set template_content '
from statistics import mean
import numpy as np

def calculate_turn_around_time(
    process_name: list, arrival_time: list, burst_time: list, no_of_process: int
) -> list:

    current_time = 0
    finished_process_count = 0
    finished_process = [0] * no_of_process
    turn_around_time = [0] * no_of_process

    burst_time = [burst_time[i] for i in np.argsort(arrival_time)]
    process_name = [process_name[i] for i in np.argsort(arrival_time)]
    arrival_time.sort()

    while no_of_process > finished_process_count:
        i = 0
        while finished_process[i] == 1:
            i += 1
        current_time = max(current_time, arrival_time[i])

        response_ratio = 0
        loc = 0
        temp = 0
        for i in range(no_of_process):
            if finished_process[i] == 0 and arrival_time[i] <= current_time:
                temp = (burst_time[i] + (current_time - arrival_time[i])) / burst_time[
                    i
                ]
            if response_ratio < temp:
                response_ratio = temp
                loc = i

        turn_around_time[loc] = current_time + burst_time[loc] - arrival_time[loc]
        current_time += burst_time[loc]
        finished_process[loc] = 1
        finished_process_count += 1

    return turn_around_time

def calculate_waiting_time(
    process_name: list,
    turn_around_time: list,
    burst_time: list,
    no_of_process: int,
) -> list:

    waiting_time = [0] * no_of_process
    for i in range(no_of_process):
        waiting_time[i] = turn_around_time[i] - burst_time[i]
    return waiting_time

if __name__ == "__main__":
    no_of_process = 5
    process_name = ["A", "B", "C", "D", "E"]
    arrival_time = [1, 2, 3, 4, 5]
    burst_time = [1, 2, 3, 4, 5]

    turn_around_time = calculate_turn_around_time(
        process_name, arrival_time, burst_time, no_of_process
    )
    waiting_time = calculate_waiting_time(
        process_name, turn_around_time, burst_time, no_of_process
    )

    print("Process name \tArrival time \tBurst time \tTurn around time \tWaiting time")
    for i in range(no_of_process):
        print(
            f"{process_name[i]}\t\t{arrival_time[i]}\t\t{burst_time[i]}\t\t"
            f"{turn_around_time[i]}\t\t\t{waiting_time[i]}"
        )

    print(f"average waiting time : {mean(waiting_time):.5f}")
    print(f"average turn around time : {mean(turn_around_time):.5f}")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function algoP.JobSequencingWithDeadlines361
    # Define the output file where the Python code will be saved
    set output_file "job_sequencing_with_deadlines.py"

    # Define the Python code template
    set template_content '
def job_sequencing_with_deadlines(jobs: list) -> list:

    # Sort the jobs in descending order of profit
    jobs = sorted(jobs, key=lambda value: value[2], reverse=True)

    # Create a list of size equal to the maximum deadline
    # and initialize it with -1
    max_deadline = max(jobs, key=lambda value: value[1])[1]
    time_slots = [-1] * max_deadline

    # Finding the maximum profit and the count of jobs
    count = 0
    max_profit = 0
    for job in jobs:
        # Find a free time slot for this job
        # (Note that we start from the last possible slot)
        for i in range(job[1] - 1, -1, -1):
            if time_slots[i] == -1:
                time_slots[i] = job[0]
                count += 1
                max_profit += job[2]
                break
    return [count, max_profit]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function generate_mlfq_python362
    # Define the output file where the Python code will be saved
    set output_file "mlfq_scheduling.py"

    # Define the Python code template
    set template_content '
from collections import deque

class Process:
    def __init__(self, process_name: str, arrival_time: int, burst_time: int) -> None:
        self.process_name = process_name  # process name
        self.arrival_time = arrival_time  # arrival time of the process
        self.stop_time = arrival_time
        self.burst_time = burst_time  # remaining burst time
        self.waiting_time = 0  # total time of the process wait in ready queue
        self.turnaround_time = 0  # time from arrival time to completion time


class MLFQ:
    def __init__(
        self,
        number_of_queues: int,
        time_slices: list[int],
        queue: deque[Process],
        current_time: int,
    ) -> None:
        self.number_of_queues = number_of_queues
        self.time_slices = time_slices
        self.ready_queue = queue
        self.current_time = current_time
        self.finish_queue: deque[Process] = deque()

    def calculate_sequence_of_finish_queue(self) -> list[str]:
        sequence = []
        for i in range(len(self.finish_queue)):
            sequence.append(self.finish_queue[i].process_name)
        return sequence

    def calculate_waiting_time(self, queue: list[Process]) -> list[int]:
        waiting_times = []
        for i in range(len(queue)):
            waiting_times.append(queue[i].waiting_time)
        return waiting_times

    def calculate_turnaround_time(self, queue: list[Process]) -> list[int]:
        turnaround_times = []
        for i in range(len(queue)):
            turnaround_times.append(queue[i].turnaround_time)
        return turnaround_times

    def calculate_completion_time(self, queue: list[Process]) -> list[int]:
        completion_times = []
        for i in range(len(queue)):
            completion_times.append(queue[i].stop_time)
        return completion_times

    def calculate_remaining_burst_time_of_processes(self, queue: deque[Process]) -> list[int]:
        return [q.burst_time for q in queue]

    def update_waiting_time(self, process: Process) -> int:
        process.waiting_time += self.current_time - process.stop_time
        return process.waiting_time

    def first_come_first_served(self, ready_queue: deque[Process]) -> deque[Process]:
        finished: deque[Process] = deque()
        while len(ready_queue) != 0:
            cp = ready_queue.popleft()
            if self.current_time < cp.arrival_time:
                self.current_time += cp.arrival_time
            self.update_waiting_time(cp)
            self.current_time += cp.burst_time
            cp.burst_time = 0
            cp.turnaround_time = self.current_time - cp.arrival_time
            cp.stop_time = self.current_time
            finished.append(cp)
        self.finish_queue.extend(finished)
        return finished

    def round_robin(self, ready_queue: deque[Process], time_slice: int) -> tuple[deque[Process], deque[Process]]:
        finished: deque[Process] = deque()
        for _ in range(len(ready_queue)):
            cp = ready_queue.popleft()
            if self.current_time < cp.arrival_time:
                self.current_time += cp.arrival_time
            self.update_waiting_time(cp)
            if cp.burst_time > time_slice:
                self.current_time += time_slice
                cp.burst_time -= time_slice
                cp.stop_time = self.current_time
                ready_queue.append(cp)
            else:
                self.current_time += cp.burst_time
                cp.burst_time = 0
                cp.stop_time = self.current_time
                cp.turnaround_time = self.current_time - cp.arrival_time
                finished.append(cp)
        self.finish_queue.extend(finished)
        return finished, ready_queue

    def multi_level_feedback_queue(self) -> deque[Process]:
        for i in range(self.number_of_queues - 1):
            _finished, self.ready_queue = self.round_robin(self.ready_queue, self.time_slices[i])
        self.first_come_first_served(self.ready_queue)
        return self.finish_queue


if __name__ == "__main__":
    import doctest

    P1 = Process("P1", 0, 53)
    P2 = Process("P2", 0, 17)
    P3 = Process("P3", 0, 68)
    P4 = Process("P4", 0, 24)
    number_of_queues = 3
    time_slices = [17, 25]
    queue = deque([P1, P2, P3, P4])

    if len(time_slices) != number_of_queues - 1:
        raise SystemExit(0)

    doctest.testmod(extraglobs={"queue": deque([P1, P2, P3, P4])})

    mlfq = MLFQ(number_of_queues, time_slices, queue, 0)
    finish_queue = mlfq.multi_level_feedback_queue()

    print(f"waiting time: {MLFQ.calculate_waiting_time(mlfq, [P1, P2, P3, P4])}")
    print(f"completion time: {MLFQ.calculate_completion_time(mlfq, [P1, P2, P3, P4])}")
    print(f"turnaround time: {MLFQ.calculate_turnaround_time(mlfq, [P1, P2, P3, P4])}")
    print(f"sequence of finished processes: {mlfq.calculate_sequence_of_finish_queue()}")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end



function generate_process_times_python363
    # Define the output file where the Python code will be saved
    set output_file "process_times.py"

    # Define the Python code template
    set template_content '
from __future__ import annotations
from statistics import mean

def calculate_waitingtime(
    arrival_time: list[int], burst_time: list[int], no_of_processes: int
) -> list[int]:
    waiting_time = [0] * no_of_processes
    remaining_time = [0] * no_of_processes

    # Initialize remaining_time to waiting_time.
    for i in range(no_of_processes):
        remaining_time[i] = burst_time[i]
    ready_process: list[int] = []

    completed = 0
    total_time = 0

    # When processes are not completed,
    # A process whose arrival time has passed \
    # and has remaining execution time is put into the ready_process.
    # The shortest process in the ready_process, target_process is executed.
    while completed != no_of_processes:
        ready_process = []
        target_process = -1

        for i in range(no_of_processes):
            if (arrival_time[i] <= total_time) and (remaining_time[i] > 0):
                ready_process.append(i)

        if len(ready_process) > 0:
            target_process = ready_process[0]
            for i in ready_process:
                if remaining_time[i] < remaining_time[target_process]:
                    target_process = i
            total_time += burst_time[target_process]
            completed += 1
            remaining_time[target_process] = 0
            waiting_time[target_process] = (
                total_time - arrival_time[target_process] - burst_time[target_process]
            )
        else:
            total_time += 1

    return waiting_time


def calculate_turnaroundtime(
    burst_time: list[int], no_of_processes: int, waiting_time: list[int]
) -> list[int]:
   

    turn_around_time = [0] * no_of_processes
    for i in range(no_of_processes):
        turn_around_time[i] = burst_time[i] + waiting_time[i]
    return turn_around_time


if __name__ == "__main__":
    print("[TEST CASE 01]")

    no_of_processes = 4
    burst_time = [2, 5, 3, 7]
    arrival_time = [0, 0, 0, 0]
    waiting_time = calculate_waitingtime(arrival_time, burst_time, no_of_processes)
    turn_around_time = calculate_turnaroundtime(
        burst_time, no_of_processes, waiting_time
    )

    # Printing the Result
    print("PID\tBurst Time\tArrival Time\tWaiting Time\tTurnaround Time")
    for i, process_id in enumerate(list(range(1, 5))):
        print(
            f"{process_id}\t{burst_time[i]}\t\t\t{arrival_time[i]}\t\t\t\t"
            f"{waiting_time[i]}\t\t\t\t{turn_around_time[i]}"
        )
    print(f"\nAverage waiting time = {mean(waiting_time):.5f}")
    print(f"Average turnaround time = {mean(turn_around_time):.5f}")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function generate_process_times_round_robin364
    # Define the output file where the Python code will be saved
    set output_file "round_robin_process_times.py"

    # Define the Python code template
    set template_content '
from __future__ import annotations
from statistics import mean

def calculate_waiting_times(burst_times: list[int]) -> list[int]:
   
    quantum = 2
    rem_burst_times = list(burst_times)
    waiting_times = [0] * len(burst_times)
    t = 0
    while True:
        done = True
        for i, burst_time in enumerate(burst_times):
            if rem_burst_times[i] > 0:
                done = False
                if rem_burst_times[i] > quantum:
                    t += quantum
                    rem_burst_times[i] -= quantum
                else:
                    t += rem_burst_times[i]
                    waiting_times[i] = t - burst_time
                    rem_burst_times[i] = 0
        if done is True:
            return waiting_times


def calculate_turn_around_times(
    burst_times: list[int], waiting_times: list[int]
) -> list[int]:
    return [burst + waiting for burst, waiting in zip(burst_times, waiting_times)]


if __name__ == "__main__":
    burst_times = [3, 5, 7]
    waiting_times = calculate_waiting_times(burst_times)
    turn_around_times = calculate_turn_around_times(burst_times, waiting_times)
    print("Process ID \tBurst Time \tWaiting Time \tTurnaround Time")
    for i, burst_time in enumerate(burst_times):
        print(
            f"  {i + 1}\t\t  {burst_time}\t\t  {waiting_times[i]}\t\t  "
            f"{turn_around_times[i]}"
        )
    print(f"\nAverage waiting time = {mean(waiting_times):.5f}")
    print(f"Average turn around time = {mean(turn_around_times):.5f}")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function generate_fcfs_process_analysis365
    # Define the output file where the Python code will be saved
    set output_file "fcfs_process_analysis.py"

    # Define the Python code template
    set template_content '
from __future__ import annotations
import pandas as pd

def calculate_waitingtime(
    arrival_time: list[int], burst_time: list[int], no_of_processes: int
) -> list[int]:
    remaining_time = [0] * no_of_processes
    waiting_time = [0] * no_of_processes
    # Copy the burst time into remaining_time[]
    for i in range(no_of_processes):
        remaining_time[i] = burst_time[i]

    complete = 0
    increment_time = 0
    minm = 999999999
    short = 0
    check = False

    # Process until all processes are completed
    while complete != no_of_processes:
        for j in range(no_of_processes):
            if (
                arrival_time[j] <= increment_time
                and remaining_time[j] > 0
                and remaining_time[j] < minm
            ):
                minm = remaining_time[j]
                short = j
                check = True

        if not check:
            increment_time += 1
            continue
        remaining_time[short] -= 1

        minm = remaining_time[short]
        if minm == 0:
            minm = 999999999

        if remaining_time[short] == 0:
            complete += 1
            check = False

            # Find finish time of current process
            finish_time = increment_time + 1

            # Calculate waiting time
            finar = finish_time - arrival_time[short]
            waiting_time[short] = finar - burst_time[short]

            waiting_time[short] = max(waiting_time[short], 0)

        # Increment time
        increment_time += 1
    return waiting_time


def calculate_turnaroundtime(
    burst_time: list[int], no_of_processes: int, waiting_time: list[int]
) -> list[int]:
    turn_around_time = [0] * no_of_processes
    for i in range(no_of_processes):
        turn_around_time[i] = burst_time[i] + waiting_time[i]
    return turn_around_time


def calculate_average_times(
    waiting_time: list[int], turn_around_time: list[int], no_of_processes: int
) -> None:
    total_waiting_time = 0
    total_turn_around_time = 0
    for i in range(no_of_processes):
        total_waiting_time = total_waiting_time + waiting_time[i]
        total_turn_around_time = total_turn_around_time + turn_around_time[i]
    print(f"Average waiting time = {total_waiting_time / no_of_processes:.5f}")
    print("Average turn around time =", total_turn_around_time / no_of_processes)


if __name__ == "__main__":
    print("Enter how many process you want to analyze")
    no_of_processes = int(input())
    burst_time = [0] * no_of_processes
    arrival_time = [0] * no_of_processes
    processes = list(range(1, no_of_processes + 1))

    for i in range(no_of_processes):
        print("Enter the arrival time and burst time for process:--" + str(i + 1))
        arrival_time[i], burst_time[i] = map(int, input().split())

    waiting_time = calculate_waitingtime(arrival_time, burst_time, no_of_processes)

    bt = burst_time
    n = no_of_processes
    wt = waiting_time
    turn_around_time = calculate_turnaroundtime(bt, n, wt)

    calculate_average_times(waiting_time, turn_around_time, no_of_processes)

    fcfs = pd.DataFrame(
        list(zip(processes, burst_time, arrival_time, waiting_time, turn_around_time)),
        columns=[
            "Process",
            "BurstTime",
            "ArrivalTime",
            "WaitingTime",
            "TurnAroundTime",
        ],
    )

    # Printing the dataFrame
    pd.set_option("display.max_rows", fcfs.shape[0] + 1)
    print(fcfs)
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end


function generate_sjn_scheduler366
    set output_file "sjn_scheduler.py"

    set template_content '
from statistics import mean

import numpy as np


def calculate_turn_around_time(
    process_name: list, arrival_time: list, burst_time: list, no_of_process: int
) -> list:

    current_time = 0
    # Number of processes finished
    finished_process_count = 0
    # Displays the finished process.
    # If it is 0, the performance is completed if it is 1, before the performance.
    finished_process = [0] * no_of_process
    # List to include calculation results
    turn_around_time = [0] * no_of_process

    # Sort by arrival time.
    burst_time = [burst_time[i] for i in np.argsort(arrival_time)]
    process_name = [process_name[i] for i in np.argsort(arrival_time)]
    arrival_time.sort()

    while no_of_process > finished_process_count:
        """
        If the current time is less than the arrival time of
        the process that arrives first among the processes that have not been performed,
        change the current time.
        """
        i = 0
        while finished_process[i] == 1:
            i += 1
        current_time = max(current_time, arrival_time[i])

        response_ratio = 0
        # Index showing the location of the process being performed
        loc = 0
        # Saves the current response ratio.
        temp = 0
        for i in range(no_of_process):
            if finished_process[i] == 0 and arrival_time[i] <= current_time:
                temp = (burst_time[i] + (current_time - arrival_time[i])) / burst_time[
                    i
                ]
            if response_ratio < temp:
                response_ratio = temp
                loc = i

        # Calculate the turn around time
        turn_around_time[loc] = current_time + burst_time[loc] - arrival_time[loc]
        current_time += burst_time[loc]
        # Indicates that the process has been performed.
        finished_process[loc] = 1
        # Increase finished_process_count by 1
        finished_process_count += 1

    return turn_around_time


def calculate_waiting_time(
    process_name: list,  # noqa: ARG001
    turn_around_time: list,
    burst_time: list,
    no_of_process: int,
) -> list:
   

    waiting_time = [0] * no_of_process
    for i in range(no_of_process):
        waiting_time[i] = turn_around_time[i] - burst_time[i]
    return waiting_time


if __name__ == "__main__":
    no_of_process = 5
    process_name = ["A", "B", "C", "D", "E"]
    arrival_time = [1, 2, 3, 4, 5]
    burst_time = [1, 2, 3, 4, 5]

    turn_around_time = calculate_turn_around_time(
        process_name, arrival_time, burst_time, no_of_process
    )
    waiting_time = calculate_waiting_time(
        process_name, turn_around_time, burst_time, no_of_process
    )

    print("Process name \tArrival time \tBurst time \tTurn around time \tWaiting time")
    for i in range(no_of_process):
        print(
            f"{process_name[i]}\t\t{arrival_time[i]}\t\t{burst_time[i]}\t\t"
            f"{turn_around_time[i]}\t\t\t{waiting_time[i]}"
        )

    print(f"average waiting time : {mean(waiting_time):.5f}")
    print(f"average turn around time : {mean(turn_around_time):.5f}")
    '
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function generate_radix_tree367
    # Define the output file where the Python code will be saved
    set output_file "radix_tree.py"

    # Define the Python code template for Radix Tree
    set template_content '


class RadixNode:
    def __init__(self, prefix: str = "", is_leaf: bool = False) -> None:
        # Mapping from the first character of the prefix of the node
        self.nodes: dict[str, RadixNode] = {}

        # A node will be a leaf if the tree contains its word
        self.is_leaf = is_leaf

        self.prefix = prefix

    def match(self, word: str) -> tuple[str, str, str]:
        x = 0
        for q, w in zip(self.prefix, word):
            if q != w:
                break

            x += 1

        return self.prefix[:x], self.prefix[x:], word[x:]

    def insert_many(self, words: list[str]) -> None:

        for word in words:
            self.insert(word)

    def insert(self, word: str) -> None:
        # Case 1: If the word is the prefix of the node
        if self.prefix == word and not self.is_leaf:
            self.is_leaf = True

        # Case 2: The node has no edges that have a prefix to the word
        elif word[0] not in self.nodes:
            self.nodes[word[0]] = RadixNode(prefix=word, is_leaf=True)

        else:
            incoming_node = self.nodes[word[0]]
            matching_string, remaining_prefix, remaining_word = incoming_node.match(
                word
            )

            # Case 3: The node prefix is equal to the matching
            if remaining_prefix == "":
                self.nodes[matching_string[0]].insert(remaining_word)

            # Case 4: The word is greater equal to the matching
            else:
                incoming_node.prefix = remaining_prefix

                aux_node = self.nodes[matching_string[0]]
                self.nodes[matching_string[0]] = RadixNode(matching_string, False)
                self.nodes[matching_string[0]].nodes[remaining_prefix[0]] = aux_node

                if remaining_word == "":
                    self.nodes[matching_string[0]].is_leaf = True
                else:
                    self.nodes[matching_string[0]].insert(remaining_word)

    def find(self, word: str) -> bool:
        incoming_node = self.nodes.get(word[0], None)
        if not incoming_node:
            return False
        else:
            _matching_string, remaining_prefix, remaining_word = incoming_node.match(
                word
            )
            if remaining_prefix != "":
                return False
            elif remaining_word == "":
                return incoming_node.is_leaf
            else:
                return incoming_node.find(remaining_word)

    def delete(self, word: str) -> bool:
        incoming_node = self.nodes.get(word[0], None)
        if not incoming_node:
            return False
        else:
            _matching_string, remaining_prefix, remaining_word = incoming_node.match(
                word
            )
            if remaining_prefix != "":
                return False
            elif remaining_word != "":
                return incoming_node.delete(remaining_word)
            elif not incoming_node.is_leaf:
                return False
            else:
                if len(incoming_node.nodes) == 0:
                    del self.nodes[word[0]]
                    if len(self.nodes) == 1 and not self.is_leaf:
                        merging_node = next(iter(self.nodes.values()))
                        self.is_leaf = merging_node.is_leaf
                        self.prefix += merging_node.prefix
                        self.nodes = merging_node.nodes
                elif len(incoming_node.nodes) > 1:
                    incoming_node.is_leaf = False
                else:
                    merging_node = next(iter(incoming_node.nodes.values()))
                    incoming_node.is_leaf = merging_node.is_leaf
                    incoming_node.prefix += merging_node.prefix
                    incoming_node.nodes = merging_node.nodes

                return True

    def print_tree(self, height: int = 0) -> None:
        if self.prefix != "":
            print("-" * height, self.prefix, "  (leaf)" if self.is_leaf else "")

        for value in self.nodes.values():
            value.print_tree(height + 1)

def test_trie() -> bool:
    words = "banana bananas bandana band apple all beast".split()
    root = RadixNode()
    root.insert_many(words)

    assert all(root.find(word) for word in words)
    assert not root.find("bandanas")
    assert not root.find("apps")
    root.delete("all")
    assert not root.find("all")
    root.delete("banana")
    assert not root.find("banana")
    assert root.find("bananas")

    return True

def pytests() -> None:
    assert test_trie()

def main() -> None:
    root = RadixNode()
    words = "banana bananas bandanas bandana band apple all beast".split()
    root.insert_many(words)

    print("Words:", words)
    print("Tree:")
    root.print_tree()


if __name__ == "__main__":
    main()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change the terminal color for success message
    set_color FFAD8D
    echo "$output_file created successfully"
    set_color normal

    # Display the contents of the output file
    cat $output_file
end




function generate_equilibrium_index368
    # Define the output file where the Python code will be saved
    set output_file "equilibrium_index.py"

    # Define the Python code template for the equilibrium_index function
    set template_content '
def equilibrium_index(arr: list[int]) -> int:
    total_sum = sum(arr)
    left_sum = 0

    for i, value in enumerate(arr):
        total_sum -= value
        if left_sum == total_sum:
            return i
        left_sum += value

    return -1


if __name__ == "__main__":
 
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end





function generate_triplets_with_0_sum369
    # Define the output file where the Python code will be saved
    set output_file "find_triplets.py"

    # Define the Python code template for finding triplets with 0 sum
    set template_content '
from itertools import combinations


def find_triplets_with_0_sum(nums: list[int]) -> list[list[int]]:
   
    return [
        list(x)
        for x in sorted({abc for abc in combinations(sorted(nums), 3) if not sum(abc)})
    ]


def find_triplets_with_0_sum_hashing(arr: list[int]) -> list[list[int]]:
    target_sum = 0

    # Initialize the final output array with blank.
    output_arr = []

    # Set the initial element as arr[i].
    for index, item in enumerate(arr[:-2]):
        # to store second elements that can complement the final sum.
        set_initialize = set()

        # current sum needed for reaching the target sum
        current_sum = target_sum - item

        # Traverse the subarray arr[i+1:].
        for other_item in arr[index + 1 :]:
            # required value for the second element
            required_value = current_sum - other_item

            # Verify if the desired value exists in the set.
            if required_value in set_initialize:
                # finding triplet elements combination.
                combination_array = sorted([item, other_item, required_value])
                if combination_array not in output_arr:
                    output_arr.append(combination_array)

            # Include the current element in the set
            # for subsequent complement verification.
            set_initialize.add(other_item)

    # Return all the triplet combinations.
    return output_arr


if __name__ == "__main__":
    from doctest import testmod

    testmod()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end




function generate_index_2d_array370
    # Define the output file where the Python code will be saved
    set output_file "index_2d_array.py"

    # Define the Python code template for the Index2DArrayIterator and index_2d_array_in_1d
    set template_content '
from collections.abc import Iterator
from dataclasses import dataclass


@dataclass
class Index2DArrayIterator:
    matrix: list[list[int]]

    def __iter__(self) -> Iterator[int]:
        for row in self.matrix:
            yield from row


def index_2d_array_in_1d(array: list[list[int]], index: int) -> int:
    rows = len(array)
    cols = len(array[0])

    if rows == 0 or cols == 0:
        raise ValueError("no items in array")

    if index < 0 or index >= rows * cols:
        raise ValueError("index out of range")

    return array[index // cols][index % cols]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end


function generate_kth_largest371
    set output_file "kth_largest.py"
    set template_content '
def partition(arr: list[int], low: int, high: int) -> int:
    
    pivot = arr[high]
    i = low - 1
    for j in range(low, high):
        if arr[j] >= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1


def kth_largest_element(arr: list[int], position: int) -> int:
    if not arr:
        return -1
    if not isinstance(position, int):
        raise ValueError("The position should be an integer")
    if not 1 <= position <= len(arr):
        raise ValueError("Invalid value of 'position'")
    low, high = 0, len(arr) - 1
    while low <= high:
        if low > len(arr) - 1 or high < 0:
            return -1
        pivot_index = partition(arr, low, high)
        if pivot_index == position - 1:
            return arr[pivot_index]
        elif pivot_index > position - 1:
            high = pivot_index - 1
        else:
            low = pivot_index + 1
    return -1


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end





function generate_median372
    # Define the output file where the Python code will be saved
    set output_file "median_sorted_arrays.py"

    # Define the Python code template for find_median_sorted_arrays function
    set template_content '
def find_median_sorted_arrays(nums1: list[int], nums2: list[int]) -> float:
    if not nums1 and not nums2:
        raise ValueError("Both input arrays are empty.")

    # Merge the arrays into a single sorted array.
    merged = sorted(nums1 + nums2)
    total = len(merged)

    if total % 2 == 1:  # If the total number of elements is odd
        return float(merged[total // 2])  # then return the middle element

    # If the total number of elements is even, calculate
    # the average of the two middle elements as the median.
    middle1 = merged[total // 2 - 1]
    middle2 = merged[total // 2]
    return (float(middle1) + float(middle2)) / 2.0


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end





function generate_monotonic373
    # Define the output file where the Python code will be saved
    set output_file "monotonic_check.py"

    # Define the Python code template for the is_monotonic function
    set template_content '
def is_monotonic(nums: list[int]) -> bool:
    return all(nums[i] <= nums[i + 1] for i in range(len(nums) - 1)) or all(
        nums[i] >= nums[i + 1] for i in range(len(nums) - 1)
    )


# Test the function with your examples
if __name__ == "__main__":
    # Test the function with your examples
    print(is_monotonic([1, 2, 2, 3]))  # Output: True
    print(is_monotonic([6, 5, 4, 4]))  # Output: True
    print(is_monotonic([1, 3, 2]))  # Output: False

    import doctest

    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    cat $output_file

    # Run the Python script
    python3 $output_file
end


function generate_pairs_with_sum374
    # Define the output file where the Python code will be saved
    set output_file "pairs_with_sum.py"

    # Define the Python code template for the pairs_with_sum function
    set template_content '
from itertools import combinations


def pairs_with_sum(arr: list, req_sum: int) -> int:
    return len([1 for a, b in combinations(arr, 2) if a + b == req_sum])


if __name__ == "__main__":
    from doctest import testmod

    testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file

    # Run the Python script
    python3 $output_file
end


function generate_permute375
    # Define the output file where the Python code will be saved
    set output_file "permute.py"

    # Define the Python code template for the permute_recursive and permute_backtrack functions
    set template_content '
def permute_recursive(nums: list[int]) -> list[list[int]]:
    result: list[list[int]] = []
    if len(nums) == 0:
        return [[]]
    for _ in range(len(nums)):
        n = nums.pop(0)
        permutations = permute_recursive(nums.copy())
        for perm in permutations:
            perm.append(n)
        result.extend(permutations)
        nums.append(n)
    return result


def permute_backtrack(nums: list[int]) -> list[list[int]]:
    def backtrack(start: int) -> None:
        if start == len(nums) - 1:
            output.append(nums[:])
        else:
            for i in range(start, len(nums)):
                nums[start], nums[i] = nums[i], nums[start]
                backtrack(start + 1)
                nums[start], nums[i] = nums[i], nums[start]  # backtrack

    output: list[list[int]] = []
    backtrack(0)
    return output


if __name__ == "__main__":
    import doctest

    result = permute_backtrack([1, 2, 3])
    print(result)
    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
    python3 $output_file
end


function generate_prefix_sum376
    # Define the output file where the Python code will be saved
    set output_file "prefix_sum.py"

    # Define the Python code template for PrefixSum class
    set template_content '
class PrefixSum:
    def __init__(self, array: list[int]) -> None:
        len_array = len(array)
        self.prefix_sum = [0] * len_array

        if len_array > 0:
            self.prefix_sum[0] = array[0]

        for i in range(1, len_array):
            self.prefix_sum[i] = self.prefix_sum[i - 1] + array[i]

    def get_sum(self, start: int, end: int) -> int:
        if not self.prefix_sum:
            raise ValueError("The array is empty.")

        if start < 0 or end >= len(self.prefix_sum) or start > end:
            raise ValueError("Invalid range specified.")

        if start == 0:
            return self.prefix_sum[end]

        return self.prefix_sum[end] - self.prefix_sum[start - 1]

    def contains_sum(self, target_sum: int) -> bool:
        sums = {0}
        for sum_item in self.prefix_sum:
            if sum_item - target_sum in sums:
                return True

            sums.add(sum_item)

        return False


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
    python3 $output_file
end


function generate_product_sum377
    # Define the output file where the Python code will be saved
    set output_file "product_sum.py"

    # Define the Python code template for product_sum class and methods
    set template_content '
def product_sum(arr: list[int | list], depth: int) -> int:
    total_sum = 0
    for ele in arr:
        total_sum += product_sum(ele, depth + 1) if isinstance(ele, list) else ele
    return total_sum * depth


def product_sum_array(array: list[int | list]) -> int:
    return product_sum(array, 1)


if __name__ == "__main__":

'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end






function generate_rotate_array378
    # Define the output file where the Python code will be saved
    set output_file "rotate_array.py"

    # Define the Python code template for the rotate_array function
    set template_content '
def rotate_array(arr: list[int], steps: int) -> list[int]:
    n = len(arr)
    if n == 0:
        return arr

    steps = steps % n

    if steps < 0:
        steps += n

    def reverse(start: int, end: int) -> None:

        while start < end:
            arr[start], arr[end] = arr[end], arr[start]
            start += 1
            end -= 1

    reverse(0, n - 1)
    reverse(0, steps - 1)
    reverse(steps, n - 1)

    return arr


if __name__ == "__main__":
    examples = [
        ([1, 2, 3, 4, 5], 2),
        ([1, 2, 3, 4, 5], -2),
        ([1, 2, 3, 4, 5], 7),
        ([], 3),
    ]

    for arr, steps in examples:
        rotated = rotate_array(arr.copy(), steps)
        print(f"Rotate {arr} by {steps}: {rotated}")
'

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end


function generate_sparse_table379
    # Define the output file where the Python code will be saved
    set output_file "sparse_table.py"

    # Define the Python code template for the sparse table and query functions
    set template_content '
from math import log2


def build_sparse_table(number_list: list[int]) -> list[list[int]]:
    if not number_list:
        raise ValueError("empty number list not allowed")

    length = len(number_list)
    # Initialise sparse_table -- sparse_table[j][i] represents the minimum value of the
    # subset of length (2 ** j) of number_list, starting from index i.

    # smallest power of 2 subset length that fully covers number_list
    row = int(log2(length)) + 1
    sparse_table = [[0 for i in range(length)] for j in range(row)]

    # minimum of subset of length 1 is that value itself
    for i, value in enumerate(number_list):
        sparse_table[0][i] = value
    j = 1

    # compute the minimum value for all intervals with size (2 ** j)
    while (1 << j) <= length:
        i = 0
        # while subset starting from i still have at least (2 ** j) elements
        while (i + (1 << j) - 1) < length:
            # split range [i, i + 2 ** j] and find minimum of 2 halves
            sparse_table[j][i] = min(
                sparse_table[j - 1][i + (1 << (j - 1))], sparse_table[j - 1][i]
            )
            i += 1
        j += 1
    return sparse_table


def query(sparse_table: list[list[int]], left_bound: int, right_bound: int) -> int:
    if left_bound < 0 or right_bound >= len(sparse_table[0]):
        raise IndexError("list index out of range")

    # highest subset length of power of 2 that is within range [left_bound, right_bound]
    j = int(log2(right_bound - left_bound + 1))

    # minimum of 2 overlapping smaller subsets:
    # [left_bound, left_bound + 2 ** j - 1] and [right_bound - 2 ** j + 1, right_bound]
    return min(sparse_table[j][right_bound - (1 << j) + 1], sparse_table[j][left_bound])


if __name__ == "__main__":
    from doctest import testmod

    testmod()
    print(f"{query(build_sparse_table([3, 1, 9]), 2, 2) = }")
    '

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end



function generate_avl_tree380
    # Define the output file where the Python code will be saved
    set output_file "avl_tree.py"

    # Define the Python code template for the AVL tree
    set template_content '
from __future__ import annotations

import math
import random
from typing import Any


class MyQueue:
    def __init__(self) -> None:
        self.data: list[Any] = []
        self.head: int = 0
        self.tail: int = 0

    def is_empty(self) -> bool:
        return self.head == self.tail

    def push(self, data: Any) -> None:
        self.data.append(data)
        self.tail = self.tail + 1

    def pop(self) -> Any:
        ret = self.data[self.head]
        self.head = self.head + 1
        return ret

    def count(self) -> int:
        return self.tail - self.head

    def print_queue(self) -> None:
        print(self.data)
        print("**************")
        print(self.data[self.head : self.tail])


class MyNode:
    def __init__(self, data: Any) -> None:
        self.data = data
        self.left: MyNode | None = None
        self.right: MyNode | None = None
        self.height: int = 1

    def get_data(self) -> Any:
        return self.data

    def get_left(self) -> MyNode | None:
        return self.left

    def get_right(self) -> MyNode | None:
        return self.right

    def get_height(self) -> int:
        return self.height

    def set_data(self, data: Any) -> None:
        self.data = data

    def set_left(self, node: MyNode | None) -> None:
        self.left = node

    def set_right(self, node: MyNode | None) -> None:
        self.right = node

    def set_height(self, height: int) -> None:
        self.height = height


def get_height(node: MyNode | None) -> int:
    if node is None:
        return 0
    return node.get_height()


def my_max(a: int, b: int) -> int:
    if a > b:
        return a
    return b


def right_rotation(node: MyNode) -> MyNode:
    r"""
            A                      B
           / \                    / \
          B   C                  Bl  A
         / \       -->          /   / \
        Bl  Br                 UB Br  C
       /
     UB
    UB = unbalanced node
    """
    print("left rotation node:", node.get_data())
    ret = node.get_left()
    assert ret is not None
    node.set_left(ret.get_right())
    ret.set_right(node)
    h1 = my_max(get_height(node.get_right()), get_height(node.get_left())) + 1
    node.set_height(h1)
    h2 = my_max(get_height(ret.get_right()), get_height(ret.get_left())) + 1
    ret.set_height(h2)
    return ret


def left_rotation(node: MyNode) -> MyNode:
    """
    a mirror symmetry rotation of the left_rotation
    """
    print("right rotation node:", node.get_data())
    ret = node.get_right()
    assert ret is not None
    node.set_right(ret.get_left())
    ret.set_left(node)
    h1 = my_max(get_height(node.get_right()), get_height(node.get_left())) + 1
    node.set_height(h1)
    h2 = my_max(get_height(ret.get_right()), get_height(ret.get_left())) + 1
    ret.set_height(h2)
    return ret


def lr_rotation(node: MyNode) -> MyNode:
    r"""
            A              A                    Br
           / \            / \                  /  \
          B   C    LR    Br  C       RR       B    A
         / \       -->  /  \         -->    /     / \
        Bl  Br         B   UB              Bl    UB  C
             \        /
             UB     Bl
    RR = right_rotation   LR = left_rotation
    """
    left_child = node.get_left()
    assert left_child is not None
    node.set_left(left_rotation(left_child))
    return right_rotation(node)


def rl_rotation(node: MyNode) -> MyNode:
    right_child = node.get_right()
    assert right_child is not None
    node.set_right(right_rotation(right_child))
    return left_rotation(node)


def insert_node(node: MyNode | None, data: Any) -> MyNode | None:
    if node is None:
        return MyNode(data)
    if data < node.get_data():
        node.set_left(insert_node(node.get_left(), data))
        if (
            get_height(node.get_left()) - get_height(node.get_right()) == 2
        ):  # an unbalance detected
            left_child = node.get_left()
            assert left_child is not None
            if (
                data < left_child.get_data()
            ):  # new node is the left child of the left child
                node = right_rotation(node)
            else:
                node = lr_rotation(node)
    else:
        node.set_right(insert_node(node.get_right(), data))
        if get_height(node.get_right()) - get_height(node.get_left()) == 2:
            right_child = node.get_right()
            assert right_child is not None
            if data < right_child.get_data():
                node = rl_rotation(node)
            else:
                node = left_rotation(node)
    h1 = my_max(get_height(node.get_right()), get_height(node.get_left())) + 1
    node.set_height(h1)
    return node


def get_right_most(root: MyNode) -> Any:
    while True:
        right_child = root.get_right()
        if right_child is None:
            break
        root = right_child
    return root.get_data()


def get_left_most(root: MyNode) -> Any:
    while True:
        left_child = root.get_left()
        if left_child is None:
            break
        root = left_child
    return root.get_data()


def del_node(root: MyNode, data: Any) -> MyNode | None:
    left_child = root.get_left()
    right_child = root.get_right()
    if root.get_data() == data:
        if left_child is not None and right_child is not None:
            temp_data = get_left_most(right_child)
            root.set_data(temp_data)
            root.set_right(del_node(right_child, temp_data))
        elif left_child is not None:
            root = left_child
        elif right_child is not None:
            root = right_child
        else:
            return None
    elif root.get_data() > data:
        if left_child is None:
            print("No such data")
            return root
        else:
            root.set_left(del_node(left_child, data))
    # root.get_data() < data
    elif right_child is None:
        return root
    else:
        root.set_right(del_node(right_child, data))

    # Re-fetch left_child and right_child references
    left_child = root.get_left()
    right_child = root.get_right()

    if get_height(right_child) - get_height(left_child) == 2:
        assert right_child is not None
        if get_height(right_child.get_right()) > get_height(right_child.get_left()):
            root = left_rotation(root)
        else:
            root = rl_rotation(root)
    elif get_height(right_child) - get_height(left_child) == -2:
        assert left_child is not None
        if get_height(left_child.get_left()) > get_height(left_child.get_right()):
            root = right_rotation(root)
        else:
            root = lr_rotation(root)
    height = my_max(get_height(root.get_right()), get_height(root.get_left())) + 1
    root.set_height(height)
    return root


class AVLtree:

    def __init__(self) -> None:
        self.root: MyNode | None = None

    def get_height(self) -> int:
        return get_height(self.root)

    def insert(self, data: Any) -> None:
        print("insert:" + str(data))
        self.root = insert_node(self.root, data)

    def del_node(self, data: Any) -> None:
        print("delete:" + str(data))
        if self.root is None:
            print("Tree is empty!")
            return
        self.root = del_node(self.root, data)

    def __str__(
        self,
    ) -> str:  # a level traversale, gives a more intuitive look on the tree
        output = ""
        q = MyQueue()
        q.push(self.root)
        layer = self.get_height()
        if layer == 0:
            return output
        cnt = 0
        while not q.is_empty():
            node = q.pop()
            space = " " * int(math.pow(2, layer - 1))
            output += space
            if node is None:
                output += "*"
                q.push(None)
                q.push(None)
            else:
                output += str(node.get_data())
                q.push(node.get_left())
                q.push(node.get_right())
            output += space
            cnt = cnt + 1
            for i in range(100):
                if cnt == math.pow(2, i) - 1:
                    layer = layer - 1
                    if layer == 0:
                        output += "\n*************************************"
                        return output
                    output += "\n"
                    break
        output += "\n*************************************"
        return output


def _test() -> None:
    import doctest

    doctest.testmod()


if __name__ == "__main__":
    _test()
    t = AVLtree()
    lst = list(range(10))
    random.shuffle(lst)
    for i in lst:
        t.insert(i)
        print(str(t))
    random.shuffle(lst)
    for i in lst:
        t.del_node(i)
        print(str(t))
    '

    # Write the Python code to the output file
    echo "$template_content" > $output_file

    # Change terminal color to indicate success
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file

    # Run the Python script
    python3 $output_file
end


function generate_binary_tree381
    # Define the output file where the Python code will be saved
    set output_file "binary_tree.py"

    # Define the Python code template for the Binary Tree implementation
    set template_content '
from __future__ import annotations

from collections.abc import Iterator
from dataclasses import dataclass


@dataclass
class Node:
    data: int
    left: Node | None = None
    right: Node | None = None

    def __iter__(self) -> Iterator[int]:
        if self.left:
            yield from self.left
        yield self.data
        if self.right:
            yield from self.right

    def __len__(self) -> int:
        return sum(1 for _ in self)

    def is_full(self) -> bool:
        if not self or (not self.left and not self.right):
            return True
        if self.left and self.right:
            return self.left.is_full() and self.right.is_full()
        return False


@dataclass
class BinaryTree:
    root: Node

    def __iter__(self) -> Iterator[int]:
        return iter(self.root)

    def __len__(self) -> int:
        return len(self.root)

    @classmethod
    def small_tree(cls) -> BinaryTree:
        binary_tree = BinaryTree(Node(2))
        binary_tree.root.left = Node(1)
        binary_tree.root.right = Node(3)
        return binary_tree

    @classmethod
    def medium_tree(cls) -> BinaryTree:
        binary_tree = BinaryTree(Node(4))
        binary_tree.root.left = two = Node(2)
        two.left = Node(1)
        two.right = Node(3)
        binary_tree.root.right = five = Node(5)
        five.right = six = Node(6)
        six.right = Node(7)
        return binary_tree

    def depth(self) -> int:
        return self._depth(self.root)

    def _depth(self, node: Node | None) -> int:
        if not node:
            return 0
        return 1 + max(self._depth(node.left), self._depth(node.right))

    def is_full(self) -> bool:
        return self.root.is_full()


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal

    # Display the content of the output file
    cat $output_file
end





function algoP.Strings382
    set output_file "main.py"

    set template_content "
def string_matching_naive(text="", pattern=""):

    n = len(text)
    m = len(pattern)
    offsets = []
    for i in range(n - m + 1):
        if pattern == text[i : i + m]:
            offsets.append(i)

    return offsets


def string_matching_rabin_karp(text="", pattern="", hash_base=256):

    n = len(text)
    m = len(pattern)
    offsets = []
    htext = hash_value(text[:m], hash_base)
    hpattern = hash_value(pattern, hash_base)
    for i in range(n - m + 1):
        if htext == hpattern:
            if text[i : i + m] == pattern:
                offsets.append(i)
        if i < n - m:
            htext = (
                hash_base * (htext - (ord(text[i]) * (hash_base ** (m - 1))))
            ) + ord(text[i + m])

    return offsets


def hash_value(s, base):
    v = 0
    p = len(s) - 1
    for i in range(p + 1):
        v += ord(s[i]) * (base**p)
        p -= 1

    return v


def string_matching_knuth_morris_pratt(text="", pattern=""):
    n = len(text)
    m = len(pattern)
    offsets = []
    pi = compute_prefix_function(pattern)
    q = 0
    for i in range(n):
        while q > 0 and pattern[q] != text[i]:
            q = pi[q - 1]
        if pattern[q] == text[i]:
            q = q + 1
        if q == m:
            offsets.append(i - m + 1)
            q = pi[q - 1]

    return offsets


def compute_prefix_function(p):
    m = len(p)
    pi = [0] * m
    k = 0
    for q in range(1, m):
        while k > 0 and p[k] != p[q]:
            k = pi[k - 1]
        if p[k] == p[q]:
            k = k + 1
        pi[q] = k
    return pi


def string_matching_boyer_moore_horspool(text="", pattern=""):
    m = len(pattern)
    n = len(text)
    offsets = []
    if m > n:
        return offsets
    skip = []
    for k in range(256):
        skip.append(m)
    for k in range(m - 1):
        skip[ord(pattern[k])] = m - k - 1
    skip = tuple(skip)
    k = m - 1
    while k < n:
        j = m - 1
        i = k
        while j >= 0 and text[i] == pattern[j]:
            j -= 1
            i -= 1
        if j == -1:
            offsets.append(i + 1)
        k += skip[ord(text[k])]

    return offsets


def atoi(s):
    if not s:
        raise ValueError
    i = 0
    idx = 0
    neg = False
    if s[0] == "-":
        neg = True
        idx += 1

    for c in s[idx:]:
        i *= 10
        i += int(c)

    if neg:
        i = -i

    return i


def reverse_string_words(s):
    def reverse(lst, i, j):
        while i != j:
            lst[i], lst[j] = lst[j], lst[i]
            i += 1
            j -= 1

    w = [e for e in s]
    i = 0
    j = len(w) - 1
    reverse(w, i, j)

    i = 0
    j = 0
    while j < len(w):
        while j < len(w) and w[j] != " ":
            j += 1
        reverse(w, i, j - 1)
        i = j + 1
        j += 1

    return "".join(e for e in w)


class StringTest(unittest.TestCase):

    def test_atoi(self):
        self.assertEqual(string.atoi('123'), 123)

    def test_atoi_neg(self):
        self.assertEqual(string.atoi('-123'), -123)

    def test_atoi_empty_string(self):
        self.assertRaises(ValueError, string.atoi, '')

    def test_reverse_string_words(self):
        s = 'word1 word2 word3'
        s = string.reverse_string_words(s)
        self.assertEqual(s, 'word3 word2 word1')

    def test_reverse_string_word(self):
        s = 'word1'
        s = string.reverse_string_words(s)
        self.assertEqual(s, 'word1')

    def test_string_matching_naive(self):
        t = 'ababbababa'
        s = 'aba'
        self.assertEqual(string.string_matching_naive(t, s), [0, 5, 7])
        t = 'ababbababa'
        s = 'abbb'
        self.assertEqual(string.string_matching_naive(t, s), [])

    def test_string_matching_rabin_karp(self):
        t = 'ababbababa'
        s = 'aba'
        self.assertEqual(string.string_matching_rabin_karp(t, s), [0, 5, 7])
        t = 'ababbababa'
        s = 'abbb'
        self.assertEqual(string.string_matching_rabin_karp(t, s), [])

    def test_string_matching_knuth_morris_pratt(self):
        t = 'ababbababa'
        s = 'aba'
        self.assertEqual(string.string_matching_knuth_morris_pratt(t, s),
                         [0, 5, 7])
        t = 'ababbababa'
        s = 'abbb'
        self.assertEqual(string.string_matching_knuth_morris_pratt(t, s), [])

    def test_string_matching_boyer_moore_horspool(self):
        t = 'ababbababa'
        s = 'aba'
        self.assertEqual(string.string_matching_boyer_moore_horspool(t, s),
                         [0, 5, 7])
        t = 'ababbababa'
        s = 'abbb'
        self.assertEqual(string.string_matching_boyer_moore_horspool(t, s), [])

        s = 'ababbababa'
        t = 'abbb'
        self.assertEqual(string.string_matching_boyer_moore_horspool(t, s), [])


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.BubbleSort.Pass383
    set output_file "main.py"

    set template_content "
def permutations(lst):
    if len(lst) <= 1:
        yield lst
    else:
        a = [lst.pop(0)]
        for p in permutations(lst):
            for i in range(len(p)+1):
                yield p[:i] + a + p[i:]

class GeneratorsTest(unittest.TestCase):

    def setUp(self):
        pass

    def test_permutations(self):
        p = [e for e in permutations.permutations([1, 2, 3])]
        self.assertEqual(p, [[1, 2, 3], [2, 1, 3], [2, 3, 1], [1, 3, 2],
                             [3, 1, 2], [3, 2, 1]])

    def test_permutations_single(self):
        p = [e for e in permutations.permutations([1])]
        self.assertEqual(p, [[1]])


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.BubbleSort384
    set output_file "
def find_int(i, lst):
    if lst:
        p_idx = len(lst) / 2
        p = lst[p_idx]
        if i == p:
            return p_idx
        elif len(lst) == 1:
            return
        elif i < p:
            res = find_int(i, lst[:p_idx])
            if res:
                return res
        elif i > p:
            res = find_int(i, lst[p_idx:])
            if res:
                return res + p_idx


def find_max_sub(lst):
    # max sum
    max = lst[0]
    # current sum
    m = 0
    # max sum subset bounds
    bounds = (0, 0)
    # current subset start
    s = 0
    for i in range(len(lst)):
        m += lst[i]
        if m > max:
            max = m
            bounds = (s, i)
        elif m < 0:
            m = 0
            s = i + 1
    return bounds, max


def merge_sort(lst):
    def merge(l1, l2):
        res = []
        i = 0
        j = 0
        while i < len(l1) and j < len(l2):
            if l1[i] <= l2[j]:
                res.append(l1[i])
                i += 1
            elif l2[j] < l1[i]:
                res.append(l2[j])
                j += 1

        while i < len(l1):
            res.append(l1[i])
            i += 1

        while j < len(l2):
            res.append(l2[j])
            j += 1

        return res

    length = len(lst)
    if length <= 1:
        return lst
    mid = length / 2
    h1 = merge_sort(lst[:mid])
    h2 = merge_sort(lst[mid:])

    return merge(h1, h2)


def quicksort(lst):
    if len(lst) <= 1:
        return lst

    pivot = lst[0]
    less = []
    equal = []
    greater = []
    for e in lst:
        if e < pivot:
            less.append(e)
        elif e == pivot:
            equal.append(e)
        else:
            greater.append(e)

    return quicksort(less) + equal + quicksort(greater)

class List(unittest.TestCase):

    def setUp(self):
        pass

    def test_find_max_sub(self):
        bounds, m = [e for e in list.find_max_sub([-2, 3, -4, 5, 1, -5])]
        self.assertEqual(bounds, (3, 4))
        self.assertEqual(m, 6)

    def test_find_int_first_half(self):
        idx = list.find_int(4, [1, 2, 4, 5, 7, 9])
        self.assertEqual(idx, 2)

    def test_find_int_second_half(self):
        idx = list.find_int(7, [1, 2, 4, 5, 7, 9])
        self.assertEqual(idx, 4)

    def test_find_int_not_found(self):
        idx = list.find_int(3, [1, 2, 4, 5, 7, 9])
        self.assertIsNone(idx)

    def test_find_int_single_element_list(self):
        idx = list.find_int(3, [3, ])
        self.assertEqual(idx, 0)

    def test_find_int_empty_list(self):
        idx = list.find_int(3, [])
        self.assertIsNone(idx)

    def test_merge_sort(self):
        res = list.merge_sort([3, 4, 1, 5, 0])
        self.assertListEqual(res, [0, 1, 3, 4, 5])

    def test_merge_sort_duplicates(self):
        res = list.merge_sort([3, 4, 1, 5, 0, 4])
        self.assertListEqual(res, [0, 1, 3, 4, 4, 5])

    def test_merge_sort_single_element(self):
        res = list.merge_sort([3])
        self.assertListEqual(res, [3])

    def test_quicksort(self):
        res = list.quicksort([3, 4, 1, 5, 0])
        self.assertListEqual(res, [0, 1, 3, 4, 5])

    def test_quicksort_duplicates(self):
        res = list.quicksort([3, 4, 1, 5, 4, 0, 1])
        self.assertListEqual(res, [0, 1, 1, 3, 4, 4, 5])

    def test_quicksort_single_element(self):
        res = list.quicksort([3])
        self.assertListEqual(res, [3])


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.BubbleSort385
    set output_file "
def fib(n):
    if not n:
        return
    a, b = 0, 1
    yield a
    i = 0
    while i < n - 1:
        yield b
        a, b = b, a + b
        i += 1

class GeneratorsTest(unittest.TestCase):

    def setUp(self):
        pass

    def test_fib(self):
        fib = [e for e in generators.fib(10)]
        self.assertEqual(fib, [0, 1, 1, 2, 3, 5, 8, 13, 21, 34])

    def test_fib_empty(self):
        fib = [e for e in generators.fib(0)]
        self.assertEqual(fib, [])


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.BubbleSort386
    set output_file "
class Node(object):
    def __init__(self, data):
        self.left = None
        self.right = None
        self.data = data

    def insert(self, data):
        if self.data:
            if data < self.data:
                if self.left is None:
                    self.left = Node(data)
                else:
                    self.left.insert(data)
            elif data > self.data:
                if self.right is None:
                    self.right = Node(data)
                else:
                    self.right.insert(data)
        else:
            self.data = data

    def lookup(self, data, parent=None):
        if data < self.data:
            if self.left is None:
                return None, None
            return self.left.lookup(data, self)
        elif data > self.data:
            if self.right is None:
                return None, None
            return self.right.lookup(data, self)
        else:
            return self, parent

    def delete(self, data):
        # get node containing data
        node, parent = self.lookup(data)
        if node is not None:
            children_count = node.children_count()
            if children_count == 0:
                # if node has no children, just remove it
                if parent:
                    if parent.left is node:
                        parent.left = None
                    else:
                        parent.right = None
                else:
                    self.data = None
            elif children_count == 1:
                # if node has 1 child
                # replace node by its child
                if node.left:
                    n = node.left
                else:
                    n = node.right
                if parent:
                    if parent.left is node:
                        parent.left = n
                    else:
                        parent.right = n
                else:
                    self.left = n.left
                    self.right = n.right
                    self.data = n.data
            else:
                # if node has 2 children
                # find its successor
                parent = node
                successor = node.right
                while successor.left:
                    parent = successor
                    successor = successor.left
                # replace node data by its successor data
                node.data = successor.data
                # fix successor's parent node child
                if parent.left == successor:
                    parent.left = successor.right
                else:
                    parent.right = successor.right

    def compare_trees(self, node):
        if node is None:
            return False
        if self.data != node.data:
            return False
        res = True
        if self.left is None:
            if node.left:
                return False
        else:
            res = self.left.compare_trees(node.left)
        if res is False:
            return False
        if self.right is None:
            if node.right:
                return False
        else:
            res = self.right.compare_trees(node.right)
        return res

    def print_tree(self):
        if self.left:
            self.left.print_tree()
        print(self.data, end=" ")
        if self.right:
            self.right.print_tree()

    def tree_data(self):
        # we use a stack to traverse the tree in a non-recursive way
        stack = []
        node = self
        while stack or node:
            if node:
                stack.append(node)
                node = node.left
            else:
                # we are returning so we pop the node and we yield it
                node = stack.pop()
                yield node.data
                node = node.right

    def children_count(self):
        cnt = 0
        if self.left:
            cnt += 1
        if self.right:
            cnt += 1
        return cnt

class BinaryTreeTest(unittest.TestCase):

    def setUp(self):
        self.root_single_node = binary_tree.Node(None)
        self.root = binary_tree.Node(10)
        self.root.left = binary_tree.Node(5)
        self.root.left.left = binary_tree.Node(3)
        self.root.left.right = binary_tree.Node(7)
        self.root.right = binary_tree.Node(15)
        self.root.right.left = binary_tree.Node(12)
        self.root.right.left.left = binary_tree.Node(11)
        self.root.right.right = binary_tree.Node(20)
        self.root_copy = copy.deepcopy(self.root)

    def test_insert(self):
        root = self.root_single_node

        root.insert(10)
        self.assertEqual(root.data, 10)

        root.insert(5)
        self.assertEqual(root.left.data, 5)

        root.insert(15)
        self.assertEqual(root.right.data, 15)

        root.insert(8)
        self.assertEqual(root.left.right.data, 8)

        root.insert(2)
        self.assertEqual(root.left.left.data, 2)

        root.insert(12)
        self.assertEqual(root.right.left.data, 12)

        root.insert(17)
        self.assertEqual(root.right.right.data, 17)

    def test_lookup(self):
        node, parent = self.root.lookup(0)
        self.assertIsNone(parent)
        self.assertIsNone(node)

        node, parent = self.root.lookup(13)
        self.assertIsNone(parent)
        self.assertIsNone(node)

        node, parent = self.root.lookup(7)
        self.assertIs(node, self.root.left.right)
        self.assertIs(parent, self.root.left)

    def test_delete_root_no_child(self):
        self.root_single_node.data = 7
        self.root_single_node.delete(7)
        self.assertIsNone(self.root_single_node.data)

    def test_delete_root_one_child(self):
        self.root_single_node.data = 7
        self.root_single_node.insert(3)
        self.root_single_node.delete(7)
        self.assertEqual(self.root_single_node.data, 3)

    def test_delete_one_child_left(self):
        self.root.delete(12)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.left.right.data, 7)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 11)
        self.assertEqual(self.root.right.right.data, 20)

    def test_delete_one_child_right(self):
        self.root.insert(25)
        self.root.delete(20)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.left.right.data, 7)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.left.left.data, 11)
        self.assertEqual(self.root.right.right.data, 25)

    def test_delete_right_leaf(self):
        self.root.delete(7)
        self.assertIsNone(self.root.left.right)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.left.left.data, 11)
        self.assertEqual(self.root.right.right.data, 20)

    def test_delete_left_leaf(self):
        self.root.delete(3)
        self.assertIsNone(self.root.left.left)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.right.data, 7)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.left.left.data, 11)
        self.assertEqual(self.root.right.right.data, 20)

    def test_delete_right_node_two_childs(self):
        self.root.delete(15)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.left.right.data, 7)
        self.assertEqual(self.root.right.data, 20)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.left.left.data, 11)

    def test_delete_left_node_two_childs(self):
        self.root.delete(5)
        self.assertEqual(self.root.left.data, 7)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.left.left.data, 11)
        self.assertEqual(self.root.right.right.data, 20)

    def test_delete_root_two_childs(self):
        self.root.delete(10)
        self.assertEqual(self.root.left.data, 5)
        self.assertEqual(self.root.left.left.data, 3)
        self.assertEqual(self.root.left.right.data, 7)
        self.assertEqual(self.root.data, 11)
        self.assertEqual(self.root.right.data, 15)
        self.assertEqual(self.root.right.left.data, 12)
        self.assertEqual(self.root.right.right.data, 20)

    def test_compare_trees_left_leaf_missing(self):
        self.root_copy.delete(11)
        self.assertFalse(self.root.compare_trees(self.root_copy))

    def test_compare_trees_right_leaf_missing(self):
        self.root_copy.delete(20)
        self.assertFalse(self.root.compare_trees(self.root_copy))

    def test_compare_trees_diff_value(self):
        self.root_copy.left.data = 16
        self.assertFalse(self.root.compare_trees(self.root_copy))

    def test_compare_trees_extra_right_leaf(self):
        self.root_copy.insert(25)
        self.assertFalse(self.root.compare_trees(self.root_copy))

    def test_compare_trees_extra_left_leaf(self):
        self.root_copy.insert(18)
        self.assertFalse(self.root.compare_trees(self.root_copy))

    def test_print_tree(self):
        self.root.print_tree()

    def test_tree_data(self):
        self.assertEqual([e for e in self.root.tree_data()],
                         [3, 5, 7, 10, 11, 12, 15, 20])


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.BubbleSort387
    set output_file "
class Cell(object):
    def __init__(self, x, y, reachable):
        self.reachable = reachable
        self.x = x
        self.y = y
        self.parent = None
        self.g = 0
        self.h = 0
        self.f = 0

    def __lt__(self, other):
        return self.f < other.f


class AStar(object):
    def __init__(self):
        # open list
        self.opened = []
        heapq.heapify(self.opened)
        # visited cells list
        self.closed = set()
        # grid cells
        self.cells = []
        self.grid_height = None
        self.grid_width = None

    def init_grid(self, width, height, walls, start, end):
        self.grid_height = height
        self.grid_width = width
        for x in range(self.grid_width):
            for y in range(self.grid_height):
                if (x, y) in walls:
                    reachable = False
                else:
                    reachable = True
                self.cells.append(Cell(x, y, reachable))
        self.start = self.get_cell(*start)
        self.end = self.get_cell(*end)

    def get_heuristic(self, cell):
        return 10 * (abs(cell.x - self.end.x) + abs(cell.y - self.end.y))

    def get_cell(self, x, y):
        return self.cells[x * self.grid_height + y]

    def get_adjacent_cells(self, cell):
        cells = []
        if cell.x < self.grid_width - 1:
            cells.append(self.get_cell(cell.x + 1, cell.y))
        if cell.y > 0:
            cells.append(self.get_cell(cell.x, cell.y - 1))
        if cell.x > 0:
            cells.append(self.get_cell(cell.x - 1, cell.y))
        if cell.y < self.grid_height - 1:
            cells.append(self.get_cell(cell.x, cell.y + 1))
        return cells

    def get_path(self):
        cell = self.end
        path = [(cell.x, cell.y)]
        while cell.parent is not self.start:
            cell = cell.parent
            path.append((cell.x, cell.y))

        path.append((self.start.x, self.start.y))
        path.reverse()
        return path

    def update_cell(self, adj, cell):
        adj.g = cell.g + 10
        adj.h = self.get_heuristic(adj)
        adj.parent = cell
        adj.f = adj.h + adj.g

    def solve(self):
        # add starting cell to open heap queue
        heapq.heappush(self.opened, (self.start.f, self.start))
        while len(self.opened):
            # pop cell from heap queue
            f, cell = heapq.heappop(self.opened)
            # add cell to closed list so we don't process it twice
            self.closed.add(cell)
            # if ending cell, return found path
            if cell is self.end:
                return self.get_path()
            # get adjacent cells for cell
            adj_cells = self.get_adjacent_cells(cell)
            for adj_cell in adj_cells:
                if adj_cell.reachable and adj_cell not in self.closed:
                    if (adj_cell.f, adj_cell) in self.opened:
                        # if adj cell in open list, check if current path is
                        # better than the one previously found
                        # for this adj cell.
                        if adj_cell.g > cell.g + 10:
                            self.update_cell(adj_cell, cell)
                    else:
                        self.update_cell(adj_cell, cell)
                        # add adj cell to open list
                        heapq.heappush(self.opened, (adj_cell.f, adj_cell))


class Test(unittest.TestCase):

    def setUp(self):
        pass

    def test_maze(self):
        a = pf.AStar()
        walls = ((0, 5), (1, 0), (1, 1), (1, 5), (2, 3),
                 (3, 1), (3, 2), (3, 5), (4, 1), (4, 4), (5, 1))
        a.init_grid(6, 6, walls, (0, 0), (5, 5))
        path = a.solve()
        self.assertEqual(path, [(0, 0), (0, 1), (0, 2), (1, 2), (1, 3), (1, 4),
                                (2, 4), (3, 4), (3, 3), (4, 3), (5, 3), (5, 4),
                                (5, 5)])

    def test_maze_no_walls(self):
        a = pf.AStar()
        walls = ()
        a.init_grid(6, 6, walls, (0, 0), (5, 5))
        path = a.solve()
        self.assertEqual(len(path), 11)

    def test_maze_no_solution(self):
        a = pf.AStar()
        walls = ((0, 5), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
                 (2, 3), (3, 1), (3, 2), (3, 5), (4, 1), (4, 4), (5, 1))
        a.init_grid(6, 6, walls, (0, 0), (5, 5))
        self.assertIsNone(a.solve())


if __name__ == '__main__':
    unittest.main()
"

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SprialRecursivePrint388
    set output_file "SprialRecursivePrint.py"

    set template_content '
def spiral(n):
    def spiralPart(x, y, n):
        if x == -1 and y == 0:
            return -1
        if y == (x + 1) and x < (n // 2):
            return spiralPart(x - 1, y - 1, n - 1) + 4 * (n - y)
        if x < (n - y) and y <= x:
            return spiralPart(y - 1, y, n) + (x - y) + 1
        if x >= (n - y) and y <= x:
            return spiralPart(x, y - 1, n) + 1
        if x >= (n - y) and y > x:
            return spiralPart(x + 1, y, n) + 1
        if x < (n - y) and y > x:
            return spiralPart(x, y - 1, n) - 1
 
    array = [[0] * n for j in xrange(n)]
    for x in xrange(n):
        for y in xrange(n):
            array[x][y] = spiralPart(y, x, n)
    return array
 
for row in spiral(5):
    print " ".join("%2s" % x for x in row)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.SprialIterativePrint389
    set output_file "SprialIterativePrint.py"

    set template_content '
def spiral_iterative(n):
    dx, dy = 1, 0  # Starting increments
    x, y = 0, 0  # Starting location
    matrix = [[None] * n for j in range(n)]
    for i in xrange(n ** 2):
        matrix[x][y] = i
        nx, ny = x + dx, y + dy
        if 0 <= nx < n and 0 <= ny < n and matrix[nx][ny] == None:
            x, y = nx, ny
        else:
            dx, dy = -dy, dx
            x, y = x + dx, y + dy
    return matrix
 
def print_spiral(matrix):
    n = range(len(matrix))
    for y in n:
        for x in n:
            print "%2i" % matrix[x][y],
        print
 
print_spiral(spiral_iterative(5))  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ShuffleCards390
    set output_file "ShuffleCards.py"

    set template_content '
def shuffle(cards):
    max = len(cards) - 1
    while max != 0:
        r = random.randint(0, max)
        cards[r], cards[max] = cards[max], cards[r]
        max = max - 1
    return cards

actual = range(1, 53)
shuffle(actual)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ShuffleArray391
    set output_file "ShuffleArray.py"

    set template_content '
def shuffle_array(A):
	n = len(A)
	i = n - 1
	while i > 0:
		j = int((random.random()) % (i + 1))
		tmp = A[j - 1];A[j - 1] = A[j];A[j] = tmp
		i -= 1

A = [1, 3, 5, 6, 2, 4, 6, 8]
shuffle_array(A)
print A   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ReverseinBinary392
    set output_file "ReverseinBinary.py"

    set template_content '
def reverse_number(n):
	nReverse = n
	s = n.bit_length()
	while(n):
		nReverse <<= 1
		nReverse |= (n & 1)
		s -= 1
		n >>= 1
	nReverse <<= s	
	print nReverse

n = 4
print n
reverse_number(n)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NumberPlusone393
    set output_file "main.py"

    set template_content '
from __future__ import division
import random

def plus_one(digits):
    print digits, '+ 1 =',
    carry = 1
    for i in reversed(xrange(len(digits))):
        x = digits[i]
        carry, x = divmod(x + carry, 10)
        digits[i] = x
    if carry > 0: digits.insert(0, carry)
    print digits
    return digits

if __name__ == '__main__':
    plus_one([1, 2, 3, 4])
    plus_one([1, 9, 9])
    plus_one([9, 9, 9])
    plus_one([0])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NumberOfTrailingZerosOfFactorialNumber394
    set output_file "NumberOfTrailingZerosOfFactorialNumber.py"

    set template_content '
def number_of_trailing_zeros_of_factorial_number(n):
	count = 0
	if(n < 0):  
		return -1
	i = 5
	while n / i > 0:
		count += n / i
		i *= 5
	return count

print number_of_trailing_zeros_of_factorial_number(100)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.NumberOneBits395
    set output_file "main.py"

    set template_content '
def number_of_ones1(n):
	count = 0
	while(n):
        count += n & 1
	    n >>= 1
	print count

def number_of_ones2(n):
	count = 0
	while(n):
	    if(n % 2 == 1):
		  	count += 1
		  	n = n / 2
	print count
	

def number_of_ones3(n):
	count = 0
	while(n):
		count += 1
		n &= n - 1
	print count

def number_of_ones4(n):
	Table = [0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4]
	count = 0
	while (n):
		count = count + Table[n & 0xF]
		n >>= 4
	print count

	

n = 11
number_of_ones1(n)
number_of_ones2(n)
number_of_ones3(n)
number_of_ones4(n)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NumberOfOccurences396
    set output_file "NumberOfOccurences.py"

    set template_content '
def linear_search_count(A, data):
	count = 0
	for i in range (0, len(A)): 
		if(A[i] == data):
			count += 1
	return count

A = [7, 3, 6, 3, 3, 6, 7	]
print linear_search_count(A, 7)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MatrixSortedFind397
    set output_file "MatrixSortedFind.py"

    set template_content '
def matrix_find(matrix, value):
    m = len(matrix)
    if m == 0:
        return 0

    n = len(matrix[0])
    if n == 0:
        return 0

    i = 0
    j = n - 1

    while i < m and j >= 0:
        if matrix[i][j] == value:
            return 1

        elif matrix[i][j] < value:
            i = i + 1

        else:
            j = j - 1

    return 0    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MatrixRotation398
    set output_file "MatrixRotation.py"

    set template_content '
def print_matrix(matrix):
    for row in matrix:
        print row
    print
 
#rotate the matrix by 90 degrees (clockwise) in place
def rotate_90_degrees(matrix):
    layers = len(matrix) / 2
    length = len(matrix) - 1
 
    for layer in range(layers): #for each layer
        for i in range(layer, length - layer): # loop through the elements we need to change at each layer
            temp = matrix[layer][i] #save the top element, it takes just one variable as extra memory
            #Left -> Top
            matrix[layer][i] = matrix[length - i][layer]
            #Bottom -> left
            matrix[length - i][layer] = matrix[length - layer][length - i]
            #Right -> bottom
            matrix[length - layer][length - i] = matrix[i][length - layer]
            #Top -> Right
            matrix[i][length - layer] = temp
 
matrix =[ 
            [1,  2,  3,  4 ],
            [5,  6,  7,  8 ],
            [9,  10, 11, 12 ],
            [13, 14, 15, 16 ]  
        ]
print "Input matrix:\n"
print_matrix(matrix)
rotate_90_degrees(matrix)
print "Rotated matrix by 90 degrees:\n"
print_matrix(matrix)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.CountNumberofSetbitsin1toN399
    set output_file "CountNumberofSetbitsin1toN.py"

    set template_content '
def counting_number_of_ones_in_1_to_N(n):
    count = 0
    for i in range(1, n+1):
        j = i;
        while(j):
            count += 1
            j &= j - 1
    print count

n = 2
counting_number_of_ones_in_1_to_N(n)
n = 5
counting_number_of_ones_in_1_to_N(n)
n = 7
counting_number_of_ones_in_1_to_N(n)
n = 8
counting_number_of_ones_in_1_to_N(n)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.KnapSackWithDP400
    set output_file "01KnapSackWithDP.py"

    set template_content '
def Knapsack(knapsackSize, itemsValue, itemsWeight):
	numItems = len(itemsValue)
	M = [[0 for x in range(knapsackSize + 1)] for x in range(len(itemsValue))]
	for i in range(1, numItems):
		for j in range(knapsackSize + 1):
			value = itemsValue[i]
			weight = itemsWeight[i]
			if weight > j:
				M[i][j] = M[i - 1][j]
			else:
				M[i][j] = max(M[i - 1][j], M[i - 1][j - weight] + value)
 
	return M[numItems - 1][knapsackSize]
	
print Knapsack(50, [60, 100, 120], [10, 20, 30])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.AllPairShortestFloyd401
    set output_file "AllPairShortestFloyd.py"

    set template_content '
INF = 999999999
def printSolution(distGraph):
    string = "inf"
    nodes = distGraph.keys()
    for n in nodes:
        print "%10s" % (n),
    print "  "
    for i in nodes:
        print"%s" % (i),
        for j in nodes:
            if distGraph[i][j] == INF:
                print "%10s" % (string),
            else:
                print "%10s" % (distGraph[i][j]),
        print" "
def floydWarshall(graph):
    nodes = graph.keys()
    distance = {}
    for n in nodes:
        distance[n] = {}
        for k in nodes:
            distance[n][k] = graph[n][k]
    for k in nodes:
        for i in nodes:
            for j in nodes:
                if distance[i][k] + distance[k][j] < distance[i][j]:
                    distance[i][j] = distance[i][k] + distance[k][j]
    printSolution(distance)
if __name__ == '__main__':
    graph = {'A':{'A':0, 'B':6, 'C':INF, 'D':6, 'E':7},
             'B':{'A':INF, 'B':0, 'C':5, 'D':INF, 'E':INF},
             'C':{'A':INF, 'B':INF, 'C':0, 'D':9, 'E':3},
             'D':{'A':INF, 'B':INF, 'C':9, 'D':0, 'E':7},
             'E':{'A':INF, 'B':4, 'C':INF, 'D':INF, 'E':0}
             }
    floydWarshall(graph)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end





function algoP.CatalanWithDP402
    set output_file "CatalanWithDP.py"

    set template_content '
def CatalanNumber(n):
        catalan = [1, 1] + [0] * n
        for i in range(2, n + 1):
            for j in range(n):
                catalan[i] += catalan[j] * catalan[i - j - 1]
        return catalan[n]

print CatalanNumber(4)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.CatalanWithFormula403
    set output_file "CatalanWithFormula.py"

    set template_content '
catalan = []
 
# 1st term is 1
catalan.append(1)
 
for i in range (1, 1001):
    x = catalan[i - 1] * (4 * i - 2) / (i + 1)
    catalan.append(x)
 
 
def CatalanNumber(n):
    return catalan[n]
    
print CatalanRecursive(4)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.Count_Apples_with_3ways_of_reaching404
    set output_file "Count_Apples_with_3ways_of_reaching.py"

    set template_content '
def find_maximum_apples_count_3ways_of_reaching(Apples, n, m):
	S =[[0 for x in range(m)] for x in range(n)]

	# Initialize position S[0][0]. 
	# We cannot collect any apples other than Apples[0][0]
	S[0][0] = Apples[0][0]

	# Initialize the first row
	for j in range(1, m):
		S[0][j] = Apples[0][j] + S[0][j-1]	

	# Initialize the first column
	for i in range(1, n):
		S[i][0] = Apples[i][0] + S[i-1][0]

	for i in range(1, n):
		for j in range(1, m):
			previous_column = S[i][j-1]
			previous_row = S[i-1][j]
			previous_diagonal = S[i-1][j-1]
			
			if (previous_column >= previous_row) and (previous_column >= previous_diagonal):
			   largest = previous_column
			elif (previous_row >= previous_column) and (previous_row >= previous_diagonal):
			   largest = previous_row
			else:
			   largest = previous_diagonal

			S[i][j] =  Apples[i][j] + largest
	
	return S[n-1][m-1]

Apples = [ [1, 2, 4, 7], [2, 1, 6, 1], [12, 5, 9, 19], [4, 29, 50, 60] ]
print find_maximum_apples_count_3ways_of_reaching(Apples, len(Apples), len(Apples[0]))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.EditDistance405
    set output_file "main.py"

    set template_content '
def editDistance(A, B):
    m = len(A) + 1
    n = len(B) + 1

    table = {}
    for i in range(m): table[i, 0] = i
    for j in range(n): table[0, j] = j
    for i in range(1, m):
        for j in range(1, n):
            cost = 0 if A[i - 1] == B[j - 1] else 1
            table[i, j] = min(table[i, j - 1] + 1, table[i - 1, j] + 1, table[i - 1, j - 1] + cost)

    return table[i, j]

print(editDistance("Helloworld", "HalloWorld"))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.FactorialRecursive406
    set output_file "FactorialRecursive.py"

    set template_content '
def factorial(n):
	if n == 0: return 1
	return n * factorial(n - 1)
	
print(factorial(10))def factorial(n):
	if n == 0: return 1
	return n * factorial(n - 1)
	
print(factorial(10))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FactorialwithDP407
    set output_file "FactorialwithDP.py"

    set template_content '
factTable = {}

def factorial(n):
    try:
        return factTable[n]
    except KeyError:
        if n == 0:
            factTable[0] = 1
            return 1
        else:
            factTable[n] = n * factorial(n - 1)
            return factTable[n]

print(factorial(10))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FiboWithDPBottomUp408
    set output_file "FiboWithDPBottomUp.py"

    set template_content '
def Fibo(n):
   fibTable = [0, 1]
   for i in range(2, n + 1):
      fibTable.append(fibTable[i - 1] + fibTable[i - 2])
   return fibTable[n]
   
print(Fibo(10))     
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FiboWithDPTopDown409
    set output_file "FiboWithDPTopDown.py"

    set template_content '
fibTable = {1:1, 2:1}
def Fibo(n):
   if n <= 2:
      return 1
   if n in fibTable:
      return fibTable[n]
   else:
      fibTable[n] = Fibo(n - 1) + Fibo(n - 2)
      return fibTable[n]
      
print(Fibo(10))  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FiboWithoutDP410
    set output_file "FiboWithoutDP.py"

    set template_content '
def Fibo(n):
	a, b = 0, 1
	for i in range(n):
		a, b = b, a + b
	return a
      
print(Fibo(10))	   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.FindApplesCount411
    set output_file "FindApplesCount.py"

    set template_content '
def find_maximum_apples_count(Apples, n, m):
	S =[[0 for x in range(m)] for x in range(n)]

	# Initialize position S[0][0]. 
	# We cannot collect any apples otherthan Apples[0][0]
	S[0][0] = Apples[0][0]

	# Initialize the first row
	for j in range(1, m):
		S[0][j] = Apples[0][j] + S[0][j-1]	

	# Initialize the first column
	for i in range(1, n):
		S[i][0] = Apples[i][0] + S[i-1][0]

	for i in range(1, n):
		for j in range(1, m):
			previous_column = S[i][j-1]
			previous_row = S[i-1][j]

			if (previous_column > previous_row):
				S[i][j] =  Apples[i][j] + previous_column
			else:
				S[i][j] = Apples[i][j ]+ previous_row
	
	return S[n-1][m-1]

Apples = [ [1, 2, 4, 7], [2, 1, 6, 1], [12, 5, 9, 19], [4, 29, 50, 60] ]
print find_maximum_apples_count(Apples, len(Apples), len(Apples[0]))    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.GetMaxOnes412
    set output_file "GetMaxOnes.py"

    set template_content '
def getval(A, i, j, L, H):
	if (i < 0 or i >= L or j < 0 or j >= H):
		return 0
	else:
		return A[i][j]

def findMaxBlock(A, r, c, L, H, size):
	global maxsize
	global cntarr	
	if (r >= L or c >= H):
		return
	cntarr[r][c] = 1
	size += 1
	if  (size > maxsize):
		maxsize = size
	# search in eight directions
	direction = [[-1, 0], [-1, -1], [0, -1], [1, -1], [1, 0], [1, 1], [0, 1], [-1, 1]];
	for i in range(0, 7):
		newi = r + direction[i][0]
		newj = c + direction[i][1]
		val = getval (A, newi, newj, L, H)
		if (val > 0  and (cntarr[newi][newj] == 0)):
			findMaxBlock(A, newi, newj, L, H, size)


	cntarr[r][c] = 0

def getMaxOnes(A, rmax, colmax):
	global maxsize
	global size
	global cntarr
	for i in range(0, rmax):
		for j in range(0, colmax):
			if (A[i][j] == 1):								
				findMaxBlock(A, i, j, rmax, colmax, 0)	
			
	return maxsize
			
zarr = [[1, 1, 0, 0, 0], [0, 1, 1, 0, 1], [0, 0, 0, 1, 1], [1, 0, 0, 1, 1], [0, 1, 0, 1, 1]]
rmax = 5
colmax = 5
maxsize = 0
size = 0
cntarr = rmax * [colmax * [0]]
print ("Number of maximum 1s are ")
print getMaxOnes(zarr, rmax, colmax)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.LargestRectangleArea413
    set output_file "LargestRectangleArea.py"

    set template_content '
def largestRectangleArea(self, height):
	stack = []; i = 0; maxArea = 0
	while i < len(height):
	    if stack == [] or height[i] > height[stack[len(stack) - 1]]:
		stack.append(i)
	    else:
		curr = stack.pop()
		width = i if stack == [] else i - stack[len(stack) - 1] - 1
		maxArea = max(maxArea, width * height[curr])
		i -= 1
	    i += 1
	while stack != []:
	    curr = stack.pop()
	    width = i if stack == [] else len(height) - stack[len(stack) - 1] - 1
	    maxArea = max(maxArea, width * height[curr])
	return maxArea   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.longest_common_subsequence_recursive414
    set output_file "longest_common_subsequence_recursive.py"

    set template_content '
def LCS(X, Y):
    if not X or not Y:
        return ""
    x, m, y, n = X[0], X[1:], Y[0], Y[1:]
    if x == y:
        return x+LCS(m, n)
    else:
        # Use key=len to select the maximum string in a list efficiently
        return max(LCS (X, n), LCS(m, Y), key=len)

print "Longest common subsequence: ", LCS('ABCBDAB', 'BDCABA')

def LCS_length(X, Y):
    if not X or not Y:
        return 0
    x, m, y, n = X[0], X[1:], Y[0], Y[1:]
    if x == y:
        return 1+LCS_length(m, n)
    else:
        # Use key=len to select the maximum string in a list efficiently
        return max(LCS_length(X, n), LCS_length(m, Y))

print "Longest common subsequence length: ", LCS_length('ABCBDAB', 'BDCABA')
 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LongestCommonSubsequenceWithDP415
    set output_file "main.py"

    set template_content '
def LCSLength(X, Y):
    Table = [[0 for j in range(len(Y) + 1)] for i in range(len(X) + 1)]
    # row 0 and column 0 are initialized to 0 already
    for i, x in enumerate(X):
        for j, y in enumerate(Y):
            if x == y:
                Table[i + 1][j + 1] = Table[i][j] + 1
            else:
                Table[i + 1][j + 1] = \
                    max(Table[i + 1][j], Table[i][j + 1])
    # read the substring out from the matrix
    result = ""
    x, y = len(X), len(Y)
    while x != 0 and y != 0:
        if Table[x][y] == Table[x - 1][y]:
            x -= 1
        elif Table[x][y] == Table[x][y - 1]:
            y -= 1
        else:
            assert X[x - 1] == Y[y - 1]
            result = X[x - 1] + result
            x -= 1
            y -= 1
    return result   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end





function algoP.LongestCommonSubsequenceWithoutDP416
    set output_file "main.py"

    set template_content '
def LCSLength(X, Y):
    if not X or not Y:
        return ""
    x, m, y, n = X[0], X[1:], Y[0], Y[1:]
    if x == y:
        return x + LCSLength(m, n)
    else:
        return max(LCSLength(X, n), LCSLength(m, Y), key=len)
	
print (LCSLength('thisisatest', 'testingLCS123testing'))	   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSequence417
    set output_file "LongestIncreasingSequence2.py"

    set template_content '
def LongestIncreasingSequence2(numList):
    LISTable = [1]
    for i in range(1, len(numList))):
        LISTable.append(1)
        for j in range(i + 1, n):
            if numList[i] < numList[j] and LISTable[i] < LISTable[j] + 1:
                LISTable[i] = 1 + LISTable[j]
    print LISTable
    return max(LISTable)

print LongestIncreasingSequence2([3, 2, 6, 4, 5, 1])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubSeq418
    set output_file "LongestIncreasingSubSeq.py"

    set template_content '
def LongestIncreasingSequence(numList):
    LISTable = [1]
    for i in range(1, len(numList))):
        LISTable.append(1)
        for j in range(i + 1, n):
            if numList[i] < numList[j] and LISTable[i] < LISTable[j] + 1:
                LISTable[i] = 1 + LISTable[j]
    print LISTable
    return max(LISTable)

print LongestIncreasingSequence([3, 2, 6, 4, 5, 1])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.LongestPalindromeSubsequence419
    set output_file "LongestPalindromeSubsequence.py"

    set template_content '
def LongestPalindromeSubsequence(A):
	n = len(A)
	L = [[0 for x in range(n)] for x in range(n)]
	# palindromes with length 1
	for i  in range(0, n - 1):
		L[i][i] = 1

	# palindromes with length up to j+1
	for k  in range(2, n + 1):
		for i  in range(0, n - k + 1):
			j = i + k - 1
			if A[i] == A[j] and k == 2:
				L[i][j] = 2
			if A[i] == A[j]:
				L[i][j] = 2 + L[i + 1][j - 1]
			else:
				L[i][j] = max(L[i + 1][j] , L[i][j - 1])
				
	# print L
	return L[0][n - 1]
	
print  LongestPalindromeSubsequence("Career Monk Publications")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LongestPalindromeSubstring420
    set output_file "LongestPalindromeSubstring.py"

    set template_content '
def longestPalindromeSubstring(A):
    n = len(A)
    if n == 0: return ''
    L = {}
    for i in range(n): L[(i, i)] = True
    # k = j-i between 0 and n-1
    for k in range(n - 1):
        for i in range(n):
            j = i + k
            if j >= n: continue
            if i + 1 <= j - 1:
                L[(i, j)] = L[(i + 1, j - 1)] and A[i] == A[j]
            else:
                L[(i, j)] = A[i] == A[j]
    start, end = max([k for k in L if L[k]],
                      key=lambda x:x[1] - x[0])
    return A[start:end + 1]
    
print longestPalindromeSubstring('cabcbaabac')
print longestPalindromeSubstring('abbaaa')
print longestPalindromeSubstring('')    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MakingChangeWithDP421
    set output_file "MakingChangeWithDP.py"

    set template_content '
def MakingChange(coins, change, minimumCoins, coinsUsed):
   for cents in range(change + 1):
      coinCount = cents
      newCoin = 1
      for j in [c for c in coins if c <= cents]:
            if minimumCoins[cents - j] + 1 < coinCount:
               coinCount = minimumCoins[cents - j] + 1
               newCoin = j
      minimumCoins[cents] = coinCount
      coinsUsed[cents] = newCoin
   return minimumCoins[change]

def printingCoins(coinsUsed, change):
   coin = change
   while coin > 0:
      thisCoin = coinsUsed[coin]
      print(thisCoin)
      coin = coin - thisCoin

def main():
    amountToGetChange = 63
    coins = [1, 5, 10, 21, 25]
    coinsUsed = [0] * (amountToGetChange + 1)
    coinCount = [0] * (amountToGetChange + 1)

    print("Making change for", amountToGetChange, "requires")
    print(MakingChange(coins, amountToGetChange, coinCount, coinsUsed), "coins")
    print("They are:")
    printingCoins(coinsUsed, amountToGetChange)
    print("The used list is as follows:")
    print(coinsUsed)

main()   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MatrixMultiplicationWithDP422
    set output_file "MatrixMultiplicationWithDP.py"

    set template_content '
import sys, time
gk = lambda i, j:str(i) + ',' + str(j)
MAX = sys.maxint
def matrixMultiplicationWithDP(p):
    n = len(p) - 1
    m = {}
    for i in xrange(1, n + 1):
        for j in xrange (i, n + 1):
            m[gk(i, j)] = MAX
    return lookup_chain(m, p, 1, n)

def lookup_chain(m, p, i, j):
    if m[gk(i, j)] < MAX:
        return m[gk(i, j)]
    if i == j:
        m[gk(i, j)] = 0
    else:
        for k in xrange(i, j):
            q = lookup_chain(m, p, i, k) + lookup_chain(m, p, k + 1, j) + p[i - 1] * p[k] * p[j]
            if q < m[gk(i, j)]:
                m[gk(i, j)] = q
    return m[gk(i, j)]

p = [30, 35, 15, 5, 10, 20, 25, 5, 16, 34, 28, 19, 66, 34, 78, 55, 23]
print matrixMultiplicationWithDP(p)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end







function algoP.MaxContigousSumBruteForce423
    set output_file "MaxContigousSumBruteForce.py"

    set template_content '
def MaxContigousSum(A):
	maxSum = 0
	n = len(A)
	for i in range(1, n): 	
		for j in range(i, n):	
			currentSum = 0
			for k in range(i, j + 1):	
				currentSum += A[k]
				if(currentSum > maxSum):
					maxSum = currentSum

	return maxSum;

A = [-2, 3, -16, 100, -4, 5]
print MaxContigousSum(A)
A = [-2, 11, -4, 13, -5, 2 ]
print MaxContigousSum(A)
A = [-15, -23, -476, -3, -292]
print MaxContigousSum(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MaxContigousSumWithDP424
    set output_file "MaxContigousSumWithDP.py"

    set template_content '
def MaxContigousSum(A):
	maxSum = 0
	n = len(A)
	M = [0] * (n + 1)
	if(A[0] > 0): 
		 M[0] = A[0]
	else: M[0] = 0
	for i in range(1, n): 
		if(M[i - 1] + A[i] > 0):
			M[i] = M[i - 1] + A[i]
		else: 	M[i] = 0		

	for i in range(0, n): 
		if(M[i] > maxSum):
			maxSum = M[i]

	return maxSum
	
A = [-2, 3, -16, 100, -4, 5]
print MaxContigousSum(A)
A = [-2, 11, -4, 13, -5, 2 ]
print MaxContigousSum(A)
A = [-15, -23, -476, -3, -292]
print MaxContigousSum(A)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MaxContigousSumWithNSquare425
    set output_file "MaxContigousSumWithNSquare.py"

    set template_content '
def MaxContigousSum(A):
	maxSum = 0
	n = len(A)
	for i in range(1, n): 
		currentSum = 0
		for j in range(i, n):	
			currentSum += A[j]
			if(currentSum > maxSum):
				maxSum = currentSum

	return maxSum;

A = [-2, 3, -16, 100, -4, 5]
print MaxContigousSum(A)
A = [-2, 11, -4, 13, -5, 2 ]
print MaxContigousSum(A)
A = [-15, -23, -476, -3, -292]
print MaxContigousSum(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MaxContigousSumWithoutDPEfficient426
    set output_file "MaxContigousSumWithoutDPEfficient.py"

    set template_content '
def MaxContigousSum(A):
	sumSoFar = sumEndingHere = 0
	n = len(A)
	for i in range(0, n) :
		sumEndingHere = sumEndingHere + A[i]
		if(sumEndingHere < 0):
			sumEndingHere = 0
			continue
		if(sumSoFar < sumEndingHere):
			sumSoFar = sumEndingHere

	return sumSoFar


A = [-2, 3, -16, 100, -4, 5]
print MaxContigousSum(A)
A = [-2, 11, -4, 13, -5, 2 ]
print MaxContigousSum(A)
A = [-15, -23, -476, -3, -292]
print MaxContigousSum(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MaximumRectangleInMatrix427
    set output_file "MaximumRectangleInMatrix.py"

    set template_content '
import sys
def preComputeMatrix(A, n):
	global Aux
	for i in range (0, n):
		for j in range (0, n):
			if(i == 0 and j == 0):
				Aux[i][j] = A[i][j]
			elif(i == 0):
				Aux[i][j] += Aux[i][j - 1] + A[i][j]
			elif(j == 0):
				Aux[i][j] += Aux[i - 1][j] + A[i][j]
			else:
				Aux[i][j] += Aux[i - 1][j] + Aux[i][j - 1] - Aux[i - 1][j - 1] + A[i][j]

def computeSum(A, i1, i2, j1, j2):
	if(i1 == 0 and j1 == 0):
		return Aux[i2][j2]
	elif(i1 == 0):
		return Aux[i2][j2] - Aux[i2][j1 - 1]
	elif(j1 == 0):
		return Aux[i2][j2] - Aux[i1 - 1][j2]
	else:
		return Aux[i2][j2] - Aux[i2][j1 - 1] - Aux[i1 - 1][j2] + Aux[i1 - 1][j1 - 1]

def getMaxMatrix(A, n):
	maxSum = -sys.maxint
	for row1 in range (0, n):
		for row2 in range (0, n):
			for col1 in range (0, n):
				for col2 in range (0, n):
					maxSum = max(maxSum, computeSum(A, row1, row2, col1, col2))
	return maxSum


A = [[-1, -2, -3, -4], [-5, -6, -7, -8 ], [-9, -10, -11, -12] , [-13, -14, -15, -16]]
n = 4
Aux = [[0 for x in range(n)] for x in range(n)]
preComputeMatrix(A, n)
print getMaxMatrix(A, n)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.MaxSumMatrixWithDP428
    set output_file "MaxSumMatrixWithDP.py"

    set template_content '
import sys
def preComputeMatrix(A, n):
	global Aux
	for i in range (0, n):
		for j in range (0, n):
			if(i == 0 and j == 0):
				Aux[i][j] = A[i][j]
			elif(i == 0):
				Aux[i][j] += Aux[i][j - 1] + A[i][j]
			elif(j == 0):
				Aux[i][j] += Aux[i - 1][j] + A[i][j]
			else:
				Aux[i][j] += Aux[i - 1][j] + Aux[i][j - 1] - Aux[i - 1][j - 1] + A[i][j]

def computeSum(A, i1, i2, j1, j2):
	if(i1 == 0 and j1 == 0):
		return Aux[i2][j2]
	elif(i1 == 0):
		return Aux[i2][j2] - Aux[i2][j1 - 1]
	elif(j1 == 0):
		return Aux[i2][j2] - Aux[i1 - 1][j2]
	else:
		return Aux[i2][j2] - Aux[i2][j1 - 1] - Aux[i1 - 1][j2] + Aux[i1 - 1][j1 - 1]

def getSubmatSum(r1, c1, r2, c2) :
	if (r1 == 0 and c1 == 0):
		return Aux[r2][c2]
	if (r1 == 0):
		return Aux[r2][c2] - Aux[r2][c1 - 1]
	if (c1 == 0):
		return Aux[r2][c2] - Aux[r1 - 1][c2]
	return Aux[r2][c2] - Aux[r1 - 1][c2] - Aux[r2][c1 - 1] + Aux[r1 - 1][c1 - 1]
 

def getMaxMatrix(A, n):
	globalmax = 0
	for i in range (0, n):
		for j in range (i, n):
			localmax = 0
			for k in range (0, n):
				localmax = max(localmax + getSubmatSum(i, k, j, k), 0)
				globalmax = max(localmax, globalmax)
	return globalmax

 
A = [[-1, -2, 13, -4], [-5, -6, -7, -8 ], [-9, 10, -11, -12] , [-13, -14, -15, -16]]
n = 4
Aux = [[0 for x in range(n)] for x in range(n)]
preComputeMatrix(A, n)
print getMaxMatrix(A, n)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MaxSumMatrixWithKadane429
    set output_file "MaxSumMatrixWithKadane.py"

    set template_content '
def maxSumWithNoTwoContinuousNumbers(A):
	n = len(A)
	M = [0] * (n + 1)
	M[0] = A[0]
	
	if(A[0] > A[1]): 
		 M[0] = A[0]
	else: M[0] = A[1]
	for i in range(2, n): 
		if(M[i - 1] > M[i - 2] + A[i]):
			M[i] = M[i - 1]
		else: 	M[i] = M[i - 2] + A[i]	

	return M[n - 1]
	
A = [-2, 3, -16, 100, -4, 5]
print maxSumWithNoTwoContinuousNumbers(A)
A = [-2, 11, -4, 13, -5, 2 ]
print maxSumWithNoTwoContinuousNumbers(A)
A = [-15, -23, -476, -3, -292]
print maxSumWithNoTwoContinuousNumbers(A)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MaxSumWithNoTwoContinuousNumbers430
    set output_file "MaxSumWithNoTwoContinuousNumbers.py"

    set template_content '
def maximumRectangleInMatrix(self, matrixInput):
	maxArea = 0
	rows = []
	columns = []
	for i in range(0, len(matrixInput)):
	    rowTemp = []
	    colTemp = []
	    for j in range(0, len(matrixInput[0])):
		rowTemp.append(0)
		colTemp.append(0)
	    rows.append(rowTemp)
	    columns.append(colTemp)
		
	for i in range(len(matrixInput) - 1, -1, -1):
	    for j in range(len(matrixInput[0]) - 1, -1, -1):
		area = 0
		if matrixInput[i][j] == '1':
		    if i == len(matrixInput) - 1:
			rows[i][j] = 1
		    else:
			rows[i][j] = rows[i + 1][j] + 1
		    if j == len(matrixInput[0]) - 1:
			columns[i][j] = 1
		    else:
			columns[i][j] = columns[i][j + 1] + 1
		    area = columns[i][j]
		    minCol = columns[i][j]
		for k in range(1, rows[i][j]):
		    if minCol > columns[i + k][j]:
			minCol = columns[i + k][j]
		    if (k + 1) * minCol > area:
			area = (k + 1) * minCol
		if maxArea < area:
		    maxArea = area
	return maxArea  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MinJumpsDP431
    set output_file "MinJumpsDP.py"

    set template_content '
import sys
def minJumps(A):
	n = len(A)
	jumps = [0] * (n)
	if (n == 0 or A[0] == 0):
		return sys.maxint + 1

	jumps[0] = 0
	for i in range(1, n):
		jumps[i] = sys.maxint + 1
		for j in range(0, i):
			if (i <= j + A[j] and jumps[j] != sys.maxint + 1):
				jumps[i] = min(jumps[i], jumps[j] + 1)
				break
	return jumps[n - 1]

A = [1, 3, 6, 1, 0, 9]
print "Minimum number of jumps to reach end is ", minJumps(A)

A = [2, 3, 1, 1, 4]
print "Minimum number of jumps to reach end is ", minJumps(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.OptimalBinarySearchTree432
    set output_file "OptimalBinarySearchTree.py"

    set template_content '
class OptimalBinarySearchTree(BSTNode):  # For BSTNode, refer Trees chapter
    def __init__(self):
        super(OptimalBinarySearchTree, self).__init__()
        self.num_keys = 0
        self.keys = []
        self.probabilities = []
        self.dummyProbabilities = [1]

    def optimalBST(self):
        n = len(self.keys) + 1
        root_matrix = [[0 for i in xrange(n)] for j in xrange(n)]
        probabilitiesSumMatrix = [[0 for i in xrange(n)] for j in xrange(n)]
        expectedCostMatrix = [[99999 for i in xrange(n)] for j in xrange(n)]
        for i in xrange(1, n):
            probabilitiesSumMatrix[i][i - 1] = self.dummyProbabilities[i - 1]
            expectedCostMatrix[i][i - 1] = self.dummyProbabilities[i - 1]

        for l in xrange(1, n):
            for i in xrange(1, n - l):
                j = i + l - 1
                expectedCostMatrix[i][j] = 99999
                probabilitiesSumMatrix[i][j] = probabilitiesSumMatrix[i][j - 1] + self.probabilities[j] + self.dummyProbabilities[j]
                for r in xrange(i, j + 1):
                    t = expectedCostMatrix[i][r - 1] + expectedCostMatrix[r + 1][j] + probabilitiesSumMatrix[i][j]
                    if t < expectedCostMatrix[i][j]:
                        expectedCostMatrix[i][j] = t
                        root_matrix[i][j] = r
        return root_matrix

    def constructOptimalBST(self):
        root = self.optimalBST()
        n = self.num_keys
        r = root[1][n]
        value = self.keys[r]
        self.insert(value)
        self.constructOptimalSubtree(1, r - 1, r, "left", root)
        self.constructOptimalSubtree(r + 1, n, r, "right", root)

    def constructOptimalSubtree(self, i, j, r, direction, root):
        if i <= j:
            t = root[i][j]
            value = self.keys[t]
            self.insert(value)
            self.constructOptimalSubtree(i, t - 1, t, "left", root)
            self.constructOptimalSubtree(t + 1, j, t, "right", root)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end





function algoP.PartitionSetWithDP433
    set output_file "PartitionSetWithDP.py"

    set template_content '
def findPartition(A):
	# calculate sum of all elements
	sum = 0
	n = len(A)
	for i in range(0, n):
		sum += A[i]
	# If sum is odd, there cannot be two subsets with equal sum
	if (sum % 2 != 0):
		return 0

	Table = [[0 for x in range(n + 1)] for x in range(sum // 2 + 1)]

	# initialize top row as true
	for i in range(0, n):
		Table[0][i] = 1

	# initialize leftmost column, except Table[0][0], as 0
	for i in range(1, sum // 2 + 1):
		Table[i][0] = 0

	# Fill the partition table in bottom up manner
	for i in range(1, sum // 2 + 1):
		for j in range(0, n + 1):
			Table[i][j] = Table[i][j - 1]
			if (i >= A[j - 1]):
				Table[i][j] = Table[i][j] or Table[i - A[j - 1]][j - 1]
	return Table[sum / 2][n]   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.PetrolStationsDPProblem434
    set output_file "PetrolStationsDPProblem.py"

    set template_content '
def canCompleteTour(self, petrol, cost):
	minVal = float("inf")
	minPos = -1
	petrolTillNow = 0
	for i in range(0, len(petrol)):
	    petrolTillNow += petrol[i] - cost[i]
	    if petrolTillNow < minVal:
		minVal = petrolTillNow
		minPos = i
	if petrolTillNow >= 0:
	    return (minPos + 1) % len(petrol)
	return -1    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.RecursiveFibo435
    set output_file "RecursiveFibo.py"

    set template_content '
def Fibo(n):
    if n == 0: return 0
    elif n == 1: return 1
    else: return Fibo(n - 1) + Fibo(n - 2)
	    
Fibo(10)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.RecusriveFunctionDPFromReccurence436
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def f(n) :
	sum = 0
	if(n == 0 or n == 1):
		return 2 
	# Recursive case
	for i in range(1, n):
		sum += 2 * f(i) * f(i - 1)
	return sum


print f(4)



def f2(n) :
	T = [0] * (n + 1)
	T[0] = T[1] = 2
	for i in range(2, n + 1):
		T[i] = 0
		for j in range(1, i):
			T[i] += 2 * T[j] * T[j - 1]

	return T[n]

print f2(4)

def f3(n):
	T = [0] * (n + 1)
	T[0] = T[1] = 2
	T[2] = 2 * T[0] * T[1]
	for i in range(3, n + 1):
		T[i] = T[i - 1] + 2 * T[i - 1] * T[i - 2]
	return T[n]


print f3(4)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SquareBlockWithAllOnesInMatrix437
    set output_file "SquareBlockWithAllOnesInMatrix.py"

    set template_content '
def squareBlockWithAllOnesInMatrix(matrix, ZERO=0):
    nrows, ncols = len(matrix), (len(matrix[0]) if matrix else 0)
    if not (nrows and ncols): return 0  # empty matrix or rows
    Table = [[0] * ncols for _ in xrange(nrows)]
    for i in reversed(xrange(nrows)):  # for each row
        assert len(matrix[i]) == ncols  # matrix must be rectangular
        for j in reversed(xrange(ncols)):  # for each element in the row
            if matrix[i][j] != ZERO:
                Table[i][j] = (1 + min(
                    Table[i][j + 1],  # east
                    Table[i + 1][j],  # south
                    Table[i + 1][j + 1]  # south-east
                    )) if i < (nrows - 1) and j < (ncols - 1) else 1  # edges
    return max(c for rows in Table for c in rows)
	    
matrix = [[0, 1, 1, 0, 1], [1, 1, 0, 1, 0], [0, 1, 1, 1, 0], [1, 1, 1, 1, 0], [1, 1, 1, 1, 1], [0, 0, 0, 0, 0]]
print squareBlockWithAllOnesInMatrix(matrix)  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.StrategyOfCoinsGameWithDP438
    set output_file "StrategyOfCoinsGameWithDP.py"

    set template_content '
coins = [1, 2, 3, 4, 5]
n = len(coins)

V = []
for i in range(n):
	V.append([0] * n)

for i in range(n):
	for j in range(n):
		if i == j:
			V[i][j] = coins[i]
		elif j == i + 1:
			V[i][j] = max(coins[i], coins[j])
		
		# only valid if i < j
		if (i + 2) <= j:
			take_start = V[i + 2][j]
		else:
			take_start = 0
		if (i + 1) <= (j - 1):
			take_end = V[i + 1][j - 1]
		else:
			take_start = 0	   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SubsetSum439
    set output_file "SubsetSum.py"

    set template_content '
def positiveSubsetSum(A, X):
	# preliminary
	if X < 0 or X > sum(A):  # T = sum(A)
		return False

	# algorithm
	subSum = [False] * (X + 1)
	subSum[0] = True
	p = 0
	while not subSum[X] and p < len(A):
		a = A[p]
		q = X
		while not subSum[X] and q >= a:
			if not subSum[q] and subSum[q - a]:
				subSum[q] = True
			q -= 1
		p += 1
	return subSum[X]   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SubsetSum440
    set output_file "SubsetSum2.py"

    set template_content '
def SubsetSum2(A):
	n = len(A)
	K = 0
	for i in range(0, n): 
		K += A[i]
	A.sort()
	T = [0] * (K + 1)
	T[0] = 1
	R = 0
	# process the numbers one by one
	for i in range(0, n): 
		for j in range(R, -1, -1): 
			if(T[j]): 
				T[j + A[i]] = 1
			R = min(K / 2, R + A[i])
	
	return T[K / 2]
	
A = [3, 2, 4, 19, 3, 7, 13, 10, 6, 11]

print SubsetSum2(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SubsetSumWithDP441
    set output_file "SubsetSumWithDP.py"

    set template_content '
def SubsetSum(A, T):
	n = len(A)
	M = [[0 for x in range(T + 1)] for x in range(n + 1)]

	M[0][0] = 0
	for i in range(0, n + 1): 	
		M[i][0] = 0
	for i in range(0, T + 1): 	
		M[0][i] = 0		
	for i in range(1, n + 1): 	
		for j in range(1, T + 1): 	
			M[i][j] = M[i - 1][j] or (M[i - 1][j - A[i]])
	return M[n][T]

A = [3, 2, 4, 19, 3, 7, 13, 10, 6, 11]

print SubsetSum(A, 17)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.longest_common_subsequence_recursive442
    set output_file "tribonacci_series.py"

    set template_content '
def LCS(X, Y):
    if not X or not Y:
        return ""
    x, m, y, n = X[0], X[1:], Y[0], Y[1:]
    if x == y:
        return x+LCS(m, n)
    else:
        # Use key=len to select the maximum string in a list efficiently
        return max(LCS (X, n), LCS(m, Y), key=len)

print "Longest common subsequence: ", LCS('ABCBDAB', 'BDCABA')

def LCS_length(X, Y):
    if not X or not Y:
        return 0
    x, m, y, n = X[0], X[1:], Y[0], Y[1:]
    if x == y:
        return 1+LCS_length(m, n)
    else:
        # Use key=len to select the maximum string in a list efficiently
        return max(LCS_length(X, n), LCS_length(m, Y))

print "Longest common subsequence length: ", LCS_length('ABCBDAB', 'BDCABA')    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.tribonacci_series443
    set output_file "tribonacci_series.py"

    set template_content '
def trib_recursive(n):
    if n == 0: return 0
    elif n == 1: return 1
    elif n == 2: return 2
    else: return trib_recursive(n-1)+ trib_recursive(n-2) + trib_recursive(n-3)
        
print (trib_recursive(10))


def trib_dep(n):
	tribTable = [0 for x in range(n+1)]
	tribTable[0] = 0
	tribTable[1] = 1
	tribTable[2] = 2
	for i in range(3, n+1):
		tribTable[i] = tribTable[i-1] + tribTable[i-2] + tribTable[i-3] 
	return tribTable[n]
      
print(trib_dep(10))	

def trib_iterative(n):
	a, b, c = 0, 1, 2
	for i in range(n):
		a, b, c = b, c, a + b + c
	return a
      
print(trib_iterative(10))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.BinarySearchIterative444
    set output_file "BinarySearchIterative.py"

    set template_content '
def BinarySearchIterative(numbersList, value):
    low = 0
    high = len(numbersList) - 1
    while low <= high: 
        mid = (low + high) // 2
        if numbersList[mid] > value: high = mid - 1
        elif numbersList[mid] < value: low = mid + 1
        else: return mid
    return -1
	
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(BinarySearchIterative(A, 277))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.BinarySearchRecursive445
    set output_file "BinarySearchRecursive.py"

    set template_content '
def BinarySearchRecursive(numbersList, value, low=0, high=-1):
    if not numbersList: return -1
    if(high == -1): high = len(numbersList) - 1
    if low == high:
        if numbersList[low] == value: return low
        else: return -1
    mid = low + (high - low) // 2
    if numbersList[mid] > value: return BinarySearchRecursive(numbersList, value, low, mid - 1)
    elif numbersList[mid] < value: return BinarySearchRecursive(numbersList, value, mid + 1, high)
    else: return mid
	    
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(BinarySearchRecursive(A, 277))    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ClosestPairBruteForce446
    set output_file "ClosestPairBruteForce.py"

    set template_content '
from math import sqrt, pow
 
def distance(a, b):
  return sqrt(pow(a[0] - b[0], 2) + pow(a[1] - b[1], 2))
 
def bruteMin(points, current=float("inf")):
  if len(points) < 2: return current
  else:
    head = points[0]
    del points[0]
    newMin = min([distance(head, x) for x in points])
    newCurrent = min([newMin, current])
    return bruteMin(points, newCurrent)

A = [(12, 30), (40, 50), (5, 1), (12, 10), (3, 4)]
print bruteMin(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.ClosestPairDivideAndConquer447
    set output_file "ClosestPairDivideAndConquer.py"

    set template_content '
from __future__ import generators

def ClosestPairWithDivideAndConquer(L):
	def square(x): 
		return x * x
	def sqdist(p, q): 
		return square(p[0] - q[0]) + square(p[1] - q[1])
	# We use the pair L[0],L[1] as our initial guess at a small distance.
	best = [sqdist(L[0], L[1]), (L[0], L[1])]
	
	# check whether pair (p,q) forms a closer pair than one seen already
	def testpair(p, q):
		d = sqdist(p, q)
		if d < best[0]:
			best[0] = d
			best[1] = p, q
			
	# merge two sorted lists by y-coordinate
	def merge(A, B):
		i = 0
		j = 0
		while i < len(A) or j < len(B):
			if j >= len(B) or (i < len(A) and A[i][1] <= B[j][1]):
				yield A[i]
				i += 1
			else:
				yield B[j]
				j += 1

	# Find closest pair recursively; returns all points sorted by y coordinate
	def recur(L):
		if len(L) < 2:
			return L
		split = len(L) / 2
		splitx = L[split][0]
		L = list(merge(recur(L[:split]), recur(L[split:])))

		E = [p for p in L if abs(p[0] - splitx) < best[0]]
		for i in range(len(E)):
			for j in range(1, 8):
				if i + j < len(E):
					testpair(E[i], E[i + j])
		return L
	
	L.sort()
	recur(L)
	return best[1]

print ClosestPairWithDivideAndConquer([(12, 30), (40, 50), (5, 1), (12, 10), (3, 4)])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ClosestPairPoints448
    set output_file "ClosestPairPoints.py"

    set template_content '
import operator

class Point():
    def __init__(self, x, y):
        """Init"""
        self.x = x
        self.y = y

    def __repr__(self):
        return '<{0}, {1}>'.format(self.x, self.y)


def distance(a, b):
    return abs((a.x - b.x) ** 2 + (a.y - b.y) ** 2) ** 0.5


def closestPoints(points):
    """Time complexity: O(nlogn)"""
    n = len(points)
    if n <= 1:
        print 'Invalid input'
        raise Exception
    elif n == 2:
        return (points[0], points[1])
    elif n == 3:
        # Calc directly
        (a, b, c) = points
        ret = (a, b) if distance(a, b) < distance(a, c) else (a, c)
        ret = (ret[0], ret[1]) if distance(ret[0], ret[1]) < distance(b, c) else (b, c)
        return ret
    else:
        points = sorted(points, key=operator.attrgetter('x'))
        leftPoints = points[ : n / 2]
        rightPoints = points[n / 2 : ]
        
        # Devide and conquer.
        (left_a, left_b) = closestPoints(leftPoints)
        (right_a, right_b) = closestPoints(rightPoints)

        # Find the min distance for leftPoints part and rightPoints part.
        d = min(distance(left_a, left_b), distance(right_a, right_b))
        # Cut the point set into two.
        mid = (points[n / 2].x + points[n / 2 + 1].x) / 2

        # Find all points fall in [mid - d, mid + d]
        midRange = filter(lambda pt : pt.x >= mid - d and pt.x <= mid + d, points)
        # Sort by y axis.
        midRange = sorted(midRange, key=operator.attrgetter('y'))

        ret = None
        localMin = None
        # Brutal force, for each point, find another point and delta y less than d.
        # Calc the distance and update the global var if hits the condition.
        for i in xrange(len(midRange)):
            a = midRange[i]
            for j in xrange(i + 1, len(midRange)):
                b = midRange[j]
                if (not ret) or (abs(a.y - b.y) <= d and distance(a, b) < localMin):
                        ret = (a, b)
                        localMin = distance(a, b)
        return ret



points = [ Point(1, 2), Point(0, 0), Point(3, 6), Point(4, 7), Point(5, 5),
        Point(8, 4), Point(2, 9), Point(4, 5), Point(8, 1), Point(4, 3),
        Point(3, 3)]
print closestPoints(points)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.ExponentialWithDivideAndConquer449
    set output_file "ExponentialWithDivideAndConquer.py"

    set template_content '
import math
def power_brute_force(k, n):
	"""linear power algorithm"""
	x = k
	for i in range(1, n):
	    x *= k
	return x

print power_brute_force(2, 3)

	    

def power_divide_and_conquer(k, n):
"""Divide and Conquer power algorithm"""

	# base case
	if n == 0: 
		return 1

	# base case
	if k == 0:
		return 0

	x = power_divide_and_conquer(a, math.floor(n/2))
	if n % 2 == 0: 
		return x * x
	else: 
		return k * x * x

print power_divide_and_conquer(2, 4)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.find_peak450
    set output_file "find_peak-2d.py"

    set template_content '
import random
import pprint

def peak_find_2d(matrix):
    j = len(matrix[0]) // 2

    # maxvalue is the global maximum in column j
    # rowmax is the row index of the maxvalue
    maxvalue, rowmax = -1, -1
    for row in range(len(matrix)):
        if maxvalue <= matrix[row][j]:
            maxvalue = matrix[row][j]
            rowmax = row

    left, right = 0, 0
    if j > 0:
        left = matrix[rowmax][j - 1]
    if j < len(matrix[0]) - 1:
        right = matrix[rowmax][j + 1]
    if left <= maxvalue >= right:
        return (rowmax, j, maxvalue)
    if left > maxvalue:
        half = []
        for row in matrix:
            half.append(row[:j + 1])
        return peak_find_2d(half)
    if right > maxvalue:
        half = []
        for row in matrix:
            half.append(row[j:])
        return peak_find_2d(half)

def generate_2d_array(n=7, m=7, lower=0, upper=9):
    return [[random.randint(lower, upper) for _ in range(m)] for _ in range(n)]

if __name__ == '__main__':
    matrix = generate_2d_array(upper=9)
    pprint.pprint(matrix)
    x = peak_find_2d(matrix)
    pprint.pprint(x) 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.KthSmallest451
    set output_file "KthSmallest.py"

    set template_content '
CHUNK_SIZE = 5


def kthByExtreme(unsortedList, k):
    for ith in xrange(k):
        kth, unsortedList = removeSmallest(unsortedList)
    return kth


def kthBySorting(unsortedList, k):
    sorted_list = mergesort(unsortedList)
    kth = sorted_list[k - 1]
    return kth


def kthByMedianOfMedian(unsortedList, k):
    if len(unsortedList) <= CHUNK_SIZE:
        return get_kth(unsortedList, k)

    chunks = splitIntoChunks(unsortedList, CHUNK_SIZE)

    medians_list = []

    for chunk in chunks:
        median_chunk = get_median(chunk)
        medians_list.append(median_chunk)

    size = len(medians_list)
    mom = kthByMedianOfMedian(medians_list, size / 2 + (size % 2))
    smaller, larger = splitListByPivot(unsortedList, mom)
    valuesBeforeMom = len(smaller)

    if valuesBeforeMom == (k - 1):
        return mom
    elif valuesBeforeMom > (k - 1):
        return kthByMedianOfMedian(smaller, k)
    else:
        return kthByMedianOfMedian(larger, k - valuesBeforeMom - 1)


def kthByQuickSelect(unsortedList, k):
    pivot = random.choice(unsortedList)
    smaller, larger = splitListByPivot(unsortedList, pivot)
    valuesBeforePivot = len(smaller)
    if valuesBeforePivot == k - 1:
        return pivot
    elif valuesBeforePivot > k - 1:
        return kthByQuickSelect(smaller, k)
    else:
        return kthByQuickSelect(larger, k - valuesBeforePivot - 1)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MaxSumWithDivideAndConquer452
    set output_file "MaxSumWithDivideAndConquer.py"

    set template_content '
def maxSumWithDivideAndConquer(A, low, hi):
	# run MCS algorithm on condensed list
	if low is hi:
		return (low, low, A[low][2])
	else:
		pivot = (low + hi) / 2
		# max subsequence exclusively in left half
		left = maxSumWithDivideAndConquer(A, low, pivot)
		# max subsequence exclusively in right half
		right = maxSub(A, pivot + 1, hi)
		# calculate max sequence left from mid
		leftSum = A[pivot][2]
		temp = 0
		for i in xrange(pivot, low - 1, -1):
			temp += A[i][2]
			if temp >= leftSum:
				l = i
				leftSum = temp
		# calculate max sequence right from mid
		rightSum = A[pivot + 1][2]
		temp = 0
		for i in xrange(pivot + 1, hi + 1):
			temp += A[i][2]
			if temp >= rightSum:
				r = i
				rightSum = temp
		# combine to find max subsequence crossing mid
		mid = (l, r, leftSum + rightSum)
		if left[2] > mid[2] and left[2] > right[2]:
			return left
		elif right[2] > mid[2] and right[2] > left[2]:
			return right
		else:
			return mid
			
list = [100, -4, -3, -10, -5, -1, -2, -2, -0, -15, -3, -5, -2, 70]	

print maxSumWithDivideAndConquer(list, 0, len(list) - 1)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.MergeSort453
    set output_file "MergeSort.py"

    set template_content '
def MergeSort(A):
    if len(A) > 1:
        mid = len(A) // 2
        lefthalf = A[:mid]
        righthalf = A[mid:]
        MergeSort(lefthalf)
        MergeSort(righthalf)
        i = j = k = 0
        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                A[k] = lefthalf[i]
                i = i + 1
            else:
                A[k] = righthalf[j]
                j = j + 1
            k = k + 1

        while i < len(lefthalf):
            A[k] = lefthalf[i]
            i = i + 1
            k = k + 1

        while j < len(righthalf):
            A[k] = righthalf[j]
            j = j + 1
            k = k + 1

A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
MergeSort(A)
print(A)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ShuffleArrayWithDivideAndConquer454
    set output_file "ShuffleArrayWithDivideAndConquer.py"

    set template_content '
def shuffleArray(A, l, r):
	# Array center
	c = l + (r - l) / 2
	q = 1 + l + (c - l) / 2
	if(l == r):  # Base case when the array has only one element
		return
	k = 1
	I = q
	while(i <= c):	
		# Swap elements around the center
		tmp = A[i]	
		A[i] = A[c + k]
		A[c + k] = tmp
		i += 1
		k += 1
	
	ShuffleArray(A, l, c)  # Recursively call the function on the left and right
	ShuffleArray(A, c + 1, r)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.SkyLinesBruteForce455
    set output_file "SkyLinesBruteForce.py"

    set template_content '
def SkyLineBruteForce():
    auxHeights = [0]*1000
    rightMostBuildingRi=0
    p = raw_input("Enter three values:  ") # raw_input() function
    inputValues = p.split()  
    inputCount = len(inputValues)
    while inputCount==3:
        left = int(inputValues[0])
        h = int(inputValues[1])
        right = int(inputValues[2])
        for i in range(left,right-1):
            if(auxHeights[i]<h):
                auxHeights[i]=h;    
        if(rightMostBuildingRi<right):
                    rightMostBuildingRi=right
        
        p = raw_input("Enter three values:  ") # raw_input() function
        inputValues = p.split()  
        inputCount = len(inputValues)

    prev = 0
    for i in range(1,rightMostBuildingRi-1):
        if prev!=auxHeights[i]:
            print i, " ", auxHeights[i]
        prev=auxHeights[i]
    print rightMostBuildingRi, " ", auxHeights[rightMostBuildingRi]

SkyLineBruteForce()   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.SkylineDivideandConquer456
    set output_file "SkylineDivideandConquer.py"

    set template_content '
class SkyLinesDivideandConquer:
    # @param {integer[][]} buildings
    # @return {integer[][]}
    def getSkylines(self, buildings):
        result = []
        if len(buildings) == 0:
            return result
        if len(buildings) == 1:
            result.append([buildings[0][0], buildings[0][2]])
            result.append([buildings[0][1], 0])
            return result
            
        mid = (len(buildings) - 1) / 2
        leftSkyline = self.getSkyline(0, mid, buildings)
        rightSkyline = self.getSkyline(mid + 1, len(buildings)-1, buildings)
        result = self.mergeSkylines(leftSkyline, rightSkyline)
        return result

    def getSkyline(self, start, end, buildings):
        result = []
        if start == end:
            result.append([buildings[start][0], buildings[start][2]])
            result.append([buildings[start][1], 0])
            return result
        mid = (start + end) / 2
        leftSkyline = self.getSkyline(start, mid, buildings)
        rightSkyline = self.getSkyline(mid+1, end, buildings)
        result = self.mergeSkylines(leftSkyline, rightSkyline)
        return result
        
    def mergeSkylines(self, leftSkyline, rightSkyline):
        result = []
        i, j, h1, h2, maxH = 0, 0, 0, 0, 0
        while i < len(leftSkyline) and j < len(rightSkyline):
            if leftSkyline[i][0] < rightSkyline[j][0]:
                h1 = leftSkyline[i][1]
                if maxH != max(h1, h2):
                    result.append([leftSkyline[i][0], max(h1, h2)])
                maxH = max(h1, h2)
                i += 1
            elif leftSkyline[i][0] > rightSkyline[j][0]:
                h2 = rightSkyline[j][1]
                if maxH != max(h1, h2):
                    result.append([rightSkyline[j][0], max(h1, h2)])
                maxH = max(h1, h2)
                j += 1
            else:
                h1 = leftSkyline[i][1]
                h2 = rightSkyline[j][1]
                if maxH != max(h1, h2):
                    result.append([rightSkyline[j][0], max(h1, h2)])
                maxH = max(h1, h2)
                i += 1
                j += 1
        while i < len(leftSkyline):
            result.append(leftSkyline[i])
            i += 1
        while j < len(rightSkyline):
            result.append(rightSkyline[j])
            j += 1
        return result    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.StockStrategyWithDivideAndConquer457
    set output_file "StockStrategyWithDivideAndConquer.py"

    set template_content '
def StockStrategy(A, start, stop):
    n = stop - start
    
    # edge case 1: start == stop: buy and sell immediately = no profit at all
    if n == 0:
        return 0, start, start

    if n == 1:
        return A[stop] - A[start], start, stop
        
    mid = start + n / 2

    # the "divide" part in Divide & Conquer: try both halfs of the array
    maxProfit1, buy1, sell1 = StockStrategy(A, start, mid - 1)
    maxProfit2, buy2, sell2 = StockStrategy(A, mid, stop)

    maxProfitBuyIndex = start
    maxProfitBuyValue = A[start]
    for k in range(start + 1, mid):
        if A[k] < maxProfitBuyValue:
            maxProfitBuyValue = A[k]
            maxProfitBuyIndex = k
            
    maxProfitSellIndex = mid
    maxProfitSellValue = A[mid]
    for k in range(mid + 1, stop + 1):
        if A[k] > maxProfitSellValue:
            maxProfitSellValue = A[k]
            maxProfitSellIndex = k

    # those two points generate the maximum cross border profit
    maxProfitCrossBorder = maxProfitSellValue - maxProfitBuyValue

    # and now compare our three options and find the best one
    if maxProfit2 > maxProfit1:
        if maxProfitCrossBorder > maxProfit2:
            return maxProfitCrossBorder, maxProfitBuyIndex, maxProfitSellIndex
        else:
            return maxProfit2, buy2, sell2
    else:
        if maxProfitCrossBorder > maxProfit1:
            return maxProfitCrossBorder, maxProfitBuyIndex, maxProfitSellIndex
        else:
            return maxProfit1, buy1, sell1

def StockStrategyWithDivideAndConquer(A):
    return StockStrategy(A, 0, len(A) - 1)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.find_peak458
    set output_file "find_peak-2d.py"

    set template_content '
def peak_find_2d(matrix):
    j = len(matrix[0]) // 2

    # maxvalue is the global maximum in column j
    # rowmax is the row index of the maxvalue
    maxvalue, rowmax = -1, -1
    for row in range(len(matrix)):
        if maxvalue <= matrix[row][j]:
            maxvalue = matrix[row][j]
            rowmax = row

    left, right = 0, 0
    if j > 0:
        left = matrix[rowmax][j - 1]
    if j < len(matrix[0]) - 1:
        right = matrix[rowmax][j + 1]
    if left <= maxvalue >= right:
        return (rowmax, j, maxvalue)
    if left > maxvalue:
        half = []
        for row in matrix:
            half.append(row[:j + 1])
        return peak_find_2d(half)
    if right > maxvalue:
        half = []
        for row in matrix:
            half.append(row[j:])
        return peak_find_2d(half)

def generate_2d_array(n=7, m=7, lower=0, upper=9):
    return [[random.randint(lower, upper) for _ in range(m)] for _ in range(n)]

if __name__ == '__main__':
    matrix = generate_2d_array(upper=9)
    pprint.pprint(matrix)
    x = peak_find_2d(matrix)
    pprint.pprint(x)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.finding_single_peak_with_linear_search459
    set output_file "finding_single_peak_with_linear_search.py"

    set template_content '
def find_peaks(A):
	peak = A[0]
	for i in range(1, len(A)-2):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr
			print peak
	if A[len(A)-1] > A[len(A)-2]:
		print A[len(A)-1]

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
print A, "\n"
find_peaks(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.finding_highest_peak_with_linear_search460
    set output_file "finding_highest_peak_with_linear_search.py"

    set template_content '
def find_peak(A):
	max_peak_value = max_peak_index = -1
	peak = A[0]
	index = 0
	for i in range(1, len(A)-1):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr
		if peak > max_peak_value:
			max_peak_value, max_peak_index = peak, index

	if A[len(A)-1] > peak:
		return A[len(A)-1], len(A)-1

	return max_peak_value, max_peak_index

A = [35, 5, 20, 2, 90, 25, 80, 25, 115, 40]
print A, "\n", find_peak(A)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.finding_peak_with_binary_search461
    set output_file "finding_peak_with_binary_search.py"

    set template_content '
def find_peak(A):
    if not A:
        return -1

    left, right = 0, len(A) - 1
    while left + 1 < right:
        mid = left + (right - left) / 2
        if A[mid] < A[mid - 1]:
            right = mid
        elif A[mid] < A[mid + 1]:
            left = mid
        else:
            return mid
    mid = left if A[left] > A[right] else right
    return mid

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
peak = find_peak(A)
print A, "\n", A[peak]    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.finding_single_peak_with_linear_search462
    set output_file "finding_single_peak_with_linear_search.py"

    set template_content '
def find_peak(A):
	peak = A[0]
	for i in range(1, len(A)-2):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr
			return peak

        if len(A)-1 > peak:
            return A[len(A)-1]
 
        return A[index]

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
print A, "\n", find_peak(A)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.greedy_ascent463
    set output_file "greedy_ascent.py"

    set template_content '
import random
import pprint
import operator
def greedy_ascent(matrix):
    j = len(matrix[0]) // 2
    i = len(matrix) // 2

    while True:
      left, right, up, bottom = 0, 0, 0, 0
      if j > 0:
          left = matrix[i][j - 1]
      if j < len(matrix[0]) - 1:
          right = matrix[i][j + 1]
      if i > 0:
          up = matrix[i-1][j]
      if i < len(matrix) - 1:
          bottom = matrix[i+1][j]
      if (left <= matrix[i][j] >= right) and (up <= matrix[i][j] >= bottom):
          return (i, j, matrix[i][j])
      my_list = [left, up, right, bottom]
      max_neighbor_index, max_neighbor_value = max(enumerate(my_list), key=operator.itemgetter(1))
      if max_neighbor_index == 0:
          j = j - 1
      elif max_neighbor_index == 1:
          i = i - 1
      elif max_neighbor_index == 2:
          j = j + 1
      else:
          i = i + 1


def generate_2d_array(n=7, m=7, lower=0, upper=9):
    return [[random.randint(lower, upper) for _ in range(m)] for _ in range(n)]

if __name__ == '__main__':
    matrix = generate_2d_array(upper=9)
    pprint.pprint(matrix)
    x = greedy_ascent(matrix)
    pprint.pprint(x)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Huffman464
    set output_file "Huffman.py"

    set template_content '
from heapq import heappush, heappop, heapify
from collections import defaultdict
 
def HuffmanEncode(characterFrequency):
    """Huffman encode the given dict mapping symbols to weights"""
    heap = [[freq, [sym, ""]] for sym, freq in characterFrequency.items()]
    heapify(heap)
    while len(heap) > 1:
        lo = heappop(heap)
        hi = heappop(heap)
        for pair in lo[1:]:
            pair[1] = '0' + pair[1]
        for pair in hi[1:]:
            pair[1] = '1' + pair[1]
        heappush(heap, [lo[0] + hi[0]] + lo[1:] + hi[1:])
    return sorted(heappop(heap)[1:], key=lambda p: (len(p[-1]), p))
 
inputText = "this is an example for huffman encoding"
characterFrequency = defaultdict(int)
for character in inputText:
    characterFrequency[character] += 1
huffCodes = HuffmanEncode(characterFrequency)
print "Symbol\tFrequency\tHuffman Code"
for p in huffCodes:
    print "%s\t\t\t%s\t\t\t%s" % (p[0], characterFrequency[p[0]], p[1])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LargestTasks465
    set output_file "LargestTasks.py"

    set template_content '
def LargestTasks(Start, n, Finish):
	sort Finish[]
	rearrange Start[] to match
	count = 1
	X[count] = 1
	for i in range(2, n):
		if(Start[i] > Finish[X[count]]):
			count = count + 1
			X[count] = I
	return X[1:count]   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.greedyAscent466
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
import random
import pprint
import operator
def greedy_ascent(matrix):
    j = len(matrix[0]) // 2
    i = len(matrix) // 2

    while True:
      left, right, up, bottom = 0, 0, 0, 0
      if j > 0:
          left = matrix[i][j - 1]
      if j < len(matrix[0]) - 1:
          right = matrix[i][j + 1]
      if i > 0:
          up = matrix[i-1][j]
      if i < len(matrix) - 1:
          bottom = matrix[i+1][j]
      if (left <= matrix[i][j] >= right) and (up <= matrix[i][j] >= bottom):
          return (i, j, matrix[i][j])
      my_list = [left, up, right, bottom]
      max_neighbor_index, max_neighbor_value = max(enumerate(my_list), key=operator.itemgetter(1))
      if max_neighbor_index == 0:
          j = j - 1
      elif max_neighbor_index == 1:
          i = i - 1
      elif max_neighbor_index == 2:
          j = j + 1
      else:
          i = i + 1


def generate_2d_array(n=7, m=7, lower=0, upper=9):
    return [[random.randint(lower, upper) for _ in range(m)] for _ in range(n)]

if __name__ == '__main__':
    matrix = generate_2d_array(upper=9)
    pprint.pprint(matrix)
    x = greedy_ascent(matrix)
    pprint.pprint(x)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.AllPairShortestFloyd467
    set output_file " AllPairShortestFloyd..py"

    set template_content '
INF = 999999999
def printSolution(distGraph):
    string = "inf"
    nodes = distGraph.keys()
    for n in nodes:
        print "%10s" % (n),
    print "  "
    for i in nodes:
        print"%s" % (i),
        for j in nodes:
            if distGraph[i][j] == INF:
                print "%10s" % (string),
            else:
                print "%10s" % (distGraph[i][j]),
        print" "
def floydWarshall(graph):
    nodes = graph.keys()
    distance = {}
    for n in nodes:
        distance[n] = {}
        for k in nodes:
            distance[n][k] = graph[n][k]
    for k in nodes:
        for i in nodes:
            for j in nodes:
                if distance[i][k] + distance[k][j] < distance[i][j]:
                    distance[i][j] = distance[i][k] + distance[k][j]
    printSolution(distance)
if __name__ == '__main__':
    graph = {'A':{'A':0, 'B':6, 'C':INF, 'D':6, 'E':7},
             'B':{'A':INF, 'B':0, 'C':5, 'D':INF, 'E':INF},
             'C':{'A':INF, 'B':INF, 'C':0, 'D':9, 'E':3},
             'D':{'A':INF, 'B':INF, 'C':9, 'D':0, 'E':7},
             'E':{'A':INF, 'B':4, 'C':INF, 'D':INF, 'E':0}
             }
    floydWarshall(graph)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Combinations468
    set output_file "Combinations.py"

    set template_content '
 def combinationByRecursion(elems, s, idx, li):
    for i in range(idx, len(elems)):
        s += elems[i]
        li.append(s)
        # print s, idx
        combinationByRecursion(elems, s, i + 1, li)
        s = s[0:-1]

def combinationByIteration(elems):
    level = ['']
    for i in range(len(elems)):
        nList = []
        for item in level:
            nList.append(item + elems[i])
        level += nList
    return level[1:]

res = []
combinationByRecursion('abc', '', 0, res)
print combinationByIteration('abc')
print combinationByIteration('abc')   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FindNonrepeatedCharacterBruteForce468
    set output_file "FindNonrepeatedCharacterBruteForce.py"

    set template_content '
def findNonrepeated(A):
	n = len(A)
	for i in range(0, n):
		repeated = 0
		for j in range(0, n):
			if(i != j and A[i] == A[j]):
				repeated = 1
		if repeated == 0:
			return A[i]
	return
		
print findNonrepeated("careermonk")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FindNonrepeatedCharacterWithHash469
    set output_file "FindNonrepeatedCharacterWithHash.py"

    set template_content '
def findNonrepeated(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0

	for char in A.lower():
		if table[char] == 1:
			print("the first non repeated character is: %s" % (char))
			return char

	return
 
print findNonrepeated("careermonk")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedCharacterWithHash470
    set output_file "FirstRepeatedCharacterWithHash.py"

    set template_content '
 def firstRepeatedChar(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
			print("the first repeated character is: %s" % (char))
			return char
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0
	return

print firstRepeatedChar("careermonk")   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Kmp471
    set output_file "Kmp.py"

    set template_content '
def prefixTable(pattern):
    m = len(pattern)
    F = [0] * m
    k = 0
    for q in range(1, m):
        while k > 0 and pattern[k] != pattern[q]:
            k = F[k - 1]
        if pattern[k] == pattern[q]:
            k = k + 1
        F[q] = k
    return F

def KMP(text, pattern):
    n = len(text)
    m = len(pattern)
    F = prefixTable(pattern)
    q = 0
    for i in range(n):
        while q > 0 and pattern[q] != text[i]:
            q = F[q - 1]
        if pattern[q] == text[i]:
            q = q + 1
        if q == m:
            return i - m + 1
    return -1
                
print KMP("bacbabababacaca", "ababaca")      
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MinWindowSubstr472
    set output_file "MinWindowSubstr.py"

    set template_content '
def minWindowSubstr(inputStr, pattern):
    if inputStr == '' or pattern == '': return ''
    last_seen = {}
    start = 0; end = len(inputStr) - 1
    pattern = set(pattern)
    # find such a substring ended at i-th character.
    for i, ch in enumerate(inputStr):
        if ch not in pattern: continue
        last_seen[ch] = i
        if len(last_seen) == len(pattern):
            # all chars have been seen
            first = min(last_seen.values())  # **We can use a priority queue, O(logn)
            if i - first + 1 < end - start + 1:
                start = first; end = i
    
    window = inputStr[start:end + 1] if len(last_seen) == len(pattern) else ""
    # print window, len(window)
    return window


print minWindowSubstr("XFDOYEZODEYXNZD", "XYZF")
print minWindowSubstr("XXXYDFYFFHGKOXXFDOPPQDQPFVZZDEZ", "XZD")
print minWindowSubstr("XXXYYYY", "XY")
print minWindowSubstr("", "")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Permutations473
    set output_file "Permutations.py"

    set template_content '
def recursivePermutations(elems, soFar):
    if len(elems) == 0:
        yield soFar
    else:
        for i in range(0, len(elems)):
            for perm in recursivePermutations(elems[0:i] + elems[i + 1:], soFar + [elems[i]]):
                yield perm
		
	
def permutations(elems):
	for perm in recursivePermutations(elems, []):
		print perm		
		
elems = [1, 2, 3]
permutations(elems)

def permutationByIteration(elems):
    level = [elems[0]]
    for i in range(1, len(elems)):
        nList = []
        for item in level:
            nList.append(item + elems[i])
            for j in range(len(item)):
                nList.append(item[0:j] + elems[i] + item[j:])
        level = nList
    return nList
    
elems = [1, 2, 3]
permutations(elems)     
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.PrintInterleavings474
    set output_file "PrintInterleavings.py"

    set template_content '
 def PrintInterleavings(str1, str2):
    perms = []
    if len(str1) + len(str2) == 1:
        return [str1 or str2]
    if str1:
        for item in PrintInterleavings(str1[1:], str2):
            perms.append(str1[0] + item)
    if str2:
        for item in PrintInterleavings(str1, str2[1:]):
            perms.append(str2[0] + item)
    return perms
    
print PrintInterleavings("AB", "CD")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RemoveAdjacentDuplicates475
    set output_file "RemoveAdjacentDuplicates.py"

    set template_content '
def removeAdjacentDuplicates(str):
    stkptr = -1
    i = 0
    size = len(str)
    while i < size:
        if (stkptr == -1 or str[stkptr] != str[i]):
            stkptr += 1
            str[stkptr] = str[i]
            i += 1
        else:
            while i < size and str[stkptr] == str[i]:
                i += 1
            stkptr -= 1
    stkptr += 1
    str = str[0:stkptr]
    print str
removeAdjacentDuplicates(['6', '2', '4', '1', '2', '1', '2', '2', '1'])    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.RemoveCharsFromString476
    set output_file "RemoveCharsFromString.py"

    set template_content '
def RemoveChars(str, removeTheseChars):
	table = {}  # hash
	temp = []
	# set true for all characters to be removed
	for char in removeTheseChars.lower():
		table[char] = 1
	index = 0
	for char in str.lower():
		if char in table:
			continue
		else:
			temp.append(char)
			index += 1
	return "".join(temp)

print RemoveChars("careermonk", "e")

'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ReversingString477
    set output_file "ReversingString.py"

    set template_content '
def ReversingString(str):
	s = list(str)
	end = len(str) - 1
	start = 0
	while (start < end):
		temp = s[start]
		s[start] = s[end]
		s[end] = temp
		start += 1
		end -= 1
		
	return "".join(s)

str = "CareerMonk Publications."
print ReversingString(str)

def reverse(str):
  r = ""
  for c in str:
    r = c + r
  return r
str = "CareerMonk Publications."
print reverse(str)

def ReversingString(str):
	s = list(str)
	end = len(str) - 1
	start = 0
	result = []
	while (start < end):
		s[start], s[end] = s[end], s[start]
		start += 1
		end -= 1

	return "".join(s)

str = "CareerMonk Publications."
print ReversingString(str)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ReverseWordsInSentence478
    set output_file "ReverseWordsInSentence.py"

    set template_content '
def reverseWordsInSentence(self, s):
	result = []
	inWord = False
	for i in range(0, len(s)):
	    if (s[i] == ' ' or s[i] == '\t') and inWord:
		inWord = False
		result.insert(0, s[start:i])
		result.insert(0, ' ')
	    elif not (s[i] == ' ' or s[i] == '\t' or inWord):
		inWord = True
		start = i
	if inWord:
	    result.insert(0, s[start:len(s)])
	    result.insert(0, ' ')
	if len(result) > 0:
	    result.pop(0)
	return ''.join(result)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RobinKarp479
    set output_file "RobinKarp.py"

    set template_content '
def RobinKarp(text, pattern):
        if pattern == None or text == None:
                return -1
        if pattern == "" or text == "":
                return -1

        if len(pattern) > len(text):
                return -1

        hashText = Hash(text, len(pattern))
        hashPattern = Hash(pattern, len(pattern))
        hashPattern.update()

        for i in range(len(text) - len(pattern) + 1):
            if hashText.hashedValue() == hashPattern.hashedValue():
                if hashText.text() == pattern:
                    return i
            hashText.update()

        return -1

class Hash:
        def __init__(self, text, size):
                self.str = text
                self.hash = 0

                for i in xrange(0, size):
                        self.hash += ord(self.str[i])

                self.init = 0
                self.end = size

        def update(self):
                if self.end <= len(self.str) - 1:
                        self.hash -= ord(self.str[self.init])
                        self.hash += ord(self.str[self.end])
                        self.init += 1
                        self.end += 1

        def hashedValue(self):
                return self.hash

        def text(self):
                return self.str[self.init:self.end]		
                
print RobinKarp("3141592653589793", "26")     
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.SmallestWindow480
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def smallestWindow(INPUT, CHARS):
    assert CHARS != ''
    disctionary = defaultdict(int)
    nneg = [0]  # number of negative entries in dictionary
    def incr(c):
        disctionary[c] += 1
        if disctionary[c] == 0:
            nneg[0] -= 1
    def decr(c):
        if disctionary[c] == 0:
            nneg[0] += 1
        disctionary[c] -= 1
    for c in CHARS:
        decr(c)
    minLength = len(INPUT) + 1
    j = 0
    for i in xrange(len(INPUT)):
        while nneg[0] > 0:
            if j >= len(INPUT):
                return minLength
            incr(INPUT[j])
            j += 1
        minLength = min(minLength, j - i)
        decr(INPUT[i])
    return minLength
    
print  smallestWindow("ADOBECODEBANC", "ABC")   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.StrstrBruteForce481
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def strstrBruteForce(str, pattern):
    if not pattern: return 0
    for i in range(len(str) - len(pattern) + 1):
        stri = i; patterni = 0
        while stri < len(str) and patterni < len(pattern) and str[stri] == pattern[patterni]:
            stri += 1
            patterni += 1
        if patterni == len(pattern): return i
    return -1

print strstrBruteForce("xxxxyzabcdabcdefabc", "abc")   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Tst482
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
class TSTNode:
    def __init__ (self, x):
        self.data = x
        self.left = None
        self.eq = None
        self.right = None

# Search
def _search (node, x):
    while node:
        if node.data == x: return node
        if x < node.data:
            node = node.left
        else:
            node = node.right
    return None

# Insert
def _insert (node, x):
    if node is None: return x
    elif x.data == node.data: return node
    elif x.data < node.data:
        node.left = _insert (node.left, x)
    else:
        node.right = _insert (node.right, x)
    return node

# I Find the minimum value
def _searchMin (node):
    if node.left is None: return node.data
    return _searchMin (node.left)

# I want to delete the minimum value
def _deleteMin (node):
    if node.left is None: return node.right
    node.left = _deleteMin (node.left)
    return node

# Delete
def _delete (node, x):
    if node:
        if x == node.data:
            if node.left is None:
                return node.right
            elif node.right is None:
                return node.left
            else:
                node.data = _searchMin (node.right)
                node.right = _deleteMin (node.right)
        elif x < node.data:
            node.left = _delete (node.left, x)
        else:
            node.right = _delete (node.right, x)
    return node

# Traverse
def _traverse (node, leaf):
    if node:
        for x in _traverse (node.left, leaf):
            yield x
        if node.data == leaf:
            yield []
        else:
            for x in _traverse (node.eq, leaf):
                yield [node.data] + x
        for x in _traverse (node.right, leaf):
            yield x


##### Ternary Search Tree #####

class TST:
    def __init__ (self, x=None):
        self.root = TSTNode (None)  # header
        self.leaf = x

    # Search
    def search (self, seq):
        node = self.root
        for x in seq:
            node = _search (node.eq, x)
            if not node: return False
        # Check leaf
        return _search (node.eq, self.leaf) is not None

    # Insert
    def insert (self, seq):
        node = self.root
        for x in seq:
            child = _search (node.eq, x)
            if not child:
                child = TSTNode (x)
                node.eq = _insert (node.eq, child)
            node = child
        # Check leaf
        if not _search (node.eq, self.leaf):
            node.eq = _insert (node.eq, TSTNode (self.leaf))

    # Delete
    def delete (self, seq):
        node = self.root
        for x in seq:
            node = _search (node.eq, x)
            if not node: return False
        # Delete leaf
        if _search (node.eq, self.leaf):
            node.eq = _delete (node.eq, self.leaf)
            return True
        return False

    # Patrol
    def traverse (self):
        for x in _traverse (self.root.eq, self.leaf):
            yield x

    # I ask the data with a common prefix
    def commonPrefix (self, seq):
        node = self.root
        buff = []
        for x in seq:
            buff.append (x)
            node = _search (node.eq, x)
            if not node: return
        for x in _traverse (node.eq, self.leaf):
            yield buff + x

# Simple test
if __name__ == '__main__':
    # Suffix trie
    def makeTST (seq):
        a = TST ()
        for x in xrange (len (seq)):
            a.insert (seq [x:])
        return a

    s = makeTST ('abcabbca')
    for x in s.traverse ():
        print x
    for x in ['a', 'bc']:
        print x
        for y in s.commonPrefix (x):
            print y
    print s.delete ('a')
    print s.delete ('ca')
    print s.delete ('bca')
    for x in s.traverse ():
        print x
    s = makeTST ([0, 1, 2, 0, 1, 1, 2, 0])
    for x in s.traverse ():
        print x   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.Trie483
    set output_file "Trie.py"

    set template_content '
import sys

class TrieNode :

    def __init__(self) :
       self.word = None
       self.letter = [None for i in range(26)]

class Trie :
    def __init__(self):
       self.root = TrieNode()

    def add(self, word):
        self.recAdd(self.root, word, 0, len(word))

    def recAdd(self, r, word, place, length):
        if place == length :
             r.word = word
        else: 
             i = ord(word[place]) - 65
             if r.letter[i] == None:
                  r.letter[i] = TrieNode()
             self.recAdd(r.letter[i], word, place + 1, length)

    def search(self, word):
        self.count = 0
        return [self.recSearch(self.root, word, 0, len(word)), self.count]

    def recSearch(self, r, word, place, length): 
      if  place == length: 
          if r.word == None:
              return None
          else:
              return r
      else :
           i = ord(word[place]) - 65
           if r.letter[i] == None:
                self.count = self.count + 1
                return None
           else: 
                self.count = self.count + 1
                return self.recSearch(r.letter[i], word, place + 1, length)
      

def tester():
    infile = open(sys.argv[1], 'r')
    f = infile.read()
    x = f.split()
    for i in range(len(x)): 
        x[i] = x[i].upper()
    trie = Trie()
    for i in range(len(x)):
        trie.add(x[i])
    w = raw_input("Enter a word ")
    w = w.upper()
    while w != "Q":
         if w != 'Q': 
           print w
           [t, count] = trie.search(w)
           if t == None:
              print "word not in dictionary", "count = ", count
           else:
              print t.word, " found", " count = ", count
           w = raw_input("Enter a word ")
           w = w.upper()
     

if __name__ == '__main__':
    tester()
   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end







function algoP.Tries484
    set output_file "Tries.py"

    set template_content '
class Node(object):
    def __init__(self):
        self.children = {}  # contains a map with child characters as keys and their Node as values

class Trie(object):

    def __init__(self):
        self.root = Node()
        self.root.data = "/" 
	
    def addWord(self, word):
        currentNode = self.root
        i = 0
        # print "adding word '"+ word+"' to trie "
        for c in word:
            # print "adding character " + c
            try:
                currentNode = currentNode.children[c]
		# print "character "+c + " exists"
            except:
                self.createSubTree(word[i:len(word)], currentNode)
                break
            i = i + 1
                
            
    def addCharacter(self, c, children):
        i = 0;
        for existingc in children:
            if existingc > c:
                children.insert(i, c)
                break
            i = i + 1
           
 
    def createSubTree(self, word, node):
        # print "creating subtree for " + word
        currentNode = node
        for c in word:
            currentNode.children[c] = Node()
            currentNode.children[c].data = c
            currentNode.children[c].parent = currentNode
            currentNode = currentNode.children[c]
                         
    def printTree(self):
	nodestack = [self.root]
        while len(nodestack) != 0:
		currentNode = nodestack.pop()
		values = ""
        	for n in currentNode.children:
			temp = currentNode.children[n]
        		values += " " + temp.data
			nodestack.append(temp)

    def getWordList(self, startingCharacters):
	    startNode = self.root
	    for c in startingCharacters:
		    try:
			 startNode = startNode.children[c]
		    except:
	    		return []
	    nodestack = []
	    for child in startNode.children:
	    	nodestack.append(startNode.children[child])
	    words = []
	    currentWord = ""
	    while len(nodestack) != 0:
		    currentNode = nodestack.pop()
		    currentWord += currentNode.data
		    if len (currentNode.children) == 0:
			words.append(startingCharacters + currentWord)
			currentWord = ""

		    for n in currentNode.children:
			    temp = currentNode.children[n]
			    nodestack.append(temp)
	    return words   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.WildcardMatch485
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def wildcardMatch(inputString, pattern):
    if len(pattern) == 0: 
	    return len(inputString) == 0
    # inputString can be empty
    if pattern[0] == '?':
        return len(inputString) > 0 and wildcardMatch(inputString[1:], pattern[1:])
    elif pattern[0] == '*':
        # match nothing or
        # match one and continue, AB* = A*
        return wildcardMatch(inputString, pattern[1:]) or \
               (len(inputString) > 0 and wildcardMatch(inputString[1:], pattern))
    else: 
        return len(inputString) > 0 and inputString[0] == pattern[0] and wildcardMatch(inputString[1:], pattern[1:])
    
    return 0

print wildcardMatch("cc", "c")
print wildcardMatch("cc", "cc")
print wildcardMatch("ccc", "cc")
print wildcardMatch("cc", "*")
print wildcardMatch("cc", "a*")
print wildcardMatch("ab", "?*")
print wildcardMatch("cca", "c*a*b")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.BloomFilter486
    set output_file "BloomFilter.py"

    set template_content '
class BloomFilter:
 def __init__(self, m, k, hashFun):
	self.m = m
	self.vector = [0] * m
	self.k = k
	self.hashFun = hashFun
	self.data = {}  # data structure to store the data
	self.flasePositive = 0

 def insert(self, key, value):
	self.data[key] = value
	for i in range(self.k):
		self.vector[self.hashFun(key + str(i)) % self.m] = 1

 def contains(self, key):
	for i in range(self.k):
		if self.vector[self.hashFun(key + str(i)) % self.m] == 0:
			return False  # the key doesnt exist
	return True  # the key can be in the data set

 def get(self, key):
	if self.contains(key):
		try:
			return self.data[key]  # actual lookup
		except KeyError:
			self.flasePositive += 1
    
import hashlib
def hashFunction(x):
	h = hashlib.sha256(x)  # well use sha256 just for this example
	return int(h.hexdigest(), base=16)

b = BloomFilter(100, 10, hashFunction)
b.insert('this is a test key', 'this is a new value')
print b.get('this is a key')    
print b.get('this is a test key')      
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedCharacterWithHash487
    set output_file "FirstRepeatedCharacterWithHash.py"

    set template_content '
def findNonrepeated(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0

	for char in A.lower():
		if table[char] == 1:
			print("the first non repeated character is: %s" % (char))
			return char

	return
 
print findNonrepeated("careermonk")    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.firstRepeatedChar488
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def firstRepeatedChar(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
			print("the first repeated character is: %s" % (char))
			return char
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0
	return

print firstRepeatedChar("careermonk")   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.HashTable489
    set output_file "HashTable.py"

    set template_content '
class HashTable:
	def __init__(self):
		self.size = 11
		self.slots = [None] * self.size
		self.data = [None] * self.size
		
	def put(self, key, data):
		hashvalue = self.hashfunction(key, len(self.slots))

		if self.slots[hashvalue] == None:
			self.slots[hashvalue] = key
			self.data[hashvalue] = data
		else:
			if self.slots[hashvalue] == key:
				self.data[hashvalue] = data  # replace
			else:
				nextslot = self.rehash(hashvalue, len(self.slots))
				while self.slots[nextslot] != None and self.slots[nextslot] != key:
					nextslot = self.rehash(nextslot, len(self.slots))

				if self.slots[nextslot] == None:
					self.slots[nextslot] = key
					self.data[nextslot] = data
				else:
					self.data[nextslot] = data  # replace

	def hashfunction(self, key, size):
	     return key % size

	def rehash(self, oldhash, size):
		return (oldhash + 1) % size	
	    
	def get(self, key):
		startslot = self.hashfunction(key, len(self.slots))

		data = None
		stop = False
		found = False
		position = startslot
		while self.slots[position] != None and  not found and not stop:
			if self.slots[position] == key:
				found = True
				data = self.data[position]
			else:
				position = self.rehash(position, len(self.slots))
				if position == startslot:
					stop = True
		return data

	def __getitem__(self, key):
		return self.get(key)

	def __setitem__(self, key, data):
		self.put(key, data)	    
	    
H = HashTable()
H[54] = "books"
H[54] = "data"
H[26] = "algorithms"
H[93] = "made"
H[17] = "easy"
H[77] = "CareerMOonk"
H[31] = "Jobs"
H[44] = "Hunting"
H[55] = "King"
H[20] = "Lion"
print H.slots
print H.data
print H[20]   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RemoveDuplicatesWithHash490
    set output_file " RemoveDuplicatesWithHash.py"

    set template_content '
A = [1, 2, 3, 'a', 'b', 'c', 2, 3, 4, 'b', 'c', 'd']
unique = []
helperSet = set()
for x in A:
    if x not in helperSet:
        unique.append(x)
        helperSet.add(x)

print A	
print unique   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FindLargestInArray491
    set output_file "FindLargestInArray.py"

    set template_content '
def FindLargestInArray(A):
    max = 0
    for number in A:
        if number > max:
            max = number
    return max
	
print(FindLargestInArray([2, 1, 5, 234, 3, 44, 7, 6, 4, 5, 9, 11, 12, 14, 13]))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.FindSmallestAndLargestInArray492
    set output_file "FindSmallestAndLargestInArray.py"

    set template_content '
def FindSmallestAndLargestInArray(A):
	max = 0
	min = 0
	for number in A:
		if number > max:
			max = number
		elif number < min:
			min = number

	print("Smallest: %d", min)	
	print("Largest: %d", max)	

FindSmallestAndLargestInArray([2, 1, 5, 234, 3, 44, 7, 6, 4, 5, 9, 11, 12, 14, 13])   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestUsingPartition493
    set output_file " KthSmallestUsingPartition.py"

    set template_content '
import random

def kthSmallest(data, k):
    "Find the nth rank ordered element (the least value has rank 0)."
    data = list(data)
    if not 0 <= k < len(data):
        raise ValueError('not enough elements for the given rank')
    while True:
        pivot = random.choice(data)
        pcount = 0
        under, over = [], []
        uappend, oappend = under.append, over.append
        for elem in data:
            if elem < pivot:
                uappend(elem)
            elif elem > pivot:
                oappend(elem)
            else:
                pcount += 1
        if k < len(under):
            data = under
        elif k < len(under) + pcount:
            return pivot
        else:
            data = over
            k -= len(under) + pcount
	
print(kthSmallest([2, 1, 5, 234, 3, 44, 7, 6, 4, 5, 9, 11, 12, 14, 13], 5))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MedianInStream494
    set output_file "MedianInStream.py"

    set template_content '
class streamMedian: 
	def __init__(self): 
		self.minHeap, self.maxHeap = [], [] 
		self.n = 0   
	def insert(self, num): 
		if self.n % 2 == 0: 
			heapq.heappush(self.maxHeap, -1 * num) 
			self.n += 1 
			if len(self.minHeap) == 0: 
				return 
			if -1 * self.maxHeap[0] > self.minHeap[0]: 
				toMin = -1 * heapq.heappop(self.maxHeap) 
				toMax = heapq.heappop(self.minHeap) 
				heapq.heappush(self.maxHeap, -1 * toMax) 
				heapq.heappush(self.minHeap, toMin) 
			else: 
				toMin = -1 * heapq.heappushpop(self.maxHeap, -1 * num) 
				heapq.heappush(self.minHeap, toMin) 
				self.n += 1   
	def getMedian(self): 
		if self.n % 2 == 0: 
			return (-1 * self.maxHeap[0] + self.minHeap[0]) / 2.0 
		else: 
			return -1 * self.maxHeap[0]   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.MedianOfTwoSortedArrays495
    set output_file "MedianOfTwoSortedArrays.py"

    set template_content '
def findKthSmallest(A, B, k):
    if len(A) > len(B):             A, B = B, A
    # stepsA = (endIndex + beginIndex_as_0) / 2
    stepsA = (min(len(A), k) - 1) / 2
    # stepsB =  k - (stepsA + 1) -1 for the 0-based index
    stepsB = k - stepsA - 2

    # Only array B contains elements
    if len(A) == 0:                 return B[k - 1]
    # Both A and B contain elements, and we need the smallest one
    elif k == 1:                    return min(A[0], B[0])
    # The median would be either A[stepsA] or B[stepsB], while A[stepsA] and 
    # B[stepsB] have the same value.
    elif A[stepsA] == B[stepsB]:    return A[stepsA]
    # The median must be in the right part of B or left part of A
    elif A[stepsA] > B[stepsB]:     return findKthSmallest(A, B[stepsB + 1:], k - stepsB - 1)
    # The median must be in the right part of A or left part of B
    else: return findKthSmallest(A[stepsA + 1:], B, k - stepsA - 1)

    
def findMedianSortedArrays(A, B):    
	# There must be at least one element in these two arrays
	assert not(len(A) == 0 and len(B) == 0)

	if (len(A) + len(B)) % 2 == 1:
	    # There are odd number of elements in total. The median the one in the middle
	    return findKthSmallest(A, B, (len(A) + len(B)) / 2 + 1) * 1.0
	else:
	    # There are even number of elements in total. The median the mean value of the
	    # middle two elements.
	    return (findKthSmallest(A, B, (len(A) + len(B)) / 2 + 1) + \
		     findKthSmallest(A, B, (len(A) + len(B)) / 2)) / 2.0
	
A = [127, 220, 246, 277, 321, 454, 534, 565, 933]
B = [12, 22, 24, 27, 32, 45, 53, 65, 93]	
	
print(findMedianSortedArrays(A, B))   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.PartitionSetWithEqualNotEfficient496
    set output_file "PartitionSetWithEqualNotEfficient.py"

    set template_content '
def subsetSum (A, n, sum):
	if (sum == 0): 
		return 1
	if (n == 0 and sum != 0):
		return 0
	# If last element is greater than sum, then ignore it
	if (A[n - 1] > sum):
		return subsetSum (A, n - 1, sum)

	return subsetSum (A, n - 1, sum) or subsetSum (A, n - 1, sum - A[n - 1])

 
# Returns 1 if A[] can be partitioned in two subsets of equal sum, otherwise 0
def findPartition(A):
	# calculate sum of all elements
	sum = 0
	n = len(A)
	for i in range(0, n):
		sum += A[i]

	# If sum is odd, there cannot be two subsets with equal sum
	if (sum % 2 != 0):
		return 0

	# Find if there is subset with sum equal to half of total sum
	return subsetSum (A, n, sum / 2)
   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.TournamentMethod497
    set output_file "TournamentMethod.py"

    set template_content '
def secondSmallestInArray(A):
	comparisonCount = 0
	# indexes that are to be compared    
	idx = range(0, len(A))

	# list of knockout for all elements
	knockout = [[] for i in idx]
	# play tournaments, until we have only one node left
	while len(idx) > 1:   
	    # index of nodes that win this tournament
	    idx1 = []
	    # nodes in idx odd, if yes then last automatically goes to next round
	    odd = len(idx) % 2
	    # iterate over even indexes, as we do a paired tournament
	    for i in xrange(0, len(idx) - odd, 2):
		firstIndex = idx[i]
		secondIndex = idx[i + 1]
		comparisonCount += 1
		# perform tournament
		if A[firstIndex] < A[secondIndex]:
		    # firstIndex qualifies for next round
		    idx1.append(firstIndex)
		    # add A[secondIndex] to knockout list of firstIndex
		    knockout[firstIndex].append(A[secondIndex])
		else:
		    idx1.append(secondIndex)
		    knockout[secondIndex].append(A[firstIndex])

	    if odd == 1:
		idx1.append(idx[i + 2])
	    # perform new tournament
	    idx = idx1
	print "Smallest element =", A[idx[0]]
	print "Total comparisons =", comparisonCount
	print "Nodes knocked off by the smallest =", knockout[idx[0]], "\n"
	# compute second smallest
	a = knockout[idx[0]]
	if len(a) > 0:
	    v = a[0]
	    for i in xrange(1, len(a)):
		comparisonCount += 1
		if v > a[i]: v = a[i]

	    print "Second smallest element =", v
	    print "Total comparisons =", comparisonCount

A = [2, 4, 3, 7, 3, 0, 8, 4, 11, 1]	
print(secondSmallestInArray(A))	   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.ComplexityWithBreakStatement498
    set output_file " ComplexityWithBreakStatement.py"

    set template_content '
def function(n):
	count = 0
	for i in range(n / 2, n):  # Outer loop execute n/2 times
		j = 1
		count = count + 1
		while j + n / 2 <= n:  # Middle loop has break
			break
			j = j * 2
			count = count + 1

	print (count)

function(20)
    
'
    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.IfElse499
    set output_file "ifelse.py"

    set template_content '
def simple_if_condition(n):
    i = n
    if i == 0: 
        i = i + 1
    print i
        
# O(1)
def if_else_condition(n):
    i = n
    if i == 0: 
        i = i + 1
    elif i == 1:
        i += 2    
    print i  
    
# O(n)
def if_else_condition2(n):
    i = n
    if i > 0: 
        for j in range(1,n):
            print j
    elif i < 0:
        i += 2    
    print i   
    
# O(n^2): Note that if testFunction is executed always
def if_else_condition3(n):
    i = n
    if test_function(n) > 0: 
        for j in range(1,n):
            print j
    elif i < 0:
        i += 2    
    print i   

# O(n)    
def test_function(n):
    for j in range(1,n):
            print j        
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LogLogNComplexity500
    set output_file "LogLogNComplexity.py"

    set template_content '
import math
count = 0
def function(n):
	global count
	if n <= 2:
		return 1
	else: 
		function(round(math.sqrt(n)))
		count = count + 1
		return count

print(function(200))  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.LogSquareNComplexity501
    set output_file "LogSquareNComplexity..py"

    set template_content '
count = 0
def logarithms(n):
	i = 1
	global count
	while i <= n: 
		j = n
		while j > 0:
			j = j // 2
			count = count + 1
		i = i * 2
	return count
	
print(logarithms(10))    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.Logarithm502
    set output_file "BubbleSort_Pass1_Python.py"

    set template_content '
def logarithms(n):
	i = n
	while i >= 1: 
		i = i // 2
		print i	

logarithms(100)


def logarithms2(n):
	i = 1
	while i <= n: 
		i = i * 2
		print i	

logarithms(100)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NCubeLognComplexity503
    set output_file "NCubeLognComplexity.py"

    set template_content '
 def function(n):
	if (n < 2):  # Constant time
		return
	else:
		counter = 0  # Constant time
	for i in range(1, 8):  # This loop executes 8 times with n value half in every call
		function (n / 2)
	for i in range(1, n ** 3):  # This loop executes n^3 times with constant time loop
		counter = counter + 1   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NLogNwithLoops504
    set output_file "NLogNwithLoops.py"

    set template_content '

def function(n):
	count = 0
	if n <= 0:
		return
	for i in range(1, n):
		j = 1
		while j < n:
			j = j + i
			count = count + 1
	print (count)

function(20)

def Function2(n):
	for i in range(1, n):
		j = 1
		while j <= n:
			j = j * 2
			print("*")

Function2(20)

import math
def function(n):
	for i in range(1, n / 3):
		j = 1
		while j <= n:
			j = j + 4
			print("*")

function(20)    
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.NLogSquareComplexity505
    set output_file "NLogSquareComplexity.py"

    set template_content '
def function(n):
	count = 0
	for i in range(n / 2, n):  # Outer loop execute n/2 times
		j = 1
		while j + n / 2 <= n:  # Middle loop executes logn times
			k = 1
			while k <= n:  # Inner loop execute logn times
				count = count + 1
				k = k * 2
			j = j * 2

	print (count)

function(20)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NPower5Complexity506
    set output_file "NPower5Complexity.py"

    set template_content '
def function(n):
    for i in range(1, n):
		j = i
		while j < i * i:
			j = j + 1
			if j % i == 0:
				for k in range(0, j):
          			print(" * ")

function(10) 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.NLogSquareComplexity507
    set output_file "NLogSquareComplexity.py"

    set template_content '
def function(n):
	count = 0
	for i in range(n / 2, n):  # Outer loop execute n/2 times
		j = 1
		while j + n / 2 <= n:  # Middle loop executes n/2 times
			k = 1
			while k <= n:  # Inner loop execute logn times
				count = count + 1
				k = k * 2
			j = j + 1

	print (count)

function(20)  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.NestedLoop508
    set output_file "NLogSquareComplexity.py"

    set template_content '
n = 10
for i in range(1, n):
    for j in range(1, n):
        print 'i value %d and j value %d' % (i, j) 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RecursiveComplexity509
    set output_file "NLogSquareComplexity.py"

    set template_content '
def function(n):
	count = 0
	if n <= 0:
		return
	for i in range(1, n):
		for j in range(1, n):
			count = count + 1
	function(n - 3)
	print (count)

function(20)
  
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RecursiveComplexity510
    set output_file "RecursiveComplexityFNby3.py"

    set template_content '
def function(n):
	if n <= 0:
		return
	for i in range(1, 3):  # This loop executes 3 times with recursive value of n/3  value
 		function(n / 3)
function(20)

def Function2(n):
	if n <= 0:
		return
	for i in range(1, 3):  # This loop executes 3 times with recursive value of n/3  value
 		Function2(n - 1)
Function2(20)

def Function3(n):
	if n <= 0:
		return
	for i in range(1, 3):  # This loop executes 3 times with recursive value of n/3  value
 		Function3(0.8 * n)
Function3(20)
 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.RecursiveNComplexity511
    set output_file "NLogSquareComplexity.py"

    set template_content '
count = 0
def function(n):
	global count
	count = 1
	if n <= 0:
		return
	for i in range(1, n):
		count = count + 1
	n = n // 2;
	function(n)
	print count

function(200)

def Function2(n):
	if n <= 0:
		return
	print ("*")
	Function2(n / 2)
	Function2(n / 2)
	print ("*")

function(20) 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoP.SimpleLoop512
    set output_file "NLogSquareComplexity.py"

    set template_content '
n = 10
# outer loop executed n times
for i in range(1, n):
    # inner loop executes n times
    for j in range(1, n):
        print 'i value %d and j value %d' % (i, j)  # constant time 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoP.SqrtComplextity513
    set output_file "SqrtComplextity.py"

    set template_content '
def function(n):
	i = s = 1
	while  s < n:
		i = i + 1
		s = s + i
		print("*")


function(20)

def Function2(n):
	i = 1
	count = 0
	while i * i < n:
		count = count + 1
		i = i + 1
	print(count)

Function2(20) 
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end





function algoP.CatalanRecursive514
    set output_file "CatalanRecursive.py"

    set template_content '
def CatalanRecursive(n):
	if n == 0:
		return 1
	else:
		count = 0
		for i in range(n):
			count += CatalanRecursive(i) * CatalanRecursive(n - 1 - i)
		return count	

print CatalanRecursive(4)   
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoP.CamptureRegions515
    set output_file "CamptureRegions.py"

    set template_content '
class CamptureRegions:
    # @param board, a 2D array
    # Capture all regions by modifying the input board in-place.
    # Do not return any value.
    def solve(self, board):
        if len(board) == 0:
            return
        for row in range(0, len(board)):
            self.mark(board, row, 0)
            self.mark(board, row, len(board[0]) - 1)
        for col in range(0, len(board[0])):
            self.mark(board, 0, col)
            self.mark(board, len(board) - 1, col)
        
        for row in range(0, len(board)):
            for col in range(0, len(board[0])):
                if board[row][col] == "$":
                    board[row][col] = "O"
                else:
                    board[row][col] = "X"
        
    def mark(self, board, row, col):
        stack = []
        nCols = len(board[0])
        stack.append(row * nCols + col)
        while len(stack) > 0:
            position = stack.pop()
            row = position // nCols
            col = position % nCols
            if board[row][col] != "O":
                continue
            board[row][col] = "$"
            if row > 0:
                stack.append((row - 1) * nCols + col)
            if row < len(board) - 1:
                stack.append((row + 1) * nCols + col)
            if col > 0: 
                stack.append(row * nCols + col - 1)
            if col < nCols - 1:
                stack.append(row * nCols + col + 1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BitSequences516
    set output_file " BitSequences.py"

    set template_content '
def append_at_front(x, L):
    return [x + element for element in L]

def bit_strings(n):
    if n == 0: return []
    if n == 1: return ["0", "1"]
    else:
        return (append_at_front("0", bit_strings(n - 1)) + append_at_front("1", bit_strings(n - 1)))
                
print bit_strings(4)                      

def bit_strings2(n):
    if n == 0: return []
    if n == 1: return ["0", "1"]
    return [ digit + bitstring for digit in bit_strings2(1)
	                         for bitstring in bit_strings2(n - 1)]
print bit_strings2(4)        

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KBitSequences517
    set output_file "KBitSequences.py"

    set template_content '
def range_to_list(k):
	result = []
	for i in range(0, k):
		result.append(str(i))
	return result
	
def base_k_strings(n, k):
	if n == 0: return []
	if n == 1: return range_to_list(k)
	return [ digit + bitstring for digit in base_k_strings(1, k) for bitstring in base_k_strings(n - 1, k)]
print base_k_strings(4, 3) 

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.PathFinder518
    set output_file "CamptureRegions.py"

    set template_content '
def path_finder( Matrix , position , N ):
    # returns list of the paths taken
    if position == ( N - 1 , N - 1 ):
        return [ ( N - 1 , N - 1 ) ]
    x , y = position
    if x + 1 < N and Matrix[x+1][y] == 1:
        a = path_finder( Matrix , ( x + 1 , y ) , N )
        if a != None:
            return [ (x , y ) ] + a

    if y + 1 < N and Matrix[x][y+1] == 1:
        b = path_finder( Matrix , (x , y + 1) , N )
        if  b != None:
            return [ ( x , y ) ] + b

Matrix = [[ 1 , 1 , 1, 1 , 0], [ 0 , 1 , 0, 1 , 0], [ 0 , 1 , 0, 1 , 0], [ 0 , 1 , 0, 0 , 0], [ 1 , 1 , 1, 1 , 1]]

print path_finder(Matrix,(0,0),5)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BinarySearcLastOccurrence519
    set output_file "binarySearchLastOccurrence.py"

    set template_content '
def binarySearchLastOccurrence(A, target):
	if A == None or len(A) == 0:
	    return -1;
	high = len(A) - 1
        low = 0
        m = 0
        lastFound = -1;
        while(1):
            if (low > high): return lastFound
            m = (low + high) / 2
            if (A[m] == target):
		    lastFound = m; low = m + 1
            if (A[m] < target): low = m + 1
            if (A[m] > target): high = m - 1

        return m
	    
A = [5, 6, 9, 12, 15, 21, 21, 34, 45, 57, 70, 84]		
print binarySearchLastOccurrence(A, 21)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BinarySearchFirstOccurrence520
    set output_file "CamptureRegions.py"

    set template_content '
def binarySearchFirstOccurrence(A, target):
	if A == None or len(A) == 0:
	    return -1;
	high = len(A) - 1
        low = 0
        m = 0
        lastFound = -1;
        while(1):
            if (low > high): return lastFound
            m = (low + high) / 2
            if (A[m] == target):
		    lastFound = m; high = m - 1
            if (A[m] < target): low = m + 1
            if (A[m] > target): high = m - 1

        return m
	    
A = [5, 6, 9, 12, 15, 21, 21, 34, 45, 57, 70, 84]		
print binarySearchFirstOccurrence(A, 21)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BinarySearchIterative521
    set output_file "BinarySearchIterative.py"

    set template_content '
def BinarySearchIterative(numbersList, value):
    low = 0
    high = len(numbersList) - 1
    while low <= high: 
        mid = (low + high) // 2
        if numbersList[mid] > value: high = mid - 1
        elif numbersList[mid] < value: low = mid + 1
        else: return mid
    return -1
	
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(BinarySearchIterative(A, 277))

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BinarySearchRecursive522
    set output_file "BinarySearchRecursive.py"

    set template_content '
def BinarySearchRecursive(numbersList, value, low=0, high=-1):
    if not numbersList: return -1
    if(high == -1): high = len(numbersList) - 1
    if low == high:
        if numbersList[low] == value: return low
        else: return -1
    mid = low + (high - low) // 2
    if numbersList[mid] > value: return BinarySearchRecursive(numbersList, value, low, mid - 1)
    elif numbersList[mid] < value: return BinarySearchRecursive(numbersList, value, mid + 1, high)
    else: return mid
	    
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(BinarySearchRecursive(A, 277))  

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CheckDuplicatesBruteForce523
    set output_file "CheckDuplicatesBruteForce.py"

    set template_content '
def CheckDuplicatesBruteForce(A):
	for i in range(0, len(A)):
		for j in range(i + 1, len(A)):
			if(A[i] == A[j]):
				print("Duplicates exist:", A[i])
				return;
	print("No duplicates in given array.")

A = [3, 2, 10, 20, 22, 32]
CheckDuplicatesBruteForce(A)
A = [3, 2, 1, 2, 2, 3]
CheckDuplicatesBruteForce(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CheckDuplicatesNegationTechnique524
    set output_file "CheckDuplicatesNegationTechnique.py"

    set template_content '
import math
def CheckDuplicatesNegationTechnique(A):
	for i in range(0, len(A)):
		if(A[abs(A[i])] < 0):
			print("Duplicates exist:", A[i])
			return
		else:
			A[A[i]] = -A[A[i]]
			
	print("No duplicates in given array.")

A = [3, 2, 1, 2, 2, 3]
CheckDuplicatesNegationTechnique(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckDuplicatesSorting525
    set output_file "CheckDuplicatesSorting.py"

    set template_content '
def CheckDuplicatesSorting(A):
	A.sort()
	for i in range(0, len(A) - 1):
		if(A[i] == A[i + 1]):
			print("Duplicates exist:", A[i])
			return
	print("No duplicates in given array.")

A = [33, 2, 10, 20, 22, 32]
CheckDuplicatesSorting(A)
A = [3, 2, 1, 2, 2, 3]
CheckDuplicatesSorting(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckPairwiseSortedness526
    set output_file "CheckPairwiseSortedness.py"

    set template_content '

def checkPairwiseSorted(A):
	n = len(A)
	if (n == 0 or n == 1):
		return 1
	for i in range(0, n - 1, 2):	
		if (A[i] > A[i + 1]):
			return 0
	return 1


A = [34, 48, 10, 13, 2, 80, 30, 23]
print checkPairwiseSorted(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckWhoWinsTheElection527
    set output_file "CheckWhoWinsTheElection.py"

    set template_content '
def CheckWhoWinsTheElection(A):
	counter = maxCounter = 0
	candidate = A[0]
	for i in range(0, len(A)):
		counter = 1
		for j in range(i + 1, len(A)):
			if(A[i] == A[j]): 
				counter += 1		
		if(counter > maxCounter):
			maxCounter = counter
			candidate = A[i]	
	print candidate, "appeared ", maxCounter, " times"

A = [3, 2, 1, 2, 2, 3]
CheckWhoWinsTheElection(A)
A = [3, 3, 3, 2, 2, 3]
CheckWhoWinsTheElection(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheckWhoWinsTheElectionWithOutSpace528
    set output_file "CheckWhoWinsTheElectionWithOutSpace.py"

    set template_content '
def CheckWhoWinsTheElection(A):
	A.sort()
	counter = maxCounter = 0
	candidate = maxCandidate = 0
	
	for i in range(0, len(A)):
		if(A[i] == candidate):
			counter += 1
		else:
			counter = 1
			candidate = A[i]

		if(counter > maxCounter):
			maxCandidate = A[i]
			maxCounter = counter

	print maxCandidate, "appeared ", maxCounter, " times"

		
A = [2, 3, 2, 1, 2, 2, 3, 2, 2]
CheckWhoWinsTheElection(A)
A = [3, 3, 3, 2, 2, 3]
CheckWhoWinsTheElection(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ExchangeEvenOddList529
    set output_file "ExchangeEvenOddList.py"

    set template_content '
def exchangeEvenOddList(head):
	# initializing the odd and even list headers
	oddList = evenList = None

	# creating tail variables for both the list
	oddListEnd = evenListEnd = None    
	itr = head	

	if(head == None):
		return
	else:
		while(itr != None):
			if(itr.data % 2 == 0):
				if(evenList == NULL):
					# first even node 
					evenList = evenListEnd = itr
				else:
					# inserting the node at the end of linked list                        
					evenListEnd.next = itr                           
					evenListEnd = itr
			else:
				if(oddList == NULL):
					# first odd node 
					oddList = oddListEnd = itr
				else:
					# inserting the node at the end of linked list
					oddListEnd.next = itr                          
					oddListEnd = itr
		itr = itr.next
	evenListEnd.next = oddList
	return head

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FinSUMInTwoSortedArrays530
    set output_file "FinSUMInTwoSortedArrays.py"

    set template_content '
def BinarySearchIterative(numbersList, value):
    low = 0
    high = len(numbersList) - 1
    while low <= high: 
        mid = (low + high) // 2
        if numbersList[mid] > value: high = mid - 1
        elif numbersList[mid] < value: low = mid + 1
        else: return mid
    return -1
		
def findSumInLists(A, B, k):
	A.sort()
	for i in range(0, len(B)):
		c = k - B[i] 	
		if(BinarySearchIterative(A, c) != -1):
			return 1
	return 0	

		
A = [2, 3, 5, 7, 12, 15, 23, 32, 42]
B = [3, 13, 13, 15, 22, 33]
print findSumInLists(A, B, 270)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindInRotatedSortedArray531
    set output_file "FindInRotatedSortedArray.py"

    set template_content '
def findInRotatedSortedArray(A, target):
	left = 0
	right = len(A) - 1
	while left <= right:
	    mid = (left + right) / 2
	    if A[mid] == target:
		return mid
	    if A[mid] >= A[left]:
		if A[left] <= target < A[mid]:
		    right = mid - 1
		else:
		    left = mid + 1
	    else:
		if A[mid] < target <= A[right]:
		    left = mid + 1
		else:
		    right = mid - 1
	return -1
	
A = [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14]		

print findInRotatedSortedArray(A, 5)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindInRotatedSortedArrayWithRecursion532
    set output_file "FindInRotatedSortedArrayWithRecursion.py"

    set template_content '
def findInRotatedSortedArrayWithRecursion(A, target):
	if A == None or len(A) == 0:
	    return -1;
	low = 0;
	high = len(A) - 1
	return findWithRecursion(A, target, low, high)

def findWithRecursion(A, target, low, high):
	if low > high:
	    return -1
	mid = (low + high) / 2

	if A[mid] == target:
	    return mid
	if A[low] < A[mid]:
	    if A[low] <= target < A[mid]:
		return findWithRecursion(A, target, low, mid - 1)
	    return findWithRecursion(A, target, mid + 1, high)
	elif A[low] > A[mid]:
	    if A[mid] < target <= A[high]:
		return findWithRecursion(A, target, mid + 1, high)
	    return findWithRecursion(A, target, low, mid - 1)
	else:
	    if A[mid] != A[high]:
		return findWithRecursion(A, target, mid + 1, high)
	    result = findWithRecursion(A, target, low, mid - 1)
	    if result != -1:
		return result
	    return findWithRecursion(A, target, mid + 1, high)
	    
A = [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14]		
print findInRotatedSortedArrayWithRecursion(A, 5)	

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMinimumInRotatedSortedArray533
    set output_file "FindMinimumInRotatedSortedArray..py"

    set template_content '
def findMinimumInRotatedSortedArray(A):
        mid, low, high = 0, 0, len(A) - 1
        while A[low] >= A[high]:
            if high - low <= 1:
                return A[high], high
            mid = (low + high) >> 1
            if A[mid] == A[low]:
                low += 1
            elif A[mid] > A[low]:
                low = mid
            elif A[mid] == A[high]:
                high -= 1
            else:
                high = mid
        return A[low], low

A = [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14]	
print findMinimumInRotatedSortedArray(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMissingNumberBruteForce534
    set output_file "main.py"

    set template_content '
def FindMissingNumber(A):
	n = len(A)
	for i in range(1, n + 1):
		found = 0
		for j in range(0, n):
			if(i == A[j]):
				found = 1
		if found == 0:
			print "Missing number is ", i

A = [8, 2, 1, 4, 6, 5, 7, 9]
FindMissingNumber(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMissingNumberEfficientWithXOR535
    set output_file "main.py"

    set template_content '
def FindMissingNumber(A):
	n = len(A)
	X = 0
	for i in range(1, n + 2):
		X = X ^ i
	for i in range(0, n):
		X = X ^ A[i]
	print "Missing number is ", X
A = [8, 2, 1, 4, 6, 5, 7, 9]
FindMissingNumber(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMissingNumberFromGivenRange536
    set output_file "main.py"

    set template_content '
import sys
def findMissingNumberFromGivenRange(A, X, Y):
	n = len(A)
	S = [-sys.maxint] * (n)
	missingNum = -sys.maxint
	for i in range(0, n):
		S[A[i] - X] = A[i]
	for i in range(0, n):
		if(S[i] == -sys.maxint):
			missingNum = i + X
			break
	return missingNum		
A = [10, 16, 14, 12, 11, 10, 13 , 15, 17, 12, 19]
print findMissingNumberFromGivenRange(A, 10, 20)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindNonrepeatedCharacterBruteForce537
    set output_file "main.py"

    set template_content '
def findNonrepeated(A):
	n = len(A)
	for i in range(0, n):
		repeated = 0
		for j in range(0, n):
			if(i != j and A[i] == A[j]):
				repeated = 1
		if repeated == 0:
			return A[i]
	return
		
print findNonrepeated("careermonk")


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindNonrepeatedCharacterWithHash538
    set output_file "FindNonrepeatedCharacterWithHash.py"

    set template_content '
def findNonrepeated(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0

	for char in A.lower():
		if table[char] == 1:
			print("the first non repeated character is: %s" % (char))
			return char

	return
 
print findNonrepeated("careermonk")


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindTwoRepeatingNumbersWithXOR539
    set output_file "FindTwoRepeatingNumbersWithXOR.py"

    set template_content '
def findTwoRepeatingNumbersWithXOR (A):
	XOR = A[0]
	X = Y = 0
	n = len(A) - 2
	for i in range(1, len(A)):                   
		XOR ^= A[i]

	for i in range(1, n + 1):
		XOR ^= i   
 	rightMostSetBitNo = XOR & ~(XOR - 1)
	for i in range(0, len(A)):
		if(A[i] & rightMostSetBitNo):
			X = X ^ A[i]    
		else:	Y = Y ^ A[i]
	for i in range(1, n + 1):
		if(i & rightMostSetBitNo):
			X = X ^ i
		else:	Y = Y ^ i
 	print X, Y

A = [4, 2, 4, 5, 2, 3, 1]
findTwoRepeatingNumbersWithXOR(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedChar540
    set output_file "FirstRepeatedChar.py"

    set template_content '
def FirstRepeatedChar (str):
	size = len(str)
	count = [0] * (256)
	for i in range(size):
		if(count[ord(str[i])] == 1):
			print  str[i]
			break
		else:    
			count[ord(str[i])] += 1
	if(i == size):
		print "No Repeated Characters"
	return 0

FirstRepeatedChar(['C', 'a', 'r', 'e', 'e', 'r', 'm', 'o', 'n', 'k'])


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedCharacterWithHash541
    set output_file "FirstRepeatedCharacterWithHash.py"

    set template_content '
def firstRepeatedChar(A):
	table = {}  # hash
	for char in A.lower():
		if char in table:
			table[char] += 1
			print("the first repeated character is: %s" % (char))
			return char
		elif char != " ":
			table[char] = 1
		else:
			table[char] = 0
	return

print firstRepeatedChar("careermonk")

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FirstRepeatedElementAmongRepeatedElementsWithHash542
    set output_file "FirstRepeatedElementAmongRepeatedElementsWithHash.py"

    set template_content '
def FirstRepeatedElementAmongRepeatedElementsWithHash(A):
	table = {}  # hash
	max = 0
	for element in A:
		if element in table and table[element] == 1:
			table[element] = -2
		elif element in table and table[element] < 0:
			table[element] -= 1			
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0

	for element in A:
		if table[element] < max:
			max = table[element]
			maxRepeatedElement = element

	print maxRepeatedElement, "repeated for ", abs(max), " times"
 
A = [3, 2, 1, 1, 2, 1, 2, 5, 5]
FirstRepeatedElementAmongRepeatedElementsWithHash(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.frequencyCounter543
    set output_file "frequencyCounter.py"

    set template_content '
def frequencyCounter(A):
	table = {}  # hash
	for element in A:
		if element in table:
			table[element] += 1
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0
	for element in A:
		print element, "--->", table[element]
 
A = [10, 1, 9, 4, 7, 6, 5, 22, 13, 2, 1]
frequencyCounter(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FrequencyCounterWithoutExtraSpace544
    set output_file "FrequencyCounterWithoutExtraSpace.py"

    set template_content '
def frequencyCounter(A):
	pos = 0
	n = len(A)
	while(pos < n):
		expectedPos = A[pos] - 1
		if(A[pos] > 0 and A[expectedPos] > 0):
			A[pos], A[expectedPos] = A[expectedPos], A[pos]
			A[expectedPos] = -1
		elif(A[pos] > 0):
			A[expectedPos] -= 1
			A[pos] = 0
			pos += 1
		else:
			pos += 1
	for i in range(1, n):
		print  i + 1 , "--->", abs(A[i])

A = [10, 1, 9, 4, 7, 6, 5, 5, 1, 2, 1]
frequencyCounter(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InterpolationSearch545
    set output_file "InterpolationSearch.py"

    set template_content '
def InterpolationSearch(numbersList, value):
    low = 0
    high = len(numbersList) - 1
    while numbersList[low] <= value and numbersList[high] >= value:
        mid = (low + ((value - numbersList[low]) * (high - low))
               / (numbersList[high] - numbersList[low]))
        if numbersList[mid] < value:
            low = mid + 1
        elif numbersList[mid] < value:
            high = mid - 1
        else:
            return mid
    if numbersList[low] == value:
        return low
    return None

A = [-30,-16,-9,3,10,11,18,22,54,84,105]
print InterpolationSearch(A, -9)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LinearSearch546
    set output_file "LinearSearch.py"

    set template_content '
key = "Data Structure and Algorithmic Thinking with Python"
 
i = 0
while i < len(name_list) and name_list[i] != key:
    i += 1
 
if i < len(name_list):
    print("The name is at position", i)
else:
    print("The name was not in the list.")


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MajorityElement547
    set output_file "CamptureRegions.py"

    set template_content '
def majorityElement(A):
	count = 0
	element = -1
	n = len(A)
	if n == 0:
		return
	for i in range(0, n - 1):
		if(count == 0) :
			element = A[i]
			count = 1
		elif(element == A[i]):
			count += 1
		else:
			count -= 1
	return element

A = [7, 3, 2, 3, 3, 6, 3	]
print majorityElement(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MatrixSortedFind548
    set output_file "MatrixSortedFind.py"

    set template_content '
def matrixFind(matrix, value):
    m = len(matrix)
    if m == 0:
        return 0

    n = len(matrix[0])
    if n == 0:
        return 0

    i = 0
    j = n - 1

    while i < m and j >= 0:
        if matrix[i][j] == value:
            return 1

        elif matrix[i][j] < value:
            i = i + 1

        else:
            j = j - 1

    return 0


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxIndexDifferenceBruteForce549
    set output_file "MaxIndexDifferenceBruteForce.py"

    set template_content '
def maxIndexDiff(A):
	maxDiff = -1
	maxJ = maxI = -1
	n = len(A)
	for i in range(0, n):
		j = n - 1
		while(j > i):
			if(A[j] > A[i] and maxDiff < (j - i)):
				maxDiff = j - i
				maxI = i
				maxJ = j
			j -= 1
	return maxDiff, maxI, maxJ
	
A = [34, 8, 10, 3, 2, 80, 30, 33, 1]
print maxIndexDiff(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxIndexDifferenceEfficient550
    set output_file "MaxIndexDifferenceEfficient.py"

    set template_content '
def maxIndexDiff(A):
	n = len(A)
	LeftMins = [0] * (n)
	RightMaxs = [0] * (n)
	LeftMins[0] = A[0]
	for i in range(1, n):
		LeftMins[i] = min(A[i], LeftMins[i - 1])

	RightMaxs[n - 1] = A[n - 1]
	for j in range(n - 2, -1, -1):
		RightMaxs[j] = max(A[j], RightMaxs[j + 1])

	i = 0; j = 0; maxDiff = -1;
	while (j < n and i < n):
		if (LeftMins[i] < RightMaxs[j]):
			maxDiff = max(maxDiff, j - i)
			j = j + 1
		else:
			i = i + 1
	return maxDiff

A = [34, 8, 10, 3, 2, 80, 30, 33, 1]
print maxIndexDiff(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxRepititionsBruteForce551
    set output_file "MaxRepititionsBruteForce..py"

    set template_content '
def MaxRepititionsBruteForce(A):
	n = len(A)
	count = max = 0
	for i in range(0, n):
		count = 1
		for j in range(0, n):
			if(i != j and A[i] == A[j]):
				count += 1
		if max < count:
			max = count
			maxRepeatedElement = A[i]
	print maxRepeatedElement, "repeated for ", max

A = [3, 2, 1, 2, 2, 3, 2, 1, 3]
MaxRepititionsBruteForce(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxRepititionsEfficient552
    set output_file "MaxRepititionsEfficient.py"

    set template_content '
def MaxRepititionsEfficient(A):
	n = len(A)
	max = 0
	for i in range(0, len(A)):
		A[A[i] % n] += n
	for i in range(0, len(A)):
		 if(A[i] / n > max): 
			max = A[i] / n
			maxIndex = i
	print maxIndex, "repeated for ", max, " times"
A = [3, 2, 2, 3, 2, 2, 2, 3, 3]
MaxRepititionsEfficient(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxRepititionsWithHash553
    set output_file "MaxRepititionsWithHash.py"

    set template_content '
def MaxRepititionsWithHash(A):
	table = {}  # hash
	max = 0
	for element in A:
		if element in table:
			table[element] += 1
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0

	for element in A:
		if table[element] > max:
			max = table[element]
			maxRepeatedElement = element

	print maxRepeatedElement, "repeated for ", max, " times"
 
A = [3, 2, 1, 3, 2, 3, 2, 3, 3]
MaxRepititionsWithHash(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxRepititionsWithSort554
    set output_file "MaxRepititionsWithSort.py"

    set template_content '
def MaxRepititionsWithSort(A):
	A.sort()
	print A
	j = 0
	count = max = 1
	element = A[0]
	for i in range(1, len(A)):
		if (A[i] == element):
			count += 1
			if count > max:
				max = count
				maxRepeatedElement = element
		else:
			count = 1
			element = A[i]
			
	print maxRepeatedElement, "repeated for ", max

A = [3, 2, 1, 3, 2, 3, 2, 3, 3]
MaxRepititionsWithSort(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MoveSpacesToBegin555
    set output_file "moveSpacesToBegin.py"

    set template_content '
def moveSpacesToBegin(A):
     i = len(A) - 1
     datalist = list(A)
     j = i
     for j in range(i, -1, -1):
          if(not datalist[j].isspace()):
		temp = datalist[i]
		datalist[i] = datalist[j]
		datalist[j] = temp
		i -= 1
     A = ''.join(datalist)
     return A
A = "move these spaces to beginning"
print A, "\n", moveSpacesToBegin(A)

def moveSpacesToBegin2(A):
	n = len(A) - 1
	datalist = list(A)
	count = i = n
	for j in range(i, 0, -1):
		if(not datalist[j].isspace()):
			datalist[count] = datalist[j]
			count -= 1
			
	while(count >= 0):
		datalist[count] = ' '
		count -= 1
	A = ''.join(datalist)
	return A
A = "move these spaces to beginning"
print A, "\n", moveSpacesToBegin2(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MoveSpacesToEnd556
    set output_file "CamptureRegions.py"

    set template_content '
def moveSpacesToEnd(A):
	n = len(A) - 1
	datalist = list(A)
	count = i = 0
	for i in range(i, n):
		if(not datalist[i].isspace()):
			datalist[count] = datalist[i]
			count += 1
			
	while(count <= n):
		datalist[count] = ' '
		count += 1
	A = ''.join(datalist)
	return A
A = "move these spaces to beginning"
print A, "\n", moveSpacesToEnd(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MoveZerosToEnd557
    set output_file "moveZerosToEnd.py"

    set template_content '
def moveZerosToEnd(A):
	i = j = 0
	while (i <= len(A) - 1):  
		if (A[i] != 0):
			A[j] = A[i]
			j += 1
		i += 1
	while (j <= len(A) - 1):   
		A[j] = 0
		j += 1
	return A
A = [7, 0, 0, 3, 0, 2, 3, 3, 6, 3]
print A, "\n", moveZerosToEnd(A)

def mySwap(A, i, j):
	temp = A[i]
	A[i] = A[j]
	A[j] = temp

def moveZerosToEnd2(A):
	i = j = 0
	while (i <= len(A) - 1):  
		if (A[i] != 0):
			mySwap(A, j, i)
			j += 1
		i += 1
	return A

A = [7, 0, 0, 3, 0, 2, 3, 3, 6, 3]
print A, "\n", moveZerosToEnd2(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionSetWithEqualNotEfficient558
    set output_file "PartitionSetWithEqualNotEfficient.py"

    set template_content '
def subsetSum (A, n, sum):
	if (sum == 0): 
		return 1
	if (n == 0 and sum != 0):
		return 0
	# If last element is greater than sum, then ignore it
	if (A[n - 1] > sum):
		return subsetSum (A, n - 1, sum)

	return subsetSum (A, n - 1, sum) or subsetSum (A, n - 1, sum - A[n - 1])

 
# Returns 1 if A[] can be partitioned in two subsets of equal sum, otherwise 0
def findPartition(A):
	# calculate sum of all elements
	sum = 0
	n = len(A)
	for i in range(0, n):
		sum += A[i]

	# If sum is odd, there cannot be two subsets with equal sum
	if (sum % 2 != 0):
		return 0

	# Find if there is subset with sum equal to half of total sum
	return subsetSum (A, n, sum / 2)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PrintTwoRepeatedElementsBruteForce559
    set output_file "PrintTwoRepeatedElementsBruteForce.py"

    set template_content '
def PrintTwoRepeatedElementsBruteForce(A):
	n = len(A)
	for i in range(0, n):
		for j in range(i + 1, n):
			if(A[i] == A[j]):
				print A[i]


A = [3, 5, 7, 4, 2, 4, 2, 1, 9]
PrintTwoRepeatedElementsBruteForce(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PrintTwoRepeatedElementsHash560
    set output_file " PrintTwoRepeatedElementsHash.py"

    set template_content '
def PrintTwoRepeatedElementsHash(A):
	table = {}  # hash
	for element in A:
		if element in table:
			table[element] += 1
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0

	for element in A:
		if table[element] == 2:
			print element
			
A = [3, 5, 7, 4, 2, 4, 2, 1, 9]
PrintTwoRepeatedElementsHash(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PrintTwoRepeatedElementsHash561
    set output_file "PrintTwoRepeatedElementsHash2.py"

    set template_content '
def PrintTwoRepeatedElementsHash2(A):
	table = {}  # hash
	for element in A:
		# print element
		if element in table and table[element] == 1:
			print element
			table[element] += 1
		elif element in table:
			table[element] += 1	
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0
A = [3, 5, 7, 4, 2, 4, 2, 1, 9]
PrintTwoRepeatedElementsHash2(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.rearrangeArrayElementsA1B1A2B2562
    set output_file "rearrangeArrayElementsA1B1A2B2.py"

    set template_content '
def rearrangeArrayElementsA1B1A2B2(A):
	n = len(A) // 2
	i = 0; 	q = 1; k = n
	while (i < n):
		
		j = k
		while j > i + q:
			A[j], A[j - 1] = A[j - 1], A[j]
			j -= 1
		i += 1; k += 1; q += 1

A = [1, 3, 5, 6, 2, 4, 6, 8]
rearrangeArrayElementsA1B1A2B2(A)
print A


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveAdjacentRepeats563
    set output_file "removeAdjacentRepeats.py"

    set template_content '
def removeAdjacentRepeats(nums):
  i = 1
  while i < len(nums):    
    if nums[i] == nums[i - 1]:
      nums.pop(i)
      i -= 1  
    i += 1
  return nums
  
nums = ["A", "B", "C", "C", "C", "C", "B", "A"]  
print removeAdjacent(nums)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RemoveDuplicatesBruteForce564
    set output_file "RemoveDuplicatesBruteForce..py"

    set template_content '

def RemoveDuplicates(A):
    m = 0
    for i in range(0, len(A)):
        if (not elem(A, m, A[i])):
            A[m] = A[i]
	    m += 1 
    return m

def elem(A, n, e):
    for i in range(0, n):
        if (A[i] == e):
            return 1 
    return 0

A = [54, 26, 93, 54, 77, 31, 44, 55, 20]
RemoveDuplicates(A)
print A

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.RemoveCharsFromString565
    set output_file "RemoveCharsFromString.py"

    set template_content '
def RemoveChars(str, removeTheseChars):
	table = {}  # hash
	temp = []
	# set true for all characters to be removed
	for char in removeTheseChars.lower():
		table[char] = 1
	index = 0
	for char in str.lower():
		if char in table:
			continue
		else:
			temp.append(char)
			index += 1
	return "".join(temp)

print RemoveChars("careermonk", "e")

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RemoveDuplicatesWithHash566
    set output_file "RemoveDuplicatesWithHash.py"

    set template_content '
A = [1, 2, 3, 'a', 'b', 'c', 2, 3, 4, 'b', 'c', 'd']
unique = []
helperSet = set()
for x in A:
    if x not in helperSet:
        unique.append(x)
        helperSet.add(x)

print A	
print unique

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.RemoveDuplicatesWithSort567
    set output_file "RemoveDuplicatesWithSort.py"

    set template_content '
def RemoveDuplicates(A):
	A.sort()
	print A
	j = 0
	for i in range(1, len(A)):
		if (A[j] != A[i]):
			j += 1
			A[j] = A[i]
			
			
	print A[:j + 1]

A = [54, 31, 93, 54, 77, 31, 44, 55, 93]
RemoveDuplicates(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.replaceWithNearestGreaterElement568
    set output_file "replaceWithNearestGreaterElement.py"

    set template_content '
def replaceWithNearestGreaterElement(A):
	nextNearestGreater = float("-inf")
	i = j = 0
	for i in range(0, len(A) - 1):
		nextNearestGreater = float("-inf")
		for j in range(i + 1, len(A)):
			if A[i] < A[j]:
				nextNearestGreater = A[j]
				break
		print("For the element " + str(A[i]) + ", " + str(nextNearestGreater) + " is the nearest greater element")

replaceWithNearestGreaterElement([6, 2, 4, 1, 2, 1, 2, 2, 10])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SeparateODDAndEvenNumbers569
    set output_file "SeparateODDAndEvenNumbers.py"

    set template_content '
def separateEvenOdd(A):
	left = 0; right = len(A) - 1
	while(left < right):
		while(A[left] % 2 == 0 and left < right):
			left += 1
		while(A[right] % 2 == 1 and left < right):
			right -= 1
		if(left < right):
			A[left], A[right] = A[right], A[left]
			left += 1
			right -= 1
A = [12, 34, 45, 9, 8, 90, 3]
separateEvenOdd(A)
print A


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SeparateZerosAndOnes570
    set output_file "CamptureRegions.py"

    set template_content '
def separateZerosAndOnes(A):
	left = 0; right = len(A) - 1
	while(left < right):
		while(A[left] == 0 and left < right):
			left += 1
		while(A[right] == 1 and left < right):
			right -= 1
		if(left < right):
			A[left], A[right] = A[right], A[left]
			left += 1
			right -= 1
A = [1, 1, 0, 0, 1, 0, 1]
separateZerosAndOnes(A)
print A

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.shuffleArray571
    set output_file "shuffleArray.py"

    set template_content '
import random
def shuffleArray(A):
	n = len(A)
	i = n - 1
	while i > 0:
		j = int((random.random()) % (i + 1))
		tmp = A[j - 1];A[j - 1] = A[j];A[j] = tmp
		i -= 1

A = [1, 3, 5, 6, 2, 4, 6, 8]
shuffleArray(A)
print A


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.singleNumber572
    set output_file "main.py"

    set template_content '
def singleNumber(A):
	i = res = 0
 	for i in range (0, len(A)): 
		res = res ^ A[i]
	return res

A = [7, 3, 6, 3, 3, 6, 7	]
print singleNumber(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Sorting012sDutchFlagProblem573
    set output_file "main.py"

    set template_content '
def sorting012sDutchFlagProblem(A):
    n = len(A)
    zero = 0; two = n - 1
    # Write 1 at the beginning; 2 at the end.
    cur = 0
    while cur <= two:
        print cur, A, zero, two
        if A[cur] == 0:
            if cur > zero:
                A[zero], A[cur] = A[cur], A[zero]
                zero += 1
            else:  # TRICKY PART.
                # cur == zero and A[cur] == A[zero] == 0
                cur += 1
                zero += 1
        
        elif A[cur] == 2:
            if cur < two:
                A[two], A[cur] = A[cur], A[two]
                two -= 1
            else:
                break
        else:
            cur += 1
    print A, '\n'
    return A

if __name__ == '__main__':
    sorting012sDutchFlagProblem([2, 0, 1, 0, 2, 1, 2, 2, 1, 1])
    sorting012sDutchFlagProblem([2, 1, 2, 1, 2, 0])
    sorting012sDutchFlagProblem([0, 0, 1, 2, 2, 2, 0, 0, 0])

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.threeElementsWithSumKBruteForce574
    set output_file "threeElementsWithSumKBruteForce.py"

    set template_content '
def threeElementsWithSumKBruteForce(A, K):
	n = len(A)
    	for i in range(0, n - 2):
		for j in range(i + 1, n - 1):
			for k in range(j + 1, n):
				if(A[i] + A[j] + A[k] == K):
					print "yes-->", A[i], " + ", A[j], " + ", A[k], " = ", K		
					return 1
	return 0    
A = [1, 6, 45, 4, 10, 18]
A.sort()
threeElementsWithSumKBruteForce(A, 22)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.threeElementsWithSumKWithSorting575
    set output_file "threeElementsWithSumKWithSorting.py"

    set template_content '
def threeElementsWithSumKWithSorting(A, K):
	n = len(A)
	left = 0
	right = n - 1
	for i in range(0, n - 2):
		left = i + 1
		right = n - 1
		while(left < right):
			print A[i] + A[left] + A[right], K
			if(A[i] + A[left] + A[right] == K):
				print "yes-->", A[i], " + ", A[left], " + ", A[right], " = ", K		
				return 1
			elif(A[i] + A[left] + A[right] < K):
				left += 1
			else:
				right -= 1
	return 0
    
A = [1, 6, 45, 4, 10, 18]
A.sort()
print threeElementsWithSumKWithSorting(A, 23)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.TwoElementsClosestToZeroBruteForce576
    set output_file "TwoElementsClosestToZero.py"

    set template_content '
def TwoElementsClosestToZero(A):
	n = len(A)
	if(n < 2):
		print "Invalid Input"
		return
 	minLeft = 0
	minRight = 1
	minSum = A[0] + A[1]
	for l in range(1, n - 1):
		for r in range(l + 1, n):
			sum = A[l] + A[r];
			if(abs(minSum) > abs(sum)):
				minSum = sum
				minLeft = l
				minRight = r
	print " The two elements whose sum is minimum are ", A[minLeft], A[minRight]

A = [1, 60, -10, 70, -80, 85]
TwoElementsClosestToZero(A)
A = [10, 8, 3, 5, -9, -7, 6]
TwoElementsClosestToZero(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.TwoElementsClosestToZeroWithSorting577
    set output_file "TwoElementsClosestToZeroWithSorting.py"

    set template_content '
import sys
def TwoElementsClosestToZero(A):
	n = len(A)
	A.sort()
	if(n < 2):
		print "Invalid Input"
		return
	l = 0
	r = n - 1		
 	minLeft = l
	minRight = n - 1
	minSum = sys.maxint
	while(l < r):
		sum = A[l] + A[r];
		if(abs(minSum) > abs(sum)):
			minSum = sum
			minLeft = l
			minRight = r
		if sum < 0:
			l += 1
		else: r -= 1
	print " The two elements whose sum is minimum are ", A[minLeft], A[minRight]

A = [1, 60, -10, 70, -80, 85]
TwoElementsClosestToZero(A)
A = [10, 8, 3, 5, -9, -7, 6]
TwoElementsClosestToZero(A)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.TwoElementsWithSumKBruteForce578
    set output_file "TwoElementsWithSumKBruteForce.py"

    set template_content '
def twoElementsWithSumKBruteForce(A, K):
	n = len(A)
    	for i in range(0, n):
		for j in range(i + 1, n):
			if(A[i] + A[j] == K):
				return 1
	return 0
    
A = [1, 4, 45, 6, 10, -8]
A.sort()
print twoElementsWithSumKBruteForce(A, 111)


'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.TwoElementsWithSumKEfficientWithSorting579
    set output_file "TwoElementsWithSumKEfficientWithSorting.py"

    set template_content '
def pair_sum_k_sorting(A, K):
    left = 0
    right = len(A) - 1; 
    while(left < right):
         if(A[left] + A[right] == K):
              return 1
         elif(A[left] + A[right] < K):
              left += 1
         else:
              right -= 1
    return 0
    
A = [1, 4, 45, 6, 10, -8]
A.sort()
print pair_sum_k_sorting(A, 11)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.TwoElementsWithSumKWithHash580
    set output_file "TwoElementsWithSumKWithHash.py"

    set template_content '
def twoElementsWithSumKWithHash(A, K):
	table = {}  # hash
	for element in A:
		if element in table:
			table[element] += 1
		elif element != " ":
			table[element] = 1
		else:
			table[element] = 0			
	for element in A:
		if K - element in table:
			print "yes-->", element, "+", K - element, " = ", K			
A = [1, 4, 45, 6, 10, -8]
A.sort()
twoElementsWithSumKWithHash(A, 11)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.finding_all_peaks_with_linear_search581
    set output_file "finding_all_peaks_with_linear_search.py"

    set template_content '
def find_peaks(A):
	peak = A[0]
	for i in range(1, len(A)-2):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr
			print peak
	if A[len(A)-1] > A[len(A)-2]:
		print A[len(A)-1]

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
print A, "\n"
find_peaks(A)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.finding_highest_peak_with_linear_search582
    set output_file "finding_highest_peak_with_linear_search.py"

    set template_content '
def find_peak(A):
	peak = A[0]
	for i in range(1, len(A)-2):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr

        if len(A)-1 > peak:
            return A[len(A)-1]
 
        return A[index]

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
print A, "\n", find_peak(A)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.finding_peak_with_binary_search583
    set output_file "finding_peak_with_binary_search.py"

    set template_content '
def find_peak(A):
    if not A:
        return -1

    l, r = 0, len(A) - 1
    while l + 1 < r:
        mid = l + (r - l) / 2
        if A[mid] < A[mid - 1]:
            r = mid
        elif A[mid] < A[mid + 1]:
            l = mid
        else:
            return mid
    mid = l if A[l] > A[r] else r
    return mid

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
p = find_peak(A)
print A, "\n", A[p]

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.finding_single_peak_with_linear_search584
    set output_file "finding_single_peak_with_linear_search.py"

    set template_content '
def find_peak(A):
	peak = A[0]
	for i in range(1, len(A)-2):
		prev = A[i-1]
		curr = A[i]
		next = A[i+1]
		if curr > prev and curr > next:
			index = i
			peak = curr
			return peak

        if len(A)-1 > peak:
            return A[len(A)-1]
 
        return A[index]

A = [35, 5, 20, 2, 40, 25, 80, 25, 15, 40]
print A, "\n", find_peak(A)

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BubbleSortSwap585
    set output_file "BubbleSortSwap.py"

    set template_content '
def BubbleSort(A):
    for i in range(len(A)):
        for k in range(len(A) - 1, i, -1):
                if (A[k] < A[k - 1]):
                    swap(A, k, k - 1)

def swap(A, x, y):
    tmp = A[x]
    A[x] = A[y]
    A[y] = tmp
      
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
BubbleSort(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.BubbleSortImproved586
    set output_file "BubbleSortImproved.py"

    set template_content '
def BubbleSort(A):
	swapped = 1 
	for i in range(len(A)):
		if (swapped == 0):
			return
		
		for k in range(len(A) - 1, i, -1):
			if (A[k] < A[k - 1]):
				swap(A, k, k - 1)
				swapped = 1

def swap(A, x, y):
	temp = A[x]
	A[x] = A[y]
	A[y] = temp
	

A = [127, 220, 246, 277, 321, 454, 534, 565, 933]
BubbleSort(A)
print(A) 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CheckWhoWinsTheElection587
    set output_file "CheckWhoWinsTheElection.py"

    set template_content '
def CheckWhoWinsTheElection(A):
	counter = maxCounter = 0
	candidate = A[0]
	for i in range(0, len(A)):
		counter = 1
		for j in range(i + 1, len(A)):
			if(A[i] == A[j]): 
				counter += 1		
		if(counter > maxCounter):
			maxCounter = counter
			candidate = A[i]	
	print candidate, "appeared ", maxCounter, " times"

A = [3, 2, 1, 2, 2, 3]
CheckWhoWinsTheElection(A)
A = [3, 3, 3, 2, 2, 3]
CheckWhoWinsTheElection(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CheckWhoWinsTheElectionWithOutSpace588
    set output_file "CheckWhoWinsTheElectionWithOutSpace.py"

    set template_content '
def CheckWhoWinsTheElection(A):
	A.sort()
	counter = maxCounter = 0
	candidate = maxCandidate = 0
	
	for i in range(0, len(A)):
		if(A[i] == candidate):
			counter += 1
		else:
			counter = 1
			candidate = A[i]

		if(counter > maxCounter):
			maxCandidate = A[i]
			maxCounter = counter

	print maxCandidate, "appeared ", maxCounter, " times"

		
A = [2, 3, 2, 1, 2, 2, 3, 2, 2]
CheckWhoWinsTheElection(A)
A = [3, 3, 3, 2, 2, 3]
CheckWhoWinsTheElection(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CountingSort589
    set output_file "CountingSort.py"

    set template_content '
def CountingSort(A, k):
	""" implementation of counting sort """
	B = [0 for el in A]
	C = [0 for el in range(0, k + 1)]

	for i in xrange(0, k + 1):
		C[i] = 0

	for j in xrange(0, len(A)):
		C[A[j]] += 1

	for i in xrange(1, k + 1):
		C[i] += C[i - 1]

	for j in xrange(len(A) - 1, 0 - 1, -1):
		tmp = A[j]
		tmp2 = C[tmp] - 1
		B[tmp2] = tmp
		C[tmp] -= 1
	return B
	
A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(CountingSort(A, 1000))

def counting_sort(A, k):
    """in-place counting sort"""
    n = len(A)
    m = k + 1
    C = [0] * m              
    for a in A:
        C[a] += 1           
    i = 0
    for a in range(m):            
        for c in range(C[a]): 
            A[i] = a
            i += 1
    return A

print counting_sort( [1, 4, 7, 2, 1, 3, 2, 1, 4, 2, 3, 2, 1], 7 )
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.exchangeEvenOddList590
    set output_file "exchangeEvenOddList.py"

    set template_content '
def exchangeEvenOddList(head):
	# initializing the odd and even list headers
	oddList = evenList = None

	# creating tail variables for both the list
	oddListEnd = evenListEnd = None    
	itr = head	

	if(head == None):
		return
	else:
		while(itr != None):
			if(itr.data % 2 == 0):
				if(evenList == None):
					# first even node 
					evenList = evenListEnd = itr
				else:
					# inserting the node at the end of linked list                        
					evenListEnd.next = itr                           
					evenListEnd = itr
			else:
				if(oddList == None):
					# first odd node 
					oddList = oddListEnd = itr
				else:
					# inserting the node at the end of linked list
					oddListEnd.next = itr                          
					oddListEnd = itr
		itr = itr.next
	evenListEnd.next = oddList
	return head
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.FinSUMInTwoSortedArrays591
    set output_file "finding.py"

    set template_content '
def BinarySearchIterative(numbersList, value):
    low = 0
    high = len(numbersList) - 1
    while low <= high: 
        mid = (low + high) // 2
        if numbersList[mid] > value: high = mid - 1
        elif numbersList[mid] < value: low = mid + 1
        else: return mid
    return -1
		
def findSumInLists(A, B, k):
	A.sort()
	for i in range(0, len(B)):
		c = k - B[i] 	
		if(BinarySearchIterative(A, c) != -1):
			return 1
	return 0	

		
A = [2, 3, 5, 7, 12, 15, 23, 32, 42]
B = [3, 13, 13, 15, 22, 33]
print findSumInLists(A, B, 270)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InsertionSort592
    set output_file " InsertionSort..py"

    set template_content '
def Insertionsort(A):
  for i in range(1, len(A)):
    tmp = A[i]
    k = i
    while k > 0 and tmp < A[k - 1]:
        A[k] = A[k - 1]
        k -= 1
    A[k] = tmp    
      
A = [54, 26, 93, 17, 77, 31, 44, 55, 20]
Insertionsort(A)
print(A) 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeSecondListToFirst593
    set output_file "finding.py"

    set template_content '
def Merge(A, m, B, n):
	i = n - 1
	j = k = m - 1
	while k >= 0:
		if(B[i] > A[j] or j < 0):
			A[k] = B[i]
			i -= 1
			if(i < 0):
				break
		else:
			A[k] = A[j]
			j -= 1
		k -= 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MergeSort594
    set output_file "MergeSort.py"

    set template_content '
def MergeSort(A):
    if len(A) > 1:
        mid = len(A) // 2
        lefthalf = A[:mid]
        righthalf = A[mid:]
        MergeSort(lefthalf)
        MergeSort(righthalf)
        i = j = k = 0
        while i < len(lefthalf) and j < len(righthalf):
            if lefthalf[i] < righthalf[j]:
                A[k] = lefthalf[i]
                i = i + 1
            else:
                A[k] = righthalf[j]
                j = j + 1
            k = k + 1

        while i < len(lefthalf):
            A[k] = lefthalf[i]
            i = i + 1
            k = k + 1

        while j < len(righthalf):
            A[k] = righthalf[j]
            j = j + 1
            k = k + 1

A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
MergeSort(A)
print(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.QuickSort595
    set output_file "QuickSort.py"

    set template_content '
import random
def QuickSort(A, low, high):
    if low < high:
        pivot = Partition(A, low, high)
        QuickSort(A, low, pivot - 1)
        QuickSort(A, pivot + 1, high)
 
def Partition(A, low, high) :
    pivot = low + random.randrange(high - low + 1)
    swap(A, pivot, high)
    for i in range(low, high):
        if A[i] <= A[high]:
            swap(A, i, low)
            low += 1
 
    swap(A, low, high)
    return low
 
def swap(A, x, y):
    temp = A[x]
    A[x] = A[y]
    A[y] = temp

A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
QuickSort(A, 0, len(A) - 1)
print(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.QuickSortWithLinkedLists596
    set output_file "QuickSortWithLinkedLists.py"

    set template_content '
class ListNode:
	def __init__(self, x):
		self.data = x
		self.next = None

def Qsort(first, last):
	lesHEAD = lesTAIL = None
	equHEAD = equTAIL = None
	larHEAD = larTAIL = None
	current = first
	if(current == None):
		return
	pivot = current.data
	Append(current, equHEAD, equTAIL)
	while (current != None):
		info = current.data
		if(info < pivot):
			Append(current, lesHEAD, lesTAIL)
		elif(info > pivot):
			Append(current, larHEAD, larTAIL)
		else:
			Append(current, equHEAD, equTAIL)
	
	Quicksort(lesHEAD, lesTAIL)
	Quicksort(larHEAD, larTAIL)
	Join(lesHEAD, lesTAIL, equHEAD, equTAIL)
	Join(lesHEAD, equTAIL, larHEAD, larTAIL)
	first = lesHEAD
	last = larTAIL
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.RadixSort597
    set output_file "finding.py"

    set template_content '
def RadixSort(A):
	  RADIX = 10
	  maxLength = False
	  tmp , placement = -1, 1
	 
	  while not maxLength:
		maxLength = True
		buckets = [list() for _ in range(RADIX)]
		for  i in A:
			tmp = i / placement
			buckets[tmp % RADIX].append(i)
			if maxLength and tmp > 0:
				maxLength = False
	 
		a = 0
		for b in range(RADIX):
			buck = buckets[b]
			for i in buck:
				A[a] = i
				a += 1
	 
		# move to next digit
		placement *= RADIX
	  
	A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
	print(RadixSort(A))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SelectionSort598
    set output_file "SelectionSort.py"

    set template_content '
def SelectionSort(A):
  for i in range(len(A)):
    least = i
    for k in range(i + 1 , len(A)):
      if A[k] < A[least]:
        least = k
 
    swap(A, least, i)
 
 
def swap(A, x, y):
  temp = A[x]
  A[x] = A[y]
  A[y] = temp
	      
      
A = [54, 26, 93, 17, 77, 31, 44, 55, 20]
SelectionSort(A)
print(A) 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ShellSort599
    set output_file "finding.py"

    set template_content '
def ShellSort(A):
    sublistcount = len(A) // 2
    while sublistcount > 0:

        for startposition in range(sublistcount):
            gapInsertionSort(A, startposition, sublistcount)

        print("After increments of size", sublistcount, "The list is", A)
        sublistcount = sublistcount // 2

def gapInsertionSort(A, start, gap):
    for i in range(start + gap, len(A), gap):
        currentvalue = A[i]
        position = i
        while position >= gap and A[position - gap] > currentvalue:
            A[position] = A[position - gap]
            position = position - gap

        A[position] = currentvalue

A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
ShellSort(A)
print(A)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SortListByFrequency600
    set output_file "SortListByFrequency.py"

    set template_content '
myString = "We want to get the counts for each letter in this sentence"
counts = {}

for letter in myString:
    counts[letter] = counts.get(letter, 0) + 1
print counts

sortedKeys = sorted(counts.keys(), key=lambda x: counts[x])
for k in sortedKeys:
    print k , "-->" , counts[k]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.BSTToDLL601
    set output_file "BSTToDLL.py"

    set template_content '
class Node:
 ''' class to represent a Node of BST/ linked list'''
 def __init__(self, data):
     self.data = data
     self.left = None
     self.right = None

def printBST(root):
 if not root:
     return
 else:
     printBST(root.left)
     print root.data, " ",
     printBST(root.right)

def printList(head):
 if not head:
     return  
 if head: print head.data    
 # print forward direction
 h = head
 print '[%d]' % (h.data),
 h = h.right
 while h != head:
     print '[%d]' % (h.data),
     h = h.right

 print ""
 # print in reverse direction
 h = head.left
 print '[%d]' % (h.data),
 h = h.left
 while h != head.left:
     print '[%d]' % (h.data),
     h = h.left


def BSTToDLL(root):
	prev = None
	head = None
	BSTToDoublyList(root, prev, head)
	return head

def BSTToDoublyList(root, prev, head):
	if (not root): return 

	BSTToDoublyList(root.left, prev, head)

	# current nodes left points to previous node
	root.left = prev
	if (prev):
		prev.right = root  # Previous nodes right points to current node
	else:
		head = root  # If previous is NULL that current node is head

	right = root.right  # Saving right node

	# Now we need to make list created till now as circular
	head.left = root
	root.right = head

	# For right-subtree/parent, current node is in-order predecessor
	prev = root
	BSTToDoublyList(right, prev, head)
   

if __name__ == "__main__":
 # create the sample BST
 root = a = Node(5)
 b = Node(3)
 c = Node(6)
 d = Node(2)
 e = Node(4)
 f = Node(7)

 a.left, a.right = b, c
 b.left, b.right = d, e
 c.right = f

 printBST(root)

 print "\ncreating to double linked list"
 head = BSTToDLL(root)
 printList(head)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BSTToDLLWithDivideAndConquer602
    set output_file "BSTToDLLWithDivideAndConquer.py"

    set template_content '
class Node:
 ''' class to represent a Node of BST/ linked list'''
 def __init__(self, data):
     self.data = data
     self.left = self
     self.right = self

def printBST(root):
 '''prints the BST in an inorder sequence'''
 if root.left == root or root.right == root:
     print root.data, " ",
 else:
     printBST(root.left)
     print root.data, " ",
     printBST(root.right)

def printList(head):
 '''prints the linked list in both directions
  to test whether both the 'next' and 'previous' pointers are fine'''
 # print forward direction
 h = head
 print '[%d]' % (h.data),
 h = h.right
 while h != head:
     print '[%d]' % (h.data),
     h = h.right

 print ""
 # print in reverse direction
 h = head.left
 print '[%d]' % (h.data),
 h = h.left
 while h != head.left:
     print '[%d]' % (h.data),
     h = h.left


def BSTToDLL(root):
 ''' main function to take the root of the BST and return the head of the doubly linked list  '''

 # for leaf Node return itself
 if root.left == root and root.right == root:
     return root

 elif root.left == root:  # no left subtree exist
     h2 = BSTToDLL(root.right)
     root.right = h2
     h2.left.right = root
     root.left = h2.left
     h2.left = root
     return root

 elif root.right == root:  # no right subtree exist
     h1 = BSTToDLL(root.left)
     root.left = h1.left
     h1.left.right = root
     root.right = h1
     h1.left = root
     return h1

 else:  # both left and right subtrees exist
     h1 = BSTToDLL(root.left)
     h2 = BSTToDLL(root.right)

     l1 = h1.left  # find last nodes of the lists
     l2 = h2.left

     h1.left = l2
     l2.right = h1

     l1.right = root
     root.left = l1

     root.right = h2
     h2.left = root
     return h1




if __name__ == "__main__":

 # create the sample BST
 root = a = Node(5)
 b = Node(3)
 c = Node(6)

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CloneLinkedListWithSpace603
    set output_file "CloneLinkedListWithSpace.py"

    set template_content '
class Node:
	def __init__(self, data):
		self.set_data(data)
		self.set_next(None)
		self.set_rand(None)
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, nextV):
		self.next = nextV
	# method for setting the next field of the node
	def set_rand(self, rand):
		self.rand = rand	
	# method for getting the next field of the node
	def get_rand(self):
		return self.rand	
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# returns true if the node points to another node
	def has_next(self):
	    return self.next != None
	    
	def clone_linked_list(old):
	    if not old:
		return

	    old_copy = old
	    root = Node(old.get_data())
	    prev = root
	    temp = None

	    old = old.get_next()

	    mapping = {}
	    
	    while old:
		temp = Node(old.get_data())
		mapping[old] = temp
		
		prev.set_next(temp)
		prev = temp
		old = old.get_next()

	    old = old_copy
	    temp = root

	    while old:
		temp.set_rand(mapping[old.rand])
		temp = temp.get_next()
		old = old.get_next()

	    return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CloneLinkedListWithoutExtraSpace604
    set output_file "CloneLinkedListWithoutExtraSpace.py"

    set template_content '
class RandomListNode:
    def __init__(self, x):
        self.data = x
        self.next = None
        self.random = None

class Solution:
    # @param head, a RandomListNode
    # @return a RandomListNode
    def copy_random_list(self, head):
        if None == head:
            return None
        save_list = [ ]
        p1 = head
        while None != p1:
            save_list.append(p1)
            p1 = p1.next
        new_head = RandomListNode(-1)
        new_head.next = head
        first = new_head
        second = head
        copyHead = RandomListNode(-1)
        copyFirst = copyHead
        copySecond = None
        while None != first:
            copySecond = RandomListNode(second.data) if None != second else None
            copyFirst.next = copySecond
            copyFirst = copyFirst.next
            first = first.next
            if None != second:
                second = second.next

        p1 = head
        p1_tail = head.next
        p2 = copyHead.next
        while None != p1:
            p1_tail = p1.next
            p1.next = p2
            p2.random = p1
            p1 = p1_tail
            p2 = p2.next
        p2 = copyHead.next
        while None != p2:
            p2.random = p2.random.random.next if None != p2.random.random else None
            p2 = p2.next
        len_save_list = len(save_list)
        for i in range(0, len_save_list - 1):
            save_list[i].next = save_list[i + 1]
        save_list[len_save_list - 1].next = None
        return copyHead.next
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Dll605
    set output_file "Dll.py"

    set template_content '
class Node:
    # Constructor to initialize data
    # If data is not given by user,its taken as None 
    def __init__(self, data=None, next=None, prev=None):
        self.data = data
        self.next = next
        self.prev = prev
    # method for setting the data field of the node    
    def set_data(self, data):
        self.data = data
    # method for getting the data field of the node   
    def get_data(self):
        return self.data
    # method for setting the next field of the node
    def set_next(self, next):
        self.next = next
    # method for getting the next field of the node    
    def get_next(self):
        return self.next
    # returns true if the node points to another node
    def has_next(self):
            return self.next != None
    # method for setting the next field of the node
    def setPrev(self, prev):
        self.prev = prev
       # method for getting the next field of the node    
    def getPrev(self):
        return self.prev
    # returns true if the node points to another node
    def hasPrev(self):
            return self.prev != None	    
    # __str__ returns string equivalent of Object
    def __str__(self):
        return "Node[Data = %s]" % (self.data,)

class DoubleLinkedList:
    
    def __init__(self):
        self.head = None
        self.tail = None
    
    def insert(self, data):
        if (self.head == None):  # To imply that if head == None
            self.head = Node(data)
            self.tail = self.head
        else:
            current = self.head
            while(current.next != None):
                current = current.next
            current.next = Node(data, None, current)
            self.tail = current.next

    def delete(self, data):
        current = self.head
        # If given item is the first element of the linked list
        if current.data == data:
            self.head = current.next
            self.head.prev = None
            return True
        
        # In case the linked list is empty
        if current == None:
            return False

        # If the element is at the last
        if self.tail == data:
            self.tail = self.tail.prev
            self.tail.next = None
            return True

        # If the element is absent or in the middle of the linked list
        while current != None:
            if current.data == data :
                current.prev.next = current.next
                current.next.prev = current.prev
                return True
            current = current.next
     
        # The element is absent
        return False
	
    def insertAtBeginning(self, data):
        newNode = Node(data, None, None)
        if (self.head == None):  # To imply that if head == None
            self.head = self.tail = newNode
        else:
            newNode.setPrev(None)
            newNode.set_next(self.head)
            self.head.setPrev(newNode)
            self.head = newNode


    def getNode(self, index):
        currentNode = self.head
        if currentNode == None:
            return None
        i = 0
        while i < index and currentNode.get_next() is not None:
            currentNode = currentNode.get_next()
            if currentNode == None:
                break
            i += 1
        return currentNode
		
    def insertAtGivenPosition(self, index, data):
        newNode = Node(data)
        if self.head == None or index == 0:
            self.insertAtBeginning(data)
        elif index > 0:
            temp = self.getNode(index) 
            if temp == None or temp.get_next() == None:	
                self.insert(data)
            else:
                newNode.set_next(temp.get_next())
                newNode.setPrev(temp)
                temp.get_next().setPrev(newNode)
                temp.set_next(newNode)
		
    def find(self, data):
        current = self.head
        while current != None:
            if current.data == data :
                return True
            current = current.next
        return False

    def fwd_print(self):
        current = self.head
        if current == None:
            print("No elements")
            return False
        while (current != None):
            print (current.data) 
            current = current.next
        return True

    def rev_print(self):
        current = self.tail
        if (self.tail == None):
            print("No elements")
            return False

        while (current != None):
            print (current.data)
            current = current.prev
        return True

if __name__ == '__main__':
    # Initializing list
    l = DoubleLinkedList()

    # Inserting Values
    l.insert(1)
    l.insert(2)
    l.insert(3)
    l.insert(4)

    # Forward Print
    l.fwd_print()

    # Reverse Print
    l.rev_print()

    # Try to find 3 in the list
    if (l.find(3)):
        print("Found")
    else :
        print("Not found")

    # Delete 3 from the list
    l.delete(3)

    # Forward Print
    l.fwd_print()

    # Reverse Print
    l.rev_print()

    # Now if we find 3, we will not get it in the list
    if (l.find(3)):
        print("Found")
    else :
        print("Not found")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.DLLToBST606
    set output_file "DLLToBST.py"

    set template_content '
def DLLtoBalancedBST(head):
	if(not head or not head.next): 
		return head
	temp = FindMiddleNode(head)
	p = head
	while(p.next != temp):
		p = p.next
	p.next = None
	q = temp.next
	temp.next = None
	temp.prev = DLLtoBalancedBST(head)
	temp.next = DLLtoBalancedBST(q)
	return temp
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.Dll_test607
    set output_file "SortListByFrequency.py"

    set template_content '
class TestSequenceFunctions(unittest.TestCase):


    def test_insert(self):
        dll = DoubleLinkedList()
        dll.insert("alice")
        self.assertEqual(dll.getNode(0).get_data(), "alice")

        dll.insert("bob")
        dll.insert("charlie")
        self.assertEqual(dll.getNode(1).get_data(), "bob")
        self.assertEqual(dll.getNode(2).get_data(), "charlie")

        # insert a node after bill, fixes insertAtGivenPosition logic
        # bill should go in between bob and charlie
        dll.insertAtGivenPosition(1, "bill")
        self.assertEqual(dll.getNode(2).get_data(), "bill")
        self.assertEqual(dll.getNode(2).getPrev().get_data(), "bob")
        self.assertEqual(dll.getNode(2).get_next().get_data(), "charlie")

        #insert an index that should go on the end and exercise the 
        # insertAtEnd method which didnt exist
        dll.insertAtGivenPosition(100, "donna")
        self.assertEqual(dll.getNode(4).get_data(), "donna")

    def test_delete(self):
        dll = DoubleLinkedList()
        dll.insert("alice")
        dll.insert("bob")
        dll.insert("charlie")
        self.assertEqual(dll.getNode(2).get_data(), "charlie")

        # charlie should shift over now to where bob was
        dll.delete("bob")
        self.assertEqual(dll.getNode(1).get_data(), "charlie")



if __name__ == '__main__':
    unittest.main()


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.deleteLinkedListDuplicates608
    set output_file "SortListByFrequency.py"

    set template_content '
def deleteLinkedListDuplicates(self):
	current = self.head;
	while current != None and current.next != None:
	    if current.get_data() == current.get_next().get_data():
		current.set_next(current.get_next().get_next())
	    else:
		current = current.get_next()
	return head
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.detectCycleStart609
    set output_file "detectCycleStart.py"

    set template_content '
class Node:
	def __init__(self, data):
		self.data = data
		self.next = None
		 
	def set_data(self, data):
		self.data = data
	 
	def get_data(self):
		return self.data
	 
	def set_next(self, next):
		self.next = next
		 
	def get_next(self):
		return self.next
	 
	 
class LinkedList:
	def __init__(self):
		self.head = None
		 
	def isEmpty(self):
		return self.head == None
	 
	def insertAtBeg(self, item):
		node = Node(item)
		node.set_next(self.head)
		self.head = node
		 
	def length(self):
		current = self.head
		count = 0
		while current != None:
			count += 1
			current = current.get_next()
		return count
	 
	def search(self, item):
		found = False
		current = self.head
		while current != None and not found:
			if current.get_data() == item:
				found = True
			else:
				current = current.get_next()
				 
		return found
	 
	def insertAtEnd(self, item):
		current = self.head
		 
		while current.get_next() != None:
			current = current.get_next()
			 
		node = Node(item)
		current.set_next(node)
		 
	def insertBeforeItem(self, inItem, item):
		current = self.head
		previous = None
		found = False
		stop = False
		 
		while current != None and not found and not stop:
			if current.get_data() == item:
				found = True
				stop = True
			else:
				previous = current
				current = current.get_next()
				 
		node = Node(inItem)
		previous.set_next(node)
		node.set_next(current)
		 
		 
	def insertAfterItem(self, inItem, item):
		current = self.head
		 
		found = False
		stop = False
		 
		while current != None and not found and not stop:
			if current.get_data() == item:
				found = True
				stop = True
			else:
#                previous = current
				current = current.get_next()
		successor = current.get_next()       
		node = Node(inItem)
		current.set_next(node)
		node.set_next(successor)
		 	 
		 
	def printList(self):
		current = self.head
		 
		while current != None:
			print current.get_data()
			current = current.get_next()
			 
			 
	def remove(self, item):
		found = False
		current = self.head
		previous = None
		 
		while current.get_next() != None and not found:
			if current.get_data() == item:
				print current.get_data()
				print previous.get_data()
				found = True
				previous.set_next(current.next)
			else:
				previous = current
				current = current.get_next()
				 
	def induceCycle(self, end, start):
		current = self.head
		stop = False
		endnodeFound = False
		endnodePointer = None
		count = 0
		while current != None and not stop:
			count += 1
			if count == end:
				endnodeFound = True
				endnodePointer = current.get_next()
				 
			else:
				if count == start:
					stop = True
				else:
					current = current.get_next()
					 
		current.set_next(endnodePointer)
		 
	def detectCycle(self):
		hare = self.head
		tortoise = self.head
		 
		while (hare and tortoise):
			hare = hare.get_next()
			if (hare == tortoise):
				return True
			 
			if hare == None:
				return False
			 
			hare = hare.get_next()
			if (hare == tortoise):
				return True
			 
			tortoise = tortoise.get_next()
	
	def detectCycleStart(self) :
		if None == self.head or None == self.head.next:
				return None
		
		slow = self.head.next
		fast = slow.next
		while slow != fast:
				slow = slow.next
				try:
						fast = fast.next.next
				except AttributeError:
						return None 
		slow = self.head
		while slow != fast:
				slow = slow.next
				fast = fast.next
		
		return slow.get_data()  # beginning of loop
	
       
		 
		 
if __name__ == "__main__":
	linkedlst = LinkedList()
	linkedlst.insertAtBeg(1)
	linkedlst.insertAtBeg(2)
	linkedlst.insertAtEnd(3)
	linkedlst.insertBeforeItem(4, 3)
	linkedlst.insertAfterItem(5, 1)
	linkedlst.insertAtEnd(6)
	linkedlst.insertAtEnd(8)
	linkedlst.insertAtEnd(7)
	 
	 
	linkedlst.printList()
	 
	linkedlst.induceCycle(2, 8)
	print linkedlst.detectCycle()
	print linkedlst.detectCycleStart()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.findIntersectingNode610
    set output_file "findIntersectingNode.py"

    set template_content '
def findIntersectingNode(self, list1, list2):
	intersect = {}
	t = list1
	while None != t:
		intersect[t] = True
		t = t.get_next()

	# first duplicate is intersection
	t = list2
	while None != t:
		if None != intersect.get(t):
			return t
		t = t.get_next()
	return None
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindMiddleNodeEfficient611
    set output_file "FindMiddleNodeEfficient.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
    
    def recursiveReverseList(self) :
		self.reverseRecursive(self.head)
		
    def reverseRecursive(self, n) :
		if None != n:
			right = n.get_next()
			if self.head != n:
				n.set_next(self.head)
				self.head = n
			else:
				n.set_next(None)
			self.reverseRecursive(right)
			
    def findMiddleNode(self) :
	fastPtr = self.head
	slowPtr = self.head
	 
	while (fastPtr != None):
	    fastPtr = fastPtr.get_next()
	    if (fastPtr == None):
		return slowPtr
	     
	    fastPtr = fastPtr.get_next()   
	    slowPtr = slowPtr.get_next()
	return slowPtr
		
    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
             
	

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
     
    linkedlst.printList()
    linkedlst.recursiveReverseList()
    linkedlst.printList()
    print(linkedlst.findMiddleNode().get_data())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FndLoopLength612
    set output_file "FndLoopLength.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
         
    def isEmpty(self):
        return self.head == None
     
    def insertAtBeg(self, item):
        node = Node(item)
        node.set_next(self.head)
        self.head = node
         
    def length(self):
        current = self.head
        count = 0
        while current != None:
            count += 1
            current = current.get_next()
        return count
     
    def search(self, item):
        found = False
        current = self.head
        while current != None and not found:
            if current.get_data() == item:
                found = True
            else:
                current = current.get_next()
                 
        return found
     
    def insertAtEnd(self, item):
        current = self.head
         
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def insertBeforeItem(self, inItem, item):
        current = self.head
        previous = None
        found = False
        stop = False
         
        while current != None and not found and not stop:
            if current.get_data() == item:
                found = True
                stop = True
            else:
                previous = current
                current = current.get_next()
                 
        node = Node(inItem)
        previous.set_next(node)
        node.set_next(current)
         
         
    def insertAfterItem(self, inItem, item):
        current = self.head
         
        found = False
        stop = False
         
        while current != None and not found and not stop:
            if current.get_data() == item:
                found = True
                stop = True
            else:
#                previous = current
                current = current.get_next()
        successor = current.get_next()       
        node = Node(inItem)
        current.set_next(node)
        node.set_next(successor)         
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
             
             
    def remove(self, item):
        found = False
        current = self.head
        previous = None
         
        while current.get_next() != None and not found:
            if current.get_data() == item:
                print current.get_data()
                print previous.get_data()
                found = True
                previous.set_next(current.next)
            else:
                previous = current
                current = current.get_next()
                 
    def induceCycle(self, end, start):
        current = self.head
        stop = False
        endnodeFound = False
        endnodePointer = None
        count = 0
        while current != None and not stop:
            count += 1
            if count == end:
                endnodeFound = True
                endnodePointer = current.get_next()
                 
            else:
                if count == start:
                    stop = True
                else:
                    current = current.get_next()
                     
        current.set_next(endnodePointer)
         
    def detectCycle(self):
        hare = self.head
        tortoise = self.head
         
        while (hare and tortoise):
            hare = hare.get_next()
            if (hare == tortoise):
                return True
             
            if hare == None:
                return False
             
            hare = hare.get_next()
            if (hare == tortoise):
                return True
             
            tortoise = tortoise.get_next()
    
	def detectCycleStart(self) :
	    if None == self.head or None == self.head.next:
	      return None
	 
	    # slow and fast both started at head after one step,
	    # slow is at self.head.next and fast is at self.head.next.next
	    slow = self.head.next
	    fast = slow.next
	    # each keep walking until they meet again.
	    while slow != fast:
	      slow = slow.next
	      try:
		fast = fast.next.next
	      except AttributeError:
		return None  # no cycle if NoneType reached
	 
	    # from self.head to beginning of loop is same as from fast to
	    # beginning of loop
	    slow = self.head
	    while slow != fast:
	      slow = slow.next
	      fast = fast.next
	 
	    return slow  # beginning of loop
    
	def fndLoopLength(self) :
	    if None == self.head or None == self.head.next:
	      return 0
	 
	    # slow and fast both started at head after one step,
	    # slow is at self.head.next and fast is at self.head.next.next
	    slow = self.head.next
	    fast = slow.next
	    # each keep walking until they meet again.
	    while slow != fast:
	      slow = slow.next
	      try:
	        fast = fast.next.next
	      except AttributeError:
	        return 0  # no cycle if NoneType reached
	 
	    loopLength = 0	
	    slow = slow.next
	    while slow != fast:
	      slow = slow.next
	      loopLength = loopLength + 1    
	    
	    return loopLength          
         
         
if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtBeg(1)
    linkedlst.insertAtBeg(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertBeforeItem(4, 3)
    linkedlst.insertAfterItem(5, 1)
    linkedlst.insertAtEnd(6)
    linkedlst.insertAtEnd(8)
    linkedlst.insertAtEnd(7)
     
     
    linkedlst.printList()
     
    linkedlst.induceCycle(2, 8)
    print linkedlst.detectCycle()
    print linkedlst.fndLoopLength()
    print linkedlst.detectCycleStart()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FractionalNode613
    set output_file "FractionalNode..py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
	
    def fractionalNode(self, k):
	fractionalNode = None
	currentNode = self.head
	i = 0
	if k <= 0:
		return None;
	
	while currentNode != None:
		if i % k == 0:
			if fractionalNode == None:
				fractionalNode = self.head
			else:
				fractionalNode = fractionalNode.get_next()		
		i = i + 1
		currentNode = currentNode.get_next()
		
	print (fractionalNode.get_data())
			
    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
    linkedlst.fractionalNode(4)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GetIntersectionNode614
    set output_file "GetIntersectionNode.py"

    set template_content '
def getIntersectionNode(self, list1, list2):
	currentList1, currentList2 = list1, list2
	list1Len, list2Len = 0, 0
	while currentList1 is not None:
	    list1Len += 1
	    currentList1 = currentList1.next
	while currentList2 is not None:
	    list2Len += 1
	    currentList2 = currentList2.next
	currentList1, currentList2 = list1, list2
	if list1Len > list2Len:
	    for i in range(list1Len - list2Len):
		currentList1 = currentList1.next
	elif list2Len > list1Len:
	    for i in range(list2Len - list1Len):
		currentList2 = currentList2.next
	while currentList2 != currentList1:
	    currentList2 = currentList2.next
	    currentList1 = currentList1.next
	return currentList1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IsLinkedListLengthEven615
    set output_file "IsLinkedListLengthEven.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
    
    def recursiveReverseList(self) :
		self.reverseRecursive(self.head)
		
    def reverseRecursive(self, n) :
		if None != n:
			right = n.get_next()
			if self.head != n:
				n.set_next(self.head)
				self.head = n
			else:
				n.set_next(None)
			self.reverseRecursive(right)
			
    def printListFromEnd(self, list) :
    	if list == None: 
    		return
    	head = list
    	tail = list.get_next()
    	self.printListFromEnd(tail)
    	print head.get_data(), 	

    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
    
    def isLinkedListLengthEven(self):
        current = self.head
         
        while current != None and current.get_next() != None:
            current = current.get_next().get_next()  
	    
	if current == None:
		return 1
	return 0	

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
     
    linkedlst.printList()
    linkedlst.printListFromEnd(linkedlst.head)
    linkedlst.isLinkedListLengthEven()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.JosephusPosition616
    set output_file "SortListByFrequency.py"

    set template_content '
def getJosephusPosition(n, m):
    class Node:
        def __init__(self, data=None, next=None):
            self.set_data(data)
            self.set_next(next)
        # method for setting the data field of the node    
        def set_data(self, data):
            self.data = data
        # method for getting the data field of the node   
        def get_data(self):
            return self.data
          # method for setting the next field of the node
        def set_next(self, next):
            self.next = next
           # method for getting the next field of the node    
        def get_next(self):
            return self.next
        # returns true if the node points to another node
        def has_next(self):
                return self.next != None
    answer = []

    # initialize circular linked list
    head = Node(0)
    prev = head
    for n in range(1, n):
        currentNode = Node(n)
        prev.set_next(currentNode)
        prev = currentNode
    prev.set_next(head)  # set the last node to point to the front (circular list)

    # extract items from linked list in proper order
    currentNode = head
    counter = 0
    while currentNode.get_next() != currentNode:
        counter += 1
        if counter == m:
            counter = 0
            prev.set_next(currentNode.next)
            answer.append(currentNode.get_data())
        else:
            prev = currentNode
        currentNode = currentNode.get_next()
    
    answer.append(currentNode.get_data())
    return answer
        

print str(getJosephusPosition(6, 3))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.LinketList617
    set output_file "SortListByFrequency.py"

    set template_content '
class Node:
    # constructor
    def __init__(self, data):
        self.data = data
        self.next = None
         # method for setting the data field of the node    
    def set_data(self, data):
        self.data = data
    # method for getting the data field of the node   
    def get_data(self):
        return self.data
      # method for setting the next field of the node
    def set_next(self, next):
        self.next = next
       # method for getting the next field of the node    
    def get_next(self):
        return self.next
    # returns true if the node points to another node
    def has_next(self):
            return self.next != None

# class for defining a linked list   
class LinkedList(object):
     
    # initializing a list
    def __init__(self):
        self.length = 0
        self.head = None
         
    # method to add a node in the linked list
    def addNode(self, node):
        if self.length == 0:
            self.addBeg(node)
        else:
            self.addLast(node)
             
         
    # method to add a node at the beginning of the list with a data   
    def addBeg(self, node):
        newNode = node
        newNode.next = self.head
        self.head = newNode
        self.length += 1
         
    # method to add a node after the node having the data=data. The data of the new node is value2
    def addAfterValue(self, data, node):
        newNode = node
        currentnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                newNode.next = currentnode.next
                currentnode.next = newNode
                self.length = self.length + 1
                return
            else:
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
    # method to add a node at a particular position
    def addAtPos(self, pos, node):
        count = 0
        currentnode = self.head
        previousnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = node
                    node.next = currentnode
                    self.length += 1
                    return
                     
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
               
                 
    # method to add a node at the end of a list
    def addLast(self, node):
        currentnode = self.head
         
        while currentnode.next != None:
            currentnode = currentnode.next
 
        newNode = node
        newNode.next = None
        currentnode.next = newNode
        self.length = self.length + 1
     
     
    # method to delete the first node of the linked list
    def deleteBeg(self):
        if self.length == 0:
            print "The list is empty"
        else:
            self.head = self.head.next
            self.length -= 1
     
    # method to delete the last node of the linked list
    def deleteLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
            previousnode = self.head
             
            while currentnode.next != None:
                previousnode = currentnode
                currentnode = currentnode.next
                 
            previousnode.next = None
             
            self.length -= 1
             
         
    # method to delete a node after the node having the given data
    def deleteValue(self, data):
        currentnode = self.head
        previousnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                previousnode.next = currentnode.next
                self.length -= 1
                return
                    
            else:
                previousnode = currentnode
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
         
         
    # method to delete a node at a particular position
    def deleteAtPos(self, pos):
        count = 0
        currentnode = self.head
        previousnode = self.head
 
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        # to deletle the first position of the linkedlist
        elif pos == 1:
            self.delete_beg()
            self.length -= 1
        else:        
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = currentnode.next
                    self.length -= 1
                    return
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
                     
             
 
     
    # returns the length of the list        
    def getLength(self):
        return self.length
     
    # returns the first element of the list
    def getFirst(self):
        if self.length == 0:
            print "The list is empty"
        else:
            return self.head.data
     
    # returns the last element of the list
    def getLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
             
            while currentnode.next != None:
                currentnode = currentnode.next
                 
            return currentnode.data
     
    # returns node at any position
    def getAtPos(self, pos):
        count = 0
        currentnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    return currentnode.data
                else:
                    currentnode = currentnode.next
 
                     
    # method to print the whole list
    def print_list(self):
        nodeList = []
        currentnode = self.head
        while currentnode != None:
            nodeList.append(currentnode.data)
            currentnode = currentnode.next 
             
        print nodeList  

class BSTNode:
    def __init__(root, data=None):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)  

node1 = Node(1)
node2 = Node(2)
node3 = Node(3)
node4 = Node(4)
node5 = Node(5)
ll = LinkedList()
ll.addNode(node1)
ll.addNode(node2)
ll.addNode(node3)
ll.addNode(node4)
ll.addNode(node5)
ll.print_list()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LinkedListAddingNumbers618
    set output_file "LinkedListAddingNumbers..py"

    set template_content '
class AddingListNumbers:
    def addTwoNumbers(self, list1, list2):
        if list1 == None:
            return list2
        if list2 == None:
            return list1
        
        len1 = 0
        len2 = 0
        
        head = list1
        while head != None:
            len1 += 1
            head = head.next
        
        head = list2
        while head != None:
            len2 += 1
            head = head.next
        
        if len1 >= len2:
            longer = list1
            shorter = list2
        else:
            longer = list2;
            shorter = list1
        
        sum = None
        
        carry = 0
        
        while shorter != None:
            value = longer.data + shorter.data + carry
            carry = value / 10
            value -= carry * 10
            
            if sum == None:
                sum = Node(value)
                result = sum
            else:
                sum.next = Node(value)
                sum = sum.next
                
            longer = longer.next
            shorter = shorter.next
            
        while longer != None:
            value = longer.data + carry
            carry = value / 10
            value -= carry * 10
            
            sum.next = Node(value)
            sum = sum.next
            
            longer = longer.next
            
        if carry != 0:
            sum.next = Node(carry)
        
        return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.LinkedListSortingWithMergeSort619
    set output_file "LinkedListSortingWithMergeSort.py"

    set template_content '
class ListNode:
	def __init__(self, x):
		self.data = x
		self.next = None

class LinkedListSortWithMergeSort:
    # @param head, a ListNode
    # @return a ListNode
    def sortList(self, head):
        if head == None:
            return None
        counter = 0 
        temp = head
        while temp != None:
            temp = temp.next
            counter += 1
        return self.sort(head, counter)
        
    def sort(self, head, size):
        if size == 1:
            return head
        list2 = head
        for i in range(0, size // 2):
            list2 = list2.next
        list1 = self.sort(head, size // 2)
        list2 = self.sort(list2, size - size // 2)
        return self.merge(list1, size // 2, list2, size - size // 2)
        
    def merge(self, list1, sizeList1, list2, sizeList2):
        dummy = ListNode(0)
        list = dummy
        pointer1 = 0
        pointer2 = 0
        while pointer1 < sizeList1 and pointer2 < sizeList2:
            if list1.data < list2.data:
                list.next = list1
                list1 = list1.next
                pointer1 += 1
            else:
                list.next = list2
                list2 = list2.next
                pointer2 += 1
            list = list.next
        while pointer1 < sizeList1:
            list.next = list1
            list1 = list1.next
            pointer1 += 1
            list = list.next
        while pointer2 < sizeList2:
            list.next = list2
            list2 = list2.next
            pointer2 += 1
            list = list.next
        list.next = None
        return dummy.next
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.MergeSecondListToFirst620
    set output_file "MergeSecondListToFirst.py"

    set template_content '
def Merge(A, m, B, n):
	i = n - 1
	j = k = m - 1
	while k >= 0:
		if(B[i] > A[j] or j < 0):
			A[k] = B[i]
			i -= 1
			if(i < 0):
				break
		else:
			A[k] = A[j]
			j -= 1
		k -= 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.MergeTwoLists621
    set output_file "SortListByFrequency.py"

    set template_content '
def mergeTwoLists(self, list1, list2):
	temp = Node()
	pointer = temp
	while list1 != None and list2 != None:
	    if list1.get_data() < list2.get_data():
		pointer.set_next(list1)
		list1 = list1.get_next()
	    else:
		pointer.set_next(list2)
		list2 = list2.get_next()
	    pointer = pointer.get_next()
	if list1 == None:
	    pointer.set_next(list2)
	else:
	    pointer.set_next(list1)
	return temp.get_next()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.MergeTwoSortedLists622
    set output_file "MergeTwoSortedLists.py"

    set template_content '
def mergeTwoSortedLists(self, list1, list2):
	temp = Node(0)
	pointer = temp
	while list1 != None and list2 != None:
	    if list1.get_data() < list2.get_data():
		pointer.set_next(list1)
		list1 = list1.get_next()
	    else:
		pointer.set_next(list2)
		list2 = list2.get_next()
	    pointer = pointer.get_next()
	if list1 == None:
	    pointer.set_next(list2)
	else:
	    pointer.set_next(list1)
	return temp.get_next()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ModularNodeFromBegin623
    set output_file " ModularNodeFromBegin.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
	
    def modularNodeFromBegin(self, k):
		currentNode = self.head
		modularNode = None
		i = 1
		if k <= 0:
			return None;
		while currentNode != None:
			if i % k == 0:
				modularNode = currentNode		
			i = i + 1
			currentNode = currentNode.get_next()
		print (modularNode.get_data())

    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
    linkedlst.modularNodeFromBegin(3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.ModularNodeFromEnd624
    set output_file "SortListByFrequency.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
	
    def modularNodeFromBegin(self, k):
		currentNode = self.head
		modularNode = None
		i = 1
		if k <= 0:
			return None;
		while currentNode != None:
			if i % k == 0:
				modularNode = currentNode		
			i = i + 1
			currentNode = currentNode.get_next()
		print (modularNode.get_data())
		
    def modular_node_from_end(self, k):
		currentNode = self.head
		modularNode = self.head
		i = 1
		if k <= 0:
			return None;
		
		while i < k and currentNode != None:
			i = i + 1
			currentNode = currentNode.get_next()
		
		if currentNode == None:
			return
		while currentNode != None:
			modularNode = modularNode.get_next()		
			currentNode = currentNode.get_next()

		print (modularNode.get_data())
			
    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
    linkedlst.modular_node_from_end(4)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.nthNodeFromEnd625
    set output_file "nthNodeFromEnd.py"

    set template_content '
def nthNodeFromEnd(self, n):
    if 0 > n:
      return None
 
    # count k units from the self.head.
    temp = self.head
    count = 0
    while count < n and None != temp:
      temp = temp.next
      count += 1
 
    # if the LinkedList does not contain k elements, return None
    if count < n or None == temp:
      return None
 
    # keeping tab on the nth element from temp, slide temp until
    # temp equals self.tail. Then return the nth element.
    nth = self.head
    while None != temp.next:
      temp = temp.next
      nth = nth.next
 
    return nth
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.OrderedInsertLinkedList626
    set output_file "OrderedInsertLinkedList.py"

    set template_content '
def orderedInsert(self, item):
    current = self.head
    previous = None
    stop = False
    while current != None and not stop:
        if current.get_data() > item:
            stop = True
        else:
            previous = current
            current = current.get_next()

    temp = Node(item)
    if previous == None:
        temp.set_next(self.head)
        self.head = temp
    else:
        temp.set_next(current)
        previous.set_next(temp)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.PrintListFromEndRecursive627
    set output_file "SortListByFrequency.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
    
    def recursiveReverseList(self) :
		self.reverseRecursive(self.head)
		
    def reverseRecursive(self, n) :
		if None != n:
			right = n.get_next()
			if self.head != n:
				n.set_next(self.head)
				self.head = n
			else:
				n.set_next(None)
			self.reverseRecursive(right)
			
    def printListFromEnd(self, list) :
    	if list == None: 
    		return
    	head = list
    	tail = list.get_next()
    	self.printListFromEnd(tail)
    	print head.get_data(), 	

    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
             
	

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
     
    linkedlst.printList()
    linkedlst.printListFromEnd(linkedlst.head)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.PrintReverse628
    set output_file " PrintReverse.py"

    set template_content '
class ListNode:
    def __init__(self, value):
        self.data = value
        self.next = None

    def get_data(self):
        return self.data

    def get_next(self):
        return self.next

    def set_data(self, value):
        self.data = value

    def set_next(self, newnext):
        self.next = newnext
	
def ListLength(self):
    current = self.head
    count = 0
    while current != None:
        count = count + 1
        current = current.get_next()

    return count	
    
    def insert(self, position, value):
        sentinel = self.sentinel
        newNode = ListNode(value)
        size = len(self)
        if size == 0:
            self.insert_between(newNode, sentinel, sentinel)
        elif position >= 0 and position < size:
            node = self.get_node(position)   
            self.insert_between(newNode, node.prev, node)
        elif position == size:
            self.insert_between(newNode, sentinel.prev, sentinel)
        else:
            raise positionError
        self.size += 1
                
    def insert_between(self, node, leftNode, rightNode):
        if node and leftNode and rightNode:
            node.prev = leftNode
            node.next = rightNode
            leftNode.next = node
            rightNode.prev = node
        else:
            raise positionError
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.QuickSortWithLinkedLists629
    set output_file "QuickSortWithLinkedLists.py"

    set template_content '
class ListNode:
	def __init__(self, x):
		self.data = x
		self.next = None

def Qsort(first, last):
	lesHEAD = lesTAIL = None
	equHEAD = equTAIL = None
	larHEAD = larTAIL = None
	current = first
	if(current == None):
		return
	pivot = current.data
	Append(current, equHEAD, equTAIL)
	while (current != None):
		info = current.data
		if(info < pivot):
			Append(current, lesHEAD, lesTAIL)
		elif(info > pivot):
			Append(current, larHEAD, larTAIL)
		else:
			Append(current, equHEAD, equTAIL)
	
	Quicksort(lesHEAD, lesTAIL)
	Quicksort(larHEAD, larTAIL)
	Join(lesHEAD, lesTAIL, equHEAD, equTAIL)
	Join(lesHEAD, equTAIL, larHEAD, larTAIL)
	first = lesHEAD
	last = larTAIL
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.ReorderList630
    set output_file "ReorderList.py"

    set template_content '
def oddeven(A):
    "Odd-Even sort implementation"
    sorted = False
    while(not sorted):
        sorted = True
        for i in range(1, len(A) - 1, 2):
            if A[i] > A[i + 1]:
                A[i], A[i + 1] = A[i + 1], A[i]
                sorted = False
        for i in range(0, len(A) - 1, 2):
            if A[i] > A[i + 1]:
                A[i], A[i + 1] = A[i + 1], A[i]
                sorted = False
        if not sorted:
            print A
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end






function algoP.ReverseInPairs631
    set output_file "ReverseInPairs.py"

    set template_content '
def reverseInPairs(self) :
    temp = self.head
    while None != temp and None != temp.get_next():
      self.swapData(temp, temp.get_next())
      temp = temp.get_next().get_next()
 
  def swapData(self, a, b):
    tmp = a.get_data()
    a.set_data(b.get_data())
    b.set_data(tmp)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.ReverseKBlock632
    set output_file "ReverseKBlock.py"

    set template_content '
def reverseKBlock(self, head, k):
        temp = Node(0);
        temp.set_next(head)
        previous = temp
        while True:
            begin = previous.get_next()
            end = previous
            for i in range(0, k):
                end = end.get_next()
                if end == None:
                    return temp.get_next()
            nextBlock = end.get_next()
            self.reverseList(begin, end)
            previous.set_next(end)
            begin.set_next(nextBlock)
            previous = begin
        
def reverseList(self, start, end):
	alreadyReversed = start
	actual = start
	nextNode = start.get_next()
	while actual != end:
	    actual = nextNode
	    nextNode = nextNode.get_next()
	    actual.set_next(alreadyReversed)
	    alreadyReversed = actual
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.ReverseListIterative633
    set output_file "ReverseListIterative.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
         
    def isEmpty(self):
        return self.head == None
   
    def reverseList(self):
	last = None
	current = self.head
	
	while(current is not None):
		nextNode = current.get_next()
		current.set_next(last) 
		last = current
		current = nextNode
	
	self.head = last 
       
    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
             
	

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
     
    linkedlst.printList()
    linkedlst.reverseList()
    linkedlst.printList()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.ReverseListRecursive634
    set output_file "ReverseListRecursive.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
    
    def recursiveReverseList(self) :
		self.reverseRecursive(self.head)
		
    def reverseRecursive(self, n) :
	if None != n:
		right = n.get_next()
		if self.head != n:
			n.set_next(self.head)
			self.head = n
		else:
			n.set_next(None)
		self.reverseRecursive(right)

    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)
         
    def printList(self):
        current = self.head
         
        while current != None:
            print current.get_data()
            current = current.get_next()
             
	

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
     
    linkedlst.printList()
    linkedlst.recursiveReverseList()
    linkedlst.printList()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.RotateList635
    set output_file "RotateList.py"

    set template_content '
def rotateList(A, K):
    n = K % len(A)
    word = A[::-1]
    return A[n:] + word[len(A) - n:]
A = [7, 3, 2, 3, 3, 6, 3]
print A, rotateList(A, 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.SkipLists636
    set output_file " SkipLists.py"

    set template_content '
import random
import math

class Node(object):
    def __init__(self, data, level=0):
        self.data = data
        self.next = [None] * level
    
    def __str__(self):
        return "Node(%s,%s)" % (self.data, len(self.next))
    __repr__ = __str__
    
class SkipList(object):
    def __init__(self, max_level=8):
        self.max_level = max_level
        n = Node(None, max_level)
        self.head = n
        self.verbose = False

    def randomLevel(self, max_level):
        num = random.randint(1, 2 ** max_level - 1)
        lognum = math.log(num, 2)
        level = int(math.floor(lognum))
        return max_level - level
    
    def updateList(self, data):
        update = [None] * (self.max_level)
        n = self.head
        
        self._n_traverse = 0
        
        level = self.max_level - 1
        while level >= 0:
            if self.verbose and \
                n.next[level] != None and n.next[level].data >= data:
                print 'DROP down from level', level + 1
            while n.next[level] != None and n.next[level].data < data:
                self._n_traverse += 1
                if self.verbose:
                    print 'AT level', level, 'data', n.next[level].data
                n = n.next[level]
            update[level] = n
            level -= 1

        return update
    
    def find(self, data, update=None):
        if update is None:
            update = self.updateList(data)
                        
        if len(update) > 0:
            candidate = update[0].next[0]
            if candidate != None and candidate.data == data:
                return candidate
        return None
    
    def insertNode(self, data, level=None):
        if level is None:
            level = self.randomLevel(self.max_level)
            
        node = Node(data, level)
        
        update = self.updateList(data)
        if self.find(data, update) == None:
            for i in range(level):
                node.next[i] = update[i].next[i]
                update[i].next[i] = node
    
def printLevel(sl, level):
    print 'level %d:' % level,
    node = sl.head.next[level]
    while node:
        print node.data, '=>',
        node = node.next[level]
    print 'END'

x = SkipList(4)
for i in range(0, 20, 2):
    x.insertNode(i)

printLevel(x, 0)
printLevel(x, 1)
printLevel(x, 2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SortedLinikedListToBST637
    set output_file " SortedLinikedListToBST.py"

    set template_content '
class Node:
    # constructor
    def __init__(self, data):
        self.data = data
        self.next = None
         # method for setting the data field of the node    
    def set_data(self, data):
        self.data = data
    # method for getting the data field of the node   
    def get_data(self):
        return self.data
      # method for setting the next field of the node
    def set_next(self, next):
        self.next = next
       # method for getting the next field of the node    
    def get_next(self):
        return self.next
    # returns true if the node points to another node
    def has_next(self):
            return self.next != None

# class for defining a linked list   
class LinkedList(object):
     
    # initializing a list
    def __init__(self):
        self.length = 0
        self.head = None
         
    # method to add a node in the linked list
    def addNode(self, node):
        if self.length == 0:
            self.addBeg(node)
        else:
            self.addLast(node)
             
         
    # method to add a node at the beginning of the list with a data   
    def addBeg(self, node):
        newNode = node
        newNode.next = self.head
        self.head = newNode
        self.length += 1
         
    # method to add a node after the node having the data=data. The data of the new node is value2
    def addAfterValue(self, data, node):
        newNode = node
        currentnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                newNode.next = currentnode.next
                currentnode.next = newNode
                self.length = self.length + 1
                return
            else:
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
    # method to add a node at a particular position
    def addAtPos(self, pos, node):
        count = 0
        currentnode = self.head
        previousnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = node
                    node.next = currentnode
                    self.length += 1
                    return
                     
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
         
         
                 
    # method to add a node at the end of a list
    def addLast(self, node):
        currentnode = self.head
         
        while currentnode.next != None:
            currentnode = currentnode.next
 
        newNode = node
        newNode.next = None
        currentnode.next = newNode
        self.length = self.length + 1
     
     
    # method to delete the first node of the linked list
    def deleteBeg(self):
        if self.length == 0:
            print "The list is empty"
        else:
            self.head = self.head.next
            self.length -= 1
     
    # method to delete the last node of the linked list
    def deleteLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
            previousnode = self.head
             
            while currentnode.next != None:
                previousnode = currentnode
                currentnode = currentnode.next
                 
            previousnode.next = None
             
            self.length -= 1
             
         
    # method to delete a node after the node having the given data
    def deleteValue(self, data):
        currentnode = self.head
        previousnode = self.head
         
        while currentnode.next != None or currentnode.data != data:
            if currentnode.data == data:
                previousnode.next = currentnode.next
                self.length -= 1
                return
                    
            else:
                previousnode = currentnode
                currentnode = currentnode.next
                 
        print "The data provided is not present"
                 
         
         
    # method to delete a node at a particular position
    def deleteAtPos(self, pos):
        count = 0
        currentnode = self.head
        previousnode = self.head
 
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:        
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    previousnode.next = currentnode.next
                    self.length -= 1
                    return
                else:
                    previousnode = currentnode
                    currentnode = currentnode.next
                     
             
 
     
    # returns the length of the list        
    def getLength(self):
        return self.length
     
    # returns the first element of the list
    def getFirst(self):
        if self.length == 0:
            print "The list is empty"
        else:
            return self.head.data
     
    # returns the last element of the list
    def getLast(self):
         
        if self.length == 0:
            print "The list is empty"
        else:
            currentnode = self.head
             
            while currentnode.next != None:
                currentnode = currentnode.next
                 
            return currentnode.data
     
    # returns node at any position
    def getAtPos(self, pos):
        count = 0
        currentnode = self.head
         
        if pos > self.length or pos < 0:
            print "The position does not exist. Please enter a valid position"
        else:
            while currentnode.next != None or count < pos:
                count = count + 1
                if count == pos:
                    return currentnode.data
                else:
                    currentnode = currentnode.next
 
                     
    # method to print the whole list
    def printList(self):
        nodeList = []
        currentnode = self.head
        while currentnode != None:
            nodeList.append(currentnode.data)
            currentnode = currentnode.next 
             
        print nodeList  

class BSTNode:
    def __init__(root, data=None):
        root.left = None
        root.right = None
        root.data = data

def insertNode(root, node):
    if root is None:
        root = node
    else:
        if root.data > node.data:
            if root.left == None:
                root.left = node
            else:
                insertNode(root.left, node)
        else:
            if root.right == None:
                root.right = node
            else:
                insertNode(root.right, node)

def deleteNode(root, data):
	""" delete the node with the given data and return the root node of the tree """	    
	if root.data == data:
		# found the node we need to delete
		if root.right and root.left: 
			# get the successor node and its parent 
			[psucc, succ] = findMin(root.right, root)
			# splice out the successor
			# (we need the parent to do this) 
			if psucc.left == succ:
				psucc.left = succ.right
			else:
				psucc.right = succ.right					
			# reset the left and right children of the successor
			succ.left = root.left
			succ.right = root.right
			return succ                
		else:
			# "easier" case
			if root.left:
				return root.left  # promote the left subtree
			else:
				return root.right  # promote the right subtree 
	else:
		if root.data > data:  # data should be in the left subtree
			if root.left:
				root.left = deleteNode(root.left, data)
			# else the data is not in the tree 
		else:  # data should be in the right subtree
			if root.right:
				root.right = deleteNode(root.right, data)
	return root

def findMin(root, parent):
	""" return the minimum node in the current tree and its parent """
	# we use an ugly trick: the parent node is passed in as an argument
	# so that eventually when the leftmost child is reached, the 
	# call can return both the parent to the successor and the successor
	if root.left:
		return findMin(root.left, root)
	else:
		return [parent, root]

def inOrderTraversal(root):
    if not root:
        return
    inOrderTraversal(root.left)
    print root.data
    inOrderTraversal(root.right)

def preOrderTraversal(root):
    if not root:
        return        
    print root.data
    preOrderTraversal(root.left)
    preOrderTraversal(root.right)  

def SortedListToBST(ll, start, end):
	if(start > end): 
		return None
	# same as (start+end)/2, avoids overflow
	mid = start + (end - start) // 2
	left = SortedListToBST(ll, start, mid - 1)
	root = BSTNode(ll.head.data)
	ll.deleteBeg()
	root.left = left
	root.right = SortedListToBST(ll, mid + 1, end)
	return root

def convertSortedListToBST(ll, n) :
	return SortedListToBST(ll, 0, n - 1)

node1 = Node(1)
node2 = Node(2)
node3 = Node(3)
node4 = Node(4)
node5 = Node(5)
node6 = Node(6)
node7 = Node(7)
node8 = Node(8)
node9 = Node(9)
ll = LinkedList()
ll.addNode(node1)
ll.addNode(node2)
ll.addNode(node3)
ll.addNode(node4)
ll.addNode(node5)
ll.addNode(node6)
ll.addNode(node7)
ll.addNode(node8)
ll.addNode(node9)
ll.printList()
root = convertSortedListToBST(ll, ll.length)                    
inOrderTraversal(root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SplitList638
    set output_file "SplitList.py"

    set template_content '
class Node:
    # constructor
    def __init__(self):
        self.data = None
        self.next = None
         # method for setting the data field of the node    
    def set_data(self, data):
        self.data = data
    # method for getting the data field of the node   
    def get_data(self):
        return self.data
      # method for setting the next field of the node
    def set_next(self, next):
        self.next = next
       # method for getting the next field of the node    
    def get_next(self):
        return self.next
    # returns true if the node points to another node
    def has_next(self):
            return self.next != None
	    
def _splitList(head):
    fast = head
    slow = head
    while fast and fast.next:
        slow = slow.get_next()
        fast = fast.get_next()
        fast = fast.get_next()

    middle = slow.get_next()
    slow.set_next(None)

    return head, middle

# Reverses in place a list.
# @return Returns the head of the new reversed list
def _reverseList(head):

  last = None
  currentNode = head

  while currentNode:
    nextNode = currentNode.get_next()
    currentNode.set_next(last)
    last = currentNode
    currentNode = nextNode

  return last

# Merges in place two lists
def _mergeLists(a, b):
    tail = a
    head = a
    a = a.get_next()
    while b:
        tail.set_next(b)
        tail = tail.get_next()
        b = b.get_next()
        if a:
            a, b = b, a
    return head

class Solution:
    # @param head, a ListNode
    # @return nothing
    def reorderList(self, head):
        if not head or not head.next:
            return
        a, b = _splitList(head)
        b = _reverseList(b)
        head = _mergeLists(a, b)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.SqrtNodes639
    set output_file "SqrtNodes.py"

    set template_content '
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None
         
    def set_data(self, data):
        self.data = data
     
    def get_data(self):
        return self.data
     
    def set_next(self, next):
        self.next = next
         
    def get_next(self):
        return self.next
     
     
class LinkedList:
    def __init__(self):
        self.head = None
	
    def sqrtNodes(self):
	sqrtNode = None
	currentNode = self.head
	i = j = 1
	while currentNode != None:
		if i == j * j:
			if sqrtNode == None:
				sqrtNode = self.head
			else:
				sqrtNode = sqrtNode.get_next()
			j = j + 1
		i = i + 1
		currentNode = currentNode.get_next()
		
	print (sqrtNode.get_data())
			
    def insertAtEnd(self, item):
        current = self.head
        if  current == None:
            node = Node(item)
            node.set_next(None)
            self.head = node
            return
            
        while current.get_next() != None:
            current = current.get_next()
             
        node = Node(item)
        current.set_next(node)

if __name__ == "__main__":
    linkedlst = LinkedList()
    linkedlst.insertAtEnd(1)
    linkedlst.insertAtEnd(2)
    linkedlst.insertAtEnd(3)
    linkedlst.insertAtEnd(4)
    linkedlst.insertAtEnd(5)
    linkedlst.insertAtEnd(11)
    linkedlst.insertAtEnd(12)
    linkedlst.insertAtEnd(13)
    linkedlst.insertAtEnd(14)
    linkedlst.insertAtEnd(15)
    
    linkedlst.sqrtNodes()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.UnrolledLists640
    set output_file " UnrolledLists.py"

    set template_content '
class Node:
	# constructor
	def __init__(self):
		self.value = None
		self.next = None

# Node of a Singly Linked List
class LinkedBlock:
	# constructor
	def __init__(self):
		self.head = None
		self.next = None
		nodeCount = 0
		
blockSize = 2
blockHead = None

# create an empty block
def newLinkedBlock():
	block = LinkedBlock()
	block.next = None
	block.head = None
	block.nodeCount = 0
	return block

# create a node 
def newNode(value):
	temp = Node()
	temp.next = None
	temp.value = value
	return temp

def searchElements(blockHead, k):
	# find the block 
	j = (k + blockSize - 1) // blockSize  # k-th node is in the j-th block 
	p = blockHead
	j -= 1
	while(j):
		p = p.next 
		j -= 1

	fLinkedBlock = p

	# find the node
	q = p.head
	k = k % blockSize
	if(k == 0):
		k = blockSize
	k = p.nodeCount + 1 - k
	k -= 1
	while (k):
		q = q.next
		k -= 1

	fNode = q
	
	return fLinkedBlock, fNode

# start shift operation from block *p 
def shift(A):
	B = A
	global blockHead	
	while(A.nodeCount > blockSize):  # if this block still have to shift
		if(A.next == None):  # reach the end. A little different
			A.next = newLinkedBlock()
			B = A.next
			temp = A.head.next
			A.head.next = A.head.next.next
			B.head = temp
			temp.next = temp
			A.nodeCount -= 1
			B.nodeCount += 1
		else:
			B = A.next
			temp = A.head.next			
			A.head.next = A.head.next.next	
			temp.next = B.head.next	
			B.head.next = temp		
			B.head = temp
			A.nodeCount -= 1			
			B.nodeCount += 1
        
	A = B

def addElement(k, x):
	global blockHead
	r = newLinkedBlock()
	p = Node() 

	if(blockHead == None):  # initial, first node and block
		blockHead = newLinkedBlock()
		blockHead.head = newNode(x)
		blockHead.head.next = blockHead.head
		blockHead.nodeCount += 1
	else:
		if(k == 0):  # special case for k=0. 
			p = blockHead.head
			q = p.next
			p.next = newNode(x)
			p.next.next = q
			blockHead.head = p.next
			blockHead.nodeCount += 1
			shift(blockHead)
		else:
			r, p = searchElements(blockHead, k)
			q = p
			while(q.next != p):
				q = q.next
			q.next = newNode(x)
			q.next.next = p
			r.nodeCount += 1
			shift(r)
        
	return blockHead
	
def searchElement(blockHead, k):
    q, p = searchElements(blockHead, k)
    return p.value


blockHead = addElement(0, 11)
blockHead = addElement(0, 21)
blockHead = addElement(1, 19)
blockHead = addElement(1, 23)
blockHead = addElement(2, 16)
blockHead = addElement(2, 35)
searchElement(blockHead, 1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.ReverseQueueFirstKElements641
    set output_file "ReverseQueueFirstKElements.py"

    set template_content '
import math
import fractions 
class Stack(object):
	def __init__(self, limit=10):
		self.stk = []
		self.limit = limit	
	def isEmpty(self):
		return len(self.stk) <= 0

	def push(self, item):
		if len(self.stk) >= self.limit:
			print 'Stack Overflow!'
		else:
			self.stk.append(item)
		print 'Stack after Push', self.stk

	def pop(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk.pop()
			
	def peek(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk[-1]
			
	def size(self):
		return len(self.stk)

# Node of a Singly Linked List
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0			
  
def reverseQueueFirstKElements(que, k):
     stk = Stack()
     if que == None or k > que.size:
	     return
     for i in range(0, k):
          stk.push(que.deQueue())
     while not stk.isEmpty():
          que.enQueue(stk.pop())
     for i in range(0, que.size - k):
          que.enQueue(que.deQueue())

que = Queue()
que.enQueue(11)
que.enQueue(12)
que.enQueue(13)
que.enQueue(14)
que.enQueue(15)
que.enQueue(16)
que.enQueue(17)
que.enQueue(18)
que.enQueue(19)
que.enQueue(20)
que.enQueue(21)
que.enQueue(22)

reverseQueueFirstKElements(que, 4)	  

while not que.isEmpty():
    print que.deQueue()   
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ReverseQueueWithStack642
    set output_file "ReverseQueueWithStack.py"

    set template_content '
class Stack(object):
	def __init__(self, limit=10):
		self.stk = []
		self.limit = limit	
	def isEmpty(self):
		return len(self.stk) <= 0

	def push(self, item):
		if len(self.stk) >= self.limit:
			print 'Stack Overflow!'
		else:
			self.stk.append(item)
		print 'Stack after Push', self.stk

	def pop(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk.pop()
			
	def peek(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk[-1]
			
	def size(self):
		return len(self.stk)

# Node of a Singly Linked List
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0		
	    
que = Queue()
for i in xrange(5):
    que.enQueue(i)
    
# suppose your have a Queue my_queue
aux_stack = Stack()
while not que.isEmpty():
    aux_stack.push(que.deQueue())

while not aux_stack.isEmpty():
    que.enQueue(aux_stack.pop())
    
for i in xrange(5):
    print que.deQueue()   
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.StackWithQueues643
    set output_file "StackWithQueues.py"

    set template_content '
class Queue(object): 
	def __init__(self): 
		self.queue = [] 
		
	def isEmpty(self): 
		return self.queue == [] 
		
	def enqueue(self, x): 
		self.queue.append(x) 
		
	def dequeue(self): 
		if self.queue: 
			a = self.queue[0] 
			self.queue.remove(a) 
			return a 
		else: 
			raise IndexError, 'queue is empty' 
			
	def size(self): 
		return len(self.queue) 

class Stack(object): 
	def __init__(self): 
		self.Q1 = Queue() 
		self.Q2 = Queue() 
		
	def isEmpty(self): 
		return self.Q1.isEmpty() and self.Q2.isEmpty() 
		
	def push(self, item): 
		if self.Q2.isEmpty(): 
			self.Q1.enqueue(item) 
		else: 
			self.Q2.enqueue(item) 
			
	def pop(self): 
		if self.isEmpty(): 
			raise IndexError, 'stack is empty' 
		elif self.Q2.isEmpty(): 
			while not self.Q1.isEmpty(): 
				cur = self.Q1.dequeue() 
				if self.Q1.isEmpty(): 
					return cur 
				self.Q2.enqueue(cur) 
		else: 
			while not self.Q2.isEmpty(): 
				cur = self.Q2.dequeue() 
				if self.Q2.isEmpty(): 
					return cur 
				self.Q1.enqueue(cur)

s = Stack()
for i in xrange(5):
    s.push(i)
for i in xrange(5):
    print s.pop()  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.QueueWithDynamicSizeArray644
    set output_file "QueueWithDynamicSizeArray.py"

    set template_content '
class Queue(object):
	def __init__(self, limit=5):
		self.que = []
		self.limit = limit
		self.front = None
		self.rear = None
		self.size = 0		

	def isEmpty(self):
		return self.size <= 0

	def enQueue(self, item):
		if self.size >= self.limit:
			self.resize()

		self.que.append(item)
			
		if self.front is None:	
			self.front = self.rear = 0
		else:
			self.rear = self.size
		self.size += 1
		print 'Queue after enQueue', self.que
		
	def deQueue(self):
		if self.size <= 0:
			print 'Queue Underflow!'
			return 0
		else:
			self.que.pop(0)
			self.size -= 1
			if self.size == 0:
				self.front = self.rear = None	
			else:
				self.rear = self.size - 1
			print 'Queue after deQueue', self.que
			
	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.que[self.rear]

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.que[self.front]
			
	def size(self):
		return self.size

	def resize(self):
		newQue = list(self.que)
		self.limit = 2 * self.limit 
		self.que = newQue

que = Queue()
que.enQueue("first")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("second")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("third")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("four")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("five")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("six")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.deQueue()
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.deQueue()
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.QueueWithFixedSizeArray645
    set output_file "QueueWithFixedSizeArray.py"

    set template_content '
class Queue(object):
	def __init__(self, limit=5):
		self.que = []
		self.limit = limit
		self.front = None
		self.rear = None
		self.size = 0		

	def isEmpty(self):
		return self.size <= 0

	def enQueue(self, item):
		if self.size >= self.limit:
			print 'Queue Overflow!'
			return
		else:
			self.que.append(item)
			
		if self.front is None:	
			self.front = self.rear = 0
		else:
			self.rear = self.size
		self.size += 1
		print 'Queue after enQueue', self.que
		
	def deQueue(self):
		if self.size <= 0:
			print 'Queue Underflow!'
			return 0
		else:
			self.que.pop(0)
			self.size -= 1
			if self.size == 0:
				self.front = self.rear = None	
			else:
				self.rear = self.size - 1
			print 'Queue after deQueue', self.que
			
	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.que[self.rear]

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.que[self.front]
			
	def size(self):
		return self.size

que = Queue()
que.enQueue("first")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("second")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("third")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.deQueue()
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.deQueue()
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.QueueWithStacks646
    set output_file "QueueWithStacks.py"

    set template_content '
class Queue(object):
    def __init__(self):
        self.S1 = []
        self.S2 = []
     
    def enqueue(self, data):
        self.S1.append(data)
    
    def dequeue(self):
        if not self.S2:
            while self.S1:
                self.S2.append(self.S1.pop())
        return self.S2.pop() 
	    
q = Queue()
for i in xrange(5):
    q.enqueue(i)
for i in xrange(5):
    print q.dequeue() 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.QueuesWithLinkedLists647
    set output_file "QueuesWithLinkedLists.py"

    set template_content '
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
	
que = Queue()
que.enQueue("first")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("second")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
que.enQueue("third")
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
print "Dequeuing: " + que.deQueue()
print "Front: " + que.queueFront()
print "Rear: " + que.queueRear()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ProducerConsumerQueues648
    set output_file "ProducerConsumerQueues.py"

    set template_content '
from random import randint
from time import sleep
from Queue import Queue
from myThread import MyThread

def writeQ(queue):
	print 'producing object for Q...',
	queue.put('MONK', 1)
	print "size now", queue.qsize()

def readQ(queue):
	val = queue.get(1)
	print 'consumed object from Q... size now', queue.qsize()

def producer(queue, loops):
	for i in range(loops):
	   writeQ(queue)
	   sleep(randint(1, 3))

def consumer(queue, loops):
	for i in range(loops):
	   readQ(queue)
	   sleep(randint(2, 5))

funcs = [producer, consumer]
nfuncs = range(len(funcs))

nloops = randint(2, 5)
q = Queue(32)

threads = []
for i in nfuncs:
   t = MyThread(funcs[i], (q, nloops),
       funcs[i].__name__)
   threads.append(t)

for i in nfuncs:
   threads[i].start()

for i in nfuncs:
   threads[i].join()

print 'all DONE'
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Producerconsumer649
    set output_file "Producerconsumer.py"

    set template_content '
from Queue import Queue

import threading
import random
import time

class ProduceToQueue(threading.Thread):
   def __init__(self, threadName, queue):
      threading.Thread.__init__(self, name=threadName)
      self.sharedObject = queue
      
   def run(self):
      for i in range(11, 21):
         time.sleep(random.randrange(4))
         print "%s adding %s to queue" % (self.getName(), i)
         self.sharedObject.put(i)

      print self.getName(), "finished producing values"
      print "Terminating", self.getName()

class ConsumeFromQueue(threading.Thread):
   def __init__(self, threadName, queue):
      threading.Thread.__init__(self, name=threadName)
      self.sharedObject = queue

   def run(self):
      sum = 0
      current = 10

      for i in range(10):
         time.sleep(random.randrange(4))
         print "%s attempting to read %s..." % (self.getName(), current + 1)
         current = self.sharedObject.get()
         print "%s read %s" % (self.getName(), current)
         sum += current

      print "%s retrieved values totaling: %d" % (self.getName(), sum)
      print "Terminating", self.getName()

queue = Queue()
producer = ProduceToQueue("Producer", queue)
consumer = ConsumeFromQueue("Consumer", queue)

producer.start()
consumer.start()

producer.join()
consumer.join()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.Dequeue650
    set output_file "Dequeue.py"

    set template_content '
class Deque:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def addFront(self, item):
        self.items.append(item)

    def addRear(self, item):
        self.items.insert(0, item)

    def removeFront(self):
        return self.items.pop()

    def removeRear(self):
        return self.items.pop(0)

    def size(self):
        return len(self.items)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.InterLeavingQueue651
    set output_file "InterLeavingQueue.py"

    set template_content '
import math
import fractions 
class Stack(object):
	def __init__(self, limit=10):
		self.stk = []
		self.limit = limit	
	def isEmpty(self):
		return len(self.stk) <= 0

	def push(self, item):
		if len(self.stk) >= self.limit:
			print 'Stack Overflow!'
		else:
			self.stk.append(item)
		print 'Stack after Push', self.stk

	def pop(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk.pop()
			
	def peek(self):
		if len(self.stk) <= 0:
			print 'Stack Underflow!'
			return 0
		else:
			return self.stk[-1]
			
	def size(self):
		return len(self.stk)

# Node of a Singly Linked List
class Node:
	# constructor
	def __init__(self, data=None, next=None):
		self.data = data
		self.last = None
		self.next = next
	# method for setting the data field of the node    
	def set_data(self, data):
		self.data = data
	# method for getting the data field of the node   
	def get_data(self):
		return self.data
	# method for setting the next field of the node
	def set_next(self, next):
		self.next = next
	# method for getting the next field of the node    
	def get_next(self):
		return self.next
	# method for setting the last field of the node
	def setLast(self, last):
		self.last = last
	# method for getting the last field of the node    
	def getLast(self):
		return self.last	
	# returns true if the node points to another node
	def has_next(self):
		return self.next != None


class Queue(object):
	def __init__(self, data=None):
		self.front = None
		self.rear = None
		self.size = 0

	def enQueue(self, data):
		self.lastNode = self.front
		self.front = Node(data, self.front)
		if self.lastNode:
			self.lastNode.setLast(self.front)
		if self.rear is None:
			self.rear = self.front
		self.size += 1

	def queueRear(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.rear.get_data()

	def queueFront(self):
		if self.front is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		return self.front.get_data()

	def deQueue(self):
		if self.rear is None:
			print "Sorry, the queue is empty!"
			raise IndexError
		result = self.rear.get_data()
		self.rear = self.rear.last
		self.size -= 1
		return result

	def size(self):
		return self.size
		
	def isEmpty(self):
		return self.size == 0			
  
def interLeavingQueue(que):
     stk = Stack()
     halfSize = que.size // 2
     for i in range(0, halfSize):
          stk.push(que.deQueue())
     while not stk.isEmpty():
          que.enQueue(stk.pop())
     for i in range(0, halfSize):
          que.enQueue(que.deQueue())
     for i in range(0, halfSize):
          stk.push(que.deQueue())
     while not stk.isEmpty():
          que.enQueue(stk.pop())
          que.enQueue(que.deQueue())
	  
que = Queue()
que.enQueue(11)
que.enQueue(12)
que.enQueue(13)
que.enQueue(14)
que.enQueue(15)
que.enQueue(16)
que.enQueue(17)
que.enQueue(18)
que.enQueue(19)
que.enQueue(20)
que.enQueue(21)
que.enQueue(22)

interLeavingQueue(que)	  

while not que.isEmpty():
    print que.deQueue()  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MinSlidingWindowWithDequeue652
    set output_file "MinSlidingWindowWithDequeue.py"

    set template_content '
from collections import deque
 
def MinSlidingWindow(A, k):
    D = deque()
    res, i = [], 0
    for i in xrange(len(A)):
        while D and D[-1][0] >= A[i]:
            D.pop()
        D.append((A[i], i + k - 1))
        if i >= k - 1: res.append(D[0][0])
        if i == D[0][1]: D.popleft()
    return res
 
print MinSlidingWindow([4, 3, 2, 1, 5, 7, 6, 8, 9], 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Palcheckerdequeue653
    set output_file "Palcheckerdequeue.py"

    set template_content '
class Deque:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def addFront(self, item):
        self.items.append(item)

    def addRear(self, item):
        self.items.insert(0, item)

    def removeFront(self):
        return self.items.pop()

    def removeRear(self):
        return self.items.pop(0)

    def size(self):
        return len(self.items)
	
def palchecker(aString):
    chardeque = Deque()

    for ch in aString:
        chardeque.addRear(ch)

    stillEqual = True

    while chardeque.size() > 1 and stillEqual:
        first = chardeque.removeFront()
        last = chardeque.removeRear()
        if first != last:
            stillEqual = False

    return stillEqual

print(palchecker("lsdkjfskf"))
print(palchecker("madam"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.palindromeCheckerWithDeque654
    set output_file "main.py"

    set template_content "
import string
import collections
class Deque:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []

    def addFront(self, item):
        self.items.append(item)

    def addRear(self, item):
        self.items.insert(0, item)

    def removeFront(self):
        return self.items.pop()

    def removeRear(self):
        return self.items.pop(0)

    def size(self):
        return len(self.items)
	
STRIP = string.whitespace + string.punctuation + \"\\\"'\"
def palindromeCheckerWithDeque(str1):
	d1 = Deque()
	d2 = collections.deque()
	for s in str1.lower():
		if s not in STRIP:
			d2.append(s)
			d1.addRear(s)
	eq1 = True
	while d1.size() > 1 and eq1:
		if d1.removeFront() != d1.removeRear():
			eq1 = False

	eq2 = True
	while len(d2) > 1 and eq2:
		if d2.pop() != d2.popleft():
			eq2 = False
		
	return eq1, eq2

str1 = 'Madam Im Adam'
str2 = 'Buffy is a Slayer'
print(palindromeCheckerWithDeque(str1))
print(palindromeCheckerWithDeque(str2))
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.KthSmallestWithExtraHeap655
    set output_file "KthSmallestWithExtraHeap.py"

    set template_content '
import heapq
class Heap:
	def __init__(self):
		self.heapList = [0]  # Elements in Heap
		self.size = 0  # Size of the heap
	def parent(self, index):
		return index // 2
		
	def leftChildIndex(self, index):
		return 2 * index
		
	def rightChildIndex(self, index):
		return 2 * index + 1
		
	def leftChild(self, index):
		if 2 * index <= self.size:
			return self.heapList[2 * index ]
		return -1
		
	def rightChild(self, index):
		if 2 * index + 1 <= self.size :
			return self.heapList[2 * index + 1]
		return -1	

	def searchElement(self, itm):
		i = 1
		while (i <= self.size):
			if itm == self.heapList[i]:
				return i
			i += 1
	# Get Minimum for MinHeap
	def getMinimum(self):
	     if self.size == 0:
		  return -1
	     return self.heapList[1]

	def percolateDown(self, i):
	    while (i * 2) <= self.size:
		minimumChild = self.minimumChild(i)
		if self.heapList[i] > self.heapList[minimumChild]:
		    tmp = self.heapList[i]
		    self.heapList[i] = self.heapList[minimumChild]
		    self.heapList[minimumChild] = tmp
		i = minimumChild

	def minimumChild(self, i):
	    if i * 2 + 1 > self.size:
		return i * 2
	    else:
		if self.heapList[i * 2] < self.heapList[i * 2 + 1]:
		    return i * 2
		else:
		    return i * 2 + 1

	def percolateUp(self, i):
		while i // 2 > 0:
			if self.heapList[i] < self.heapList[i // 2]:
				tmp = self.heapList[i // 2]
				self.heapList[i // 2] = self.heapList[i]
				self.heapList[i] = tmp
			i = i // 2

	# Delete Minimum for MinHeap
	def deleteMin(self):
	    retval = self.heapList[1]
	    self.heapList[1] = self.heapList[self.size]
	    self.size = self.size - 1
	    self.heapList.pop()
	    self.percolateDown(1)
	    return retval

	def insert(self, k):
		self.heapList.append(k)
		self.size = self.size + 1
		self.percolateUp(self.size)

	def printHeap(self):
		print self.heapList[1:]
		
	    
def FindKthLargestEle(HOrig, k):
	count = 1
	HAux = Heap()
	itm = HOrig.getMinimum()
	HAux.insert(itm)
	if count == k:
		return itm		
	while (HAux.size >= 1):
		itm = HAux.deleteMin()
		count += 1
		if count == k:
			return itm
		else:
			if HOrig.rightChild(HOrig.searchElement(itm)) != -1:
				HAux.insert(HOrig.rightChild(HOrig.searchElement(itm)))
			if HOrig.leftChild(HOrig.searchElement(itm)) != -1:	
				HAux.insert(HOrig.leftChild(HOrig.searchElement(itm)))

HOrig = Heap()
# add some nonsense:
HOrig.insert(1)
HOrig.insert(20)
HOrig.insert(5)
HOrig.insert(100)
HOrig.insert(1000)
HOrig.insert(12)
HOrig.insert(18)
HOrig.insert(16)

print FindKthLargestEle(HOrig, 6)
print FindKthLargestEle(HOrig, 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestWithHeapDeletion656
    set output_file "KthSmallestWithHeapDeletion.py"

    set template_content '
def kthSmallest(collection, k):
    """Return kth smallest element in collection for valid k >=1 """
    A = collection[:k]
    buildHeap(A)
    for i in range(k, len(collection)):
        if collection[i] < A[0]:
            A[0] = collection[i]
            heapify(A, 0, k)
    return A[0]

def buildHeap(A):
    n = len(A)
    for i in range(n / 2 - 1, -1, -1):
        heapify(A, i, n)

def heapify (A, index, maxIndex):
    """Ensure structure rooted at A[index] is a heap"""
    left = 2 * index + 1
    right = 2 * index + 2
    if left < maxIndex and A[left] > A[index]:
        largest = left
    else: 
        largest = index
    if right < maxIndex and A[right] > A[largest]:
        largest = right

    if largest != index:
        A[index], A[largest] = A[largest], A[index]
        heapify(A, largest, maxIndex)

print kthSmallest(range(10), 3)
print kthSmallest(range(10), 1)
print kthSmallest(range(10), 10)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MaxSlidingWindowWithHeap657
    set output_file "MaxSlidingWindowWithHeap.py"

    set template_content '
from collections import deque
 
def MaxSlidingWindow(A, k):
    D = deque()
    res, i = [], 0
    for i in xrange(len(A)):
        while D and D[-1][0] <= A[i]:
            D.pop()
        D.append((A[i], i + k - 1))
        if i >= k - 1: res.append(D[0][0])
        if i == D[0][1]: D.popleft()
    return res
 
print MaxSlidingWindow([4, 3, 2, 1, 5, 7, 6, 8, 9], 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.MedianInStream658
    set output_file "MedianInStream.py"

    set template_content '
class streamMedian: 
	def __init__(self): 
		self.minHeap, self.maxHeap = [], [] 
		self.n = 0   
	def insert(self, num): 
		if self.n % 2 == 0: 
			heapq.heappush(self.maxHeap, -1 * num) 
			self.n += 1 
			if len(self.minHeap) == 0: 
				return 
			if -1 * self.maxHeap[0] > self.minHeap[0]: 
				toMin = -1 * heapq.heappop(self.maxHeap) 
				toMax = heapq.heappop(self.minHeap) 
				heapq.heappush(self.maxHeap, -1 * toMax) 
				heapq.heappush(self.minHeap, toMin) 
			else: 
				toMin = -1 * heapq.heappushpop(self.maxHeap, -1 * num) 
				heapq.heappush(self.minHeap, toMin) 
				self.n += 1   
	def getMedian(self): 
		if self.n % 2 == 0: 
			return (-1 * self.maxHeap[0] + self.minHeap[0]) / 2.0 
		else: 
			return -1 * self.maxHeap[0]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MedianInStream659
    set output_file "MedianInStream.py"

    set template_content '
class streamMedian: 
	def __init__(self): 
		self.minHeap, self.maxHeap = [], [] 
		self.n = 0   
	def insert(self, num): 
		if self.n % 2 == 0: 
			heapq.heappush(self.maxHeap, -1 * num) 
			self.n += 1 
			if len(self.minHeap) == 0: 
				return 
			if -1 * self.maxHeap[0] > self.minHeap[0]: 
				toMin = -1 * heapq.heappop(self.maxHeap) 
				toMax = heapq.heappop(self.minHeap) 
				heapq.heappush(self.maxHeap, -1 * toMax) 
				heapq.heappush(self.minHeap, toMin) 
			else: 
				toMin = -1 * heapq.heappushpop(self.maxHeap, -1 * num) 
				heapq.heappush(self.minHeap, toMin) 
				self.n += 1   
	def getMedian(self): 
		if self.n % 2 == 0: 
			return (-1 * self.maxHeap[0] + self.minHeap[0]) / 2.0 
		else: 
			return -1 * self.maxHeap[0]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MinSlidingWindowWithDequeue660
    set output_file "MinSlidingWindowWithDequeue.py"

    set template_content '
from collections import deque
 
def MinSlidingWindow(A, k):
    D = deque()
    res, i = [], 0
    for i in xrange(len(A)):
        while D and D[-1][0] >= A[i]:
            D.pop()
        D.append((A[i], i + k - 1))
        if i >= k - 1: res.append(D[0][0])
        if i == D[0][1]: D.popleft()
    return res
 
print MinSlidingWindow([4, 3, 2, 1, 5, 7, 6, 8, 9], 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxSlidingWindowWithHeap661
    set output_file "MaxSlidingWindowWithHeap.py"

    set template_content '
from collections import deque
 
def MaxSlidingWindow(A, k):
    D = deque()
    res, i = [], 0
    for i in xrange(len(A)):
        while D and D[-1][0] <= A[i]:
            D.pop()
        D.append((A[i], i + k - 1))
        if i >= k - 1: res.append(D[0][0])
        if i == D[0][1]: D.popleft()
    return res
 
print MaxSlidingWindow([4, 3, 2, 1, 5, 7, 6, 8, 9], 3)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.DisjointSets662
    set output_file "DisjointSets.py"

    set template_content '
class DisjointSet:   
	def __init__(self, n):
		self.MAKESETUNIONBYSIZE(n)

	def MAKESET(self, n):
		self.S = [x for x in range(n)]	

	def MAKESETUNIONBYSIZE(self, n):
		self.S = [-1 for x in range(n)]	
 
	def FIND(self, X):
		if(not (X >= 0 and X < len(self.S))):
			return

		if(self.S[X] == X): 
			return X

		else:	
			return self.FIND([X])
			
	def FINDBYSIZE(self, X):
		if(self.S[X] < 0): 
			return X
		else:	
			return self.FINDBYSIZE(self.S[X])

	def UNION(self, root1, root2):
		if self.FIND(root1) == self.FIND(root2):
			return
		if(not ((root1 >= 0 and root1 < size) and (root2 >= 0 and root2 < size))):
			return	    
		self.S[root1] = root2
 
 	def UNIONBYSIZE(self, root1, root2):
		if self.FIND(root1) == self.FIND(root2) and self.FIND(root1) == -1:
			return
		if(self.S[root2] < self.S[root1]):
			self.S[root2] += self.S[root1]	    
			self.S[root1] = root2
		else:
			self.S[root1] += self.S[root2]
			self.S[root2] = root1			
 
  	def UNIONBYHEIGHT(self, root1, root2):
		if self.FIND(root1) == self.FIND(root2) and self.FIND(root1) == -1:
			return		
		if(self.S[root2] < self.S[root1]):
			self.S[root1] = root2
		elif self.S[root2] == self.S[root1] :
			self.S[root1] -= 1
		self.S[root2] = root1
			
	def printSet(self):
		print self.S

 
if __name__ == '__main__':
    # Part a)
    uf = DisjointSet(9)
    uf.UNIONBYSIZE(1, 2)
    uf.UNIONBYSIZE(3, 4)
    uf.UNIONBYSIZE(5, 6)
    uf.printSet()

    uf.UNIONBYSIZE(1, 3)
    uf.printSet()
 
    print uf.FINDBYSIZE(2)
    uf.printSet()
    
    uf = DisjointSet(9)
    uf.UNIONBYHEIGHT(1, 2)
    uf.UNIONBYHEIGHT(3, 4)
    uf.UNIONBYHEIGHT(5, 6)
    uf.printSet()

    uf.UNIONBYHEIGHT(1, 3)    
    uf.UNIONBYHEIGHT(1, 5)
    uf.printSet()
 
    print uf.FINDBYSIZE(2)
    uf.printSet()    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.KthSmallestWithHeapDeletion663
    set output_file "KthSmallestWithHeapDeletion.py"

    set template_content '
def kthSmallest(collection, k):
    """Return kth smallest element in collection for valid k >=1 """
    A = collection[:k]
    buildHeap(A)
    for i in range(k, len(collection)):
        if collection[i] < A[0]:
            A[0] = collection[i]
            heapify(A, 0, k)
    return A[0]

def buildHeap(A):
    n = len(A)
    for i in range(n / 2 - 1, -1, -1):
        heapify(A, i, n)

def heapify (A, index, maxIndex):
    """Ensure structure rooted at A[index] is a heap"""
    left = 2 * index + 1
    right = 2 * index + 2
    if left < maxIndex and A[left] > A[index]:
        largest = left
    else: 
        largest = index
    if right < maxIndex and A[right] > A[largest]:
        largest = right

    if largest != index:
        A[index], A[largest] = A[largest], A[index]
        heapify(A, largest, maxIndex)

print kthSmallest(range(10), 3)
print kthSmallest(range(10), 1)
print kthSmallest(range(10), 10)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KListsOneFromEachListsWithHeap664
    set output_file "KListsOneFromEachListsWithHeap.py"

    set template_content '
import heapq

def KListsOneElementFromEach(Lst):
    heap = []
    end = False
    for l in Lst :
        thisRange = max(l) - min(l)
        heap.append(min(l))
        heapq.heapify(heap)
            
    while not end:
        elem = heapq.heappop(heap)
        print elem
        for l in Lst :            
            if elem in l:
                # print l                
                l.remove(elem)
                # print l
                if len(l) == 0:
                    end = True
                    break
                heapq.heappush(heap, l[0])
    print heap
    
def minL(l):
    m = min(float(s) for s in l)
    return m

def maxL(l):
    m = max(float(s) for s in l)
    return m

Lst = [[4, 10, 15, 24, 26], [0, 19, 12, 20], [15, 18, 28, 30], ]
KListsOneElementFromEach(Lst)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.HeapSort665
    set output_file "heapSort.py"

    set template_content '
def heapSort(A):
  # convert A to heap
  length = len(A) - 1
  leastParent = length / 2
  for i in range (leastParent, -1, -1):
    percolateDown(A, i, length)

  # flatten heap into sorted array
  for i in range (length, 0, -1):
    if A[0] > A[i]:
      swap(A, 0, i)
      percolateDown(A, 0, i - 1)

 # Modfied percolateDown to skip the sorted elements
def percolateDown(A, first, last):
  largest = 2 * first + 1
  while largest <= last:
    # right child exists and is larger than left child
    if (largest < last) and (A[largest] < A[largest + 1]):
      largest += 1
  
    # right child is larger than parent
    if A[largest] > A[first]:
      swap(A, largest, first)
      # move down to largest child
      first = largest;
      largest = 2 * first + 1
    else:
      return  # force exit
  
def swap(A, x, y):
  temp = A[x]
  A[x] = A[y]
  A[y] = temp

A = [534, 246, 933, 127, 277, 321, 454, 565, 220]
print(heapSort(A))
print A
'

    echo \"$template_content\" > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoP.Twosum666
    set output_file "twosum.py"

    set template_content '
def two_sum(numbers, target):
    for i, number in enumerate(numbers):
        second_val = target - number
        low, high = i + 1, len(numbers) - 1
        while low <= high:
            mid = low + (high - low) // 2
            if second_val == numbers[mid]:
                return [i + 1, mid + 1]

            if second_val > numbers[mid]:
                low = mid + 1
            else:
                high = mid - 1
    return None


def two_sum1(numbers, target):
    dic = {}
    for i, num in enumerate(numbers):
        if target - num in dic:
            return [dic[target - num] + 1, i + 1]
        dic[num] = i
    return None


def two_sum2(numbers, target):
    left = 0  # pointer 1 holds from left of array numbers
    right = len(numbers) - 1  # pointer 2 holds from right of array numbers
    while left < right:
        current_sum = numbers[left] + numbers[right]
        if current_sum == target:
            return [left + 1, right + 1]

        if current_sum > target:
            right = right - 1
        else:
            left = left + 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.TernarySearch667
    set output_file "TernarySearch.py"

    set template_content '
def ternary_search(left, right, key, arr):

    while right >= left:
        mid1 = left + (right - left) // 3
        mid2 = right - (right - left) // 3

        if key == arr[mid1]:
            return mid1
        if key == mid2:
            return mid2

        if key < arr[mid1]:
            # key lies between l and mid1
            right = mid1 - 1
        elif key > arr[mid2]:
            # key lies between mid2 and r
            left = mid2 + 1
        else:
            # key lies between mid1 and mid2
            left = mid1 + 1
            right = mid2 - 1

    # key not found
    return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.search_rotate_recur668
    set output_file "search_rotate_recur.py"

    set template_content '
def search_rotate(array, val):
    low, high = 0, len(array) - 1
    while low <= high:
        mid = (low + high) // 2
        if val == array[mid]:
            return mid

        if array[low] <= array[mid]:
            if array[low] <= val <= array[mid]:
                high = mid - 1
            else:
                low = mid + 1
        else:
            if array[mid] <= val <= array[high]:
                low = mid + 1
            else:
                high = mid - 1

    return -1

def search_rotate_recur(array, low, high, val):
    if low >= high:
        return -1
    mid = (low + high) // 2
    if val == array[mid]:       # found element
        return mid
    if array[low] <= array[mid]:
        if array[low] <= val <= array[mid]:
            return search_rotate_recur(array, low, mid - 1, val)    # Search left
        return search_rotate_recur(array, mid + 1, high, val)   # Search right
    if array[mid] <= val <= array[high]:
        return search_rotate_recur(array, mid + 1, high, val)   # Search right
    return search_rotate_recur(array, low, mid - 1, val)    # Search left
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.search_range669
    set output_file "search_range.py"

    set template_content '
def search_range(nums, target):
    low = 0
    high = len(nums) - 1
    # breaks at low == high
    # both pointing to first occurence of target
    while low < high:
        mid = low + (high - low) // 2
        if target <= nums[mid]:
            high = mid
        else:
            low = mid + 1

    for j in range(len(nums) - 1, -1, -1):
        if nums[j] == target:
            return [low, j]

    return [-1, -1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.search_insert670
    set output_file "SortListByFrequency.py"

    set template_content '
def search_insert(array, val):
   
    low = 0
    high = len(array) - 1
    while low <=  high:
        mid = low + (high - low) // 2
        if val > array[mid]:
            low = mid + 1
        else:
            high = mid - 1
    return low
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.next_greatest_letter671
    set output_file "SortListByFrequency.py"

    set template_content '
import bisect

def next_greatest_letter(letters, target):
    index = bisect.bisect(letters, target)
    return letters[index % len(letters)]

def next_greatest_letter_v1(letters, target):
    if letters[0] > target:
        return letters[0]
    if letters[len(letters) - 1] <= target:
        return letters[0]
    left, right = 0, len(letters) - 1
    while left <= right:
        mid = left + (right - left) // 2
        if  letters[mid] > target:
            right = mid - 1
        else:
            left = mid + 1
    return letters[left]

def next_greatest_letter_v2(letters, target):
    for index in letters:
        if index > target:
            return index
    return letters[0]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.linear_search672
    set output_file "SortListByFrequency.py"

    set template_content '
def linear_search(array, query):
    for i, value in enumerate(array):
        if value == query:
            return i
    return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.last_occurrence673
    set output_file "SortListByFrequency.py"

    set template_content '
def last_occurrence(array, query):
    low, high = 0, len(array) - 1
    while low <= high:
        mid = (high + low) // 2
        if (array[mid] == query and mid == len(array)-1) or \
           (array[mid] == query and array[mid+1] > query):
            return mid
        if array[mid] <= query:
            low = mid + 1
        else:
            high = mid - 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.jump_search673
    set output_file "SortListByFrequency.py"

    set template_content '
def jump_search(arr, target):

    length = len(arr)
    block_size = int(math.sqrt(length))
    block_prev = 0
    block = block_size

    if arr[length - 1] < target:
        return -1
    while block <= length and arr[block - 1] < target:
        block_prev = block
        block += block_size


    while arr[block_prev] < target:
        block_prev += 1
        if block_prev == min(block, length):
            return -1


    if arr[block_prev] == target:
        return block_prev
    return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.interpolation_search674
    set output_file "interpolation_search.py"

    set template_content '
from typing import List


def interpolation_search(array: List[int], search_key: int) -> int:

    # highest and lowest index in array
    high = len(array) - 1
    low = 0

    while (low <= high) and (array[low] <= search_key <= array[high]):
        # calculate the search position
        pos = low + int(
            ((search_key - array[low]) * (high - low) / (array[high] - array[low]))
        )

        # search_key is found
        if array[pos] == search_key:
            return pos

        # if search_key is larger, search_key is in upper part
        if array[pos] < search_key:
            low = pos + 1

        # if search_key is smaller, search_key is in lower part
        else:
            high = pos - 1

    return -1


if __name__ == "__main__":
    import doctest

    doctest.testmod()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.first_occurrence675
    set output_file "SortListByFrequency.py"

    set template_content '
def first_occurrence(array, query):

    low, high = 0, len(array) - 1
    while low <= high:
        mid = low + (high-low)//2 #Now mid will be ininteger range
        #print("lo: ", lo, " hi: ", hi, " mid: ", mid)
        if low == high:
            break
        if array[mid] < query:
            low = mid + 1
        else:
            high = mid
    if array[low] == query:
        return low
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_min_rotate676
    set output_file "find_min_rotate.py"

    set template_content '
def find_min_rotate(array):
    low = 0
    high = len(array) - 1
    while low < high:
        mid = (low + high) // 2
        if array[mid] > array[high]:
            low = mid + 1
        else:
            high = mid

    return array[low]


def find_min_rotate_recur(array, low, high):
    mid = (low + high) // 2
    if mid == low:
        return array[low]
    if array[mid] > array[high]:
        return find_min_rotate_recur(array, mid + 1, high)
    return find_min_rotate_recur(array, low, mid)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.binary_search_recur678
    set output_file "SortListByFrequency.py"

    set template_content '
def binary_search(array, query):

    low, high = 0, len(array) - 1
    while low <= high:
        mid = (high + low) // 2
        val = array[mid]
        if val == query:
            return mid

        if val < query:
            low = mid + 1
        else:
            high = mid - 1
    return None


def binary_search_recur(array, low, high, val):
    if low > high:
        return -1
    mid = low + (high - low) // 2  # This mid will not break integer range
    if val < array[mid]:
        return binary_search_recur(
            array, low, mid - 1, val
        )  # Go search in the left subarray
    if val > array[mid]:
        return binary_search_recur(
            array, mid + 1, high, val
        )  # Go search in the right subarray
    return mid
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end






function algoP.set_find_keyboard_row679
    set output_file "SortListByFrequency.py"

    set template_content '
def find_keyboard_row(words):
    keyboard = [
        set("qwertyuiop"),
        set("asdfghjkl"),
        set("zxcvbnm"),
    ]
    result = []
    for word in words:
        for key in keyboard:
            if set(word.lower()).issubset(key):
                result.append(word)
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RandomizedSet680
    set output_file "RandomizedSet.py"

    set template_content '
import random


class RandomizedSet():

    def __init__(self):
        self.elements = []
        self.index_map = {}  # element -> index

    def insert(self, new_one):
        if new_one in self.index_map:
            return
        self.index_map[new_one] = len(self.elements)
        self.elements.append(new_one)

    def remove(self, old_one):
        if not old_one in self.index_map:
            return
        index = self.index_map[old_one]
        last = self.elements.pop()
        self.index_map.pop(old_one)
        if index == len(self.elements):
            return
        self.elements[index] = last
        self.index_map[last] = index

    def random_element(self):
        return random.choice(self.elements)


def __test():
    rset = RandomizedSet()
    ground_truth = set()
    n = 64

    for i in range(n):
        rset.insert(i)
        ground_truth.add(i)

    # Remove a half
    for i in random.sample(range(n), n // 2):
        rset.remove(i)
        ground_truth.remove(i)

    print(len(ground_truth), len(rset.elements), len(rset.index_map))
    for i in ground_truth:
        assert(i == rset.elements[rset.index_map[i]])

    for i in range(n):
        print(rset.random_element(), end=' ')
    print()


if __name__ == "__main__":
    __test()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.Set_Covering681
    set output_file "function algoP.Set_Covering.py"

    set template_content '
def powerset(iterable):
    "list(powerset([1,2,3])) --> [(), (1,), (2,), (3,), (1,2), (1,3), (2,3), (1,2,3)]"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s) + 1))


def optimal_set_cover(universe, subsets, costs):
    pset = powerset(subsets.keys())
    best_set = None
    best_cost = float("inf")
    for subset in pset:
        covered = set()
        cost = 0
        for s in subset:
            covered.update(subsets[s])
            cost += costs[s]
        if len(covered) == len(universe) and cost < best_cost:
            best_set = subset
            best_cost = cost
    return best_set


def greedy_set_cover(universe, subsets, costs):
    elements = set(e for s in subsets.keys() for e in subsets[s])
    # elements dont cover universe -> invalid input for set cover
    if elements != universe:
        return None

    covered = set()
    cover_sets = []

    while covered != universe:
        min_cost_elem_ratio = float("inf")
        min_set = None
        # find set with minimum cost:elements_added ratio
        for s, elements in subsets.items():
            new_elements = len(elements - covered)
            # set may have same elements as already covered -> new_elements = 0
            # check to avoid division by 0 error
            if new_elements != 0:
                cost_elem_ratio = costs[s] / new_elements
                if cost_elem_ratio < min_cost_elem_ratio:
                    min_cost_elem_ratio = cost_elem_ratio
                    min_set = s
        cover_sets.append(min_set)
        # union
        covered |= subsets[min_set]
    return cover_sets


if __name__ == "__main__":
    universe = {1, 2, 3, 4, 5}
    subsets = {"S1": {4, 1, 3}, "S2": {2, 5}, "S3": {1, 4, 3, 2}}
    costs = {"S1": 5, "S2": 10, "S3": 3}

    optimal_cover = optimal_set_cover(universe, subsets, costs)
    optimal_cost = sum(costs[s] for s in optimal_cover)

    greedy_cover = greedy_set_cover(universe, subsets, costs)
    greedy_cost = sum(costs[s] for s in greedy_cover)

    print("Optimal Set Cover:")
    print(optimal_cover)
    print("Cost = %s" % optimal_cost)

    print("Greedy Set Cover:")
    print(greedy_cover)
    print("Cost = %s" % greedy_cost)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bead_sort682
    set output_file "SortListByFrequency.py"

    set template_content '
def bead_sort(arr):
    if any(num < 0 for num in arr):
        raise ValueError("Bead sort only works with non-negative integers.")

    max_num = max(arr) if arr else 0
    grid = [[0] * len(arr) for _ in range(max_num)]

    # Drop beads (place beads in columns)
    for col, num in enumerate(arr):
        for row in range(num):
            grid[row][col] = 1

    # Let the beads "fall" (count beads in each row)
    for row in grid:
        sum_beads = sum(row)
        for col in range(len(arr)):
            row[col] = 1 if col < sum_beads else 0

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bitonic_sort683
    set output_file "SortListByFrequency.py"

    set template_content '
def compare(arr, reverse):
        n = len(arr)//2
        for i in range(n):
            if reverse != (arr[i] > arr[i+n]):
                arr[i], arr[i+n] = arr[i+n], arr[i]
        return arr

    def bitonic_merge(arr, reverse):
        n = len(arr)
        
        if n <= 1:
            return arr
        
        arr = compare(arr, reverse)
        left = bitonic_merge(arr[:n // 2], reverse)
        right = bitonic_merge(arr[n // 2:], reverse)
        return left + right
    
    #end of function(compare and bitionic_merge) definition
    n = len(arr)
    if n <= 1:
        return arr
    # checks if n is power of two
    if not (n and (not(n & (n - 1))) ):
        raise ValueError("the size of input should be power of two")
    
    left = bitonic_sort(arr[:n // 2], True)
    right = bitonic_sort(arr[n // 2:], False)

    arr = bitonic_merge(left + right, reverse)
        
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bogo_sort684
    set output_file "SortListByFrequency.py"

    set template_content '
def bogo_sort(arr, simulation=False):
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
    
    def is_sorted(arr):
        #check the array is inorder
        i = 0
        arr_len = len(arr)
        while i+1 < arr_len:
            if arr[i] > arr[i+1]:
                return False
            i += 1
            

        return True
    while not is_sorted(arr):
        random.shuffle(arr)
        
        if simulation:
            iteration = iteration + 1
            print("iteration",iteration,":",*arr)
            
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bubble_sort685
    set output_file "bubble_sort.py"

    set template_content '
def bubble_sort(arr, simulation=False):
    def swap(i, j):
        arr[i], arr[j] = arr[j], arr[i]

    n = len(arr)
    swapped = True
    
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
    x = -1
    while swapped:
        swapped = False
        x = x + 1
        for i in range(1, n-x):
            if arr[i - 1] > arr[i]:
                swap(i - 1, i)
                swapped = True
                if simulation:
                    iteration = iteration + 1
                    print("iteration",iteration,":",*arr)
                    
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bucket_sort686
    set output_file "bucket_sort.py"

    set template_content '
def bucket_sort(arr):
    # The number of buckets and make buckets
    num_buckets = len(arr)
    buckets = [[] for bucket in range(num_buckets)]
    # Assign values into bucket_sort
    for value in arr:
        index = value * num_buckets // (max(arr) + 1)
        buckets[index].append(value)
    # Sort
    sorted_list = []
    for i in range(num_buckets):
        sorted_list.extend(next_sort(buckets[i]))
    return sorted_list

def next_sort(arr):
    # We will use insertion sort here.
    for i in range(1, len(arr)):
        j = i - 1
        key = arr[i]
        while arr[j] > key and j >= 0:
            arr[j+1] = arr[j]
            j = j - 1
        arr[j + 1] = key
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.cocktail_shaker_sort687
    set output_file "SortListByFrequency.py"

    set template_content '
 def swap(i, j):
        arr[i], arr[j] = arr[j], arr[i]

    n = len(arr)
    swapped = True
    while swapped:
        swapped = False
        for i in range(1, n):
            if arr[i - 1] > arr[i]:
                swap(i - 1, i)
                swapped = True
        if swapped == False:
            return arr
        swapped = False
        for i in range(n-1,0,-1):
            if arr[i - 1] > arr[i]:
                swap(i - 1, i)
                swapped = True
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.comb_sort688
    set output_file "SortListByFrequency.py"

    set template_content '
def comb_sort(arr):
    def swap(i, j):
        arr[i], arr[j] = arr[j], arr[i]

    n = len(arr)
    gap = n
    shrink = 1.3
    sorted = False
    while not sorted:
        gap = int(gap / shrink)
        if gap > 1:
            sorted = False
        else:
            gap = 1
            sorted = True

        i = 0
        while i + gap < n:
            if arr[i] > arr[i + gap]:
                swap(i, i + gap)
                sorted = False
            i = i + 1
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.counting_sort689
    set output_file "SortListByFrequency.py"

    set template_content '
def counting_sort(arr):

    m = min(arr)
    # in case there are negative elements, change the array to all positive element
    different = 0
    if m < 0:
        # save the change, so that we can convert the array back to all positive number
        different = -m
        for i in range(len(arr)):
            arr[i] += -m
    k = max(arr)
    temp_arr = [0] * (k + 1)
    for i in range(0, len(arr)):
        temp_arr[arr[i]] = temp_arr[arr[i]] + 1
    # temp_array[i] contain the times the number i appear in arr

    for i in range(1, k + 1):
        temp_arr[i] = temp_arr[i] + temp_arr[i - 1]
    # temp_array[i] contain the number of element less than or equal i in arr

    result_arr = arr.copy()
    # creating a result_arr an put the element in a correct positon
    for i in range(len(arr) - 1, -1, -1):
        result_arr[temp_arr[arr[i]] - 1] = arr[i] - different
        temp_arr[arr[i]] = temp_arr[arr[i]] - 1

    return result_arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.cycle_sort690
    set output_file "cycle_sort.py"

    set template_content '
def cycle_sort(arr):
    len_arr = len(arr)
    # Finding cycle to rotate.
    for cur in range(len_arr - 1):
        item = arr[cur]

        # Finding an indx to put items in.
        index = cur
        for i in range(cur + 1, len_arr):
            if arr[i] < item:
                index += 1

        # Case of there is not a cycle
        if index == cur:
            continue

        # Putting the item immediately right after the duplicate item or on the right.
        while item == arr[index]:
            index += 1
        arr[index], item = item, arr[index]

        # Rotating the remaining cycle.
        while index != cur:

            # Finding where to put the item.
            index = cur
            for i in range(cur + 1, len_arr):
                if arr[i] < item:
                    index += 1

            # After item is duplicated, put it in place or put it there.
            while item == arr[index]:
                index += 1
            arr[index], item = item, arr[index]
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.exchange_sort691
    set output_file "SortListByFrequency.py"

    set template_content '
def exchange_sort(arr):
    arr_len = len(arr)
    for i in range(arr_len-1):
        for j in range(i+1, arr_len):
            if(arr[i] > arr[j]):
                arr[i], arr[j] = arr[j], arr[i]
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.gnome_sort692
    set output_file "gnome_sort.py"

    set template_content '
def gnome_sort(arr):
    n = len(arr)
    index = 0
    while index < n:
        if index == 0 or arr[index] >= arr[index-1]:
            index = index + 1
        else:
            arr[index], arr[index-1] = arr[index-1], arr[index]
            index = index - 1
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.heap_sort693
    set output_file "heap_sort.py"

    set template_content '
def max_heap_sort(arr, simulation=False):
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
        
    for i in range(len(arr) - 1, 0, -1):
        iteration = max_heapify(arr, i, simulation, iteration)

    if simulation:
                iteration = iteration + 1
                print("iteration",iteration,":",*arr)
    return arr


def max_heapify(arr, end, simulation, iteration):
    last_parent = (end - 1) // 2

    # Iterate from last parent to first
    for parent in range(last_parent, -1, -1):
        current_parent = parent

        # Iterate from current_parent to last_parent
        while current_parent <= last_parent:
            # Find greatest child of current_parent
            child = 2 * current_parent + 1
            if child + 1 <= end and arr[child] < arr[child + 1]:
                child = child + 1

            # Swap if child is greater than parent
            if arr[child] > arr[current_parent]:
                arr[current_parent], arr[child] = arr[child], arr[current_parent]
                current_parent = child
                if simulation:
                    iteration = iteration + 1
                    print("iteration",iteration,":",*arr)
            # If no swap occurred, no need to keep iterating
            else:
                break
    arr[0], arr[end] = arr[end], arr[0]
    return iteration

def min_heap_sort(arr, simulation=False):
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
        
    for i in range(0, len(arr) - 1):
        iteration = min_heapify(arr, i, simulation, iteration)

    return arr


def min_heapify(arr, start, simulation, iteration):
    # Offset last_parent by the start (last_parent calculated as if start index was 0)
    # All array accesses need to be offset by start
    end = len(arr) - 1
    last_parent = (end - start - 1) // 2

    # Iterate from last parent to first
    for parent in range(last_parent, -1, -1):
        current_parent = parent

        # Iterate from current_parent to last_parent
        while current_parent <= last_parent:
            # Find lesser child of current_parent
            child = 2 * current_parent + 1
            if child + 1 <= end - start and arr[child + start] > arr[
                child + 1 + start]:
                child = child + 1
            
            # Swap if child is less than parent
            if arr[child + start] < arr[current_parent + start]:
                arr[current_parent + start], arr[child + start] = \
                    arr[child + start], arr[current_parent + start]
                current_parent = child
                if simulation:
                    iteration = iteration + 1
                    print("iteration",iteration,":",*arr)
            # If no swap occurred, no need to keep iterating
            else:
                break
    return iteration
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.insertion_sort694
    set output_file "insertion_sort.py"

    set template_content '
def insertion_sort(arr, simulation=False):
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
        
    for i in range(len(arr)):
        cursor = arr[i]
        pos = i
        
        while pos > 0 and arr[pos - 1] > cursor:
            # Swap the number down the list
            arr[pos] = arr[pos - 1]
            pos = pos - 1
        # Break and do the final swap
        arr[pos] = cursor
        
        if simulation:
                iteration = iteration + 1
                print("iteration",iteration,":",*arr)

    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.can_attend_meetings695
    set output_file "can_attend_meetings.py"

    set template_content '
def can_attend_meetings(intervals):
    intervals = sorted(intervals, key=lambda x: x.start)
    for i in range(1, len(intervals)):
        if intervals[i].start < intervals[i - 1].end:
            return False
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.merge_sort696
    set output_file "merge_sort.py"

    set template_content '
def merge_sort(arr):
    # Our recursive base case
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    # Perform merge_sort recursively on both halves
    left, right = merge_sort(arr[:mid]), merge_sort(arr[mid:])

    # Merge each side together
    # return merge(left, right, arr.copy()) # changed, no need to copy, mutate inplace.
    merge(left,right,arr)
    return arr


def merge(left, right, merged):

    left_cursor, right_cursor = 0, 0
    while left_cursor < len(left) and right_cursor < len(right):
        # Sort each one and place into the result
        if left[left_cursor] <= right[right_cursor]:
            merged[left_cursor+right_cursor]=left[left_cursor]
            left_cursor += 1
        else:
            merged[left_cursor + right_cursor] = right[right_cursor]
            right_cursor += 1
    # Add the left overs if theres any left to the result
    for left_cursor in range(left_cursor, len(left)):
        merged[left_cursor + right_cursor] = left[left_cursor]
    # Add the left overs if theres any left to the result
    for right_cursor in range(right_cursor, len(right)):
        merged[left_cursor + right_cursor] = right[right_cursor]

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.template_content697
    set output_file "template_content.py"

    set template_content '
def pancake_sort(arr):
    len_arr = len(arr)
    if len_arr <= 1:
        return arr
    for cur in range(len(arr), 1, -1):
        #Finding index of maximum number in arr
        index_max = arr.index(max(arr[0:cur]))
        if index_max+1 != cur:
            #Needs moving
            if index_max != 0:
                #reverse from 0 to index_max
                arr[:index_max+1] = reversed(arr[:index_max+1])
            # Reverse list
            arr[:cur] = reversed(arr[:cur])
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.pigeonhole_sort698
    set output_file "pigeonhole_sort.py"

    set template_content '
def pigeonhole_sort(arr):
    Max = max(arr)
    Min = min(arr)
    size = Max - Min + 1

    holes = [0]*size

    for i in arr:
        holes[i-Min] += 1

    i = 0
    for count in range(size):
        while holes[count] > 0:
            holes[count] -= 1
            arr[i] = count + Min
            i += 1
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.quick_sort699
    set output_file "quick_sort.py"

    set template_content '
def quick_sort(arr, simulation=False):
    
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
    arr, _ = quick_sort_recur(arr, 0, len(arr) - 1, iteration, simulation)
    return arr

def quick_sort_recur(arr, first, last, iteration, simulation):
    if first < last:
        pos = partition(arr, first, last)
        # Start our two recursive calls
        if simulation:
            iteration = iteration + 1
            print("iteration",iteration,":",*arr)
            
        _, iteration = quick_sort_recur(arr, first, pos - 1, iteration, simulation)
        _, iteration = quick_sort_recur(arr, pos + 1, last, iteration, simulation)

    return arr, iteration

def partition(arr, first, last):
    wall = first
    for pos in range(first, last):
        if arr[pos] < arr[last]:  # last is the pivot
            arr[pos], arr[wall] = arr[wall], arr[pos]
            wall += 1
    arr[wall], arr[last] = arr[last], arr[wall]
    return wall
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.radix_sort700
    set output_file "radix_sort.py"

    set template_content '
def radix_sort(arr, simulation=False):
    position = 1
    max_number = max(arr)

    iteration = 0
    if simulation:
        print("iteration", iteration, ":", *arr)

    while position <= max_number:
        queue_list = [list() for _ in range(10)]

        for num in arr:
            digit_number = num // position % 10
            queue_list[digit_number].append(num)

        index = 0
        for numbers in queue_list:
            for num in numbers:
                arr[index] = num
                index += 1

        if simulation:
            iteration = iteration + 1
            print("iteration", iteration, ":", *arr)

        position *= 10
    return arr
    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.selection_sort701
    set output_file "selection_sort.py"

    set template_content '
def selection_sort(arr, simulation=False):
    iteration = 0
    if simulation:
        print("iteration",iteration,":",*arr)
        
    for i in range(len(arr)):
        minimum = i
        
        for j in range(i + 1, len(arr)):
            # "Select" the correct value
            if arr[j] < arr[minimum]:
                minimum = j

        arr[minimum], arr[i] = arr[i], arr[minimum]
        
        if simulation:
                iteration = iteration + 1
                print("iteration",iteration,":",*arr)
            
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.shell_sort702
    set output_file "SortListByFrequency.py"

    set template_content '
def shell_sort(arr):
    n = len(arr)
    # Initialize size of the gap
    gap = n//2
    
    while gap > 0:
        y_index = gap
        while y_index < len(arr):
            y = arr[y_index]
            x_index = y_index - gap
            while x_index >= 0 and y < arr[x_index]:
                arr[x_index + gap] = arr[x_index]
                x_index = x_index - gap
            arr[x_index + gap] = y
            y_index = y_index + 1
        gap = gap//2
        
    return arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.stoogesort703
    set output_file "SortListByFrequency.py"

    set template_content '
def stoogesort(arr, l, h): 
    if l >= h: 
        return
   
    # If first element is smaller 
    # than last, swap them 
    if arr[l]>arr[h]: 
        t = arr[l] 
        arr[l] = arr[h] 
        arr[h] = t 
   
    # If there are more than 2 elements in 
    # the array 
    if h-l + 1 > 2: 
        t = (int)((h-l + 1)/3) 
   
        # Recursively sort first 2 / 3 elements 
        stoogesort(arr, l, (h-t)) 
   
        # Recursively sort last 2 / 3 elements 
        stoogesort(arr, l + t, (h)) 
   
        # Recursively sort first 2 / 3 elements 
        # again to confirm 
        stoogesort(arr, l, (h-t)) 
        

if __name__ == "__main__":
    array = [1,3,64,5,7,8]
    n = len(array) 
    stoogesort(array, 0, n-1) 
    for i in range(0, n): 
        print(array[i], end = ' ') 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.sort_colors704
    set output_file "sort_colors.py"

    set template_content '
def sort_colors(nums):
    i = j = 0
    for k in range(len(nums)):
        v = nums[k]
        nums[k] = 2
        if v < 2:
            nums[j] = 1
            j += 1
        if v == 0:
            nums[i] = 0
            i += 1


if __name__ == "__main__":
    nums = [0, 1, 1, 1, 2, 2, 2, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 2, 2]
    sort_colors(nums)
    print(nums)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.top_sort_recursive705
    set output_file "top_sort_recursive.py"

    set template_content '
GRAY, BLACK = 0, 1

def top_sort_recursive(graph):
    """ Time complexity is the same as DFS, which is O(V + E)
        Space complexity: O(V)
    """
    order, enter, state = [], set(graph), {}
    
    def dfs(node):
        state[node] = GRAY
        #print(node)
        for k in graph.get(node, ()):
            sk = state.get(k, None)
            if sk == GRAY:
                raise ValueError("cycle")
            if sk == BLACK:
                continue
            enter.discard(k)
            dfs(k)
        order.append(node)
        state[node] = BLACK
        
    while enter: dfs(enter.pop())
    return order

def top_sort(graph):
    """ Time complexity is the same as DFS, which is O(V + E)
        Space complexity: O(V)
    """
    order, enter, state = [], set(graph), {}
    
    def is_ready(node):
        lst = graph.get(node, ())
        if len(lst) == 0:
            return True
        for k in lst:
            sk = state.get(k, None)
            if sk == GRAY: 
                raise ValueError("cycle")
            if sk != BLACK:
                return False
        return True
        
    while enter:
        node = enter.pop()
        stack = []
        while True:
            state[node] = GRAY
            stack.append(node)
            for k in graph.get(node, ()):
                sk = state.get(k, None)
                if sk == GRAY: 
                    raise ValueError("cycle")
                if sk == BLACK: 
                    continue
                enter.discard(k)
                stack.append(k)
            while stack and is_ready(stack[-1]):
                node = stack.pop()
                order.append(node)
                state[node] = BLACK
            if len(stack) == 0:
                break
            node = stack.pop()
        
    return order
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.wiggle_sort706
    set output_file "wiggle_sort.py"

    set template_content '
def wiggle_sort(nums):
    for i in range(len(nums)):
        if (i % 2 == 1) == (nums[i-1] > nums[i]):
            nums[i-1], nums[i] = nums[i], nums[i-1]

if __name__ == "__main__":
    array = [3, 5, 2, 1, 6, 4]

    print(array)
    wiggle_sort(array)
    print(array)


'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.stack_is_consecutive707
    set output_file "is_consecutive.py"

    set template_content '
import collections


def first_is_consecutive(stack):
    storage_stack = []
    for i in range(len(stack)):
        first_value = stack.pop()
        if len(stack) == 0:  # Case odd number of values in stack
            return True
        second_value = stack.pop()
        if first_value - second_value != 1:  # Not consecutive
            return False
        stack.append(second_value)          # Backup second value
        storage_stack.append(first_value)

    # Back up stack from storage stack
    for i in range(len(storage_stack)):
        stack.append(storage_stack.pop())
    return True


def second_is_consecutive(stack):
    q = collections.deque()
    for i in range(len(stack)):
        first_value = stack.pop()
        if len(stack) == 0:  # Case odd number of values in stack
            return True
        second_value = stack.pop()
        if first_value - second_value != 1:  # Not consecutive
            return False
        stack.append(second_value)          # Backup second value
        q.append(first_value)

    # Back up stack from queue
    for i in range(len(q)):
        stack.append(q.pop())
    for i in range(len(stack)):
        q.append(stack.pop())
    for i in range(len(q)):
        stack.append(q.pop())

    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.stack_is_sorted708
    set output_file "SortListByFrequency.py"

    set template_content '
def is_sorted(stack):
    storage_stack = []
    for i in range(len(stack)):
        if len(stack) == 0:
            break
        first_val = stack.pop()
        if len(stack) == 0:
            break
        second_val = stack.pop()
        if first_val < second_val:
            return False
        storage_stack.append(first_val)
        stack.append(second_val)

    # Backup stack
    for i in range(len(storage_stack)):
        stack.append(storage_stack.pop())

    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.length_longest_path709
    set output_file "length_longest_path.py"

    set template_content '
def length_longest_path(input):
    curr_len, max_len = 0, 0    # running length and max length
    stack = []    # keep track of the name length
    for s in input.split('\n'):
        print("---------")
        print("<path>:", s)
        depth = s.count('\t')    # the depth of current dir or file
        print("depth: ", depth)
        print("stack: ", stack)
        print("curlen: ", curr_len)
        while len(stack) > depth:    # go back to the correct depth
            curr_len -= stack.pop()
        stack.append(len(s.strip('\t'))+1)   # 1 is the length of '/'
        curr_len += stack[-1]    # increase current length
        print("stack: ", stack)
        print("curlen: ", curr_len)
        if '.' in s:    # update maxlen only when it is a file
            max_len = max(max_len, curr_len-1)    # -1 is to minus one '/'
    return max_len


st = "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdirectory1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
st2 = "a\n\tb1\n\t\tf1.txt\n\taaaaa\n\t\tf2.txt"
print("path:", st2)

print("answer:", length_longest_path(st2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.OrderedStack710
    set output_file "SortListByFrequency.py"

    set template_content '
class OrderedStack:
    def __init__(self):
        self.items = []

    def is_empty(self):
        return self.items == []

    def push_t(self, item):
        self.items.append(item)

    # push method to maintain order when pushing new elements
    def push(self, item):
        temp_stack = OrderedStack()
        if self.is_empty() or item > self.peek():
            self.push_t(item)
        else:
            while item < self.peek() and not self.is_empty():
                temp_stack.push_t(self.pop())
            self.push_t(item)
            while not temp_stack.is_empty():
                self.push_t(temp_stack.pop())

    def pop(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self.items.pop()

    def peek(self):
        return self.items[len(self.items) - 1]

    def size(self):
        return len(self.items)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.remove_min711
    set output_file "remove_min.py"

    set template_content '
def remove_min(stack):
    storage_stack = []
    if len(stack) == 0:  # Stack is empty
        return stack
    # Find the smallest value
    min = stack.pop()
    stack.append(min)
    for i in range(len(stack)):
        val = stack.pop()
        if val <= min:
            min = val
        storage_stack.append(val)
    # Back up stack and remove min value
    for i in range(len(storage_stack)):
        val = storage_stack.pop()
        if val != min:
            stack.append(val)
    return stack
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.simplify_path712
    set output_file "simplify_path.py"

    set template_content '
def simplify_path(path):
    skip = {'..', '.', ''}
    stack = []
    paths = path.split('/')
    for tok in paths:
        if tok == '..':
            if stack:
                stack.pop()
        elif tok not in skip:
            stack.append(tok)
    return '/' + '/'.join(stack)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Stack713
    set output_file "Stack1.py"

    set template_content '
from abc import ABCMeta, abstractmethod


class AbstractStack(metaclass=ABCMeta):
    """Abstract Class for Stacks."""
    def __init__(self):
        self._top = -1

    def __len__(self):
        return self._top + 1

    def __str__(self):
        result = " ".join(map(str, self))
        return 'Top-> ' + result

    def is_empty(self):
        return self._top == -1

    @abstractmethod
    def __iter__(self):
        pass

    @abstractmethod
    def push(self, value):
        pass

    @abstractmethod
    def pop(self):
        pass

    @abstractmethod
    def peek(self):
        pass


class ArrayStack(AbstractStack):
    def __init__(self, size=10):
        """
        Initialize python List with size of 10 or user given input.
        Python List type is a dynamic array, so we have to restrict its
        dynamic nature to make it work like a static array.
        """
        super().__init__()
        self._array = [None] * size

    def __iter__(self):
        probe = self._top
        while True:
            if probe == -1:
                return
            yield self._array[probe]
            probe -= 1

    def push(self, value):
        self._top += 1
        if self._top == len(self._array):
            self._expand()
        self._array[self._top] = value

    def pop(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        value = self._array[self._top]
        self._top -= 1
        return value

    def peek(self):
        """returns the current top element of the stack."""
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self._array[self._top]

    def _expand(self):
        """
         expands size of the array.
         Time Complexity: O(n)
        """
        self._array += [None] * len(self._array)  # double the size of the array


class StackNode:
    """Represents a single stack node."""
    def __init__(self, value):
        self.value = value
        self.next = None


class LinkedListStack(AbstractStack):

    def __init__(self):
        super().__init__()
        self.head = None

    def __iter__(self):
        probe = self.head
        while True:
            if probe is None:
                return
            yield probe.value
            probe = probe.next

    def push(self, value):
        node = StackNode(value)
        node.next = self.head
        self.head = node
        self._top += 1

    def pop(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        value = self.head.value
        self.head = self.head.next
        self._top -= 1
        return value

    def peek(self):
        if self.is_empty():
            raise IndexError("Stack is empty")
        return self.head.value
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.stutter714
    set output_file "stutter.py"

    set template_content '
import collections


def first_stutter(stack):
    storage_stack = []
    for i in range(len(stack)):
        storage_stack.append(stack.pop())
    for i in range(len(storage_stack)):
        val = storage_stack.pop()
        stack.append(val)
        stack.append(val)

    return stack


def second_stutter(stack):
    q = collections.deque()
    # Put all values into queue from stack
    for i in range(len(stack)):
        q.append(stack.pop())
    # Put values back into stack from queue
    for i in range(len(q)):
        stack.append(q.pop())
    # Now, stack is reverse, put all values into queue from stack
    for i in range(len(stack)):
        q.append(stack.pop())
    # Put 2 times value into stack from queue
    for i in range(len(q)):
        val = q.pop()
        stack.append(val)
        stack.append(val)

    return stack
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.switch_pairs715
    set output_file "switch_pairs.py"

    set template_content '
import collections


def first_switch_pairs(stack):
    storage_stack = []
    for i in range(len(stack)):
        storage_stack.append(stack.pop())
    for i in range(len(storage_stack)):
        if len(storage_stack) == 0:
            break
        first = storage_stack.pop()
        if len(storage_stack) == 0:    # case: odd number of values in stack
            stack.append(first)
            break
        second = storage_stack.pop()
        stack.append(second)
        stack.append(first)
    return stack


def second_switch_pairs(stack):
    q = collections.deque()
    # Put all values into queue from stack
    for i in range(len(stack)):
        q.append(stack.pop())
    # Put values back into stack from queue
    for i in range(len(q)):
        stack.append(q.pop())
    # Now, stack is reverse, put all values into queue from stack
    for i in range(len(stack)):
        q.append(stack.pop())
    # Swap pairs by appending the 2nd value before appending 1st value
    for i in range(len(q)):
        if len(q) == 0:
            break
        first = q.pop()
        if len(q) == 0:                 # case: odd number of values in stack
            stack.append(first)
            break
        second = q.pop()
        stack.append(second)
        stack.append(first)

    return stack
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.valid_parenthesis716
    set output_file "valid_parenthesis.py"

    set template_content '
def is_valid(s: str) -> bool:
    stack = []
    dic = {")": "(",
           "}": "{",
           "]": "["}
    for char in s:
        if char in dic.values():
            stack.append(char)
        elif char in dic:
            if not stack or dic[char] != stack.pop():
                return False
    return not stack
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.streamingMisras_gries717
    set output_file "SortListByFrequency.py"

    set template_content '
def misras_gries(array,k=2):
    keys = {}
    for i in array:
        val = str(i)
        if val in keys:
            keys[val] = keys[val] + 1

        elif len(keys) < k - 1:
            keys[val] = 1

        else:
            for key in list(keys):
                keys[key] = keys[key] - 1
                if keys[key] == 0:
                    del keys[key]

    suspects =  keys.keys()
    frequencies = {}
    for suspect in suspects:
        freq = _count_frequency(array,int(suspect))
        if freq >= len(array) / k:
            frequencies[suspect] = freq

    return frequencies if len(frequencies) > 0 else None


def _count_frequency(array,element):
    return array.count(element)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.streaming_one_sparseRecovery718
    set output_file "SortListByFrequency.py"

    set template_content '
def one_sparse(array):
    sum_signs = 0
    bitsum = [0]*32
    sum_values = 0
    for val,sign in array:
        if sign == "+":
            sum_signs += 1
            sum_values += val
        else:
            sum_signs -= 1
            sum_values -= val

        _get_bit_sum(bitsum,val,sign)

    if sum_signs > 0 and _check_every_number_in_bitsum(bitsum,sum_signs):
        return int(sum_values/sum_signs)
    else:
        return None

#Helper function to check that every entry in the list is either 0 or  the same as the
#sum of signs
def _check_every_number_in_bitsum(bitsum,sum_signs):
    for val in bitsum:
        if val != 0 and val != sum_signs :
            return False
    return True

# Adds bit representation value to bitsum array
def _get_bit_sum(bitsum,val,sign):
    i = 0
    if sign == "+":
        while val:
            bitsum[i] += val & 1
            i +=1
            val >>=1
    else :
        while val:
            bitsum[i] -= val & 1
            i +=1
            val >>=1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.count_islands719
    set output_file "count_islands.py"

    set template_content '
class Union:

    def __init__(self):
        self.parents = {}
        self.size = {}
        self.count = 0

    def add(self, element):
        self.parents[element] = element
        self.size[element] = 1
        self.count += 1

    def root(self, element):

        while element != self.parents[element]:
            self.parents[element] = self.parents[self.parents[element]]
            element = self.parents[element]
        return element

    def unite(self, element1, element2):

        root1, root2 = self.root(element1), self.root(element2)
        if root1 == root2:
            return
        if self.size[root1] > self.size[root2]:
            root1, root2 = root2, root1
        self.parents[root1] = root2
        self.size[root2] += self.size[root1]
        self.count -= 1


def num_islands(positions):

    ans = []
    islands = Union()
    for position in map(tuple, positions):
        islands.add(position)
        for delta in (0, 1), (0, -1), (1, 0), (-1, 0):
            adjacent = (position[0] + delta[0], position[1] + delta[1])
            if adjacent in islands.parents:
                islands.unite(position, adjacent)
        ans += [islands.count]
    return ans
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.split720
    set output_file "split.py"

    set template_content '
import os

def split(path):
    parts = []
    split_part = path.rpartition('/')
    # Takt the origin path without the last part
    parts.append(split_part[0])
    # Take the last element of list
    parts.append(split_part[2])
    return parts
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.simplify_path721
    set output_file "simplify_path.py"

    set template_content '
import os
def simplify_path_v1(path):
    return os.path.abspath(path)

def simplify_path_v2(path):
    stack, tokens = [], path.split("/")
    for token in tokens:
        if token == ".." and stack:
            stack.pop()
        elif token != ".." and token != "." and token:
            stack.append(token)
    return "/" + "/".join(stack)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.join_with_slash722
    set output_file "join_with_slash.py"

    set template_content '
import os

def join_with_slash(base, suffix):
    # Remove / trailing
    base = base.rstrip('/')
    # Remove / leading
    suffix = suffix.lstrip('/').rstrip()
    full_path = "{}/{}".format(base, suffix)
    return full_path
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.full_path723
    set output_file "full_path.py"

    set template_content '
import os
def full_path(file):
    return os.path.abspath(os.path.expanduser(file))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.add_binary724
    set output_file "add_binary.py"

    set template_content '
def add_binary(a, b):
    s = ""
    c, i, j = 0, len(a)-1, len(b)-1
    zero = ord('0')
    while (i >= 0 or j >= 0 or c == 1):
        if (i >= 0):
            c += ord(a[i]) - zero
            i -= 1
        if (j >= 0):
            c += ord(b[j]) - zero
            j -= 1
        s = chr(c % 2 + zero) + s
        c //= 2 
        
    return s
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.atbash_cipher725
    set output_file "atbash_cipher.py"

    set template_content '
def atbash(s):
    translated = ""
    for i in range(len(s)):
        n = ord(s[i])
        
        if s[i].isalpha():
            
            if s[i].isupper():
                x = n - ord('A')
                translated += chr(ord('Z') - x)
            
            if s[i].islower():
                x = n - ord('a')
                translated += chr(ord('z') - x)
        else:
            translated += s[i]
    return translated
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.breaking_bad726
    set output_file "breaking_bad..py"

    set template_content '
from functools import reduce


def match_symbol(words, symbols):
    import re
    combined = []
    for s in symbols:
        for c in words:
            r = re.search(s, c)
            if r:
                combined.append(re.sub(s, "[{}]".format(s), c))
    return combined

def match_symbol_1(words, symbols):
    res = []
    # reversely sort the symbols according to their lengths.
    symbols = sorted(symbols, key=lambda _: len(_), reverse=True)
    for word in words:
        for symbol in symbols:
            word_replaced = ''
            # once match, append the `word_replaced` to res, process next word
            if word.find(symbol) != -1:
                word_replaced = word.replace(symbol, '[' + symbol + ']')
                res.append(word_replaced)
                break
        # if this word matches no symbol, append it.
        if word_replaced == '':
            res.append(word)
    return res



class TreeNode:
    def __init__(self):
        self.c = dict()
        self.sym = None


def bracket(words, symbols):
    root = TreeNode()
    for s in symbols:
        t = root
        for char in s:
            if char not in t.c:
                t.c[char] = TreeNode()
            t = t.c[char]
        t.sym = s
    result = dict()
    for word in words:
        i = 0
        symlist = list()
        while i < len(word):
            j, t = i, root
            while j < len(word) and word[j] in t.c:
                t = t.c[word[j]]
                if t.sym is not None:
                    symlist.append((j + 1 - len(t.sym), j + 1, t.sym))
                j += 1
            i += 1
        if len(symlist) > 0:
            sym = reduce(lambda x, y: x if x[1] - x[0] >= y[1] - y[0] else y,
                         symlist)
            result[word] = "{}[{}]{}".format(word[:sym[0]], sym[2],
                                             word[sym[1]:])
    return tuple(word if word not in result else result[word] for word in words)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.caesar_cipher727
    set output_file "caesar_cipher.py"

    set template_content '
def caesar_cipher(s, k):
    result = ""
    for char in s:
        n = ord(char)
        if 64 < n < 91:
            n = ((n - 65 + k) % 26) + 65
        if 96 < n < 123:
            n = ((n - 97 + k) % 26) + 97
        result = result + chr(n)
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.check_pangram728
    set output_file "check_pangram.py"

    set template_content '
def check_pangram(input_string):
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    for ch in alphabet:
        if ch not in input_string.lower():
            return False
    return True 
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.contain_string729
    set output_file "contain_string.py"

    set template_content '
def contain_string(haystack, needle):
    if len(needle) == 0:
        return 0
    if len(needle) > len(haystack):
        return -1
    for i in range(len(haystack)):
        if len(haystack) - i < len(needle):
            return -1
        if haystack[i:i+len(needle)] == needle:
            return i
    return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.count_binary_substring730
    set output_file "count_binary_substring.py"

    set template_content '
def count_binary_substring(s):
    cur = 1
    pre = 0
    count = 0
    for i in range(1, len(s)):
        if s[i] != s[i - 1]:
            count = count + min(pre, cur)
            pre = cur
            cur = 1
        else:
            cur = cur + 1
    count = count + min(pre, cur)
    return count
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.decode_string731
    set output_file "decode_string.py"

    set template_content '
def decode_string(s):
    stack = []; cur_num = 0; cur_string = ''
    for c in s:
        if c == '[':
            stack.append((cur_string, cur_num))
            cur_string = ''
            cur_num = 0
        elif c == ']':
            prev_string, num = stack.pop()
            cur_string = prev_string + num * cur_string
        elif c.isdigit():
            cur_num = cur_num*10 + int(c)
        else:
            cur_string += c
    return cur_string
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.delete_reoccurring_characters732
    set output_file "delete_reoccurring_characters.py"

    set template_content '
def delete_reoccurring_characters(string):
    seen_characters = set()
    output_string = ''
    for char in string:
        if char not in seen_characters:
            seen_characters.add(char)
            output_string += char
    return output_string

    
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.domain_name733
    set output_file "domain_name.py"

    set template_content '
def domain_name_1(url):
	#grab only the non http(s) part
    full_domain_name = url.split('//')[-1] 
    #grab the actual one depending on the len of the list  
    actual_domain = full_domain_name.split('.')  
    
    # case when www is in the url
    if (len(actual_domain) > 2):
        return actual_domain[1]    
    # case when www is not in the url
    return actual_domain[0]


# pythonic one liner
def domain_name_2(url):
    return url.split("//")[-1].split("www.")[-1].split(".")[0]

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.encode734
    set output_file "encode_decode.py"

    set template_content '
def encode(strs):
    res = ''
    for string in strs.split():
        res += str(len(string)) + ":" + string
    return res

def decode(s):
    strs = []
    i = 0
    while i < len(s):
        index = s.find(":", i)
        size = int(s[i:index])
        strs.append(s[index+1: index+1+size])
        i = index+1+size
    return strs
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.first_unique_char735
    set output_file "first_unique_char.py"

    set template_content '
def first_unique_char(s):
    if (len(s) == 1):
        return 0
    ban = []
    for i in range(len(s)):
        if all(s[i] != s[k] for k in range(i + 1, len(s))) == True and s[i] not in ban:
            return i
        else:
            ban.append(s[i])
    return -1   
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.fizzbuzz736
    set output_file "fizzbuzz.py"

    set template_content '
def fizzbuzz(n):
    
    # Validate the input
    if n < 1:
        raise ValueError('n cannot be less than one')
    if n is None:
        raise TypeError('n cannot be None')
    
    result = []
    
    for i in range(1, n+1):
        if i%3 == 0 and i%5 == 0:
            result.append('FizzBuzz')
        elif i%3 == 0:
            result.append('Fizz')
        elif i%5 == 0:
            result.append('Buzz')
        else:
            result.append(i)
    return result

# Alternative solution
def fizzbuzz_with_helper_func(n):
    return [fb(m) for m in range(1,n+1)]
    
def fb(m):
    r = (m % 3 == 0) * "Fizz" + (m % 5 == 0) * "Buzz"
    return r if r != "" else m
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.group_anagrams737
    set output_file "group_anagrams.py"

    set template_content '
def group_anagrams(strs):
    d = {}
    ans = []
    k = 0
    for str in strs:
        sstr = ''.join(sorted(str))
        if sstr not in d:
            d[sstr] = k
            k += 1
            ans.append([])
            ans[-1].append(str)
        else:
            ans[d[sstr]].append(str)
    return ans
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.int_to_roman738
    set output_file "SortListByFrequency.py"

    set template_content '
def int_to_roman(num):
    """
    :type num: int
    :rtype: str
    """
    m = ["", "M", "MM", "MMM"];
    c = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
    x = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
    i = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
    return m[num//1000] + c[(num%1000)//100] + x[(num%100)//10] + i[num%10];
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.is_palindrome739
    set output_file "is_palindrome.py"

    set template_content '
from string import ascii_letters
from collections import deque


def is_palindrome(s):
    i = 0
    j = len(s) - 1
    while i < j:
        while not s[i].isalnum():
            i += 1
        while not s[j].isalnum():
            j -= 1
        if s[i].lower() != s[j].lower():
            return False
        i, j = i + 1, j - 1
    return True


def remove_punctuation(s):
    return "".join(i.lower() for i in s if i in ascii_letters)


# Variation 1
def string_reverse(s):
    return s[::-1]


def is_palindrome_reverse(s):
    s = remove_punctuation(s)

    # can also get rid of the string_reverse function and just do this return s == s[::-1] in one line.
    if s == string_reverse(s):
        return True
    return False


# Variation 2
def is_palindrome_two_pointer(s):
    s = remove_punctuation(s)

    for i in range(0, len(s) // 2):
        if s[i] != s[len(s) - i - 1]:
            return False
    return True


# Variation 3
def is_palindrome_stack(s):
    stack = []
    s = remove_punctuation(s)

    for i in range(len(s) // 2, len(s)):
        stack.append(s[i])
    for i in range(0, len(s) // 2):
        if s[i] != stack.pop():
            return False
    return True


# Variation 4 (using deque)
def is_palindrome_deque(s):
    s = remove_punctuation(s)
    deq = deque()
    for char in s:
        deq.appendleft(char)

    equal = True

    while len(deq) > 1 and equal:
        first = deq.pop()
        last = deq.popleft()
        if first != last:
            equal = False

    return equal
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.is_rotated740
    set output_file "is_rotated.py"

    set template_content '
def is_rotated(s1, s2):
    if len(s1) == len(s2):
        return s2 in s1 + s1
    else:
        return False

def is_rotated_v1(s1, s2):
    if len(s1) != len(s2):
        return False
    if len(s1) == 0:
        return True

    for c in range(len(s1)):
        if all(s1[(c + i) % len(s1)] == s2[i] for i in range(len(s1))):
            return True
    return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.judge_circle741
    set output_file "judge_circle.py"

    set template_content '
def judge_circle(moves):
    dict_moves = {
        'U' : 0,
        'D' : 0,
        'R' : 0,
        'L' : 0
    }
    for char in moves:
        dict_moves[char] = dict_moves[char] + 1
    return dict_moves['L'] == dict_moves['R'] and dict_moves['U'] == dict_moves['D']
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.knuth_morris_pratt742
    set output_file "knuth_morris_pratt.py"

    set template_content '
def knuth_morris_pratt(text: Sequence, pattern: Sequence) -> List[int]:
    n = len(text)
    m = len(pattern)
    pi = [0 for i in range(m)]
    i = 0
    j = 0
    # making pi table
    for i in range(1, m):
        while j and pattern[i] != pattern[j]:
            j = pi[j - 1]
        if pattern[i] == pattern[j]:
            j += 1
            pi[i] = j
    # finding pattern
    j = 0
    ret = []
    for i in range(n):
        while j and text[i] != pattern[j]:
            j = pi[j - 1]
        if text[i] == pattern[j]:
            j += 1
            if j == m:
                ret.append(i - m + 1)
                j = pi[j - 1]
    return ret
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.license_number743
    set output_file "license_number.py"

    set template_content '
def license_number(key, k):
    res, alnum = [], []
    for char in key:
        if char != "-":
            alnum.append(char)
    for i, char in enumerate(reversed(alnum)):
        res.append(char)
        if (i+1) % k == 0 and i != len(alnum)-1:
            res.append("-")
    return "".join(res[::-1])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.longest_common_prefix744
    set output_file " longest_common_prefix.py"

    set template_content '
def common_prefix(s1, s2):
    "Return prefix common of 2 strings"
    if not s1 or not s2:
        return ""
    k = 0
    while s1[k] == s2[k]:
        k = k + 1
        if k >= len(s1) or k >= len(s2):
            return s1[0:k]
    return s1[0:k]

def longest_common_prefix_v1(strs):
    if not strs:
        return ""
    result = strs[0]
    for i in range(len(strs)):
        result = common_prefix(result, strs[i])
    return result

"""
Second solution: Vertical scanning
"""
def longest_common_prefix_v2(strs):
    if not strs:
        return ""
    for i in range(len(strs[0])):
        for string in strs[1:]:
            if i == len(string) or string[i] != strs[0][i]:
                return strs[0][0:i]
    return strs[0]

"""
Third solution: Divide and Conquer
"""
def longest_common_prefix_v3(strs):
    if not strs:
        return ""
    return longest_common(strs, 0, len(strs) -1)

def longest_common(strs, left, right):
    if left == right:
        return strs[left]
    mid = (left + right) // 2
    lcp_left = longest_common(strs, left, mid)
    lcp_right = longest_common(strs, mid + 1, right)
    return common_prefix(lcp_left, lcp_right)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.longest_palindrome745
    set output_file "longest_palindrome.py"

    set template_content '
ef longest_palindrome(s):
    if len(s) < 2:
        return s

    n_str = '#' + '#'.join(s) + '#'
    p = [0] * len(n_str)
    mx, loc = 0, 0
    index, maxlen = 0, 0
    for i in range(len(n_str)):
        if i < mx and 2 * loc - i < len(n_str):
            p[i] = min(mx - i, p[2 * loc - i])
        else:
            p[i] = 1

        while p[i] + i < len(n_str) and i - p[i] >= 0 and n_str[
                i - p[i]] == n_str[i + p[i]]:
            p[i] += 1

        if i + p[i] > mx:
            mx = i + p[i]
            loc = i

        if p[i] > maxlen:
            index = i
            maxlen = p[i]
    s = n_str[index - p[index] + 1:index + p[index]]
    return s.replace('#', '')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.make_sentence746
    set output_file "make_sentence.py"

    set template_content '
count = 0


def make_sentence(str_piece, dictionaries):
    global count
    if len(str_piece) == 0:
        return True
    for i in range(0, len(str_piece)):
        prefix, suffix = str_piece[0:i], str_piece[i:]
        if prefix in dictionaries:
            if suffix in dictionaries or make_sentence(suffix, dictionaries):
                count += 1
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.merge_string_checker747
    set output_file "merge_string_checker.py"

    set template_content '
def is_merge_recursive(s, part1, part2):
    if not part1:
        return s == part2
    if not part2:
        return s == part1
    if not s:
        return part1 + part2 == ''
    if s[0] == part1[0] and is_merge_recursive(s[1:], part1[1:], part2):
        return True
    if s[0] == part2[0] and is_merge_recursive(s[1:], part1, part2[1:]):
        return True
    return False


# An iterative approach
def is_merge_iterative(s, part1, part2):
    tuple_list = [(s, part1, part2)]
    while tuple_list:
        string, p1, p2 = tuple_list.pop()            
        if string:
            if p1 and string[0] == p1[0]:
                tuple_list.append((string[1:], p1[1:], p2))
            if p2 and string[0] == p2[0]:
                tuple_list.append((string[1:], p1, p2[1:]))
        else:
            if not p1 and not p2:
                return True
    return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.min_distance748
    set output_file "min_distance..py"

    set template_content '
def min_distance(word1, word2):
    return len(word1) + len(word2) - 2 * lcs(word1, word2, len(word1), len(word2))


def lcs(word1, word2, i, j):
    if i == 0 or j == 0:
        return 0
    if word1[i - 1] == word2[j - 1]:
        return 1 + lcs(word1, word2, i - 1, j - 1)
    return max(lcs(word1, word2, i - 1, j), lcs(word1, word2, i, j - 1))


def min_distance_dp(word1, word2):
    length1, length2 = len(word1) + 1, len(word2) + 1
    res = [[0 for _ in range(length2)] for _ in range(length1)]

    if length1 == length2:
        for i in range(1, length1):
            res[i][0], res[0][i] = i, i
    else:
        for i in range(length1):
            res[i][0] = i
        for i in range(length2):
            res[0][i] = i

    for i in range(1, length1):
        for j in range(1, length2):
            if word1[i - 1] == word2[j - 1]:
                res[i][j] = res[i - 1][j - 1]
            else:
                res[i][j] = min(res[i - 1][j], res[i][j - 1]) + 1

    return res[len(word1)][len(word2)]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.multiply_string749
    set output_file "multiply_string.py"

    set template_content '
def multiply(num1: "str", num2: "str") -> "str":
    interm = []
    zero = ord('0')
    i_pos = 1
    for i in reversed(num1):
        j_pos = 1
        add = 0
        for j in reversed(num2):
            mult = (ord(i)-zero) * (ord(j)-zero) * j_pos * i_pos
            j_pos *= 10
            add += mult
        i_pos *= 10
        interm.append(add)
    return str(sum(interm))


if __name__ == "__main__":
    print(multiply("1", "23"))
    print(multiply("23", "23"))
    print(multiply("100", "23"))
    print(multiply("100", "10000"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.one_edit_distance750
    set output_file "one_edit_distance.py"

    set template_content '
def is_one_edit(s, t):
    if len(s) > len(t):
        return is_one_edit(t, s)
    if len(t) - len(s) > 1 or t == s:
        return False
    for i in range(len(s)):
        if s[i] != t[i]:
            return s[i+1:] == t[i+1:] or s[i:] == t[i+1:]
    return True


def is_one_edit2(s, t):
    l1, l2 = len(s), len(t)
    if l1 > l2:
        return is_one_edit2(t, s)
    if len(t) - len(s) > 1 or t == s:
        return False
    for i in range(len(s)):
        if s[i] != t[i]:
            if l1 == l2:
                s = s[:i]+t[i]+s[i+1:]  # modify
            else:
                s = s[:i]+t[i]+s[i:]  # insertion
            break
    return s == t or s == t[:-1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.panagram751
    set output_file "panagram.py"

    set template_content '
from string import ascii_lowercase

def panagram(string):
    letters = set(ascii_lowercase)
    for c in string:
        try:
            letters.remove(c.lower())
        except:
            pass
    return len(letters) == 0
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.word_squares752
    set output_file "word_squares.py"

    set template_content '
import collections

def word_squares(words):
    n = len(words[0])
    fulls = collections.defaultdict(list)
    for word in words:
        for i in range(n):
            fulls[word[:i]].append(word)

    def build(square):
        if len(square) == n:
            squares.append(square)
            return
        prefix = ""
        for k in range(len(square)):
            prefix += square[k][len(square)]
        for word in fulls[prefix]:
            build(square + [word])
    squares = []
    for word in words:
        build([word])
    return squares

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.strip_url_params753
    set output_file "strip_url_params.py"

    set template_content '
from collections import defaultdict
import urllib
import urllib.parse

# Here is a very non-pythonic grotesque solution
def strip_url_params1(url, params_to_strip=None):
    
    if not params_to_strip:
        params_to_strip = []
    if url:
        result = '' # final result to be returned
        tokens = url.split('?')
        domain = tokens[0]
        query_string = tokens[-1]
        result += domain
        # add the '?' to our result if it is in the url
        if len(tokens) > 1:
            result += '?'
        if not query_string:
            return url
        else:
            # logic for removing duplicate query strings
            # build up the list by splitting the query_string using digits
            key_value_string = []
            string = ''
            for char in query_string:
                if char.isdigit():
                    key_value_string.append(string + char)
                    string = ''
                else:
                    string += char
            dict = defaultdict(int)
            # logic for checking whether we should add the string to our result
            for i in key_value_string:
                _token = i.split('=')
                if _token[0]:
                    length = len(_token[0])
                    if length == 1:
                        if _token and (not(_token[0] in dict)):
                            if params_to_strip:
                                if _token[0] != params_to_strip[0]:
                                    dict[_token[0]] = _token[1]
                                    result = result + _token[0] + '=' + _token[1]
                            else:
                                if not _token[0] in dict:
                                    dict[_token[0]] = _token[1]
                                    result = result + _token[0] + '=' + _token[1]
                    else:
                        check = _token[0]
                        letter = check[1]
                        if _token and (not(letter in dict)):
                            if params_to_strip:
                                if letter != params_to_strip[0]:
                                    dict[letter] = _token[1]
                                    result = result + _token[0] + '=' + _token[1]
                            else:
                                if not letter in dict:
                                    dict[letter] = _token[1]
                                    result = result + _token[0] + '=' + _token[1]
    return result

# A very friendly pythonic solution (easy to follow)
def strip_url_params2(url, param_to_strip=[]):
    if '?' not in url:
        return url

    queries = (url.split('?')[1]).split("&")
    queries_obj = [query[0] for query in queries]
    for i in range(len(queries_obj) - 1, 0, -1):
        if queries_obj[i] in param_to_strip or queries_obj[i] in queries_obj[0:i]:
            queries.pop(i)

    return url.split('?')[0] + '?' + "&".join(queries)


# Here is my friend's solution using python's builtin libraries
def strip_url_params3(url, strip=None):
    if not strip: strip = []
    
    parse = urllib.parse.urlparse(url)
    query = urllib.parse.parse_qs(parse.query)
    
    query = {k: v[0] for k, v in query.items() if k not in strip}
    query = urllib.parse.urlencode(query)
    new = parse._replace(query=query)
    
    return new.geturl()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.text_justification754
    set output_file "text_justification.py"

    set template_content '
def text_justification(words, max_width):
   
    ret = []  # return value
    row_len = 0  # current length of strs in a row
    row_words = []  # current words in a row
    index = 0  # the index of current word in words
    is_first_word = True  # is current word the first in a row
    while index < len(words):
        while row_len <= max_width and index < len(words):
            if len(words[index]) > max_width:
                raise ValueError("there exists word whose length is larger than max_width")
            tmp = row_len
            row_words.append(words[index])
            tmp += len(words[index])
            if not is_first_word:
                tmp += 1  # except for the first word, each word should have at least a ' ' before it.
            if tmp > max_width:
                row_words.pop()
                break
            row_len = tmp
            index += 1
            is_first_word = False
        # here we have already got a row of str , then we should supplement enough ' ' to make sure the length is max_width.
        row = ""
        # if the row is the last
        if index == len(words):
            for word in row_words:
                row += (word + ' ')
            row = row[:-1]
            row += ' ' * (max_width - len(row))
        # not the last row and more than one word
        elif len(row_words) != 1:
            space_num = max_width - row_len
            space_num_of_each_interval = space_num // (len(row_words) - 1)
            space_num_rest = space_num - space_num_of_each_interval * (len(row_words) - 1)
            for j in range(len(row_words)):
                row += row_words[j]
                if j != len(row_words) - 1:
                    row += ' ' * (1 + space_num_of_each_interval)
                if space_num_rest > 0:
                    row += ' '
                    space_num_rest -= 1
        # row with only one word
        else:
            row += row_words[0]
            row += ' ' * (max_width - len(row))
        ret.append(row)
        # after a row , reset those value
        row_len = 0
        row_words = []
        is_first_word = True
    return ret
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.unique_morse755
    set output_file "unique_morse.py"

    set template_content '
morse_code = {
    'a':".-",
    'b':"-...",
    'c':"-.-.",
    'd': "-..",
    'e':".",
    'f':"..-.",
    'g':"--.",
    'h':"....",
    'i':"..",
    'j':".---",
    'k':"-.-",
    'l':".-..",
    'm':"--",
    'n':"-.",
    'o':"---",
    'p':".--.",
    'q':"--.-",
    'r':".-.",
    's':"...",
    't':"-",
    'u':"..-",
    'v':"...-",
    'w':".--",
    'x':"-..-",
    'y':"-.--",
    'z':"--.."
}
def convert_morse_word(word):
    morse_word = ""
    word = word.lower()
    for char in word:
        morse_word = morse_word + morse_code[char]
    return morse_word

def unique_morse(words):
    unique_morse_word = []
    for word in words:
        morse_word = convert_morse_word(word)
        if morse_word not in unique_morse_word:
            unique_morse_word.append(morse_word)
    return len(unique_morse_word)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.valid_coordinates756
    set output_file "valid_coordinates.py"

    set template_content '
import re
def is_valid_coordinates_0(coordinates):
    for char in coordinates:
        if not (char.isdigit() or char in ['-', '.', ',', ' ']):
            return False
    l = coordinates.split(", ")
    if len(l) != 2:
        return False
    try:
        latitude = float(l[0])
        longitude = float(l[1])
    except:
        return False
    return -90 <= latitude <= 90 and -180 <= longitude <= 180

# friends solutions
def is_valid_coordinates_1(coordinates):
    try:
        lat, lng = [abs(float(c)) for c in coordinates.split(',') if 'e' not in c]
    except ValueError:
        return False

    return lat <= 90 and lng <= 180

# using regular expression
def is_valid_coordinates_regular_expression(coordinates):
    return bool(re.match("-?(\d|[1-8]\d|90)\.?\d*, -?(\d|[1-9]\d|1[0-7]\d|180)\.?\d*$", coordinates))  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.rabin_karp757
    set output_file "SortListByFrequency.py"

    set template_content '
class RollingHash:
    def __init__(self, text, size_word):
        self.text = text
        self.hash = 0
        self.size_word = size_word

        for i in range(0, size_word):
            #ord maps the character to a number
            #subtract out the ASCII value of "a" to start the indexing at zero
            self.hash += (ord(self.text[i]) - ord("a")+1)*(26**(size_word - i -1))

        #start index of current window
        self.window_start = 0
        #end of index window
        self.window_end = size_word

    def move_window(self):
        if self.window_end <= len(self.text) - 1:
            #remove left letter from hash value
            self.hash -= (ord(self.text[self.window_start]) - ord("a")+1)*26**(self.size_word-1)
            self.hash *= 26
            self.hash += ord(self.text[self.window_end])- ord("a")+1
            self.window_start += 1
            self.window_end += 1

    def window_text(self):
        return self.text[self.window_start:self.window_end]

def rabin_karp(word, text):
    if word == "" or text == "":
        return None
    if len(word) > len(text):
        return None

    rolling_hash = RollingHash(text, len(word))
    word_hash = RollingHash(word, len(word))
    #word_hash.move_window()

    for i in range(len(text) - len(word) + 1):
        if rolling_hash.hash == word_hash.hash:
            if rolling_hash.window_text() == word:
                return i
        rolling_hash.move_window()
    return None

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.repeat_string758
    set output_file "SortListByFrequency.py"

    set template_content '
def repeat_string(A, B):
    count = 1
    tmp = A
    max_count = (len(B) / len(A)) + 1
    while not(B in tmp):
        tmp = tmp + A
        if (count > max_count):
            count = -1
            break
        count = count + 1

    return count
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.repeat_substring759
    set output_file "repeat_substring.py"

    set template_content '

def repeat_substring(s):
    str = (s + s)[1:-1]
    return s in str
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_string760
    set output_file "reverse_string.py"

    set template_content '
def recursive(s):
    l = len(s)
    if l < 2:
        return s
    return recursive(s[l//2:]) + recursive(s[:l//2])

def iterative(s):
    r = list(s)
    i, j = 0, len(s) - 1
    while i < j:
        r[i], r[j] = r[j], r[i]
        i += 1
        j -= 1
    return "".join(r)

def pythonic(s):
    r = list(reversed(s))
    return "".join(r)

def ultra_pythonic(s):
    return s[::-1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_vowel761
    set output_file "reverse_vowel.py"

    set template_content '
def reverse_vowel(s):
    vowels = "AEIOUaeiou"
    i, j = 0, len(s)-1
    s = list(s)
    while i < j:
        while i < j and s[i] not in vowels:
            i += 1
        while i < j and s[j] not in vowels:
            j -= 1
        s[i], s[j] = s[j], s[i]
        i, j = i + 1, j - 1
    return "".join(s)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.reverse_words762
    set output_file "reverse_words..py"

    set template_content '
def reverse(array, i, j):
    while i < j:
        array[i], array[j] = array[j], array[i]
        i += 1
        j -= 1


def reverse_words(string):
    arr = string.strip().split()  # arr is list of words
    n = len(arr)
    reverse(arr, 0, n-1)

    return " ".join(arr)


if __name__ == "__main__":
    test = "I am keon kim and I like pizza"
    print(test)
    print(reverse_words(test))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.roman_to_int763
    set output_file "roman_to_int.py"

    set template_content '
def roman_to_int(s:"str")->"int":
    number = 0
    roman = {'M':1000, 'D':500, 'C': 100, 'L':50, 'X':10, 'V':5, 'I':1}
    for i in range(len(s)-1):
        if roman[s[i]] < roman[s[i+1]]:
            number -= roman[s[i]]
        else:
            number += roman[s[i]]
    return number + roman[s[-1]]


if __name__ == "__main__":
    roman = "DCXXI"
    print(roman_to_int(roman))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.rotate764
    set output_file "SortListByFrequency.py"

    set template_content '
def rotate(s, k):
    long_string = s * (k // len(s) + 2)
    if k <= len(s):
        return long_string[k:k + len(s)]
    else:
        return long_string[k-len(s):k]
    
def rotate_alt(string, k):
    k = k % len(string)
    return string[k:] + string[:k]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.strong_password765
    set output_file "strong_password.py"

    set template_content '
def strong_password(n, password):
    count_error = 0
    # Return the minimum number of characters to make the password strong
    if any(i.isdigit() for i in password) == False:
        count_error = count_error + 1
    if any(i.islower() for i in password) == False:
        count_error = count_error + 1
    if any(i.isupper() for i in password) == False:
        count_error = count_error + 1
    if any(i in "!@#$%^&*()-+" for i in password) == False:
        count_error = count_error + 1
    return max(count_error, 6 - n)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.delete_nth_naive766
    set output_file "delete_nth_naive.py"

    set template_content '
import collections


# Time complexity O(n^2)
def delete_nth_naive(array, n):
    ans = []
    for num in array:
        if ans.count(num) < n:
            ans.append(num)
    return ans


# Time Complexity O(n), using hash tables.
def delete_nth(array, n):
    result = []
    counts = collections.defaultdict(int)  # keep track of occurrences

    for i in array:

        if counts[i] < n:
            result.append(i)
            counts[i] += 1

    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.flatten767
    set output_file "flatten.py"

    set template_content '
from collections.abc import Iterable


# return list
def flatten(input_arr, output_arr=None):
    if output_arr is None:
        output_arr = []
    for ele in input_arr:
        if not isinstance(ele, str) and isinstance(ele, Iterable):
            flatten(ele, output_arr)    #tail-recursion
        else:
            output_arr.append(ele)      #produce the result
    return output_arr


# returns iterator
def flatten_iter(iterable):
    """
    Takes as input multi dimensional iterable and
    returns generator which produces one dimensional output.
    """
    for element in iterable:
        if not isinstance(element, str) and isinstance(element, Iterable):
            yield from flatten_iter(element)    
        else:
            yield element
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.garage768
    set output_file "SortListByFrequency.py"

    set template_content '
def garage(initial, final):

    initial = initial[::]      # prevent changes in original 'initial'
    seq = []                   # list of each step in sequence
    steps = 0
    while initial != final:
        zero = initial.index(0)
        if zero != final.index(0):  # if zero isnt where it should be,
            car_to_move = final[zero]   # what should be where zero is,
            pos = initial.index(car_to_move)         # and where is it?
            initial[zero], initial[pos] = initial[pos], initial[zero]
        else:
            for i in range(len(initial)):
                if initial[i] != final[i]:
                    initial[zero], initial[i] = initial[i], initial[zero]
                    break
        seq.append(initial[::])
        steps += 1

    return steps, seq   
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.josephus769
    set output_file "josephus.py"

    set template_content '
def josephus(int_list, skip):
    skip = skip - 1                     # list starts with 0 index
    idx = 0
    len_list = (len(int_list))
    while len_list > 0:
        idx = (skip + idx) % len_list   # hash index to every 3rd
        yield int_list.pop(idx)
        len_list -= 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.limit770
    set output_file "limit.py"

    set template_content '
def limit(arr, min_lim=None, max_lim=None):
    if len(arr) == 0:
        return arr

    if min_lim is None:
        min_lim = min(arr)
    if max_lim is None:
        max_lim = max(arr)

    return list(filter(lambda x: (min_lim <= x <= max_lim), arr))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_non_repeat771
    set output_file "longest_non_repeat_v1.py"

    set template_content '
def longest_non_repeat_v1(string):
    if string is None:
        return 0
    dict = {}
    max_length = 0
    j = 0
    for i in range(len(string)):
        if string[i] in dict:
            j = max(dict[string[i]], j)
        dict[string[i]] = i + 1
        max_length = max(max_length, i - j + 1)
    return max_length

def longest_non_repeat_v2(string):
    if string is None:
        return 0
    start, max_len = 0, 0
    used_char = {}
    for index, char in enumerate(string):
        if char in used_char and start <= used_char[char]:
            start = used_char[char] + 1
        else:
            max_len = max(max_len, index - start + 1)
        used_char[char] = index
    return max_len

# get functions of above, returning the max_len and substring
def get_longest_non_repeat_v1(string):
    if string is None:
        return 0, ''
    sub_string = ''
    dict = {}
    max_length = 0
    j = 0
    for i in range(len(string)):
        if string[i] in dict:
            j = max(dict[string[i]], j)
        dict[string[i]] = i + 1
        if i - j + 1 > max_length:
            max_length = i - j + 1
            sub_string = string[j: i + 1]
    return max_length, sub_string

def get_longest_non_repeat_v2(string):
    if string is None:
        return 0, ''
    sub_string = ''
    start, max_len = 0, 0
    used_char = {}
    for index, char in enumerate(string):
        if char in used_char and start <= used_char[char]:
            start = used_char[char] + 1
        else:
            if index - start + 1 > max_len:
                max_len = index - start + 1
                sub_string = string[start: index + 1]
        used_char[char] = index
    return max_len, sub_string

def get_longest_non_repeat_v3(string):
    longest_substring = ''
    seen = set()
    start_idx = 0
    for i in range(len(string)):
        while string[i] in seen:
            seen.remove(string[start_idx])
            start_idx += 1
        seen.add(string[i])
        longest_substring = max(longest_substring, string[start_idx: i+1], key=len)
    return len(longest_substring), longest_substring
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.max_ones_index772
    set output_file "max_ones_index.py"

    set template_content '
def max_ones_index(arr):

    n = len(arr)
    max_count = 0
    max_index = 0
    prev_zero = -1
    prev_prev_zero = -1

    for curr in range(n):

        # If current element is 0,
        # then calculate the difference
        # between curr and prev_prev_zero
        if arr[curr] == 0:
            if curr - prev_prev_zero > max_count:
                max_count = curr - prev_prev_zero
                max_index = prev_zero

            prev_prev_zero = prev_zero
            prev_zero = curr

    if n - prev_prev_zero > max_count:
        max_index = prev_zero

    return max_index
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.merge_intervals773
    set output_file "merge_intervals.py"

    set template_content '
class Interval:
    def __init__(self, start=0, end=0):
        self.start = start
        self.end = end

    def __repr__(self):
        return "Interval ({}, {})".format(self.start, self.end)

    def __iter__(self):
        return iter(range(self.start, self.end))

    def __getitem__(self, index):
        if index < 0:
            return self.end + index
        return self.start + index

    def __len__(self):
        return self.end - self.start

    def __contains__(self, item):
        if self.start >= item >= self.end:
            return True
        return False

    def __eq__(self, other):
        if self.start == other.start and self.end == other.end:
            return True
        return False

    def as_list(self):
        """ Return interval as list. """
        return list(self)

    @staticmethod
    def merge(intervals):
        """ Merge two intervals into one. """
        out = []
        for i in sorted(intervals, key=lambda i: i.start):
            if out and i.start <= out[-1].end:
                out[-1].end = max(out[-1].end, i.end)
            else:
                out += i,
        return out

    @staticmethod
    def print_intervals(intervals):
        """ Print out the intervals. """
        res = []
        for i in intervals:
            res.append(repr(i))
        print("".join(res))


def merge_intervals(intervals):
    """ Merge intervals in the form of a list. """
    if intervals is None:
        return None
    intervals.sort(key=lambda i: i[0])
    out = [intervals.pop(0)]
    for i in intervals:
        if out[-1][-1] >= i[0]:
            out[-1][-1] = max(out[-1][-1], i[-1])
        else:
            out.append(i)
    return out
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.missing_ranges774
    set output_file "missing_ranges.py"

    set template_content '
def missing_ranges(arr, lo, hi):

    res = []
    start = lo

    for n in arr:

        if n == start:
            start += 1
        elif n > start:
            res.append((start, n-1))
            start = n + 1

    if start <= hi:                 # after done iterating thru array,
        res.append((start, hi))     # append remainder to list

    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.move_zeros775
    set output_file "move_zeros.py"

    set template_content '
def move_zeros(array):
    result = []
    zeros = 0

    for i in array:
            if i == 0 and type(i) != bool:  # not using `not i` to avoid `False`, `[]`, etc.
                zeros += 1
            else:
                result.append(i)
    
    result.extend([0] * zeros)
    return result


print(move_zeros([False, 1, 0, 1, 2, 0, 1, 3, "a"]))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.n_sum776
    set output_file "n_sum.py"

    set template_content '
def n_sum(n, nums, target, **kv):
    def sum_closure_default(a, b):
        return a + b

    def compare_closure_default(num, target):
        if num < target:
            return -1
        elif num > target:
            return 1
        else:
            return 0

    def same_closure_default(a, b):
        return a == b

    def n_sum(n, nums, target):
        if n == 2:  # want answers with only 2 terms? easy!
            results = two_sum(nums, target)
        else:
            results = []
            prev_num = None
            for index, num in enumerate(nums):
                if prev_num is not None and same_closure(prev_num, num):
                    continue

                prev_num = num
                n_minus1_results = n_sum(  # recursive call
                    n - 1, nums[index + 1 :], target - num  # a  # b  # c
                )  # x = n_sum( a, b, c )  # n_minus1_results = x

                n_minus1_results = append_elem_to_each_list(num, n_minus1_results)
                results += n_minus1_results
        return union(results)

    def two_sum(nums, target):
        nums.sort()
        lt = 0
        rt = len(nums) - 1
        results = []
        while lt < rt:
            sum_ = sum_closure(nums[lt], nums[rt])
            flag = compare_closure(sum_, target)
            if flag == -1:
                lt += 1
            elif flag == 1:
                rt -= 1
            else:
                results.append(sorted([nums[lt], nums[rt]]))
                lt += 1
                rt -= 1
                while lt < len(nums) and same_closure(nums[lt - 1], nums[lt]):
                    lt += 1
                while 0 <= rt and same_closure(nums[rt], nums[rt + 1]):
                    rt -= 1
        return results

    def append_elem_to_each_list(elem, container):
        results = []
        for elems in container:
            elems.append(elem)
            results.append(sorted(elems))
        return results

    def union(duplicate_results):
        results = []

        if len(duplicate_results) != 0:
            duplicate_results.sort()
            results.append(duplicate_results[0])
            for result in duplicate_results[1:]:
                if results[-1] != result:
                    results.append(result)

        return results

    sum_closure = kv.get("sum_closure", sum_closure_default)
    same_closure = kv.get("same_closure", same_closure_default)
    compare_closure = kv.get("compare_closure", compare_closure_default)
    nums.sort()
    return n_sum(n, nums, target)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.plus_one777
    set output_file "plus_one.py"

    set template_content '
def plus_one_v1(digits):
    digits[-1] = digits[-1] + 1
    res = []
    ten = 0
    i = len(digits)-1
    while i >= 0 or ten == 1:
        summ = 0
        if i >= 0:
            summ += digits[i]
        if ten:
            summ += 1
        res.append(summ % 10)
        ten = summ // 10
        i -= 1
    return res[::-1]


def plus_one_v2(digits):
    n = len(digits)
    for i in range(n-1, -1, -1):
        if digits[i] < 9:
            digits[i] += 1
            return digits
        digits[i] = 0
    digits.insert(0, 1)
    return digits


def plus_one_v3(num_arr):

    for idx in reversed(list(enumerate(num_arr))):
        num_arr[idx[0]] = (num_arr[idx[0]] + 1) % 10
        if num_arr[idx[0]]:
            return num_arr
    return [1] + num_arr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.remove_duplicates778
    set output_file "remove_duplicates.py"

    set template_content '
from collections.abc import Hashable


def remove_duplicates(array):
    seen = set()
    new_array = []

    for item in array:
        if isinstance(item, Hashable):
            if item not in seen:
                seen.add(item)
                new_array.append(item)
        else:
            if item not in new_array:
                new_array.append(item)

    return new_array
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.rotate779
    set output_file "rotate.py"

    set template_content '
def rotate_v1(array, k):
    array = array[:]
    n = len(array)
    for i in range(k):  # unused variable is not a problem
        temp = array[n - 1]
        for j in range(n - 1, 0, -1):
            array[j] = array[j - 1]
        array[0] = temp
    return array


def rotate_v2(array, k):
    array = array[:]

    def reverse(arr, a, b):
        while a < b:
            arr[a], arr[b] = arr[b], arr[a]
            a += 1
            b -= 1

    n = len(array)
    k = k % n
    reverse(array, 0, n - k - 1)
    reverse(array, n - k, n - 1)
    reverse(array, 0, n - 1)
    return array


def rotate_v3(array, k):
    if array is None:
        return None
    length = len(array)
    k = k % length
    return array[length - k :] + array[: length - k]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.summarize_ranges780
    set output_file "summarize_ranges.py"

    set template_content '
from typing import List, Tuple


def summarize_ranges(array: List[int]) -> List[Tuple[int, ...]]:
    res = []
    if len(array) == 0:
        return []
    if len(array) == 1:
        return [(array[0], array[0])]
    it = iter(array)
    start = end = next(it)
    for num in it:
        if num - end == 1:
            end = num
        else:
            res.append((start, end))
            start = end = num
    res.append((start, end))
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.three_sum781
    set output_file "three_sum.py"

    set template_content '
def three_sum(array):
    res = set()
    array.sort()
    for i in range(len(array) - 2):
        if i > 0 and array[i] == array[i - 1]:
            continue
        l, r = i + 1, len(array) - 1
        while l < r:
            s = array[i] + array[l] + array[r]
            if s > 0:
                r -= 1
            elif s < 0:
                l += 1
            else:
                # found three sum
                res.add((array[i], array[l], array[r]))

                # remove duplicates
                while l < r and array[l] == array[l + 1]:
                    l += 1

                while l < r and array[r] == array[r - 1]:
                    r -= 1

                l += 1
                r -= 1
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.top782
    set output_file "top_1.py"

    set template_content '
def top_1(arr):
    values = {}
    #reserve each value which first appears on keys
    #reserve how many time each value appears by index number on values
    result = []
    f_val = 0

    for i in arr:
        if i in values:
            values[i] += 1
        else:
            values[i] = 1

    f_val = max(values.values())
        
    for i in values.keys():
        if values[i] == f_val:
            result.append(i)
        else:
            continue
    
    return result

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.trimmean783
    set output_file "trimmean.py"

    set template_content '
def trimmean(arr, per):
    ratio = per/200
    # /100 for easy calculation by *, and /2 for easy adaption to best and worst parts.
    cal_sum = 0
    # sum value to be calculated to trimmean.
    arr.sort()
    neg_val = int(len(arr)*ratio)
    arr = arr[neg_val:len(arr)-neg_val]
    for i in arr:
        cal_sum += i
    return cal_sum/len(arr)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.two_sum784
    set output_file "two_sum.py"

    set template_content '
def two_sum(array, target):
    dic = {}
    for i, num in enumerate(array):
        if num in dic:
            return dic[num], i
        else:
            dic[target - num] = i
    return None
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.DFA785
    set output_file "SortListByFrequency.py"

    set template_content '
def DFA(transitions, start, final, string):

    num = len(string)
    num_final = len(final)
    cur = start

    for i in range(num):

        if transitions[cur][string[i]] is None:
            return False
        else:
            cur = transitions[cur][string[i]]

    for i in range(num_final):
        if cur == final[i]:
            return True
    return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.add_operators786
    set output_file "add_operators.py"

    set template_content '
def add_operators(num, target):


    def dfs(res, path, num, target, pos, prev, multed):
        if pos == len(num):
            if target == prev:
                res.append(path)
            return
        for i in range(pos, len(num)):
            if i != pos and num[pos] == '0':  # all digits have to be used
                break
            cur = int(num[pos:i+1])
            if pos == 0:
                dfs(res, path + str(cur), num, target, i+1, cur, cur)
            else:
                dfs(res, path + "+" + str(cur), num, target,
                    i+1, prev + cur, cur)
                dfs(res, path + "-" + str(cur), num, target,
                    i+1, prev - cur, -cur)
                dfs(res, path + "*" + str(cur), num, target,
                    i+1, prev - multed + multed * cur, multed * cur)

    res = []
    if not num:
        return res
    dfs(res, "", num, target, 0, 0, 0)
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.anagram787
    set output_file "anagram.py"

    set template_content '
def anagram(s1, s2):
    c1 = [0] * 26
    c2 = [0] * 26

    for c in s1:
        pos = ord(c)-ord('a')
        c1[pos] = c1[pos] + 1

    for c in s2:
        pos = ord(c)-ord('a')
        c2[pos] = c2[pos] + 1

    return c1 == c2
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.array_sum_combinations788
    set output_file "array_sum_combinations.py"

    set template_content '
import itertools
from functools import partial


def array_sum_combinations(A, B, C, target):

    def over(constructed_sofar):
        sum = 0
        to_stop, reached_target = False, False
        for elem in constructed_sofar:
            sum += elem
        if sum >= target or len(constructed_sofar) >= 3:
            to_stop = True
            if sum == target and 3 == len(constructed_sofar):
                reached_target = True
        return to_stop, reached_target

    def construct_candidates(constructed_sofar):
        array = A
        if 1 == len(constructed_sofar):
            array = B
        elif 2 == len(constructed_sofar):
            array = C
        return array

    def backtrack(constructed_sofar=[], res=[]):
        to_stop, reached_target = over(constructed_sofar)
        if to_stop:
            if reached_target:
                res.append(constructed_sofar)
            return
        candidates = construct_candidates(constructed_sofar)

        for candidate in candidates:
            constructed_sofar.append(candidate)
            backtrack(constructed_sofar[:], res)
            constructed_sofar.pop()

    res = []
    backtrack([], res)
    return res


def unique_array_sum_combinations(A, B, C, target):
    def check_sum(n, *nums):
        if sum(x for x in nums) == n:
            return (True, nums)
        else:
            return (False, nums)

    pro = itertools.product(A, B, C)
    func = partial(check_sum, target)
    sums = list(itertools.starmap(func, pro))

    res = set()
    for s in sums:
        if s[0] is True and s[1] not in res:
            res.add(s[1])

    return list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.combination_sum789
    set output_file "combination_sum.py"

    set template_content '
def combination_sum(candidates, target):

    def dfs(nums, target, index, path, res):
        if target < 0:
            return  # backtracking
        if target == 0:
            res.append(path)
            return
        for i in range(index, len(nums)):
            dfs(nums, target-nums[i], i, path+[nums[i]], res)

    res = []
    candidates.sort()
    dfs(candidates, target, 0, [], res)
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.get_factors790
    set output_file "get_factors.py"

    set template_content '
def get_factors(n):
    todo, combis = [(n, 2, [])], []
    while todo:
        n, i, combi = todo.pop()
        while i * i <= n:
            if n % i == 0:
                combis.append(combi + [i, n//i])
                todo.append((n//i, i, combi+[i]))
            i += 1
    return combis


# Recursive:
def recursive_get_factors(n):

    def factor(n, i, combi, combis):
        while i * i <= n:
            if n % i == 0:
                combis.append(combi + [i, n//i]),
                factor(n//i, i, combi+[i], combis)
            i += 1
        return combis

    return factor(n, 2, [], [])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.find_words791
    set output_file "find_words.py"

    set template_content '
def find_words(board, words):

    def backtrack(board, i, j, trie, pre, used, result):

        if "#" in trie:
            result.add(pre)

        if i < 0 or i >= len(board) or j < 0 or j >= len(board[0]):
            return

        if not used[i][j] and board[i][j] in trie:
            used[i][j] = True
            backtrack(
                board, i + 1, j, trie[board[i][j]], pre + board[i][j], used, result
            )
            backtrack(
                board, i, j + 1, trie[board[i][j]], pre + board[i][j], used, result
            )
            backtrack(
                board, i - 1, j, trie[board[i][j]], pre + board[i][j], used, result
            )
            backtrack(
                board, i, j - 1, trie[board[i][j]], pre + board[i][j], used, result
            )
            used[i][j] = False

    # make a trie structure that is essentially dictionaries of dictionaries
    # that map each character to a potential next character
    trie = {}
    for word in words:
        curr_trie = trie
        for char in word:
            if char not in curr_trie:
                curr_trie[char] = {}
            curr_trie = curr_trie[char]
        curr_trie["#"] = "#"

    # result is a set of found words since we do not want repeats
    result = set()
    used = [[False] * len(board[0]) for _ in range(len(board))]

    for i in range(len(board)):
        for j in range(len(board[0])):
            backtrack(board, i, j, trie, "", used, result)
    return list(result)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.generate_abbreviations792
    set output_file "SortListByFrequency.py"

    set template_content '
def generate_abbreviations(word):

    def backtrack(result, word, pos, count, cur):
        if pos == len(word):
            if count > 0:
                cur += str(count)
            result.append(cur)
            return

        if count > 0:  # add the current word
            backtrack(result, word, pos+1, 0, cur+str(count)+word[pos])
        else:
            backtrack(result, word, pos+1, 0, cur+word[pos])
        # skip the current word
        backtrack(result, word, pos+1, count+1, cur)

    result = []
    backtrack(result, word, 0, 0, "")
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.generate_parenthesis793
    set output_file "generate_parenthesis.py"

    set template_content '
def generate_parenthesis_v1(n):
    def add_pair(res, s, left, right):
        if left == 0 and right == 0:
            res.append(s)
            return
        if right > 0:
            add_pair(res, s + ")", left, right - 1)
        if left > 0:
            add_pair(res, s + "(", left - 1, right + 1)

    res = []
    add_pair(res, "", n, 0)
    return res


def generate_parenthesis_v2(n):
    def add_pair(res, s, left, right):
        if left == 0 and right == 0:
            res.append(s)
        if left > 0:
            add_pair(res, s + "(", left - 1, right)
        if right > 0 and left < right:
            add_pair(res, s + ")", left, right - 1)

    res = []
    add_pair(res, "", n, n)
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.letter_combinations794
    set output_file "letter_combinations.py"

    set template_content '
def letter_combinations(digits):
    if digits == "":
        return []
    kmaps = {
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz"
    }
    ans = [""]
    for num in digits:
        tmp = []
        for an in ans:
            for char in kmaps[num]:
                tmp.append(an + char)
        ans = tmp
    return ans
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.palindromic_substrings795
    set output_file "palindromic_substrings.py"

    set template_content '
def palindromic_substrings(s):
    if not s:
        return [[]]
    results = []
    for i in range(len(s), 0, -1):
        sub = s[:i]
        if sub == sub[::-1]:
            for rest in palindromic_substrings(s[i:]):
                results.append([sub] + rest)
    return results


def palindromic_substrings_iter(s):
    if not s:
        yield []
        return
    for i in range(len(s), 0, -1):
        sub = s[:i]
        if sub == sub[::-1]:
            for rest in palindromic_substrings_iter(s[i:]):
                yield [sub] + rest
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.pattern_match796
    set output_file "pattern_match.py"

    set template_content '
def pattern_match(pattern, string):
    def backtrack(pattern, string, dic):

        if len(pattern) == 0 and len(string) > 0:
            return False

        if len(pattern) == len(string) == 0:
            return True

        for end in range(1, len(string) - len(pattern) + 2):
            if pattern[0] not in dic and string[:end] not in dic.values():
                dic[pattern[0]] = string[:end]
                if backtrack(pattern[1:], string[end:], dic):
                    return True
                del dic[pattern[0]]
            elif pattern[0] in dic and dic[pattern[0]] == string[:end]:
                if backtrack(pattern[1:], string[end:], dic):
                    return True
        return False

    return backtrack(pattern, string, {})
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.permute797
    set output_file "permute.py"

    set template_content '
def permute(elements):
    if len(elements) <= 1:
        return [elements]
    else:
        tmp = []
        for perm in permute(elements[1:]):
            for i in range(len(elements)):
                tmp.append(perm[:i] + elements[0:1] + perm[i:])
        return tmp


def permute_iter(elements):
    if len(elements) <= 1:
        yield elements
    else:
        for perm in permute_iter(elements[1:]):
            for i in range(len(elements)):
                yield perm[:i] + elements[0:1] + perm[i:]


# DFS Version
def permute_recursive(nums):
    def dfs(res, nums, path):
        if not nums:
            res.append(path)
        for i in range(len(nums)):
            print(nums[:i] + nums[i + 1 :])
            dfs(res, nums[:i] + nums[i + 1 :], path + [nums[i]])

    res = []
    dfs(res, nums, [])
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.permute_unique798
    set output_file "permute_unique.py"

    set template_content '

def permute_unique(nums):
    perms = [[]]
    for n in nums:
        new_perms = []
        for l in perms:
            for i in range(len(l)+1):
                new_perms.append(l[:i]+[n]+l[i:])
                if i < len(l) and l[i] == n:
                    break  # handles duplication
        perms = new_perms
    return perms
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.subsets799
    set output_file "subsets.py"

    set template_content '
def subsets(nums):

    def backtrack(res, nums, stack, pos):
        if pos == len(nums):
            res.append(list(stack))
        else:
            # take nums[pos]
            stack.append(nums[pos])
            backtrack(res, nums, stack, pos + 1)
            stack.pop()
            # dont take nums[pos]
            backtrack(res, nums, stack, pos + 1)

    res = []
    backtrack(res, nums, [], 0)
    return res


# """
# simplified backtrack

# def backtrack(res, nums, cur, pos):
#     if pos >= len(nums):
#         res.append(cur)
#     else:
#         backtrack(res, nums, cur+[nums[pos]], pos+1)
#         backtrack(res, nums, cur, pos+1)
# """


# Iteratively
def subsets_v2(nums):
    res = [[]]
    for num in sorted(nums):
        res += [item + [num] for item in res]
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.subsets_unique800
    set output_file "subsets_unique.py"

    set template_content '
def subsets_unique(nums):

    def backtrack(res, nums, stack, pos):
        if pos == len(nums):
            res.add(tuple(stack))
        else:
            # take
            stack.append(nums[pos])
            backtrack(res, nums, stack, pos+1)
            stack.pop()

            # dont take
            backtrack(res, nums, stack, pos+1)

    res = set()
    backtrack(res, nums, [], 0)
    return list(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveAdjacentDuplicatesQueue801
    set output_file "subsets_unique.py"

    set template_content '
class Queue(object):
    def __init__(self):
        self.S1 = []
        self.S2 = []
     
    def enqueue(self, data):
        self.S1.append(data)
    
    def dequeue(self):
        if not self.S2:
            while self.S1:
                self.S2.append(self.S1.pop())
        return self.S2.pop() 
	    
q = Queue()
for i in xrange(5):
    q.enqueue(i)
for i in xrange(5):
    print q.dequeue()  
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.distance802
    set output_file "distance.py"

    set template_content '
import math

def distance(x,y):
    assert len(x) == len(y), "The vector must have same length"
    result = ()
    sum = 0
    for i in range(len(x)):
        result += (x[i] -y[i],)
    for component in result:
        sum += component**2
    return math.sqrt(sum)


def nearest_neighbor(x, tSet):
    assert isinstance(x, tuple) and isinstance(tSet, dict)
    current_key = ()
    min_d = float('inf')
    for key in tSet:
        d = distance(x, key)
        if d < min_d:
            min_d = d
            current_key = key
    return tSet[current_key]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.count_islands803
    set output_file "count_islands.py"

    set template_content '
def count_islands(grid):
    row = len(grid)
    col = len(grid[0])

    num_islands = 0
    visited = [[0] * col for i in range(row)]
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    queue = []

    for i in range(row):
        for j, num in enumerate(grid[i]):
            if num == 1 and visited[i][j] != 1:
                visited[i][j] = 1
                queue.append((i, j))
                while queue:
                    x, y = queue.pop(0)
                    for k in range(len(directions)):
                        nx_x = x + directions[k][0]
                        nx_y = y + directions[k][1]
                        if nx_x >= 0 and nx_y >= 0 and nx_x < row and nx_y < col:
                            if visited[nx_x][nx_y] != 1 and grid[nx_x][nx_y] == 1:
                                queue.append((nx_x, nx_y))
                                visited[nx_x][nx_y] = 1
                num_islands += 1

    return num_islands
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.maze_search804
    set output_file "maze_search.py"

    set template_content '
def maze_search(maze):
    BLOCKED, ALLOWED = 0, 1
    UNVISITED, VISITED = 0, 1

    initial_x, initial_y = 0, 0

    if maze[initial_x][initial_y] == BLOCKED:
        return -1
    
    directions = [(0, -1), (0, 1), (-1, 0), (1, 0)]

    height, width = len(maze), len(maze[0])

    target_x, target_y = height - 1, width - 1

    queue = deque([(initial_x, initial_y, 0)])

    is_visited = [[UNVISITED for w in range(width)] for h in range(height)]
    is_visited[initial_x][initial_y] = VISITED

    while queue:
        x, y, steps = queue.popleft()

        if x == target_x and y == target_y:
            return steps

        for dx, dy in directions:
            new_x = x + dx
            new_y = y + dy

            if not (0 <= new_x < height and 0 <= new_y < width):
                continue

            if maze[new_x][new_y] == ALLOWED and is_visited[new_x][new_y] == UNVISITED:
                queue.append((new_x, new_y, steps + 1))
                is_visited[new_x][new_y] = VISITED

    return -1 

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.shortest_distance805
    set output_file "shortest_distance.py"

    set template_content '
def shortest_distance(grid):
    if not grid or not grid[0]:
        return -1

    matrix = [[[0,0] for i in range(len(grid[0]))] for j in range(len(grid))]

    count = 0    # count how many building we have visited
    for i in range(len(grid)):
        for j in range(len(grid[0])):
            if grid[i][j] == 1:
                bfs(grid, matrix, i, j, count)
                count += 1

    res = float('inf')
    for i in range(len(matrix)):
        for j in range(len(matrix[0])):
            if matrix[i][j][1]==count:
                res = min(res, matrix[i][j][0])

    return res if res!=float('inf') else -1

def bfs(grid, matrix, i, j, count):
    q = [(i, j, 0)]
    while q:
        i, j, step = q.pop(0)
        for k, l in [(i-1,j), (i+1,j), (i,j-1), (i,j+1)]:
            # only the position be visited by count times will append to queue
            if 0<=k<len(grid) and 0<=l<len(grid[0]) and \
                    matrix[k][l][1]==count and grid[k][l]==0:
                matrix[k][l][0] += step+1
                matrix[k][l][1] = count+1
                q.append((k, l, step+1))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.ladderLength806
    set output_file "ladder_length.py"

    set template_content '
def ladder_length(begin_word, end_word, word_list):
    if len(begin_word) != len(end_word):
        return -1  # not possible

    if begin_word == end_word:
        return 0

    # when only differ by 1 character
    if sum(c1 != c2 for c1, c2 in zip(begin_word, end_word)) == 1:
        return 1

    begin_set = set()
    end_set = set()
    begin_set.add(begin_word)
    end_set.add(end_word)
    result = 2
    while begin_set and end_set:

        if len(begin_set) > len(end_set):
            begin_set, end_set = end_set, begin_set

        next_begin_set = set()
        for word in begin_set:
            for ladder_word in word_range(word):
                if ladder_word in end_set:
                    return result
                if ladder_word in word_list:
                    next_begin_set.add(ladder_word)
                    word_list.remove(ladder_word)
        begin_set = next_begin_set
        result += 1
        # print(begin_set)
        # print(result)
    return -1


def word_range(word):
    for ind in range(len(word)):
        temp = word[ind]
        for c in [chr(x) for x in range(ord("a"), ord("z") + 1)]:
            if c != temp:
                yield word[:ind] + c + word[ind + 1 :]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.elias807
    set output_file "elias.py"

    set template_content '
from math import log

log2 = lambda x: log(x, 2)


# Calculates the binary number
def binary(x, l=1):
    fmt = "{0:0%db}" % l
    return fmt.format(x)


# Calculates the unary number
def unary(x):
    return (x - 1) * "1" + "0"


def elias_generic(lencoding, x):
    if x == 0:
        return "0"

    first_part = 1 + int(log2(x))

    a = x - 2 ** (int(log2(x)))

    k = int(log2(x))

    return lencoding(first_part) + binary(a, k)


def elias_gamma(x):
    return elias_generic(unary, x)


def elias_delta(x):
    return elias_generic(elias_gamma, x)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end





function algoP.huffman_coding808
    set output_file "SortListByFrequency.py"

    set template_content '
from collections import defaultdict, deque
import heapq


class Node:
    def __init__(self, frequency=0, sign=None, left=None, right=None):
        self.frequency = frequency
        self.sign = sign
        self.left = left
        self.right = right

    def __lt__(self, other):
        return self.frequency < other.frequency

    def __gt__(self, other):
        return self.frequency > other.frequency

    def __eq__(self, other):
        return self.frequency == other.frequency

    def __str__(self):
        return "<ch: {0}: {1}>".format(self.sign, self.frequency)

    def __repr__(self):
        return "<ch: {0}: {1}>".format(self.sign, self.frequency)


class HuffmanReader:
    def __init__(self, file):
        self.file = file
        self.buffer = []
        self.is_last_byte = False

    def get_number_of_additional_bits_in_the_last_byte(self) -> int:
        bin_num = self.get_bit() + self.get_bit() + self.get_bit()
        return int(bin_num, 2)

    def load_tree(self) -> Node:
        node_stack = deque()
        queue_leaves = deque()
        root = Node()

        current_node = root
        is_end_of_tree = False
        while not is_end_of_tree:
            current_bit = self.get_bit()
            if current_bit == "0":
                current_node.left = Node()
                current_node.right = Node()
                node_stack.append(current_node.right)  # going to left node, right push on stack
                current_node = current_node.left
            else:
                queue_leaves.append(current_node)
                if node_stack:
                    current_node = node_stack.pop()
                else:
                    is_end_of_tree = True

        self._fill_tree(queue_leaves)

        return root

    def _fill_tree(self, leaves_queue):
        leaves_queue.reverse()
        while leaves_queue:
            node = leaves_queue.pop()
            s = int(self.get_byte(), 2)
            node.sign = s

    def _load_byte(self, buff_limit=8) -> bool:
        """
        Load next byte is buffer is less than buff_limit
        :param buff_limit:
        :return: True if there is enough bits in buffer to read
        """
        if len(self.buffer) <= buff_limit:
            byte = self.file.read(1)

            if not byte:
                return False

            i = int.from_bytes(byte, "big")
            self.buffer.extend(list("{0:08b}".format(i)))

        return True

    def get_bit(self, buff_limit=8):
        if self._load_byte(buff_limit):
            bit = self.buffer.pop(0)
            return bit
        else:
            return -1

    def get_byte(self):
        if self._load_byte():
            byte_list = self.buffer[:8]
            self.buffer = self.buffer[8:]

            return "".join(byte_list)
        else:
            return -1


class HuffmanWriter:
    def __init__(self, file):
        self.file = file
        self.buffer = ""
        self.saved_bits = 0

    def write_char(self, char):
        self.write_int(ord(char))

    def write_int(self, num):
        bin_int = "{0:08b}".format(num)
        self.write_bits(bin_int)

    def write_bits(self, bits):
        self.saved_bits += len(bits)

        self.buffer += bits

        while len(self.buffer) >= 8:
            i = int(self.buffer[:8], 2)
            self.file.write(bytes([i]))
            self.buffer = self.buffer[8:]

    def save_tree(self, tree):
        signs = []
        tree_code = ""

        def get_code_tree(T):
            nonlocal tree_code
            if T.sign is not None:
                signs.append(T.sign)
            if T.left:
                tree_code += "0"
                get_code_tree(T.left)
            if T.right:
                tree_code += "1"
                get_code_tree(T.right)

        get_code_tree(tree)
        self.write_bits(tree_code + "1")  # "1" indicates that tree ended (it will be needed to load the tree)
        for int_sign in signs:
            self.write_int(int_sign)

    def _save_information_about_additional_bits(self, additional_bits: int):
        self.file.seek(0)
        first_byte_raw = self.file.read(1)
        self.file.seek(0)
        first_byte = "{0:08b}".format(int.from_bytes(first_byte_raw, "big"))
        # overwrite first three bits
        first_byte = first_byte[3:]
        first_byte = "{0:03b}".format(additional_bits) + first_byte

        self.write_bits(first_byte)

    def close(self):
        additional_bits = 8 - len(self.buffer)
        if additional_bits != 8:  # buffer is empty, no need to append extra "0"
            self.write_bits("0" * additional_bits)
            self._save_information_about_additional_bits(additional_bits)


class TreeFinder:

    def __init__(self, tree):
        self.root = tree
        self.current_node = tree
        self.found = None

    def find(self, bit):
        if bit == "0":
            self.current_node = self.current_node.left
        elif bit == "1":
            self.current_node = self.current_node.right
        else:
            self._reset()
            return True

        if self.current_node.sign is not None:
            self._reset(self.current_node.sign)
            return True
        else:
            return False

    def _reset(self, found=""):
        self.found = found
        self.current_node = self.root


class HuffmanCoding:
    def __init__(self):
        pass

    @staticmethod
    def decode_file(file_in_name, file_out_name):
        with open(file_in_name, "rb") as file_in, open(file_out_name, "wb") as file_out:
            reader = HuffmanReader(file_in)
            additional_bits = reader.get_number_of_additional_bits_in_the_last_byte()
            tree = reader.load_tree()

            HuffmanCoding._decode_and_write_signs_to_file(file_out, reader, tree, additional_bits)

        print("File decoded.")

    @staticmethod
    def _decode_and_write_signs_to_file(file, reader: HuffmanReader, tree: Node, additional_bits: int):
        tree_finder = TreeFinder(tree)
        is_end_of_file = False

        while not is_end_of_file:
            bit = reader.get_bit()
            if bit != -1:
                while not tree_finder.find(bit):  # read whole code
                    bit = reader.get_bit(0)
                file.write(bytes([tree_finder.found]))
            else:  # There is last byte in buffer to parse
                is_end_of_file = True
                last_byte = reader.buffer
                last_byte = last_byte[:-additional_bits]  # remove additional "0" used to fill byte
                for bit in last_byte:
                    if tree_finder.find(bit):
                        file.write(bytes([tree_finder.found]))

    @staticmethod
    def encode_file(file_in_name, file_out_name):
        with open(file_in_name, "rb") as file_in, open(file_out_name, mode="wb+") as file_out:
            signs_frequency = HuffmanCoding._get_char_frequency(file_in)
            file_in.seek(0)
            tree = HuffmanCoding._create_tree(signs_frequency)
            codes = HuffmanCoding._generate_codes(tree)

            writer = HuffmanWriter(file_out)
            writer.write_bits("000")  # leave space to save how many bits will be appended to fill the last byte
            writer.save_tree(tree)
            HuffmanCoding._encode_and_write_signs_to_file(file_in, writer, codes)
            writer.close()

        print("File encoded.")

    @staticmethod
    def _encode_and_write_signs_to_file(file, writer: HuffmanWriter, codes: dict):
        sign = file.read(1)
        while sign:
            int_char = int.from_bytes(sign, "big")
            writer.write_bits(codes[int_char])
            sign = file.read(1)

    @staticmethod
    def _get_char_frequency(file) -> dict:
        is_end_of_file = False
        signs_frequency = defaultdict(lambda: 0)
        while not is_end_of_file:
            prev_pos = file.tell()
            sign = file.read(1)
            curr_pos = file.tell()
            if prev_pos == curr_pos:
                is_end_of_file = True
            else:
                signs_frequency[int.from_bytes(sign, "big")] += 1

        return signs_frequency

    @staticmethod
    def _generate_codes(tree: Node) -> dict:
        codes = dict()
        HuffmanCoding._go_through_tree_and_create_codes(tree, "", codes)
        return codes

    @staticmethod
    def _create_tree(signs_frequency: dict) -> Node:
        nodes = [Node(frequency=frequency, sign=char_int) for char_int, frequency in signs_frequency.items()]
        heapq.heapify(nodes)

        while len(nodes) > 1:
            left = heapq.heappop(nodes)
            right = heapq.heappop(nodes)
            new_node = Node(frequency=left.frequency + right.frequency, left=left, right=right)
            heapq.heappush(nodes, new_node)

        return nodes[0]  # root

    @staticmethod
    def _go_through_tree_and_create_codes(tree: Node, code: str, dict_codes: dict):
        if tree.sign is not None:
            dict_codes[tree.sign] = code

        if tree.left:
            HuffmanCoding._go_through_tree_and_create_codes(tree.left, code + "0", dict_codes)

        if tree.right:
            HuffmanCoding._go_through_tree_and_create_codes(tree.right, code + "1", dict_codes)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.subsets_unique809
    set output_file "subsets_unique.py"

    set template_content '
def encode_rle(input):
    if not input:
        return ""

    encoded_str = ""
    prev_ch = ""
    count = 1

    for ch in input:

        # Check If the subsequent character does not match
        if ch != prev_ch:
            # Add the count and character
            if prev_ch:
                encoded_str += str(count) + prev_ch
            # Reset the count and set the character
            count = 1
            prev_ch = ch
        else:
            # Otherwise increment the counter
            count += 1
    else:
        return encoded_str + (str(count) + prev_ch)


def decode_rle(input):
    decode_str = ""
    count = ""

    for ch in input:
        # If not numerical
        if not ch.isdigit():
            # Expand it for the decoding
            decode_str += ch * int(count)
            count = ""
        else:
            # Add it in the counter
            count += ch
    return decode_str
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.rle_compression810
    set output_file "rle_compression.py"

    set template_content '
def encode_rle(input):
    if not input:
        return ""

    encoded_str = ""
    prev_ch = ""
    count = 1

    for ch in input:

        # Check If the subsequent character does not match
        if ch != prev_ch:
            # Add the count and character
            if prev_ch:
                encoded_str += str(count) + prev_ch
            # Reset the count and set the character
            count = 1
            prev_ch = ch
        else:
            # Otherwise increment the counter
            count += 1
    else:
        return encoded_str + (str(count) + prev_ch)


def decode_rle(input):
    decode_str = ""
    count = ""

    for ch in input:
        # If not numerical
        if not ch.isdigit():
            # Expand it for the decoding
            decode_str += ch * int(count)
            count = ""
        else:
            # Add it in the counter
            count += ch
    return decode_str
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.base_conversion811
    set output_file "base_conversion.py"

    set template_content '
def int_to_base(num, base):
    is_negative = False
    if num == 0:
        return "0"
    if num < 0:
        is_negative = True
        num *= -1
    digit = string.digits + string.ascii_uppercase
    res = ""
    while num > 0:
        res += digit[num % base]
        num //= base
    if is_negative:
        return "-" + res[::-1]
    return res[::-1]


def base_to_int(str_to_convert, base):

    digit = {}
    for ind, char in enumerate(string.digits + string.ascii_uppercase):
        digit[char] = ind
    multiplier = 1
    res = 0
    for char in str_to_convert[::-1]:
        res += digit[char] * multiplier
        multiplier *= base
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.solve_chinese_remainder812
    set output_file "solve_chinese_remainder.py"

    set template_content '
def solve_chinese_remainder(nums : List[int], rems : List[int]):
    if not len(nums) == len(rems):
        raise Exception("nums and rems should have equal length")
    if not len(nums) > 0:
        raise Exception("Lists nums and rems need to contain at least one element")
    for num in nums:
        if not num > 1:
            raise Exception("All numbers in nums needs to be > 1")
    if not _check_coprime(nums):
        raise Exception("All pairs of numbers in nums are not coprime")
    k = len(nums)
    x = 1
    while True:
        i = 0
        while i < k:
            if x % nums[i] != rems[i]:
                break
            i += 1
        if i == k:
            return x
        x += 1

def _check_coprime(list_to_check : List[int]):
    for ind, num in enumerate(list_to_check):
        for num2 in list_to_check[ind + 1:]:
            if gcd(num, num2) != 1:
                return False
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.combination813
    set output_file "combination.py"

    set template_content '
def combination(n, r):
    if n == r or r == 0:
        return 1
    return combination(n-1, r-1) + combination(n-1, r)

def combination_memo(n, r):
    memo = {}
    def recur(n, r):
        if n == r or r == 0:
            return 1
        if (n, r) not in memo:
            memo[(n, r)] = recur(n - 1, r - 1) + recur(n - 1, r)
        return memo[(n, r)]
    return recur(n, r)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.cosine_similarity814
    set output_file "cosine_similarity.py"

    set template_content '
import math


def _l2_distance(vec):
    norm = 0.
    for element in vec:
        norm += element * element
    norm = math.sqrt(norm)
    return norm


def cosine_similarity(vec1, vec2):
    if len(vec1) != len(vec2):
        raise ValueError("The two vectors must be the same length. Got shape " + str(len(vec1))
                        + " and " + str(len(vec2)))

    norm_a = _l2_distance(vec1)
    norm_b = _l2_distance(vec2)

    similarity = 0.

    # Calculate the dot product of two vectors
    for vec1_element, vec2_element in zip(vec1, vec2):
        similarity += vec1_element * vec2_element

    similarity /= (norm_a * norm_b)

    return similarity
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.decimal_to_binary815
    set output_file "decimal_to_binary.py"

    set template_content '
def decimal_to_binary_util(val):
    bits = [128, 64, 32, 16, 8, 4, 2, 1]
    val = int(val)
    binary_rep = ''
    for bit in bits:
        if val >= bit:
            binary_rep += str(1)
            val -= bit
        else:
            binary_rep += str(0)

    return binary_rep

def decimal_to_binary_ip(ip):
    values = ip.split('.')
    binary_list = []
    for val in values:
        binary_list.append(decimal_to_binary_util(val))
    return '.'.join(binary_list)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.is_strobogrammatic816
    set output_file "is_strobogrammatic.py"

    set template_content '
def is_strobogrammatic(num):
    comb = "00 11 88 69 96"
    i = 0
    j = len(num) - 1
    while i <= j:
        if comb.find(num[i]+num[j]) == -1:
            return False
        i += 1
        j -= 1
    return True


def is_strobogrammatic2(num: str):
    """Another implementation."""
    return num == num[::-1].replace('6', '#').replace('9', '6').replace('#', '9')
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.krishnamurthy_number817
    set output_file "krishnamurthy_number.py"

    set template_content '
def find_factorial(n):
    """ Calculates the factorial of a given number n """
    fact = 1
    while n != 0:
        fact *= n
        n -= 1
    return fact


def krishnamurthy_number(n):
    if n == 0:
        return False
    sum_of_digits = 0   # will hold sum of FACTORIAL of digits
    temp = n

    while temp != 0:

        # get the factorial of of the last digit of n and add it to sum_of_digits
        sum_of_digits += find_factorial(temp % 10)

        # replace value of temp by temp/10
        # i.e. will remove the last digit from temp
        temp //= 10

    # returns True if number is krishnamurthy
    return sum_of_digits == n
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.magic_number818
    set output_file "magic_number.py"

    set template_content '
def magic_number(n):
    """ Checks if n is a magic number """
    total_sum = 0

    while n > 0 or total_sum > 9:
        # when n becomes 0 but we have a total_sum,
        # we update the value of n with the value of the sum digits
        if n == 0:
            n = total_sum  # only when sum of digits isnt single digit
            total_sum = 0
        total_sum += n % 10
        n //= 10
    return total_sum == 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.modular_exponential819
    set output_file "modular_exponential.py"

    set template_content '
ef modular_exponential(base, exponent, mod):
    """Computes (base ^ exponent) % mod.
    Time complexity - O(log n)
    Use similar to Python in-built function pow."""
    if exponent < 0:
        raise ValueError("Exponent must be positive.")
    base %= mod
    result = 1

    while exponent > 0:
        # If the last bit is 1, add 2^k.
        if exponent & 1:
            result = (result * base) % mod
        exponent = exponent >> 1
        # Utilize modular multiplication properties to combine the computed mod C values.
        base = (base * base) % mod

    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.modular_inverse820
    set output_file "modular_inverse.py"

    set template_content '
def extended_gcd(a: int, b: int) -> [int, int, int]:
    """Extended GCD algorithm.
    Return s, t, g
    such that a * s + b * t = GCD(a, b)
    and s and t are co-prime.
    """

    old_s, s = 1, 0
    old_t, t = 0, 1
    old_r, r = a, b

    while r != 0:
        quotient = old_r // r

        old_r, r = r, old_r - quotient * r
        old_s, s = s, old_s - quotient * s
        old_t, t = t, old_t - quotient * t

    return old_s, old_t, old_r


def modular_inverse(a: int, m: int) -> int:
    s, _, g = extended_gcd(a, m)
    if g != 1:
        raise ValueError("a and m must be coprime")
    return s % m
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.next_bigger821
    set output_file "next_bigger.py"

    set template_content '
import unittest

def next_bigger(num):

    digits = [int(i) for i in str(num)]
    idx = len(digits) - 1

    while idx >= 1 and digits[idx - 1] >= digits[idx]:
        idx -= 1

    if idx == 0:
        return -1  # no such number exists

    pivot = digits[idx - 1]
    swap_idx = len(digits) - 1

    while pivot >= digits[swap_idx]:
        swap_idx -= 1

    digits[swap_idx], digits[idx - 1] = digits[idx - 1], digits[swap_idx]
    digits[idx:] = digits[
        : idx - 1 : -1
    ]  # prefer slicing instead of reversed(digits[idx:])

    return int("".join(str(x) for x in digits))


class TestSuite(unittest.TestCase):

    def test_next_bigger(self):

        self.assertEqual(next_bigger(38276), 38627)
        self.assertEqual(next_bigger(12345), 12354)
        self.assertEqual(next_bigger(1528452), 1528524)
        self.assertEqual(next_bigger(138654), 143568)

        self.assertEqual(next_bigger(54321), -1)
        self.assertEqual(next_bigger(999), -1)
        self.assertEqual(next_bigger(5), -1)


if __name__ == "__main__":

    unittest.main()
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.find_next_square822
    set output_file "subsets_unique.py"

    set template_content '
def find_next_square(sq):
    root = sq ** 0.5
    if root.is_integer():
        return (root + 1)**2
    return -1

def find_next_square2(sq):
    """ Alternative method, works by evaluating anything non-zero as True (0.000001 --> True) """
    root = sq**0.5
    return -1 if root % 1 else (root+1)**2
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.find_nth_digit823
    set output_file "find_nth_digit.py"

    set template_content '
def find_nth_digit(n):
    length = 1
    count = 9
    start = 1
    while n > length * count:
        n -= length * count
        length += 1
        count *= 10
        start *= 10
    start += (n-1) / length
    s = str(start)
    return int(s[(n-1) % length])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.num_digits824
    set output_file "num_digits.py"

    set template_content '
import math

def num_digits(n):
    n=abs(n)
    if n==0:
        return 1
    return int(math.log10(n))+1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.num_perfect_squares825
    set output_file "num_perfect_squares.py"

    set template_content '
import math

def num_perfect_squares(number):
    if int(math.sqrt(number)) ** 2 == number:
        return 1

    while number > 0 and number % 4 == 0:
        number /= 4

    if number % 8 == 7:
        return 4

    for i in range(1, int(math.sqrt(number)) + 1):
        if int(math.sqrt(number - i**2)) ** 2 == number - i**2:
            return 2

    return 3
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.power827
    set output_file "power.py"

    set template_content '
def power(a: int, n: int, mod: int = None):
    ans = 1
    while n:
        if n & 1:
            ans = ans * a
        a = a * a
        if mod:
            ans %= mod
            a %= mod
        n >>= 1
    return ans


def power_recur(a: int, n: int, mod: int = None):
    if n == 0:
        ans = 1
    elif n == 1:
        ans = a
    else:
        ans = power_recur(a, n // 2, mod)
        ans = ans * ans
        if n % 2:
            ans = ans * a
    if mod:
        ans %= mod
    return ans
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.prime_check828
    set output_file "prime_check.py"

    set template_content '
def prime_check(n):
    if n <= 1:
        return False
    if n == 2 or n == 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    j = 5
    while j * j <= n:
        if n % j == 0 or n % (j + 2) == 0:
            return False
        j += 6
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.primes_sieve_of_eratosthenes829
    set output_file "primes_sieve_of_eratosthenes.py"

    set template_content '
def get_primes(n):
    if n <= 0:
        raise ValueError("'n' must be a positive integer.")
    # If x is even, exclude x from list (-1):
    sieve_size = (n // 2 - 1) if n % 2 == 0 else (n // 2)
    sieve = [True for _ in range(sieve_size)]   # Sieve
    primes = []      # List of Primes
    if n >= 2:
        primes.append(2)      # 2 is prime by default
    for i in range(sieve_size):
        if sieve[i]:
            value_at_i = i*2 + 3
            primes.append(value_at_i)
            for j in range(i, sieve_size, value_at_i):
                sieve[j] = False
    return primes
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.pythagoras830
    set output_file "pythagoras.py"

    set template_content '
def pythagoras(opposite, adjacent, hypotenuse):
    try:
        if opposite == str("?"):
            return ("Opposite = " + str(((hypotenuse**2) - (adjacent**2))**0.5))
        if adjacent == str("?"):
            return ("Adjacent = " + str(((hypotenuse**2) - (opposite**2))**0.5))
        if hypotenuse == str("?"):
            return ("Hypotenuse = " + str(((opposite**2) + (adjacent**2))**0.5))
        return "You already know the answer!"
    except:
        raise ValueError("invalid argument(s) were given.")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.rabin_miller831
    set output_file "rabin_miller.py"

    set template_content '
import random


def is_prime(n, k):
    def pow2_factor(num):
        """factor n into a power of 2 times an odd number"""
        power = 0
        while num % 2 == 0:
            num /= 2
            power += 1
        return power, num

    def valid_witness(a):
        x = pow(int(a), int(d), int(n))

        if x == 1 or x == n - 1:
            return False

        for _ in range(r - 1):
            x = pow(int(x), int(2), int(n))

            if x == 1:
                return True
            if x == n - 1:
                return False

        return True

    # precondition n >= 5
    if n < 5:
        return n == 2 or n == 3  # True for prime

    r, d = pow2_factor(n - 1)

    for _ in range(k):
        if valid_witness(random.randrange(2, n - 2)):
            return False

    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.recursive_binomial_coefficient832
    set output_file "recursive_binomial_coefficient.py"

    set template_content '
def recursive_binomial_coefficient(n, k):

    if k > n:
        raise ValueError("Invalid Inputs, ensure that n >= k")
        # function is only defined for n>=k
    if k == 0 or n == k:
        # C(n,0) = C(n,n) = 1, so this is our base case.
        return 1
    if k > n / 2:
        # C(n,k) = C(n,n-k), so if n/2 is sufficiently small, we can reduce the problem size.
        return recursive_binomial_coefficient(n, n - k)
    # else, we know C(n,k) = (n/k)C(n-1,k-1), so we can use this to reduce our problem size.
    return int((n / k) * recursive_binomial_coefficient(n - 1, k - 1))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.rsa833
    set output_file "rsa.py"

    set template_content '
import random


def generate_key(k, seed=None):
    def modinv(a, m):
        """calculate the inverse of a mod m
        that is, find b such that (a * b) % m == 1"""
        b = 1
        while not (a * b) % m == 1:
            b += 1
        return b

    def gen_prime(k, seed=None):
        """generate a prime with k bits"""

        def is_prime(num):
            if num == 2:
                return True
            for i in range(2, int(num ** 0.5) + 1):
                if num % i == 0:
                    return False
            return True

        random.seed(seed)
        while True:
            key = random.randrange(int(2 ** (k - 1)), int(2 ** k))
            if is_prime(key):
                return key

    # size in bits of p and q need to add up to the size of n
    p_size = k / 2
    q_size = k - p_size

    e = gen_prime(k, seed)  # in many cases, e is also chosen to be a small constant

    while True:
        p = gen_prime(p_size, seed)
        if p % e != 1:
            break

    while True:
        q = gen_prime(q_size, seed)
        if q % e != 1:
            break

    n = p * q
    l = (p - 1) * (q - 1)  # calculate totient function
    d = modinv(e, l)

    return int(n), int(e), int(d)


def encrypt(data, e, n):
    return pow(int(data), int(e), int(n))


def decrypt(data, d, n):
    return pow(int(data), int(d), int(n))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.square_root834
    set output_file "square_root.py"

    set template_content '
def square_root(n, epsilon=0.001):
    """Return square root of n, with maximum absolute error epsilon"""
    guess = n / 2

    while abs(guess * guess - n) > epsilon:
        guess = (guess + (n / guess)) / 2

    return guess
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.summing_digits835
    set output_file "summing_digits.py"

    set template_content '
def sum_dig_pow(low, high):
    result = []

    for number in range(low, high + 1):
        exponent = 1  # set to 1
        summation = 0    # set to 1
        number_as_string = str(number)

        tokens = list(map(int, number_as_string))  # parse the string into individual digits

        for k in tokens:
            summation = summation + (k ** exponent)
            exponent += 1

        if summation == number:
            result.append(number)
    return result


# Some test cases:
assert sum_dig_pow(1, 10) == [1, 2, 3, 4, 5, 6, 7, 8, 9]
assert sum_dig_pow(1, 100) == [1, 2, 3, 4, 5, 6, 7, 8, 9, 89]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end






function algoP.symmetry_group_cycle_index836
    set output_file "symmetry_group_cycle_index.py"

    set template_content '
from fractions import Fraction
from typing import Dict, Union
from polynomial import ( Monomial, Polynomial )
from gcd import lcm


def cycle_product(m1: Monomial, m2: Monomial) -> Monomial:
    assert isinstance(m1, Monomial) and isinstance(m2, Monomial)
    A = m1.variables
    B = m2.variables
    result_variables = dict()
    for i in A:
        for j in B:
            k = lcm(i, j)
            g = (i * j) // k
            if k in result_variables:
                result_variables[k] += A[i] * B[j] * g
            else:
                result_variables[k] = A[i] * B[j] * g

    return Monomial(result_variables, Fraction(m1.coeff * m2.coeff, 1))


def cycle_product_for_two_polynomials(p1: Polynomial, p2: Polynomial, q: Union[float, int, Fraction]) -> Union[float, int, Fraction]:
    ans = Fraction(0, 1)
    for m1 in p1.monomials:
        for m2 in p2.monomials:
            ans += cycle_product(m1, m2).substitute(q)

    return ans


def cycle_index_sym_helper(n: int, memo: Dict[int, Polynomial]) -> Polynomial:
    if n in memo:
        return memo[n]
    ans = Polynomial([Monomial({}, Fraction(0, 1))])
    for t in range(1, n+1):
        ans = ans.__add__(Polynomial([Monomial({t: 1}, Fraction(1, 1))]) * cycle_index_sym_helper(n-t, memo))
    ans *= Fraction(1, n)
    memo[n] = ans
    return memo[n]


def get_cycle_index_sym(n: int) -> Polynomial:
    if n < 0:
        raise ValueError('n should be a non-negative integer.')

    memo = {
        0: Polynomial([
            Monomial({}, Fraction(1, 1))
        ]),
        1: Polynomial([
            Monomial({1: 1}, Fraction(1, 1))
        ]),
        2: Polynomial([
            Monomial({1: 2}, Fraction(1, 2)),
            Monomial({2: 1}, Fraction(1, 2))
        ]),
        3: Polynomial([
            Monomial({1: 3}, Fraction(1, 6)),
            Monomial({1: 1, 2: 1}, Fraction(1, 2)),
            Monomial({3: 1}, Fraction(1, 3))
        ]),
        4: Polynomial([
            Monomial({1: 4}, Fraction(1, 24)),
            Monomial({2: 1, 1: 2}, Fraction(1, 4)),
            Monomial({3: 1, 1: 1}, Fraction(1, 3)),
            Monomial({2: 2}, Fraction(1, 8)),
            Monomial({4: 1}, Fraction(1, 4)),
        ])
    }
    result = cycle_index_sym_helper(n, memo)
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.word_pattern837
    set output_file "word_pattern.py"

    set template_content '
def word_pattern(pattern, str):
    dict = {}
    set_value = set()
    list_str = str.split()
    if len(list_str) != len(pattern):
        return False
    for i in range(len(pattern)):
        if pattern[i] not in dict:
            if list_str[i] in set_value:
                return False
            dict[pattern[i]] = list_str[i]
            set_value.add(list_str[i])
        else:
            if dict[pattern[i]] != list_str[i]:
                return False
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.is_valid_sudoku838
    set output_file "is_valid_sudoku.py"

    set template_content '
def is_valid_sudoku(self, board):
    seen = []
    for i, row in enumerate(board):
        for j, c in enumerate(row):
            if c != '.':
                seen += [(c,j),(i,c),(i/3,j/3,c)]
    return len(seen) == len(set(seen))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.separate_chaining_hashtable839
    set output_file "separate_chaining_hashtable.py"

    set template_content '
import unittest


class Node(object):
    def __init__(self, key=None, value=None, next=None):
        self.key = key
        self.value = value
        self.next = next


class SeparateChainingHashTable(object):
    _empty = None

    def __init__(self, size=11):
        self.size = size
        self._len = 0
        self._table = [self._empty] * size

    def put(self, key, value):
        hash_ = self.hash(key)
        node_ = self._table[hash_]
        if node_ is self._empty:
            self._table[hash_] = Node(key, value)
        else:
            while node_.next is not None:
                if node_.key == key:
                    node_.value = value
                    return
                node_ = node_.next
            node_.next = Node(key, value)
        self._len += 1

    def get(self, key):
        hash_ = self.hash(key)
        node_ = self._table[hash_]
        while node_ is not self._empty:
            if node_.key == key:
                return node_.value
            node_ = node_.next
        return None

    def del_(self, key):
        hash_ = self.hash(key)
        node_ = self._table[hash_]
        pre_node = None
        while node_ is not None:
            if node_.key == key:
                if pre_node is None:
                    self._table[hash_] = node_.next
                else:
                    pre_node.next = node_.next
                self._len -= 1
            pre_node = node_
            node_ = node_.next

    def hash(self, key):
        return hash(key) % self.size

    def __len__(self):
        return self._len

    def __getitem__(self, key):
        return self.get(key)

    def __delitem__(self, key):
        return self.del_(key)

    def __setitem__(self, key, value):
        self.put(key, value)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.randomized_set840
    set output_file "randomized_set.py"

    set template_content '
import random


class RandomizedSet:
    def __init__(self):
        self.nums = []
        self.idxs = {}

    def insert(self, val):
        if val not in self.idxs:
            self.nums.append(val)
            self.idxs[val] = len(self.nums)-1
            return True
        return False

    def remove(self, val):
        if val in self.idxs:
            idx, last = self.idxs[val], self.nums[-1]
            self.nums[idx], self.idxs[last] = last, idx
            self.nums.pop()
            self.idxs.pop(val, 0)
            return True
        return False

    def get_random(self):
        idx = random.randint(0, len(self.nums)-1)
        return self.nums[idx]


if __name__ == "__main__":
    rs = RandomizedSet()
    print("insert 1: ", rs.insert(1))
    print("insert 2: ", rs.insert(2))
    print("insert 3: ", rs.insert(3))
    print("insert 4: ", rs.insert(4))
    print("remove 3: ", rs.remove(3))
    print("remove 3: ", rs.remove(3))
    print("remove 1: ", rs.remove(1))
    print("random: ", rs.get_random())
    print("random: ", rs.get_random())
    print("random: ", rs.get_random())
    print("random: ", rs.get_random())
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.longest_palindromic_subsequence841
    set output_file "longest_palindromic_subsequence.py"

    set template_content '
def longest_palindromic_subsequence(s):

    k = len(s)
    olist = [0] * k    # 申请长度为n的列表，并初始化
    nList = [0] * k    # 同上
    logestSubStr = ""
    logestLen = 0

    for j in range(0, k):
        for i in range(0, j + 1):
            if j - i <= 1:
                if s[i] == s[j]:
                    nList[i] = 1                 # 当 j 时，第 i 个子串为回文子串
                    len_t = j - i + 1
                    if logestLen < len_t:        # 判断长度
                        logestSubStr = s[i:j + 1]
                        logestLen = len_t
            else:
                if s[i] == s[j] and olist[i+1]:   # 当j-i>1时，判断s[i]是否等于s[j]，并判断当j-1时，第i+1个子串是否为回文子串
                    nList[i] = 1                  # 当 j 时，第 i 个子串为回文子串
                    len_t = j - i + 1
                    if logestLen < len_t:
                        logestSubStr = s[i:j + 1]
                        logestLen = len_t
        olist = nList                            # 覆盖旧的列表
        nList = [0] * k                          # 新的列表清空
    # ~ from icecream import ic
    # ~ ic(s, logestSubStr)
    return logestLen#, logestSubStr
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.longest_common_subsequence842
    set output_file "longest_common_subsequence.py"

    set template_content '
def max_common_sub_string(s1, s2):
    # Assuming s2 has all unique chars
    s2dic = {s2[i]: i for i in range(len(s2))}
    maxr = 0
    subs = ''
    i = 0
    while i < len(s1):
        if s1[i] in s2dic:
            j = s2dic[s1[i]]
            k = i
            while j < len(s2) and k < len(s1) and s1[k] == s2[j]:
                k += 1
                j += 1
            if k - i > maxr:
                maxr = k-i
                subs = s1[i:k]
            i = k
        else:
            i += 1
    return subs
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.is_isomorphic843
    set output_file "is_isomorphic.py"

    set template_content '
def is_isomorphic(s, t):
    if len(s) != len(t):
        return False
    dict = {}
    set_value = set()
    for i in range(len(s)):
        if s[i] not in dict:
            if t[i] in set_value:
                return False
            dict[s[i]] = t[i]
            set_value.add(t[i])
        else:
            if dict[s[i]] != t[i]:
                return False
    return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.is_anagram844
    set output_file "is_anagram.py"

    set template_content '
def is_anagram(s, t):
   
    maps = {}
    mapt = {}
    for i in s:
        maps[i] = maps.get(i, 0) + 1
    for i in t:
        mapt[i] = mapt.get(i, 0) + 1
    return maps == mapt
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.hashtable845
    set output_file "hashtable.py"

    set template_content '
class HashTable(object):

    _empty = object()
    _deleted = object()

    def __init__(self, size=11):
        self.size = size
        self._len = 0
        self._keys = [self._empty] * size  # keys
        self._values = [self._empty] * size  # values

    def put(self, key, value):
        initial_hash = hash_ = self.hash(key)

        while True:
            if self._keys[hash_] is self._empty or self._keys[hash_] is self._deleted:
                # can assign to hash_ index
                self._keys[hash_] = key
                self._values[hash_] = value
                self._len += 1
                return
            elif self._keys[hash_] == key:
                # key already exists here, assign over
                self._keys[hash_] = key
                self._values[hash_] = value
                return

            hash_ = self._rehash(hash_)

            if initial_hash == hash_:
                # table is full
                raise ValueError("Table is full")

    def get(self, key):
        initial_hash = hash_ = self.hash(key)
        while True:
            if self._keys[hash_] is self._empty:
                # That key was never assigned
                return None
            elif self._keys[hash_] == key:
                # key found
                return self._values[hash_]

            hash_ = self._rehash(hash_)
            if initial_hash == hash_:
                # table is full and wrapped around
                return None

    def del_(self, key):
        initial_hash = hash_ = self.hash(key)
        while True:
            if self._keys[hash_] is self._empty:
                # That key was never assigned
                return None
            elif self._keys[hash_] == key:
                # key found, assign with deleted sentinel
                self._keys[hash_] = self._deleted
                self._values[hash_] = self._deleted
                self._len -= 1
                return

            hash_ = self._rehash(hash_)
            if initial_hash == hash_:
                # table is full and wrapped around
                return None

    def hash(self, key):
        return key % self.size

    def _rehash(self, old_hash):
        return (old_hash + 1) % self.size

    def __getitem__(self, key):
        return self.get(key)

    def __delitem__(self, key):
        return self.del_(key)

    def __setitem__(self, key, value):
        self.put(key, value)

    def __len__(self):
        return self._len


class ResizableHashTable(HashTable):
    MIN_SIZE = 8

    def __init__(self):
        super().__init__(self.MIN_SIZE)

    def put(self, key, value):
        rv = super().put(key, value)
        # increase size of dict * 2 if filled >= 2/3 size (like python dict)
        if len(self) >= (self.size * 2) / 3:
            self.__resize()

    def __resize(self):
        keys, values = self._keys, self._values
        self.size *= 2  # this will be the new size
        self._len = 0
        self._keys = [self._empty] * self.size
        self._values = [self._empty] * self.size
        for key, value in zip(keys, values):
            if key is not self._empty and key is not self._deleted:
                self.put(key, value)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.add_bitwise_operator846
    set output_file "add_bitwise_operator.py"

    set template_content '
def add_bitwise_operator(x, y):

    while y:
        carry = x & y
        x = x ^ y
        y = carry << 1
    return x
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.binary_gap847
    set output_file "binary_gap.py"

    set template_content '
def binary_gap(N):
    last = None
    ans = 0
    index = 0
    while N != 0:
        if N & 1:
            if last is not None:
                ans = max(ans, index - last)
            last = index
        index = index + 1
        N = N >> 1
    return ans


def binary_gap_improved(N):
    last = None
    ans = 0
    index = 0
    while N != 0:
        tes = N & 1
        if tes:
            if last is not None:
                ans = max(ans, index - last + 1)
            else:
                last = index
        else:
            last = index + 1
        index = index + 1
        N = N >> 1
    return ans


print(binary_gap(111))
print(binary_gap_improved(111))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.bit_operation848
    set output_file "subsets_unique.py"

    set template_content '
def get_bit(num, i):
    return (num & (1 << i)) != 0


def set_bit(num, i):
    return num | (1 << i)

def clear_bit(num, i):
    mask = ~(1 << i)
    return num & mask


def update_bit(num, i, bit):
    mask = ~(1 << i)
    return (num & mask) | (bit << i)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.bytes_int_conversion849
    set output_file "bytes_int_conversion.py"

    set template_content '
def int_to_bytes_big_endian(num):
    bytestr = deque()
    while num > 0:
        # list.insert(0, ...) is inefficient
        bytestr.appendleft(num & 0xff)
        num >>= 8
    return bytes(bytestr)


def int_to_bytes_little_endian(num):
    bytestr = []
    while num > 0:
        bytestr.append(num & 0xff)
        num >>= 8
    return bytes(bytestr)


def bytes_big_endian_to_int(bytestr):
    num = 0
    for b in bytestr:
        num <<= 8
        num += b
    return num


def bytes_little_endian_to_int(bytestr):
    num = 0
    e = 0
    for b in bytestr:
        num += b << e
        e += 8
    return num
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.count_flips_to_convert850
    set output_file "count_flips_to_convert.py"

    set template_content '
def count_flips_to_convert(a, b):

    diff = a ^ b

    # count number of ones in diff
    count = 0
    while diff:
        diff &= (diff - 1)
        count += 1
    return count
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.count_ones851
    set output_file "count_ones.py"

    set template_content '
def count_ones_recur(n):
    if not n:
        return 0
    return 1 + count_ones_recur(n & (n-1))


def count_ones_iter(n):
    count = 0
    while n:
        n &= (n-1)
        count += 1
    return count
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_difference852
    set output_file "find_difference.py"

    set template_content '
def find_difference(s, t):
    ret = 0
    for ch in s + t:
        # ord(ch) return an integer representing the Unicode code point of that character
        ret = ret ^ ord(ch)
    # chr(i) Return the string representing a character whose Unicode code point is the integer i
    return chr(ret)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.find_missing_number853
    set output_file "find_missing_number.py"

    set template_content '
def find_missing_number(nums):

    missing = 0
    for i, num in enumerate(nums):
        missing ^= num
        missing ^= i + 1

    return missing

def find_missing_number2(nums):

    num_sum = sum(nums)
    n = len(nums)
    total_sum = n*(n+1) // 2
    missing = total_sum - num_sum
    return missing
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.flip_bit_longest_sequence854
    set output_file "flip_bit_longest_sequence.py"

    set template_content '
def flip_bit_longest_seq(num):

    curr_len = 0
    prev_len = 0
    max_len = 0

    while num:
        if num & 1 == 1:  # last digit is 1
            curr_len += 1

        elif num & 1 == 0:  # last digit is 0
            if num & 2 == 0:  # second last digit is 0
                prev_len = 0
            else:
                prev_len = curr_len
            curr_len = 0

        max_len = max(max_len, prev_len + curr_len)
        num = num >> 1  # right shift num

    return max_len + 1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.has_alternative_bit_fast855
    set output_file "has_alternative_bit_fast.py"

    set template_content '
s_alternative_bit(n):
    first_bit = 0
    second_bit = 0
    while n:
        first_bit = n & 1
        if n >> 1:
            second_bit = (n >> 1) & 1
            if not first_bit ^ second_bit:
                return False
        else:
            return True
        n = n >> 1
    return True    

# Time Complexity - O(1)
def has_alternative_bit_fast(n):
    mask1 = int('aaaaaaaa', 16)  # for bits ending with zero (...1010)
    mask2 = int('55555555', 16)  # for bits ending with one  (...0101)
    return mask1 == (n + (n ^ mask1)) or mask2 == (n + (n ^ mask2))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.insert_one_bit856
    set output_file "insert_one_bit.py"

    set template_content '
def insert_one_bit(num, bit, i):
    # Create mask
    mask = num >> i
    mask = (mask << 1) | bit
    mask = mask << i
    # Keep the bit from 0 position to i position
    right = ((1 << i) - 1) & num
    return right | mask

def insert_mult_bits(num, bits, len, i):
    mask = num >> i
    mask = (mask << len) | bits
    mask = mask << i
    right = ((1 << i) - 1) & num
    return right | mask
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.is_power_of_two857
    set output_file "is_power_of_two.py"

    set template_content '
def is_power_of_two(n):
    return n > 0 and not n & (n-1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.remove_bit858
    set output_file "remove_bit.py"

    set template_content '
def remove_bit(num, i):
    mask = num >> (i + 1)
    mask = mask << i
    right = ((1 << i) - 1) & num
    return mask | right
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.reverse_bits859
    set output_file "reverse_bits.py"

    set template_content '
def reverse_bits(n):
    m = 0
    i = 0
    while i < 32:
        m = (m << 1) + (n & 1)
        n >>= 1
        i += 1
    return m
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.single_number860
    set output_file "single_number.py"

    set template_content '
def single_number(nums):
    i = 0
    for num in nums:
        i ^= num
    return i

def single_number2(nums):
    ones, twos = 0, 0
    for i in range(len(nums)):
        ones = (ones ^ nums[i]) & ~twos
        twos = (twos ^ nums[i]) & ~ones
    return ones

def single_number3(nums):
    # isolate a^b from pairs using XOR
    ab = 0
    for n in nums:
        ab ^= n

    # isolate right most bit from a^b
    right_most = ab & (-ab)

    # isolate a and b from a^b
    a, b = 0, 0
    for n in nums:
        if n & right_most:
            a ^= n
        else:
            b ^= n
    return [a, b]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.subsets861
    set output_file "subsets.py"

    set template_content '
def subsets(nums):
    n = len(nums)
    total = 1 << n
    res = set()

    for i in range(total):
        subset = tuple(num for j, num in enumerate(nums) if i & 1 << j)
        res.add(subset)

    return res

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.swap_pair862
    set output_file "swap_pair.py"

    set template_content '
def swap_pair(num):
    # odd bit arithmetic right shift 1 bit
    odd = (num & int('AAAAAAAA', 16)) >> 1
    # even bit left shift 1 bit
    even = (num & int('55555555', 16)) << 1
    return odd | even
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.histogram863
    set output_file "subsets_unique.py"

    set template_content '
def get_histogram(input_list: list) -> dict:
    # Create dict to store histogram
    histogram = {}
    # For each list value, add one to the respective histogram dict position
    for i in input_list:
        histogram[i] = histogram.get(i, 0) + 1
    return histogram
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.gale_shapley864
    set output_file "gale_shapley.py"

    set template_content '
def gale_shapley(men, women):
    size = len(men)
    # Initialize all men to be available
    men_available = list(men.keys())
    # Initialize married to empty
    married = {}
    # Intialize proposal count for each man to 0
    proposal_counts = {man: 0 for man in men}
    while men_available:
        # Pop first available man
        man = men_available.pop(0)
        # Of the popped man, set woman equal to corresponding proposal index
        woman = men[man][proposal_counts[man]]
        #increment proposal count
        proposal_counts[man] += 1
        if woman not in married:
            # Set marriage if woman not married
            married[woman] = man
        else:
            # If woman married, currently_married corresponds to currently matched man
            currently_married = married[woman]
            if women[woman].index(man) < women[woman].index(currently_married):
                """
                If the available man is of greater preference to the woman than her
                currently married partner, change the marriage to the new available
                man and append the previously married man back to men_available
                """
                married[woman] = man
                men_available.append(currently_married)
            else:
                # Add man back to men_available and try woman at next index
                men_available.append(man)
    # Returns pairs of matched men and women in form of Man:Woman
    return {man: woman for woman, man in married.items()}

# Example case
men_preferences = {
    "M1": ["W1", "W2", "W3"],
    "M2": ["W1", "W3", "W2"],
    "M3": ["W3", "W1", "W2"],
}
women_preferences = {
    "W1": ["M2", "M1", "M3"],
    "W2": ["M1", "M2", "M3"],
    "W3": ["M3", "M1", "M2"],
}

res = gale_shapley(men_preferences, women_preferences)
print(res)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.max_contiguous_subsequence_sum865
    set output_file "max_contiguous_subsequence_sum.py"

    set template_content '
def max_contiguous_subsequence_sum(arr) -> int:
    arr_size = len(arr)

    if arr_size == 0:
        return 0

    max_till_now = arr[0]
    curr_sub_sum = 0

    for i in range(0, arr_size):
        if curr_sub_sum + arr[i] < arr[i]:
            curr_sub_sum = arr[i]
        else:
            curr_sub_sum += arr[i]

        max_till_now = max(max_till_now, curr_sub_sum)

    return max_till_now
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindingSpans866
    set output_file "subsets_unique.py"

    set template_content '
class Stack:
    def __init__(self):
        self.items = []
         
    # method for pushing an item on a stack
    def push(self, item):
        self.items.append(item)
         
    # method for popping an item from a stack
    def pop(self):
        return self.items.pop()
     
    # method to check whether the stack is empty or not
    def isEmpty(self):
        return (self.items == [])
     
    # method to get the top of the stack
    def peek(self):
        return self.items[-1]
     
    def __str__(self):
        return str(self.items)

def findingSpans(A):
	D = Stack()
	S = [None] * len(A)
	for i in range (0, len(A)):
		while not D.isEmpty() and A[i] > A[D.peek()]:
		       	D.pop()
		if D.isEmpty():
		       P = -1
		else:
			P = D.peek()
		S[i] = i - P
		D.push(i)
	print S

findingSpans(['6', '3', '4', '5', '2'])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.generate_strobogrammtic877
    set output_file " generate_strobogrammtic.py"

    set template_content '
def gen_strobogrammatic(n):
    return helper(n, n)


def helper(n, length):
    if n == 0:
        return [""]
    if n == 1:
        return ["1", "0", "8"]
    middles = helper(n - 2, length)
    result = []
    for middle in middles:
        if n != length:
            result.append("0" + middle + "0")
        result.append("8" + middle + "8")
        result.append("1" + middle + "1")
        result.append("9" + middle + "6")
        result.append("6" + middle + "9")
    return result


def strobogrammatic_in_range(low, high):
    res = []
    count = 0
    low_len = len(low)
    high_len = len(high)
    for i in range(low_len, high_len + 1):
        res.extend(helper2(i, i))
    for perm in res:
        if len(perm) == low_len and int(perm) < int(low):
            continue
        if len(perm) == high_len and int(perm) > int(high):
            continue
        count += 1
    return count


def helper2(n, length):
    if n == 0:
        return [""]
    if n == 1:
        return ["0", "8", "1"]
    mids = helper(n - 2, length)
    res = []
    for mid in mids:
        if n != length:
            res.append("0" + mid + "0")
        res.append("1" + mid + "1")
        res.append("6" + mid + "9")
        res.append("9" + mid + "6")
        res.append("8" + mid + "8")
    return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.hailstone888
    set output_file "subsets_unique.py"

    set template_content '
def hailstone(n):
    """
    Return the 'hailstone sequence' from n to 1
    n: The starting point of the hailstone sequence
    """

    sequence = [n]
    while n > 1:
        if n%2 != 0:
            n = 3*n + 1
        else:
            n = int(n/2)
        sequence.append(n)
    return sequence
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.find_primitive_root889
    set output_file "find_primitive_root.py"

    set template_content '
import math


def find_order(a, n):
    if (a == 1) & (n == 1):
        # Exception Handeling : 1 is the order of of 1
        return 1
    if math.gcd(a, n) != 1:
        print("a and n should be relative prime!")
        return -1
    for i in range(1, n):
        if pow(a, i) % n == 1:
            return i
    return -1


def euler_totient(n):
    result = n
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            while n % i == 0:
                n //= i
            result -= result // i
    if n > 1:
        result -= result // n
    return result


def find_primitive_root(n):
    if n == 1:
        # Exception Handeling : 0 is the only primitive root of 1
        return [0]
    phi = euler_totient(n)
    p_root_list = []
    """ It will return every primitive roots of n. """
    for i in range(1, n):
        # To have order, a and n must be relative prime with each other.
        if math.gcd(i, n) == 1:
            order = find_order(i, n)
            if order == phi:
                p_root_list.append(i)
    return p_root_list
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.gcd890
    set output_file "gcd.py"

    set template_content '
def gcd(a, b):
    
    a_int = isinstance(a, int)
    b_int = isinstance(b, int)
    a = abs(a)
    b = abs(b)
    if not(a_int or b_int):
        raise ValueError("Input arguments are not integers")

    if (a == 0) or (b == 0) :
        raise ValueError("One or more input arguments equals zero")

    while b != 0:
        a, b = b, a % b
    return a

def lcm(a, b):
    return abs(a) * abs(b) / gcd(a, b)


def trailing_zero(x):
    count = 0
    while x and not x & 1:
        count += 1
        x >>= 1
    return count


def gcd_bit(a, b):
    """ Similar to gcd but uses bitwise operators and less error handling."""
    tza = trailing_zero(a)
    tzb = trailing_zero(b)
    a >>= tza
    b >>= tzb
    while b:
        if a < b:
            a, b = b, a
        a -= b
        a >>= trailing_zero(a)
    return a << min(tza, tzb)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.fft891
    set output_file "subsets_unique.py"

    set template_content '
from cmath import exp, pi

def fft(x):
    """ Recursive implementation of the Cooley-Tukey"""
    N = len(x)
    if N == 1:
        return x

    # get the elements at even/odd indices
    even = fft(x[0::2])
    odd = fft(x[1::2])

    y = [0 for i in range(N)]
    for k in range(N//2):
        q = exp(-2j*pi*k/N)*odd[k]
        y[k] = even[k] + q
        y[k + N//2] = even[k] - q

    return y
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.find_order892
    set output_file "find_order.py"

    set template_content '
import math

def find_order(a, n):
    if (a == 1) & (n == 1):
        # Exception Handeling : 1 is the order of of 1
        return 1
    if math.gcd(a, n) != 1:
        print ("a and n should be relative prime!")
        return -1
    for i in range(1, n):
        if pow(a, i) % n == 1:
            return i
    return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.extended_gcd893
    set output_file "extended_gcd.py"

    set template_content '
def extended_gcd(num1, num2):

    old_s, s = 1, 0
    old_t, t = 0, 1
    old_r, r = num1, num2

    while r != 0:
        quotient = old_r / r

        old_r, r = r, old_r - quotient * r
        old_s, s = s, old_s - quotient * s
        old_t, t = t, old_t - quotient * t

    return old_s, old_t, old_r
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.factorial894
    set output_file "factorial.py"

    set template_content '
def factorial(n, mod=None):
    if not (isinstance(n, int) and n >= 0):
        raise ValueError("'n' must be a non-negative integer.")
    if mod is not None and not (isinstance(mod, int) and mod > 0):
        raise ValueError("'mod' must be a positive integer")
    result = 1
    if n == 0:
        return 1
    for i in range(2, n+1):
        result *= i
        if mod:
            result %= mod
    return result


def factorial_recur(n, mod=None):
    if not (isinstance(n, int) and n >= 0):
        raise ValueError("'n' must be a non-negative integer.")
    if mod is not None and not (isinstance(mod, int) and mod > 0):
        raise ValueError("'mod' must be a positive integer")
    if n == 0:
        return 1
    result = n * factorial(n - 1, mod)
    if mod:
        result %= mod
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.diffie_hellman_key_exchange895
    set output_file "diffie_hellman_key_exchange.py"

    set template_content '
import math
from random import randint


def prime_check(num):
    if num <= 1:
        return False
    if num == 2 or num == 3:
        return True
    if num % 2 == 0 or num % 3 == 0:
        return False
    j = 5
    while j * j <= num:
        if num % j == 0 or num % (j + 2) == 0:
            return False
        j += 6
    return True


def find_order(a, n):
    if (a == 1) & (n == 1):
        # Exception Handeling : 1 is the order of of 1
        return 1
    if math.gcd(a, n) != 1:
        print ("a and n should be relative prime!")
        return -1
    for i in range(1, n):
        if pow(a, i) % n == 1:
            return i
    return -1



def euler_totient(n):
  
    result = n
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            while n % i == 0:
                n //= i
            result -= result // i
    if n > 1:
        result -= result // n
    return result



def find_primitive_root(n):
    if n == 1:
        # Exception Handeling : 0 is the only primitive root of 1
        return [0]
    phi = euler_totient(n)
    p_root_list = []
    for i in range (1, n):
        if math.gcd(i, n) != 1:
            # To have order, a and n must be relative prime with each other.
            continue
        order = find_order(i, n)
        if order == phi:
            p_root_list.append(i)
    return p_root_list



def alice_private_key(p):
    """Alice determine her private key
    in the range of 1 ~ p-1.
    This must be kept in secret"""
    return randint(1, p-1)


def alice_public_key(a_pr_k, a, p):
    """Alice calculate her public key
    with her private key.
    This is open to public"""
    return pow(a, a_pr_k) % p


def bob_private_key(p):
    """Bob determine his private key
    in the range of 1 ~ p-1.
    This must be kept in secret"""
    return randint(1, p-1)


def bob_public_key(b_pr_k, a, p):
    """Bob calculate his public key
    with his private key.
    This is open to public"""
    return pow(a, b_pr_k) % p


def alice_shared_key(b_pu_k, a_pr_k, p):
    return pow(b_pu_k, a_pr_k) % p


def bob_shared_key(a_pu_k, b_pr_k, p):
    return pow(a_pu_k, b_pr_k) % p


def diffie_hellman_key_exchange(a, p, option = None):
    if option is not None:
        # Print explanation of process when option parameter is given
        option = 1
    if prime_check(p) is False:
        print(f"{p} is not a prime number")
        # p must be large prime number
        return False
    try:
        p_root_list = find_primitive_root(p)
        p_root_list.index(a)
    except ValueError:
        print(f"{a} is not a primitive root of {p}")
        # a must be primitive root of p
        return False

    a_pr_k = alice_private_key(p)
    a_pu_k = alice_public_key(a_pr_k, a, p)

    b_pr_k = bob_private_key(p)
    b_pu_k = bob_public_key(b_pr_k, a, p)

    if option == 1:
        print(f"Alice's private key: {a_pr_k}")
        print(f"Alice's public key: {a_pu_k}")
        print(f"Bob's private key: {b_pr_k}")
        print(f"Bob's public key: {b_pu_k}")

    # In here, Alice send her public key to Bob, and Bob also send his public key to Alice.

    a_sh_k = alice_shared_key(b_pu_k, a_pr_k, p)
    b_sh_k = bob_shared_key(a_pu_k, b_pr_k, p)
    print (f"Shared key calculated by Alice = {a_sh_k}")
    print (f"Shared key calculated by Bob = {b_sh_k}")

    return a_sh_k == b_sh_k
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.euler_totient896
    set output_file "euler_totient.py"

    set template_content '
def euler_totient(n):
    result = n
    for i in range(2, int(n ** 0.5) + 1):
        if n % i == 0:
            while n % i == 0:
                n //= i
            result -= result // i
    if n > 1:
        result -= result // n
    return result
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


