function algoJS.ContainsDuplicate.BruteForce
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @return {boolean}
     */
    hasDuplicate(nums) {
        for (let i = 0; i < nums.length; i++) {
            for (let j = i + 1; j < nums.length; j++) {
                if (nums[i] === nums[j]) {
                    return true;
                }
            }
        }
        return false;
    }
}

const sol = new Solution();

const examples = [
    [1, 2, 3, 4],
    [1, 2, 3, 1],
    [],
    [5],
    [0, 0],
    [10, -1, 2, 3, -1],
];

for (const arr of examples) {
    console.log(arr, "->", sol.hasDuplicate(arr));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.ContainsDuplicate.Sorting
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @return {boolean}
     */
    hasDuplicate(nums) {
        nums.sort((a, b) => a - b);
        for (let i = 1; i < nums.length; i++) {
            if (nums[i] === nums[i - 1]) {
                return true;
            }
        }
        return false;
    }
}

const sol = new Solution();

const examples = [
    [1, 2, 3, 4],
    [1, 2, 3, 1],
    [],
    [5],
    [0, 0],
    [10, -1, 2, 3, -1],
];

for (const arr of examples) {
    console.log(arr, "->", sol.hasDuplicate(arr));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.ContainsDuplicate.HashSet
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @return {boolean}
     */
    hasDuplicate(nums) {
        const seen = new Set();
        for (const num of nums) {
            if (seen.has(num)) {
                return true;
            }
            seen.add(num);
        }
        return false;
    }
}

const sol = new Solution();

const examples = [
    [1, 2, 3, 4],
    [1, 2, 3, 1],
    [],
    [5],
    [0, 0],
    [10, -1, 2, 3, -1],
];

for (const arr of examples) {
    console.log(arr, "->", sol.hasDuplicate(arr));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.ContainsDuplicate.HashSet_Length
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @return {boolean}
     */
    hasDuplicate(nums) {
        return new Set(nums).size < nums.length;
    }
}

const sol = new Solution();

const examples = [
    [1, 2, 3, 4],
    [1, 2, 3, 1],
    [],
    [5],
    [0, 0],
    [10, -1, 2, 3, -1],
];

for (const arr of examples) {
    console.log(arr, "->", sol.hasDuplicate(arr));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.ValidAnagram.Sorting
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {string} s
     * @param {string} t
     * @return {boolean}
     */
    isAnagram(s, t) {
        if (s.length !== t.length) {
            return false;
        }

        let sSort = s.split('').sort().join();
        let tSort = t.split('').sort().join();
        return sSort == tSort;
    }
}

const sol = new Solution();

const examples = [
    ["anagram", "nagaram"], // true
    ["rat", "car"],         // false
    ["a", "a"],             // true
    ["ab", "ba"],           // true
    ["abc", "ab"],          // false
    ["", ""],               // true
];

for (const [s, t] of examples) {
    console.log(`"${s}", "${t}" ->`, sol.isAnagram(s, t));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.ValidAnagram.HashMap
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {string} s
     * @param {string} t
     * @return {boolean}
     */
    isAnagram(s, t) {
        if (s.length !== t.length) {
            return false;
        }

        const countS = {};
        const countT = {};
        for (let i = 0; i < s.length; i++) {
            countS[s[i]] = (countS[s[i]] || 0) + 1;
            countT[t[i]] = (countT[t[i]] || 0) + 1;
        }

        for (const key in countS) {
            if (countS[key] !== countT[key]) {
                return false;
            }
        }
        return true;
    }
}

const sol = new Solution();

const examples = [
    ["anagram", "nagaram"], // true
    ["rat", "car"],         // false
    ["a", "a"],             // true
    ["ab", "ba"],           // true
    ["abc", "ab"],          // false
    ["", ""],               // true
];

for (const [s, t] of examples) {
    console.log(`"${s}", "${t}" ->`, sol.isAnagram(s, t));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.ValidAnagram.HashTable_UsingArray
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {string} s
     * @param {string} t
     * @return {boolean}
     */
    isAnagram(s, t) {
        if (s.length !== t.length) {
            return false;
        }

        const count = new Array(26).fill(0);
        for (let i = 0; i < s.length; i++) {
            count[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
            count[t.charCodeAt(i) - 'a'.charCodeAt(0)]--;
        }
        return count.every((val) => val === 0);
    }
}

const sol = new Solution();

const examples = [
    ["anagram", "nagaram"], // true
    ["rat", "car"],         // false
    ["a", "a"],             // true
    ["ab", "ba"],           // true
    ["abc", "ab"],          // false
    ["", ""],               // true
];

for (const [s, t] of examples) {
    console.log(`"${s}", "${t}" ->`, sol.isAnagram(s, t));
}
'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoJS.TwoSum.BruteForce
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @param {number} target
     * @return {number[]}
     */
    twoSum(nums, target) {
        for (let i = 0; i < nums.length; i++) {
            for (let j = i + 1; j < nums.length; j++) {
                if (nums[i] + nums[j] === target) {
                    return [i, j];
                }
            }
        }
        return [];
    }
}

const sol = new Solution();

const examples = [
    { nums: [2, 7, 11, 15], target: 9 },   // [0,1]
    { nums: [3, 2, 4], target: 6 },        // [1,2]
    { nums: [3, 3], target: 6 },           // [0,1]
    { nums: [1, 2, 3], target: 7 },        // []
    { nums: [], target: 0 },               // []
];

for (const { nums, target } of examples) {
    console.log(nums, target, "->", sol.twoSum(nums, target));
}

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.TwoSum.Sorting
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @param {number} target
     * @return {number[]}
     */
    twoSum(nums, target) {
        let A = [];
        for (let i = 0; i < nums.length; i++) {
            A.push([nums[i], i]);
        }

        A.sort((a, b) => a[0] - b[0]);

        let i = 0,
            j = nums.length - 1;
        while (i < j) {
            let cur = A[i][0] + A[j][0];
            if (cur === target) {
                return [Math.min(A[i][1], A[j][1]), Math.max(A[i][1], A[j][1])];
            } else if (cur < target) {
                i++;
            } else {
                j--;
            }
        }
        return [];
    }
}

const sol = new Solution();

const examples = [
    { nums: [2, 7, 11, 15], target: 9 },   // [0,1]
    { nums: [3, 2, 4], target: 6 },        // [1,2]
    { nums: [3, 3], target: 6 },           // [0,1]
    { nums: [1, 2, 3], target: 7 },        // []
    { nums: [], target: 0 },               // []
];

for (const { nums, target } of examples) {
    console.log(nums, target, "->", sol.twoSum(nums, target));
}

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.TwoSum.HashMap_TwoPass
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @param {number} target
     * @return {number[]}
     */
    twoSum(nums, target) {
        const indices = {}; // val -> index

        for (let i = 0; i < nums.length; i++) {
            indices[nums[i]] = i;
        }

        for (let i = 0; i < nums.length; i++) {
            let diff = target - nums[i];
            if (indices[diff] !== undefined && indices[diff] !== i) {
                return [i, indices[diff]];
            }
        }

        return [];
    }
}

const sol = new Solution();

const examples = [
    { nums: [2, 7, 11, 15], target: 9 },   // [0,1]
    { nums: [3, 2, 4], target: 6 },        // [1,2]
    { nums: [3, 3], target: 6 },           // [0,1]
    { nums: [1, 2, 3], target: 7 },        // []
    { nums: [], target: 0 },               // []
];

for (const { nums, target } of examples) {
    console.log(nums, target, "->", sol.twoSum(nums, target));
}

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.TwoSum.HashMap_OnePass
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {number[]} nums
     * @param {number} target
     * @return {number[]}
     */
    twoSum(nums, target) {
        const prevMap = new Map();

        for (let i = 0; i < nums.length; i++) {
            const diff = target - nums[i];
            if (prevMap.has(diff)) {
                return [prevMap.get(diff), i];
            }

            prevMap.set(nums[i], i);
        }

        return [];
    }
}

const sol = new Solution();

const examples = [
    { nums: [2, 7, 11, 15], target: 9 },   // [0,1]
    { nums: [3, 2, 4], target: 6 },        // [1,2]
    { nums: [3, 3], target: 6 },           // [0,1]
    { nums: [1, 2, 3], target: 7 },        // []
    { nums: [], target: 0 },               // []
];

for (const { nums, target } of examples) {
    console.log(nums, target, "->", sol.twoSum(nums, target));
}

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.GroupAnagrams.Sorting
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {string[]} strs
     * @return {string[][]}
     */
    groupAnagrams(strs) {
        const res = {};
        for (let s of strs) {
            const sortedS = s.split('').sort().join('');
            if (!res[sortedS]) {
                res[sortedS] = [];
            }
            res[sortedS].push(s);
        }
        return Object.values(res);
    }
}

const sol = new Solution();

const examples = [
    ["eat","tea","tan","ate","nat","bat"],
    [""],
    ["a"],
    ["ab","ba","abc","cab","bca"],
    [],
];

for (const arr of examples) {
    console.log(JSON.stringify(arr), "->", sol.groupAnagrams(arr));
}

'
    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.GroupAnagrams.HashTable
    set output_file "main.js"

    set template_content '
class Solution {
    /**
     * @param {string[]} strs
     * @return {string[][]}
     */
    groupAnagrams(strs) {
        const res = {};
        for (let s of strs) {
            const count = new Array(26).fill(0);
            for (let c of s) {
                count[c.charCodeAt(0) - 'a'.charCodeAt(0)] += 1;
            }
            const key = count.join(',');
            if (!res[key]) {
                res[key] = [];
            }
            res[key].push(s);
        }
        return Object.values(res);
    }
}

const sol = new Solution();

const examples = [
    ["eat","tea","tan","ate","nat","bat"],
    [""],
    ["a"],
    ["ab","ba","abc","cab","bca"],
    [],
];

for (const arr of examples) {
    console.log(JSON.stringify(arr), "->", sol.groupAnagrams(arr));
}

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoJS.
    set output_file "main.js"

    set template_content '

'

    echo "$template_content" > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end