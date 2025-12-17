function algoP.ContainsDuplicate.BruteForce
    set output_file "ContainsDuplicate.Brute_Force_Python.py"

    set template_content "class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                if nums[i] == nums[j]:
                    return True
        return False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ContainsDuplicate.Sorting
    set output_file "ContainsDuplicate.Sort_Python.py"

    set template_content "class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        nums.sort()
        for i in range(1, len(nums)):
            if nums[i] == nums[i - 1]:
                return True
        return False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ContainsDuplicate.HashSet
    set output_file "ContainsDuplicate.SetAdd_Python.py"

    set template_content "class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        seen = set()
        for num in nums:
            if num in seen:
                return True
            seen.add(num)
        return False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ContainsDuplicate.HashSetLength
    set output_file "ContainsDuplicate.SetLen_Python.py"

    set template_content "class Solution:
    def hasDuplicate(self, nums: List[int]) -> bool:
        return len(set(nums)) < len(nums)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidAnagram.Sorting
    set output_file "IsAnagram.Sorted_Python.py"

    set template_content "class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        return sorted(s) == sorted(t)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidAnagram.HashMap
    set output_file "IsAnagram.HashMap_Python.py"

    set template_content "class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        countS, countT = {}, {}

        for i in range(len(s)):
            countS[s[i]] = 1 + countS.get(s[i], 0)
            countT[t[i]] = 1 + countT.get(t[i], 0)
        return countS == countT
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidAnagram.HashTable_UsingArray
    set output_file "IsAnagram.Array26_Python.py"

    set template_content "class Solution:
    def isAnagram(self, s: str, t: str) -> bool:
        if len(s) != len(t):
            return False

        count = [0] * 26
        for i in range(len(s)):
            count[ord(s[i]) - ord('a')] += 1
            count[ord(t[i]) - ord('a')] -= 1

        for val in count:
            if val != 0:
                return False
        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GroupAnagrams.Sorting
    set output_file "GroupAnagrams.Sorted_Python.py"

    set template_content "class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        res = defaultdict(list)
        for s in strs:
            sortedS = ''.join(sorted(s))
            res[sortedS].append(s)
        return list(res.values())
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GroupAnagrams.HashTable
    set output_file "GroupAnagrams.Count_Python.py"

    set template_content "class Solution:
    def groupAnagrams(self, strs: List[str]) -> List[List[str]]:
        res = defaultdict(list)
        for s in strs:
            count = [0] * 26
            for c in s:
                count[ord(c) - ord('a')] += 1
            res[tuple(count)].append(s)
        return list(res.values())
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TopKFrequentElements.Sorting
    set output_file "TopKFrequent.Sort_Python.py"

    set template_content "class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = {}
        for num in nums:
            count[num] = 1 + count.get(num, 0)

        arr = []
        for num, cnt in count.items():
            arr.append([cnt, num])
        arr.sort()

        res = []
        while len(res) < k:
            res.append(arr.pop()[1])
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TopKFrequentElements.Min-Heap
    set output_file "TopKFrequent.Heap_Python.py"

    set template_content "class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = {}
        for num in nums:
            count[num] = 1 + count.get(num, 0)

        heap = []
        for num in count.keys():
            heapq.heappush(heap, (count[num], num))
            if len(heap) > k:
                heapq.heappop(heap)

        res = []
        for i in range(k):
            res.append(heapq.heappop(heap)[1])
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EncodeandDecodeStrings.EncodingDecoding
    set output_file "TopKFrequent.Bucket_Python.py"

    set template_content "class Solution:
    def topKFrequent(self, nums: List[int], k: int) -> List[int]:
        count = {}
        freq = [[] for i in range(len(nums) + 1)]

        for num in nums:
            count[num] = 1 + count.get(num, 0)
        for num, cnt in count.items():
            freq[cnt].append(num)

        res = []
        for i in range(len(freq) - 1, 0, -1):
            for num in freq[i]:
                res.append(num)
                if len(res) == k:
                    return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EncodeandDecodeStrings.EncodingDecoding_Optimal
    set output_file "EncodeDecode.Sizes_Python.py"

    set template_content "class Solution:
    def encode(self, strs: List[str]) -> str:
        if not strs:
            return \"\"
        sizes, res = [], \"\"
        for s in strs:
            sizes.append(len(s))
        for sz in sizes:
            res += str(sz)
            res += ','
        res += '#'
        for s in strs:
            res += s
        return res

    def decode(self, s: str) -> List[str]:
        if not s:
            return []
        sizes, res, i = [], [], 0
        while s[i] != '#':
            cur = \"\"
            while s[i] != ',':
                cur += s[i]
                i += 1
            sizes.append(int(cur))
            i += 1
        i += 1
        for sz in sizes:
            res.append(s[i:i + sz])
            i += sz
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ProductsofArrayExceptSelf.BruteForce
    set output_file "ProductExceptSelf.BruteForce_Python.py"

    set template_content "class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n

        for i in range(n):
            prod = 1
            for j in range(n):
                if i == j:
                    continue
                prod *= nums[j]

            res[i] = prod
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ProductsofArrayExceptSelf.Division
    set output_file "ProductExceptSelf.MathZeros_Python.py"

    set template_content "class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        prod, zero_cnt = 1, 0
        for num in nums:
            if num:
                prod *= num
            else:
                zero_cnt +=  1
        if zero_cnt > 1: return [0] * len(nums)

        res = [0] * len(nums)
        for i, c in enumerate(nums):
            if zero_cnt: res[i] = 0 if c else prod
            else: res[i] = prod // c
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ProductsofArrayExceptSelf.PrefixSuffix
    set output_file "ProductExceptSelf.PrefixSuffixArrays_Python.py"

    set template_content "class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        pref = [0] * n
        suff = [0] * n

        pref[0] = suff[n - 1] = 1
        for i in range(1, n):
            pref[i] = nums[i - 1] * pref[i - 1]
        for i in range(n - 2, -1, -1):
            suff[i] = nums[i + 1] * suff[i + 1]
        for i in range(n):
            res[i] = pref[i] * suff[i]
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ProductsofArrayExceptSelf.Prefix_SuffixOptimal
    set output_file "ProductExceptSelf.Optimal_Python.py"

    set template_content "class Solution:
    def productExceptSelf(self, nums: List[int]) -> List[int]:
        res = [1] * (len(nums))

        prefix = 1
        for i in range(len(nums)):
            res[i] = prefix
            prefix *= nums[i]
        postfix = 1
        for i in range(len(nums) - 1, -1, -1):
            res[i] *= postfix
            postfix *= nums[i]
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidSudoku.BruteForce
    set output_file "IsValidSudoku.SetsIterative_Python.py"

    set template_content "class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        for row in range(9):
            seen = set()
            for i in range(9):
                if board[row][i] == '.':
                    continue
                if board[row][i] in seen:
                    return False
                seen.add(board[row][i])

        for col in range(9):
            seen = set()
            for i in range(9):
                if board[i][col] == '.':
                    continue
                if board[i][col] in seen:
                    return False
                seen.add(board[i][col])

        for square in range(9):
            seen = set()
            for i in range(3):
                for j in range(3):
                    row = (square // 3) * 3 + i
                    col = (square % 3) * 3 + j
                    if board[row][col] == '.':
                        continue
                    if board[row][col] in seen:
                        return False
                    seen.add(board[row][col])
        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidSudoku.HashSet_OnePass
    set output_file "IsValidSudoku.HashSets_Python.py"

    set template_content "class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        cols = defaultdict(set)
        rows = defaultdict(set)
        squares = defaultdict(set)

        for r in range(9):
            for c in range(9):
                if board[r][c] == '.':
                    continue
                if (board[r][c] in rows[r]
                    or board[r][c] in cols[c]
                    or board[r][c] in squares[(r // 3, c // 3)]):
                    return False

                cols[c].add(board[r][c])
                rows[r].add(board[r][c])
                squares[(r // 3, c // 3)].add(board[r][c])

        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidSudoku.Bitmask
    set output_file "IsValidSudoku.Bitmask_Python.py"

    set template_content "class Solution:
    def isValidSudoku(self, board: List[List[str]]) -> bool:
        rows = [0] * 9
        cols = [0] * 9
        squares = [0] * 9

        for r in range(9):
            for c in range(9):
                if board[r][c] == '.':
                    continue

                val = int(board[r][c]) - 1
                if (1 << val) & rows[r]:
                    return False
                if (1 << val) & cols[c]:
                    return False
                if (1 << val) & squares[(r // 3) * 3 + (c // 3)]:
                    return False

                rows[r] |= (1 << val)
                cols[c] |= (1 << val)
                squares[(r // 3) * 3 + (c // 3)] |= (1 << val)

        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestConsecutiveSequence.BruteForce
    set output_file "LongestConsecutive.BrutishSet_Python.py"

    set template_content "class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        res = 0
        store = set(nums)

        for num in nums:
            streak, curr = 0, num
            while curr in store:
                streak += 1
                curr += 1
            res = max(res, streak)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestConsecutiveSequence.Sorting
    set output_file "LongestConsecutive.Sorting_Python.py"

    set template_content "class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        if not nums:
            return 0
        res = 0
        nums.sort()

        curr, streak = nums[0], 0
        i = 0
        while i < len(nums):
            if curr != nums[i]:
                curr = nums[i]
                streak = 0
            while i < len(nums) and nums[i] == curr:
                i += 1
            streak += 1
            curr += 1
            res = max(res, streak)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestConsecutiveSequence.HashSet
    set output_file "LongestConsecutive.OptimalStartCheck_Python.py"

    set template_content "class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        numSet = set(nums)
        longest = 0

        for num in numSet:
            if (num - 1) not in numSet:
                length = 1
                while (num + length) in numSet:
                    length += 1
                longest = max(length, longest)
        return longest
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestConsecutiveSequence.HashMap
    set output_file "LongestConsecutive.UnionFindMap_Python.py"

    set template_content "class Solution:
    def longestConsecutive(self, nums: List[int]) -> int:
        mp = defaultdict(int)
        res = 0

        for num in nums:
            if not mp[num]:
                mp[num] = mp[num - 1] + mp[num + 1] + 1
                mp[num - mp[num - 1]] = mp[num]
                mp[num + mp[num + 1]] = mp[num]
                res = max(res, mp[num])
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidPalindrome.ReverseString
    set output_file "ValidPalindrome.BuildString_Python.py"

    set template_content "class Solution:
    def isPalindrome(self, s: str) -> bool:
        newStr = ''
        for c in s:
            if c.isalnum():
                newStr += c.lower()
        return newStr == newStr[::-1]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidPalindrome.TwoPointers
    set output_file "ValidPalindrome.TwoPointers_Python.py"

    set template_content "class Solution:
    def isPalindrome(self, s: str) -> bool:
        l, r = 0, len(s) - 1

        while l < r:
            while l < r and not self.alphaNum(s[l]):
                l += 1
            while r > l and not self.alphaNum(s[r]):
                r -= 1
            if s[l].lower() != s[r].lower():
                return False
            l, r = l + 1, r - 1
        return True

    def alphaNum(self, c):
        return (ord('A') <= ord(c) <= ord('Z') or
                ord('a') <= ord(c) <= ord('z') or
                ord('0') <= ord(c) <= ord('9'))
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TwoIntegerSumII.BruteForce
    set output_file "TwoSumSorted.Brute_Force.py"

    set template_content "class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        for i in range(len(numbers)):
            for j in range(i + 1, len(numbers)):
                if numbers[i] + numbers[j] == target:
                    return [i + 1, j + 1]
        return []"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TwoIntegerSumII.HashMap
    set output_file "TwoSumSorted.Binary_Search.py"

    set template_content "class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        for i in range(len(numbers)):
            l, r = i + 1, len(numbers) - 1
            tmp = target - numbers[i]
            while l <= r:
                mid = l + (r - l)//2
                if numbers[mid] == tmp:
                    return [i + 1, mid + 1]
                elif numbers[mid] < tmp:
                    l = mid + 1
                else:
                    r = mid - 1
        return []"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TwoIntegerSumII.HashMap
    set output_file "TwoSumSorted.HashMap.py"

    set template_content "class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        mp = defaultdict(int)
        for i in range(len(numbers)):
            tmp = target - numbers[i]
            if mp[tmp]:
                return [mp[tmp], i + 1]
            mp[numbers[i]] = i + 1
        return []"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TwoIntegerSumII.TwoPointers
    set output_file "TwoSumSorted.Two_Pointers.py"

    set template_content "class Solution:
    def twoSum(self, numbers: List[int], target: int) -> List[int]:
        l, r = 0, len(numbers) - 1
        while l < r:
            curSum = numbers[l] + numbers[r]
            if curSum > target:
                r -= 1
            elif curSum < target:
                l += 1
            else:
                return [l + 1, r + 1]
        return []"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.3Sum.BruteForce
    set output_file "ThreeSum.Brute_Force.py"

    set template_content "class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        res = set()
        nums.sort()
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                for k in range(j + 1, len(nums)):
                    if nums[i] + nums[j] + nums[k] == 0:
                        tmp = [nums[i], nums[j], nums[k]]
                        res.add(tuple(tmp))
        return [list(i) for i in res]"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.3Sum.HashMap
    set output_file "ThreeSum.HashMap.py"

    set template_content "class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        res = []
        for i in range(len(nums)):
            count[nums[i]] -= 1
            if i and nums[i] == nums[i - 1]:
                continue

            for j in range(i + 1, len(nums)):
                count[nums[j]] -= 1
                if j - 1 > i and nums[j] == nums[j - 1]:
                    continue
                target = -(nums[i] + nums[j])
                if count[target] > 0:
                    res.append([nums[i], nums[j], target])

            for j in range(i + 1, len(nums)):
                count[nums[j]] += 1
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.3Sum.TwoPointers
    set output_file "ThreeSum.Two_Pointers.py"

    set template_content "class Solution:
    def threeSum(self, nums: List[int]) -> List[List[int]]:
        res = []
        nums.sort()

        for i, a in enumerate(nums):
            if a > 0:
                break

            if i > 0 and a == nums[i - 1]:
                continue

            l, r = i + 1, len(nums) - 1
            while l < r:
                threeSum = a + nums[l] + nums[r]
                if threeSum > 0:
                    r -= 1
                elif threeSum < 0:
                    l += 1
                else:
                    res.append([a, nums[l], nums[r]])
                    l += 1
                    r -= 1
                    while nums[l] == nums[l - 1] and l < r:
                        l += 1

        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ContainerWithMostWater.BruteForce
    set output_file "MaxArea.Brute_Force.py"

    set template_content "class Solution:
    def maxArea(self, heights: List[int]) -> int:
        res = 0
        for i in range(len(heights)):
            for j in range(i + 1, len(heights)):
                res = max(res, min(heights[i], heights[j]) * (j - i))
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ContainerWithMostWater.TwoPointers
    set output_file "MaxArea.Two_Pointers.py"

    set template_content "class Solution:
    def maxArea(self, heights: List[int]) -> int:
        l, r = 0, len(heights) - 1
        res = 0

        while l < r:
            area = min(heights[l], heights[r]) * (r - l)
            res = max(res, area)
            if heights[l] <= heights[r]:
                l += 1
            else:
                r -= 1
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParentheses.BruteForce
    set output_file "ValidParentheses.Replace.py"

    set template_content "class Solution:
    def isValid(self, s: str) -> bool:
        while '()' in s or '{}' in s or '[]' in s:
            s = s.replace('()', '')
            s = s.replace('{}', '')
            s = s.replace('[]', '')
        return s == ''"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ValidParentheses.Stack
    set output_file "ValidParentheses.Stack.py"

    set template_content 'class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        closeToOpen = { ")": "(", "]": "[", "}": "{" }

        for c in s:
            if c in closeToOpen:
                if stack and stack[-1] == closeToOpen[c]:
                    stack.pop()
                else:
                    return False
            else:
                stack.append(c)

        return True if not stack else False'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinimumStack.BruteForce
    set output_file "MinStack.Brute_Force.py"

    set template_content "class MinStack:

    def __init__(self):
        self.stack = []

    def push(self, val: int) -> None:
        self.stack.append(val)

    def pop(self) -> None:
        self.stack.pop()

    def top(self) -> int:
        return self.stack[-1]

    def getMin(self) -> int:
        tmp = []
        mini = self.stack[-1]

        while len(self.stack):
            mini = min(mini, self.stack[-1])
            tmp.append(self.stack.pop())

        while len(tmp):
            self.stack.append(tmp.pop())

        return mini"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinimumStack.TwoStacks
    set output_file "MinStack.Two_Stacks.py"

    set template_content "class MinStack:
    def __init__(self):
        self.stack = []
        self.minStack = []

    def push(self, val: int) -> None:
        self.stack.append(val)
        val = min(val, self.minStack[-1] if self.minStack else val)
        self.minStack.append(val)

    def pop(self) -> None:
        self.stack.pop()
        self.minStack.pop()

    def top(self) -> int:
        return self.stack[-1]

    def getMin(self) -> int:
        return self.minStack[-1]"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinimumStack.OneStack
    set output_file "MinStack.Encoded_Diff.py"

    set template_content "class MinStack:
    def __init__(self):
        self.min = float('inf')
        self.stack = []

    def push(self, val: int) -> None:
        if not self.stack:
            self.stack.append(0)
            self.min = val
        else:
            self.stack.append(val - self.min)
            if val < self.min:
                self.min = val

    def pop(self) -> None:
        if not self.stack:
            return

        pop = self.stack.pop()

        if pop < 0:
            self.min = self.min - pop

    def top(self) -> int:
        top = self.stack[-1]
        if top > 0:
            return top + self.min
        else:
            return self.min

    def getMin(self) -> int:
        return self.min"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.EvaluateReversePolishNotation.BruteForce 
    set output_file "EvalRPN.ReplaceList.py"

    set template_content 'class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        while len(tokens) > 1:
            for i in range(len(tokens)):
                if tokens[i] in "+-*/":
                    a = int(tokens[i-2])
                    b = int(tokens[i-1])
                    if tokens[i] == "+":
                        result = a + b
                    elif tokens[i] == "-":
                        result = a - b
                    elif tokens[i] == "*":
                        result = a * b
                    elif tokens[i] == "/":
                        result = int(a / b)
                    tokens = tokens[:i-2] + [str(result)] + tokens[i+1:]
                    break
        return int(tokens[0])'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EvaluateReversePolishNotation.DoublyLinkedList
    set output_file "EvalRPN.DoublyLinkedList.py"

    set template_content 'class DoublyLinkedList:
    def __init__(self, val, next=None, prev=None):
        self.val = val
        self.next = next
        self.prev = prev

class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        head = DoublyLinkedList(tokens[0])
        curr = head

        for i in range(1, len(tokens)):
            curr.next = DoublyLinkedList(tokens[i], prev=curr)
            curr = curr.next

        while head is not None:
            if head.val in "+-*/":
                l = int(head.prev.prev.val)
                r = int(head.prev.val)
                if head.val == "+":
                    res = l + r
                elif head.val == "-":
                    res = l - r
                elif head.val == "*":
                    res = l * r
                else:
                    res = int(l / r)

                head.val = str(res)
                head.prev = head.prev.prev.prev
                if head.prev is not None:
                    head.prev.next = head

            ans = int(head.val)
            head = head.next

        return ans'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EvaluateReversePolishNotation.Recursion
    set output_file "EvalRPN.RecursiveDFS.py"

    set template_content 'class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        def dfs():
            token = tokens.pop()
            if token not in "+-*/":
                return int(token)

            right = dfs()
            left = dfs()

            if token == "+":
                return left + right
            elif token == "-":
                return left - right
            elif token == "*":
                return left * right
            elif token == "/":
                return int(left / right)

        return dfs()'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.EvaluateReversePolishNotation.Stack
    set output_file "EvalRPN.Stack.py"

    set template_content 'class Solution:
    def evalRPN(self, tokens: List[str]) -> int:
        stack = []
        for c in tokens:
            if c == "+":
                stack.append(stack.pop() + stack.pop())
            elif c == "-":
                a, b = stack.pop(), stack.pop()
                stack.append(b - a)
            elif c == "*":
                stack.append(stack.pop() * stack.pop())
            elif c == "/":
                a, b = stack.pop(), stack.pop()
                stack.append(int(float(b) / a))
            else:
                stack.append(int(c))
        return stack[0]'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DailyTemperatures.BruteForce
    set output_file "DailyTemperatures.Brute_Force.py"

    set template_content "class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        n = len(temperatures)
        res = []

        for i in range(n):
            count = 1
            j = i + 1
            while j < n:
                if temperatures[j] > temperatures[i]:
                    break
                j += 1
                count += 1
            count = 0 if j == n else count
            res.append(count)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DailyTemperatures.Stack
    set output_file "DailyTemperatures.Stack.py"

    set template_content "class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        res = [0] * len(temperatures)
        stack = []  # pair: [temp, index]

        for i, t in enumerate(temperatures):
            while stack and t > stack[-1][0]:
                stackT, stackInd = stack.pop()
                res[stackInd] = i - stackInd
            stack.append((t, i))
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DailyTemperatures.DynamicProgramming
    set output_file "DailyTemperatures.Reverse.py"

    set template_content "class Solution:
    def dailyTemperatures(self, temperatures: List[int]) -> List[int]:
        n = len(temperatures)
        res = [0] * n

        for i in range(n - 2, -1, -1):
            j = i + 1
            while j < n and temperatures[j] <= temperatures[i]:
                if res[j] == 0:
                    j = n
                    break
                j += res[j]

            if j < n:
                res[i] = j - i
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CarFleet.Stack
    set output_file "CarFleet.Stack.py"

    set template_content "class Solution:
    def carFleet(self, target: int, position: List[int], speed: List[int]) -> int:
        pair = [(p, s) for p, s in zip(position, speed)]
        pair.sort(reverse=True)
        stack = []
        for p, s in pair:  # Reverse Sorted Order
            stack.append((target - p) / s)
            if len(stack) >= 2 and stack[-1] <= stack[-2]:
                stack.pop()
        return len(stack)"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CarFleet.Iteration
    set output_file "CarFleet.FleetCount.py"

    set template_content "class Solution:
    def carFleet(self, target: int, position: List[int], speed: List[int]) -> int:
        pair = [(p, s) for p, s in zip(position, speed)]
        pair.sort(reverse=True)

        fleets = 1
        prevTime = (target - pair[0][0]) / pair[0][1]
        for i in range(1, len(pair)):
            currCar = pair[i]
            currTime = (target - currCar[0]) / currCar[1]
            if currTime > prevTime:
                fleets += 1
                prevTime = currTime
        return fleets"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BinarySearch.RecursiveBinarySearch
    set output_file "BinarySearch.Recursive.py"

    set template_content "class Solution:
    def binary_search(self, l: int, r: int, nums: List[int], target: int) -> int:
        if l > r:
            return -1
        m = l + (r - l) // 2

        if nums[m] == target:
            return m
        if nums[m] < target:
            return self.binary_search(m + 1, r, nums, target)
        return self.binary_search(l, m - 1, nums, target)

    def search(self, nums: List[int], target: int) -> int:
        return self.binary_search(0, len(nums) - 1, nums, target)"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch.IterativeBinarySearch
    set output_file "BinarySearch.Iterative.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1

        while l <= r:
            # (l + r) // 2 can lead to overflow
            m = l + ((r - l) // 2)

            if nums[m] > target:
                r = m - 1
            elif nums[m] < target:
                l = m + 1
            else:
                return m
        return -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch.UpperBound
    set output_file "BinarySearch.UpperBound.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums)

        while l < r:
            m = l + ((r - l) // 2)
            if nums[m] > target:
                r = m
            elif nums[m] <= target:
                l = m + 1
        return l - 1 if (l and nums[l - 1] == target) else -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch.LowerBound
    set output_file "BinarySearch.LowerBound.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums)

        while l < r:
            m = l + ((r - l) // 2)
            if nums[m] >= target:
                r = m
            elif nums[m] < target:
                l = m + 1
        return l if (l < len(nums) and nums[l] == target) else -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinarySearch.Built-InFunction
    set output_file "BinarySearch.Bisect.py"

    set template_content "import bisect
class Solution:
    def search(self, nums: List[int], target: int) -> int:
        index = bisect.bisect_left(nums, target)
        return index if index < len(nums) and nums[index] == target else -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Search2DMatrix.BruteForce
    set output_file "SearchMatrix.Brute_Force.py"

    set template_content "class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        for r in range(len(matrix)):
            for c in range(len(matrix[0])):
                if matrix[r][c] == target:
                    return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Search2DMatrix.StaircaseSearch
    set output_file "SearchMatrix.Stepwise.py"

    set template_content "class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        m, n = len(matrix), len(matrix[0])
        r, c = 0, n - 1

        while r < m and c >= 0:
            if matrix[r][c] > target:
                c -= 1
            elif matrix[r][c] < target:
                r += 1
            else:
                return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Search2DMatrix.BinarySearch
    set output_file "SearchMatrix.RowBinary.py"

    set template_content "class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        ROWS, COLS = len(matrix), len(matrix[0])

        top, bot = 0, ROWS - 1
        while top <= bot:
            row = (top + bot) // 2
            if target > matrix[row][-1]:
                top = row + 1
            elif target < matrix[row][0]:
                bot = row - 1
            else:
                break

        if not (top <= bot):
            return False
        row = (top + bot) // 2
        l, r = 0, COLS - 1
        while l <= r:
            m = (l + r) // 2
            if target > matrix[row][m]:
                l = m + 1
            elif target < matrix[row][m]:
                r = m - 1
            else:
                return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Search2DMatrix.BinarySearch_OnePass
    set output_file "SearchMatrix.FlatBinary.py"

    set template_content "class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        ROWS, COLS = len(matrix), len(matrix[0])

        l, r = 0, ROWS * COLS - 1
        while l <= r:
            m = l + (r - l) // 2
            row, col = m // COLS, m % COLS
            if target > matrix[row][col]:
                l = m + 1
            elif target < matrix[row][col]:
                r = m - 1
            else:
                return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KokoEatingBananas.BruteForce
    set output_file "MinEatingSpeed.Brute_Force.py"

    set template_content "import math
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        speed = 1
        while True:
            totalTime = 0
            for pile in piles:
                totalTime += math.ceil(pile / speed)

            if totalTime <= h:
                return speed
            speed += 1
        return speed"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KokoEatingBananas.BinarySearch
    set output_file "MinEatingSpeed.BinarySearch.py"

    set template_content "import math
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        l, r = 1, max(piles)
        res = r

        while l <= r:
            k = (l + r) // 2

            totalTime = 0
            for p in piles:
                totalTime += math.ceil(float(p) / k)
            if totalTime <= h:
                res = k
                r = k - 1
            else:
                l = k + 1
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SearchinRotatedSortedArray.BruteForce
    set output_file "SearchRotatedArray.Linear.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        for i in range(len(nums)):
            if nums[i] == target:
                return i
        return -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SearchinRotatedSortedArray.BinarySearch
    set output_file "SearchRotatedArray.BinarySeparate.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1

        while l < r:
            m = (l + r) // 2
            if nums[m] > nums[r]:
                l = m + 1
            else:
                r = m

        pivot = l

        def binary_search(left: int, right: int) -> int:
            while left <= right:
                mid = (left + right) // 2
                if nums[mid] == target:
                    return mid
                elif nums[mid] < target:
                    left = mid + 1
                else:
                    right = mid - 1
            return -1

        result = binary_search(0, pivot - 1)
        if result != -1:
            return result

        return binary_search(pivot, len(nums) - 1)"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SearchinRotatedSortedArray.BinarySearch_TwoPass
    set output_file "SearchRotatedArray.BinaryAdjusted.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1

        while l < r:
            m = (l + r) // 2
            if nums[m] > nums[r]:
                l = m + 1
            else:
                r = m

        pivot = l
        l, r = 0, len(nums) - 1

        if target >= nums[pivot] and target <= nums[r]:
            l = pivot
        else:
            r = pivot - 1

        while l <= r:
            m = (l + r) // 2
            if nums[m] == target:
                return m
            elif nums[m] < target:
                l = m + 1
            else:
                r = m - 1

        return -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SearchinRotatedSortedArray.BinarySearch_OnePass
    set output_file "SearchRotatedArray.BinaryInline.py"

    set template_content "class Solution:
    def search(self, nums: List[int], target: int) -> int:
        l, r = 0, len(nums) - 1

        while l <= r:
            mid = (l + r) // 2
            if target == nums[mid]:
                return mid

            if nums[l] <= nums[mid]:
                if target > nums[mid] or target < nums[l]:
                    l = mid + 1
                else:
                    r = mid - 1

            else:
                if target < nums[mid] or target > nums[r]:
                    r = mid - 1
                else:
                    l = mid + 1
        return -1"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TimeBasedKeyValueStore.BruteForce
    set output_file "TimeMap.Linear.py"

    set template_content "class TimeMap:

    def __init__(self):
        self.keyStore = {}

    def set(self, key: str, value: str, timestamp: int) -> None:
        if key not in self.keyStore:
            self.keyStore[key] = {}
        if timestamp not in self.keyStore[key]:
            self.keyStore[key][timestamp] = []
        self.keyStore[key][timestamp].append(value)

    def get(self, key: str, timestamp: int) -> str:
        if key not in self.keyStore:
            return \"\"
        seen = 0

        for time in self.keyStore[key]:
            if time <= timestamp:
                seen = max(seen, time)
        return \"\" if seen == 0 else self.keyStore[key][seen][-1]"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TimeBasedKeyValueStore.BinarySearch_SortedMap
    set output_file "TimeMap.SortedDict.py"

    set template_content "from sortedcontainers import SortedDict
from collections import defaultdict

class TimeMap:
    def __init__(self):
        self.m = defaultdict(SortedDict)

    def set(self, key: str, value: str, timestamp: int) -> None:
        self.m[key][timestamp] = value

    def get(self, key: str, timestamp: int) -> str:
        if key not in self.m:
            return \"\"

        timestamps = self.m[key]
        idx = timestamps.bisect_right(timestamp) - 1

        if idx >= 0:
            closest_time = timestamps.iloc[idx]
            return timestamps[closest_time]
        return \"\""

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TimeBasedKeyValueStore.BinarySearch_Array
    set output_file "TimeMap.BinarySearch.py"

    set template_content "class TimeMap:

    def __init__(self):
        self.keyStore = {}  # key : list of [val, timestamp]

    def set(self, key: str, value: str, timestamp: int) -> None:
        if key not in self.keyStore:
            self.keyStore[key] = []
        self.keyStore[key].append([value, timestamp])

    def get(self, key: str, timestamp: int) -> str:
        res, values = \"\", self.keyStore.get(key, [])
        l, r = 0, len(values) - 1
        while l <= r:
            m = (l + r) // 2
            if values[m][1] <= timestamp:
                res = values[m][0]
                l = m + 1
            else:
                r = m - 1
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BestTimeBuySellStock.BruteForce
    set output_file "MaxProfit.Bruteforce.py"

    set template_content "class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        res = 0
        for i in range(len(prices)):
            buy = prices[i]
            for j in range(i + 1, len(prices)):
                sell  = prices[j]
                res = max(res, sell - buy)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BestTimeBuySellStock.TwoPointers
    set output_file "MaxProfit.TwoPointer.py"

    set template_content "class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        l, r = 0, 1
        maxP = 0

        while r < len(prices):
            if prices[l] < prices[r]:
                profit = prices[r] - prices[l]
                maxP = max(maxP, profit)
            else:
                l = r
            r += 1
        return maxP"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BestTimeBuySellStock.DynamicProgramming
    set output_file "MaxProfit.MinBuy.py"

    set template_content "class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        maxP = 0
        minBuy = prices[0]

        for sell in prices:
            maxP = max(maxP, sell - minBuy)
            minBuy = min(minBuy, sell)
        return maxP"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestSubstringWithoutRepeatingCharacters.BruteForce
    set output_file "LongestSubstring.Bruteforce.py"

    set template_content "class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        res = 0
        for i in range(len(s)):
            charSet = set()
            for j in range(i, len(s)):
                if s[j] in charSet:
                    break
                charSet.add(s[j])
            res = max(res, len(charSet))
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestSubstringWithoutRepeatingCharacters.SlidingWindow
    set output_file "LongestSubstring.SlidingWindow.py"

    set template_content "class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        charSet = set()
        l = 0
        res = 0

        for r in range(len(s)):
            while s[r] in charSet:
                charSet.remove(s[l])
                l += 1
            charSet.add(s[r])
            res = max(res, r - l + 1)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestSubstringWithoutRepeatingCharacters.SlidingWindow_Optimal
    set output_file "LongestSubstring.Hashmap.py"

    set template_content "class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        mp = {}
        l = 0
        res = 0

        for r in range(len(s)):
            if s[r] in mp:
                l = max(mp[s[r]] + 1, l)
            mp[s[r]] = r
            res = max(res, r - l + 1)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestSubstringWithoutRepeatingCharacters.BruteForce
    set output_file "3-longest-substring-without-repeating-characters-brutetest.py"

    set template_content "from typing import List

class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        res = 0
        for i in range(len(s)):
            charSet = set()
            for j in range(i, len(s)):
                if s[j] in charSet:
                    break
                charSet.add(s[j])
            res = max(res, len(charSet))
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestSubstringWithoutRepeatingCharacters.List
    set file_name "3-longest-substring-without-repeating-characters-set.py"
    set template_content 'from typing import List
class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        charSet = set()
        l = 0
        res = 0

        for r in range(len(s)):
            while s[r] in charSet:
                charSet.remove(s[l])
                l += 1
            charSet.add(s[r])
            res = max(res, r - l + 1)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestSubstringWithoutRepeatingCharacters.Set
    set file_name "3-longest-substring-without-repeating-characters-map.py"

    set template_content "from typing import List

class Solution:
    def lengthOfLongestSubstring(self, s: str) -> int:
        mp = {}
        l = 0
        res = 0

        for r in range(len(s)):
            if s[r] in mp:
                l = max(mp[s[r]] + 1, l)
            mp[s[r]] = r
            res = max(res, r - l + 1)
        return res
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestRepeatingCharacterReplacement.Bruteforce
    set output_file "CharacterReplacement.Bruteforce.py"

    set template_content "class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        res = 0
        for i in range(len(s)):
            count, maxf = {}, 0
            for j in range(i, len(s)):
                count[s[j]] = 1 + count.get(s[j], 0)
                maxf = max(maxf, count[s[j]])
                if (j - i + 1) - maxf <= k:
                    res = max(res, j - i + 1)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestRepeatingCharacterReplacement.SlidingWindow
    set output_file "CharacterReplacement.ByChar.py"

    set template_content "class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        res = 0
        charSet = set(s)

        for c in charSet:
            count = l = 0
            for r in range(len(s)):
                if s[r] == c:
                    count += 1

                while (r - l + 1) - count > k:
                    if s[l] == c:
                        count -= 1
                    l += 1

                res = max(res, r - l + 1)
        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestRepeatingCharacterReplacement.SlidingWindow_Optimal
    set output_file "CharacterReplacement.SlidingWindow.py"

    set template_content "class Solution:
    def characterReplacement(self, s: str, k: int) -> int:
        count = {}
        res = 0

        l = 0
        maxf = 0
        for r in range(len(s)):
            count[s[r]] = 1 + count.get(s[r], 0)
            maxf = max(maxf, count[s[r]])

            while (r - l + 1) - maxf > k:
                count[s[l]] -= 1
                l += 1
            res = max(res, r - l + 1)

        return res"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PermutationinString.Bruteforce
    set output_file "CheckInclusion.Bruteforce.py"

    set template_content "class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        s1 = sorted(s1)

        for i in range(len(s2)):
            for j in range(i, len(s2)):
                subStr = s2[i : j + 1]
                subStr = sorted(subStr)
                if subStr == s1:
                    return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PermutationinString.HashTable
    set output_file "CheckInclusion.CountsBruteforce.py"

    set template_content "class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        count1 = {}
        for c in s1:
            count1[c] = 1 + count1.get(c, 0)

        need = len(count1)
        for i in range(len(s2)):
            count2, cur = {}, 0
            for j in range(i, len(s2)):
                count2[s2[j]] = 1 + count2.get(s2[j], 0)
                if count1.get(s2[j], 0) < count2[s2[j]]:
                    break
                if count1.get(s2[j], 0) == count2[s2[j]]:
                    cur += 1
                if cur == need:
                    return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PermutationinString.SlidingWindow
    set output_file "CheckInclusion.SlidingWindow.py"

    set template_content "class Solution:
    def checkInclusion(self, s1: str, s2: str) -> bool:
        if len(s1) > len(s2):
            return False

        s1Count, s2Count = [0] * 26, [0] * 26
        for i in range(len(s1)):
            s1Count[ord(s1[i]) - ord('a')] += 1
            s2Count[ord(s2[i]) - ord('a')] += 1

        matches = 0
        for i in range(26):
            matches += (1 if s1Count[i] == s2Count[i] else 0)

        l = 0
        for r in range(len(s1), len(s2)):
            if matches == 26:
                return True

            index = ord(s2[r]) - ord('a')
            s2Count[index] += 1
            if s1Count[index] == s2Count[index]:
                matches += 1
            elif s1Count[index] + 1 == s2Count[index]:
                matches -= 1

            index = ord(s2[l]) - ord('a')
            s2Count[index] -= 1
            if s1Count[index] == s2Count[index]:
                matches += 1
            elif s1Count[index] - 1 == s2Count[index]:
                matches -= 1
            l += 1
        return matches == 26"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseLinkedList.Recursion 
    set output_file "ReverseList.Recursive.py"

    set template_content "# Definition for singly-linked list.
from typing import Optional

class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseList(self, head: Optional[ListNode]) -> Optional[ListNode]:
        if not head:
            return None

        newHead = head
        if head.next:
            newHead = self.reverseList(head.next)
            head.next.next = head
        head.next = None

        return newHead
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseLinkedList.Iteration 
    set output_file "ReverseList.Iterative.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def reverseList(self, head: ListNode) -> ListNode:
        prev, curr = None, head

        while curr:
            temp = curr.next
            curr.next = prev
            prev = curr
            curr = temp
        return prev
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeTwoSortedLinkedLists.Recursion
    set output_file "MergeTwoSortedLinkedLists.Recursion.py"

    set template_content "from typing import Optional

# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        if list1 is None:
            return list2
        if list2 is None:
            return list1
        if list1.val <= list2.val:
            list1.next = self.mergeTwoLists(list1.next, list2)
            return list1
        else:
            list2.next = self.mergeTwoLists(list1, list2.next)
            return list2
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeTwoSortedLinkedLists.Iteration
    set output_file "MergeTwoSortedLinkedLists.Iteration.py"

    set template_content "from typing import Optional
# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
        self.val = val
        self.next = next

class Solution:
    def mergeTwoLists(self, list1: Optional[ListNode], list2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = node = ListNode()

        while list1 and list2:
            if list1.val < list2.val:
                node.next = list1
                list1 = list1.next
            else:
                node.next = list2
                list2 = list2.next
            node = node.next

        node.next = list1 or list2
        return dummy.next
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LinkedListCycleDetection.HashSet
    set output_file "HasCycle.HashSet.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        seen = set()
        cur = head
        while cur:
            if cur in seen:
                return True
            seen.add(cur)
            cur = cur.next
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LinkedListCycleDetection.FastAndSlowPointers
    set output_file "HasCycle.TwoPointers.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def hasCycle(self, head: Optional[ListNode]) -> bool:
        slow, fast = head, head

        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next
            if slow == fast:
                return True
        return False"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReorderLinkedList.BruteForce
    set output_file "ReorderList.Array.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        if not head:
            return

        nodes = []
        cur = head
        while cur:
            nodes.append(cur)
            cur = cur.next

        i, j = 0, len(nodes) - 1
        while i < j:
            nodes[i].next = nodes[j]
            i += 1
            if i >= j:
                break
            nodes[j].next = nodes[i]
            j -= 1

        nodes[i].next = None
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReorderLinkedList.Recursion
    set output_file "ReorderList.Recursion.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:

        def rec(root: ListNode, cur: ListNode) -> ListNode:
            if not cur:
                return root

            root = rec(root, cur.next)
            if not root:
                return None

            tmp = None
            if root == cur or root.next == cur:
                cur.next = None
            else:
                tmp = root.next
                root.next = cur
                cur.next = tmp

            return tmp

        head = rec(head, head.next)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReorderLinkedList.ReverseAndMerge
    set output_file "ReorderList.Optimal.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def reorderList(self, head: Optional[ListNode]) -> None:
        slow, fast = head, head.next
        while fast and fast.next:
            slow = slow.next
            fast = fast.next.next

        second = slow.next
        prev = slow.next = None
        while second:
            tmp = second.next
            second.next = prev
            prev = second
            second = tmp

        first, second = head, prev
        while second:
            tmp1, tmp2 = first.next, second.next
            first.next = second
            second.next = tmp1
            first, second = tmp1, tmp2
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveNodeFromEndLinkedList.BruteForce
    set output_file "RemoveNthFromEnd.Array.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
    def __init__(self, val=0, next=None):
           self.val = val
           self.next = next

class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        nodes = []
        cur = head
        while cur:
            nodes.append(cur)
            cur = cur.next

        removeIndex = len(nodes) - n
        if removeIndex == 0:
            return head.next

        nodes[removeIndex - 1].next = nodes[removeIndex].next
        return head
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveNodeFromEndLinkedList.Iteration_TwoPass
    set output_file "RemoveNthFromEnd.Count.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        N = 0
        cur = head
        while cur:
            N += 1
            cur = cur.next

        removeIndex = N - n
        if removeIndex == 0:
            return head.next

        cur = head
        for i in range(N - 1):
            if (i + 1) == removeIndex:
                cur.next = cur.next.next
                break
            cur = cur.next

        return head
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RemoveNodeFromEndLinkedList.Recursion
    set output_file "RemoveNthFromEnd.Recursion.py"

    set template_content "# Definition for singly-linked list.
 class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def rec(self, head, n):
        if not head:
            return None

        head.next = self.rec(head.next, n)
        n[0] -= 1
        if n[0] == 0:
            return head.next
        return head

    def removeNthFromEnd(self, head, n):
        return self.rec(head, [n])
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RemoveNodeFromEndLinkedList.TwoPointers
    set output_file "RemoveNthFromEnd.TwoPointers.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        dummy = ListNode(0, head)
        left = dummy
        right = head

        while n > 0:
            right = right.next
            n -= 1

        while right:
            left = left.next
            right = right.next

        left.next = left.next.next
        return dummy.next
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CopyLinkedListwithRandomPointer.Recursion_HashMap
    set output_file "CopyRandomList.RecursionMap.py"

    set template_content "# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = x
        self.next = next
        self.random = random

class Solution:
    def __init__(self):
        self.map = {}

    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if head is None:
            return None
        if head in self.map:
            return self.map[head]

        copy = Node(head.val)
        self.map[head] = copy
        copy.next = self.copyRandomList(head.next)
        copy.random = self.map.get(head.random)
        return copy
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CopyLinkedListwithRandomPointer.HashMap_TwoPass
    set output_file "CopyRandomList.DictTwoPass.py"

    set template_content "# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = x
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        oldToCopy = {None: None}

        cur = head
        while cur:
            oldToCopy[cur] = Node(cur.val)
            cur = cur.next

        cur = head
        while cur:
            copy = oldToCopy[cur]
            copy.next = oldToCopy[cur.next]
            copy.random = oldToCopy[cur.random]
            cur = cur.next

        return oldToCopy[head]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CopyLinkedListwithRandomPointer.HashMap_OnePass
    set output_file "CopyRandomList.DefaultDict.py"

    set template_content "import collections
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = x
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        oldToCopy = collections.defaultdict(lambda: Node(0))
        oldToCopy[None] = None

        cur = head
        while cur:
            oldToCopy[cur].val = cur.val
            oldToCopy[cur].next = oldToCopy[cur.next]
            oldToCopy[cur].random = oldToCopy[cur.random]
            cur = cur.next

        return oldToCopy[head]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CopyLinkedListwithRandomPointer.SpaceOptimized-I
    set output_file "CopyRandomList.InterleaveClassic.py"

    set template_content "# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = x
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if head is None:
            return None

        l1 = head
        while l1:
            l2 = Node(l1.val)
            l2.next = l1.next
            l1.next = l2
            l1 = l2.next

        newHead = head.next

        l1 = head
        while l1:
            if l1.random:
                l1.next.random = l1.random.next
            l1 = l1.next.next

        l1 = head
        while l1:
            l2 = l1.next
            l1.next = l2.next
            if l2.next:
                l2.next = l2.next.next
            l1 = l1.next

        return newHead
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CopyLinkedListwithRandomPointer.SpaceOptimized-II
    set output_file "CopyRandomList.RandomChainTrick.py"

    set template_content "# Definition for a Node.
class Node:
    def __init__(self, x: int, next: 'Node' = None, random: 'Node' = None):
        self.val = x
        self.next = next
        self.random = random

class Solution:
    def copyRandomList(self, head: 'Optional[Node]') -> 'Optional[Node]':
        if head is None:
            return None

        l1 = head
        while l1:
            l2 = Node(l1.val)
            l2.next = l1.random
            l1.random = l2
            l1 = l1.next

        newHead = head.random

        l1 = head
        while l1:
            l2 = l1.random
            l2.random = l2.next.random if l2.next else None
            l1 = l1.next

        l1 = head
        while l1:
            l2 = l1.random
            l1.random = l2.next
            l2.next = l1.next.random if l1.next else None
            l1 = l1.next

        return newHead
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AddTwoNumbers.Recursion

    set output_file "AddTwoNumbers.Recursive.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def add(self, l1: Optional[ListNode], l2: Optional[ListNode], carry: int) -> Optional[ListNode]:
        if not l1 and not l2 and carry == 0:
            return None

        v1 = l1.val if l1 else 0
        v2 = l2.val if l2 else 0

        carry, val = divmod(v1 + v2 + carry, 10)

        next_node = self.add(
            l1.next if l1 else None,
            l2.next if l2 else None,
            carry
        )
        return ListNode(val, next_node)

    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        return self.add(l1, l2, 0)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.AddTwoNumbers.Iteration
    set output_file "AddTwoNumbers.Iterative.py"

    set template_content "# Definition for singly-linked list.
class ListNode:
     def __init__(self, val=0, next=None):
         self.val = val
         self.next = next

class Solution:
    def addTwoNumbers(self, l1: Optional[ListNode], l2: Optional[ListNode]) -> Optional[ListNode]:
        dummy = ListNode()
        cur = dummy
        carry = 0

        while l1 or l2 or carry:
            v1 = l1.val if l1 else 0
            v2 = l2.val if l2 else 0

            val = v1 + v2 + carry
            carry = val // 10
            val = val % 10
            cur.next = ListNode(val)

            cur = cur.next
            l1 = l1.next if l1 else None
            l2 = l2.next if l2 else None

        return dummy.next
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.FindtheDuplicateNumber.Sorting
    set output_file "FindDuplicate.Sort.py"

    set template_content "class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        nums.sort()
        for i in range(len(nums) - 1):
            if nums[i] == nums[i + 1]:
                return nums[i]
        return -1
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.FindtheDuplicateNumber.HashSet
    set output_file "FindDuplicate.Set.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        seen = set()
        for num in nums:
            if num in seen:
                return num
            seen.add(num)
        return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindtheDuplicateNumber.Array
    set output_file "FindDuplicate.FrequencyArray.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        seen = [0] * len(nums)
        for num in nums:
            if seen[num - 1]:
                return num
            seen[num - 1] = 1
        return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindtheDuplicateNumber.NegativeMarking
    set output_file "FindDuplicate.MarkNegative.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        for num in nums:
            idx = abs(num) - 1
            if nums[idx] < 0:
                return abs(num)
            nums[idx] *= -1
        return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindtheDuplicateNumber.BinarySearch
    set output_file "FindDuplicate.BinarySearch.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        n = len(nums)
        low, high = 1, n - 1
        while low < high:
            mid = low + (high - low) // 2
            lessOrEqual = sum(1 for num in nums if num <= mid)

            if lessOrEqual <= mid:
                low = mid + 1
            else:
                high = mid
        return low
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindtheDuplicateNumber.BitManipulation
    set output_file "FindDuplicate.BitCount.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        n = len(nums)
        res = 0
        for b in range(32):
            x = y = 0
            mask = 1 << b
            for num in nums:
                if num & mask:
                    x += 1

            for num in range(1, n):
                if num & mask:
                    y += 1

            if x > y:
                res |= mask
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.FindtheDuplicateNumber.FastAndSlowPointers
    set output_file "FindDuplicate.Floyd.py"

    set template_content 'class Solution:
    def findDuplicate(self, nums: List[int]) -> int:
        slow, fast = 0, 0
        while True:
            slow = nums[slow]
            fast = nums[nums[fast]]
            if slow == fast:
                break

        slow2 = 0
        while True:
            slow = nums[slow]
            slow2 = nums[slow2]
            if slow == slow2:
                return slow
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LRUCache.BruteForce
    set output_file "LRUCache.List.py"

    set template_content 'class LRUCache:

    def __init__(self, capacity: int):
        self.cache = []
        self.capacity = capacity

    def get(self, key: int) -> int:
        for i in range(len(self.cache)):
            if self.cache[i][0] == key:
                tmp = self.cache.pop(i)
                self.cache.append(tmp)
                return tmp[1]
        return -1

    def put(self, key: int, value: int) -> None:
        for i in range(len(self.cache)):
            if self.cache[i][0] == key:
                tmp = self.cache.pop(i)
                tmp[1] = value
                self.cache.append(tmp)
                return

        if self.capacity == len(self.cache):
            self.cache.pop(0)

        self.cache.append([key, value])
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LRUCache.DoublyLinkedList
    set output_file "LRUCache.CustomDLL.py"

    set template_content 'class Node:
    def __init__(self, key, val):
        self.key, self.val = key, val
        self.prev = self.next = None

class LRUCache:
    def __init__(self, capacity: int):
        self.cap = capacity
        self.cache = {}

        self.left, self.right = Node(0, 0), Node(0, 0)
        self.left.next, self.right.prev = self.right, self.left

    def remove(self, node):
        prev, nxt = node.prev, node.next
        prev.next, nxt.prev = nxt, prev

    def insert(self, node):
        prev, nxt = self.right.prev, self.right
        prev.next = nxt.prev = node
        node.next, node.prev = nxt, prev

    def get(self, key: int) -> int:
        if key in self.cache:
            self.remove(self.cache[key])
            self.insert(self.cache[key])
            return self.cache[key].val
        return -1

    def put(self, key: int, value: int) -> None:
        if key in self.cache:
            self.remove(self.cache[key])

        self.cache[key] = Node(key, value)
        self.insert(self.cache[key])

        if len(self.cache) > self.cap:
            lru = self.left.next
            self.remove(lru)
            del self.cache[lru.key]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LRUCache.Built-InDataStructure
    set output_file "LRUCache.OrderedDict.py"

    set template_content 'from collections import OrderedDict

class LRUCache:

    def __init__(self, capacity: int):
        self.cache = OrderedDict()
        self.cap = capacity

    def get(self, key: int) -> int:
        if key not in self.cache:
            return -1
        self.cache.move_to_end(key)
        return self.cache[key]

    def put(self, key: int, value: int) -> None:
        if key in self.cache:
            self.cache.move_to_end(key)
        self.cache[key] = value

        if len(self.cache) > self.cap:
            self.cache.popitem(last=False)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InvertBinaryTree.BreadthFirstSearch
    set output_file "InvertTree.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None
        queue = deque([root])
        while queue:
            node = queue.popleft()
            node.left, node.right = node.right, node.left
            if node.left:
                queue.append(node.left)
            if node.right:
                queue.append(node.right)
        return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InvertBinaryTree.DepthFirstSearch
    set output_file "InvertTree.DFSRecursive.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right
class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None

        root.left, root.right = root.right, root.left

        self.invertTree(root.left)
        self.invertTree(root.right)

        return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.InvertBinaryTree.IterativeDFS
    set output_file "InvertTree.DFSStack.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def invertTree(self, root: Optional[TreeNode]) -> Optional[TreeNode]:
        if not root:
            return None
        stack = [root]
        while stack:
            node = stack.pop()
            node.left, node.right = node.right, node.left
            if node.left:
                stack.append(node.left)
            if node.right:
                stack.append(node.right)
        return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algo.MaximumDepthBinaryTree.RecursiveDFS
    set output_file "MaxDepth.Recursive.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        return 1 + max(self.maxDepth(root.left), self.maxDepth(root.right))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumDepthBinaryTree.IterativeDFS_Stack
    set output_file "MaxDepth.DFSStack.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        stack = [[root, 1]]
        res = 0

        while stack:
            node, depth = stack.pop()
            if node:
                res = max(res, depth)
                stack.append([node.left, depth + 1])
                stack.append([node.right, depth + 1])
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumDepthBinaryTree.BreadthFirstSearch
    set output_file "MaxDepth.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def maxDepth(self, root: Optional[TreeNode]) -> int:
        q = deque()
        if root:
            q.append(root)

        level = 0
        while q:
            for i in range(len(q)):
                node = q.popleft()
                if node.left:
                    q.append(node.left)
                if node.right:
                    q.append(node.right)
            level += 1
        return level
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DiameterofBinaryTree.BruteForce
    set output_file "DiameterOfBinaryTree.Recursive.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0

        leftHeight = self.maxHeight(root.left)
        rightHeight = self.maxHeight(root.right)
        diameter = leftHeight + rightHeight
        sub = max(self.diameterOfBinaryTree(root.left),
                  self.diameterOfBinaryTree(root.right))
        return max(diameter, sub)

    def maxHeight(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        return 1 + max(self.maxHeight(root.left), self.maxHeight(root.right))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DiameterofBinaryTree.DepthFirstSearch
    set output_file "DiameterOfBinaryTree.DFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        res = 0

        def dfs(root):
            nonlocal res
            if not root:
                return 0
            left = dfs(root.left)
            right = dfs(root.right)
            res = max(res, left + right)
            return 1 + max(left, right)

        dfs(root)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DiameterofBinaryTree.IterativeDFS
    set output_file "DiameterOfBinaryTree.Iterative.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def diameterOfBinaryTree(self, root: Optional[TreeNode]) -> int:
        stack = [root]
        mp = {None: (0, 0)}

        while stack:
            node = stack[-1]
            if node.left and node.left not in mp:
                stack.append(node.left)
            elif node.right and node.right not in mp:
                stack.append(node.right)
            else:
                node = stack.pop()
                leftHeight, leftDiameter = mp[node.left]
                rightHeight, rightDiameter = mp[node.right]
                mp[node] = (1 + max(leftHeight, rightHeight),
                           max(leftHeight + rightHeight, leftDiameter, rightDiameter))

        return mp[root][1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.
    set output_file "IsBalanced.RecursiveTopDown.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        left = self.height(root.left)
        right = self.height(root.right)
        if abs(left - right) > 1:
            return False
        return self.isBalanced(root.left) and self.isBalanced(root.right)

    def height(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        return 1 + max(self.height(root.left), self.height(root.right))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.
    set output_file "IsBalanced.RecursiveBottomUp.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        def dfs(root):
            if not root:
                return [True, 0]

            left, right = dfs(root.left), dfs(root.right)
            balanced = left[0] and right[0] and abs(left[1] - right[1]) <= 1
            return [balanced, 1 + max(left[1], right[1])]

        return dfs(root)[0]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BalancedBinaryTree.BruteForce
    set output_file "IsBalanced.RecursiveTopDown.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        left = self.height(root.left)
        right = self.height(root.right)
        if abs(left - right) > 1:
            return False
        return self.isBalanced(root.left) and self.isBalanced(root.right)

    def height(self, root: Optional[TreeNode]) -> int:
        if not root:
            return 0
        return 1 + max(self.height(root.left), self.height(root.right))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BalancedBinaryTree.DepthFirstSearch
    set output_file "IsBalanced.RecursiveBottomUp.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isBalanced(self, root: Optional[TreeNode]) -> bool:
        def dfs(root):
            if not root:
                return [True, 0]

            left, right = dfs(root.left), dfs(root.right)
            balanced = left[0] and right[0] and abs(left[1] - right[1]) <= 1
            return [balanced, 1 + max(left[1], right[1])]

        return dfs(root)[0]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.BalancedBinaryTree.IterativeDFS
    set output_file "IsBalanced.Iterative.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isBalanced(self, root):
        stack = []
        node = root
        last = None
        depths = {}

        while stack or node:
            if node:
                stack.append(node)
                node = node.left
            else:
                node = stack[-1]
                if not node.right or last == node.right:
                    stack.pop()
                    left = depths.get(node.left, 0)
                    right = depths.get(node.right, 0)

                    if abs(left - right) > 1:
                        return False

                    depths[node] = 1 + max(left, right)
                    last = node
                    node = None
                else:
                    node = node.right

        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SameBinaryTree.DepthFirstSearch
    set output_file "IsSameTree.Recursive.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        if not p and not q:
            return True
        if p and q and p.val == q.val:
            return self.isSameTree(p.left, q.left) and self.isSameTree(p.right, q.right)
        else:
            return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SameBinaryTree.IterativeDFS
    set output_file "IsSameTree.IterativeStack.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        stack = [(p, q)]

        while stack:
            node1, node2 = stack.pop()

            if not node1 and not node2:
                continue
            if not node1 or not node2 or node1.val != node2.val:
                return False

            stack.append((node1.right, node2.right))
            stack.append((node1.left, node2.left))

        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SameBinaryTree.BreadthFirstSearch
    set output_file "IsSameTree.IterativeQueue.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def isSameTree(self, p: Optional[TreeNode], q: Optional[TreeNode]) -> bool:
        q1 = deque([p])
        q2 = deque([q])

        while q1 and q2:
            for _ in range(len(q1)):
                nodeP = q1.popleft()
                nodeQ = q2.popleft()

                if nodeP is None and nodeQ is None:
                    continue
                if nodeP is None or nodeQ is None or nodeP.val != nodeQ.val:
                    return False

                q1.append(nodeP.left)
                q1.append(nodeP.right)
                q2.append(nodeQ.left)
                q2.append(nodeQ.right)

        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SubtreeofAnotherTree.DepthFirstSearch
    set output_file "IsSubtree.Recursive.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:

    def isSubtree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        if not subRoot:
            return True
        if not root:
            return False

        if self.sameTree(root, subRoot):
            return True
        return (self.isSubtree(root.left, subRoot) or
                self.isSubtree(root.right, subRoot))

    def sameTree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        if not root and not subRoot:
            return True
        if root and subRoot and root.val == subRoot.val:
            return (self.sameTree(root.left, subRoot.left) and
                    self.sameTree(root.right, subRoot.right))
        return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SubtreeofAnotherTree.SerializationAndPatternMatching
    set output_file "IsSubtree.ZFunction.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def serialize(self, root: Optional[TreeNode]) -> str:
        if root is None:
            return "$#"

        return "$" + str(root.val) + self.serialize(root.left) + self.serialize(root.right)

    def z_function(self, s: str) -> list:
        z = [0] * len(s)
        l = r = 0
        for i in range(1, len(s)):
            if i <= r:
                z[i] = min(r - i + 1, z[i - l])
            while i + z[i] < len(s) and s[z[i]] == s[i + z[i]]:
                z[i] += 1
            if i + z[i] - 1 > r:
                l, r = i, i + z[i] - 1
        return z

    def isSubtree(self, root: Optional[TreeNode], subRoot: Optional[TreeNode]) -> bool:
        serialized_root = self.serialize(root)
        serialized_subRoot = self.serialize(subRoot)
        combined = serialized_subRoot + "|" + serialized_root

        z_values = self.z_function(combined)
        sub_len = len(serialized_subRoot)

        for i in range(sub_len + 1, len(combined)):
            if z_values[i] == sub_len:
                return True
        return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LowestCommonAncestorBinarySearchTree.Recursion
    set output_file "LCA.BST.Recursive.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        if not root or not p or not q:
            return None
        if max(p.val, q.val) < root.val:
            return self.lowestCommonAncestor(root.left, p, q)
        elif min(p.val, q.val) > root.val:
            return self.lowestCommonAncestor(root.right, p, q)
        else:
            return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LowestCommonAncestorBinarySearchTree.Iteration
    set output_file "LCA.BST.Iterative.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def lowestCommonAncestor(self, root: TreeNode, p: TreeNode, q: TreeNode) -> TreeNode:
        cur = root

        while cur:
            if p.val > cur.val and q.val > cur.val:
                cur = cur.right
            elif p.val < cur.val and q.val < cur.val:
                cur = cur.left
            else:
                return cur
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeLevelOrderTraversal.DepthFirstSearch
    set output_file "LevelOrder.DFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        res = []

        def dfs(node, depth):
            if not node:
                return None
            if len(res) == depth:
                res.append([])

            res[depth].append(node.val)
            dfs(node.left, depth + 1)
            dfs(node.right, depth + 1)

        dfs(root, 0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeLevelOrderTraversal.BreadthFirstSearch
    set output_file "LevelOrder.BFS.py"

    set template_content '# Definition for a binary tree node.
class TreeNode:
    def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

import collections

class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        res = []

        q = collections.deque()
        q.append(root)

        while q:
            qLen = len(q)
            level = []
            for i in range(qLen):
                node = q.popleft()
                if node:
                    level.append(node.val)
                    q.append(node.left)
                    q.append(node.right)
            if level:
                res.append(level)

        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeLevelOrderTraversal.DepthFirstSearch
    set output_file "LevelOrder.DFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        res = []

        def dfs(node, depth):
            if not node:
                return
            if len(res) == depth:
                res.append([])

            res[depth].append(node.val)
            dfs(node.left, depth + 1)
            dfs(node.right, depth + 1)

        dfs(root, 0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.BinaryTreeLevelOrderTraversal.BreadthFirstSearch
    set output_file "LevelOrder.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

import collections

class Solution:
    def levelOrder(self, root: Optional[TreeNode]) -> List[List[int]]:
        res = []

        q = collections.deque()
        if root:
            q.append(root)

        while q:
            qLen = len(q)
            level = []
            for i in range(qLen):
                node = q.popleft()
                if node:
                    level.append(node.val)
                    q.append(node.left)
                    q.append(node.right)
            if level:
                res.append(level)

        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountGoodNodesBinaryTree.DepthFirstSearch
    set output_file "RightSideView.DFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        res = []

        def dfs(node, depth):
            if not node:
                return
            if depth == len(res):
                res.append(node.val)

            dfs(node.right, depth + 1)
            dfs(node.left, depth + 1)

        dfs(root, 0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountGoodNodesBinaryTree.BreadthFirstSearch
    set output_file "RightSideView.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def rightSideView(self, root: Optional[TreeNode]) -> List[int]:
        res = []
        q = deque([root])

        while q:
            rightSide = None
            qLen = len(q)

            for i in range(qLen):
                node = q.popleft()
                if node:
                    rightSide = node
                    q.append(node.left)
                    q.append(node.right)
            if rightSide:
                res.append(rightSide.val)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountGoodNodesBinaryTree.DepthFirstSearch
    set output_file "GoodNodes.DFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def goodNodes(self, root: TreeNode) -> int:

        def dfs(node, maxVal):
            if not node:
                return 0

            res = 1 if node.val >= maxVal else 0
            maxVal = max(maxVal, node.val)
            res += dfs(node.left, maxVal)
            res += dfs(node.right, maxVal)
            return res

        return dfs(root, root.val)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountGoodNodesBinaryTree.BreadthFirstSearch
    set output_file "GoodNodes.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def goodNodes(self, root: TreeNode) -> int:
        res = 0
        q = deque()
        q.append((root, -float("inf")))

        while q:
            node, maxval = q.popleft()
            if node.val >= maxval:
                res += 1

            if node.left:
                q.append((node.left, max(maxval, node.val)))
            if node.right:
                q.append((node.right, max(maxval, node.val)))

        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidBinarySearchTree.BruteForce
    set output_file "IsValidBST.Lambda.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    left_check = staticmethod(lambda val, limit: val < limit)
    right_check = staticmethod(lambda val, limit: val > limit)

    def isValidBST(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        if (not self.isValid(root.left, root.val, self.left_check) or
            not self.isValid(root.right, root.val, self.right_check)):
            return False

        return self.isValidBST(root.left) and self.isValidBST(root.right)

    def isValid(self, root: Optional[TreeNode], limit: int, check) -> bool:
        if not root:
            return True
        if not check(root.val, limit):
            return False
        return (self.isValid(root.left, limit, check) and
                self.isValid(root.right, limit, check))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidBinarySearchTree.DepthFirstSearch
    set output_file "IsValidBST.Recursive.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def isValidBST(self, root: Optional[TreeNode]) -> bool:
        def valid(node, left, right):
            if not node:
                return True
            if not (left < node.val < right):
                return False

            return valid(node.left, left, node.val) and valid(
                node.right, node.val, right
            )

        return valid(root, float("-inf"), float("inf"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ValidBinarySearchTree.BreadthFirstSearch
    set output_file "IsValidBST.BFS.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

from collections import deque

class Solution:
    def isValidBST(self, root: Optional[TreeNode]) -> bool:
        if not root:
            return True

        q = deque([(root, float("-inf"), float("inf"))])

        while q:
            node, left, right = q.popleft()
            if not (left < node.val < right):
                return False
            if node.left:
                q.append((node.left, left, node.val))
            if node.right:
                q.append((node.right, node.val, right))

        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestIntegerinBST.BruteForce
    set output_file "KthSmallest.DFS.Sort.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        arr = []

        def dfs(node):
            if not node:
                return
            arr.append(node.val)
            dfs(node.left)
            dfs(node.right)

        dfs(root)
        arr.sort()
        return arr[k - 1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthSmallestIntegerinBST.InorderTraversal
    set output_file "KthSmallest.DFS.Inorder.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        arr = []

        def dfs(node):
            if not node:
                return
            dfs(node.left)
            arr.append(node.val)
            dfs(node.right)

        dfs(root)
        return arr[k - 1]
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestIntegerinBST.RecursiveDFS_Optimal
    set output_file "KthSmallest.DFS.Inorder.EarlyExit.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        cnt = k
        res = root.val

        def dfs(node):
            nonlocal cnt, res
            if not node:
                return
            dfs(node.left)
            cnt -= 1
            if cnt == 0:
                res = node.val
                return
            dfs(node.right)

        dfs(root)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthSmallestIntegerinBST.IterativeDFS_Optimal
    set output_file "KthSmallest.Iterative.Stack.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        stack = []
        curr = root

        while stack or curr:
            while curr:
                stack.append(curr)
                curr = curr.left
            curr = stack.pop()
            k -= 1
            if k == 0:
                return curr.val
            curr = curr.right
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthSmallestIntegerinBST.MorrisTraversal
    set output_file "KthSmallest.Morris.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def kthSmallest(self, root: Optional[TreeNode], k: int) -> int:
        curr = root

        while curr:
            if not curr.left:
                k -= 1
                if k == 0:
                    return curr.val
                curr = curr.right
            else:
                pred = curr.left
                while pred.right and pred.right != curr:
                    pred = pred.right

                if not pred.right:
                    pred.right = curr
                    curr = curr.left
                else:
                    pred.right = None
                    k -= 1
                    if k == 0:
                        return curr.val
                    curr = curr.right

        return -1
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ConstructBinaryTreefromPreorderInorderTraversal.DepthFirstSearch
    set output_file "BuildTree.Recursive.Basic.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        if not preorder or not inorder:
            return None

        root = TreeNode(preorder[0])
        mid = inorder.index(preorder[0])
        root.left = self.buildTree(preorder[1 : mid + 1], inorder[:mid])
        root.right = self.buildTree(preorder[mid + 1 :], inorder[mid + 1 :])
        return root
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ConstructBinaryTreefromPreorderInorderTraversal.HashMap_DepthFirstSearch
    set output_file "BuildTree.Recursive.Dict.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        indices = {val: idx for idx, val in enumerate(inorder)}

        self.pre_idx = 0
        def dfs(l, r):
            if l > r:
                return None

            root_val = preorder[self.pre_idx]
            self.pre_idx += 1
            root = TreeNode(root_val)
            mid = indices[root_val]
            root.left = dfs(l, mid - 1)
            root.right = dfs(mid + 1, r)
            return root

        return dfs(0, len(inorder) - 1)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ConstructBinaryTreefromPreorderInorderTraversal.DepthFirst_SearchOptimal
    set output_file "BuildTree.Recursive.Limit.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        preIdx = inIdx = 0
        def dfs(limit):
            nonlocal preIdx, inIdx
            if preIdx >= len(preorder):
                return None
            if inorder[inIdx] == limit:
                inIdx += 1
                return None

            root = TreeNode(preorder[preIdx])
            preIdx += 1
            root.left = dfs(root.val)
            root.right = dfs(limit)
            return root
        return dfs(float("inf"))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ConstructBinaryTreefromPreorderInorderTraversal.MorrisTraversal
    set output_file "BuildTree.Iterative.py"

    set template_content '# Definition for a binary tree node.
 class TreeNode:
     def __init__(self, val=0, left=None, right=None):
         self.val = val
         self.left = left
         self.right = right

class Solution:
    def buildTree(self, preorder: List[int], inorder: List[int]) -> Optional[TreeNode]:
        head = TreeNode(None)
        curr = head
        i, j, n = 0, 0, len(preorder)
        while i < n and j < n:
            curr.right = TreeNode(preorder[i], right = curr.right)
            curr = curr.right
            i += 1
            while i < n and curr.val != inorder[j]:
                curr.left = TreeNode(preorder[i], right=curr)
                curr = curr.left
                i += 1
            j += 1
            while curr.right and j < n and curr.right.val == inorder[j]:
                prev = curr.right
                curr.right = None
                curr = prev
                j += 1

        return head.right
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ImplementTrie_PrefixTree.PrefixTreeArray
    set output_file "Trie.FixedArray.py"

    set template_content 'class TrieNode:
    def __init__(self):
        self.children = [None] * 26
        self.endOfWord = False

class PrefixTree:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word: str) -> None:
        cur = self.root
        for c in word:
            i = ord(c) - ord("a")
            if cur.children[i] == None:
                cur.children[i] = TrieNode()
            cur = cur.children[i]
        cur.endOfWord = True

    def search(self, word: str) -> bool:
        cur = self.root
        for c in word:
            i = ord(c) - ord("a")
            if cur.children[i] == None:
                return False
            cur = cur.children[i]
        return cur.endOfWord

    def startsWith(self, prefix: str) -> bool:
        cur = self.root
        for c in prefix:
            i = ord(c) - ord("a")
            if cur.children[i] == None:
                return False
            cur = cur.children[i]
        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ImplementTrie_PrefixTree.PrefixTree_HashMap
    set output_file "Trie.Dictionary.py"

    set template_content 'class TrieNode:
    def __init__(self):
        self.children = {}
        self.endOfWord = False

class PrefixTree:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word: str) -> None:
        cur = self.root
        for c in word:
            if c not in cur.children:
                cur.children[c] = TrieNode()
            cur = cur.children[c]
        cur.endOfWord = True

    def search(self, word: str) -> bool:
        cur = self.root
        for c in word:
            if c not in cur.children:
                return False
            cur = cur.children[c]
        return cur.endOfWord

    def startsWith(self, prefix: str) -> bool:
        cur = self.root
        for c in prefix:
            if c not in cur.children:
                return False
            cur = cur.children[c]
        return True
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algo.DesignAddSearchWordDataStructure.BruteForce
    set output_file "WordDictionary.List.py"

    set template_content 'class WordDictionary:

    def __init__(self):
        self.store = []

    def addWord(self, word: str) -> None:
        self.store.append(word)

    def search(self, word: str) -> bool:
        for w in self.store:
            if len(w) != len(word):
                continue
            i = 0
            while i < len(w):
                if w[i] == word[i] or word[i] == ".":
                    i += 1
                else:
                    break
            if i == len(w):
                return True
        return False
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algo.DesignAddSearchWordDataStructure.DepthFirstSearch
    set output_file "WordDictionary.Trie.py"

    set template_content 'class TrieNode:
    def __init__(self):
        self.children = {}
        self.word = False

class WordDictionary:
    def __init__(self):
        self.root = TrieNode()

    def addWord(self, word: str) -> None:
        cur = self.root
        for c in word:
            if c not in cur.children:
                cur.children[c] = TrieNode()
            cur = cur.children[c]
        cur.word = True

    def search(self, word: str) -> bool:
        def dfs(j, root):
            cur = root

            for i in range(j, len(word)):
                c = word[i]
                if c == ".":
                    for child in cur.children.values():
                        if dfs(i + 1, child):
                            return True
                    return False
                else:
                    if c not in cur.children:
                        return False
                    cur = cur.children[c]
            return cur.word

        return dfs(0, self.root)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Subsets.Backtracking
    set output_file "subsets.dfs.py"

    set template_content '# Definition for subsets using DFS (backtracking)

class Solution:
    def subsets(self, nums):
        res = []
        subset = []

        def dfs(i):
            if i >= len(nums):
                res.append(subset.copy())
                return
            subset.append(nums[i])
            dfs(i + 1)
            subset.pop()
            dfs(i + 1)

        dfs(0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algo.Subsets.Iteration
    set output_file "subsets.iter.py"

    set template_content '# Definition for subsets using iterative method

class Solution:
    def subsets(self, nums):
        res = [[]]

        for num in nums:
            res += [subset + [num] for subset in res]

        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Subsets.BitManipulation
    set output_file "subsets.bitmask.py"

    set template_content '# Definition for subsets using bitmask

class Solution:
    def subsets(self, nums):
        n = len(nums)
        res = []
        for i in range(1 << n):
            subset = [nums[j] for j in range(n) if (i & (1 << j))]
            res.append(subset)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CombinationSum.Backtracking
    set output_file "CombinationSumDFS1.py"

    set template_content '# Combination Sum — DFS with include/exclude

class Solution:
    def combinationSum(self, nums, target):
        res = []

        def dfs(i, cur, total):
            if total == target:
                res.append(cur.copy())
                return
            if i >= len(nums) or total > target:
                return

            cur.append(nums[i])
            dfs(i, cur, total + nums[i])
            cur.pop()
            dfs(i + 1, cur, total)

        dfs(0, [], 0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CombinationSum.Backtracking_Optimal
    set output_file "CombinationSum.DFS2.py"

    set template_content '# Combination Sum — DFS with for-loop + pruning

class Solution:
    def combinationSum(self, nums, target):
        res = []
        nums.sort()

        def dfs(i, cur, total):
            if total == target:
                res.append(cur.copy())
                return

            for j in range(i, len(nums)):
                if total + nums[j] > target:
                    return
                cur.append(nums[j])
                dfs(j, cur, total + nums[j])
                cur.pop()

        dfs(0, [], 0)
        return res
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CombinationSumII.BruteForce
    set output_file "CombinationSum2.SET.py"

    set template_content "# Combination Sum II — solution using set to avoid duplicates

class Solution:
    def combinationSum2(self, candidates, target):
        res = set()
        candidates.sort()

        def generate_subsets(i, cur, total):
            if total == target:
                res.add(tuple(cur))
                return
            if total > target or i == len(candidates):
                return

            cur.append(candidates[i])
            generate_subsets(i + 1, cur, total + candidates[i])
            cur.pop()

            generate_subsets(i + 1, cur, total)

        generate_subsets(0, [], 0)
        return [list(combination) for combination in res]
"

    echo "$template_content" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    cat $output_file
end

function algoP.CombinationSumII.Backtracking
    set output_file "CombinationSum2.SKIPDUP.py"

    set template_content "# Combination Sum II — skip duplicates by advancing index

class Solution:
    def combinationSum2(self, candidates, target):
        res = []
        candidates.sort()

        def dfs(i, cur, total):
            if total == target:
                res.append(cur.copy())
                return
            if total > target or i == len(candidates):
                return

            cur.append(candidates[i])
            dfs(i + 1, cur, total + candidates[i])
            cur.pop()

            while i + 1 < len(candidates) and candidates[i] == candidates[i + 1]:
                i += 1
            dfs(i + 1, cur, total)

        dfs(0, [], 0)
        return res
"

    echo "$template_content" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    cat $output_file
end


function algoP.CombinationSumII.Backtracking_HashMap
    set output_file "CombinationSum2.COUNTMAP.py"

    set template_content "# Combination Sum II — using frequency map

from collections import defaultdict

class Solution:
    def combinationSum2(self, nums, target):
        self.res = []
        self.count = defaultdict(int)
        cur = []
        A = []

        for num in nums:
            if self.count[num] == 0:
                A.append(num)
            self.count[num] += 1

        self.backtrack(A, target, cur, 0)
        return self.res

    def backtrack(self, nums, target, cur, i):
        if target == 0:
            self.res.append(cur.copy())
            return
        if target < 0 or i >= len(nums):
            return

        if self.count[nums[i]] > 0:
            cur.append(nums[i])
            self.count[nums[i]] -= 1
            self.backtrack(nums, target - nums[i], cur, i)
            self.count[nums[i]] += 1
            cur.pop()

        self.backtrack(nums, target, cur, i + 1)
"

    echo "$template_content" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    cat $output_file
end

function algo.CombinationSumII.Backtracking_Optimal
    set output_file "CombinationSum2.FORLOOP.py"

    set template_content "# Combination Sum II — classic sorted + skip dup in loop

class Solution:
    def combinationSum2(self, candidates, target):
        res = []
        candidates.sort()

        def dfs(idx, path, cur):
            if cur == target:
                res.append(path.copy())
                return
            for i in range(idx, len(candidates)):
                if i > idx and candidates[i] == candidates[i - 1]:
                    continue
                if cur + candidates[i] > target:
                    break

                path.append(candidates[i])
                dfs(i + 1, path, cur + candidates[i])
                path.pop()

        dfs(0, [], 0)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Permutations.Recursion
    set output_file "Permute.RECURSIVE_INSERT.py"

    set template_content "# Permutations — recursive insert method

class Solution:
    def permute(self, nums):
        if len(nums) == 0:
            return [[]]

        perms = self.permute(nums[1:])
        res = []
        for p in perms:
            for i in range(len(p) + 1):
                p_copy = p.copy()
                p_copy.insert(i, nums[0])
                res.append(p_copy)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Permutations.Iteration
    set output_file "Permute.ITERATIVE_INSERT.py"

    set template_content "# Permutations — iterative insert method

class Solution:
    def permute(self, nums):
        perms = [[]]
        for num in nums:
            new_perms = []
            for p in perms:
                for i in range(len(p) + 1):
                    p_copy = p.copy()
                    p_copy.insert(i, num)
                    new_perms.append(p_copy)
            perms = new_perms
        return perms
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.Permutations.Backtracking
    set output_file "Permute.BACKTRACK_BOOL.py"

    set template_content "# Permutations — backtracking with boolean used-array

class Solution:
    def permute(self, nums):
        self.res = []
        self.backtrack([], nums, [False] * len(nums))
        return self.res

    def backtrack(self, perm, nums, pick):
        if len(perm) == len(nums):
            self.res.append(perm[:])
            return
        for i in range(len(nums)):
            if not pick[i]:
                perm.append(nums[i])
                pick[i] = True
                self.backtrack(perm, nums, pick)
                perm.pop()
                pick[i] = False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Permutations.Backtracking_BitMask
    set output_file "Permute.BACKTRACK_MASK.py"

    set template_content "# Permutations — bitmask backtracking

class Solution:
    def permute(self, nums):
        self.res = []
        self.backtrack([], nums, 0)
        return self.res

    def backtrack(self, perm, nums, mask):
        if len(perm) == len(nums):
            self.res.append(perm[:])
            return
        for i in range(len(nums)):
            if not (mask & (1 << i)):
                perm.append(nums[i])
                self.backtrack(perm, nums, mask | (1 << i))
                perm.pop()
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Permutations.Backtracking_Optimal
    set output_file "Permute.SWAP.py"

    set template_content "# Permutations — swap method (in-place)

class Solution:
    def permute(self, nums):
        self.res = []
        self.backtrack(nums, 0)
        return self.res

    def backtrack(self, nums, idx):
        if idx == len(nums):
            self.res.append(nums[:])
            return
        for i in range(idx, len(nums)):
            nums[idx], nums[i] = nums[i], nums[idx]
            self.backtrack(nums, idx + 1)
            nums[idx], nums[i] = nums[i], nums[idx]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SubsetsII.BruteForce 
    set output_file "SubsetsWithDup.SET.py"

    set template_content "# Subsets II — using set to avoid duplicates
from typing import List

class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        res = set()

        def backtrack(i, subset):
            if i == len(nums):
                res.add(tuple(subset))
                return

            subset.append(nums[i])
            backtrack(i + 1, subset)
            subset.pop()
            backtrack(i + 1, subset)

        nums.sort()
        backtrack(0, [])
        return [list(s) for s in res]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SubsetsII.Backtracking-I
    set output_file "SubsetsWithDup.SkipDupRecursive.py"

    set template_content "# Subsets II — backtracking skip duplicates
from typing import List

class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        res = []
        nums.sort()

        def backtrack(i, subset):
            if i == len(nums):
                res.append(subset[::])
                return

            subset.append(nums[i])
            backtrack(i + 1, subset)
            subset.pop()

            while i + 1 < len(nums) and nums[i] == nums[i + 1]:
                i += 1
            backtrack(i + 1, subset)

        backtrack(0, [])
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SubsetsII.Backtracking-II
    set output_file "SubsetsWithDup.ForLoopBacktrack.py"

    set template_content "# Subsets II — for-loop backtracking skip duplicates
from typing import List

class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        res = []
        def backtrack(i, subset):
            res.append(subset[::])

            for j in range(i, len(nums)):
                if j > i and nums[j] == nums[j - 1]:
                    continue
                subset.append(nums[j])
                backtrack(j + 1, subset)
                subset.pop()

        backtrack(0, [])
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.SubsetsII.Iteration
    set output_file "SubsetsWithDup.Iterative.py"

    set template_content "# Subsets II — iterative method skip duplicates
from typing import List

class Solution:
    def subsetsWithDup(self, nums: List[int]) -> List[List[int]]:
        nums.sort()
        res = [[]]
        prev_idx = 0

        for i in range(len(nums)):
            start = prev_idx if i >= 1 and nums[i] == nums[i - 1] else 0
            prev_idx = len(res)
            for j in range(start, prev_idx):
                tmp = res[j].copy()
                tmp.append(nums[i])
                res.append(tmp)

        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GenerateParentheses.BruteForce
    set output_file "GenerateParenthesis.Bruteforce.py"

    set template_content "# Generate Parentheses — brute force validation
from typing import List

class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        res = []

        def valid(s: str):
            open = 0
            for c in s:
                open += 1 if c == '(' else -1
                if open < 0:
                    return False
            return open == 0

        def dfs(s: str):
            if len(s) == 2 * n:
                if valid(s):
                    res.append(s)
                return
            dfs(s + '(')
            dfs(s + ')')

        dfs('')
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GenerateParentheses.Backtracking
    set output_file "GenerateParenthesis.Backtracking.py"

    set template_content "# Generate Parentheses — backtracking method
from typing import List

class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        res = []
        stack = []

        def backtrack(openN, closedN):
            if openN == closedN == n:
                res.append(''.join(stack))
                return
            if openN < n:
                stack.append('(')
                backtrack(openN + 1, closedN)
                stack.pop()
            if closedN < openN:
                stack.append(')')
                backtrack(openN, closedN + 1)
                stack.pop()

        backtrack(0, 0)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GenerateParentheses.DynamicProgramming
    set output_file "GenerateParenthesis.DP.py"

    set template_content "# Generate Parentheses — dynamic programming method
from typing import List

class Solution:
    def generateParenthesis(self, n: int) -> List[str]:
        res = [[] for _ in range(n + 1)]
        res[0] = ['']

        for k in range(1, n + 1):
            for i in range(k):
                for left in res[i]:
                    for right in res[k - i - 1]:
                        res[k].append('(' + left + ')' + right)

        return res[n]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordSearch.Backtracking_HashSet
    set output_file "WordSearch.SET.py"

    set template_content "# Word Search — backtracking with hash set
from typing import List

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        ROWS, COLS = len(board), len(board[0])
        path = set()

        def dfs(r, c, i):
            if i == len(word):
                return True

            if (min(r, c) < 0 or
                r >= ROWS or c >= COLS or
                word[i] != board[r][c] or
                (r, c) in path):
                return False

            path.add((r, c))
            res = (dfs(r + 1, c, i + 1) or
                   dfs(r - 1, c, i + 1) or
                   dfs(r, c + 1, i + 1) or
                   dfs(r, c - 1, i + 1))
            path.remove((r, c))
            return res

        for r in range(ROWS):
            for c in range(COLS):
                if dfs(r, c, 0):
                    return True
        return False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordSearch.Backtracking_VisitedArray
    set output_file "WordSearch.VISITED.py"

    set template_content "# Word Search — backtracking with visited array
from typing import List

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        ROWS, COLS = len(board), len(board[0])
        visited = [[False for _ in range(COLS)] for _ in range(ROWS)]

        def dfs(r, c, i):
            if i == len(word):
                return True
            if (r < 0 or c < 0 or r >= ROWS or c >= COLS or
                word[i] != board[r][c] or visited[r][c]):
                return False

            visited[r][c] = True
            res = (dfs(r + 1, c, i + 1) or
                   dfs(r - 1, c, i + 1) or
                   dfs(r, c + 1, i + 1) or
                   dfs(r, c - 1, i + 1))
            visited[r][c] = False
            return res

        for r in range(ROWS):
            for c in range(COLS):
                if dfs(r, c, 0):
                    return True
        return False
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordSearch.Backtracking_Optimal
    set output_file "WordSearch.INPLACE.py"

    set template_content "# Word Search — backtracking in-place marking
from typing import List

class Solution:
    def exist(self, board: List[List[str]], word: str) -> bool:
        ROWS, COLS = len(board), len(board[0])

        def dfs(r, c, i):
            if i == len(word):
                return True
            if (r < 0 or c < 0 or r >= ROWS or c >= COLS or
                word[i] != board[r][c] or board[r][c] == '#'):
                return False

            board[r][c] = '#'
            res = (dfs(r + 1, c, i + 1) or
                   dfs(r - 1, c, i + 1) or
                   dfs(r, c + 1, i + 1) or
                   dfs(r, c - 1, i + 1))
            board[r][c] = word[i]
            return res

        for r in range(ROWS):
            for c in range(COLS):
                if dfs(r, c, 0):
                    return True
        return False
"

    echo "$template_content" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    cat $output_file
end

function algoP.PalindromePartitioning.Backtracking-I
    set output_file "Partition.DFS1.SET.py"

    set template_content "# Palindrome Partitioning — backtracking with set
from typing import List

class Solution:
    def partition(self, s: str) -> List[List[str]]:
        res, part = [], []

        def dfs(j, i):
            if i >= len(s):
                if i == j:
                    res.append(part.copy())
                return

            if self.isPali(s, j, i):
                part.append(s[j : i + 1])
                dfs(i + 1, i + 1)
                part.pop()

            dfs(j, i + 1)

        dfs(0, 0)
        return res

    def isPali(self, s, l, r):
        while l < r:
            if s[l] != s[r]:
                return False
            l, r = l + 1, r - 1
        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PalindromePartitioning.Backtracking-II
    set output_file "Partition.DFS2.SET.py"

    set template_content "# Palindrome Partitioning — backtracking (for loop)
from typing import List

class Solution:
    def partition(self, s: str) -> List[List[str]]:
        res, part = [], []

        def dfs(i):
            if i >= len(s):
                res.append(part.copy())
                return
            for j in range(i, len(s)):
                if self.isPali(s, i, j):
                    part.append(s[i : j + 1])
                    dfs(j + 1)
                    part.pop()

        dfs(0)
        return res

    def isPali(self, s, l, r):
        while l < r:
            if s[l] != s[r]:
                return False
            l, r = l + 1, r - 1
        return True
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.PalindromePartitioning.BacktrackingDP
    set output_file "Partition.DP1.SET.py"

    set template_content "# Palindrome Partitioning — DP + backtracking
from typing import List

class Solution:
    def partition(self, s: str) -> List[List[str]]:
        n = len(s)
        dp = [[False] * n for _ in range(n)]
        for l in range(1, n + 1):
            for i in range(n - l + 1):
                dp[i][i + l - 1] = (s[i] == s[i + l - 1] and
                                    (i + 1 > (i + l - 2) or
                                     dp[i + 1][i + l - 2]))

        res, part = [], []

        def dfs(i):
            if i >= len(s):
                res.append(part.copy())
                return
            for j in range(i, len(s)):
                if dp[i][j]:
                    part.append(s[i : j + 1])
                    dfs(j + 1)
                    part.pop()

        dfs(0)
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PalindromePartitioning.Recursion
    set output_file "Partition.DP2.SET.py"

    set template_content "# Palindrome Partitioning — DP + recursion
from typing import List

class Solution:
    def partition(self, s: str) -> List[List[str]]:
        n = len(s)
        dp = [[False] * n for _ in range(n)]
        for l in range(1, n + 1):
            for i in range(n - l + 1):
                dp[i][i + l - 1] = (s[i] == s[i + l - 1] and
                                    (i + 1 > (i + l - 2) or
                                     dp[i + 1][i + l - 2]))

        def dfs(i):
            if i >= n:
                return [[]]

            ret = []
            for j in range(i, n):
                if dp[i][j]:
                    nxt = dfs(j + 1)
                    for part in nxt:
                        cur = [s[i : j + 1]] + part
                        ret.append(cur)
            return ret

        return dfs(0)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LetterCombinationsofPhoneNumber.Backtracking
    set output_file "LetterCombinations.BACKTRACK.SET.py"

    set template_content "# Letter Combinations of a Phone Number — backtracking
from typing import List

class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        res = []
        digitToChar = {
            \"2\": \"abc\",
            \"3\": \"def\",
            \"4\": \"ghi\",
            \"5\": \"jkl\",
            \"6\": \"mno\",
            \"7\": \"qprs\",
            \"8\": \"tuv\",
            \"9\": \"wxyz\",
        }

        def backtrack(i, curStr):
            if len(curStr) == len(digits):
                res.append(curStr)
                return
            for c in digitToChar[digits[i]]:
                backtrack(i + 1, curStr + c)

        if digits:
            backtrack(0, \"\")

        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LetterCombinationsofPhoneNumber.Iteration
    set output_file "LetterCombinations.ITERATIVE.SET.py"

    set template_content "# Letter Combinations of a Phone Number — iterative
from typing import List

class Solution:
    def letterCombinations(self, digits: str) -> List[str]:
        if not digits:
            return []

        res = [\"\"] 
        digitToChar = {
            \"2\": \"abc\",
            \"3\": \"def\",
            \"4\": \"ghi\",
            \"5\": \"jkl\",
            \"6\": \"mno\",
            \"7\": \"qprs\",
            \"8\": \"tuv\",
            \"9\": \"wxyz\",
        }

        for digit in digits:
            tmp = []
            for curStr in res:
                for c in digitToChar[digit]:
                    tmp.append(curStr + c)
            res = tmp
        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthLargestElementinStream.Sorting
    set output_file "KthLargest.SORT.SET.py"

    set template_content "# Kth Largest Element in a Stream — sorting method
from typing import List

class KthLargest:
    def __init__(self, k: int, nums: List[int]):
        self.k = k
        self.arr = nums

    def add(self, val: int) -> int:
        self.arr.append(val)
        self.arr.sort()
        return self.arr[len(self.arr) - self.k]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthLargestElementinStream.Min-Heap
    set output_file "KthLargest.MINHEAP.SET.py"

    set template_content "# Kth Largest Element in a Stream — min-heap method
from typing import List
import heapq

class KthLargest:
    def __init__(self, k: int, nums: List[int]):
        self.k = k
        self.minHeap = nums
        heapq.heapify(self.minHeap)
        while len(self.minHeap) > k:
            heapq.heappop(self.minHeap)

    def add(self, val: int) -> int:
        heapq.heappush(self.minHeap, val)
        if len(self.minHeap) > self.k:
            heapq.heappop(self.minHeap)
        return self.minHeap[0]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LastStoneWeight.Sorting
    set output_file "LastStoneWeight.SORT1.SET.py"

    set template_content "# Last Stone Weight — sorting method
from typing import List

class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        while len(stones) > 1:
            stones.sort()
            cur = stones.pop() - stones.pop()
            if cur:
                stones.append(cur)
        return stones[0] if stones else 0
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LastStoneWeight.BinarySearch
    set output_file "LastStoneWeight.SORT2.SET.py"

    set template_content "# Last Stone Weight — binary search insert method
from typing import List

class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        stones.sort()
        n = len(stones)

        while n > 1:
            cur = stones.pop() - stones.pop()
            n -= 2
            if cur > 0:
                l, r = 0, n
                while l < r:
                    mid = (l + r) // 2
                    if stones[mid] < cur:
                        l = mid + 1
                    else:
                        r = mid
                pos = l
                n += 1
                stones.append(0)
                for i in range(n - 1, pos, -1):
                    stones[i] = stones[i - 1]
                stones[pos] = cur

        return stones[0] if n > 0 else 0
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LastStoneWeight.Heap
    set output_file "LastStoneWeight.HEAP.SET.py"

    set template_content "# Last Stone Weight — heap method (max-heap via min-heap)
from typing import List
import heapq

class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        # max-heap simulated by negating values
        stones = [-s for s in stones]
        heapq.heapify(stones)

        while len(stones) > 1:
            first = heapq.heappop(stones)
            second = heapq.heappop(stones)
            if first != second:
                heapq.heappush(stones, first - second)

        return -stones[0] if stones else 0
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LastStoneWeight.BucketSort
    set output_file "LastStoneWeight.BUCKET.SET.py"

    set template_content "# Last Stone Weight — bucket sort method
from typing import List

class Solution:
    def lastStoneWeight(self, stones: List[int]) -> int:
        if not stones:
            return 0

        maxStone = max(stones)
        bucket = [0] * (maxStone + 1)
        for stone in stones:
            bucket[stone] += 1

        first = second = maxStone
        while first > 0:
            if bucket[first] % 2 == 0:
                first -= 1
                continue

            j = min(first - 1, second)
            while j > 0 and bucket[j] == 0:
                j -= 1

            if j == 0:
                return first

            second = j
            bucket[first] -= 1
            bucket[second] -= 1
            bucket[first - second] += 1
            first = max(first - second, second)

        return first
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KClosestPointsOrigin.Sorting
    set output_file "KClosest.SORT.SET.py"

    set template_content "# K Closest Points to Origin — sorting method
from typing import List

class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        points.sort(key=lambda p: p[0]**2 + p[1]**2)
        return points[:k]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KClosestPointsOrigin.Min-Heap
    set output_file "KClosest.MINHEAP.SET.py"

    set template_content "# K Closest Points to Origin — min-heap method
from typing import List
import heapq

class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        minHeap = []
        for x, y in points:
            dist = x**2 + y**2
            minHeap.append([dist, x, y])

        heapq.heapify(minHeap)
        res = []
        while k > 0:
            dist, x, y = heapq.heappop(minHeap)
            res.append([x, y])
            k -= 1

        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KClosestPointsOrigin.MaxHeap
    set output_file "KClosest.MAXHEAP.SET.py"

    set template_content "# K Closest Points to Origin — max-heap method
from typing import List
import heapq

class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        maxHeap = []
        for x, y in points:
            dist = -(x ** 2 + y ** 2)
            heapq.heappush(maxHeap, [dist, x, y])
            if len(maxHeap) > k:
                heapq.heappop(maxHeap)

        res = []
        while maxHeap:
            dist, x, y = heapq.heappop(maxHeap)
            res.append([x, y])

        return res
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KClosestPointsOrigin.QuickSelect
    set output_file "KClosest.QUICKSELECT.SET.py"

    set template_content "# K Closest Points to Origin — QuickSelect method
from typing import List

class Solution:
    def kClosest(self, points: List[List[int]], k: int) -> List[List[int]]:
        euclidean = lambda x: x[0] ** 2 + x[1] ** 2

        def partition(l, r):
            pivotIdx = r
            pivotDist = euclidean(points[pivotIdx])
            i = l
            for j in range(l, r):
                if euclidean(points[j]) <= pivotDist:
                    points[i], points[j] = points[j], points[i]
                    i += 1
            points[i], points[r] = points[r], points[i]
            return i

        L, R = 0, len(points) - 1
        pivot = len(points)

        while pivot != k:
            pivot = partition(L, R)
            if pivot < k:
                L = pivot + 1
            else:
                R = pivot - 1

        return points[:k]
"
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.KthLargestElementinArray.Sorting
    set output_file "FindKthLargest.SORT.SET.py"

    set template_content "# Find Kth Largest Element in Array — sorting method
from typing import List

class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        nums.sort()
        return nums[len(nums) - k]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthLargestElementinArray.Min-Heap
    set output_file "FindKthLargest.NLARGEST.SET.py"

    set template_content "# Find Kth Largest Element in Array — heapq.nlargest
from typing import List
import heapq

class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        return heapq.nlargest(k, nums)[-1]
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthLargestElementinArray.QuickSelect
    set output_file "FindKthLargest.QUICKSELECT.SET.py"

    set template_content "# Find Kth Largest Element in Array — QuickSelect
from typing import List

class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        k = len(nums) - k

        def quickSelect(l, r):
            pivot, p = nums[r], l
            for i in range(l, r):
                if nums[i] <= pivot:
                    nums[p], nums[i] = nums[i], nums[p]
                    p += 1
            nums[p], nums[r] = nums[r], nums[p]

            if p > k:
                return quickSelect(l, p - 1)
            elif p < k:
                return quickSelect(p + 1, r)
            else:
                return nums[p]

        return quickSelect(0, len(nums) - 1)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.KthLargestElementinArray.QuickSelect_Optimal
    set output_file "FindKthLargest.QUICKSELECT2.SET.py"

    set template_content "# Find Kth Largest Element in Array — QuickSelect Optimal
from typing import List

class Solution:
    def partition(self, nums: List[int], left: int, right: int) -> int:
        mid = (left + right) >> 1
        nums[mid], nums[left + 1] = nums[left + 1], nums[mid]

        if nums[left] < nums[right]:
            nums[left], nums[right] = nums[right], nums[left]
        if nums[left + 1] < nums[right]:
            nums[left + 1], nums[right] = nums[right], nums[left + 1]
        if nums[left] < nums[left + 1]:
            nums[left], nums[left + 1] = nums[left + 1], nums[left]

        pivot = nums[left + 1]
        i = left + 1
        j = right

        while True:
            while True:
                i += 1
                if not nums[i] > pivot:
                    break
            while True:
                j -= 1
                if not nums[j] < pivot:
                    break
            if i > j:
                break
            nums[i], nums[j] = nums[j], nums[i]

        nums[left + 1], nums[j] = nums[j], nums[left + 1]
        return j

    def quickSelect(self, nums: List[int], k: int) -> int:
        left = 0
        right = len(nums) - 1

        while True:
            if right <= left + 1:
                if right == left + 1 and nums[right] > nums[left]:
                    nums[left], nums[right] = nums[right], nums[left]
                return nums[k]

            j = self.partition(nums, left, right)

            if j >= k:
                right = j - 1
            if j <= k:
                left = j + 1

    def findKthLargest(self, nums: List[int], k: int) -> int:
        return self.quickSelect(nums, k - 1)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end
function algoP.TaskScheduler.BruteForce
    set output_file "LeastInterval.GREEDY.SET.py"

    set template_content "# Task Scheduler — brute force greedy
from typing import List

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        count = [0] * 26
        for task in tasks:
            count[ord(task) - ord('A')] += 1

        arr = []
        for i in range(26):
            if count[i] > 0:
                arr.append([count[i], i])

        time = 0
        processed = []
        while arr:
            maxi = -1
            for i in range(len(arr)):
                if all(processed[j] != arr[i][1] for j in range(max(0, time - n), time)):
                    if maxi == -1 or arr[maxi][0] < arr[i][0]:
                        maxi = i

            time += 1
            cur = -1
            if maxi != -1:
                cur = arr[maxi][1]
                arr[maxi][0] -= 1
                if arr[maxi][0] == 0:
                    arr.pop(maxi)
            processed.append(cur)
        return time
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TaskScheduler.Max-Heap
    set output_file "LeastInterval.HEAP.SET.py"

    set template_content "# Task Scheduler — max heap + cooldown
from typing import List
from collections import Counter, deque
import heapq

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        count = Counter(tasks)
        maxHeap = [-cnt for cnt in count.values()]
        heapq.heapify(maxHeap)

        time = 0
        q = deque()  # pairs of [-cnt, readyTime]

        while maxHeap or q:
            time += 1

            if not maxHeap:
                time = q[0][1]
            else:
                cnt = 1 + heapq.heappop(maxHeap)
                if cnt:
                    q.append([cnt, time + n])

            if q and q[0][1] == time:
                heapq.heappush(maxHeap, q.popleft()[0])

        return time
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TaskScheduler.Greedy
    set output_file "LeastInterval.IDLE.SET.py"

    set template_content "# Task Scheduler — greedy method
from typing import List

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        count = [0] * 26
        for task in tasks:
            count[ord(task) - ord('A')] += 1

        count.sort()
        maxf = count[25]
        idle = (maxf - 1) * n

        for i in range(24, -1, -1):
            idle -= min(maxf - 1, count[i])

        return max(0, idle) + len(tasks)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.TaskScheduler.Math
    set output_file "LeastInterval.FORMULA.SET.py"

    set template_content "# Task Scheduler — formula method
from typing import List

class Solution:
    def leastInterval(self, tasks: List[str], n: int) -> int:
        count = [0] * 26
        for task in tasks:
            count[ord(task) - ord('A')] += 1

        maxf = max(count)
        maxCount = sum(1 for i in count if i == maxf)

        time = (maxf - 1) * (n + 1) + maxCount
        return max(len(tasks), time)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DesignTwitter.Sorting
    set output_file "Twitter.SIMPLE.SET.py"

    set template_content "from collections import defaultdict

class Twitter:
    def __init__(self):
        self.time = 0
        self.followMap = defaultdict(set)
        self.tweetMap = defaultdict(list)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweetMap[userId].append((self.time, tweetId))
        self.time += 1

    def getNewsFeed(self, userId: int) -> list[int]:
        feed = self.tweetMap[userId][:]
        for followeeId in self.followMap[userId]:
            feed.extend(self.tweetMap[followeeId])
        feed.sort(key=lambda x: -x[0])
        return [tweetId for _, tweetId in feed[:10]]

    def follow(self, followerId: int, followeeId: int) -> None:
        if followerId != followeeId:
            self.followMap[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        self.followMap[followerId].discard(followeeId)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DesignTwitter.Heap
    set output_file "Twitter.HEAP.SET.py"

    set template_content "from collections import defaultdict
import heapq

class Twitter:
    def __init__(self):
        self.count = 0
        self.tweetMap = defaultdict(list)
        self.followMap = defaultdict(set)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweetMap[userId].append([self.count, tweetId])
        self.count -= 1

    def getNewsFeed(self, userId: int) -> list[int]:
        res = []
        minHeap = []
        self.followMap[userId].add(userId)

        for followeeId in self.followMap[userId]:
            if followeeId in self.tweetMap:
                index = len(self.tweetMap[followeeId]) - 1
                count, tweetId = self.tweetMap[followeeId][index]
                heapq.heappush(minHeap, [count, tweetId, followeeId, index - 1])

        while minHeap and len(res) < 10:
            count, tweetId, followeeId, index = heapq.heappop(minHeap)
            res.append(tweetId)
            if index >= 0:
                count, tweetId = self.tweetMap[followeeId][index]
                heapq.heappush(minHeap, [count, tweetId, followeeId, index - 1])

        return res

    def follow(self, followerId: int, followeeId: int) -> None:
        self.followMap[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.followMap[followerId]:
            self.followMap[followerId].remove(followeeId)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DesignTwitter.Heap_Optimal
    set output_file "Twitter.HEAP_LIMIT.SET.py"

    set template_content "from collections import defaultdict
import heapq

class Twitter:
    def __init__(self):
        self.count = 0
        self.tweetMap = defaultdict(list)
        self.followMap = defaultdict(set)

    def postTweet(self, userId: int, tweetId: int) -> None:
        self.tweetMap[userId].append([self.count, tweetId])
        if len(self.tweetMap[userId]) > 10:
            self.tweetMap[userId].pop(0)
        self.count -= 1

    def getNewsFeed(self, userId: int) -> list[int]:
        res = []
        minHeap = []
        self.followMap[userId].add(userId)
        for followeeId in self.followMap[userId]:
            if followeeId in self.tweetMap:
                index = len(self.tweetMap[followeeId]) - 1
                count, tweetId = self.tweetMap[followeeId][index]
                heapq.heappush(minHeap, [count, tweetId, followeeId, index - 1])

        while minHeap and len(res) < 10:
            count, tweetId, followeeId, index = heapq.heappop(minHeap)
            res.append(tweetId)
            if index >= 0:
                count, tweetId = self.tweetMap[followeeId][index]
                heapq.heappush(minHeap, [count, tweetId, followeeId, index - 1])
        return res

    def follow(self, followerId: int, followeeId: int) -> None:
        self.followMap[followerId].add(followeeId)

    def unfollow(self, followerId: int, followeeId: int) -> None:
        if followeeId in self.followMap[followerId]:
            self.followMap[followerId].remove(followeeId)
"

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.basic.min_of_three
    set output_file "min_of_three.py"

    set template_content '#!/usr/bin/env python3

"""Find the minimum of three values."""
number1 = int(input("Enter first integer: "))
number2 = int(input("Enter second integer: "))
number3 = int(input("Enter third integer: "))

minimum = number1

if number2 < minimum:
    minimum = number2

if number3 < minimum:
    minimum = number3

print("Minimum value is", minimum)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.basic.compare_integers
    set output_file "compare_integers.py"

    set template_content '#!/usr/bin/env python3

"""Compare integers using if statements and comparison operators."""

print("Enter two integers and I will tell you", 
      "the relationships they satisfy.")

number1 = int(input("Enter first integer: "))
number2 = int(input("Enter second integer: "))

if number1 == number2:
    print(number1, "is equal to", number2)

if number1 != number2:
    print(number1, "is not equal to", number2)

if number1 < number2:
    print(number1, "is less than", number2)

if number1 > number2:
    print(number1, "is greater than", number2)

if number1 <= number2:
    print(number1, "is less than or equal to", number2)

if number1 >= number2:
    print(number1, "is greater than or equal to", number2)
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.variables_examples
    set output_file "variables_examples.py"

    set template_content '#!/usr/bin/env python3

lesson_section = 1
lesson_subsection = 2
print("We are on Section #", lesson_section)
print("And this is unit #", lesson_subsection, ", which covers Variable Assignment")

days_in_a_year = 365
my_age = 21
print("My age is ", my_age, ", and I'\''ve been alive for ", days_in_a_year * my_age, " days, give or take.")

days_in_a_year = days_in_a_year + .25  # Equivalent to days_in_a_year = 365 + .25
print("My age is ", my_age, ", and I'\''ve been alive for ", days_in_a_year * my_age, " days, give or take, now that I'\''m including leap years.")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.strings1
    set output_file "strings_1.py"

    set template_content '#!/usr/bin/env python3

def is_alphaspace(string):
    return all([any([char.isspace(), char.isalpha()]) for char in string])

# This custom function will behave similarly to the str.isalpha() and str.isspace() combined together.

test_string = "This string will return false for each of isalpha and isspace but it will return true for the custom function"

print ("test_string.isalpha() gives us: ", test_string.isalpha())
print ("test_string.isspace() gives us: ", test_string.isspace())

# Note how the syntax differs.  That''s because is_alphaspace() isn''t a string method, it''s a custom function.
print ("But is_alphaspace(test_string) gives us: ", is_alphaspace(test_string))
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.strings2
    set output_file "strings_2.py"

    set template_content 'github_handle = ''@shannonturner''
print ("My github handle is ", github_handle)
print ("My first name is ", github_handle[1:8])
print ("My last name is ", github_handle[8:14])
print ("My last name is ", github_handle[8:])
print ("My twitter handle is NOT ", github_handle[:8])
print ("My last name is ", github_handle[-6:])
print ("My first name is ", github_handle[1:-6])


text = "My GitHub handle is @shannonturner and my Twitter handle is @svt827"
snail_index = text.find(''@'')
print (text[snail_index:snail_index + 14])  
space_after_first_snail_index = text[snail_index:].find('' '') 
print (text[snail_index:snail_index + space_after_first_snail_index])

print ("snail_index is: ", snail_index)
print ("space_after_first_snail_index is: ", space_after_first_snail_index)
print ("So this is essentially saying text[20:34], see? --> ", text[20:34])

print (text[text.find(''@''):text.find(''@'')+text[text.find(''@''):].find('' '')])
print ("Can you use slicing and string methods like str.find() to extract the Twitter handle from text?")'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.strings3
    set output_file "strings_3.py"

    set template_content 'gettysburg_address = """
Four score and seven years ago our fathers brought forth on this continent a new nation, conceived in liberty, and dedicated to the proposition that all men are created equal.
Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. 
We are met on a great battlefield of that war. 
We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. 
It is altogether fitting and proper that we should do this.
But, in a larger sense, we can not dedicate, we can not consecrate, we can not hallow this ground. 
The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. 
The world will little note, nor long remember what we say here, but it can never forget what they did here. 
It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. 
It is rather for us to be here dedicated to the great task remaining before us -- that from these honored dead we take increased devotion to that cause 
for which they gave the last full measure of devotion -- that we here highly resolve that these dead shall not have died in vain -- that this nation, under God, 
shall have a new birth of freedom -- and that government of the people, by the people, for the people, shall not perish from the earth.
"""
print (gettysburg_address.count("people")) 
print (gettysburg_address.count("here, ")) 
print (gettysburg_address.count("e")) 
print (gettysburg_address.count("!!!!!!"))'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.strings4
    set output_file "strings_4.py"
    set template_content 'email_address = "hoorayforpython@notarealwebsite.com"
print ("I found the snail at: {0}".format(email_address.find("@"))) 
string.find() + slicing = "awesome!"

at_symbol_index = email_address.find("@")
print ("I found the snail at: {0}".format(at_symbol_index))
email_handle = email_address[0:at_symbol_index]
print ("The email_handle is: {0}".format(email_handle))
email_domain = email_address[at_symbol_index + 1:]
print ("The email_domain is: {0}".format(email_domain))
print ("When string.find() can''t find a string, it''ll give a -1.  So since there''s no ''QQQ'' in email_address, this will return a -1: {0}".format(email_address.find("QQQ")))'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.basic.strings5
    set output_file "strings_5.py"
    set template_content 'name = "Shannon"
print ("My name is {0}".format(name))
name = "Pumpkin"
print ("My name is {0}".format(name))
age = 100
location = "The Pumpkin Patch"
print ("My name is {0} and my age is {1} and I live in {2}".format(name, age, location))
print ("My name is {name} and my age is {age} and I live in {location}".format(name=name, age=age, location=location))'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end



function algoP.basic.strings6
    set output_file "strings_6.py"
    set template_content 'name = "SHANNON!!"
print (name.lower())
print (name)
name = name.lower()
print (name)

greeting = "hello, hi"

print (greeting.upper())
greeting = greeting.upper()
print (greeting)
gender = "F"

if gender.lower() == "f":
    print ("Hi lady!")
if gender == "F" or gender == "f":
    print ("Hi lady!")'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.basic.strings7
    set output_file "strings_7.py"
    set template_content 'song = "eat, eat, eat, apples and bananas"
print ("I like to ... {0}".format(song))
print ("I like to ... {0}".format(song.replace("a","o")))
print ("But note that the original song itself is unchanged: {0}".format(song))
print ("string.replace() is case-sensitive.")
print (song.replace("Eat", "chop")) 

print (song)
print (song.replace("eat", "chop"))
print (song)
song = song.replace("eat", "chop")
song = song.replace("apples", "mangos")
song = song.replace(" and", ", pears, and")
song = song.replace("bananas", "kiwis")
print (song)
song = "eat, eat, eat, apples and bananas"
song = song.replace("eat", "chop").replace("apples", "mangos").replace(" and", ", pears, and").replace("bananas", "kiwis")
print (song)

name = input("Please enter your name: ")
drink = input("Please enter your drink: ")
flavor = input("Please enter your flavor: ")
topping = input("Please enter your topping: ")
print("Here is your order, ", name)
print("Main product: ", drink)
print("Flavor: ", flavor)
print("Topping: ", topping)
print("Thanks for your order!")

message = "One of Pythons strengths is its diverse community."
print(message)

print("Hello world!")
print("What is your name?")
myName = input()
print("It is good to meet you, " + myName)
print("The length of your name is:")
print(len(myName))
print("What is your age?")
myAge = input()
print("You will be " + str(int(myAge) + 1) + " in a year.")

favorite_language = "python"
favorite_language = favorite_language.rstrip()
print(favorite_language)'
    
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.Basic.for
    set output_file "coffee_shop.py"
    set template_content '#!/usr/bin/env python3

drinks = ["chocolate", "coffee", "decaf"]
flavors = ["caramel", "vanilla", "peppermint", "raspberry", "plain"]
toppings = ["chocolate", "cinnamon", "caramel"]

print("Erik'\''s Coffee Shop drinks")
print("-------------------------")
i = 1
for d in drinks:
    print(i, d)
    i = i + 1
drink = input("Choose your drink: ")

print("Erik'\''s Coffee Shop flavors")
print("--------------------------")
i = 1
for f in flavors:
    print(i, f)
    i = i + 1
flavor = input("Choose your flavor: ")

print("Erik'\''s Coffee Shop toppings")
print("---------------------------")
i = 1
for t in toppings:
    print(i, t)
    i = i + 1
topping = input("Choose your topping: ")

print("Here is your order: ")
print("Main product: ", drinks[int(drink) - 1])
print("Flavor: ", flavors[int(flavor) - 1])
print("Topping: ", toppings[int(topping) - 1])
print("Thanks for your order!")'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Function.coffee_menu_basic
    set output_file "coffee_menu_basic.py"
    set template_content '#!/usr/bin/env python3

def menu(choices, title="Erik'\''s Menu", prompt="Choose your item: "):
    print(title)
    print(len(title) * "-")
    i = 1
    for c in choices:
        print(i, c)
        i = i + 1
    choice = input(prompt)
    answer = choices[int(choice) - 1]

    return answer


drinks = ["chocolate", "coffee", "decaf"]
flavors = ["caramel", "vanilla", "peppermint", "raspberry", "plain"]
toppings = ["chocolate", "cinnamon", "caramel"]

drink = menu(drinks, "Erik'\''s drinks", "Choose your drink: ")
flavor = menu(flavors, "Erik'\''s flavors", "Choose your flavor: ")
topping = menu(toppings, "Erik'\''s toppings", "Choose your topping: ")

print("Here is your order: ")
print("Main product: ", drink)
print("Flavor: ", flavor)
print("Topping: ", topping)
print("Thanks for your order!")'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.Function.coffee_menu_validated
    set output_file "coffee_menu_validated.py"
    set template_content '#!/usr/bin/env python3

def menu(choices, title="Erik'\''s Menu", prompt="Choose your item: "):
    print(title)
    print(len(title) * "-")
    i = 1
    for c in choices:
        print(i, c)
        i = i + 1
    while True:
        choice = input(prompt)
        allowed_answers = [str(a) for a in range(1, len(choices) + 1)]
        allowed_answers.extend(["X", "x"])

        if choice in allowed_answers:
            if choice == "X" or choice == "x":
                answer = ""
                break
            else:
                answer = choices[int(choice) - 1]
                break
        else:
            print("Enter number from 1 to ", len(choices))
            answer = ""

    return answer


drinks = ["chocolate", "coffee", "decaf"]
flavors = ["caramel", "vanilla", "peppermint", "raspberry", "plain"]
toppings = ["chocolate", "cinnamon", "caramel"]

drink = menu(drinks)
flavor = menu(flavors, "Erik'\''s flavors", "Choose your flavor: ")
topping = menu(toppings, "Erik'\''s toppings", "Choose your topping: ")

print("Here is your order: ")
print("Main product: ", drink)
print("Flavor: ", flavor)
print("Topping: ", topping)
print("Thanks for your order!")'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.Function.read_menu_preview
    set output_file "read_menu_preview.py"
    set template_content '#!/usr/bin/env python3

def read_menu(filename):
    with open(filename) as f:
        temp = f.readlines()
    result = [item.strip() for item in temp]
    return result


drinks = read_menu("drinks.txt")
print(drinks)
flavors = read_menu("flavors.txt")
print(flavors)
toppings = read_menu("toppings.txt")
print(toppings)'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.Function.menu_only
    set output_file "menu_only.py"
    set template_content '#!/usr/bin/env python3

def menu(choices, title="Erik'\''s Menu", prompt="Choose your item: "):
    print(title)
    print(len(title) * "-")
    i = 1
    for c in choices:
        print(i, c)
        i = i + 1
    while True:
        choice = input(prompt)
        allowed_answers = [str(a) for a in range(1, len(choices) + 1)] + ["X", "x"]

        if choice in allowed_answers:
            if choice.lower() == "x":
                answer = ""
                break
            else:
                answer = choices[int(choice) - 1]
                break
        else:
            print("Enter number from 1 to", len(choices))
            answer = ""

    return answer'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Function.coffee_final
    set output_file "coffee_final.py"
    set content '#!/usr/bin/env python3

def menu(choices, title="Erik'\''s Menu", prompt="Choose your item: "):
    print(title)
    print(len(title) * "-")
    i = 1
    for c in choices:
        print(i, c)
        i = i + 1
    while True:
        choice = input(prompt)
        allowed_answers = [str(a) for a in range(1, len(choices) + 1)] + ["X", "x"]

        if choice in allowed_answers:
            if choice.lower() == "x":
                answer = ""
                break
            else:
                answer = choices[int(choice) - 1]
                break
        else:
            print("Enter number from 1 to", len(choices))
            answer = ""

    return answer


def read_menu(filename):
    with open(filename) as f:
        return [line.strip() for line in f]


drinks = read_menu("drinks.txt")
flavors = read_menu("flavors.txt")
toppings = read_menu("toppings.txt")

drink = menu(drinks)
flavor = menu(flavors, "Erik'\''s flavors", "Choose your flavor: ")
topping = menu(toppings, "Erik'\''s toppings", "Choose your topping: ")

print("Here is your order: ")
print("Main product:", drink)
print("Flavor:", flavor)
print("Topping:", topping)
print("Thanks for your order!")'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end

function algoP.Function.main_menu_basic
    set output_file "main_menu_basic.py"
    set template_content '#!/usr/bin/env python3

def main_menu():
    while True:
        order = get_order()
        print("Check your order:")
        print_order(order)
        confirm = input("Confirm? Press Y to confirm, N to cancel: ")
        if confirm.lower() == "y":
            save_order(order)
            print("Thanks for your order:")
            print_order(order)
            break
        else:
            print("Order cancelled. Let''s try again.\n")
            continue


def get_order():
    # Returns an empty order dict as placeholder
    return {}


def print_order(order):
    print(order)
    return


def save_order(order):
    print("Saving order...")
    return


if __name__ == "__main__":
    main_menu()'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function python.Function.main_menu_full
    set output_file "main_menu_full.py"
    set template_content '#!/usr/bin/env python3

def main_menu():
    while True:
        order = get_order()
        print("Check your order:")
        print_order(order)
        confirm = input("Confirm? Press Y to confirm, N to cancel: ")
        if confirm.lower() == "y":
            save_order(order)
            print("Thanks for your order:")
            print_order(order)
            break
        else:
            print("Order cancelled. Let''s try again.\n")
            continue


def menu(choices, title="Erik'\''s Menu", prompt="Choose your item: "):
    print(title)
    print(len(title) * "-")
    for i, c in enumerate(choices, 1):
        print(i, c)
    while True:
        choice = input(prompt)
        allowed_answers = [str(a) for a in range(1, len(choices)+1)] + ["X", "x"]
        if choice in allowed_answers:
            if choice.lower() == "x":
                return ""
            return choices[int(choice)-1]
        else:
            print("Enter number from 1 to ", len(choices))


def read_menu(filename):
    with open(filename) as f:
        return [line.strip() for line in f.readlines()]


def get_order():
    order = {}
    order["name"] = input("What'\''s your name: ")
    drinks = read_menu("drinks.txt")
    flavors = read_menu("flavors.txt")
    toppings = read_menu("toppings.txt")
    order["drink"] = menu(drinks, "Erik'\''s drinks", "Choose your drink: ")
    order["flavor"] = menu(flavors, "Erik'\''s flavors", "Choose your flavor: ")
    order["topping"] = menu(toppings, "Erik'\''s toppings", "Choose your topping: ")
    return order


def print_order(order):
    print("Here is your order, ", order["name"])
    print("Main product: ", order["drink"])
    print("Flavor: ", order["flavor"])
    print("Topping: ", order["topping"])
    print("Thanks for your order!")
    return


def save_order(order):
    print("Saving order...")
    return


if __name__ == "__main__":
    main_menu()'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Function.save_orders_json
    set output_file "save_orders_json.py"
    set template_content '#!/usr/bin/env python3
import json

order = {"name": "Erik", "drink": "coffee", "flavor": "caramel", "topping": "chocolate"}

order1 = {
    "name": "Alex",
    "drink": "chocolate",
    "flavor": "vanilla",
    "topping": "caramel",
}

orders = []

orders.append(order)
orders.append(order1)

f = open("orders.json", "w")
json.dump(orders, f, indent=4)
f.close()

saved_orders = []
f = open("orders.json", "r")
saved_orders = json.load(f)
print(saved_orders)'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end




function algoPython.FunctionArgs
    set output_file "FunctionArgs.py"

    set template_content "def greet(name, msg):
    \"\"\"This function greets to the person with the provided message\"\"\"
    print(\"Hello\", name + ', ' + msg)

greet(\"Arthur\", \"Good morning!\")

------------

def add(a, b):
    print(a - b)

add(90, 30)
add(60, 30)

--------------

# This will cause an error due to too many arguments
# add(109, 633, 9)

-------

def evenodd(x):
    if (x % 2 == 0):
        print(\"even\")
    else:
        print(\"odd\")

evenodd(6)
evenodd(9)

------

def cube(x):
    \"\"\"This x a passed num value into this function, return cube of x\"\"\"
    y = x*x*x
    return y

z = cube(2)
print(z)

------

def greet(name, msg=\"Good morning!\"):
    print(\"Hello\", name + ', ' + msg)

greet(\"Alan\")
greet(\"Bruce\", \"How do you do?\")
greet(\"Carson\",\"Good night!\")

----

def message(name=\"Everyone\"):
    print(\"Hello\", name)

message(\"David\")
message()

-------

def emp_data(name, emp_id, age, company=\"Baidu.com\"):
    print(\"Details of: \", name)
    print(\"Empoyee Id : \", emp_id)
    print(\"Age : \", age)
    print(\"Company : \", company)

emp_data(\"Bill\",101,21,\"Samsung.com\")
print(\"-----------------------\")
emp_data(\"Cory\",102,22)

-------

# Using keyword arguments
greet(\"Eric\", \"How do you do?\")
greet(name = \"Eric\", msg = \"How do you do?\")
greet(msg = \"How do you do?\", name = \"Eric\")
greet(\"Eric\", msg = \"How do you do?\")

------

def print_fullname(firstname, lastname):
    space = ' '
    full_name = firstname + space + lastname
    return full_name

print(print_fullname(firstname = 'Milaan', lastname = 'Parmar'))

------

def add_two_numbers(num1, num2):
    total = num1 + num2
    return total

print(add_two_numbers(num2 = 3, num1 = 2))

-----

def calculate_age(current_year, birth_year):
    age = current_year - birth_year
    return age

print('Age: ', calculate_age(2019, 1819))

------

def remainder(dividend, divisor):
    return dividend % divisor

rem = remainder(divisor = 3, dividend = 10)
print(\"remainder of 10/3 :\", rem)

------

def message(name, surname):
    print(\"Hello\", name, surname)

message(name=\"Frank\", surname=\"Harper\")
message(surname=\"Clayton\", name=\"Gretta\")

------

def message(first_nm, last_nm):
    print(\"Hello..!\", first_nm, last_nm)

message(\"Frank\", \"Harper\")
message(\"Frank\", last_nm=\"Harper\")
# message(first_nm=\"Frank\", \"Harper\")  # SyntaxError

------

def greet(*names):
    \"\"\"This function greets all the person in the names tuple.\"\"\"
    for name in names:
        print(\"Hello\", name)

greet(\"Gary\", \"Hank\", \"Ivan\", \"John\")

-----------

def addition(*numbers):
    total = 0
    for no in numbers:
        total = total + no
    print(\"Sum is:\", total)

addition()
addition(10, 5, 3, 6, 9)
addition(96, 77, 3.6)

-------

def sum_all_nums(*nums):
    total = 0
    for num in nums:
        total += num
    return total

print(sum_all_nums(2, 3, 5))

-------

def printinfo(arg1, *vartuple):
    \"\"\"This prints a variable passed arguments\"\"\"
    print(\"Output is:\")
    print(arg1)
    for var in vartuple:
        print(var)
    return

printinfo(10)
printinfo(70, 40, 20)
printinfo(30, 60, 90, 120)

--------------

def generate_groups(team, *args):
    print(team)
    for i in args:
        print(i)

print(generate_groups('Team-1','Milaan','Arthur','Clark','Ethan'))

-------

# Passing functions as arguments
def square_number(n):
    return n * n

def do_something(f, x):
    return f(x)

print(do_something(square_number, 3))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoPython.RecursionLambda
    set output_file "RecursionLambda.py"

    set template_content "from functools import reduce

# ----------------
# Recursive factorial
def factorial(n):
    \"\"\"This is a recursive function to find the factorial of an integer\"\"\"
    if n == 1:
        return 1
    else:
        return n * factorial(n-1)

num = 3
print(\"The factorial of\", num, \"is\", factorial(num))

# ----------------
# Even numbers without lambda
def even_numbers(nums):
    even_list = []
    for n in nums:
        if n % 2 == 0:
            even_list.append(n)
    return even_list

num_list = [10, 9, 16, 78, 2, 3, 7, 1]
ans = even_numbers(num_list)
print(\"Even numbers are:\", ans)

# ----------------
# Even numbers with lambda
l = [10, 9, 16, 78, 2, 3, 7, 1]
even_nos = list(filter(lambda x: x % 2 == 0, l))
print(\"Even numbers are: \", even_nos)

# ----------------
# Lambda to double values
double = lambda x: x * 2
print(double(6))

# ----------------
# Normal function and lambda function for square
def square(x):
    return x*x

sqr = lambda x: x*x

print(\"Square of number is\", square(10))
print(\"Square of number is\", sqr(2))

# ----------------
# Filter even numbers from a list using lambda
my_list = [1, 5, 4, 6, 8, 11, 3, 12]
new_list = list(filter(lambda x: (x%2 == 0), my_list))
print(\"Even numbers are: \", new_list)

# ----------------
# Filter positive numbers
l = [-10, 5, 12, -78, 6, -1, -7, 9]
positive_nos = list(filter(lambda x: x > 0, l))
print(\"Positive numbers are: \", positive_nos)

# ----------------
# Map to double values
my_list = [1, 5, 4, 6, 8, 11, 3, 12]
new_list = list(map(lambda x: x * 2, my_list))
print(\"Double values are: \", new_list)

# ----------------
# Map to cube values
list1 = [2, 3, 4, 8, 9]
list2 = list(map(lambda x: x*x*x, list1))
print(\"Cube values are:\", list2)

# ----------------
# Reduce to sum list
list1 = [20, 13, 4, 8, 9]
add = reduce(lambda x, y: x+y, list1)
print(\"Addition of all list elements is : \", add)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoPython.FunctionExamples
    set output_file "FunctionExamples.py"

    set template_content "# ----------------
# Function to wish someone
def wish(name):
    print(\"Happy birthday, \" + name + \". Hope you have a wonderful day!\")

wish('Bill')

# ----------------
# Simple calculator function
def calculator(a, b):
    add = a + b   
    return add    # return the addition

result = calculator(30, 6)   # call function & take return value in variable
print(\"Addition :\", result)

# ----------------
# Function to show course info
def course(name, course_name):
    print(\"Hello\", name, \"Welcome to Data Science\")
    print(\"Your course name is\", course_name)

course('Arthur', 'Python')

# ----------------
# Function to swap two numbers
def swap(x, y):
    \"\"\"
    This function swaps the value of two variables
    \"\"\"
    temp = x
    x = y
    y = temp
    print(\"value of x is:\", x)
    print(\"value of y is:\", y)
    return

x = 6
y = 9
swap(x, y)

# ----------------
# Function to check even or odd
def even_odd(n):    
    if n % 2 == 0:
        print(n, 'is a Even number')
    else:
        print(n, 'is a Odd Number')

even_odd(9)

# ----------------
# Sum function and message function
def sum(a,b):
    print(\"Adding the two values\")
    print(\"Printing within Function\")
    print(a+b)
    return a+b

def msg():
    print(\"Hello\")
    return

total = sum(10,20)
print('total : ', total)
msg()
print(\"Rest of code\")

# ----------------
# Function to get even numbers from a list
def is_even(list1):
    even_num = []
    for n in list1:
        if n % 2 == 0:
            even_num.append(n)
    return even_num

even_num = is_even([2, 3, 46, 63, 72, 83, 90, 19])
print(\"Even numbers are:\", even_num)

# ----------------
# Arithmetic operations returning multiple values
def arithmetic(num1, num2):
    add = num1 + num2
    sub = num1 - num2
    multiply = num1 * num2
    division = num1 / num2
    return add, sub, multiply, division

a, b, c, d = arithmetic(10, 2)

print(\"Addition: \", a)
print(\"Subtraction: \", b)
print(\"Multiplication: \", c)
print(\"Division: \", d)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.OOP_SuperExample
    set output_file "OOP_SuperExample.py"

    set template_content "# ----------------
# Example 1: super() with Single Inheritance

class Mammal(object):
    def __init__(self, mammalName):
        print(mammalName, 'is a warm-blooded animal.')

class Dog(Mammal):
    def __init__(self):
        print('Dog has four legs.')
        super().__init__('Dog')

d1 = Dog()

# ----------------
# Example 2: Multiple Inheritance with super()

class Animal:
    def __init__(self, Animal):
        print(Animal, 'is an animal.')

class Mammal(Animal):
    def __init__(self, mammalName):
        print(mammalName, 'is a warm-blooded animal.')
        super().__init__(mammalName)

class NonWingedMammal(Mammal):
    def __init__(self, NonWingedMammal):
        print(NonWingedMammal, \"can't fly.\")
        super().__init__(NonWingedMammal)

class NonMarineMammal(Mammal):
    def __init__(self, NonMarineMammal):
        print(NonMarineMammal, \"can't swim.\")
        super().__init__(NonMarineMammal)

class Dog(NonMarineMammal, NonWingedMammal):
    def __init__(self):
        print('Dog has 4 legs.')
        super().__init__('Dog')

d = Dog()
print('')
bat = NonMarineMammal('Bat')
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Basic.ZipExamples
    set output_file "ZipExamples.py"

    set template_content "# ----------------
# Example 1: Python zip()

number_list = [1, 2, 3]
str_list = ['one', 'two', 'three']

# No iterables are passed
result = zip()

# Converting iterator to list
result_list = list(result)
print(result_list)

# Two iterables are passed
result = zip(number_list, str_list)

# Converting iterator to set
result_set = set(result)
print(result_set)

# ----------------
# Example 2: Different number of iterable elements

numbersList = [1, 2, 3]
str_list = ['one', 'two']
numbers_tuple = ('ONE', 'TWO', 'THREE', 'FOUR')

# Notice, the size of numbersList and numbers_tuple is different
result = zip(numbersList, numbers_tuple)

# Converting to set
result_set = set(result)
print(result_set)

result = zip(numbersList, str_list, numbers_tuple)

# Converting to set
result_set = set(result)
print(result_set)

# ----------------
# Example 3: Unzipping the Value Using zip()

coordinate = ['x', 'y', 'z']
value = [3, 4, 5]

result = zip(coordinate, value)
result_list = list(result)
print(result_list)

c, v = zip(*result_list)
print('c =', c)
print('v =', v)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoPython.AdvancedExamples
    set output_file "AdvancedExamples.py"

    set template_content "# ----------------
# Example 1: Class with default __init__ parameters

class Foo:
    def __init__(self, a = 5, b = 10):
        self.a = a
        self.b = b
  
object = Foo()
print(vars(object))

# ----------------
# Example 2: Type checking

numbers_list = [1, 2]
print(type(numbers_list))

numbers_dict = {1: 'one', 2: 'two'}
print(type(numbers_dict))

class Foo:
    a = 0

foo = Foo()
print(type(foo))

# ----------------
# Example 3: Creating classes dynamically using type()

o1 = type('X', (object,), dict(a='Foo', b=12))

print(type(o1))
print(vars(o1))

class test:
    a = 'Foo'
    b = 12
  
o2 = type('Y', (test,), dict(a='Foo', b=12))
print(type(o2))
print(vars(o2))

# ----------------
# Example 4: Tuples

t1 = tuple()
print('t1 =', t1)

# creating a tuple from a list
t2 = tuple([1, 4, 6])
print('t2 =', t2)

# creating a tuple from a string
t1 = tuple('Python')
print('t1 =',t1)

# creating a tuple from a dictionary
t1 = tuple({1: 'one', 2: 'two'})
print('t1 =',t1)

# ----------------
# Example 5: sum() function with optional start parameter

numbers = [2.5, 3, 4, -5]

# start parameter is not provided
numbers_sum = sum(numbers)
print(numbers_sum)

# start = 10
numbers_sum = sum(numbers, 10)
print(numbers_sum)

# ----------------
# Example 6: str() and bytes conversion

result = str(10)
print(result)

# bytes
b = bytes('pythön', encoding='utf-8')
print(str(b, encoding='ascii', errors='ignore'))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.SortExamples
    set output_file "SortExamples.py"

    set template_content "# ----------------
# Example 1: Sorting lists, strings, tuples

# vowels list
py_list = ['e', 'a', 'u', 'o', 'i']
print(sorted(py_list))

# string
py_string = 'Python'
print(sorted(py_string))

# vowels tuple
py_tuple = ('e', 'a', 'u', 'o', 'i')
print(sorted(py_tuple))

# ----------------
# Example 2: Sorting sets, dicts, frozensets

# set
py_set = {'e', 'a', 'u', 'o', 'i'}
print(sorted(py_set, reverse=True))

# dictionary
py_dict = {'e': 1, 'a': 2, 'u': 3, 'o': 4, 'i': 5}
print(sorted(py_dict, reverse=True))

# frozen set
frozen_set = frozenset(('e', 'a', 'u', 'o', 'i'))
print(sorted(frozen_set, reverse=True))

# ----------------
# Example 3: Sorting by second element using a function

def take_second(elem):
    return elem[1]

# random list
random = [(2, 2), (3, 4), (4, 1), (1, 3)]

# sort list with key
sorted_list = sorted(random, key=take_second)

# print list
print('Sorted list:', sorted_list)

# ----------------
# Example 4: Sorting list of tuples (Student Name, Marks, Age)

participant_list = [
    ('Alison', 50, 18),
    ('Terence', 75, 12),
    ('David', 75, 20),
    ('Jimmy', 90, 22),
    ('John', 45, 12)
]

def sorter(item):
    error = 100 - item[1]  # highest marks first
    age = item[2]
    return (error, age)

sorted_list = sorted(participant_list, key=sorter)
print(sorted_list)

# ----------------
# Example 5: Sorting using lambda

participant_list = [
    ('Alison', 50, 18),
    ('Terence', 75, 12),
    ('David', 75, 20),
    ('Jimmy', 90, 22),
    ('John', 45, 12)
]

sorted_list = sorted(participant_list, key=lambda item: (100-item[1], item[2]))
print(sorted_list)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.SliceExamples
    set output_file "SliceExamples.py"

    set template_content "# ----------------
# Example 1: Creating slice objects

# contains indices (0, 1, 2)
result1 = slice(3)
print(result1)

# contains indices (1, 3)
result2 = slice(1, 5, 2)
print(slice(1, 5, 2))

# ----------------
# Example 2: Using slice objects with strings

py_string = 'Python'

# stop = 3, contains 0, 1, 2 indices
slice_object = slice(3)
print(py_string[slice_object])  # Pyt

# start = 1, stop = 6, step = 2, contains 1, 3, 5 indices
slice_object = slice(1, 6, 2)
print(py_string[slice_object])  # yhn

# start = -1, stop = -4, step = -1, contains indices -1, -2, -3
slice_object = slice(-1, -4, -1)
print(py_string[slice_object])  # noh

# ----------------
# Example 3: Using slice objects with lists and tuples

py_list = ['P', 'y', 't', 'h', 'o', 'n']
py_tuple = ('P', 'y', 't', 'h', 'o', 'n')

# slice(3) -> indices 0,1,2
slice_object = slice(3)
print(py_list[slice_object])  # ['P', 'y', 't']

# slice(1,5,2) -> indices 1 and 3
slice_object = slice(1, 5, 2)
print(py_tuple[slice_object]) # ('y', 'h')

# slice(-1,-4,-1) -> indices -1,-2,-3
slice_object = slice(-1, -4, -1)
print(py_list[slice_object])  # ['n', 'o', 'h']

# slice(-1,-5,-2) -> indices -1,-3
slice_object = slice(-1, -5, -2)
print(py_tuple[slice_object]) # ('n', 'h')

# ----------------
# Example 4: Using slicing notation directly

py_string = 'Python'

# indices 0,1,2
print(py_string[0:3])  # Pyt

# indices 1 and 3
print(py_string[1:5:2]) # yh
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.SetAttrExamples
    set output_file "SetAttrExamples.py"

    set template_content "# ----------------
# Example 1: Modify existing attribute using setattr

class Person:
    name = 'Adam'
    
p = Person()
print('Before modification:', p.name)

# setting name to 'John'
setattr(p, 'name', 'John')

print('After modification:', p.name)

# ----------------
# Example 2: Add new attribute using setattr

class Person:
    name = 'Adam'
    
p = Person()

# setting attribute name to John
setattr(p, 'name', 'John')
print('Name is:', p.name)

# setting an attribute not present in Person
setattr(p, 'age', 23)
print('Age is:', p.age)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.Round_Tuple
    set output_file "RoundReversedRange.py"

    set template_content "# ----------------
# ROUND examples
from decimal import Decimal

# normal float
num = 2.675
print(round(num, 2))

# using decimal.Decimal (passed float as string for precision)
num = Decimal('2.675')
print(round(num, 2))

# round examples with integers and floats
print(round(10))
print(round(10.7))
print(round(5.5))

# ----------------
# REVERSED examples
seq_string = 'Python'
print(list(reversed(seq_string)))

seq_tuple = ('P', 'y', 't', 'h', 'o', 'n')
print(list(reversed(seq_tuple)))

seq_range = range(5, 9)
print(list(reversed(seq_range)))

seq_list = [1, 2, 4, 3, 5]
print(list(reversed(seq_list)))

# class with __reversed__
class Vowels:
    vowels = ['a', 'e', 'i', 'o', 'u']

    def __reversed__(self):
        return reversed(self.vowels)

v = Vowels()
print(list(reversed(v)))

# __repr__ example
class Person:
    name = 'Adam'

    def __repr__(self):
        return repr('Hello ' + self.name)

print(repr(Person()))

# ----------------
# RANGE examples
print(list(range(0)))
print(list(range(5)))
print(list(range(10)))
print(list(range(1, 10)))
print(list(range(2, 14, 2)))
print(list(range(2, -14, -2)))
print(list(range(2, 14, -2))) # value constraint not met

print(\"Python range() example\")
for i in range(5):
    print(i, end=', ')

for i in range(5, 10):
    print(i, end=', ')

for i in range(2, 10, 2):
    print(i, end=', ')

for i in range(1, 10, 2):
    print(\"Current value of i is:\", i)

# inclusive ranges
start, stop, step = 1, 5, 1
stop += step
for i in range(start, stop, step):
    print(i, end=', ')

start, stop, step = 2, 10, 2
stop += step
for i in range(start, stop, step):
    print(i, end=', ')

start, stop, step = -2, -10, -2
for number in range(start, stop, step):
    print(number, end=', ')

for num in range(-2, 5, 1):
    print(num, end=\", \")

for num in range(2, -5, -1):
    print(num, end=\", \")

for i in range(5, -1, -1):
    print(i, end=', ')

# using reversed() on range
for i in reversed(range(0, 5)):
    print(i)

print(\"Checking the type\")
print(type(range(0, 5)))
print(type(reversed(range(0,5))))

# ----------------
# itertools.chain example
from itertools import chain

concatenated_range = chain(range(10), range(50, 75))
for num in concatenated_range:
    print(num, end=\", \")
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.PropertyPrint
    set output_file "PropertyPrint.py"

    set template_content "# ----------------
# PROPERTY example using property() function
class Person:
    def __init__(self, name):
        self._name = name

    def get_name(self):
        print('Getting name')
        return self._name

    def set_name(self, value):
        print('Setting name to ' + value)
        self._name = value

    def del_name(self):
        print('Deleting name')
        del self._name

    # Set property to use get_name, set_name, and del_name
    name = property(get_name, set_name, del_name, 'Name property')

p = Person('Adam')
print(p.name)
p.name = 'John'
del p.name

# ----------------
# PROPERTY example using @property decorator
class Person:
    def __init__(self, name):
        self._name = name

    @property
    def name(self):
        print('Getting name')
        return self._name

    @name.setter
    def name(self, value):
        print('Setting name to ' + value)
        self._name = value

    @name.deleter
    def name(self):
        print('Deleting name')
        del self._name

p = Person('Adam')
print('The name is:', p.name)
p.name = 'John'
del p.name

# ----------------
# PRINT examples
print(\"Python is fun.\")

a = 5
print(\"a =\", a)

b = a
print('a =', a, '= b')

# Using sep and end
a = 5
print(\"a =\", a, sep='00000', end='\\n\\n\\n')
print(\"a =\", a, sep='0', end='')

# Printing to a file
sourceFile = open('python.txt', 'w')
print('Pretty cool, huh!', file=sourceFile)
sourceFile.close()
"

    echo "$content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Basic.PowIterMap
    set output_file "PowIterMap.py"

    set template_content "# ----------------
# pow() examples
print(pow(2, 2))     # 4, positive x, positive y
print(pow(-2, 2))    # 4, negative x, positive y
print(pow(2, -2))    # 0.25, positive x, negative y
print(pow(-2, -2))   # 0.25, negative x, negative y

# ----------------
# File handling examples
f = open('test.txt')  # open file in current directory
# specifying full path
# f = open('C:/Python99/README.txt')

# ----------------
# ord() examples
print(ord('5'))    # 53
print(ord('A'))    # 65


# ----------------
# oct() examples
print('oct(10) is:', oct(10))
print('oct(0b101) is:', oct(0b101))
print('oct(0XA) is:', oct(0XA))

# ----------------
# Custom class with __index__ and __int__
class Person:
    age = 23

    def __index__(self):
        return self.age

    def __int__(self):
        return self.age

person = Person()
print('The oct is:', oct(person))

# ----------------
# Iterator examples
random = [5, 9, 'cat']
random_iterator = iter(random)
print(random_iterator)
print(next(random_iterator))  # 5
print(next(random_iterator))  # 9
print(next(random_iterator))  # 'cat'
# print(next(random_iterator))  # raises StopIteration

# ----------------
# memoryview examples
random_byte_array = bytearray('ABC', 'utf-8')
mv = memoryview(random_byte_array)

# access zeroth index
print(mv[0])
# create byte from memory view
print(bytes(mv[0:2]))
# create list from memory view
print(list(mv[0:3]))

# update memoryview
print('Before updation:', random_byte_array)
mv[1] = 90
print('After updation:', random_byte_array)

# ----------------
# map() examples with normal function
def calculateSquare(n):
    return n*n

numbers = (1, 2, 3, 4)
result = map(calculateSquare, numbers)
print(result)
numbersSquare = set(result)
print(numbersSquare)

# ----------------
# map() examples with lambda
numbers = (1, 2, 3, 4)
result = map(lambda x: x*x, numbers)
print(result)
numbersSquare = set(result)
print(numbersSquare)

# ----------------
# map() with multiple iterables
num1 = [4, 5, 6]
num2 = [5, 6, 7]
result = map(lambda n1, n2: n1+n2, num1, num2)
print(list(result))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function python.max_len_examples
    set output_file "python_max_len_examples.py"

    set template_content "# MAX examples
number = [3, 2, 8, 5, 10, 6]
largest_number = max(number)
print('The largest number is:', largest_number)

print('-' * 40)

languages = ['Python', 'C Programming', 'Java', 'JavaScript']
largest_string = max(languages)
print('The largest string is:', largest_string)

print('-' * 40)

square = {2: 4, -3: 9, -1: 1, -2: 4}

key1 = max(square)
print('The largest key:', key1)

key2 = max(square, key=lambda k: square[k])
print('The key with the largest value:', key2)
print('The largest value:', square[key2])

print('-' * 40)

result = max(4, -5, 23, 5)
print('The maximum number is:', result)

print('-' * 40)

# LEN examples
testList = []
print(testList, 'length is', len(testList))

testList = [1, 2, 3]
print(testList, 'length is', len(testList))

testTuple = (1, 2, 3)
print(testTuple, 'length is', len(testTuple))

testRange = range(1, 10)
print('Length of', testRange, 'is', len(testRange))

print('-' * 40)

testString = ''
print('Length of', testString, 'is', len(testString))

testString = 'Python'
print('Length of', testString, 'is', len(testString))

testByte = b'Python'
print('Length of', testByte, 'is', len(testByte))

testList = [1, 2, 3]
testByte = bytes(testList)
print('Length of', testByte, 'is', len(testByte))

print('-' * 40)

testSet = {1, 2, 3}
print(testSet, 'length is', len(testSet))

testSet = set()
print(testSet, 'length is', len(testSet))

testDict = {1: 'one', 2: 'two'}
print(testDict, 'length is', len(testDict))

testDict = {}
print(testDict, 'length is', len(testDict))

testSet = {1, 2}
frozenTestSet = frozenset(testSet)
print(frozenTestSet, 'length is', len(frozenTestSet))

print('-' * 40)

class Session:
    def __init__(self, number=0):
        self.number = number
    
    def __len__(self):
        return self.number

s1 = Session()
print(len(s1))

s2 = Session(6)
print(len(s2))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function python.max_len_examples
    set output_file "python_max_len_examples.py"

    set template_content "# MAX examples
number = [3, 2, 8, 5, 10, 6]
largest_number = max(number)
print('The largest number is:', largest_number)

print('-' * 40)

languages = ['Python', 'C Programming', 'Java', 'JavaScript']
largest_string = max(languages)
print('The largest string is:', largest_string)

print('-' * 40)

square = {2: 4, -3: 9, -1: 1, -2: 4}

key1 = max(square)
print('The largest key:', key1)

key2 = max(square, key=lambda k: square[k])
print('The key with the largest value:', key2)
print('The largest value:', square[key2])

print('-' * 40)

result = max(4, -5, 23, 5)
print('The maximum number is:', result)

print('-' * 40)

# LEN examples
testList = []
print(testList, 'length is', len(testList))

testList = [1, 2, 3]
print(testList, 'length is', len(testList))

testTuple = (1, 2, 3)
print(testTuple, 'length is', len(testTuple))

testRange = range(1, 10)
print('Length of', testRange, 'is', len(testRange))

print('-' * 40)

testString = ''
print('Length of', testString, 'is', len(testString))

testString = 'Python'
print('Length of', testString, 'is', len(testString))

testByte = b'Python'
print('Length of', testByte, 'is', len(testByte))

testList = [1, 2, 3]
testByte = bytes(testList)
print('Length of', testByte, 'is', len(testByte))

print('-' * 40)

testSet = {1, 2, 3}
print(testSet, 'length is', len(testSet))

testSet = set()
print(testSet, 'length is', len(testSet))

testDict = {1: 'one', 2: 'two'}
print(testDict, 'length is', len(testDict))

testDict = {}
print(testDict, 'length is', len(testDict))

testSet = {1, 2}
frozenTestSet = frozenset(testSet)
print(frozenTestSet, 'length is', len(frozenTestSet))

print('-' * 40)

class Session:
    def __init__(self, number=0):
        self.number = number
    
    def __len__(self):
        return self.number

s1 = Session()
print(len(s1))

s2 = Session(6)
print(len(s2))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.localsIterInt
    set output_file "python_locals_iter_int_examples.py"

    set template_content "# locals()

def localsNotPresent():
    return locals()

def localsPresent():
    present = True
    return locals()

print('localsNotPresent:', localsNotPresent())
print('localsPresent:', localsPresent())

print('-' * 40)

def localsPresent():
    present = True
    print(present)
    locals()['present'] = False
    print(present)

localsPresent()

print('-' * 40)

# list()
print(list())
vowel_string = 'aeiou'
print(list(vowel_string))
vowel_tuple = ('a', 'e', 'i', 'o', 'u')
print(list(vowel_tuple))
vowel_list = ['a', 'e', 'i', 'o', 'u']
print(list(vowel_list))

print('-' * 40)

vowel_set = {'a', 'e', 'i', 'o', 'u'}
print(list(vowel_set))
vowel_dictionary = {'a': 1, 'e': 2, 'i': 3, 'o':4, 'u':5}
print(list(vowel_dictionary))

print('-' * 40)

class PowTwo:
    def __init__(self, max):
        self.max = max
    
    def __iter__(self):
        self.num = 0
        return self
        
    def __next__(self):
        if self.num >= self.max:
            raise StopIteration
        result = 2 ** self.num
        self.num += 1
        return result

pow_two = PowTwo(5)
pow_two_iter = iter(pow_two)
print(list(pow_two_iter))

print('-' * 40)

vowels = ['a', 'e', 'i', 'o', 'u']
vowels_iter = iter(vowels)
print(next(vowels_iter))
print(next(vowels_iter))
print(next(vowels_iter))
print(next(vowels_iter))
print(next(vowels_iter))

print('-' * 40)

class PrintNumber:
    def __init__(self, max):
        self.max = max

    def __iter__(self):
        self.num = 0
        return self

    def __next__(self):
        if self.num >= self.max:
            raise StopIteration
        self.num += 1
        return self.num

print_num = PrintNumber(3)
print_num_iter = iter(print_num)
print(next(print_num_iter))
print(next(print_num_iter))
print(next(print_num_iter))

try:
    print(next(print_num_iter))
except StopIteration:
    print('StopIteration raised')

print('-' * 40)

class DoubleIt:
    def __init__(self):
        self.start = 1

    def __iter__(self):
        return self

    def __next__(self):
        self.start *= 2
        return self.start

    __call__ = __next__

my_iter = iter(DoubleIt(), 16)
for x in my_iter:
    print(x)

print('-' * 40)

class Polygon:
    def __init__(polygonType):
        print('Polygon is a', polygonType)

class Triangle(Polygon):
    def __init__(self):
        Polygon.__init__('triangle')

print(issubclass(Triangle, Polygon))
print(issubclass(Triangle, list))
print(issubclass(Triangle, (list, Polygon)))
print(issubclass(Polygon, (list, Polygon)))

print('-' * 40)

print(int(123))
print(int(123.23))
print(int('123'))

print('-' * 40)

print(int('1010', 2))
print(int('0b1010', 2))
print(int('12', 8))
print(int('0o12', 8))
print(int('A', 16))
print(int('0xA', 16))

print('-' * 40)

class Person:
    age = 23
    def __index__(self):
        return self.age
    def __int__(self):
        return self.age

person = Person()
print('int(person) is:', int(person))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.function4
    set output_file "PythonDemo.py"

    set template_content "# isinstance examples
numbers = [1, 2, 3]

print(numbers,'instance of list?', isinstance(numbers, list))
print(numbers,'instance of dict?', isinstance(numbers, dict))
print(numbers,'instance of dict or list?', isinstance(numbers, (dict, list)))

number = 5
print(number,'instance of list?', isinstance(number, list))
print(number,'instance of int?', isinstance(number, int))

# id() examples
class Foo:
    b = 5

dummyFoo = Foo()
print('id of dummyFoo =', id(dummyFoo))

print('id of 5 =', id(5))
a = 5
print('id of a =', id(a))
b = a
print('id of b =', id(b))
c = 5.0
print('id of c =', id(c))

# input examples
inputString = input()
print('The inputted string is:', inputString)

inputString = input('Enter a string:')
print('The inputted string is:', inputString)

# hash examples
print('Hash for 181 is:', hash(181))
print('Hash for 181.23 is:', hash(181.23))
print('Hash for Python is:', hash('Python'))

# hex examples
number = 435
print(number, 'in hex =', hex(number))
number = 0
print(number, 'in hex =', hex(number))
number = -34
print(number, 'in hex =', hex(number))
print('Return type from hex() is', type(hex(number)))

# float.hex examples
print(2.5, 'in hex =', float.hex(2.5))
print(0.0, 'in hex =', float.hex(0.0))
print(10.5, 'in hex =', float.hex(10.5))

# hasattr examples
class Person:
    age = 23
    name = 'Adam'

person = Person()

print('Person has age?:', hasattr(person, 'age'))
print('Person has salary?:', hasattr(person, 'salary'))

# exec examples
program = 'a = 5\\nb=10\\nprint(\"Sum =\", a+b)'
exec(program)

program = input('Enter a program:')
exec(program)

# getattr examples
class Person:
    age = 23
    name = 'Adam'

person = Person()
print('The age is:', getattr(person, 'age'))
print('The age is:', person.age)

class Person:
    age = 23
    name = 'Adam'

person = Person()

print('The sex is:', getattr(person, 'sex', 'Male'))
print('The sex is:', getattr(person, 'sex'))

# frozenset examples
vowels = ('a', 'e', 'i', 'o', 'u')
fSet = frozenset(vowels)
print('The frozen set is:', fSet)
print('The empty frozen set is:', frozenset())

try:
    fSet.add('v')
except Exception as e:
    print('Error:', e)

person = {'name': 'John', 'age': 23, 'sex': 'male'}
print('The frozen set is:', frozenset(person))

A = frozenset([1, 2, 3, 4])
B = frozenset([3, 4, 5, 6])

C = A.copy()
print(C)

print(A.union(B))
print(A.intersection(B))
print(A.difference(B))
print(A.symmetric_difference(B))

A = frozenset([1, 2, 3, 4])
B = frozenset([3, 4, 5, 6])
C = frozenset([5, 6])

print(A.isdisjoint(C))
print(C.issubset(B))
print(B.issuperset(C))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoPython.BigTemplate
    set output_file "python_template.py"

    set template_content "# Python Template

def calculatePerimeter(l):
    return 4*l

def calculateArea(l):
    return l*l

expression = input(\"Type a function: \")

for l in range(1, 5):
    if (expression == 'calculatePerimeter(l)'):
        print(\"If length is \", l, \", Perimeter = \", eval(expression))
    elif (expression == 'calculateArea(l)'):
        print(\"If length is \", l, \", Area = \", eval(expression))
    else:
        print('Wrong Function')
        break

letters = ['a', 'b', 'd', 'e', 'i', 'j', 'o']

def filterVowels(letter):
    vowels = ['a', 'e', 'i', 'o', 'u']
    if(letter in vowels):
        return True
    else:
        return False

filteredVowels = filter(filterVowels, letters)

print('The filtered vowels are:')
for vowel in filteredVowels:
    print(vowel)

randomList = [1, 'a', 0, False, True, '0']

filteredList = filter(None, randomList)

print('The filtered elements are:')
for element in filteredList:
    print(element)

class Mathematics:
    def addNumbers(x, y):
        return x + y

Mathematics.addNumbers = staticmethod(Mathematics.addNumbers)

print('The sum is:', Mathematics.addNumbers(5, 10))

class Dates:
    def __init__(self, date):
        self.date = date
        
    def getDate(self):
        return self.date

    @staticmethod
    def toDashDate(date):
        return date.replace(\"/\", \"-\")

date = Dates(\"15-12-2016\")
dateFromDB = \"15/12/2016\"
dateWithDash = Dates.toDashDate(dateFromDB)

if(date.getDate() == dateWithDash):
    print(\"Equal\")
else:
    print(\"Unequal\")

class Dates:
    def __init__(self, date):
        self.date = date
        
    def getDate(self):
        return self.date

    @staticmethod
    def toDashDate(date):
        return date.replace(\"/\", \"-\")

class DatesWithSlashes(Dates):
    def getDate(self):
        return Dates.toDashDate(self.date)

date = Dates(\"15-12-2016\")
dateFromDB = DatesWithSlashes(\"15/12/2016\")

if(date.getDate() == dateFromDB.getDate()):
    print(\"Equal\")
else:
    print(\"Unequal\")

grocery = ['bread', 'milk', 'butter']
enumerateGrocery = enumerate(grocery)

print(type(enumerateGrocery))
print(list(enumerateGrocery))

enumerateGrocery = enumerate(grocery, 10)
print(list(enumerateGrocery))

grocery = ['bread', 'milk', 'butter']

for item in enumerate(grocery):
    print(item)

print('\\n')
for count, item in enumerate(grocery):
    print(count, item)

print('\\n')
for count, item in enumerate(grocery, 100):
    print(count, item)

print('divmod(8, 3) = ', divmod(8, 3))
print('divmod(3, 8) = ', divmod(3, 8))
print('divmod(5, 5) = ', divmod(5, 5))

print('divmod(8.0, 3) = ', divmod(8.0, 3))
print('divmod(3, 8.0) = ', divmod(3, 8.0))
print('divmod(7.5, 2.5) = ', divmod(7.5, 2.5))
print('divmod(2.6, 0.5) = ', divmod(2.6, 0.5))

class Person:
    def __dir__(self):
        return ['age', 'name', 'salary']

teacher = Person()
print(dir(teacher))

numbers = dict(x=5, y=0)
print('numbers =', numbers)
print(type(numbers))

empty = dict()
print('empty =', empty)
print(type(empty))

numbers1 = dict([('x', 5), ('y', -5)])
print('numbers1 =',numbers1)

numbers2 = dict([('x', 5), ('y', -5)], z=8)
print('numbers2 =',numbers2)

numbers3 = dict(dict(zip(['x', 'y', 'z'], [1, 2, 3])))
print('numbers3 =',numbers3)

numbers1 = dict({'x': 4, 'y': 5})
print('numbers1 =',numbers1)

numbers2 = {'x': 4, 'y': 5}
print('numbers2 =',numbers2)

numbers3 = dict({'x': 4, 'y': 5}, z=8)
print('numbers3 =',numbers3)

z = complex(2, -3)
print(z)

z = complex(1)
print(z)

z = complex()
print(z)

z = complex('5-9j')
print(z)

a = 2+3j
print('a =',a)
print('Type of a is',type(a))

b = -2j
print('b =',b)
print('Type of b is',type(a))

c = 0j
print('c =',c)
print('Type of c is',type(c))

class Person:
    age = 25

    def printAge(cls):
        print('The age is:', cls.age)

Person.printAge = classmethod(Person.printAge)

Person.printAge()

from datetime import date

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    @classmethod
    def fromBirthYear(cls, name, birthYear):
        return cls(name, date.today().year - birthYear)

    def display(self):
        print(self.name + \"'s age is: \" + str(self.age))

person = Person('Adam', 19)
person.display()

person1 = Person.fromBirthYear('John', 1985)
person1.display()

from datetime import date

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    @staticmethod
    def fromFathersAge(name, fatherAge, fatherPersonAgeDiff):
        return Person(name, date.today().year - fatherAge + fatherPersonAgeDiff)

    @classmethod
    def fromBirthYear(cls, name, birthYear):
        return cls(name, date.today().year - birthYear)

    def display(self):
        print(self.name + \"'s age is: \" + str(self.age))

class Man(Person):
    sex = 'Male'

man = Man.fromBirthYear('John', 1985)
print(isinstance(man, Man))

man1 = Man.fromFathersAge('John', 1965, 20)
print(isinstance(man1, Man))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.MatrixAddition
    set output_file "MatrixAddition.py"

    set template_content "X = [[12,9,3],
    [4,5,6],
    [7,8,3]]

Y = [[9,8,1],
    [6,7,3],
    [4,5,9]]

# Method 1: Using nested loops
result = [[0,0,0],
          [0,0,0],
          [0,0,0]]

for i in range(len(X)):
    for j in range(len(X[0])):
        result[i][j] = X[i][j] + Y[i][j]

print('Method 1 result:')
for r in result:
    print(r)

# Method 2: Using list comprehension
result = [[X[i][j] + Y[i][j] for j in range(len(X[0]))] for i in range(len(X))]

print('Method 2 result:')
for r in result:
    print(r)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.MatrixTranspose
    set output_file "MatrixTranspose.py"

    set template_content "X = [[12,9],
     [7 ,3],
     [5 ,6]]

# Method 1: Using nested loops
result = [[0,0,0],
          [0,0,0]]

for i in range(len(X)):
    for j in range(len(X[0])):
        result[j][i] = X[i][j]

print('Method 1 result:')
for r in result:
    print(r)

# Method 2: Using list comprehension
result = [[X[j][i] for j in range(len(X))] for i in range(len(X[0]))]

print('Method 2 result:')
for r in result:
    print(r)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MatrixMultiplication
    set output_file "MatrixMultiplication.py"

    set template_content "# 3x3 matrix
X = [[12,9,3],
     [4,5,6],
     [7,8,3]]

# 3x4 matrix
Y = [[6,8,1,3],
     [5,7,3,4],
     [0,6,9,1]]

# Method 1: Nested loops
result1 = [[0,0,0,0],
           [0,0,0,0],
           [0,0,0,0]]

for i in range(len(X)):
    for j in range(len(Y[0])):
        for k in range(len(Y)):
            result1[i][j] += X[i][k] * Y[k][j]

print('Result using nested loops:')
for r in result1:
    print(r)

# Method 2: List comprehension with zip
result2 = [[sum(a*b for a,b in zip(X_row,Y_col)) for Y_col in zip(*Y)] for X_row in X]

print('\\nResult using list comprehension:')
for r in result2:
    print(r)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.CheckPalindrome
    set output_file "CheckPalindrome.py"

    set template_content "# Method 1: Case-insensitive palindrome check
my_str = 'aIbohPhoBiA'

# make it suitable for caseless comparison
my_str = my_str.casefold()

# reverse the string
rev_str = reversed(my_str)

# check if the string is equal to its reverse
if list(my_str) == list(rev_str):
    print(\"The string is a palindrome.\")
else:
    print(\"The string is not a palindrome.\")

# Method 2: Using slicing
string = str(input(\"Enter string: \"))
if string == string[::-1]:
    print(\"The string is a palindrome\")
else:
    print(\"The string isn't a palindrome\")"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Basic.RemovePunctuation
    set output_file "RemovePunctuation.py"

    set template_content "punctuations = '''!()-[]{};:'\"\\,<>./?@#\$%^&*_~'''

my_str = \"Hello!!!, how are you? -Hope doing well.\"

# To take input from the user
# my_str = input(\"Enter a string: \")

# Remove punctuation from the string
no_punct = \"\"
for char in my_str:
    if char not in punctuations:
        no_punct = no_punct + char

# Display the unpunctuated string
print(no_punct)"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Basic.SortWords
    set output_file "SortWords.py"

    set template_content "my_str = \"The quick brown fox jumps over the lazy dog\"

# To take input from the user
# my_str = input(\"Enter a string: \")

# breakdown the string into a list of words
words = [word.lower() for word in my_str.split()]

# sort the list
words.sort()

# display the sorted words
print(\"The sorted words are:\")
for word in words:
    print(word)"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.SetOperations
    set output_file "SetOperations.py"

    set template_content "# define three sets
M = {0, 2, 4, 6, 8, 10}
N = {1, 2, 3, 4, 5, 7}

# set union
print(\"Union of M and N is\", M | N)

# set intersection
print(\"Intersection of M and N is\", M & N)

# set difference
print(\"Difference of M and N is\", M - N)

# set symmetric difference
print(\"Symmetric difference of M and N is\", M ^ N)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.CountVowels
    set output_file "CountVowels.py"

    set template_content "vowels = 'aeiou'

ip_str = 'Hello, have you visited my github python tutorials yet?'

# make it suitable for caseless comparisions
ip_str = ip_str.casefold()

# make a dictionary with each vowel as key and value 0
count = {}.fromkeys(vowels, 0)

# count the vowels
for char in ip_str:
    if char in count:
        count[char] += 1

print(count)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.CountVowels
    set output_file "CountVowels.py"

    set template_content "# Version 1
vowels = 'aeiou'

ip_str = 'Hello, have you visited my github python tutorials yet?'

# make it suitable for caseless comparisons
ip_str = ip_str.casefold()

# make a dictionary with each vowel as key and value 0
count = {}.fromkeys(vowels,0)

# count the vowels
for char in ip_str:
    if char in count:
        count[char] += 1

print(count)

# Version 2: using dictionary comprehension
ip_str = 'Hello, have you visited my github python tutorials yet?'

# make it suitable for caseless comparisons
ip_str = ip_str.casefold()

# count the vowels
count = {x: sum([1 for char in ip_str if char == x]) for x in 'aeiou'}

print(count)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.MergeDicts
    set output_file "MergeDicts.py"

    set template_content "# Method 1: Using | operator (Python 3.9+)
dict_1 = {1: 'a', 2: 'b'}
dict_2 = {2: 'c', 4: 'd'}

print(dict_1 | dict_2)

# Method 2: Using unpacking **
dict_1 = {1: 'a', 2: 'b'}
dict_2 = {2: 'c', 4: 'd'}

print({**dict_1, **dict_2})

# Method 3: Using copy() and update()
dict_1 = {1: 'a', 2: 'b'}
dict_2 = {2: 'c', 4: 'd'}

dict_3 = dict_2.copy()
dict_3.update(dict_1)

print(dict_3)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.EnumerateList
    set output_file "EnumerateList.py"

    set template_content "# Method 1: Using enumerate()
my_list = [21, 33, 66, 77]

for index, val in enumerate(my_list):
    print(index, val)

# Method 2: Using enumerate() with start=1
my_list = [21, 33, 66, 77]

for index, val in enumerate(my_list, start=1):
    print(index, val)

# Method 3: Using range() and len()
my_list = [21, 33, 66, 77]

for index in range(len(my_list)):
    value = my_list[index]
    print(index, value)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoG.FlattenNestedList
    set output_file "FlattenNestedList.py"

    set template_content "# Method 1: List comprehension
my_list = [[7], [6, 5], [4, 3, 2, 1]]
flat_list = [num for sublist in my_list for num in sublist]
print(flat_list)

# Method 2: Nested loops
my_list = [[7], [6, 5], [4, 3, 2, 1]]
flat_list = []
for sublist in my_list:
    for num in sublist:
        flat_list.append(num)
print(flat_list)

# Method 3: Using itertools.chain
import itertools
my_list = [[7], [6, 5], [4, 3, 2, 1]]
flat_list = list(itertools.chain(*my_list))
print(flat_list)

# Method 4: Using sum()
my_list = [[7], [6, 5], [4, 3, 2, 1]]
flat_list = sum(my_list, [])
print(flat_list)

# Method 5: Using functools.reduce
from functools import reduce
my_list = [[7], [6, 5], [4, 3, 2, 1]]
print(reduce(lambda x, y: x + y, my_list))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.ListSlicing
    set output_file "ListSlicingExamples.py"

    set template_content "# Original list
my_list = [1, 2, 3, 4, 5, 6]

# Full slice
print(my_list[:])

# Slice from index 3 to end
print(my_list[3:])

# Slice from start to index 3 (exclusive)
print(my_list[:3])

# Slice from index 2 to 5 (exclusive)
print(my_list[2:5])

# Slice with step 3
print(my_list[::3])

# Reverse slice with step -3
print(my_list[::-3])

# Slice from index 1 to 5 with step 3
print(my_list[1:5:3])
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.DictSorting
    set output_file "DictSortingExamples.py"

    set template_content "# Original dictionary
dt = {7:8, 1:9, 6:3}

# Sort dictionary by values
sorted_dt = {key: value for key, value in sorted(dt.items(), key=lambda item: item[1])}
print(sorted_dt)

# Sort and get only the values
sorted_dt_value = sorted(dt.values())
print(sorted_dt_value)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.ListExamples.Basic
    set output_file "ListExamples.py"

    set template_content "# Проверка на пустой список
my_list = []
if not my_list:
    print(\"The list is empty\")

if not len(my_list):
    print(\"The list is empty\")

if my_list == []:
    print(\"The list is empty\")

# Объединение списков
list_1 = [7, 'n', 'm']
list_2 = [3, 6, 9]

list_joined = list_1 + list_2
print(list_joined)

# Использование распаковки
list_1 = [7, 'n', 'm']
list_2 = range(3, 6)

list_joined = [*list_1, *list_2]
print(list_joined)

# Объединение и удаление дубликатов
list_1 = [7, 'n', 'm']
list_2 = [7, 9, 12]

list_joined = list(set(list_1 + list_2))
print(list_joined)

# Использование extend()
list_1 = [7, 'n', 'm']
list_2 = [7, 9, 12]

list_2.extend(list_1)
print(list_2)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Basic.ListDict
    set output_file "ListDictChunkExamples.py"

    set template_content "# Перевірка наявності ключа у словнику
my_dict = {1: 'a', 2: 'b', 3: 'c'}

if 2 in my_dict:
    print(\"present\")

# Розбиття списку на чанки за допомогою генератора
def split(list_a, chunk_size):
    for i in range(0, len(list_a), chunk_size):
        yield list_a[i:i + chunk_size]

chunk_size = 2
my_list = [1,2,3,4,5,6,7,8,9]
print(list(split(my_list, chunk_size)))

# Розбиття списку на чанки за допомогою list comprehension
chunk_size = 2
list_chunked = [my_list[i:i + chunk_size] for i in range(0, len(my_list), chunk_size)]
print(list_chunked)

# Розбиття списку на рівні частини з numpy
import numpy as np

my_list = [1,2,3,4,5,6,7,8,9]
print(np.array_split(my_list, 5))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.TypeConversion
    set output_file "TypeConversion_Date_ListExample.py"

    set template_content "# Конвертація рядка у ціле число
balance_str = \"1900\"
balance_int = int(balance_str)

print(type(balance_int))
print(balance_int)

# Конвертація рядка у число з плаваючою крапкою
balance_str = \"1900.6\"
balance_float = float(balance_str)

print(type(balance_float))
print(balance_float)

# Конвертація рядка з десятковою частиною у ціле число
balance_str = \"1900.36\"
balance_int = int(float(balance_str))

print(type(balance_int))
print(balance_int)

# Вивід тексту з кольором у терміналі
print('\\x1b[38;2;6;96;243m' + 'Python4DataScience' + '\\x1b[0m')

# Конвертація рядка у datetime за допомогою strptime
from datetime import datetime

my_date_string = \"Aug 9 2018 11:11AM\"
datetime_object = datetime.strptime(my_date_string, '%b %d %Y %I:%M%p')

print(type(datetime_object))
print(datetime_object)

# Конвертація рядка у datetime за допомогою dateutil.parser
from dateutil import parser

date_time = parser.parse(\"Aug 9 2018 11:11AM\")

print(date_time)
print(type(date_time))

# Доступ до останнього елементу списку
my_list = ['a', 'b', 'c', 'd', 'e', 'f']
print(my_list[-1])
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.StringListDict
    set output_file "StringListDict_Examples.py"

    set template_content "# Приклади роботи з рядками
my_string = \"Python is fun.\"

# друк підрядка
print(my_string[0:6])
print(my_string[7:])
print(my_string[:-1])

# Випадковий вибір елемента зі списку
import random
my_list = [1, 'a', 33, 'c', 'd', 66]
print(random.choice(my_list))

# Більш криптографічно безпечний вибір
import secrets
print(secrets.choice(my_list))

# Перевірка, чи можна конвертувати у float
def isfloat(num):
    try:
        float(num)
        return True
    except ValueError:
        return False

print(isfloat('s66'))
print(isfloat('9.639'))

# Підрахунок кількості елементів у списку
freq = ['a', 1, 'a', 9, 6, 3, 'a'].count('a')
print(freq)

# Робота зі словниками
my_dict = {33: 'a', 77: 'b', 99: 'c'}
del my_dict[33]
print(my_dict)

my_dict = {33: 'a', 77: 'b', 99: 'c'}
print(my_dict.pop(33))
print(my_dict)

# Багаторядкові рядки
my_string = '''The only way to
learn to programing is
by writing codes.'''
print(my_string)

my_string = (\"The only way to \\n\"
             \"learn to programing is \\n\"
             \"by writing codes.\")
print(my_string)

my_string = \"The only way to \\n\" \\
            \"learn to programing is \\n\" \\
            \"by writing codes.\"
print(my_string)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Basic.DictStringList
    set output_file "DictStringList_Examples.py"

    set template_content "# Створення словника за допомогою zip()
index = [1, 2, 3]
languages = ['python', 'java', 'c']

dictionary = dict(zip(index, languages))
print(dictionary)

# Створення словника через dict comprehension
dictionary = {k: v for k, v in zip(index, languages)}
print(dictionary)

# Видалення пробілів у рядках
my_string = \" Python4DataScience \"
print(my_string.strip())

my_string = \" \\nPython4DataScience \"
print(my_string.strip(\" \"))

# Видалення пробілів через регулярні вирази
import re
my_string  = \" Hello World \"
output = re.sub(r'^\\s+|\\s+\$', '', my_string)
print(output)

# Робота зі списками та del
my_list = [1, 2, 3, 4]
del my_list[1]
print(my_list)

# del повністю списку
my_list = [1, 2, 3, 4]
del my_list
# print(my_list) # викличе помилку, тому можна закоментувати

# del з індексами
my_list = [1, 2, 3, 4]
del my_list[3:]
print(my_list)

# del елементу за індексом (помилка якщо індекс поза діапазоном)
my_list = [1, 2, 3, 4]
# del my_list[4] # викличе IndexError
# print(my_list)

# remove() для видалення елемента
my_list = [1, 2, 3, 4]
my_list.remove(2)
print(my_list)

# remove() для елементу, якого немає (викличе ValueError)
# my_list.remove(12)
# print(my_list)

# pop() для видалення елемента за індексом
my_list = [1, 2, 3, 4]
print(my_list.pop(2))
print(my_list)

# pop() з індексом поза діапазоном (викличе IndexError)
# my_list.pop(4)
# print(my_list)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Basic.ZipDigitsAnagram
    set output_file "ZipDigitsAnagram_StringCapitalize.py"

    set template_content "# Приклад zip() з двома списками
list_1 = [1, 2, 3, 4, 5]
list_2 = ['a', 'b', 'c']

for i, j in zip(list_1, list_2):
    print(i, j)

# Підрахунок кількості цифр у числі через цикл
num = 963969
count = 0

while num != 0:
    num //= 10
    count += 1

print(\"Number of digits: \" + str(count))

# Підрахунок кількості цифр через str()
num = 123456
print(len(str(num)))

# Перевірка анаграм
str1 = \"Heart\"
str2 = \"Earth\"

str1 = str1.lower()
str2 = str2.lower()

if len(str1) == len(str2):
    sorted_str1 = sorted(str1)
    sorted_str2 = sorted(str2)
    if sorted_str1 == sorted_str2:
        print(str1 + \" and \" + str2 + \" are anagram.\")
    else:
        print(str1 + \" and \" + str2 + \" are not anagram.\")
else:
    print(str1 + \" and \" + str2 + \" are not anagram.\")

# Капіталізація першої букви рядка
my_string = \"python is Fun\"
print(my_string[0].upper() + my_string[1:])

cap_string = my_string.capitalize()
print(cap_string)

# Генерація перестановок рядка
def get_permutation(string, i=0):
    if i == len(string):   	 
        print(\"\".join(string))
    for j in range(i, len(string)):
        words = [c for c in string]
        words[i], words[j] = words[j], words[i]
        get_permutation(words, i + 1)

get_permutation('eat')

# Підрахунок кількості входжень символу у рядку через цикл
count = 0
my_string = \"Python4DataScience\"
my_char = \"a\"
for i in my_string:
    if i == my_char:
        count += 1
print(count)

# Підрахунок кількості входжень символу через str.count()
print(my_string.count(my_char))

# Видалення дублікатів зі списку
list_1 = [1, 3, 1, 6, 9]
print(list(set(list_1)))

# Симетрична різниця двох списків
list_1 = [1, 3, 1, 6, 9]
list_2 = [7, 5, 2, 8]
print(list(set(list_1) ^ set(list_2)))"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.MatrixNumpy.Advanced
    set output_file "MatrixNumpy_Advanced.py"

    set template_content "# Робота з вкладеними списками (матрицями)
A = [[1, 3, 6, 12], 
    [-7, 8, 9, 0],
    [-5, 7, 12, 19]]

print(\"A =\", A) 
print(\"A[1] =\", A[1])      # 2nd row
print(\"A[1][2] =\", A[1][2])   # 3rd element of 2nd row
print(\"A[0][-1] =\", A[0][-1])   # Last element of 1st Row

column = []
for row in A:
    column.append(row[2])   
print(\"3rd column =\", column)

# NumPy: створення масивів
import numpy as np

A = np.array([[1, 2, 3], [3, 4, 5]])
print(A)

A = np.array([[1.1, 2, 3], [3, 4, 5]]) # Array of floats
print(A)

A = np.array([[1, 2, 3], [3, 4, 5]], dtype = complex) # Array of complex numbers
print(A)

# Масиви заповнені нулями та одиницями
zeros_array = np.zeros((2, 3))
print(zeros_array)

ones_array = np.ones((1, 5), dtype=np.int32)
print(ones_array)

# arange та reshape
A = np.arange(4)
print('A =', A)

B = np.arange(12).reshape(2, 6)
print('B =', B)

# Доступ до елементів масиву
A = np.array([2, 4, 6, 8, 10])
print(\"A[0] =\", A[0])     
print(\"A[2] =\", A[2])     
print(\"A[-1] =\", A[-1])   

# Вкладені масиви
A = np.array([[1, 3, 7, 12],
              [-5, 6, 9, 0],
              [-3, 7, 15, 19]])
print(\"A[0][0] =\", A[0][0])  
print(\"A[1][2] =\", A[1][2])
print(\"A[-1][-1] =\", A[-1][-1])
print(\"A[0] =\", A[0]) 
print(\"A[2] =\", A[2])
print(\"A[-1] =\", A[-1])

# Доступ до колонок
print(\"A[:,0] =\", A[:,0])
print(\"A[:,3] =\", A[:,3])
print(\"A[:,-1] =\", A[:,-1])

# Приклади індексації масивів
letters = np.array([1, 3, 5, 7, 9, 7, 5])
print(letters[2:5])
print(letters[:-5])
print(letters[5:])
print(letters[:])
print(letters[::-1])

# Вибірка підмасивів
A = np.array([[1, 4, 5, 12, 14], 
              [-5, 8, 9, 0, 17],
              [-6, 7, 11, 19, 21]])
print(A[:2, :4])
print(A[:1,])
print(A[:,2])
print(A[:,2:5])

# Додавання матриць
A = np.array([[3, 6], [7, -9]])
B = np.array([[9, -3], [3, 6]])
C = A + B
print(C)

# Матричне множення (dot product)
A = np.array([[3, 6, 5], [7, -3, 0]])
B = np.array([[1, 1], [2, 1], [3, -3]])
C = A.dot(B)
print(C)

# Транспонування
A = np.array([[1, 1], [2, 1], [3, -3]])
print(A.transpose())
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Conditional.PrimeLeap
    set output_file "Conditional_PrimeLeap.py"

    set template_content "# Перевірка позитивного, нульового або негативного числа
num = float(input(\"Enter a number: \"))
if num > 0:
    print(\"Positive number\")
elif num == 0:
    print(\"Zero\")
else:
    print(\"Negative number\")

# Альтернативний спосіб вкладених умов
num = float(input(\"Enter a number: \"))
if num >= 0:
    if num == 0:
        print(\"Zero\")
    else:
        print(\"Positive number\")
else:
    print(\"Negative number\")

# Перевірка на парне або непарне число
num = int(input(\"Enter a number: \"))
if (num % 2) == 0:
    print(\"{0} is Even\".format(num))
else:
    print(\"{0} is Odd\".format(num))

# Перевірка високосного року
year = 2022
# year = int(input(\"Enter a year: \"))
if (year % 4) == 0:
    if (year % 100) == 0:
        if (year % 400) == 0:
            print(\"{0} is a leap year\".format(year))
        else:
            print(\"{0} is not a leap year\".format(year))
    else:
        print(\"{0} is a leap year\".format(year))
else:
    print(\"{0} is not a leap year\".format(year))

# Знаходження найбільшого з трьох чисел
num1 = 12
num2 = 19
num3 = 16
# num1 = float(input(\"Enter first number: \"))
# num2 = float(input(\"Enter second number: \"))
# num3 = float(input(\"Enter third number: \"))

if (num1 >= num2) and (num1 >= num3):
    largest = num1
elif (num2 >= num1) and (num2 >= num3):
    largest = num2
else:
    largest = num3

print(\"The largest number is:\", largest)

# Перевірка, чи число просте (варіант з flag)
num = 39
# num = int(input(\"Enter a number: \"))
flag = False

if num > 1:
    for i in range(2, num):
        if (num % i) == 0:
            flag = True
            break

if flag:
    print(num, \"is not a prime number\")
else:
    print(num, \"is a prime number\")

# Перевірка простого числа з поясненням
num = 963
# num = int(input(\"Enter a number: \"))

if num > 1:
    for i in range(2,num):
        if (num % i) == 0:
            print(num, \"is not a prime number\")
            print(i, \"times\", num//i, \"is\", num)
            break
    else:
        print(num, \"is a prime number\")
else:
    print(num, \"is not a prime number\")

# Виведення простих чисел у проміжку
lower = 900
upper = 1000

print(\"Prime numbers between\", lower, \"and\", upper, \"are:\")

for num in range(lower, upper + 1):
    if num > 1:
        for i in range(2, num):
            if (num % i) == 0:
                break
        else:
            print(num)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.factorial-range
    set output_file "Loops_MathExamples.py"

    set template_content "# Обчислення факторіалу числа
num = 6
# num = int(input(\"Enter a number: \"))
factorial = 1

if num < 0:
    print(\"Sorry, factorial does not exist for negative numbers\")
elif num == 0:
    print(\"The factorial of 0 is 1\")
else:
    for i in range(1, num + 1):
        factorial *= i
    print(\"The factorial of\", num, \"is\", factorial)

# Таблиця множення числа
num = 15
# num = int(input(\"Display multiplication table of? \"))
for i in range(1, 11):
    print(num, 'x', i, '=', num*i)

# Послідовність Фібоначчі
nterms = int(input(\"How many terms? \"))
n1, n2 = 0, 1
count = 0

if nterms <= 0:
    print(\"Please enter a positive integer\")
elif nterms == 1:
    print(\"Fibonacci sequence upto\", nterms, \":\")
    print(n1)
else:
    print(\"Fibonacci sequence:\")
    while count < nterms:
        print(n1)
        nth = n1 + n2
        n1, n2 = n2, nth
        count += 1

# Перевірка числа на Armstrong
num = int(input(\"Enter a number: \"))
sum = 0
temp = num
while temp > 0:
    digit = temp % 10
    sum += digit ** 3
    temp //= 10

if num == sum:
    print(num, \"is an Armstrong number\")
else:
    print(num, \"is not an Armstrong number\")

# Armstrong числа у діапазоні
lower = 90
upper = 1500
for num in range(lower, upper + 1):
    order = len(str(num))
    sum = 0
    temp = num
    while temp > 0:
        digit = temp % 10
        sum += digit ** order
        temp //= 10
    if num == sum:
        print(num)

# Сума чисел до num
num = 19
if num < 0:
    print(\"Enter a positive number\")
else:
    sum = 0
    while num > 0:
        sum += num
        num -= 1
    print(\"The sum is\", sum)

# Вивід піраміди з зірочок
rows = int(input(\"Enter number of rows: \"))
for i in range(rows):
    for j in range(i + 1):
        print(\"* \", end=\"\")
    print(\"\\n\")

# Ітерація по словнику
dt = {'a': 'time', 'b': 'money', 'c': 'health'}
for key, value in dt.items():
    print(key, value)

# Реверс числа
num = 123456
reversed_num = 0
while num != 0:
    digit = num % 10
    reversed_num = reversed_num * 10 + digit
    num //= 10
print(\"Reversed Number: \" + str(reversed_num))

# Обчислення степеня числа (while)
base = 2
exponent = 3
power = exponent
result = 1
while exponent != 0:
    result *= base
    exponent -= 1
print(\"Value of\", base, \"power\", power, \"is:\", str(result))

# Обчислення степеня числа (for)
base = 2
exponent = 3
power = exponent
result = 1
for exponent in range(exponent, 0, -1):
    result *= base
print(\"Value of\", base, \"power\", power, \"is:\", str(result))

# Використання pow() для обчислення степеня
base = 2
exponent = -3
power = exponent
result = pow(base, exponent)
print(\"Value of\", base, \"power\", power, \"is:\", str(result))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.IfElseElif
    set output_file "IfElse_Nested.py"

    set template_content "# Example 1: Age-based ordering
age = 30

if age >= 21:
    print(\"I would like a three philosophers, please\")
elif age >= 18:
    print(\"I'm here to vote -- you can vote at bars, right?\")
else:
    print(\"I really shouldn't even be here but can I have a cherry coke please?\")

# Example 2: Age and gender-based life stages
age = 10
gender = 'f'

if age < 2:
    print(\"You can eat and poo all day and people will fall all over themselves over how adorable you are\")
elif age == 2:
    print(\"You can throw tantrums and it's pretty much expected\")
elif age == 3:
    print(\"By this point, you are the master of object permanence.\")
elif 4 <= age <= 6:
    print(\"This seems like a good time to learn how to read.\")
    if age == 4:
        print(\"How about some preschool?\")
    elif age == 5:
        print(\"Kindergarten is cool -- nap time rocks.  Don't forget to share.\")
    elif age == 6:
        print(\"First grade.  Naptime is a thing of the past. You're probably too stubborn to be upset much by this.\")
elif 7 <= age <= 9:
    print(\"Grade school goes by so quickly\")
elif 10 <= age <= 11:
    print(\"Middle school is kind of neat.\")
    if age == 10:
        print(\"Health class for the first time ...\")
        if gender.lower() == 'f':
            print(\"... Well, that explains a lot, really.\")
        elif gender.lower() == 'm':
            print(\"Wonder what the girls are all talking about?\")
    elif age == 11:
        print(\"The periodic table is SO COOL\")
elif 12 <= age <= 13:
    print(\"Junior high, aka welcome to hormone land\")
    print(\"PS: sucks to be you\")
elif 14 <= age <= 17:
    print(\"High school was probably the worst\")
    print(\"Why on earth did everyone say it was the best time of their life?\")
    if age >= 16:
        print(\"But you can drive, so you've got that going for you\")
elif age == 18:
    print(\"So you're technically an adult now. But not really.\")
    print(\"But you can vote, so you've got that going for you.\")
    print(\"PS: you have responsibilities now. sucks to be you\")
    if gender.lower() == 'm':
        print(\"Better register for the draft.\")
elif 19 <= age <= 20:
    print(\"Now's a good time to be in college.\")
elif age == 21:
    print(\"Well, you can drink now.\")
elif 22 <= age <= 24:
    print(\"Graduating college and spoiling your liver, mostly.\")
elif age == 25:
    print(\"You can rent a car now.  You know, that's never actually come up for me, but apparently it's a thing ...\")
else:
    print(\"You're an adult.  Do what you want.\")
    if age > 30 and gender.lower() == 'f':
        print(\"Meddling folks are going to start hectoring you about your love life.  Yawn.\")
    if age > 40:
        print(\"You're over the hill\")
    if age > 50:
        print(\"Everything hurts and your children never call.\")
    if age > 70:
        print(\"You're old enough not to care about anything.  You can now do what you like with total impunity.\")

# Example 3: Volunteer goal check
volunteers_goal = 20
current_volunteers = 100

if current_volunteers < volunteers_goal:
    print(f\"You still have {volunteers_goal - current_volunteers} volunteers to recruit!\")
elif current_volunteers == volunteers_goal:
    print(\"You met your goal exactly! Way to go!\")
elif current_volunteers > volunteers_goal:
    print(f\"You exceeded your recruitment goals by {current_volunteers - volunteers_goal}! Way to go!\")
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Average1
    set output_file "Grades_ClassAverage.py"

    set template_content "# Initialization phase
total = 0           # sum of grades
grade_counter = 0   # number of grades entered

# Grades list (замінює введення через input)
grades_list = [85, 90, 78, 92, 88]  # приклад оцінок

# Processing phase
for grade in grades_list:
    total += grade
    grade_counter += 1

# Termination phase
if grade_counter != 0:
    average = total / grade_counter
    print(f'Class average is {average:.2f}')
else:
    print('No grades were entered')
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Average
    set output_file "Grades_ComputeAverage.py"

    set template_content "# Initialization phase
total = 0           # sum of grades
grade_counter = 0   # number of grades processed

# List of grades
grades = [98, 76, 71, 87, 83, 90, 57, 79, 82, 94]  # example grades

# Processing phase
for grade in grades:
    total += grade        # add current grade to running total
    grade_counter += 1    # increment grade counter

# Termination phase
if grade_counter != 0:
    average = total / grade_counter
    print(f'Class average is {average:.2f}')
else:
    print('No grades were entered')
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumMin
    set output_file "MaximumMin_Basic.py"

    set template_content "# -----------------------------
# Function to find the maximum of three values
# -----------------------------
def maximum(value1, value2, value3):
    \"\"\"Return the maximum of three values.\"\"\"
    max_value = value1           # Assume first value is maximum
    if value2 > max_value:       # Compare with second value
        max_value = value2
    if value3 > max_value:       # Compare with third value
        max_value = value3
    return max_value

# Examples
print(maximum(12, 27, 36))        # Numbers
print(maximum(12.3, 45.6, 9.7))   # Floats
print(maximum('FFAD8D', 'red', 'orange'))  # Strings (lexicographical order)
print(maximum(13.5, -3, 7))       # Mixed positive/negative numbers

# -----------------------------
# Using built-in max() and min()
# -----------------------------
print(max('FFAD8D', 'red', 'orange', 'blue', 'green'))  # max of multiple strings
print(min(15, 9, 27, 14))                                # min of multiple numbers

# Example with a list
numbers = [12, 45, 7, 19, 33]
print(\"Max:\", max(numbers))
print(\"Min:\", min(numbers))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.Range
    set output_file "Random_DiceRoll.py"

    set template_content "import random

# Імітація 10 кидків кубика
print('10 випадкових кидків кубика без seed:')
for roll in range(10):
    print(random.randrange(1, 7), end=' ')
print('\\n')

# Ще 10 кидків кубика
for roll in range(10):
    print(random.randrange(1, 7), end=' ')
print('\\n')

# Використання seed для відтворюваності
print('10 випадкових кидків кубика з seed=32:')
random.seed(32)
for roll in range(10):
    print(random.randrange(1, 7), end=' ')
print('\\n')

# Повторне встановлення seed, щоб отримати ту ж саму послідовність
random.seed(32)
print('Повторне відтворення тієї ж послідовності:')
for roll in range(10):
    print(random.randrange(1, 7), end=' ')
print()
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Basic.StringListDict
    set output_file "StringListDict_Access.py"

    set template_content "# -----------------------------
# Приклади роботи зі строками, списками та словниками
# -----------------------------

# Строки
name = 'Shannon'
print(name[0])  # перша буква

# Списки
attendees = ['Shannon', 'Amy', 'Jen', 'Julie']
print(attendees[0:2])  # перші двоє учасників

# Словники
contacts = {
    'Shannon': '202-555-1234',
    'Amy': '410-515-3000',
    'Jen': '301-600-5555',
    'Julie': '202-333-9876'
}

print(contacts['Jen'])  # доступ по ключу

# Список списків
contacts_as_list = [
    ['Shannon', '202-555-1234'],
    ['Amy', '410-515-3000'],
    ['Jen', '301-600-5555'],
    ['Julie', '202-333-9876']
]

phone_we_want = 'Jen'
for contact in contacts_as_list:
    if contact[0] == phone_we_want:
        print(contact[1])

# Ітерація по словнику
for contact, phone in contacts.items():
    print(\"{0}'s number is {1}\".format(contact, phone))

# Доступ до ключів і сортування
for contact in sorted(contacts.keys()):
    print(\"{0}'s number is {1}\".format(contact, contacts[contact]))

# Оновлення словника
contacts['Rachel'] = '202-888-1234'
contacts['Amy'] = '703-444-8888'

new_contacts = {
    'Kristin': '703-333-1234',
    'Katie': '301-555-9876',
    'Grace': '202-777-2222',
    'Charlotte': '410-555-9999'
}

contacts.update(new_contacts)
print(contacts)

# Доступ до значень словника
for phone in contacts.values():
    print(phone)

# -----------------------------
# Рекурсивний доступ до вкладених словників і списків
# -----------------------------
def access(dictionary, nested_keys):
    for index, key in enumerate(nested_keys):
        try:
            # якщо об'єкт словник
            if key in dictionary:
                if nested_keys[index + 1:] != []:
                    return access(dictionary[key], nested_keys[index + 1:])
                else:
                    return dictionary[key]
            else:
                return False
        except TypeError:  # якщо об'єкт список
            if key < len(dictionary):
                if nested_keys[index + 1:] != []:
                    return access(dictionary[key], nested_keys[index + 1:])
                else:
                    return dictionary[key]
            else:
                return False

# Приклад використання
data = {'a': [10, {'b': 20}, 30]}
print(access(data, ['a', 1, 'b']))  # 20
print(access(data, ['a', 2]))       # 30
print(access(data, ['a', 3]))       # False
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.print
    set output_file "print_examples.py"

    set template_content "#!/usr/bin/env python3

print(\"Or you can have a comment on the same line\")  # as a command that Python WILL run

# Printing a Comma-Separated List of Items
print(\"Welcome\", \"to\", \"Python!\")

# Printing Many Lines of Text with One Statement
print(\"Welcome\\nto\\n\\nPython!\")

# Ignoring a Line Break in a Long String
print(\"this is a longer string, so we split it over two lines\")

# Printing the Value of an Expression
print(\"Sum is\", 7 + 3)

print(\"Display \\\"hi\\\" in quotes\")
print(\"Display 'hi' in quotes\")
print(\"Display the name O'Brien\")

print(\"\"\"Display \"hi\" and 'bye' in quotes\"\"\")

# Multiline Strings
triple_quoted_string = \"\"\"This is a triple-quoted
string that spans two lines\"\"\"

print(triple_quoted_string)
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.basic.input_examples
    set output_file "input_examples.py"

    set template_content "#!/usr/bin/env python3

name = input(\"What's your name? \")
print(name)

# Function input Always Returns a String
value1 = input(\"Enter first number: \")
value2 = input(\"Enter second number: \")
print(value1 + value2)

# Getting an Integer from the User
value = int(input(\"Enter an integer: \"))
print(value)

another_value = int(input(\"Enter another integer: \"))
print(another_value)

print(value + another_value)

bad_value = int(input(\"Enter another integer: \"))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Function.GlobalLocalNonlocal
    set output_file "GlobalLocalNonlocal.py"

    set template_content "# Example 1: Create a Global Variable

global_var = 999

def fun1():
    print(\"Value in 1st function:\", global_var)

def fun2():
    print(\"Value in 2nd function:\", global_var)

fun1()
fun2()


------

x = \"global\"

def fun():
    print(\"x inside:\", x)

fun()
print(\"x outside:\", x)

-----

global_lang = 'DataScience'

def var_scope_test():
    local_lang = 'Python'
    print(local_lang)

var_scope_test()  # Output 'Python'

print(global_lang)   # Output 'DataScience'
# print(local_lang)  # NameError

-------

# Example 5: Global vs Local variable

a = 90  # Global variable

def print_data():
    a = 6  # Local variable
    b = 30
    print(\"(a,b):(\", a, \",\", b, \")\")

print_data()
print(\"Global a :\", a)
# print(\"Local b :\", b)  # NameError

--------

# Example 1: Accessing local variable outside the scope

def fun_local_scope():
    y = \"local\"
    
fun_local_scope()
# print(y)  # NameError

-------

def fun_local_print():
    y = \"local\"
    print(y)

fun_local_print()

-------------

def fun1_local():
    loc_var = 999
    print(\"Value is :\", loc_var)

def fun2_local():
    # print(\"Value is :\", loc_var)  # NameError
    pass

fun1_local()
fun2_local()

------------

# Example 1: Using Global and Local variables in the same code

x = \"global\"

def fun_global_local():
    global x
    y = \"local\"
    x = x * 2
    print(x)
    print(y)

fun_global_local()

--------------

# Example 2: Global variable and Local variable with same name

x = 9

def fun_shadow():
    x = 19
    print(\"local x:\", x)

fun_shadow()
print(\"global x:\", x)

------------

# Exercise 3: Function scope demonstration

def my_func():  
    x = 10
    print(\"Value inside the body of function:\", x)

x = 20
my_func()
print(\"Value outside of function:\", x)

-------------------

# Example 1: Create a nonlocal variable

x1 = \"global\"  # Global variable

def outer_fun():  
    x1 = \"local\"  # Local variable in outer function
    print(\"variable type for Outer function:\", x1)
    
    def inner_fun():  # Nested function
        nonlocal x1
        x1 = \"nonlocal\"
        print(\"variable type for Inner function:\", x1)

    inner_fun()
    print(\"Outer function after inner_fun:\", x1)

outer_fun()
print(\"Variable type of x1:\", x1)

-----------

# Nonlocal in nested function example

def outer_fun_nonlocal():
    x = 999

    def inner_fun():
        nonlocal x
        x = 900
        print(\"value of x inside inner function is:\", x)

    inner_fun()
    print(\"value of x inside outer function is:\", x)

outer_fun_nonlocal()
"
echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Function.GlobalLocalNonlocal
    set output_file "GlobalLocalNonlocal.py"

    set template_content '
# Example 1: Create a Global Variable

global_var = 999

def fun1():
    print("Value in 1st function:", global_var)

def fun2():
    print("Value in 2nd function:", global_var)

fun1()
fun2()


# --------------------------------
x = "global"

def fun():
    print("x inside:", x)

fun()
print("x outside:", x)


# --------------------------------
global_lang = "DataScience"

def var_scope_test():
    local_lang = "Python"
    print(local_lang)

var_scope_test()  
print(global_lang)   


# --------------------------------
# Global vs Local variable

a = 90

def print_data():
    a = 6
    b = 30
    print("(a,b):(", a, ",", b, ")")

print_data()
print("Global a :", a)


# --------------------------------
def fun_local_scope():
    y = "local"

fun_local_scope()


# --------------------------------
def fun_local_print():
    y = "local"
    print(y)

fun_local_print()


# --------------------------------
def fun1_local():
    loc_var = 999
    print("Value is :", loc_var)

def fun2_local():
    pass

fun1_local()
fun2_local()


# --------------------------------
# Using global and local variables

x = "global"

def fun_global_local():
    global x
    y = "local"
    x = x * 2
    print(x)
    print(y)

fun_global_local()


# --------------------------------
# Shadowing: local and global x

x = 9

def fun_shadow():
    x = 19
    print("local x:", x)

fun_shadow()
print("global x:", x)


# --------------------------------
# Function scope demonstration

def my_func():  
    x = 10
    print("Value inside function:", x)

x = 20
my_func()
print("Value outside function:", x)


# --------------------------------
# nonlocal example

x1 = "global"

def outer_fun():  
    x1 = "local"
    print("Outer function:", x1)
    
    def inner_fun():
        nonlocal x1
        x1 = "nonlocal"
        print("Inner function:", x1)

    inner_fun()
    print("Outer after inner:", x1)

outer_fun()
print("Global x1:", x1)


# --------------------------------
# Nonlocal in nested functions

def outer_fun_nonlocal():
    x = 999

    def inner_fun():
        nonlocal x
        x = 900
        print("value of x in inner:", x)

    inner_fun()
    print("value of x in outer:", x)

outer_fun_nonlocal()
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.functions2
    set output_file "python_functions_examples.py"

    set template_content '
# ------------------------------
# FIND EVEN NUMBERS
# ------------------------------
def find_even_numbers(n):
    evens = []
    for i in range(n + 1):
        if i % 2 == 0:
            evens.append(i)
    return evens
print(find_even_numbers(10))

# ------------------------------
# WISH FUNCTION
# ------------------------------
def wish(name):
    """
    This function wishes to the person passed in as a parameter
    """
    print("Happy birthday, " + name + ". Hope you have a wonderful day!")
wish("Bill")

# ------------------------------
# GREETINGS WITH DEFAULT PARAMETER
# ------------------------------
def greetings(name="Clark"):
    message = name + ", welcome to Python for Data Science"
    return message
print(greetings())
print(greetings("Milaan"))

# ------------------------------
# GENERATE FULL NAME WITH DEFAULTS
# ------------------------------
def generate_full_name(first_name="Milaan", last_name="Parmar"):
    full_name = first_name + " " + last_name
    return full_name
print(generate_full_name())
print(generate_full_name("Ethan","Hunt"))

# ------------------------------
# CALCULATE AGE WITH DEFAULT CURRENT YEAR
# ------------------------------
def calculate_age(birth_year, current_year=2021):
    return current_year - birth_year
print("Age:", calculate_age(1821))

# ------------------------------
# SWAP FUNCTION
# ------------------------------
def swap(x, y):
    temp = x
    x = y
    y = temp
    print("value of x is:", x)
    print("value of y is:", y)
x = 6
y = 9
swap(x, y)

# ------------------------------
# EVEN OR ODD CHECK
# ------------------------------
def even_odd(n):
    if n % 2 == 0:
        print(n, "is an Even number")
    else:
        print(n, "is an Odd Number")
even_odd(9)

# ------------------------------
# WEIGHT OF OBJECT WITH DEFAULT GRAVITY
# ------------------------------
def weight_of_object(mass, gravity=9.81):
    return str(mass * gravity) + " N"
print("Weight:", weight_of_object(100))
print("Weight on Moon:", weight_of_object(100, 1.62))

# ------------------------------
# PLACEHOLDER FUNCTION (PASS)
# ------------------------------
def addition(num1, num2):
    pass
addition(10, 2)
'

  
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Basic.functions1
    set file "python_functions_template.py"

    set template_content '
# ------------------------------
# SIMPLE GREETING
# ------------------------------
def greet():
    print("Welcome to Python for Data Science")
greet()

# ------------------------------
# ADD TWO NUMBERS
# ------------------------------
def add_two_numbers():
    num_one = 3
    num_two = 6
    total = num_one + num_two
    print(total)
add_two_numbers()

# ------------------------------
# GENERATE FULL NAME
# ------------------------------
def generate_full_name():
    first_name = "Milaan"
    last_name = "Parmar"
    space = " "
    full_name = first_name + space + last_name
    print(full_name)
generate_full_name()

# ------------------------------
# RETURN EXAMPLES
# ------------------------------
def add_two_numbers():
    num_one = 3
    num_two = 6
    total = num_one + num_two
    return total
print(add_two_numbers())

def generate_full_name():
    first_name = "Milaan"
    last_name = "Parmar"
    space = " "
    full_name = first_name + space + last_name
    return full_name
print(generate_full_name())

# ------------------------------
# GREETING WITH PARAMETER
# ------------------------------
def greet(name):
    """
    This function greets to the person passed in as a parameter
    """
    print("Hello, " + name + ". Good morning!")

# ------------------------------
# SUM OF NUMBERS
# ------------------------------
def sum_of_numbers(n):
    total = 0
    for i in range(n+1):
        total += i
    print(total)
print(sum_of_numbers(10))
print(sum_of_numbers(100))

# ------------------------------
# COURSE FUNCTION
# ------------------------------
def course(name, course_name):
    print("Hello", name, "Welcome to Python for Data Science")
    print("Your course name is", course_name)
course("Arthur", "Python")

# ------------------------------
# SINGLE PARAMETER FUNCTIONS
# ------------------------------
def greetings(name):
    message = name + ", welcome to Python for Data Science"
    return message
print(greetings("Milaan"))

def add_ten(num):
    ten = 10
    return num + ten
print(add_ten(90))

def square_number(x):
    return x * x
print(square_number(3))

def area_of_circle(r):
    PI = 3.14
    area = PI * r ** 2
    return area
print(area_of_circle(10))

# ------------------------------
# TWO PARAMETER FUNCTIONS
# ------------------------------
def calculator(a, b):
    add = a + b
    return add
result = calculator(30, 6)
print("Addition :", result)

def generate_full_name(first_name, last_name):
    space = " "
    full_name = first_name + space + last_name
    return full_name
print("Full Name: ", generate_full_name("Milaan", "Parmar"))

def sum_two_numbers(num_one, num_two):
    sum = num_one + num_two
    return sum
print("Sum of two numbers: ", sum_two_numbers(1, 9))

def calculate_age(current_year, birth_year):
    age = current_year - birth_year
    return age
print("Age: ", calculate_age(2021, 1819))

def weight_of_object(mass, gravity):
    weight = str(mass * gravity) + " N"
    return weight
print("Weight of an object in Newtons: ", weight_of_object(100, 9.81))

# ------------------------------
# NAMED PARAMETERS
# ------------------------------
def print_fullname(firstname, lastname):
    space = " "
    full_name = firstname + space + lastname
    print(full_name)
print(print_fullname(firstname="Milaan", lastname="Parmar"))

def add_two_numbers(num1, num2):
    total = num1 + num2
    print(total)
print(add_two_numbers(num2=3, num1=2))

def print_fullname(firstname, lastname):
    space = " "
    full_name = firstname + space + lastname
    return full_name
print(print_fullname(firstname="Milaan", lastname="Parmar"))

def add_two_numbers(num1, num2):
    total = num1 + num2
    return total
print(add_two_numbers(num2=3, num1=2))

# ------------------------------
# ABSOLUTE VALUE FUNCTION
# ------------------------------
def absolute_value(num):
    """This function returns the absolute
    value of the entered number"""
    if num >= 0:
        return num
    else:
        return -num
print(absolute_value(2))
print(absolute_value(-4))

# ------------------------------
# MULTIPLE FUNCTIONS
# ------------------------------
def sum(a, b):
    print("Adding the two values")
    print("Printing within Function")
    print(a + b)
    return a + b

def msg():
    print("Hello")
    return

total = sum(10, 20)
print("total : ", total)
msg()
print("Rest of code")

# ------------------------------
# EVEN NUMBERS
# ------------------------------
def is_even(list1):
    even_num = []
    for n in list1:
        if n % 2 == 0:
            even_num.append(n)
    return even_num
even_num = is_even([2, 3, 46, 63, 72, 83, 90, 19])
print("Even numbers are:", even_num)

# ------------------------------
# MULTIPLE RETURNS
# ------------------------------
def arithmetic(num1, num2):
    add = num1 + num2
    sub = num1 - num2
    multiply = num1 * num2
    division = num1 / num2
    return add, sub, multiply, division

a, b, c, d = arithmetic(10, 2)
print("Addition: ", a)
print("Subtraction: ", b)
print("Multiplication: ", c)
print("Division: ", d)

# ------------------------------
# EVEN CHECK WITH RETURN
# ------------------------------
def is_even(n):
    if n % 2 == 0:
        print("even")
        return True
    return False
print(is_even(10))
print(is_even(7))
'

    echo $template_content > $file
    set_color FFAD8D
    echo "$file created"
    set_color normal
    cat $file
end


function algoP.Basic.function
    set output_file "python_examples.py"

    set template_content "# ------------------------------
# BASIC FUNCTION & ASSIGNMENT
# ------------------------------
def my_function(foo):
    return foo + 1
my_var = my_function
print(str(my_var(1)))  # prints \"2\"

def my_function(foo):
    def my_inner_function():
        return 1
    return foo + my_inner_function()
print(str(my_function(1)))

def my_function(foo, my_parameter_function):
    return foo + my_parameter_function()
def parameter_function(): return 1
print(str(my_function(1, parameter_function)))

def my_function(constant):
    def inner(foo):
        return foo + constant
    return inner
plus_one = my_function(1)
print(str(plus_one(1)))

# ------------------------------
# LAMBDA EXAMPLES
# ------------------------------
terms = 11
result = list(map(lambda x: 2 ** x, range(terms)))
print(\"The total terms are:\", terms)
for i in range(terms):
    print(\"Value of 2 to power\", i, \"is:\", result[i])

my_list = [17, 34, 51, 43, 68, 72, 119, 327, 243, 986]
result = list(filter(lambda x: (x % 17 == 0), my_list))
print(\"Numbers divisible by 17 are\", result)

# ------------------------------
# HCF & LCM
# ------------------------------
def compute_hcf(x, y):
    smaller = y if x > y else x
    for i in range(1, smaller+1):
        if (x % i == 0) and (y % i == 0):
            hcf = i
    return hcf
print(\"The H.C.F. of 64 and 24 is:\", compute_hcf(64, 24))

def compute_lcm(x, y):
    greater = x if x > y else y
    while True:
        if (greater % x == 0) and (greater % y == 0):
            return greater
        greater += 1
print(\"The L.C.M. of 64 and 24 is:\", compute_lcm(64, 24))

# ------------------------------
# FACTORS
# ------------------------------
def print_factors(x):
    print(\"The factors of\", x, \"are:\")
    for i in range(1, x+1):
        if x % i == 0:
            print(i)
print_factors(290)

# ------------------------------
# SIMPLE CALCULATOR
# ------------------------------
def add(x, y): return x + y
def subtract(x, y): return x - y
def multiply(x, y): return x * y
def divide(x, y): return x / y

num1 = 5
num2 = 3
print(num1, \"+\", num2, \"=\", add(num1, num2))
print(num1, \"-\", num2, \"=\", subtract(num1, num2))
print(num1, \"*\", num2, \"=\", multiply(num1, num2))
print(num1, \"/\", num2, \"=\", divide(num1, num2))

# ------------------------------
# DECK OF CARDS
# ------------------------------
import itertools, random
deck = list(itertools.product(range(1,14), [\"Spade\",\"Heart\",\"Diamond\",\"Club\"]))
random.shuffle(deck)
print(\"You've got:\")
for i in range(5):
    print(deck[i][0], \"of\", deck[i][1])

# ------------------------------
# RECURSION EXAMPLES
# ------------------------------
def recur_fibo(n):
    if n <= 1: return n
    return recur_fibo(n-1) + recur_fibo(n-2)
print(\"Fibonacci sequence:\")
for i in range(9):
    print(recur_fibo(i))

def recur_sum(n):
    if n <= 1: return n
    return n + recur_sum(n-1)
print(\"The sum is:\", recur_sum(19))

def recur_factorial(n):
    if n == 1: return n
    return n * recur_factorial(n-1)
print(\"The factorial of 6 is:\", recur_factorial(6))

def convertToBinary(n):
    if n > 1: convertToBinary(n // 2)
    print(n % 2, end=\"\")
convertToBinary(47)
print(\" is a Binary equivalent to Decimal of 47\")

# ------------------------------
# RETURNING MULTIPLE VALUES
# ------------------------------
def name():
    return \"Arthur\",\"Ethan\",\"Peter\"
print(name())
n1, n2, n3 = name()
print(n1, n2, n3)

def name_dict():
    return {1:\"Arthur\", 2:\"Ethan\", 3:\"Peter\"}
print(name_dict())
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.Basic.functions
    set output_file "functions_all.py"

    set template_content "def my_function(my_arg):
    return my_arg + 1

print(my_function(5))  # 6

# -------------------------------------------------

def my_function(my_arg: int) -> int:
    return my_arg + 1

print(my_function(10))  # 11

# -------------------------------------------------

def my_function(my_arg):
    if not isinstance(my_arg, (int, float)):
        raise TypeError(\"Аргумент повинен бути числом\")
    return my_arg + 1

print(my_function(3.5))  # 4.5
# print(my_function(\"abc\")) -> TypeError

# -------------------------------------------------

my_function = lambda x: x + 1

print(my_function(7))  # 8

# -------------------------------------------------

def my_function(my_arg):
    print(my_arg + 1)

my_function(5)

# -------------------------------------------------

def my_function(my_arg):
    \"\"\"
    Функція збільшує аргумент на 1.
    \"\"\"
    return my_arg + 1

print(my_function(9))  # 10

# -------------------------------------------------

def my_function(my_arg):
    try:
        return my_arg + 1
    except Exception:
        print(\"Помилка! Не можна додати 1 до цього значення.\")

my_function(\"abc\")

# -------------------------------------------------

import asyncio

async def my_function(my_arg):
    await asyncio.sleep(0.1)
    return my_arg + 1

async def main():
    print(await my_function(10))

asyncio.run(main())

# -------------------------------------------------

class Incrementer:
    def __call__(self, x):
        return x + 1

inc = Incrementer()

print(inc(5))  # 6

# -------------------------------------------------

from functools import lru_cache

@lru_cache(maxsize=None)
def my_function(n):
    return n + 1

print(my_function(5))

# -------------------------------------------------

def my_function(x):
    return x + 1

nums = [1, 2, 3, 4]
new_nums = list(map(my_function, nums))

print(new_nums)

# -------------------------------------------------

from functools import partial
import operator

my_function = partial(operator.add, 1)

print(my_function(5))

# -------------------------------------------------

def make_incrementer(step=1):
    def inner(x):
        return x + step
    return inner

inc1 = make_incrementer(1)
inc5 = make_incrementer(5)

print(inc1(10))
print(inc5(10))
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"File written: $output_file\"
    set_color normal
    cat $output_file
end


function algoP.Basic.coffee_shop
    set output_file "coffee_shop_orders.py"

    set template_content "#!/usr/bin/env python3
import json
import os

def main_menu(orders):
    while True:
        order = get_order()
        if order == {}:
            print(\"You entered 'X', exiting...\")
            return
        print(\"Check your order:\")
        print_order(order)
        confirm = input(\"Confirm? Press Y to confirm, N to cancel: \")
        if confirm == \"Y\" or confirm == \"y\":
            orders.append(order)
            print(\"Thanks for your order:\")
            print_order(order)
        else:
            continue

def menu(choices, title=\"Erik's Menu\", prompt=\"Choose your item: \"):
    print(title)
    print(len(title) * \"-\")
    i = 1
    for c in choices:
        print(i, c)
        i += 1
    while True:
        choice = input(prompt)
        allowed_answers = []
        for a in range(1, len(choices) + 1):
            allowed_answers.append(str(a))
        allowed_answers.append(\"X\")
        allowed_answers.append(\"x\")
        if choice in allowed_answers:
            if choice == \"X\" or choice == \"x\":
                answer = \"\"
                break
            else:
                answer = choices[int(choice) - 1]
                break
        else:
            print(\"Enter number from 1 to\", len(choices))
            answer = \"\"
    return answer

def read_menu(filename):
    f = open(filename)
    temp = f.readlines()
    result = []
    for item in temp:
        new_item = item.strip()
        result.append(new_item)
    return result

def get_order():
    order = {}
    name = input(\"Enter your name or enter 'X' to exit: \")
    if name == \"X\" or name == \"x\":
        return {}
    else:
        order[\"name\"] = name
    drinks = read_menu(\"drinks.txt\")
    flavors = read_menu(\"flavors.txt\")
    toppings = read_menu(\"toppings.txt\")
    order[\"drink\"] = menu(drinks, \"Erik's drinks\", \"Choose your drink: \")
    order[\"flavor\"] = menu(flavors, \"Erik's flavors\", \"Choose your flavor: \")
    order[\"topping\"] = menu(toppings, \"Erik's toppings\", \"Choose your topping: \")
    return order

def print_order(order):
    print(\"Here is your order,\", order[\"name\"])
    print(\"Main product:\", order[\"drink\"])
    print(\"Flavor:\", order[\"flavor\"])
    print(\"Topping:\", order[\"topping\"])
    print(\"Thanks for your order!\")
    return

def save_orders(orders, filename):
    f = open(filename, \"w\")
    json.dump(orders, f, indent=4)
    return

def load_orders(filename):
    if os.path.exists(filename):
        f = open(filename, \"r\")
        orders = json.load(f)
        return orders
    else:
        return []

orders = load_orders(\"orders.json\")
main_menu(orders)
save_orders(orders, \"orders.json\")
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file written"
    set_color normal
    cat $output_file
end

function algoP.Basic.dicts_loops
    set output_file "dicts_loops_examples.py"
    set template_content '#!/usr/bin/env python3

# ---------------------
# СТАТИСТИКА ПІДСМІНКИ МОНЕТИ
# ---------------------
import random

heads = 0
for i in range(1, 1001):
    if random.randint(0, 1) == 1:
        heads += 1
    if i == 500:
        print("Halfway done!")
print(f"Heads came up {heads} times.")

# ---------------------
# ПІДРАХУНОК СИМВОЛІВ У РЯДКУ
# ---------------------
message = "It was a bright cold day in April, and the clocks were striking thirteen."
count = {}

for character in message:
    count.setdefault(character, 0)
    count[character] += 1

print(count)

# ---------------------
# ЛОГУВАННЯ ФАКТОРІАЛУ
# ---------------------
import logging

logging.basicConfig(level=logging.DEBUG, format="%(asctime)s - %(levelname)s - %(message)s")
logging.debug("Start of program")

def factorial(n):
    logging.debug(f"Start of factorial({n})")
    total = 1
    for i in range(1, n + 1):
        total *= i
        logging.debug(f"i is {i}, total is {total}")
    logging.debug(f"End of factorial({n})")
    return total

print(factorial(5))
logging.debug("End of program")

# ---------------------
# СЛОВНИКИ І ЦИКЛИ
# ---------------------
favorite_languages = {
    "jen": "python",
    "sarah": "c",
    "edward": "ruby",
    "phil": "python",
}
friends = ["phil", "sarah"]

for name in favorite_languages.keys():
    print(name.title())
    if name in friends:
        print(f" Hi {name.title()}, I see your favorite language is {favorite_languages[name].title()}!")

# Вивід відсортованих ключів
for name in sorted(favorite_languages.keys()):
    print(f"{name.title()}, thank you for taking the poll.")

# Унікальні мови
print("The following languages have been mentioned:")
for language in set(favorite_languages.values()):
    print(language.title())

# Словник зі списками мов
favorite_languages_multi = {
    "jen": ["python", "ruby"],
    "sarah": ["c"],
    "edward": ["ruby", "go"],
    "phil": ["python", "haskell"],
}
for name, languages in favorite_languages_multi.items():
    print(f"\n{name.title()}'s favorite languages are:")
    for language in languages:
        print(f"\t{language.title()}")

# ---------------------
# OrderedDict
# ---------------------
from collections import OrderedDict

favorite_languages_ordered = OrderedDict()
favorite_languages_ordered["jen"] = "python"
favorite_languages_ordered["sarah"] = "c"
favorite_languages_ordered["edward"] = "ruby"
favorite_languages_ordered["phil"] = "python"

for name, language in favorite_languages_ordered.items():
    print(f"{name.title()}'s favorite language is {language.title()}.")

# ---------------------
# Сумісні пари дівчат і хлопців
# ---------------------
girls = ["alice", "bernice", "clarice"]
boys = ["chris", "arnold", "bob"]
letterGirls = {}
for girl in girls:
    letterGirls.setdefault(girl[0], []).append(girl)

print([b+"+"+g for b in boys for g in letterGirls[b[0]]])

# ---------------------
# ІНВЕНТАР
# ---------------------
stuff = {"rope": 1, "torch": 6, "gold coin": 42, "dagger": 1, "arrow": 12}
inv = {"gold coin": 42, "rope": 1}
dragonLoot = ["gold coin", "dagger", "gold coin", "gold coin", "ruby"]

def displayInventory(inventory):
    print("Inventory:")
    item_total = 0
    for k, v in inventory.items():
        print(f"{v} {k}")
        item_total += v
    print(f"Total number of items: {item_total}")

def addToInventory(inventory, addedItems):
    for item in addedItems:
        inventory[item] = inventory.get(item, 0) + 1
    return inventory

inv = addToInventory(inv, dragonLoot)
displayInventory(inv)
displayInventory(stuff)
'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Basic.misc
    set output_file "misc_examples.py"

    set template_content '#!/usr/bin/env python3

# --------------
user_start = int(input())
user_end = int(input())
branch = input()
users = ["%.3d" % u for u in range(user_start, user_end)]
for user in users:
    print("user_id is 16/" + branch + "/" + str(user))
    print("password is 16/" + branch + "/" + str(user))


# --------------
import time
startTime = time.time()
product = 1
for i in range(1, 100000):
    product *= i
endTime = time.time()
print("The result is %s digits long." % len(str(product)))
print("Took %s seconds to calculate." % (endTime - startTime))


# --------------
cars = ["audi", "bmw", "subaru", "toyota"]

for car in cars:
    if car == "bmw":
        print(car.upper())
    else:
        print(car.title())


# --------------
catNames = []
while True:
    print("Enter the name of cat " + str(len(catNames) + 1) + " (Or enter nothing to stop.):")
    name = input()
    if name == "":
        break
    catNames.append(name)

print("The cat names are:")
for name in catNames:
    print("  " + name)


# --------------
for i in range(4):
    print(i)

for i in [0, 1, 2, 3]:
    print(i)

supplies = ["pens", "staplers", "flame-throwers", "binders"]
for i in range(len(supplies)):
    print("Index " + str(i) + " in supplies is: " + supplies[i])

spam = ["hello", "hi", "howdy", "heyas"]
print("howdy" in spam)
print("cat" in spam)
print("howdy" not in spam)
print("cat" not in spam)


# --------------
name = "Zophie"
print(name[0])
print(name[-2])
print(name[0:4])
print("Zo" in name)
print("z" in name)
print("p" not in name)

for i in name:
    print("* * * " + i + " * * *")


# --------------
spam = {"color": "red", "age": 30}

for v in spam.values():
    print(v)

for k in spam.keys():
    print(k)

for i in spam.items():
    print(i)

print("-----")
print(spam.keys())
print(list(spam.keys()))

for k, v in spam.items():
    print("Key: " + k + " Value: " + str(v))


# --------------
allGuests = {
    "Alice": {"apples": 5, "pretzels": 12},
    "Bob": {"ham sandwiches": 3, "apples": 2},
    "Carol": {"cups": 3, "apple pies": 1}
}

def totalBrought(guests, item):
    numBrought = 0
    for _, v in guests.items():
        numBrought += v.get(item, 0)
    return numBrought

print("Number of things being brought:")
print(" - Apples         " + str(totalBrought(allGuests, "apples")))
print(" - Cups           " + str(totalBrought(allGuests, "cups")))
print(" - Cakes          " + str(totalBrought(allGuests, "cakes")))
print(" - Ham Sandwiches " + str(totalBrought(allGuests, "ham sandwiches")))
print(" - Apple Pies     " + str(totalBrought(allGuests, "apple pies")))


# --------------
def printPicnic(itemsDict, leftWidth, rightWidth):
    print("PICNIC ITEMS".center(leftWidth + rightWidth, "-"))
    for k, v in itemsDict.items():
        print(k.ljust(leftWidth, ".") + str(v).rjust(rightWidth))

picnicItems = {"sandwiches": 4, "apples": 12, "cups": 4, "cookies": 8000}
printPicnic(picnicItems, 12, 5)
printPicnic(picnicItems, 20, 6)

spam = "    Hello World     "
print(spam.strip())
print(spam.lstrip())
print(spam.rstrip())

spam = "SpamSpamBaconSpamEggsSpamSpam"
print(spam.strip("ampS"))


# --------------
def isPhoneNumber(text):
    if len(text) != 12:
        return False
    for i in range(0, 3):
        if not text[i].isdecimal():
            return False
    if text[3] != "-":
        return False
    for i in range(4, 7):
        if not text[i].isdecimal():
            return False
    if text[7] != "-":
        return False
    for i in range(8, 12):
        if not text[i].isdecimal():
            return False
    return True

message = "Call me at 415-555-1011 tomorrow. 415-555-9999 is my office."
for i in range(len(message)):
    chunk = message[i:i+12]
    if isPhoneNumber(chunk):
        print("Phone number found: " + chunk)
print("Done")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end


function algoP.Basic.lists_dicts1
    set output_file "lists_dicts.py"
    set template_content '#!/usr/bin/env python3

# --------
aliens = []

# Make 30 green aliens.
for alien_number in range(30):
    new_alien = {"color": "green", "points": 5, "speed": "slow"}
    aliens.append(new_alien)
    
for alien in aliens[0:3]:
    if alien["color"] == "green":
        alien["color"] = "FFAD8D"
        alien["speed"] = "medium"
        alien["points"] = 10
    elif alien["color"] == "yellow":
        alien["color"] = "red"
        alien["speed"] = "fast"
        alien["points"] = 15
        
# Show the first 5 aliens:
for alien in aliens[0:5]:
    print(alien)
print("...")


# --------
alien_0 = {"color": "green", "points": 5}
alien_1 = {"color": "yellow", "points": 10}
alien_2 = {"color": "red", "points": 15}
aliens = [alien_0, alien_1, alien_2]
for alien in aliens:
    print(alien)


# --------
# Make an empty list for storing aliens.
aliens = []
# Make 30 green aliens.
for alien_number in range(30):
   new_alien = {"color": "green", "points": 5, "speed": "slow"}
   aliens.append(new_alien)

# Show the first 5 aliens:
for alien in aliens[:5]:
   print(alien)
print("...")
# Show how many aliens have been created.
print("Total number of aliens: " + str(len(aliens)))


# --------
# Make an empty list for storing aliens.
aliens = []
# Make 30 green aliens.
for alien_number in range(30):
   new_alien = {"color": "green", "points": 5, "speed": "slow"}
   aliens.append(new_alien)

for alien in aliens[0:3]:
    if alien["color"] == "green":
       alien["color"] = "yellow"
       alien["speed"] = "medium"
       alien["points"] = 10

# Show the first 5 aliens:
for alien in aliens[0:5]:
    print(alien)
print("...")


# --------
# Start with empty list
catNames = []

# While loop
while True:
    print("Enter the name of cat " + str(len(catNames) + 1) + " (Or enter nothing to stop.):")
    name = input()
    if name == "":
        break
    catNames.append(name)  # use append instead of concatenation
print("The cat names are:")
for name in catNames:
    print("  " + name)


# --------
birthdays = {"Alice": "Apr 1", "Bob": "Dec 12", "Carol": "Mar 4"}

while True:
    print("Enter a name: (blank to quit)")
    name = input()
    if name == "":
        break

    if name in birthdays:
        print(birthdays[name] + " is the birthday of " + name)
    else:
        print("I do not have birthday information for " + name)
        print("What is their birthday?")
        bday = input()
        birthdays[name] = bday
        print("Birthday database updated.")
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "File written: $output_file"
    set_color normal
    cat $output_file
end





function algoP.NumberofIslands.DepthFirstSearch
    set output_file "num_islands_dfs.go"

    set template_content "package main

import \"fmt\"

func numIslandsDFS(grid [][]byte) int {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])
    islands := 0

    var dfs func(r, c int)
    dfs = func(r, c int) {
        if r < 0 || c < 0 || r >= rows || c >= cols || grid[r][c] == '0' {
            return
        }
        grid[r][c] = '0'
        directions := [][]int{{1,0},{-1,0},{0,1},{0,-1}}
        for _, d := range directions {
            dfs(r + d[0], c + d[1])
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
    fmt.Println(\"Number of islands:\", numIslandsDFS(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberofIslands.BreadthFirstSearch
    set output_file "num_islands_bfs.go"

    set template_content "package main

import (
    \"container/list\"
    \"fmt\"
)

func numIslandsBFS(grid [][]byte) int {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])
    islands := 0
    directions := [][]int{{1,0},{-1,0},{0,1},{0,-1}}

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == '1' {
                islands++
                grid[r][c] = '0'
                q := list.New()
                q.PushBack([2]int{r, c})

                for q.Len() > 0 {
                    e := q.Front()
                    pos := e.Value.([2]int)
                    q.Remove(e)
                    for _, d := range directions {
                        nr, nc := pos[0]+d[0], pos[1]+d[1]
                        if nr < 0 || nc < 0 || nr >= rows || nc >= cols || grid[nr][nc] == '0' {
                            continue
                        }
                        grid[nr][nc] = '0'
                        q.PushBack([2]int{nr, nc})
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
    fmt.Println(\"Number of islands:\", numIslandsBFS(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberofIslands.DisjointSetUnion
    set output_file "num_islands_dsu.go"

    set template_content "package main

import \"fmt\"

type DSU struct {
    parent []int
    size   []int
}

func NewDSU(n int) *DSU {
    parent := make([]int, n)
    size := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
        size[i] = 1
    }
    return &DSU{parent, size}
}

func (d *DSU) Find(x int) int {
    if d.parent[x] != x {
        d.parent[x] = d.Find(d.parent[x])
    }
    return d.parent[x]
}

func (d *DSU) Union(x, y int) bool {
    px, py := d.Find(x), d.Find(y)
    if px == py {
        return false
    }
    if d.size[px] >= d.size[py] {
        d.size[px] += d.size[py]
        d.parent[py] = px
    } else {
        d.size[py] += d.size[px]
        d.parent[px] = py
    }
    return true
}

func numIslandsDSU(grid [][]byte) int {
    rows, cols := len(grid), len(grid[0])
    dsu := NewDSU(rows * cols)
    directions := [][2]int{{1,0},{-1,0},{0,1},{0,-1}}
    islands := 0

    index := func(r, c int) int {
        return r*cols + c
    }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == '1' {
                islands++
                for _, d := range directions {
                    nr, nc := r+d[0], c+d[1]
                    if nr < 0 || nc < 0 || nr >= rows || nc >= cols || grid[nr][nc] == '0' {
                        continue
                    }
                    if dsu.Union(index(r, c), index(nr, nc)) {
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
    fmt.Println(\"Number of islands:\", numIslandsDSU(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaxAreaofIsland.DepthFirstSearch
    set output_file "max_area_island_dfs.go"

    set template_content "package main

import \"fmt\"

func maxAreaOfIslandDFS(grid [][]int) int {
    rows := len(grid)
    if rows == 0 {
        return 0
    }
    cols := len(grid[0])
    visit := make(map[[2]int]bool)
    directions := [][]int{{1,0},{-1,0},{0,1},{0,-1}}

    var dfs func(r, c int) int
    dfs = func(r, c int) int {
        if r < 0 || c < 0 || r >= rows || c >= cols || grid[r][c] == 0 || visit[[2]int{r, c}] {
            return 0
        }
        visit[[2]int{r, c}] = true
        area := 1
        for _, d := range directions {
            area += dfs(r+d[0], c+d[1])
        }
        return area
    }

    maxArea := 0
    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 && !visit[[2]int{r, c}] {
                maxArea = max(maxArea, dfs(r, c))
            }
        }
    }
    return maxArea
}

func max(a, b int) int {
    if a > b { return a }
    return b
}

func main() {
    grid := [][]int{
        {0,1,0,0,1},
        {1,1,0,0,0},
        {0,0,1,1,0},
        {0,0,0,1,1},
    }
    fmt.Println(\"Max area of island:\", maxAreaOfIslandDFS(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxAreaofIsland.BreadthFirstSearch
    set output_file "max_area_island_bfs.go"

    set template_content "package main

import (
    \"container/list\"
    \"fmt\"
)

func maxAreaOfIslandBFS(grid [][]int) int {
    rows := len(grid)
    if rows == 0 { return 0 }
    cols := len(grid[0])
    directions := [][]int{{1,0},{-1,0},{0,1},{0,-1}}
    maxArea := 0

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                area := 1
                grid[r][c] = 0
                q := list.New()
                q.PushBack([2]int{r, c})

                for q.Len() > 0 {
                    e := q.Front()
                    pos := e.Value.([2]int)
                    q.Remove(e)
                    for _, d := range directions {
                        nr, nc := pos[0]+d[0], pos[1]+d[1]
                        if nr < 0 || nc < 0 || nr >= rows || nc >= cols || grid[nr][nc] == 0 {
                            continue
                        }
                        grid[nr][nc] = 0
                        area++
                        q.PushBack([2]int{nr, nc})
                    }
                }
                if area > maxArea {
                    maxArea = area
                }
            }
        }
    }
    return maxArea
}

func main() {
    grid := [][]int{
        {0,1,0,0,1},
        {1,1,0,0,0},
        {0,0,1,1,0},
        {0,0,0,1,1},
    }
    fmt.Println(\"Max area of island:\", maxAreaOfIslandBFS(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaxAreaofIsland.DisjointSetUnion
    set output_file "max_area_island_dsu.go"

    set template_content "package main

import \"fmt\"

type DSU struct {
    parent []int
    size   []int
}

func NewDSU(n int) *DSU {
    parent := make([]int, n)
    size := make([]int, n)
    for i := 0; i < n; i++ {
        parent[i] = i
        size[i] = 1
    }
    return &DSU{parent, size}
}

func (d *DSU) Find(x int) int {
    if d.parent[x] != x {
        d.parent[x] = d.Find(d.parent[x])
    }
    return d.parent[x]
}

func (d *DSU) Union(x, y int) bool {
    px, py := d.Find(x), d.Find(y)
    if px == py { return false }
    if d.size[px] >= d.size[py] {
        d.size[px] += d.size[py]
        d.parent[py] = px
    } else {
        d.size[py] += d.size[px]
        d.parent[px] = py
    }
    return true
}

func (d *DSU) GetSize(x int) int {
    return d.size[d.Find(x)]
}

func maxAreaOfIslandDSU(grid [][]int) int {
    rows, cols := len(grid), len(grid[0])
    dsu := NewDSU(rows * cols)
    directions := [][2]int{{1,0},{-1,0},{0,1},{0,-1}}
    maxArea := 0

    index := func(r, c int) int { return r*cols + c }

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if grid[r][c] == 1 {
                for _, d := range directions {
                    nr, nc := r+d[0], c+d[1]
                    if nr < 0 || nc < 0 || nr >= rows || nc >= cols || grid[nr][nc] == 0 {
                        continue
                    }
                    dsu.Union(index(r,c), index(nr,nc))
                }
                if dsu.GetSize(index(r,c)) > maxArea {
                    maxArea = dsu.GetSize(index(r,c))
                }
            }
        }
    }
    return maxArea
}

func main() {
    grid := [][]int{
        {0,1,0,0,1},
        {1,1,0,0,0},
        {0,0,1,1,0},
        {0,0,0,1,1},
    }
    fmt.Println(\"Max area of island:\", maxAreaOfIslandDSU(grid))
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

