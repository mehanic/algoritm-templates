function algoG.MinCostClimbingStairs.Recursion
    set output_file "MinCostClimbingStairs.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    set output_file "MinCostClimbingStairs.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    set output_file "MinCostClimbingStairs.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    set output_file "MinCostClimbingStairsOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

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


function algoG.HouseRobber.Recursion
    set output_file "RobDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= len(nums) {
            return 0
        }
        return max(dfs(i+1), nums[i] + dfs(i+2))
    }
    return dfs(0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,7,9,3,1}
    fmt.Println(\"Maximum amount that can be robbed:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.HouseRobber.DynamicProgramming_Top-Down
    set output_file "RobMemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    n := len(nums)
    memo := make([]int, n+1)
    for i := 0; i <= n; i++ {
        memo[i] = -1
    }

    var dfs func(i int) int
    dfs = func(i int) int {
        if i >= len(nums) {
            return 0
        }
        if memo[i] != -1 {
            return memo[i]
        }
        memo[i] = max(dfs(i+1), nums[i] + dfs(i+2))
        return memo[i]
    }

    return dfs(0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,7,9,3,1}
    fmt.Println(\"Maximum amount that can be robbed:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.HouseRobber.DynamicProgramming_Bottom-Up
    set output_file "RobDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }
    if n == 1 {
        return nums[0]
    }

    dp := make([]int, n)
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])

    for i := 2; i < n; i++ {
        dp[i] = max(dp[i-1], nums[i] + dp[i-2])
    }

    return dp[n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,7,9,3,1}
    fmt.Println(\"Maximum amount that can be robbed:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.HouseRobber.DynamicProgramming_SpaceOptimized
    set output_file "RobOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    rob1, rob2 := 0, 0
    for _, num := range nums {
        temp := max(num+rob1, rob2)
        rob1 = rob2
        rob2 = temp
    }
    return rob2
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,7,9,3,1}
    fmt.Println(\"Maximum amount that can be robbed:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function algoG.HouseRobber.DynamicProgramming_SpaceOptimized
    set output_file "RobOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    rob1, rob2 := 0, 0
    for _, num := range nums {
        temp := max(num+rob1, rob2)
        rob1 = rob2
        rob2 = temp
    }
    return rob2
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 7, 9, 3, 1}
    fmt.Println(\"Maximum amount that can be robbed:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoG.HouseRobberII.Recursion
    set output_file "RobCircleDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    if len(nums) == 1 {
        return nums[0]
    }

    var dfs func(i int, flag bool) int
    dfs = func(i int, flag bool) int {
        if i >= len(nums) || (flag && i == len(nums)-1) {
            return 0
        }
        return max(dfs(i+1, flag), nums[i] + dfs(i+2, flag || i == 0))
    }

    return max(dfs(0, true), dfs(1, false))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 3, 2}
    fmt.Println(\"Maximum amount that can be robbed in a circle:\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HouseRobberII.DynamicProgramming_Top-Down

    set output_file "RobCircleDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    if len(nums) == 1 {
        return nums[0]
    }
    memo := make([][2]int, len(nums))
    for i := range memo {
        memo[i][0] = -1
        memo[i][1] = -1
    }

    var dfs func(i, flag int) int
    dfs = func(i, flag int) int {
        if i >= len(nums) || (flag == 1 && i == len(nums)-1) {
            return 0
        }
        if memo[i][flag] != -1 {
            return memo[i][flag]
        }

        tmp := flag
        if i == 0 {
            tmp = 1
        }
        memo[i][flag] = max(dfs(i+1, flag), nums[i] + dfs(i+2, tmp))
        return memo[i][flag]
    }

    return max(dfs(0, 1), dfs(1, 0))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 3, 2}
    fmt.Println(\"Maximum amount that can be robbed in a circle (DP):\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HouseRobberII.DynamicProgramming_Bottom-Up
    set output_file "RobCircleIterativeDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    if len(nums) == 1 {
        return nums[0]
    }
    return max(helper(nums[1:]), helper(nums[:len(nums)-1]))
}

func helper(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    if len(nums) == 1 {
        return nums[0]
    }

    dp := make([]int, len(nums))
    dp[0] = nums[0]
    dp[1] = max(nums[0], nums[1])

    for i := 2; i < len(nums); i++ {
        dp[i] = max(dp[i-1], nums[i] + dp[i-2])
    }

    return dp[len(nums)-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 3, 2}
    fmt.Println(\"Maximum amount that can be robbed in a circle (Iterative DP):\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HouseRobberII.DynamicProgramming_SpaceOptimized
    set output_file "RobCircleOptimizedDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func rob(nums []int) int {
    if len(nums) == 0 {
        return 0
    }
    return max(nums[0], max(helper(nums[1:]), helper(nums[:len(nums)-1])))
}

func helper(nums []int) int {
    rob1, rob2 := 0, 0

    for _, num := range nums {
        newRob := max(rob1+num, rob2)
        rob1 = rob2
        rob2 = newRob
    }
    return rob2
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 3, 2}
    fmt.Println(\"Maximum amount that can be robbed in a circle (Optimized DP):\", rob(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestPalindromicSubstring.BruteForce
    set output_file "LongestPalindromeBruteforce.go"

    set template_content "package main

import (
    \"fmt\"
)

func longestPalindrome(s string) string {
    res := \"\"
    resLen := 0

    for i := 0; i < len(s); i++ {
        for j := i; j < len(s); j++ {
            l, r := i, j
            for l < r && s[l] == s[r] {
                l++
                r--
            }

            if l >= r && resLen < (j-i+1) {
                res = s[i : j+1]
                resLen = j - i + 1
            }
        }
    }

    return res
}

func main() {
    s := \"babad\"
    fmt.Println(\"Longest Palindromic Substring (Bruteforce):\", longestPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestPalindromicSubstring.DynamicProgramming
    set output_file "LongestPalindromeDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func longestPalindrome(s string) string {
    n := len(s)
    resIdx, resLen := 0, 0

    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for i := n - 1; i >= 0; i-- {
        for j := i; j < n; j++ {
            if s[i] == s[j] && (j-i <= 2 || dp[i+1][j-1]) {
                dp[i][j] = true
                if resLen < (j-i+1) {
                    resIdx = i
                    resLen = j - i + 1
                }
            }
        }
    }

    return s[resIdx : resIdx+resLen]
}

func main() {
    s := \"babad\"
    fmt.Println(\"Longest Palindromic Substring (DP):\", longestPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestPalindromicSubstring.DynamicProgramming
    set output_file "LongestPalindromeDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func longestPalindrome(s string) string {
    n := len(s)
    resIdx, resLen := 0, 0

    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for i := n - 1; i >= 0; i-- {
        for j := i; j < n; j++ {
            if s[i] == s[j] && (j-i <= 2 || dp[i+1][j-1]) {
                dp[i][j] = true
                if resLen < (j-i+1) {
                    resIdx = i
                    resLen = j - i + 1
                }
            }
        }
    }

    return s[resIdx : resIdx+resLen]
}

func main() {
    s := \"babad\"
    fmt.Println(\"Longest Palindromic Substring (DP):\", longestPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestPalindromicSubstring.TwoPointers
    set output_file "LongestPalindromeExpandCenter.go"

    set template_content "package main

import (
    \"fmt\"
)

func longestPalindrome(s string) string {
    resIdx, resLen := 0, 0

    for i := 0; i < len(s); i++ {
        // odd length
        l, r := i, i
        for l >= 0 && r < len(s) && s[l] == s[r] {
            if r-l+1 > resLen {
                resIdx = l
                resLen = r - l + 1
            }
            l--
            r++
        }

        // even length
        l, r = i, i+1
        for l >= 0 && r < len(s) && s[l] == s[r] {
            if r-l+1 > resLen {
                resIdx = l
                resLen = r - l + 1
            }
            l--
            r++
        }
    }

    return s[resIdx : resIdx+resLen]
}

func main() {
    s := \"babad\"
    fmt.Println(\"Longest Palindromic Substring (Expand Around Center):\", longestPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestPalindromicSubstring.ManacherAlgorithm
    set output_file "LongestPalindromeManacher.go"

    set template_content "package main

import (
    \"fmt\"
)

func longestPalindrome(s string) string {
    manacher := func(s string) []int {
        t := \"#\"
        for i := 0; i < len(s); i++ {
            t += string(s[i]) + \"#\"
        }
        n := len(t)
        p := make([]int, n)
        l, r := 0, 0
        for i := 0; i < n; i++ {
            if i < r {
                p[i] = min(r-i, p[l+(r-i)])
            }
            for i+p[i]+1 < n && i-p[i]-1 >= 0 && t[i+p[i]+1] == t[i-p[i]-1] {
                p[i]++
            }
            if i + p[i] > r {
                l, r = i - p[i], i + p[i]
            }
        }
        return p
    }

    p := manacher(s)
    resLen, centerIdx := 0, 0
    for i, v := range p {
        if v > resLen {
            resLen = v
            centerIdx = i
        }
    }

    resIdx := (centerIdx - resLen) / 2
    return s[resIdx : resIdx + resLen]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    s := \"babad\"
    fmt.Println(\"Longest Palindromic Substring (Manacher):\", longestPalindrome(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.PalindromicSubstrings.BruteForce
    set output_file "CountPalindromicSubstringsBruteforce.go"

    set template_content "package main

import (
    \"fmt\"
)

func countSubstrings(s string) int {
    res := 0
    for i := range s {
        for j := i; j < len(s); j++ {
            l, r := i, j
            for l < r && s[l] == s[r] {
                l++
                r--
            }
            if l >= r {
                res++
            }
        }
    }
    return res
}

func main() {
    s := \"abc\"
    fmt.Println(\"Count of palindromic substrings (Bruteforce):\", countSubstrings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PalindromicSubstrings.DynamicProgramming
    set output_file "CountPalindromicSubstringsDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func countSubstrings(s string) int {
    n := len(s)
    res := 0
    dp := make([][]bool, n)
    for i := range dp {
        dp[i] = make([]bool, n)
    }

    for i := n - 1; i >= 0; i-- {
        for j := i; j < n; j++ {
            if s[i] == s[j] && (j-i <= 2 || dp[i+1][j-1]) {
                dp[i][j] = true
                res++
            }
        }
    }

    return res
}

func main() {
    s := \"abc\"
    fmt.Println(\"Count of palindromic substrings (DP):\", countSubstrings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.PalindromicSubstrings.TwoPointers
    set output_file "CountPalindromicSubstringsExpandCenter.go"

    set template_content "package main

import (
    \"fmt\"
)

func countSubstrings(s string) int {
    res := 0

    for i := 0; i < len(s); i++ {
        // Odd-length
        l, r := i, i
        for l >= 0 && r < len(s) && s[l] == s[r] {
            res++
            l--
            r++
        }

        // Even-length
        l, r = i, i+1
        for l >= 0 && r < len(s) && s[l] == s[r] {
            res++
            l--
            r++
        }
    }

    return res
}

func main() {
    s := \"abc\"
    fmt.Println(\"Count of palindromic substrings (Expand Around Center):\", countSubstrings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.PalindromicSubstrings.TwoPointers_Optimal
    set output_file "CountPalindromicSubstringsHelper.go"

    set template_content "package main

import (
    \"fmt\"
)

func countSubstrings(s string) int {
    res := 0
    for i := 0; i < len(s); i++ {
        res += countPali(s, i, i)
        res += countPali(s, i, i+1)
    }
    return res
}

func countPali(s string, l, r int) int {
    res := 0
    for l >= 0 && r < len(s) && s[l] == s[r] {
        res++
        l--
        r++
    }
    return res
}

func main() {
    s := \"abc\"
    fmt.Println(\"Count of palindromic substrings (Helper function):\", countSubstrings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PalindromicSubstrings.ManacherAlgorithm
    set output_file "CountPalindromicSubstringsManacher.go"

    set template_content "package main

import (
    \"fmt\"
)

func countSubstrings(s string) int {
    manacher := func(s string) []int {
        t := \"#\" + joinWithSeparator(s, \"#\") + \"#\"
        n := len(t)
        p := make([]int, n)
        l, r := 0, 0
        for i := 0; i < n; i++ {
            if i < r {
                p[i] = min(r-i, p[l+(r-i)])
            }
            for i+p[i]+1 < n && i-p[i]-1 >= 0 && t[i+p[i]+1] == t[i-p[i]-1] {
                p[i]++
            }
            if i+p[i] > r {
                l, r = i-p[i], i+p[i]
            }
        }
        return p
    }

    p := manacher(s)
    res := 0
    for _, val := range p {
        res += (val + 1) / 2
    }
    return res
}

func joinWithSeparator(s, sep string) string {
    result := \"\"
    for i := 0; i < len(s); i++ {
        result += string(s[i]) + sep
    }
    return result[:len(result)-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    s := \"abc\"
    fmt.Println(\"Count of palindromic substrings (Manacher):\", countSubstrings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.DecodeWays.Recursion
    set output_file "NumDecodingsDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func numDecodings(s string) int {
    return dfs(s, 0)
}

func dfs(s string, i int) int {
    if i == len(s) {
        return 1
    }
    if s[i] == '0' {
        return 0
    }
    res := dfs(s, i+1)
    if i < len(s)-1 {
        if s[i] == '1' || (s[i] == '2' && s[i+1] < '7') {
            res += dfs(s, i+2)
        }
    }
    return res
}

func main() {
    s := \"226\"
    fmt.Println(\"Number of ways to decode:\", numDecodings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DecodeWays.DynamicProgramming_Top-Down

    set output_file "NumDecodingsMemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func numDecodings(s string) int {
    return dfs(s, 0, map[int]int{len(s): 1})
}

func dfs(s string, i int, dp map[int]int) int {
    if val, ok := dp[i]; ok {
        return val
    }
    if i == len(s) {
        return 1
    }
    if s[i] == '0' {
        return 0
    }
    res := dfs(s, i+1, dp)
    if i+1 < len(s) && (s[i] == '1' ||
       (s[i] == '2' && s[i+1] <= '6')) {
        res += dfs(s, i+2, dp)
    }
    dp[i] = res
    return res
}

func main() {
    s := \"226\"
    fmt.Println(\"Number of ways to decode (Memoized):\", numDecodings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DecodeWays.DynamicProgramming_Bottom-Up
    set output_file "NumDecodingsDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func numDecodings(s string) int {
    dp := make(map[int]int)
    dp[len(s)] = 1
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] == '0' {
            dp[i] = 0
        } else {
            dp[i] = dp[i+1]
            if i+1 < len(s) && (s[i] == '1' ||
               (s[i] == '2' && s[i+1] <= '6')) {
                dp[i] += dp[i+2]
            }
        }
    }
    return dp[0]
}

func main() {
    s := \"226\"
    fmt.Println(\"Number of ways to decode (Iterative DP):\", numDecodings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DecodeWays.DynamicProgramming_SpaceOptimized
    set output_file "NumDecodingsOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func numDecodings(s string) int {
    dp, dp2 := 0, 0
    dp1 := 1
    for i := len(s) - 1; i >= 0; i-- {
        if s[i] == '0' {
            dp = 0
        } else {
            dp = dp1
        }
        if i+1 < len(s) && (s[i] == '1' ||
           s[i] == '2' && s[i+1] <= '6') {
            dp += dp2
        }
        dp2 = dp1
        dp1 = dp
        dp = 0
    }
    return dp1
}

func main() {
    s := \"226\"
    fmt.Println(\"Number of ways to decode (Optimized DP):\", numDecodings(s))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChange.Recursion
    set output_file "CoinChangeDFS.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func coinChange(coins []int, amount int) int {
    var dfs func(int) int
    dfs = func(amt int) int {
        if amt == 0 {
            return 0
        }

        res := math.MaxInt32
        for _, coin := range coins {
            if amt - coin >= 0 {
                res = min(res, 1 + dfs(amt - coin))
            }
        }

        return res
    }

    minCoins := dfs(amount)
    if minCoins >= math.MaxInt32 {
        return -1
    }
    return minCoins
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    coins := []int{1, 2, 5}
    amount := 11
    fmt.Println(\"Minimum coins needed:\", coinChange(coins, amount))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.CoinChange.DynamicProgramming_Top-Down
    set output_file "CoinChangeMemo.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func coinChange(coins []int, amount int) int {
    var memo = make(map[int]int)
    memo[0] = 0

    var dfs func(int) int
    dfs = func(amt int) int {
        if val, ok := memo[amt]; ok {
            return val
        }

        res := math.MaxInt32
        for _, coin := range coins {
            if amt - coin >= 0 {
                res = min(res, 1 + dfs(amt - coin))
            }
        }
        memo[amt] = res
        return res
    }

    minCoins := dfs(amount)
    if minCoins >= math.MaxInt32 {
        return -1
    }
    return minCoins
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    coins := []int{1, 2, 5}
    amount := 11
    fmt.Println(\"Minimum coins needed (Memoized):\", coinChange(coins, amount))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChange.DynamicProgramming_Bottom-Up
    set output_file "CoinChangeDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func coinChange(coins []int, amount int) int {
    dp := make([]int, amount+1)
    for i := range dp {
        dp[i] = amount + 1
    }
    dp[0] = 0
    for a := 1; a <= amount; a++ {
        for _, c := range coins {
            if a-c >= 0 {
                dp[a] = min(dp[a], 1+dp[a-c])
            }
        }
    }
    if dp[amount] > amount {
        return -1
    }
    return dp[amount]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    coins := []int{1, 2, 5}
    amount := 11
    fmt.Println(\"Minimum coins needed (Iterative DP):\", coinChange(coins, amount))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChange.BreadthFirstSearch
    set output_file "CoinChangeBFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func coinChange(coins []int, amount int) int {
    if amount == 0 {
        return 0
    }
    queue := []int{0}
    seen := make([]bool, amount+1)
    seen[0] = true
    res := 0
    for len(queue) > 0 {
        res++
        size := len(queue)
        for i := 0; i < size; i++ {
            cur := queue[0]
            queue = queue[1:]
            for _, coin := range coins {
                next := cur + coin
                if next == amount {
                    return res
                }
                if next > amount || seen[next] {
                    continue
                }
                seen[next] = true
                queue = append(queue, next)
            }
        }
    }
    return -1
}

func main() {
    coins := []int{1, 2, 5}
    amount := 11
    fmt.Println(\"Minimum coins needed (BFS):\", coinChange(coins, amount))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumProductSubarray.BruteForce
    set output_file "MaxProductBruteForce.go"

    set template_content "package main

import (
    \"fmt\"
)

func maxProduct(nums []int) int {
    res := nums[0]
    for i := 0; i < len(nums); i++ {
        cur := nums[i]
        res = max(res, cur)
        for j := i + 1; j < len(nums); j++ {
            cur *= nums[j]
            res = max(res, cur)
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
    nums := []int{2, 3, -2, 4}
    fmt.Println(\"Maximum product subarray:\", maxProduct(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumProductSubarray.SlidingWindow
    set output_file "MaxProductSubarrayNegatives.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func maxProduct(nums []int) int {
    res := math.MinInt32
    for _, num := range nums {
        res = max(res, num)
    }

    var A [][]int
    var cur []int
    for _, num := range nums {
        if num == 0 {
            if len(cur) > 0 {
                A = append(A, cur)
            }
            cur = nil
        } else {
            cur = append(cur, num)
        }
    }
    if len(cur) > 0 {
        A = append(A, cur)
    }

    for _, sub := range A {
        negs := 0
        for _, i := range sub {
            if i < 0 {
                negs++
            }
        }
        prod := 1
        need := negs
        if negs%2 != 0 {
            need = negs - 1
        }
        negs = 0
        j := 0
        for i := range sub {
            prod *= sub[i]
            if sub[i] < 0 {
                negs++
                for negs > need {
                    prod /= sub[j]
                    if sub[j] < 0 {
                        negs--
                    }
                    j++
                }
            }
            if j <= i {
                res = max(res, prod)
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
    nums := []int{2, 3, -2, 4, -1}
    fmt.Println(\"Maximum product subarray:\", maxProduct(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumProductSubarray.KadaneAlgorithm
    set output_file "MaxProductOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func maxProduct(nums []int) int {
    res := nums[0]
    curMin, curMax := 1, 1
    for _, num := range nums {
        tmp := curMax * num
        curMax = max(num*curMax, max(num*curMin, num))
        curMin = min(tmp, min(num*curMin, num))
        res = max(res, curMax)
    }
    return res
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
    nums := []int{2, 3, -2, 4, -1}
    fmt.Println(\"Maximum product subarray (Optimized):\", maxProduct(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumProductSubarray.PrefixSuffix
    set output_file "MaxProductPrefixSuffix.go"

    set template_content "package main

import (
    \"fmt\"
)

func maxProduct(nums []int) int {
    n := len(nums)
    res := nums[0]
    prefix, suffix := 0, 0

    for i := 0; i < n; i++ {
        if prefix == 0 {
            prefix = 1
        }
        if suffix == 0 {
            suffix = 1
        }

        prefix *= nums[i]
        suffix *= nums[n-1-i]
        res = max(res, max(prefix, suffix))
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
    nums := []int{2, 3, -2, 4, -1}
    fmt.Println(\"Maximum product subarray (Prefix-Suffix):\", maxProduct(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordBreak.Recursion
    set output_file "WordBreakDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func wordBreak(s string, wordDict []string) bool {
    return dfs(s, wordDict, 0)
}

func dfs(s string, wordDict []string, i int) bool {
    if i == len(s) {
        return true
    }

    for _, w := range wordDict {
        if len(s[i:]) >= len(w) && s[i:i+len(w)] == w {
            if dfs(s, wordDict, i+len(w)) {
                return true
            }
        }
    }

    return false
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordBreak.Recursion_HashSet
    set output_file "WordBreakDFSMap.go"

    set template_content "package main

import (
    \"fmt\"
)

func wordBreak(s string, wordDict []string) bool {
    wordSet := make(map[string]bool)
    for _, w := range wordDict {
        wordSet[w] = true
    }
    return dfs(s, wordSet, 0)
}

func dfs(s string, wordSet map[string]bool, i int) bool {
    if i == len(s) {
        return true
    }

    for j := i; j < len(s); j++ {
        if wordSet[s[i:j+1]] {
            if dfs(s, wordSet, j+1) {
                return true
            }
        }
    }

    return false
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented (DFS with map)?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.WordBreak.DynamicProgramming_Top-Down
    set output_file "WordBreakMemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func wordBreak(s string, wordDict []string) bool {
    memo := make(map[int]bool)
    memo[len(s)] = true

    var dfs func(int) bool
    dfs = func(i int) bool {
        if val, found := memo[i]; found {
            return val
        }

        for _, w := range wordDict {
            if i+len(w) <= len(s) && s[i:i+len(w)] == w {
                if dfs(i + len(w)) {
                    memo[i] = true
                    return true
                }
            }
        }

        memo[i] = false
        return false
    }

    return dfs(0)
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented (Memoized DFS)?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordBreak.DynamicProgramming_HashSet
    set output_file "WordBreakMemoOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func wordBreak(s string, wordDict []string) bool {
    wordSet := make(map[string]bool)
    maxLen := 0

    for _, w := range wordDict {
        wordSet[w] = true
        if len(w) > maxLen {
            maxLen = len(w)
        }
    }

    memo := make(map[int]bool)

    var dfs func(int) bool
    dfs = func(i int) bool {
        if val, found := memo[i]; found {
            return val
        }
        if i == len(s) {
            return true
        }
        for j := i; j < len(s) && j < i+maxLen; j++ {
            if wordSet[s[i:j+1]] {
                if dfs(j + 1) {
                    memo[i] = true
                    return true
                }
            }
        }
        memo[i] = false
        return false
    }

    return dfs(0)
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented (Optimized Memo DFS)?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordBreak.DynamicProgramming.Bottom-Up
    set output_file "WordBreakDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func wordBreak(s string, wordDict []string) bool {
    dp := make([]bool, len(s)+1)
    dp[len(s)] = true

    for i := len(s) - 1; i >= 0; i-- {
        for _, w := range wordDict {
            if i+len(w) <= len(s) && s[i:i+len(w)] == w {
                dp[i] = dp[i+len(w)]
            }
            if dp[i] {
                break
            }
        }
    }

    return dp[0]
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented (DP)?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.WordBreak.DynamicProgramming_Trie
    set output_file "WordBreakTrieDP.go"

    set template_content "package main

import (
    \"fmt\"
)

type TrieNode struct {
    children map[rune]*TrieNode
    isWord   bool
}

func NewTrieNode() *TrieNode {
    return &TrieNode{children: make(map[rune]*TrieNode)}
}

type Trie struct {
    root *TrieNode
}

func NewTrie() *Trie {
    return &Trie{root: NewTrieNode()}
}

func (t *Trie) Insert(word string) {
    node := t.root
    for _, char := range word {
        if _, found := node.children[char]; !found {
            node.children[char] = NewTrieNode()
        }
        node = node.children[char]
    }
    node.isWord = true
}

func (t *Trie) Search(s string, i, j int) bool {
    node := t.root
    for idx := i; idx <= j; idx++ {
        char := rune(s[idx])
        if _, found := node.children[char]; !found {
            return false
        }
        node = node.children[char]
    }
    return node.isWord
}

func wordBreak(s string, wordDict []string) bool {
    trie := NewTrie()
    for _, word := range wordDict {
        trie.Insert(word)
    }

    dp := make([]bool, len(s)+1)
    dp[len(s)] = true

    maxLength := 0
    for _, word := range wordDict {
        if len(word) > maxLength {
            maxLength = len(word)
        }
    }

    for i := len(s) - 1; i >= 0; i-- {
        for j := i; j < len(s) && j < i+maxLength; j++ {
            if trie.Search(s, i, j) {
                dp[i] = dp[j+1]
                if dp[i] {
                    break
                }
            }
        }
    }

    return dp[0]
}

func main() {
    s := \"leetcode\"
    wordDict := []string{\"leet\", \"code\"}
    fmt.Println(\"Can the word be segmented (Trie + DP)?\", wordBreak(s, wordDict))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.Recursion
    set output_file "LISDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLIS(nums []int) int {
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == len(nums) {
            return 0
        }

        LIS := dfs(i + 1, j) // not include

        if j == -1 || nums[j] < nums[i] {
            LIS = max(LIS, 1 + dfs(i + 1, i)) // include
        }

        return LIS
    }

    return dfs(0, -1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence:\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.DynamicProgramming-Top-Down-I
    set output_file "LISMemoDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLIS(nums []int) int {
    n := len(nums)
    memo := make([][]int, n)
    for i := range memo {
        memo[i] = make([]int, n+1)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == n {
            return 0
        }
        if memo[i][j+1] != -1 {
            return memo[i][j+1]
        }

        LIS := dfs(i + 1, j)

        if j == -1 || nums[j] < nums[i] {
            LIS = max(LIS, 1 + dfs(i + 1, i))
        }

        memo[i][j+1] = LIS
        return LIS
    }

    return dfs(0, -1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (Memoized DFS):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.DynamicProgramming_Top-DownII
    set output_file "LISMemoDFSNext.go"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLIS(nums []int) int {
    n := len(nums)
    memo := make([]int, n)
    for i := range memo {
        memo[i] = -1
    }

    var dfs func(int) int
    dfs = func(i int) int {
        if memo[i] != -1 {
            return memo[i]
        }

        LIS := 1
        for j := i + 1; j < n; j++ {
            if nums[i] < nums[j] {
                LIS = max(LIS, 1+dfs(j))
            }
        }

        memo[i] = LIS
        return LIS
    }

    maxLIS := 1
    for i := 0; i < n; i++ {
        maxLIS = max(maxLIS, dfs(i))
    }

    return maxLIS
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (Memo DFS Next):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.LongestIncreasingSubsequence.DynamicProgramming_Bottom-UpI
    set output_file "LISDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLIS(nums []int) int {
    n := len(nums)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := n - 1; i >= 0; i-- {
        for j := i - 1; j >= -1; j-- {
            LIS := dp[i+1][j+1] // Not including nums[i]

            if j == -1 || nums[j] < nums[i] {
                LIS = max(LIS, 1+dp[i+1][i+1]) // Including nums[i]
            }

            dp[i][j+1] = LIS
        }
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (DP):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.DynamicProgramming_Bottom-UpII
    set output_file "LISClassicDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func lengthOfLIS(nums []int) int {
    LIS := make([]int, len(nums))
    for i := range LIS {
        LIS[i] = 1
    }

    for i := len(nums) - 1; i >= 0; i-- {
        for j := i + 1; j < len(nums); j++ {
            if nums[i] < nums[j] {
                if 1 + LIS[j] > LIS[i] {
                    LIS[i] = 1 + LIS[j]
                }
            }
        }
    }

    maxLen := 1
    for _, length := range LIS {
        if length > maxLen {
            maxLen = length
        }
    }

    return maxLen
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (Classic DP):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.SegmentTree
    set output_file "LISSegmentTree.go"
    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

type SegmentTree struct {
    n    int
    tree []int
}

func NewSegmentTree(N int) *SegmentTree {
    n := N
    for (n & (n - 1)) != 0 {
        n++
    }
    tree := make([]int, 2*n)
    return &SegmentTree{n: n, tree: tree}
}

func (seg *SegmentTree) Update(i, val int) {
    seg.tree[seg.n+i] = val
    j := (seg.n + i) >> 1
    for j >= 1 {
        seg.tree[j] = max(seg.tree[j<<1], seg.tree[j<<1|1])
        j >>= 1
    }
}

func (seg *SegmentTree) Query(l, r int) int {
    if l > r {
        return 0
    }
    res := -1 << 63
    l += seg.n
    r += seg.n + 1
    for l < r {
        if l&1 != 0 {
            res = max(res, seg.tree[l])
            l++
        }
        if r&1 != 0 {
            r--
            res = max(res, seg.tree[r])
        }
        l >>= 1
        r >>= 1
    }
    return res
}

func compress(arr []int) []int {
    sortedArr := make([]int, len(arr))
    copy(sortedArr, arr)
    sort.Ints(sortedArr)
    order := make([]int, len(arr))
    for i, num := range arr {
        order[i] = sort.SearchInts(sortedArr, num)
    }
    return order
}

func lengthOfLIS(nums []int) int {
    nums = compress(nums)
    n := len(nums)
    segTree := NewSegmentTree(n)
    LIS := 0
    for _, num := range nums {
        curLIS := segTree.Query(0, num-1) + 1
        segTree.Update(num, curLIS)
        LIS = max(LIS, curLIS)
    }
    return LIS
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (Segment Tree):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestIncreasingSubsequence.DynamicProgramming_BinarySearch
    set output_file "LISBinarySearch.go"
    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func lengthOfLIS(nums []int) int {
    dp := []int{}
    dp = append(dp, nums[0])

    LIS := 1
    for i := 1; i < len(nums); i++ {
        if dp[len(dp)-1] < nums[i] {
            dp = append(dp, nums[i])
            LIS++
            continue
        }

        idx := sort.Search(len(dp), func(j int) bool {
            return dp[j] >= nums[i]
        })
        dp[idx] = nums[i]
    }

    return LIS
}

func main() {
    nums := []int{10, 9, 2, 5, 3, 7, 101, 18}
    fmt.Println(\"Length of Longest Increasing Subsequence (Binary Search):\", lengthOfLIS(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.PartitionEqualSubsetSum.Recursion
    set output_file "CanPartitionDFS.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if sum%2 != 0 {
        return false
    }

    target := sum / 2

    var dfs func(int, int) bool
    dfs = func(i int, target int) bool {
        if target == 0 {
            return true
        }
        if i >= len(nums) || target < 0 {
            return false
        }

        return dfs(i+1, target) || dfs(i+1, target-nums[i])
    }

    return dfs(0, target)
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets:\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionEqualSubsetSum.DynamicProgramming_Top-Down
    set output_file "CanPartitionMemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%2 != 0 {
        return false
    }

    target := total / 2
    n := len(nums)
    memo := make([][]int, n+1)
    for i := range memo {
        memo[i] = make([]int, target+1)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(int, int) bool
    dfs = func(i, target int) bool {
        if target == 0 {
            return true
        }
        if i >= n || target < 0 {
            return false
        }
        if memo[i][target] != -1 {
            return memo[i][target] == 1
        }

        found := dfs(i+1, target) || dfs(i+1, target-nums[i])
        if found {
            memo[i][target] = 1
        } else {
            memo[i][target] = 0
        }

        return found
    }

    return dfs(0, target)
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets (Memoized):\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionEqualSubsetSum.DynamicProgramming_SpaceOptimized
    set output_file "CanPartitionDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%2 != 0 {
        return false
    }

    target := total / 2
    n := len(nums)
    dp := make([][]bool, n+1)
    for i := range dp {
        dp[i] = make([]bool, target+1)
    }

    for i := 0; i <= n; i++ {
        dp[i][0] = true
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= target; j++ {
            if nums[i-1] <= j {
                dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i-1]]
            } else {
                dp[i][j] = dp[i-1][j]
            }
        }
    }

    return dp[n][target]
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets (DP):\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionEqualSubsetSum.DynamicProgramming_HashSet
    set output_file "CanPartitionOptimized.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%2 != 0 {
        return false
    }

    target := total / 2
    dp := map[int]bool{0: true}

    for i := len(nums) - 1; i >= 0; i-- {
        nextDP := map[int]bool{}
        for t := range dp {
            if t+nums[i] == target {
                return true
            }
            nextDP[t+nums[i]] = true
            nextDP[t] = true
        }
        dp = nextDP
    }

    return false
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets (Optimized DP):\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionEqualSubsetSum.DynamicProgramming_Optimal
    set output_file "CanPartitionDP1D.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%2 != 0 {
        return false
    }

    target := total / 2
    dp := make([]bool, target+1)
    dp[0] = true

    for _, num := range nums {
        for j := target; j >= num; j-- {
            dp[j] = dp[j] || dp[j-num]
        }
    }

    return dp[target]
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets (1D DP):\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionEqualSubsetSum.DynamicProgramming_Bitset
    set output_file "CanPartitionBitDP.go"

    set template_content "package main

import (
    \"fmt\"
)

func canPartition(nums []int) bool {
    total := 0
    for _, num := range nums {
        total += num
    }
    if total%2 != 0 {
        return false
    }

    target := total / 2
    dp := 1 << 0

    for _, num := range nums {
        dp |= dp << num
    }

    return (dp & (1 << target)) != 0
}

func main() {
    nums := []int{1, 5, 11, 5}
    fmt.Println(\"Can partition into equal subsets (Bit DP):\", canPartition(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.LinearSearch
    set output_file "InsertInterval.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    result := insert(intervals, newInterval)
    fmt.Println(\"Intervals after insertion:\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.BinarySearch
    set output_file "InsertIntervalBinary.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    result := insert(intervals, newInterval)
    fmt.Println(\"Intervals after insertion (binary search):\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.Greedy
    set output_file "InsertIntervalCompact.go"

    set template_content "package main

import (
    \"fmt\"
)

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
    result := insert(intervals, newInterval)
    fmt.Println(\"Intervals after insertion (compact version):\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
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
    result := merge(intervals)
    fmt.Println(\"Merged intervals:\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeIntervals.SweepLineAlgorithm
    set output_file "MergeIntervalsSweep.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
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
    intervals := [][]int{{1,3},{2,6},{8,10},{15,18}}
    result := merge(intervals)
    fmt.Println(\"Merged intervals (sweep line):\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeIntervals.Greedy
    set output_file "MergeIntervals.go"

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
    fmt.Println(\"Merged Intervals:\", merge(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Non-overlappingIntervals.Recursion
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
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Non-overlappingIntervals.DynamicProgramming_Top-Down
    set output_file "EraseOverlapIntervalsMemo.go"

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
    set_color FFAD8D
    echo "$output_file created"
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
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_BinarySearch
    set output_file "EraseOverlapIntervalsDPBS.go"

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
    intervals := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Greedy_SortByStart
    set output_file "EraseOverlapIntervalsGreedy.go"

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
    intervals := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Minimum intervals to remove (Greedy):\", eraseOverlapIntervals(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Greedy_SortByEnd
    set output_file "EraseOverlapIntervalsOptimal.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
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
    intervals := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Minimum intervals to remove (Optimal Greedy):\", eraseOverlapIntervals(intervals))
}
"

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
)

type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i].start < intervals[j].start
    })

    endTimes := []int{}
    for _, interval := range intervals {
        inserted := false
        for i, t := range endTimes {
            if t <= interval.start {
                endTimes[i] = interval.end
                inserted = true
                break
            }
        }
        if !inserted {
            endTimes = append(endTimes, interval.end)
        }
    }

    return len(endTimes)
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
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.MeetingRoomsII.SweepLineAlgorithm
    set output_file "MinMeetingRoomsSweepLine.go"

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
    fmt.Println(\"Minimum meeting rooms needed (Sweep Line):\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.MeetingRoomsII.TwoPointers
    set output_file "MinMeetingRoomsTwoPointers.go"

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
    fmt.Println(\"Minimum meeting rooms needed (Two Pointers):\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.MeetingRoomsII.Greedy
    set output_file "MinMeetingRoomsSweepLine.go"

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
    var time [][]int
    for _, i := range intervals {
        time = append(time, []int{i.start, 1})
        time = append(time, []int{i.end, -1})
    }

    sort.Slice(time, func(i, j int) bool {
        if time[i][0] == time[j][0] {
            return time[i][1] < time[j][1]
        }
        return time[i][0] < time[j][0]
    })

    res, count := 0, 0
    for _, t := range time {
        count += t[1]
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
    fmt.Println(\"Minimum meeting rooms needed (Sweep Line):\", minMeetingRooms(intervals))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SlicePrintGrid
    set output_file "PrintGrid.go"

    set template_content "package main

import (
    \"fmt\"
)

var grid = [][]string{
    {\".\", \".\", \".\", \".\", \".\", \".\"},
    {\".\", \"0\", \"0\", \".\", \".\", \".\"},
    {\"0\", \"0\", \"0\", \"0\", \".\", \".\"},
    {\"0\", \"0\", \"0\", \"0\", \"0\", \".\"},
    {\".\", \"0\", \"0\", \"0\", \"0\", \"0\"},
    {\"0\", \"0\", \"0\", \"0\", \"0\", \".\"},
    {\"0\", \"0\", \"0\", \"0\", \".\", \".\"},
    {\".\", \"0\", \"0\", \".\", \".\", \".\"},
    {\".\", \".\", \".\", \".\", \".\", \".\"},
}

func makeGrid() {
    for i := 0; i < 6; i++ { // Loop over columns
        for j := 0; j < 9; j++ { // Loop over rows
            fmt.Print(grid[j][i])
        }
        fmt.Println()
    }
}

func main() {
    makeGrid()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceIterate
    set output_file "IterateSlice.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    // Срез з будь-якою кількістю елементів
    fruits := []string{\"apple\", \"pear\", \"banana\", \"orange\"}

    fmt.Println(\"--- Range with index ---\")
    for index, value := range fruits {
        fmt.Println(index, value)
    }

    fmt.Println(\"--- Range without index ---\")
    for _, value := range fruits {
        fmt.Println(value)
    }

    fmt.Println(\"--- Classic for loop ---\")
    for i := 0; i < len(fruits); i++ {
        fmt.Println(fruits[i])
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceIterateMatrix
    set output_file "IterateSliceMatrix.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    // Одномірний срез
    nums := []int{1, 2, 3, 4, 5}

    fmt.Println(\"--- Classic for loop ---\")
    for i := 0; i < len(nums); i++ {
        fmt.Println(nums[i])
    }

    fmt.Println(\"--- Range with index ---\")
    for index, element := range nums {
        fmt.Printf(\"Index: %d Element: %d\\n\", index, element)
    }

    fmt.Println(\"--- Range without index ---\")
    for _, element := range nums {
        fmt.Printf(\"Element: %d\\n\", element)
    }

    fmt.Println(\"-----------------------------\")

    // Двовимірний срез (матриця)
    matrix := [][]int{
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9},
    }

    fmt.Println(\"Matrix:\")
    for _, row := range matrix {
        for _, column := range row {
            fmt.Printf(\"%d \", column)
        }
        fmt.Println()
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceCountElementsMapSorted
    set output_file "CountElementsMapSorted.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func main() {
    lines := []string{
        \"apple\", \"banana\", \"apple\", \"orange\", \"banana\", \"apple\",
    }

    // Створюємо map для підрахунку
    counts := make(map[string]int)
    for _, line := range lines {
        counts[line]++
    }

    // Вивід результатів
    for name, count := range counts {
        fmt.Printf(\"%s: %d\\n\", name, count)
    }

    // Перетворюємо map у slice для сортування
    type kv struct {
        Key   string
        Value int
    }

    var sorted []kv
    for k, v := range counts {
        sorted = append(sorted, kv{k, v})
    }

    // Сортування по значенню у порядку спадання
    sort.Slice(sorted, func(i, j int) bool {
        return sorted[i].Value > sorted[j].Value
    })

    // Вивід
    for _, kv := range sorted {
        fmt.Printf(\"%s: %d\\n\", kv.Key, kv.Value)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceAverage
    set output_file "AverageSlice.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    numbers := []float64{10.5, 20.0, 30.25, 40.75, 50.0}

    var sum float64 = 0
    for _, number := range numbers {
        sum += number
    }

    count := float64(len(numbers))
    average := sum / count

    fmt.Printf(\"Average: %.2f\\n\", average)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceBreakNestedLoopExample
    set output_file "BreakNestedLoopExample.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    people := [5]string{\"Mary\", \"Mark\", \"Joy\", \"Theo\", \"Shallom\"}
    friends := [2]string{\"Joy\", \"Shallom\"}

outer:
    for index, name := range people {
        for _, friend := range friends {
            if name == friend {
                fmt.Printf(\"Found a friend %s at index %d\\n\", friend, index)
                break outer
            }
        }
    }
    fmt.Println(\"Next instruction after the break\")
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceMultiplicationTable
    set output_file "MultiplicationTable.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    max := 10 // можна змінити на будь-яке число

    // print the header
    fmt.Printf(\"%5s\", \"X\")
    for i := 0; i <= max; i++ {
        fmt.Printf(\"%5d\", i)
    }
    fmt.Println()

    for i := 0; i <= max; i++ {
        // print the vertical header
        fmt.Printf(\"%5d\", i)

        // print the cells
        for j := 0; j <= max; j++ {
            fmt.Printf(\"%5d\", i*j)
        }
        fmt.Println()
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceBuildUserProfile
    set output_file "BuildUserProfile.go"

    set template_content "package main

import (
    \"fmt\"
)

// buildProfile builds a map containing everything we know about a user.
func buildProfile(first, last string, userInfo map[string]string) map[string]string {
    profile := make(map[string]string)
    profile[\"first name\"] = first
    profile[\"last name\"] = last

    // Print the profile dictionary
    fmt.Println(\"Profile:\")
    for key, value := range profile {
        fmt.Printf(\"%s: %s\\n\", key, value)
    }

    // Print user info details
    for key, value := range userInfo {
        fmt.Printf(\"\\nkey: %s\\n\", key)
        fmt.Printf(\"value: %s\\n\", value)
        profile[key] = value
    }
    return profile
}

func main() {
    // Define additional user information as a map
    userInfo := map[string]string{
        \"location\": \"princeton\",
        \"field\":    \"physics\",
    }

    // Build the profile
    userProfile := buildProfile(\"albert\", \"einstein\", userInfo)

    // Print the complete user profile
    fmt.Println(\"\\nComplete user profile:\")
    for key, value := range userProfile {
        fmt.Printf(\"%s: %s\\n\", key, value)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SlicePlanetsTerraform
    set output_file "PlanetsTerraform.go"

    set template_content "package main

import (
    \"fmt\"
)

type Planets []string

// Метод типа Planets
func (planets Planets) terraform() {
    for i := range planets {
        planets[i] = \"Новый \" + planets[i]
    }
}

func main() {
    planets := []string{
        \"Меркурий\", \"Венера\", \"Земля\", \"Марс\",
        \"Юпитер\", \"Сатурн\", \"Уран\", \"Нептун\",
    }

    // Изменение подмассивов
    Planets(planets[3:4]).terraform()
    Planets(planets[6:]).terraform()

    fmt.Println(planets)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceIterationDemo
    set output_file "IterationDemo.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    // Итерация по срезу
    sl := []int64{9, 8, 7}
    for key, value := range sl {
        fmt.Printf(\"key: %v, val: %v \\n\", key, value)
    }

    for _, value := range sl {
        fmt.Println(value)
    }

    // Итерация по мапе
    ages := map[string]int{
        \"Андрей\":    30,
        \"Анастасия\": 25,
    }
    for key, value := range ages {
        fmt.Println(key)
        fmt.Println(value)
    }

    // Итерация по строке
    word := \"слёрм\"
    fmt.Println(\"--- Итерируем по байтам ---\")
    for i := 0; i < len(word); i++ {
        fmt.Println(word[i])
        fmt.Printf(\"%T\\n\", word[i])
    }

    fmt.Println(\"--- Итерируем по рунам ---\")
    for key, value := range word {
        fmt.Println(key)
        fmt.Println(value)
        fmt.Printf(\"%T\\n\", value)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.SliceRandomSearch
    set output_file "RandomSliceSearch.go"

    set template_content "package main

import (
    \"fmt\"
    \"math/rand\"
    \"time\"
)

func main() {
    // Инициализация случайного генератора
    rand.Seed(time.Now().UTC().UnixNano())
    n := 5
    a := []int{}

    // Заполнение среза случайными числами
    for i := 0; i < n; i++ {
        k := rand.Intn(100)
        a = append(a, k)
    }
    fmt.Println(\"Generated slice:\", a)

    // Пошук елемента
    find := 5
    isExist := false
    for _, v := range a {
        if find == v {
            isExist = true
            break
        }
    }

    if isExist {
        fmt.Println(find, \"found in slice\")
    } else {
        fmt.Println(find, \"not found in slice\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SliceDemo
    set output_file "SliceDemo.go"

    set template_content "package main

import (
    \"fmt\"
    \"strings\"
)

func main() {
    fmt.Println(\"=== Работа с срезом ===\")
    n := 5
    a := []int{}
    fmt.Println(len(a))
    fmt.Printf(\"Длина среза ДО добавления элементов: %d\\n\", len(a))

    for i := 0; i < n; i++ {
        k := 5
        a = append(a, k)
    }

    fmt.Println(len(a))
    fmt.Printf(\"Длина среза ПОСЛЕ добавления элементов: %d\\n\", len(a))

    strSlice := []string{}
    for _, v := range a {
        strSlice = append(strSlice, fmt.Sprintf(\"%d\", v))
    }
    fmt.Println(\"Содержимое среза:\", strings.Join(strSlice, \", \"))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LoopExamples
    set output_file "ForLoopExamples.go"

    set template_content "package main

import \"fmt\"

// Глобальные переменные, доступные во всех функциях
var sl = []int{1, 2, 3}                     // Срез
var profile = map[int]string{1: \"Hoasker\", 2: \"RZ\"} // Карта

func main() {
    // Бесконечный цикл for + break
    for {
        fmt.Println(\"Loop iteration\")
        break
    }

    loopWithCondition(\"loopWithCondition\")
    fmt.Println(\"------\")
    loopWithContinue(\"loopWithContinue\")
    fmt.Println(\"------\")
    whileStyleLoop(\"whileStyleLoop\")
    fmt.Println(\"------\")
    cStyleLoop(\"cStyleLoop\")
    fmt.Println(\"------\")
    rangeOverSlice(\"rangeOverSlice\")
    fmt.Println(\"------\")
    rangeOverSliceWithValues(\"rangeOverSliceWithValues\")
    fmt.Println(\"------\")
    rangeOverMapKeys(\"rangeOverMapKeys\")
    fmt.Println(\"------\")
    rangeOverMapKeysAndValues(\"rangeOverMapKeysAndValues\")
    fmt.Println(\"------\")
    rangeOverMapValues(\"rangeOverMapValues\")
    fmt.Println(\"------\")
    rangeOverString(\"rangeOverString\")
}

// Цикл for с логическим условием
func loopWithCondition(name string) {
    isRun := true
    for isRun {
        fmt.Println(name, \"Loop iteration with condition\")
        isRun = false
    }
}

// for с continue
func loopWithContinue(name string) {
    for i := 0; i < 2; i++ {
        fmt.Println(name, \"Loop iteration\", i)
        if i == 1 {
            continue
        }
    }
}

// while-стиль цикл (for с логическим условием)
func whileStyleLoop(name string) {
    idx := 0
    for idx < len(sl) {
        fmt.Println(name, \"while-style loop idx:\", idx, \"value:\", sl[idx])
        idx++
    }
}

// for в C-стиле
func cStyleLoop(name string) {
    for i := 0; i < len(sl); i++ {
        fmt.Println(name, \"c-style loop\", i, sl[i])
    }
}

// range по срезу (индексы)
func rangeOverSlice(name string) {
    for idx := range sl {
        fmt.Println(name, \"range slice by index\", idx)
    }
}

// range по срезу (индексы + значения)
func rangeOverSliceWithValues(name string) {
    for idx, val := range sl {
        fmt.Println(name, \"range slice by idx-value\", idx, val)
    }
}

// range по map (только ключи)
func rangeOverMapKeys(name string) {
    for key := range profile {
        fmt.Println(name, \"range map by key\", key)
    }
}

// range по map (ключи + значения)
func rangeOverMapKeysAndValues(name string) {
    for key, val := range profile {
        fmt.Println(name, \"range map by key-val\", key, val)
    }
}

// range по map (только значения)
func rangeOverMapValues(name string) {
    for _, val := range profile {
        fmt.Println(name, \"range map by val\", val)
    }
}

// range по строке (Unicode-символы)
func rangeOverString(name string) {
    str := \"Hello, World!\"
    for pos, char := range str {
        fmt.Printf(\"%s %#U at pos %d\\n\", name, char, pos)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.LoopsInGo
    set output_file "LoopsInGo.go"

    set template_content "package main

import \"fmt\"

func main() {
    fmt.Println(\"Welcome to loops in GoLang\")

    // Масив днів тижня
    days := []string{\"Sunday\", \"Tuesday\", \"Wednesday\", \"Friday\", \"Saturday\"}
    fmt.Println(days)

    // --- Приклад 1: Класичний for з лічильником ---
    fmt.Println(\"Loops example 1:\")
    for d := 0; d < len(days); d++ {
        fmt.Println(days[d])
    }

    // --- Приклад 2: Цикл for range з індексами ---
    fmt.Println(\"Loops example 2:\")
    for i := range days {
        fmt.Println(days[i])
    }

    // --- Приклад 3: Цикл for range з індексами і значеннями ---
    fmt.Println(\"Loops example 3:\")
    for index, day := range days {
        fmt.Printf(\"Index is %v and value is %v\\n\", index, day)
    }

    // --- Приклад 4: while-подібний цикл з break і goto ---
    rogueValue := 1
    for rogueValue < 10 {
        if rogueValue == 2 {
            goto lco
        }
        if rogueValue == 5 {
            break
        }
        fmt.Println(\"Value is:\", rogueValue)
        rogueValue++
    }

lco:
    fmt.Println(\"Jumping at LearnCodeOnline\")

    // --- Приклад 5: цикл із continue ---
    anotherValue := 1
    for anotherValue < 10 {
        if anotherValue == 5 {
            anotherValue++
            continue
        }
        fmt.Println(\"Value is:\", anotherValue)
        anotherValue++
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LoopsInGo
    set output_file "LoopsInGo.go"

    set template_content "package main

import \"fmt\"

func main() {
    fmt.Println(\"Welcome to loops in GoLang\")

    // Масив днів тижня
    days := []string{\"Sunday\", \"Tuesday\", \"Wednesday\", \"Friday\", \"Saturday\"}
    fmt.Println(days)

    // --- Приклад 1: Класичний for з лічильником ---
    fmt.Println(\"Loops example 1:\")
    for d := 0; d < len(days); d++ {
        fmt.Println(days[d])
    }

    // --- Приклад 2: Цикл for range з індексами ---
    fmt.Println(\"Loops example 2:\")
    for i := range days {
        fmt.Println(days[i])
    }

    // --- Приклад 3: Цикл for range з індексами і значеннями ---
    fmt.Println(\"Loops example 3:\")
    for index, day := range days {
        fmt.Printf(\"Index is %v and value is %v\\n\", index, day)
    }

    // --- Приклад 4: while-подібний цикл з break і goto ---
    rogueValue := 1
    for rogueValue < 10 {
        if rogueValue == 2 {
            goto lco
        }
        if rogueValue == 5 {
            break
        }
        fmt.Println(\"Value is:\", rogueValue)
        rogueValue++
    }

lco:
    fmt.Println(\"Jumping at LearnCodeOnline\")

    // --- Приклад 5: цикл із continue ---
    anotherValue := 1
    for anotherValue < 10 {
        if anotherValue == 5 {
            anotherValue++
            continue
        }
        fmt.Println(\"Value is:\", anotherValue)
        anotherValue++
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LoopsShowcase
    set output_file "LoopsShowcase.go"

    set template_content "package main

import (
    \"fmt\"
    \"time\"
)

func main() {
    // === Прямий цикл з інкрементом ===
    for num := 0; num < 10; num += 1 {
        println(num) // --> 0,1,2,3,4,5,6,7,8,9
    }

    fmt.Println(\"----------------------------------------\")

    // === Зворотній цикл з декрементом ===
    for num := 100; num >= 0; num -= 1 {
        println(num)
    }

    fmt.Println(\"----------------------------------------\")

    // === Підрахунок суми чисел від 10 до 0 ===
    jami := 0
    for i := 10; i >= 0; i-- {
        jami += i
    }
    fmt.Printf(\"The sum of numbers from 10 to 0 is: %d\\n\", jami)

    fmt.Println(\"----------------------------------------\")

    // === While-стиль цикл ===
    i := 0
    for i <= 100 {
        fmt.Println(\"-->\", i)
        i++
    }

    fmt.Println(\"----------------------------------------\")

    // === Пропуск парних чисел через continue ===
    for n := 1; n <= 100; n++ {
        if n%2 == 0 {
            continue
        }
        fmt.Println(n)
    }

    fmt.Println(\"----------------------------------------\")

    // === Вкладений цикл для побудови шаблону ===
    for i := 1; i <= 10; i++ {
        for v := 1; v <= 10; v++ {
            fmt.Print(\"* \")
        }
        fmt.Println()
    }

    fmt.Println(\"----------------------------------------\")

    // === Безкінечний цикл з break ===
    var x int = 0
    for {
        if 7 == x {
            break
        }
        if x <= 10 {
            fmt.Println(\"loop\", x)
        }
        x++
    }

    fmt.Println(\"----------------------------------------\")

    // === Цикл з затримкою ===
    var number int = 0
    for number <= 11 {
        fmt.Println(\"-->\", number)
        number++
        time.Sleep(1 * time.Second)
    }
    fmt.Println(\"Next time\")

    fmt.Println(\"----------------------------------------\")

    var number2 int = 12
    for number2 <= 20 {
        fmt.Println(\"-->\", number2)
        number2++
        time.Sleep(500 * time.Millisecond)
    }

    fmt.Println(\"----------------------------------------\")

    // === Ще один цикл від 0 до 21 ===
    for num := 0; num < 22; num += 1 {
        fmt.Println(num)
    }

    fmt.Println(\"----------------------------------------\")

    // === Класичний цикл з ініціалізацією, умовою і пост-операцією ===
    for i := 1; i <= 5; i++ {
        fmt.Println(\"No more\", i)
    }

    fmt.Println(\"----------------------------------------\")

    // === While-style цикл із інкрементом ===
    i2 := 1
    for i2 <= 100 {
        fmt.Println(\"I am learning Go:\", i2)
        i2++
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.LoopIterationExamples
    set output_file "LoopIterationExamples.go"

    set template_content "package main

import \"fmt\"

// === Головна функція ===
func main() {
    mySlice := []string{\"Prasetiyo\", \"Angga\", \"Diana\"}

    for i := 0; i < len(mySlice); i++ {
        fmt.Println(mySlice[i])
    }

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main1 (iterate string):\")
    main1()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main2 (iterate array):\")
    main2()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main3 (iterate slice):\")
    main3()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main4 (iterate map):\")
    main4()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main5 (vowels with if):\")
    main5()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main6 (vowels with switch):\")
    main6()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main7 (break example):\")
    main7()

    fmt.Println(\"-----------------------------------\")
    fmt.Println(\"Run main8 (continue example):\")
    main8()
}

// === Ітерація по символах у рядку ===
func main1() {
    myString := \"Sirclo\"
    for _, eachString := range myString {
        fmt.Println(string(eachString))
    }
}

// === Ітерація по масиву ===
func main2() {
    myArray := [5]string{\"Prasetiyo\", \"Diana\", \"Angga\", \"Satria\", \"Ramdani\"}
    for _, eachArray := range myArray {
        fmt.Println(eachArray)
    }
}

// === Ітерація по зрізу ===
func main3() {
    mySlice := []string{\"Prasetiyo\", \"Diana\", \"Angga\", \"Satria\", \"Ramdani\"}
    for _, eachSlice := range mySlice {
        fmt.Println(eachSlice)
    }
}

// === Ітерація по мапі ===
func main4() {
    myMap := map[string]string{
        \"Name\":  \"Prasetiyo\",
        \"Hobby\": \"Coding\",
    }

    for _, eachMap := range myMap {
        fmt.Println(eachMap)
    }
}

// === Пошук голосних через if ===
func main5() {
    title := \"I am learning the fundamentals of Golang\"

    for index, letter := range title {
        letterString := string(letter)
        if letterString == \"a\" || letterString == \"i\" || letterString == \"u\" || letterString == \"e\" || letterString == \"o\" {
            fmt.Println(\"index:\", index, \"letter:\", letterString)
        }
    }
}

// === Пошук голосних через switch ===
func main6() {
    title := \"I am learning the fundamentals of Golang\"

    for index, letter := range title {
        letterString := string(letter)
        switch letterString {
        case \"a\", \"i\", \"u\", \"e\", \"o\":
            fmt.Println(\"index:\", index, \" letter:\", letterString)
        }
    }
}

// === Цикл із break ===
func main7() {
    for i := 0; i < 10; i++ {
        fmt.Println(\"Iteration number\", i)
        if i == 5 {
            break // вихід із циклу
        }
    }
}

// === Цикл із continue ===
func main8() {
    for i := 0; i < 10; i++ {
        if i%2 == 0 {
            continue // пропустити парні числа
        }
        fmt.Println(i, \"is an odd number\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end

function algoG.LoopAndArrayExamples
    set output_file "LoopAndArrayExamples.go"

    set template_content "package main

import (
    \"fmt\"
)

// === Example 1: SumLoop ===
// Підрахунок суми чисел від 0 до 9
func SumLoop() int {
    result := 0
    for i := 0; i < 10; i++ {
        result += i
    }
    return result
}

// === Example 2: SumArray ===
// Підрахунок суми елементів у масиві (slice)
func SumArray(arr []int) int {
    var result int
    for _, num := range arr {
        result += num
    }
    return result
}

// === Example 3: ListElements ===
// Вивід елементів масиву з їхніми індексами
func ListElements(elements []string) {
    for index, value := range elements {
        fmt.Println(index, value)
    }
}

// === Example 4: Count Repeats ===
// Підрахунок кількості повторень кожного числа
func CountRepeats() {
    arr := []int{1, 11, 2, 1, 3, 4, 2, 2}
    numbers := []int{}
    repeats := []int{}

    // Беремо кожне число по черзі
    for i := 0; i < len(arr); i++ {
        temp := arr[i]
        counter := 0

        // Підрахунок повторів числа temp у всьому масиві
        for j := 0; j < len(arr); j++ {
            if temp == arr[j] {
                counter++
            }
        }

        // Перевіряємо, чи вже є це число у списку унікальних
        isNotExist := true
        for k := 0; k < len(numbers); k++ {
            if numbers[k] == temp {
                isNotExist = false
                break
            }
        }

        // Якщо ще не існує — додаємо
        if isNotExist {
            numbers = append(numbers, temp)
            repeats = append(repeats, counter)
        }
    }

    // Виводимо результати
    for i := 0; i < len(numbers); i++ {
        fmt.Println(numbers[i], repeats[i])
    }
}

// === Example 5: Slice Demo ===
// Демонстрація роботи зі зрізом
func SliceDemo() {
    sl := []string{\"yerassyl\", \"anel\", \"aidar\", \"kairat\", \"1232\"}
    a := sl[2:4]
    fmt.Println(a)
}

// === MAIN ===
func main() {
    fmt.Println(\"Example 1: SumLoop\")
    sumResult := SumLoop()
    fmt.Println(\"The sum of numbers from 0 to 9 is:\", sumResult)

    fmt.Println(\"\\nExample 2: SumArray\")
    arr := []int{1, 2, 3, 4, 5}
    arraySumResult := SumArray(arr)
    fmt.Println(\"The sum of the array elements is:\", arraySumResult)

    fmt.Println(\"\\nExample 3: ListElements\")
    elements := []string{\"Go\", \"Python\", \"JavaScript\", \"Java\", \"C++\"}
    ListElements(elements)

    fmt.Println(\"\\nExample 4: CountRepeats\")
    CountRepeats()

    fmt.Println(\"\\nExample 5: SliceDemo\")
    SliceDemo()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end

function algoG.LoopExamples
    set output_file "LoopExamples.go"

    set template_content "package main

import (
    \"fmt\"
)

// === Example 1: Split slice into even and odd ===
func SplitEvenOdd() {
    a := []int{1, 2, 3, 45}
    b := []int{} // even numbers
    c := []int{} // odd numbers

    a = append(a, 3)
    fmt.Println(\"a[3]:\", a[3])
    a = append(a, 123)

    for i := 0; i < len(a); i++ {
        if a[i]%2 == 0 {
            b = append(b, a[i])
        } else {
            c = append(c, a[i])
        }
    }
    fmt.Println(\"Even numbers:\", b)
    fmt.Println(\"Odd numbers:\", c)
}

// === Example 2: Basic for loops ===
func BasicLoops() {
    fmt.Println(\"Basic for Loop:\")
    for i := 0; i < 5; i++ {
        fmt.Println(i)
    }

    fmt.Println(\"\\nfor as a while Loop:\")
    i := 0
    for i < 5 {
        fmt.Println(i)
        i++
    }

    fmt.Println(\"\\nInfinite for Loop:\")
    j := 0
    for {
        if j > 10 {
            break
        }
        fmt.Println(j)
        j++
    }
}

// === Example 3: for range examples ===
func RangeExamples() {
    fmt.Println(\"for range with slice:\")
    nums := []int{1, 2, 3, 4, 5}
    for index, value := range nums {
        fmt.Printf(\"Index: %d, Value: %d\\n\", index, value)
    }

    fmt.Println(\"\\nfor range with string:\")
    for index, runeValue := range \"hello\" {
        fmt.Printf(\"Index: %d, Rune: %c\\n\", index, runeValue)
    }
}

// === Example 4: Classic loop, break, continue ===
func ControlFlowExamples() {
    fmt.Println(\"Classic for:\")
    for i := 1; i < 10; i++ {
        fmt.Println(i)
    }

    fmt.Println(\"\\nBreaking from a loop:\")
    for {
        fmt.Println(\"We're in the for loop\")
        break
    }
    fmt.Println(\"Now we're out!\")

    fmt.Println(\"\\nContinue in a loop:\")
    for n := 0; n <= 10; n++ {
        if n%3 == 0 {
            continue
        }
        fmt.Println(n)
    }
}

// === MAIN ===
func main() {
    fmt.Println(\"=== Example 1: SplitEvenOdd ===\")
    SplitEvenOdd()

    fmt.Println(\"\\n=== Example 2: BasicLoops ===\")
    BasicLoops()

    fmt.Println(\"\\n=== Example 3: RangeExamples ===\")
    RangeExamples()

    fmt.Println(\"\\n=== Example 4: ControlFlowExamples ===\")
    ControlFlowExamples()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapExamples
    set output_file "MapExamples.go"

    set template_content "package main

import (
    \"fmt\"
)

// === Example 1: Basic map operations ===
func BasicMapExample() {
    fmt.Println(\"Go tutorial for Maps\")
    mp := make(map[string]string)
    mp[\"rohan\"] = \"patel\"
    mp[\"hello\"] = \"world\"
    mp[\"hotel\"] = \"trivigo\"
    mp[\"hi\"] = \"bye\"

    fmt.Println(\"Map:\", mp)
    fmt.Println(\"Last name of rohan:\", mp[\"rohan\"])

    delete(mp, \"hi\")
    fmt.Println(\"After deleting 'hi':\", mp)

    for k, v := range mp {
        fmt.Println(k, \":\", v)
    }
}

// === Example 2: Numeric map example ===
func IntMapExample() {
    m := make(map[string]int)

    m[\"k1\"] = 7
    m[\"k2\"] = 13

    fmt.Println(\"map:\", m)
    fmt.Println(\"map[k1]:\", m[\"k1\"])
    fmt.Println(\"len:\", len(m))

    delete(m, \"k2\")
    fmt.Println(\"After delete, len:\", len(m))

    keyValue, exists := m[\"k3\"]
    fmt.Println(\"keyValue:\", keyValue, \"exists:\", exists)

    n := map[string]int{\"foo\": 1, \"bar\": 2}
    fmt.Println(\"literal map:\", n)
}

// === Example 3: Currency map example ===
func CurrencyMapExample() {
    money := map[string]int{
        \"dollar\": 1000,
        \"euro\":   100,
        \"ap\":     5,
    }

    fmt.Println(money)
    fmt.Println(\"money[dollar]:\", money[\"dollar\"])

    money2 := map[string]int{
        \"dollar\": 1000,
        \"euro\":   100,
        \"ap\":     5,
    }

    fmt.Println(\"Initial money2:\", money2)
    money2[\"dollar\"] = 5000
    fmt.Println(\"After update:\", money2)

    delete(money2, \"ap\")
    fmt.Println(\"After delete:\", money2)

    fmt.Println(\"Access non-existent key 'gg':\", money2[\"gg\"])

    val, status := money2[\"dollar\"]
    fmt.Println(\"Existing key -> value:\", val, \"status:\", status)

    val2, status2 := money2[\"gg\"]
    fmt.Println(\"Missing key -> value:\", val2, \"status:\", status2)
}

// === Example 4: Map inspection ===
func MapInspection() {
    m1 := make(map[string]int)
    m1[\"foo\"] = 100
    m1[\"baa\"] = 200

    m := map[string]int{\"foo\": 300, \"baa\": 400}
    fmt.Println(m)
    fmt.Println(\"len(m):\", len(m))

    delete(m, \"foo\")
    fmt.Println(\"After delete:\", m)

    v, ok := m[\"baa\"]
    fmt.Println(\"Value for 'baa':\", v)
    fmt.Println(\"Key exists?:\", ok)
}

// === MAIN ===
func main() {
    fmt.Println(\"=== Example 1: BasicMapExample ===\")
    BasicMapExample()

    fmt.Println(\"\\n=== Example 2: IntMapExample ===\")
    IntMapExample()

    fmt.Println(\"\\n=== Example 3: CurrencyMapExample ===\")
    CurrencyMapExample()

    fmt.Println(\"\\n=== Example 4: MapInspection ===\")
    MapInspection()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapAndArrayExamples
    set output_file "MapAndArrayExamples.go"

    set template_content "package main

import (
    \"fmt\"
)

// === Example 1: Map reference behavior ===
// Показує, що map у Go — це reference type
func MapReferenceExample() {
    ages := map[string]int{
        \"Ann\":  20,
        \"Tema\": 22,
        \"Dad\":  48,
        \"Kira\": 7,
    }

    // Змінюємо значення Kira
    ages[\"Kira\"] = 9

    var ages2 map[string]int

    fmt.Println(\"--- ages content ---\")
    for key, value := range ages {
        fmt.Printf(\"%s - %d\\n\", key, value)
    }

    fmt.Println(\"\\n--- ages2 content (before assignment, nil) ---\")
    for key, value := range ages2 {
        fmt.Printf(\"%s - %d\\n\", key, value)
    }

    ages2 = ages
    delete(ages2, \"Kira\") // видаляє і з ages, бо це посилання

    fmt.Println(\"\\n--- ages after deleting from ages2 ---\")
    for key, value := range ages {
        fmt.Printf(\"%s - %d\\n\", key, value)
    }

    fmt.Println(\"\\n--- ages2 after delete ---\")
    for key, value := range ages2 {
        fmt.Printf(\"%s - %d\\n\", key, value)
    }
}

// === Example 2: Simple dictionary (string map) ===
func DictionaryExample() {
    sozluk := make(map[string]string)
    sozluk[\"chair\"] = \"sandalye\"
    sozluk[\"fury\"] = \"ofke\"
    sozluk[\"car\"] = \"araba\"

    fmt.Println(\"chair:\", sozluk[\"chair\"])
    fmt.Println(\"len:\", len(sozluk))
    fmt.Println(\"dictionary:\", sozluk)

    delete(sozluk, \"car\")
    fmt.Println(\"After delete:\", sozluk)

    deger, varmi := sozluk[\"xxx\"]
    fmt.Println(\"Access 'xxx' -> value:\", deger, \"exists:\", varmi)

    sozluk2 := map[string]string{\"glass\": \"bardak\", \"window\": \"cam\"}
    fmt.Println(\"another dictionary:\", sozluk2)
}

// === Example 3: Class arrays with range ===
func ClassArraysExample() {
    classOne := [2]string{\"Mandy\", \"Collins\"}
    classTwo := [2]string{\"Emeli\", \"Nesland\"}
    classThree := [2]string{\"Ariana\", \"Wood\"}
    classFour := [2]string{\"Norma\", \"Patina\"}

    fmt.Println(\"Class One:\", classOne)
    fmt.Println(\"Class Two:\", classTwo)
    fmt.Println(\"Class Three:\", classThree)
    fmt.Println(\"Class Four:\", classFour)

    fmt.Println(\"\\n--- Listing each class ---\")

    for index, item := range classOne {
        fmt.Println(\"classOne\", index, item)
    }

    for index, item := range classTwo {
        fmt.Println(\"classTwo\", index, item)
    }

    for index, item := range classThree {
        fmt.Println(\"classThree\", index, item)
    }

    for index, item := range classFour {
        fmt.Println(\"classFour\", index, item)
    }
}

// === MAIN ===
func main() {
    fmt.Println(\"=== Example 1: MapReferenceExample ===\")
    MapReferenceExample()

    fmt.Println(\"\\n=== Example 2: DictionaryExample ===\")
    DictionaryExample()

    fmt.Println(\"\\n=== Example 3: ClassArraysExample ===\")
    ClassArraysExample()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapFrequencyAndNestedExamples
    set output_file "MapFrequencyAndNestedExamples.go"

    set template_content "package main

import (
    \"fmt\"
)

// === Example 1: Max key with frequency > 1 ===
func MaxKeyWithFrequency(arr []int) {
    x_map := make(map[int]int)
    max := 0

    for _, el := range arr {
        x_map[el]++
    }
    fmt.Println(\"Initial frequency map:\", x_map)

    for key, val := range x_map {
        if val == 1 {
            delete(x_map, key)
        }
        if _, ok := x_map[key]; max < key && ok {
            max = key
        }
    }
    fmt.Println(\"Max key with frequency >1:\", max, \"Updated map:\", x_map)
}

// === Example 2: Frequency check for a specific number ===
func FrequencyCheck(arr []int, n int) {
    x_map := make(map[int]int)
    is := 0

    for _, el := range arr {
        x_map[el]++
    }

    for key, val := range x_map {
        if val == 1 && n == key {
            is = -1
        } else if val > 1 && key == n {
            is = x_map[n]
        }
    }
    fmt.Printf(\"Frequency check for %d: %d\\n\", n, is)
}

// === Example 3: Nested map pairs based on modulo condition ===
func NestedMapPairs(arr []int) {
    var slice = []map[int]int{}
    for _, el1 := range arr {
        for _, el2 := range arr {
            if el1%el2 == 3 {
                x_map := make(map[int]int)
                x_map[el1] = el2
                slice = append(slice, x_map)
            }
        }
    }
    fmt.Println(\"Nested map pairs:\", slice)
}

// === Example 4: Jewels in Stones ===
func NumJewelsInStones(jewels string, stones string) int {
    count := 0
    for _, el1 := range jewels {
        for _, el2 := range stones {
            if el1 == el2 {
                count++
            }
        }
    }
    return count
}

// === MAIN ===
func main() {
    fmt.Println(\"=== Example 1: MaxKeyWithFrequency ===\")
    MaxKeyWithFrequency([]int{1,1,1,2,2,3,4,4,5,10})

    fmt.Println(\"\\n=== Example 2: FrequencyCheck ===\")
    FrequencyCheck([]int{1,2,4,4,5,6,7,12,20}, 4)

    fmt.Println(\"\\n=== Example 3: NestedMapPairs ===\")
    NestedMapPairs([]int{2,3,5,4,7})

    fmt.Println(\"\\n=== Example 4: NumJewelsInStones ===\")
    fmt.Println(\"Jewels count:\", NumJewelsInStones(\"aA\", \"aAAbbbb\"))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapsAndSlicesExamples
    set output_file "MapsAndSlicesExamples.go"

    set template_content "package main

import (
    \"fmt\"
    \"time\"
)

func main() {
    // === Example 1: Basic Map Operations ===
    fmt.Println(\"--- Example 1: Basic Map ---\")
    fruits := map[string]int{\"apple\": 5, \"banana\": 7}
    fmt.Println(\"Initial map:\", fruits)

    fruits[\"orange\"] = 10
    fmt.Println(\"After adding orange:\", fruits)

    applePrice := fruits[\"apple\"]
    fmt.Println(\"Price of apple:\", applePrice)

    price, exists := fruits[\"kiwi\"]
    if exists {
        fmt.Println(\"Price of kiwi:\", price)
    } else {
        fmt.Println(\"Kiwi does not exist in the map\")
    }

    delete(fruits, \"banana\")
    fmt.Println(\"After deleting banana:\", fruits)

    fmt.Println(\"Length of map:\", len(fruits))
    fmt.Println()

    // === Example 2: Map with slices as values ===
    fmt.Println(\"--- Example 2: Map with Slice Values ---\")
    myMap3 := map[string][]string{
        \"Yaşar Kemal\":     {\"İnce Memed\", \"Yer Demir Gök Bakır\"},
        \"Sabahattin Ali\":  {\"Kuyucaklı Yusuf\", \"Kürk Mantolu Madonna\", \"Değirmen\"},
        \"Haruki Murakami\": {\"1Q84\", \"Dans Dans Dans\", \"Kumandanı Öldürmek\"},
    }

    for author, books := range myMap3 {
        fmt.Println(\"Author:\", author)
        fmt.Println(\"Books:\")
        for i, book := range books {
            fmt.Printf(\"\\t%d. %s\\n\", i+1, book)
        }
    }
    fmt.Println()

    // === Example 3: Slices and slicing ===
    fmt.Println(\"--- Example 3: Slices ---\")
    mySlcExample := []int{0, 1, 2, 3, 4, 5, 6, 7, 8}
    fmt.Println(\"Original slice:\", mySlcExample)

    fmt.Println(\"mySlc1 ([:4]):\", mySlcExample[:4])
    fmt.Println(\"mySlc2 ([4:7]):\", mySlcExample[4:7])
    fmt.Println(\"mySlc3 ([6:]):\", mySlcExample[6:])
    fmt.Println(\"mySlc4 (append([2:4], [6:8]...)):\", append(mySlcExample[2:4], mySlcExample[6:8]...))
    fmt.Println()

    // === Example 4: Calendar Example ===
    fmt.Println(\"--- Example 4: Simple Calendar ---\")
    now := time.Now()
    year, month, _ := now.Date()
    fmt.Println(\"Current month:\", month, \"Year:\", year)
    caL()
}

// Function to print a simple calendar
func caL() {
    weeks := [][]string{
        {\"Su\", \"Mo\", \"Tu\", \"We\", \"Th\", \"Fr\", \"Sa\"},
        {\"  \", \"  \", \"  \", \" 1\", \" 2\", \" 3\", \" 4\"},
        {\" 5\", \" 6\", \" 7\", \" 8\", \" 9\", \"10\", \"11\"},
        {\"12\", \"13\", \"14\", \"15\", \"16\", \"17\", \"18\"},
        {\"19\", \"20\", \"21\", \"22\", \"23\", \"24\", \"25\"},
        {\"26\", \"27\", \"28\", \"29\", \"30\", \"  \", \"  \"},
    }

    for _, week := range weeks {
        for _, day := range week {
            fmt.Print(day, \" \")
        }
        fmt.Println()
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.AliensSliceExample
    set output_file "AliensSliceExample.go"

    set template_content "package main

import (
    \"fmt\"
)

func main() {
    // === Example: Create a slice of aliens (map[string]interface{}) ===
    aliens := []map[string]interface{}{}

    // Generate 30 aliens and add to the slice
    for alienNumber := 0; alienNumber < 30; alienNumber++ {
        newAlien := map[string]interface{}{
            \"color\":  \"FFAD8D\",
            \"points\": 5,
            \"speed\":  \"slow\",
        }
        aliens = append(aliens, newAlien)
    }

    // Modify the first 3 aliens based on their color
    for i := 0; i < 3; i++ {
        alien := aliens[i]
        if alien[\"color\"] == \"green\" {
            alien[\"color\"] = \"yellow\"
            alien[\"speed\"] = \"medium\"
            alien[\"points\"] = 10
        } else if alien[\"color\"] == \"yellow\" {
            alien[\"color\"] = \"red\"
            alien[\"speed\"] = \"fast\"
            alien[\"points\"] = 15
        }
    }

    // Print the first 10 aliens
    for i := 0; i < 10; i++ {
        fmt.Println(aliens[i])
    }

    fmt.Println(\"...\")
    fmt.Printf(\"Total number of aliens: %d\\n\", len(aliens))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapExamples
    set output_file "MapExamples.go"

    set template_content "package main

import (
    \"fmt\"
    \"reflect\"
)

func main() {
    // === Example 1: Simple map iteration ===
    map1 := map[int]string{
        0: \"first\",
        1: \"second\",
        2: \"third\",
        3: \"fourth\",
    }

    // map is unordered
    for key, val := range map1 {
        fmt.Println(\"key\", key, \"value\", val)
    }

    // === Example 2: Summing slice elements ===
    nums := []int{2, 3, 4}
    sum := 0
    for _, num := range nums {
        sum += num
    }
    fmt.Println(\"sum:\", sum)

    // Finding index of a value
    for i, num := range nums {
        if num == 3 {
            fmt.Println(\"index:\", i)
        }
    }

    // === Example 3: Map iteration with string keys ===
    kvs := map[string]string{\"a\": \"apple\", \"b\": \"banana\"}
    for k, v := range kvs {
        fmt.Printf(\"%s -> %s\\n\", k, v)
    }
    for k := range kvs {
        fmt.Println(\"key:\", k)
    }

    // Iterating through string
    for i, c := range \"go\" {
        fmt.Println(i, c)
    }

    // === Example 4: Nil maps and initialization ===
    var intToStringMap map[int]string
    var stringToIntMap map[string]int
    fmt.Println(reflect.TypeOf(intToStringMap))
    fmt.Println(reflect.TypeOf(stringToIntMap))

    // Initialize map with make
    map1b := make(map[string]string)
    map1b[\"Key Example\"] = \"Value Example\"
    map1b[\"Red\"] = \"FF0000\"
    fmt.Println(map1b)

    // Initialize map with literal values
    map2 := map[int]bool{
        4:  false,
        6:  false,
        42: true,
    }
    fmt.Println(map1b[\"Red\"])
    fmt.Println(map2[42])

    for key, value := range map2 {
        fmt.Printf(\"%d: %t\\n\", key, value)
    }

    // === Example 5: Nested maps ===
    var (
        phones      map[string]string
        products    map[int]bool
        multiPhones map[string][]string
        basket      map[int]map[int]int
    )

    fmt.Printf(\"phones     : %#v\\n\", phones)
    fmt.Printf(\"products   : %#v\\n\", products)
    fmt.Printf(\"multiPhones: %#v\\n\", multiPhones)
    fmt.Printf(\"basket     : %#v\\n\", basket)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapAndConnectionExamples
    set output_file "MapAndConnectionExamples.go"

    set template_content "package main

import (
    \"fmt\"
    \"strings\"
)

// === Example 1: Build connection string from map ===
func buildConnectionString(params map[string]string) string {
    parts := []string{}
    for k, v := range params {
        parts = append(parts, fmt.Sprintf(\"%s=%s\", k, v))
    }
    return strings.Join(parts, \";\")
}

// === Example 2: Working with maps, nested maps, and slices ===
func main() {
    // Connection string example
    myParams := map[string]string{
        \"server\":   \"mpilgrim\",
        \"database\": \"master\",
        \"uid\":      \"sa\",
        \"pwd\":      \"secret\",
    }
    fmt.Println(\"Connection string:\", buildConnectionString(myParams))

    // Simple maps
    phones := map[string]string{
        \"bowen\": \"202-555-0179\",
        \"dulin\": \"03.37.77.63.06\",
        \"greco\": \"03489940240\",
    }

    products := map[int]bool{
        617841573: true,
        879401371: false,
        576872813: true,
    }

    // Map with slice values
    multiPhones := map[string][]string{
        \"bowen\": {\"202-555-0179\"},
        \"dulin\": {\"03.37.77.63.06\", \"03.37.70.50.05\", \"02.20.40.10.04\"},
        \"greco\": {\"03489940240\", \"03489900120\"},
    }

    // Nested map (customer basket)
    basket := map[int]map[int]int{
        100: {617841573: 4, 576872813: 2},
        101: {576872813: 5, 657473833: 20},
        102: {},
    }

    // Example 1: Print dulin's phone number
    who, phone := \"dulin\", \"N/A\"
    if v, ok := phones[who]; ok {
        phone = v
    }
    fmt.Printf(\"%s's phone number: %s\\n\", who, phone)

    // Example 2: Check product availability
    id, status := 879401371, \"available\"
    if !products[id] {
        status = \"not \" + status
    }
    fmt.Printf(\"Product ID #%d is %s\\n\", id, status)

    // Example 3: Greco's second phone number
    who, phone = \"greco\", \"N/A\"
    if phones := multiPhones[who]; len(phones) >= 2 {
        phone = phones[1]
    }
    fmt.Printf(\"%s's 2nd phone number: %s\\n\", who, phone)

    // Example 4: How many of a product a customer will buy
    cid, pid := 101, 576872813
    fmt.Printf(\"Customer #%d is going to buy %d from Product ID #%d.\\n\", cid, basket[cid][pid], pid)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapAndSortExamples
    set output_file "MapAndSortExamples.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func main() {
    // === Example 1: Basic map usage ===
    var m1 map[int32]bool
    var m2 map[string]string
    m3 := make(map[int]int)

    ages := map[string]int{
        \"Андрей\":    30,
        \"Анастасия\": 25,
    }

    age := ages[\"Андрей\"]          // 30
    ages[\"Наталья\"] = 31           // add new key
    fmt.Println(ages[\"Михаил\"])    // 0 (zero value)
    ages[\"Михаил\"] = ages[\"Михаил\"] + 1 // increment or initialize to 1

    fmt.Println(\"Maps:\", m1, m2, m3, \"Age of Андрей:\", age)

    // === Example 2: Map with different key/value types ===
    people := map[string]int{
        \"Tom\":   1,
        \"Bob\":   2,
        \"Sam\":   4,
        \"Alice\": 8,
    }
    fruits := map[int]string{1: \"mango\", 2: \"Orange\"}
    fmt.Println(\"Fruits map:\", fruits)

    students := map[string][]string{
        \"ss1\": {\"John\", \"Ade\"},
        \"ss2\": {\"John\", \"Ade\"},
    }
    ss1Students := students[\"ss1\"]
    fmt.Println(\"Students ss1:\", ss1Students)
    fmt.Println(\"All students:\", students)

    // === Example 3: Sorting slices ===
    messages := []string{\"c\", \"a\", \"b\"}
    sort.Strings(messages)
    fmt.Println(\"Sorted messages:\", messages)

    integers := []int{10, 4, 6}
    sort.Ints(integers)
    fmt.Println(\"Sorted integers:\", integers)

    isSorted := sort.IntsAreSorted(integers)
    fmt.Println(\"Is integers sorted?\", isSorted)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.MapExamples
    set output_file "MapExamples.go"

    set template_content "package main

import \"fmt\"

// --- Example: Iterating, adding, deleting maps ---
func main() {
    fmt.Println(\"Example 1: Iterating over a map\")
    people1 := map[string]int{
        \"Tom\":   1,
        \"Bob\":   2,
        \"Sam\":   4,
        \"Alice\": 8,
    }

    for key, value := range people1 {
        fmt.Println(key, value)
    }

    fmt.Println(\"\\nExample 2: Adding a new key-value pair\")
    people2 := map[string]int{
        \"Tom\": 1,
        \"Bob\": 2,
    }
    people2[\"Kate\"] = 128
    fmt.Println(people2)

    fmt.Println(\"\\nExample 3: Deleting a key-value pair\")
    people3 := map[string]int{
        \"Tom\": 1,
        \"Bob\": 2,
        \"Sam\": 8,
    }
    delete(people3, \"Bob\")
    fmt.Println(people3)

    fmt.Println(\"-----------------------------\")
    main1()

    fmt.Println(\"\\nExample 4: Map initialization, checking key existence\")
    var map1 = make(map[string]int)
    map1[\"key1\"] = 22
    map1[\"key2\"] = 24
    fmt.Println(\"map1\", map1)

    delete(map1, \"key2\")
    fmt.Println(\"map1 after delete\", map1)

    v, ok := map1[\"key1\"]
    fmt.Println(\"key1 exists?\", ok, \"value:\", v)
    v, ok = map1[\"key2\"]
    fmt.Println(\"key2 exists?\", ok, \"value:\", v)

    map2 := map[string]int{
        \"key1\": 22,
        \"key2\": 24,
    }
    fmt.Println(\"map2\", map2)

    var map3 map[int]int
    fmt.Println(\"map3 is nil?\", map3 == nil)

    fmt.Println(\"\\nExample 5: Arrays are not reference types\")
    var arr [3]int
    fmt.Println(\"arr\", arr)
    arr[1] = 2
    fmt.Println(\"arr after update\", arr)
}

// --- Helper function: Using interface{} in maps ---
func setSettings(settings map[string]interface{}) {
    if val, ok := settings[\"brightness\"]; ok {
        fmt.Printf(\"Setting brightness to %v\\n\", val)
    }
}

func main1() {
    settings := map[string]interface{}{
        \"brightness\": 75,
    }
    setSettings(settings)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end

function algoG.InsertInterval.LinearSearch
    set output_file "InsertIntervals.go"

    set template_content "package main

import \"fmt\"

// insert merges a new interval into a list of sorted, non-overlapping intervals.
func insert(intervals [][]int, newInterval []int) [][]int {
    n := len(intervals)
    i := 0
    var res [][]int

    // Step 1: Add all intervals ending before newInterval starts
    for i < n && intervals[i][1] < newInterval[0] {
        res = append(res, intervals[i])
        i++
    }

    // Step 2: Merge overlapping intervals
    for i < n && newInterval[1] >= intervals[i][0] {
        newInterval[0] = min(newInterval[0], intervals[i][0])
        newInterval[1] = max(newInterval[1], intervals[i][1])
        i++
    }
    res = append(res, newInterval)

    // Step 3: Add all remaining intervals
    for i < n {
        res = append(res, intervals[i])
        i++
    }

    return res
}

// Helper: return smaller value
func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

// Helper: return larger value
func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1, 3}, {6, 9}}
    newInterval := []int{2, 5}

    result := insert(intervals, newInterval)
    fmt.Println(\"Merged intervals:\", result)

    // Another example
    intervals2 := [][]int{{1, 2}, {3, 5}, {6, 7}, {8, 10}, {12, 16}}
    newInterval2 := []int{4, 8}
    result2 := insert(intervals2, newInterval2)
    fmt.Println(\"Merged intervals (example 2):\", result2)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.BinarySearch
    set output_file "InsertIntervals.go"

    set template_content "package main

import \"fmt\"

// insert inserts a new interval into a sorted list using binary search
// and merges overlapping intervals.
func insert(intervals [][]int, newInterval []int) [][]int {
    if len(intervals) == 0 {
        return [][]int{newInterval}
    }

    n := len(intervals)
    target := newInterval[0]
    left, right := 0, n-1

    // Binary search to find the correct insert position
    for left <= right {
        mid := (left + right) / 2
        if intervals[mid][0] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    // Insert newInterval into the correct position
    intervals = append(intervals[:left], append([][]int{newInterval}, intervals[left:]...)...)

    // Merge overlapping intervals
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

// Helper: return larger value
func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    // Example 1
    intervals := [][]int{{1, 3}, {6, 9}}
    newInterval := []int{2, 5}
    fmt.Println(\"Result:\", insert(intervals, newInterval))

    // Example 2
    intervals2 := [][]int{{1, 2}, {3, 5}, {6, 7}, {8, 10}, {12, 16}}
    newInterval2 := []int{4, 8}
    fmt.Println(\"Result:\", insert(intervals2, newInterval2))

    // Example 3 (insert into empty)
    fmt.Println(\"Result:\", insert([][]int{}, []int{5, 7}))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.InsertInterval.Greedy
    set output_file "InsertIntervals.go"

    set template_content "package main

import \"fmt\"

// insert merges a new interval into a list of sorted non-overlapping intervals.
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
    // Example 1
    intervals1 := [][]int{{1, 3}, {6, 9}}
    newInterval1 := []int{2, 5}
    fmt.Println(\"Result 1:\", insert(intervals1, newInterval1))

    // Example 2
    intervals2 := [][]int{{1, 2}, {3, 5}, {6, 7}, {8, 10}, {12, 16}}
    newInterval2 := []int{4, 8}
    fmt.Println(\"Result 2:\", insert(intervals2, newInterval2))

    // Example 3
    intervals3 := [][]int{{5, 7}}
    newInterval3 := []int{1, 2}
    fmt.Println(\"Result 3:\", insert(intervals3, newInterval3))

    // Example 4
    intervals4 := [][]int{{1, 3}}
    newInterval4 := []int{5, 7}
    fmt.Println(\"Result 4:\", insert(intervals4, newInterval4))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo "$output_file created successfully!"
    set_color normal

    # Print the code for review
    cat $output_file

    # Optional: Uncomment below line to run automatically
    # go run $output_file
end


function algoG.MergeIntervals.Sorting
    set output_file "MergeIntervals.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// merge merges all overlapping intervals in a 2D slice
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
    // Example test cases
    intervals1 := [][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}}
    fmt.Println(\"Merged intervals 1:\", merge(intervals1))

    intervals2 := [][]int{{1, 4}, {4, 5}}
    fmt.Println(\"Merged intervals 2:\", merge(intervals2))

    intervals3 := [][]int{{6, 8}, {1, 9}, {2, 4}, {4, 7}}
    fmt.Println(\"Merged intervals 3:\", merge(intervals3))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo "✅ $output_file created successfully!"
    set_color normal

    # Display code
    cat $output_file

    # Optional: Uncomment below line to auto-run and test
    # go run $output_file
end


function algoG.MergeIntervals.SweepLineAlgorithm
    set output_file "MergeIntervalsMap.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// merge merges overlapping intervals using a counting map
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
    fmt.Println(\"=== Merge Intervals (Map Method) ===\")

    intervals1 := [][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}}
    fmt.Println(\"Input:\", intervals1)
    fmt.Println(\"Merged:\", merge(intervals1))

    intervals2 := [][]int{{1, 4}, {4, 5}}
    fmt.Println(\"\\nInput:\", intervals2)
    fmt.Println(\"Merged:\", merge(intervals2))

    intervals3 := [][]int{{1, 5}, {2, 3}, {6, 8}, {7, 9}}
    fmt.Println(\"\\nInput:\", intervals3)
    fmt.Println(\"Merged:\", merge(intervals3))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo "✅ $output_file created successfully!"
    set_color normal

    # Show contents
    cat $output_file

    # Optional: Run and clean up (uncomment next 2 lines if you want auto-run)
    # go run $output_file
    # rm $output_file
end


function algoG.MergeIntervals.Greedy
    set output_file "MergeIntervalsArrayMap.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

// merge merges overlapping intervals using an array-based map approach
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
    fmt.Println(\"=== Merge Intervals (Array Map Method) ===\")

    intervals1 := [][]int{{1, 3}, {2, 6}, {8, 10}, {15, 18}}
    fmt.Println(\"Input:\", intervals1)
    fmt.Println(\"Merged:\", merge(intervals1))

    intervals2 := [][]int{{1, 4}, {4, 5}}
    fmt.Println(\"\\nInput:\", intervals2)
    fmt.Println(\"Merged:\", merge(intervals2))

    intervals3 := [][]int{{1, 5}, {2, 3}, {6, 8}, {7, 9}}
    fmt.Println(\"\\nInput:\", intervals3)
    fmt.Println(\"Merged:\", merge(intervals3))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo " $output_file created successfully!"
    set_color normal

    # Show the content
    cat $output_file

    # Optional: Auto-run and clean up
    # go run $output_file
    # rm $output_file
end


function algoG.Non-overlappingIntervals.Recursion
    set output_file "EraseOverlapIntervalsDFS.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// eraseOverlapIntervals removes the minimum number of overlapping intervals
// using a recursive DFS approach to find the maximum non-overlapping subset.
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
    fmt.Println(\"=== Erase Overlap Intervals (DFS) ===\")

    intervals1 := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Input:\", intervals1)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals1))

    intervals2 := [][]int{{1,2}, {1,2}, {1,2}}
    fmt.Println(\"\\nInput:\", intervals2)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals2))

    intervals3 := [][]int{{1,2}, {2,3}}
    fmt.Println(\"\\nInput:\", intervals3)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals3))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo "✅ $output_file created successfully!"
    set_color normal

    # Show the generated file
    cat $output_file

    # Optionally run it
    # go run $output_file
    # rm $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_Top-Down

    set output_file "EraseOverlapIntervalsDFS_Memo.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// eraseOverlapIntervals removes the minimum number of overlapping intervals
// using DFS with memoization on intervals sorted by end time.
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
    fmt.Println(\"=== Erase Overlap Intervals (DFS + Memo) ===\")

    intervals1 := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Input:\", intervals1)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals1))

    intervals2 := [][]int{{1,2}, {1,2}, {1,2}}
    fmt.Println(\"\\nInput:\", intervals2)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals2))

    intervals3 := [][]int{{1,2}, {2,3}}
    fmt.Println(\"\\nInput:\", intervals3)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals3))
}
"

    echo $template_content > $output_file
    set_color cyan
    echo "$output_file created successfully!"
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

// eraseOverlapIntervals calculates the minimum number of intervals to remove
// to eliminate all overlaps using dynamic programming.
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
    fmt.Println(\"=== Erase Overlap Intervals (DP) ===\")

    intervals1 := [][]int{{1,2}, {2,3}, {3,4}, {1,3}}
    fmt.Println(\"Input:\", intervals1)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals1))

    intervals2 := [][]int{{1,2}, {1,2}, {1,2}}
    fmt.Println(\"\\nInput:\", intervals2)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals2))

    intervals3 := [][]int{{1,2}, {2,3}}
    fmt.Println(\"\\nInput:\", intervals3)
    fmt.Println(\"Removed:\", eraseOverlapIntervals(intervals3))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal

    cat $output_file
end


function algoG.Non-overlappingIntervals.DynamicProgramming_BinarySearch
    set output_file "EraseOverlapIntervalsBS.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// eraseOverlapIntervals removes the minimum number of intervals
// to eliminate overlaps using DP + binary search.
func eraseOverlapIntervals(intervals [][]int) int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][1] < intervals[j][1]
    })

    n := len(intervals)
    if n == 0 {
        return 0
    }

    dp := make([]int, n)
    dp[0] = 1

    // Binary search: find rightmost interval that ends before 'target'
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
    testCases := [][][]int{
        {{1,2}, {2,3}, {3,4}, {1,3}},
        {{1,2}, {1,2}, {1,2}},
        {{1,2}, {2,3}},
    }

    for _, intervals := range testCases {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Intervals removed:\", eraseOverlapIntervals(intervals))
        fmt.Println(\"----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Greedy_SortByStart
    set output_file "EraseOverlapIntervalsGreedy.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// eraseOverlapIntervals finds the minimum number of overlapping intervals to remove.
// Greedy approach — sort by start time, then keep track of the smallest end seen.
func eraseOverlapIntervals(intervals [][]int) int {
    if len(intervals) == 0 {
        return 0
    }

    // Sort by start time
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    res := 0
    prevEnd := intervals[0][1]

    for _, interval := range intervals[1:] {
        start, end := interval[0], interval[1]
        // If no overlap, just move forward
        if start >= prevEnd {
            prevEnd = end
        } else {
            // Overlap -> remove one interval (the one with the larger end)
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
    testCases := [][][]int{
        {{1,2}, {2,3}, {3,4}, {1,3}},
        {{1,2}, {1,2}, {1,2}},
        {{1,2}, {2,3}},
        {{1,100}, {11,22}, {1,11}, {2,12}},
    }

    for _, intervals := range testCases {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Minimum intervals to remove:\", eraseOverlapIntervals(intervals))
        fmt.Println(\"--------------------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal
    cat $output_file
end


function algoG.Non-overlappingIntervals.Greedy_SortByEnd

    set output_file "EraseOverlapIntervals.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// eraseOverlapIntervals removes the minimum number of overlapping intervals.
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
    testCases := [][][]int{
        {{1,2},{2,3},{3,4},{1,3}},
        {{1,2},{1,2},{1,2}},
        {{1,2},{2,3}},
        {{1,100},{11,22},{1,11},{2,12}},
    }

    for _, intervals := range testCases {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"To remove:\", eraseOverlapIntervals(intervals))
        fmt.Println(\"-------------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal

    go run $output_file
end

function algoG.MeetingRooms.BruteForce
    set output_file "CanAttendMeetings.go"

    set template_content "package main

import (
    \"fmt\"
)

/**
 * Definition of Interval:
 */
type Interval struct {
    start int
    end   int
}

// canAttendMeetings checks if there are no overlapping intervals
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
    tests := [][]Interval{
        {{0,30},{5,10},{15,20}},
        {{7,10},{2,4}},
        {{1,2},{2,3},{3,4}},
        {{1,5},{6,10}},
    }

    for _, intervals := range tests {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Can attend all meetings?\", canAttendMeetings(intervals))
        fmt.Println(\"-------------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal

    go run $output_file
end


function algoG.MeetingRooms.Sorting
    set output_file "CanAttendMeetings.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

/**
 * Definition of Interval:
 */
type Interval struct {
    start int
    end   int
}

// canAttendMeetings determines if there are no overlapping intervals
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
    tests := [][]Interval{
        {{0, 30}, {5, 10}, {15, 20}},
        {{7, 10}, {2, 4}},
        {{1, 2}, {2, 3}, {3, 4}},
        {{1, 5}, {6, 10}},
    }

    for _, intervals := range tests {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Can attend all meetings?\", canAttendMeetings(intervals))
        fmt.Println(\"-----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal

    go run $output_file
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

/**
 * Definition of Interval:
 */
type Interval struct {
    start int
    end   int
}

// minMeetingRooms returns the minimum number of meeting rooms required
func minMeetingRooms(intervals []Interval) int {
    if len(intervals) == 0 {
        return 0
    }

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
    testCases := [][]Interval{
        {{0, 30}, {5, 10}, {15, 20}},
        {{7, 10}, {2, 4}},
        {{1, 5}, {8, 9}, {9, 10}},
        {{1, 10}, {2, 6}, {7, 8}},
    }

    for _, intervals := range testCases {
        fmt.Println(\"Input:\", intervals)
        fmt.Printf(\"Minimum meeting rooms needed: %d\\n\", minMeetingRooms(intervals))
        fmt.Println(\"-----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "✅ $output_file created successfully!"
    set_color normal

    go run $output_file
end

function algoG.MeetingRoomsII.SweepLineAlgorithm
    set output_file "MinMeetingRooms_Exact.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

/**
 * Definition of Interval:
 * type Interval struct {
 *    start int
 *    end   int
 * }
 */

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
    // Приклад для перевірки (можеш змінити)
    tests := [][]Interval{
        {{0, 30}, {5, 10}, {15, 20}},
        {{7, 10}, {2, 4}},
        {{1, 5}, {8, 9}, {9, 10}},
    }

    for _, intervals := range tests {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Min meeting rooms:\", minMeetingRooms(intervals))
        fmt.Println(\"-----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created (exact copy)"
    set_color normal
    cat $output_file
end


function algoG.MeetingRoomsII.TwoPointers
    set output_file "MinMeetingRoomsTwoPointers.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

/**
 * Definition of Interval:
 * type Interval struct {
 *    start int
 *    end   int
 * }
 */

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
    tests := [][]Interval{
        {{0, 30}, {5, 10}, {15, 20}},
        {{7, 10}, {2, 4}},
        {{1, 5}, {8, 9}, {9, 10}},
    }

    for _, intervals := range tests {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Min meeting rooms:\", minMeetingRooms(intervals))
        fmt.Println(\"-----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully (exact copy)"
    set_color normal
    cat $output_file
end


function algoG.MeetingRoomsII.Greedy
    set output_file "MinMeetingRoomsSweepLine.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

/**
 * Definition of Interval:
 * type Interval struct {
 *    start int
 *    end   int
 * }
 */

type Interval struct {
    start int
    end   int
}

func minMeetingRooms(intervals []Interval) int {
    var time [][]int
    for _, i := range intervals {
        time = append(time, []int{i.start, 1})
        time = append(time, []int{i.end, -1})
    }

    sort.Slice(time, func(i, j int) bool {
        if time[i][0] == time[j][0] {
            return time[i][1] < time[j][1]
        }
        return time[i][0] < time[j][0]
    })

    res, count := 0, 0
    for _, t := range time {
        count += t[1]
        if count > res {
            res = count
        }
    }
    return res
}

func main() {
    tests := [][]Interval{
        {{0, 30}, {5, 10}, {15, 20}},
        {{7, 10}, {2, 4}},
        {{1, 5}, {8, 9}, {9, 10}},
    }

    for _, intervals := range tests {
        fmt.Println(\"Input:\", intervals)
        fmt.Println(\"Min meeting rooms:\", minMeetingRooms(intervals))
        fmt.Println(\"-----------------------------\")
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully (exact copy of your sweep line code)"
    set_color normal
    cat $output_file
end


function algoG.MinimumIntervaltoIncludeEachQuery.BruteForce
    set output_file "MinIntervalBruteForce.go"

    set template_content "package main

import (
    \"fmt\"
)

// minInterval returns the size of the smallest interval that contains each query.
// If no interval contains the query, returns -1.
func minInterval(intervals [][]int, queries []int) []int {
    res := make([]int, len(queries))
    for i, q := range queries {
        cur := -1
        for _, interval := range intervals {
            l, r := interval[0], interval[1]
            if l <= q && q <= r {
                if cur == -1 || (r - l + 1) < cur {
                    cur = r - l + 1
                }
            }
        }
        res[i] = cur
    }
    return res
}

func main() {
    intervals := [][]int{{1,4},{2,4},{3,6}}
    queries := []int{2,3,4,5,7}

    fmt.Println(\"Intervals:\", intervals)
    fmt.Println(\"Queries:\", queries)
    fmt.Println(\"Result:\", minInterval(intervals, queries))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created successfully (brute-force minInterval)"
    set_color normal
    cat $output_file
end

function algoG.MinimumIntervaltoIncludeEachQuery.SweepLineAlgorithm
    set output_file "MinIntervalHeap.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"

    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

type Event struct {
    time int
    typ  int // 0: interval start, 1: query, 2: interval end
    val  int // interval size or query index
    idx  int // interval index
}

func minInterval(intervals [][]int, queries []int) []int {
    events := []Event{}

    // Create events for intervals
    for idx, interval := range intervals {
        start, end := interval[0], interval[1]
        size := end - start + 1
        events = append(events, Event{start, 0, size, idx})
        events = append(events, Event{end, 2, size, idx})
    }

    // Create events for queries
    for i, q := range queries {
        events = append(events, Event{q, 1, i, -1})
    }

    // Sort events by time and type
    sort.Slice(events, func(i, j int) bool {
        if events[i].time == events[j].time {
            return events[i].typ < events[j].typ
        }
        return events[i].time < events[j].time
    })

    // Priority queue to store intervals with the smallest size on top
    sizes := priorityqueue.NewWith(func(a, b interface{}) int {
        return utils.IntComparator(a.([]int)[0], b.([]int)[0])
    })

    ans := make([]int, len(queries))
    for i := range ans {
        ans[i] = -1
    }

    inactive := make([]bool, len(intervals))

    for _, event := range events {
        switch event.typ {
        case 0: // Interval start
            sizes.Enqueue([]int{event.val, event.idx})
        case 2: // Interval end
            inactive[event.idx] = true
        case 1: // Query
            queryIdx := event.val
            for !sizes.Empty() {
                top, _ := sizes.Peek()
                if inactive[top.([]int)[1]] {
                    sizes.Dequeue()
                } else {
                    break
                }
            }
            if !sizes.Empty() {
                top, _ := sizes.Peek()
                ans[queryIdx] = top.([]int)[0]
            }
        }
    }
    return ans
}

func main() {
    intervals := [][]int{{1,4},{2,4},{3,6}}
    queries := []int{2,3,4,5,7}
    fmt.Println(\"Intervals:\", intervals)
    fmt.Println(\"Queries:\", queries)
    fmt.Println(\"Result:\", minInterval(intervals, queries))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.MinimumIntervaltoIncludeEachQuery.MinHeap
    set output_file "MinIntervalPQ.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"

    \"github.com/emirpasic/gods/queues/priorityqueue\"
)

func minInterval(intervals [][]int, queries []int) []int {
    sort.Slice(intervals, func(i, j int) bool {
        return intervals[i][0] < intervals[j][0]
    })

    queriesWithIdx := make([][2]int, len(queries))
    for i, q := range queries {
        queriesWithIdx[i] = [2]int{q, i}
    }
    sort.Slice(queriesWithIdx, func(i, j int) bool {
        return queriesWithIdx[i][0] < queriesWithIdx[j][0]
    })

    comparator := func(a, b interface{}) int {
        pair1 := a.([2]int)
        pair2 := b.([2]int)
        if pair1[0] != pair2[0] {
            if pair1[0] < pair2[0] {
                return -1
            }
            return 1
        }
        return 0
    }

    pq := priorityqueue.NewWith(comparator)
    res := make([]int, len(queries))
    i := 0

    for _, qPair := range queriesWithIdx {
        q, originalIdx := qPair[0], qPair[1]

        for i < len(intervals) && intervals[i][0] <= q {
            size := intervals[i][1] - intervals[i][0] + 1
            pq.Enqueue([2]int{size, intervals[i][1]})
            i++
        }

        for !pq.Empty() {
            if top, _ := pq.Peek(); top.([2]int)[1] < q {
                pq.Dequeue()
            } else {
                break
            }
        }

        if !pq.Empty() {
            top, _ := pq.Peek()
            res[originalIdx] = top.([2]int)[0]
        } else {
            res[originalIdx] = -1
        }
    }

    return res
}

func main() {
    intervals := [][]int{{1,4},{2,4},{3,6}}
    queries := []int{2,3,4,5,7}
    fmt.Println(\"Intervals:\", intervals)
    fmt.Println(\"Queries:\", queries)
    fmt.Println(\"Result:\", minInterval(intervals, queries))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MinimumIntervaltoIncludeEachQuery.MinSegmentTree_LazyPropagation
    set output_file "MinIntervalSegmentTree.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
    \"sort\"
)

type SegmentTree struct {
    n    int
    tree []int
    lazy []int
}

func NewSegmentTree(n int) *SegmentTree {
    tree := make([]int, 4*n)
    lazy := make([]int, 4*n)
    for i := range tree {
        tree[i] = math.MaxInt32
        lazy[i] = math.MaxInt32
    }
    return &SegmentTree{n: n, tree: tree, lazy: lazy}
}

func (st *SegmentTree) propagate(treeIdx, lo, hi int) {
    if st.lazy[treeIdx] != math.MaxInt32 {
        st.tree[treeIdx] = min(st.tree[treeIdx], st.lazy[treeIdx])
        if lo != hi {
            st.lazy[2*treeIdx+1] = min(st.lazy[2*treeIdx+1], st.lazy[treeIdx])
            st.lazy[2*treeIdx+2] = min(st.lazy[2*treeIdx+2], st.lazy[treeIdx])
        }
        st.lazy[treeIdx] = math.MaxInt32
    }
}

func (st *SegmentTree) updateRange(treeIdx, lo, hi, left, right, val int) {
    st.propagate(treeIdx, lo, hi)
    if lo > right || hi < left {
        return
    }
    if lo >= left && hi <= right {
        st.lazy[treeIdx] = min(st.lazy[treeIdx], val)
        st.propagate(treeIdx, lo, hi)
        return
    }
    mid := (lo + hi) / 2
    st.updateRange(2*treeIdx+1, lo, mid, left, right, val)
    st.updateRange(2*treeIdx+2, mid+1, hi, left, right, val)
    st.tree[treeIdx] = min(st.tree[2*treeIdx+1], st.tree[2*treeIdx+2])
}

func (st *SegmentTree) queryPoint(treeIdx, lo, hi, idx int) int {
    st.propagate(treeIdx, lo, hi)
    if lo == hi {
        return st.tree[treeIdx]
    }
    mid := (lo + hi) / 2
    if idx <= mid {
        return st.queryPoint(2*treeIdx+1, lo, mid, idx)
    }
    return st.queryPoint(2*treeIdx+2, mid+1, hi, idx)
}

func (st *SegmentTree) Update(left, right, val int) {
    st.updateRange(0, 0, st.n-1, left, right, val)
}

func (st *SegmentTree) Query(idx int) int {
    return st.queryPoint(0, 0, st.n-1, idx)
}

func minInterval(intervals [][]int, queries []int) []int {
    points := make(map[int]bool)
    for _, interval := range intervals {
        points[interval[0]] = true
        points[interval[1]] = true
    }
    for _, q := range queries {
        points[q] = true
    }

    pointsList := make([]int, 0, len(points))
    for point := range points {
        pointsList = append(pointsList, point)
    }
    sort.Ints(pointsList)

    compress := make(map[int]int)
    for i, point := range pointsList {
        compress[point] = i
    }

    segTree := NewSegmentTree(len(pointsList))

    for _, interval := range intervals {
        start := compress[interval[0]]
        end := compress[interval[1]]
        length := interval[1] - interval[0] + 1
        segTree.Update(start, end, length)
    }

    ans := make([]int, len(queries))
    for i, q := range queries {
        idx := compress[q]
        res := segTree.Query(idx)
        if res == math.MaxInt32 {
            ans[i] = -1
        } else {
            ans[i] = res
        }
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    intervals := [][]int{{1,4},{2,4},{3,6}}
    queries := []int{2,3,4,5,7}
    fmt.Println(\"Intervals:\", intervals)
    fmt.Println(\"Queries:\", queries)
    fmt.Println(\"Result:\", minInterval(intervals, queries))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SumofTwoIntegers.BruteForce
    set output_file "getSum.go"

    set template_content "package main

import \"fmt\"

// getSum returns the sum of two integers
func getSum(a int, b int) int {
    return a + b
}

func main() {
    a, b := 5, 7
    fmt.Printf(\"getSum(%d, %d) = %d\\n\", a, b, getSum(a, b))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SumofTwoIntegers.BitManipulation
    set output_file "getSum_bitwise.go"

    set template_content "package main

import \"fmt\"

// getSum calculates the sum of two integers without using '+' or '-'
func getSum(a int, b int) int {
    carry := 0
    res := 0
    mask := 0xFFFFFFFF

    for i := 0; i < 32; i++ {
        aBit := (a >> i) & 1
        bBit := (b >> i) & 1
        curBit := aBit ^ bBit ^ carry
        if (aBit + bBit + carry) >= 2 {
            carry = 1
        } else {
            carry = 0
        }
        if curBit == 1 {
            res |= (1 << i)
        }
    }

    if res > 0x7FFFFFFF {
        res = ^(res ^ mask)
    }

    return res
}

func main() {
    a, b := 15, 27
    fmt.Printf(\"getSum(%d, %d) = %d\\n\", a, b, getSum(a, b))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.SumofTwoIntegers.BitManipulation_Optimal
    set output_file "getSum_bitwise2.go"

    set template_content "package main

import \"fmt\"

// getSum calculates the sum of two integers without using '+' or '-'
func getSum(a int, b int) int {
    mask := 0xFFFFFFFF
    maxInt := 0x7FFFFFFF

    for b != 0 {
        carry := (a & b) << 1
        a = (a ^ b) & mask
        b = carry & mask
    }

    if a <= maxInt {
        return a
    }
    return ^(a ^ mask)
}

func main() {
    a, b := 15, 27
    fmt.Printf(\"getSum(%d, %d) = %d\\n\", a, b, getSum(a, b))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ReverseInteger.BruteForce
    set output_file "reverse_int.go"

    set template_content "package main

import \"fmt\"

// reverse reverses the digits of a 32-bit signed integer
func reverse(x int) int {
    org := x
    x = abs(x)
    res := 0

    for x > 0 {
        res = res*10 + x%10
        x /= 10
    }

    if org < 0 {
        res = -res
    }

    if res < -(1<<31) || res > (1<<31)-1 {
        return 0
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    nums := []int{123, -456, 1534236469}
    for _, n := range nums {
        fmt.Printf(\"reverse(%d) = %d\\n\", n, reverse(n))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ReverseInteger.Recursion
    set output_file "reverse_int_recursive.go"

    set template_content "package main

import \"fmt\"

// reverse recursively reverses the digits of a 32-bit signed integer
func reverse(x int) int {
    var rec func(int, int) int
    rec = func(n, rev int) int {
        if n == 0 {
            return rev
        }
        rev = rev*10 + n%10
        return rec(n/10, rev)
    }

    sign := 1
    if x < 0 {
        sign = -1
        x = -x
    }

    reversedNum := rec(x, 0) * sign
    if reversedNum < -(1<<31) || reversedNum > (1<<31)-1 {
        return 0
    }
    return reversedNum
}

func main() {
    nums := []int{123, -456, 1534236469}
    for _, n := range nums {
        fmt.Printf(\"reverse(%d) = %d\\n\", n, reverse(n))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ReverseInteger.Iteration
    set output_file "reverse_int_iterative.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

// reverse iteratively reverses a 32-bit signed integer with overflow check
func reverse(x int) int {
    MIN := -2147483648 // -2^31
    MAX := 2147483647  // 2^31 - 1

    res := 0
    for x != 0 {
        digit := int(math.Mod(float64(x), 10))
        x = int(float64(x) / 10)

        if res > MAX/10 || (res == MAX/10 && digit > MAX%10) {
            return 0
        }
        if res < MIN/10 || (res == MIN/10 && digit < MIN%10) {
            return 0
        }
        res = (res * 10) + digit
    }

    return res
}

func main() {
    nums := []int{123, -456, 1534236469, -2147483412}
    for _, n := range nums {
        fmt.Printf(\"reverse(%d) = %d\\n\", n, reverse(n))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.BruteForce
    set output_file "max_subarray_brute.go"

    set template_content "package main

import \"fmt\"

// maxSubArray finds the maximum subarray sum using the brute-force approach (O(n^2))
func maxSubArray(nums []int) int {
    n := len(nums)
    res := nums[0]

    for i := 0; i < n; i++ {
        cur := 0
        for j := i; j < n; j++ {
            cur += nums[j]
            if cur > res {
                res = cur
            }
        }
    }
    return res
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"maxSubArray:\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.Recursion
    set output_file "max_subarray_dfs.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    var dfs func(i int, flag bool) int
    dfs = func(i int, flag bool) int {
        if i == len(nums) {
            if flag {
                return 0
            }
            return -1000000
        }
        if flag {
            return max(0, nums[i]+dfs(i+1, true))
        }
        return max(dfs(i+1, false), nums[i]+dfs(i+1, true))
    }

    return dfs(0, false)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"maxSubArray (DFS):\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.DynamicProgramming_Top-Down
    set output_file "max_subarray_memo.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    memo := make([][2]*int, len(nums)+1)
    for i := range memo {
        memo[i] = [2]*int{nil, nil}
    }

    var dfs func(int, int) int
    dfs = func(i, flag int) int {
        if i == len(nums) {
            if flag == 1 {
                return 0
            }
            return -1000000
        }
        if memo[i][flag] != nil {
            return *memo[i][flag]
        }
        if flag == 1 {
            result := max(0, nums[i]+dfs(i+1, 1))
            memo[i][flag] = &result
        } else {
            result := max(dfs(i+1, 0), nums[i]+dfs(i+1, 1))
            memo[i][flag] = &result
        }
        return *memo[i][flag]
    }

    return dfs(0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"maxSubArray (Memoized DFS):\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.DynamicProgramming_Top-Down
    set output_file "max_subarray_memo.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    memo := make([][2]*int, len(nums)+1)
    for i := range memo {
        memo[i] = [2]*int{nil, nil}
    }

    var dfs func(int, int) int
    dfs = func(i, flag int) int {
        if i == len(nums) {
            if flag == 1 {
                return 0
            }
            return -1000000
        }
        if memo[i][flag] != nil {
            return *memo[i][flag]
        }
        if flag == 1 {
            result := max(0, nums[i]+dfs(i+1, 1))
            memo[i][flag] = &result
        } else {
            result := max(dfs(i+1, 0), nums[i]+dfs(i+1, 1))
            memo[i][flag] = &result
        }
        return *memo[i][flag]
    }

    return dfs(0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"maxSubArray (Memoized DFS):\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.DynamicProgramming_Bottom-Up
    set output_file "max_subarray_dp.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    n := len(nums)
    dp := make([][]int, n)
    for i := range dp {
        dp[i] = make([]int, 2)
    }

    dp[n-1][1] = nums[n-1]
    dp[n-1][0] = nums[n-1]

    for i := n-2; i >= 0; i-- {
        dp[i][1] = max(nums[i], nums[i] + dp[i+1][1])
        dp[i][0] = max(dp[i+1][0], dp[i][1])
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"maxSubArray (DP version):\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.MaximumSubarray.DynamicProgramming_SpaceOptimized
    set output_file "max_subarray_dp_array.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    dp := make([]int, len(nums))
    copy(dp, nums)

    for i := 1; i < len(nums); i++ {
        dp[i] = max(nums[i], nums[i] + dp[i-1])
    }

    maxSum := dp[0]
    for _, v := range dp {
        if v > maxSum {
            maxSum = v
        }
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"Max Subarray Sum:\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.KadanesAlgorithm
    set output_file "max_subarray_kadane.go"

    set template_content "package main

import \"fmt\"

func maxSubArray(nums []int) int {
    maxSub, curSum := nums[0], 0
    for _, num := range nums {
        if curSum < 0 {
            curSum = 0
        }
        curSum += num
        maxSub = max(maxSub, curSum)
    }
    return maxSub
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"Max Subarray Sum:\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MaximumSubarray.DivideConquer
    set output_file "max_subarray_divide_conquer.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func maxSubArray(nums []int) int {
    var dfs func(l, r int) int
    dfs = func(l, r int) int {
        if l > r {
            return math.MinInt64
        }

        m := (l + r) >> 1
        leftSum, rightSum, curSum := 0, 0, 0

        for i := m - 1; i >= l; i-- {
            curSum += nums[i]
            if curSum > leftSum {
                leftSum = curSum
            }
        }

        curSum = 0
        for i := m + 1; i <= r; i++ {
            curSum += nums[i]
            if curSum > rightSum {
                rightSum = curSum
            }
        }

        maxLeft := dfs(l, m-1)
        maxRight := dfs(m+1, r)
        crossSum := leftSum + nums[m] + rightSum

        return max(max(maxLeft, maxRight), crossSum)
    }

    return dfs(0, len(nums)-1)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    nums := []int{-2, 1, -3, 4, -1, 2, 1, -5, 4}
    fmt.Println(\"Max Subarray (Divide & Conquer):\", maxSubArray(nums))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGame.Recursion
    set output_file "can_jump_dfs.go"

    set template_content "package main

import (
    \"fmt\"
)

func canJump(nums []int) bool {
    var dfs func(i int) bool
    dfs = func(i int) bool {
        if i == len(nums)-1 {
            return true
        }

        end := min(len(nums)-1, i+nums[i])
        for j := i + 1; j <= end; j++ {
            if dfs(j) {
                return true
            }
        }
        return false
    }

    return dfs(0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums := []int{2, 3, 1, 1, 4}
    fmt.Println(\"Can Jump (DFS):\", canJump(nums))

    nums2 := []int{3, 2, 1, 0, 4}
    fmt.Println(\"Can Jump (DFS):\", canJump(nums2))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGame.DynamicProgramming_Top-Down
    set output_file "can_jump_memo.go"

    set template_content "package main

import (
    \"fmt\"
)

func canJump(nums []int) bool {
    memo := make(map[int]bool)

    var dfs func(i int) bool
    dfs = func(i int) bool {
        if result, exists := memo[i]; exists {
            return result
        }

        if i == len(nums)-1 {
            return true
        }
        if nums[i] == 0 {
            memo[i] = false
            return false
        }

        end := min(len(nums), i+nums[i]+1)
        for j := i + 1; j < end; j++ {
            if dfs(j) {
                memo[i] = true
                return true
            }
        }

        memo[i] = false
        return false
    }

    return dfs(0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums1 := []int{2, 3, 1, 1, 4}
    fmt.Println(\"Can Jump (Memo):\", canJump(nums1)) // true

    nums2 := []int{3, 2, 1, 0, 4}
    fmt.Println(\"Can Jump (Memo):\", canJump(nums2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGame.DynamicProgramming_Bottom-Up

    set output_file "can_jump_dp.go"

    set template_content "package main

import (
    \"fmt\"
)

func canJump(nums []int) bool {
    n := len(nums)
    dp := make([]bool, n)
    dp[n-1] = true

    for i := n - 2; i >= 0; i-- {
        end := min(n, i + nums[i] + 1)
        for j := i + 1; j < end; j++ {
            if dp[j] {
                dp[i] = true
                break
            }
        }
    }
    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums1 := []int{2, 3, 1, 1, 4}
    fmt.Println(\"Can Jump (DP):\", canJump(nums1)) // true

    nums2 := []int{3, 2, 1, 0, 4}
    fmt.Println(\"Can Jump (DP):\", canJump(nums2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGame.Greedy
    set output_file "can_jump_greedy.go"

    set template_content "package main

import (
    \"fmt\"
)

func canJump(nums []int) bool {
    goal := len(nums) - 1
    for i := len(nums) - 2; i >= 0; i-- {
        if i + nums[i] >= goal {
            goal = i
        }
    }
    return goal == 0
}

func main() {
    nums1 := []int{2, 3, 1, 1, 4}
    fmt.Println(\"Can Jump (Greedy):\", canJump(nums1)) // true

    nums2 := []int{3, 2, 1, 0, 4}
    fmt.Println(\"Can Jump (Greedy):\", canJump(nums2)) // false

    nums3 := []int{0}
    fmt.Println(\"Can Jump (Greedy):\", canJump(nums3)) // true
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGameII.Recursion
    set output_file "jump_dfs.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func jump(nums []int) int {
    var dfs func(int) int
    dfs = func(i int) int {
        if i == len(nums)-1 {
            return 0
        }
        if nums[i] == 0 {
            return math.MaxInt32
        }

        end := min(len(nums)-1, i+nums[i])
        res := math.MaxInt32
        for j := i + 1; j <= end; j++ {
            res = min(res, 1+dfs(j))
        }
        return res
    }

    return dfs(0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,3,1,1,4}
    fmt.Println(\"Min jumps (DFS):\", jump(nums)) // 2

    nums2 := []int{2,3,0,1,4}
    fmt.Println(\"Min jumps (DFS):\", jump(nums2)) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGameII.DynamicProgramming_Top-Down
    set output_file "jump_dfs_memo.go"

    set template_content "package main

import (
    \"fmt\"
)

func jump(nums []int) int {
    memo := make(map[int]int)

    var dfs func(int) int
    dfs = func(i int) int {
        if val, ok := memo[i]; ok {
            return val
        }
        if i == len(nums)-1 {
            return 0
        }
        if nums[i] == 0 {
            return 1000000
        }
        res := 1000000
        end := min(len(nums), i+nums[i]+1)
        for j := i + 1; j < end; j++ {
            res = min(res, 1+dfs(j))
        }
        memo[i] = res
        return res
    }
    return dfs(0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,3,1,1,4}
    fmt.Println(\"Min jumps (DFS + Memo):\", jump(nums)) // 2

    nums2 := []int{2,3,0,1,4}
    fmt.Println(\"Min jumps (DFS + Memo):\", jump(nums2)) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGameII.DynamicProgramming_Bottom-Up
    set output_file "jump_dp.go"

    set template_content "package main

import (
    \"fmt\"
)

func jump(nums []int) int {
    n := len(nums)
    dp := make([]int, n)
    for i := range dp {
        dp[i] = 1000000
    }
    dp[n-1] = 0

    for i := n - 2; i >= 0; i-- {
        end := min(n, i+nums[i]+1)
        for j := i + 1; j < end; j++ {
            dp[i] = min(dp[i], 1+dp[j])
        }
    }
    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    nums := []int{2,3,1,1,4}
    fmt.Println(\"Min jumps (DP bottom-up):\", jump(nums)) // 2

    nums2 := []int{2,3,0,1,4}
    fmt.Println(\"Min jumps (DP bottom-up):\", jump(nums2)) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.JumpGameII.BreadthFirst_SearchGreedy
    set output_file "jump_greedy.go"

    set template_content "package main

import (
    \"fmt\"
)

func jump(nums []int) int {
    res := 0
    l, r := 0, 0

    for r < len(nums)-1 {
        farthest := 0
        for i := l; i <= r; i++ {
            farthest = max(farthest, i+nums[i])
        }
        l = r + 1
        r = farthest
        res++
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
    nums := []int{2,3,1,1,4}
    fmt.Println(\"Min jumps (Greedy):\", jump(nums)) // 2

    nums2 := []int{2,3,0,1,4}
    fmt.Println(\"Min jumps (Greedy):\", jump(nums2)) // 2
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.GasStation.BruteForce
    set output_file "gas_station_bf.go"

    set template_content "package main

import (
    \"fmt\"
)

func canCompleteCircuit(gas []int, cost []int) int {
    n := len(gas)

    for i := 0; i < n; i++ {
        tank := gas[i] - cost[i]
        if tank < 0 {
            continue
        }

        j := (i + 1) % n
        for j != i {
            tank += gas[j]
            tank -= cost[j]
            if tank < 0 {
                break
            }
            j = (j + 1) % n
        }

        if j == i {
            return i
        }
    }

    return -1
}

func main() {
    gas := []int{1,2,3,4,5}
    cost := []int{3,4,5,1,2}
    fmt.Println(\"Starting index (BF):\", canCompleteCircuit(gas, cost)) // 3

    gas2 := []int{2,3,4}
    cost2 := []int{3,4,3}
    fmt.Println(\"Starting index (BF):\", canCompleteCircuit(gas2, cost2)) // -1
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.GasStation.TwoPointers
    set output_file "gas_station_greedy.go"

    set template_content "package main

import (
    \"fmt\"
)

func canCompleteCircuit(gas []int, cost []int) int {
    n := len(gas)
    start, end := n-1, 0
    tank := gas[start] - cost[start]

    for start > end {
        if tank < 0 {
            start--
            tank += gas[start] - cost[start]
        } else {
            tank += gas[end] - cost[end]
            end++
        }
    }

    if tank >= 0 {
        return start
    }
    return -1
}

func main() {
    gas := []int{1,2,3,4,5}
    cost := []int{3,4,5,1,2}
    fmt.Println(\"Starting index (Greedy):\", canCompleteCircuit(gas, cost)) // 3

    gas2 := []int{2,3,4}
    cost2 := []int{3,4,3}
    fmt.Println(\"Starting index (Greedy):\", canCompleteCircuit(gas2, cost2)) // -1
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.GasStation.Greedy
    set output_file "gas_station_sum.go"

    set template_content "package main

import (
    \"fmt\"
)

func canCompleteCircuit(gas []int, cost []int) int {
    if sum(gas) < sum(cost) {
        return -1
    }

    total := 0
    res := 0

    for i := range gas {
        total += gas[i] - cost[i]
        if total < 0 {
            total = 0
            res = i + 1
        }
    }

    return res
}

func sum(nums []int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    return total
}

func main() {
    gas := []int{1,2,3,4,5}
    cost := []int{3,4,5,1,2}
    fmt.Println(\"Starting index (Sum method):\", canCompleteCircuit(gas, cost)) // 3

    gas2 := []int{2,3,4}
    cost2 := []int{3,4,3}
    fmt.Println(\"Starting index (Sum method):\", canCompleteCircuit(gas2, cost2)) // -1
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HandofStraights.Sorting
    set output_file "is_n_straight_hand.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func isNStraightHand(hand []int, groupSize int) bool {
    if len(hand)%groupSize != 0 {
        return false
    }

    count := map[int]int{}
    for _, num := range hand {
        count[num]++
    }

    sort.Ints(hand)
    for _, num := range hand {
        if count[num] > 0 {
            for i := num; i < num+groupSize; i++ {
                if count[i] == 0 {
                    return false
                }
                count[i]--
            }
        }
    }
    return true
}

func main() {
    hand := []int{1,2,3,6,2,3,4,7,8}
    groupSize := 3
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand, groupSize)) // true

    hand2 := []int{1,2,3,4,5}
    groupSize2 := 4
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand2, groupSize2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HandofStraights.Heap
    set output_file "is_n_straight_hand_pq.go"

    set template_content "package main

import (
    \"fmt\"
    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

func isNStraightHand(hand []int, groupSize int) bool {
    if len(hand)%groupSize != 0 {
        return false
    }

    count := map[int]int{}
    for _, n := range hand {
        count[n]++
    }

    minH := priorityqueue.NewWith(utils.IntComparator)
    for k := range count {
        minH.Enqueue(k)
    }

    for !minH.Empty() {
        first, _ := minH.Peek()
        firstKey := first.(int)
        for i := firstKey; i < firstKey+groupSize; i++ {
            if count[i] == 0 {
                return false
            }
            count[i]--
            if count[i] == 0 {
                if val, _ := minH.Peek(); val.(int) != i {
                    return false
                }
                minH.Dequeue()
            }
        }
    }
    return true
}

func main() {
    hand := []int{1,2,3,6,2,3,4,7,8}
    groupSize := 3
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand, groupSize)) // true

    hand2 := []int{1,2,3,4,5}
    groupSize2 := 4
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand2, groupSize2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HandofStraights.OrderedMap
    set output_file "is_n_straight_hand_queue.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

func isNStraightHand(hand []int, groupSize int) bool {
    if len(hand)%groupSize != 0 {
        return false
    }

    count := make(map[int]int)
    for _, num := range hand {
        count[num]++
    }

    keys := make([]int, 0, len(count))
    for k := range count {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    q := []int{}
    lastNum, openGroups := -1, 0

    for _, num := range keys {
        if (openGroups > 0 && num > lastNum+1) || openGroups > count[num] {
            return false
        }

        q = append(q, count[num]-openGroups)
        lastNum = num
        openGroups = count[num]

        if len(q) == groupSize {
            openGroups -= q[0]
            q = q[1:]
        }
    }
    return openGroups == 0
}

func main() {
    hand := []int{1,2,3,6,2,3,4,7,8}
    groupSize := 3
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand, groupSize)) // true

    hand2 := []int{1,2,3,4,5}
    groupSize2 := 4
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand2, groupSize2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HandofStraights.HashMap
    set output_file "is_n_straight_hand_backtrack.go"

    set template_content "package main

import (
    \"fmt\"
)

func isNStraightHand(hand []int, groupSize int) bool {
    if len(hand)%groupSize != 0 {
        return false
    }

    count := map[int]int{}
    for _, num := range hand {
        count[num]++
    }

    for _, num := range hand {
        start := num
        for count[start-1] > 0 {
            start--
        }

        for start <= num {
            for count[start] > 0 {
                for i := start; i < start+groupSize; i++ {
                    if count[i] == 0 {
                        return false
                    }
                    count[i]--
                }
            }
            start++
        }
    }
    return true
}

func main() {
    hand := []int{1,2,3,6,2,3,4,7,8}
    groupSize := 3
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand, groupSize)) // true

    hand2 := []int{1,2,3,4,5}
    groupSize2 := 4
    fmt.Println(\"Can rearrange into groups:\", isNStraightHand(hand2, groupSize2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeTripletstoFormTarget.Greedy
    set output_file "merge_triplets.go"

    set template_content "package main

import (
    \"fmt\"
)

func mergeTriplets(triplets [][]int, target []int) bool {
    good := make(map[int]bool)

    for _, t := range triplets {
        if t[0] > target[0] || t[1] > target[1] || t[2] > target[2] {
            continue
        }
        for i, v := range t {
            if v == target[i] {
                good[i] = true
            }
        }
    }
    return len(good) == 3
}

func main() {
    triplets1 := [][]int{{2,5,3}, {1,8,4}, {1,7,5}}
    target1 := []int{2,7,5}
    fmt.Println(\"Can merge triplets:\", mergeTriplets(triplets1, target1)) // true

    triplets2 := [][]int{{3,4,5}, {4,5,6}}
    target2 := []int{3,2,5}
    fmt.Println(\"Can merge triplets:\", mergeTriplets(triplets2, target2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MergeTripletstoFormTarget.Greedy_Optimal
    set output_file "merge_triplets_xy.go"

    set template_content "package main

import (
    \"fmt\"
)

func mergeTriplets(triplets [][]int, target []int) bool {
    x, y, z := false, false, false

    for _, t := range triplets {
        x = x || (t[0] == target[0] && t[1] <= target[1] && t[2] <= target[2])
        y = y || (t[0] <= target[0] && t[1] == target[1] && t[2] <= target[2])
        z = z || (t[0] <= target[0] && t[1] <= target[1] && t[2] == target[2])

        if x && y && z {
            return true
        }
    }
    return false
}

func main() {
    triplets1 := [][]int{{2,5,3}, {1,8,4}, {1,7,5}}
    target1 := []int{2,7,5}
    fmt.Println(\"Can merge triplets:\", mergeTriplets(triplets1, target1)) // true

    triplets2 := [][]int{{3,4,5}, {4,5,6}}
    target2 := []int{3,2,5}
    fmt.Println(\"Can merge triplets:\", mergeTriplets(triplets2, target2)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.PartitionLabels.TwoPointers_Greedy
    set output_file "partition_labels.go"

    set template_content "package main

import (
    \"fmt\"
)

func partitionLabels(s string) []int {
    lastIndex := make(map[rune]int)
    for i, c := range s {
        lastIndex[c] = i
    }

    var res []int
    size, end := 0, 0
    for i, c := range s {
        size++
        if lastIndex[c] > end {
            end = lastIndex[c]
        }

        if i == end {
            res = append(res, size)
            size = 0
        }
    }
    return res
}

func main() {
    s1 := \"ababcbacadefegdehijhklij\"
    fmt.Println(\"Partition Labels:\", partitionLabels(s1)) // [9 7 8]

    s2 := \"eccbbbbdec\"
    fmt.Println(\"Partition Labels:\", partitionLabels(s2)) // [10]
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ValidParenthesisString.Recursion
    set output_file "check_valid_string.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    var dfs func(i, open int) bool
    dfs = func(i, open int) bool {
        if open < 0 {
            return false
        }
        if i == len(s) {
            return open == 0
        }

        if s[i] == '(' {
            return dfs(i+1, open+1)
        } else if s[i] == ')' {
            return dfs(i+1, open-1)
        } else {
            return dfs(i+1, open) ||
                dfs(i+1, open+1) ||
                dfs(i+1, open-1)
        }
    }
    return dfs(0, 0)
}

func main() {
    s1 := \"(*)\"
    fmt.Println(\"checkValidString(\", s1, \") =\", checkValidString(s1)) // true

    s2 := \"(*))\"
    fmt.Println(\"checkValidString(\", s2, \") =\", checkValidString(s2)) // true

    s3 := \"(((*)\"
    fmt.Println(\"checkValidString(\", s3, \") =\", checkValidString(s3)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ValidParenthesisString.DynamicProgramming_Top-Down
    set output_file "check_valid_string_memo.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    memo := make([][]int, len(s)+1)
    for i := range memo {
        memo[i] = make([]int, len(s)+1)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(i, open int) bool
    dfs = func(i, open int) bool {
        if open < 0 {
            return false
        }
        if i == len(s) {
            return open == 0
        }
        if memo[i][open] != -1 {
            return memo[i][open] == 1
        }

        result := false
        if s[i] == '(' {
            result = dfs(i+1, open+1)
        } else if s[i] == ')' {
            result = dfs(i+1, open-1)
        } else {
            result = dfs(i+1, open) ||
                dfs(i+1, open+1) ||
                dfs(i+1, open-1)
        }

        if result {
            memo[i][open] = 1
        } else {
            memo[i][open] = 0
        }
        return result
    }

    return dfs(0, 0)
}

func main() {
    s1 := \"(*)\"
    fmt.Println(\"checkValidString(\", s1, \") =\", checkValidString(s1)) // true

    s2 := \"(*))\"
    fmt.Println(\"checkValidString(\", s2, \") =\", checkValidString(s2)) // true

    s3 := \"(((*)\"
    fmt.Println(\"checkValidString(\", s3, \") =\", checkValidString(s3)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ValidParenthesisString.DynamicProgramming_Bottom-Up
    set output_file "check_valid_string_dp.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    n := len(s)
    dp := make([][]bool, n+1)
    for i := range dp {
        dp[i] = make([]bool, n+1)
    }
    dp[n][0] = true

    for i := n - 1; i >= 0; i-- {
        for open := 0; open < n; open++ {
            res := false
            if s[i] == '*' {
                res = dp[i+1][open+1]
                if open > 0 {
                    res = res || dp[i+1][open-1]
                }
                res = res || dp[i+1][open]
            } else {
                if s[i] == '(' {
                    res = dp[i+1][open+1]
                } else if open > 0 {
                    res = dp[i+1][open-1]
                }
            }
            dp[i][open] = res
        }
    }
    return dp[0][0]
}

func main() {
    s1 := \"(*)\"
    fmt.Println(\"checkValidString(\", s1, \") =\", checkValidString(s1)) // true

    s2 := \"(*))\"
    fmt.Println(\"checkValidString(\", s2, \") =\", checkValidString(s2)) // true

    s3 := \"(((*)\"
    fmt.Println(\"checkValidString(\", s3, \") =\", checkValidString(s3)) // false
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ValidParenthesisString.DynamicProgramming_SpaceOptimized
    set output_file "check_valid_string_dp1d.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    n := len(s)
    dp := make([]bool, n+1)
    dp[0] = true

    for i := n - 1; i >= 0; i-- {
        newDp := make([]bool, n+1)
        for open := 0; open < n; open++ {
            if s[i] == '*' {
                newDp[open] = (dp[open+1] ||
                               (open > 0 && dp[open-1]) ||
                               dp[open])
            } else if s[i] == '(' {
                newDp[open] = dp[open+1]
            } else if open > 0 {
                newDp[open] = dp[open-1]
            }
        }
        dp = newDp
    }
    return dp[0]
}

func main() {
    tests := []string{\"(*)\", \"(*))\", \"(((*)\", \"((*)*)\"}
    for _, t := range tests {
        fmt.Printf(\"checkValidString(%q) = %v\\n\", t, checkValidString(t))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ValidParenthesisString.Stack
    set output_file "check_valid_string_stacks.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    var left, star []int
    for i, ch := range s {
        if ch == '(' {
            left = append(left, i)
        } else if ch == '*' {
            star = append(star, i)
        } else {
            if len(left) == 0 && len(star) == 0 {
                return false
            }
            if len(left) > 0 {
                left = left[:len(left)-1]
            } else {
                star = star[:len(star)-1]
            }
        }
    }

    for len(left) > 0 && len(star) > 0 {
        if left[len(left)-1] > star[len(star)-1] {
            return false
        }
        left = left[:len(left)-1]
        star = star[:len(star)-1]
    }
    return len(left) == 0
}

func main() {
    tests := []string{\"(*)\", \"(*))\", \"(((*)\", \"((*)*)\", \"(()*\", \"(*()*)\"}
    for _, t := range tests {
        fmt.Printf(\"checkValidString(%q) = %v\\n\", t, checkValidString(t))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ValidParenthesisString.Greedy
    set output_file "check_valid_string_greedy.go"

    set template_content "package main

import (
    \"fmt\"
)

func checkValidString(s string) bool {
    leftMin, leftMax := 0, 0

    for _, c := range s {
        if c == '(' {
            leftMin, leftMax = leftMin+1, leftMax+1
        } else if c == ')' {
            leftMin, leftMax = leftMin-1, leftMax-1
        } else {
            leftMin, leftMax = leftMin-1, leftMax+1
        }
        if leftMax < 0 {
            return false
        }
        if leftMin < 0 {
            leftMin = 0
        }
    }
    return leftMin == 0
}

func main() {
    tests := []string{\"(*)\", \"(*))\", \"(((*)\", \"((*)*)\", \"(()*\", \"(*()*)\"}
    for _, t := range tests {
        fmt.Printf(\"checkValidString(%q) = %v\\n\", t, checkValidString(t))
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.NetworkDelayTime.DepthFirstSearch
    set output_file "network_delay_dfs.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func networkDelayTime(times [][]int, n int, k int) int {
    adj := make(map[int][][]int)
    for _, time := range times {
        u, v, w := time[0], time[1], time[2]
        adj[u] = append(adj[u], []int{v, w})
    }

    dist := make(map[int]int)
    for i := 1; i <= n; i++ {
        dist[i] = math.MaxInt32
    }

    var dfs func(int, int)
    dfs = func(node int, time int) {
        if time >= dist[node] {
            return
        }
        dist[node] = time
        for _, edge := range adj[node] {
            nei, w := edge[0], edge[1]
            dfs(nei, time+w)
        }
    }

    dfs(k, 0)
    res := 0
    for _, time := range dist {
        if time == math.MaxInt32 {
            return -1
        }
        if time > res {
            res = time
        }
    }
    return res
}

func main() {
    times := [][]int{{2,1,1},{2,3,1},{3,4,1}}
    n, k := 4, 2
    fmt.Println(\"Network delay time (DFS):\", networkDelayTime(times, n, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.NetworkDelayTime.FloydWarshallAlgorithm
    set output_file "network_delay_floyd.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func networkDelayTime(times [][]int, n int, k int) int {
    inf := math.MaxInt32
    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, n)
        for j := range dist[i] {
            dist[i][j] = inf
        }
    }

    for _, time := range times {
        u, v, w := time[0]-1, time[1]-1, time[2]
        dist[u][v] = w
    }
    for i := 0; i < n; i++ {
        dist[i][i] = 0
    }

    for mid := 0; mid < n; mid++ {
        for i := 0; i < n; i++ {
            for j := 0; j < n; j++ {
                dist[i][j] = min(dist[i][j], dist[i][mid]+dist[mid][j])
            }
        }
    }

    res := 0
    for i := 0; i < n; i++ {
        if dist[k-1][i] == inf {
            return -1
        }
        res = max(res, dist[k-1][i])
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
    times := [][]int{{2,1,1},{2,3,1},{3,4,1}}
    n, k := 4, 2
    fmt.Println(\"Network delay time (Floyd-Warshall):\", networkDelayTime(times, n, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.NetworkDelayTime.BellmanFordAlgorithm
    set output_file "network_delay_bellman.go"

    set template_content "package main

import (
    \"fmt\"
)

func networkDelayTime(times [][]int, n int, k int) int {
    dist := make([]int, n)
    for i := range dist {
        dist[i] = 1<<31 - 1
    }
    dist[k-1] = 0

    for _ = range n-1 {
        for _, time := range times {
            u, v, w := time[0]-1, time[1]-1, time[2]
            if dist[u]+w < dist[v] {
                dist[v] = dist[u] + w
            }
        }
    }

    maxDist := 0
    for _, d := range dist {
        if d == 1<<31-1 {
            return -1
        }
        if d > maxDist {
            maxDist = d
        }
    }

    return maxDist
}

func main() {
    times := [][]int{{2,1,1},{2,3,1},{3,4,1}}
    n, k := 4, 2
    fmt.Println(\"Network delay time (Bellman-Ford):\", networkDelayTime(times, n, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.NetworkDelayTime.ShortestPathFasterAlgorithm
    set output_file "network_delay_bfs.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func networkDelayTime(times [][]int, n int, k int) int {
    adj := make(map[int][][]int)
    for _, edge := range times {
        u, v, w := edge[0], edge[1], edge[2]
        adj[u] = append(adj[u], []int{v, w})
    }

    dist := make(map[int]int)
    for i := 1; i <= n; i++ {
        dist[i] = math.MaxInt
    }
    dist[k] = 0

    q := [][]int{{k, 0}}

    for len(q) > 0 {
        node, time := q[0][0], q[0][1]
        q = q[1:]

        if time > dist[node] {
            continue
        }
        for _, nei := range adj[node] {
            v, w := nei[0], nei[1]
            if time+w < dist[v] {
                dist[v] = time + w
                q = append(q, []int{v, time + w})
            }
        }
    }

    res := -1
    for _, d := range dist {
        if d == math.MaxInt {
            return -1
        }
        if d > res {
            res = d
        }
    }
    return res
}

func main() {
    times := [][]int{{2,1,1},{2,3,1},{3,4,1}}
    n, k := 4, 2
    fmt.Println(\"Network delay time (BFS/Dijkstra):\", networkDelayTime(times, n, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.NetworkDelayTime.DijkstrasAlgorithm

    set output_file "network_delay_pq.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

type Edge struct {
    node, weight int
}

func networkDelayTime(times [][]int, n int, k int) int {
    edges := make(map[int][]Edge)
    for _, time := range times {
        u, v, w := time[0], time[1], time[2]
        edges[u] = append(edges[u], Edge{node: v, weight: w})
    }

    pq := priorityqueue.NewWith(func(a, b interface{}) int {
        return utils.IntComparator(a.(Edge).weight, b.(Edge).weight)
    })
    pq.Enqueue(Edge{node: k, weight: 0})

    visited := make(map[int]bool)
    t := 0

    for !pq.Empty() {
        item, _ := pq.Dequeue()
        edge := item.(Edge)
        node, time := edge.node, edge.weight

        if visited[node] {
            continue
        }
        visited[node] = true
        t = time

        for _, next := range edges[node] {
            if !visited[next.node] {
                pq.Enqueue(Edge{node: next.node, weight: time + next.weight})
            }
        }
    }

    if len(visited) == n {
        return t
    }
    return -1
}

func main() {
    times := [][]int{{2,1,1},{2,3,1},{3,4,1}}
    n, k := 4, 2
    fmt.Println(\"Network delay time (Dijkstra PQ):\", networkDelayTime(times, n, k))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MinCosttoConnectPoints.KruskalAlgorithm
    set output_file "min_cost_connect_points.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
    \"sort\"
)

type DSU struct {
    Parent []int
    Size   []int
}

func NewDSU(n int) *DSU {
    parent := make([]int, n)
    size := make([]int, n)
    for i := range parent {
        parent[i] = i
        size[i] = 1
    }
    return &DSU{Parent: parent, Size: size}
}

func (dsu *DSU) find(node int) int {
    if dsu.Parent[node] != node {
        dsu.Parent[node] = dsu.find(dsu.Parent[node])
    }
    return dsu.Parent[node]
}

func (dsu *DSU) union(u, v int) bool {
    pu, pv := dsu.find(u), dsu.find(v)
    if pu == pv {
        return false
    }
    if dsu.Size[pu] < dsu.Size[pv] {
        pu, pv = pv, pu
    }
    dsu.Size[pu] += dsu.Size[pv]
    dsu.Parent[pv] = pu
    return true
}

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    dsu := NewDSU(n)
    var edges [][]int

    for i := 0; i < n; i++ {
        x1, y1 := points[i][0], points[i][1]
        for j := i + 1; j < n; j++ {
            x2, y2 := points[j][0], points[j][1]
            dist := int(math.Abs(float64(x1-x2)) + math.Abs(float64(y1-y2)))
            edges = append(edges, []int{dist, i, j})
        }
    }

    sort.Slice(edges, func(a, b int) bool {
        return edges[a][0] < edges[b][0]
    })

    res := 0
    for _, edge := range edges {
        dist, u, v := edge[0], edge[1], edge[2]
        if dsu.union(u, v) {
            res += dist
        }
    }
    return res
}

func main() {
    points := [][]int{{0,0},{2,2},{3,10},{5,2},{7,0}}
    fmt.Println(\"Min cost to connect points:\", minCostConnectPoints(points))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MinCosttoConnectPoints.PrimsAlgorithm 
    set output_file "min_cost_connect_points.go"

    set template_content "package main

import (
    \"math\"
    priorityqueue \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    adj := make(map[int][][]int)

    for i := 0; i < n; i++ {
        x1, y1 := points[i][0], points[i][1]
        for j := i + 1; j < n; j++ {
            x2, y2 := points[j][0], points[j][1]
            dist := int(math.Abs(float64(x1-x2)) + math.Abs(float64(y1-y2)))
            adj[i] = append(adj[i], []int{dist, j})
            adj[j] = append(adj[j], []int{dist, i})
        }
    }

    res := 0
    visit := make(map[int]bool)

    pq := priorityqueue.NewWith(func(a, b interface{}) int {
        return utils.IntComparator(a.([]int)[0], b.([]int)[0])
    })
    pq.Enqueue([]int{0, 0})

    for len(visit) < n {
        item, ok := pq.Dequeue()
        if !ok {
            continue
        }
        cost, point := item.([]int)[0], item.([]int)[1]
        if visit[point] {
            continue
        }
        res += cost
        visit[point] = true

        for _, edge := range adj[point] {
            neiCost, neiPoint := edge[0], edge[1]
            if !visit[neiPoint] {
                pq.Enqueue([]int{neiCost, neiPoint})
            }
        }
    }
    return res
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MinCosttoConnectPoints.PrimsAlgorithm_Optimal
    set output_file "min_cost_connect_points.go"

    set template_content "package main

import (
    \"math\"
)

func minCostConnectPoints(points [][]int) int {
    n := len(points)
    node := 0
    dist := make([]int, n)
    for i := range dist {
        dist[i] = 100000000
    }
    visit := make([]bool, n)
    edges, res := 0, 0

    for edges < n-1 {
        visit[node] = true
        nextNode := -1
        for i := 0; i < n; i++ {
            if visit[i] {
                continue
            }
            curDist := int(math.Abs(float64(points[i][0]-points[node][0])) +
                math.Abs(float64(points[i][1]-points[node][1])))
            if curDist < dist[i] {
                dist[i] = curDist
            }
            if nextNode == -1 || dist[i] < dist[nextNode] {
                nextNode = i
            }
        }
        res += dist[nextNode]
        node = nextNode
        edges++
    }
    return res
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CheapestFlightsWithinKStops.Dijkstras
    set output_file "find_cheapest_price.go"

    set template_content "package main

import (
    \"github.com/emirpasic/gods/queues/priorityqueue\"
    \"github.com/emirpasic/gods/utils\"
)

func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {
    INF := 1000000000
    adj := make([][]struct{ to, cost int }, n)
    dist := make([][]int, n)
    for i := range dist {
        dist[i] = make([]int, k+5)
        for j := range dist[i] {
            dist[i][j] = INF
        }
    }
    for _, flight := range flights {
        from, to, cost := flight[0], flight[1], flight[2]
        adj[from] = append(adj[from], struct{ to, cost int }{to, cost})
    }
    dist[src][0] = 0
    minHeap := priorityqueue.NewWith(func(a, b interface{}) int {
        return utils.IntComparator(a.([3]int)[0], b.([3]int)[0])
    })
    minHeap.Enqueue([3]int{0, src, -1})
    for !minHeap.Empty() {
        value, _ := minHeap.Dequeue()
        cst, node, stops := value.([3]int)[0], value.([3]int)[1], value.([3]int)[2]
        if node == dst {
            return cst
        }
        if stops == k || dist[node][stops+1] < cst {
            continue
        }
        for _, nei := range adj[node] {
            nextCst := cst + nei.cost
            nextStops := stops + 1
            if dist[nei.to][nextStops+1] > nextCst {
                dist[nei.to][nextStops+1] = nextCst
                minHeap.Enqueue([3]int{nextCst, nei.to, nextStops})
            }
        }
    }
    return -1
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.CheapestFlightsWithinKStops.BellmanFordAlgorithm
    set output_file "find_cheapest_price.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {
    prices := make([]int, n)
    for i := range prices {
        prices[i] = math.MaxInt32
    }
    prices[src] = 0

    for i := 0; i <= k; i++ {
        tmpPrices := make([]int, n)
        copy(tmpPrices, prices)

        for _, flight := range flights {
            s, d, p := flight[0], flight[1], flight[2]
            if prices[s] == math.MaxInt32 {
                continue
            }
            if prices[s] + p < tmpPrices[d] {
                tmpPrices[d] = prices[s] + p
            }
        }
        prices = tmpPrices
    }

    if prices[dst] == math.MaxInt32 {
        return -1
    }
    return prices[dst]
}

func main() {
    flights := [][]int{{0,1,100},{1,2,100},{0,2,500}}
    fmt.Println(findCheapestPrice(3, flights, 0, 2, 1)) // Output: 200
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CheapestFlightsWithinKStops.ShortestPathFasterAlgorithm
    set output_file "find_cheapest_price.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

func findCheapestPrice(n int, flights [][]int, src int, dst int, k int) int {
    prices := make([]int, n)
    for i := range prices {
        prices[i] = math.MaxInt32
    }
    prices[src] = 0

    adj := make([][][2]int, n)
    for _, flight := range flights {
        from, to, cost := flight[0], flight[1], flight[2]
        adj[from] = append(adj[from], [2]int{to, cost})
    }

    q := [][3]int{{0, src, 0}}

    for len(q) > 0 {
        curr := q[0]
        q = q[1:]
        cst, node, stops := curr[0], curr[1], curr[2]

        if stops > k {
            continue
        }

        for _, neighbor := range adj[node] {
            nei, w := neighbor[0], neighbor[1]
            nextCost := cst + w
            if nextCost < prices[nei] {
                prices[nei] = nextCost
                q = append(q, [3]int{nextCost, nei, stops + 1})
            }
        }
    }

    if prices[dst] == math.MaxInt32 {
        return -1
    }
    return prices[dst]
}

func main() {
    flights := [][]int{{0,1,100},{1,2,100},{0,2,500}}
    fmt.Println(findCheapestPrice(3, flights, 0, 2, 1)) // Output: 200
}
"

   echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.GenerateArrayExamples
    set output_file "array_examples.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
)

// ===================== EXAMPLE 1 =====================

func example1() {
    var n int = 5
    arr := [10]int{}

    values := [5]int{1, 2, 7, 5, 8}
    for i := 0; i < n; i++ {
        arr[i] = values[i]
    }

    fmt.Println(arr)
    k := len(arr)
    fmt.Println(k)

    sumi := 0
    for i := 0; i < n; i++ {
        sumi += arr[i]
    }
    fmt.Println(sumi)
}

// ===================== EXAMPLE 2 =====================

func addElement(arr []int) {
    arr[0] = 123
}

func example2() {
    arr := []int{1, 2, 3, 4}
    fmt.Println(arr)
    addElement(arr)
    fmt.Println(arr)
}

// ===================== EXAMPLE 3 =====================

func example3() {
    arr := []int{1, 2, 3, 4}
    arr = append(arr, arr[0])
    arr = append(arr, arr[1])

    fmt.Println(arr)

    n := len(arr)
    maxi := 0

    for i := 0; i < n-2; i++ {
        sumi := arr[i] + arr[i+1] + arr[i+2]
        fmt.Println(\"sumi\", sumi)
        if sumi > maxi {
            maxi = sumi
        }
    }

    fmt.Println(\"maxi:\", maxi)
}

// ===================== MAIN =====================

func main() {
    fmt.Println(\"=== Example 1 ===\")
    example1()

    fmt.Println(\"\\n=== Example 2 ===\")
    example2()

    fmt.Println(\"\\n=== Example 3 ===\")
    example3()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.GenerateArrayExamples2
    set output_file "array_examples2.go"

    set template_content "package main

import \"fmt\"

// ========== EXAMPLE 1 ==========
func example1() {
    var numbers [10]int
    fmt.Println(numbers)

    elements := [5]int{1, 2, 3, 4, 5}
    fmt.Println(elements)

    array := [...]int{1, 2, 4, 5, 6, 7, 8, 9, 2, 3, 4}
    fmt.Println(array)
}

// ========== EXAMPLE 2 ==========
func example2() {
    books := [...]string{\"red\", \"orange\", \"FFAD8D\", \"blue\", \"violet\"}
    fmt.Println(books)
    fmt.Println(books[3])
}

// ========== EXAMPLE 3 ==========
func example3() {
    numbers := [...]int{100, 12, 3, 53}
    fmt.Println(numbers)
    numbers[2] = 15
    fmt.Println(numbers)
}

// ========== EXAMPLE 4 ==========
func example4() {
    numbers := [...]int{1, 2, 3, 4, 5}
    sumi := 0
    sumi = sumi + numbers[0]
    sumi = sumi + numbers[1]
    sumi = sumi + numbers[2]
    sumi = sumi + numbers[3]
    sumi = sumi + numbers[4]

    fmt.Println(sumi)
}

// ========== EXAMPLE 5 ==========
func example5() {
    numbers := [...]int{1, 2, 3, 4, 5}
    sumi := 0
    for _, val := range numbers {
        sumi += val
    }
    fmt.Println(sumi)
}

// ================= MAIN =================
func main() {
    fmt.Println(\"=== Example 1 ===\")
    example1()

    fmt.Println(\"\\n=== Example 2 ===\")
    example2()

    fmt.Println(\"\\n=== Example 3 ===\")
    example3()

    fmt.Println(\"\\n=== Example 4 ===\")
    example4()

    fmt.Println(\"\\n=== Example 5 ===\")
    example5()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EvenFilterExample
    set output_file "even_filter.go"

    set template_content "package main

import \"fmt\"

// ========== FILTER ONLY EVEN NUMBERS ==========

func GetOnlyEven(arr []int) []int {
    evens := []int{}
    for i := 0; i < len(arr); i++ {
        if CheckForEven(arr[i]) {
            evens = append(evens, arr[i])
        }
    }
    return evens
}

func CheckForEven(k int) bool {
    return k%2 == 0
}

// Alternative using range
func exampleRangeFilter() {
    arr := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}
    evens := []int{}
    for _, val := range arr {
        if val%2 == 0 {
            evens = append(evens, val)
        }
    }
    fmt.Println(evens)
}

// Main example
func main() {
    arr := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}
    newArr := GetOnlyEven(arr)
    fmt.Println(newArr)

    fmt.Println(\"Using range version:\")
    exampleRangeFilter()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayModifyExample
    set output_file "array_modify_example.go"

    set template_content "package main

import (
    \"fmt\"
)

func modifyArray(arr [5]int, index int, value int) [5]int {
    arr[index] = value
    return arr
}

func main() {
    originalArray := [5]int{1, 2, 3, 4, 5}

    fmt.Println(\"Length of the array is:\", len(originalArray))

    copiedArray := originalArray
    fmt.Println(\"Copied Array:\", copiedArray)

    modifiedArray := modifyArray(originalArray, 2, 10)
    fmt.Println(\"Modified Array:\", modifiedArray)

    isEqual := originalArray == modifiedArray
    fmt.Println(\"Are original and modified arrays equal?\", isEqual)

    isCopiedEqual := originalArray == copiedArray
    fmt.Println(\"Are original and copied arrays equal?\", isCopiedEqual)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayExamples
    set output_file "array_examples.go"

    set template_content "package main

import \"fmt\"

func main() {
	week := [...]string{\"Monday\", \"Tuesday\"}
	wend := [...]string{\"Saturday\", \"Sunday\"}

	fmt.Println(week != wend)

	evens := [...]int{2, 4, 6, 8, 10}
	evens2 := [...]int{2, 4, 6, 8, 10}

	fmt.Println(evens == evens2)

	image := [5]uint8{'h', 'i'}
	var data [5]byte

	fmt.Println(data == image)
}


func main1() {
	var numbersZero [4]int

	fmt.Printf(\"%d\\n\", numbersZero)
	fmt.Printf(\"%#v\\n\", numbersZero)

	var a1 = [4]float64{}
	fmt.Printf(\"%#v\\n\", a1)

	var a2 = [4]int{-10, 1, 100}
	fmt.Printf(\"%#v\\n\", a2)

	a3 := [4]string{\"Dan\", \"Diana\", \"Paul\", \"John\"}
	fmt.Printf(\"%#v\\n\", a3)

	a4 := [4]string{\"x\", \"y\"}
	fmt.Printf(\"%#v\\n\", a4)

	//ellipsis operator

	a5 := [...]int{1, 2, 5, 1, -10, 66}
	fmt.Printf(\"%#v\\n\", a5)
	fmt.Printf(\"The length of a5 is %d\\n\", len(a5))

	for i, v := range a2 {
		fmt.Println(\"Index: \", i, \"Values: \", v)
	}

	//multi-dimensional arrays

	balances := [2][3]int{
		{5, 6, 7},
		{8, 9, 10}, //this comma is mandatory
	}
	fmt.Println(balances)

	// keyed elements array
	grades := [3]int{
		1: 10,
		0: 3,
		2: 43,
	}
	fmt.Println(grades)

	accounts := [3]int{2: 50}
	fmt.Println(accounts)

	names := [...]string{5: \"Willkommen\"}
	fmt.Printf(\"%#v\\n\", names)

	cities := [...]string{
		5: \"Kaduna\",
		\"London\",
		1: \"France\",
	}
	fmt.Printf(\"%#v\\n\", cities)

	numbers := []int{2, 3, 4, 5}

	fmt.Println(numbers)
}


func main2() {
	// 1. Declaration Without Initialization
	var arr1 [5]int
	fmt.Println(\"Array declared without initialization:\", arr1)

	// 2. Declaration With Initialization
	var arr2 [5]int = [5]int{1, 2, 3, 4, 5}
	fmt.Println(\"Array declared with initialization:\", arr2)

	// 3. Short Hand Declaration
	arr3 := [5]int{1, 2, 3, 4, 5}
	fmt.Println(\"Array with short hand declaration:\", arr3)

	// 4. Initializing With Specific Elements
	arr4 := [5]int{1: 10, 3: 30}
	fmt.Println(\"Array initializing with specific elements:\", arr4)

	// 5. Using the ... Operator to Infer Length
	arr5 := [...]int{1, 2, 3, 4, 5, 6, 7}
	fmt.Println(\"Array using ... operator to infer length:\", arr5)
	main21()
	main22()
}

func main21() {
	// 6. Array of Arrays (Multi-dimensional Arrays)
	var multiArray [2][3]int
	multiArray[0] = [3]int{1, 2, 3}
	multiArray[1] = [3]int{4, 5, 6}
	fmt.Println(\"Multi-dimensional Array:\", multiArray)

	// 7. Initializing Multi-dimensional Arrays
	initializedMultiArray := [2][3]int{{7, 8, 9}, {10, 11, 12}}
	fmt.Println(\"Initialized Multi-dimensional Array:\", initializedMultiArray)

	// 8. Arrays with Pointers
	var pointerArray [3]*int
	num1, num2, num3 := 13, 14, 15
	pointerArray[0] = &num1
	pointerArray[1] = &num2
	pointerArray[2] = &num3
	fmt.Println(\"Array with Pointers:\")
	for i := 0; i < len(pointerArray); i++ {
		fmt.Printf(\"pointerArray[%d] = %d\\n\", i, *pointerArray[i])
	}
}

func main22() {
	// 9. Arrays of Structs
	type Person struct {
		Name string
		Age  int
	}
	var structArray [2]Person
	structArray[0] = Person{\"Alice\", 30}
	structArray[1] = Person{\"Bob\", 25}
	fmt.Println(\"Array of Structs:\", structArray)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TwoDimensionalArray
    set output_file "two_dimensional_array.go"

    set template_content "package main

import (
	\"fmt\"
	\"math/rand\"
)

func CreateTwoDimensionalArray(rows, columns, randomRange int) [][]int {
	arr := [][]int{}
	for i := 0; i < rows; i++ {
		a := []int{}
		for j := 0; j < columns; j++ {
			k := rand.Intn(randomRange)
			a = append(a, k)
		}
		arr = append(arr, a)
	}
	return arr
}

func main() {
	arr := CreateTwoDimensionalArray(10, 20, 15)
	for _, v := range arr {
		fmt.Println(v)
	}
	for i := 0; i < len(arr); i++ {
		shetchik := 0
		for j := 0; j < len(arr[i]); j++ {
			if arr[i][j] == 5 {
				shetchik += 1
			}
		}
		if shetchik >= 3 {
			fmt.Println(\"Повторение в массиве = \", shetchik, \"\", \"Строка = \", i)
		}
	}
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Array1
    set output_file "array1.go"

    set template_content "package main

import (
	\"fmt\"
)

func Array1() {
	numbers := [5]int{233, 24, 56, 87, 23}
	fmt.Println(numbers)
	fmt.Println(\"-------------------\")

	// Initialize maxValue with the first element of the array
	maxValue := numbers[0]

	// Iterate through the array to find the maximum value
	for i := 0; i < len(numbers); i++ {
		fmt.Println(numbers[i])
		if numbers[i] > maxValue {
			maxValue = numbers[i]
		}
	}
	fmt.Println(maxValue)
	fmt.Println(\"-------------------\")
}

func main() {
	Array1()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayStats
    set output_file "array_stats.go"

    set template_content "package main

import \"fmt\"

func getMaxAndMin(a []int) (int, int) {
    maxi := a[0]
    mini := a[0]
    for i := 0; i < len(a); i++ {
        if a[i] > maxi {
            maxi = a[i]
        }
        if a[i] < mini {
            mini = a[i]
        }
    }
    return maxi, mini
}

func getAvg(a []int) int {
    sumi := 0
    avg := 0
    for i := 0; i < len(a); i++ {
        sumi += a[i]
    }
    avg = sumi / len(a)
    return avg
}

func printInfo(a []int) {
    maxi, mini := getMaxAndMin(a)
    avg := getAvg(a)
    fmt.Println(\"maxi =\", maxi)
    fmt.Println(\"mini =\", mini)
    fmt.Println(\"avg =\", avg)
    fmt.Println(\"\")
}

func main() {
    arr1 := []int{1, 2, 3, 4}
    arr2 := []int{4, 5, 6, 2, 323, 23, 4, 232}
    arr3 := []int{1, 23, 4, 123, 23213, 43434, 4545, 12321, 1313213, 343443, 54565}
    printInfo(arr1)
    printInfo(arr2)
    printInfo(arr3)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.ArraysAndSlices
    set output_file "arrays_and_slices.go"

    set template_content "package main

import \"fmt\"

func setSection() {
    fmt.Println()
    fmt.Println(\"----------------------------\")
    fmt.Println()
}

func changeLocal(num [5]int) {
    num[0] = 55
    fmt.Println(\"inside function \", num)
}

func subtactOne(numbers []int) {
    for i := range numbers {
        numbers[i] -= 2
    }
}

func main() {
    fmt.Println(\"Arrays\")
    var threeNillIntegers [3]int
    fmt.Println(threeNillIntegers)

    var threeIntegers = [3]int{1, 2, 3}
    fmt.Println(threeIntegers)

    var integers = [...]int{1, 2, 3, 4, 5}
    fmt.Println(fmt.Sprintf(\`Array %d. Size %d\`, integers, len(integers)))

    setSection()

    num := [...]int{5, 6, 7, 8, 8}
    fmt.Println(\"before passing to function \", num)
    changeLocal(num)
    fmt.Println(\"after passing to function \", num)

    setSection()
    fmt.Println(\"Slices\")

    arr := [5]int{1, 2, 3, 4, 5}
    var sli []int = arr[1:4]
    fmt.Println(sli)

    slic := []int{6, 7, 8}
    fmt.Println(slic)

    darr := [...]int{57, 89, 90, 82, 100, 78, 67, 69, 59}
    dslice := darr[2:5]
    fmt.Println(\"array before\", darr)
    for i := range dslice {
        dslice[i]++
    }
    fmt.Println(\"array after\", darr)

    veggies := []string{\"potatoes\", \"tomatoes\", \"brinjal\"}
    fruits := []string{\"oranges\", \"apples\"}
    food := append(veggies, fruits...)
    fmt.Println(\"food:\", food)

    nos := []int{8, 7, 6}
    fmt.Println(\"slice before function call\", nos)
    subtactOne(nos)
    fmt.Println(\"slice after function call\", nos)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ArrayIteration
    set output_file "array_iteration.go"

    set template_content "package main

import \"fmt\"

func main() {
    numbers := [5]int{10, 20, 30, 40, 50}

    fmt.Println(\"Iterating using traditional for loop:\")
    for i := 0; i < len(numbers); i++ {
        fmt.Printf(\"Index: %d, Value: %d\\n\", i, numbers[i])
    }

    fmt.Println(\"\\nIterating using range loop:\")
    for index, value := range numbers {
        fmt.Printf(\"Index: %d, Value: %d\\n\", index, value)
    }
}
"

   echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.CircularMax3
    set output_file "circular_max3.go"

    set template_content "package main

import \"fmt\"

func main() {
    arr := []int{1, 2, 3}
    n := len(arr)
    sumi := 0
    maxi := 0

    for i := 0; i < n; i++ {
        if i == n-1 {
            sumi = arr[i] + arr[0] + arr[1]
        } else if i == n-2 {
            sumi = arr[i] + arr[i+1] + arr[0]
        } else {
            sumi = arr[i] + arr[i+1] + arr[i+2]
        }
        if sumi > maxi {
            maxi = sumi
        }
    }
    fmt.Println(maxi)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MultiArrayAndSlice
    set output_file "multi_array_and_slice.go"

    set template_content "package main

import (
	\"fmt\"
)

func main() {
	// Масив multiArray
	multiArray := [3][4]int{{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}}
	fmt.Println(multiArray)
	fmt.Println(multiArray[1][2]) // Accesses the element at row 1, column 2
	fmt.Println(multiArray[2][3]) // Accesses the element at row 2, column 3
}

package main

import \"fmt\"

func main() {
	// Створюємо slice of slices (аналог multiArray)
	multiSlice := [][]int{{1, 2, 3, 4}, {5, 6, 7, 8}, {9, 10, 11, 12}}

	fmt.Println(multiSlice)

	// Доступ до елементів так само
	fmt.Println(multiSlice[1][2]) // 7
	fmt.Println(multiSlice[2][3]) // 12

	// Додаємо новий рядок
	multiSlice = append(multiSlice, []int{13, 14, 15, 16})
	fmt.Println(multiSlice)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.LongestWarmStreak
    set output_file "longest_warm_streak.go"

    set template_content "package main

import \"fmt\"

func main() {
	arr := [10]int{10, 20, 30, 1, -10, 1, 2, 3}
	max := 0
	ottepel := 0
	n := len(arr)
	for i := 0; i < n; i++ {
		if arr[i] >= 0 {
			ottepel += 1
		} else {
			if ottepel > max {
				max = ottepel
			}
			ottepel = 0
		}
	}
	fmt.Println(\"Продолжительная оттепель = \", max)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SummaryRanges
    set output_file "summary_ranges.go"

    set template_content "package main

import (
	\"bytes\"
	\"fmt\"
	\"strconv\"
)

func summaryRanges(nums []int) []string {
	res := []string{}
	if len(nums) == 1 {
		res = append(res, strconv.Itoa(nums[0]))
		return res
	}
	for i := 0; i < len(nums); i++ {
		num := nums[i]
		for i+1 < len(nums) && nums[i+1]-nums[i] == 1 {
			i += 1
		}
		if nums[i] != num {
			var tempBuffer bytes.Buffer
			tempBuffer.WriteString(strconv.Itoa(num))
			tempBuffer.WriteString(\"->\")
			tempBuffer.WriteString(strconv.Itoa(nums[i]))
			res = append(res, tempBuffer.String())
		} else {
			res = append(res, strconv.Itoa(num))
		}
	}
	return res
}

func main() {
	// Test array
	nums := []int{0, 1, 2, 4, 5, 7}
	fmt.Println(\"Input array:\", nums)

	// Call summaryRanges function
	result := summaryRanges(nums)

	// Display the result
	fmt.Println(\"Summary of ranges:\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SummaryRanges
    set output_file "summary_ranges.go"

    set template_content "package main

import (
	\"bytes\"
	\"fmt\"
	\"strconv\"
)

func summaryRanges(nums []int) []string {
	res := []string{}
	if len(nums) == 1 {
		res = append(res, strconv.Itoa(nums[0]))
		return res
	}
	for i := 0; i < len(nums); i++ {
		num := nums[i]
		for i+1 < len(nums) && nums[i+1]-nums[i] == 1 {
			i += 1
		}
		if nums[i] != num {
			var tempBuffer bytes.Buffer
			tempBuffer.WriteString(strconv.Itoa(num))
			tempBuffer.WriteString(\"->\")
			tempBuffer.WriteString(strconv.Itoa(nums[i]))
			res = append(res, tempBuffer.String())
		} else {
			res = append(res, strconv.Itoa(num))
		}
	}
	return res
}

func main() {
	// Test array
	nums := []int{0, 1, 2, 4, 5, 7}
	fmt.Println(\"Input array:\", nums)

	// Call summaryRanges function
	result := summaryRanges(nums)

	// Display the result
	fmt.Println(\"Summary of ranges:\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ThreeSum
    set output_file "three_sum.go"

    set template_content "package main

import (
    \"fmt\"
    \"sort\"
)

// threeSum finds all unique triplets in the array which give the sum of zero.
func threeSum(nums []int) [][]int {
    res := [][]int{}
    sort.Ints(nums)
    for i := 0; i < len(nums)-2; i++ {
        if i > 0 && nums[i] == nums[i-1] {
            continue
        }
        l, r := i+1, len(nums)-1
        for l < r {
            s := nums[i] + nums[l] + nums[r]
            if s > 0 {
                r -= 1
            } else if s < 0 {
                l += 1
            } else {
                res = append(res, []int{nums[i], nums[l], nums[r]})
                for l < r && nums[l] == nums[l+1] {
                    l += 1
                }
                for l < r && nums[r] == nums[r-1] {
                    r -= 1
                }
                l += 1
                r -= 1
            }
        }
    }
    return res
}

func main() {
    // Test array
    nums := []int{-1, 0, 1, 2, -1, -4}
    fmt.Println(\"Input array:\", nums)

    // Call threeSum function
    result := threeSum(nums)

    // Display the result
    fmt.Println(\"Unique triplets that sum to zero:\", result)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.TwoDimensionalArray
    set output_file "two_dimensional_array.go"

    set template_content "package main

import (
	\"fmt\"
	\"math/rand\"
	//\"time\"
)

func CreateTwoDimensionalArray(rows, columns, randomRange int) [][]int {
	arr := [][]int{}
	// code
	for i := 0; i < rows; i++ {
		a := []int{}
		for j := 0; j < columns; j++ {
			// create random number
			k := rand.Intn(randomRange)
			// add elements to the nested array
			a = append(a, k)
		}
		// add array into arr array
		arr = append(arr, a)
	}
	return arr
}

func CreateArray(n, randomRange int) []int {
	//	rand.Seed(time.Now().UnixNano())
	arr := []int{}
	for i := 0; i < n; i++ {
		k := rand.Intn(randomRange)
		arr = append(arr, k)
	}
	return arr
}

func main() {
	arr := CreateTwoDimensionalArray(3, 4, 20)
	for _, v := range arr {
		fmt.Println(v)
	}
}
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.StudentsAvg
    set output_file "students_avg.go"

    set template_content "package main

import (
	\"fmt\"
)

func main() {
	// ------------------------------------
	// #1 - THE BEST WAY
	// ------------------------------------

	students := [...][3]float64{
		{5, 6, 1},
		{9, 8, 4},
	}

	var sum float64

	for _, grades := range students {
		for _, grade := range grades {
			sum += grade
		}
	}

	const N = float64(len(students) * len(students[0]))
	fmt.Printf(\"Avg Grade: %g\\n\", sum/N)

	main1()
	main2()
}

func main1() {
	// ------------------------------------
	// #2 - SO SO WAY
	// ------------------------------------
	students1 := [2][3]float64{
		{5, 6, 1},
		{9, 8, 4},
	}

	var sum1 float64

	sum1 += students1[0][0] + students1[0][1] + students1[0][2]
	sum1 += students1[1][0] + students1[1][1] + students1[1][2]

	const D = float64(len(students1) * len(students1[0]))
	fmt.Printf(\"Avg Grade: %g\\n\", sum1/D)
}

func main2() {
	// ------------------------------------
	// #3 - MANUAL WAY
	// ------------------------------------
	student1 := [3]float64{5, 6, 1}
	student2 := [3]float64{9, 8, 4}

	var sum float64
	sum += student1[0] + student1[1] + student1[2]
	sum += student2[0] + student2[1] + student2[2]

	const N = float64(len(student1) * 2)
	fmt.Printf(\"Avg Grade: %g\\n\", sum/N)
}
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TwoSum
    set output_file "two_sum.go"

    set template_content "package main

import (
	\"fmt\"
)

// twoSum function finds two indices of nums that add up to the target.
func twoSum(nums []int, target int) []int {
	dic := make(map[int]int) // map to store the needed difference for each number
	for index, num := range nums {
		if i, ok := dic[num]; ok { // check if num is in map
			return []int{i, index} // return indices if target pair is found
		}
		dic[target-num] = index // store the difference and current index
	}
	return []int{} // return empty if no solution found
}

func main() {
	// Example input
	nums := []int{2, 7, 11, 15}
	target := 9

	// Call twoSum and print result
	result := twoSum(nums, target)
	if len(result) > 0 {
		fmt.Printf(\"Indices: %d and %d\\n\", result[0], result[1])
	} else {
		fmt.Println(\"No two numbers add up to the target.\")
	}
}

//Indices: 0 and 1
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindRows
    set output_file "find_rows.go"

    set template_content "package main

import \"fmt\"

func main() {
	arr := [][]int{
		{5, 5, 2, 2},
		{4, 5, 5, 5},
		{5, 1, 23, 4},
		{5, 5, 5, 5},
	}
	for i, v := range arr {
		count := 0
		for _, k := range v {
			if k == 5 {
				count += 1
			}
		}
		if count >= 3 {
			fmt.Println(i)
		}
	}
	main1()
}

func findRowsWithValue(arr [][]int, val int, countThreshold int) []int {
	var result []int

	for i, row := range arr {
		count := 0
		for _, num := range row {
			if num == val {
				count++
			}
		}
		if count >= countThreshold {
			result = append(result, i)
		}
	}

	return result
}

func main1() {
	arr := [][]int{
		{5, 5, 2, 2},
		{4, 5, 5, 5},
		{5, 1, 23, 4},
		{5, 5, 5, 5},
	}

	indices := findRowsWithValue(arr, 5, 3)
	fmt.Println(indices) // [1 3]
}
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindRows
    set output_file "find_rows.go"

    set template_content "package main

import \"fmt\"

func main() {
	arr := [][]int{
		{5, 5, 2, 2},
		{4, 5, 5, 5},
		{5, 1, 23, 4},
		{5, 5, 5, 5},
	}
	for i, v := range arr {
		count := 0
		for _, k := range v {
			if k == 5 {
				count += 1
			}
		}
		if count >= 3 {
			fmt.Println(i)
		}
	}
	main1()
}

func findRowsWithValue(arr [][]int, val int, countThreshold int) []int {
	var result []int

	for i, row := range arr {
		count := 0
		for _, num := range row {
			if num == val {
				count++
			}
		}
		if count >= countThreshold {
			result = append(result, i)
		}
	}

	return result
}

func main1() {
	arr := [][]int{
		{5, 5, 2, 2},
		{4, 5, 5, 5},
		{5, 1, 23, 4},
		{5, 5, 5, 5},
	}

	indices := findRowsWithValue(arr, 5, 3)
	fmt.Println(indices) // [1 3]
}
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MultiSlice
    set output_file "multi_slice.go"

    set template_content "package main

import \"fmt\"

func main() {
    arr1 := []int{1, 2, 3, 4}
    fmt.Println(arr1[1])
    arr2 := [][]int{
        {1, 2, 3, 4},
        {4, 5, 6, 7},
    }

    fmt.Println(arr2[0][1])
    main1()
}

func main1() {
    arr := [][]int{
        {1, 2, 3, 4},
        {4, 5, 6, 7},
    }

    arr = append(arr, []int{8, 9, 10, 11})
    fmt.Println(arr)
    arr[1][2] = 99
    fmt.Println(arr)
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.SortColumns
    set output_file "sort_columns.go"

    set template_content "package main

import \"fmt\"

func main() {
    arr := [][]int{
        {3, -2, 6, 4},
        {8, 1, 12, 2},
        {5, 4, -8, 0},
    }
    newArr := [][]int{}
    n := len(arr)
    m := len(arr[0])
    for i := 0; i < m; i++ {
        tempArr := []int{}
        for j := 0; j < n; j++ {
            tempArr = append(tempArr, arr[j][i])
        }
        newArr = append(newArr, tempArr)
    }
    n = len(newArr)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if newArr[i][0] < newArr[j][0] {
                temp := newArr[i]
                newArr[i] = newArr[j]
                newArr[j] = temp
            }
        }
    }
    m = len(newArr[0])
    result := [][]int{}
    for i := 0; i < m; i++ {
        tempArr := []int{}
        for j := 0; j < n; j++ {
            tempArr = append(tempArr, newArr[j][i])
        }
        result = append(result, tempArr)
    }
    fmt.Println(result)
}
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function go.sum_verbose
    set output_file "sum_verbose.go"

    set template_content 'package main

import (
	"fmt"
)

// sum the number verbose
func main() {
	const min, max = 1, 10

	var sum int
	for i := min; i <= max; i++ {
		sum += i

		fmt.Print(i)
		if i < max {
			fmt.Print(" + ")
		}
	}
	fmt.Printf(" = %d\n", sum)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function go.inventory
    set output_file "inventory.go"

    set template_content 'package main

import (
	"fmt"
)

func displayInventory(inventory map[string]int) {
	fmt.Println("Inventory:")
	itemTotal := 0

	// Loop through the inventory items
	for k, v := range inventory {
		fmt.Printf("%d %s\n", v, k)
		itemTotal += v
	}

	// Display total number of items
	fmt.Println("Total number of items:", itemTotal)
}

func main() {
	// Inventory items
	stuff := map[string]int{
		"rope":      1,
		"torch":     6,
		"gold coin": 42,
		"dagger":    1,
		"arrow":     12,
	}

	// Call displayInventory function to show the inventory
	displayInventory(stuff)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function go.inventory
    set output_file "inventory.go"

    set template_content 'package main

import (
	"fmt"
)

func displayInventory(inventory map[string]int) {
	fmt.Println("Inventory:")
	itemTotal := 0

	// Loop through the inventory items
	for k, v := range inventory {
		fmt.Printf("%d %s\n", v, k)
		itemTotal += v
	}

	// Display total number of items
	fmt.Println("Total number of items:", itemTotal)
}

func main() {
	// Inventory items
	stuff := map[string]int{
		"rope":      1,
		"torch":     6,
		"gold coin": 42,
		"dagger":    1,
		"arrow":     12,
	}

	// Call displayInventory function to show the inventory
	displayInventory(stuff)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.add_numbers
    set output_file "add_numbers.go"

    set template_content 'package main

import "fmt"

func addNumbers(max, step int) []int {
    i := 0
    var numbers []int

    for i < max {
        fmt.Printf("At the top i is %d\n", i)
        numbers = append(numbers, i)

        i = i + step
        fmt.Printf("Numbers now: %v\n", numbers)
        fmt.Printf("At the bottom i is %d\n", i)
    }

    return numbers
}

func main() {
    numbers := addNumbers(10, 5)

    fmt.Println("The numbers: ")
    for _, num := range numbers {
        fmt.Println(num)
    }
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.investigation
    set output_file "investigation.go"

    set template_content 'package main

import (
    "fmt"
    "strings"
)

func main() {
    // Define the map with people'\''s names and their favorite languages
    favoriteLanguages := map[string]string{
        "jen":    "python",
        "sarah":  "c",
        "edward": "ruby",
        "phil":   "python",
        "jack":   "c",
    }

    // Define the slice of investigated people
    investigatedPeople := []string{"jen", "jack"}

    // Convert the slice to a map for O(1) lookup time
    investigatedMap := make(map[string]bool)
    for _, name := range investigatedPeople {
        investigatedMap[name] = true
    }

    // Iterate through the map and print the appropriate messages
    for name := range favoriteLanguages {
        fmt.Printf("Hi %s\n", strings.Title(name))
        if _, found := investigatedMap[name]; found {
            fmt.Println("Thanks for your investigation!")
        } else {
            fmt.Println("Would you take part in our investigation?")
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

function algoG.UniquePaths.Recursion
    set output_file "unique_paths.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == m-1 && j == n-1 {
            return 1
        }
        if i >= m || j >= n {
            return 0
        }
        return dfs(i, j+1) + dfs(i+1, j)
    }

    return dfs(0, 0)
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.UniquePaths.DynamicProgramming_Top-Down
    set output_file "unique_paths.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    memo := make([][]int, m)
    for i := range memo {
        memo[i] = make([]int, n)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == m-1 && j == n-1 {
            return 1
        }
        if i >= m || j >= n {
            return 0
        }
        if memo[i][j] != -1 {
            return memo[i][j]
        }

        memo[i][j] = dfs(i, j+1) + dfs(i+1, j)
        return memo[i][j]
    }

    return dfs(0, 0)
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.UniquePaths.DynamicProgramming_Bottom-Up
    set output_file "unique_paths_dp.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }
    dp[m-1][n-1] = 1

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            dp[i][j] += dp[i+1][j] + dp[i][j+1]
        }
    }

    return dp[0][0]
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.UniquePaths.DynamicProgramming_SpaceOptimized
    set output_file "unique_paths_1d.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    row := make([]int, n)
    for i := range row {
        row[i] = 1
    }

    for i := 0; i < m-1; i++ {
        newRow := make([]int, n)
        newRow[n-1] = 1
        for j := n - 2; j >= 0; j-- {
            newRow[j] = newRow[j+1] + row[j]
        }
        row = newRow
    }

    return row[0]
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.UniquePaths.DynamicProgramming_Optimal
    set output_file "unique_paths_1d_opt.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    dp := make([]int, n)
    for i := range dp {
        dp[i] = 1
    }

    for i := m - 2; i >= 0; i-- {
        for j := n - 2; j >= 0; j-- {
            dp[j] += dp[j+1]
        }
    }

    return dp[0]
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.UniquePaths.Math
    set output_file "unique_paths_comb.go"

    set template_content 'package main

import "fmt"

func uniquePaths(m int, n int) int {
    if m == 1 || n == 1 {
        return 1
    }
    if m < n {
        m, n = n, m
    }

    res, j := 1, 1
    for i := m; i < m+n-1; i++ {
        res *= i
        res /= j
        j++
    }

    return res
}

func main() {
    fmt.Println(uniquePaths(3, 7))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestCommonSubsequence.Recursion
    set output_file "longest_common_subsequence.go"

    set template_content "package main

import \"fmt\"

func longestCommonSubsequence(text1 string, text2 string) int {
    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == len(text1) || j == len(text2) {
            return 0
        }
        if text1[i] == text2[j] {
            return 1 + dfs(i+1, j+1)
        }
        return max(dfs(i+1, j), dfs(i, j+1))
    }
    return dfs(0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    text1 := \"abcde\"
    text2 := \"ace\"
    fmt.Println(longestCommonSubsequence(text1, text2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestCommonSubsequence.DynamicProgramming_Top-Down
    set output_file "longest_common_subsequence_memo.go"

    set template_content "package main

import \"fmt\"

func longestCommonSubsequence(text1 string, text2 string) int {
    m, n := len(text1), len(text2)
    memo := make([][]int, m+1)
    for i := range memo {
        memo[i] = make([]int, n+1)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == m || j == n {
            return 0
        }
        if memo[i][j] != -1 {
            return memo[i][j]
        }

        if text1[i] == text2[j] {
            memo[i][j] = 1 + dfs(i+1, j+1)
        } else {
            memo[i][j] = max(dfs(i+1, j), dfs(i, j+1))
        }

        return memo[i][j]
    }

    return dfs(0, 0)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    text1 := \"abcde\"
    text2 := \"ace\"
    fmt.Println(longestCommonSubsequence(text1, text2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.LongestCommonSubsequence.DynamicProgramming_Bottom-Up1
    set output_file "longest_common_subsequence_dp.go"

    set template_content "package main

import \"fmt\"

func longestCommonSubsequence(text1 string, text2 string) int {
    m, n := len(text1), len(text2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if text1[i] == text2[j] {
                dp[i][j] = 1 + dp[i+1][j+1]
            } else {
                dp[i][j] = max(dp[i+1][j], dp[i][j+1])
            }
        }
    }

    return dp[0][0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    text1 := \"abcde\"
    text2 := \"ace\"
    fmt.Println(longestCommonSubsequence(text1, text2)) // Output: 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestCommonSubsequence.DynamicProgramming_Bottom-Up

    set output_file "lcs.go"

    set template_content 'package main

import "fmt"

func longestCommonSubsequence(text1 string, text2 string) int {
    if len(text1) < len(text2) {
        text1, text2 = text2, text1
    }

    prev := make([]int, len(text2)+1)
    curr := make([]int, len(text2)+1)

    for i := len(text1) - 1; i >= 0; i-- {
        for j := len(text2) - 1; j >= 0; j-- {
            if text1[i] == text2[j] {
                curr[j] = 1 + prev[j+1]
            } else {
                curr[j] = max(curr[j+1], prev[j])
            }
        }
        prev, curr = curr, prev
    }

    return prev[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(longestCommonSubsequence("abcde", "ace"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestCommonSubsequence.DynamicProgramming_SpaceOptimized
    set output_file "lcs.go"

    set template_content 'package main

import "fmt"

func longestCommonSubsequence(text1 string, text2 string) int {
    if len(text1) < len(text2) {
        text1, text2 = text2, text1
    }

    prev := make([]int, len(text2)+1)
    curr := make([]int, len(text2)+1)

    for i := len(text1) - 1; i >= 0; i-- {
        for j := len(text2) - 1; j >= 0; j-- {
            if text1[i] == text2[j] {
                curr[j] = 1 + prev[j+1]
            } else {
                curr[j] = max(curr[j+1], prev[j])
            }
        }
        prev, curr = curr, prev
    }

    return prev[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(longestCommonSubsequence("abcde", "ace"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.LongestCommonSubsequence.DeynamicProgramming_Optimal
    set output_file "lcs_optimized.go"

    set template_content 'package main

import "fmt"

func longestCommonSubsequence(text1 string, text2 string) int {
    if len(text1) < len(text2) {
        text1, text2 = text2, text1
    }

    dp := make([]int, len(text2)+1)

    for i := len(text1) - 1; i >= 0; i-- {
        prev := 0
        for j := len(text2) - 1; j >= 0; j-- {
            temp := dp[j]
            if text1[i] == text2[j] {
                dp[j] = 1 + prev
            } else {
                dp[j] = max(dp[j], dp[j+1])
            }
            prev = temp
        }
    }

    return dp[0]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(longestCommonSubsequence("abcde", "ace"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BestTimetoBuyandSellStockwithCooldown.Recursion
    set output_file "stock_cooldown.go"

    set template_content 'package main

import "fmt"

func maxProfit(prices []int) int {
    var dfs func(i int, buying bool) int
    dfs = func(i int, buying bool) int {
        if i >= len(prices) {
            return 0
        }

        cooldown := dfs(i + 1, buying)
        if buying {
            buy := dfs(i + 1, false) - prices[i]
            return max(buy, cooldown)
        } else {
            sell := dfs(i + 2, true) + prices[i]
            return max(sell, cooldown)
        }
    }

    return dfs(0, true)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(maxProfit([]int{1,2,3,0,2}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.BestTimetoBuyandSellStockwithCooldown.DynamicProgramming_Top-Down
    set output_file "stock_cooldown_memo.go"

    set template_content 'package main

import "fmt"

func maxProfit(prices []int) int {
    dp := make(map[[2]int]int) // key is [i, buying], value is max profit

    var dfs func(i int, buying bool) int
    dfs = func(i int, buying bool) int {
        if i >= len(prices) {
            return 0
        }

        key := [2]int{i, boolToInt(buying)}
        if val, found := dp[key]; found {
            return val
        }

        cooldown := dfs(i + 1, buying)
        if buying {
            buy := dfs(i + 1, false) - prices[i]
            dp[key] = max(buy, cooldown)
        } else {
            sell := dfs(i + 2, true) + prices[i]
            dp[key] = max(sell, cooldown)
        }

        return dp[key]
    }

    return dfs(0, true)
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(maxProfit([]int{1,2,3,0,2}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BestTimetoBuyandSellStockwithCooldown.DynamicProgramming_Bottom-Up
    set output_file "stock_cooldown_dp.go"

    set template_content 'package main

import "fmt"

func maxProfit(prices []int) int {
    n := len(prices)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, 2)
    }

    for i := n - 1; i >= 0; i-- {
        for buying := 1; buying >= 0; buying-- {
            if buying == 1 {
                buy := dp[i+1][0] - prices[i]
                cooldown := dp[i+1][1]
                dp[i][1] = max(buy, cooldown)
            } else {
                sell := prices[i]
                if i+2 < n {
                    sell += dp[i+2][1]
                }
                cooldown := dp[i+1][0]
                dp[i][0] = max(sell, cooldown)
            }
        }
    }

    return dp[0][1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    fmt.Println(maxProfit([]int{1, 2, 3, 0, 2}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BestTimetoBuyandSellStockwithCooldown.DynamicProgramming_SpaceOptimized
    set output_file "stock_cooldown.go"

    set template_content 'package main

import "fmt"

func maxProfit(prices []int) int {
    n := len(prices)
    dp1_buy, dp1_sell := 0, 0
    dp2_buy := 0

    for i := n - 1; i >= 0; i-- {
        dp_buy := max(dp1_sell - prices[i], dp1_buy)
        dp_sell := max(dp2_buy + prices[i], dp1_sell)
        dp2_buy, dp1_sell = dp1_buy, dp_sell
        dp1_buy = dp_buy
    }

    return dp1_buy
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func main() {
    prices := []int{1, 2, 3, 0, 2}
    fmt.Println(maxProfit(prices))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChangeII.Recursion
    set output_file "coin_change_recursive.go"

    set template_content 'package main

import (
    "fmt"
    "sort"
)

func change(amount int, coins []int) int {
    sort.Ints(coins)

    var dfs func(i, a int) int
    dfs = func(i, a int) int {
        if a == 0 {
            return 1
        }
        if i >= len(coins) {
            return 0
        }

        res := 0
        if a >= coins[i] {
            res = dfs(i+1, a)
            res += dfs(i, a-coins[i])
        }
        return res
    }

    return dfs(0, amount)
}

func main() {
    fmt.Println(change(5, []int{1, 2, 5}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChangeII.DynamicProgramming_Top-Down
    set output_file "coin_change_memo.go"

    set template_content 'package main

import (
    "fmt"
    "sort"
)

func change(amount int, coins []int) int {
    sort.Ints(coins)
    memo := make([][]int, len(coins)+1)
    for i := range memo {
        memo[i] = make([]int, amount+1)
        for j := range memo[i] {
            memo[i][j] = -1
        }
    }

    var dfs func(i, a int) int
    dfs = func(i, a int) int {
        if a == 0 {
            return 1
        }
        if i >= len(coins) {
            return 0
        }
        if memo[i][a] != -1 {
            return memo[i][a]
        }

        res := 0
        if a >= coins[i] {
            res = dfs(i+1, a)
            res += dfs(i, a-coins[i])
        }
        memo[i][a] = res
        return res
    }

    return dfs(0, amount)
}

func main() {
    fmt.Println(change(5, []int{1, 2, 5}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChangeII.DynamicProgramming_Bottom-Up
    set output_file "coin_change_tab.go"

    set template_content 'package main

import "fmt"

func change(amount int, coins []int) int {
    n := len(coins)
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, amount+1)
    }

    for i := 0; i <= n; i++ {
        dp[i][0] = 1
    }

    for i := n - 1; i >= 0; i-- {
        for a := 0; a <= amount; a++ {
            if a >= coins[i] {
                dp[i][a] = dp[i+1][a]
                dp[i][a] += dp[i][a-coins[i]]
            } else {
                dp[i][a] = dp[i+1][a]
            }
        }
    }

    return dp[0][amount]
}

func main() {
    fmt.Println(change(5, []int{1, 2, 5}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChangeII.DynamicProgramming_SpaceOptimized
    set output_file "coin_change_1d_copy.go"

    set template_content 'package main

import "fmt"

func change(amount int, coins []int) int {
    dp := make([]int, amount+1)
    dp[0] = 1

    for i := len(coins) - 1; i >= 0; i-- {
        nextDP := make([]int, amount+1)
        nextDP[0] = 1

        for a := 1; a <= amount; a++ {
            nextDP[a] = dp[a]
            if a-coins[i] >= 0 {
                nextDP[a] += nextDP[a-coins[i]]
            }
        }
        dp = nextDP
    }

    return dp[amount]
}

func main() {
    fmt.Println(change(5, []int{1, 2, 5}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CoinChangeII.DynamicProgramming_Optimal
    set output_file "coin_change_1d.go"

    set content 'package main

import "fmt"

func change(amount int, coins []int) int {
    dp := make([]int, amount+1)
    dp[0] = 1

    for i := len(coins) - 1; i >= 0; i-- {
        for a := 1; a <= amount; a++ {
            if a-coins[i] >= 0 {
                dp[a] += dp[a - coins[i]]
            }
        }
    }

    return dp[amount]
}

func main() {
    fmt.Println(change(5, []int{1, 2, 5}))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TargetSum.Recursion
    set output_file "target_sum_backtrack.go"

    set template_content 'package main

import "fmt"

func findTargetSumWays(nums []int, target int) int {
    var backtrack func(i int, total int) int
    backtrack = func(i int, total int) int {
        if i == len(nums) {
            if total == target {
                return 1
            }
            return 0
        }
        return backtrack(i+1, total+nums[i]) + backtrack(i+1, total-nums[i])
    }

    return backtrack(0, 0)
}

func main() {
    fmt.Println(findTargetSumWays([]int{1,1,1,1,1}, 3))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TargetSum.DynamicProgramming_Top-Down
    set output_file "target_sum_memo.go"

    set template_content 'package main

import (
    "fmt"
    "math"
)

func findTargetSumWays(nums []int, target int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    dp := make([][]int, len(nums))
    for i := range dp {
        dp[i] = make([]int, 2*totalSum+1)
        for j := range dp[i] {
            dp[i][j] = math.MinInt32
        }
    }

    var backtrack func(i, total int) int
    backtrack = func(i, total int) int {
        if i == len(nums) {
            if total == target {
                return 1
            }
            return 0
        }

        if dp[i][total+totalSum] != math.MinInt32 {
            return dp[i][total+totalSum]
        }

        dp[i][total+totalSum] =
            backtrack(i+1, total+nums[i]) +
            backtrack(i+1, total-nums[i])

        return dp[i][total+totalSum]
    }

    return backtrack(0, 0)
}

func main() {
    fmt.Println(findTargetSumWays([]int{1,1,1,1,1}, 3))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TargetSum.DynamicProgramming_Bottom-Up
    set output_file "target_sum_mapdp.go"

    set template_content 'package main

import "fmt"

func findTargetSumWays(nums []int, target int) int {
    n := len(nums)
    dp := make([]map[int]int, n+1)

    for i := 0; i <= n; i++ {
        dp[i] = make(map[int]int)
    }

    dp[0][0] = 1

    for i := 0; i < n; i++ {
        for total, count := range dp[i] {
            dp[i+1][total+nums[i]] += count
            dp[i+1][total-nums[i]] += count
        }
    }

    return dp[n][target]
}

func main() {
    fmt.Println(findTargetSumWays([]int{1,1,1,1,1}, 3))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.TargetSum.DynamicProgramming_SpaceOptimized
    set output_file "target_sum_1d.go"

    set template_content 'package main

import "fmt"

func findTargetSumWays(nums []int, target int) int {
    dp := make(map[int]int)
    dp[0] = 1

    for _, num := range nums {
        nextDp := make(map[int]int)
        for total, count := range dp {
            nextDp[total+num] += count
            nextDp[total-num] += count
        }
        dp = nextDp
    }

    return dp[target]
}

func main() {
    fmt.Println(findTargetSumWays([]int{1,1,1,1,1}, 3))
}
'

    echo "$content" > $output_file
    echo "File written: $output_file"
end


function algoG.InterleavingString.Recursion
    set output_file "is_interleave_recursive.go"

    set template_content 'package main

import "fmt"

func isInterleave(s1, s2, s3 string) bool {
    var dfs func(i, j, k int) bool
    dfs = func(i, j, k int) bool {
        if k == len(s3) {
            return i == len(s1) && j == len(s2)
        }

        if i < len(s1) && s1[i] == s3[k] {
            if dfs(i+1, j, k+1) {
                return true
            }
        }

        if j < len(s2) && s2[j] == s3[k] {
            if dfs(i, j+1, k+1) {
                return true
            }
        }

        return false
    }

    return dfs(0, 0, 0)
}

func main() {
    fmt.Println(isInterleave("aab", "axy", "aaxaby"))
    fmt.Println(isInterleave("aab", "axy", "abaaxy"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InterleavingString.DynamicProgramming_Top-Down

    set output_file "is_interleave_memo.go"

    set template_content 'package main

import "fmt"

func isInterleave(s1, s2, s3 string) bool {
    if len(s1)+len(s2) != len(s3) {
        return false
    }

    m, n := len(s1), len(s2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(i, j, k int) bool
    dfs = func(i, j, k int) bool {
        if k == len(s3) {
            return i == len(s1) && j == len(s2)
        }

        if dp[i][j] != -1 {
            return dp[i][j] == 1
        }

        res := false
        if i < len(s1) && s1[i] == s3[k] {
            res = dfs(i+1, j, k+1)
        }
        if !res && j < len(s2) && s2[j] == s3[k] {
            res = dfs(i, j+1, k+1)
        }

        if res {
            dp[i][j] = 1
        } else {
            dp[i][j] = 0
        }

        return res
    }

    return dfs(0, 0, 0)
}

func main() {
    fmt.Println(isInterleave("aab", "axy", "aaxaby"))
    fmt.Println(isInterleave("aab", "axy", "abaaxy"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InterleavingString.DynamicProgramming_Bottom-Up
    set output_file "is_interleave_dp.go"

    set template_content 'package main

import "fmt"

func isInterleave(s1 string, s2 string, s3 string) bool {
    if len(s1) + len(s2) != len(s3) {
        return false
    }

    dp := make([][]bool, len(s1)+1)
    for i := range dp {
        dp[i] = make([]bool, len(s2)+1)
    }
    dp[len(s1)][len(s2)] = true

    for i := len(s1); i >= 0; i-- {
        for j := len(s2); j >= 0; j-- {
            if i < len(s1) && s1[i] == s3[i+j] && dp[i+1][j] {
                dp[i][j] = true
            }
            if j < len(s2) && s2[j] == s3[i+j] && dp[i][j+1] {
                dp[i][j] = true
            }
        }
    }

    return dp[0][0]
}

func main() {
    fmt.Println(isInterleave("aab", "axy", "aaxaby"))
    fmt.Println(isInterleave("aab", "axy", "abaaxy"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.InterleavingString.DynamicProgramming_SpaceOptimized
    set output_file "is_interleave_dp_1d.go"

    set template_content 'package main

import "fmt"

func isInterleave(s1 string, s2 string, s3 string) bool {
    m, n := len(s1), len(s2)
    if m + n != len(s3) {
        return false
    }
    if n < m {
        s1, s2 = s2, s1
        m, n = n, m
    }

    dp := make([]bool, n+1)
    dp[n] = true

    for i := m; i >= 0; i-- {
        nextDp := make([]bool, n+1)
        if i == m {
            nextDp[n] = true
        }
        for j := n; j >= 0; j-- {
            if i < m && s1[i] == s3[i+j] && dp[j] {
                nextDp[j] = true
            }
            if j < n && s2[j] == s3[i+j] && nextDp[j+1] {
                nextDp[j] = true
            }
        }
        dp = nextDp
    }

    return dp[0]
}

func main() {
    fmt.Println(isInterleave("aab", "axy", "aaxaby"))
    fmt.Println(isInterleave("aab", "axy", "abaaxy"))
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.InterleavingString.DynamicProgramming_Optimal
    set output_file "is_interleave.go"

    set template_content 'package main

import "fmt"

func isInterleave(s1, s2, s3 string) bool {
    m, n := len(s1), len(s2)
    if m+n != len(s3) {
        return false
    }
    if n < m {
        s1, s2 = s2, s1
        m, n = n, m
    }

    dp := make([]bool, n+1)
    dp[n] = true
    for i := m; i >= 0; i-- {
        nextDp := (i == m)
        for j := n; j >= 0; j-- {
            res := nextDp
            if j < n {
                res = false
            }
            if i < m && s1[i] == s3[i+j] && dp[j] {
                res = true
            }
            if j < n && s2[j] == s3[i+j] && nextDp {
                res = true
            }
            dp[j] = res
            nextDp = dp[j]
        }
    }
    return dp[0]
}

func main() {
    fmt.Println(isInterleave("aabcc", "dbbca", "aadbbcbcac")) // true
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EditDistance.Recursion
    set output_file "min_distance.go"

    set template_content 'package main

import "fmt"

func minDistance(word1 string, word2 string) int {
    m, n := len(word1), len(word2)

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == m {
            return n - j
        }
        if j == n {
            return m - i
        }
        if word1[i] == word2[j] {
            return dfs(i+1, j+1)
        }
        res := min(dfs(i+1, j), dfs(i, j+1))
        res = min(res, dfs(i+1, j+1))
        return res + 1
    }

    return dfs(0, 0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    fmt.Println(minDistance("horse", "ros")) // Output: 3
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EditDistance.DynamicProgramming_Top-Down

    set output_file "min_distance.go"

    set template_content 'package main

import "fmt"

func minDistance(word1 string, word2 string) int {
    m, n := len(word1), len(word2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
        for j := range dp[i] {
            dp[i][j] = -1
        }
    }

    var dfs func(i, j int) int
    dfs = func(i, j int) int {
        if i == m {
            return n - j
        }
        if j == n {
            return m - i
        }
        if dp[i][j] != -1 {
            return dp[i][j]
        }

        if word1[i] == word2[j] {
            dp[i][j] = dfs(i+1, j+1)
        } else {
            insert := dfs(i, j+1)
            delete := dfs(i+1, j)
            replace := dfs(i+1, j+1)
            dp[i][j] = 1 + min(insert, min(delete, replace))
        }
        return dp[i][j]
    }

    return dfs(0, 0)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    fmt.Println(minDistance("horse", "ros")) // Output: 3
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EditDistance.DynamicProgramming_Bottom-Up
    set output_file "min_distance.go"

    set template_content 'package main

import "fmt"

func minDistance(word1, word2 string) int {
    m, n := len(word1), len(word2)
    dp := make([][]int, m+1)
    for i := range dp {
        dp[i] = make([]int, n+1)
    }

    for j := 0; j <= n; j++ {
        dp[m][j] = n - j
    }
    for i := 0; i <= m; i++ {
        dp[i][n] = m - i
    }

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            if word1[i] == word2[j] {
                dp[i][j] = dp[i+1][j+1]
            } else {
                dp[i][j] = 1 + min(dp[i+1][j],
                                   min(dp[i][j+1], dp[i+1][j+1]))
            }
        }
    }

    return dp[0][0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    fmt.Println(minDistance("horse", "ros")) // Output: 3
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EditDistance.DynamicProgramming_SpaceOptimized
    set output_file "min_distance_optimized.go"

    set template_content 'package main

import "fmt"

func minDistance(word1, word2 string) int {
    m, n := len(word1), len(word2)
    if m < n {
        word1, word2 = word2, word1
        m, n = n, m
    }

    dp := make([]int, n+1)
    nextDp := make([]int, n+1)

    for j := 0; j <= n; j++ {
        dp[j] = n - j
    }

    for i := m - 1; i >= 0; i-- {
        nextDp[n] = m - i
        for j := n - 1; j >= 0; j-- {
            if word1[i] == word2[j] {
                nextDp[j] = dp[j+1]
            } else {
                nextDp[j] = 1 + min(dp[j],
                                    min(nextDp[j+1], dp[j+1]))
            }
        }
        dp, nextDp = nextDp, dp
    }

    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    fmt.Println(minDistance("horse", "ros")) // Output: 3
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.EditDistance.DynamicProgramming_Optimal
    set output_file "min_distance_rolling.go"

    set template_content 'package main

import "fmt"

func minDistance(word1, word2 string) int {
    m, n := len(word1), len(word2)
    if m < n {
        word1, word2 = word2, word1
        m, n = n, m
    }

    dp := make([]int, n+1)
    for j := 0; j <= n; j++ {
        dp[j] = n - j
    }

    for i := m - 1; i >= 0; i-- {
        nextDp := dp[n]
        dp[n] = m - i
        for j := n - 1; j >= 0; j-- {
            temp := dp[j]
            if word1[i] == word2[j] {
                dp[j] = nextDp
            } else {
                dp[j] = 1 + min(dp[j],
                                min(dp[j+1], nextDp))
            }
            nextDp = temp
        }
    }

    return dp[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func main() {
    fmt.Println(minDistance("horse", "ros")) // Output: 3
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DesignDynamicArray
    set output_file "dynamic_array.go"

    set template_content 'package main

import "fmt"

// DynamicArray implementation
// Note: Go slices are dynamic arrays by default,
// but this is an example of what is going on under the hood.
type DynamicArray struct {
	capacity int
	length   int
	arr      []int
}

// NewDynamicArray creates a new dynamic array with given capacity
func NewDynamicArray(capacity int) *DynamicArray {
	return &DynamicArray{
		capacity: capacity,
		length:   0,
		arr:      make([]int, capacity),
	}
}

// Get value at i-th index
func (da *DynamicArray) Get(i int) int {
	return da.arr[i]
}

// Set n at i-th index
func (da *DynamicArray) Set(i int, n int) {
	da.arr[i] = n
}

// Pushback inserts n in the last position of the array
func (da *DynamicArray) Pushback(n int) {
	if da.length == da.capacity {
		da.resize()
	}
	da.arr[da.length] = n
	da.length++
}

// Popback removes the last element in the array
func (da *DynamicArray) Popback() int {
	if da.length > 0 {
		da.length--
	}
	return da.arr[da.length]
}

func (da *DynamicArray) resize() {
	da.capacity = 2 * da.capacity
	newArr := make([]int, da.capacity)
	for i := 0; i < da.length; i++ {
		newArr[i] = da.arr[i]
	}
	da.arr = newArr
}

func (da *DynamicArray) GetSize() int {
	return da.length
}

func (da *DynamicArray) GetCapacity() int {
	return da.capacity
}

func main() {
	da := NewDynamicArray(2)
	da.Pushback(10)
	da.Pushback(20)
	fmt.Println("Size:", da.GetSize(), "Capacity:", da.GetCapacity())
	da.Pushback(30)
	fmt.Println("Size:", da.GetSize(), "Capacity:", da.GetCapacity())
	fmt.Println("Elements:", da.arr[:da.GetSize()])
	da.Popback()
	fmt.Println("After Popback, Size:", da.GetSize())
}
'

   echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DesignSinglyLinkedList
    set output_file "linked_list.go"

    set template_content 'package main

import "fmt"

// Singly Linked List Node
type ListNode struct {
	val  int
	next *ListNode
}

// NewListNode creates a new list node
func NewListNode(val int, nextNode *ListNode) *ListNode {
	return &ListNode{
		val:  val,
		next: nextNode,
	}
}

// Implementation for Singly Linked List
type LinkedList struct {
	head *ListNode
	tail *ListNode
}

func NewLinkedList() *LinkedList {
	// Init the list with a "dummy" node which makes
	// removing a node from the beginning of list easier.
	head := NewListNode(-1, nil)
	return &LinkedList{
		head: head,
		tail: head,
	}
}

func (ll *LinkedList) Get(index int) int {
	curr := ll.head.next
	i := 0
	for curr != nil {
		if i == index {
			return curr.val
		}
		i++
		curr = curr.next
	}
	return -1 // Index out of bounds or list is empty
}

func (ll *LinkedList) InsertHead(val int) {
	newNode := NewListNode(val, ll.head.next)
	ll.head.next = newNode
	if newNode.next == nil { // If list was empty before insertion
		ll.tail = newNode
	}
}

func (ll *LinkedList) InsertTail(val int) {
	ll.tail.next = NewListNode(val, nil)
	ll.tail = ll.tail.next
}

func (ll *LinkedList) Remove(index int) bool {
	i := 0
	curr := ll.head
	for i < index && curr != nil {
		i++
		curr = curr.next
	}

	// Remove the node ahead of curr
	if curr != nil && curr.next != nil {
		if curr.next == ll.tail {
			ll.tail = curr
		}
		curr.next = curr.next.next
		return true
	}
	return false
}

func (ll *LinkedList) GetValues() []int {
	curr := ll.head.next
	var res []int
	for curr != nil {
		res = append(res, curr.val)
		curr = curr.next
	}
	return res
}

func main() {
	ll := NewLinkedList()
	ll.InsertHead(10)
	ll.InsertTail(20)
	ll.InsertTail(30)
	fmt.Println("List:", ll.GetValues())
	ll.Remove(1)
	fmt.Println("After Remove:", ll.GetValues())
	fmt.Println("Get index 1:", ll.Get(1))
}
'

 echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.InsertionSort
    set output_file "insertion_sort_pairs.go"

    set template_content 'package main

import "fmt"

type Pair struct {
	Key   int
	Value string
}

func insertionSort(pairs []Pair) [][]Pair {
	n := len(pairs)
	res := [][]Pair{} // To store the intermediate states of the array

	for i := 0; i < n; i++ {
		j := i - 1
		// Move elements that are greater than key one position ahead
		for j >= 0 && pairs[j].Key > pairs[j+1].Key {
			pairs[j], pairs[j+1] = pairs[j+1], pairs[j]
			j--
		}

		// Clone and save the entire state of the array at this point
		clone := make([]Pair, len(pairs))
		copy(clone, pairs)
		res = append(res, clone)
	}

	return res
}

func main() {
	pairs := []Pair{
		{3, "c"},
		{1, "a"},
		{2, "b"},
	}
	states := insertionSort(pairs)
	for i, state := range states {
		fmt.Printf("Step %d: %v\n", i+1, state)
	}
}
'

echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DijkstraAlgorithm
    set output_file "dijkstra_shortest_path.go"

    set template_content 'package main

import (
	"container/heap"
	"fmt"
)

// Implementation for Dijkstra'\''s shortest path algorithm
func shortestPath(n int, edges [][]int, src int) map[int]int {
	adj := make(map[int][][2]int)
	for i := 0; i < n; i++ {
		adj[i] = [][2]int{}
	}

	// s = src, d = dst, w = weight
	for _, edge := range edges {
		s, d, w := edge[0], edge[1], edge[2]
		adj[s] = append(adj[s], [2]int{d, w})
	}

	// Compute shortest paths
	shortest := make(map[int]int)
	minHeap := &MinHeap{}
	heap.Init(minHeap)
	heap.Push(minHeap, [2]int{0, src})

	for minHeap.Len() > 0 {
		curr := heap.Pop(minHeap).([2]int)
		w1, n1 := curr[0], curr[1]

		if _, exists := shortest[n1]; exists {
			continue
		}

		shortest[n1] = w1

		for _, neighbor := range adj[n1] {
			n2, w2 := neighbor[0], neighbor[1]
			if _, exists := shortest[n2]; !exists {
				heap.Push(minHeap, [2]int{w1 + w2, n2})
			}
		}
	}

	// Fill in missing nodes
	for i := 0; i < n; i++ {
		if _, exists := shortest[i]; !exists {
			shortest[i] = -1
		}
	}

	return shortest
}

type MinHeap [][2]int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i][0] < h[j][0] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.([2]int))
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

func main() {
	edges := [][]int{
		{0, 1, 4},
		{0, 2, 1},
		{2, 1, 2},
		{1, 3, 1},
		{2, 3, 5},
	}
	n := 4
	src := 0
	shortest := shortestPath(n, edges, src)
	fmt.Println(shortest)
}
'

  echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.RotateImage.BruteForce
set output_file "rotate_matrix.go"

set template_content 'package main


// Rotate matrix 90 degrees clockwise
func rotate(matrix [][]int) {
n := len(matrix)
rotated := make([][]int, n)
for i := range rotated {
rotated[i] = make([]int, n)
}


for i := 0; i < n; i++ {
	for j := 0; j < n; j++ {
		rotated[j][n-1-i] = matrix[i][j]
	}
}

for i := 0; i < n; i++ {
	for j := 0; j < n; j++ {
		matrix[i][j] = rotated[i][j]
	}
}


}

func main() {
// test usage here if needed
}
'

echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.RotateImage.RotateByFourCells
set output_file "rotate_matrix.go"


set template_content 'package main


// Rotate NxN matrix 90 degrees in-place
func rotate(matrix [][]int) {
l, r := 0, len(matrix)-1
for l < r {
for i := 0; i < r-l; i++ {
top, bottom := l, r


		// save the topleft
		topLeft := matrix[top][l+i]

		// move bottom left into top left
		matrix[top][l+i] = matrix[bottom-i][l]

		// move bottom right into bottom left
		matrix[bottom-i][l] = matrix[bottom][r-i]

		// move top right into bottom right
		matrix[bottom][r-i] = matrix[top+i][r]

		// move top left into top right
		matrix[top+i][r] = topLeft
	}
	r--
	l++
}


}

func main() {
// add testing here if needed
}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.RotateImage.ReverseAndTranspose
set output_file "rotate_matrix_fast.go"


set template_content 'package main


// Rotate NxN matrix 90 degrees in-place using vertical reverse + transpose
func rotate(matrix [][]int) {
// Reverse the matrix vertically
for i, j := 0, len(matrix)-1; i < j; i, j = i+1, j-1 {
matrix[i], matrix[j] = matrix[j], matrix[i]
}


// Transpose the matrix
for i := 0; i < len(matrix); i++ {
	for j := i + 1; j < len(matrix); j++ {
		matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
	}
}


}

func main() {
// add testing here if needed
}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.SpiralMatrix.Recursion
set output_file "spiral_order.go"


set template_content 'package main


// Return matrix in spiral order using DFS-style traversal
func spiralOrder(matrix [][]int) []int {
m, n := len(matrix), len(matrix[0])
res := []int{}


// Helper function for DFS traversal
var dfs func(row, col, r, c, dr, dc int)
dfs = func(row, col, r, c, dr, dc int) {
	if row == 0 || col == 0 {
		return
	}

	for i := 0; i < col; i++ {
		r += dr
		c += dc
		res = append(res, matrix[r][c])
	}

	// Recursive call with updated direction and dimensions
	dfs(col, row-1, r, c, dc, -dr)
}

// Start the DFS going to the right
dfs(m, n, 0, -1, 0, 1)
return res


}

func main() {
// add example call if needed
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.SpiralMatrix.Iteration
set output_file "spiral_order_iter.go"


set template_content 'package main


func spiralOrder(matrix [][]int) []int {
res := []int{}
if len(matrix) == 0 || len(matrix[0]) == 0 {
return res
}


left, right := 0, len(matrix[0])
top, bottom := 0, len(matrix)

for left < right && top < bottom {
	for i := left; i < right; i++ {
		res = append(res, matrix[top][i])
	}
	top++

	for i := top; i < bottom; i++ {
		res = append(res, matrix[i][right-1])
	}
	right--

	if !(left < right && top < bottom) {
		break
	}

	for i := right - 1; i >= left; i-- {
		res = append(res, matrix[bottom-1][i])
	}
	bottom--

	for i := bottom - 1; i >= top; i-- {
		res = append(res, matrix[i][left])
	}
	left++
}

return res


}

func main() {
// add example call if needed
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SpiralMatrix.Iteration_Optimal
    set output_file "spiral_order.go"

    set template_content 'package main

func spiralOrder(matrix [][]int) []int {
	res := []int{}
	if len(matrix) == 0 || len(matrix[0]) == 0 {
		return res
	}

	directions := [4][2]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
	steps := []int{len(matrix[0]), len(matrix) - 1}

	r, c, d := 0, -1, 0

	for steps[d&1] > 0 {
		for i := 0; i < steps[d&1]; i++ {
			r += directions[d][0]
			c += directions[d][1]
			res = append(res, matrix[r][c])
		}
		steps[d&1]--
		d = (d + 1) % 4
	}

	return res
}

func main() {
	// example usage
	matrix := [][]int{
		{1, 2, 3},
		{4, 5, 6},
		{7, 8, 9},
	}
	result := spiralOrder(matrix)
	fmt.Println(result)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.DetectSquares.HashMap-I
    set output_file "count_squares.go"

    set template_content 'package main

import "fmt"

type CountSquares struct {
    ptsCount map[Point]int
    pts      []Point
}

type Point struct {
    x, y int
}

func Constructor() CountSquares {
    return CountSquares{
        ptsCount: make(map[Point]int),
        pts:      make([]Point, 0),
    }
}

func (this *CountSquares) Add(point []int) {
    p := Point{point[0], point[1]}
    this.ptsCount[p]++
    this.pts = append(this.pts, p)
}

func (this *CountSquares) Count(point []int) int {
    res := 0
    px, py := point[0], point[1]

    for _, pt := range this.pts {
        if abs(py-pt.y) != abs(px-pt.x) || pt.x == px || pt.y == py {
            continue
        }

        p1 := Point{pt.x, py}
        p2 := Point{px, pt.y}

        res += this.ptsCount[p1] * this.ptsCount[p2]
    }

    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func main() {
    cs := Constructor()
    cs.Add([]int{3, 10})
    cs.Add([]int{11, 2})
    cs.Add([]int{3, 2})
    fmt.Println(cs.Count([]int{11, 10})) // Example usage
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoG.SetMatrixZeroes.BruteForce
    set output_file "set_zeroes.go"

    set template_content 'package main

import "fmt"

func setZeroes(matrix [][]int) {
    ROWS, COLS := len(matrix), len(matrix[0])
    mark := make([][]int, ROWS)
    for i := 0; i < ROWS; i++ {
        mark[i] = make([]int, COLS)
        copy(mark[i], matrix[i])
    }

    for r := 0; r < ROWS; r++ {
        for c := 0; c < COLS; c++ {
            if matrix[r][c] == 0 {
                for col := 0; col < COLS; col++ {
                    mark[r][col] = 0
                }
                for row := 0; row < ROWS; row++ {
                    mark[row][c] = 0
                }
            }
        }
    }

    for r := 0; r < ROWS; r++ {
        for c := 0; c < COLS; c++ {
            matrix[r][c] = mark[r][c]
        }
    }
}

func main() {
    mat := [][]int{
        {1, 1, 1},
        {1, 0, 1},
        {1, 1, 1},
    }
    setZeroes(mat)
    fmt.Println(mat)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SetMatrixZeroes.Iteration
    set output_file "set_zeroes_optimized.go"

    set template_content 'package main

import "fmt"

func setZeroes(matrix [][]int) {
    ROWS, COLS := len(matrix), len(matrix[0])
    rows := make([]bool, ROWS)
    cols := make([]bool, COLS)

    for r := 0; r < ROWS; r++ {
        for c := 0; c < COLS; c++ {
            if matrix[r][c] == 0 {
                rows[r] = true
                cols[c] = true
            }
        }
    }

    for r := 0; r < ROWS; r++ {
        for c := 0; c < COLS; c++ {
            if rows[r] || cols[c] {
                matrix[r][c] = 0
            }
        }
    }
}

func main() {
    mat := [][]int{
        {1, 1, 1},
        {1, 0, 1},
        {1, 1, 1},
    }
    setZeroes(mat)
    fmt.Println(mat)
}
'

   echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SetMatrixZeroes.Iteration_SpaceOptimized
    set output_file "set_zeroes_constant_space.go"

    set template_content 'package main

import "fmt"

func setZeroes(matrix [][]int) {
    ROWS, COLS := len(matrix), len(matrix[0])
    rowZero := false

    // Mark zeros in first row/column
    for r := 0; r < ROWS; r++ {
        for c := 0; c < COLS; c++ {
            if matrix[r][c] == 0 {
                matrix[0][c] = 0
                if r > 0 {
                    matrix[r][0] = 0
                } else {
                    rowZero = true
                }
            }
        }
    }

    // Zero based on markers
    for r := 1; r < ROWS; r++ {
        for c := 1; c < COLS; c++ {
            if matrix[0][c] == 0 || matrix[r][0] == 0 {
                matrix[r][c] = 0
            }
        }
    }

    // Zero first column if needed
    if matrix[0][0] == 0 {
        for r := 0; r < ROWS; r++ {
            matrix[r][0] = 0
        }
    }

    // Zero first row if needed
    if rowZero {
        for c := 0; c < COLS; c++ {
            matrix[0][c] = 0
        }
    }
}

func main() {
    mat := [][]int{
        {1, 1, 1},
        {1, 0, 1},
        {1, 1, 1},
    }
    setZeroes(mat)
    fmt.Println(mat)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Pow-x-n.BruteForce
set output_file "my_pow_basic.go"
set template_content 'package main


import (
"fmt"
"math"
)

func myPow(x float64, n int) float64 {
if x == 0 {
return 0
}
if n == 0 {
return 1
}


res := 1.0
for i := 0; i < int(math.Abs(float64(n))); i++ {
    res *= x
}

if n >= 0 {
    return res
}
return 1 / res


}

func main() {
fmt.Println(myPow(2, 10))
fmt.Println(myPow(2, -2))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end

function algoG.Pow-x-n.BinaryExponentiation_Recursive
set output_file "my_pow_recursion.go"
set template_content 'package main


import (
"fmt"
"math"
)

func myPow(x float64, n int) float64 {
var helper func(x float64, n int) float64
helper = func(x float64, n int) float64 {
if x == 0 {
return 0
}
if n == 0 {
return 1
}


    res := helper(x*x, n/2)
    if n%2 != 0 {
        return x * res
    }
    return res
}

res := helper(x, int(math.Abs(float64(n))))
if n >= 0 {
    return res
}
return 1 / res


}

func main() {
fmt.Println(myPow(2, 10))
fmt.Println(myPow(2, -2))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.Pow-x-n.BinaryExponentiation_Iterative
set output_file "my_pow_bit.go"
set template_content 'package main


import (
"fmt"
"math"
)

func myPow(x float64, n int) float64 {
if x == 0 {
return 0
}
if n == 0 {
return 1
}


res := 1.0
power := int(math.Abs(float64(n)))

for power > 0 {
    if power&1 != 0 {
        res *= x
    }
    x *= x
    power >>= 1
}

if n >= 0 {
    return res
}
return 1 / res


}

func main() {
fmt.Println(myPow(2, 10))
fmt.Println(myPow(2, -2))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.MultiplyStrings.Multiplication_Addition
set output_file "multiply_strings.go"
set template_content 'package main

import "fmt"

func multiply(num1 string, num2 string) string {
if num1 == "0" || num2 == "0" {
return "0"
}


if len(num1) < len(num2) {
    return multiply(num2, num1)
}

res, zero := "", 0
for i := len(num2) - 1; i >= 0; i-- {
    cur := mul(num1, num2[i], zero)
    res = add(res, cur)
    zero++
}

return res


}

func mul(s string, d byte, zero int) string {
i, carry := len(s)-1, 0
d = d - '0'
cur := make([]byte, 0)

```
for i >= 0 || carry > 0 {
    var n int
    if i >= 0 {
        n = int(s[i] - '0')
    }
    prod := n*int(d) + carry
    cur = append(cur, byte(prod%10+'0'))
    carry = prod / 10
    i--
}

for i := 0; i < len(cur)/2; i++ {
    cur[i], cur[len(cur)-1-i] = cur[len(cur)-1-i], cur[i]
}

result := string(cur)
for i := 0; i < zero; i++ {
    result += "0"
}
return result


}

func add(num1 string, num2 string) string {
i, j, carry := len(num1)-1, len(num2)-1, 0
res := make([]byte, 0)


for i >= 0 || j >= 0 || carry > 0 {
    var n1, n2 int
    if i >= 0 {
        n1 = int(num1[i] - '0')
    }
    if j >= 0 {
        n2 = int(num2[j] - '0')
    }
    total := n1 + n2 + carry
    res = append(res, byte(total%10+'0'))
    carry = total / 10
    i--
    j--
}

for i := 0; i < len(res)/2; i++ {
    res[i], res[len(res)-1-i] = res[len(res)-1-i], res[i]
}

return string(res)


}

func main() {
fmt.Println(multiply("123", "456"))
}
'


    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MultiplyStrings.Multiplication
set output_file "multiply_strings_optimized.go"
set template_content 'package main

import (
"fmt"
"strconv"
"strings"
)

func multiply(num1 string, num2 string) string {
if num1 == "0" || num2 == "0" {
return "0"
}


res := make([]int, len(num1)+len(num2))
for i1 := len(num1) - 1; i1 >= 0; i1-- {
    for i2 := len(num2) - 1; i2 >= 0; i2-- {
        pos := len(num1) - 1 - i1 + len(num2) - 1 - i2
        digit := int(num1[i1]-'0') * int(num2[i2]-'0')

        res[pos] += digit
        res[pos+1] += res[pos] / 10
        res[pos] = res[pos] % 10
    }
}

var result strings.Builder
start := len(res) - 1
for start >= 0 && res[start] == 0 {
    start--
}
if start < 0 {
    return "0"
}

for i := start; i >= 0; i-- {
    result.WriteString(strconv.Itoa(res[i]))
}

return result.String()


}

func main() {
fmt.Println(multiply("123", "456"))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.AverageCalculation
set output_file "avg_variadic.go"
set template_content 'package main


import (
"fmt"
)

func avg(num ...float64) float64 {
fmt.Println(num)
fmt.Printf("%T \n", num)
total := 0.0
for _, value := range num {
total += value
}


return total / float64(len(num))


}

func main() {
fmt.Println(avg(1.0, 2.0, 3.0, 4.0))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.BalancedBinaryTree
set output_file "is_balanced_binary_tree.go"
set template_content 'package main


import (
"fmt"
"math"
)

// Definition for a binary tree node.
type TreeNode struct {
Val   int
Left  *TreeNode
Right *TreeNode
}

// Helper function to check balance and compute height
func checkBalance(root *TreeNode) (bool, int) {
if root == nil {
return true, 0
}


leftBalanced, leftHeight := checkBalance(root.Left)
rightBalanced, rightHeight := checkBalance(root.Right)

balanced := leftBalanced && rightBalanced && math.Abs(float64(leftHeight-rightHeight)) <= 1
height := max(leftHeight, rightHeight) + 1

return balanced, height


}

// Function to check if the tree is height-balanced
func isBalanced(root *TreeNode) bool {
balanced, _ := checkBalance(root)
return balanced
}

// Helper function to get the max of two integers
func max(a, b int) int {
if a > b {
return a
}
return b
}

func main() {
// Creating the tree: [1,2,3,nil,nil,4]
root := &TreeNode{Val: 1}
root.Left = &TreeNode{Val: 2}
root.Right = &TreeNode{Val: 3}
root.Right.Left = &TreeNode{Val: 4}


fmt.Println("Is the tree balanced?", isBalanced(root))

// Creating an unbalanced tree: [1,2,3,nil,nil,4,nil,5]
root.Right.Left.Left = &TreeNode{Val: 5}
fmt.Println("Is the tree balanced?", isBalanced(root))


}
'

echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.BinarySearch.CuttingWood
set output_file "cutting_wood.go"


set template_content 'package main


import (
"fmt"
)

func cuttingWood(heights []int, k int) int {
left, right := 0, max(heights)
for left < right {
mid := (left + right) / 2 + 1 // смещение в сторону правой границы
if cutsEnoughWood(mid, k, heights) {
left = mid
} else {
right = mid - 1
}
}
return right
}

func cutsEnoughWood(H int, k int, heights []int) bool {
woodCollected := 0
for _, height := range heights {
if height > H {
woodCollected += height - H
}
}
return woodCollected >= k
}

func max(nums []int) int {
maxVal := nums[0]
for _, n := range nums[1:] {
if n > maxVal {
maxVal = n
}
}
return maxVal
}

func main() {
heights := []int{20, 15, 10, 17}
k := 7
fmt.Println("Max cutting height:", cuttingWood(heights, k))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.ArraySorted
set output_file "search_insert_position.go"
set template_content 'package main


import (
"fmt"
)

func findTheInsertionIndex(nums []int, target int) int {
left, right := 0, len(nums)
for left < right {
mid := (left + right) / 2
if nums[mid] >= target {
right = mid
} else {
left = mid + 1
}
}
return left
}

func main() {
nums := []int{1, 3, 5, 6}
target := 5
fmt.Println("Insertion index:", findTheInsertionIndex(nums, target)) // Output: 2
}
'

echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.BinarySearch.MedianTwoSortedArrays
set output_file "median_two_sorted_arrays.go"
set template_content 'package main


import (
"fmt"
"math"
)

func findTheMedianFromTwoSortedArrays(nums1 []int, nums2 []int) float64 {
if len(nums2) < len(nums1) {
return findTheMedianFromTwoSortedArrays(nums2, nums1)
}


m, n := len(nums1), len(nums2)
halfTotalLen := (m + n) / 2
left, right := 0, m-1

for {
    L1Index := (left + right) / 2
    L2Index := halfTotalLen - (L1Index + 1) - 1

    L1 := math.Inf(-1)
    if L1Index >= 0 {
        L1 = float64(nums1[L1Index])
    }

    R1 := math.Inf(1)
    if L1Index+1 < m {
        R1 = float64(nums1[L1Index+1])
    }

    L2 := math.Inf(-1)
    if L2Index >= 0 {
        L2 = float64(nums2[L2Index])
    }

    R2 := math.Inf(1)
    if L2Index+1 < n {
        R2 = float64(nums2[L2Index+1])
    }

    if L1 > R2 {
        right = L1Index - 1
    } else if L2 > R1 {
        left = L1Index + 1
    } else {
        if (m+n)%2 == 0 {
            return (math.Max(L1, L2) + math.Min(R1, R2)) / 2.0
        }
        return math.Min(R1, R2)
    }
}


}

func main() {
nums1 := []int{1, 3}
nums2 := []int{2}
fmt.Println(findTheMedianFromTwoSortedArrays(nums1, nums2))
}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.search_rotated_sorted_array
set output_file "search_rotated_sorted_array.go"
set template_content 'package main

import "fmt"

func findTheTargetInARotatedSortedArray(nums []int, target int) int {
left, right := 0, len(nums)-1

for left < right {
    mid := (left + right) / 2

    if nums[mid] == target {
        return mid
    } else if nums[left] <= nums[mid] {
        if nums[left] <= target && target < nums[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
    } else {
        if nums[mid] < target && target <= nums[right] {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
}

if len(nums) > 0 && nums[left] == target {
    return left
}
return -1


}

func main() {
nums := []int{4, 5, 6, 7, 0, 1, 2}
target := 0
fmt.Println(findTheTargetInARotatedSortedArray(nums, target))
}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.BinarySearch.SearchRotatedSortedArray
set output_file "search_rotated_sorted_array.go"
set template_content 'package main


import "fmt"

func findTheTargetInARotatedSortedArray(nums []int, target int) int {
left, right := 0, len(nums)-1

for left < right {
    mid := (left + right) / 2

    if nums[mid] == target {
        return mid
    } else if nums[left] <= nums[mid] {
        if nums[left] <= target && target < nums[mid] {
            right = mid - 1
        } else {
            left = mid + 1
        }
    } else {
        if nums[mid] < target && target <= nums[right] {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
}

if len(nums) > 0 && nums[left] == target {
    return left
}
return -1


}

func main() {
nums := []int{4, 5, 6, 7, 0, 1, 2}
target := 0
fmt.Println(findTheTargetInARotatedSortedArray(nums, target))
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file


end


function algoG.BinarySearch.FirstLastOccurrences
set output_file "first_last_occurrences.go"


set template_content 'package main


import (
"fmt"
)

func firstAndLastOccurrences(nums []int, target int) []int {
lower := lowerBoundBinarySearch(nums, target)
upper := upperBoundBinarySearch(nums, target)
return []int{lower, upper}
}

func lowerBoundBinarySearch(nums []int, target int) int {
left, right := 0, len(nums)-1
for left < right {
mid := (left + right) / 2
if nums[mid] > target {
right = mid - 1
} else if nums[mid] < target {
left = mid + 1
} else {
right = mid
}
}
if len(nums) > 0 && nums[left] == target {
return left
}
return -1
}

func upperBoundBinarySearch(nums []int, target int) int {
left, right := 0, len(nums)-1
for left < right {
mid := (left + right) / 2 + 1
if nums[mid] > target {
right = mid - 1
} else if nums[mid] < target {
left = mid + 1
} else {
left = mid
}
}
if len(nums) > 0 && nums[right] == target {
return right
}
return -1
}

func main() {
nums := []int{1, 2, 2, 2, 3, 4, 5}
target := 2
fmt.Println(firstAndLastOccurrences(nums, target))
}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.LocalMaximaBinarySearch
set output_file "local_maxima.go"
set template_content 'package main

import (
"fmt"
)

func localMaximaInArray(nums []int) int {
left, right := 0, len(nums)-1
for left < right {
mid := (left + right) / 2
if nums[mid] > nums[mid+1] {
right = mid
} else {
left = mid + 1
}
}
return left
}

func main() {
nums := []int{1, 3, 5, 4, 2}
index := localMaximaInArray(nums)
fmt.Printf("Local maxima at index %d with value %d\n", index, nums[index])
}
'

echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file

end


function algoG.BinarySearch.MatrixSearchBinary
set output_file "matrix_search.go"
set template_content 'package main


import (
"fmt"
)

func matrixSearch(matrix [][]int, target int) bool {
if len(matrix) == 0 || len(matrix[0]) == 0 {
return false
}


m, n := len(matrix), len(matrix[0])
left, right := 0, m*n-1

for left <= right {
    mid := (left + right) / 2
    r, c := mid/n, mid%n
    if matrix[r][c] == target {
        return true
    } else if matrix[r][c] > target {
        right = mid - 1
    } else {
        left = mid + 1
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
target := 3
fmt.Println(matrixSearch(matrix, target)) // true
}
'


echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file


end


function algoG.BinarySearch.WeightedRandomSelection
    set output_file "weighted_random_selection.go"

    set template_content 'package main

import (
	"fmt"
	"math/rand"
	"time"
)

type WeightedRandomSelection struct {
	prefixSums []int
}

func NewWeightedRandomSelection(weights []int) *WeightedRandomSelection {
	prefixSums := make([]int, len(weights))
	prefixSums[0] = weights[0]
	for i := 1; i < len(weights); i++ {
		prefixSums[i] = prefixSums[i-1] + weights[i]
	}
	return &WeightedRandomSelection{prefixSums: prefixSums}
}

func (wrs *WeightedRandomSelection) Select() int {
	rand.Seed(time.Now().UnixNano())
	target := rand.Intn(wrs.prefixSums[len(wrs.prefixSums)-1]) + 1

	left, right := 0, len(wrs.prefixSums)-1
	for left < right {
		mid := (left + right) / 2
		if wrs.prefixSums[mid] < target {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return left
}

func main() {
	weights := []int{1, 3, 2}
	wrs := NewWeightedRandomSelection(weights)

	// Example: run 10 selections
	for i := 0; i < 10; i++ {
		fmt.Println(wrs.Select())
	}
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Recursive_divide
    set output_file "binary_search.go"

    set template_content 'package main

import "fmt"

func BinarySearch(array []int, target int) int {
	return helper(array, target, 0, len(array)-1)
}

func helper(array []int, target, left, right int) int {
	if left > right {
		return -1
	}

	middle := (left + right) / 2
	potentialMatch := array[middle]

	if target == potentialMatch {
		return middle
	} else if target < potentialMatch {
		return helper(array, target, left, middle-1)
	}

	return helper(array, target, middle+1, right)
}

func main() {
	array := []int{1, 3, 5, 7, 9, 11, 13, 15, 17}
	targets := []int{7, 15, 2, 11}
	for _, target := range targets {
		result := BinarySearch(array, target)
		if result != -1 {
			fmt.Printf("Target %d found at index %d\\n", target, result)
		} else {
			fmt.Printf("Target %d not found in the array\\n", target)
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

function algoG.BinarySearch.Iterative
    set output_file "binary_search.go"

    set template_content 'package main

import "fmt"

func BinarySearch(array []int, target int) int {
    left, right := 0, len(array)-1

    for left <= right {
        middle := (left + right) / 2
        potentialMatch := array[middle]

        if target == potentialMatch {
            return middle
        } else if target < potentialMatch {
            right = middle - 1
        } else {
            left = middle + 1
        }
    }

    return -1
}

func main() {
    array := []int{11, 3, 5, 12, 9, 11, 52, 15, 104}
    targets := []int{7, 15, 2, 11}
    for _, target := range targets {
        result := BinarySearch(array, target)
        if result != -1 {
            fmt.Printf("Target %d found at index %d\\n", target, result)
        } else {
            fmt.Printf("Target %d not found in the array\\n", target)
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


function algoG.BinarySearch.Recursive
    set output_file "binary_search_recursive.go"

    set template_content 'package main

import "fmt"

func helper(array []int, target, left, right int) int {
	if left > right {
		return -1
	}

	middle := (left + right) / 2
	potentialMatch := array[middle]

	if target == potentialMatch {
		return middle
	} else if target < potentialMatch {
		return helper(array, target, left, middle-1)
	}
	return helper(array, target, middle+1, right)
}

func main() {
	array := []int{1, 3, 5, 7, 9, 11, 13, 15, 17}
	targets := []int{7, 15, 2, 11}

	for _, target := range targets {
		index := helper(array, target, 0, len(array)-1)
		if index != -1 {
			fmt.Printf("Target %d found at index %d\\n", target, index)
		} else {
			fmt.Printf("Target %d not found\\n", target)
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


function algoG.BinarySearch.Iterative
    set output_file "binary_search_iterative.go"

    set template_content 'package main

import "fmt"

func main() {
    var arr = []int{2, 4, 6, 8, 10, 12, 14, 16, 18, 20}
    find := 14
    fmt.Printf("Array: %v\\n", arr)
    result := search(arr, find)
    fmt.Printf("Result: %d\\n", result)
}

func search(list []int, item int) int {
    low := 0
    high := len(list) - 1
    for low <= high {
        middle := (low + high) / 2
        if list[middle] == item {
            return middle
        } else if list[middle] < item {
            low = middle + 1
        } else {
            high = middle - 1
        }
    }
    return -1
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.BinarySearch.Recursive2
    set output_file "binary_search_recursive.go"

    set template_content 'package main

import "fmt"

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
    nums := []int{1, 3, 5, 7, 9, 11}
    targets := []int{3, 8, 1, 11}

    for _, target := range targets {
        index := search(nums, target)
        if index != -1 {
            fmt.Printf("Target %d found at index %d\\n", target, index)
        } else {
            fmt.Printf("Target %d not found\\n", target)
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

function algoG.BubbleSort.comparision
    set output_file "bubble_sort.go"

    set template_content 'package main

import "fmt"

func BubbleSort(arr []int) {
	size := len(arr)
	for i := 0; i < (size - 1); i++ {
		for j := 0; j < size-i-1; j++ {
			if arr[j] > arr[j+1] {
				/* Swapping */
				arr[j+1], arr[j] = arr[j], arr[j+1]
			}
		}
	}
}

func main() {
	data := []int{9, 1, 8, 2, 7, 3, 6, 4, 5}
	BubbleSort(data)
	fmt.Println(data)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CaesarCipherEncryptor
    set output_file "caesar_cipher_encryptor.go"

    set template_content 'package main

import (
	"fmt"
	"strings"
)

// O(n) time | O(n) space
func CaesarCipherEncryptor(str string, key int) string {
	shift := rune(key % 26) // Ensure key stays within 0-25
	runes := []rune(str)

	for i, char := range runes {
		if char >= '\''a'\'' && char <= '\''z'\'' { // Ensure it'\''s a lowercase letter
			newChar := char + shift
			if newChar > '\''z'\'' {
				newChar -= 26 // Wrap around the alphabet
			}
			runes[i] = newChar
		}
	}
	return string(runes)
}

func main() {
	// Test cases
	fmt.Println(CaesarCipherEncryptor("abc", 2))   // Output: "cde"
	fmt.Println(CaesarCipherEncryptor("xyz", 5))   // Output: "cde"
	fmt.Println(CaesarCipherEncryptor("hello", 3)) // Output: "khoor"
	fmt.Println(CaesarCipherEncryptor("zebra", 1)) // Output: "afcsb"
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ClimbStairs.DynamicProgramming
    set output_file "climb_stairs.go"

    set template_content 'package main

import "fmt"

func climbStairs(n int) int {
	if n == 1 {
		return 1
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
	// Test cases
	fmt.Println(climbStairs(2)) // Output: 2
	fmt.Println(climbStairs(3)) // Output: 3
	fmt.Println(climbStairs(4)) // Output: 5
	fmt.Println(climbStairs(5)) // Output: 8
	fmt.Println(climbStairs(6)) // Output: 13
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ClimbStairs.Recursive
    set output_file "climb_stairs_recursive.go"

    set template_content 'package main

import "fmt"

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
	fmt.Println(climbStairs(2)) // Output: 2
	fmt.Println(climbStairs(3)) // Output: 3
	fmt.Println(climbStairs(4)) // Output: 5
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.ClimbStairs.DepthFirstSearch
    set output_file "climb_stairs_recursive.go"

    set template_content 'package main

import (
	"fmt"
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
		return dfs(i+1) + dfs(i+2)
	}
	return dfs(0)
}

func main() {
	n := 4
	result := climbStairs(n)
	fmt.Printf("Number of ways to climb %d stairs: %d\n", n, result)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.HasDuplicate.Bruteforce
    set output_file "has_duplicate_bruteforce.go"

    set template_content 'package main

import (
	"fmt"
)

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
	nums := []int{1, 2, 3, 4, 5}
	fmt.Println(hasDuplicate(nums)) // false

	fmt.Println(hasDuplicate([]int{1, 2, 3, 4, 3})) // true
	fmt.Println(hasDuplicate([]int{5, 5, 5, 5, 5})) // true
	fmt.Println(hasDuplicate([]int{1, 2, 3, 1, 2, 3})) // true
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.CombinationsSum
    set output_file "combinations_sum_k.go"

    set template_content 'package main

import (
	"fmt"
)

func combinationsOfSumK(nums []int, target int) [][]int {
	var res [][]int
	var combination []int
	dfs(combination, 0, nums, target, &res)
	return res
}

func dfs(combination []int, startIndex int, nums []int, target int, res *[][]int) {
	if target == 0 {
		temp := make([]int, len(combination))
		copy(temp, combination)
		*res = append(*res, temp)
		return
	}

	if target < 0 {
		return
	}

	for i := startIndex; i < len(nums); i++ {
		combination = append(combination, nums[i])
		dfs(combination, i, nums, target-nums[i], res)
		combination = combination[:len(combination)-1]
	}
}

func main() {
	nums := []int{2, 3, 6, 7}
	target := 7
	result := combinationsOfSumK(nums, target)
	fmt.Println(result)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.HasDuplicate.Sort
    set output_file "has_duplicate_sort.go"

    set template_content 'package main

import (
	"fmt"
	"sort"
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
	nums := []int{1, 2, 3, 4, 5}
	fmt.Println(hasDuplicate(nums))

	fmt.Println(hasDuplicate([]int{1, 2, 3, 4, 3})) // true
	fmt.Println(hasDuplicate([]int{5, 5, 5, 5, 5})) // true
	fmt.Println(hasDuplicate([]int{1, 2, 3, 1, 2, 3})) // true
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HasDuplicate.Hash
    set output_file "has_duplicate_hash.go"

    set template_content 'package main

import (
	"fmt"
)

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
	nums := []int{1, 2, 3, 4, 5}
	fmt.Println(hasDuplicate(nums))

	fmt.Println(hasDuplicate([]int{1, 2, 3, 4, 3})) // true
	fmt.Println(hasDuplicate([]int{5, 5, 5, 5, 5})) // true
	fmt.Println(hasDuplicate([]int{1, 2, 3, 1, 2, 3})) // true
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.HasDuplicate.HashStruct
    set output_file "has_duplicate_hash_struct.go"

    set template_content 'package main

import (
	"fmt"
)

func hasDuplicate(nums []int) bool {
	seen := make(map[int]struct{})
	for _, num := range nums {
		seen[num] = struct{}{}
	}
	return len(seen) < len(nums)
}

func main() {
	nums := []int{1, 2, 3, 4, 5}
	fmt.Println(hasDuplicate(nums))

	fmt.Println(hasDuplicate([]int{1, 2, 3, 4, 3})) // true
	fmt.Println(hasDuplicate([]int{5, 5, 5, 5, 5})) // true
	fmt.Println(hasDuplicate([]int{1, 2, 3, 1, 2, 3})) // true
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.SumofOneIntegers.Func
    set output_file "convert_minutes_to_seconds.go"

    set template_content 'package main

import (
	"fmt"
)

func convert(minutes int) int {
	return minutes * 60
}

func main() {
	fmt.Println(convert(5)) // ➞ 300
	fmt.Println(convert(3)) // ➞ 180
	fmt.Println(convert(2)) // ➞ 120
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.SumofTwoIntegers.Func
    set output_file "addition.go"

    set template_content 'package main

import (
	"fmt"
)

func addition(a int, b int) int {
	return a + b
}

func main() {
	// Примеры
	fmt.Println(addition(3, 2))   // ➞ 5
	fmt.Println(addition(-3, -6)) // ➞ -9
	fmt.Println(addition(7, 3))   // ➞ 10
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindMin
    set output_file "find_min_int.go"

    set template_content 'package main

import "fmt"

func findMinInt(a []int) int {
	var minInt int = a[0]
	for _, i := range a {
		if minInt > i {
			minInt = i
		}
	}
	return minInt
}

func main() {
	arr := []int{5, 2, 9, 1, 7}
	fmt.Println("Minimum value:", findMinInt(arr)) // Output: 1
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindMax
    set output_file "find_max_int.go"

    set template_content 'package main

import "fmt"

func findMaxInt(b []int) int {
	var max int = b[0]
	for _, i := range b {
		if max < i {
			max = i
		}
	}
	return max
}

func main() {
	arr := []int{5, 2, 9, 1, 7}
	fmt.Println("Maximum value:", findMaxInt(arr)) // Output: 9
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindMax2
    set output_file "find_max_numbers.go"

    set template_content 'package main

import (
	"fmt"
	"sort"
)

func findmaxnumber(mang1 []int) {
	maxnumber := mang1[0]
	for i := 0; i < len(mang1); i++ {
		if maxnumber < mang1[i] {
			maxnumber = mang1[i]
		}
	}
	fmt.Println("The largest element in the array is:", maxnumber)
}

func findmax2number(mang2 []int) {
	sort.Ints(mang2)
	fmt.Println("The array sorted in ascending order is:", mang2)
	fmt.Println("==> THE SECOND LARGEST NUMBER IN THE ABOVE ARRAY IS:", mang2[len(mang2)-2])
}

func main() {
	arr1 := []int{5, 2, 9, 1, 7}
	findmaxnumber(arr1)

	arr2 := []int{4, 8, 6, 10, 3}
	findmax2number(arr2)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.FindMaxLength
    set output_file "find_max_length_elements.go"

    set template_content 'package main

import (
	"fmt"
)

func findMaxLengthElement(arr []string) {
	maxLength := len(arr[0])
	var newArr []string

	// Знаходимо максимальну довжину рядка
	for i := 0; i < len(arr); i++ {
		if len(arr[i]) > maxLength {
			maxLength = len(arr[i])
		}
	}

	// Збираємо всі рядки з максимальною довжиною
	for i := 0; i < len(arr); i++ {
		if len(arr[i]) == maxLength {
			newArr = append(newArr, arr[i])
		}
	}

	fmt.Println("--------------------------------------------------------------")
	fmt.Printf("The elements in the array with the maximum length of %d are: %v\n", maxLength, newArr)
}

func main() {
	strArr := []string{"apple", "banana", "kiwi", "strawberry", "peach"}
	findMaxLengthElement(strArr)
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Fibonacci
    set output_file "get_nth_fib.go"

    set template_content 'package main

import "fmt"

// O(2^n) time | O(n) space
func GetNthFib(n int) int {
	if n == 2 {
		return 1
	} else if n == 1 {
		return 0
	}
	return GetNthFib(n-1) + GetNthFib(n-2)
}

func main() {
	// Example: Print the first 10 Fibonacci numbers
	for i := 1; i <= 10; i++ {
		fmt.Printf("Fibonacci(%d) = %d\n", i, GetNthFib(i))
	}
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Fibonacci1
    set output_file "get_nth_fib_memo.go"

    set template_content 'package main

import "fmt"

func GetNthFib(n int) int {
	memoize := make(map[int]int) // Create a map to store computed Fibonacci values
	return helper(n, memoize)
}

// Helper function with memoization
func helper(n int, memoize map[int]int) int {
	// Base cases
	if n == 2 {
		return 1
	} else if n == 1 {
		return 0
	}

	if val, found := memoize[n]; found {
		return val
	}

	memoize[n] = helper(n-1, memoize) + helper(n-2, memoize)
	return memoize[n]
}

func main() {
	// Example: Print the first 10 Fibonacci numbers
	for i := 1; i <= 10; i++ {
		fmt.Printf("Fibonacci(%d) = %d\n", i, GetNthFib(i))
	}
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Fibonacci2
    set output_file "get_nth_fib_iterative.go"

    set template_content 'package main

import "fmt"

func GetNthFib(n int) int {
	lastTwo := []int{0, 1} // Stores the last two Fibonacci numbers
	counter := 3           // Start from the 3rd Fibonacci number

	// Iteratively compute Fibonacci numbers up to n
	for counter <= n {
		nextFib := lastTwo[0] + lastTwo[1]   // Compute next Fibonacci number
		lastTwo = []int{lastTwo[1], nextFib} // Update last two numbers
		counter += 1
	}

	// Return the correct Fibonacci number
	if n > 1 {
		return lastTwo[1] // If n > 1, return the latest computed Fibonacci number
	}
	return lastTwo[0] // If n == 1, return 0
}

func main() {
	for i := 1; i <= 10; i++ {
		fmt.Printf("Fibonacci(%d) = %d\n", i, GetNthFib(i))
	}
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.EightQueens
    set output_file "eight_queens.go"

    set template_content 'package main

import "fmt"

const (
    maxRows             = 8
    maxCols             = 8
    invalidateIncrement = -1 // Indicates that this location cannot host a queen
    validateIncrement   = 1
    queen = 1
    empty = 0
)

var solutionCount int

func main() {
    board := make([][]int, maxRows)
    for i := range board {
        board[i] = make([]int, maxCols)
    }

    queenForRow(board, 0, 0)
    fmt.Printf("%d solutions.\n", solutionCount)
}

func queenForRow(board [][]int, row, qcount int) {
    for col, value := range board[row] {
        if value == empty {
            qcount = addQueen(board, row, col, qcount)
            if qcount == maxRows {
                printBoard(board)
            } else {
                queenForRow(board, row+1, qcount)
            }
            qcount = removeQueen(qcount, board, row, col)
        }
    }
}

func removeQueen(qcount int, board [][]int, row int, col int) int {
    qcount--
    board[row][col] = empty
    unblocker(board, row, col)
    return qcount
}

func addQueen(board [][]int, row, col, qcount int) int {
    board[row][col] = queen
    qcount++
    blocker(board, row, col)
    return qcount
}

func blocker(board [][]int, row, col int) {
    setter(board, row, col, invalidateIncrement)
}

func unblocker(board [][]int, row, col int) {
    setter(board, row, col, validateIncrement)
}

func setter(board [][]int, row, col, valueToSet int) {
    for x := col + 1; x < maxCols; x++ {
        board[row][x] += valueToSet
    }
    for x := row + 1; x < maxRows; x++ {
        board[x][col] += valueToSet
    }
    for x, y := row+1, col+1; x < maxRows && y < maxCols; x, y = x+1, y+1 {
        board[x][y] += valueToSet
    }
    for x, y := row+1, col-1; x < maxRows && y >= 0; x, y = x+1, y-1 {
        board[x][y] += valueToSet
    }
}

func printBoard(board [][]int) {
    for i := range board {
        for j := range board[i] {
            if board[i][j] != queen {
                fmt.Print("- ")
            } else {
                fmt.Print("Q ")
            }
        }
        fmt.Println()
    }
    solutionCount++
    fmt.Println("********************")
}
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.arithmetic.template
    set output_file "arithmetic.go"

    set template_content 'package main

import "fmt"

func main() {
    var a int = 12 
    var b int = 3 

    fmt.Println("ex. of '+' operator:", a+b)
    fmt.Println("ex. of '-' operator:", a-b)
    fmt.Println("ex. of '*' operator:", a*b)
    fmt.Println("ex. of '/' operator:", a/b)
    fmt.Println("ex. of '%' operator:", a%b)

    a++
    fmt.Println("ex. of '++' operator:", a)
    b--
    fmt.Println("ex. of '--' operator:", b)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.relational.template
    set output_file "relational.go"

    set template_content 'package main

import "fmt"

func main() {
    var a int = 12
    var b int = 3

    fmt.Println("ex. of '==' operator:", a == b)
    fmt.Println("ex. of '!=' operator:", a != b)
    fmt.Println("ex. of '<' operator:", a < b)
    fmt.Println("ex. of '>' operator:", a > b)
    fmt.Println("ex. of '<=' operator:", a <= b)
    fmt.Println("ex. of '>=' operator:", a >= b)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.logical.template
    set output_file "logical.go"

    set template_content 'package main

import "fmt"

func main() {
    var a int = 12
    var b int = 3

    fmt.Println("ex. of '&&' operator:", a < b && a > b)
    fmt.Println("ex. of '&&' operator:", a < b && a <= b)
    fmt.Println("ex. of '||' operator:", a < b || a > b)
    fmt.Println("ex. of '!' operator:", !(a < b && a > b))
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.assignment.template
    set output_file "assignment.go"

    set template_content 'package main

import "fmt"

func main() {
    var a int = 50
    var b int = 5

    a += b
    fmt.Println("ex. of '+=' operator:", a)

    a -= b
    fmt.Println("ex. of '-=' operator:", a)

    a *= 3
    fmt.Println("ex. of '*=' operator:", a)

    a /= b
    fmt.Println("ex. of '/=' operator:", a)

    a %= 7
    fmt.Println("ex. of '%=' operator:", a)

    b <<= 2
    fmt.Println("ex. of "<<=" operator:", b)

    b >>= 2
    fmt.Println("ex. of '>>=' operator:", b)

    a &= 10
    fmt.Println("ex. of '&=' operator:", a)

    a ^= 10
    fmt.Println("ex. of '^=' operator:", a)

    a |= 10
    fmt.Println("ex. of '|=' operator:", a)

    c := "hello world"
    fmt.Println("ex. of ':=' operator:", c)
}
'
   echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.pointers_structs.template
    set output_file "pointers_structs.go"

    set template_content 'package main

import "fmt"

type Point struct {
	X int
	Y int
}

func hello() {
	fmt.Println("Hello World")
}

func inc1(i int) int {
	return i + 1
}

func inc2(i int) (res int) {
	res = i + 1
	return
}

func sum(i, j int) int {
	return i + j
}

func calc(i int) (int, int) {
	return i * i, i + i
}

func inc(i *int) {
	*i = *i + 1
}

func main() {
	// Pointer example
	var pi *int

	i := 27
	pi = &i
	fmt.Println(*pi)

	*pi = 18
	fmt.Println(*pi)

	// Struct example
	p := Point{27, 5}
	fmt.Println(p)
	p.X = 18
	fmt.Println(p)

	pp := &p
	fmt.Println(*pp)

	i = 5
	pi = &i
	inc(pi)
	fmt.Println(i)
}
'

    echo "$content" > $output_file
    echo "File written: $output_file"
end


function algoG.variables.template
set output_file "variables.go"
set template_content 'package main

import "fmt"

func main() {
var variable1 int
fmt.Println(variable1)

var variable2 string
fmt.Println(variable2)

variable1 = 123
variable2 = "hello world"
fmt.Println(variable1, variable2)

var variable3 = 123.45
fmt.Println(variable3)

variable4 := false
fmt.Println(variable4)

variable5, variable6 := "multiple", 2
fmt.Println(variable5, variable6)

var variable7, variable8, variable9 int
variable7, variable8, variable9 = 123, 456, 789
fmt.Println(variable7, variable8, variable9)

var (
    variable10 int
    variable11 string
    variable12 bool
)
fmt.Println(variable10, variable11, variable12)
variable10, variable11, variable12 = 123, "multiple", true
fmt.Println(variable10, variable11, variable12)

variable13, variable14 := 123, 456
_ = variable14
fmt.Println(variable13)

variable15, _ := 123, 456
fmt.Println(variable15)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.boolean.template
set output_file "boolean.go"
set template_content 'package main

import "fmt"

func main() {
var isRed bool = true
fmt.Println("isRed:", isRed)


var isBlue bool
fmt.Println("isBlue (default):", isBlue)

flag := false
fmt.Println("flag:", flag)

var result bool
result = (5 > 3)
fmt.Println("5 > 3 =", result)

result = (2 == 3)
fmt.Println("2 == 3 =", result)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.numeric.template
set output_file "numeric.go"
set template_content 'package main

import "fmt"

func main() {
var intVal int = 42
var int32Val int32 = 100
var int64Val int64 = 1000
fmt.Println(intVal, int32Val, int64Val)


var floatVal float32 = 3.14
var float64Val float64 = 3.141592
fmt.Println(floatVal, float64Val)

var complexVal complex64 = 2 + 3i
fmt.Println("complexVal:", complexVal)

var unsigned uint8 = 255
fmt.Println("unsigned:", unsigned)

// conversion examples
var newInt int = int(int32Val)
fmt.Println("newInt from int32Val:", newInt)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.string.template
set output_file "string.go"
set template_content 'package main

import "fmt"

func main() {
var str string = "Grow with Golang"
fmt.Println("str:", str)


strCopy := str
fmt.Println("strCopy:", strCopy)

fmt.Println("Length:", len(str))
fmt.Println("Character at index 3:", string(str[3]))

// concatenation
message := str + " is fun!"
fmt.Println("message:", message)

// address of strings
fmt.Println("Address of str:", &str)
fmt.Println("Address of strCopy:", &strCopy)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.pointer.template
set output_file "pointer.go"
set template_content 'package main

import "fmt"

func main() {
var x int = 10
var p *int = &x
fmt.Println("Pointer p:", p)
fmt.Println("Value pointed by p:", *p)


*p = 20
fmt.Println("New x value:", x)

// pointer to struct example
type Point struct { X, Y int }
pt := Point{5, 7}
pPt := &pt
fmt.Println("Point:", pt, "Pointer to Point:", pPt)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.array.template
set output_file "array.go"
set template_content 'package main

import "fmt"

func main() {
var arr [3]string
arr[0] = "abc"
arr[1] = "def"
arr[2] = "ghi"
fmt.Println("arr:", arr)


arr2 := [3]string{"abc", "def", "ghi"}
fmt.Println("arr2:", arr2)

// multi-dimensional array
var arr2D [2][3]int = [2][3]int{{1,2,3},{4,5,6}}
fmt.Println("arr2D:", arr2D)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.structures.template
set output_file "structures.go"
set content 'package main

import "fmt"

type Company struct {
Name string
ID string
Employees int
}

func main() {
var comp Company
comp.Name = "ABC Ltd."
comp.ID = "SYRP7302"
comp.Employees = 90
fmt.Println("comp:", comp)


comp2 := Company{"XYZ Ltd.", "ID2025", 50}
fmt.Println("comp2:", comp2)
fmt.Println("comp2 Employees:", comp2.Employees)

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.slice.template
set output_file "slice.go"
set template_content 'package main

import "fmt"

func main() {
slice1 := make([]int,0)
fmt.Println("slice1:", slice1)


slice2 := make([]int,3)
slice2[0] = 123
slice2[1] = 456
slice2[2] = 789
fmt.Println("slice2:", slice2)

slice3 := []string{"abc", "def", "ghi"}
fmt.Println("slice3:", slice3)
slice3 = append(slice3, "jkl")
fmt.Println("slice3 after append:", slice3)

slice4 := make([]string,5)
copy(slice4, slice3)
fmt.Println("slice4:", slice4)

slice2D := make([][]string,2,3)
slice2D[0] = []string{"a","b","c"}
slice2D[1] = []string{"d","e"}
fmt.Println("slice2D:", slice2D)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.map.template
set output_file "map.go"
set template_content 'package main

import "fmt"

func main() {
map1 := make(map[string]int)
map1["first"] = 16
map1["second"] = 32
fmt.Println("map1:", map1)

```
map2 := make(map[int]string)
map2[1] = "WORLD"
map2[2] = "INDIA"
fmt.Println("map2:", map2)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.channel.template
set output_file "channel.go"
set content 'package main

import "fmt"

func main() {
var ch chan int
fmt.Println("ch:", ch)


ch2 := make(chan string)
go func() { ch2 <- "DONE" }()
msg := <-ch2
fmt.Println("msg from channel:", msg)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.numeric_constants.template
set output_file "numeric_constants.go"
set template_content 'package main

import "fmt"

func main() {
const untypedInt = 123
const untypedFloat = 3.97
const typedFloat float64 = 4.87
const untypedComplex = 56+2i
const typedComplex complex64 = 56+2i
const typedComplexFromInt complex64 = untypedInt
fmt.Println("typedComplexFromInt:", typedComplexFromInt)

const charRune = 'G'
fmt.Println("charRune:", charRune)

var converted uint8 = uint8(-100)
fmt.Println("converted uint8 from -100:", converted)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.string_constants.template
set output_file "string_constants.go"
set template_content 'package main

import "fmt"

type myString string

func main() {
const untypedStr = "Golang is a great language"
const typedStr string = "Golang is a great language"

```
const custom1 myString = untypedStr
// const custom2 myString = typedStr // error: conversion not allowed
fmt.Println("custom1:", custom1)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.boolean_constants.template
set output_file "boolean_constants.go"
set template_content 'package main

import "fmt"

type myBool bool

func main() {
const untypedBool = true
const typedBool bool = false

```
const custom1 myBool = untypedBool
// const custom2 myBool = typedBool // error: conversion not allowed
fmt.Println("custom1:", custom1)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.iota.template
set output_file "iota.go"
set template_content 'package main

import "fmt"

func main() {
const (
C0 = iota
_
C1 = iota
)
fmt.Println("C0:", C0)
fmt.Println("C1:", C1)

```
const (
    C2 = iota
)
fmt.Println("C2:", C2)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.print.format_specifiers
set output_file "format_specifiers.go"
set template_content 'package main

import "fmt"

func main() {
str := "hello"
intval := 78
floatval := 56.8789
complexval := 67+6i
boolval := true
pointerval := &str


fmt.Printf("%%v: %v\n", intval)
fmt.Printf("%%#v: %#v\n", str)
fmt.Printf("%%T: %T\n", intval)
fmt.Printf("%%%%: used to print %%\n\n")

fmt.Printf("%%t: %t\n", boolval)
fmt.Printf("%%b: %b\n", intval)
fmt.Printf("%%c: %c\n", intval)
fmt.Printf("%%d: %d\n", intval)
fmt.Printf("%%o: %o\n", intval)
fmt.Printf("%%q: %q\n", intval)
fmt.Printf("%%x: %x\n", intval)
fmt.Printf("%%X: %X\n", intval)
fmt.Printf("%%U: %U\n", intval)

fmt.Printf("%%e: %e\n", floatval)
fmt.Printf("%%f: %f\n", floatval)
fmt.Printf("%%g: %g\n", floatval)
fmt.Printf("%%G: %G\n", floatval)
fmt.Printf("%%p: %p\n", pointerval)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.main_function
set output_file "main_function.go"
set template_content 'package main

import "fmt"

func init() {
fmt.Println("initialization of main function")
}

func main() {
fmt.Println("Program execution begins")
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.function_arguments
set output_file "function_arguments.go"
set template_content 'package main

import "fmt"

func sum(a int, b int) int {
sum_value := a + b
fmt.Println("sum is:", sum_value)
return sum_value
}

func main() {
a := 90
b := 30
sum(a, b)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.function_variations
set output_file "function_variations.go"
set template_content 'package main

import "fmt"

// variation with shorthand arguments
func sum(a, b int) int {
sum_value := a + b
fmt.Println("sum is:", sum_value)
return sum_value
}

// function with additional string argument
func sumWithStr(a, b int, c string) int {
sum_value := a + b
fmt.Println("sum is:", sum_value)
fmt.Println("value of c is:", c)
return sum_value
}

// function returning int and string
func sumWithStrReturn(a, b int, c string) (int, string) {
sum_value := a + b
fmt.Println("sum is:", sum_value)
fmt.Println("value of c is:", c)
return sum_value, c
}

func main() {
sum(10, 20)
sumWithStr(5, 15, "GoLang")
result, str := sumWithStrReturn(3, 7, "Test")
fmt.Println("Returned:", result, str)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.call_by_value
set output_file "call_by_value.go"
set template_content 'package main

import "fmt"

func callByValue(x int, y int) {
x = x - 20
y = y - 30
fmt.Printf("In function, x: %d, y: %d\n", x, y)
}

func main() {
a := 100
b := 200
fmt.Printf("Before: a=%d, b=%d\n", a, b)
callByValue(a, b)
fmt.Printf("After: a=%d, b=%d\n", a, b)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.call_by_reference
set output_file "call_by_reference.go"
set template_content 'package main

import "fmt"

func callByReference(x *int, y *int) {
*x = *x - 20
*y = *y - 30
}

func main() {
a := 100
b := 200
fmt.Printf("Before: a=%d, b=%d\n", a, b)
callByReference(&a, &b)
fmt.Printf("After: a=%d, b=%d\n", a, b)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.named_return
set output_file "named_return_values.go"
set template_content 'package main

import "fmt"

func sum(a, b int, c string) (sum_value int, c_val string) {
sum_value = a + b
c_val = c
return
}

func main() {
a := 90
b := 30
result, c := sum(a, b, "Hello Go")
fmt.Println("Returned values:", result, c)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.blank_identifier
set output_file "blank_identifier.go"
set template_content 'package main

import "fmt"

func sum(a, b int, c string) (sum_value int, c_val string) {
sum_value = a + b
c_val = c
return
}

func main() {
a := 90
b := 30
result, _ := sum(a, b, "Hello Go")
fmt.Println("Returned value:", result)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.function_as_type
set output_file "function_as_type.go"
set template_content 'package main

import "fmt"

type sub func(a int, b int) int

func main() {
var result sub = func(a int, b int) int {
return a - b
}
fmt.Println("Result:", result(100, 70))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.array_slice.full_array_slice_example
set output_file "array_slice_example_full.go"
set template_content 'package main

import (
"fmt"
"sort"
"reflect"
)

func main() {
// Declaring arrays
var array_int [10]int
var array_float [10]float32
var array_string [10]string
var array_complex [10]complex128

```
fmt.Println("Int type array:", array_int)
fmt.Println("Float type array:", array_float)
fmt.Println("String type array:", array_string)
fmt.Println("Complex type array:", array_complex)

// Initializing arrays
var arr1 [5]int = [5]int{1, 2, 3, 4, 5}
fmt.Println(arr1)

var arr2 [5]int
arr2[0], arr2[1], arr2[2], arr2[3], arr2[4] = 1, 2, 3, 4, 5
fmt.Println(arr2)

arr3 := [5]int{1, 2, 3, 4, 5}
fmt.Println(arr3)

var arr4 [5]int
arr4[1], arr4[3] = 2, 4
fmt.Println(arr4)

arr5 := [5]int{1, 2, 3}
fmt.Println(arr5)

arr6 := [...]int{1, 4, 7, 2, 7, 9, 3, 5}
fmt.Println(arr6)

// Names using array
names := [...]string{"aman", "rahul", "geet", "preeti"}
fmt.Printf("Names are %q\n", names)

// Multidimensional arrays
arr2D := [3][2]int{{1, 2}, {4, 5}, {7, 8}}
fmt.Println(arr2D)

arr2D2 := [3][2]int{{1, 2}, {7}}
fmt.Println(arr2D2)

var arr3D [3][3]int
arr3D[0], arr3D[1], arr3D[2] = [3]int{1, 2, 3}, [3]int{4, 5, 6}, [3]int{7, 8, 9}
fmt.Println(arr3D)

// Array comparison
arrA := [4]int{1, 4, 7, 2}
arrB := [4]int{1, 4, 7, 0}
arrC := [3][2]int{{1, 2}, {7}}
arrD := [3][2]int{{1, 1}, {7}}
fmt.Println("arrA == arrB:", arrA == arrB)
fmt.Println("arrC == arrD:", arrC == arrD)

// Copying arrays
arrF := [4]int{1, 4, 7, 2}
arrG := arrF
arrG[2] = 90
fmt.Println("arrF:", arrF)
fmt.Println("arrG:", arrG)

// Passing array to function
fmt.Println("Sum of array elements:", sum([4]int{1, 4, 7, 2}))

// Iteration over array
arrH := [...]int{1, 4, 7, 2, 7, 9, 3, 5}
sumH := 0
for _, v := range arrH {
	sumH += v
}
fmt.Println("Sum using range:", sumH)

// Slices initialization
slice1 := []int{1, 2, 3, 5}
slice2 := []int{1, 2, 3, 5}
fmt.Println("slice1:", slice1)
fmt.Println("slice2:", slice2)

// Slices from array
arrayval := [10]int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
slice3, slice4, slice5, slice6 := arrayval[3:7], arrayval[:6], arrayval[5:], arrayval[:]
fmt.Println(slice3, slice4, slice5, slice6)

// Slice copying
sliceA := []int{23, 56, 47, 58}
sliceB := []int{90, 107, 0, 67, 28, 89}
copy(sliceB, sliceA)
fmt.Println("sliceB after copy:", sliceB)

// Sorting slices
sliceSort1 := []int{23, 0, 105, 58}
sort.Ints(sliceSort1)
fmt.Println("sliceSort1 sorted:", sliceSort1)

// Searching in slices
sliceSearch := []int{0, 9, 16, 105, 345}
idx := sort.SearchInts(sliceSearch, 105)
fmt.Println("Index of 105:", idx)

// Reversing slices
sliceRev := []int{0, 888, 9, 16, 105, 345}
sort.Sort(sort.Reverse(sort.IntSlice(sliceRev)))
fmt.Println("sliceRev reversed:", sliceRev)

// Appending slices
sliceApp := []int{0, 888, 9, 16, 105, 345}
sliceApp = append(sliceApp, 345, 646, 0)
fmt.Println("sliceApp after append:", sliceApp)
```

}

// Sum function
func sum(arr [4]int) int {
sum := 0
for _, v := range arr {
sum += v
}
return sum
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.string_examples.full_string_examples
set output_file "string_examples.go"
set template_content 'package main

import (
"fmt"
"strings"
)

func main() {
introduction()
lengthOfString()
iterateString()
runesExample()
rangeIteration()
multilineString()
convertRuneSliceToString()
convertByteSliceToString()
immutableStrings()
charComparison()
caseConversion()
prefixSuffixSearch()
substringSearch()
countOccurrences()
findPosition()
findLastPosition()
convertArrayToString()
replaceString()
stringToSlice()
removeUnicodeCodepoints()
}

// Introduction
func introduction() {
var str string
fmt.Printf("By default strings are: %q\n", str)
str = "Hello Go"
fmt.Println("After assigning a value string is:", str)
str_new := "Hello world"
fmt.Printf("After shorthand declaration: %q\n", str_new)
fmt.Printf("Uninterpreted bytes: %s\n", str_new)
fmt.Printf("Base16 notation of str: %x\n", str)
}

// Length of string
func lengthOfString() {
str := "Hello Go"
fmt.Println("Length of str:", len(str))
str_new := "世Hello Go世"
fmt.Println("Length of str_new:", len(str_new))
}

// Iterate through string
func iterateString() {
str := "Hello Go"
fmt.Println("Characters of str:")
for i := 0; i < len(str); i++ {
fmt.Printf("%c ", str[i])
}
fmt.Println("\nUTF-8 encoded values:")
for i := 0; i < len(str); i++ {
fmt.Printf("%x ", str[i])
}
}

// Rune example
func runesExample() {
str_new := "世Hello Go世"
runeSlice := []rune(str_new)
fmt.Println("\nCharacters of str_new (using runes):")
for _, r := range runeSlice {
fmt.Printf("%c ", r)
}
}

// Iterate using range
func rangeIteration() {
str_new := "世Hello Go世"
fmt.Println("\nCharacters using range:")
for _, c := range str_new {
fmt.Printf("%c ", c)
}
}

// Multiline string
func multilineString() {
str := "Hello\nGo"
fmt.Println("Double quotes string:", str)
str_new := `Hello\nGo`
fmt.Println("Backtick string:", str_new)
str_new = `Hello
Go`
fmt.Println("Backtick with linebreak:", str_new)
}

// Convert slice of runes to string
func convertRuneSliceToString() {
runes := []rune{0x4e16, 0x0048, 0x0065, 0x006c, 0x006c, 0x006f, 0x0047, 0x006f, 0x4e16}
str := string(runes)
fmt.Println("String from slice of runes:", str)
}

// Convert slice of bytes to string
func convertByteSliceToString() {
bytes := []byte{228, 184, 150, 72, 101, 108, 108, 111, 71, 111, 228, 184, 150}
str := string(bytes)
fmt.Println("String from slice of bytes:", str)
}

// Immutable strings
func immutableStrings() {
str := "Hello Go"
fmt.Printf("Character at index 3: %c\n", str[3])
runes := []rune(str)
runes[3] = 'M'
str = string(runes)
fmt.Printf("After change, character at index 3: %c\n", str[3])
}

// Character comparison
func charComparison() {
if 'a' > 'A' {
fmt.Println("a > A")
}
fmt.Println("a > z:", 'a' > 'z')
for c := 'a'; c < 'm'; c++ {
fmt.Printf("%c ", c)
}
fmt.Println()
}

// Convert string to uppercase/lowercase
func caseConversion() {
str := "Hello Go"
fmt.Println("Uppercase:", strings.ToUpper(str))
fmt.Println("Lowercase:", strings.ToLower(str))
}

// Search for prefix/suffix
func prefixSuffixSearch() {
str := "Hello Go"
fmt.Println("Has prefix He:", strings.HasPrefix(str, "He"))
fmt.Println("Has prefix he:", strings.HasPrefix(str, "he"))
fmt.Println("Has suffix Go:", strings.HasSuffix(str, "Go"))
fmt.Println("Has suffix go:", strings.HasSuffix(str, "go"))
}

// Search for substring
func substringSearch() {
str := "Hello Go"
fmt.Println("Contains 'ellO':", strings.Contains(str, "ellO"))
fmt.Println("Contains 'o G':", strings.Contains(str, "o G"))
fmt.Println("ContainsAny 'welcome':", strings.ContainsAny(str, "welcome"))
fmt.Println("ContainsAny 'shubh':", strings.ContainsAny(str, "shubh"))
}

// Count occurrences
func countOccurrences() {
str := "Grow And Grow With Golang"
fmt.Println("Occurrences of 'Gr':", strings.Count(str, "Gr"))
fmt.Println("Occurrences of 'welcome':", strings.Count(str, "welcome"))
}

// Find position
func findPosition() {
str := "Grow And Grow With Golang"
fmt.Println("Index of 'Gr':", strings.Index(str, "Gr"))
fmt.Println("Index of 'welcome':", strings.Index(str, "welcome"))
fmt.Println("IndexAny 'Ground':", strings.IndexAny(str, "Ground"))
fmt.Println("LastIndex 'Gr':", strings.LastIndex(str, "Gr"))
fmt.Println("LastIndexAny 'Ground':", strings.LastIndexAny(str, "Ground"))
}

// Convert array to string
func convertArrayToString() {
arr := []string{"my", "name", "is", "rahul"}
fmt.Println("Joined string:", strings.Join(arr, "-"))
}

// Replace string
func replaceString() {
str := "my-name-is-rahul"
fmt.Println(strings.Replace(str, "-", " ", 1))
fmt.Println(strings.Replace(str, "-", " ", 9))
fmt.Println(strings.ReplaceAll(str, "-", " "))
}

// Convert string to slice
func stringToSlice() {
str := "my-name-is-rahul"
fmt.Println(strings.Split(str, "-"))
fmt.Println(strings.Split(str, ""))
fmt.Println(strings.Fields("welcome \t in the world of \n Go"))
}

// Remove specific Unicode codepoints / trim
func removeUnicodeCodepoints() {
str := "-my-name-is-rahul-"
fmt.Println(strings.Trim(str, "-"))
fmt.Println(strings.TrimLeft(str, "-"))
fmt.Println(strings.TrimRight(str, "-"))
fmt.Println(strings.TrimSpace("    -my-name-is-rahul-    "))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.pointers.full_pointers_examples
set output_file "pointers_examples.go"
set template_content 'package main

import (
"fmt"
)

func main() {
declarePointers()
initializePointers()
dereferencePointers()
manipulatePointers()
pointerWithNew()
nestedPointers()
arrayOfPointers()
passingPointerToFunctionByValue()
passingPointerToFunctionByReference()
}

// Declare pointers
func declarePointers() {
var pointerv *int
fmt.Println("Default value of pointer is:", pointerv) // <nil>
}

// Initialize pointers
func initializePointers() {
a := 10
var pointerv *int
pointerv = &a
fmt.Println("Pointer value (address of a):", pointerv)
fmt.Println("Address of pointer itself:", &pointerv)
}

// Dereferencing pointers
func dereferencePointers() {
a := 10
var pointerv *int
pointerv = &a
fmt.Println("Pointer value:", pointerv)
fmt.Println("Dereferenced value:", *pointerv)
}

// Manipulating pointers
func manipulatePointers() {
a := 10
var pointerv *int
pointerv = &a
fmt.Println("Original value:", *pointerv)
*pointerv = 30
fmt.Println("After assigning new value:", *pointerv)
}

// Pointer with new
func pointerWithNew() {
var a int
pointerv := &a
fmt.Println("Initial pointer:", pointerv)
pointerv = new(int)
fmt.Println("Pointer after new:", pointerv)
fmt.Println("Dereferenced value after new:", *pointerv)
*pointerv = 10
fmt.Println("Dereferenced value after assignment:", *pointerv)
}

// Nested pointers
func nestedPointers() {
var a int
pointerv := &a
fmt.Println("value of pointerv:", pointerv)
fmt.Println("Address of pointerv:", &pointerv)
pointerv1 := &pointerv
fmt.Println("value of pointerv1:", pointerv1)
fmt.Println("Address of pointerv1:", &pointerv1)
pointerv2 := &pointerv1
fmt.Println("value of pointerv2:", pointerv2)
fmt.Println("Address of pointerv2:", &pointerv2)
}

// Array of pointers
func arrayOfPointers() {
var a, b int
var pointerv [4]*int
pointerv[0] = &a
pointerv[3] = &b
fmt.Println("Array of pointers:", pointerv)
}

// Passing pointer to function by value
func passingPointerToFunctionByValue() {
a := "Welcome world"
pointerv := &a
fmt.Println("Value of a is:", *pointerv)
changeVal(a)
fmt.Println("After modification by value, a is:", *pointerv)
}
func changeVal(y string) {
y = "Hello Go!"
fmt.Println("Changed value inside function:", y)
}

// Passing pointer to function by reference
func passingPointerToFunctionByReference() {
a := "Welcome world"
pointerv := &a
fmt.Println("Value of a is:", *pointerv)
changeValRef(pointerv)
fmt.Println("After modification by reference, a is:", *pointerv)
}
func changeValRef(y *string) {
*y = "Hello Go!"
fmt.Println("Changed value inside function:", *y)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.structs.full_struct_examples
set output_file "struct_examples.go"
set template_content 'package main

import "fmt"

func main() {
declaringStruct()
anonymousStruct()
initializeStruct()
accessStructFields()
pointerToStruct()
structWithNew()
anonymousStructFields()
nestedStruct()
embeddedStruct()
passingStructToFunction()
compareStructs()
}

// Declaring struct
func declaringStruct() {
type student struct {
name, city string
rollno     int
}
var s student
fmt.Println("Declared struct:", s) // {  0}
}

// Anonymous struct
func anonymousStruct() {
var student struct {
name, city string
rollno     int
}
fmt.Println("Anonymous struct:", student)
}

// Initialize struct
func initializeStruct() {
type student struct {
name, city string
rollno     int
}
s := student{name: "rahul", city: "jaipur", rollno: 67}
fmt.Println("Initialized struct:", s)

```
// Anonymous struct
s1 := struct {
	name    string
	city    string
	rollno  int
}{name: "rahul", rollno: 67}
fmt.Println("Anonymous initialized struct:", s1)
```

}

// Access struct’s fields
func accessStructFields() {
var student struct {
name, city string
rollno     int
}
student.city = "jaipur"
student.rollno = 67
fmt.Println("Struct after field assignment:", student)
}

// Pointer to struct
func pointerToStruct() {
type student struct {
name, city string
rollno     int
}
s := student{"rahul", "jaipur", 67}
p := &s
fmt.Println("Pointer to struct:", p)
fmt.Println("Dereferenced pointer:", *p)
fmt.Println("Access via pointer:", p.city)
}

// Struct with new function
func structWithNew() {
type student struct {
name, city string
rollno     int
}
p := new(student)
fmt.Println("Struct created with new:", *p)
p.city = "jaipur"
p.rollno = 67
fmt.Println("After assigning fields:", *p)
}

// Anonymous struct fields
func anonymousStructFields() {
type student struct {
string
city string
int
}
s := student{"rahul", "jaipur", 67}
fmt.Println("Anonymous fields struct:", s)
}

// Nested struct
func nestedStruct() {
type result struct {
math, science, english int
isPass                  bool
}
type student struct {
name, city string
rollno     int
result     result
}
s := student{
name:   "Rahul",
city:   "Jaipur",
rollno: 11,
result: result{45, 78, 90, true},
}
fmt.Println("Nested struct, isPass:", s.result.isPass)
}

// Embedded struct
func embeddedStruct() {
type result struct {
math, science, english int
isPass                  bool
}
type student struct {
name, city string
rollno     int
result
}
s := student{"rahul", "jaipur", 11, result{45, 78, 90, true}}
fmt.Println("Embedded struct:", s)
}

// Passing struct to functions
type student struct {
name, city string
rollno     int
}
func getValue(s *student) string {
fmt.Println("Struct inside function:", s)
return s.name
}
func passingStructToFunction() {
s := student{"rahul", "jaipur", 67}
copy := s
fmt.Println("Struct copy:", copy)
fmt.Println("Access via function:", getValue(&copy))
}

// Compare structs
func compareStructs() {
s1 := struct {
name, city string
rollno     int
}{"rahul", "jaipur", 11}

```
s2 := struct {
	name, city string
	rollno     int
}{"rahul", "jaipur", 11}

fmt.Println("Structs equal:", s1 == s2)

s3 := struct {
	name, city string
	rollno     int
}{"rahul", "jaipur", 0}

fmt.Println("Struct comparison s1==s3:", s1 == s3)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.structs.full_struct_examples
set output_file "struct_examples.go"
set template_content 'package main

import "fmt"

func main() {
declaringStruct()
anonymousStruct()
initializeStruct()
accessStructFields()
pointerToStruct()
structWithNew()
anonymousStructFields()
nestedStruct()
embeddedStruct()
passingStructToFunction()
compareStructs()
}

// Declaring struct
func declaringStruct() {
type student struct {
name, city string
rollno     int
}
var s student
fmt.Println("Declared struct:", s) // {  0}
}

// Anonymous struct
func anonymousStruct() {
var student struct {
name, city string
rollno     int
}
fmt.Println("Anonymous struct:", student)
}

// Initialize struct
func initializeStruct() {
type student struct {
name, city string
rollno     int
}
s := student{name: "rahul", city: "jaipur", rollno: 67}
fmt.Println("Initialized struct:", s)

```
// Anonymous struct
s1 := struct {
	name    string
	city    string
	rollno  int
}{name: "rahul", rollno: 67}
fmt.Println("Anonymous initialized struct:", s1)
```

}

// Access struct’s fields
func accessStructFields() {
var student struct {
name, city string
rollno     int
}
student.city = "jaipur"
student.rollno = 67
fmt.Println("Struct after field assignment:", student)
}

// Pointer to struct
func pointerToStruct() {
type student struct {
name, city string
rollno     int
}
s := student{"rahul", "jaipur", 67}
p := &s
fmt.Println("Pointer to struct:", p)
fmt.Println("Dereferenced pointer:", *p)
fmt.Println("Access via pointer:", p.city)
}

// Struct with new function
func structWithNew() {
type student struct {
name, city string
rollno     int
}
p := new(student)
fmt.Println("Struct created with new:", *p)
p.city = "jaipur"
p.rollno = 67
fmt.Println("After assigning fields:", *p)
}

// Anonymous struct fields
func anonymousStructFields() {
type student struct {
string
city string
int
}
s := student{"rahul", "jaipur", 67}
fmt.Println("Anonymous fields struct:", s)
}

// Nested struct
func nestedStruct() {
type result struct {
math, science, english int
isPass                  bool
}
type student struct {
name, city string
rollno     int
result     result
}
s := student{
name:   "Rahul",
city:   "Jaipur",
rollno: 11,
result: result{45, 78, 90, true},
}
fmt.Println("Nested struct, isPass:", s.result.isPass)
}

// Embedded struct
func embeddedStruct() {
type result struct {
math, science, english int
isPass                  bool
}
type student struct {
name, city string
rollno     int
result
}
s := student{"rahul", "jaipur", 11, result{45, 78, 90, true}}
fmt.Println("Embedded struct:", s)
}

// Passing struct to functions
type student struct {
name, city string
rollno     int
}
func getValue(s *student) string {
fmt.Println("Struct inside function:", s)
return s.name
}
func passingStructToFunction() {
s := student{"rahul", "jaipur", 67}
copy := s
fmt.Println("Struct copy:", copy)
fmt.Println("Access via function:", getValue(&copy))
}

// Compare structs
func compareStructs() {
s1 := struct {
name, city string
rollno     int
}{"rahul", "jaipur", 11}

```
s2 := struct {
	name, city string
	rollno     int
}{"rahul", "jaipur", 11}

fmt.Println("Structs equal:", s1 == s2)

s3 := struct {
	name, city string
	rollno     int
}{"rahul", "jaipur", 0}

fmt.Println("Struct comparison s1==s3:", s1 == s3)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.structs.embedded_struct_demo
set output_file "embedded_structs_demo.go"
set template_content 'package main

import "fmt"

// --------------------
// Embedded structs
// --------------------
type websiteinfo struct {
name      string
url       string
ageinyear int
}

type youtube struct {
websiteinfo
ytFirstVideo  string
ytlongestvideo string
}

type amazon struct {
websiteinfo
departments string
can_sell    bool
}

func (web websiteinfo) basicInfo() {
fmt.Println("Name:", web.name)
fmt.Println("URL:", web.url)
fmt.Println("Age in years:", web.ageinyear)
}

func (yt youtube) youtubeInfo() {
fmt.Println("YouTube Info:")
fmt.Println("Name:", yt.name)
fmt.Println("URL:", yt.url)
fmt.Println("Age in years:", yt.ageinyear)
fmt.Println("First video:", yt.ytFirstVideo)
fmt.Println("Longest video:", yt.ytlongestvideo)
}

func (az amazon) amazonInfo() {
az.basicInfo()
fmt.Println("Departments:", az.departments)
fmt.Println("Can sell:", az.can_sell)
}

// --------------------
// Pointer embedded structs
// --------------------
type youtubePointer struct {
*websiteinfo
ytFirstVideo  string
ytlongestvideo string
}

// --------------------
// Slice of structs
// --------------------
type websitelist struct {
websites []websiteinfo
}

func (wl *websitelist) updateWebsiteAge(index int, newAge int) {
if index >= 0 && index < len(wl.websites) {
wl.websites[index].ageinyear = newAge
} else {
fmt.Println("Index out of range")
}
}

// --------------------
// Main demo function
// --------------------
func main() {
fmt.Println("=== Embedded structs demo ===")
youtube_var := youtube{websiteinfo{"Youtube", "[www.youtube.com](http://www.youtube.com)", 14}, "me at the zoo", "571 hours"}
amazon_var := amazon{websiteinfo{"Amazon", "[www.amazon.com](http://www.amazon.com)", 25}, "Electronics, Computers", true}

```
youtube_var.basicInfo()
amazon_var.amazonInfo()
youtube_var.youtubeInfo()

fmt.Println("\n=== Pointer embedded structs demo ===")
webinfo := &websiteinfo{"YouTube", "www.youtube.com", 14}
youtube_ptr := youtubePointer{webinfo, "Me at the zoo", "571 hours"}
youtube_ptr.websiteinfo.basicInfo()

fmt.Println("\n=== Slice of structs demo ===")
websiteData := []websiteinfo{
	{"YouTube", "www.youtube.com", 14},
	{"Google", "www.google.com", 25},
	{"Facebook", "www.facebook.com", 20},
}
websiteList := websitelist{websiteData}

fmt.Println("Before update:")
for i, site := range websiteList.websites {
	fmt.Printf("%d - %s, %s, %d\n", i, site.name, site.url, site.ageinyear)
}

websiteList.updateWebsiteAge(0, 15)

fmt.Println("\nAfter update:")
for i, site := range websiteList.websites {
	fmt.Printf("%d - %s, %s, %d\n", i, site.name, site.url, site.ageinyear)
}
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.interfaces.interfaces_demo
set output_file "interfaces_demo.go"
set template_content 'package main

import "fmt"

// --------------------
// Basic Interface
// --------------------
type AirthOperation interface {
Add() float32
Subtract(float32, float32) float32
Multiply(int, int) int
}

type Operandset1 struct {
op1 float32
op2 float32
}

func (o Operandset1) Add() float32 {
return o.op1 + o.op2
}

func (o Operandset1) Subtract(a, b float32) float32 {
return o.op1 - o.op2
}

type Operandset2 struct {
op1 int
op2 int
}

func (o Operandset2) Multiply(a, b int) int {
return o.op1 * o.op2
}

// --------------------
// Empty Interface
// --------------------
func showValue(i interface{}) {
fmt.Println(i)
}

// --------------------
// Multiple Interfaces
// --------------------
type CompareOperation interface {
Compare(a, b float32) bool
}

func (o Operandset1) Compare(a, b float32) bool {
return a == b
}

// --------------------
// Embedded Interface
// --------------------
type Operation interface {
AirthOperation
Compare() bool
}

// --------------------
// Type Assertion / Switch
// --------------------
func checkType(i interface{}) {
switch v := i.(type) {
case Operandset1:
fmt.Println("Operandset1:", v)
case Operandset2:
fmt.Println("Operandset2:", v)
default:
fmt.Println("Unknown type:", v)
}
}

// --------------------
// Main
// --------------------
func main() {
fmt.Println("=== Basic Interface ===")
var a AirthOperation = Operandset1{3.6, 6.9}
fmt.Println("Add:", a.Add())

```
fmt.Println("\n=== Empty Interface ===")
showValue(Operandset1{1, 2})
showValue("Hello")
showValue(3.14)

fmt.Println("\n=== Multiple Interface ===")
var m1 AirthOperation = Operandset1{5.5, 4.5}
fmt.Println("Add:", m1.Add())
var m2 CompareOperation = Operandset1{5.5, 5.5}
fmt.Println("Compare:", m2.Compare(5.5, 4.5))

fmt.Println("\n=== Type Assertion / Switch ===")
checkType(Operandset1{1.1, 2.2})
checkType(Operandset2{1, 2})
checkType("Test")

fmt.Println("\n=== Polymorphism ===")
var poly AirthOperation
poly = Operandset1{2.5, 3.5}
fmt.Println("Add Operandset1:", poly.Add())
poly = Operandset2{2, 3}
fmt.Println("Add Operandset2:", poly.Add())
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_declare
set output_file "map_declare.go"
set template_content 'package main

import "fmt"

func main() {
var phone_dict map[string]int64
fmt.Println(phone_dict) // map[]
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_initialize
set output_file "map_initialize.go"
set template_content 'package main

import "fmt"

func main() {
phone_dict1 := map[string]int64{}
phone_dict1["Rahul"] = 9876543201
fmt.Println(phone_dict1)

```
phone_dict2 := map[string]int64{
	"Rahul": 9876543201,
	"Swati": 9123456789,
}
phone_dict2["aayush"] = 9823165748
fmt.Println(phone_dict2["Swati"])

phone_dict3 := make(map[string]int64)
fmt.Println(phone_dict3) // map[]
phone_dict3["Rahul"] = 9876543201
phone_dict3["Swati"] = 9123456789
fmt.Println(phone_dict3)
fmt.Println(phone_dict3["aayush"])
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_length
set output_file "map_length.go"
set template_content 'package main

import "fmt"

func main() {
phone_dict3 := make(map[string]int64)
phone_dict3["Rahul"] = 9876543201
phone_dict3["Swati"] = 9123456789
fmt.Println(phone_dict3)
fmt.Println("length of phone_dict3:", len(phone_dict3))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_check_keys
set output_file "map_check_keys.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main() {
phone_dict3 := make(map[string]int64)
phone_dict3["Rahul"] = 9876543201
phone_dict3["Swati"] = 9123456789

```
mapkeys := reflect.ValueOf(phone_dict3).MapKeys()
fmt.Println("Keys of phone_dict3", mapkeys)

val, ok := phone_dict3["Swati"]
fmt.Println(ok, val)

val, ok = phone_dict3["Suman"]
fmt.Println(ok, val)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.map_iteration
set output_file "map_iteration.go"
set template_content 'package main

import (
"fmt"
"sort"
)

func main() {
phone_dict3 := make(map[string]int64)
phone_dict3["Rahul"] = 9876543201
phone_dict3["Swati"] = 9123456789
phone_dict3["Suman"] = 9675463768
phone_dict3["Mayank"] = 9342516789
phone_dict3["Deepak"] = 8765453678

```
var mapkeys []string
for itr := range phone_dict3 {
	fmt.Println(itr)
	mapkeys = append(mapkeys, itr)
}

sort.Strings(mapkeys)
for _, k := range mapkeys {
	fmt.Println("Key:", k, "Value:", phone_dict3[k])
}
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.map_delete
set output_file "map_delete.go"
set template_content 'package main

import "fmt"

func main() {
phone_dict3 := make(map[string]int64)
phone_dict3["Rahul"] = 9876543201
phone_dict3["Swati"] = 9123456789
phone_dict3["Suman"] = 9675463768
phone_dict3["Mayank"] = 9342516789
phone_dict3["Deepak"] = 8765453678

```
fmt.Println("Before deleting a key:", phone_dict3)
delete(phone_dict3, "Suman")
fmt.Println("After deleting a key:", phone_dict3)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_comparison
set output_file "map_comparison.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main() {
phone_dict := make(map[string]int64)
phone_dict["Rahul"] = 9876543201
phone_dict["Swati"] = 9123456789

```
phone_dict1 := make(map[string]int64)
phone_dict1["Rahul"] = 9876543201
phone_dict1["Swati"] = 9123456789

fmt.Println(phone_dict == nil)
fmt.Println(reflect.DeepEqual(phone_dict, phone_dict1))

phone_dict1["Swati"] = 1987654321
fmt.Println(reflect.DeepEqual(phone_dict, phone_dict1))
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoG.function.map_reference
set output_file "map_reference.go"
set template_content 'package main

import "fmt"

func change_value(phone_dict1 map[string]int64) {
phone_dict1["Mayank"] = 1234567890
}

func main() {
phone_dict := make(map[string]int64)
phone_dict["Rahul"] = 9876543201
phone_dict["Swati"] = 9123456789
phone_dict["Suman"] = 9675463768
phone_dict["Mayank"] = 9342516789
phone_dict["Deepak"] = 8765453678

```
fmt.Println("Before calling function, value of key 'Mayank' is:", phone_dict["Mayank"])
change_value(phone_dict)
fmt.Println("After calling function, value of key 'Mayank' is:", phone_dict["Mayank"])
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.goroutine_simple
set output_file "goroutine_simple.go"
set template_content 'package main

import "fmt"

func show_value(i int){
for i<10{
fmt.Println(i)
i = i+1
}
}

func main() {
show_value(0)
fmt.Println("We have called the function")
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.goroutine_call
set output_file "goroutine_call.go"
set template_content 'package main

import "fmt"

func show_value(i int){
for i<10{
fmt.Println(i)
i = i+1
}
}

func main() {
go show_value(0)
fmt.Println("We have called the function")
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.goroutine_scanln
set output_file "goroutine_scanln.go"
set template_content 'package main

import "fmt"

func show_value(i int){
for i<10{
fmt.Println(i)
i = i+1
}
}

func main() {
go show_value(0)
fmt.Println("We have called the function")
fmt.Scanln()
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.goroutine_sleep
set output_file "goroutine_sleep.go"
set template_content 'package main

import (
"fmt"
"time"
)

func show_value(i int){
for i<10{
fmt.Println(i)
time.Sleep(200 * time.Millisecond)
i = i+1
}
}

func main() {
go show_value(0)
fmt.Println("We have called a goroutine")
show_value(0)
fmt.Println("We have called a function")
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.multiple_goroutines
set output_file "multiple_goroutines.go"
set template_content 'package main

import (
"fmt"
"time"
)

func show_value(i int){
for i<10{
fmt.Println(i)
time.Sleep(200 * time.Millisecond)
i = i+1
}
}

func show_value1(c int){
for c<110{
fmt.Println(c)
time.Sleep(200 * time.Millisecond)
c = c+1
}
}

func main() {
go show_value(0)
fmt.Println("We have called a goroutine show_value")
go show_value1(100)
fmt.Println("We have called a goroutine show_value1")
fmt.Scanln()
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.wait_goroutines
set output_file "wait_goroutines.go"
set template_content 'package main

import (
"fmt"
"sync"
"time"
)

func show_value(i int, wg *sync.WaitGroup){
for i<10{
fmt.Println(i)
time.Sleep(200 * time.Millisecond)
i = i+1
}
wg.Done()
}

func show_value1(c int, wg *sync.WaitGroup){
for c<110{
fmt.Println(c)
time.Sleep(200 * time.Millisecond)
c = c+1
}
wg.Done()
}

func main() {
var wg sync.WaitGroup
wg.Add(2)

```
go show_value(0, &wg)
fmt.Println("We have called a goroutine show_value")

go show_value1(100, &wg)
fmt.Println("We have called a goroutine show_value1")

wg.Wait()
fmt.Println("Done")
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.channel_declare
set output_file "channel_declare.go"
set template_content 'package main

import "fmt"

func main(){
var ch1 chan int
fmt.Println("channel with var keyword:", ch1)
ch2 := make(chan string)
fmt.Println("channel with make method:", ch2)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.channel_send_receive
set output_file "channel_send_receive.go"
set template_content 'package main

import "fmt"

func show_value(c chan int){
c <- 8
}

func main(){
c := make(chan int)
go show_value(c)
a, ok := <-c
fmt.Println("Value received from channel:", a)
fmt.Println("Status of operation is:", ok)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.channel_buffered
set output_file "channel_buffered.go"
set template_content 'package main

import "fmt"

func main(){
ch := make(chan int, 2)
ch <- 8
ch <- 99
a := <-ch
b := <-ch
fmt.Println("Values received:", a, b)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.data_race
set output_file "data_race.go"
set template_content 'package main

import (
"fmt"
"sync"
)

var wg sync.WaitGroup
var value = 45

func update_value(){
if value == 45 {
value++
}
fmt.Println(value)
wg.Done()
}

func main(){
wg.Add(2)
go update_value()
go update_value()
wg.Wait()
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.mutex_example
set output_file "mutex_example.go"
set template_content 'package main

import (
"fmt"
"sync"
)

type initial_amount struct{
amount int
sync.Mutex
}

func (ia *initial_amount) withdraw_amount(val int){
ia.Lock()
ia.amount -= val
defer ia.Unlock()
}

func (ia *initial_amount) deposit_amount(val int){
ia.Lock()
ia.amount += val
defer ia.Unlock()
}

func (ia *initial_amount) get_balance() int {
ia.Lock()
val := ia.amount
defer ia.Unlock()
return val
}

func main(){
ia := initial_amount{amount:2000}
for i := 0; i < 10; i++ {
go ia.deposit_amount(500)
go ia.withdraw_amount(300)
}
final_balance := ia.get_balance()
fmt.Println("Final balance is:", final_balance)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.rwmutex_example
set output_file "rwmutex_example.go"
set template_content 'package main

import (
"fmt"
"sync"
"time"
)

type MapStruct struct{
map_val map[int]int
sync.RWMutex
}

func (m *MapStruct) update_map(key int){
m.Lock()
m.map_val[key] = key * 10
m.Unlock()
}

func (m *MapStruct) read_map(){
m.RLock()
val := m.map_val
m.RUnlock()
fmt.Println(val)
}

func main(){
ms := MapStruct{map_val: make(map[int]int)}
for i := 1; i < 10; i++{
go ms.update_map(i)
go ms.read_map()
}
time.Sleep(5 * time.Second)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.error_intro
set output_file "error_intro.go"
set template_content 'package main

import (
"fmt"
"os"
)

func main(){
file, err := os.Open("./example.json")
fmt.Println("file status:", file)
fmt.Println("error status:", err)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.custom_error
set output_file "custom_error.go"
set template_content 'package main

import "fmt"

type My_error struct{}

func (e *My_error) Error() string {
return "Unexpected outcome"
}

func main(){
obj := My_error{}
fmt.Println(obj.Error())
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.error_package
set output_file "error_package.go"
set template_content 'package main

import (
"fmt"
"os"
"errors"
)

func main(){
file, err := os.Open("./example.json")
if err != nil {
error_msg := errors.New("file operation failed")
fmt.Println(error_msg)
} else {
fmt.Println("file opened successfully", file)
}
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.defer_statement
set output_file "defer_statement.go"
set template_content 'package main

import (
"fmt"
"os"
)

func open_file(){
file, err := os.Open("./example.txt")
defer file.Close()
fmt.Println("file status:", file)
fmt.Println("error status:", err)
}

func main(){
open_file()
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.defer_loop
set output_file "defer_loop.go"
set template_content 'package main

import "fmt"

func show_value(){
for i:=0; i<=10; i++{
defer fmt.Println("value:", i)
}
}

func main(){
show_value()
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.defer_update_return
set output_file "defer_update_return.go"
set template_content 'package main

import "fmt"

func update_return_value() (i int){
defer func(){ i = i + 10 }()
return 1
}

func main(){
fmt.Println("updated return value:", update_return_value())
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.panic_example
set output_file "panic_example.go"
set template_content 'package main

import "fmt"

func op(a, b int) int {
if b == 0 {
panic("Cannot divide a number by zero!")
}
return a / b
}

func main(){
result := op(10, 0)
fmt.Println("Completed", result)
}'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.panic_defer
set output_file "panic_defer.go"
set template_content 'package main

import "fmt"

func op_defer(){
fmt.Println("op defer executed")
}

func main_defer(){
fmt.Println("main defer executed")
}

func op(a, b int) int {
defer op_defer()
if b == 0 {
panic("Cannot divide by zero!")
}
return a / b
}

func main(){
defer main_defer()
result := op(10, 0)
fmt.Println("Completed", result)
}'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.function.recover_example
set output_file "recover_example.go"
set template_content 'package main

import "fmt"

func op_defer(){
fmt.Println("op defer executed")
}

func main_defer(){
fmt.Println("main defer executed")
}

func op(a, b int) int {
defer func(){
if r := recover(); r != nil {
fmt.Println("Panic recovered:", r)
op_defer()
}
}()
if b == 0 {
panic("Cannot divide by zero!")
}
return a / b
}

func main(){
defer main_defer()
result := op(10, 0)
fmt.Println("Completed", result)
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_intro
set output_file "reflection_intro.go"
set template_content 'package main

func main(){
slice_val := []string{"one", "two", "three", "four", "five", "six"}
map_val := map[string]int64{}
for i := 0; i < len(slice_val); i++ {
map_val[slice_val[i]] = 0
}
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_type
set output_file "reflection_type.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name string
age  int
}

stu := student{"Akansha", 17}
fmt.Println(stu)
stu_type := reflect.TypeOf(stu)
fmt.Println("type of 'stu' variable:", stu_type)
fmt.Println("type of 'stu_type' variable:", reflect.TypeOf(stu_type))
fmt.Println("name of 'stu' variable type:", stu_type.Name())


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_value
set output_file "reflection_value.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name string
age  int
}


stu := student{"Akansha", 17}
fmt.Println(stu)
stu_type := reflect.TypeOf(stu)
fmt.Println("value of 'stu' variable:", reflect.ValueOf(stu))
fmt.Println("value of 'stu_type' variable:", reflect.ValueOf(stu_type))


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_kind
set output_file "reflection_kind.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name string
age  int
}

stu := student{"Akansha", 17}
stu_type := reflect.TypeOf(stu)
stu_kind := stu_type.Kind()
fmt.Println("type of 'stu' variable:", stu_type.Name())
fmt.Println("kind of 'stu_type' variable:", stu_kind)

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_numfield
set output_file "reflection_numfield.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name string
age  int
}


stu := student{"Akansha", 17}
stu_value := reflect.ValueOf(stu)
num_fields := stu_value.NumField()
fmt.Println("number of fields in 'stu':", num_fields, reflect.TypeOf(stu_value))
stu_type := reflect.TypeOf(stu)
fmt.Println("number of fields in 'stu':", num_fields, reflect.TypeOf(stu_type))


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_field
set output_file "reflection_field.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name string
age  int
}


stu := student{"Akansha", 17}
stu_value := reflect.ValueOf(stu)
num_fields := stu_value.NumField()
for i := 0; i < num_fields; i++ {
	fmt.Printf("value of %dth field is:%v of type %T\n", i+1, stu_value.Field(i), stu_value.Field(i))
}


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_types
set output_file "reflection_types.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func main(){
type student struct{
name   string
age    int
income float32
}


stu := student{"Akansha", 17, 40000.565}
stu_value := reflect.ValueOf(stu)

name := reflect.ValueOf(stu.name).String()
age := reflect.ValueOf(stu.age).Int()
income := reflect.ValueOf(stu.income).Float()

fmt.Printf("name: %v, type: %T\n", name, name)
fmt.Printf("age: %v, type: %T\n", age, age)
fmt.Printf("income: %v, type: %T\n", income, income)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.reflection_rule1
set output_file "reflection_rule1.go"
set template_content 'package main

import (
"fmt"
"reflect"
)

func show_value(i interface{}){
value_type := reflect.TypeOf(i)
value := reflect.ValueOf(i)
fmt.Printf("Passed value is %v of type %v\n", value, value_type.Kind())
fmt.Println(reflect.TypeOf(value))
fmt.Println(reflect.TypeOf(value_type))
}

func main(){
type student struct{
name   string
age    int
income float32
}

stu := student{"Akansha", 17, 40000.565}
show_value(stu)


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoGo.BinarySearch.BinSearch2
set output_file "binary_search.go"
set template_content 'package main

import (
"fmt"
"sort"
)

func BinSearch(array []int, key int) int {
low := 0
high := len(array) - 1


for low <= high {
	mid := (low + high) / 2
	if key == array[mid] {
		return mid
	} else if key < array[mid] {
		high = mid - 1
	} else {
		low = mid + 1
	}
}

return -1


}

func main() {
array := []int{1, 5, 8, 9, 18, 21, 25, 27}

// Binary search
fmt.Println("Custom BinSearch result for 18:", BinSearch(array, 18))

// Using sort.SearchInts
fmt.Println("sort.SearchInts result for 9:", sort.SearchInts(array, 9))

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoGo.BinarySearch.SeqSearch1
set output_file "seq_search.go"
set template_content 'package main

import "fmt"

func SeqSearch(array []int, key int) int {
for i := 0; i < len(array); i++ {
if key == array[i] {
return i
}
}
return -1
}

func SeqSearchRange(array []int, key int) int {
for i, elem := range array {
if key == elem {
return i
}
}
return -1
}

func main() {
array := []int{1, 18, 5, 27, 8, 25, 9, 21}


fmt.Println("SeqSearch result for 27:", SeqSearch(array, 27))
fmt.Println("SeqSearchRange result for 27:", SeqSearchRange(array, 27))


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Sorting.Bubble
set output_file "bubble_sort.go"
set template_content 'package main

import (
"fmt"
)

func BubbleSort(array []int) []int {
n := len(array)
for i := 0; i < n-1; i++ {
for j := 0; j < n-i-1; j++ {
if array[j] > array[j+1] {
array[j], array[j+1] = array[j+1], array[j]
}
}
}
return array
}

func main() {
array := []int{18, 1, 5, 27, 8, 25, 9, 21}
fmt.Println("Original array:", array)
fmt.Println("BubbleSort:", BubbleSort(array))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.Sorting.Insertion
set output_file "insertion_sort.go"
set template_content 'package main

import (
"fmt"
)

func InsertionSort(array []int) []int {
for i := 1; i < len(array); i++ {
key := array[i]
j := i - 1
for j >= 0 && array[j] > key {
array[j+1] = array[j]
j--
}
array[j+1] = key
}
return array
}

func main() {
array := []int{18, 1, 5, 27, 8, 25, 9, 21}
fmt.Println("Original array:", array)
fmt.Println("InsertionSort:", InsertionSort(array))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Sorting.Selection
set output_file "selection_sort.go"
set template_content 'package main

import (
"fmt"
)

func SelectionSort(array []int) []int {
for i := 0; i < len(array)-1; i++ {
min := array[i]
pos := i
for j := i + 1; j < len(array); j++ {
if array[j] < min {
min = array[j]
pos = j
}
}
array[pos] = array[i]
array[i] = min
}
return array
}

func main() {
array := []int{18, 1, 5, 27, 8, 25, 9, 21}
fmt.Println("Original array:", array)
fmt.Println("SelectionSort:", SelectionSort(array))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Sorting.Quick
set output_file "quick_sort.go"
set template_content 'package main

import (
"fmt"
)

func QuickSort(array []int, low, high int) []int {
if low < high {
array, j := partition(array, low, high)
QuickSort(array, low, j-1)
QuickSort(array, j+1, high)
}
return array
}

func partition(array []int, low, high int) ([]int, int) {
pivot := array[low]
i := low
j := high
for i < j {
for i < j && array[i] <= pivot {
i++
}
for array[j] > pivot {
j--
}
if i < j {
array[i], array[j] = array[j], array[i]
}
}
array[low], array[j] = array[j], pivot
return array, j
}

func main() {
array := []int{18, 1, 5, 27, 8, 25, 9, 21}
fmt.Println("Original array:", array)
fmt.Println("QuickSort:", QuickSort(array, 0, len(array)-1))
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.List.LinkedList
set output_file "linked_list_demo.go"
set template_content 'package main

import (
"fmt"
)

type Node struct {
next  *Node
value int
}

type List struct {
head *Node
len  int
}

func New() List {
return List{
head: nil,
len:  0,
}
}

func (l *List) Insert(v int) {
node := Node{value: v, next: l.head}
l.head = &node
l.len++
}

func (l *List) InsertOrdered(v int) {
node := Node{value: v}

if l.head == nil || l.head.value >= v {
	node.next = l.head
	l.head = &node
	l.len++
	return
}

temp := l.head
for temp.next != nil && temp.next.value < v {
	temp = temp.next
}

node.next = temp.next
temp.next = &node
l.len++

}

func (l *List) Remove(v int) {
if l.head == nil {
return
}

if l.head.value == v {
	l.head = l.head.next
	l.len--
	return
}

for temp := l.head; temp.next != nil; temp = temp.next {
	if temp.next.value == v {
		temp.next = temp.next.next
		l.len--
		return
	}
}


}

func (l *List) Find(v int) *Node {
for temp := l.head; temp != nil; temp = temp.next {
if temp.value == v {
return temp
}
}
return nil
}

func (l *List) Concatenate(l2 List) {
if l.head == nil {
l.head = l2.head
} else {
temp := l.head
for temp.next != nil {
temp = temp.next
}
temp.next = l2.head
}
l.len += l2.len
l2.head = nil
l2.len = 0
}

func (l *List) Print() {
fmt.Print("[")
for temp := l.head; temp != nil; temp = temp.next {
if temp.next != nil {
fmt.Printf("%v, ", temp.value)
} else {
fmt.Print(temp.value)
}
}
fmt.Println("]")
}

func main() {
l1 := New()
l1.Insert(1)
l1.Insert(18)
l1.Insert(9)
l1.Insert(21)
fmt.Print("List 1: ")
l1.Print()

```
l1.Remove(9)
fmt.Print("After removing 9: ")
l1.Print()

l2 := New()
l2.InsertOrdered(5)
l2.InsertOrdered(27)
l2.InsertOrdered(25)
l2.InsertOrdered(8)
fmt.Print("List 2 (ordered insert): ")
l2.Print()

n1 := l1.Find(18)
fmt.Println("Found 18 in List 1:", n1)

n2 := l1.Find(27)
fmt.Println("Found 27 in List 1:", n2)

l1.Concatenate(l2)
fmt.Print("After concatenation: ")
l1.Print()
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.Queue.Queue_template
set output_file "queue.go"
set template_content 'package main

import (
"container/list"
"fmt"
)

type Queue struct {
queue *list.List
}

func NewQueue() *Queue {
return &Queue{queue: list.New()}
}

func (q *Queue) Enqueue(v int) {
q.queue.PushBack(v)
}

func (q *Queue) Dequeue() int {
if q.queue.Len() == 0 {
return -1
}
element := q.queue.Front()
q.queue.Remove(element)
return element.Value.(int)
}

func (q *Queue) Print() {
fmt.Print("[")
for e := q.queue.Front(); e != nil; e = e.Next() {
if e.Next() != nil {
fmt.Printf("%v, ", e.Value)
} else {
fmt.Print(e.Value)
}
}
fmt.Println("]")
}

func main() {
q := NewQueue()
q.Enqueue(27)
q.Enqueue(5)
q.Enqueue(1)
q.Enqueue(18)


fmt.Print("Queue: ")
q.Print()

fmt.Println("Dequeue:", q.Dequeue())
fmt.Println("Dequeue:", q.Dequeue())
fmt.Print("Queue after dequeue: ")
q.Print()

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Queue.PriorityQueu
set output_file "priority_queue.go"
set template_content 'package main

import (
"container/heap"
"fmt"
)

type Element struct {
value int
}

type PriorityQueue []Element

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].value < pq[j].value }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x any) {
*pq = append(*pq, x.(Element))
}

func (pq *PriorityQueue) Pop() any {
old := *pq
n := len(old)
if n == 0 {
return nil
}
elem := old[n-1]
*pq = old[0 : n-1]
return elem
}

func main() {
pq := &PriorityQueue{}
heap.Init(pq)

heap.Push(pq, Element{27})
heap.Push(pq, Element{5})
heap.Push(pq, Element{1})
heap.Push(pq, Element{18})

fmt.Println("PriorityQueue:", *pq)

for pq.Len() > 0 {
	elem := heap.Pop(pq).(Element)
	fmt.Println("Pop:", elem.value)
}
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Stack.StackTemplate
set output_file "stack.go"
set template_content 'package main

import (
"fmt"
)

type Stack struct {
stack        []int
stackPointer int
}

func NewStack() *Stack {
return &Stack{
stack:        []int{},
stackPointer: -1,
}
}

func (s *Stack) Push(v int) {
s.stack = append(s.stack, v)
s.stackPointer = len(s.stack) - 1
}

func (s *Stack) Pop() int {
if s.stackPointer == -1 {
return -1
}
element := s.stack[s.stackPointer]
s.stack = s.stack[:s.stackPointer]
s.stackPointer--
return element
}

func (s *Stack) Peek() int {
if s.stackPointer == -1 {
return -1
}
return s.stack[s.stackPointer]
}

func (s *Stack) Len() int {
return len(s.stack)
}

func main() {
stack := NewStack()
stack.Push(5)
stack.Push(10)
stack.Push(20)
fmt.Println("Stack length:", stack.Len())
fmt.Println("Pop:", stack.Pop())
fmt.Println("Peek:", stack.Peek())
fmt.Println("Pop:", stack.Pop())
fmt.Println("Pop:", stack.Pop())
fmt.Println("Pop from empty stack:", stack.Pop())
}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.function.map_template
set output_file "map_example.go"
set template_content 'package main

import "fmt"

func main() {
m := map[string]int{
"Monday":    1,
"Tuesday":   2,
"Wednesday": 3,
"Thursday":  4,
"Friday":    5,
"Saturday":  6,
"Sunday":    7,
}

// Iterate over map
fmt.Println("Original map:")
for key, value := range m {
	fmt.Println(key, value)
}

// Update element
m["Monday"] = 0
fmt.Println("\nAfter update:")
for key, value := range m {
	fmt.Println(key, value)
}

// Get element
day := m["Monday"]
fmt.Println("\nGet element Monday:", day)

// Delete element
delete(m, "Thursday")
fmt.Println("\nAfter delete Thursday:")
for key, value := range m {
	fmt.Println(key, value)
}

// Check if element exists
if day, ok := m["Monday"]; ok {
	fmt.Println("\nMonday exists with value:", day)
} else {
	fmt.Println("\nMonday does not exist")
}


}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Tree.BinaryTree.Binary
set output_file "binarytree_example.go"
set template_content 'package main

import "fmt"

type Node struct {
value  int
left   *Node
right  *Node
parent *Node
}

type BinaryTree struct {
root *Node
}

func (bt *BinaryTree) Insert(node *Node, side string, value int) *Node {
newNode := &Node{value: value}
if bt.root == nil {
bt.root = newNode
return newNode
}
if side == "left" {
if node.left != nil {
newNode.left = node.left
}
node.left = newNode
} else {
if node.right != nil {
newNode.right = node.right
}
node.right = newNode
}
newNode.parent = node
return newNode
}

func (bt *BinaryTree) Delete(node *Node) {
if node.left == nil && node.right == nil {
if node.parent != nil {
if node.parent.left == node {
node.parent.left = nil
} else {
node.parent.right = nil
}
} else {
bt.root = nil
}
} else {
leftmost := node
for leftmost.left != nil || leftmost.right != nil {
if leftmost.left != nil {
leftmost = leftmost.left
} else {
leftmost = leftmost.right
}
}
node.value = leftmost.value
if leftmost.parent.left == leftmost {
leftmost.parent.left = nil
} else {
leftmost.parent.right = nil
}
}
}

func Preorder(node *Node) {
if node != nil {
fmt.Println(node.value)
Preorder(node.left)
Preorder(node.right)
}
}

func main() {
bt := &BinaryTree{}
n1 := bt.Insert(nil, "left", 10)
n2 := bt.Insert(n1, "left", 5)
n3 := bt.Insert(n1, "right", 15)
n4 := bt.Insert(n3, "left", 12)

```
fmt.Println("Preorder traversal:")
Preorder(bt.root)

bt.Delete(n2)
fmt.Println("After deleting 5:")
Preorder(bt.root)

bt.Delete(n3)
fmt.Println("After deleting 15:")
Preorder(bt.root)
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Tree.BinaryTree.Heap
set output_file "heap_example.go"
set template_content 'package main

import (
"container/heap"
"fmt"
)

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] } // max-heap
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *IntHeap) Push(v any) {
*h = append(*h, v.(int))
}

func (h *IntHeap) Pop() any {
old := *h
n := len(old)
v := old[n-1]
*h = old[0 : n-1]
return v
}

func main() {
h := &IntHeap{3, 1, 4, 1, 5, 9}
heap.Init(h)

```
fmt.Println("Heap elements:")
for h.Len() > 0 {
	fmt.Println(heap.Pop(h))
}
```

}'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Tree.BinaryTree.PriorityQueue
set output_file "priorityqueue_example.go"
set template_content 'package main

import (
"container/heap"
"fmt"
)

type WeightNode struct {
value  int
weight int
left   *WeightNode
right  *WeightNode
}

type Element struct {
value WeightNode
}

type PriorityQueue []Element

func (pq PriorityQueue) Len() int { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].value.weight < pq[j].value.weight }
func (pq PriorityQueue) Swap(i, j int) { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(v any) {
element := Element{value: v.(WeightNode)}
*pq = append(*pq, element)
}

func (pq *PriorityQueue) Pop() any {
old := *pq
n := len(old)
element := old[n-1]
*pq = old[0 : n-1]
return element
}

func main() {
pq := &PriorityQueue{}
heap.Init(pq)


heap.Push(pq, WeightNode{value: 1, weight: 10})
heap.Push(pq, WeightNode{value: 2, weight: 5})
heap.Push(pq, WeightNode{value: 3, weight: 20})

fmt.Println("PriorityQueue elements (by weight):")
for pq.Len() > 0 {
	node := heap.Pop(pq).(Element).value
	fmt.Println("Value:", node.value, "Weight:", node.weight)
}


}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Tree.BinaryTree.Queue
set output_file "queue_example.go"
set template_content 'package main

import (
"container/list"
"fmt"
)

type Node struct {
value int
}

type Queue struct {
queue *list.List
}

func NewQueue() *Queue {
return &Queue{queue: list.New()}
}

func (q *Queue) Enqueue(node *Node) {
q.queue.PushFront(node)
}

func (q *Queue) Dequeue() *Node {
if q.queue.Len() == 0 {
return nil
}
elem := q.queue.Back()
q.queue.Remove(elem)
return elem.Value.(*Node)
}

func (q *Queue) IsEmpty() bool {
return q.queue.Len() == 0
}

func main() {
q := NewQueue()
q.Enqueue(&Node{value: 10})
q.Enqueue(&Node{value: 20})
q.Enqueue(&Node{value: 30})


fmt.Println("Dequeue elements:")
for !q.IsEmpty() {
	node := q.Dequeue()
	fmt.Println(node.value)
}


}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Tree.BinaryTree.Sort
set output_file "array_tree_example.go"
set template_content 'package main

import (
"container/heap"
"fmt"
)

type Node struct {
value  int
left   *Node
right  *Node
parent *Node
}

type BinaryTree struct {
root *Node
}

type IntHeap []int

func (h IntHeap) Len() int           { return len(h) }
func (h IntHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h *IntHeap) Push(x any)        { *h = append(*h, x.(int)) }
func (h *IntHeap) Pop() any {
old := *h
n := len(old)
x := old[n-1]
*h = old[0 : n-1]
return x
}

func (bt *BinaryTree) Insert(node *Node, side string, value int) *Node {
newNode := &Node{value: value}
if bt.root == nil {
bt.root = newNode
return newNode
}
if side == "left" {
if node.left != nil {
newNode.left = node.left
}
node.left = newNode
} else {
if node.right != nil {
newNode.right = node.right
}
node.right = newNode
}
newNode.parent = node
return newNode
}

func ArrayToTree(array []int) *Node {
var bt BinaryTree
root := bt.Insert(nil, "left", array[0])
for i := 1; i < len(array); i++ {
side, node := find(array[i], root)
bt.Insert(node, side, array[i])
}
return root
}

func find(value int, root *Node) (side string, node *Node) {
next := root
for next != nil {
node = next
if value <= next.value {
side = "left"
next = next.left
} else {
side = "right"
next = next.right
}
}
return
}

func Heapsort(array *IntHeap) []int {
heap.Init(array)
n := array.Len()
sortedArray := make([]int, n)
for i := n - 1; array.Len() > 0; i-- {
sortedArray[i] = heap.Pop(array).(int)
}
return sortedArray
}

func main() {
arr := []int{10, 5, 15, 12, 7}
root := ArrayToTree(arr)
fmt.Println("Tree root:", root.value)

```
h := &IntHeap{3, 1, 4, 2}
sorted := Heapsort(h)
fmt.Println("Heapsort result:", sorted)
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.Graph.FlowGraph
set output_file "flowgraph_example.go"
set template_content 'package main

import "fmt"

type Node struct {
value int
}

type FlowEdge struct {
u, v     Node
capacity int
flow     int
}

type FlowGraph struct {
nodes map[Node]struct{}
edges map[FlowEdge]struct{}
}

func NewFlowGraph() *FlowGraph {
return &FlowGraph{
nodes: make(map[Node]struct{}),
edges: make(map[FlowEdge]struct{}),
}
}

func (fg *FlowGraph) AddNode(n Node) {
fg.nodes[n] = struct{}{}
}

func (fg *FlowGraph) AddEdge(u, v Node, c int) {
e := FlowEdge{u, v, c, 0}
fg.edges[e] = struct{}{}
}

func (fg *FlowGraph) RemoveNode(n Node) {
delete(fg.nodes, n)
for e := range fg.edges {
if e.u == n || e.v == n {
delete(fg.edges, e)
}
}
}

func AugmentingPath(g *FlowGraph, source, target Node) (ok bool, path []FlowEdge) {
ok = false
visit := make(map[int]bool)
for n := range g.nodes {
visit[n.value] = false
}
visit[source.value] = true
queue := []*Node{&source}
for len(queue) > 0 {
u := queue[0]
queue = queue[1:]
for edge := range g.edges {
if edge.u.value == u.value && !visit[edge.v.value] && edge.capacity != edge.flow {
visit[edge.v.value] = true
path = append(path, edge)
n := edge.v
queue = append(queue, &n)
if edge.v.value == target.value {
ok = true
return
}
}
}
}
return
}

func FordFulkerson(graph *FlowGraph, source, target Node) int {
for e := range graph.edges {
e.flow = 0
}

```
maxFlow := 0
ok, path := AugmentingPath(graph, source, target)
for ok {
	cf := INF
	for _, edge := range path {
		if edge.capacity-edge.flow < cf {
			cf = edge.capacity - edge.flow
		}
	}
	for _, edge := range path {
		delete(graph.edges, edge)
		edge.flow += cf
		graph.edges[edge] = struct{}{}
	}
	maxFlow += cf
	ok, path = AugmentingPath(graph, source, target)
}
return maxFlow
```

}

const INF = 1 << 30

func main() {
g := NewFlowGraph()
a := Node{1}
b := Node{2}
c := Node{3}
g.AddNode(a)
g.AddNode(b)
g.AddNode(c)
g.AddEdge(a, b, 10)
g.AddEdge(b, c, 5)

```
maxFlow := FordFulkerson(g, a, c)
fmt.Println("Max flow:", maxFlow)
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Graph.Graph
set output_file "graph_example.go"
set template_content 'package main

import "fmt"

type Node struct {
value int
}

func NewNode(value int) Node {
return Node{value}
}

type Edge struct {
u, v Node
}

type Graph struct {
nodes map[Node]struct{}
edges map[Edge]struct{}
}

func NewGraph() *Graph {
return &Graph{
nodes: make(map[Node]struct{}),
edges: make(map[Edge]struct{}),
}
}

func (g *Graph) AddNode(n Node) {
g.nodes[n] = struct{}{}
}

func (g *Graph) AddEdge(u, v Node) {
e := Edge{u, v}
g.edges[e] = struct{}{}
}

func (g *Graph) RemoveNode(n Node) {
delete(g.nodes, n)
for e := range g.edges {
if e.u == n || e.v == n {
delete(g.edges, e)
}
}
}

// BFS traversal
func BFS(g *Graph, start *Node) {
visit := make(map[int]bool)
for n := range g.nodes {
visit[n.value] = false
}
visit[start.value] = true
queue := []*Node{start}
for len(queue) > 0 {
u := queue[0]
queue = queue[1:]
for edge := range g.edges {
if edge.u.value == u.value && !visit[edge.v.value] {
visit[edge.v.value] = true
queue = append(queue, &edge.v)
}
}
}
}

// DFS traversal
func DFS(g *Graph, start *Node) {
visit := make(map[int]bool)
for n := range g.nodes {
visit[n.value] = false
}
dfsVisit(g, start, visit)
}

func dfsVisit(g *Graph, u *Node, visit map[int]bool) {
visit[u.value] = true
for edge := range g.edges {
if edge.u.value == u.value && !visit[edge.v.value] {
dfsVisit(g, &edge.v, visit)
}
}
}

func main() {
g := NewGraph()
a := NewNode(1)
b := NewNode(2)
c := NewNode(3)
g.AddNode(a)
g.AddNode(b)
g.AddNode(c)
g.AddEdge(a, b)
g.AddEdge(b, c)

```
fmt.Println("Graph nodes:", g.nodes)
fmt.Println("Graph edges:", g.edges)

BFS(g, &a)
DFS(g, &a)
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Graph.MST
set output_file "mst_example.go"
set template_content 'package main

import "fmt"

type Node struct {
value int
}

func NewNode(value int) Node {
return Node{value}
}

type WeightedEdge struct {
u, v   Node
weight int
}

type MST struct {
nodes map[Node]struct{}
edges map[WeightedEdge]struct{}
}

func NewMST() *MST {
return &MST{
nodes: make(map[Node]struct{}),
edges: make(map[WeightedEdge]struct{}),
}
}

func (m *MST) AddNode(n Node) {
m.nodes[n] = struct{}{}
}

func (m *MST) AddEdge(u, v Node, weight int) {
e := WeightedEdge{u, v, weight}
m.edges[e] = struct{}{}
}

func (m MST) Print() {
fmt.Println("Nodes:")
for n := range m.nodes {
fmt.Printf("%v ", n.value)
}
fmt.Println("\nEdges:")
for e := range m.edges {
fmt.Printf("{%v -> %v : %v} ", e.u.value, e.v.value, e.weight)
}
fmt.Println()
}

func main() {
mst := NewMST()
a := NewNode(1)
b := NewNode(2)
c := NewNode(3)

```
mst.AddNode(a)
mst.AddNode(b)
mst.AddNode(c)

mst.AddEdge(a, b, 5)
mst.AddEdge(b, c, 7)

mst.Print()
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Graph.PriorityQueu
set output_file "pq_mst_example.go"
set template_content 'package main

import (
"fmt"
)

// Node для графа
type Node struct {
value int
}

func NewNode(value int) Node {
return Node{value}
}

// WeightedEdge для MST
type WeightedEdge struct {
u, v   Node
weight int
}

// Element обгортка для PriorityQueue
type Element struct {
value WeightedEdge
}

// PriorityQueue реалізація min-heap для WeightedEdge
type PriorityQueue []Element

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].value.weight < pq[j].value.weight }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }
func (pq *PriorityQueue) Push(v any)        { *pq = append(*pq, Element{v.(WeightedEdge)}) }
func (pq *PriorityQueue) Pop() any {
old := *pq
n := len(old)
elem := old[n-1]
*pq = old[0:n-1]
return elem
}

func main() {
a := NewNode(1)
b := NewNode(2)
c := NewNode(3)

```
pq := &PriorityQueue{}
pq.Push(WeightedEdge{a, b, 5})
pq.Push(WeightedEdge{b, c, 7})
pq.Push(WeightedEdge{a, c, 3})

fmt.Println("Edges in priority order:")
for pq.Len() > 0 {
	e := pq.Pop().(Element)
	fmt.Printf("{%v -> %v : %v}\n", e.value.u.value, e.value.v.value, e.value.weight)
}
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.Graph.QueueGraph
set output_file "queue_graph_example.go"
set template_content 'package main

import (
"container/list"
"fmt"
)

// Node для графа
type Node struct {
value int
}

func NewNode(value int) *Node {
return &Node{value}
}

// Queue реалізація черги для графів
type Queue struct {
queue *list.List
}

func NewQueue() *Queue {
return &Queue{queue: list.New()}
}

func (q *Queue) Enqueue(node *Node) {
q.queue.PushFront(node)
}

func (q *Queue) Dequeue() *Node {
if q.queue.Len() == 0 {
return nil
}
elem := q.queue.Back()
q.queue.Remove(elem)
return elem.Value.(*Node)
}

func (q *Queue) IsEmpty() bool {
return q.queue.Len() == 0
}

func (q *Queue) Print() {
fmt.Print("[")
for e := q.queue.Front(); e != nil; e = e.Next() {
if e.Next() != nil {
fmt.Printf("%v, ", e.Value)
} else {
fmt.Print(e.Value)
}
}
fmt.Println("]")
}

// Приклад використання
func main() {
q := NewQueue()
q.Enqueue(NewNode(1))
q.Enqueue(NewNode(2))
q.Enqueue(NewNode(3))

```
fmt.Println("Dequeue elements:")
for !q.IsEmpty() {
	n := q.Dequeue()
	fmt.Println(n.value)
}
```

}
'
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Graph.WeightedGraph
set output_file "weighted_graph_template.go"
set template_content 'package main

import (
"container/heap"
"fmt"
)

type Node struct {
value int
}

func NewNode(value int) Node {
return Node{value}
}

type WeightedEdge struct {
u, v   Node
weight int
}

type WeightedGraph struct {
nodes map[Node]struct{}
edges map[WeightedEdge]struct{}
}

func NewWeightedGraph() WeightedGraph {
return WeightedGraph{
nodes: make(map[Node]struct{}),
edges: make(map[WeightedEdge]struct{}),
}
}

func (wg *WeightedGraph) AddNode(n Node) {
wg.nodes[n] = struct{}{}
}

func (wg *WeightedGraph) AddEdge(u, v Node, w int) {
e := WeightedEdge{u, v, w}
wg.edges[e] = struct{}{}
}

// MST structure
type MST struct {
nodes map[Node]struct{}
edges map[WeightedEdge]struct{}
}

// PriorityQueue for WeightedEdges
type Element struct {
value WeightedEdge
}

type PriorityQueue []Element

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].value.weight < pq[j].value.weight }
func (pq PriorityQueue) Swap(i, j int)      { pq[i], pq[j] = pq[j], pq[i] }

func (pq *PriorityQueue) Push(x any) {
*pq = append(*pq, Element{x.(WeightedEdge)})
}

func (pq *PriorityQueue) Pop() any {
n := len(*pq)
elem := (*pq)[n-1]
*pq = (*pq)[:n-1]
return elem
}

// Print MST
func (m MST) Print() {
fmt.Println("Nodes:")
for n := range m.nodes {
fmt.Printf("%v ", n.value)
}
fmt.Println("\nEdges:")
for e := range m.edges {
fmt.Printf("(%v->%v : %v) ", e.u.value, e.v.value, e.weight)
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

