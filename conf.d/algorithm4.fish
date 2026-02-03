function algoP.Quicksort
    set output_file "quicksort.py"

    set template_content 'def qsort(L):
    if L == []:
        return []
    return (
        qsort([x for x in L[1:] if x < L[0]]) +
        L[0:1] +
        qsort([x for x in L[1:] if x >= L[0]])
    )

lst = [44, 33, 22, 5, 77, 55, 999]
print(qsort(lst))
# [5, 22, 33, 44, 55, 77, 999]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Quicksort
    set output_file "quicksort.go"

    set template_content 'package main

import "fmt"

func qsort(arr []int) []int {
    if len(arr) == 0 {
        return []int{}
    }

    pivot := arr[0]
    left := []int{}
    right := []int{}

    for _, v := range arr[1:] {
        if v < pivot {
            left = append(left, v)
        } else {
            right = append(right, v)
        }
    }

    result := append(qsort(left), pivot)
    result = append(result, qsort(right)...)
    return result
}

func main() {
    lst := []int{44, 33, 22, 5, 77, 55, 999}
    fmt.Println(qsort(lst))
    // [5 22 33 44 55 77 999]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Permutations
    set output_file "main.py"

    set template_content '
def get_permutations(w):
    if len(w) <= 1:
        return set(w)

    smaller = get_permutations(w[1:])
    perms = set()

    for x in smaller:
        for pos in range(len(x) + 1):
            perm = x[:pos] + w[0] + x[pos:]
            perms.add(perm)

    return perms


print(get_permutations("nan"))
# {"nna", "ann", "nan"}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Permutations
    set output_file "main.go"

    set template_content '
package main

import "fmt"

func permutations(s string) map[string]bool {
    result := make(map[string]bool)

    if len(s) <= 1 {
        result[s] = true
        return result
    }

    smaller := permutations(s[1:])
    first := s[0:1]

    for perm := range smaller {
        for i := 0; i <= len(perm); i++ {
            newPerm := perm[:i] + first + perm[i:]
            result[newPerm] = true
        }
    }

    return result
}

func main() {
    perms := permutations("nan")
    for p := range perms {
        fmt.Println(p)
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LinearTableDefinition
    set output_file "array_print.go"

    set template_content 'package main

import "fmt"

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaxValue
    set output_file "array_max.go"

    set template_content 'package main

import "fmt"

func max(arrays []int, length int) int {
    for i := 0; i < length-1; i++ {
        if arrays[i] > arrays[i+1] {
            temp := arrays[i]
            arrays[i] = arrays[i+1]
            arrays[i+1] = temp
        }
    }
    return arrays[length-1]
    return maxValue
}

func main() {
    scores := []int{60, 50, 95, 80, 70}
    length := len(scores)

    maxValue := max(scores, length)
    fmt.Printf("Max Value = %d\n", maxValue)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BubbleSort.Swap
    set output_file "array_sort.go"

    set template_content 'package main

import "fmt"

func sort(arrays []int, length int) {
    for i := 0; i < length-1; i++ {
        for j := 0; j < length-i-1; j++ {
            if arrays[j] > arrays[j+1] {
                flag := arrays[j]
                arrays[j] = arrays[j+1]
                arrays[j+1] = flag
            }
        }
    }
}

func main() {
    // index starts from 0
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    sort(scores, length)

    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MinValue
    set output_file "array_min.go"

    set template_content 'package main

import "fmt"

func min(arrays []int, length int) int {
    minIndex := 0 // the index of the minimum
    for j := 1; j < length; j++ {
        if arrays[minIndex] > arrays[j] {
            minIndex = j
        }
    }
    return arrays[minIndex]
}

func main() {
    scores := []int{60, 80, 95, 50, 70}
    length := len(scores)

    minValue := min(scores, length)
    fmt.Printf("Min Value = %d\n", minValue)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SelectionSort
    set output_file "array_selection_sort.go"

    set template_content 'package main

import "fmt"

func sort(arrays []int, length int) {
    var minIndex int // Save the index of the selected minimum

    for i := 0; i < length-1; i++ {
        minIndex = i
        // Save the minimum value of each loop as the first element
        minValue := arrays[minIndex]

        for j := i; j < length-1; j++ {
            if minValue > arrays[j+1] {
                minValue = arrays[j+1]
                minIndex = j + 1
            }
        }

        // If minIndex changed, exchange elements
        if i != minIndex {
            temp := arrays[i]
            arrays[i] = arrays[minIndex]
            arrays[minIndex] = temp
        }
    }
}

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    sort(scores, length)

    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayAppend
    set output_file "array_append.go"

    set template_content 'package main

import "fmt"

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    // create a new array
    tempArray := make([]int, length+1)

    for i := 0; i < length; i++ {
        tempArray[i] = scores[i]
    }

    tempArray[length] = 75
    scores = tempArray

    for i := 0; i < length+1; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ArrayInsert
    set output_file "array_insert.go"

    set template_content 'package main

import "fmt"

func insert(array []int, length int, tempArray []int, score int, insertIndex int) {
    for i := 0; i < length; i++ {
        if i < insertIndex {
            tempArray[i] = array[i]
        } else {
            tempArray[i+1] = array[i]
        }
    }
    tempArray[insertIndex] = score
}

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    tempArray := make([]int, length+1)

    // Insert 75 into the index = 2
    insert(scores, length, tempArray, 75, 2)

    scores = tempArray

    for i := 0; i < length+1; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayDelete
    set output_file "array_delete.go"

    set template_content 'package main

import "fmt"

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}

    fmt.Printf("Please enter the index to be deleted:\n")
    var index int
    fmt.Scan(&index)

    length := len(scores)

    // create a new array
    tempArray := make([]int, length-1)

    for i := 0; i < length; i++ {
        if i < index {
            // Copy data in front of index
            tempArray[i] = scores[i]
        }
        if i > index {
            // Copy data after index
            tempArray[i-1] = scores[i]
        }
    }

    scores = tempArray

    for i := 0; i < length-1; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayDelete
    set output_file "array_delete.go"

    set template_content 'package main

import "fmt"

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}

    fmt.Printf("Please enter the index to be deleted:\n")
    var index int
    fmt.Scan(&index)

    length := len(scores)

    // create a new array
    tempArray := make([]int, length-1)

    for i := 0; i < length; i++ {
        if i < index {
            // Copy data in front of index
            tempArray[i] = scores[i]
        }
        if i > index {
            // Copy data after index
            tempArray[i-1] = scores[i]
        }
    }

    scores = tempArray

    for i := 0; i < length-1; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InsertionSort
    set output_file "array_insertion_sort.go"

    set template_content 'package main

import "fmt"

func sort(arrays []int, length int) {
    for i := 0; i < length; i++ {
        // Take unsorted new element
        insertElement := arrays[i]
        insertPosition := i

        // Move elements of the sorted part to the right
        for j := insertPosition - 1; j >= 0; j-- {
            if insertElement < arrays[j] {
                arrays[j+1] = arrays[j]
                insertPosition--
            }
        }

        // Insert the new element
        arrays[insertPosition] = insertElement
    }
}

func main() {
    // index starts from 0
    scores := []int{90, 70, 50, 80, 60, 85}
    length := len(scores)

    sort(scores, length)

    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayReverse
    set output_file "array_reverse.go"

    set template_content 'package main

import "fmt"

func reverse(arrays []int, length int) {
    middle := length / 2

    for i := 0; i <= middle; i++ {
        temp := arrays[i]
        arrays[i] = arrays[length-i-1]
        arrays[length-i-1] = temp
    }
}

func main() {
    scores := []int{50, 60, 70, 80, 90}
    length := len(scores)

    reverse(scores, length)

    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LinearSearch
    set output_file "array_linear_search.go"

    set template_content 'package main

import "fmt"

func main() {
    scores := []int{90, 70, 50, 80, 60, 85}

    fmt.Printf("Please enter the value you want to search:\n")
    var value int
    fmt.Scan(&value)

    isSearch := false
    length := len(scores)

    for i := 0; i < length; i++ {
        if scores[i] == value {
            isSearch = true
            fmt.Printf("Found value: %d at index: %d\n", value, i)
            break
        }
    }

    if !isSearch {
        fmt.Printf("The value was not found: %d\n", value)
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch
    set output_file "main.go"

    set template_content 'package main

import "fmt"

func binarySearch(arrays []int, length int, searchValue int) int {
    low := 0
    high := length - 1
    mid := 0

    for low <= high {
        mid = (low + high) / 2
        if arrays[mid] == searchValue {
            return mid
        } else if arrays[mid] < searchValue {
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return -1
}

func main() {
    scores := []int{30, 40, 50, 70, 85, 90, 100}
    length := len(scores)

    searchValue := 40
    position := binarySearch(scores, length, searchValue)
    fmt.Printf("%d position : %d\n", searchValue, position)

    fmt.Printf("-----------------------------\n")

    searchValue = 90
    position = binarySearch(scores, length, searchValue)
    fmt.Printf("%d position : %d\n", searchValue, position)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ShellSort
    set output_file "array_shell_sort.go"

    set template_content 'package main

import "fmt"

func swap(array []int, a int, b int) {
    array[a] = array[a] + array[b]
    array[b] = array[a] - array[b]
    array[a] = array[a] - array[b]
}

func shellSort(array []int, length int) {
    for gap := length / 2; gap > 0; gap = gap / 2 {
        for i := gap; i < length; i++ {
            j := i
            for {
                if j-gap < 0 || array[j] >= array[j-gap] {
                    break
                }
                swap(array, j, j-gap)
                j = j - gap
            }
        }
    }
}

func main() {
    scores := []int{9, 6, 5, 8, 0, 7, 4, 3, 1, 2}
    length := len(scores)

    shellSort(scores, length)

    for i := 0; i < length; i++ {
        fmt.Printf("%d, ", scores[i])
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.LinkedList
    set output_file "linked_list.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node) // the first node called head node

func initial() {
    head.data = "San Francisco"
    head.next = nil

    nodeOakland := &Node{data: "Oakland", next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", next: nil}
    nodeOakland.next = nodeBerkeley

    tail := &Node{data: "Fremont", next: nil}
    nodeBerkeley.next = tail
}

func output(node *Node) {
    p := node
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.next
    }
    fmt.Printf("End\n\n")
}

func main() {
    initial()
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LinkedListAppend
    set output_file "linked_list_append.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.next = nil

    nodeOakland := &Node{data: "Oakland", next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.next = nil
    nodeBerkeley.next = tail
}

func add(data string) {
    newNode := &Node{data: data, next: nil}
    tail.next = newNode
    tail = newNode
}

func output(node *Node) {
    p := node
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.next
    }
    fmt.Printf("End\n\n")
}

func main() {
    initial()
    fmt.Printf("Append a new node name: Walnut to the end:\n")
    add("Walnut")
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LinkedListDelete
    set output_file "linked_list_delete.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.next = nil

    nodeOakland := &Node{data: "Oakland", next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.next = nil
    nodeBerkeley.next = tail
}

func removeNode(removePosition int) {
    p := head
    i := 0
    // Move to the node before the one to delete
    for {
        if p.next == nil || i >= removePosition-1 {
            break
        }
        p = p.next
        i++
    }
    temp := p.next         // Save the node to delete
    p.next = p.next.next   // Previous node points to next of deleted node
    temp.next = nil
}

func output(node *Node) {
    p := node
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.next
    }
    fmt.Printf("End\n\n")
}

func main() {
    initial()
    fmt.Printf("Delete a node Berkeley at index = 2:\n")
    removeNode(2)
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DoublyLinkedList
    set output_file "doubly_linked_list.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.prev = nil
    head.next = nil

    nodeOakland := &Node{data: "Oakland", prev: head, next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", prev: nodeOakland, next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.prev = nodeBerkeley
    tail.next = nil
    nodeBerkeley.next = tail
}

func output(node *Node) {
    p := node
    var end *Node = nil

    // Forward traversal
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        end = p
        p = p.next
    }
    fmt.Printf("End\n")

    // Backward traversal
    p = end
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.prev
    }
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.DoublyLinkedListAppend
    set output_file "doubly_linked_list_append.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.prev = nil
    head.next = nil

    nodeOakland := &Node{data: "Oakland", prev: head, next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", prev: nodeOakland, next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.prev = nodeBerkeley
    tail.next = nil
    nodeBerkeley.next = tail
}

func add(data string) {
    newNode := &Node{data: data, next: nil}
    tail.next = newNode
    newNode.prev = tail
    tail = newNode
}

func output(node *Node) {
    p := node
    var end *Node = nil

    // Forward traversal
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        end = p
        p = p.next
    }
    fmt.Printf("End\n")

    // Backward traversal
    p = end
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.prev
    }
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    fmt.Printf("Add a new node Walnut:\n")
    add("Walnut")
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DoublyLinkedListInsert
    set output_file "doubly_linked_list_insert.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.prev = nil
    head.next = nil

    nodeOakland := &Node{data: "Oakland", prev: head, next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", prev: nodeOakland, next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.prev = nodeBerkeley
    tail.next = nil
    nodeBerkeley.next = tail
}

func insert(insertPosition int, data string) {
    p := head
    i := 0
    for {
        if p.next == nil || i >= insertPosition-1 {
            break
        }
        p = p.next
        i++
    }

    newNode := &Node{data: data}
    newNode.next = p.next // newNode next points to next node
    p.next = newNode      // current node points to newNode
    newNode.prev = p

    if newNode.next != nil {
        newNode.next.prev = newNode
    } else {
        tail = newNode
    }
}

func output(node *Node) {
    p := node
    var end *Node = nil

    // Forward traversal
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        end = p
        p = p.next
    }
    fmt.Printf("End\n")

    // Backward traversal
    p = end
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.prev
    }
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    fmt.Printf("Insert a new node Walnut at index 2:\n")
    insert(2, "Walnut")
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DoublyLinkedListDelete
    set output_file "doubly_linked_list_delete.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "San Francisco"
    head.prev = nil
    head.next = nil

    nodeOakland := &Node{data: "Oakland", prev: head, next: nil}
    head.next = nodeOakland

    nodeBerkeley := &Node{data: "Berkeley", prev: nodeOakland, next: nil}
    nodeOakland.next = nodeBerkeley

    tail.data = "Fremont"
    tail.prev = nodeBerkeley
    tail.next = nil
    nodeBerkeley.next = tail
}

func removeNode(removePosition int) {
    p := head
    i := 0

    // Move to the node before the one to delete
    for {
        if p.next == nil || i >= removePosition-1 {
            break
        }
        p = p.next
        i++
    }

    temp := p.next // Save the node to delete
    if temp == nil {
        return // nothing to delete
    }

    p.next = temp.next // Previous node points to next of deleted node
    if temp.next != nil {
        temp.next.prev = p
    } else {
        tail = p // update tail if last node deleted
    }

    temp.next = nil // clean up
    temp.prev = nil
}

func output(node *Node) {
    p := node
    var end *Node = nil

    // Forward traversal
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        end = p
        p = p.next
    }
    fmt.Printf("End\n")

    // Backward traversal
    p = end
    for {
        if p == nil {
            break
        }
        fmt.Printf("%s -> ", p.data)
        p = p.prev
    }
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    fmt.Printf("Delete node Berkeley at index = 2:\n")
    removeNode(2)
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoG.CircularLinkedList
    set output_file "circular_linked_list.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.next = nil

    nodeB := &Node{data: "B", next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.next = head // make it circular
    nodeC.next = tail
}

func output(node *Node) {
    p := node
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s \n\n", p.data)
}

func main() {
    initial()
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CircularLinkedListInsert
    set output_file "circular_linked_list_insert.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.next = nil

    nodeB := &Node{data: "B", next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.next = head   // make it circular
    nodeC.next = tail
}

func insert(insertPosition int, data string) {
    p := head
    i := 0

    // Move to the node before the insertion position
    for {
        if p.next == nil || i >= insertPosition-1 {
            break
        }
        p = p.next
        i++
    }

    newNode := &Node{data: data}
    newNode.next = p.next
    p.next = newNode

    // Update tail if we inserted before head (at the end)
    if p == tail {
        tail = newNode
        tail.next = head
    }
}

func output(node *Node) {
    p := node
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s \n\n", p.data)
}

func main() {
    initial()
    fmt.Printf("Insert a new node E at index = 2:\n")
    insert(2, "E")
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CircularLinkedListDelete
    set output_file "circular_linked_list_delete.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.next = nil

    nodeB := &Node{data: "B", next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.next = head   // make it circular
    nodeC.next = tail
}

func removeNode(removePosition int) {
    if removePosition == 0 {
        // Remove head
        tail.next = head.next
        head = head.next
        return
    }

    p := head
    i := 0

    // Move to the node before the one to delete
    for {
        if p.next == nil || i >= removePosition-1 {
            break
        }
        p = p.next
        i++
    }

    temp := p.next
    if temp == nil {
        return
    }

    p.next = temp.next

    // Update tail if we deleted the last node
    if temp == tail {
        tail = p
        tail.next = head
    }

    temp.next = nil
}

func output(node *Node) {
    p := node
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s \n\n", p.data)
}

func main() {
    initial()
    fmt.Printf("Delete a node at index = 2:\n")
    removeNode(2)
    output(head)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CircularDoublyLinkedList
    set output_file "circular_doubly_linked_list.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.prev = nil
    head.next = nil

    nodeB := &Node{data: "B", prev: head, next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", prev: nodeB, next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.prev = nodeC
    tail.next = head
    nodeC.next = tail
    head.prev = tail
}

func output() {
    p := head
    // Forward traversal
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("End\n")

    // Backward traversal
    p = tail
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.prev
        if p == tail {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    output()
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.CircularDoublyLinkedListInsert
    set output_file "circular_doubly_linked_list_insert.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.prev = nil
    head.next = nil

    nodeB := &Node{data: "B", prev: head, next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", prev: nodeB, next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.prev = nodeC
    tail.next = head
    nodeC.next = tail
    head.prev = tail
}

func insert(insertPosition int, data string) {
    p := head
    i := 0

    for {
        if p.next == nil || i >= insertPosition-1 {
            break
        }
        p = p.next
        i++
    }

    newNode := &Node{data: data}
    newNode.next = p.next
    newNode.prev = p
    p.next = newNode

    if newNode.next != nil {
        newNode.next.prev = newNode
    } else {
        tail = newNode
        tail.next = head
        head.prev = tail
    }
}

func output() {
    p := head
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("End\n")

    p = tail
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.prev
        if p == tail {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    fmt.Printf("Insert a new node E at index 2:\n")
    insert(2, "E")
    output()
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CircularDoublyLinkedListDelete
    set output_file "circular_doubly_linked_list_delete.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = new(Node)
var tail *Node = new(Node)

func initial() {
    head.data = "A"
    head.prev = nil
    head.next = nil

    nodeB := &Node{data: "B", prev: head, next: nil}
    head.next = nodeB

    nodeC := &Node{data: "C", prev: nodeB, next: nil}
    nodeB.next = nodeC

    tail.data = "D"
    tail.prev = nodeC
    tail.next = head
    nodeC.next = tail
    head.prev = tail
}

func removeNode(removePosition int) {
    p := head
    i := 0

    for {
        if p.next == nil || i >= removePosition-1 {
            break
        }
        p = p.next
        i++
    }

    temp := p.next
    p.next = temp.next
    temp.next.prev = p
    temp.next = nil
    temp.prev = nil
}

func output() {
    p := head
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.next
        if p == head {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("End\n")

    p = tail
    for {
        fmt.Printf("%s -> ", p.data)
        p = p.prev
        if p == tail {
            break
        }
    }
    fmt.Printf("%s ", p.data)
    fmt.Printf("Start\n\n")
}

func main() {
    initial()
    fmt.Printf("Delete a new node C at index = 2:\n")
    removeNode(2)
    output()
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.DoublyLinkedQueue
    set output_file "doubly_linked_queue.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    prev *Node
    next *Node
}

var head *Node = nil
var tail *Node = new(Node)
var size int

func offer(element string) {
    if head == nil {
        head = new(Node)
        head.data = element
        tail = head
    } else {
        newNode := new(Node)
        newNode.data = element
        newNode.next = tail
        tail.prev = newNode
        tail = newNode
    }
    size++
}

func poll() *Node {
    p := head
    if p == nil {
        return nil
    }
    head = head.prev
    if head != nil {
        head.next = nil
    }
    p.next = nil
    p.prev = nil
    size--
    return p
}

func output() {
    fmt.Printf("Head ")
    var node *Node = nil
    for {
        node = poll()
        if node == nil {
            break
        }
        fmt.Printf("%s <- ", node.data)
    }
    fmt.Printf("Tail\n")
}

func main() {
    offer("A")
    offer("B")
    offer("C")
    offer("D")
    output()
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.StackLinkedList
    set output_file "stack_linked_list.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data string
    next *Node
}

var top *Node = nil
var size int

func push(element string) {
    if top == nil {
        top = new(Node)
        top.data = element
    } else {
        newNode := new(Node)
        newNode.data = element
        newNode.next = top
        top = newNode
    }
    size++
}

func pop() *Node {
    if top == nil {
        return nil
    }
    p := top
    top = top.next
    p.next = nil
    size--
    return p
}

func output() {
    fmt.Printf("Top ")
    var node *Node = nil
    for {
        node = pop()
        if node == nil {
            break
        }
        fmt.Printf("%s -> ", node.data)
    }
    fmt.Printf("End\n")
}

func main() {
    push("A")
    push("B")
    push("C")
    push("D")
    output()
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FactorialRecursive
    set output_file "factorial_recursive.go"

    set template_content 'package main

import "fmt"

func factorial(n int) int {
    if n == 1 {
        return 1
    } else {
        return factorial(n-1) * n // Recursively call until n == 1
    }
}

func main() {
    var n = 5
    var fac = factorial(n)
    fmt.Printf("The factorial of %d is: %d\n", n, fac)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeSort
    set output_file "merge_sort.go"

    set template_content 'package main

import "fmt"

func main() {
    var scores = []int{50, 65, 99, 87, 74, 63, 76, 100, 92}
    var length = len(scores)
    sort(scores, length)
    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}

func sort(array []int, length int) {
    temp := make([]int, length)
    mergeSort(array, temp, 0, length-1)
}

func mergeSort(array []int, temp []int, left int, right int) {
    if left < right {
        center := (left + right) / 2
        mergeSort(array, temp, left, center)        // Left merge sort
        mergeSort(array, temp, center+1, right)     // Right merge sort
        merge(array, temp, left, center+1, right)  // Merge two sorted subarrays
    }
}

func merge(array []int, temp []int, left int, right int, rightEndIndex int) {
    leftEndIndex := right - 1
    tempIndex := left
    elementNumber := rightEndIndex - left + 1

    for left <= leftEndIndex && right <= rightEndIndex {
        if array[left] <= array[right] {
            temp[tempIndex] = array[left]
            tempIndex++
            left++
        } else {
            temp[tempIndex] = array[right]
            tempIndex++
            right++
        }
    }

    for left <= leftEndIndex {
        temp[tempIndex] = array[left]
        tempIndex++
        left++
    }

    for right <= rightEndIndex {
        temp[tempIndex] = array[right]
        tempIndex++
        right++
    }

    for i := 0; i < elementNumber; i++ {
        array[rightEndIndex] = temp[rightEndIndex]
        rightEndIndex--
    }
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.QuickSort
    set output_file "quick_sort.go"

    set template_content 'package main

import "fmt"

func main() {
    var scores = []int{50, 65, 99, 87, 74, 63, 76, 100, 92}
    var length = len(scores)
    sort(scores, length)
    for i := 0; i < length; i++ {
        fmt.Printf("%d,", scores[i])
    }
}

func sort(array []int, length int) {
    if length > 0 {
        quickSort(array, 0, length-1)
    }
}

func quickSort(array []int, low int, high int) {
    if low > high {
        return
    }

    i := low
    j := high
    threshold := array[low]

    for {
        if i >= j {
            break
        }

        // Scan from right to left for element <= threshold
        for {
            if i >= j || array[j] <= threshold {
                break
            }
            j--
        }

        if i < j {
            array[i] = array[j]
            i++
        }

        // Scan from left to right for element > threshold
        for {
            if i >= j || array[i] > threshold {
                break
            }
            i++
        }

        if i < j {
            array[j] = array[i]
            j--
        }
    }

    array[i] = threshold

    // Recursive sort left and right subarrays
    quickSort(array, low, i-1)
    quickSort(array, i+1, high)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearchTreeInOrder
    set output_file "main.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data  int
    left  *Node
    right *Node
}

var root *Node = nil

func createNewNode(newData int) *Node {
    newNode := new(Node)
    newNode.data = newData
    newNode.left = nil
    newNode.right = nil
    return newNode
}

// In-order traversal of BST
func inOrder(root *Node) {
    if root == nil {
        return
    }
    inOrder(root.left)
    fmt.Printf("%d, ", root.data)
    inOrder(root.right)
}

func insert(node *Node, newData int) {
    if root == nil {
        root = &Node{data: newData, left: nil, right: nil}
        return
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        if node.left == nil {
            node.left = createNewNode(newData)
        } else {
            insert(node.left, newData)
        }
    } else if compareValue > 0 {
        if node.right == nil {
            node.right = createNewNode(newData)
        } else {
            insert(node.right, newData)
        }
    }
}

func main() {
    // Constructing a BST
    insert(root, 60)
    insert(root, 40)
    insert(root, 20)
    insert(root, 10)
    insert(root, 30)
    insert(root, 50)
    insert(root, 80)
    insert(root, 70)
    insert(root, 90)

    fmt.Printf("In-order traversal of BST:\n")
    inOrder(root)
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.BinarySearchTreePreOrder
    set output_file "main.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data  int
    left  *Node
    right *Node
}

var root *Node = nil

func createNewNode(newData int) *Node {
    newNode := new(Node)
    newNode.data = newData
    newNode.left = nil
    newNode.right = nil
    return newNode
}

// Pre-order traversal of BST
func preOrder(root *Node) {
    if root == nil {
        return
    }
    fmt.Printf("%d, ", root.data)
    preOrder(root.left)
    preOrder(root.right)
}

func insert(node *Node, newData int) {
    if root == nil {
        root = &Node{data: newData, left: nil, right: nil}
        return
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        if node.left == nil {
            node.left = createNewNode(newData)
        } else {
            insert(node.left, newData)
        }
    } else if compareValue > 0 {
        if node.right == nil {
            node.right = createNewNode(newData)
        } else {
            insert(node.right, newData)
        }
    }
}

func main() {
    // Constructing a BST
    insert(root, 60)
    insert(root, 40)
    insert(root, 20)
    insert(root, 10)
    insert(root, 30)
    insert(root, 50)
    insert(root, 80)
    insert(root, 70)
    insert(root, 90)

    fmt.Printf("Pre-order traversal of BST:\n")
    preOrder(root)
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.BinarySearchTreePostOrder
    set output_file "main.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data  int
    left  *Node
    right *Node
}

var root *Node = nil

func createNewNode(newData int) *Node {
    newNode := new(Node)
    newNode.data = newData
    newNode.left = nil
    newNode.right = nil
    return newNode
}

// Post-order traversal of BST
func postOrder(root *Node) {
    if root == nil {
        return
    }
    postOrder(root.left)
    postOrder(root.right)
    fmt.Printf("%d, ", root.data)
}

func insert(node *Node, newData int) {
    if root == nil {
        root = &Node{data: newData, left: nil, right: nil}
        return
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        if node.left == nil {
            node.left = createNewNode(newData)
        } else {
            insert(node.left, newData)
        }
    } else if compareValue > 0 {
        if node.right == nil {
            node.right = createNewNode(newData)
        } else {
            insert(node.right, newData)
        }
    }
}

func main() {
    // Constructing a BST
    insert(root, 60)
    insert(root, 40)
    insert(root, 20)
    insert(root, 10)
    insert(root, 30)
    insert(root, 50)
    insert(root, 80)
    insert(root, 70)
    insert(root, 90)

    fmt.Printf("Post-order traversal of BST:\n")
    postOrder(root)
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.BinarySearchTreePostOrder
    set output_file "main.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data  int
    left  *Node
    right *Node
}

var root *Node = nil

func createNewNode(newData int) *Node {
    newNode := new(Node)
    newNode.data = newData
    newNode.left = nil
    newNode.right = nil
    return newNode
}

// Post-order traversal of BST
func postOrder(root *Node) {
    if root == nil {
        return
    }
    postOrder(root.left)
    postOrder(root.right)
    fmt.Printf("%d, ", root.data)
}

func insert(node *Node, newData int) {
    if root == nil {
        root = &Node{data: newData, left: nil, right: nil}
        return
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        if node.left == nil {
            node.left = createNewNode(newData)
        } else {
            insert(node.left, newData)
        }
    } else if compareValue > 0 {
        if node.right == nil {
            node.right = createNewNode(newData)
        } else {
            insert(node.right, newData)
        }
    }
}

func main() {
    // Constructing a BST
    insert(root, 60)
    insert(root, 40)
    insert(root, 20)
    insert(root, 10)
    insert(root, 30)
    insert(root, 50)
    insert(root, 80)
    insert(root, 70)
    insert(root, 90)

    fmt.Printf("Post-order traversal of BST:\n")
    postOrder(root)
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearchTreeDelete
    set output_file "main.go"

    set template_content 'package main

import "fmt"

type Node struct {
    data  int
    left  *Node
    right *Node
}

var root *Node = nil

func createNewNode(newData int) *Node {
    newNode := new(Node)
    newNode.data = newData
    newNode.left = nil
    newNode.right = nil
    return newNode
}

// Find minimum value node in BST
func searchMinValue(node *Node) *Node {
    if node == nil {
        return nil
    }
    if node.left == nil {
        return node
    }
    return searchMinValue(node.left)
}

// In-order traversal of BST
func inOrder(root *Node) {
    if root == nil {
        return
    }
    inOrder(root.left)
    fmt.Printf("%d, ", root.data)
    inOrder(root.right)
}

// Insert a new node into BST
func insert(node *Node, newData int) {
    if root == nil {
        root = &Node{data: newData, left: nil, right: nil}
        return
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        if node.left == nil {
            node.left = createNewNode(newData)
        } else {
            insert(node.left, newData)
        }
    } else if compareValue > 0 {
        if node.right == nil {
            node.right = createNewNode(newData)
        } else {
            insert(node.right, newData)
        }
    }
}

// Remove a node from BST
func removeNode(node *Node, newData int) *Node {
    if node == nil {
        return node
    }

    compareValue := newData - node.data

    if compareValue < 0 {
        node.left = removeNode(node.left, newData)
    } else if compareValue > 0 {
        node.right = removeNode(node.right, newData)
    } else if node.left != nil && node.right != nil {
        // Node with two children
        node.data = searchMinValue(node.right).data
        node.right = removeNode(node.right, node.data)
    } else {
        if node.left != nil {
            node = node.left
        } else {
            node = node.right
        }
    }
    return node
}

func main() {
    // Constructing a BST
    insert(root, 60)
    insert(root, 40)
    insert(root, 20)
    insert(root, 10)
    insert(root, 30)
    insert(root, 50)
    insert(root, 80)
    insert(root, 70)
    insert(root, 90)

    fmt.Printf("Delete node: 10\n")
    removeNode(root, 10)
    fmt.Printf("In-order traversal:\n")
    inOrder(root)
    fmt.Printf("\n--------------------------------------------\n")

    fmt.Printf("Delete node: 20\n")
    removeNode(root, 20)
    fmt.Printf("In-order traversal:\n")
    inOrder(root)
    fmt.Printf("\n--------------------------------------------\n")

    fmt.Printf("Delete node: 40\n")
    removeNode(root, 40)
    fmt.Printf("In-order traversal:\n")
    inOrder(root)
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HeapSort
    set output_file "heap_sort.go"

    set template_content 'package main

import "fmt"

// Adjust heap for a given non-leaf node
func adjustHeap(array []int, currentIndex int, maxLength int) {
    noLeafValue := array[currentIndex] // Current non-leaf node

    // 2 * currentIndex + 1 is the left child index
    for j := 2*currentIndex + 1; j <= maxLength; j = 2*currentIndex + 1 {
        if j < maxLength && array[j] < array[j+1] {
            j++ // Move to the larger child
        }
        if noLeafValue >= array[j] {
            break
        }
        array[currentIndex] = array[j] // Move child up
        currentIndex = j
    }
    array[currentIndex] = noLeafValue // Place the original value
}

// Initialize the heap
func createHeap(array []int, length int) {
    // Start from the last non-leaf node and adjust heap
    for i := (length - 1) / 2; i >= 0; i-- {
        adjustHeap(array, i, length-1)
    }
}

// Heap sort
func heapSort(array []int, length int) {
    for i := length - 1; i > 0; i-- {
        array[0], array[i] = array[i], array[0] // Swap max to the end
        adjustHeap(array, 0, i-1)               // Re-adjust heap
    }
}

func main() {
    scores := []int{10, 90, 20, 80, 30, 70, 40, 60, 50}
    length := len(scores)

    fmt.Printf("Before building a heap:\n")
    for i := 0; i < length; i++ {
        fmt.Printf("%d, ", scores[i])
    }
    fmt.Printf("\n\n")

    fmt.Printf("After building a heap:\n")
    createHeap(scores, length)
    for i := 0; i < length; i++ {
        fmt.Printf("%d, ", scores[i])
    }
    fmt.Printf("\n\n")

    fmt.Printf("After heap sorting:\n")
    heapSort(scores, length)
    for i := 0; i < length; i++ {
        fmt.Printf("%d, ", scores[i])
    }
    fmt.Printf("\n")
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HashTable
    set output_file "hash_table.go"

    set template_content 'package main

import (
    "fmt"
    "math"
    "strings"
)

type Node struct {
    key   string
    value string
    hash  int
    next  *Node
}

const CAPACITY = 16
var table = make([]*Node, CAPACITY)
var size int

func isEmpty() bool {
    return size == 0
}

// Simple hash function using mid-square method
func hashCode(key string) int {
    num := 0
    length := len(key)
    for i := 0; i < length; i++ {
        num += int(key[i])
    }
    avg := num * int((math.Sqrt(5.0) - 1) / 2)
    numeric := avg - int(math.Floor(float64(avg)))
    return int(math.Floor(float64(numeric * CAPACITY)))
}

// Insert key-value pair
func put(key string, value string) {
    hash := hashCode(key)
    newNode := &Node{key: key, value: value, hash: hash, next: nil}

    node := table[hash]
    for node != nil {
        if strings.Compare(node.key, key) == 0 {
            node.value = value
            return
        }
        node = node.next
    }

    newNode.next = table[hash]
    table[hash] = newNode
    size++
}

// Get value by key
func get(key string) string {
    if key == "" {
        return ""
    }
    hash := hashCode(key)
    node := table[hash]
    for node != nil {
        if strings.Compare(node.key, key) == 0 {
            return node.value
        }
        node = node.next
    }
    return ""
}

func main() {
    put("david", "Good Boy Keep Going")
    put("grace", "Cute Girl Keep Going")
    fmt.Printf("david => %s\n", get("david"))
    fmt.Printf("grace => %s\n", get("grace"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DFSGraph
    set output_file "dfs_graph.go"

    set template_content 'package main

import "fmt"

const MAX_VERTEX_SIZE = 5
const STACKSIZE = 1000

type Vertex struct {
    data    string
    visited bool
}

var top = -1
var stacks = make([]int, STACKSIZE)

func push(element int) {
    top++
    stacks[top] = element
}

func pop() int {
    if top == -1 {
        return -1
    }
    data := stacks[top]
    top--
    return data
}

func peek() int {
    if top == -1 {
        return -1
    }
    return stacks[top]
}

func isEmpty() bool {
    return top == -1
}

var size = 0
var vertexs = make([]Vertex, MAX_VERTEX_SIZE)
var adjacencyMatrix [MAX_VERTEX_SIZE][MAX_VERTEX_SIZE]int

func addVertex(data string) {
    vertexs[size] = Vertex{data: data, visited: false}
    size++
}

func addEdge(from int, to int) {
    adjacencyMatrix[from][to] = 1
}

func clearVisited() {
    for i := 0; i < size; i++ {
        vertexs[i].visited = false
    }
}

func depthFirstSearch() {
    vertexs[0].visited = true
    fmt.Printf("%s", vertexs[0].data)
    push(0)

    for !isEmpty()
        row := peek()
        col := findAdjacencyUnVisitedVertex(row)
        if col == -1
            pop()
        else
            vertexs[col].visited = true
            fmt.Printf(" -> %s", vertexs[col].data)
            push(col)
        end
    end

    fmt.Println()
    clearVisited()
}

func findAdjacencyUnVisitedVertex(row int) int {
    for col := 0; col < size; col++
        if adjacencyMatrix[row][col] == 1 && !vertexs[col].visited
            return col
        end
    end
    return -1
}

func printGraph() {
    fmt.Println("Vertex and adjacency matrix:")
    for i := 0; i < size; i++
        fmt.Printf("%s ", vertexs[i].data)
    end
    fmt.Println()
    for i := 0; i < size; i++
        fmt.Printf("%s ", vertexs[i].data)
        for j := 0; j < size; j++
            fmt.Printf("%d ", adjacencyMatrix[i][j])
        end
        fmt.Println()
    end
}

func main() {
    addVertex("A")
    addVertex("B")
    addVertex("C")
    addVertex("D")
    addVertex("E")

    addEdge(0, 1)
    addEdge(0, 2)
    addEdge(0, 3)
    addEdge(1, 2)
    addEdge(1, 3)
    addEdge(2, 3)
    addEdge(3, 4)

    printGraph()
    fmt.Println("\nDepth-first search traversal output:")
    depthFirstSearch()
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BFSGraph
    set output_file "bfs_graph.go"

    set template_content 'package main

import "fmt"

const MAX_VERTEX_SIZE = 5
const QUEUESIZE = 40

type Queue struct {
    queue [QUEUESIZE]int
    head  int
    tail  int
}

var q *Queue = nil

func initQueue() {
    q = new(Queue)
    q.head = 0
    q.tail = 0
}

func isQueueEmpty() bool {
    return q.head == q.tail
}

func enQueue(data int) bool {
    if q.tail == QUEUESIZE {
        fmt.Println("The queue was full and could not join.")
        return false
    }
    q.queue[q.tail] = data
    q.tail++
    return true
}

func deleteQueue() int {
    if isQueueEmpty() {
        fmt.Println("The queue was empty and could not join.")
        return -1
    }
    data := q.queue[q.head]
    q.head++
    return data
}

type Vertex struct {
    data    string
    visited bool
}

var size = 0
var vertexs [MAX_VERTEX_SIZE]Vertex
var adjacencyMatrix [MAX_VERTEX_SIZE][MAX_VERTEX_SIZE]int

func addVertex(data string) {
    vertexs[size] = Vertex{data: data, visited: false}
    size++
}

func addEdge(from int, to int) {
    adjacencyMatrix[from][to] = 1
}

func clearVisited() {
    for i := 0; i < size; i++ {
        vertexs[i].visited = false
    }
}

func breadthFirstSearch() {
    vertexs[0].visited = true
    fmt.Printf("%s", vertexs[0].data)
    enQueue(0)

    for !isQueueEmpty()
        row := deleteQueue()
        col := findAdjacencyUnVisitedVertex(row)
        for col != -1
            vertexs[col].visited = true
            fmt.Printf(" -> %s", vertexs[col].data)
            enQueue(col)
            col = findAdjacencyUnVisitedVertex(row)
        end
    end

    fmt.Println()
    clearVisited()
}

func findAdjacencyUnVisitedVertex(row int) int {
    for col := 0; col < size; col++
        if adjacencyMatrix[row][col] == 1 && !vertexs[col].visited
            return col
        end
    end
    return -1
}

func printGraph() {
    fmt.Println("Vertex and adjacency matrix:")
    for i := 0; i < size; i++
        fmt.Printf("%s ", vertexs[i].data)
    end
    fmt.Println()
    for i := 0; i < size; i++
        fmt.Printf("%s ", vertexs[i].data)
        for j := 0; j < size; j++
            fmt.Printf("%d ", adjacencyMatrix[i][j])
        end
        fmt.Println()
    end
}

func main() {
    initQueue()
    addVertex("A")
    addVertex("B")
    addVertex("C")
    addVertex("D")
    addVertex("E")

    addEdge(0, 1)
    addEdge(0, 2)
    addEdge(0, 3)
    addEdge(1, 2)
    addEdge(1, 3)
    addEdge(2, 3)
    addEdge(3, 4)

    printGraph()
    fmt.Println("\nBreadth-first search traversal output:")
    breadthFirstSearch()
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.TopologySort
    set output_file "topology_sort.go"

    set template_content 'package main

import "fmt"

const MAX_VERTEX_SIZE = 5
const STACKSIZE = 1000

type Vertex struct {
    data    string
    visited bool
}

// Stack saves current vertices
var top = -1
var stacks [STACKSIZE]int

func push(element int) {
    top++
    stacks[top] = element
}

func pop() int {
    if top == -1 {
        return -1
    }
    data := stacks[top]
    top--
    return data
}

func peek() int {
    if top == -1 {
        return -1
    }
    return stacks[top]
}

func isEmpty() bool {
    return top <= -1
}

var size = 0
var vertexs [MAX_VERTEX_SIZE]Vertex
var topologys [MAX_VERTEX_SIZE]Vertex
var adjacencyMatrix [MAX_VERTEX_SIZE][MAX_VERTEX_SIZE]int

func addVertex(data string) {
    vertexs[size] = Vertex{data: data, visited: false}
    size++
}

func addEdge(from int, to int) {
    adjacencyMatrix[from][to] = 1
}

func removeVertex(vertex int) {
    if vertex != size-1 {
        for i := vertex; i < size-1; i++ {
            vertexs[i] = vertexs[i+1]
        }
        for row := vertex; row < size-1; row++ {
            for col := 0; col < size-1; col++ {
                adjacencyMatrix[row][col] = adjacencyMatrix[row+1][col]
            }
        }
        for col := vertex; col < size-1; col++ {
            for row := 0; row < size-1; row++ {
                adjacencyMatrix[row][col] = adjacencyMatrix[row][col+1]
            }
        }
    }
    size--
}

func getNoSuccessorVertex() int {
    for row := 0; row < size; row++ {
        existSuccessor := false
        for col := 0; col < size; col++ {
            if adjacencyMatrix[row][col] == 1 {
                existSuccessor = true
                break
            }
        }
        if !existSuccessor {
            return row
        }
    }
    return -1
}

func topologySort() {
    originalSize := size
    for {
        if size <= 0 {
            break
        }
        noSuccessorVertex := getNoSuccessorVertex()
        if noSuccessorVertex == -1 {
            fmt.Println("There is a cycle in the graph")
            return
        }
        topologys[size-1] = vertexs[noSuccessorVertex]
        removeVertex(noSuccessorVertex)
    }
    size = originalSize
}

func printGraph() {
    fmt.Println("Vertex and adjacency matrix:")
    for i := 0; i < MAX_VERTEX_SIZE; i++ {
        fmt.Printf("%s ", vertexs[i].data)
    }
    fmt.Println()
    for i := 0; i < MAX_VERTEX_SIZE; i++ {
        fmt.Printf("%s ", vertexs[i].data)
        for j := 0; j < MAX_VERTEX_SIZE; j++ {
            fmt.Printf("%d ", adjacencyMatrix[i][j])
        }
        fmt.Println()
    }
}

func main() {
    addVertex("A")
    addVertex("B")
    addVertex("C")
    addVertex("D")
    addVertex("E")

    addEdge(0, 1)
    addEdge(0, 2)
    addEdge(0, 3)
    addEdge(1, 2)
    addEdge(1, 3)
    addEdge(2, 3)
    addEdge(3, 4)

    printGraph()
    fmt.Println("\nDirected Graph Topological Sorting:")
    topologySort()
    for i := 0; i < MAX_VERTEX_SIZE; i++ {
        fmt.Printf("%s -> ", topologys[i].data)
    }
    fmt.Println()
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Hanoi
    set output_file "hanoi.go"

    set template_content 'package main

import "fmt"

func hanoi(n int, A string, B string, C string) {
    if n == 1 {
        fmt.Printf("Move %d from %s to %s \n", n, A, C)
    } else {
        hanoi(n-1, A, C, B) // Move n-1 discs from A to B using C
        fmt.Printf("Move %d from %s to %s \n", n, A, C)
        hanoi(n-1, B, A, C) // Move n-1 discs from B to C using A
    }
}

func main() {
    fmt.Printf("Please enter the number of discs: \n")
    var n int
    fmt.Scanf("%d", &n)
    hanoi(n, "A", "B", "C")
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Fibonacci
    set output_file "fibonacci.go"

    set template_content 'package main

import "fmt"

// Recursive Fibonacci function
func fibonacci(n int) int {
    if n == 1 || n == 2 {
        return 1
    } else {
        return fibonacci(n-1) + fibonacci(n-2)
    }
}

func main() {
    fmt.Printf("Please enter the number of months: \n")
    var number int
    fmt.Scanf("%d", &number)

    for i := 1; i <= number; i++ {
        fmt.Printf("%d month: %d \n", i, fibonacci(i))
    }
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DutchFlagSort
    set output_file "dutch_flag_sort.go"

    set template_content 'package main

import "fmt"

func main() {
    var flags = []string{"R", "B", "W", "B", "R", "W"}
    var length = len(flags)
    var b = 0
    var w = 0
    var r = length - 1
    var count = 0

    for {
        if w > r {
            break
        }

        if flags[w] == "W" {
            w++
        } else if flags[w] == "B" {
            temp := flags[w]
            flags[w] = flags[b]
            flags[b] = temp
            w++
            b++
            count++
        } else if flags[w] == "R" {
            temp := flags[w]
            flags[w] = flags[r]
            flags[r] = temp
            r--
            count++
        }
    }

    fmt.Printf("Sorted flags: ")
    for i := 0; i < length; i++ {
        fmt.Printf("%s", flags[i])
    }
    fmt.Printf("\nThe total exchange count: %d\n", count)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MazeBacktracking
    set output_file "maze_backtracking.go"

    set template_content 'package main

import "fmt"

var maze = [7][7]int{
    {2, 2, 2, 2, 2, 2, 2},
    {2, 0, 0, 0, 0, 0, 2},
    {2, 2, 2, 0, 2, 0, 2},
    {2, 0, 2, 0, 0, 2, 2},
    {2, 2, 0, 2, 0, 2, 2},
    {2, 0, 0, 0, 0, 0, 2},
    {2, 2, 2, 2, 2, 2, 2},
}

var startI = 1
var startJ = 1
var endI = 5
var endJ = 5
var success = 0

// Recursive mouse movement: up, left, down, right
func visit(i int, j int) int {
    maze[i][j] = 1
    if i == endI && j == endJ {
        success = 1
    }
    if success != 1 && maze[i][j+1] == 0 {
        visit(i, j+1)
    }
    if success != 1 && maze[i+1][j] == 0 {
        visit(i+1, j)
    }
    if success != 1 && maze[i][j-1] == 0 {
        visit(i, j-1)
    }
    if success != 1 && maze[i-1][j] == 0 {
        visit(i-1, j)
    }
    if success != 1 {
        maze[i][j] = 0
    }
    return success
}

func main() {
    fmt.Printf("Maze: \n")
    for i := 0; i < 7; i++ {
        for j := 0; j < 7; j++ {
            if maze[i][j] == 2 {
                fmt.Printf("█ ")
            } else {
                fmt.Printf("* ")
            }
        }
        fmt.Printf("\n")
    }

    if visit(startI, startJ) == 0 {
        fmt.Printf("No exit found\n")
    } else {
        fmt.Printf("Maze Path: \n")
        for i := 0; i < 7; i++ {
            for j := 0; j < 7; j++ {
                if maze[i][j] == 2 {
                    fmt.Printf("█ ")
                } else if maze[i][j] == 1 {
                    fmt.Printf("- ")
                } else {
                    fmt.Printf("* ")
                }
            }
            fmt.Printf("\n")
        }
    }
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EightCoins
    set output_file "eight_coins.go"

    set template_content 'package main

import (
    "fmt"
    "math/rand"
)

func compare(coins []int, i int, j int, k int) {
    // coins[k] is the reference true coin
    if coins[i] > coins[k] {
        fmt.Printf("\nCounterfeit coin %d is heavier\n", i+1)
    } else {
        fmt.Printf("\nCounterfeit coin %d is lighter\n", j+1)
    }
}

func eightcoins(coins []int) {
    if coins[0]+coins[1]+coins[2] == coins[3]+coins[4]+coins[5] {
        // a+b+c == d+e+f
        if coins[6] > coins[7] {
            compare(coins, 6, 7, 0)
        } else {
            compare(coins, 7, 6, 0)
        }
    } else if coins[0]+coins[1]+coins[2] > coins[3]+coins[4]+coins[5] {
        if coins[0]+coins[3] == coins[1]+coins[4] {
            compare(coins, 2, 5, 0)
        } else if coins[0]+coins[3] > coins[1]+coins[4] {
            compare(coins, 0, 4, 1)
        } else {
            compare(coins, 1, 3, 0)
        }
    } else { // a+b+c < d+e+f
        if coins[0]+coins[3] == coins[1]+coins[4] {
            compare(coins, 5, 2, 0)
        } else if coins[0]+coins[3] > coins[1]+coins[4] {
            compare(coins, 3, 1, 0)
        } else {
            compare(coins, 4, 0, 1)
        }
    }
}

func main() {
    coins := make([]int, 8)
    for i := 0; i < 8; i++ {
        coins[i] = 10 // normal coin weight
    }

    fmt.Printf("Enter weight of counterfeit coin (different from 10): ")
    var coin int
    fmt.Scanf("%d", &coin)

    index := rand.Intn(8)
    coins[index] = coin

    eightcoins(coins)

    fmt.Printf("Coin weights: ")
    for i := 0; i < 8; i++ {
        fmt.Printf("%d, ", coins[i])
    }
    fmt.Printf("\n")
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.FruitKnapsack
    set output_file "fruit_knapsack.go"

    set template_content 'package main

import "fmt"

const MAXSIZE = 8
const MINSIZE = 1

type Fruit struct {
    name  string
    size  int
    price int
}

func main() {
    item := [MAXSIZE + 1]int{0}
    value := [MAXSIZE + 1]int{0}

    fruits := [5]Fruit{
        {"Plum", 4, 4500},
        {"Apple", 5, 5700},
        {"Orange", 2, 2250},
        {"Strawberry", 1, 1100},
        {"Melon", 6, 6700},
    }

    length := len(fruits)

    // Dynamic programming to find optimal value
    for i := 0; i < length; i++ {
        for j := fruits[i].size; j <= MAXSIZE; j++ {
            p := j - fruits[i].size
            newValue := value[p] + fruits[i].price
            if newValue > value[j] {
                value[j] = newValue
                item[j] = i
            }
        }
    }

    fmt.Printf("Item \t Price \n")
    for i := MAXSIZE; i >= MINSIZE; i -= fruits[item[i]].size {
        fmt.Printf("%s\t %d \n", fruits[item[i]].name, fruits[item[i]].price)
    }

    fmt.Printf("Total \t %d\n", value[MAXSIZE])
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Josephus
    set output_file "josephus.go"

    set template_content 'package main

import "fmt"

const N = 11
const M = 3

func main() {
    man := [N]int{0}
    count := 1
    i := 0
    pos := -1

    for {
        if count > N {
            break
        }
        for {
            pos = (pos + 1) % N // кільце
            if man[pos] == 0 {
                i++
            }
            if i == M {
                i = 0
                break
            }
        }
        man[pos] = count
        count++
    }

    fmt.Printf("\nJoseph sequence: ")
    for i := 0; i < N; i++ {
        fmt.Printf("%d, ", man[i])
    }
    fmt.Printf("\n")
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
