function algoG.ContainsDuplicate.Brute_Force
    set output_file "ContainsDuplicate.Brute_Force.go"

    set template_content "package main

import \"fmt\"

func hasDuplicate(nums []int) bool {
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if nums[i] == nums[j] {
                return true
            }
        }
    }
    return false
}

func main() {
    nums := []int{1, 2, 3, 4, 5, 3}
    fmt.Println(\"Has duplicate:\", hasDuplicate(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ContainsDuplicate.Sorting
    set output_file "ContainsDuplicate.Sort_Based.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func hasDuplicate(nums []int) bool {
    sort.Ints(nums)
    for i := 1; i < len(nums); i++ {
        if nums[i] == nums[i-1] {
            return true
        }
    }
    return false
}

func main() {
    nums := []int{1, 2, 3, 4, 5, 3}
    fmt.Println(\"Has duplicate:\", hasDuplicate(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ContainsDuplicate.Hash_Set
    set output_file "ContainsDuplicate.HashMap_Based"

    set template_content "package main

import \"fmt\"

func hasDuplicate(nums []int) bool {
    seen := make(map[int]bool)
    for _, num := range nums {
        if seen[num] {
            return true
        }
        seen[num] = true
    }
    return false
}

func main() {
    nums := []int{1, 2, 3, 4, 5, 3}
    fmt.Println(\"Has duplicate:\", hasDuplicate(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.ContainsDuplicate.Hash_Set_Length
    set output_file "ContainsDuplicate.Set_Based"

    set template_content "package main

import \"fmt\"

func hasDuplicate(nums []int) bool {
    seen := make(map[int]struct{})
    for _, num := range nums {
        seen[num] = struct{}{}
    }
    return len(seen) < len(nums)
}

func main() {
    nums := []int{1, 2, 3, 4, 5, 3}
    fmt.Println(\"Has duplicate:\", hasDuplicate(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidAnagram.Sorting
    set output_file "IsAnagram.Sort_Based"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    sRunes, tRunes := []rune(s), []rune(t)
    sort.Slice(sRunes, func(i, j int) bool {
        return sRunes[i] < sRunes[j]
    })
    sort.Slice(tRunes, func(i, j int) bool {
        return tRunes[i] < tRunes[j]
    })

    for i := range sRunes {
        if sRunes[i] != tRunes[i] {
            return false
        }
    }
    return true
}

func main() {
    s := \"listen\"
    t := \"silent\"
    fmt.Println(\"Is anagram:\", isAnagram(s, t))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidAnagram.Hash_Map
    set output_file "IsAnagram.HashMap_Based"

    set template_content "package main

import \"fmt\"

func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    countS, countT := make(map[rune]int), make(map[rune]int)
    for i, ch := range s {
        countS[ch]++
        countT[rune(t[i])]++
    }

    for k, v := range countS {
        if countT[k] != v {
            return false
        }
    }
    return true
}

func main() {
    s := \"listen\"
    t := \"silent\"
    fmt.Println(\"Is anagram:\", isAnagram(s, t))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidAnagram.Hash_Table_Using_Array
    set output_file "IsAnagram.OneArray_Based"

    set template_content "package main

import \"fmt\"

func isAnagram(s string, t string) bool {
    if len(s) != len(t) {
        return false
    }

    count := [26]int{}
    for i := 0; i < len(s); i++ {
        count[s[i]-'a']++
        count[t[i]-'a']--
    }

    for _, val := range count {
        if val != 0 {
            return false
        }
    }
    return true
}

func main() {
    s := \"listen\"
    t := \"silent\"
    fmt.Println(\"Is anagram:\", isAnagram(s, t))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoSum.Brute_Force
    set output_file "TwoSum.Brute_Force"

    set template_content "package main

import \"fmt\"

func twoSum(nums []int, target int) []int {
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if nums[i] + nums[j] == target {
                return []int{i, j}
            }
        }
    }
    return []int{}
}

func main() {
    nums := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(\"Indices:\", twoSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoSum.Sorting
    set output_file "TwoSum.Sort_Based"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func twoSum(nums []int, target int) []int {
    A := make([][2]int, len(nums))
    for i, num := range nums {
        A[i] = [2]int{num, i}
    }

    sort.Slice(A, func(i, j int) bool {
        return A[i][0] < A[j][0]
    })

    i, j := 0, len(nums)-1
    for i < j {
        cur := A[i][0] + A[j][0]
        if cur == target {
            if A[i][1] < A[j][1] {
                return []int{A[i][1], A[j][1]}
            } else {
                return []int{A[j][1], A[i][1]}
            }
        } else if cur < target {
            i++
        } else {
            j--
        }
    }
    return []int{}
}

func main() {
    nums := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(\"Indices:\", twoSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.TwoSum.TwoPass_HashMap
    set output_file "TwoSum.HashMap_Based"

    set template_content "package main

import \"fmt\"

func twoSum(nums []int, target int) []int {
    indices := make(map[int]int)

    for i, n := range nums {
        indices[n] = i
    }

    for i, n := range nums {
        diff := target - n
        if j, found := indices[diff]; found && j != i {
            return []int{i, j}
        }
    }
    return []int{}
}

func main() {
    nums := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(\"Indices:\", twoSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoSum.OnePass_HashMap
    set output_file "TwoSum.OnePass_HashMap"

    set template_content "package main

import \"fmt\"

func twoSum(nums []int, target int) []int {
    prevMap := make(map[int]int)

    for i, n := range nums {
        diff := target - n
        if j, found := prevMap[diff]; found {
            return []int{j, i}
        }
        prevMap[n] = i
    }
    return []int{}
}

func main() {
    nums := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(\"Indices:\", twoSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidPalindrome.Reverse_String
    set output_file "IsPalindrome.String_Reversal"

    set template_content "package main

import \"fmt\"

func isPalindrome(s string) bool {
    newStr := \"\"
    for _, c := range s {
        if ('a' <= c && c <= 'z') || ('0' <= c && c <= '9') {
            newStr += string(c)
        } else if 'A' <= c && c <= 'Z' {
            newStr += string(c + 'a' - 'A')
        }
    }

    reversedStr := reverse(newStr)
    return newStr == reversedStr
}

func reverse(s string) string {
    runes := []rune(s)
    n := len(runes)
    for i := 0; i < n/2; i++ {
        runes[i], runes[n-1-i] = runes[n-1-i], runes[i]
    }
    return string(runes)
}

func main() {
    s := \"A man, a plan, a canal: Panama\"
    fmt.Println(\"Is palindrome:\", isPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidPalindrome.TwoPointers
    set output_file "IsPalindrome.TwoPointers"

    set template_content "package main

import (
    \"fmt\"
    \"unicode\"
)

func isPalindrome(s string) bool {
    l, r := 0, len(s)-1

    for l < r {
        for l < r && !isAlphaNum(rune(s[l])) {
            l++
        }
        for r > l && !isAlphaNum(rune(s[r])) {
            r--
        }
        if unicode.ToLower(rune(s[l])) != unicode.ToLower(rune(s[r])) {
            return false
        }
        l++
        r--
    }
    return true
}

func isAlphaNum(c rune) bool {
    return unicode.IsLetter(c) || unicode.IsDigit(c)
}

func main() {
    s := \"A man, a plan, a canal: Panama\"
    fmt.Println(\"Is palindrome:\", isPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.ValidParentheses.Brute_Force
    set output_file "ValidParentheses.Brute_Force"

    set template_content "package main

import (
    \"fmt\"
    \"strings\"
)

func isValid(s string) bool {
    for strings.Contains(s, \"()\") || strings.Contains(s, \"{}\") || strings.Contains(s, \"[]\") {
        s = strings.ReplaceAll(s, \"()\", \"\")
        s = strings.ReplaceAll(s, \"{}\", \"\")
        s = strings.ReplaceAll(s, \"[]\", \"\")
    }
    return s == \"\"
}

func main() {
    s := \"([{}])\"
    fmt.Println(\"Is valid:\", isValid(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidParentheses.Stack
    set output_file "ValidParentheses.Stack_Based"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/stacks/linkedliststack\"
)

func isValid(s string) bool {
    stack := linkedliststack.New()
    closeToOpen := map[rune]rune{')': '(', ']': '[', '}': '{'}

    for _, c := range s {
        if open, exists := closeToOpen[c]; exists {
            if !stack.Empty() {
                top, ok := stack.Pop()
                if ok && top.(rune) != open {
                    return false
                }
            } else {
                return false
            }
        } else {
            stack.Push(c)
        }
    }

    return stack.Empty()
}

func main() {
    s := \"([{}])\"
    fmt.Println(\"Is valid:\", isValid(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Recursive_Binary_Search
    set output_file "BinarySearch.Recursive"

    set template_content "package main

import \"fmt\"

func binarySearch(l, r int, nums []int, target int) int {
    if l > r {
        return -1
    }
    m := l + (r-l)/2

    if nums[m] == target {
        return m
    }
    if nums[m] < target {
        return binarySearch(m+1, r, nums, target)
    }
    return binarySearch(l, m-1, nums, target)
}

func search(nums []int, target int) int {
    return binarySearch(0, len(nums)-1, nums, target)
}

func main() {
    nums := []int{1, 3, 5, 7, 9}
    target := 5
    fmt.Println(\"Index:\", search(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Iterative_Binary_Search
    set output_file "BinarySearch.Iterative"

    set template_content "package main

import \"fmt\"

func search(nums []int, target int) int {
    l, r := 0, len(nums)-1

    for l <= r {
        m := l + (r-l)/2

        if nums[m] > target {
            r = m - 1
        } else if nums[m] < target {
            l = m + 1
        } else {
            return m
        }
    }
    return -1
}

func main() {
    nums := []int{1, 3, 5, 7, 9}
    target := 5
    fmt.Println(\"Index:\", search(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Upper_Bound
    set output_file "BinarySearch.RightBoundary"

    set template_content "package main

import \"fmt\"

func search(nums []int, target int) int {
    l, r := 0, len(nums)

    for l < r {
        m := l + (r-l)/2
        if nums[m] > target {
            r = m
        } else {
            l = m + 1
        }
    }
    if l > 0 && nums[l-1] == target {
        return l - 1
    }
    return -1
}

func main() {
    nums := []int{1, 2, 2, 2, 3, 4, 5}
    target := 2
    fmt.Println(\"Rightmost index:\", search(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Lower_Bound
    set output_file "BinarySearch.LeftBoundary"

    set template_content "package main

import \"fmt\"

func search(nums []int, target int) int {
    l, r := 0, len(nums)

    for l < r {
        m := l + (r-l)/2
        if nums[m] >= target {
            r = m
        } else {
            l = m + 1
        }
    }
    if l < len(nums) && nums[l] == target {
        return l
    }
    return -1
}

func main() {
    nums := []int{1, 2, 2, 2, 3, 4, 5}
    target := 2
    fmt.Println(\"Leftmost index:\", search(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Built-In_Function
    set output_file "BinarySearch.GoSortSearch"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func search(nums []int, target int) int {
    index := sort.Search(len(nums), func(i int) bool { return nums[i] >= target })
    if index < len(nums) && nums[index] == target {
        return index
    }
    return -1
}

func main() {
    nums := []int{1, 2, 2, 2, 3, 4, 5}
    target := 2
    fmt.Println(\"Index:\", search(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BestTimeToBuyAndSellStock.Brute_Force
    set output_file "BestTimeToBuyAndSellStock.Brute_Force"

    set template_content "package main

import \"fmt\"

func maxProfit(prices []int) int {
    res := 0
    for i := 0; i < len(prices); i++ {
        buy := prices[i]
        for j := i + 1; j < len(prices); j++ {
            sell := prices[j]
            res = max(res, sell - buy)
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    prices := []int{7,1,5,3,6,4}
    fmt.Println(\"Max profit:\", maxProfit(prices))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BestTimeToBuyAndSellStock.Two_Pointers
    set output_file "BestTimeToBuyAndSellStock.OnePass"

    set template_content "package main

import \"fmt\"

func maxProfit(prices []int) int {
    l, r := 0, 1
    maxP := 0

    for r < len(prices) {
        if prices[l] < prices[r] {
            profit := prices[r] - prices[l]
            if profit > maxP {
                maxP = profit
            }
        } else {
            l = r
        }
        r++
    }
    return maxP
}

func main() {
    prices := []int{7,1,5,3,6,4}
    fmt.Println(\"Max profit:\", maxProfit(prices))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BestTimeToBuyAndSellStock.Dynamic_Programming
    set output_file "BestTimeToBuyAndSellStock.MinPrice"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func maxProfit(prices []int) int {
    maxP := 0
    minBuy := math.MaxInt32

    for _, sell := range prices {
        if sell - minBuy > maxP {
            maxP = sell - minBuy
        }
        if sell < minBuy {
            minBuy = sell
        }
    }
    return maxP
}

func main() {
    prices := []int{7,1,5,3,6,4}
    fmt.Println(\"Max profit:\", maxProfit(prices))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.ReverseLinkedList.Recursion
    set output_file "ReverseLinkedList.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func reverseList(head *ListNode) *ListNode {
    if head == nil {
        return nil
    }

    newHead := head
    if head.Next != nil {
        newHead = reverseList(head.Next)
        head.Next.Next = head
    }
    head.Next = nil

    return newHead
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Print(head.Val, \" \")
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := &ListNode{1, &ListNode{2, &ListNode{3, &ListNode{4, nil}}}}
    fmt.Print(\"Original list: \")
    printList(head)
    reversed := reverseList(head)
    fmt.Print(\"Reversed list: \")
    printList(reversed)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReverseLinkedList.Iteration
    set output_file "ReverseLinkedList.Iterative"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head

    for curr != nil {
        temp := curr.Next
        curr.Next = prev
        prev = curr
        curr = temp
    }
    return prev
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Print(head.Val, \" \")
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := &ListNode{1, &ListNode{2, &ListNode{3, &ListNode{4, nil}}}}
    fmt.Print(\"Original list: \")
    printList(head)
    reversed := reverseList(head)
    fmt.Print(\"Reversed list: \")
    printList(reversed)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MergeTwoSortedLists.Recursion
    set output_file "MergeTwoSortedLists.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func mergeTwoLists(list1 *ListNode, list2 *ListNode) *ListNode {
    if list1 == nil {
        return list2
    }
    if list2 == nil {
        return list1
    }
    if list1.Val <= list2.Val {
        list1.Next = mergeTwoLists(list1.Next, list2)
        return list1
    }
    list2.Next = mergeTwoLists(list1, list2.Next)
    return list2
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Print(head.Val, \" \")
        head = head.Next
    }
    fmt.Println()
}

func main() {
    list1 := &ListNode{1, &ListNode{3, &ListNode{5, nil}}}
    list2 := &ListNode{2, &ListNode{4, &ListNode{6, nil}}}
    fmt.Print(\"List1: \")
    printList(list1)
    fmt.Print(\"List2: \")
    printList(list2)
    merged := mergeTwoLists(list1, list2)
    fmt.Print(\"Merged list: \")
    printList(merged)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MergeTwoSortedLists.Iteration
    set output_file "MergeTwoSortedLists.Iterative"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func mergeTwoLists(list1 *ListNode, list2 *ListNode) *ListNode {
    dummy := &ListNode{}
    node := dummy

    for list1 != nil && list2 != nil {
        if list1.Val < list2.Val {
            node.Next = list1
            list1 = list1.Next
        } else {
            node.Next = list2
            list2 = list2.Next
        }
        node = node.Next
    }

    node.Next = list1
    if list1 == nil {
        node.Next = list2
    }

    return dummy.Next
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Print(head.Val, \" \")
        head = head.Next
    }
    fmt.Println()
}

func main() {
    list1 := &ListNode{1, &ListNode{3, &ListNode{5, nil}}}
    list2 := &ListNode{2, &ListNode{4, &ListNode{6, nil}}}
    fmt.Print(\"List1: \")
    printList(list1)
    fmt.Print(\"List2: \")
    printList(list2)
    merged := mergeTwoLists(list1, list2)
    fmt.Print(\"Merged list: \")
    printList(merged)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.LinkedListCycle.HashSet
    set output_file "LinkedListCycle.HashMap"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func hasCycle(head *ListNode) bool {
    seen := make(map[*ListNode]bool)
    cur := head
    for cur != nil {
        if seen[cur] {
            return true
        }
        seen[cur] = true
        cur = cur.Next
    }
    return false
}

func main() {
    node1 := &ListNode{1, nil}
    node2 := &ListNode{2, nil}
    node3 := &ListNode{3, nil}
    node1.Next = node2
    node2.Next = node3
    node3.Next = node1 // Creates a cycle

    fmt.Println(\"Has cycle:\", hasCycle(node1))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LinkedListCycle.FastAndSlow_Pointers
    set output_file "LinkedListCycle.TwoPointers"

    set template_content "package main

import \"fmt\"

// Definition for singly-linked list.
type ListNode struct {
    Val  int
    Next *ListNode
}

func hasCycle(head *ListNode) bool {
    slow := head
    fast := head
    for fast != nil && fast.Next != nil {
        slow = slow.Next
        fast = fast.Next.Next
        if slow == fast {
            return true
        }
    }
    return false
}

func main() {
    node1 := &ListNode{1, nil}
    node2 := &ListNode{2, nil}
    node3 := &ListNode{3, nil}
    node1.Next = node2
    node2.Next = node3
    node3.Next = node1 // Creates a cycle

    fmt.Println(\"Has cycle:\", hasCycle(node1))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InvertBinaryTree.BreadthFirstSearch
    set output_file "InvertBinaryTree.Iterative"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/queues/arrayqueue\"
)

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func invertTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }
    queue := arrayqueue.New()
    queue.Enqueue(root)

    for queue.Size() > 0 {
        node, _ := queue.Dequeue()
        current := node.(*TreeNode)
        current.Left, current.Right = current.Right, current.Left

        if current.Left != nil {
            queue.Enqueue(current.Left)
        }
        if current.Right != nil {
            queue.Enqueue(current.Right)
        }
    }
    return root
}

func printLevelOrder(root *TreeNode) {
    if root == nil {
        return
    }
    queue := arrayqueue.New()
    queue.Enqueue(root)
    for queue.Size() > 0 {
        node, _ := queue.Dequeue()
        current := node.(*TreeNode)
        fmt.Print(current.Val, \" \")
        if current.Left != nil {
            queue.Enqueue(current.Left)
        }
        if current.Right != nil {
            queue.Enqueue(current.Right)
        }
    }
    fmt.Println()
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Print(\"Original tree (level-order): \")
    printLevelOrder(root)
    inverted := invertTree(root)
    fmt.Print(\"Inverted tree (level-order): \")
    printLevelOrder(inverted)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InvertBinaryTree.DepthFirstSearch
    set output_file "InvertBinaryTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func invertTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    root.Left, root.Right = root.Right, root.Left
    invertTree(root.Left)
    invertTree(root.Right)

    return root
}

func printLevelOrder(root *TreeNode) {
    if root == nil {
        return
    }
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        fmt.Print(current.Val, \" \")
        if current.Left != nil {
            queue = append(queue, current.Left)
        }
        if current.Right != nil {
            queue = append(queue, current.Right)
        }
    }
    fmt.Println()
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Print(\"Original tree (level-order): \")
    printLevelOrder(root)
    inverted := invertTree(root)
    fmt.Print(\"Inverted tree (level-order): \")
    printLevelOrder(inverted)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InvertBinaryTree.Recursive
    set output_file "InvertBinaryTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func invertTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    root.Left, root.Right = root.Right, root.Left

    invertTree(root.Left)
    invertTree(root.Right)

    return root
}

func printLevelOrder(root *TreeNode) {
    if root == nil {
        return
    }
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        fmt.Print(current.Val, \" \")
        if current.Left != nil {
            queue = append(queue, current.Left)
        }
        if current.Right != nil {
            queue = append(queue, current.Right)
        }
    }
    fmt.Println()
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Print(\"Original tree (level-order): \")
    printLevelOrder(root)
    inverted := invertTree(root)
    fmt.Print(\"Inverted tree (level-order): \")
    printLevelOrder(inverted)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaximumDepthOfBinaryTree.RecursiveDFS
    set output_file "MaximumDepthOfBinaryTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maxDepth(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return 1 + max(maxDepth(root.Left), maxDepth(root.Right))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Maximum depth:\", maxDepth(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaximumDepthOfBinaryTree.IterativeDFS_Stack
    set output_file "MaximumDepthOfBinaryTree.Iterative"

    set template_content "package main

import (
    \"container/list\"
    \"fmt\"
)

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maxDepth(root *TreeNode) int {
    if root == nil {
        return 0
    }

    stack := list.New()
    stack.PushBack([]interface{}{root, 1})
    res := 0

    for stack.Len() > 0 {
        back := stack.Back()
        stack.Remove(back)
        pair := back.Value.([]interface{})
        node := pair[0].(*TreeNode)
        depth := pair[1].(int)

        if node != nil {
            res = max(res, depth)
            stack.PushBack([]interface{}{node.Left, depth + 1})
            stack.PushBack([]interface{}{node.Right, depth + 1})
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Maximum depth:\", maxDepth(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaximumDepthOfBinaryTree.BreadthFirstSearch
    set output_file "MaximumDepthOfBinaryTree.BFS"

    set template_content "package main

import (
    \"fmt\"
    \"your/linkedlistqueue\" // замініть на фактичний пакет реалізації черги
)

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maxDepth(root *TreeNode) int {
   if root == nil {
       return 0
   }

   q := linkedlistqueue.New()
   q.Enqueue(root)
   level := 0

   for !q.Empty() {
       size := q.Size()

       for i := 0; i < size; i++ {
           val, _ := q.Dequeue()
           node := val.(*TreeNode)

           if node.Left != nil {
               q.Enqueue(node.Left)
           }
           if node.Right != nil {
               q.Enqueue(node.Right)
           }
       }
       level++
   }

   return level
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Maximum depth:\", maxDepth(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DiameterOfBinaryTree.BruteForce
    set output_file "DiameterOfBinaryTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func diameterOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }

    leftHeight := maxHeight(root.Left)
    rightHeight := maxHeight(root.Right)
    diameter := leftHeight + rightHeight

    sub := max(diameterOfBinaryTree(root.Left),
              diameterOfBinaryTree(root.Right))

    return max(diameter, sub)
}

func maxHeight(root *TreeNode) int {
    if root == nil {
        return 0
    }

    return 1 + max(maxHeight(root.Left), maxHeight(root.Right))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Diameter of the tree:\", diameterOfBinaryTree(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DiameterOfBinaryTree.DepthFirstSearch
    set output_file "DiameterOfBinaryTree.Optimized"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func diameterOfBinaryTree(root *TreeNode) int {
    res := 0

    var dfs func(*TreeNode) int
    dfs = func(root *TreeNode) int {
        if root == nil {
            return 0
        }

        left := dfs(root.Left)
        right := dfs(root.Right)
        res = max(res, left + right)

        return 1 + max(left, right)
    }

    dfs(root)
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Diameter of the tree:\", diameterOfBinaryTree(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DiameterOfBinaryTree.IterativeDFS
    set output_file "DiameterOfBinaryTree.Iterative"

    set template_content "package main

import (
    \"fmt\"
    \"your/linkedliststack\" // замініть на фактичний пакет реалізації стеку
)

// Definition for a binary tree node.
type TreeNode struct {
   Val   int
   Left  *TreeNode
   Right *TreeNode
}

func diameterOfBinaryTree(root *TreeNode) int {
   if root == nil {
       return 0
   }

   stack := linkedliststack.New()
   stack.Push(root)
   mp := make(map[*TreeNode][]int)
   mp[nil] = []int{0, 0}

   for !stack.Empty() {
       val, _ := stack.Peek()
       node := val.(*TreeNode)

       if node.Left != nil && len(mp[node.Left]) == 0 {
           stack.Push(node.Left)
       } else if node.Right != nil && len(mp[node.Right]) == 0 {
           stack.Push(node.Right)
       } else {
           stack.Pop()

           leftHeight := mp[node.Left][0]
           leftDiameter := mp[node.Left][1]
           rightHeight := mp[node.Right][0]
           rightDiameter := mp[node.Right][1]

           height := 1 + max(leftHeight, rightHeight)
           diameter := max(leftHeight+rightHeight,
                         max(leftDiameter, rightDiameter))

           mp[node] = []int{height, diameter}
       }
   }

   return mp[root][1]
}

func max(a, b int) int {
   if a > b {
       return a
   }
   return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, &TreeNode{6, nil, nil}, &TreeNode{7, nil, nil}},
    }

    fmt.Println(\"Diameter of the tree:\", diameterOfBinaryTree(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BalancedBinaryTree.BruteForce
    set output_file "BalancedBinaryTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
    if root == nil {
        return true
    }

    left := height(root.Left)
    right := height(root.Right)
    if abs(left-right) > 1 {
        return false
    }
    return isBalanced(root.Left) && isBalanced(root.Right)
}

func height(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return 1 + max(height(root.Left), height(root.Right))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Is tree balanced:\", isBalanced(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BalancedBinaryTree.DepthFirstSearch
    set output_file "BalancedBinaryTree.Optimized"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
    return dfs(root).balanced
}

type Result struct {
    balanced bool
    height   int
}

func dfs(root *TreeNode) Result {
    if root == nil {
        return Result{true, 0}
    }

    left := dfs(root.Left)
    right := dfs(root.Right)

    balanced := left.balanced && right.balanced && abs(left.height - right.height) <= 1
    return Result{balanced, 1 + max(left.height, right.height)}
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Is tree balanced:\", isBalanced(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BalancedBinaryTree.IterativeDFS
    set output_file "BalancedBinaryTree.Iterative"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isBalanced(root *TreeNode) bool {
    stack := []*TreeNode{}
    node := root
    last := (*TreeNode)(nil)
    depths := make(map[*TreeNode]int)

    for len(stack) > 0 || node != nil {
        if node != nil {
            stack = append(stack, node)
            node = node.Left
        } else {
            node = stack[len(stack)-1]
            if node.Right == nil || last == node.Right {
                stack = stack[:len(stack)-1]
                left := depths[node.Left]
                right := depths[node.Right]

                if abs(left-right) > 1 {
                    return false
                }

                depths[node] = 1 + max(left, right)
                last = node
                node = nil
            } else {
                node = node.Right
            }
        }
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{1,
        &TreeNode{2, &TreeNode{4, nil, nil}, &TreeNode{5, nil, nil}},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Is tree balanced:\", isBalanced(root))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SameBinaryTree.DepthFirstSearch
    set output_file "SameTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isSameTree(p *TreeNode, q *TreeNode) bool {
    if p == nil && q == nil {
        return true
    }
    if p != nil && q != nil && p.Val == q.Val {
        return isSameTree(p.Left, q.Left) && isSameTree(p.Right, q.Right)
    }
    return false
}

func main() {
    tree1 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    tree2 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Are the trees same:\", isSameTree(tree1, tree2))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SameBinaryTree.IterativeDFS
    set output_file "SameTree.Iterative"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isSameTree(p *TreeNode, q *TreeNode) bool {
    type Pair struct {
        first, second *TreeNode
    }

    stack := []Pair{{p, q}}

    for len(stack) > 0 {
        lastIdx := len(stack) - 1
        node1, node2 := stack[lastIdx].first, stack[lastIdx].second
        stack = stack[:lastIdx]

        if node1 == nil && node2 == nil {
            continue
        }
        if node1 == nil || node2 == nil || node1.Val != node2.Val {
            return false
        }

        stack = append(stack, Pair{node1.Right, node2.Right})
        stack = append(stack, Pair{node1.Left, node2.Left})
    }

    return true
}

func main() {
    tree1 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    tree2 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Are the trees same:\", isSameTree(tree1, tree2))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SameBinaryTree.BreadthFirstSearch
    set output_file "SameTree.BFS"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isSameTree(p *TreeNode, q *TreeNode) bool {
    queue1 := []*TreeNode{p}
    queue2 := []*TreeNode{q}

    for len(queue1) > 0 && len(queue2) > 0 {
        for i := len(queue1); i > 0; i-- {
            nodeP := queue1[0]
            nodeQ := queue2[0]
            queue1 = queue1[1:]
            queue2 = queue2[1:]

            if nodeP == nil && nodeQ == nil {
                continue
            }
            if nodeP == nil || nodeQ == nil || nodeP.Val != nodeQ.Val {
                return false
            }

            queue1 = append(queue1, nodeP.Left, nodeP.Right)
            queue2 = append(queue2, nodeQ.Left, nodeQ.Right)
        }
    }

    return len(queue1) == 0 && len(queue2) == 0
}

func main() {
    tree1 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    tree2 := &TreeNode{1,
        &TreeNode{2, nil, nil},
        &TreeNode{3, nil, nil},
    }

    fmt.Println(\"Are the trees same:\", isSameTree(tree1, tree2))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SubtreeOfAnotherTree.DepthFirstSearch
    set output_file "SubtreeOfAnotherTree.Recursive"

    set template_content "package main

import \"fmt\"

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isSubtree(root *TreeNode, subRoot *TreeNode) bool {
    if subRoot == nil {
        return true
    }
    if root == nil {
        return false
    }

    if sameTree(root, subRoot) {
        return true
    }
    return isSubtree(root.Left, subRoot) || isSubtree(root.Right, subRoot)
}

func sameTree(root *TreeNode, subRoot *TreeNode) bool {
    if root == nil && subRoot == nil {
        return true
    }
    if root != nil && subRoot != nil && root.Val == subRoot.Val {
        return sameTree(root.Left, subRoot.Left) && sameTree(root.Right, subRoot.Right)
    }
    return false
}

func main() {
    root := &TreeNode{3,
        &TreeNode{4, &TreeNode{1, nil, nil}, &TreeNode{2, nil, nil}},
        &TreeNode{5, nil, nil},
    }

    subRoot := &TreeNode{4,
        &TreeNode{1, nil, nil},
        &TreeNode{2, nil, nil},
    }

    fmt.Println(\"Is subtree:\", isSubtree(root, subRoot))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SubtreeOfAnotherTree.SerializationAndPatternMatching
    set output_file "SubtreeOfAnotherTree.KMP"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

// Definition for a binary tree node.
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func serialize(root *TreeNode) string {
    if root == nil {
        return \"$argv\"
    }
    return \"\$\" + strconv.Itoa(root.Val) + serialize(root.Left) + serialize(root.Right)
}

func zFunction(s string) []int {
    n := len(s)
    z := make([]int, n)
    l, r := 0, 0

    for i := 1; i < n; i++ {
        if i <= r {
            z[i] = min(r-i+1, z[i-l])
        }
        for i+z[i] < n && s[z[i]] == s[i+z[i]] {
            z[i]++
        }
        if i+z[i]-1 > r {
            l = i
            r = i + z[i] - 1
        }
    }
    return z
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func isSubtree(root *TreeNode, subRoot *TreeNode) bool {
    serializedRoot := serialize(root)
    serializedSubRoot := serialize(subRoot)
    combined := serializedSubRoot + \"|\" + serializedRoot

    zValues := zFunction(combined)
    subLen := len(serializedSubRoot)

    for i := subLen + 1; i < len(combined); i++ {
        if zValues[i] == subLen {
            return true
        }
    }
    return false
}

func main() {
    root := &TreeNode{3,
        &TreeNode{4, &TreeNode{1, nil, nil}, &TreeNode{2, nil, nil}},
        &TreeNode{5, nil, nil},
    }

    subRoot := &TreeNode{4,
        &TreeNode{1, nil, nil},
        &TreeNode{2, nil, nil},
    }

    fmt.Println(\"Is subtree (KMP/Z-function):\", isSubtree(root, subRoot))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.KthLargestElementinStream.Sorting
    set output_file "KthLargest.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type KthLargest struct {
    k   int
    arr []int
}

func Constructor(k int, nums []int) KthLargest {
    return KthLargest{k: k, arr: nums}
}

func (this *KthLargest) Add(val int) int {
    this.arr = append(this.arr, val)
    sort.Ints(this.arr)
    return this.arr[len(this.arr)-this.k]
}

func main() {
    kth := Constructor(3, []int{4, 5, 8, 2})
    fmt.Println(kth.Add(3))  // returns 4
    fmt.Println(kth.Add(5))  // returns 5
    fmt.Println(kth.Add(10)) // returns 5
    fmt.Println(kth.Add(9))  // returns 8
    fmt.Println(kth.Add(4))  // returns 8
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LastStoneWeight.Min-Heap
    set output_file "KthLargest.Heap"

    set template_content "package main

import (
    \"fmt\"
    \"your/priorityqueue\" // замініть на фактичний пакет реалізації priority queue
    \"your/utils\"          // для IntComparator
)

type KthLargest struct {
    minHeap *priorityqueue.Queue
    k       int
}

func Constructor(k int, nums []int) KthLargest {
    minHeap := priorityqueue.NewWith(utils.IntComparator)
    for _, num := range nums {
        minHeap.Enqueue(num)
    }
    for minHeap.Size() > k {
        minHeap.Dequeue()
    }
    return KthLargest{minHeap: minHeap, k: k}
}

func (this *KthLargest) Add(val int) int {
    this.minHeap.Enqueue(val)
    if this.minHeap.Size() > this.k {
        this.minHeap.Dequeue()
    }
    top, _ := this.minHeap.Peek()
    return top.(int)
}

func main() {
    kth := Constructor(3, []int{4, 5, 8, 2})
    fmt.Println(kth.Add(3))  // returns 4
    fmt.Println(kth.Add(5))  // returns 5
    fmt.Println(kth.Add(10)) // returns 5
    fmt.Println(kth.Add(9))  // returns 8
    fmt.Println(kth.Add(4))  // returns 8
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthLargestElementinStream.Sorting
    set output_file "LastStoneWeight.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func lastStoneWeight(stones []int) int {
    for len(stones) > 1 {
        sort.Ints(stones)
        cur := stones[len(stones)-1] - stones[len(stones)-2]
        stones = stones[:len(stones)-2]
        if cur > 0 {
            stones = append(stones, cur)
        }
    }
    if len(stones) == 0 {
        return 0
    }
    return stones[0]
}

func main() {
    stones := []int{2,7,4,1,8,1}
    fmt.Println(\"Last stone weight:\", lastStoneWeight(stones))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LastStoneWeight.BinarySearch
    set output_file "LastStoneWeight.Insertion"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func lastStoneWeight(stones []int) int {
    sort.Ints(stones)
    n := len(stones)

    for n > 1 {
        cur := stones[n-1] - stones[n-2]
        n -= 2

        if cur > 0 {
            pos := sort.Search(n, func(i int) bool {
                return stones[i] >= cur
            })

            for i := n; i > pos; i-- {
                stones[i] = stones[i-1]
            }
            stones[pos] = cur
            n++
        }
    }

    if n > 0 {
        return stones[0]
    }
    return 0
}

func main() {
    stones := []int{2,7,4,1,8,1}
    fmt.Println(\"Last stone weight:\", lastStoneWeight(stones))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LastStoneWeight.Heap
    set output_file "LastStoneWeight.Heap"

    set template_content "package main

import (
    \"fmt\"
    \"your/priorityqueue\" // замініть на фактичний пакет реалізації priority queue
)

func lastStoneWeight(stones []int) int {
    pq := priorityqueue.NewWith(func(a, b interface{}) int {
        return a.(int) - b.(int)
    })

    for _, s := range stones {
        pq.Enqueue(-s)
    }

    for pq.Size() > 1 {
        first, _ := pq.Dequeue()
        second, _ := pq.Dequeue()
        if second.(int) > first.(int) {
            pq.Enqueue(first.(int) - second.(int))
        }
    }

    pq.Enqueue(0)
    result, _ := pq.Dequeue()
    return -result.(int)
}

func main() {
    stones := []int{2,7,4,1,8,1}
    fmt.Println(\"Last stone weight (Heap):\", lastStoneWeight(stones))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LastStoneWeight.BucketSort
    set output_file "LastStoneWeight.Bucket"

    set template_content "package main

import \"fmt\"

func lastStoneWeight(stones []int) int {
    maxStone := 0
    for _, stone := range stones {
        if stone > maxStone {
            maxStone = stone
        }
    }

    bucket := make([]int, maxStone+1)
    for _, stone := range stones {
        bucket[stone]++
    }

    first, second := maxStone, maxStone
    for first > 0 {
        if bucket[first]%2 == 0 {
            first--
            continue
        }

        j := min(first-1, second)
        for j > 0 && bucket[j] == 0 {
            j--
        }

        if j == 0 {
            return first
        }
        second = j
        bucket[first]--
        bucket[second]--
        bucket[first-second]++
        first = max(first-second, second)
    }
    return first
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    stones := []int{2,7,4,1,8,1}
    fmt.Println(\"Last stone weight (Bucket):\", lastStoneWeight(stones))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.Recursion
    set output_file "ClimbStairs.Recursive"

    set template_content "package main

import \"fmt\"

func climbStairs(n int) int {
    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= n {
            if i == n {
                return 1
            }
            return 0
        }
        return dfs(i + 1) + dfs(i + 2)
    }
    return dfs(0)
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.DynamicProgramming_Top-Down
    set output_file "ClimbStairs.Memoization"

    set template_content "package main

import \"fmt\"

func climbStairs(n int) int {
    cache := make([]int, n+1)
    for i := 0; i <= n; i++ {
        cache[i] = -1
    }

    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= n {
            if i == n {
                return 1
            }
            return 0
        }
        if cache[i] != -1 {
            return cache[i]
        }
        cache[i] = dfs(i + 1) + dfs(i + 2)
        return cache[i]
    }
    return dfs(0)
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.DynamicProgramming_Bottom-Up
    set output_file "ClimbStairs.DP"

    set template_content "package main

import \"fmt\"

func climbStairs(n int) int {
    if n <= 2 {
        return n
    }
    dp := make([]int, n+1)
    dp[1] = 1
    dp[2] = 2
    for i := 3; i <= n; i++ {
        dp[i] = dp[i-1] + dp[i-2]
    }
    return dp[n]
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.ClimbingStairs.DynamicProgramming_SpaceOptimized
    set output_file "ClimbStairs.O1"

    set template_content "package main

import \"fmt\"

func climbStairs(n int) int {
    one := 1
    two := 1

    for i := 0; i < n-1; i++ {
        temp := one
        one += two
        two = temp
    }

    return one
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.MatrixExponentiation
    set output_file "ClimbStairs.Matrix"

    set template_content "package main

import \"fmt\"

func climbStairs(n int) int {
    if n == 1 {
        return 1
    }

    M := [][]int{{1, 1}, {1, 0}}
    result := matrixPow(M, n)

    return result[0][0]
}

func matrixMult(A, B [][]int) [][]int {
    return [][]int{
        {A[0][0]*B[0][0] + A[0][1]*B[1][0],
         A[0][0]*B[0][1] + A[0][1]*B[1][1]},
        {A[1][0]*B[0][0] + A[1][1]*B[1][0],
         A[1][0]*B[0][1] + A[1][1]*B[1][1]},
    }
}

func matrixPow(M [][]int, p int) [][]int {
    result := [][]int{{1, 0}, {0, 1}}
    base := M

    for p > 0 {
        if p%2 == 1 {
            result = matrixMult(result, base)
        }
        base = matrixMult(base, base)
        p /= 2
    }

    return result
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.Math
    set output_file "ClimbStairs.Binet"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func climbStairs(n int) int {
    sqrt5 := math.Sqrt(5)
    phi := (1 + sqrt5) / 2
    psi := (1 - sqrt5) / 2
    n++
    return int(math.Round((math.Pow(phi, float64(n)) -
               math.Pow(psi, float64(n))) / sqrt5))
}

func main() {
    n := 5
    fmt.Println(\"Number of ways to climb\", n, \"stairs:\", climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinCostClimbingStairs.Recursion
    set output_file "MinCostClimbingStairs.Recursive"

    set template_content "package main

import \"fmt\"

func minCostClimbingStairs(cost []int) int {
    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= len(cost) {
            return 0
        }
        return cost[i] + min(dfs(i+1), dfs(i+2))
    }

    return min(dfs(0), dfs(1))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    cost := []int{10, 15, 20}
    fmt.Println(\"Minimum cost to climb stairs:\", minCostClimbingStairs(cost))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinCostClimbingStairs.DynamicProgramming_Top-Down
    set output_file "MinCostClimbingStairs.Memoization"

    set template_content "package main

import \"fmt\"

func minCostClimbingStairs(cost []int) int {
    memo := make([]int, len(cost))
    for i := 0; i < len(cost); i++ {
        memo[i] = -1
    }

    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= len(cost) {
            return 0
        }
        if memo[i] != -1 {
            return memo[i]
        }
        memo[i] = cost[i] + min(dfs(i+1), dfs(i+2))
        return memo[i]
    }

    return min(dfs(0), dfs(1))
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    cost := []int{10, 15, 20}
    fmt.Println(\"Minimum cost to climb stairs:\", minCostClimbingStairs(cost))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.MinCostClimbingStairs.DynamicProgramming_Bottom-Up
    set output_file "MinCostClimbingStairs.DP"

    set template_content "package main

import \"fmt\"

func minCostClimbingStairs(cost []int) int {
    n := len(cost)
    dp := make([]int, n+1)

    for i := 2; i <= n; i++ {
        dp[i] = min(dp[i-1] + cost[i-1],
                    dp[i-2] + cost[i-2])
    }

    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    cost := []int{10, 15, 20}
    fmt.Println(\"Minimum cost to climb stairs:\", minCostClimbingStairs(cost))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinCostClimbingStairs.DynamicProgramming_SpaceOptimized
    set output_file "MinCostClimbingStairs.O1"

    set template_content "package main

import \"fmt\"

func minCostClimbingStairs(cost []int) int {
    n := len(cost)
    for i := n - 3; i >= 0; i-- {
        cost[i] += min(cost[i+1], cost[i+2])
    }
    return min(cost[0], cost[1])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    cost := []int{10, 15, 20}
    fmt.Println(\"Minimum cost to climb stairs:\", minCostClimbingStairs(cost))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.CanAttendMeetings.Brute_Force
    set output_file "CanAttendMeetings.Brute_Force"

    set template_content "package main

import \"fmt\"

type Interval struct {
    start int
    end   int
}

func canAttendMeetings(intervals []Interval) bool {
    n := len(intervals)
    for i := 0; i < n; i++ {
        A := intervals[i]
        for j := i + 1; j < n; j++ {
            B := intervals[j]
            if min(A.end, B.end) > max(A.start, B.start) {
                return false
            }
        }
    }
    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := []Interval{{0, 30}, {5, 10}, {15, 20}}
    fmt.Println(\"Can attend all meetings:\", canAttendMeetings(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.CanAttendMeetings.Sorting
    set output_file "CanAttendMeetings.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type Interval struct {
    start int
    end   int
}

func canAttendMeetings(intervals []Interval) bool {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i].start < intervals[j].start
    })

    for i := 1; i < len(intervals); i++ {
        if intervals[i-1].end > intervals[i].start {
            return false
        }
    }
    return true
}

func main() {
    intervals := []Interval{{0, 30}, {5, 10}, {15, 20}}
    fmt.Println(\"Can attend all meetings:\", canAttendMeetings(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SingleNumber.Brute_Force
    set output_file "SingleNumber.Brute_Force"

    set template_content "package main

import \"fmt\"

func singleNumber(nums []int) int {
    for i := 0; i < len(nums); i++ {
        flag := true
        for j := 0; j < len(nums); j++ {
            if i != j && nums[i] == nums[j] {
                flag = false
                break
            }
        }
        if flag {
            return nums[i]
        }
    }
    return 0
}

func main() {
    nums := []int{4, 1, 2, 1, 2}
    fmt.Println(\"Single number is:\", singleNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SingleNumber.HashMap
    set output_file "SingleNumber.HashMap"

    set template_content "package main

import \"fmt\"

func singleNumber(nums []int) int {
	seen := make(map[int]bool)
	for _, num := range nums {
		if seen[num] {
			delete(seen, num)
		} else {
			seen[num] = true
		}
	}
	for num := range seen {
		return num
	}
	return -1
}

func main() {
	nums := []int{4, 1, 2, 1, 2}
	fmt.Println(\"Single number is:\", singleNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SingleNumber.Sorting
    set output_file "SingleNumber.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func singleNumber(nums []int) int {
	sort.Ints(nums)
	i := 0
	for i < len(nums)-1 {
		if nums[i] == nums[i+1] {
			i += 2
		} else {
			return nums[i]
		}
	}
	return nums[i]
}

func main() {
	nums := []int{4, 1, 2, 1, 2}
	fmt.Println(\"Single number is:\", singleNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SingleNumber.BitManipulation
    set output_file "SingleNumber.BitManipulation"

    set template_content "package main

import \"fmt\"

func singleNumber(nums []int) int {
	res := 0
	for _, num := range nums {
		res ^= num
	}
	return res
}

func main() {
	nums := []int{4, 1, 2, 1, 2}
	fmt.Println(\"Single number is:\", singleNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoG.NumberOfOneBits.BitMask-I
    set output_file "HammingWeight.Brute_Force"

    set template_content "package main

import \"fmt\"

func hammingWeight(n int) int {
	res := 0
	for i := 0; i < 32; i++ {
		if (1<<i)&n != 0 {
			res++
		}
	}
	return res
}

func main() {
	num := 11 // 1011 in binary
	fmt.Println(\"Number of 1 bits:\", hammingWeight(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberOfOneBits.BitMask-II
    set output_file "HammingWeight.BitShift"

    set template_content "package main

import \"fmt\"

func hammingWeight(n int) int {
	res := 0
	for n != 0 {
		if n&1 != 0 {
			res++
		}
		n >>= 1
	}
	return res
}

func main() {
	num := 11 // 1011 in binary
	fmt.Println(\"Number of 1 bits:\", hammingWeight(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberOfOneBits.BitMask_Optimal
    set output_file "HammingWeight.BrianKernighan"

    set template_content "package main

import \"fmt\"

func hammingWeight(n int) int {
	res := 0
	for n != 0 {
		n &= n - 1
        res++
	}
	return res
}

func main() {
	num := 11 // 1011 in binary
	fmt.Println(\"Number of 1 bits:\", hammingWeight(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberOfOneBits.Built-InFunction
    set output_file "HammingWeight.BitsPackage"

    set template_content "package main

import (
    \"fmt\"
    \"math/bits\"
)

func hammingWeight(n int) int {
	return bits.OnesCount(uint(n))
}

func main() {
	num := 11 // 1011 in binary
	fmt.Println(\"Number of 1 bits:\", hammingWeight(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CountBits.BitManipulation-I
    set output_file "CountBits.BruteForce"

    set template_content "package main

import \"fmt\"

func countBits(n int) []int {
    res := make([]int, n+1)
    for num := 0; num <= n; num++ {
        one := 0
        for i := 0; i < 32; i++ {
            if num&(1<<i) != 0 {
                one++
            }
        }
        res[num] = one
    }
    return res
}

func main() {
    n := 5
    fmt.Println(\"Count of 1 bits:\", countBits(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CountBits.BitManipulation-II
    set output_file "CountBits.BrianKernighan"

    set template_content "package main

import \"fmt\"

func countBits(n int) []int {
    res := make([]int, n+1)
    for i := 1; i <= n; i++ {
        num := i
        for num != 0 {
            res[i]++
            num &= (num - 1)
        }
    }
    return res
}

func main() {
    n := 5
    fmt.Println(\"Count of 1 bits:\", countBits(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.CountBits.In-BuiltFunction
    set output_file "CountBits.BitsPackage"

    set template_content "package main

import (
    \"fmt\"
    \"math/bits\"
)

func countBits(n int) []int {
    res := make([]int, n+1)
    for i := 0; i <= n; i++ {
        res[i] = bits.OnesCount(uint(i))
    }
    return res
}

func main() {
    n := 5
    fmt.Println(\"Count of 1 bits:\", countBits(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.CountBits.BitManipulationDP
    set output_file "CountBits.DynamicProgramming"

    set template_content "package main

import \"fmt\"

func countBits(n int) []int {
    dp := make([]int, n+1)
    offset := 1

    for i := 1; i <= n; i++ {
        if offset*2 == i {
            offset = i
        }
        dp[i] = 1 + dp[i - offset]
    }
    return dp
}

func main() {
    n := 5
    fmt.Println(\"Count of 1 bits:\", countBits(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CountBits.BitManipulationOptimal
    set output_file "CountBits.BitManipulation"

    set template_content "package main

import \"fmt\"

func countBits(n int) []int {
    dp := make([]int, n+1)
    for i := 1; i <= n; i++ {
        dp[i] = dp[i >> 1] + (i & 1)
    }
    return dp
}

func main() {
    n := 5
    fmt.Println(\"Count of 1 bits:\", countBits(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReverseBits.Brute_Force
    set output_file "ReverseBits.StringMethod"

    set template_content "package main

import \"fmt\"

func reverseBits(n uint32) uint32 {
    binary := \"\"
    for i := 0; i < 32; i++ {
        if n&(1<<i) != 0 {
            binary += \"1\"
        } else {
            binary += \"0\"
        }
    }

    var res uint32 = 0
    for i, bit := range binary {
        if bit == '1' {
            res |= (1 << (31 - i))
        }
    }
    return res
}

func main() {
    num := uint32(43261596)
    fmt.Println(\"Reversed bits:\", reverseBits(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReverseBits.BitManipulation
    set output_file "ReverseBits.BitManipulation"

    set template_content "package main

import \"fmt\"

func reverseBits(n uint32) uint32 {
    var res uint32 = 0
    for i := 0; i < 32; i++ {
        bit := (n >> i) & 1
        res |= (bit << (31 - i))
    }
    return res
}

func main() {
    num := uint32(43261596)
    fmt.Println(\"Reversed bits:\", reverseBits(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReverseBits.BitManipulation_Optimal
    set output_file "ReverseBits.Swapping"

    set template_content "package main

import \"fmt\"

func reverseBits(n uint32) uint32 {
    res := n
    res = (res >> 16) | (res << 16)
    res = ((res & 0xff00ff00) >> 8) | ((res & 0x00ff00ff) << 8)
    res = ((res & 0xf0f0f0f0) >> 4) | ((res & 0x0f0f0f0f) << 4)
    res = ((res & 0xcccccccc) >> 2) | ((res & 0x33333333) << 2)
    res = ((res & 0xaaaaaaaa) >> 1) | ((res & 0x55555555) << 1)
    return res
}

func main() {
    num := uint32(43261596)
    fmt.Println(\"Reversed bits:\", reverseBits(num))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MissingNumber.Sorting
    set output_file "MissingNumber.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func missingNumber(nums []int) int {
    n := len(nums)
    sort.Ints(nums)
    for i := 0; i < n; i++ {
        if nums[i] != i {
            return i
        }
    }
    return n
}

func main() {
    nums := []int{3, 0, 1}
    fmt.Println(\"Missing number:\", missingNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MissingNumber.HashSet
    set output_file "MissingNumber.HashSet"

    set template_content "package main

import \"fmt\"

func missingNumber(nums []int) int {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        numSet[num] = struct{}{}
    }
    n := len(nums)
    for i := 0; i <= n; i++ {
        if _, exists := numSet[i]; !exists {
            return i
        }
    }
    return -1
}

func main() {
    nums := []int{3, 0, 1}
    fmt.Println(\"Missing number:\", missingNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MissingNumber.BitwiseXOR
    set output_file "MissingNumber.XOR"

    set template_content "package main

import \"fmt\"

func missingNumber(nums []int) int {
    n := len(nums)
    xorr := n
    for i := 0; i < n; i++ {
        xorr ^= i ^ nums[i]
    }
    return xorr
}

func main() {
    nums := []int{3, 0, 1}
    fmt.Println(\"Missing number:\", missingNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MissingNumber.Math
    set output_file "MissingNumber.Summation"

    set template_content "package main

import \"fmt\"

func missingNumber(nums []int) int {
    res := len(nums)
    for i := 0; i < len(nums); i++ {
        res += i - nums[i]
    }
    return res
}

func main() {
    nums := []int{3, 0, 1}
    fmt.Println(\"Missing number:\", missingNumber(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GroupAnagrams.Sorting
    set output_file "GroupAnagrams.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func groupAnagrams(strs []string) [][]string {
    res := make(map[string][]string)

    for _, s := range strs {
        sortedS := sortString(s)
        res[sortedS] = append(res[sortedS], s)
    }

    var result [][]string
    for _, group := range res {
        result = append(result, group)
    }
    return result
}

func sortString(s string) string {
    characters := []rune(s)
    sort.Slice(characters, func(i, j int) bool {
        return characters[i] < characters[j]
    })
    return string(characters)
}

func main() {
    strs := []string{\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"}
    fmt.Println(groupAnagrams(strs))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GroupAnagrams.HashTable
    set output_file "GroupAnagramsHashtable"

    set template_content "package main

import \"fmt\"

func groupAnagrams(strs []string) [][]string {
    res := make(map[[26]int][]string)

    for _, s := range strs {
        var count [26]int
        for _, c := range s {
            count[c-'a']++
        }
        res[count] = append(res[count], s)
    }

    var result [][]string
    for _, group := range res {
        result = append(result, group)
    }
    return result
}

func main() {
    strs := []string{\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"}
    fmt.Println(groupAnagrams(strs))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TopKFrequent.Sorting
    set output_file "TopKFrequent.Sorting"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func topKFrequent(nums []int, k int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    arr := make([][2]int, 0, len(count))
    for num, cnt := range count {
        arr = append(arr, [2]int{cnt, num})
    }

    sort.Slice(arr, func(i, j int) bool {
        return arr[i][0] > arr[j][0]
    })

    res := make([]int, k)
    for i := 0; i < k; i++ {
        res[i] = arr[i][1]
    }
    return res
}

func main() {
    nums := []int{1,1,1,2,2,3}
    k := 2
    fmt.Println(topKFrequent(nums, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TopKFrequent.MinHeap
    set output_file "TopKFrequent.Heap"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

func topKFrequent(nums []int, k int) []int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    heap := priorityqueue.NewWith(func(a, b interface{}) int {
        freqA := a.([2]int)[0]
        freqB := b.([2]int)[0]
        return utils.IntComparator(freqA, freqB)
    })

    for num, freq := range count {
        heap.Enqueue([2]int{freq, num})
        if heap.Size() > k {
            heap.Dequeue()
        }
    }

    res := make([]int, k)
    for i := k - 1; i >= 0; i-- {
        value, _ := heap.Dequeue()
        res[i] = value.([2]int)[1]
    }
    return res
}

func main() {
    nums := []int{1,1,1,2,2,3}
    k := 2
    fmt.Println(topKFrequent(nums, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TopKFrequent.BucketSort
    set output_file "TopKFrequent.BucketSort"

    set template_content "package main

import (
    \"fmt\"
)

func topKFrequent(nums []int, k int) []int {
    count := make(map[int]int)
    freq := make([][]int, len(nums)+1)

    for _, num := range nums {
        count[num]++
    }
    for num, cnt := range count {
        freq[cnt] = append(freq[cnt], num)
    }

    res := []int{}
    for i := len(freq) - 1; i > 0; i-- {
        for _, num := range freq[i] {
            res = append(res, num)
            if len(res) == k {
                return res
            }
        }
    }
    return res
}

func main() {
    nums := []int{1,1,1,2,2,3}
    k := 2
    fmt.Println(topKFrequent(nums, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.EncodeandDecodeStrings.Encoding-Decoding
    set output_file "StringCodec"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
    \"strings\"
)

type Solution struct{}

func (s *Solution) Encode(strs []string) string {
    if len(strs) == 0 {
        return \"\"
    }
    var sizes []string
    for _, str := range strs {
        sizes = append(sizes, strconv.Itoa(len(str)))
    }
    return strings.Join(sizes, \",\") + \"#\" + strings.Join(strs, \"\")
}

func (s *Solution) Decode(encoded string) []string {
    if encoded == \"\" {
        return []string{}
    }
    parts := strings.SplitN(encoded, \"#\", 2)
    sizes := strings.Split(parts[0], \",\")
    var res []string
    i := 0
    for _, sz := range sizes {
        if sz == \"\" {
            continue
        }
        length, _ := strconv.Atoi(sz)
        res = append(res, parts[1][i:i+length])
        i += length
    }
    return res
}

func main() {
    s := &Solution{}
    strs := []string{\"hello\", \"world\", \"\"}
    encoded := s.Encode(strs)
    fmt.Println(\"Encoded:\", encoded)
    decoded := s.Decode(encoded)
    fmt.Println(\"Decoded:\", decoded)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.EncodeandDecodeStrings.Encoding-Decoding1
    set output_file "EncodeDecodeStrings.go"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

type Solution struct{}

func (s *Solution) Encode(strs []string) string {
    res := \"\"
    for _, str := range strs {
        res += strconv.Itoa(len(str)) + \"#\" + str
    }
    return res
}

func (s *Solution) Decode(encoded string) []string {
    res := []string{}
    i := 0
    for i < len(encoded) {
        j := i
        for encoded[j] != '#' {
            j++
        }
        length, _ := strconv.Atoi(encoded[i:j])
        i = j + 1
        res = append(res, encoded[i:i+length])
        i += length
    }
    return res
}

func main() {
    s := &Solution{}
    strs := []string{\"hello\", \"world\", \"\"}
    encoded := s.Encode(strs)
    fmt.Println(\"Encoded:\", encoded)
    decoded := s.Decode(encoded)
    fmt.Println(\"Decoded:\", decoded)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ProductsArrayExceptSelf.BruteForce
    set output_file "ProductExceptSelf"

    set template_content "package main

import (
    \"fmt\"
)

func productExceptSelf(nums []int) []int {
    n := len(nums)
    res := make([]int, n)

    for i := 0; i < n; i++ {
        prod := 1
        for j := 0; j < n; j++ {
            if i == j {
                continue
            }
            prod *= nums[j]
        }
        res[i] = prod
    }
    return res
}

func main() {
    nums := []int{1,2,3,4}
    fmt.Println(productExceptSelf(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ProductsArrayExceptSelf.Division
    set output_file "ProductExceptSelfOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func productExceptSelf(nums []int) []int {
    prod := 1
    zeroCount := 0

    for _, num := range nums {
        if num != 0 {
            prod *= num
        } else {
            zeroCount++
        }
    }

    res := make([]int, len(nums))
    if zeroCount > 1 {
        return res
    }

    for i, num := range nums {
        if zeroCount > 0 {
            if num == 0 {
                res[i] = prod
            } else {
                res[i] = 0
            }
        } else {
            res[i] = prod / num
        }
    }
    return res
}

func main() {
    nums := []int{1,2,0,4}
    fmt.Println(productExceptSelf(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ProductsArrayExceptSelf.PrefixSuffix
    set output_file "ProductExceptSelfPrefixSuffix"

    set template_content "package main

import (
    \"fmt\"
)

func productExceptSelf(nums []int) []int {
    n := len(nums)
    res := make([]int, n)
    pref := make([]int, n)
    suff := make([]int, n)

    pref[0], suff[n-1] = 1, 1
    for i := 1; i < n; i++ {
        pref[i] = nums[i-1] * pref[i-1]
    }
    for i := n - 2; i >= 0; i-- {
        suff[i] = nums[i+1] * suff[i+1]
    }
    for i := 0; i < n; i++ {
        res[i] = pref[i] * suff[i]
    }
    return res
}

func main() {
    nums := []int{1,2,3,4}
    fmt.Println(productExceptSelf(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ProductsArrayExceptSelf.PrefixSuffixOptimal
    set output_file "ProductExceptSelfOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func productExceptSelf(nums []int) []int {
    res := make([]int, len(nums))
    for i := range res {
        res[i] = 1
    }

    prefix := 1
    for i := 0; i < len(nums); i++ {
        res[i] = prefix
        prefix *= nums[i]
    }

    postfix := 1
    for i := len(nums) - 1; i >= 0; i-- {
        res[i] *= postfix
        postfix *= nums[i]
    }

    return res
}

func main() {
    nums := []int{1,2,3,4}
    fmt.Println(productExceptSelf(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidSudoku.BruteForce
    set output_file "IsValidSudoku"

    set template_content "package main

import (
    \"fmt\"
)

func isValidSudoku(board [][]byte) bool {
    for row := 0; row < 9; row++ {
        seen := make(map[byte]bool)
        for i := 0; i < 9; i++ {
            if board[row][i] == '.' {
                continue
            }
            if seen[board[row][i]] {
                return false
            }
            seen[board[row][i]] = true
        }
    }

    for col := 0; col < 9; col++ {
        seen := make(map[byte]bool)
        for i := 0; i < 9; i++ {
            if board[i][col] == '.' {
                continue
            }
            if seen[board[i][col]] {
                return false
            }
            seen[board[i][col]] = true
        }
    }

    for square := 0; square < 9; square++ {
        seen := make(map[byte]bool)
        for i := 0; i < 3; i++ {
            for j := 0; j < 3; j++ {
                row := (square / 3) * 3 + i
                col := (square % 3) * 3 + j
                if board[row][col] == '.' {
                    continue
                }
                if seen[board[row][col]] {
                    return false
                }
                seen[board[row][col]] = true
            }
        }
    }
    return true
}

func main() {
    board := [][]byte{
        {'5','3','.','.','7','.','.','.','.'},
        {'6','.','.','1','9','5','.','.','.'},
        {'.','9','8','.','.','.','.','6','.'},
        {'8','.','.','.','6','.','.','.','3'},
        {'4','.','.','8','.','3','.','.','1'},
        {'7','.','.','.','2','.','.','.','6'},
        {'.','6','.','.','.','.','2','8','.'},
        {'.','.','.','4','1','9','.','.','5'},
        {'.','.','.','.','8','.','.','7','9'},
    }
    fmt.Println(isValidSudoku(board))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidSudoku.HashSet_OnePass
    set output_file "IsValidSudokuOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func isValidSudoku(board [][]byte) bool {
    rows := make([]map[byte]bool, 9)
    cols := make([]map[byte]bool, 9)
    squares := make([]map[byte]bool, 9)

    for i := 0; i < 9; i++ {
        rows[i] = make(map[byte]bool)
        cols[i] = make(map[byte]bool)
        squares[i] = make(map[byte]bool)
    }

    for r := 0; r < 9; r++ {
        for c := 0; c < 9; c++ {
            if board[r][c] == '.' {
                continue
            }
            val := board[r][c]
            squareIdx := (r/3)*3 + c/3

            if rows[r][val] || cols[c][val] || squares[squareIdx][val] {
                return false
            }

            rows[r][val] = true
            cols[c][val] = true
            squares[squareIdx][val] = true
        }
    }

    return true
}

func main() {
    board := [][]byte{
        {'5','3','.','.','7','.','.','.','.'},
        {'6','.','.','1','9','5','.','.','.'},
        {'.','9','8','.','.','.','.','6','.'},
        {'8','.','.','.','6','.','.','.','3'},
        {'4','.','.','8','.','3','.','.','1'},
        {'7','.','.','.','2','.','.','.','6'},
        {'.','6','.','.','.','.','2','8','.'},
        {'.','.','.','4','1','9','.','.','5'},
        {'.','.','.','.','8','.','.','7','9'},
    }
    fmt.Println(isValidSudoku(board))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidSudoku.Bitmask
    set output_file "IsValidSudokuBitOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func isValidSudoku(board [][]byte) bool {
    rows := make([]int, 9)
    cols := make([]int, 9)
    squares := make([]int, 9)

    for r := 0; r < 9; r++ {
        for c := 0; c < 9; c++ {
            if board[r][c] == '.' {
                continue
            }

            val := board[r][c] - '1'
            bit := 1 << val
            squareIdx := (r/3)*3 + c/3

            if rows[r]&bit != 0 || cols[c]&bit != 0 || squares[squareIdx]&bit != 0 {
                return false
            }

            rows[r] |= bit
            cols[c] |= bit
            squares[squareIdx] |= bit
        }
    }

    return true
}

func main() {
    board := [][]byte{
        {'5','3','.','.','7','.','.','.','.'},
        {'6','.','.','1','9','5','.','.','.'},
        {'.','9','8','.','.','.','.','6','.'},
        {'8','.','.','.','6','.','.','.','3'},
        {'4','.','.','8','.','3','.','.','1'},
        {'7','.','.','.','2','.','.','.','6'},
        {'.','6','.','.','.','.','2','8','.'},
        {'.','.','.','4','1','9','.','.','5'},
        {'.','.','.','.','8','.','.','7','9'},
    }
    fmt.Println(isValidSudoku(board))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestConsecutiveSequence.BruteForce
    set output_file "LongestConsecutive"

    set template_content "package main

import (
    \"fmt\"
)

func longestConsecutive(nums []int) int {
    res := 0
    store := make(map[int]struct{})
    for _, num := range nums {
        store[num] = struct{}{}
    }

    for _, num := range nums {
        streak, curr := 0, num
        for _, ok := store[curr]; ok; _, ok = store[curr] {
            streak++
            curr++
        }
        if streak > res {
            res = streak
        }
    }
    return res
}

func main() {
    nums := []int{100, 4, 200, 1, 3, 2}
    fmt.Println(longestConsecutive(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestConsecutiveSequence.Sorting
    set output_file "LongestConsecutiveSorted"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func longestConsecutive(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    sort.Ints(nums)

    res := 0
    curr, streak := nums[0], 0
    i := 0
    for i < len(nums) {
        if curr != nums[i] {
            curr = nums[i]
            streak = 0
        }
        for i < len(nums) && nums[i] == curr {
            i++
        }
        streak++
        curr++
        if streak > res {
            res = streak
        }
    }
    return res
}

func main() {
    nums := []int{100, 4, 200, 1, 3, 2}
    fmt.Println(longestConsecutive(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestConsecutiveSequence.HashSet
    set output_file "LongestConsecutiveSet"

    set template_content "package main

import (
    \"fmt\"
)

func longestConsecutive(nums []int) int {
    numSet := make(map[int]struct{})
    for _, num := range nums {
        numSet[num] = struct{}{}
    }

    longest := 0
    for num := range numSet {
        if _, found := numSet[num-1]; !found {
            length := 1
            for {
                if _, exists := numSet[num+length]; exists {
                    length++
                } else {
                    break
                }
            }
            if length > longest {
                longest = length
            }
        }
    }
    return longest
}

func main() {
    nums := []int{100, 4, 200, 1, 3, 2}
    fmt.Println(longestConsecutive(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestConsecutiveSequence.HashMap
    set output_file "LongestConsecutiveBoundary"

    set template_content "package main

import (
    \"fmt\"
)

func longestConsecutive(nums []int) int {
    mp := make(map[int]int)
    res := 0

    for _, num := range nums {
        if mp[num] == 0 {
            left := mp[num - 1]
            right := mp[num + 1]
            sum := left + right + 1
            mp[num] = sum
            mp[num - left] = sum
            mp[num + right] = sum
            if sum > res {
                res = sum
            }
        }
    }
    return res
}

func main() {
    nums := []int{100, 4, 200, 1, 3, 2}
    fmt.Println(longestConsecutive(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoIntegerSumII.BruteForce
    set output_file "TwoSumBruteForce"

    set template_content "package main

import (
    \"fmt\"
)

func twoSum(numbers []int, target int) []int {
    for i := 0; i < len(numbers); i++ {
        for j := i + 1; j < len(numbers); j++ {
            if numbers[i]+numbers[j] == target {
                return []int{i + 1, j + 1}
            }
        }
    }
    return []int{}
}

func main() {
    numbers := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(twoSum(numbers, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoIntegerSumII.BinarySearch
    set output_file "TwoSumBinarySearch"

    set template_content "package main

import (
    \"fmt\"
)

func twoSum(numbers []int, target int) []int {
    for i := 0; i < len(numbers); i++ {
        l, r := i+1, len(numbers)-1
        tmp := target - numbers[i]
        for l <= r {
            mid := l + (r-l)/2
            if numbers[mid] == tmp {
                return []int{i + 1, mid + 1}
            } else if numbers[mid] < tmp {
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
    }
    return []int{}
}

func main() {
    numbers := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(twoSum(numbers, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoIntegerSumII.HashMap
    set output_file "TwoSumHashMap"

    set template_content "package main

import (
    \"fmt\"
)

func twoSum(numbers []int, target int) []int {
    mp := make(map[int]int)
    for i := 0; i < len(numbers); i++ {
        tmp := target - numbers[i]
        if val, exists := mp[tmp]; exists {
            return []int{val, i + 1}
        }
        mp[numbers[i]] = i + 1
    }
    return []int{}
}

func main() {
    numbers := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(twoSum(numbers, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TwoIntegerSumII.TwoPointer
    set output_file "TwoSumTwoPointer"

    set template_content "package main

import (
    \"fmt\"
)

func twoSum(numbers []int, target int) []int {
    l, r := 0, len(numbers) - 1

    for l < r {
        curSum := numbers[l] + numbers[r]
        if curSum > target {
            r--
        } else if curSum < target {
            l++
        } else {
            return []int{l + 1, r + 1}
        }
    }
    return []int{}
}

func main() {
    numbers := []int{2, 7, 11, 15}
    target := 9
    fmt.Println(twoSum(numbers, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.3Sum.BruteForce
    set output_file "ThreeSumTwoPointer"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func threeSum(nums []int) [][]int {
    sort.Ints(nums)
    res := [][]int{}

    for i := 0; i < len(nums)-2; i++ {
        if i > 0 && nums[i] == nums[i-1] {
            continue
        }
        target := -nums[i]
        l, r := i+1, len(nums)-1
        for l < r {
            sum := nums[l] + nums[r]
            if sum == target {
                res = append(res, []int{nums[i], nums[l], nums[r]})
                l++
                r--
                for l < r && nums[l] == nums[l-1] {
                    l++
                }
                for l < r && nums[r] == nums[r+1] {
                    r--
                }
            } else if sum < target {
                l++
            } else {
                r--
            }
        }
    }

    return res
}



func main() {
    nums := []int{-1,0,1,2,-1,-4}
    fmt.Println(threeSum(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.3Sum.HashMap
    set output_file "ThreeSumHashCount"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func threeSum(nums []int) [][]int {
    sort.Ints(nums)
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    var res [][]int
    for i := 0; i < len(nums); i++ {
        count[nums[i]]--
        if i > 0 && nums[i] == nums[i-1] {
            continue
        }

        for j := i + 1; j < len(nums); j++ {
            count[nums[j]]--
            if j > i+1 && nums[j] == nums[j-1] {
                continue
            }
            target := -(nums[i] + nums[j])
            if count[target] > 0 {
                res = append(res, []int{nums[i], nums[j], target})
            }
        }

        for j := i + 1; j < len(nums); j++ {
            count[nums[j]]++
        }
    }

    return res
}

func main() {
    nums := []int{-1, 0, 1, 2, -1, -4}
    fmt.Println(threeSum(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.3Sum.TwoPointers
    set output_file "ThreeSumTwoPointerOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func threeSum(nums []int) [][]int {
    res := [][]int{}
    sort.Ints(nums)

    for i := 0; i < len(nums); i++ {
        a := nums[i]
        if a > 0 {
            break
        }
        if i > 0 && a == nums[i-1] {
            continue
        }

        l, r := i+1, len(nums)-1
        for l < r {
            threeSum := a + nums[l] + nums[r]
            if threeSum > 0 {
                r--
            } else if threeSum < 0 {
                l++
            } else {
                res = append(res, []int{a, nums[l], nums[r]})
                l++
                r--
                for l < r && nums[l] == nums[l-1] {
                    l++
                }
            }
        }
    }

    return res
}

func main() {
    nums := []int{-1, 0, 1, 2, -1, -4}
    fmt.Println(threeSum(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ContainerWithMostWater.BruteForce
    set output_file "MaxAreaBruteForce"

    set template_content "package main

import (
    \"fmt\"
)

func maxArea(heights []int) int {
    res := 0
    for i := 0; i < len(heights); i++ {
        for j := i + 1; j < len(heights); j++ {
            area := min(heights[i], heights[j]) * (j - i)
            if area > res {
                res = area
            }
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    heights := []int{1,8,6,2,5,4,8,3,7}
    fmt.Println(maxArea(heights))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ContainerWithMostWater.TwoPointers
    set output_file "MaxAreaTwoPointer"

    set template_content "package main

import (
    \"fmt\"
)

func maxArea(heights []int) int {
    l, r := 0, len(heights) - 1
    res := 0

    for l < r {
        area := min(heights[l], heights[r]) * (r - l)
        if area > res {
            res = area
        }
        if heights[l] <= heights[r] {
            l++
        } else {
            r--
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    heights := []int{1,8,6,2,5,4,8,3,7}
    fmt.Println(maxArea(heights))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinimumStack.BruteForce
    set output_file "MinStackLinkedList"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/stacks/linkedliststack\"
)

type MinStack struct {
    stack *linkedliststack.Stack
}

func Constructor() MinStack {
    return MinStack{stack: linkedliststack.New()}
}

func (this *MinStack) Push(val int) {
    this.stack.Push(val)
}

func (this *MinStack) Pop() {
    this.stack.Pop()
}

func (this *MinStack) Top() int {
    top, _ := this.stack.Peek()
    return top.(int)
}

func (this *MinStack) GetMin() int {
    tmp := linkedliststack.New()
    min := this.Top()

    for !this.stack.Empty() {
        val, _ := this.stack.Pop()
        min = getMin(min, val.(int))
        tmp.Push(val)
    }

    for !tmp.Empty() {
        val, _ := tmp.Pop()
        this.stack.Push(val)
    }

    return min
}

func getMin(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    s := Constructor()
    s.Push(3)
    s.Push(5)
    s.Push(2)
    s.Push(1)
    fmt.Println(s.GetMin()) // 1
    s.Pop()
    fmt.Println(s.GetMin()) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinimumStack.TwoStacks
    set output_file "MinStackOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/stacks/linkedliststack\"
)

type MinStack struct {
    stack    *linkedliststack.Stack
    minStack *linkedliststack.Stack
}

func Constructor() MinStack {
    return MinStack{
        stack:    linkedliststack.New(),
        minStack: linkedliststack.New(),
    }
}

func (this *MinStack) Push(val int) {
    this.stack.Push(val)
    minVal := val
    if !this.minStack.Empty() {
        if top, ok := this.minStack.Peek(); ok {
            if top.(int) < val {
                minVal = top.(int)
            }
        }
    }
    this.minStack.Push(minVal)
}

func (this *MinStack) Pop() {
    this.stack.Pop()
    this.minStack.Pop()
}

func (this *MinStack) Top() int {
    top, _ := this.stack.Peek()
    return top.(int)
}

func (this *MinStack) GetMin() int {
    min, _ := this.minStack.Peek()
    return min.(int)
}

func main() {
    s := Constructor()
    s.Push(3)
    s.Push(5)
    fmt.Println(s.GetMin()) // 3
    s.Push(2)
    s.Push(1)
    fmt.Println(s.GetMin()) // 1
    s.Pop()
    fmt.Println(s.GetMin()) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MinimumStack.OneStack
    set output_file "MinStackOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

type MinStack struct {
    min   int
    stack []int
}

func Constructor() MinStack {
    return MinStack{
        min:   math.MaxInt64,
        stack: []int{},
    }
}

func (this *MinStack) Push(val int) {
    if len(this.stack) == 0 {
        this.stack = append(this.stack, 0)
        this.min = val
    } else {
        this.stack = append(this.stack, val - this.min)
        if val < this.min {
            this.min = val
        }
    }
}

func (this *MinStack) Pop() {
    if len(this.stack) == 0 {
        return
    }
    pop := this.stack[len(this.stack)-1]
    this.stack = this.stack[:len(this.stack)-1]
    if pop < 0 {
        this.min = this.min - pop
    }
}

func (this *MinStack) Top() int {
    top := this.stack[len(this.stack)-1]
    if top > 0 {
        return top + this.min
    }
    return this.min
}

func (this *MinStack) GetMin() int {
    return this.min
}

func main() {
    s := Constructor()
    s.Push(-2)
    s.Push(0)
    s.Push(-3)
    fmt.Println(s.GetMin()) // -3
    s.Pop()
    fmt.Println(s.Top())    // 0
    fmt.Println(s.GetMin()) // -2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.EvaluateReversePolishNotation.BruteForce
    set output_file "EvalRPN"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

func evalRPN(tokens []string) int {
    stack := []int{}

    for _, token := range tokens {
        switch token {
        case \"+\", \"-\", \"*\", \"/\":
            b := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            a := stack[len(stack)-1]
            stack = stack[:len(stack)-1]

            var res int
            switch token {
            case \"+\":
                res = a + b
            case \"-\":
                res = a - b
            case \"*\":
                res = a * b
            case \"/\":
                res = a / b
            }
            stack = append(stack, res)
        default:
            val, _ := strconv.Atoi(token)
            stack = append(stack, val)
        }
    }

    return stack[0]
}

func main() {
    tokens := []string{\"2\", \"1\", \"+\", \"3\", \"*\"} // (2 + 1) * 3
    fmt.Println(evalRPN(tokens)) // Output: 9

    tokens2 := []string{\"4\", \"13\", \"5\", \"/\", \"+\"} // 4 + (13 / 5)
    fmt.Println(evalRPN(tokens2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.EvaluateReversePolishNotation.DoublyLinkedList
    set output_file "EvalRPNLinkedList"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

type DoublyLinkedList struct {
    val  string
    next *DoublyLinkedList
    prev *DoublyLinkedList
}

func evalRPN(tokens []string) int {
    head := &DoublyLinkedList{val: tokens[0]}
    curr := head

    for i := 1; i < len(tokens); i++ {
        newNode := &DoublyLinkedList{val: tokens[i], prev: curr}
        curr.next = newNode
        curr = curr.next
    }

    node := head
    for node != nil {
        if node.val == \"+\" || node.val == \"-\" || node.val == \"*\" || node.val == \"/\" {
            l, _ := strconv.Atoi(node.prev.prev.val)
            r, _ := strconv.Atoi(node.prev.val)

            var res int
            switch node.val {
            case \"+\":
                res = l + r
            case \"-\":
                res = l - r
            case \"*\":
                res = l * r
            case \"/\":
                res = l / r
            }

            node.val = strconv.Itoa(res)
            node.prev = node.prev.prev.prev
            if node.prev != nil {
                node.prev.next = node
            }
        }
        node = node.next
    }

    ans, _ := strconv.Atoi(curr.val)
    return ans
}

func main() {
    tokens := []string{\"2\", \"1\", \"+\", \"3\", \"*\"} // (2 + 1) * 3
    fmt.Println(evalRPN(tokens)) // Output: 9

    tokens2 := []string{\"4\", \"13\", \"5\", \"/\", \"+\"} // 4 + (13 / 5)
    fmt.Println(evalRPN(tokens2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.EvaluateReversePolishNotation.Recursion
    set output_file "EvalRPNRecursive"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

func evalRPN(tokens []string) int {
    index := len(tokens) - 1

    var dfs func() int
    dfs = func() int {
        token := tokens[index]
        index--

        if token != \"+\" && token != \"-\" && token != \"*\" && token != \"/\" {
            val, _ := strconv.Atoi(token)
            return val
        }

        right := dfs()
        left := dfs()

        switch token {
        case \"+\":
            return left + right
        case \"-\":
            return left - right
        case \"*\":
            return left * right
        default:
            return left / right
        }
    }

    return dfs()
}

func main() {
    tokens := []string{\"2\", \"1\", \"+\", \"3\", \"*\"} // (2 + 1) * 3
    fmt.Println(evalRPN(tokens)) // Output: 9

    tokens2 := []string{\"4\", \"13\", \"5\", \"/\", \"+\"} // 4 + (13 / 5)
    fmt.Println(evalRPN(tokens2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.EvaluateReversePolishNotation.Stack
    set output_file "EvalRPNStack"

    set template_content "package main

import (
    \"fmt\"
    \"strconv\"
)

func evalRPN(tokens []string) int {
    stack := make([]int, 0)

    for _, token := range tokens {
        switch token {
        case \"+\":
            a := stack[len(stack)-1]
            b := stack[len(stack)-2]
            stack = stack[:len(stack)-2]
            stack = append(stack, b+a)
        case \"-\":
            a := stack[len(stack)-1]
            b := stack[len(stack)-2]
            stack = stack[:len(stack)-2]
            stack = append(stack, b-a)
        case \"*\":
            a := stack[len(stack)-1]
            b := stack[len(stack)-2]
            stack = stack[:len(stack)-2]
            stack = append(stack, b*a)
        case \"/\":
            a := stack[len(stack)-1]
            b := stack[len(stack)-2]
            stack = stack[:len(stack)-2]
            stack = append(stack, b/a)
        default:
            num, _ := strconv.Atoi(token)
            stack = append(stack, num)
        }
    }

    return stack[0]
}

func main() {
    tokens := []string{\"2\", \"1\", \"+\", \"3\", \"*\"} // (2 + 1) * 3
    fmt.Println(evalRPN(tokens)) // Output: 9

    tokens2 := []string{\"4\", \"13\", \"5\", \"/\", \"+\"} // 4 + (13 / 5)
    fmt.Println(evalRPN(tokens2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.DailyTemperatures.BruteForce
    set output_file "DailyTemperaturesBruteForce"

    set template_content "package main

import (
    \"fmt\"
)

func dailyTemperatures(temperatures []int) []int {
    n := len(temperatures)
    res := make([]int, 0)

    for i := 0; i < n; i++ {
        count := 1
        j := i + 1

        for j < n {
            if temperatures[j] > temperatures[i] {
                break
            }
            j++
            count++
        }

        if j == n {
            count = 0
        }

        res = append(res, count)
    }

    return res
}

func main() {
    temps := []int{73, 74, 75, 71, 69, 72, 76, 73}
    fmt.Println(dailyTemperatures(temps)) // Output: [1 1 4 2 1 1 0 0]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DailyTemperatures.Stack
    set output_file "DailyTemperaturesStack"

    set template_content "package main

import (
    \"fmt\"
)

func dailyTemperatures(temperatures []int) []int {
    res := make([]int, len(temperatures))
    stack := []int{}

    for i, t := range temperatures {
        for len(stack) > 0 && t > temperatures[stack[len(stack)-1]] {
            stackInd := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            res[stackInd] = i - stackInd
        }
        stack = append(stack, i)
    }

    return res
}

func main() {
    temps := []int{73, 74, 75, 71, 69, 72, 76, 73}
    fmt.Println(dailyTemperatures(temps)) // Output: [1 1 4 2 1 1 0 0]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DailyTemperatures.DynamicProgramming
    set output_file "DailyTemperaturesJump"

    set template_content "package main

import (
    \"fmt\"
)

func dailyTemperatures(temperatures []int) []int {
    n := len(temperatures)
    res := make([]int, n)

    for i := n - 2; i >= 0; i-- {
        j := i + 1
        for j < n && temperatures[j] <= temperatures[i] {
            if res[j] == 0 {
                j = n
                break
            }
            j += res[j]
        }

        if j < n {
            res[i] = j - i
        }
    }
    return res
}

func main() {
    temps := []int{73, 74, 75, 71, 69, 72, 76, 73}
    fmt.Println(dailyTemperatures(temps)) // Output: [1 1 4 2 1 1 0 0]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CarFleet.Stack
    set output_file "CarFleet"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func carFleet(target int, position []int, speed []int) int {
    n := len(position)
    pair := make([][2]int, n)
    for i := 0; i < n; i++ {
        pair[i] = [2]int{position[i], speed[i]}
    }

    sort.Slice(pair, func(i, j int) bool {
        return pair[i][0] > pair[j][0]
    })

    stack := []float64{}
    for _, p := range pair {
        time := float64(target - p[0]) / float64(p[1])
        stack = append(stack, time)
        if len(stack) >= 2 && stack[len(stack)-1] <= stack[len(stack)-2] {
            stack = stack[:len(stack)-1]
        }
    }

    return len(stack)
}

func main() {
    target := 12
    position := []int{10, 8, 0, 5, 3}
    speed := []int{2, 4, 1, 1, 3}
    fmt.Println(carFleet(target, position, speed)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CarFleet.Iteration
    set output_file "CarFleetOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func carFleet(target int, position []int, speed []int) int {
    n := len(position)
    pair := make([][2]int, n)
    for i := 0; i < n; i++ {
        pair[i] = [2]int{position[i], speed[i]}
    }

    sort.Slice(pair, func(i, j int) bool {
        return pair[i][0] > pair[j][0]
    })

    fleets := 1
    prevTime := float64(target - pair[0][0]) / float64(pair[0][1])
    for i := 1; i < n; i++ {
        currTime := float64(target - pair[i][0]) / float64(pair[i][1])
        if currTime > prevTime {
            fleets++
            prevTime = currTime
        }
    }

    return fleets
}

func main() {
    target := 12
    position := []int{10, 8, 0, 5, 3}
    speed := []int{2, 4, 1, 1, 3}
    fmt.Println(carFleet(target, position, speed)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Search2DMatrix.BruteForce
    set output_file "SearchMatrixBrute"

    set template_content "package main

import (
    \"fmt\"
)

func searchMatrix(matrix [][]int, target int) bool {
    for _, row := range matrix {
        for _, value := range row {
            if value == target {
                return true
            }
        }
    }
    return false
}

func main() {
    matrix := [][]int{
        {1, 3, 5, 7},
        {10, 11, 16, 20},
        {23, 30, 34, 60},
    }
    fmt.Println(searchMatrix(matrix, 3))  // Output: true
    fmt.Println(searchMatrix(matrix, 13)) // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Search2DMatrix.StaircaseSearch
    set output_file "SearchMatrixOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func searchMatrix(matrix [][]int, target int) bool {
    m, n := len(matrix), len(matrix[0])
    r, c := 0, n - 1

    for r < m && c >= 0 {
        if matrix[r][c] > target {
            c--
        } else if matrix[r][c] < target {
            r++
        } else {
            return true
        }
    }
    return false
}

func main() {
    matrix := [][]int{
        {1, 4, 7, 11, 15},
        {2, 5, 8, 12, 19},
        {3, 6, 9, 16, 22},
        {10, 13, 14, 17, 24},
        {18, 21, 23, 26, 30},
    }
    fmt.Println(searchMatrix(matrix, 5))   // Output: true
    fmt.Println(searchMatrix(matrix, 20))  // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Search2DMatrix.BinarySearch
    set output_file "SearchMatrixBinary"

    set template_content "package main

import (
    \"fmt\"
)

func searchMatrix(matrix [][]int, target int) bool {
    rows, cols := len(matrix), len(matrix[0])
    top, bot := 0, rows - 1

    for top <= bot {
        row := (top + bot) / 2
        if target > matrix[row][cols-1] {
            top = row + 1
        } else if target < matrix[row][0] {
            bot = row - 1
        } else {
            break
        }
    }

    if !(top <= bot) {
        return false
    }
    row := (top + bot) / 2
    l, r := 0, cols - 1
    for l <= r {
        m := (l + r) / 2
        if target > matrix[row][m] {
            l = m + 1
        } else if target < matrix[row][m] {
            r = m - 1
        } else {
            return true
        }
    }
    return false
}

func main() {
    matrix := [][]int{
        {1, 3, 5, 7},
        {10, 11, 16, 20},
        {23, 30, 34, 60},
    }
    fmt.Println(searchMatrix(matrix, 3))   // Output: true
    fmt.Println(searchMatrix(matrix, 13))  // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Search2DMatrix.BinarySearch_OnePass
    set output_file "SearchMatrixFlattened"

    set template_content "package main

import (
    \"fmt\"
)

func searchMatrix(matrix [][]int, target int) bool {
    rows, cols := len(matrix), len(matrix[0])
    l, r := 0, rows*cols-1

    for l <= r {
        m := l + (r-l)/2
        row, col := m / cols, m % cols
        if matrix[row][col] == target {
            return true
        } else if matrix[row][col] < target {
            l = m + 1
        } else {
            r = m - 1
        }
    }
    return false
}

func main() {
    matrix := [][]int{
        {1, 3, 5, 7},
        {10, 11, 16, 20},
        {23, 30, 34, 60},
    }
    fmt.Println(searchMatrix(matrix, 3))  // true
    fmt.Println(searchMatrix(matrix, 13)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KokoEatingBananas.BruteForce
    set output_file "MinEatingSpeedBrute"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func minEatingSpeed(piles []int, h int) int {
    speed := 1
    for {
        totalTime := 0
        for _, pile := range piles {
            totalTime += int(math.Ceil(float64(pile) / float64(speed)))
        }

        if totalTime <= h {
            return speed
        }
        speed += 1
    }
    return speed
}

func main() {
    piles := []int{3, 6, 7, 11}
    h := 8
    fmt.Println(minEatingSpeed(piles, h)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KokoEatingBananas.BinarySearch
    set output_file "MinEatingSpeedBinarySearch"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func minEatingSpeed(piles []int, h int) int {
    l, r := 1, 0
    for _, p := range piles {
        if p > r {
            r = p
        }
    }
    res := r

    for l <= r {
        k := (l + r) / 2
        totalTime := 0

        for _, p := range piles {
            totalTime += int(math.Ceil(float64(p) / float64(k)))
        }

        if totalTime <= h {
            res = k
            r = k - 1
        } else {
            l = k + 1
        }
    }
    return res
}

func main() {
    piles := []int{3, 6, 7, 11}
    h := 8
    fmt.Println(minEatingSpeed(piles, h)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindMinimumRotatedSortedArray.BruteForce
    set output_file "FindMinLinear"

    set template_content "package main

import (
    \"fmt\"
)

func findMin(nums []int) int {
    minVal := nums[0]
    for _, num := range nums {
        if num < minVal {
            minVal = num
        }
    }
    return minVal
}

func main() {
    nums := []int{3, 4, 5, 1, 2}
    fmt.Println(findMin(nums)) // Output: 1
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindMinimumRotatedSortedArray.BinarySearch
    set output_file "FindMinBinarySearch"

    set template_content "package main

import (
    \"fmt\"
)

func findMin(nums []int) int {
    res := nums[0]
    l, r := 0, len(nums)-1

    for l <= r {
        if nums[l] < nums[r] {
            if nums[l] < res {
                res = nums[l]
            }
            break
        }

        m := l + (r-l)/2
        if nums[m] < res {
            res = nums[m]
        }

        if nums[m] >= nums[l] {
            l = m + 1
        } else {
            r = m - 1
        }
    }
    return res
}

func main() {
    nums := []int{3, 4, 5, 1, 2}
    fmt.Println(findMin(nums)) // Output: 1

    nums2 := []int{4,5,6,7,0,1,2}
    fmt.Println(findMin(nums2)) // Output: 0
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindMinimumRotatedSortedArray.BinarySearch_LowerBound
    set output_file "FindMinBinarySearchSimple"

    set template_content "package main

import (
    \"fmt\"
)

func findMin(nums []int) int {
    l, r := 0, len(nums)-1
    for l < r {
        m := l + (r-l)/2
        if nums[m] < nums[r] {
            r = m
        } else {
            l = m + 1
        }
    }
    return nums[l]
}

func main() {
    nums := []int{3, 4, 5, 1, 2}
    fmt.Println(findMin(nums)) // Output: 1

    nums2 := []int{4,5,6,7,0,1,2}
    fmt.Println(findMin(nums2)) // Output: 0
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.SearchRotatedSortedArray.BruteForce
    set output_file "SearchLinear"

    set template_content "package main

import (
    \"fmt\"
)

func search(nums []int, target int) int {
    for i := 0; i < len(nums); i++ {
        if nums[i] == target {
            return i
        }
    }
    return -1
}

func main() {
    nums := []int{4, 5, 6, 7, 0, 1, 2}
    target := 0
    fmt.Println(search(nums, target)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SearchRotatedSortedArray.BinarySearch
    set output_file "SearchRotatedBinary"

    set template_content "package main

import (
    \"fmt\"
)

func search(nums []int, target int) int {
    l, r := 0, len(nums)-1

    for l < r {
        m := (l + r) / 2
        if nums[m] > nums[r] {
            l = m + 1
        } else {
            r = m
        }
    }

    pivot := l

    var binarySearch func(left, right int) int
    binarySearch = func(left, right int) int {
        for left <= right {
            mid := (left + right) / 2
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return -1
    }

    result := binarySearch(0, pivot-1)
    if result != -1 {
        return result
    }

    return binarySearch(pivot, len(nums)-1)
}

func main() {
    nums := []int{4,5,6,7,0,1,2}
    target := 0
    fmt.Println(search(nums, target)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SearchRotatedSortedArray.BinarySearch_TwoPass
    set output_file "SearchRotatedBinaryOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func search(nums []int, target int) int {
    l, r := 0, len(nums)-1

    // Find pivot
    for l < r {
        m := (l + r) / 2
        if nums[m] > nums[r] {
            l = m + 1
        } else {
            r = m
        }
    }

    pivot := l
    l, r = 0, len(nums)-1

    // Determine which subarray to search
    if target >= nums[pivot] && target <= nums[r] {
        l = pivot
    } else {
        r = pivot - 1
    }

    // Standard binary search
    for l <= r {
        m := (l + r) / 2
        if nums[m] == target {
            return m
        } else if nums[m] < target {
            l = m + 1
        } else {
            r = m - 1
        }
    }

    return -1
}

func main() {
    nums := []int{4,5,6,7,0,1,2}
    target := 0
    fmt.Println(search(nums, target)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SearchRotatedSortedArray.BinarySearch_OnePass
 
    set output_file "SearchRotatedBinarySinglePass"

    set template_content "package main

import (
    \"fmt\"
)

func search(nums []int, target int) int {
    l, r := 0, len(nums)-1

    for l <= r {
        mid := (l + r) / 2
        if target == nums[mid] {
            return mid
        }

        if nums[l] <= nums[mid] {
            if target > nums[mid] || target < nums[l] {
                l = mid + 1
            } else {
                r = mid - 1
            }
        } else {
            if target < nums[mid] || target > nums[r] {
                r = mid - 1
            } else {
                l = mid + 1
            }
        }
    }
    return -1
}

func main() {
    nums := []int{4,5,6,7,0,1,2}
    target := 0
    fmt.Println(search(nums, target)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TimeBasedKey-ValueStore.BruteForce
    set output_file "TimeMap"

    set template_content "package main

import (
    \"fmt\"
)

type TimeMap struct {
    keyStore map[string]map[int][]string
}

func Constructor() TimeMap {
    return TimeMap{
        keyStore: make(map[string]map[int][]string),
    }
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    if _, exists := this.keyStore[key]; !exists {
        this.keyStore[key] = make(map[int][]string)
    }
    this.keyStore[key][timestamp] = append(this.keyStore[key][timestamp], value)
}

func (this *TimeMap) Get(key string, timestamp int) string {
    if _, exists := this.keyStore[key]; !exists {
        return \"\"
    }

    seen := 0
    for time := range this.keyStore[key] {
        if time <= timestamp {
            seen = max(seen, time)
        }
    }

    if seen == 0 {
        return \"\"
    }
    values := this.keyStore[key][seen]
    return values[len(values)-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    tm := Constructor()
    tm.Set(\"foo\", \"bar\", 1)
    fmt.Println(tm.Get(\"foo\", 1)) // Output: bar
    fmt.Println(tm.Get(\"foo\", 3)) // Output: bar
    tm.Set(\"foo\", \"bar2\", 4)
    fmt.Println(tm.Get(\"foo\", 4)) // Output: bar2
    fmt.Println(tm.Get(\"foo\", 5)) // Output: bar2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TimeBasedKey-ValueStore.BinarySearch_SortedMap
    set output_file "TimeMapOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type pair struct {
    timestamp int
    value     string
}

type TimeMap struct {
    m map[string][]pair
}

func Constructor() TimeMap {
    return TimeMap{
        m: make(map[string][]pair),
    }
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    this.m[key] = append(this.m[key], pair{timestamp, value})
}

func (this *TimeMap) Get(key string, timestamp int) string {
    if _, exists := this.m[key]; !exists {
        return \"\"
    }

    pairs := this.m[key]
    idx := sort.Search(len(pairs), func(i int) bool {
        return pairs[i].timestamp > timestamp
    })

    if idx == 0 {
        return \"\"
    }
    return pairs[idx-1].value
}

func main() {
    tm := Constructor()
    tm.Set(\"foo\", \"bar\", 1)
    fmt.Println(tm.Get(\"foo\", 1)) // Output: bar
    fmt.Println(tm.Get(\"foo\", 3)) // Output: bar
    tm.Set(\"foo\", \"bar2\", 4)
    fmt.Println(tm.Get(\"foo\", 4)) // Output: bar2
    fmt.Println(tm.Get(\"foo\", 5)) // Output: bar2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.TimeBasedKey-ValueStore.BinarySearch_Array
    set output_file "TimeMapOptimized"

    set template_content "package main

import (
    \"fmt\"
)

type TimeMap struct {
    m map[string][]pair
}

type pair struct {
    timestamp int
    value     string
}

func Constructor() TimeMap {
    return TimeMap{
        m: make(map[string][]pair),
    }
}

func (this *TimeMap) Set(key string, value string, timestamp int) {
    this.m[key] = append(this.m[key], pair{timestamp, value})
}

func (this *TimeMap) Get(key string, timestamp int) string {
    if _, exists := this.m[key]; !exists {
        return \"\"
    }

    pairs := this.m[key]
    l, r := 0, len(pairs)-1

    for l <= r {
        mid := (l + r) / 2
        if pairs[mid].timestamp <= timestamp {
            if mid == len(pairs)-1 || pairs[mid+1].timestamp > timestamp {
                return pairs[mid].value
            }
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    return \"\"
}

func main() {
    tm := Constructor()
    tm.Set(\"foo\", \"bar\", 1)
    fmt.Println(tm.Get(\"foo\", 1)) // Output: bar
    fmt.Println(tm.Get(\"foo\", 3)) // Output: bar
    tm.Set(\"foo\", \"bar2\", 4)
    fmt.Println(tm.Get(\"foo\", 4)) // Output: bar2
    fmt.Println(tm.Get(\"foo\", 5)) // Output: bar2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestSubstringWithoutRepeatingCharacters.BruteForce
    set output_file "LengthOfLongestSubstring"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLongestSubstring(s string) int {
    res := 0

    for i := 0; i < len(s); i++ {
        charSet := make(map[byte]bool)
        for j := i; j < len(s); j++ {
            if charSet[s[j]] {
                break
            }
            charSet[s[j]] = true
        }
        if len(charSet) > res {
            res = len(charSet)
        }
    }
    return res
}

func main() {
    s := \"abcabcbb\"
    fmt.Println(lengthOfLongestSubstring(s)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestSubstringWithoutRepeatingCharacters.SlidingWindow
    set output_file "LengthOfLongestSubstringOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLongestSubstring(s string) int {
    charSet := make(map[byte]bool)
    l, res := 0, 0

    for r := 0; r < len(s); r++ {
        for charSet[s[r]] {
            delete(charSet, s[l])
            l++
        }
        charSet[s[r]] = true
        if r - l + 1 > res {
            res = r - l + 1
        }
    }
    return res
}

func main() {
    s := \"abcabcbb\"
    fmt.Println(lengthOfLongestSubstring(s)) // Output: 3

    s2 := \"bbbbb\"
    fmt.Println(lengthOfLongestSubstring(s2)) // Output: 1

    s3 := \"pwwkew\"
    fmt.Println(lengthOfLongestSubstring(s3)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestSubstringWithoutRepeatingCharacters.SlidingWindow_Optimal
    set output_file "LengthOfLongestSubstringMap"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLongestSubstring(s string) int {
    mp := make(map[byte]int)
    l, res := 0, 0

    for r := 0; r < len(s); r++ {
        if idx, found := mp[s[r]]; found {
            l = max(idx+1, l)
        }
        mp[s[r]] = r
        if r - l + 1 > res {
            res = r - l + 1
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    s := \"abcabcbb\"
    fmt.Println(lengthOfLongestSubstring(s)) // Output: 3

    s2 := \"bbbbb\"
    fmt.Println(lengthOfLongestSubstring(s2)) // Output: 1

    s3 := \"pwwkew\"
    fmt.Println(lengthOfLongestSubstring(s3)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestRepeatingCharacterReplacement.BruteForce
    set output_file "CharacterReplacementBruteForce"

    set template_content "package main

import (
    \"fmt\"
)

func characterReplacement(s string, k int) int {
    res := 0
    for i := 0; i < len(s); i++ {
        count := make(map[byte]int)
        maxf := 0
        for j := i; j < len(s); j++ {
            count[s[j]]++
            maxf = max(maxf, count[s[j]])
            if (j - i + 1) - maxf <= k {
                res = max(res, j - i + 1)
            }
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    s := \"ABAB\"
    k := 2
    fmt.Println(characterReplacement(s, k)) // Output: 4

    s2 := \"AABABBA\"
    k2 := 1
    fmt.Println(characterReplacement(s2, k2)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LongestRepeatingCharacterReplacement.SlidingWindow
    set output_file "CharacterReplacementSlidingWindow"

    set template_content "package main

import (
    \"fmt\"
)

func characterReplacement(s string, k int) int {
    res := 0
    charSet := make(map[byte]bool)

    for i := 0; i < len(s); i++ {
        charSet[s[i]] = true
    }

    for c := range charSet {
        count, l := 0, 0
        for r := 0; r < len(s); r++ {
            if s[r] == c {
                count++
            }

            for (r - l + 1) - count > k {
                if s[l] == c {
                    count--
                }
                l++
            }

            res = max(res, r - l + 1)
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    s := \"ABAB\"
    k := 2
    fmt.Println(characterReplacement(s, k)) // Output: 4

    s2 := \"AABABBA\"
    k2 := 1
    fmt.Println(characterReplacement(s2, k2)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.LongestRepeatingCharacterReplacement.SlidingWindow_Optimal
    set output_file "CharacterReplacementOptimized"

    set template_content "package main

import (
    \"fmt\"
)

func characterReplacement(s string, k int) int {
    count := make(map[byte]int)
    res, l, maxf := 0, 0, 0

    for r := 0; r < len(s); r++ {
        count[s[r]]++
        if count[s[r]] > maxf {
            maxf = count[s[r]]
        }

        for (r - l + 1) - maxf > k {
            count[s[l]]--
            l++
        }

        if r - l + 1 > res {
            res = r - l + 1
        }
    }

    return res
}

func main() {
    s := \"ABAB\"
    k := 2
    fmt.Println(characterReplacement(s, k)) // Output: 4

    s2 := \"AABABBA\"
    k2 := 1
    fmt.Println(characterReplacement(s2, k2)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PermutationinString.BruteForce
    set output_file "CheckInclusion"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func checkInclusion(s1 string, s2 string) bool {
    s1Sorted := []rune(s1)
    sort.Slice(s1Sorted, func(i, j int) bool {
        return s1Sorted[i] < s1Sorted[j]
    })
    s1 = string(s1Sorted)

    for i := 0; i < len(s2); i++ {
        for j := i; j < len(s2); j++ {
            subStr := s2[i : j+1]
            subStrSorted := []rune(subStr)
            sort.Slice(subStrSorted, func(a, b int) bool {
                return subStrSorted[a] < subStrSorted[b]
            })
            if string(subStrSorted) == s1 {
                return true
            }
        }
    }
    return false
}

func main() {
    s1 := \"ab\"
    s2 := \"eidbaooo\"
    fmt.Println(checkInclusion(s1, s2)) // Output: true

    s1_2 := \"ab\"
    s2_2 := \"eidboaoo\"
    fmt.Println(checkInclusion(s1_2, s2_2)) // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PermutationinString.HashTable
    set output_file "CheckInclusionMap"

    set template_content "package main

import (
    \"fmt\"
)

func checkInclusion(s1 string, s2 string) bool {
    count1 := make(map[rune]int)
    for _, c := range s1 {
        count1[c]++
    }

    need := len(count1)
    for i := 0; i < len(s2); i++ {
        count2 := make(map[rune]int)
        cur := 0
        for j := i; j < len(s2); j++ {
            count2[rune(s2[j])]++
            if count1[rune(s2[j])] < count2[rune(s2[j])] {
                break
            }
            if count1[rune(s2[j])] == count2[rune(s2[j])] {
                cur++
            }
            if cur == need {
                return true
            }
        }
    }
    return false
}

func main() {
    s1 := \"ab\"
    s2 := \"eidbaooo\"
    fmt.Println(checkInclusion(s1, s2)) // Output: true

    s1_2 := \"ab\"
    s2_2 := \"eidboaoo\"
    fmt.Println(checkInclusion(s1_2, s2_2)) // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PermutationinString.SlidingWindow
    set output_file "CheckInclusionSlidingWindow"

    set template_content "package main

import (
    \"fmt\"
)

func checkInclusion(s1 string, s2 string) bool {
    if len(s1) > len(s2) {
        return false
    }

    s1Count := make([]int, 26)
    s2Count := make([]int, 26)
    for i := 0; i < len(s1); i++ {
        s1Count[s1[i]-'a']++
        s2Count[s2[i]-'a']++
    }

    matches := 0
    for i := 0; i < 26; i++ {
        if s1Count[i] == s2Count[i] {
            matches++
        }
    }

    l := 0
    for r := len(s1); r < len(s2); r++ {
        if matches == 26 {
            return true
        }

        index := s2[r] - 'a'
        s2Count[index]++
        if s1Count[index] == s2Count[index] {
            matches++
        } else if s1Count[index]+1 == s2Count[index] {
            matches--
        }

        index = s2[l] - 'a'
        s2Count[index]--
        if s1Count[index] == s2Count[index] {
            matches++
        } else if s1Count[index]-1 == s2Count[index] {
            matches--
        }
        l++
    }
    return matches == 26
}

func main() {
    s1 := \"ab\"
    s2 := \"eidbaooo\"
    fmt.Println(checkInclusion(s1, s2)) // Output: true

    s1_2 := \"ab\"
    s2_2 := \"eidboaoo\"
    fmt.Println(checkInclusion(s1_2, s2_2)) // Output: false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReorderLinkedList.BruteForce
    set output_file "ReorderList"

    set template_content "package main

import (
    \"fmt\"
)

type ListNode struct {
    Val  int
    Next *ListNode
}

func reorderList(head *ListNode) {
    if head == nil {
        return
    }

    nodes := []*ListNode{}
    cur := head
    for cur != nil {
        nodes = append(nodes, cur)
        cur = cur.Next
    }

    i, j := 0, len(nodes)-1
    for i < j {
        nodes[i].Next = nodes[j]
        i++
        if i >= j {
            break
        }
        nodes[j].Next = nodes[i]
        j--
    }

    nodes[i].Next = nil
}

func main() {
    // helper to build and print list
    build := func(vals []int) *ListNode {
        if len(vals) == 0 {
            return nil
        }
        head := &ListNode{Val: vals[0]}
        curr := head
        for _, v := range vals[1:] {
            curr.Next = &ListNode{Val: v}
            curr = curr.Next
        }
        return head
    }

    printList := func(head *ListNode) {
        for head != nil {
            fmt.Printf(\"%d \", head.Val)
            head = head.Next
        }
        fmt.Println()
    }

    head := build([]int{1, 2, 3, 4, 5})
    reorderList(head)
    printList(head) // Output: 1 5 2 4 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReorderLinkedList.Recursion
    set output_file "ReorderListRecursive"

    set template_content "package main

import (
    \"fmt\"
)

type ListNode struct {
    Val  int
    Next *ListNode
}

/**
 * Definition for singly-linked list.
 */
func reorderList(head *ListNode) {
    if head == nil {
        return
    }

    var rec func(root, cur *ListNode) *ListNode
    rec = func(root, cur *ListNode) *ListNode {
        if cur == nil {
            return root
        }

        root = rec(root, cur.Next)
        if root == nil {
            return nil
        }

        var tmp *ListNode
        if root == cur || root.Next == cur {
            cur.Next = nil
            return nil
        } else {
            tmp = root.Next
            root.Next = cur
            cur.Next = tmp
        }

        return tmp
    }

    rec(head, head.Next)
}

func main() {
    // helper to build and print list
    build := func(vals []int) *ListNode {
        if len(vals) == 0 {
            return nil
        }
        head := &ListNode{Val: vals[0]}
        curr := head
        for _, v := range vals[1:] {
            curr.Next = &ListNode{Val: v}
            curr = curr.Next
        }
        return head
    }

    printList := func(head *ListNode) {
        for head != nil {
            fmt.Printf(\"%d \", head.Val)
            head = head.Next
        }
        fmt.Println()
    }

    head := build([]int{1, 2, 3, 4, 5})
    reorderList(head)
    printList(head) // Output: 1 5 2 4 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ReorderLinkedList.ReverseAndMerge
    set output_file "ReorderListIterative"

    set template_content "package main

import (
    \"fmt\"
)

type ListNode struct {
    Val  int
    Next *ListNode
}

/**
 * Definition for singly-linked list.
 */
func reorderList(head *ListNode) {
    if head == nil || head.Next == nil {
        return
    }

    // Find the middle (slow-fast pointers)
    slow, fast := head, head.Next
    for fast != nil && fast.Next != nil {
        slow = slow.Next
        fast = fast.Next.Next
    }

    // Reverse the second half
    second := slow.Next
    slow.Next = nil
    var prev *ListNode
    for second != nil {
        tmp := second.Next
        second.Next = prev
        prev = second
        second = tmp
    }

    // Merge two halves
    first := head
    second = prev
    for second != nil {
        tmp1, tmp2 := first.Next, second.Next
        first.Next = second
        second.Next = tmp1
        first, second = tmp1, tmp2
    }
}

func buildList(vals []int) *ListNode {
    if len(vals) == 0 {
        return nil
    }
    head := &ListNode{Val: vals[0]}
    curr := head
    for _, v := range vals[1:] {
        curr.Next = &ListNode{Val: v}
        curr = curr.Next
    }
    return head
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Printf(\"%d \", head.Val)
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := buildList([]int{1, 2, 3, 4, 5})
    reorderList(head)
    printList(head) // Output: 1 5 2 4 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RemoveNodeFromEndLinkedList.BruteForce
    set output_file "RemoveNthFromEndArray"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
    nodes := []*ListNode{}
    cur := head
    for cur != nil {
        nodes = append(nodes, cur)
        cur = cur.Next
    }

    removeIndex := len(nodes) - n
    if removeIndex == 0 {
        return head.Next
    }

    nodes[removeIndex-1].Next = nodes[removeIndex].Next
    return head
}

// helpers for testing
func buildList(vals []int) *ListNode {
    if len(vals) == 0 {
        return nil
    }
    head := &ListNode{Val: vals[0]}
    curr := head
    for _, v := range vals[1:] {
        curr.Next = &ListNode{Val: v}
        curr = curr.Next
    }
    return head
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Printf(\"%d \", head.Val)
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := buildList([]int{1, 2, 3, 4, 5})
    head = removeNthFromEnd(head, 2)
    printList(head) // Output: 1 2 3 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RemoveNodeFromEndLinkedList.Iteration_TwoPass
    set output_file "RemoveNthFromEndLength"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
    N := 0
    cur := head
    for cur != nil {
        N++
        cur = cur.Next
    }

    removeIndex := N - n
    if removeIndex == 0 {
        return head.Next
    }

    cur = head
    for i := 0; i < N-1; i++ {
        if (i + 1) == removeIndex {
            cur.Next = cur.Next.Next
            break
        }
        cur = cur.Next
    }
    return head
}

// helpers for testing
func buildList(vals []int) *ListNode {
    if len(vals) == 0 {
        return nil
    }
    head := &ListNode{Val: vals[0]}
    curr := head
    for _, v := range vals[1:] {
        curr.Next = &ListNode{Val: v}
        curr = curr.Next
    }
    return head
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Printf(\"%d \", head.Val)
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := buildList([]int{1, 2, 3, 4, 5})
    head = removeNthFromEnd(head, 2)
    printList(head) // Output: 1 2 3 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RemoveNodeFromEndLinkedList.Recursion
    set output_file "RemoveNthFromEndRecursive"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func rec(head *ListNode, n *int) *ListNode {
    if head == nil {
        return nil
    }

    head.Next = rec(head.Next, n)
    (*n)-- // зменшуємо лічильник після повернення з глибини

    if *n == 0 {
        return head.Next // коли n == 0 — пропускаємо цей вузол
    }
    return head
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
    return rec(head, &n)
}

// helpers for testing
func buildList(vals []int) *ListNode {
    if len(vals) == 0 {
        return nil
    }
    head := &ListNode{Val: vals[0]}
    curr := head
    for _, v := range vals[1:] {
        curr.Next = &ListNode{Val: v}
        curr = curr.Next
    }
    return head
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Printf(\"%d \", head.Val)
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := buildList([]int{1, 2, 3, 4, 5})
    head = removeNthFromEnd(head, 2)
    printList(head) // Output: 1 2 3 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RemoveNodeFromEndLinkedList.TwoPointers
    set output_file "RemoveNthFromEndTwoPointer"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func removeNthFromEnd(head *ListNode, n int) *ListNode {
    dummy := &ListNode{Next: head}
    left := dummy
    right := head

    for n > 0 {
        right = right.Next
        n--
    }

    for right != nil {
        left = left.Next
        right = right.Next
    }

    left.Next = left.Next.Next
    return dummy.Next
}

// helpers for testing
func buildList(vals []int) *ListNode {
    if len(vals) == 0 {
        return nil
    }
    head := &ListNode{Val: vals[0]}
    curr := head
    for _, v := range vals[1:] {
        curr.Next = &ListNode{Val: v}
        curr = curr.Next
    }
    return head
}

func printList(head *ListNode) {
    for head != nil {
        fmt.Printf(\"%d \", head.Val)
        head = head.Next
    }
    fmt.Println()
}

func main() {
    head := buildList([]int{1, 2, 3, 4, 5})
    head = removeNthFromEnd(head, 2)
    printList(head) // Output: 1 2 3 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CopyLinkedListwithRandomPointer.Recursion_HashMap
    set output_file "CopyRandomList"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a Node.
 */
type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

var m = make(map[*Node]*Node)

func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }
    if val, exists := m[head]; exists {
        return val
    }

    copy := &Node{Val: head.Val}
    m[head] = copy
    copy.Next = copyRandomList(head.Next)
    copy.Random = m[head.Random]
    return copy
}

// helper to print list (for demonstration)
func printList(head *Node) {
    for head != nil {
        randomVal := -1
        if head.Random != nil {
            randomVal = head.Random.Val
        }
        fmt.Printf(\"Val: %d, Random: %d\\n\", head.Val, randomVal)
        head = head.Next
    }
}

func main() {
    // Example: 1 -> 2 -> 3, random pointers
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n1.Next = n2
    n2.Next = n3
    n1.Random = n3
    n2.Random = n1
    n3.Random = n2

    copyHead := copyRandomList(n1)
    printList(copyHead)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CopyLinkedListwithRandomPointer.HashMap_TwoPass
    set output_file "CopyRandomListOptimized"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a Node.
 */
type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

func copyRandomList(head *Node) *Node {
    oldToCopy := map[*Node]*Node{nil: nil}

    cur := head
    for cur != nil {
        copy := &Node{Val: cur.Val}
        oldToCopy[cur] = copy
        cur = cur.Next
    }

    cur = head
    for cur != nil {
        copy := oldToCopy[cur]
        copy.Next = oldToCopy[cur.Next]
        copy.Random = oldToCopy[cur.Random]
        cur = cur.Next
    }

    return oldToCopy[head]
}

// helper to print list (for demonstration)
func printList(head *Node) {
    for head != nil {
        randomVal := -1
        if head.Random != nil {
            randomVal = head.Random.Val
        }
        fmt.Printf(\"Val: %d, Random: %d\\n\", head.Val, randomVal)
        head = head.Next
    }
}

func main() {
    // Example: 1 -> 2 -> 3, random pointers
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n1.Next = n2
    n2.Next = n3
    n1.Random = n3
    n2.Random = n1
    n3.Random = n2

    copyHead := copyRandomList(n1)
    printList(copyHead)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CopyLinkedListwithRandomPointer.HashMap_OnePass
    set output_file "CopyRandomListMap"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a Node.
 */
type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

func copyRandomList(head *Node) *Node {
    oldToCopy := make(map[*Node]*Node)
    oldToCopy[nil] = nil

    cur := head
    for cur != nil {
        if _, exists := oldToCopy[cur]; !exists {
            oldToCopy[cur] = &Node{Val: cur.Val}
        }
        if cur.Next != nil {
            if _, exists := oldToCopy[cur.Next]; !exists {
                oldToCopy[cur.Next] = &Node{Val: cur.Next.Val}
            }
            oldToCopy[cur].Next = oldToCopy[cur.Next]
        }
        if cur.Random != nil {
            if _, exists := oldToCopy[cur.Random]; !exists {
                oldToCopy[cur.Random] = &Node{Val: cur.Random.Val}
            }
            oldToCopy[cur].Random = oldToCopy[cur.Random]
        }
        cur = cur.Next
    }
    return oldToCopy[head]
}

// helper to print list (for demonstration)
func printList(head *Node) {
    for head != nil {
        randomVal := -1
        if head.Random != nil {
            randomVal = head.Random.Val
        }
        fmt.Printf(\"Val: %d, Random: %d\\n\", head.Val, randomVal)
        head = head.Next
    }
}

func main() {
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n1.Next = n2
    n2.Next = n3
    n1.Random = n3
    n2.Random = n1
    n3.Random = n2

    copyHead := copyRandomList(n1)
    printList(copyHead)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.CopyLinkedListwithRandomPointer.SpaceOptimized-I
    set output_file "CopyRandomListOptimized"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a Node.
 */
type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }

    // 1. Make copy of each node and insert next to original
    l1 := head
    for l1 != nil
        l2 := &Node{Val: l1.Val}
        l2.Next = l1.Next
        l1.Next = l2
        l1 = l2.Next
    end

    newHead := head.Next

    // 2. Assign random pointers
    l1 = head
    for l1 != nil
        if l1.Random != nil
            l1.Next.Random = l1.Random.Next
        end
        l1 = l1.Next.Next
    end

    // 3. Restore original list and extract copy
    l1 = head
    for l1 != nil
        l2 := l1.Next
        l1.Next = l2.Next
        if l2.Next != nil
            l2.Next = l2.Next.Next
        end
        l1 = l1.Next
    end

    return newHead
end

// helper to print list (for demonstration)
func printList(head *Node)
    while head != nil
        randomVal := -1
        if head.Random != nil
            randomVal = head.Random.Val
        end
        fmt.Printf(\"Val: %d, Random: %d\\n\", head.Val, randomVal)
        head = head.Next
    end
end

func main()
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n1.Next = n2
    n2.Next = n3
    n1.Random = n3
    n2.Random = n1
    n3.Random = n2

    copyHead := copyRandomList(n1)
    printList(copyHead)
end
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.CopyLinkedListwithRandomPointer.SpaceOptimized-II
    set output_file "CopyRandomListOptimizedAlt"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a Node.
 */
type Node struct {
    Val    int
    Next   *Node
    Random *Node
}

func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }

    l1 := head
    for l1 != nil
        l2 := &Node{Val: l1.Val}
        l2.Next = l1.Random
        l1.Random = l2
        l1 = l1.Next
    end

    newHead := head.Random

    l1 = head
    for l1 != nil
        l2 := l1.Random
        if l2.Next != nil
            l2.Random = l2.Next.Random
        else
            l2.Random = nil
        end
        l1 = l1.Next
    end

    l1 = head
    for l1 != nil
        l2 := l1.Random
        l1.Random = l2.Next
        if l1.Next != nil
            l2.Next = l1.Next.Random
        else
            l2.Next = nil
        end
        l1 = l1.Next
    end

    return newHead
end

func printList(head *Node)
    while head != nil
        randomVal := -1
        if head.Random != nil
            randomVal = head.Random.Val
        end
        fmt.Printf(\"Val: %d, Random: %d\\n\", head.Val, randomVal)
        head = head.Next
    end
end

func main()
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n1.Next = n2
    n2.Next = n3
    n1.Random = n3
    n2.Random = n1
    n3.Random = n2

    copyHead := copyRandomList(n1)
    printList(copyHead)
end
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.AddTwoNumbers.Recursion
    set output_file "AddTwoNumbersRecursive"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func add(l1 *ListNode, l2 *ListNode, carry int) *ListNode {
    if l1 == nil && l2 == nil && carry == 0
        return nil
    end

    v1, v2 := 0, 0
    if l1 != nil
        v1 = l1.Val
    end
    if l2 != nil
        v2 = l2.Val
    end

    sum := v1 + v2 + carry
    carry, val := sum/10, sum%10

    var nextNode *ListNode
    nextL1 := nil
    if l1 != nil
        nextL1 = l1.Next
    end
    nextL2 := nil
    if l2 != nil
        nextL2 = l2.Next
    end

    nextNode = add(nextL1, nextL2, carry)
    return &ListNode{Val: val, Next: nextNode}
end

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode
    return add(l1, l2, 0)
end

func printList(head *ListNode)
    while head != nil
        fmt.Printf(\"%d -> \", head.Val)
        head = head.Next
    end
    fmt.Println(\"nil\")
end

func main()
    l1 := &ListNode{Val: 2, Next: &ListNode{Val: 4, Next: &ListNode{Val: 3}}}
    l2 := &ListNode{Val: 5, Next: &ListNode{Val: 6, Next: &ListNode{Val: 4}}}

    sum := addTwoNumbers(l1, l2)
    printList(sum) // Output: 7 -> 0 -> 8 -> nil
end
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.AddTwoNumbers.Iteration
    set output_file "AddTwoNumbersIterative"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for singly-linked list.
 */
type ListNode struct {
    Val  int
    Next *ListNode
}

func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
    dummy := &ListNode{}
    cur := dummy
    carry := 0

    while l1 != nil || l2 != nil || carry != 0
        v1 := 0
        if l1 != nil
            v1 = l1.Val
            l1 = l1.Next
        end

        v2 := 0
        if l2 != nil
            v2 = l2.Val
            l2 = l2.Next
        end

        val := v1 + v2 + carry
        carry = val / 10
        cur.Next = &ListNode{Val: val % 10}
        cur = cur.Next
    end

    return dummy.Next
end

func printList(head *ListNode)
    while head != nil
        fmt.Printf(\"%d -> \", head.Val)
        head = head.Next
    end
    fmt.Println(\"nil\")
end

func main()
    l1 := &ListNode{Val: 2, Next: &ListNode{Val: 4, Next: &ListNode{Val: 3}}}
    l2 := &ListNode{Val: 5, Next: &ListNode{Val: 6, Next: &ListNode{Val: 4}}}

    sum := addTwoNumbers(l1, l2)
    printList(sum) // Output: 7 -> 0 -> 8 -> nil
end
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.Sorting
    set output_file "FindDuplicate"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func findDuplicate(nums []int) int {
    sort.Ints(nums)

    for i := 0; i < len(nums)-1; i++ {
        if nums[i] == nums[i+1] {
            return nums[i]
        }
    }

    return -1
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.HashSet
    set output_file "FindDuplicateHash"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    seen := make(map[int]struct{})
    for _, num := range nums {
        if _, exists := seen[num]; exists {
            return num
        }
        seen[num] = struct{}{}
    }
    return -1
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.Array
    set output_file "FindDuplicateArray"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    seen := make([]int, len(nums))
    for _, num := range nums {
        if seen[num-1] == 1 {
            return num
        }
        seen[num-1] = 1
    }
    return -1
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.NegativeMarking
    set output_file "FindDuplicateNegate"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    for _, num := range nums {
        idx := abs(num) - 1
        if nums[idx] < 0 {
            return abs(num)
        }
        nums[idx] *= -1
    }
    return -1
}

func abs(num int) int {
    if num < 0 {
        return -num
    }
    return num
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.BinarySearch
    set output_file "FindDuplicateBinary"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    n := len(nums)
    low, high := 1, n-1

    for low < high {
        mid := low + (high-low)/2
        lessOrEqual := 0

        for _, num := range nums {
            if num <= mid {
                lessOrEqual++
            }
        }

        if lessOrEqual <= mid {
            low = mid + 1
        } else {
            high = mid
        }
    }

    return low
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.BitManipulation
    set output_file "FindDuplicateBitwise"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    n := len(nums)
    res := 0

    for b := 0; b < 32; b++ {
        x, y := 0, 0
        mask := 1 << b

        for _, num := range nums {
            if num&mask != 0 {
                x++
            }
        }

        for num := 1; num < n; num++ {
            if num&mask != 0 {
                y++
            }
        }

        if x > y {
            res |= mask
        }
    }

    return res
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.FindDuplicateNumber.FastAndSlowPointers
    set output_file "FindDuplicateFloyd"

    set template_content "package main

import (
    \"fmt\"
)

func findDuplicate(nums []int) int {
    slow, fast := 0, 0

    // Фаза 1: знайти точку зустрічі
    for {
        slow = nums[slow]
        fast = nums[nums[fast]]
        if slow == fast {
            break
        }
    }

    // Фаза 2: знайти початок циклу (дубль)
    slow2 := 0
    for {
        slow = nums[slow]
        slow2 = nums[slow2]
        if slow == slow2 {
            return slow
        }
    }
}

func main() {
    nums := []int{1,3,4,2,2}
    fmt.Println(findDuplicate(nums)) // Output: 2

    nums2 := []int{3,1,3,4,2}
    fmt.Println(findDuplicate(nums2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LRUCache.BruteForce
    set output_file "LRUCacheArray"

    set template_content "package main

import (
    \"fmt\"
)

type LRUCache struct {
    cache    [][2]int
    capacity int
}

func Constructor(capacity int) LRUCache {
    return LRUCache{
        cache:    make([][2]int, 0),
        capacity: capacity,
    }
}

func (this *LRUCache) Get(key int) int {
    for i := range this.cache {
        if this.cache[i][0] == key {
            tmp := this.cache[i]
            this.cache = append(this.cache[:i], this.cache[i+1:]...)
            this.cache = append(this.cache, tmp)
            return tmp[1]
        }
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    for i := range this.cache {
        if this.cache[i][0] == key {
            tmp := this.cache[i]
            this.cache = append(this.cache[:i], this.cache[i+1:]...)
            tmp[1] = value
            this.cache = append(this.cache, tmp)
            return
        }
    }

    if len(this.cache) == this.capacity {
        this.cache = this.cache[1:]
    }

    this.cache = append(this.cache, [2]int{key, value})
}

func main() {
    obj := Constructor(2)
    obj.Put(1, 1)
    obj.Put(2, 2)
    fmt.Println(obj.Get(1)) // Output: 1
    obj.Put(3, 3)           // removes key 2
    fmt.Println(obj.Get(2)) // Output: -1
    obj.Put(4, 4)           // removes key 1
    fmt.Println(obj.Get(1)) // Output: -1
    fmt.Println(obj.Get(3)) // Output: 3
    fmt.Println(obj.Get(4)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LRUCache.DoublyLinkedList
    set output_file "LRUCache"

    set template_content "package main

import (
    \"fmt\"
)

type Node struct {
    key, val   int
    prev, next *Node
}

type LRUCache struct {
    cap        int
    cache      map[int]*Node
    left, right *Node
}

func Constructor(capacity int) LRUCache {
    lru := LRUCache{
        cap:   capacity,
        cache: make(map[int]*Node),
        left:  &Node{},
        right: &Node{},
    }
    lru.left.next = lru.right
    lru.right.prev = lru.left
    return lru
}

func (this *LRUCache) remove(node *Node) {
    prev, next := node.prev, node.next
    prev.next = next
    next.prev = prev
}

func (this *LRUCache) insert(node *Node) {
    prev, next := this.right.prev, this.right
    prev.next = node
    next.prev = node
    node.next = next
    node.prev = prev
}

func (this *LRUCache) Get(key int) int {
    if node, ok := this.cache[key]; ok {
        this.remove(node)
        this.insert(node)
        return node.val
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if node, ok := this.cache[key]; ok {
        this.remove(node)
        delete(this.cache, key)
    }

    node := &Node{key: key, val: value}
    this.cache[key] = node
    this.insert(node)

    if len(this.cache) > this.cap {
        lru := this.left.next
        this.remove(lru)
        delete(this.cache, lru.key)
    }
}

func main() {
    lru := Constructor(2)
    lru.Put(1, 1)
    lru.Put(2, 2)
    fmt.Println(lru.Get(1)) // Output: 1
    lru.Put(3, 3)
    fmt.Println(lru.Get(2)) // Output: -1
    lru.Put(4, 4)
    fmt.Println(lru.Get(1)) // Output: -1
    fmt.Println(lru.Get(3)) // Output: 3
    fmt.Println(lru.Get(4)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LRUCache.Built-InDataStructure
    set output_file "LRUCacheSimple"

    set template_content "package main

import (
    \"fmt\"
)

type LRUCache struct {
    capacity int
    keys     []int
    values   map[int]int
}

func Constructor(capacity int) LRUCache {
    return LRUCache{
        capacity: capacity,
        keys:     make([]int, 0, capacity),
        values:   make(map[int]int),
    }
}

func (this *LRUCache) Get(key int) int {
    if val, exists := this.values[key]; exists {
        for i := range this.keys {
            if this.keys[i] == key {
                this.keys = append(this.keys[:i], this.keys[i+1:]...)
                break
            }
        }
        this.keys = append(this.keys, key)
        return val
    }
    return -1
}

func (this *LRUCache) Put(key int, value int) {
    if _, exists := this.values[key]; exists {
        for i := range this.keys {
            if this.keys[i] == key {
                this.keys = append(this.keys[:i], this.keys[i+1:]...)
                break
            }
        }
    } else {
        if len(this.keys) >= this.capacity {
            delete(this.values, this.keys[0])
            this.keys = this.keys[1:]
        }
    }
    this.values[key] = value
    this.keys = append(this.keys, key)
}

func main() {
    cache := Constructor(2)
    cache.Put(1, 1)
    cache.Put(2, 2)
    fmt.Println(cache.Get(1)) // 1
    cache.Put(3, 3)
    fmt.Println(cache.Get(2)) // -1
    cache.Put(4, 4)
    fmt.Println(cache.Get(1)) // -1
    fmt.Println(cache.Get(3)) // 3
    fmt.Println(cache.Get(4)) // 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LowestCommonAncestorBinarySearchTree.Recursion
    set output_file "LowestCommonAncestorBST"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func lowestCommonAncestor(root, p, q *TreeNode) *TreeNode {
    if root == nil || p == nil || q == nil {
        return nil
    }
    if max(p.Val, q.Val) < root.Val {
        return lowestCommonAncestor(root.Left, p, q)
    } else if min(p.Val, q.Val) > root.Val {
        return lowestCommonAncestor(root.Right, p, q)
    } else {
        return root
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    //       6
    //      / \\
    //     2   8
    //    / \\ / \\
    //   0  4 7  9
    //     / \\
    //    3   5

    root := &TreeNode{Val: 6}
    root.Left = &TreeNode{Val: 2}
    root.Right = &TreeNode{Val: 8}
    root.Left.Left = &TreeNode{Val: 0}
    root.Left.Right = &TreeNode{Val: 4}
    root.Left.Right.Left = &TreeNode{Val: 3}
    root.Left.Right.Right = &TreeNode{Val: 5}
    root.Right.Left = &TreeNode{Val: 7}
    root.Right.Right = &TreeNode{Val: 9}

    p := root.Left        // 2
    q := root.Left.Right  // 4

    ans := lowestCommonAncestor(root, p, q)
    fmt.Println(ans.Val) // Output: 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LowestCommonAncestorBinarySearchTree.Iteration
    set output_file "LowestCommonAncestorIterative"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func lowestCommonAncestor(root, p, q *TreeNode) *TreeNode {
    cur := root
    for cur != nil {
        if p.Val > cur.Val && q.Val > cur.Val {
            cur = cur.Right
        } else if p.Val < cur.Val && q.Val < cur.Val {
            cur = cur.Left
        } else {
            return cur
        }
    }
    return nil
}

func main() {
    //       6
    //      / \\
    //     2   8
    //    / \\ / \\
    //   0  4 7  9
    //     / \\
    //    3   5

    root := &TreeNode{Val: 6}
    root.Left = &TreeNode{Val: 2}
    root.Right = &TreeNode{Val: 8}
    root.Left.Left = &TreeNode{Val: 0}
    root.Left.Right = &TreeNode{Val: 4}
    root.Left.Right.Left = &TreeNode{Val: 3}
    root.Left.Right.Right = &TreeNode{Val: 5}
    root.Right.Left = &TreeNode{Val: 7}
    root.Right.Right = &TreeNode{Val: 9}

    p := root.Left        // 2
    q := root.Left.Right  // 4

    ans := lowestCommonAncestor(root, p, q)
    fmt.Println(ans.Val) // Output: 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.BinaryTreeLevelOrderTraversal.DepthFirstSearch
    set output_file "LevelOrderDFS"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func levelOrder(root *TreeNode) [][]int {
    res := [][]int{}

    var dfs func(node *TreeNode, depth int)
    dfs = func(node *TreeNode, depth int) {
        if node == nil {
            return
        }

        if len(res) == depth {
            res = append(res, []int{})
        }

        res[depth] = append(res[depth], node.Val)
        dfs(node.Left, depth+1)
        dfs(node.Right, depth+1)
    }

    dfs(root, 0)
    return res
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 9}
    root.Right = &TreeNode{Val: 20}
    root.Right.Left = &TreeNode{Val: 15}
    root.Right.Right = &TreeNode{Val: 7}

    ans := levelOrder(root)
    fmt.Println(ans) // Output: [[3] [9 20] [15 7]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.BinaryTreeLevelOrderTraversal.BreadthFirstSearch
    set output_file "LevelOrderBFS"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func levelOrder(root *TreeNode) [][]int {
    res := [][]int{}
    if root == nil {
        return res
    }

    q := []*TreeNode{root}

    for len(q) > 0 {
        qLen := len(q)
        level := []int{}

        for i := 0; i < qLen; i++ {
            node := q[0]
            q = q[1:]
            level = append(level, node.Val)

            if node.Left != nil {
                q = append(q, node.Left)
            }
            if node.Right != nil {
                q = append(q, node.Right)
            }
        }

        res = append(res, level)
    }

    return res
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 9}
    root.Right = &TreeNode{Val: 20}
    root.Right.Left = &TreeNode{Val: 15}
    root.Right.Right = &TreeNode{Val: 7}

    ans := levelOrder(root)
    fmt.Println(ans) // Output: [[3] [9 20] [15 7]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinaryTreeRightSideView.DepthFirstSearch
    set output_file "RightSideViewDFS"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func rightSideView(root *TreeNode) []int {
    var res []int

    var dfs func(node *TreeNode, depth int)
    dfs = func(node *TreeNode, depth int) {
        if node == nil {
            return
        }
        if depth == len(res) {
            res = append(res, node.Val)
        }
        dfs(node.Right, depth+1)
        dfs(node.Left, depth+1)
    }

    dfs(root, 0)
    return res
}

func main() {
    root := &TreeNode{Val: 1}
    root.Left = &TreeNode{Val: 2}
    root.Right = &TreeNode{Val: 3}
    root.Left.Right = &TreeNode{Val: 5}
    root.Right.Right = &TreeNode{Val: 4}

    ans := rightSideView(root)
    fmt.Println(ans) // Output: [1 3 4 5]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.BinaryTreeRightSideView.BreadthFirstSearch
    set output_file "RightSideViewBFS"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func rightSideView(root *TreeNode) []int {
    if root == nil {
        return []int{}
    }

    res := []int{}
    q := []*TreeNode{root}

    for len(q) > 0 {
        rightSide := 0
        qLen := len(q)

        for i := 0; i < qLen; i++ {
            node := q[0]
            q = q[1:]

            if node != nil {
                rightSide = node.Val
                if node.Left != nil {
                    q = append(q, node.Left)
                }
                if node.Right != nil {
                    q = append(q, node.Right)
                }
            }
        }
        res = append(res, rightSide)
    }

    return res
}

func main() {
    root := &TreeNode{Val: 1}
    root.Left = &TreeNode{Val: 2}
    root.Right = &TreeNode{Val: 3}
    root.Left.Right = &TreeNode{Val: 5}
    root.Right.Right = &TreeNode{Val: 4}

    ans := rightSideView(root)
    fmt.Println(ans) // Output: [1 3 4 5]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CountGoodNodesBinaryTree.DepthFirstSearch
    set output_file "GoodNodes"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func goodNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }

    var dfs func(node *TreeNode, maxVal int) int
    dfs = func(node *TreeNode, maxVal int) int {
        if node == nil {
            return 0
        }

        res := 0
        if node.Val >= maxVal {
            res = 1
        }

        maxVal = max(maxVal, node.Val)
        res += dfs(node.Left, maxVal)
        res += dfs(node.Right, maxVal)

        return res
    }

    return dfs(root, root.Val)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Left = &TreeNode{Val: 3}
    root.Right.Left = &TreeNode{Val: 1}
    root.Right.Right = &TreeNode{Val: 5}

    ans := goodNodes(root)
    fmt.Println(ans) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CountGoodNodesBinaryTree.BreadthFirstSearch
    set output_file "GoodNodesBFS"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func goodNodes(root *TreeNode) int {
    if root == nil {
        return 0
    }

    res := 0
    q := []struct {
        node   *TreeNode
        maxVal int
    }{{root, math.MinInt32}}

    for len(q) > 0 {
        front := q[0]
        q = q[1:]

        node := front.node
        maxVal := front.maxVal

        if node.Val >= maxVal {
            res++
        }

        newMaxVal := max(maxVal, node.Val)

        if node.Left != nil {
            q = append(q, struct {
                node   *TreeNode
                maxVal int
            }{node.Left, newMaxVal})
        }

        if node.Right != nil {
            q = append(q, struct {
                node   *TreeNode
                maxVal int
            }{node.Right, newMaxVal})
        }
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Left = &TreeNode{Val: 3}
    root.Right.Left = &TreeNode{Val: 1}
    root.Right.Right = &TreeNode{Val: 5}

    ans := goodNodes(root)
    fmt.Println(ans) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidBinarySearchTree.BruteForce
    set output_file "IsValidBST"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isValidBST(root *TreeNode) bool {
    if root == nil {
        return true
    }
    return isValid(root.Left, root.Val, func(val, limit int) bool { return val < limit }) &&
           isValid(root.Right, root.Val, func(val, limit int) bool { return val > limit }) &&
           isValidBST(root.Left) &&
           isValidBST(root.Right)
}

func isValid(root *TreeNode, limit int, check func(int, int) bool) bool {
    if root == nil {
        return true
    }
    if !check(root.Val, limit) {
        return false
    }
    return isValid(root.Left, limit, check) && isValid(root.Right, limit, check)
}

func main() {
    root := &TreeNode{Val: 2}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 3}

    fmt.Println(isValidBST(root)) // Output: true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ValidBinarySearchTree.DepthFirstSearch
    set output_file "IsValidBSTOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func isValidBST(root *TreeNode) bool {
    return valid(root, math.MinInt64, math.MaxInt64)
}

func valid(node *TreeNode, left, right int64) bool {
    if node == nil {
        return true
    }

    val := int64(node.Val)
    if val <= left || val >= right {
        return false
    }

    return valid(node.Left, left, val) && valid(node.Right, val, right)
}

func main() {
    root := &TreeNode{Val: 2}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 3}

    fmt.Println(isValidBST(root)) // Output: true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.ValidBinarySearchTree.BreadthFirstSearch
    set output_file "IsValidBSTBFS"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

type QueueItem struct {
    node *TreeNode
    left int64
    right int64
}

func isValidBST(root *TreeNode) bool {
    if root == nil {
        return true
    }

    queue := []QueueItem{{root, math.MinInt64, math.MaxInt64}}

    for len(queue) > 0 {
        item := queue[0]
        queue = queue[1:]

        val := int64(item.node.Val)
        if val <= item.left || val >= item.right {
            return false
        }

        if item.node.Left != nil {
            queue = append(queue, QueueItem{item.node.Left, item.left, val})
        }
        if item.node.Right != nil {
            queue = append(queue, QueueItem{item.node.Right, val, item.right})
        }
    }

    return true
}

func main() {
    root := &TreeNode{Val: 2}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 3}

    fmt.Println(isValidBST(root)) // Output: true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthSmallestIntegerBST.BruteForce
    set output_file "KthSmallestBST"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
    var arr []int

    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }

        dfs(node.Left)
        arr = append(arr, node.Val)
        dfs(node.Right)
    }

    dfs(root)
    return arr[k-1]
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Right = &TreeNode{Val: 2}

    k := 1
    fmt.Println(kthSmallest(root, k)) // Output: 1

    k = 3
    fmt.Println(kthSmallest(root, k)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.KthSmallestIntegerBST.InorderTraversal
    set output_file "KthSmallestBST"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
    var arr []int

    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }

        dfs(node.Left)
        arr = append(arr, node.Val)
        dfs(node.Right)
    }

    dfs(root)
    return arr[k-1]
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Right = &TreeNode{Val: 2}

    k := 1
    fmt.Println(kthSmallest(root, k)) // Output: 1

    k = 3
    fmt.Println(kthSmallest(root, k)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.KthSmallestIntegerBST.RecursiveDFS_Optimal
    set output_file "KthSmallestBSTOptimized"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
    cnt, res := k, 0

    var dfs func(node *TreeNode)
    dfs = func(node *TreeNode) {
        if node == nil {
            return
        }

        dfs(node.Left)
        cnt--
        if cnt == 0 {
            res = node.Val
            return
        }
        dfs(node.Right)
    }

    dfs(root)
    return res
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Right = &TreeNode{Val: 2}

    k := 1
    fmt.Println(kthSmallest(root, k)) // Output: 1

    k = 3
    fmt.Println(kthSmallest(root, k)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthSmallestIntegerBST.IterativeDFS_Optimal
    set output_file "KthSmallestBSTIterative"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
    stack := []*TreeNode{}
    curr := root

    for len(stack) > 0 || curr != nil {
        for curr != nil {
            stack = append(stack, curr)
            curr = curr.Left
        }

        curr = stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        k--
        if k == 0 {
            return curr.Val
        }

        curr = curr.Right
    }

    return 0
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Right = &TreeNode{Val: 2}

    k := 1
    fmt.Println(kthSmallest(root, k)) // Output: 1

    k = 3
    fmt.Println(kthSmallest(root, k)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthSmallestIntegerBST.MorrisTraversal
    set output_file "KthSmallestMorris"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthSmallest(root *TreeNode, k int) int {
    curr := root
    for {
        if curr.Left == nil {
            k--
            if k == 0 {
                return curr.Val
            }
            curr = curr.Right
        } else {
            pred := curr.Left
            for pred.Right != nil && pred.Right != curr {
                pred = pred.Right
            }
            if pred.Right == nil {
                pred.Right = curr
                curr = curr.Left
            } else {
                pred.Right = nil
                k--
                if k == 0 {
                    return curr.Val
                }
                curr = curr.Right
            }
        }
    }
}

func main() {
    root := &TreeNode{Val: 3}
    root.Left = &TreeNode{Val: 1}
    root.Right = &TreeNode{Val: 4}
    root.Left.Right = &TreeNode{Val: 2}

    k := 1
    fmt.Println(kthSmallest(root, k)) // Output: 1

    k = 3
    fmt.Println(kthSmallest(root, k)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ConstructBinaryTreefromPreorderInorderTraversal.DepthFirstSearch
    set output_file "BuildTree"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func buildTree(preorder []int, inorder []int) *TreeNode {
    if len(preorder) == 0 || len(inorder) == 0 {
        return nil
    }

    root := &TreeNode{Val: preorder[0]}

    mid := 0
    for i, val := range inorder {
        if val == preorder[0] {
            mid = i
            break
        }
    }

    root.Left = buildTree(preorder[1:mid+1], inorder[:mid])
    root.Right = buildTree(preorder[mid+1:], inorder[mid+1:])

    return root
}

func printInorder(root *TreeNode) {
    if root == nil {
        return
    }
    printInorder(root.Left)
    fmt.Print(root.Val, \" \")
    printInorder(root.Right)
}

func main() {
    preorder := []int{3, 9, 20, 15, 7}
    inorder := []int{9, 3, 15, 20, 7}

    root := buildTree(preorder, inorder)
    fmt.Print(\"Inorder traversal of constructed tree: \")
    printInorder(root)
    fmt.Println()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ConstructBinaryTreefromPreorderandInorderTraversal.HashMap_DepthFirstSearch
    set output_file "BuildTreeOptimized"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func buildTree(preorder []int, inorder []int) *TreeNode {
    indices := make(map[int]int)
    for i, val := range inorder {
        indices[val] = i
    }

    preIdx := 0

    var dfs func(int, int) *TreeNode
    dfs = func(left, right int) *TreeNode {
        if left > right {
            return nil
        }

        rootVal := preorder[preIdx]
        preIdx++

        root := &TreeNode{Val: rootVal}
        mid := indices[rootVal]

        root.Left = dfs(left, mid-1)
        root.Right = dfs(mid+1, right)

        return root
    }

    return dfs(0, len(inorder)-1)
}

func printInorder(root *TreeNode) {
    if root == nil {
        return
    }
    printInorder(root.Left)
    fmt.Print(root.Val, \" \")
    printInorder(root.Right)
}

func main() {
    preorder := []int{3, 9, 20, 15, 7}
    inorder := []int{9, 3, 15, 20, 7}

    root := buildTree(preorder, inorder)
    fmt.Print(\"Inorder traversal of constructed tree: \")
    printInorder(root)
    fmt.Println()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ConstructBinaryTreefromPreorderandInorderTraversal.DepthFirst_SearchOptimal
    set output_file "BuildTreeLimit"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

/**
 * Definition for a binary tree node.
 */
type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func buildTree(preorder []int, inorder []int) *TreeNode {
    preIdx, inIdx := 0, 0

    var dfs func(int) *TreeNode
    dfs = func(limit int) *TreeNode {
        if preIdx >= len(preorder) {
            return nil
        }
        if inorder[inIdx] == limit {
            inIdx++
            return nil
        }

        root := &TreeNode{Val: preorder[preIdx]}
        preIdx++

        root.Left = dfs(root.Val)
        root.Right = dfs(limit)

        return root
    }

    return dfs(math.MaxInt)
}

func printInorder(root *TreeNode) {
    if root == nil {
        return
    }
    printInorder(root.Left)
    fmt.Print(root.Val, \" \")
    printInorder(root.Right)
}

func main() {
    preorder := []int{3, 9, 20, 15, 7}
    inorder := []int{9, 3, 15, 20, 7}

    root := buildTree(preorder, inorder)
    fmt.Print(\"Inorder traversal of constructed tree: \")
    printInorder(root)
    fmt.Println()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ImplementPrefixTree.Prefix_TreeArray
    set output_file "PrefixTree"

    set template_content "package main

import \"fmt\"

type TrieNode struct {
    children [26]*TrieNode
    endOfWord bool
}

type PrefixTree struct {
    root *TrieNode
}

func Constructor() PrefixTree {
    return PrefixTree{root: &TrieNode{}}
}

func (this *PrefixTree) Insert(word string) {
    cur := this.root
    for _, c := range word {
        i := c - 'a'
        if cur.children[i] == nil {
            cur.children[i] = &TrieNode{}
        }
        cur = cur.children[i]
    }
    cur.endOfWord = true
}

func (this *PrefixTree) Search(word string) bool {
    cur := this.root
    for _, c := range word {
        i := c - 'a'
        if cur.children[i] == nil {
            return false
        }
        cur = cur.children[i]
    }
    return cur.endOfWord
}

func (this *PrefixTree) StartsWith(prefix string) bool {
    cur := this.root
    for _, c := range prefix {
        i := c - 'a'
        if cur.children[i] == nil {
            return false
        }
        cur = cur.children[i]
    }
    return true
}

func main() {
    trie := Constructor()
    trie.Insert(\"apple\")
    fmt.Println(trie.Search(\"apple\"))   // Output: true
    fmt.Println(trie.Search(\"app\"))     // Output: false
    fmt.Println(trie.StartsWith(\"app\")) // Output: true
    trie.Insert(\"app\")
    fmt.Println(trie.Search(\"app\"))     // Output: true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ImplementTrie_PrefixTree.PrefixTree_HashMap
    set output_file "PrefixTreeUnicode"

    set template_content "package main

import \"fmt\"

type TrieNode struct {
    children map[rune]*TrieNode
    endOfWord bool
}

type PrefixTree struct {
    root *TrieNode
}

func Constructor() PrefixTree {
    return PrefixTree{root: &TrieNode{children: make(map[rune]*TrieNode)}}
}

func (this *PrefixTree) Insert(word string) {
    cur := this.root
    for _, c := range word {
        if cur.children[c] == nil {
            cur.children[c] = &TrieNode{children: make(map[rune]*TrieNode)}
        }
        cur = cur.children[c]
    }
    cur.endOfWord = true
}

func (this *PrefixTree) Search(word string) bool {
    cur := this.root
    for _, c := range word {
        if cur.children[c] == nil {
            return false
        }
        cur = cur.children[c]
    }
    return cur.endOfWord
}

func (this *PrefixTree) StartsWith(prefix string) bool {
    cur := this.root
    for _, c := range prefix {
        if cur.children[c] == nil {
            return false
        }
        cur = cur.children[c]
    }
    return true
}

func main() {
    trie := Constructor()
    trie.Insert(\"apple\")
    fmt.Println(trie.Search(\"apple\"))   // Output: true
    fmt.Println(trie.Search(\"app\"))     // Output: false
    fmt.Println(trie.StartsWith(\"app\")) // Output: true
    trie.Insert(\"app\")
    fmt.Println(trie.Search(\"app\"))     // Output: true
    trie.Insert(\"яблуко\")               // Unicode приклад
    fmt.Println(trie.Search(\"яблуко\"))  // Output: true
    fmt.Println(trie.StartsWith(\"яб\"))  // Output: true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.DesignAddandSearchWordDataStructure.BruteForce
    set output_file "WordDictionary"

    set template_content "package main

import \"fmt\"

type WordDictionary struct {
    store []string
}

func Constructor() WordDictionary {
    return WordDictionary{store: []string{}}
}

func (this *WordDictionary) AddWord(word string) {
    this.store = append(this.store, word)
}

func (this *WordDictionary) Search(word string) bool {
    for _, w := range this.store {
        if len(w) != len(word) {
            continue
        }
        match := true
        for i := 0; i < len(w); i++ {
            if w[i] != word[i] && word[i] != '.' {
                match = false
                break
            }
        }
        if match {
            return true
        }
    }
    return false
}

func main() {
    dict := Constructor()
    dict.AddWord(\"bad\")
    dict.AddWord(\"dad\")
    dict.AddWord(\"mad\")

    fmt.Println(dict.Search(\"pad\")) // false
    fmt.Println(dict.Search(\"bad\")) // true
    fmt.Println(dict.Search(\".ad\")) // true
    fmt.Println(dict.Search(\"b..\")) // true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.DesignAddandSearchWordDataStructure.DepthFirstSearch
    set output_file "WordDictionaryTrie"

    set template_content "package main

import \"fmt\"

type TrieNode struct {
    children [26]*TrieNode
    word     bool
}

func NewTrieNode() *TrieNode {
    return &TrieNode{}
}

type WordDictionary struct {
    root *TrieNode
}

func Constructor() WordDictionary {
    return WordDictionary{root: NewTrieNode()}
}

func (this *WordDictionary) AddWord(word string) {
    cur := this.root
    for _, c := range word {
        index := c - 'a'
        if cur.children[index] == nil {
            cur.children[index] = NewTrieNode()
        }
        cur = cur.children[index]
    }
    cur.word = true
}

func (this *WordDictionary) Search(word string) bool {
    return this.dfs(word, 0, this.root)
}

func (this *WordDictionary) dfs(word string, j int, root *TrieNode) bool {
    cur := root
    for i := j; i < len(word); i++ {
        c := word[i]
        if c == '.' {
            for _, child := range cur.children {
                if child != nil && this.dfs(word, i+1, child) {
                    return true
                }
            }
            return false
        } else {
            index := c - 'a'
            if cur.children[index] == nil {
                return false
            }
            cur = cur.children[index]
        }
    }
    return cur.word
}

func main() {
    dict := Constructor()
    dict.AddWord(\"bad\")
    dict.AddWord(\"dad\")
    dict.AddWord(\"mad\")

    fmt.Println(dict.Search(\"pad\")) // false
    fmt.Println(dict.Search(\"bad\")) // true
    fmt.Println(dict.Search(\".ad\")) // true
    fmt.Println(dict.Search(\"b..\")) // true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KClosestPointstoOrigin.Sorting
    set output_file "KClosestSort"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func kClosest(points [][]int, k int) [][]int {
    sort.Slice(points, func(i, j int) bool {
        return points[i][0]*points[i][0]+points[i][1]*points[i][1] <
            points[j][0]*points[j][0]+points[j][1]*points[j][1]
    })
    return points[:k]
}

func main() {
    points := [][]int{{1, 3}, {-2, 2}, {2, -2}}
    k := 2
    res := kClosest(points, k)
    fmt.Println(res) // Output: [[-2 2] [2 -2]] або подібно (залежно від сортування)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Min-Heap
    set output_file "KClosestHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
)

func kClosest(points [][]int, k int) [][]int {
    // Використовуємо мін-купу (пріоритетну чергу)
    minHeap := pq.NewWith(func(a, b interface{}) int {
        distA := a.([]int)[0]
        distB := b.([]int)[0]
        return distA - distB
    })

    // Додаємо всі точки до купи з їхньою відстанню до початку координат
    for _, point := range points {
        x, y := point[0], point[1]
        dist := x*x + y*y
        minHeap.Enqueue([]int{dist, x, y})
    }

    res := [][]int{}
    for i := 0; i < k; i++ {
        item, _ := minHeap.Dequeue()
        point := item.([]int)
        res = append(res, []int{point[1], point[2]})
    }

    return res
}

func main() {
    points := [][]int{{3, 3}, {5, -1}, {-2, 4}}
    k := 2
    res := kClosest(points, k)
    fmt.Println(res) // Output: [[3 3] [-2 4]] (порядок може відрізнятись)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KClosestPointstoOrigin.MaxHeap
    set output_file "KClosestMaxHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
)

func kClosest(points [][]int, k int) [][]int {
    maxHeap := pq.NewWith(func(a, b interface{}) int {
        distA := a.([]int)[2]
        distB := b.([]int)[2]
        if distA > distB {
            return -1
        } else if distA < distB {
            return 1
        }
        return 0
    })

    for _, point := range points {
        x, y := point[0], point[1]
        dist := x*x + y*y
        maxHeap.Enqueue([]int{x, y, dist})
        if maxHeap.Size() > k {
            maxHeap.Dequeue()
        }
    }

    result := make([][]int, k)
    for i := k - 1; i >= 0; i-- {
        val, _ := maxHeap.Dequeue()
        point := val.([]int)
        result[i] = []int{point[0], point[1]}
    }

    return result
}

func main() {
    points := [][]int{{3, 3}, {5, -1}, {-2, 4}, {2, 2}}
    k := 2
    res := kClosest(points, k)
    fmt.Println(res) // Output: [[2 2] [3 3]] або подібне
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KClosestPointstoOrigin.QuickSelect
    set output_file "KClosestQuickSelect"

    set template_content "package main

import (
    \"fmt\"
)

func kClosest(points [][]int, k int) [][]int {
    euclidean := func(x []int) int {
        return x[0]*x[0] + x[1]*x[1]
    }

    partition := func(points [][]int, l, r int) int {
        pivotIdx := r
        pivotDist := euclidean(points[pivotIdx])
        i := l
        for j := l; j < r; j++ {
            if euclidean(points[j]) <= pivotDist {
                points[i], points[j] = points[j], points[i]
                i++
            }
        }
        points[i], points[r] = points[r], points[i]
        return i
    }

    L, R := 0, len(points)-1
    pivot := len(points)

    for pivot != k {
        pivot = partition(points, L, R)
        if pivot < k {
            L = pivot + 1
        } else {
            R = pivot - 1
        }
    }
    return points[:k]
}

func main() {
    points := [][]int{{3, 3}, {5, -1}, {-2, 4}, {2, 2}}
    k := 2
    res := kClosest(points, k)
    fmt.Println(res) // Output: [[2 2] [3 3]] або подібне
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthLargestElementInArray.Sorting
    set output_file "FindKthLargestSort"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func findKthLargest(nums []int, k int) int {
    sort.Ints(nums)
    return nums[len(nums)-k]
}

func main() {
    nums := []int{3,2,1,5,6,4}
    k := 2
    fmt.Println(findKthLargest(nums, k)) // Output: 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthLargestElementInArray.Min-Heap
    set output_file "FindKthLargestHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

func findKthLargest(nums []int, k int) int {
    // Створюємо мін-купу (пріоритетну чергу)
    minHeap := pq.NewWith(utils.IntComparator)

    // Зберігаємо у купі лише k найбільших елементів
    for _, num := range nums {
        minHeap.Enqueue(num)
        if minHeap.Size() > k {
            minHeap.Dequeue()
        }
    }

    // Найменший у купі тепер є k-м найбільшим у масиві
    val, _ := minHeap.Peek()
    return val.(int)
}

func main() {
    nums := []int{3,2,3,1,2,4,5,5,6}
    k := 4
    fmt.Println(findKthLargest(nums, k)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthLargestElementInArray.QuickSelect
    set output_file "FindKthLargestQuickSelect"

    set template_content "package main

import \"fmt\"

// QuickSelect — знаходимо k-й найбільший елемент за O(n) у середньому
func findKthLargest(nums []int, k int) int {
    k = len(nums) - k

    var quickSelect func(l, r int) int
    quickSelect = func(l, r int) int {
        pivot, p := nums[r], l
        for i := l; i < r; i++ {
            if nums[i] <= pivot {
                nums[p], nums[i] = nums[i], nums[p]
                p++
            }
        }
        nums[p], nums[r] = nums[r], nums[p]

        if p > k {
            return quickSelect(l, p-1)
        } else if p < k {
            return quickSelect(p+1, r)
        } else {
            return nums[p]
        }
    }

    return quickSelect(0, len(nums)-1)
}

func main() {
    nums := []int{3,2,1,5,6,4}
    k := 2
    fmt.Println(findKthLargest(nums, k)) // Output: 5
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.KthLargestElementInArray.QuickSelect_Optimal
    set output_file "FindKthLargestQuickSelect"

    set template_content "package main

import (
    \"fmt\"
)

func findKthLargest(nums []int, k int) int {
    var partition func(left, right int) int
    partition = func(left, right int) int {
        mid := (left + right) >> 1
        nums[mid], nums[left+1] = nums[left+1], nums[mid]

        if nums[left] < nums[right] {
            nums[left], nums[right] = nums[right], nums[left]
        }
        if nums[left+1] < nums[right] {
            nums[left+1], nums[right] = nums[right], nums[left+1]
        }
        if nums[left] < nums[left+1] {
            nums[left], nums[left+1] = nums[left+1], nums[left]
        }

        pivot := nums[left+1]
        i := left + 1
        j := right

        for {
            for i++; nums[i] > pivot; i++ {}
            for j--; nums[j] < pivot; j-- {}
            if i > j {
                break
            }
            nums[i], nums[j] = nums[j], nums[i]
        }

        nums[left+1], nums[j] = nums[j], nums[left+1]
        return j
    }

    quickSelect := func(k int) int {
        left := 0
        right := len(nums) - 1

        for {
            if right <= left+1 {
                if right == left+1 && nums[right] > nums[left] {
                    nums[left], nums[right] = nums[right], nums[left]
                }
                return nums[k]
            }

            j := partition(left, right)

            if j >= k {
                right = j - 1
            }
            if j <= k {
                left = j + 1
            }
        }
    }

    return quickSelect(k - 1)
}

func main() {
    nums := []int{3,2,1,5,6,4}
    k := 2
    fmt.Println(findKthLargest(nums, k)) // Output: 5

    nums2 := []int{3,2,3,1,2,4,5,5,6}
    k2 := 4
    fmt.Println(findKthLargest(nums2, k2)) // Output: 4
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TaskScheduler.BruteForce
    set output_file "LeastInterval"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Обчислення мінімального часу для виконання завдань з cooldown n
 */
func leastInterval(tasks []byte, n int) int {
    count := make([]int, 26)
    for _, task := range tasks {
        count[task-'A']++
    }

    arr := [][]int{}
    for i := 0; i < 26; i++ {
        if count[i] > 0 {
            arr = append(arr, []int{count[i], i})
        }
    }

    time := 0
    processed := []int{}
    for len(arr) > 0 {
        maxi := -1
        for i := 0; i < len(arr); i++ {
            canProcess := true
            for j := max(0, time-n); j < time && canProcess; j++ {
                if processed[j] == arr[i][1] {
                    canProcess = false
                }
            }
            if canProcess && (maxi == -1 || arr[maxi][0] < arr[i][0]) {
                maxi = i
            }
        }

        time++
        cur := -1
        if maxi != -1 {
            cur = arr[maxi][1]
            arr[maxi][0]--
            if arr[maxi][0] == 0 {
                arr = append(arr[:maxi], arr[maxi+1:]...)
            }
        }
        processed = append(processed, cur)
    }
    return time
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    tasks := []byte{'A','A','A','B','B','B'}
    n := 2
    fmt.Println(leastInterval(tasks, n)) // Output: 8

    tasks2 := []byte{'A','A','A','B','B','B'}
    n2 := 0
    fmt.Println(leastInterval(tasks2, n2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TaskScheduler.Max-Heap
    set output_file "LeastIntervalHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
)

func leastInterval(tasks []byte, n int) int {
    count := make(map[byte]int)
    for _, task := range tasks {
        count[task]++
    }

    maxHeap := pq.NewWith(func(a, b interface{}) int {
        return b.(int) - a.(int)
    })
    for _, cnt := range count {
        maxHeap.Enqueue(cnt)
    }

    time := 0
    q := make([][2]int, 0)

    for maxHeap.Size() > 0 || len(q) > 0 {
        time++

        if maxHeap.Size() == 0 {
            time = q[0][1]
        } else {
            cnt, _ := maxHeap.Dequeue()
            cnt = cnt.(int) - 1
            if cnt.(int) > 0 {
                q = append(q, [2]int{cnt.(int), time + n})
            }
        }

        if len(q) > 0 && q[0][1] == time {
            maxHeap.Enqueue(q[0][0])
            q = q[1:]
        }
    }

    return time
}

func main() {
    tasks := []byte{'A','A','A','B','B','B'}
    n := 2
    fmt.Println(leastInterval(tasks, n)) // Output: 8

    tasks2 := []byte{'A','A','A','B','B','B'}
    n2 := 0
    fmt.Println(leastInterval(tasks2, n2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TaskScheduler.Greedy
    set output_file "TaskScheduler"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func leastInterval(tasks []byte, n int) int {
    count := make([]int, 26)
    for _, task := range tasks {
        count[task-'A']++
    }

    sort.Ints(count)
    maxf := count[25]
    idle := (maxf - 1) * n

    for i := 24; i >= 0; i-- {
        idle -= min(maxf-1, count[i])
    }

    return max(0, idle) + len(tasks)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    tasks := []byte{'A','A','A','B','B','B'}
    n := 2
    fmt.Println(leastInterval(tasks, n)) // Output: 8

    tasks2 := []byte{'A','A','A','B','B','B'}
    n2 := 0
    fmt.Println(leastInterval(tasks2, n2)) // Output: 6
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.TaskScheduler.Math
    set output_file "TaskSchedulerOptimized"

    set template_content "package main

import \"fmt\"

func leastInterval(tasks []byte, n int) int {
    count := make([]int, 26)
    for _, task := range tasks {
        count[task-'A']++
    }

    maxf := 0
    for _, cnt := range count {
        if cnt > maxf {
            maxf = cnt
        }
    }

    maxCount := 0
    for _, cnt := range count {
        if cnt == maxf {
            maxCount++
        }
    }

    time := (maxf - 1) * (n + 1) + maxCount
    if len(tasks) > time {
        return len(tasks)
    }
    return time
}

func main() {
    tasks1 := []byte{'A','A','A','B','B','B'}
    n1 := 2
    fmt.Println(leastInterval(tasks1, n1)) // Output: 8

    tasks2 := []byte{'A','A','A','B','B','B'}
    n2 := 0
    fmt.Println(leastInterval(tasks2, n2)) // Output: 6

    tasks3 := []byte{'A','A','A','B','B','B','C','C'}
    n3 := 2
    fmt.Println(leastInterval(tasks3, n3)) // Output: 8
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DesignTwitter.Sorting
    set output_file "TwitterFish"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type Twitter struct {
    time      int
    followMap map[int]map[int]bool
    tweetMap  map[int][]Tweet
}

type Tweet struct {
    time    int
    tweetId int
}

func Constructor() Twitter {
    return Twitter{
        time:      0,
        followMap: make(map[int]map[int]bool),
        tweetMap:  make(map[int][]Tweet),
    }
}

func (this *Twitter) PostTweet(userId int, tweetId int) {
    this.tweetMap[userId] = append(this.tweetMap[userId], Tweet{this.time, tweetId})
    this.time++
}

func (this *Twitter) GetNewsFeed(userId int) []int {
    feed := append([]Tweet{}, this.tweetMap[userId]...)

    if follows, ok := this.followMap[userId]; ok {
        for followeeId := range follows {
            feed = append(feed, this.tweetMap[followeeId]...)
        }
    }

    sort.Slice(feed, func(i, j int) bool {
        return feed[i].time > feed[j].time
    })

    result := []int{}
    for i := 0; i < len(feed) && i < 10; i++ {
        result = append(result, feed[i].tweetId)
    }
    return result
}

func (this *Twitter) Follow(followerId int, followeeId int) {
    if followerId == followeeId { return }
    if this.followMap[followerId] == nil {
        this.followMap[followerId] = make(map[int]bool)
    }
    this.followMap[followerId][followeeId] = true
}

func (this *Twitter) Unfollow(followerId int, followeeId int) {
    if follows, ok := this.followMap[followerId]; ok {
        delete(follows, followeeId)
    }
}

func main() {
    twitter := Constructor()
    twitter.PostTweet(1, 5)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [5]
    twitter.Follow(1, 2)
    twitter.PostTweet(2, 6)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [6, 5]
    twitter.Unfollow(1, 2)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [5]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DesignTwitter.Heap
    set output_file "TwitterHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
)

type Twitter struct {
    count     int
    tweetMap  map[int][][]int
    followMap map[int]map[int]bool
}

func Constructor() Twitter {
    return Twitter{
        count:     0,
        tweetMap:  make(map[int][][]int),
        followMap: make(map[int]map[int]bool),
    }
}

func (this *Twitter) PostTweet(userId int, tweetId int) {
    if this.tweetMap[userId] == nil {
        this.tweetMap[userId] = make([][]int, 0)
    }
    this.tweetMap[userId] = append(this.tweetMap[userId], []int{this.count, tweetId})
    this.count--
}

func (this *Twitter) GetNewsFeed(userId int) []int {
    res := []int{}
    minHeap := pq.NewWith(func(a, b interface{}) int {
        return a.([]int)[0] - b.([]int)[0]
    })

    if this.followMap[userId] == nil {
        this.followMap[userId] = make(map[int]bool)
    }
    this.followMap[userId][userId] = true

    for followeeId := range this.followMap[userId] {
        tweets := this.tweetMap[followeeId]
        if len(tweets) > 0 {
            index := len(tweets) - 1
            count, tweetId := tweets[index][0], tweets[index][1]
            minHeap.Enqueue([]int{count, tweetId, followeeId, index - 1})
        }
    }

    for minHeap.Size() > 0 && len(res) < 10 {
        item, _ := minHeap.Dequeue()
        curr := item.([]int)
        count, tweetId, followeeId, index := curr[0], curr[1], curr[2], curr[3]

        res = append(res, tweetId)

        if index >= 0 {
            tweets := this.tweetMap[followeeId]
            count, tweetId = tweets[index][0], tweets[index][1]
            minHeap.Enqueue([]int{count, tweetId, followeeId, index - 1})
        }
    }

    return res
}

func (this *Twitter) Follow(followerId int, followeeId int) {
    if this.followMap[followerId] == nil {
        this.followMap[followerId] = make(map[int]bool)
    }
    this.followMap[followerId][followeeId] = true
}

func (this *Twitter) Unfollow(followerId int, followeeId int) {
    if this.followMap[followerId] != nil {
        delete(this.followMap[followerId], followeeId)
    }
}

func main() {
    twitter := Constructor()
    twitter.PostTweet(1, 5)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [5]
    twitter.Follow(1, 2)
    twitter.PostTweet(2, 6)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [6, 5]
    twitter.Unfollow(1, 2)
    fmt.Println(twitter.GetNewsFeed(1)) // Output: [5]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.DesignTwitter.HeapOptimal
    set output_file "TwitterHeap"

    set template_content "package main

import (
    \"fmt\"
    pq \"github.com/emirpasic/gods/queues/priorityqueue\"
)

type Twitter struct {
    count     int
    tweetMap  map[int][][2]int
    followMap map[int]map[int]bool
}

func Constructor() Twitter {
    return Twitter{
        count:     0,
        tweetMap:  make(map[int][][2]int),
        followMap: make(map[int]map[int]bool),
    }
}

func (t *Twitter) PostTweet(userId int, tweetId int) {
    if _, exists := t.tweetMap[userId]; !exists {
        t.tweetMap[userId] = make([][2]int, 0, 10)
    }
    t.tweetMap[userId] = append(t.tweetMap[userId], [2]int{t.count, tweetId})
    if len(t.tweetMap[userId]) > 10 {
        t.tweetMap[userId] = t.tweetMap[userId][1:]
    }
    t.count--
}

func maxHeapComparator(a, b interface{}) int {
    A := a.([]int)
    B := b.([]int)
    switch {
    case A[0] < B[0]:
        return -1
    case A[0] > B[0]:
        return 1
    default:
        return 0
    }
}

func minHeapComparator(a, b interface{}) int {
    A := a.([]int)
    B := b.([]int)
    switch {
    case A[0] < B[0]:
        return -1
    case A[0] > B[0]:
        return 1
    default:
        return 0
    }
}

func (t *Twitter) GetNewsFeed(userId int) []int {
    res := []int{}
    if _, ok := t.followMap[userId]; !ok {
        t.followMap[userId] = make(map[int]bool)
    }
    t.followMap[userId][userId] = true
    minHeap := pq.NewWith(minHeapComparator)

    if len(t.followMap[userId]) >= 10 {
        maxHeap := pq.NewWith(maxHeapComparator)
        for fId := range t.followMap[userId] {
            if tweets, exists := t.tweetMap[fId]; exists && len(tweets) > 0 {
                idx := len(tweets) - 1
                c := tweets[idx][0]
                tId := tweets[idx][1]
                maxHeap.Enqueue([]int{-c, tId, fId, idx - 1})
                if maxHeap.Size() > 10 {
                    maxHeap.Dequeue()
                }
            }
        }

        for !maxHeap.Empty() {
            item, _ := maxHeap.Dequeue()
            arr := item.([]int)
            negCount := arr[0]
            tId := arr[1]
            fId := arr[2]
            nextIdx := arr[3]
            realCount := -negCount
            minHeap.Enqueue([]int{realCount, tId, fId, nextIdx})
        }
    } else {
        for fId := range t.followMap[userId] {
            if tweets, exists := t.tweetMap[fId]; exists && len(tweets) > 0 {
                idx := len(tweets) - 1
                c := tweets[idx][0]
                tId := tweets[idx][1]
                minHeap.Enqueue([]int{c, tId, fId, idx - 1})
            }
        }
    }

    for !minHeap.Empty() && len(res) < 10 {
        top, _ := minHeap.Dequeue()
        arr := top.([]int)
        tId := arr[1]
        fId := arr[2]
        nextIdx := arr[3]

        res = append(res, tId)
        if nextIdx >= 0 {
            older := t.tweetMap[fId][nextIdx]
            minHeap.Enqueue([]int{older[0], older[1], fId, nextIdx - 1})
        }
    }

    return res
}

func (t *Twitter) Follow(followerId, followeeId int) {
    if _, ok := t.followMap[followerId]; !ok {
        t.followMap[followerId] = make(map[int]bool)
    }
    t.followMap[followerId][followeeId] = true
}

func (t *Twitter) Unfollow(followerId, followeeId int) {
    if _, ok := t.followMap[followerId]; ok {
        delete(t.followMap[followerId], followeeId)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Subsets.Backtracking
    set output_file "Subsets"

    set template_content "package main

import \"fmt\"

func subsets(nums []int) [][]int {
    res := [][]int{}
    subset := []int{}

    var dfs func(int)
    dfs = func(i int) {
        if i >= len(nums) {
            temp := make([]int, len(subset))
            copy(temp, subset)
            res = append(res, temp)
            return
        }
        subset = append(subset, nums[i])
        dfs(i + 1)
        subset = subset[:len(subset)-1]
        dfs(i + 1)
    }

    dfs(0)
    return res
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(subsets(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.Subsets.Iteration
    set output_file "SubsetsIterative"

    set template_content "package main

import \"fmt\"

func subsets(nums []int) [][]int {
    res := [][]int{{}}

    for _, num := range nums {
        n := len(res)
        for i := 0; i < n; i++ {
            newSubset := make([]int, len(res[i]))
            copy(newSubset, res[i])
            newSubset = append(newSubset, num)
            res = append(res, newSubset)
        }
    }

    return res
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(subsets(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Subsets.BitManipulation
    set output_file "SubsetsBitmask"

    set template_content "package main

import \"fmt\"

func subsets(nums []int) [][]int {
    n := len(nums)
    res := [][]int{}

    for i := 0; i < (1 << n); i++ {
        subset := []int{}
        for j := 0; j < n; j++ {
            if (i & (1 << j)) != 0 {
                subset = append(subset, nums[j])
            }
        }
        res = append(res, subset)
    }

    return res
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(subsets(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSum.Backtracking
    set output_file "CombinationSum"

    set template_content "package main

import \"fmt\"

func combinationSum(nums []int, target int) [][]int {
    res := [][]int{}

    var dfs func(int, []int, int)
    dfs = func(i int, cur []int, total int) {
        if total == target {
            temp := make([]int, len(cur))
            copy(temp, cur)
            res = append(res, temp)
            return
        }
        if i >= len(nums) || total > target {
            return
        }

        cur = append(cur, nums[i])
        dfs(i, cur, total + nums[i])
        cur = cur[:len(cur)-1]
        dfs(i+1, cur, total)
    }

    dfs(0, []int{}, 0)
    return res
}

func main() {
    nums := []int{2, 3, 6, 7}
    target := 7
    fmt.Println(combinationSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSum.BacktrackingOptimal
    set output_file "CombinationSumOptimized"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func combinationSum(nums []int, target int) [][]int {
    res := [][]int{}
    sort.Ints(nums)

    var dfs func(int, []int, int)
    dfs = func(i int, cur []int, total int) {
        if total == target {
            temp := make([]int, len(cur))
            copy(temp, cur)
            res = append(res, temp)
            return
        }

        for j := i; j < len(nums); j++ {
            if total + nums[j] > target {
                return
            }
            cur = append(cur, nums[j])
            dfs(j, cur, total + nums[j])
            cur = cur[:len(cur)-1]
        }
    }

    dfs(0, []int{}, 0)
    return res
}

func main() {
    nums := []int{2, 3, 6, 7}
    target := 7
    fmt.Println(combinationSum(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSumII.BruteForce
    set output_file "CombinationSum2"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func combinationSum2(candidates []int, target int) [][]int {
    res := [][]int{}
    sort.Ints(candidates)

    var dfs func(int, []int, int)
    dfs = func(start int, cur []int, total int) {
        if total == target {
            temp := make([]int, len(cur))
            copy(temp, cur)
            res = append(res, temp)
            return
        }
        if total > target {
            return
        }

        for i := start; i < len(candidates); i++ {
            if i > start && candidates[i] == candidates[i-1] {
                continue
            }
            dfs(i+1, append(cur, candidates[i]), total + candidates[i])
        }
    }

    dfs(0, []int{}, 0)
    return res
}

func main() {
    candidates := []int{10,1,2,7,6,1,5}
    target := 8
    fmt.Println(combinationSum2(candidates, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSumII.Backtracking
    set output_file "CombinationSum2"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func combinationSum2(candidates []int, target int) [][]int {
    res := [][]int{}
    sort.Ints(candidates)

    var dfs func(int, []int, int)
    dfs = func(i int, cur []int, total int) {
        if total == target {
            temp := make([]int, len(cur))
            copy(temp, cur)
            res = append(res, temp)
            return
        }
        if total > target || i == len(candidates) {
            return
        }

        cur = append(cur, candidates[i])
        dfs(i+1, cur, total + candidates[i])
        cur = cur[:len(cur)-1]

        for i+1 < len(candidates) && candidates[i] == candidates[i+1] {
            i++
        }
        dfs(i+1, cur, total)
    }

    dfs(0, []int{}, 0)
    return res
}

func main() {
    candidates := []int{10,1,2,7,6,1,5}
    target := 8
    fmt.Println(combinationSum2(candidates, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSumII.Backtracking_HashMap

    set output_file "CombinationSum2"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func combinationSum2(nums []int, target int) [][]int {
    res := [][]int{}
    count := map[int]int{}
    uniqueNums := []int{}
    for _, num := range nums {
        if count[num] == 0 {
            uniqueNums = append(uniqueNums, num)
        }
        count[num]++
    }
    sort.Ints(uniqueNums)

    var backtrack func(int, int, []int)
    backtrack = func(target int, i int, cur []int) {
        if target == 0 {
            temp := make([]int, len(cur))
            copy(temp, cur)
            res = append(res, temp)
            return
        }
        if target < 0 || i >= len(uniqueNums) {
            return
        }

        if count[uniqueNums[i]] > 0 {
            cur = append(cur, uniqueNums[i])
            count[uniqueNums[i]]--
            backtrack(target - uniqueNums[i], i, cur)
            count[uniqueNums[i]]++
            cur = cur[:len(cur)-1]
        }

        backtrack(target, i+1, cur)
    }

    backtrack(target, 0, []int{})
    return res
}

func main() {
    nums := []int{10,1,2,7,6,1,5}
    target := 8
    fmt.Println(combinationSum2(nums, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CombinationSumII.BacktrackingOptimal
    set output_file "CombinationSum2"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func combinationSum2(candidates []int, target int) [][]int {
    var res [][]int
    sort.Ints(candidates)

    var dfs func(int, []int, int)
    dfs = func(idx int, path []int, cur int) {
        if cur == target {
            temp := make([]int, len(path))
            copy(temp, path)
            res = append(res, temp)
            return
        }

        for i := idx; i < len(candidates); i++ {
            if i > idx && candidates[i] == candidates[i-1] {
                continue
            }
            if cur + candidates[i] > target {
                break
            }

            path = append(path, candidates[i])
            dfs(i+1, path, cur + candidates[i])
            path = path[:len(path)-1]
        }
    }

    dfs(0, []int{}, 0)
    return res
}

func main() {
    candidates := []int{10,1,2,7,6,1,5}
    target := 8
    fmt.Println(combinationSum2(candidates, target))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Permutations.Recursion
    set output_file "Permute"

    set template_content "package main

import (
    \"fmt\"
)

func permute(nums []int) [][]int {
    if len(nums) == 0 {
        return [][]int{{}}
    }

    perms := permute(nums[1:])
    var res [][]int
    for _, p := range perms {
        for i := 0; i <= len(p); i++ {
            pCopy := append([]int{}, p...)
            pCopy = append(pCopy[:i], append([]int{nums[0]}, pCopy[i:]...)...)
            res = append(res, pCopy)
        }
    }
    return res
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(permute(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Permutations.Iteration
    set output_file "PermuteIterative"

    set template_content "package main

import (
    \"fmt\"
)

func permute(nums []int) [][]int {
    perms := [][]int{{}}

    for _, num := range nums {
        var newPerms [][]int
        for _, p := range perms {
            for i := 0; i <= len(p); i++ {
                pCopy := append([]int{}, p...)
                pCopy = append(pCopy[:i], append([]int{num}, pCopy[i:]...)...)
                newPerms = append(newPerms, pCopy)
            }
        }
        perms = newPerms
    }

    return perms
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(permute(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Permutations.Backtracking
    set output_file "PermuteBacktrack"

    set template_content "package main

import (
    \"fmt\"
)

func permute(nums []int) [][]int {
    var res [][]int
    backtrack(&res, []int{}, nums, make([]bool, len(nums)))
    return res
}

func backtrack(res *[][]int, perm []int, nums []int, pick []bool) {
    if len(perm) == len(nums) {
        temp := append([]int{}, perm...)
        *res = append(*res, temp)
        return
    }
    for i := 0; i < len(nums); i++ {
        if !pick[i] {
            perm = append(perm, nums[i])
            pick[i] = true
            backtrack(res, perm, nums, pick)
            perm = perm[:len(perm)-1]
            pick[i] = false
        }
    }
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(permute(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Permutations.Backtracking_BitMask
    set output_file "PermuteBitmask"

    set template_content "package main

import (
    \"fmt\"
)

func permute(nums []int) [][]int {
    var res [][]int
    backtrack(&res, []int{}, nums, 0)
    return res
}

func backtrack(res *[][]int, perm []int, nums []int, mask int) {
    if len(perm) == len(nums) {
        temp := append([]int{}, perm...)
        *res = append(*res, temp)
        return
    }
    for i := 0; i < len(nums); i++ {
        if mask&(1<<i) == 0 {
            perm = append(perm, nums[i])
            backtrack(res, perm, nums, mask|(1<<i))
            perm = perm[:len(perm)-1]
        }
    }
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(permute(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Permutations.Backtracking_Optimal
    set output_file "PermuteSwap"

    set template_content "package main

import (
    \"fmt\"
)

func permute(nums []int) [][]int {
    var res [][]int
    backtrack(&res, nums, 0)
    return res
}

func backtrack(res *[][]int, nums []int, idx int) {
    if idx == len(nums) {
        temp := append([]int{}, nums...)
        *res = append(*res, temp)
        return
    }
    for i := idx; i < len(nums); i++ {
        nums[idx], nums[i] = nums[i], nums[idx]
        backtrack(res, nums, idx+1)
        nums[idx], nums[i] = nums[i], nums[idx]
    }
}

func main() {
    nums := []int{1, 2, 3}
    fmt.Println(permute(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SubsetsII.BruteForce
    set output_file "SubsetsDupMap.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func subsetsWithDup(nums []int) [][]int {
    sort.Ints(nums)
    res := make(map[string][]int)

    var backtrack func(int, []int)
    backtrack = func(i int, subset []int) {
        if i == len(nums) {
            key := fmt.Sprint(subset)
            res[key] = append([]int{}, subset...)
            return
        }

        subset = append(subset, nums[i])
        backtrack(i+1, subset)
        subset = subset[:len(subset)-1]
        backtrack(i+1, subset)
    }

    backtrack(0, []int{})

    var result [][]int
    for _, v := range res {
        result = append(result, v)
    }
    return result
}

func main() {
    nums := []int{1, 2, 2}
    fmt.Println(subsetsWithDup(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SubsetsII.Backtracking-I
    set output_file "SubsetsDup.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func subsetsWithDup(nums []int) [][]int {
    var res [][]int
    sort.Ints(nums)

    var backtrack func(int, []int)
    backtrack = func(i int, subset []int) {
        if i == len(nums) {
            res = append(res, append([]int{}, subset...))
            return
        }

        subset = append(subset, nums[i])
        backtrack(i+1, subset)
        subset = subset[:len(subset)-1]

        for i+1 < len(nums) && nums[i] == nums[i+1] {
            i++
        }

        backtrack(i+1, subset)
    }

    backtrack(0, []int{})
    return res
}

func main() {
    nums := []int{1, 2, 2}
    fmt.Println(subsetsWithDup(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SubsetsII.Backtracking-II
    set output_file "SubsetsDup.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func subsetsWithDup(nums []int) [][]int {
    var res [][]int
    sort.Ints(nums)

    var backtrack func(int, []int)
    backtrack = func(i int, subset []int) {
        res = append(res, append([]int{}, subset...))

        for j := i; j < len(nums); j++ {
            if j > i && nums[j] == nums[j-1] {
                continue
            }
            subset = append(subset, nums[j])
            backtrack(j+1, subset)
            subset = subset[:len(subset)-1]
        }
    }

    backtrack(0, []int{})
    return res
}

func main() {
    nums := []int{1, 2, 2}
    fmt.Println(subsetsWithDup(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.SubsetsII.Iteration
    set output_file "SubsetsDupIter.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func subsetsWithDup(nums []int) [][]int {
    sort.Ints(nums)
    res := [][]int{{}}
    prevIdx, idx := 0, 0

    for i := 0; i < len(nums); i++ {
        if i > 0 && nums[i] == nums[i-1] {
            idx = prevIdx
        } else {
            idx = 0
        }
        prevIdx = len(res)
        for j := idx; j < prevIdx; j++ {
            tmp := append([]int{}, res[j]...)
            tmp = append(tmp, nums[i])
            res = append(res, tmp)
        }
    }

    return res
}

func main() {
    nums := []int{1, 2, 2}
    fmt.Println(subsetsWithDup(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GenerateParentheses.BruteForce
    set output_file "GenerateParenthesis.go"

    set template_content "package main

import (
    \"fmt\"
)

func generateParenthesis(n int) []string {
    res := make([]string, 0)

    var valid func(string) bool
    valid = func(s string) bool {
        open := 0
        for _, c := range s {
            if c == '(' {
                open++
            } else {
                open--
            }
            if open < 0 {
                return false
            }
        }
        return open == 0
    }

    var dfs func(string)
    dfs = func(s string) {
        if len(s) == n*2 {
            if valid(s) {
                res = append(res, s)
            }
            return
        }

        dfs(s + \"(\")
        dfs(s + \")\")
    }

    dfs(\"\")
    return res
}

func main() {
    n := 3
    fmt.Println(generateParenthesis(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GenerateParentheses.Backtracking
    set output_file "GenerateParenthesisOpt.go"

    set template_content "package main

import (
    \"fmt\"
    \"strings\"
)

func generateParenthesis(n int) []string {
    stack := make([]string, 0)
    res := make([]string, 0)

    var backtrack func(int, int)
    backtrack = func(openN, closedN int) {
        if openN == n && closedN == n {
            res = append(res, strings.Join(stack, \"\"))
            return
        }

        if openN < n {
            stack = append(stack, \"(\")
            backtrack(openN+1, closedN)
            stack = stack[:len(stack)-1]
        }

        if closedN < openN {
            stack = append(stack, \")\")
            backtrack(openN, closedN+1)
            stack = stack[:len(stack)-1]
        }
    }

    backtrack(0, 0)
    return res
}

func main() {
    n := 3
    fmt.Println(generateParenthesis(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GenerateParentheses.DynamicProgramming
    set output_file "GenerateParenthesisDP.go"

    set template_content "package main

import \"fmt\"

func generateParenthesis(n int) []string {
    res := make([][]string, n+1)
    res[0] = []string{\"\"}

    for k := 1; k <= n; k++ {
        res[k] = make([]string, 0)
        for i := 0; i < k; i++ {
            for _, left := range res[i] {
                for _, right := range res[k-i-1] {
                    res[k] = append(res[k], \"(\" + left + \")\" + right)
                }
            }
        }
    }

    return res[n]
}

func main() {
    n := 3
    fmt.Println(generateParenthesis(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordSearch.Backtracking_HashSet
    set output_file "WordSearch.go"

    set template_content "package main

import \"fmt\"

func exist(board [][]byte, word string) bool {
    rows, cols := len(board), len(board[0])
    path := make(map[[2]int]bool)

    var dfs func(r, c, i int) bool
    dfs = func(r, c, i int) bool {
        if i == len(word) {
            return true
        }
        if r < 0 || c < 0 || r >= rows || c >= cols ||
            board[r][c] != word[i] || path[[2]int{r, c}] {
            return false
        }

        path[[2]int{r, c}] = true
        res := dfs(r+1, c, i+1) ||
               dfs(r-1, c, i+1) ||
               dfs(r, c+1, i+1) ||
               dfs(r, c-1, i+1)
        delete(path, [2]int{r, c})

        return res
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if dfs(r, c, 0) {
                return true
            }
        }
    }
    return false
}

func main() {
    board := [][]byte{
        {'A', 'B', 'C', 'E'},
        {'S', 'F', 'C', 'S'},
        {'A', 'D', 'E', 'E'},
    }
    word := \"ABCCED\"
    fmt.Println(exist(board, word)) // true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordSearch.Backtracking_VisitedArray
    set output_file "WordSearch"

    set template_content "package main

import \"fmt\"

func exist(board [][]byte, word string) bool {
    rows, cols := len(board), len(board[0])
    visited := make([][]bool, rows)
    for i := range visited {
        visited[i] = make([]bool, cols)
    }

    var dfs func(int, int, int) bool
    dfs = func(r, c, i int) bool {
        if i == len(word) {
            return true
        }
        if r < 0 || c < 0 || r >= rows || c >= cols || board[r][c] != word[i] || visited[r][c] {
            return false
        }

        visited[r][c] = true
        res := dfs(r+1, c, i+1) ||
               dfs(r-1, c, i+1) ||
               dfs(r, c+1, i+1) ||
               dfs(r, c-1, i+1)
        visited[r][c] = false

        return res
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if dfs(r, c, 0) {
                return true
            }
        }
    }
    return false
}

func main() {
    board := [][]byte{
        {'A','B','C','E'},
        {'S','F','C','S'},
        {'A','D','E','E'},
    }
    fmt.Println(exist(board, \"ABCCED\")) // true
    fmt.Println(exist(board, \"SEE\"))    // true
    fmt.Println(exist(board, \"ABCB\"))   // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.WordSearch.Backtracking_Optimal
    set output_file "WordSearchInPlace"

    set template_content "package main

import \"fmt\"

func exist(board [][]byte, word string) bool {
    rows, cols := len(board), len(board[0])

    var dfs func(int, int, int) bool
    dfs = func(r, c, i int) bool {
        if i == len(word) {
            return true
        }
        if r < 0 || c < 0 || r >= rows || c >= cols || board[r][c] != word[i] || board[r][c] == '#' {
            return false
        }

        temp := board[r][c]
        board[r][c] = '#'
        res := dfs(r+1, c, i+1) ||
               dfs(r-1, c, i+1) ||
               dfs(r, c+1, i+1) ||
               dfs(r, c-1, i+1)
        board[r][c] = temp

        return res
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if dfs(r, c, 0) {
                return true
            }
        }
    }
    return false
}

func main() {
    board := [][]byte{
        {'A','B','C','E'},
        {'S','F','C','S'},
        {'A','D','E','E'},
    }
    fmt.Println(exist(board, \"ABCCED\")) // true
    fmt.Println(exist(board, \"SEE\"))    // true
    fmt.Println(exist(board, \"ABCB\"))   // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PalindromePartitioning.Backtracking-I
    set output_file "PalindromePartition"

    set template_content "package main

import \"fmt\"

func partition(s string) [][]string {
    res := [][]string{}
    part := []string{}

    var dfs func(j, i int)
    dfs = func(j, i int) {
        if i >= len(s) {
            if i == j {
                res = append(res, append([]string{}, part...))
            }
            return
        }

        if isPali(s, j, i) {
            part = append(part, s[j:i+1])
            dfs(i+1, i+1)
            part = part[:len(part)-1]
        }

        dfs(j, i+1)
    }

    dfs(0, 0)
    return res
}

func isPali(s string, l, r int) bool {
    for l < r {
        if s[l] != s[r] {
            return false
        }
        l++
        r--
    }
    return true
}

func main() {
    fmt.Println(partition(\"aab\")) // [["a","a","b"],["aa","b"]]
    fmt.Println(partition(\"a\"))   // [["a"]]
    fmt.Println(partition(\"abc\")) // [["a","b","c"]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PalindromePartitioning.Backtracking-II
    set output_file "PalindromePartition"

    set template_content "package main

import \"fmt\"

func partition(s string) [][]string {
    res := [][]string{}
    part := []string{}

    var dfs func(i int)
    dfs = func(i int) {
        if i >= len(s) {
            res = append(res, append([]string{}, part...))
            return
        }
        for j := i; j < len(s); j++ {
            if isPali(s, i, j) {
                part = append(part, s[i:j+1])
                dfs(j + 1)
                part = part[:len(part)-1]
            }
        }
    }

    dfs(0)
    return res
}

func isPali(s string, l, r int) bool {
    for l < r {
        if s[l] != s[r] {
            return false
        }
        l++
        r--
    }
    return true
}

func main() {
    fmt.Println(partition(\"aab\")) // [["a","a","b"],["aa","b"]]
    fmt.Println(partition(\"a\"))   // [["a"]]
    fmt.Println(partition(\"abc\")) // [["a","b","c"]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PalindromePartitioning.Backtracking_DP
    set output_file "PalindromePartitionDP"

    set template_content "package main

import \"fmt\"

func partition(s string) [][]string {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for l := 1; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            dp[i][i+l-1] = (s[i] == s[i+l-1] && (i+1 > i+l-2 || dp[i+1][i+l-2]))
        }
    }

    res := [][]string{}
    part := []string{}

    var dfs func(i int)
    dfs = func(i int) {
        if i >= n {
            res = append(res, append([]string{}, part...))
            return
        }
        for j := i; j < n; j++ {
            if dp[i][j] {
                part = append(part, s[i:j+1])
                dfs(j + 1)
                part = part[:len(part)-1]
            }
        }
    }

    dfs(0)
    return res
}

func main() {
    fmt.Println(partition(\"aab\")) // [["a","a","b"],["aa","b"]]
    fmt.Println(partition(\"a\"))   // [["a"]]
    fmt.Println(partition(\"abc\")) // [["a","b","c"]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PalindromePartitioning.Recursion
    set output_file "PalindromePartitionDP"

    set template_content "package main

import \"fmt\"

func partition(s string) [][]string {
    n := len(s)
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for l := 1; l <= n; l++ {
        for i := 0; i <= n-l; i++ {
            dp[i][i+l-1] = (s[i] == s[i+l-1] &&
                            (i+1 > (i+l-2) || dp[i+1][i+l-2]))
        }
    }

    var dfs func(i int) [][]string
    dfs = func(i int) [][]string {
        if i >= n {
            return [][]string{{}}
        }

        ret := [][]string{}
        for j := i; j < n; j++ {
            if dp[i][j] {
                nxt := dfs(j + 1)
                for _, part := range nxt {
                    cur := append([]string{s[i : j+1]}, part...)
                    ret = append(ret, cur)
                }
            }
        }
        return ret
    }

    return dfs(0)
}

func main() {
    fmt.Println(partition(\"aab\")) // [["a","a","b"],["aa","b"]]
    fmt.Println(partition(\"a\"))   // [["a"]]
    fmt.Println(partition(\"abc\")) // [["a","b","c"]]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LetterCombinationsOfPhoneNumber.Backtracking
    set output_file "LetterCombinations"

    set template_content "package main

import \"fmt\"

func letterCombinations(digits string) []string {
    if len(digits) == 0 {
        return []string{}
    }

    res := []string{}
    digitToChar := map[byte]string{
        '2': \"abc\",
        '3': \"def\",
        '4': \"ghi\",
        '5': \"jkl\",
        '6': \"mno\",
        '7': \"pqrs\",
        '8': \"tuv\",
        '9': \"wxyz\",
    }

    var backtrack func(i int, curStr string)
    backtrack = func(i int, curStr string) {
        if len(curStr) == len(digits) {
            res = append(res, curStr)
            return
        }
        for _, c := range digitToChar[digits[i]] {
            backtrack(i+1, curStr+string(c))
        }
    }

    backtrack(0, \"\")
    return res
}

func main() {
    fmt.Println(letterCombinations(\"23\")) // ["ad","ae","af","bd","be","bf","cd","ce","cf"]
    fmt.Println(letterCombinations(\"\"))   // []
    fmt.Println(letterCombinations(\"9\"))  // ["w","x","y","z"]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.LetterCombinationsOfPhoneNumber.Iteration
    set output_file "LetterCombinationsIter"

    set template_content "package main

import \"fmt\"

func letterCombinations(digits string) []string {
    if len(digits) == 0 {
        return []string{}
    }

    res := []string{\"\"}
    digitToChar := map[byte]string{
        '2': \"abc\",
        '3': \"def\",
        '4': \"ghi\",
        '5': \"jkl\",
        '6': \"mno\",
        '7': \"pqrs\",
        '8': \"tuv\",
        '9': \"wxyz\",
    }

    for i := 0; i < len(digits); i++ {
        digit := digits[i]
        tmp := []string{}
        for _, curStr := range res {
            for _, c := range digitToChar[digit] {
                tmp = append(tmp, curStr+string(c))
            }
        }
        res = tmp
    }
    return res
}

func main() {
    fmt.Println(letterCombinations(\"23\")) // ["ad","ae","af","bd","be","bf","cd","ce","cf"]
    fmt.Println(letterCombinations(\"\"))   // []
    fmt.Println(letterCombinations(\"9\"))  // ["w","x","y","z"]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberOfIslands.DepthFirstSearch
    set output_file "NumIslands"

    set template_content "package main

import \"fmt\"

func numIslands(grid [][]byte) int {
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    rows, cols := len(grid), len(grid[0])
    islands := 0

    var dfs func(r, c int)
    dfs = func(r, c int) {
        if r < 0 || c < 0 || r >= rows ||
           c >= cols || grid[r][c] == '0' {
            return
        }
        grid[r][c] = '0'
        for _, dir := range directions {
            dfs(r+dir[0], c+dir[1])
        }
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == '1' {
                dfs(r, c)
                islands++
            }
        }
    }

    return islands
}

func main() {
    grid := [][]byte{
        {'1','1','0','0','0'},
        {'1','1','0','0','0'},
        {'0','0','1','0','0'},
        {'0','0','0','1','1'},
    }
    fmt.Println(numIslands(grid)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.NumberOfIslands.BreadthFirstSearch
    set output_file "NumIslandsBFS"

    set template_content "package main

import \"fmt\"

func numIslands(grid [][]byte) int {
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    rows, cols := len(grid), len(grid[0])
    islands := 0

    var bfs func(r, c int)
    bfs = func(r, c int) {
        q := [][]int{{r, c}}
        grid[r][c] = '0'

        for len(q) > 0 {
            front := q[0]
            q = q[1:]
            row, col := front[0], front[1]
            for _, dir := range directions {
                nr, nc := row+dir[0], col+dir[1]
                if nr < 0 || nc < 0 || nr >= rows ||
                   nc >= cols || grid[nr][nc] == '0' {
                    continue
                }
                q = append(q, []int{nr, nc})
                grid[nr][nc] = '0'
            }
        }
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == '1' {
                bfs(r, c)
                islands++
            }
        }
    }

    return islands
}

func main() {
    grid := [][]byte{
        {'1','1','0','0','0'},
        {'1','1','0','0','0'},
        {'0','0','1','0','0'},
        {'0','0','0','1','1'},
    }
    fmt.Println(numIslands(grid)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberOfIslands.DisjointSetUnion
    set output_file "DSUIslands"

    set template_content "package main

import \"fmt\"

type DSU struct {
    Parent []int
    Size   []int
}

func NewDSU(n int) *DSU {
    dsu := &DSU{
        Parent: make([]int, n+1),
        Size:   make([]int, n+1),
    }
    for i := 0; i <= n; i++ {
        dsu.Parent[i] = i
        dsu.Size[i] = 1
    }
    return dsu
}

func (dsu *DSU) find(node int) int {
    if dsu.Parent[node] != node {
        dsu.Parent[node] = dsu.find(dsu.Parent[node])
    }
    return dsu.Parent[node]
}

func (dsu *DSU) union(u, v int) bool {
    pu := dsu.find(u)
    pv := dsu.find(v)
    if pu == pv {
        return false
    }
    if dsu.Size[pu] >= dsu.Size[pv] {
        dsu.Size[pu] += dsu.Size[pv]
        dsu.Parent[pv] = pu
    } else {
        dsu.Size[pv] += dsu.Size[pu]
        dsu.Parent[pu] = pv
    }
    return true
}

func numIslands(grid [][]byte) int {
    rows, cols := len(grid), len(grid[0])
    dsu := NewDSU(rows * cols)
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    islands := 0

    index := func(r, c int) int {
        return r*cols + c
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == '1' {
                islands++
                for _, dir := range directions {
                    nr, nc := r+dir[0], c+dir[1]
                    if nr < 0 || nc < 0 || nr >= rows ||
                       nc >= cols || grid[nr][nc] == '0' {
                        continue
                    }
                    if dsu.union(index(r, c), index(nr, nc)) {
                        islands--
                    }
                }
            }
        }
    }

    return islands
}

func main() {
    grid := [][]byte{
        {'1','1','0','0','0'},
        {'1','1','0','0','0'},
        {'0','0','1','0','0'},
        {'0','0','0','1','1'},
    }
    fmt.Println(numIslands(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaxAreaOfIsland.DepthFirstSearch
    set output_file "MaxAreaOfIsland"

    set template_content "package main

import \"fmt\"

func maxAreaOfIsland(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    visit := make(map[[2]int]bool)

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || r >= rows || c < 0 || c >= cols ||
           grid[r][c] == 0 || visit[[2]int{r, c}] {
            return 0
        }
        visit[[2]int{r, c}] = true
        return 1 + dfs(r+1, c) + dfs(r-1, c) + dfs(r, c+1) + dfs(r, c-1)
    }

    area := 0
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            area = max(area, dfs(r, c))
        }
    }
    return area
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    grid := [][]int{
        {0,0,1,0,0,0,0,1,0,0,0,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,1,1,0,1,0,0,0,0,0,0,0,0},
        {0,1,0,0,1,1,0,0,1,0,1,0,0},
        {0,1,0,0,1,1,0,0,1,1,1,0,0},
        {0,0,0,0,0,0,0,0,0,0,1,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,0,0,0,0,0,0,1,1,0,0,0,0},
    }
    fmt.Println(maxAreaOfIsland(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaxAreaOfIsland.BreadthFirstSearch
    set output_file "MaxAreaOfIslandBFS"

    set template_content "package main

import \"fmt\"

func maxAreaOfIsland(grid [][]int) int {
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    rows, cols := len(grid), len(grid[0])
    area := 0

    var bfs func(r, c int) int
    bfs = func(r, c int) int {
        q := [][]int{{r, c}}
        grid[r][c] = 0
        res := 1

        for len(q) > 0 {
            front := q[0]
            q = q[1:]
            row, col := front[0], front[1]
            for _, dir := range directions {
                nr, nc := row+dir[0], col+dir[1]
                if nr < 0 || nc < 0 || nr >= rows ||
                   nc >= cols || grid[nr][nc] == 0 {
                    continue
                }
                q = append(q, []int{nr, nc})
                grid[nr][nc] = 0
                res++
            }
        }
        return res
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                area = max(area, bfs(r, c))
            }
        }
    }
    return area
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    grid := [][]int{
        {0,0,1,0,0,0,0,1,0,0,0,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,1,1,0,1,0,0,0,0,0,0,0,0},
        {0,1,0,0,1,1,0,0,1,0,1,0,0},
        {0,1,0,0,1,1,0,0,1,1,1,0,0},
        {0,0,0,0,0,0,0,0,0,0,1,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,0,0,0,0,0,0,1,1,0,0,0,0},
    }
    fmt.Println(maxAreaOfIsland(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MaxAreaOfIsland.DisjointSetUnion
    set output_file "MaxAreaOfIslandDSU"

    set template_content "package main

import \"fmt\"

type DSU struct {
    Parent []int
    Size   []int
}

func (dsu *DSU) find(node int) int {
    if dsu.Parent[node] != node {
        dsu.Parent[node] = dsu.find(dsu.Parent[node])
    }
    return dsu.Parent[node]
}

func (dsu *DSU) union(u, v int) bool {
    pu := dsu.find(u)
    pv := dsu.find(v)
    if pu == pv {
        return false
    }
    if dsu.Size[pu] >= dsu.Size[pv] {
        dsu.Size[pu] += dsu.Size[pv]
        dsu.Parent[pv] = pu
    } else {
        dsu.Size[pv] += dsu.Size[pu]
        dsu.Parent[pu] = pv
    }
    return true
}

func (dsu *DSU) getSize(node int) int {
    par := dsu.find(node)
    return dsu.Size[par]
}

func maxAreaOfIsland(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    dsu := DSU{
        Parent: make([]int, rows*cols+1),
        Size:   make([]int, rows*cols+1),
    }

    for i := 0; i <= rows*cols; i++ {
        dsu.Parent[i] = i
        dsu.Size[i] = 1
    }

    index := func(r, c int) int {
        return r*cols + c
    }

    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    area := 0

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                for _, dir := range directions {
                    nr, nc := r+dir[0], c+dir[1]
                    if nr < 0 || nc < 0 || nr >= rows ||
                       nc >= cols || grid[nr][nc] == 0 {
                        continue
                    }
                    dsu.union(index(r, c), index(nr, nc))
                }
                area = max(area, dsu.getSize(index(r, c)))
            }
        }
    }
    return area
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    grid := [][]int{
        {0,0,1,0,0,0,0,1,0,0,0,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,1,1,0,1,0,0,0,0,0,0,0,0},
        {0,1,0,0,1,1,0,0,1,0,1,0,0},
        {0,1,0,0,1,1,0,0,1,1,1,0,0},
        {0,0,0,0,0,0,0,0,0,0,1,0,0},
        {0,0,0,0,0,0,0,1,1,1,0,0,0},
        {0,0,0,0,0,0,0,1,1,0,0,0,0},
    }
    fmt.Println(maxAreaOfIsland(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function algoG.CloneGraph.DepthFirstSeacrh
    set output_file "CloneGraph"

    set template_content "package main

import \"fmt\"

// Definition for a Node.
type Node struct {
    Val int
    Neighbors []*Node
}

func cloneGraph(node *Node) *Node {
    oldToNew := make(map[*Node]*Node)

    var dfs func(*Node) *Node
    dfs = func(node *Node) *Node {
        if node == nil {
            return nil
        }

        if _, found := oldToNew[node]; found {
            return oldToNew[node]
        }

        copy := &Node{Val: node.Val}
        oldToNew[node] = copy
        for _, nei := range node.Neighbors {
            copy.Neighbors = append(copy.Neighbors, dfs(nei))
        }
        return copy
    }

    return dfs(node)
}

func main() {
    // приклад створення графа
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n4 := &Node{Val: 4}

    n1.Neighbors = []*Node{n2, n4}
    n2.Neighbors = []*Node{n1, n3}
    n3.Neighbors = []*Node{n2, n4}
    n4.Neighbors = []*Node{n1, n3}

    cloned := cloneGraph(n1)
    fmt.Println(cloned.Val, \"cloned graph created\")
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CloneGraph.BreadthFirstSearch
    set output_file "CloneGraphBFS.go"
    set template_content "package main

import \"fmt\"

// Definition for a Node.
type Node struct {
    Val int
    Neighbors []*Node
}

func cloneGraph(node *Node) *Node {
    if node == nil {
        return nil
    }

    oldToNew := make(map[*Node]*Node)
    oldToNew[node] = &Node{Val: node.Val, Neighbors: make([]*Node, 0)}
    queue := []*Node{node}

    for len(queue) > 0 {
        cur := queue[0]
        queue = queue[1:]

        for _, nei := range cur.Neighbors {
            if _, exists := oldToNew[nei]; !exists {
                oldToNew[nei] = &Node{Val: nei.Val, Neighbors: make([]*Node, 0)}
                queue = append(queue, nei)
            }
            oldToNew[cur].Neighbors = append(oldToNew[cur].Neighbors, oldToNew[nei])
        }
    }

    return oldToNew[node]
}

func main() {
    n1 := &Node{Val: 1}
    n2 := &Node{Val: 2}
    n3 := &Node{Val: 3}
    n4 := &Node{Val: 4}

    n1.Neighbors = []*Node{n2, n4}
    n2.Neighbors = []*Node{n1, n3}
    n3.Neighbors = []*Node{n2, n4}
    n4.Neighbors = []*Node{n1, n3}

    cloned := cloneGraph(n1)
    fmt.Println(cloned.Val, \"cloned graph created (BFS)\")
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.IslandsandTreasure.BruteForce_Backtracking
    set output_file "IslandsAndTreasure.go"

    set template_content "package main

import \"fmt\"

func islandsAndTreasure(grid [][]int) {
    rows, cols := len(grid), len(grid[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    INF := 2147483647
    visit := make([][]bool, rows)
    for i := range visit {
        visit[i] = make([]bool, cols)
    }

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || c < 0 || r >= rows || c >= cols ||
           grid[r][c] == -1 || visit[r][c] {
            return INF
        }
        if grid[r][c] == 0 {
            return 0
        }

        visit[r][c] = true
        res := INF
        for _, d := range directions {
            dx, dy := d[0], d[1]
            res = min(res, 1+dfs(r+dx, c+dy))
        }
        visit[r][c] = false
        return res
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == INF {
                grid[r][c] = dfs(r, c)
            }
        }
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    grid := [][]int{
        {2147483647, -1, 0, 2147483647},
        {2147483647, 2147483647, 2147483647, -1},
        {2147483647, -1, 2147483647, -1},
        {0, -1, 2147483647, 2147483647},
    }

    islandsAndTreasure(grid)

    fmt.Println(\"Grid after computing distances to treasure:\")
    for _, row := range grid {
        fmt.Println(row)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.IslandsandTreasure.BreadthFirstSearch
    set output_file "IslandsAndTreasureBFS.go"

    set template_content "package main

import \"fmt\"

func islandsAndTreasure(grid [][]int) {
    rows, cols := len(grid), len(grid[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    INF := 2147483647

    bfs := func(r, c int) int {
        q := [][2]int{{r, c}}
        visit := make([][]bool, rows)
        for i := range visit {
            visit[i] = make([]bool, cols)
        }
        visit[r][c] = true
        steps := 0

        for len(q) > 0 {
            size := len(q)
            for i := 0; i < size; i++ {
                current := q[0]
                q = q[1:]
                row, col := current[0], current[1]
                if grid[row][col] == 0 {
                    return steps
                }
                for _, dir := range directions {
                    nr, nc := row+dir[0], col+dir[1]
                    if nr >= 0 && nc >= 0 && nr < rows && nc < cols &&
                       !visit[nr][nc] && grid[nr][nc] != -1 {
                        visit[nr][nc] = true
                        q = append(q, [2]int{nr, nc})
                    }
                }
            }
            steps++
        }
        return INF
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == INF {
                grid[r][c] = bfs(r, c)
            }
        }
    }
}

func main() {
    grid := [][]int{
        {2147483647, -1, 0, 2147483647},
        {2147483647, 2147483647, 2147483647, -1},
        {2147483647, -1, 2147483647, -1},
        {0, -1, 2147483647, 2147483647},
    }

    islandsAndTreasure(grid)

    fmt.Println(\"Grid after computing distances to treasure (BFS):\")
    for _, row := range grid {
        fmt.Println(row)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.IslandsandTreasure.MultiSourceBFS
    set output_file "IslandsAndTreasureMultiBFS.go"

    set template_content "package main

import \"fmt\"

func islandsAndTreasure(grid [][]int) {
    m, n := len(grid), len(grid[0])
    q := [][2]int{}

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if grid[i][j] == 0 {
                q = append(q, [2]int{i, j})
            }
        }
    }
    if len(q) == 0 {
        return
    }

    dirs := [][]int{{-1, 0}, {0, -1}, {1, 0}, {0, 1}}

    for len(q) > 0 {
        node := q[0]
        q = q[1:]
        row, col := node[0], node[1]

        for _, dir := range dirs {
            r, c := row+dir[0], col+dir[1]
            if r >= m || c >= n || r < 0 || c < 0 || grid[r][c] != 2147483647 {
                continue
            }
            q = append(q, [2]int{r, c})
            grid[r][c] = grid[row][col] + 1
        }
    }
}

func main() {
    grid := [][]int{
        {2147483647, -1, 0, 2147483647},
        {2147483647, 2147483647, 2147483647, -1},
        {2147483647, -1, 2147483647, -1},
        {0, -1, 2147483647, 2147483647},
    }

    islandsAndTreasure(grid)

    fmt.Println(\"Grid after computing distances to treasure (multi-source BFS):\")
    for _, row := range grid {
        fmt.Println(row)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RottingFruit.BreadthFirstSearch
    set output_file "RottingOrangesBFS.go"

    set template_content "package main

import \"fmt\"

type Pair struct {
    row, col int
}

func orangesRotting(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    queue := make([]Pair, 0)
    fresh := 0
    time := 0

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                fresh++
            }
            if grid[r][c] == 2 {
                queue = append(queue, Pair{r, c})
            }
        }
    }

    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for fresh > 0 && len(queue) > 0 {
        length := len(queue)

        for i := 0; i < length; i++ {
            current := queue[0]
            queue = queue[1:]

            for _, dir := range directions {
                newRow := current.row + dir[0]
                newCol := current.col + dir[1]

                if newRow >= 0 && newRow < rows &&
                   newCol >= 0 && newCol < cols &&
                   grid[newRow][newCol] == 1 {
                    grid[newRow][newCol] = 2
                    queue = append(queue, Pair{newRow, newCol})
                    fresh--
                }
            }
        }
        time++
    }

    if fresh == 0 {
        return time
    }
    return -1
}

func main() {
    grid := [][]int{
        {2,1,1},
        {1,1,0},
        {0,1,1},
    }
    fmt.Println(\"Minutes to rot all oranges:\", orangesRotting(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RottingFruit.BreadthFirstSearch_NoQueue
    set output_file "RottingOrangesBFS_InPlace.go"

    set template_content "package main

import \"fmt\"

func orangesRotting(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    fresh := 0
    time := 0

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                fresh++
            }
        }
    }

    directions := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}

    for fresh > 0 {
        flag := false
        for r := 0; r < rows; r++ {
            for c := 0; c < cols; c++ {
                if grid[r][c] == 2 {
                    for _, d := range directions {
                        row, col := r+d[0], c+d[1]
                        if row >= 0 && row < rows &&
                           col >= 0 && col < cols &&
                           grid[row][col] == 1 {
                            grid[row][col] = 3
                            fresh--
                            flag = true
                        }
                    }
                }
            }
        }

        if !flag {
            return -1
        }

        for r := 0; r < rows; r++ {
            for c := 0; c < cols; c++ {
                if grid[r][c] == 3 {
                    grid[r][c] = 2
                }
            }
        }
        time++
    }

    return time
}

func main() {
    grid := [][]int{
        {2,1,1},
        {1,1,0},
        {0,1,1},
    }
    fmt.Println(\"Minutes to rot all oranges:\", orangesRotting(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PacificAtlanticWaterFlow.BruteForce_Backtracking
    set output_file "PacificAtlanticDFS.go"

    set template_content "package main

import \"fmt\"

func pacificAtlantic(heights [][]int) [][]int {
    rows, cols := len(heights), len(heights[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    result := make([][]int, 0)

    var pacific, atlantic bool

    var dfs func(r, c int, prevVal int)
    dfs = func(r, c int, prevVal int) {
        if r < 0 || c < 0 {
            pacific = true
            return
        }
        if r >= rows || c >= cols {
            atlantic = true
            return
        }
        if heights[r][c] > prevVal {
            return
        }

        tmp := heights[r][c]
        heights[r][c] = int(^uint(0) >> 1)

        for _, dir := range directions {
            dfs(r + dir[0], c + dir[1], tmp)
            if pacific && atlantic {
                break
            }
        }
        heights[r][c] = tmp
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            pacific = false
            atlantic = false
            dfs(r, c, int(^uint(0) >> 1))
            if pacific && atlantic {
                result = append(result, []int{r, c})
            }
        }
    }

    return result
}

func main() {
    heights := [][]int{
        {1, 2, 2, 3, 5},
        {3, 2, 3, 4, 4},
        {2, 4, 5, 3, 1},
        {6, 7, 1, 4, 5},
        {5, 1, 1, 2, 4},
    }
    res := pacificAtlantic(heights)
    fmt.Println(\"Cells that can reach both oceans:\", res)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PacificAtlanticWaterFlow.DepthFirstSearch
    set output_file "PacificAtlanticDFS_Oceans.go"

    set template_content "package main

import \"fmt\"

func pacificAtlantic(heights [][]int) [][]int {
    rows, cols := len(heights), len(heights[0])
    pac := make(map[[2]int]bool)
    atl := make(map[[2]int]bool)

    var dfs func(r, c int, visit map[[2]int]bool, prevHeight int)
    dfs = func(r, c int, visit map[[2]int]bool, prevHeight int) {
        coord := [2]int{r, c}
        if visit[coord] ||
           r < 0 || c < 0 ||
           r == rows || c == cols ||
           heights[r][c] < prevHeight {
            return
        }

        visit[coord] = true

        dfs(r+1, c, visit, heights[r][c])
        dfs(r-1, c, visit, heights[r][c])
        dfs(r, c+1, visit, heights[r][c])
        dfs(r, c-1, visit, heights[r][c])
    }

    for c := 0; c < cols; c++ {
        dfs(0, c, pac, heights[0][c])
        dfs(rows-1, c, atl, heights[rows-1][c])
    }

    for r := 0; r < rows; r++ {
        dfs(r, 0, pac, heights[r][0])
        dfs(r, cols-1, atl, heights[r][cols-1])
    }

    result := make([][]int, 0)
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            coord := [2]int{r, c}
            if pac[coord] && atl[coord] {
                result = append(result, []int{r, c})
            }
        }
    }

    return result
}

func main() {
    heights := [][]int{
        {1, 2, 2, 3, 5},
        {3, 2, 3, 4, 4},
        {2, 4, 5, 3, 1},
        {6, 7, 1, 4, 5},
        {5, 1, 1, 2, 4},
    }
    res := pacificAtlantic(heights)
    fmt.Println(\"Cells that can reach both oceans:\", res)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.PacificAtlanticWaterFlow.BreadthFirstSearch
    set output_file "PacificAtlanticBFS.go"

    set template_content "package main

import (
    \"container/list\"
    \"fmt\"
)

func pacificAtlantic(heights [][]int) [][]int {
    rows, cols := len(heights), len(heights[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    pac := make([][]bool, rows)
    atl := make([][]bool, rows)
    for i := range pac {
        pac[i] = make([]bool, cols)
        atl[i] = make([]bool, cols)
    }

    bfs := func(source [][2]int, ocean [][]bool) {
        q := list.New()
        for _, s := range source {
            q.PushBack(s)
        }
        for q.Len() > 0 {
            element := q.Front()
            q.Remove(element)
            r, c := element.Value.([2]int)[0], element.Value.([2]int)[1]
            ocean[r][c] = true
            for _, dir := range directions {
                nr, nc := r+dir[0], c+dir[1]
                if nr >= 0 && nr < rows && nc >= 0 && nc < cols &&
                    !ocean[nr][nc] && heights[nr][nc] >= heights[r][c] {
                    q.PushBack([2]int{nr, nc})
                }
            }
        }
    }

    pacific := [][2]int{}
    atlantic := [][2]int{}
    for c := 0; c < cols; c++ {
        pacific = append(pacific, [2]int{0, c})
        atlantic = append(atlantic, [2]int{rows - 1, c})
    }
    for r := 0; r < rows; r++ {
        pacific = append(pacific, [2]int{r, 0})
        atlantic = append(atlantic, [2]int{r, cols - 1})
    }

    bfs(pacific, pac)
    bfs(atlantic, atl)

    res := [][]int{}
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if pac[r][c] && atl[r][c] {
                res = append(res, []int{r, c})
            }
        }
    }
    return res
}

func main() {
    heights := [][]int{
        {1, 2, 2, 3, 5},
        {3, 2, 3, 4, 4},
        {2, 4, 5, 3, 1},
        {6, 7, 1, 4, 5},
        {5, 1, 1, 2, 4},
    }
    res := pacificAtlantic(heights)
    fmt.Println(\"Cells that can reach both oceans:\", res)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SurroundedRegions.DepthFirstSearch
    set output_file "SurroundedRegionsDFS.go"

    set template_content "package main

import \"fmt\"

func solve(board [][]byte) {
    rows, cols := len(board), len(board[0])

    var capture func(r, c int)
    capture = func(r, c int) {
        if r < 0 || c < 0 || r == rows ||
           c == cols || board[r][c] != 'O' {
            return
        }
        board[r][c] = 'T'
        capture(r+1, c)
        capture(r-1, c)
        capture(r, c+1)
        capture(r, c-1)
    }

    for r := 0; r < rows; r++ {
        if board[r][0] == 'O' {
            capture(r, 0)
        }
        if board[r][cols-1] == 'O' {
            capture(r, cols-1)
        }
    }

    for c := 0; c < cols; c++ {
        if board[0][c] == 'O' {
            capture(0, c)
        }
        if board[rows-1][c] == 'O' {
            capture(rows-1, c)
        }
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if board[r][c] == 'O' {
                board[r][c] = 'X'
            } else if board[r][c] == 'T' {
                board[r][c] = 'O'
            }
        }
    }
}

func main() {
    board := [][]byte{
        {'X','X','X','X'},
        {'X','O','O','X'},
        {'X','X','O','X'},
        {'X','O','X','X'},
    }

    solve(board)

    fmt.Println(\"Solved board:\")
    for _, row := range board {
        fmt.Println(string(row))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.SurroundedRegions.BreadthFirstSearch
    set output_file "SurroundedRegionsBFS.go"

    set template_content "package main

import \"fmt\"

func solve(board [][]byte) {
    rows, cols := len(board), len(board[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}

    capture := func() {
        q := [][]int{}
        for r := 0; r < rows; r++ {
            for c := 0; c < cols; c++ {
                if r == 0 || r == rows-1 || c == 0 || c == cols-1 {
                    if board[r][c] == 'O' {
                        q = append(q, []int{r, c})
                    }
                }
            }
        }
        for len(q) > 0 {
            r, c := q[0][0], q[0][1]
            q = q[1:]
            if board[r][c] == 'O' {
                board[r][c] = 'T'
                for _, dir := range directions {
                    nr, nc := r+dir[0], c+dir[1]
                    if nr >= 0 && nr < rows && nc >= 0 && nc < cols {
                        q = append(q, []int{nr, nc})
                    }
                }
            }
        }
    }

    capture()

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if board[r][c] == 'O' {
                board[r][c] = 'X'
            } else if board[r][c] == 'T' {
                board[r][c] = 'O'
            }
        }
    }
}

func main() {
    board := [][]byte{
        {'X','X','X','X'},
        {'X','O','O','X'},
        {'X','X','O','X'},
        {'X','O','X','X'},
    }

    solve(board)

    fmt.Println(\"Solved board (BFS):\")
    for _, row := range board {
        fmt.Println(string(row))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.SurroundedRegions.DisjointSetUnion
    set output_file "SurroundedRegionsDSU.go"

    set template_content "package main

import \"fmt\"

type DSU struct {
    Parent []int
    Size   []int
}

func NewDSU(n int) *DSU {
    dsu := &DSU{
        Parent: make([]int, n+1),
        Size:   make([]int, n+1),
    }
    for i := 0; i <= n; i++ {
        dsu.Parent[i] = i
        dsu.Size[i] = 1
    }
    return dsu
}

func (dsu *DSU) Find(node int) int {
    if dsu.Parent[node] != node {
        dsu.Parent[node] = dsu.Find(dsu.Parent[node])
    }
    return dsu.Parent[node]
}

func (dsu *DSU) Union(u, v int) bool {
    pu := dsu.Find(u)
    pv := dsu.Find(v)
    if pu == pv {
        return false
    }
    if dsu.Size[pu] >= dsu.Size[pv] {
        dsu.Size[pu] += dsu.Size[pv]
        dsu.Parent[pv] = pu
    } else {
        dsu.Size[pv] += dsu.Size[pu]
        dsu.Parent[pu] = pv
    }
    return true
}

func (dsu *DSU) Connected(u, v int) bool {
    return dsu.Find(u) == dsu.Find(v)
}

func solve(board [][]byte) {
    rows, cols := len(board), len(board[0])
    directions := [][]int{{1, 0}, {-1, 0}, {0, 1}, {0, -1}}
    dsu := NewDSU(rows * cols)

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if board[r][c] != 'O' {
                continue
            }
            if r == 0 || c == 0 || r == rows-1 || c == cols-1 {
                dsu.Union(rows*cols, r*cols+c)
            } else {
                for _, dir := range directions {
                    nr, nc := r+dir[0], c+dir[1]
                    if nr >= 0 && nr < rows && nc >= 0 && nc < cols && board[nr][nc] == 'O' {
                        dsu.Union(r*cols+c, nr*cols+nc)
                    }
                }
            }
        }
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if !dsu.Connected(rows*cols, r*cols+c) {
                board[r][c] = 'X'
            }
        }
    }
}

func main() {
    board := [][]byte{
        {'X','X','X','X'},
        {'X','O','O','X'},
        {'X','X','O','X'},
        {'X','O','X','X'},
    }
    solve(board)
    fmt.Println(\"Board after surrounded regions solved:\")
    for _, row := range board {
        fmt.Println(row)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CourseSchedule.CycleDetection_DFS
    set output_file "CanFinishDFS.go"

    set template_content "package main

import \"fmt\"

func canFinish(numCourses int, prerequisites [][]int) bool {
    preMap := make(map[int][]int)
    for i := 0; i < numCourses; i++ {
        preMap[i] = []int{}
    }
    for _, prereq := range prerequisites {
        crs, pre := prereq[0], prereq[1]
        preMap[crs] = append(preMap[crs], pre)
    }

    visiting := make(map[int]bool)

    var dfs func(int) bool
    dfs = func(crs int) bool {
        if visiting[crs] {
            return false
        }
        if len(preMap[crs]) == 0 {
            return true
        }

        visiting[crs] = true
        for _, pre := range preMap[crs] {
            if !dfs(pre) {
                return false
            }
        }
        visiting[crs] = false
        preMap[crs] = []int{}
        return true
    }

    for c := 0; c < numCourses; c++ {
        if !dfs(c) {
            return false
        }
    }
    return true
}

func main() {
    numCourses := 4
    prerequisites := [][]int{
        {1, 0},
        {2, 1},
        {3, 2},
    }
    fmt.Println(\"Can finish courses:\", canFinish(numCourses, prerequisites))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CourseSchedule.TopologicalSort
    set output_file "CanFinishBFS.go"

    set template_content "package main

import \"fmt\"

func canFinish(numCourses int, prerequisites [][]int) bool {
    indegree := make([]int, numCourses)
    adj := make([][]int, numCourses)
    for i := 0; i < numCourses; i++ {
        adj[i] = []int{}
    }

    for _, prereq := range prerequisites {
        src, dst := prereq[0], prereq[1]
        indegree[dst]++
        adj[src] = append(adj[src], dst)
    }

    q := []int{}
    for n := 0; n < numCourses; n++ {
        if indegree[n] == 0 {
            q = append(q, n)
        }
    }

    finish := 0
    for len(q) > 0 {
        node := q[0]
        q = q[1:]
        finish++
        for _, nei := range adj[node] {
            indegree[nei]--
            if indegree[nei] == 0 {
                q = append(q, nei)
            }
        }
    }

    return finish == numCourses
}

func main() {
    numCourses := 4
    prerequisites := [][]int{
        {1, 0},
        {2, 1},
        {3, 2},
    }
    fmt.Println(\"Can finish courses:\", canFinish(numCourses, prerequisites))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CourseScheduleII.CycleDetection
    set output_file "FindOrderDFS.go"

    set template_content "package main

import \"fmt\"

func findOrder(numCourses int, prerequisites [][]int) []int {
    prereq := make(map[int][]int)
    for i := 0; i < numCourses; i++ {
        prereq[i] = []int{}
    }
    for _, pair := range prerequisites {
        crs, pre := pair[0], pair[1]
        prereq[crs] = append(prereq[crs], pre)
    }

    output := []int{}
    visit := make(map[int]bool)
    cycle := make(map[int]bool)

    var dfs func(int) bool
    dfs = func(crs int) bool {
        if cycle[crs] {
            return false
        }
        if visit[crs] {
            return true
        }

        cycle[crs] = true
        for _, pre := range prereq[crs] {
            if !dfs(pre) {
                return false
            }
        }
        cycle[crs] = false
        visit[crs] = true
        output = append(output, crs)
        return true
    }

    for i := 0; i < numCourses; i++ {
        if !dfs(i) {
            return []int{}
        }
    }

    return output
}

func main() {
    numCourses := 4
    prerequisites := [][]int{
        {1, 0},
        {2, 0},
        {3, 1},
        {3, 2},
    }
    order := findOrder(numCourses, prerequisites)
    fmt.Println(\"Course order:\", order)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.CourseScheduleII.TopologicalSort1 
    set output_file "FindOrderBFS.go"

    set template_content "package main

import \"fmt\"

func findOrder(numCourses int, prerequisites [][]int) []int {
    indegree := make([]int, numCourses)
    adj := make([][]int, numCourses)
    for _, pair := range prerequisites {
        src, dst := pair[0], pair[1]
        indegree[dst]++
        adj[src] = append(adj[src], dst)
    }

    q := []int{}
    for i := 0; i < numCourses; i++ {
        if indegree[i] == 0 {
            q = append(q, i)
        }
    }

    output := []int{}
    finish := 0
    for len(q) > 0 {
        node := q[0]
        q = q[1:]
        output = append(output, node)
        finish++
        for _, nei := range adj[node] {
            indegree[nei]--
            if indegree[nei] == 0 {
                q = append(q, nei)
            }
        }
    }

    if finish != numCourses {
        return []int{}
    }

    for i, j := 0, len(output)-1; i < j; i, j = i+1, j-1 {
        output[i], output[j] = output[j], output[i]
    }
    return output
}

func main() {
    numCourses := 4
    prerequisites := [][]int{
        {1, 0},
        {2, 0},
        {3, 1},
        {3, 2},
    }
    order := findOrder(numCourses, prerequisites)
    fmt.Println(\"Course order:\", order)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.CourseScheduleII.TopologicalSort2
    set output_file "FindOrderDFS_InPlace.go"

    set template_content "package main

import \"fmt\"

func findOrder(numCourses int, prerequisites [][]int) []int {
    adj := make([][]int, numCourses)
    indegree := make([]int, numCourses)
    for _, pair := range prerequisites {
        nxt, pre := pair[0], pair[1]
        indegree[nxt]++
        adj[pre] = append(adj[pre], nxt)
    }

    output := []int{}

    var dfs func(int)
    dfs = func(node int) {
        output = append(output, node)
        indegree[node]--
        for _, nei := range adj[node] {
            indegree[nei]--
            if indegree[nei] == 0 {
                dfs(nei)
            }
        }
    }

    for i := 0; i < numCourses; i++ {
        if indegree[i] == 0 {
            dfs(i)
        }
    }

    if len(output) == numCourses {
        return output
    }
    return []int{}
}

func main() {
    numCourses := 4
    prerequisites := [][]int{
        {1, 0},
        {2, 0},
        {3, 1},
        {3, 2},
    }
    order := findOrder(numCourses, prerequisites)
    fmt.Println(\"Course order:\", order)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GraphValidTree.CycleDetection
    set output_file "ValidTreeDFS.go"

    set template_content "package main

import \"fmt\"

func validTree(n int, edges [][]int) bool {
    if len(edges) > n-1 {
        return false
    }

    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visit := make(map[int]bool)
    var dfs func(node, parent int) bool
    dfs = func(node, parent int) bool {
        if visit[node] {
            return false
        }
        visit[node] = true
        for _, nei := range adj[node] {
            if nei == parent {
                continue
            }
            if !dfs(nei, node) {
                return false
            }
        }
        return true
    }

    return dfs(0, -1) && len(visit) == n
}

func main() {
    n := 5
    edges := [][]int{{0,1},{0,2},{0,3},{1,4}}
    fmt.Println(\"Is valid tree:\", validTree(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GraphValidTree.BreadthFirstSearch
    set output_file "ValidTreeBFS.go"

    set template_content "package main

import \"fmt\"

func validTree(n int, edges [][]int) bool {
    if len(edges) > n-1 {
        return false
    }

    adj := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visit := make(map[int]bool)
    q := [][2]int{{0, -1}} // (current node, parent node)
    visit[0] = true

    for len(q) > 0 {
        node, parent := q[0][0], q[0][1]
        q = q[1:]

        for _, nei := range adj[node] {
            if nei == parent {
                continue
            }
            if visit[nei] {
                return false
            }
            visit[nei] = true
            q = append(q, [2]int{nei, node})
        }
    }

    return len(visit) == n
}

func main() {
    n := 5
    edges := [][]int{{0,1},{0,2},{0,3},{1,4}}
    fmt.Println(\"Is valid tree (BFS):\", validTree(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.GraphValidTree.DisjointSetUnion 
    set output_file "ValidTreeDSU.go"

    set template_content "package main

import \"fmt\"

type DSU struct {
    Parent []int
    Size   []int
    Comps  int
}

func NewDSU(n int) *DSU {
    parent := make([]int, n+1)
    size := make([]int, n+1)
    for i := 0; i <= n; i++ {
        parent[i] = i
        size[i] = 1
    }
    return &DSU{Parent: parent, Size: size, Comps: n}
}

func (dsu *DSU) Find(node int) int {
    if dsu.Parent[node] != node {
        dsu.Parent[node] = dsu.Find(dsu.Parent[node])
    }
    return dsu.Parent[node]
}

func (dsu *DSU) Union(u, v int) bool {
    pu, pv := dsu.Find(u), dsu.Find(v)
    if pu == pv {
        return false
    }
    dsu.Comps--
    if dsu.Size[pu] < dsu.Size[pv] {
        pu, pv = pv, pu
    }
    dsu.Size[pu] += dsu.Size[pv]
    dsu.Parent[pv] = pu
    return true
}

func (dsu *DSU) Components() int {
    return dsu.Comps
}

func validTree(n int, edges [][]int) bool {
    if len(edges) > n-1 {
        return false
    }
    dsu := NewDSU(n)
    for _, edge := range edges {
        if !dsu.Union(edge[0], edge[1]) {
            return false
        }
    }
    return dsu.Components() == 1
}

func main() {
    n := 5
    edges := [][]int{{0,1},{0,2},{0,3},{1,4}}
    fmt.Println(\"Is valid tree (DSU):\", validTree(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberConnectedComponentsInUndirectedGraph.DepthFirstSearch
    set output_file "CountComponentsDFS.go"

    set template_content "package main

import \"fmt\"

func countComponents(n int, edges [][]int) int {
    adj := make([][]int, n)
    visit := make([]bool, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    var dfs func(int)
    dfs = func(node int) {
        for _, nei := range adj[node] {
            if !visit[nei] {
                visit[nei] = true
                dfs(nei)
            }
        }
    }

    res := 0
    for node := 0; node < n; node++ {
        if !visit[node] {
            visit[node] = true
            dfs(node)
            res++
        }
    }
    return res
}

func main() {
    n := 5
    edges := [][]int{{0,1},{1,2},{3,4}}
    fmt.Println(\"Number of connected components:\", countComponents(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberConnectedComponentsInUndirectedGraph.BreadthFirstSearch
    set output_file "CountComponentsBFS.go"

    set template_content "package main

import \"fmt\"

func countComponents(n int, edges [][]int) int {
    adj := make([][]int, n)
    visit := make([]bool, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    bfs := func(node int) {
        q := []int{node}
        visit[node] = true
        for len(q) > 0 {
            cur := q[0]
            q = q[1:]
            for _, nei := range adj[cur] {
                if !visit[nei] {
                    visit[nei] = true
                    q = append(q, nei)
                }
            }
        }
    }

    res := 0
    for node := 0; node < n; node++ {
        if !visit[node] {
            bfs(node)
            res++
        }
    }
    return res
}

func main() {
    n := 5
    edges := [][]int{{0,1},{1,2},{3,4}}
    fmt.Println(\"Number of connected components:\", countComponents(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.NumberConnectedComponentsInUndirectedGraph.DisjointSetUnion
    set output_file "CountComponentsDSU.go"

    set template_content "package main

import \"fmt\"

type DSU struct {
    parent []int
    rank   []int
}

func NewDSU(n int) *DSU {
    dsu := &DSU{
        parent: make([]int, n),
        rank:   make([]int, n),
    }
    for i := 0; i < n; i++ {
        dsu.parent[i] = i
        dsu.rank[i] = 1
    }
    return dsu
}

func (dsu *DSU) Find(node int) int {
    cur := node
    for cur != dsu.parent[cur] {
        dsu.parent[cur] = dsu.parent[dsu.parent[cur]]
        cur = dsu.parent[cur]
    }
    return cur
}

func (dsu *DSU) Union(u, v int) bool {
    pu := dsu.Find(u)
    pv := dsu.Find(v)
    if pu == pv {
        return false
    }
    if dsu.rank[pv] > dsu.rank[pu] {
        pu, pv = pv, pu
    }
    dsu.parent[pv] = pu
    dsu.rank[pu] += dsu.rank[pv]
    return true
}

func countComponents(n int, edges [][]int) int {
    dsu := NewDSU(n)
    res := n
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if dsu.Union(u, v) {
            res--
        }
    }
    return res
}

func main() {
    n := 5
    edges := [][]int{{0,1},{1,2},{3,4}}
    fmt.Println(\"Number of connected components:\", countComponents(n, edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RedundantConnection.CycleDetection
    set output_file "FindRedundantConnectionDFS.go"

    set template_content "package main

import \"fmt\"

func findRedundantConnection(edges [][]int) []int {
    n := len(edges)
    adj := make([][]int, n+1)
    visit := make([]bool, n+1)

    var dfs func(node, par int) bool
    dfs = func(node, par int) bool {
        if visit[node] {
            return true
        }
        visit[node] = true
        for _, nei := range adj[node] {
            if nei == par {
                continue
            }
            if dfs(nei, node) {
                return true
            }
        }
        return false
    }

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
        for i := 0; i <= n; i++ {
            visit[i] = false
        }

        if dfs(u, -1) {
            return []int{u, v}
        }
    }
    return []int{}
}

func main() {
    edges := [][]int{{1,2},{1,3},{2,3}}
    fmt.Println(\"Redundant connection:\", findRedundantConnection(edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.RedundantConnection.DepthFirstSearch
    set output_file "FindRedundantConnectionDFS_Cycle.go"

    set template_content "package main

import \"fmt\"

func findRedundantConnection(edges [][]int) []int {
    n := len(edges)
    adj := make([][]int, n+1)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    visit := make([]bool, n+1)
    cycle := make(map[int]bool)
    cycleStart := -1

    var dfs func(node, par int) bool
    dfs = func(node, par int) bool {
        if visit[node] {
            cycleStart = node
            return true
        }

        visit[node] = true
        for _, nei := range adj[node] {
            if nei == par {
                continue
            }
            if dfs(nei, node) {
                if cycleStart != -1 {
                    cycle[node] = true
                }
                if node == cycleStart {
                    cycleStart = -1
                }
                return true
            }
        }
        return false
    }

    dfs(1, -1)

    for i := len(edges) - 1; i >= 0; i-- {
        u, v := edges[i][0], edges[i][1]
        if cycle[u] && cycle[v] {
            return []int{u, v}
        }
    }
    return []int{}
}

func main() {
    edges := [][]int{{1,2},{1,3},{2,3}}
    fmt.Println(\"Redundant connection:\", findRedundantConnection(edges))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.LinearSearch
    set output_file "InsertInterval.go"

    set template_content "package main

import \"fmt\"

func insert(intervals [][]int, newInterval []int) [][]int {
    n := len(intervals)
    i := 0
    var res [][]int

    for i < n && intervals[i][1] < newInterval[0] {
        res = append(res, intervals[i])
        i++
    }

    for i < n && newInterval[1] >= intervals[i][0] {
        newInterval[0] = min(newInterval[0], intervals[i][0])
        newInterval[1] = max(newInterval[1], intervals[i][1])
        i++
    }
    res = append(res, newInterval)

    for i < n {
        res = append(res, intervals[i])
        i++
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,3},{6,9}}
    newInterval := []int{2,5}
    fmt.Println(\"After insert:\", insert(intervals, newInterval))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.BinarySearch
    set output_file "InsertIntervalBinary.go"

    set template_content "package main

import \"fmt\"

func insert(intervals [][]int, newInterval []int) [][]int {
    if len(intervals) == 0 {
        return [][]int{newInterval}
    }

    n := len(intervals)
    target := newInterval[0]
    left, right := 0, n-1

    for left <= right {
        mid := (left + right) / 2
        if intervals[mid][0] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    intervals = append(intervals[:left], append(
        [][]int{newInterval}, intervals[left:]...)...)

    var res [][]int
    for _, interval := range intervals {
        if len(res) == 0 || res[len(res)-1][1] < interval[0] {
            res = append(res, interval)
        } else {
            res[len(res)-1][1] = max(res[len(res)-1][1], interval[1])
        }
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,3},{6,9}}
    newInterval := []int{2,5}
    fmt.Println(\"After binary insert:\", insert(intervals, newInterval))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.Greedy
    set output_file "InsertIntervalSimple.go"

    set template_content "package main

import \"fmt\"

func insert(intervals [][]int, newInterval []int) [][]int {
    var res [][]int

    for i := 0; i < len(intervals); i++ {
        if newInterval[1] < intervals[i][0] {
            res = append(res, newInterval)
            return append(res, intervals[i:]...)
        } else if newInterval[0] > intervals[i][1] {
            res = append(res, intervals[i])
        } else {
            newInterval = []int{
                min(newInterval[0], intervals[i][0]),
                max(newInterval[1], intervals[i][1]),
            }
        }
    }
    res = append(res, newInterval)
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,3},{6,9}}
    newInterval := []int{2,5}
    fmt.Println(\"Merged intervals:\", insert(intervals, newInterval))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MergeIntervals.Sorting
    set output_file "MergeIntervals.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func merge(intervals [][]int) [][]int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })
    output := [][]int{intervals[0]}

    for _, interval := range intervals[1:] {
        start, end := interval[0], interval[1]
        lastEnd := output[len(output)-1][1]

        if start <= lastEnd {
            output[len(output)-1][1] = max(lastEnd, end)
        } else {
            output = append(output, []int{start, end})
        }
    }
    return output
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,3},{2,6},{8,10},{15,18}}
    fmt.Println(\"Merged intervals:\", merge(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function  algoG.MergeIntervals.SweepLineAlgorithm
    set output_file "merge_intervals.go"

    set template_content 'package main

import (
    "fmt"
    "sort"
)

func merge(intervals [][]int) [][]int {
    mp := make(map[int]int)
    for _, interval := range intervals {
        start, end := interval[0], interval[1]
        mp[start]++
        mp[end]--
    }

    res := [][]int{}
    interval := []int{}
    have := 0
    keys := make([]int, 0, len(mp))
    for key := range mp {
        keys = append(keys, key)
    }
    sort.Ints(keys)

    for _, i := range keys {
        if len(interval) == 0 {
            interval = append(interval, i)
        }
        have += mp[i]
        if have == 0 {
            interval = append(interval, i)
            res = append(res, append([]int{}, interval...))
            interval = []int{}
        }
    }
    return res
}

func main() {
    intervals := [][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}}
    fmt.Println(merge(intervals))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeIntervals.Greedy
    set output_file "MergeIntervalsLineSweep.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func merge(intervals [][]int) [][]int {
    maxVal := math.MinInt
    for _, interval := range intervals {
        maxVal = max(maxVal, interval[0])
    }

    mp := make([]int, maxVal+1)
    for _, interval := range intervals {
        start, end := interval[0], interval[1]
        mp[start] = max(mp[start], end+1)
    }

    res := [][]int{}
    have := -1
    intervalStart := -1
    for i := 0; i < len(mp); i++ {
        if mp[i] != 0 {
            if intervalStart == -1 {
                intervalStart = i
            }
            have = max(mp[i]-1, have)
        }
        if have == i {
            res = append(res, []int{intervalStart, have})
            have = -1
            intervalStart = -1
        }
    }

    if intervalStart != -1 {
        res = append(res, []int{intervalStart, have})
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,3},{2,6},{8,10},{15,18}}
    fmt.Println(\"Merged intervals:\", merge(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Recursion
    set output_file "EraseOverlapIntervalsDFS.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    var dfs func(i, prev int) int
    dfs = func(i, prev int) int {
        if i == len(intervals) {
            return 0
        }
        res := dfs(i+1, prev)
        if prev == -1 || intervals[prev][1] <= intervals[i][0] {
            res = max(res, 1+dfs(i+1, i))
        }
        return res
    }

    return len(intervals) - dfs(0, -1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color 
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_Top-Down
    set output_file "EraseOverlapIntervalsDFS_RightSort.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })
    n := len(intervals)
    memo := make([]int, n)

    var dfs func(i int) int
    dfs = func(i int) int {
        if memo[i] != 0 {
            return memo[i]
        }

        res := 1
        for j := i + 1; j < n; j++ {
            if intervals[i][1] <= intervals[j][0] {
                res = max(res, 1+dfs(j))
            }
        }
        memo[i] = res
        return res
    }

    return n - dfs(0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color 
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_Bottom-Up
    set output_file "EraseOverlapIntervalsDP.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    n := len(intervals)
    dp := make([]int, n)

    for i := 0; i < n; i++ {
        dp[i] = 1
        for j := 0; j < i; j++ {
            if intervals[j][1] <= intervals[i][0] {
                dp[i] = max(dp[i], 1+dp[j])
            }
        }
    }

    maxNonOverlapping := dp[0]
    for i := 1; i < n; i++ {
        maxNonOverlapping = max(maxNonOverlapping, dp[i])
    }

    return n - maxNonOverlapping
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color 
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_BinarySearch
    set output_file "EraseOverlapIntervalsBinaryDP.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    n := len(intervals)
    dp := make([]int, n)
    dp[0] = 1

    var bs func(r, target int) int
    bs = func(r, target int) int {
        l := 0
        for l < r {
            m := (l + r) >> 1
            if intervals[m][1] <= target {
                l = m + 1
            } else {
                r = m
            }
        }
        return l
    }

    for i := 1; i < n; i++ {
        idx := bs(i, intervals[i][0])
        if idx == 0 {
            dp[i] = dp[i-1]
        } else {
            dp[i] = max(dp[i-1], 1+dp[idx-1])
        }
    }

    return n - dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color 
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Greedy_SortByStart

    set output_file "EraseOverlapIntervals.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    res := 0
    prevEnd := intervals[0][1]

    for _, interval := range intervals[1:] {
        start, end := interval[0], interval[1]
        if start >= prevEnd {
            prevEnd = end
        } else {
            res++
            prevEnd = min(end, prevEnd)
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.Non-overlappingIntervals.Greedy_SortByEnd
    set output_file "erase_overlap_intervals_optimized.go"

    set template_content 'package main

import (
    "fmt"
    "sort"
)

func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    prevEnd := intervals[0][1]
    res := 0

    for i := 1; i < len(intervals); i++ {
        if prevEnd > intervals[i][0] {
            res++
        } else {
            prevEnd = intervals[i][1]
        }
    }
    return res
}

func main() {
    intervals := [][]int{{1,2},{2,3},{3,4},{1,3}}
    fmt.Println("Intervals to remove:", eraseOverlapIntervals(intervals))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MeetingRoomsII.MinHeap
    set output_file "MinMeetingRooms.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"

    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i].start < intervals[j].start
    })

    pq := priorityqueue.NewWith(utils.IntComparator)

    for _, interval := range intervals {
        if pq.Size() > 0 {
            if top, _ := pq.Peek(); top.(int) <= interval.start {
                pq.Dequeue()
            }
        }
        pq.Enqueue(interval.end)
    }

    return pq.Size()
}

func main() {
    intervals := []Interval{
        {start: 0, end: 30},
        {start: 5, end: 10},
        {start: 15, end: 20},
    }

    fmt.Println(\"Minimum meeting rooms needed:\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MeetingRoomsII.SweepLineAlgorithm
    set output_file "MinMeetingRoomsSweep.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    mp := make(map[int]int)
    for _, i := range intervals {
        mp[i.start]++
        mp[i.end]--
    }

    keys := make([]int, 0, len(mp))
    for k := range mp {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    prev := 0
    res := 0
    for _, k := range keys {
        prev += mp[k]
        if prev > res {
            res = prev
        }
    }
    return res
}

func main() {
    intervals := []Interval{
        {start: 0, end: 30},
        {start: 5, end: 10},
        {start: 15, end: 20},
    }

    fmt.Println(\"Minimum meeting rooms needed:\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.MeetingRoomsII.TwoPointers
    set output_file "MinMeetingRoomsTwoArrays.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    start := make([]int, len(intervals))
    end := make([]int, len(intervals))

    for i, interval := range intervals {
        start[i] = interval.start
        end[i] = interval.end
    }

    sort.Ints(start)
    sort.Ints(end)

    res, count := 0, 0
    s, e := 0, 0

    for s < len(intervals) {
        if start[s] < end[e] {
            s++
            count++
        } else {
            e++
            count--
        }
        if count > res {
            res = count
        }
    }

    return res
}

func main() {
    intervals := []Interval{
        {start: 0, end: 30},
        {start: 5, end: 10},
        {start: 15, end: 20},
    }

    fmt.Println(\"Minimum meeting rooms needed:\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.Recursion
    set output_file "ClimbStairs.go"

    set template_content "package main

import (
    \"fmt\"
)

func climbStairs(n int) int {
    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= n {
            if i == n {
                return 1
            }
            return 0
        }
        return dfs(i + 1) + dfs(i + 2)
    }
    return dfs(0)
}

func main() {
    n := 5
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end




function algoG.ClimbingStairs.DynamicProgramming_Top-Down
    set output_file "ClimbStairsMemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func climbStairs(n int) int {
    cache := make([]int, n+1)
    for i := 0; i <= n; i++ {
        cache[i] = -1
    }

    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= n {
            if i == n {
                return 1
            }
            return 0
        }
        if cache[i] != -1 {
            return cache[i]
        }
        cache[i] = dfs(i + 1) + dfs(i + 2)
        return cache[i]
    }
    return dfs(0)
}

func main() {
    n := 10
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.DynamicProgramming_Bottom-Up
    set output_file "ClimbStairsIter.go"

    set template_content "package main

import (
    \"fmt\"
)

func climbStairs(n int) int {
    if n <= 2 {
        return n
    }
    dp := make([]int, n+1)
    dp[1] = 1
    dp[2] = 2
    for i := 3; i <= n; i++ {
        dp[i] = dp[i - 1] + dp[i - 2]
    }
    return dp[n]
}

func main() {
    n := 10
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function algoG.ClimbingStairs.DynamicProgramming_SpaceOptimized
    set output_file "ClimbStairsOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func climbStairs(n int) int {
    one := 1
    two := 1

    for i := 0; i < n-1; i++ {
        temp := one
        one += two
        two = temp
    }

    return one
}

func main() {
    n := 10
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.MatrixExponentiation
    set output_file "ClimbStairsMatrix.go"

    set template_content "package main

import (
    \"fmt\"
)

func climbStairs(n int) int {
    if n == 1 {
        return 1
    }

    M := [][]int{{1, 1}, {1, 0}}
    result := matrixPow(M, n)

    return result[0][0]
}

func matrixMult(A, B [][]int) [][]int {
    return [][]int{
        {A[0][0]*B[0][0] + A[0][1]*B[1][0],
         A[0][0]*B[0][1] + A[0][1]*B[1][1]},
        {A[1][0]*B[0][0] + A[1][1]*B[1][0],
         A[1][0]*B[0][1] + A[1][1]*B[1][1]},
    }
}

func matrixPow(M [][]int, p int) [][]int {
    result := [][]int{{1, 0}, {0, 1}}
    base := M

    for p > 0 {
        if p%2 == 1 {
            result = matrixMult(result, base)
        }
        base = matrixMult(base, base)
        p /= 2
    }

    return result
}

func main() {
    n := 10
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.ClimbingStairs.Math
    set output_file "ClimbStairsBinet.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func climbStairs(n int) int {
    sqrt5 := math.Sqrt(5)
    phi := (1 + sqrt5) / 2
    psi := (1 - sqrt5) / 2
    n++
    return int(math.Round((math.Pow(phi, float64(n)) -
               math.Pow(psi, float64(n))) / sqrt5))
}

func main() {
    n := 10
    fmt.Printf(\"Number of ways to climb %d stairs: %d\\n\", n, climbStairs(n))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

