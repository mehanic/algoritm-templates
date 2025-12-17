function algoG.Basic.For
    set output_file "basic_loops_examples.go"

    set template_content "package main

import (
    \"fmt\"
    \"math\"
    // \"golang.org/x/exp/vector\" // раніше для векторів, якщо потрібно
)

func main() {
    // --- Example 1: Fill array ---
    n := 5
    numbers := [10]int{}
    fmt.Println(numbers)
    for i := 0; i < n; i++ {
        numbers[i] = 5
    }
    fmt.Println(numbers)

    // --- Example 2: Sum of prime digits ---
    num := 12357
    sum := 0
    for numCopy := num; numCopy > 0; {
        number := numCopy % 10
        count := 0
        for i := 2; i <= number; i++ {
            if number%i == 0 {
                count++
            }
        }
        if count == 1 {
            sum += number
        }
        numCopy /= 10
    }
    fmt.Println(\"Sum of prime digits:\", sum)

    // --- Example 3: Perfect numbers up to limit ---
    limit := 100
    for i := 1; i <= limit; i++ {
        sumDiv := 0
        for j := 1; j < i; j++ {
            if i%j == 0 {
                sumDiv += j
            }
        }
        if sumDiv == i {
            fmt.Println(\"Perfect number:\", i)
        }
    }

    // --- Example 4: Right-aligned triangle ---
    nTriangle := 30
    str := \"\"
    for i := 1; i <= nTriangle; i++ {
        for j := nTriangle; j >= 1; j-- {
            if i >= j {
                str += \" * \"
            } else {
                str += \"   \"
            }
        }
        str += \"\\n\"
    }
    fmt.Println(str)

    // --- Example 5: Loop types ---
    // 1. C-style
    for i := 0; i < 10; i++ {
        if i == 5 {
            continue
        }
        fmt.Println(i)
    }

    // 2. Only condition
    i := 0.0
    for i < 10 {
        fmt.Println(i)
        i++
    }

    // 3. Infinity loop
    iInt := 0
    for {
        fmt.Println(\"Infinity loop....\")
        if iInt > 10 {
            break
        }
        iInt++
    }

    // --- Example 6: Palindrome check ---
    number := 123454321
    summer := 0
    numClone := number
    for numberCopy := number; numberCopy > 0; {
        summer = summer*10 + numberCopy%10
        numberCopy /= 10
    }
    if summer == numClone {
        fmt.Println(\"Palindrome\")
    } else {
        fmt.Println(\"Not Palindrome\")
    }

    // --- Example 7: First N primes ---
    primeCount := 10
    numberPrime := 2
    for primeCount > 0 {
        isPrime := true
        for i := 2; i < numberPrime; i++ {
            if numberPrime%i == 0 {
                isPrime = false
                break
            }
        }
        if isPrime {
            fmt.Print(numberPrime, \" \")
            primeCount--
        }
        numberPrime++
    }
    fmt.Println()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Basic.For1
    set output_file "basic_tutorial.go"

    set template_content "package main

import (
    \"fmt\"
)

const constWidth int = 320

func main() {
    // Константы
    fmt.Println(\"Width =\", constWidth)
    // Функций
    fmt.Println(test())
    fmt.Println(test2())
    s, s2 := test()
    fmt.Println(s, s2)
    fmt.Println(test3())
    fmt.Println(test4())
    // Циклы
    sum := 0
    for i := 0; i < 10; i++ {
        sum += i
    }
    fmt.Println(\"func num\")
    fmt.Println(\"sum = 45 — потому что ты складываешь числа от 0 до 9.\", sum)

    sum2 := 0
    for sum2 < 100 {
        sum2 += 10
    }
    fmt.Println(\"func 2\")
    fmt.Println(\"sum2 =\", sum2)

    sum3 := 0
    for sum3 < 10 {
        sum3 += 10
    }
    fmt.Println(\"func 3\")
    fmt.Println(\"sum3 =\", sum3)
    fmt.Println(\"--------------------------------------------\")

    // Ветвления
    a := 0
    for a < 10 {
        if a == 10 {
            fmt.Println(\"a is 10\")
        } else {
            fmt.Println(fmt.Sprintf(\"a is not 10. a=%d\", a))
        }
        a++
    }

    fmt.Println(\"stack LIFO\")
    defer fmt.Println(\"1\")
    defer fmt.Println(\"2\")
    defer fmt.Println(\"3\")
    fmt.Println(\"!!! Отложенное выполнения операций !!!\")
}

// Функций
func test() (string, string) {
    a := \"hello\"
    b := \"world!\"
    return a, b
}

func test2() string {
    return \"hello world!!\"
}

func test3() (a, b string) {
    a = \"hello\"
    b = \"world!!!\"
    return a, b
}

func test4() (a, b int) {
    a = 1
    b = 3
    return a, b
}

// Циклы
func isTest(a int) int {
    if a == 2 {
        return 1
    } else if a == 3 {
        return 2
    }
    return 3
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Go.ArraysLoops
    set output_file "arrays_loops.go"

    set template_content "package main

import (
    \"fmt\"
    \"golang.org/x/text/cases\"
)

func main() {
    // ===== Example 1: break =====
    numbers := [...]int{1, 2, 3, 4, 5, 7, 8, 12323}
    n := len(numbers)
    fmt.Println(numbers)
    for i := 0; i < n; i++ {
        if i == 2 { break }
        numbers[i] = numbers[i] * 2
    }
    fmt.Println(numbers)

    // ===== Example 2: continue =====
    numbers = [...]int{1, 2, 3, 4, 5, 7, 8, 12323}
    fmt.Println(numbers)
    for i := 0; i < n; i++ {
        if i == 2 { continue }
        numbers[i] = numbers[i] * 2
    }
    fmt.Println(numbers)

    // ===== Example 3: conditional =====
    numbers = [...]int{1, 2, 3, 4, 5, 7, 8, 12323}
    for i := 0; i < n; i++ {
        if i != 2 {
            numbers[i] = numbers[i] * 2
        }
    }
    fmt.Println(numbers)

    // ===== Example 4: array vs slice =====
    numbers = [...]int{10, 8, 1, 2, 3, 45, 12, 20}
    var leftPart [10]int
    j := 0
    for i := 0; i < len(numbers)/2; i++ {
        leftPart[j] = numbers[i]
        j++
    }
    fmt.Println(leftPart)

    var leftSlice []int
    for i := 0; i < len(numbers)/2; i++ {
        leftSlice = append(leftSlice, numbers[i])
    }
    fmt.Println(leftSlice)

    // ===== Example 5: sum =====
    sumi := 0
    for i := 0; i < len(numbers); i++ {
        sumi += numbers[i]
    }
    fmt.Println(\"Sum:\", sumi)

    // ===== Example 6: slice of strings =====
    magicians := []string{\"alice\", \"david\", \"carolina\"}
    for _, magician := range magicians {
        formattedName := cases.Title(magician)
        fmt.Printf(\"%s, that was a great trick!\\n\", formattedName)
        fmt.Printf(\"I can't wait to see your next trick, %s,\\n\\n\", formattedName)
    }
    fmt.Println(\"Thank you, everyone. That was a great magic show!\")

    // ===== Example 7: pets =====
    myPets := []string{\"Zophie\", \"Pooka\", \"Fat-tail\"}
    fmt.Println(myPets)
    a, b, c := myPets[0], myPets[1], myPets[2]
    for _, pet := range []string{a, b, c} {
        fmt.Println(pet)
    }

    // ===== Example 8: for loop variations =====
    i := 1
    for i <= 3 {
        fmt.Println(i)
        i++
    }
    for j := 7; j <= 9; j++ {
        fmt.Println(j)
    }
    for { fmt.Println(\"loop\"); break }
    for n := 0; n <= 5; n++ {
        if n%2 == 0 { continue }
        fmt.Println(n)
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Basic.for3
    set output_file "loops_examples.go"

    set template_content "package main

import (
    \"fmt\"
    \"math/big\"
    \"time\"
)

func main() {
    // ===== Example 1: simple increment =====
    sumi := 5
    fmt.Println(\"start cycle\")
    for i := 0; i < 5; i++ {
        fmt.Println(\"i=\", i)
        fmt.Println(\"before sumi=\", sumi)
        sumi += 1
        fmt.Println(\"after sumi=\", sumi)
        fmt.Println()
    }
    fmt.Println(\"end cycle\")
    fmt.Println(sumi)

    // ===== Example 2: for with multiple conditions =====
    for i := 0; i < 10; i++ {
        fmt.Println(i)
    }
    sum := 0
    for sum < 1000 {
        sum += 100
    }
    fmt.Println(sum)
    k := 0
    for k < 100 {
        k += 10
        fmt.Println(k)
    }

    // ===== Example 3: array assignment =====
    n := 5
    numbers := [10]int{}
    fmt.Println(numbers)
    for i := 0; i < n; i++ {
        numbers[i] = 5
    }
    fmt.Println(numbers)

    // ===== Example 4: runes =====
    fmt.Println()
    for i := 0; i < 128; i++ {
        fmt.Printf(\"%q \", i)
    }
    fmt.Println()
    fmt.Println(\"rune is alias of int32\")
    xr := []rune{'a', 'b', 'c'}
    for _, r := range xr {
        fmt.Printf(\"%q\\t%v\\n\", r, r)
    }
    fmt.Println()

    // ===== Example 5: break =====
    i := 0
    for {
        fmt.Println(i)
        if i >= 10 { break }
        i++
    }

    // ===== Example 6: big.Int product =====
    startTime := time.Now()
    product := new(big.Int).SetInt64(1)
    for i := int64(1); i < 100000; i++ {
        product.Mul(product, big.NewInt(i))
    }
    endTime := time.Now()
    duration := endTime.Sub(startTime)
    productStr := product.String()
    numDigits := len(productStr)
    fmt.Printf(\"The result is %d digits long.\\n\", numDigits)
    fmt.Printf(\"Took %s seconds to calculate.\\n\", duration)

    // ===== Example 7: char codes =====
    for i := 250; i <= 340; i++ {
        fmt.Println(i, \" - \", string(i), \" - \", []byte(string(i)))
    }
    foo := \"a\"
    fmt.Println(foo)
    fmt.Printf(\"%T \\n\", foo)

    for i := 50; i <= 140; i++ {
        fmt.Printf(\"%v - %v - %v \\n\", i, string(i), []byte(string(i)))
    }

    // ===== Example 8: continue and break =====
    i = 0
    for {
        i++
        if i%2 == 0 { continue }
        fmt.Println(i)
        if i >= 50 { break }
    }
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Basic.For_Advanced
    set output_file "loops_advanced.go"

    set template_content "package main

import (
    \"fmt\"
    \"log\"
    \"math/rand\"
)

//
// ---------------------- Part 1: Count Strings in File ----------------------
//

func voteCounter() {
    lines, err := datafile.GetStrings(\"votes.txt\")
    if err != nil {
        log.Fatal(err)
    }

    counts := make(map[string]int)

    for _, line := range lines {
        counts[line]++
    }

    for name, count := range counts {
        fmt.Printf(\"%s: %d\\n\\n\", name, count)
    }
}

//
// -------------------------- Part 2: Divisible loops ------------------------
//

func divisibleLoops() {
    for i := 1; i <= 100; i++ {
        if i%3 == 0 {
            fmt.Println(i)
        }
    }
    fmt.Println(\"-----------------------------\")

    for i := 1; i <= 100; i++ {
        if i%7 != 0 {
            continue
        }
        fmt.Println(i)
    }
    fmt.Println(\"-----------------------------\")

    for i := 1; i <= 100; i++ {
        if i == 10 {
            break
        }
        fmt.Println(i)
    }
    fmt.Println(\"After loop\")
    fmt.Println(\"-----------------------------\")

    nums := []int{1, 2, 3, 4, 5}

    for i := 0; i < len(nums); i++ {
        fmt.Println(nums[i])
    }

    for index, element := range nums {
        fmt.Printf(\"Index: %d Element: %d\\n\", index, element)
    }

    for _, element := range nums {
        fmt.Printf(\"Element: %d\\n\", element)
    }

    fmt.Println(\"-----------------------------\")

    matrix := [][]int{
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9},
    }

    for _, row := range matrix {
        for _, column := range row {
            fmt.Printf(\"%d \", column)
        }
        fmt.Println()
    }
}

//
// --------------------------- Part 3: For examples ---------------------------
//

func basicLoops() {
    i := 1
    for i <= 3 {
        fmt.Println(i)
        i++
    }

    for j := 7; j <= 9; j++ {
        fmt.Println(j)
    }

    for {
        fmt.Println(\"loop\")
        break
    }

    for n := 0; n <= 5; n++ {
        if n%2 == 0 {
            continue
        }
        fmt.Println(n)
    }

    fruits := [3]string{\"apple\", \"pear\", \"baban\"}

    for index, value := range fruits {
        fmt.Println(index, value)
    }

    for _, value := range fruits {
        fmt.Println(value)
    }

    for i := 0; i < len(fruits); i++ {
        fmt.Println(fruits[i])
    }
}

//
// ---------------------- Part 4: Sensor & Calibration ------------------------
//

type kelvin float64
type sensor func() kelvin

func fakeSensor() kelvin {
    result := kelvin(rand.Intn(151) + 150)
    fmt.Printf(\"я фейк, %f\", result)
    return result
}

func calibrate(s sensor, offset kelvin) sensor {
    return func() kelvin {
        return s() + offset
    }
}

func sensorDemo() {
    var offset kelvin = 5
    sensor := calibrate(fakeSensor, offset)

    for count := 0; count < 10; count++ {
        fmt.Println(sensor())
    }
}

//
// --------------------------- Part 5: Grid Printer ---------------------------
//

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
    for i := 0; i < 6; i++ {
        for j := 0; j < 9; j++ {
            fmt.Print(grid[j][i])
        }
        fmt.Println()
    }
}

//
// ------------------------------------ MAIN ----------------------------------
//

func main() {
    // Uncomment what you want to run:

    // voteCounter()
    // divisibleLoops()
    // basicLoops()
    // sensorDemo()
    makeGrid()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoG.Go.Loops_Advanced
    set output_file "loops_advanced.go"

    set template_content "package main

import (
    \"fmt\"
    \"math/rand\"
    \"strings\"
    \"time\"
)

//
// ---------------------- Part 1: Multiplication Table ----------------------
//

const max = 5

func multiplicationTable() {
    fmt.Printf(\"%5s\", \"X\")
    for i := 0; i <= max; i++ {
        fmt.Printf(\"%5d\", i)
    }
    fmt.Println()

    for i := 0; i <= max; i++ {
        fmt.Printf(\"%5d\", i)
        for j := 0; j <= max; j++ {
            fmt.Printf(\"%5d\", i*j)
        }
        fmt.Println()
    }
}

//
// --------------------------- Part 2: Slice Operations ----------------------
//

func sliceDemo() {
    n := 5
    a := []int{}
    fmt.Printf(\"Length before append: %d\\n\", len(a))
    for i := 0; i < n; i++ {
        a = append(a, 5)
    }
    fmt.Printf(\"Length after append: %d\\n\", len(a))

    strSlice := []string{}
    for _, v := range a {
        strSlice = append(strSlice, fmt.Sprintf(\"%d\", v))
    }
    fmt.Println(\"Slice contents: \", strings.Join(strSlice, \", \"))
}

//
// -------------------------- Part 3: Loop Examples --------------------------
//

func loopExamples() {
    for i := 0; i <= 10; i++ {
        if i == 5 {
            continue
        }
        fmt.Println(i)
    }

    shalom := \"shalom\"
    for i := 0; i < len(shalom); i++ {
        fmt.Printf(\"%c\\n\", shalom[i])
    }

    i := 0
    for i < 10 {
        fmt.Println(i)
        i++
    }

    i = 0
    for {
        fmt.Println(i)
        i++
        if i == 3 {
            break
        }
    }
}

//
// -------------------------- Part 4: Bubble sort check -----------------------
//

func bubbleSortCheck() {
    rand.Seed(time.Now().UTC().UnixNano())
    n := 5
    a := []int{}
    b := []int{3, 4, 5}

    for i := 0; i < n; i++ {
        a = append(a, rand.Intn(20))
    }
    fmt.Println(a)

    for i := 0; i < len(b); i++ {
        find := b[i]
        isExist := false
        for _, v := range a {
            if find == v {
                isExist = true
                break
            }
        }
        if isExist {
            fmt.Printf(\"find number %d in slice\\n\", find)
        } else {
            fmt.Printf(\"not find number %d in slice\\n\", find)
        }
    }
}

//
// ----------------------------------- MAIN ----------------------------------
//

func main() {
    // Uncomment what you want to run:

    // multiplicationTable()
    // sliceDemo()
    // loopExamples()
    // bubbleSortCheck()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoG.Basic.For-Slices_Arrays
    set output_file "slices_arrays_loops.go"

    set template_content "package main

import (
    \"fmt\"
    \"math/rand\"
    \"time\"
)

//
// ---------------------- Part 1: Nested Slices ----------------------
//

func nestedSlicesDemo() {
    arr1 := []int{1, 2, 3, 4}
    arr2 := []int{4, 5, 6, 7}
    arr3 := [][]int{arr1, arr2}

    for _, v := range arr3 {
        for _, k := range v {
            fmt.Println(k)
        }
    }
}

func columnSumDemo() {
    arr1 := []int{1, 2, 3, 4}
    arr2 := []int{4, 5, 6, 7}
    arr3 := []int{7, 8, 9, 10}
    arr := [][]int{arr1, arr2, arr3}
    arr4 := []int{111, 2, 3233, 341}
    arr = append(arr, arr4)

    n := len(arr)
    m := len(arr1)

    for i := 0; i < m; i++ {
        sumiColumn := 0
        for j := 0; j < n; j++ {
            sumiColumn += arr[j][i]
        }
        fmt.Println(sumiColumn)
    }
}

func nestedSlicePrint() {
    arr1 := []int{1, 2, 3, 4}
    arr2 := []int{4, 5, 6, 7}
    arr3 := []int{7, 8, 9, 10, 123}
    arr := [][]int{arr1, arr2, arr3}
    arr4 := []int{111, 2, 3233, 341}
    arr = append(arr, arr4)

    for _, v := range arr {
        for _, k := range v {
            fmt.Println(k)
        }
    }
}

//
// ---------------------- Part 2: Even Numbers & Indexing ----------------------
//

func evenNumbersDemo() {
    numbers := []int{}
    n := 100
    for i := 0; i <= n; i++ {
        if i%2 == 0 {
            numbers = append(numbers, i)
        }
    }

    indexes := []int{2, 6, 3}
    for _, v := range indexes {
        targetIndex := v - 1
        for j, value := range numbers {
            if targetIndex == j {
                fmt.Print(value, \" \")
            }
        }
        fmt.Println()
    }
}

func countEvenInNested() {
    arr1 := []int{1, 2, 3, 4}
    arr2 := []int{4, 5, 6, 7}
    arr3 := []int{7, 8, 9, 10, 123}
    arr := [][]int{arr1, arr2, arr3}
    arr4 := []int{111, 2, 3233, 341}
    arr = append(arr, arr4)

    counter := 0
    for _, v := range arr {
        for _, k := range v {
            if k%2 == 0 {
                counter++
            }
        }
    }
    fmt.Println(counter)
}

//
// ---------------------- Part 3: Loops Examples ----------------------
//

func loopsDemo() {
    fmt.Println(\"simple for-loop\")
    for i := 0; i < 10; i++ {
        fmt.Print(i, \" \")
    }
    fmt.Println()

    fmt.Println(\"nested-loop\")
    for i := 0; i < 2; i++ {
        fmt.Println(\"outer loop:\", i)
        for j := 0; j < 3; j++ {
            fmt.Println(\"\\tinner loop:\", j)
        }
    }

    fmt.Println(\"like C while\")
    x := 0
    for x < 10 {
        fmt.Print(x, \" \")
        x++
    }
    fmt.Println()

    fmt.Println(\"for with break\")
    x = 0
    for x < 10 {
        if x == 5 {
            break
        }
        fmt.Print(x, \" \")
        x++
    }
    fmt.Println()

    fmt.Println(\"for with continue\")
    x = 0
    for x < 10 {
        x++
        if x%2 == 0 {
            continue
        }
        fmt.Print(x, \" \")
    }
    fmt.Println()
}

//
// ---------------------- Part 4: Modify Slices ----------------------
//

type Planets []string

func (planets Planets) terraform() {
    for i := range planets {
        planets[i] = \"Новый \" + planets[i]
    }
}

func planetsDemo() {
    planets := []string{
        \"Меркурий\", \"Венера\", \"Земля\", \"Марс\",
        \"Юпитер\", \"Сатурн\", \"Уран\", \"Нептун\",
    }
    Planets(planets[3:4]).terraform()
    Planets(planets[6:]).terraform()
    fmt.Println(planets)
}

//
// ---------------------- Part 5: User Profile ----------------------
//

func buildProfile(first, last string, userInfo map[string]string) map[string]string {
    profile := make(map[string]string)
    profile[\"first name\"] = first
    profile[\"last name\"] = last

    fmt.Println(\"Profile:\")
    for key, value := range profile {
        fmt.Printf(\"%s: %s\\n\", key, value)
    }

    for key, value := range userInfo {
        fmt.Printf(\"\\nkey: %s\\n\", key)
        fmt.Printf(\"value: %s\\n\", value)
        profile[key] = value
    }
    return profile
}

func userProfileDemo() {
    userInfo := map[string]string{
        \"location\": \"princeton\",
        \"field\":    \"physics\",
    }
    userProfile := buildProfile(\"albert\", \"einstein\", userInfo)

    fmt.Println(\"\\nComplete user profile:\")
    for key, value := range userProfile {
        fmt.Printf(\"%s: %s\\n\", key, value)
    }
}

//
// ---------------------- Part 6: Random Slice Modification ----------------------
//

func randomSliceDemo() {
    rand.Seed(time.Now().UTC().UnixNano())
    n := 5
    a := []int{}
    for i := 0; i < n; i++ {
        a = append(a, rand.Intn(100))
    }
    fmt.Println(a)

    for i := 0; i < len(a); i++ {
        a[i] = 5
    }
    fmt.Println(a)

    for i := range a {
        a[i] = 10
    }
    fmt.Println(a)
}

//
// ---------------------- MAIN ----------------------
//

func main() {
    // Uncomment the demos you want to run:
    // nestedSlicesDemo()
    // columnSumDemo()
    // nestedSlicePrint()
    // evenNumbersDemo()
    // countEvenInNested()
    // loopsDemo()
    // planetsDemo()
    // userProfileDemo()
    // randomSliceDemo()
}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CloneGraph.DepthFirstSeacrh
    set output_file "clone_graph_dfs.py"

    set template_content '"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []

from typing import Optional

class Solution:
    def cloneGraph(self, node: Optional["Node"]) -> Optional["Node"]:
        oldToNew = {}

        def dfs(node):
            if node in oldToNew:
                return oldToNew[node]

            copy = Node(node.val)
            oldToNew[node] = copy
            for nei in node.neighbors:
                copy.neighbors.append(dfs(nei))
            return copy

        return dfs(node) if node else None
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CloneGraph.BreadthFirstSearch
    set output_file "clone_graph_bfs.py"

    set template_content '"""
# Definition for a Node.
class Node:
    def __init__(self, val = 0, neighbors = None):
        self.val = val
        self.neighbors = neighbors if neighbors is not None else []

from typing import Optional
from collections import deque

class Solution:
    def cloneGraph(self, node: Optional["Node"]) -> Optional["Node"]:
        if not node:
            return None

        oldToNew = {}
        oldToNew[node] = Node(node.val)
        q = deque([node])

        while q:
            cur = q.popleft()
            for nei in cur.neighbors:
                if nei not in oldToNew:
                    oldToNew[nei] = Node(nei.val)
                    q.append(nei)
                oldToNew[cur].neighbors.append(oldToNew[nei])

        return oldToNew[node]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.IslandsAndTreasure.BruteForce_Backtracking
    set output_file "islands_and_treasure_dfs.py"

    set template_content 'from typing import List

class Solution:
    def islandsAndTreasure(self, grid: List[List[int]]) -> None:
        ROWS, COLS = len(grid), len(grid[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        INF = 2147483647
        visit = [[False for _ in range(COLS)] for _ in range(ROWS)]

        def dfs(r, c):
            if (r < 0 or c < 0 or r >= ROWS or
                c >= COLS or grid[r][c] == -1 or
                visit[r][c]):
                return INF
            if grid[r][c] == 0:
                return 0

            visit[r][c] = True
            res = INF
            for dx, dy in directions:
                res = min(res, 1 + dfs(r + dx, c + dy))
            visit[r][c] = False
            return res

        for r in range(ROWS):
            for c in range(COLS):
                if grid[r][c] == INF:
                    grid[r][c] = dfs(r, c)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IslandsAndTreasure.BreadthFirstSearch
    set output_file "islands_and_treasure_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def islandsAndTreasure(self, grid: List[List[int]]) -> None:
        ROWS, COLS = len(grid), len(grid[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        INF = 2147483647

        def bfs(r, c):
            q = deque([(r, c)])
            visit = [[False] * COLS for _ in range(ROWS)]
            visit[r][c] = True
            steps = 0
            while q:
                for _ in range(len(q)):
                    row, col = q.popleft()
                    if grid[row][col] == 0:
                        return steps
                    for dr, dc in directions:
                        nr, nc = row + dr, col + dc
                        if (0 <= nr < ROWS and 0 <= nc < COLS and
                            not visit[nr][nc] and grid[nr][nc] != -1
                        ):
                            visit[nr][nc] = True
                            q.append((nr, nc))
                steps += 1
            return INF

        for r in range(ROWS):
            for c in range(COLS):
                if grid[r][c] == INF:
                    grid[r][c] = bfs(r, c)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.IslandsAndTreasure.MultiSourceBFS
    set output_file "islands_and_treasure_multibfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def islandsAndTreasure(self, grid: List[List[int]]) -> None:
        ROWS, COLS = len(grid), len(grid[0])
        visit = set()
        q = deque()

        def addCell(r, c):
            if (min(r, c) < 0 or r == ROWS or c == COLS or
                (r, c) in visit or grid[r][c] == -1
            ):
                return
            visit.add((r, c))
            q.append([r, c])

        for r in range(ROWS):
            for c in range(COLS):
                if grid[r][c] == 0:
                    q.append([r, c])
                    visit.add((r, c))

        dist = 0
        while q:
            for i in range(len(q)):
                r, c = q.popleft()
                grid[r][c] = dist
                addCell(r + 1, c)
                addCell(r - 1, c)
                addCell(r, c + 1)
                addCell(r, c - 1)
            dist += 1
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RottingFruit.BreadthFirstSearch
    set output_file "rotting_oranges_bfs.py"

    set template_content 'from typing import List
import collections

class Solution:
    def orangesRotting(self, grid: List[List[int]]) -> int:
        q = collections.deque()
        fresh = 0
        time = 0

        for r in range(len(grid)):
            for c in range(len(grid[0])):
                if grid[r][c] == 1:
                    fresh += 1
                if grid[r][c] == 2:
                    q.append((r, c))

        directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
        while fresh > 0 and q:
            length = len(q)
            for i in range(length):
                r, c = q.popleft()
                for dr, dc in directions:
                    row, col = r + dr, c + dc
                    if (row in range(len(grid)) and col in range(len(grid[0])) 
                        and grid[row][col] == 1):
                        grid[row][col] = 2
                        q.append((row, col))
                        fresh -= 1
            time += 1

        return time if fresh == 0 else -1
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RottingFruit.BreadthFirstSearch_NoQueue
    set output_file "rotting_oranges_step_simulation.py"

    set template_content 'from typing import List

class Solution:
    def orangesRotting(self, grid: List[List[int]]) -> int:
        ROWS, COLS = len(grid), len(grid[0])
        fresh = 0
        time = 0

        for r in range(ROWS):
            for c in range(COLS):
                if grid[r][c] == 1:
                    fresh += 1

        directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

        while fresh > 0:
            flag = False
            for r in range(ROWS):
                for c in range(COLS):
                    if grid[r][c] == 2:
                        for dr, dc in directions:
                            row, col = r + dr, c + dc
                            if (0 <= row < ROWS and 0 <= col < COLS 
                                and grid[row][col] == 1):
                                grid[row][col] = 3
                                fresh -= 1
                                flag = True

            if not flag:
                return -1

            for r in range(ROWS):
                for c in range(COLS):
                    if grid[r][c] == 3:
                        grid[r][c] = 2

            time += 1

        return time
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PacificAtlanticWaterFlow.BruteForce_Backtracking
    set output_file "pacific_atlantic_brutal_dfs.py"

    set template_content 'from typing import List

class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        ROWS, COLS = len(heights), len(heights[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        pacific = atlantic = False

        def dfs(r, c, prevVal):
            nonlocal pacific, atlantic
            if r < 0 or c < 0:
                pacific = True
                return
            if r >= ROWS or c >= COLS:
                atlantic = True
                return
            if heights[r][c] > prevVal:
                return

            tmp = heights[r][c]
            heights[r][c] = float("inf")

            for dr, dc in directions:
                dfs(r + dr, c + dc, tmp)
                if pacific and atlantic:
                    break

            heights[r][c] = tmp

        res = []
        for r in range(ROWS):
            for c in range(COLS):
                pacific = atlantic = False
                dfs(r, c, float("inf"))
                if pacific and atlantic:
                    res.append([r, c])
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PacificAtlanticWaterFlow.DepthFirstSearch
    set output_file "pacific_atlantic_dfs_set.py"

    set template_content 'from typing import List

class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        ROWS, COLS = len(heights), len(heights[0])
        pac, atl = set(), set()

        def dfs(r, c, visit, prevHeight):
            if ((r, c) in visit or
                r < 0 or c < 0 or r >= ROWS or c >= COLS or
                heights[r][c] < prevHeight):
                return
            visit.add((r, c))
            dfs(r + 1, c, visit, heights[r][c])
            dfs(r - 1, c, visit, heights[r][c])
            dfs(r, c + 1, visit, heights[r][c])
            dfs(r, c - 1, visit, heights[r][c])

        for c in range(COLS):
            dfs(0, c, pac, heights[0][c])
            dfs(ROWS - 1, c, atl, heights[ROWS - 1][c])

        for r in range(ROWS):
            dfs(r, 0, pac, heights[r][0])
            dfs(r, COLS - 1, atl, heights[r][COLS - 1])

        res = []
        for r in range(ROWS):
            for c in range(COLS):
                if (r, c) in pac and (r, c) in atl:
                    res.append([r, c])
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PacificAtlanticWaterFlow.BreadthFirstSearch
    set output_file "pacific_atlantic_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        ROWS, COLS = len(heights), len(heights[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        pac = [[False] * COLS for _ in range(ROWS)]
        atl = [[False] * COLS for _ in range(ROWS)]

        def bfs(source, ocean):
            q = deque(source)
            while q:
                r, c = q.popleft()
                ocean[r][c] = True
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if (0 <= nr < ROWS and 0 <= nc < COLS and
                        not ocean[nr][nc] and
                        heights[nr][nc] >= heights[r][c]):
                        q.append((nr, nc))

        pacific = []
        atlantic = []

        for c in range(COLS):
            pacific.append((0, c))
            atlantic.append((ROWS - 1, c))

        for r in range(ROWS):
            pacific.append((r, 0))
            atlantic.append((r, COLS - 1))

        bfs(pacific, pac)
        bfs(atlantic, atl)

        res = []
        for r in range(ROWS):
            for c in range(COLS):
                if pac[r][c] and atl[r][c]:
                    res.append([r, c])
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SurroundedRegions.DepthFirstSearch
    set output_file "surrounded_regions_dfs.py"

    set template_content 'from typing import List

class Solution:
    def solve(self, board: List[List[str]]) -> None:
        ROWS, COLS = len(board), len(board[0])

        def capture(r, c):
            if (r < 0 or c < 0 or r == ROWS or c == COLS or
                board[r][c] != "O"):
                return
            board[r][c] = "T"
            capture(r + 1, c)
            capture(r - 1, c)
            capture(r, c + 1)
            capture(r, c - 1)

        for r in range(ROWS):
            if board[r][0] == "O":
                capture(r, 0)
            if board[r][COLS - 1] == "O":
                capture(r, COLS - 1)

        for c in range(COLS):
            if board[0][c] == "O":
                capture(0, c)
            if board[ROWS - 1][c] == "O":
                capture(ROWS - 1, c)

        for r in range(ROWS):
            for c in range(COLS):
                if board[r][c] == "O":
                    board[r][c] = "X"
                elif board[r][c] == "T":
                    board[r][c] = "O"
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SurroundedRegions.BreadthFirstSearch
    set output_file "surrounded_regions_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def solve(self, board: List[List[str]]) -> None:
        ROWS, COLS = len(board), len(board[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        def capture():
            q = deque()
            for r in range(ROWS):
                for c in range(COLS):
                    if (r == 0 or r == ROWS - 1 or
                        c == 0 or c == COLS - 1) and board[r][c] == "O":
                        q.append((r, c))

            while q:
                r, c = q.popleft()
                if board[r][c] == "O":
                    board[r][c] = "T"
                    for dr, dc in directions:
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < ROWS and 0 <= nc < COLS:
                            q.append((nr, nc))

        capture()

        for r in range(ROWS):
            for c in range(COLS):
                if board[r][c] == "O":
                    board[r][c] = "X"
                elif board[r][c] == "T":
                    board[r][c] = "O"
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SurroundedRegions.DisjointSetUnion
    set output_file "surrounded_regions_dsu.py"

    set template_content 'from typing import List

class DSU:
    def __init__(self, n):
        self.Parent = list(range(n + 1))
        self.Size = [1] * (n + 1)

    def find(self, node):
        if self.Parent[node] != node:
            self.Parent[node] = self.find(self.Parent[node])
        return self.Parent[node]

    def union(self, u, v):
        pu = self.find(u)
        pv = self.find(v)
        if pu == pv:
            return
        if self.Size[pu] >= self.Size[pv]:
            self.Size[pu] += self.Size[pv]
            self.Parent[pv] = pu
        else:
            self.Size[pv] += self.Size[pu]
            self.Parent[pu] = pv

    def connected(self, u, v):
        return self.find(u) == self.find(v)

class Solution:
    def solve(self, board: List[List[str]]) -> None:
        ROWS, COLS = len(board), len(board[0])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        dsu = DSU(ROWS * COLS + 1)

        for r in range(ROWS):
            for c in range(COLS):
                if board[r][c] != "O":
                    continue
                idx = r * COLS + c

                if r == 0 or c == 0 or r == ROWS - 1 or c == COLS - 1:
                    dsu.union(ROWS * COLS, idx)
                else:
                    for dr, dc in directions:
                        nr, nc = r + dr, c + dc
                        if board[nr][nc] == "O":
                            dsu.union(idx, nr * COLS + nc)

        for r in range(ROWS):
            for c in range(COLS):
                if board[r][c] == "O" and not dsu.connected(ROWS * COLS, r * COLS + c):
                    board[r][c] = "X"
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CourseSchedule.CycleDetection_DFS
    set output_file "course_schedule_dfs.py"

    set template_content 'from typing import List

class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        preMap = {i: [] for i in range(numCourses)}
        for crs, pre in prerequisites:
            preMap[crs].append(pre)

        visiting = set()

        def dfs(crs):
            if crs in visiting:
                return False
            if preMap[crs] == []:
                return True

            visiting.add(crs)
            for pre in preMap[crs]:
                if not dfs(pre):
                    return False
            visiting.remove(crs)
            preMap[crs] = []
            return True

        for c in range(numCourses):
            if not dfs(c):
                return False
        return True
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CourseSchedule.TopologicalSort_KahnAlgorithm
    set output_file "course_schedule_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def canFinish(self, numCourses: int, prerequisites: List[List[int]]) -> bool:
        indegree = [0] * numCourses
        adj = [[] for _ in range(numCourses)]
        for src, dst in prerequisites:
            indegree[dst] += 1
            adj[src].append(dst)

        q = deque()
        for n in range(numCourses):
            if indegree[n] == 0:
                q.append(n)

        finish = 0
        while q:
            node = q.popleft()
            finish += 1
            for nei in adj[node]:
                indegree[nei] -= 1
                if indegree[nei] == 0:
                    q.append(nei)

        return finish == numCourses
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.CourseScheduleII.CycleDetection_DFS
    set output_file "course_schedule_II_dfs.py"

    set template_content 'from typing import List

class Solution:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        prereq = {c: [] for c in range(numCourses)}
        for crs, pre in prerequisites:
            prereq[crs].append(pre)

        output = []
        visit, cycle = set(), set()

        def dfs(crs):
            if crs in cycle:
                return False
            if crs in visit:
                return True

            cycle.add(crs)
            for pre in prereq[crs]:
                if not dfs(pre):
                    return False
            cycle.remove(crs)
            visit.add(crs)
            output.append(crs)
            return True

        for c in range(numCourses):
            if not dfs(c):
                return []
        return output
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CourseScheduleII.TopologicalSort_KahnAlgorithm
    set output_file "course_schedule_II_bfs.py"

    set template_content 'from typing import List
from collections import deque

class SolutionBFS:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        indegree = [0] * numCourses
        adj = [[] for _ in range(numCourses)]
        for src, dst in prerequisites:
            indegree[dst] += 1
            adj[src].append(dst)

        q = deque()
        for n in range(numCourses):
            if indegree[n] == 0:
                q.append(n)

        finish, output = 0, []
        while q:
            node = q.popleft()
            output.append(node)
            finish += 1
            for nei in adj[node]:
                indegree[nei] -= 1
                if indegree[nei] == 0:
                    q.append(nei)

        if finish != numCourses:
            return []
        return output[::-1]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CourseScheduleII.TopologicalSort_DFS
    set output_file "course_schedule_II_dfs_indegree.py"

    set template_content 'from typing import List

class SolutionDFSIndegree:
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        adj = [[] for _ in range(numCourses)]
        indegree = [0] * numCourses
        for nxt, pre in prerequisites:
            indegree[nxt] += 1
            adj[pre].append(nxt)

        output = []

        def dfs(node):
            output.append(node)
            indegree[node] -= 1
            for nei in adj[node]:
                indegree[nei] -= 1
                if indegree[nei] == 0:
                    dfs(nei)

        for i in range(numCourses):
            if indegree[i] == 0:
                dfs(i)

        return output if len(output) == numCourses else []
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GraphValidTree.CycleDetection 
    set output_file "valid_tree_dfs.py"

    set template_content 'from typing import List

class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        if len(edges) > n - 1:
            return False

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visit = set()

        def dfs(node, parent):
            if node in visit:
                return False
            visit.add(node)
            for nei in adj[node]:
                if nei == parent:
                    continue
                if not dfs(nei, node):
                    return False
            return True

        return dfs(0, -1) and len(visit) == n
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.GraphValidTree.BreadthFirstSearch
    set output_file "valid_tree_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        if len(edges) > n - 1:
            return False

        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visit = set()
        q = deque([(0, -1)])
        visit.add(0)

        while q:
            node, parent = q.popleft()
            for nei in adj[node]:
                if nei == parent:
                    continue
                if nei in visit:
                    return False
                visit.add(nei)
                q.append((nei, node))

        return len(visit) == n
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GraphValidTree.DisjointSetUnion
    set output_file "valid_tree_dsu.py"

    set template_content 'from typing import List

class DSU:
    def __init__(self, n):
        self.comps = n
        self.parent = list(range(n))
        self.size = [1] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, a, b):
        pa, pb = self.find(a), self.find(b)
        if pa == pb:
            return False
        if self.size[pa] < self.size[pb]:
            pa, pb = pb, pa
        self.parent[pb] = pa
        self.size[pa] += self.size[pb]
        self.comps -= 1
        return True

class Solution:
    def validTree(self, n: int, edges: List[List[int]]) -> bool:
        if len(edges) > n - 1:
            return False

        dsu = DSU(n)
        for u, v in edges:
            if not dsu.union(u, v):
                return False

        return dsu.comps == 1
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NumberConnectedComponentsUndirectedGraph.DepthFirstSearch
    set output_file "count_components_dfs.py"

    set template_content 'from typing import List

class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        adj = [[] for _ in range(n)]
        visit = [False] * n

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def dfs(node):
            for nei in adj[node]:
                if not visit[nei]:
                    visit[nei] = True
                    dfs(nei)

        res = 0
        for node in range(n):
            if not visit[node]:
                visit[node] = True
                dfs(node)
                res += 1
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberConnectedComponentsUndirectedGraph.BreadthFirstSearch
    set output_file "count_components_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        adj = [[] for _ in range(n)]
        visit = [False] * n

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        def bfs(node):
            q = deque([node])
            visit[node] = True
            while q:
                cur = q.popleft()
                for nei in adj[cur]:
                    if not visit[nei]:
                        visit[nei] = True
                        q.append(nei)

        res = 0
        for node in range(n):
            if not visit[node]:
                bfs(node)
                res += 1
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NumberConnectedComponentsUndirectedGraph.DisjointSetUnion_RankSize
    set output_file "count_components_dsu.py"

    set template_content 'from typing import List

class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n

    def find(self, node):
        cur = node
        while cur != self.parent[cur]:
            self.parent[cur] = self.parent[self.parent[cur]]
            cur = self.parent[cur]
        return cur

    def union(self, u, v):
        pu = self.find(u)
        pv = self.find(v)
        if pu == pv:
            return False
        if self.rank[pv] > self.rank[pu]:
            pu, pv = pv, pu
        self.parent[pv] = pu
        self.rank[pu] += self.rank[pv]
        return True

class Solution:
    def countComponents(self, n: int, edges: List[List[int]]) -> int:
        dsu = DSU(n)
        res = n
        for u, v in edges:
            if dsu.union(u, v):
                res -= 1
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RedundantConnection.CycleDetection
    set output_file "redundant_connection_dfs.py"

    set template_content 'from typing import List

class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        n = len(edges)
        adj = [[] for _ in range(n + 1)]

        def dfs(node, parent):
            if visit[node]:
                return True
            visit[node] = True
            for nei in adj[node]:
                if nei == parent:
                    continue
                if dfs(nei, node):
                    return True
            return False

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            visit = [False] * (n + 1)
            if dfs(u, -1):
                return [u, v]

        return []
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RedundantConnection.DepthFirstSearch
    set output_file "redundant_connection_cycle_dfs.py"

    set template_content 'from typing import List

class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        n = len(edges)
        adj = [[] for _ in range(n + 1)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        visit = [False] * (n + 1)
        cycle = set()
        cycleStart = -1

        def dfs(node, parent):
            nonlocal cycleStart
            if visit[node]:
                cycleStart = node
                return True

            visit[node] = True
            for nei in adj[node]:
                if nei == parent:
                    continue
                if dfs(nei, node):
                    if cycleStart != -1:
                        cycle.add(node)
                    if node == cycleStart:
                        cycleStart = -1
                    return True
            return False

        dfs(1, -1)

        for u, v in reversed(edges):
            if u in cycle and v in cycle:
                return [u, v]
        return []
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RedundantConnection.TopologicalSort
    set output_file "redundant_connection_degree.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        n = len(edges)
        indegree = [0] * (n + 1)
        adj = [[] for _ in range(n + 1)]

        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)
            indegree[u] += 1
            indegree[v] += 1

        q = deque()
        for i in range(1, n + 1):
            if indegree[i] == 1:
                q.append(i)

        while q:
            node = q.popleft()
            indegree[node] -= 1
            for nei in adj[node]:
                indegree[nei] -= 1
                if indegree[nei] == 1:
                    q.append(nei)

        for u, v in reversed(edges):
            if indegree[u] > 0 and indegree[v] > 0:
                return [u, v]
        return []
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RedundantConnection.DisjointSetUnion
    set output_file "redundant_connection_dsu.py"

    set template_content 'from typing import List

class Solution:
    def findRedundantConnection(self, edges: List[List[int]]) -> List[int]:
        parent = [i for i in range(len(edges) + 1)]
        rank = [1] * (len(edges) + 1)

        def find(x):
            while x != parent[x]:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            px, py = find(x), find(y)
            if px == py:
                return False
            if rank[px] >= rank[py]:
                parent[py] = px
                rank[px] += rank[py]
            else:
                parent[px] = py
                rank[py] += rank[px]
            return True

        for u, v in edges:
            if not union(u, v):
                return [u, v]
        return []
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ClimbingStairs.Recursion
    set output_file "climbing_stairs_dfs.py"

    set template_content 'class Solution:
    def climbStairs(self, n: int) -> int:
        def dfs(i):
            if i >= n:
                return i == n
            return dfs(i + 1) + dfs(i + 2)

        return dfs(0)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ClimbingStairs.DynamicProgramming_Top-Down
    set output_file "climbing_stairs_memo.py"

    set template_content 'class Solution:
    def climbStairs(self, n: int) -> int:
        cache = [-1] * n

        def dfs(i):
            if i >= n:
                return i == n
            if cache[i] != -1:
                return cache[i]
            cache[i] = dfs(i + 1) + dfs(i + 2)
            return cache[i]

        return dfs(0)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ClimbingStairs.DynamicProgramming_Bottom-Up
    set output_file "climbing_stairs_dp.py"

    set template_content 'class Solution:
    def climbStairs(self, n: int) -> int:
        if n <= 2:
            return n

        dp = [0] * (n + 1)
        dp[1], dp[2] = 1, 2

        for i in range(3, n + 1):
            dp[i] = dp[i - 1] + dp[i - 2]

        return dp[n]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ClimbingStairs.DynamicProgramming_SpaceOptimized
    set output_file "climbing_stairs_fib.py"

    set template_content 'class Solution:
    def climbStairs(self, n: int) -> int:
        one, two = 1, 1

        for _ in range(n - 1):
            one, two = one + two, one

        return one
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ClimbingStairs.MatrixExponentiation
    set output_file "climbing_stairs_matrix.py"

    set template_content 'class Solution:
    def climbStairs(self, n: int) -> int:
        if n == 1:
            return 1

        def mul(A, B):
            return [
                [A[0][0]*B[0][0] + A[0][1]*B[1][0],
                 A[0][0]*B[0][1] + A[0][1]*B[1][1]],
                [A[1][0]*B[0][0] + A[1][1]*B[1][0],
                 A[1][0]*B[0][1] + A[1][1]*B[1][1]]
            ]

        def power(M, p):
            res = [[1, 0], [0, 1]]
            while p:
                if p & 1:
                    res = mul(res, M)
                M = mul(M, M)
                p >>= 1
            return res

        M = [[1, 1], [1, 0]]
        return power(M, n)[0][0]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostClimbingStairs.Recursion
    set output_file "min_cost_climbing_stairs_dfs.py"

    set template_content 'from typing import List

class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        def dfs(i):
            if i >= len(cost):
                return 0
            return cost[i] + min(dfs(i + 1), dfs(i + 2))

        return min(dfs(0), dfs(1))
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostClimbingStairs.DynamicProgramming_Top-Down
    set output_file "min_cost_climbing_stairs_memo.py"

    set template_content 'from typing import List

class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        memo = [-1] * len(cost)

        def dfs(i):
            if i >= len(cost):
                return 0
            if memo[i] != -1:
                return memo[i]
            memo[i] = cost[i] + min(dfs(i + 1), dfs(i + 2))
            return memo[i]

        return min(dfs(0), dfs(1))
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostClimbingStairs.DynamicProgramming_Bottom-Up
    set output_file "min_cost_climbing_stairs_dp.py"

    set template_content 'from typing import List

class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        n = len(cost)
        dp = [0] * (n + 1)

        for i in range(2, n + 1):
            dp[i] = min(dp[i - 1] + cost[i - 1],
                        dp[i - 2] + cost[i - 2])

        return dp[n]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MinCostClimbingStairs.DynamicProgramming_SpaceOptimized
    set output_file "min_cost_climbing_stairs_space.py"

    set template_content 'from typing import List

class Solution:
    def minCostClimbingStairs(self, cost: List[int]) -> int:
        for i in range(len(cost) - 3, -1, -1):
            cost[i] += min(cost[i + 1], cost[i + 2])

        return min(cost[0], cost[1])
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.
    set output_file "rob_dfs.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        def dfs(i):
            if i >= len(nums):
                return 0
            return max(dfs(i + 1),
                       nums[i] + dfs(i + 2))

        return dfs(0)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobber.Recursion
    set output_file "rob_dfs.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        def dfs(i):
            if i >= len(nums):
                return 0
            return max(dfs(i + 1),
                       nums[i] + dfs(i + 2))

        return dfs(0)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobber.DynamicProgramming_Top-Down
    set output_file "rob_memo.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        memo = [-1] * len(nums)

        def dfs(i):
            if i >= len(nums):
                return 0
            if memo[i] != -1:
                return memo[i]
            memo[i] = max(dfs(i + 1), nums[i] + dfs(i + 2))
            return memo[i]

        return dfs(0)
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobber.DynamicProgramming_Bottom-Up
    set output_file "rob_dp.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        dp = [0] * len(nums)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            dp[i] = max(dp[i - 1], nums[i] + dp[i - 2])

        return dp[-1]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobber.DynamicProgramming_SpaceOptimized
    set output_file "rob_space.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        rob1, rob2 = 0, 0

        for num in nums:
            temp = max(num + rob1, rob2)
            rob1 = rob2
            rob2 = temp
        return rob2
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobberII.Recursion
    set output_file "robII_dfs.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        def dfs(i, flag):
            if i >= len(nums) or (flag and i == len(nums) - 1):
                return 0
            return max(dfs(i + 1, flag),
                       nums[i] + dfs(i + 2, flag or i == 0))
        return max(dfs(0, True), dfs(1, False))
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HouseRobberII.DynamicProgramming_Top-Down
    set output_file "robII_memo.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]

        memo = [[-1] * 2 for _ in range(len(nums))]

        def dfs(i, flag):
            if i >= len(nums) or (flag and i == len(nums) - 1):
                return 0
            if memo[i][flag] != -1:
                return memo[i][flag]
            memo[i][flag] = max(dfs(i + 1, flag),
                            nums[i] + dfs(i + 2, flag or (i == 0)))
            return memo[i][flag]

        return max(dfs(0, True), dfs(1, False))
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HouseRobberII.DynamicProgramming_Bottom-Up
    set output_file "robII_dp.py"

    set template_content 'from typing import List

class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        return max(self.helper(nums[1:]),
                   self.helper(nums[:-1]))

    def helper(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        dp = [0] * len(nums)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])

        for i in range(2, len(nums)):
            dp[i] = max(dp[i - 1], nums[i] + dp[i - 2])

        return dp[-1]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HouseRobberII.DynamicProgramming_SpaceOptimized
    set output_file "robII_space.py"

    set template_content 'from typing import List

class Solution:

    def rob(self, nums: List[int]) -> int:
        return max(nums[0], self.helper(nums[1:]),
                            self.helper(nums[:-1]))

    def helper(self, nums):
        rob1, rob2 = 0, 0

        for num in nums:
            newRob = max(rob1 + num, rob2)
            rob1 = rob2
            rob2 = newRob
        return rob2
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.LongestPalindromicSubstring.BruteForce
    set output_file "longest_palindrome_bf.py"

    set template_content 'class Solution:
    def longestPalindrome(self, s: str) -> str:
        res, resLen = "", 0

        for i in range(len(s)):
            for j in range(i, len(s)):
                l, r = i, j
                while l < r and s[l] == s[r]:
                    l += 1
                    r -= 1

                if l >= r and resLen < (j - i + 1):
                    res = s[i : j + 1]
                    resLen = j - i + 1
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestPalindromicSubstring.DynamicProgramming
    set output_file "longest_palindrome_dp.py"

    set template_content 'class Solution:
    def longestPalindrome(self, s: str) -> str:
        resIdx, resLen = 0, 0
        n = len(s)

        dp = [[False] * n for _ in range(n)]

        for i in range(n - 1, -1, -1):
            for j in range(i, n):
                if s[i] == s[j] and (j - i <= 2 or dp[i + 1][j - 1]):
                    dp[i][j] = True
                    if resLen < (j - i + 1):
                        resIdx = i
                        resLen = j - i + 1

        return s[resIdx : resIdx + resLen]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestPalindromicSubstring.TwoPointers
    set output_file "longest_palindrome_center.py"

    set template_content 'class Solution:
    def longestPalindrome(self, s: str) -> str:
        resIdx = 0
        resLen = 0

        for i in range(len(s)):
            # odd length
            l, r = i, i
            while l >= 0 and r < len(s) and s[l] == s[r]:
                if (r - l + 1) > resLen:
                    resIdx = l
                    resLen = r - l + 1
                l -= 1
                r += 1

            # even length
            l, r = i, i + 1
            while l >= 0 and r < len(s) and s[l] == s[r]:
                if (r - l + 1) > resLen:
                    resIdx = l
                    resLen = r - l + 1
                l -= 1
                r += 1

        return s[resIdx : resIdx + resLen]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestPalindromicSubstring.ManacherAlgorithm
    set output_file "longest_palindrome_manacher.py"

    set template_content 'class Solution:
    def longestPalindrome(self, s: str) -> str:
        def manacher(s):
            t = "#" + "#".join(s) + "#"
            n = len(t)
            p = [0] * n
            l, r = 0, 0
            for i in range(n):
                p[i] = min(r - i, p[l + (r - i)]) if i < r else 0
                while (i + p[i] + 1 < n and i - p[i] - 1 >= 0
                       and t[i + p[i] + 1] == t[i - p[i] - 1]):
                    p[i] += 1
                if i + p[i] > r:
                    l, r = i - p[i], i + p[i]
            return p

        p = manacher(s)
        resLen, center_idx = max((v, i) for i, v in enumerate(p))
        resIdx = (center_idx - resLen) // 2
        return s[resIdx : resIdx + resLen]
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PalindromicSubstrings.BruteForce
    set output_file "count_pali_bf.py"

    set template_content 'class Solution:
    def countSubstrings(self, s: str) -> int:
        res = 0

        for i in range(len(s)):
            for j in range(i, len(s)):
                l, r = i, j
                while l < r and s[l] == s[r]:
                    l += 1
                    r -= 1
                res += (l >= r)

        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PalindromicSubstrings.DynamicProgramming
    set output_file "count_pali_dp.py"

    set template_content 'class Solution:
    def countSubstrings(self, s: str) -> int:
        n, res = len(s), 0
        dp = [[False] * n for _ in range(n)]

        for i in range(n - 1, -1, -1):
            for j in range(i, n):
                if s[i] == s[j] and (j - i <= 2 or dp[i + 1][j - 1]):
                    dp[i][j] = True
                    res += 1

        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PalindromicSubstrings.TwoPointers
    set output_file "count_pali_center.py"

    set template_content 'class Solution:
    def countSubstrings(self, s: str) -> int:
        res = 0

        for i in range(len(s)):
            # odd length
            l, r = i, i
            while l >= 0 and r < len(s) and s[l] == s[r]:
                res += 1
                l -= 1
                r += 1

            # even length
            l, r = i, i + 1
            while l >= 0 and r < len(s) and s[l] == s[r]:
                res += 1
                l -= 1
                r += 1

        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PalindromicSubstrings.TwoPointers_Optimal
    set output_file "count_pali_helper.py"

    set template_content 'class Solution:
    def countSubstrings(self, s: str) -> int:
        res = 0

        for i in range(len(s)):
            res += self.countPali(s, i, i)
            res += self.countPali(s, i, i + 1)
        return res

    def countPali(self, s, l, r):
        res = 0
        while l >= 0 and r < len(s) and s[l] == s[r]:
            res += 1
            l -= 1
            r += 1
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.PalindromicSubstrings.ManacherAlgorithm
    set output_file "count_pali_manacher.py"

    set template_content 'class Solution:
    def countSubstrings(self, s: str) -> int:

        def manacher(s):
            t = "#" + "#".join(s) + "#"
            n = len(t)
            p = [0] * n
            l, r = 0, 0
            for i in range(n):
                p[i] = min(r - i, p[l + (r - i)]) if i < r else 0
                while (i + p[i] + 1 < n and i - p[i] - 1 >= 0
                       and t[i + p[i] + 1] == t[i - p[i] - 1]):
                    p[i] += 1
                if i + p[i] > r:
                    l, r = i - p[i], i + p[i]
            return p

        p = manacher(s)
        res = 0
        for i in p:
            res += (i + 1) // 2
        return res
'

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DecodeWays.Recursion
    set output_file "decode_ways_dfs.py"

    set template_content 'class Solution:
    def numDecodings(self, s: str) -> int:

        def dfs(i):
            if i == len(s):
                return 1
            if s[i] == "0":
                return 0

            res = dfs(i + 1)
            if i < len(s) - 1:
                if s[i] == "1" or (s[i] == "2" and s[i + 1] < "7"):
                    res += dfs(i + 2)
            return res

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DecodeWays.DynamicProgramming_Top-Down
    set output_file "decode_ways_memo.py"

    set template_content 'class Solution:
    def numDecodings(self, s: str) -> int:
        dp = {len(s): 1}

        def dfs(i):
            if i in dp:
                return dp[i]
            if s[i] == "0":
                return 0

            res = dfs(i + 1)
            if i + 1 < len(s) and (
                s[i] == "1" or
                (s[i] == "2" and s[i + 1] in "0123456")
            ):
                res += dfs(i + 2)

            dp[i] = res
            return res

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DecodeWays.DynamicProgramming_Bottom-Up
    set output_file "decode_ways_dp.py"

    set template_content 'class Solution:
    def numDecodings(self, s: str) -> int:
        dp = {len(s): 1}

        for i in range(len(s) - 1, -1, -1):
            if s[i] == "0":
                dp[i] = 0
            else:
                dp[i] = dp[i + 1]

            if i + 1 < len(s) and (
                s[i] == "1" or
                (s[i] == "2" and s[i + 1] in "0123456")
            ):
                dp[i] += dp[i + 2]

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.DecodeWays.DynamicProgramming_SpaceOptimized
    set output_file "decode_ways_optimized.py"

    set template_content 'class Solution:
    def numDecodings(self, s: str) -> int:
        dp = dp2 = 0
        dp1 = 1

        for i in range(len(s) - 1, -1, -1):
            if s[i] == "0":
                dp = 0
            else:
                dp = dp1

            if i + 1 < len(s) and (
                s[i] == "1" or
                (s[i] == "2" and s[i + 1] in "0123456")
            ):
                dp += dp2

            dp, dp1, dp2 = 0, dp, dp1

        return dp1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CoinChange.Recursion
    set output_file "coin_change_dfs.py"

    set template_content 'from typing import List

class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:

        def dfs(amt):
            if amt == 0:
                return 0
            res = 1e9
            for coin in coins:
                if amt - coin >= 0:
                    res = min(res, 1 + dfs(amt - coin))
            return res

        minCoins = dfs(amount)
        return -1 if minCoins >= 1e9 else minCoins
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CoinChange.DynamicProgramming_Top-Down
    set output_file "coin_change_memo.py"

    set template_content 'from typing import List

class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        memo = {}

        def dfs(amt):
            if amt == 0:
                return 0
            if amt in memo:
                return memo[amt]

            res = 1e9
            for coin in coins:
                if amt - coin >= 0:
                    res = min(res, 1 + dfs(amt - coin))

            memo[amt] = res
            return res

        minCoins = dfs(amount)
        return -1 if minCoins >= 1e9 else minCoins
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CoinChange.DynamicProgramming_Bottom-Up
    set output_file "coin_change_dp.py"

    set template_content 'from typing import List

class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        dp = [amount + 1] * (amount + 1)
        dp[0] = 0

        for a in range(1, amount + 1):
            for c in coins:
                if a - c >= 0:
                    dp[a] = min(dp[a], 1 + dp[a - c])

        return dp[amount] if dp[amount] != amount + 1 else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CoinChange.BreadthFirstSearch
    set output_file "coin_change_bfs.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:
        if amount == 0:
            return 0

        q = deque([0])
        seen = [False] * (amount + 1)
        seen[0] = True
        res = 0

        while q:
            res += 1
            for _ in range(len(q)):
                cur = q.popleft()
                for coin in coins:
                    nxt = cur + coin
                    if nxt == amount:
                        return res
                    if nxt > amount or seen[nxt]:
                        continue
                    seen[nxt] = True
                    q.append(nxt)

        return -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumProductSubarray.BruteForce
    set output_file "max_product_bf.py"

    set template_content 'from typing import List

class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        res = nums[0]

        for i in range(len(nums)):
            cur = nums[i]
            res = max(res, cur)
            for j in range(i + 1, len(nums)):
                cur *= nums[j]
                res = max(res, cur)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumProductSubarray.SlidingWindow
    set output_file "max_product_split.py"

    set template_content 'from typing import List

class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        A = []
        cur = []
        res = float("-inf")

        for num in nums:
            res = max(res, num)
            if num == 0:
                if cur:
                    A.append(cur)
                cur = []
            else:
                cur.append(num)

        if cur:
            A.append(cur)

        for sub in A:
            negs = sum(1 for x in sub if x < 0)
            need = negs if negs % 2 == 0 else negs - 1
            prod = 1
            neg_count = 0
            j = 0
            for i in range(len(sub)):
                prod *= sub[i]
                if sub[i] < 0:
                    neg_count += 1
                    while neg_count > need:
                        if sub[j] < 0:
                            neg_count -= 1
                        prod //= sub[j]
                        j += 1
                if j <= i:
                    res = max(res, prod)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumProductSubarray.KadaneAlgorithm
    set output_file "max_product_dp.py"

    set template_content 'from typing import List

class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        res = nums[0]
        curMin, curMax = 1, 1

        for num in nums:
            tmp = curMax * num
            curMax = max(num * curMax, num * curMin, num)
            curMin = min(tmp, num * curMin, num)
            res = max(res, curMax)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumProductSubarray.PrefixSuffix
    set output_file "max_product_prefix_suffix.py"

    set template_content 'from typing import List

class Solution:
    def maxProduct(self, nums: List[int]) -> int:
        n, res = len(nums), nums[0]
        prefix = suffix = 0

        for i in range(n):
            prefix = nums[i] * (prefix or 1)
            suffix = nums[n - 1 - i] * (suffix or 1)
            res = max(res, max(prefix, suffix))

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.WordBreak.Recursion
    set output_file "word_break_recursive.py"

    set template_content 'from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:

        def dfs(i):
            if i == len(s):
                return True

            for w in wordDict:
                if ((i + len(w)) <= len(s) and s[i : i + len(w)] == w):
                    if dfs(i + len(w)):
                        return True
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.WordBreak.Recursion_HashSet
    set output_file "word_break_recursive_set.py"

    set template_content 'from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        wordSet = set(wordDict)

        def dfs(i):
            if i == len(s):
                return True

            for j in range(i, len(s)):
                if s[i : j + 1] in wordSet:
                    if dfs(j + 1):
                        return True
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordBreak.DynamicProgramming_Top-Down
    set output_file "word_break_memo.py"

    set template_content 'from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        memo = {len(s): True}

        def dfs(i):
            if i in memo:
                return memo[i]

            for w in wordDict:
                if ((i + len(w)) <= len(s) and s[i : i + len(w)] == w):
                    if dfs(i + len(w)):
                        memo[i] = True
                        return True
            memo[i] = False
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordBreak.DynamicProgramming_HashSet
    set output_file "word_break_memo_maxlen.py"

    set template_content 'from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        wordSet = set(wordDict)
        t = max(len(w) for w in wordDict)
        memo = {}

        def dfs(i):
            if i in memo:
                return memo[i]
            if i == len(s):
                return True
            for j in range(i, min(len(s), i + t)):
                if s[i : j + 1] in wordSet:
                    if dfs(j + 1):
                        memo[i] = True
                        return True
            memo[i] = False
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordBreak.DynamicProgramming_Bottom-Up
    set output_file "word_break_dp.py"

    set template_content 'from typing import List

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        dp = [False] * (len(s) + 1)
        dp[len(s)] = True

        for i in range(len(s) - 1, -1, -1):
            for w in wordDict:
                if (i + len(w)) <= len(s) and s[i : i + len(w)] == w:
                    dp[i] = dp[i + len(w)]
                if dp[i]:
                    break

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.WordBreak.DynamicProgramming
    set output_file "word_break_trie_dp.py"

    set template_content 'from typing import List

class TrieNode:
    def __init__(self):
        self.children = {}
        self.is_word = False

class Trie:
    def __init__(self):
        self.root = TrieNode()

    def insert(self, word):
        node = self.root
        for char in word:
            if char not in node.children:
                node.children[char] = TrieNode()
            node = node.children[char]
        node.is_word = True

    def search(self, s, i, j):
        node = self.root
        for idx in range(i, j + 1):
            if s[idx] not in node.children:
                return False
            node = node.children[s[idx]]
        return node.is_word

class Solution:
    def wordBreak(self, s: str, wordDict: List[str]) -> bool:
        trie = Trie()
        for word in wordDict:
            trie.insert(word)

        dp = [False] * (len(s) + 1)
        dp[len(s)] = True
        t = max(len(w) for w in wordDict)

        for i in range(len(s), -1, -1):
            for j in range(i, min(len(s), i + t)):
                if trie.search(s, i, j):
                    dp[i] = dp[j + 1]
                    if dp[i]:
                        break

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubsequence.Recursion
    set output_file "length_of_lis_dfs.py"

    set template_content 'from typing import List

class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:

        def dfs(i, j):
            if i == len(nums):
                return 0

            LIS = dfs(i + 1, j) # not include

            if j == -1 or nums[j] < nums[i]:
                LIS = max(LIS, 1 + dfs(i + 1, i)) # include

            return LIS

        return dfs(0, -1)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestIncreasingSubsequence.DynamicProgramming_Top-DownI
    set output_file "length_of_lis_dfs_memo2d.py"

    set template_content 'class Solution:
    def lengthOfLIS(self, nums):
        n = len(nums)
        memo = [[-1] * (n + 1) for _ in range(n)]

        def dfs(i, j):
            if i == n:
                return 0
            if memo[i][j + 1] != -1:
                return memo[i][j + 1]

            LIS = dfs(i + 1, j)

            if j == -1 or nums[j] < nums[i]:
                LIS = max(LIS, 1 + dfs(i + 1, i))

            memo[i][j + 1] = LIS
            return LIS

        return dfs(0, -1)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubsequence.DynamicProgramming_Top-DownII
    set output_file "length_of_lis_dfs_memo1d.py"

    set template_content 'from typing import List

class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        n = len(nums)
        memo = [-1] * n

        def dfs(i):
            if memo[i] != -1:
                return memo[i]

            LIS = 1
            for j in range(i + 1, n):
                if nums[i] < nums[j]:
                    LIS = max(LIS, 1 + dfs(j))

            memo[i] = LIS
            return LIS

        return max(dfs(i) for i in range(n))
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubsequence.DynamicProgramming_Bottom-UpI
    set output_file "length_of_lis_dp2d.py"

    set template_content 'class Solution:
    def lengthOfLIS(self, nums):
        n = len(nums)
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(n - 1, -1, -1):
            for j in range(i - 1, -2, -1):
                LIS = dp[i + 1][j + 1]  # Not including nums[i]

                if j == -1 or nums[j] < nums[i]:
                    LIS = max(LIS, 1 + dp[i + 1][i + 1])  # Including nums[i]

                dp[i][j + 1] = LIS

        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubsequence.DynamicProgramming_Bottom-UpII
    set output_file "length_of_lis_dp1d.py"

    set template_content 'from typing import List

class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        LIS = [1] * len(nums)

        for i in range(len(nums) - 1, -1, -1):
            for j in range(i + 1, len(nums)):
                if nums[i] < nums[j]:
                    LIS[i] = max(LIS[i], 1 + LIS[j])
        return max(LIS)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.LongestIncreasingSubsequence.SegmentTree
    set output_file "length_of_lis_segment_tree.py"

    set template_content 'from bisect import bisect_left
class SegmentTree:
    def __init__(self, N):
        self.n = N
        while (self.n & (self.n - 1)) != 0:
            self.n += 1
        self.tree = [0] * (2 * self.n)

    def update(self, i, val):
        self.tree[self.n + i] = val
        j = (self.n + i) >> 1
        while j >= 1:
            self.tree[j] = max(self.tree[j << 1], self.tree[j << 1 | 1])
            j >>= 1

    def query(self, l, r):
        if l > r:
            return 0
        res = float("-inf")
        l += self.n
        r += self.n + 1
        while l < r:
            if l & 1:
                res = max(res, self.tree[l])
                l += 1
            if r & 1:
                r -= 1
                res = max(res, self.tree[r])
            l >>= 1
            r >>= 1
        return res

class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        def compress(arr):
            sortedArr = sorted(set(arr))
            order = []
            for num in arr:
                order.append(bisect_left(sortedArr, num))
            return order

        nums = compress(nums)
        n = len(nums)
        segTree = SegmentTree(n)

        LIS = 0
        for num in nums:
            curLIS = segTree.query(0, num - 1) + 1
            segTree.update(num, curLIS)
            LIS = max(LIS, curLIS)
        return LIS
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.LongestIncreasingSubsequence.DynamicProgramming_BinarySearch
    set output_file "length_of_lis_bisect.py"

    set template_content 'from bisect import bisect_left
from typing import List

class Solution:
    def lengthOfLIS(self, nums: List[int]) -> int:
        dp = []
        dp.append(nums[0])

        LIS = 1
        for i in range(1, len(nums)):
            if dp[-1] < nums[i]:
                dp.append(nums[i])
                LIS += 1
                continue

            idx = bisect_left(dp, nums[i])
            dp[idx] = nums[i]

        return LIS
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.Recursion
    set output_file "can_partition_dfs.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        if sum(nums) % 2:
            return False

        def dfs(i, target):
            if i >= len(nums):
                return target == 0
            if target < 0:
                return False

            return dfs(i + 1, target) or dfs(i + 1, target - nums[i])

        return dfs(0, sum(nums) // 2)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_Top-Down
    set output_file "can_partition_dfs_memo2d.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        total = sum(nums)
        if total % 2 != 0:
            return False

        target = total // 2
        n = len(nums)
        memo = [[-1] * (target + 1) for _ in range(n + 1)]

        def dfs(i, target):
            if target == 0:
                return True
            if i >= n or target < 0:
                return False
            if memo[i][target] != -1:
                return memo[i][target]

            memo[i][target] = (dfs(i + 1, target) or dfs(i + 1, target - nums[i]))
            return memo[i][target]

        return dfs(0, target)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_Bottom-Up
    set output_file "can_partition_dp2d.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        total = sum(nums)
        if total % 2 != 0:
            return False

        target = total // 2
        n = len(nums)
        dp = [[False] * (target + 1) for _ in range(n + 1)]

        for i in range(n + 1):
            dp[i][0] = True

        for i in range(1, n + 1):
            for j in range(1, target + 1):
                if nums[i - 1] <= j:
                    dp[i][j] = dp[i - 1][j] or dp[i - 1][j - nums[i - 1]]
                else:
                    dp[i][j] = dp[i - 1][j]

        return dp[n][target]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_SpaceOptimized
    set output_file "can_partition_dp1d_next.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        if sum(nums) % 2:
            return False

        target = sum(nums) // 2
        dp = [False] * (target + 1)
        nextDp = [False] * (target + 1)

        dp[0] = True
        for i in range(len(nums)):
            for j in range(1, target + 1):
                if j >= nums[i]:
                    nextDp[j] = dp[j] or dp[j - nums[i]]
                else:
                    nextDp[j] = dp[j]
            dp, nextDp = nextDp, dp

        return dp[target]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_HashSet
    set output_file "can_partition_dp_set.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        if sum(nums) % 2:
            return False

        dp = set()
        dp.add(0)
        target = sum(nums) // 2

        for i in range(len(nums) - 1, -1, -1):
            nextDP = set()
            for t in dp:
                if (t + nums[i]) == target:
                    return True
                nextDP.add(t + nums[i])
                nextDP.add(t)
            dp = nextDP
        return False
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_Optimal
    set output_file "can_partition_dp1d_optimized.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        if sum(nums) % 2:
            return False

        target = sum(nums) // 2
        dp = [False] * (target + 1)

        dp[0] = True
        for num in nums:
            for j in range(target, num - 1, -1):
                dp[j] = dp[j] or dp[j - num]

        return dp[target]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionEqualSubsetSum.DynamicProgramming_Bitset
    set output_file "can_partition_bitmask_dp.py"

    set template_content 'from typing import List

class Solution:
    def canPartition(self, nums: List[int]) -> bool:
        total = sum(nums)
        if total % 2 != 0:
            return False

        target = total // 2
        dp = 1 << 0

        for num in nums:
            dp |= dp << num

        return (dp & (1 << target)) != 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.InsertInterval.LinearSearch
    set output_file "insert_interval_linear.py"

    set template_content 'from typing import List

class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        n = len(intervals)
        i = 0
        res = []

        while i < n and intervals[i][1] < newInterval[0]:
            res.append(intervals[i])
            i += 1

        while i < n and newInterval[1] >= intervals[i][0]:
            newInterval[0] = min(newInterval[0], intervals[i][0])
            newInterval[1] = max(newInterval[1], intervals[i][1])
            i += 1
        res.append(newInterval)

        while i < n:
            res.append(intervals[i])
            i += 1

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.InsertInterval.BinarySearch
    set output_file "insert_interval_binary_search.py"

    set template_content 'from typing import List

class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[List[int]]) -> List[List[int]]:
        if not intervals:
            return [newInterval]

        n = len(intervals)
        target = newInterval[0]
        left, right = 0, n - 1

        while left <= right:
            mid = (left + right) // 2
            if intervals[mid][0] < target:
                left = mid + 1
            else:
                right = mid - 1

        intervals.insert(left, newInterval)

        res = []
        for interval in intervals:
            if not res or res[-1][1] < interval[0]:
                res.append(interval)
            else:
                res[-1][1] = max(res[-1][1], interval[1])
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.InsertInterval.Greedy
    set output_file "insert_interval_one_pass.py"

    set template_content 'from typing import List

class Solution:
    def insert(self, intervals: List[List[int]], newInterval: List[int]) -> List[List[int]]:
        res = []

        for i in range(len(intervals)):
            if newInterval[1] < intervals[i][0]:
                res.append(newInterval)
                return res + intervals[i:]
            elif newInterval[0] > intervals[i][1]:
                res.append(intervals[i])
            else:
                newInterval = [
                    min(newInterval[0], intervals[i][0]),
                    max(newInterval[1], intervals[i][1]),
                ]
        res.append(newInterval)
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.MergeIntervals.Sorting
    set output_file "merge_intervals_sort_merge.py"

    set template_content 'from typing import List

class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        intervals.sort(key=lambda pair: pair[0])
        output = [intervals[0]]

        for start, end in intervals:
            lastEnd = output[-1][1]

            if start <= lastEnd:
                output[-1][1] = max(lastEnd, end)
            else:
                output.append([start, end])
        return output
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeIntervals.SweepLineAlgorithm
    set output_file "merge_intervals_sweep_line.py"

    set template_content 'from typing import List
from collections import defaultdict

class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        mp = defaultdict(int)
        for start, end in intervals:
            mp[start] += 1
            mp[end] -= 1

        res = []
        interval = []
        have = 0
        for i in sorted(mp):
            if not interval:
                interval.append(i)
            have += mp[i]
            if have == 0:
                interval.append(i)
                res.append(interval)
                interval = []
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MergeIntervals.Greedy
    set output_file "merge_intervals_array_sweep.py"

    set template_content 'from typing import List

class Solution:
    def merge(self, intervals: List[List[int]]) -> List[List[int]]:
        max_val = max(interval[0] for interval in intervals)

        mp = [0] * (max_val + 1)
        for start, end in intervals:
            mp[start] = max(end + 1, mp[start])

        res = []
        have = -1
        interval_start = -1
        for i in range(len(mp)):
            if mp[i] != 0:
                if interval_start == -1:
                    interval_start = i
                have = max(mp[i] - 1, have)
            if have == i:
                res.append([interval_start, have])
                have = -1
                interval_start = -1

        if interval_start != -1:
            res.append([interval_start, have])

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NonOverlappingIntervals.Recursion
    set output_file "erase_overlap_intervals_dfs.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort()

        def dfs(i, prev):
            if i == len(intervals):
                return 0

            res = dfs(i + 1, prev)
            if prev == -1 or intervals[prev][1] <= intervals[i][0]:
                res = max(res, 1 + dfs(i + 1, i))
            return res

        return len(intervals) - dfs(0, -1)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NonOverlappingIntervals.DynamicProgramming_Top-Down
    set output_file "erase_overlap_intervals_dfs_memo.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        n = len(intervals)
        memo = {}

        def dfs(i):
            if i in memo:
                return memo[i]

            res = 1
            for j in range(i + 1, n):
                if intervals[i][1] <= intervals[j][0]:
                    res = max(res, 1 + dfs(j))
            memo[i] = res
            return res

        return n - dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NonOverlappingIntervals.DynamicProgramming_Bottom-Up
    set output_file "erase_overlap_intervals_dp_n2.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        n = len(intervals)
        dp = [0] * n

        for i in range(n):
            dp[i] = 1
            for j in range(i):
                if intervals[j][1] <= intervals[i][0]:
                    dp[i] = max(dp[i], 1 + dp[j])

        return n - max(dp)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NonOverlappingIntervals.DynamicProgramming_BinarySearch
    set output_file "erase_overlap_intervals_dp_bs.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        n = len(intervals)
        dp = [0] * n
        dp[0] = 1

        def bs(r, target):
            l = 0
            while l < r:
                m = (l + r) >> 1
                if intervals[m][1] <= target:
                    l = m + 1
                else:
                    r = m
            return l

        for i in range(1, n):
            idx = bs(i, intervals[i][0])
            if idx == 0:
                dp[i] = dp[i - 1]
            else:
                dp[i] = max(dp[i - 1], 1 + dp[idx - 1])

        return n - dp[n - 1]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NonOverlappingIntervals.Greedy_SortByStart
    set output_file "erase_overlap_intervals_greedy_start.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort()
        res = 0
        prevEnd = intervals[0][1]

        for start, end in intervals[1:]:
            if start >= prevEnd:
                prevEnd = end
            else:
                res += 1
                prevEnd = min(end, prevEnd)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NonOverlappingIntervals.Greedy_SortByEnd
    set output_file "erase_overlap_intervals_greedy_end.py"

    set template_content 'from typing import List

class Solution:
    def eraseOverlapIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda pair: pair[1])
        prevEnd = intervals[0][1]
        res = 0

        for i in range(1, len(intervals)):
            if prevEnd > intervals[i][0]:
                res += 1
            else:
                prevEnd = intervals[i][1]

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRooms.BruteForce
    set output_file "meeting_rooms_can_attend_bruteforce.py"

    set template_content 'from typing import List

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def canAttendMeetings(self, intervals: List[Interval]) -> bool:
        n = len(intervals)
        for i in range(n):
            A = intervals[i]
            for j in range(i + 1, n):
                B = intervals[j]
                if min(A.end, B.end) > max(A.start, B.start):
                    return False
        return True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRooms.Sorting
    set output_file "meeting_rooms_can_attend_sort.py"

    set template_content 'from typing import List

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def canAttendMeetings(self, intervals: List[Interval]) -> bool:
        intervals.sort(key=lambda i: i.start)

        for i in range(1, len(intervals)):
            prev = intervals[i - 1]
            curr = intervals[i]

            if prev.end > curr.start:
                return False
        return True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRoomsII.MinHeap
    set output_file "meeting_rooms_min_heap.py"

    set template_content 'from typing import List
import heapq

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def minMeetingRooms(self, intervals: List[Interval]) -> int:
        intervals.sort(key=lambda x: x.start)
        min_heap = []

        for interval in intervals:
            if min_heap and min_heap[0] <= interval.start:
                heapq.heappop(min_heap)
            heapq.heappush(min_heap, interval.end)

        return len(min_heap)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRoomsII.SweepLineAlgorithm
    set output_file "meeting_rooms_sweep_map.py"

    set template_content 'from typing import List
from collections import defaultdict

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def minMeetingRooms(self, intervals: List[Interval]) -> int:
        mp = defaultdict(int)
        for i in intervals:
            mp[i.start] += 1
            mp[i.end] -= 1

        prev = 0
        res = 0
        for i in sorted(mp.keys()):
            prev += mp[i]
            res = max(res, prev)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRoomsII.TwoPointers
    set output_file "meeting_rooms_two_pointers.py"

    set template_content 'from typing import List

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def minMeetingRooms(self, intervals: List[Interval]) -> int:
        start = sorted([i.start for i in intervals])
        end = sorted([i.end for i in intervals])

        res = count = 0
        s = e = 0
        while s < len(intervals):
            if start[s] < end[e]:
                s += 1
                count += 1
            else:
                e += 1
                count -= 1
            res = max(res, count)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MeetingRoomsII.Greedy
    set output_file "meeting_rooms_events.py"

    set template_content 'from typing import List

"""
Definition of Interval:
class Interval(object):
    def __init__(self, start, end):
        self.start = start
        self.end = end
"""

class Solution:
    def minMeetingRooms(self, intervals: List[Interval]) -> int:
        time = []
        for i in intervals:
            time.append((i.start, 1))
            time.append((i.end, -1))

        time.sort(key=lambda x: (x[0], x[1]))

        res = count = 0
        for _, delta in time:
            count += delta
            res = max(res, count)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NetworkDelayTime.DepthFirstSearch
    set output_file "network_delay_time_dfs.py"

    set template_content 'from typing import List
from collections import defaultdict

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        adj = defaultdict(list)
        for u, v, w in times:
            adj[u].append((v, w))

        dist = {node: float("inf") for node in range(1, n + 1)}

        def dfs(node, time):
            if time >= dist[node]:
                return
            dist[node] = time
            for nei, w in adj[node]:
                dfs(nei, time + w)

        dfs(k, 0)
        res = max(dist.values())
        return res if res < float("inf") else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NetworkDelayTime.FloydWarshallAlgorithm
    set output_file "network_delay_time_floyd_warshall.py"

    set template_content 'from typing import List

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        inf = float("inf")
        dist = [[inf] * n for _ in range(n)]

        for u, v, w in times:
            dist[u - 1][v - 1] = w
        for i in range(n):
            dist[i][i] = 0

        for mid in range(n):
            for i in range(n):
                for j in range(n):
                    dist[i][j] = min(dist[i][j], dist[i][mid] + dist[mid][j])

        res = max(dist[k - 1])
        return res if res < inf else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NetworkDelayTime.BellmanFordAlgorithm
    set output_file "network_delay_time_bellman_ford.py"

    set template_content 'from typing import List

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        dist = [float("inf")] * n
        dist[k - 1] = 0

        for _ in range(n - 1):
            for u, v, w in times:
                if dist[u - 1] + w < dist[v - 1]:
                    dist[v - 1] = dist[u - 1] + w

        res = max(dist)
        return res if res < float("inf") else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NetworkDelayTime.ShortestPathFasterAlgorithm
    set output_file "network_delay_time_bfs.py"

    set template_content 'from typing import List
from collections import defaultdict, deque

class Solution:
    def networkDelayTime(self, times, n, k):
        adj = defaultdict(list)
        for u, v, w in times:
            adj[u].append((v, w))

        dist = {node: float("inf") for node in range(1, n + 1)}
        q = deque([(k, 0)])
        dist[k] = 0

        while q:
            node, time = q.popleft()
            if time > dist[node]:
                continue
            for nei, w in adj[node]:
                if time + w < dist[nei]:
                    dist[nei] = time + w
                    q.append((nei, time + w))

        res = max(dist.values())
        return res if res < float("inf") else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NetworkDelayTime.DijkstraAlgorithm
    set output_file "network_delay_time_dijkstra.py"

    set template_content 'from typing import List
import heapq
import collections

class Solution:
    def networkDelayTime(self, times: List[List[int]], n: int, k: int) -> int:
        edges = collections.defaultdict(list)
        for u, v, w in times:
            edges[u].append((v, w))

        minHeap = [(0, k)]
        visit = set()
        t = 0

        while minHeap:
            w1, n1 = heapq.heappop(minHeap)
            if n1 in visit:
                continue
            visit.add(n1)
            t = w1

            for n2, w2 in edges[n1]:
                if n2 not in visit:
                    heapq.heappush(minHeap, (w1 + w2, n2))

        return t if len(visit) == n else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostConnectPoints.KruskalAlgorithm
    set output_file "min_cost_connect_points_kruskal.py"

    set template_content 'from typing import List

class DSU:
    def __init__(self, n):
        self.Parent = list(range(n))
        self.Size = [1] * n

    def find(self, node):
        if self.Parent[node] != node:
            self.Parent[node] = self.find(self.Parent[node])
        return self.Parent[node]

    def union(self, u, v):
        pu = self.find(u)
        pv = self.find(v)
        if pu == pv:
            return False
        if self.Size[pu] < self.Size[pv]:
            pu, pv = pv, pu
        self.Parent[pv] = pu
        self.Size[pu] += self.Size[pv]
        return True

class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        dsu = DSU(n)
        edges = []

        for i in range(n):
            for j in range(i + 1, n):
                dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                edges.append((dist, i, j))

        edges.sort()
        res = 0
        for dist, u, v in edges:
            if dsu.union(u, v):
                res += dist
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostConnectPoints.PrimAlgorithm
    set output_file "min_cost_connect_points_prim_heap.py"

    set template_content 'from typing import List
import heapq

class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        N = len(points)
        adj = {i: [] for i in range(N)}

        for i in range(N):
            for j in range(i + 1, N):
                dist = abs(points[i][0] - points[j][0]) + abs(points[i][1] - points[j][1])
                adj[i].append((dist, j))
                adj[j].append((dist, i))

        res = 0
        visit = set()
        minH = [(0, 0)]

        while len(visit) < N:
            cost, i = heapq.heappop(minH)
            if i in visit:
                continue
            visit.add(i)
            res += cost
            for neiCost, nei in adj[i]:
                if nei not in visit:
                    heapq.heappush(minH, (neiCost, nei))
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MinCostConnectPoints.PrimAlgorithm_Optimal
    set output_file "min_cost_connect_points_prim_optimized.py"

    set template_content 'from typing import List

class Solution:
    def minCostConnectPoints(self, points: List[List[int]]) -> int:
        n = len(points)
        dist = [10**8] * n
        visit = [False] * n

        node = 0
        res = 0

        for _ in range(n - 1):
            visit[node] = True
            nextNode = -1

            for i in range(n):
                if visit[i]:
                    continue
                curDist = abs(points[i][0] - points[node][0]) + abs(points[i][1] - points[node][1])
                dist[i] = min(dist[i], curDist)
                if nextNode == -1 or dist[i] < dist[nextNode]:
                    nextNode = i

            res += dist[nextNode]
            node = nextNode

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheapestFlightsWithinStops.DijkstraAlgorithm
    set output_file "cheapest_flights_dijkstra_k_stops.py"

    set template_content 'from typing import List
import heapq

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        INF = float("inf")
        adj = [[] for _ in range(n)]

        for u, v, w in flights:
            adj[u].append((v, w))

        dist = [[INF] * (k + 2) for _ in range(n)]
        dist[src][0] = 0

        minH = [(0, src, 0)]  # cost, node, stops

        while minH:
            cost, node, stops = heapq.heappop(minH)
            if node == dst:
                return cost
            if stops > k:
                continue

            for nei, w in adj[node]:
                newCost = cost + w
                if newCost < dist[nei][stops + 1]:
                    dist[nei][stops + 1] = newCost
                    heapq.heappush(minH, (newCost, nei, stops + 1))

        return -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheapestFlightsWithinStops.BellmanFordAlgorithm
    set output_file "cheapest_flights_bellman_ford.py"

    set template_content 'from typing import List

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        INF = float("inf")
        prices = [INF] * n
        prices[src] = 0

        for _ in range(k + 1):
            tmp = prices[:]
            for u, v, w in flights:
                if prices[u] == INF:
                    continue
                if prices[u] + w < tmp[v]:
                    tmp[v] = prices[u] + w
            prices = tmp

        return -1 if prices[dst] == INF else prices[dst]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CheapestFlightsWithinStops.ShortestPathFasterAlgorithm
    set output_file "cheapest_flights_bfs_k_stops.py"

    set template_content 'from typing import List
from collections import deque

class Solution:
    def findCheapestPrice(self, n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:
        INF = float("inf")
        prices = [INF] * n
        prices[src] = 0

        adj = [[] for _ in range(n)]
        for u, v, w in flights:
            adj[u].append((v, w))

        q = deque([(src, 0, 0)])  # node, cost, stops

        while q:
            node, cost, stops = q.popleft()
            if stops > k:
                continue

            for nei, w in adj[node]:
                newCost = cost + w
                if newCost < prices[nei]:
                    prices[nei] = newCost
                    q.append((nei, newCost, stops + 1))

        return -1 if prices[dst] == INF else prices[dst]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumSubarray.BruteForce
    set output_file "max_subarray_bruteforce.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        n, res = len(nums), nums[0]
        for i in range(n):
            cur = 0
            for j in range(i, n):
                cur += nums[j]
                res = max(res, cur)
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumSubarray.Recursion
    set output_file "max_subarray_dfs.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        def dfs(i, flag):
            if i == len(nums):
                return 0 if flag else -1e6
            if flag:
                return max(0, nums[i] + dfs(i + 1, True))
            return max(dfs(i + 1, False), nums[i] + dfs(i + 1, True))
        return dfs(0, False)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumSubarray.DynamicProgramming_Top-Down
    set output_file "max_subarray_dfs_memo.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        memo = [[None] * 2 for _ in range(len(nums) + 1)]

        def dfs(i, flag):
            if i == len(nums):
                return 0 if flag else -1e6
            if memo[i][flag] is not None:
                return memo[i][flag]
            if flag:
                memo[i][flag] = max(0, nums[i] + dfs(i + 1, True))
            else:
                memo[i][flag] = max(dfs(i + 1, False),
                                    nums[i] + dfs(i + 1, True))
            return memo[i][flag]

        return dfs(0, False)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MaximumSubarray.DynamicProgramming_Bottom-Up
    set output_file "max_subarray_dp2d.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [[0] * 2 for _ in range(n)]
        dp[n - 1][1] = dp[n - 1][0] = nums[n - 1]
        for i in range(n - 2, -1, -1):
            dp[i][1] = max(nums[i], nums[i] + dp[i + 1][1])
            dp[i][0] = max(dp[i + 1][0], dp[i][1])
        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumSubarray.DynamicProgramming_SpaceOptimized
    set output_file "max_subarray_dp1d.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums):
        dp = nums[:]
        for i in range(1, len(nums)):
            dp[i] = max(nums[i], nums[i] + dp[i - 1])
        return max(dp)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumSubarray.KadaneAlgorithm
    set output_file "max_subarray_kadane.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        maxSub, curSum = nums[0], 0
        for num in nums:
            if curSum < 0:
                curSum = 0
            curSum += num
            maxSub = max(maxSub, curSum)
        return maxSub
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MaximumSubarray.DivideConquer
    set output_file "max_subarray_divide_conquer.py"

    set template_content 'from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        def dfs(l, r):
            if l > r:
                return float("-inf")

            m = (l + r) >> 1
            leftSum = rightSum = curSum = 0
            for i in range(m - 1, l - 1, -1):
                curSum += nums[i]
                leftSum = max(leftSum, curSum)

            curSum = 0
            for i in range(m + 1, r + 1):
                curSum += nums[i]
                rightSum = max(rightSum, curSum)

            return max(dfs(l, m - 1),
                       dfs(m + 1, r),
                       leftSum + nums[m] + rightSum)

        return dfs(0, len(nums) - 1)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.JumpGame.Recursion
    set output_file "jump_game_dfs.py"

    set template_content 'from typing import List

class Solution:
    def canJump(self, nums: List[int]) -> bool:
        def dfs(i):
            if i == len(nums) - 1:
                return True
            end = min(len(nums) - 1, i + nums[i])
            for j in range(i + 1, end + 1):
                if dfs(j):
                    return True
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JumpGame.DynamicProgramming_Top-Down
    set output_file "jump_game_dfs_memo.py"

    set template_content 'from typing import List

class Solution:
    def canJump(self, nums: List[int]) -> bool:
        memo = {}

        def dfs(i):
            if i in memo:
                return memo[i]
            if i == len(nums) - 1:
                return True
            if nums[i] == 0:
                return False

            end = min(len(nums), i + nums[i] + 1)
            for j in range(i + 1, end):
                if dfs(j):
                    memo[i] = True
                    return True
            memo[i] = False
            return False

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.JumpGame.DynamicProgramming_Bottom-Up
    set output_file "jump_game_dp.py"

    set template_content 'from typing import List

class Solution:
    def canJump(self, nums: List[int]) -> bool:
        n = len(nums)
        dp = [False] * n
        dp[-1] = True

        for i in range(n - 2, -1, -1):
            end = min(n, i + nums[i] + 1)
            for j in range(i + 1, end):
                if dp[j]:
                    dp[i] = True
                    break
        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JumpGame.Greedy
    set output_file "jump_game_greedy.py"

    set template_content 'from typing import List

class Solution:
    def canJump(self, nums: List[int]) -> bool:
        goal = len(nums) - 1

        for i in range(len(nums) - 2, -1, -1):
            if i + nums[i] >= goal:
                goal = i
        return goal == 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.JumpGameII.Recursion
    set output_file "jump_game_ii_dfs.py"

    set template_content 'from typing import List

class Solution:
    def jump(self, nums: List[int]) -> int:
        def dfs(i):
            if i == len(nums) - 1:
                return 0
            if nums[i] == 0:
                return float("inf")

            end = min(len(nums) - 1, i + nums[i])
            res = float("inf")
            for j in range(i + 1, end + 1):
                res = min(res, 1 + dfs(j))
            return res

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JumpGameII.DynamicProgramming_Top-Dowт
    set output_file "jump_game_ii_dfs_memo.py"

    set template_content 'from typing import List

class Solution:
    def jump(self, nums: List[int]) -> int:
        memo = {}

        def dfs(i):
            if i in memo:
                return memo[i]
            if i == len(nums) - 1:
                return 0
            if nums[i] == 0:
                return 1000000

            res = 1000000
            end = min(len(nums), i + nums[i] + 1)
            for j in range(i + 1, end):
                res = min(res, 1 + dfs(j))
            memo[i] = res
            return res

        return dfs(0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.JumpGameII.DynamicProgramming_Bottom-Up
    set output_file "jump_game_ii_dp.py"

    set template_content 'from typing import List

class Solution:
    def jump(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [1000000] * n
        dp[-1] = 0

        for i in range(n - 2, -1, -1):
            end = min(n, i + nums[i] + 1)
            for j in range(i + 1, end):
                dp[i] = min(dp[i], 1 + dp[j])
        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.JumpGameII.BreadthFirstSearch_Greedy
    set output_file "jump_game_ii_greedy.py"

    set template_content 'from typing import List

class Solution:
    def jump(self, nums: List[int]) -> int:
        res = 0
        l = r = 0

        while r < len(nums) - 1:
            farthest = 0
            for i in range(l, r + 1):
                farthest = max(farthest, i + nums[i])
            l = r + 1
            r = farthest
            res += 1
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GasStation.BruteForce
    set output_file "gas_station_bruteforce.py"

    set template_content 'from typing import List

class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        n = len(gas)

        for i in range(n):
            tank = gas[i] - cost[i]
            if tank < 0:
                continue

            j = (i + 1) % n
            while j != i:
                tank += gas[j] - cost[j]
                if tank < 0:
                    break
                j = (j + 1) % n

            if j == i:
                return i
        return -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GasStation.TwoPointers
    set output_file "gas_station_two_pointers.py"

    set template_content 'from typing import List

class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        n = len(gas)
        start, end = n - 1, 0
        tank = gas[start] - cost[start]

        while start > end:
            if tank < 0:
                start -= 1
                tank += gas[start] - cost[start]
            else:
                tank += gas[end] - cost[end]
                end += 1

        return start if tank >= 0 else -1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.GasStation.Greedy
    set output_file "gas_station_greedy.py"

    set template_content 'from typing import List

class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        if sum(gas) < sum(cost):
            return -1

        total = 0
        res = 0
        for i in range(len(gas)):
            total += gas[i] - cost[i]
            if total < 0:
                total = 0
                res = i + 1

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HandOfStraights.Sorting
    set output_file "hand_of_straights_sort_counter.py"

    set template_content 'from typing import List
from collections import Counter

class Solution:
    def isNStraightHand(self, hand: List[int], groupSize: int) -> bool:
        if len(hand) % groupSize:
            return False

        count = Counter(hand)
        hand.sort()

        for num in hand:
            if count[num]:
                for x in range(num, num + groupSize):
                    if count[x] == 0:
                        return False
                    count[x] -= 1
        return True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.HandOfStraights.Heap
    set output_file "hand_of_straights_heap.py"

    set template_content 'from typing import List
from collections import Counter
import heapq

class Solution:
    def isNStraightHand(self, hand: List[int], groupSize: int) -> bool:
        if len(hand) % groupSize:
            return False

        count = Counter(hand)
        minH = list(count.keys())
        heapq.heapify(minH)

        while minH:
            first = minH[0]
            for i in range(first, first + groupSize):
                if i not in count:
                    return False
                count[i] -= 1
                if count[i] == 0:
                    if i != minH[0]:
                        return False
                    heapq.heappop(minH)
        return True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HandOfStraights.OrderedMap
    set output_file "hand_of_straights_open_groups.py"

    set template_content 'from typing import List
from collections import Counter, deque

class Solution:
    def isNStraightHand(self, hand: List[int], groupSize: int) -> bool:
        if len(hand) % groupSize:
            return False

        count = Counter(hand)
        q = deque()
        open_groups = 0
        last = -1

        for num in sorted(count):
            if (open_groups and num != last + 1) or open_groups > count[num]:
                return False

            q.append(count[num] - open_groups)
            last = num
            open_groups = count[num]

            if len(q) == groupSize:
                open_groups -= q.popleft()

        return open_groups == 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.HandOfStraights.HashMap
    set output_file "hand_of_straights_backward_expand.py"

    set template_content 'from typing import List
from collections import Counter

class Solution:
    def isNStraightHand(self, hand: List[int], groupSize: int) -> bool:
        if len(hand) % groupSize:
            return False

        count = Counter(hand)

        for num in hand:
            start = num
            while count[start - 1]:
                start -= 1

            while count[start]:
                for x in range(start, start + groupSize):
                    if count[x] == 0:
                        return False
                    count[x] -= 1
                start += 1
        return True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MergeTripletsFormTarget.Greedy
    set output_file "merge_triplets_set_greedy.py"

    set template_content 'from typing import List

class Solution:
    def mergeTriplets(self, triplets: List[List[int]], target: List[int]) -> bool:
        good = set()

        for t in triplets:
            if t[0] > target[0] or t[1] > target[1] or t[2] > target[2]:
                continue

            for i in range(3):
                if t[i] == target[i]:
                    good.add(i)

        return len(good) == 3
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MergeTripletsFormTarget.Greedy_Optimal
    set output_file "merge_triplets_boolean_greedy.py"

    set template_content 'from typing import List

class Solution:
    def mergeTriplets(self, triplets: List[List[int]], target: List[int]) -> bool:
        x = y = z = False

        for a, b, c in triplets:
            if a == target[0] and b <= target[1] and c <= target[2]:
                x = True
            if a <= target[0] and b == target[1] and c <= target[2]:
                y = True
            if a <= target[0] and b <= target[1] and c == target[2]:
                z = True

            if x and y and z:
                return True

        return False
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PartitionLabels.TwoPointers
    set output_file "partition_labels_greedy.py"

    set template_content 'from typing import List

class Solution:
    def partitionLabels(self, s: str) -> List[int]:
        lastIndex = {}
        for i, c in enumerate(s):
            lastIndex[c] = i

        res = []
        size = 0
        end = 0

        for i, c in enumerate(s):
            size += 1
            end = max(end, lastIndex[c])

            if i == end:
                res.append(size)
                size = 0

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParenthesisString.Recursion
    set output_file "valid_parenthesis_string_dfs.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        def dfs(i, open):
            if open < 0:
                return False
            if i == len(s):
                return open == 0

            if s[i] == "(":
                return dfs(i + 1, open + 1)
            elif s[i] == ")":
                return dfs(i + 1, open - 1)
            else:
                return (dfs(i + 1, open) or
                        dfs(i + 1, open + 1) or
                        dfs(i + 1, open - 1))

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParenthesisString.DynamicProgramming_Top-Down
    set output_file "valid_parenthesis_string_dfs_memo.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        n = len(s)
        memo = {}

        def dfs(i, open):
            if open < 0:
                return False
            if i == n:
                return open == 0
            if (i, open) in memo:
                return memo[(i, open)]

            if s[i] == "(":
                res = dfs(i + 1, open + 1)
            elif s[i] == ")":
                res = dfs(i + 1, open - 1)
            else:
                res = (dfs(i + 1, open) or
                       dfs(i + 1, open + 1) or
                       dfs(i + 1, open - 1))

            memo[(i, open)] = res
            return res

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParenthesisString.DynamicProgramming_Bottom-Up
    set output_file "valid_parenthesis_string_dp_2d.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        n = len(s)
        dp = [[False] * (n + 1) for _ in range(n + 1)]
        dp[n][0] = True

        for i in range(n - 1, -1, -1):
            for open in range(n):
                if s[i] == "*":
                    dp[i][open] = (dp[i + 1][open] or
                                   dp[i + 1][open + 1] or
                                   (open > 0 and dp[i + 1][open - 1]))
                elif s[i] == "(":
                    dp[i][open] = dp[i + 1][open + 1]
                elif open > 0:
                    dp[i][open] = dp[i + 1][open - 1]

        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParenthesisString.DynamicProgramming_SpaceOptimized
    set output_file "valid_parenthesis_string_dp_1d.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        n = len(s)
        dp = [False] * (n + 1)
        dp[0] = True

        for i in range(n - 1, -1, -1):
            new_dp = [False] * (n + 1)
            for open in range(n):
                if s[i] == "*":
                    new_dp[open] = (dp[open] or
                                    dp[open + 1] or
                                    (open > 0 and dp[open - 1]))
                elif s[i] == "(":
                    new_dp[open] = dp[open + 1]
                elif open > 0:
                    new_dp[open] = dp[open - 1]
            dp = new_dp

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ValidParenthesisString.Stack
    set output_file "valid_parenthesis_string_stack.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        left = []
        star = []

        for i, c in enumerate(s):
            if c == "(":
                left.append(i)
            elif c == "*":
                star.append(i)
            else:
                if left:
                    left.pop()
                elif star:
                    star.pop()
                else:
                    return False

        while left and star:
            if left.pop() > star.pop():
                return False

        return not left
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ValidParenthesisString.Greedy
    set output_file "valid_parenthesis_string_greedy.py"

    set template_content 'class Solution:
    def checkValidString(self, s: str) -> bool:
        leftMin = leftMax = 0

        for c in s:
            if c == "(":
                leftMin += 1
                leftMax += 1
            elif c == ")":
                leftMin -= 1
                leftMax -= 1
            else:
                leftMin -= 1
                leftMax += 1

            if leftMax < 0:
                return False
            if leftMin < 0:
                leftMin = 0

        return leftMin == 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SingleNumber.BruteForce
    set output_file "single_number_bruteforce.py"

    set template_content 'from typing import List

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        for i in range(len(nums)):
            flag = True
            for j in range(len(nums)):
                if i != j and nums[i] == nums[j]:
                    flag = False
                    break
            if flag:
                return nums[i]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SingleNumber.HashSet
    set output_file "single_number_hashset.py"

    set template_content 'from typing import List

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        seen = set()
        for num in nums:
            if num in seen:
                seen.remove(num)
            else:
                seen.add(num)
        return list(seen)[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SingleNumber.Sorting
    set output_file "single_number_sorting.py"

    set template_content 'from typing import List

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        nums.sort()
        i = 0
        while i < len(nums) - 1:
            if nums[i] == nums[i + 1]:
                i += 2
            else:
                return nums[i]
        return nums[i]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SingleNumber.BitManipulation
    set output_file "single_number_xor.py"

    set template_content 'from typing import List

class Solution:
    def singleNumber(self, nums: List[int]) -> int:
        res = 0
        for num in nums:
            res ^= num
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.NumberOneBits.BitMaskI
    set output_file "hamming_weight_fixedbits.py"

    set template_content 'class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        for i in range(32):
            if (1 << i) & n:
                res += 1
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberOneBits.BitMaskII
    set output_file "hamming_weight_bitshift.py"

    set template_content 'class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            res += 1 if n & 1 else 0
            n >>= 1
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberOneBits.BitMask_Optimal
    set output_file "hamming_weight_kernighan.py"

    set template_content 'class Solution:
    def hammingWeight(self, n: int) -> int:
        res = 0
        while n:
            n &= n - 1
            res += 1
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.NumberOneBits.BuiltInFunction
    set output_file "hamming_weight_builtin.py"

    set template_content 'class Solution:
    def hammingWeight(self, n: int) -> int:
        return bin(n).count("1")
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountingBits.BitManipulationI
    set output_file "count_bits_fixedbits.py"

    set template_content 'from typing import List

class Solution:
    def countBits(self, n: int) -> List[int]:
        res = []
        for num in range(n + 1):
            one = 0
            for i in range(32):
                if num & (1 << i):
                    one += 1
            res.append(one)
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountingBits.BitManipulationII
    set output_file "count_bits_kernighan.py"

    set template_content 'from typing import List

class Solution:
    def countBits(self, n: int) -> List[int]:
        res = [0] * (n + 1)
        for i in range(1, n + 1):
            num = i
            while num != 0:
                res[i] += 1
                num &= (num - 1)
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountingBits.In-BuiltFunction
    set output_file "count_bits_builtin.py"

    set template_content 'from typing import List

class Solution:
    def countBits(self, n: int) -> List[int]:
        return [bin(i).count("1") for i in range(n + 1)]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.CountingBits.BitManipulationDP
    set output_file "count_bits_dp_offset.py"

    set template_content 'from typing import List

class Solution:
    def countBits(self, n: int) -> List[int]:
        dp = [0] * (n + 1)
        offset = 1

        for i in range(1, n + 1):
            if offset * 2 == i:
                offset = i
            dp[i] = 1 + dp[i - offset]
        return dp
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.CountingBits.BitManipulation_Optimal
    set output_file "count_bits_dp_shift.py"

    set template_content 'from typing import List

class Solution:
    def countBits(self, n: int) -> List[int]:
        dp = [0] * (n + 1)
        for i in range(n + 1):
            dp[i] = dp[i >> 1] + (i & 1)
        return dp
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseBits.BruteForce
    set output_file "reverse_bits_string.py"

    set template_content 'class Solution:
    def reverseBits(self, n: int) -> int:
        binary = ""
        for i in range(32):
            if n & (1 << i):
                binary += "1"
            else:
                binary += "0"

        res = 0
        for i, bit in enumerate(binary[::-1]):
            if bit == "1":
                res |= (1 << i)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseBits.BitManipulation
    set output_file "reverse_bits_shift.py"

    set template_content 'class Solution:
    def reverseBits(self, n: int) -> int:
        res = 0
        for i in range(32):
            bit = (n >> i) & 1
            res += (bit << (31 - i))
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.ReverseBits.BitManipulation_Optimal
    set output_file "reverse_bits_dc.py"

    set template_content 'class Solution:
    def reverseBits(self, n: int) -> int:
        res = n
        res = (res >> 16) | ((res << 16) & 0xFFFFFFFF)
        res = ((res & 0xff00ff00) >> 8) | ((res & 0x00ff00ff) << 8)
        res = ((res & 0xf0f0f0f0) >> 4) | ((res & 0x0f0f0f0f) << 4)
        res = ((res & 0xcccccccc) >> 2) | ((res & 0x33333333) << 2)
        res = ((res & 0xaaaaaaaa) >> 1) | ((res & 0x55555555) << 1)
        return res & 0xFFFFFFFF
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MissingNumber.Sorting
    set output_file "missing_number_sort.py"

    set template_content 'from typing import List

class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        nums.sort()
        for i in range(n):
            if nums[i] != i:
                return i
        return n
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MissingNumber.HashSet
    set output_file "missing_number_hashset.py"

    set template_content 'from typing import List

class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        num_set = set(nums)
        n = len(nums)
        for i in range(n + 1):
            if i not in num_set:
                return i
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MissingNumber.BitwiseXOR
    set output_file "missing_number_xor.py"

    set template_content 'from typing import List

class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        n = len(nums)
        xorr = n
        for i in range(n):
            xorr ^= i ^ nums[i]
        return xorr
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.MissingNumber.Math
    set output_file "missing_number_sum.py"

    set template_content 'from typing import List

class Solution:
    def missingNumber(self, nums: List[int]) -> int:
        res = len(nums)
        for i in range(len(nums)):
            res += i - nums[i]
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SumTwoIntegers.BruteForce
    set output_file "sum_of_two_integers_builtin.py"

    set template_content 'class Solution:
    def getSum(self, a: int, b: int) -> int:
        return a + b
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SumTwoIntegers.BitManipulation
    set output_file "sum_of_two_integers_bit_by_bit.py"

    set template_content 'class Solution:
    def getSum(self, a: int, b: int) -> int:
        carry = 0
        res = 0
        mask = 0xFFFFFFFF

        for i in range(32):
            a_bit = (a >> i) & 1
            b_bit = (b >> i) & 1
            cur_bit = a_bit ^ b_bit ^ carry
            carry = (a_bit + b_bit + carry) >= 2
            if cur_bit:
                res |= (1 << i)

        if res > 0x7FFFFFFF:
            res = ~(res ^ mask)

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.SumTwoIntegers.BitManipulation_Optimal
    set output_file "sum_of_two_integers_bitwise.py"

    set template_content 'class Solution:
    def getSum(self, a: int, b: int) -> int:
        mask = 0xFFFFFFFF
        max_int = 0x7FFFFFFF

        while b != 0:
            carry = (a & b) << 1
            a = (a ^ b) & mask
            b = carry & mask

        return a if a <= max_int else ~(a ^ mask)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function algoP.ReverseInteger.BruteForce
    set output_file "reverse_integer_string.py"

    set template_content 'class Solution:
    def reverse(self, x: int) -> int:
        org = x
        x = abs(x)
        res = int(str(x)[::-1])

        if org < 0:
            res *= -1

        if res < -(1 << 31) or res > (1 << 31) - 1:
            return 0
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ReverseInteger.Recursion
    set output_file "reverse_integer_recursive.py"

    set template_content 'class Solution:
    def reverse(self, x: int) -> int:
        def rec(n: int, rev: int) -> int:
            if n == 0:
                return rev
            return rec(n // 10, rev * 10 + n % 10)

        sign = -1 if x < 0 else 1
        x = abs(x)
        res = rec(x, 0) * sign

        if res < -(1 << 31) or res > (1 << 31) - 1:
            return 0
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.ReverseInteger.Iteration
    set output_file "reverse_integer_iterative.py"

    set template_content 'import math

class Solution:
    def reverse(self, x: int) -> int:
        MIN = -2147483648
        MAX = 2147483647

        res = 0
        while x:
            digit = int(math.fmod(x, 10))
            x = int(x / 10)

            if res > MAX // 10 or (res == MAX // 10 and digit > MAX % 10):
                return 0
            if res < MIN // 10 or (res == MIN // 10 and digit < MIN % 10):
                return 0

            res = res * 10 + digit

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RotateImage.BruteForce
    set output_file "rotate_image_extra_matrix.py"

    set template_content 'from typing import List

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        n = len(matrix)
        rotated = [[0] * n for _ in range(n)]

        for i in range(n):
            for j in range(n):
                rotated[j][n - 1 - i] = matrix[i][j]

        for i in range(n):
            for j in range(n):
                matrix[i][j] = rotated[i][j]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.RotateImage.RotateByFourCells
    set output_file "rotate_image_in_place.py"

    set template_content 'from typing import List

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        l, r = 0, len(matrix) - 1

        while l < r:
            for i in range(r - l):
                top, bottom = l, r

                topLeft = matrix[top][l + i]

                matrix[top][l + i] = matrix[bottom - i][l]
                matrix[bottom - i][l] = matrix[bottom][r - i]
                matrix[bottom][r - i] = matrix[top + i][r]
                matrix[top + i][r] = topLeft

            l += 1
            r -= 1
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.RotateImage.ReverseAndTranspose
    set output_file "rotate_image_reverse_transpose.py"

    set template_content 'from typing import List

class Solution:
    def rotate(self, matrix: List[List[int]]) -> None:
        # Reverse vertically
        matrix.reverse()

        # Transpose
        n = len(matrix)
        for i in range(n):
            for j in range(i + 1, n):
                matrix[i][j], matrix[j][i] = matrix[j][i], matrix[i][j]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SpiralMatrix.Recursion
    set output_file "spiral_matrix_dfs.py"

    set template_content 'from typing import List

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        m, n = len(matrix), len(matrix[0])
        res = []

        def dfs(row, col, r, c, dr, dc):
            if row == 0 or col == 0:
                return

            for _ in range(col):
                r += dr
                c += dc
                res.append(matrix[r][c])

            dfs(col, row - 1, r, c, dc, -dr)

        dfs(m, n, 0, -1, 0, 1)
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SpiralMatrix.Iteration
    set output_file "spiral_matrix_boundary.py"

    set template_content 'from typing import List

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        res = []
        left, right = 0, len(matrix[0])
        top, bottom = 0, len(matrix)

        while left < right and top < bottom:
            for i in range(left, right):
                res.append(matrix[top][i])
            top += 1

            for i in range(top, bottom):
                res.append(matrix[i][right - 1])
            right -= 1

            if not (left < right and top < bottom):
                break

            for i in range(right - 1, left - 1, -1):
                res.append(matrix[bottom - 1][i])
            bottom -= 1

            for i in range(bottom - 1, top - 1, -1):
                res.append(matrix[i][left])
            left += 1

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SpiralMatrix.Iteration_Optimal
    set output_file "spiral_matrix_directions.py"

    set template_content 'from typing import List

class Solution:
    def spiralOrder(self, matrix: List[List[int]]) -> List[int]:
        res = []
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        steps = [len(matrix[0]), len(matrix) - 1]

        r, c, d = 0, -1, 0
        while steps[d & 1]:
            for _ in range(steps[d & 1]):
                r += directions[d][0]
                c += directions[d][1]
                res.append(matrix[r][c])

            steps[d & 1] -= 1
            d = (d + 1) % 4

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.
    set output_file "set_matrix_zeroes_copy.py"

    set template_content 'from typing import List

class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        ROWS, COLS = len(matrix), len(matrix[0])
        mark = [[matrix[r][c] for c in range(COLS)] for r in range(ROWS)]

        for r in range(ROWS):
            for c in range(COLS):
                if matrix[r][c] == 0:
                    for col in range(COLS):
                        mark[r][col] = 0
                    for row in range(ROWS):
                        mark[row][c] = 0

        for r in range(ROWS):
            for c in range(COLS):
                matrix[r][c] = mark[r][c]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SetMatrixZeroes.BruteForce
    set output_file "set_matrix_zeroes_copy.py"

    set template_content 'from typing import List

class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        ROWS, COLS = len(matrix), len(matrix[0])
        mark = [[matrix[r][c] for c in range(COLS)] for r in range(ROWS)]

        for r in range(ROWS):
            for c in range(COLS):
                if matrix[r][c] == 0:
                    for col in range(COLS):
                        mark[r][col] = 0
                    for row in range(ROWS):
                        mark[row][c] = 0

        for r in range(ROWS):
            for c in range(COLS):
                matrix[r][c] = mark[r][c]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SetMatrixZeroes.Iteration
    set output_file "set_matrix_zeroes_mark.py"

    set template_content 'from typing import List

class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        ROWS, COLS = len(matrix), len(matrix[0])
        rows = [False] * ROWS
        cols = [False] * COLS

        for r in range(ROWS):
            for c in range(COLS):
                if matrix[r][c] == 0:
                    rows[r] = True
                    cols[c] = True

        for r in range(ROWS):
            for c in range(COLS):
                if rows[r] or cols[c]:
                    matrix[r][c] = 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.SetMatrixZeroes.Iteration_SpaceOptimized
    set output_file "set_matrix_zeroes_inplace.py"
    set template_content 'from typing import List

class Solution:
    def setZeroes(self, matrix: List[List[int]]) -> None:
        ROWS, COLS = len(matrix), len(matrix[0])
        rowZero = False

        for r in range(ROWS):
            for c in range(COLS):
                if matrix[r][c] == 0:
                    matrix[0][c] = 0
                    if r > 0:
                        matrix[r][0] = 0
                    else:
                        rowZero = True

        for r in range(1, ROWS):
            for c in range(1, COLS):
                if matrix[0][c] == 0 or matrix[r][0] == 0:
                    matrix[r][c] = 0

        if matrix[0][0] == 0:
            for r in range(ROWS):
                matrix[r][0] = 0

        if rowZero:
            for c in range(COLS):
                matrix[0][c] = 0
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Non-CyclicalNumber.HashSet
    set output_file "happy_number_set.py"

    set template_content 'class Solution:
    def isHappy(self, n: int) -> bool:
        visit = set()

        while n not in visit:
            visit.add(n)
            n = self.sumOfSquares(n)
            if n == 1:
                return True
        return False

    def sumOfSquares(self, n: int) -> int:
        output = 0
        while n:
            digit = n % 10
            output += digit * digit
            n = n // 10
        return output
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Non-CyclicalNumber.FastAndSlowPointersI
    set output_file "happy_number_floyd.py"

    set template_content 'class Solution:
    def isHappy(self, n: int) -> bool:
        slow, fast = n, self.sumOfSquares(n)

        while slow != fast:
            slow = self.sumOfSquares(slow)
            fast = self.sumOfSquares(self.sumOfSquares(fast))
        return fast == 1

    def sumOfSquares(self, n: int) -> int:
        output = 0
        while n:
            digit = n % 10
            output += digit * digit
            n = n // 10
        return output
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Non-CyclicalNumber.FastAndSlowPointersII
    set output_file "happy_number_brent.py"

    set template_content 'class Solution:
    def isHappy(self, n: int) -> bool:
        slow, fast = n, self.sumOfSquares(n)
        power = lam = 1

        while slow != fast:
            if power == lam:
                slow = fast
                power *= 2
                lam = 0
            fast = self.sumOfSquares(fast)
            lam += 1
        return fast == 1

    def sumOfSquares(self, n: int) -> int:
        output = 0
        while n:
            digit = n % 10
            output += digit * digit
            n = n // 10
        return output
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PlusOne.Recursion
    set output_file "plus_one_recursive.py"

    set template_content 'from typing import List

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        if not digits:
            return [1]

        if digits[-1] < 9:
            digits[-1] += 1
            return digits
        else:
            return self.plusOne(digits[:-1]) + [0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PlusOne.IterationI
    set output_file "plus_one_reverse.py"

    set template_content 'from typing import List

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        one = 1
        i = 0
        digits.reverse()

        while one:
            if i < len(digits):
                if digits[i] == 9:
                    digits[i] = 0
                else:
                    digits[i] += 1
                    one = 0
            else:
                digits.append(one)
                one = 0
            i += 1

        digits.reverse()
        return digits
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.PlusOne.IterationII
    set output_file "plus_one_backward.py"

    set template_content 'from typing import List

class Solution:
    def plusOne(self, digits: List[int]) -> List[int]:
        n = len(digits)
        for i in range(n - 1, -1, -1):
            if digits[i] < 9:
                digits[i] += 1
                return digits
            digits[i] = 0

        return [1] + digits
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.Pow.BruteForce
    set output_file "my_pow_iterative.py"

    set template_content 'class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0:
            return 0
        if n == 0:
            return 1

        res = 1
        for i in range(abs(n)):
            res *= x
        return res if n >= 0 else 1 / res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Pow.BinaryExponentiation_Recursive
    set output_file "my_pow_recursive.py"

    set template_content 'class Solution:
    def myPow(self, x: float, n: int) -> float:
        def helper(x, n):
            if x == 0:
                return 0
            if n == 0:
                return 1

            res = helper(x * x, n // 2)
            return x * res if n % 2 else res

        res = helper(x, abs(n))
        return res if n >= 0 else 1 / res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function algoP.Pow.BinaryExponentiation_Iterative
    set output_file "my_pow_fast_iterative.py"

    set template_content 'class Solution:
    def myPow(self, x: float, n: int) -> float:
        if x == 0:
            return 0
        if n == 0:
            return 1

        res = 1
        power = abs(n)

        while power:
            if power & 1:
                res *= x
            x *= x
            power >>= 1

        return res if n >= 0 else 1 / res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.
    set output_file "multiply_strings.py"

    set template_content 'class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"

        if len(num1) < len(num2):
            return self.multiply(num2, num1)

        res, zero = "", 0
        for i in range(len(num2) - 1, -1, -1):
            cur = self.mul(num1, num2[i], zero)
            res = self.add(res, cur)
            zero += 1

        return res

    def mul(self, s: str, d: str, zero: int) -> str:
        i, carry = len(s) - 1, 0
        d = int(d)
        cur = []

        while i >= 0 or carry:
            n = int(s[i]) if i >= 0 else 0
            prod = n * d + carry
            cur.append(str(prod % 10))
            carry = prod // 10
            i -= 1

        return ''.join(cur[::-1]) + "0" * zero

    def add(self, num1: str, num2: str) -> str:
        i, j, carry = len(num1) - 1, len(num2) - 1, 0
        res = []

        while i >= 0 or j >= 0 or carry:
            n1 = int(num1[i]) if i >= 0 else 0
            n2 = int(num2[j]) if j >= 0 else 0
            total = n1 + n2 + carry
            res.append(str(total % 10))
            carry = total // 10
            i -= 1
            j -= 1

        return "".join(res[::-1])
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MultiplyStrings.MultiplicationAddition
    set output_file "multiply_strings_recursive.py"

    set template_content 'class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if num1 == "0" or num2 == "0":
            return "0"

        if len(num1) < len(num2):
            return self.multiply(num2, num1)

        res, zero = "", 0
        for i in range(len(num2) - 1, -1, -1):
            cur = self.mul(num1, num2[i], zero)
            res = self.add(res, cur)
            zero += 1

        return res

    def mul(self, s: str, d: str, zero: int) -> str:
        i, carry = len(s) - 1, 0
        d = int(d)
        cur = []

        while i >= 0 or carry:
            n = int(s[i]) if i >= 0 else 0
            prod = n * d + carry
            cur.append(str(prod % 10))
            carry = prod // 10
            i -= 1

        return "".join(cur[::-1]) + "0" * zero

    def add(self, num1: str, num2: str) -> str:
        i, j, carry = len(num1) - 1, len(num2) - 1, 0
        res = []

        while i >= 0 or j >= 0 or carry:
            n1 = int(num1[i]) if i >= 0 else 0
            n2 = int(num2[j]) if j >= 0 else 0
            total = n1 + n2 + carry
            res.append(str(total % 10))
            carry = total // 10
            i -= 1
            j -= 1

        return "".join(res[::-1])
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.MultiplyStrings.Multiplication
    set output_file "multiply_strings_iterative.py"

    set template_content 'class Solution:
    def multiply(self, num1: str, num2: str) -> str:
        if "0" in [num1, num2]:
            return "0"

        res = [0] * (len(num1) + len(num2))
        num1, num2 = num1[::-1], num2[::-1]
        for i1 in range(len(num1)):
            for i2 in range(len(num2)):
                digit = int(num1[i1]) * int(num2[i2])
                res[i1 + i2] += digit
                res[i1 + i2 + 1] += res[i1 + i2] // 10
                res[i1 + i2] %= 10

        res, beg = res[::-1], 0
        while beg < len(res) and res[beg] == 0:
            beg += 1
        res = map(str, res[beg:])
        return "".join(res)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DetectSquares.HashMapI
    set output_file "detect_squares_bruteforce.py"

    set template_content 'from typing import List
from collections import defaultdict

class CountSquares:
    def __init__(self):
        self.ptsCount = defaultdict(int)
        self.pts = []

    def add(self, point: List[int]) -> None:
        self.ptsCount[tuple(point)] += 1
        self.pts.append(point)

    def count(self, point: List[int]) -> int:
        res = 0
        px, py = point

        for x, y in self.pts:
            if x == px or y == py:
                continue
            if abs(px - x) != abs(py - y):
                continue

            res += (self.ptsCount[(x, py)] *
                    self.ptsCount[(px, y)])
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function algoP.DetectSquares.HashMapII
    set output_file "detect_squares_optimized.py"

    set template_content 'from typing import List
from collections import defaultdict

class CountSquares:
    def __init__(self):
        self.ptsCount = defaultdict(lambda: defaultdict(int))

    def add(self, point: List[int]) -> None:
        x, y = point
        self.ptsCount[x][y] += 1

    def count(self, point: List[int]) -> int:
        res = 0
        x1, y1 = point

        for y2 in self.ptsCount[x1]:
            side = y2 - y1
            if side == 0:
                continue

            x3 = x1 + side
            x4 = x1 - side

            res += (self.ptsCount[x1][y2] *
                    self.ptsCount[x3][y1] *
                    self.ptsCount[x3][y2])

            res += (self.ptsCount[x1][y2] *
                    self.ptsCount[x4][y1] *
                    self.ptsCount[x4][y2])
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end




function algoP.UniquePaths.Recursion
    set output_file "unique_paths_dfs.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        def dfs(i, j):
            if i == m - 1 and j == n - 1:
                return 1
            if i >= m or j >= n:
                return 0
            return dfs(i + 1, j) + dfs(i, j + 1)

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.UniquePaths.DynamicProgramming_Top-Down
    set output_file "unique_paths_memo.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        memo = [[-1] * n for _ in range(m)]

        def dfs(i, j):
            if i == m - 1 and j == n - 1:
                return 1
            if i >= m or j >= n:
                return 0
            if memo[i][j] != -1:
                return memo[i][j]

            memo[i][j] = dfs(i + 1, j) + dfs(i, j + 1)
            return memo[i][j]

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.UniquePaths.DynamicProgramming_Bottom-Up
    set output_file "unique_paths_dp_2d.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        dp = [[0] * (n + 1) for _ in range(m + 1)]
        dp[m - 1][n - 1] = 1

        for i in range(m - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                dp[i][j] += dp[i + 1][j] + dp[i][j + 1]

        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.UniquePaths.DynamicProgramming_SpaceOptimized
    set output_file "unique_paths_rolling_row.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        row = [1] * n

        for _ in range(m - 1):
            newRow = [1] * n
            for j in range(n - 2, -1, -1):
                newRow[j] = newRow[j + 1] + row[j]
            row = newRow

        return row[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.UniquePaths.DynamicProgramming_Optimal
    set output_file "unique_paths_dp_1d.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        dp = [1] * n

        for _ in range(m - 1):
            for j in range(n - 2, -1, -1):
                dp[j] += dp[j + 1]

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.UniquePaths.Math
    set output_file "unique_paths_math.py"

    set template_content 'class Solution:
    def uniquePaths(self, m: int, n: int) -> int:
        if m == 1 or n == 1:
            return 1
        if m < n:
            m, n = n, m

        res = 1
        j = 1
        for i in range(m, m + n - 1):
            res *= i
            res //= j
            j += 1

        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.LongestCommonSubsequence.Recursion
    set output_file "lcs_dfs.py"

    set template_content 'class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        def dfs(i, j):
            if i == len(text1) or j == len(text2):
                return 0
            if text1[i] == text2[j]:
                return 1 + dfs(i + 1, j + 1)
            return max(dfs(i + 1, j), dfs(i, j + 1))

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.LongestCommonSubsequence.DynamicProgramming_Top-Down
    set output_file "lcs_memo.py"

    set template_content 'class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        memo = {}

        def dfs(i, j):
            if i == len(text1) or j == len(text2):
                return 0
            if (i, j) in memo:
                return memo[(i, j)]

            if text1[i] == text2[j]:
                memo[(i, j)] = 1 + dfs(i + 1, j + 1)
            else:
                memo[(i, j)] = max(dfs(i + 1, j), dfs(i, j + 1))

            return memo[(i, j)]

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.LongestCommonSubsequence.DynamicProgramming_Bottom-Up
    set output_file "lcs_dp_2d.py"

    set template_content 'class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        dp = [[0] * (len(text2) + 1) for _ in range(len(text1) + 1)]

        for i in range(len(text1) - 1, -1, -1):
            for j in range(len(text2) - 1, -1, -1):
                if text1[i] == text2[j]:
                    dp[i][j] = 1 + dp[i + 1][j + 1]
                else:
                    dp[i][j] = max(dp[i + 1][j], dp[i][j + 1])

        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.LongestCommonSubsequence.DynamicProgramming_SpaceOptimized
    set output_file "lcs_dp_2rows.py"

    set template_content 'class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        if len(text1) < len(text2):
            text1, text2 = text2, text1

        prev = [0] * (len(text2) + 1)
        curr = [0] * (len(text2) + 1)

        for i in range(len(text1) - 1, -1, -1):
            for j in range(len(text2) - 1, -1, -1):
                if text1[i] == text2[j]:
                    curr[j] = 1 + prev[j + 1]
                else:
                    curr[j] = max(curr[j + 1], prev[j])
            prev, curr = curr, prev

        return prev[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.LongestCommonSubsequence.DynamicProgramming_Optimal
    set output_file "lcs_dp_1d.py"

    set template_content 'class Solution:
    def longestCommonSubsequence(self, text1: str, text2: str) -> int:
        if len(text1) < len(text2):
            text1, text2 = text2, text1

        dp = [0] * (len(text2) + 1)

        for i in range(len(text1) - 1, -1, -1):
            prev = 0
            for j in range(len(text2) - 1, -1, -1):
                temp = dp[j]
                if text1[i] == text2[j]:
                    dp[j] = 1 + prev
                else:
                    dp[j] = max(dp[j], dp[j + 1])
                prev = temp

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end



function algoP.BestTimeBuySellStockwithCooldown.Recursion
    set output_file "stock_cooldown_dfs.py"

    set template_content 'class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        def dfs(i, buying):
            if i >= len(prices):
                return 0

            cooldown = dfs(i + 1, buying)
            if buying:
                buy = dfs(i + 1, False) - prices[i]
                return max(buy, cooldown)
            else:
                sell = dfs(i + 2, True) + prices[i]
                return max(sell, cooldown)

        return dfs(0, True)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.BestTimeBuySellStockwithCooldown.DynamicProgramming_Top-Down
    set output_file "stock_cooldown_memo.py"

    set template_content 'class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        dp = {}

        def dfs(i, buying):
            if i >= len(prices):
                return 0
            if (i, buying) in dp:
                return dp[(i, buying)]

            cooldown = dfs(i + 1, buying)
            if buying:
                buy = dfs(i + 1, False) - prices[i]
                dp[(i, buying)] = max(buy, cooldown)
            else:
                sell = dfs(i + 2, True) + prices[i]
                dp[(i, buying)] = max(sell, cooldown)

            return dp[(i, buying)]

        return dfs(0, True)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.BestTimeBuySellStockwithCooldown.DynamicProgramming_Bottom-Up
    set output_file "stock_cooldown_dp_2d.py"

    set template_content 'class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        n = len(prices)
        dp = [[0] * 2 for _ in range(n + 2)]

        for i in range(n - 1, -1, -1):
            dp[i][1] = max(
                dp[i + 1][0] - prices[i],  # buy
                dp[i + 1][1]               # cooldown
            )
            dp[i][0] = max(
                dp[i + 2][1] + prices[i],  # sell
                dp[i + 1][0]               # cooldown
            )

        return dp[0][1]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.BestTimeBuySellStockwithCooldown.DynamicProgramming_Bottom-Up
    set output_file "stock_cooldown_dp_optimized.py"

    set template_content 'class Solution:
    def maxProfit(self, prices: List[int]) -> int:
        n = len(prices)
        dp1_buy = dp1_sell = 0
        dp2_buy = 0

        for i in range(n - 1, -1, -1):
            dp_buy = max(dp1_sell - prices[i], dp1_buy)
            dp_sell = max(dp2_buy + prices[i], dp1_sell)

            dp2_buy = dp1_buy
            dp1_buy, dp1_sell = dp_buy, dp_sell

        return dp1_buy
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.CoinChangeII.Recursion
    set output_file "coin_change_2_dfs.py"

    set template_content 'class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        coins.sort()

        def dfs(i, a):
            if a == 0:
                return 1
            if i >= len(coins):
                return 0

            res = dfs(i + 1, a)
            if a >= coins[i]:
                res += dfs(i, a - coins[i])
            return res

        return dfs(0, amount)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.CoinChangeII.DynamicProgramming_Top-Down
    set output_file "coin_change_2_memo.py"

    set template_content 'class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        coins.sort()
        memo = [[-1] * (amount + 1) for _ in range(len(coins))]

        def dfs(i, a):
            if a == 0:
                return 1
            if i >= len(coins):
                return 0
            if memo[i][a] != -1:
                return memo[i][a]

            res = dfs(i + 1, a)
            if a >= coins[i]:
                res += dfs(i, a - coins[i])

            memo[i][a] = res
            return res

        return dfs(0, amount)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.CoinChangeII.DynamicProgramming_Bottom-Up
    set output_file "coin_change_2_dp_2d.py"

    set template_content 'class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        n = len(coins)
        dp = [[0] * (amount + 1) for _ in range(n + 1)]

        for i in range(n + 1):
            dp[i][0] = 1

        for i in range(n - 1, -1, -1):
            for a in range(amount + 1):
                dp[i][a] = dp[i + 1][a]
                if a >= coins[i]:
                    dp[i][a] += dp[i][a - coins[i]]

        return dp[0][amount]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.CoinChangeII.DynamicProgramming_SpaceOptimized
    set output_file "coin_change_2_dp_rolling.py"

    set template_content 'class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        dp = [0] * (amount + 1)
        dp[0] = 1

        for i in range(len(coins) - 1, -1, -1):
            nextDP = dp[:]
            for a in range(coins[i], amount + 1):
                nextDP[a] += nextDP[a - coins[i]]
            dp = nextDP

        return dp[amount]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.CoinChangeII.DynamicProgramming_Optimal
    set output_file "coin_change_2_dp_1d.py"

    set template_content 'class Solution:
    def change(self, amount: int, coins: List[int]) -> int:
        dp = [0] * (amount + 1)
        dp[0] = 1

        for coin in coins:
            for a in range(coin, amount + 1):
                dp[a] += dp[a - coin]

        return dp[amount]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.TargetSum.Recursion
    set output_file "target_sum_dfs.py"

    set template_content 'class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        def backtrack(i, total):
            if i == len(nums):
                return 1 if total == target else 0

            return (backtrack(i + 1, total + nums[i]) +
                    backtrack(i + 1, total - nums[i]))

        return backtrack(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.TargetSum.DynamicProgramming_Top-Down
    set output_file "target_sum_memo.py"

    set template_content 'class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        dp = {}

        def backtrack(i, total):
            if i == len(nums):
                return 1 if total == target else 0
            if (i, total) in dp:
                return dp[(i, total)]

            dp[(i, total)] = (backtrack(i + 1, total + nums[i]) +
                              backtrack(i + 1, total - nums[i]))
            return dp[(i, total)]

        return backtrack(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.TargetSum.DynamicProgramming_Bottom-Up
    set output_file "target_sum_dp_2d.py"

    set template_content 'class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        from collections import defaultdict

        n = len(nums)
        dp = [defaultdict(int) for _ in range(n + 1)]
        dp[0][0] = 1

        for i in range(n):
            for total, count in dp[i].items():
                dp[i + 1][total + nums[i]] += count
                dp[i + 1][total - nums[i]] += count

        return dp[n][target]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.TargetSum.DynamicProgramming_SpaceOptimized
    set output_file "target_sum_dp_1d.py"

    set template_content 'class Solution:
    def findTargetSumWays(self, nums: List[int], target: int) -> int:
        from collections import defaultdict

        dp = defaultdict(int)
        dp[0] = 1

        for num in nums:
            next_dp = defaultdict(int)
            for total, count in dp.items():
                next_dp[total + num] += count
                next_dp[total - num] += count
            dp = next_dp

        return dp[target]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end



function algoP.InterleavingString.Recursion
    set output_file "interleaving_dfs.py"

    set template_content 'class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:

        def dfs(i, j, k):
            if k == len(s3):
                return i == len(s1) and j == len(s2)

            if i < len(s1) and s1[i] == s3[k]:
                if dfs(i + 1, j, k + 1):
                    return True

            if j < len(s2) and s2[j] == s3[k]:
                if dfs(i, j + 1, k + 1):
                    return True

            return False

        return dfs(0, 0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.InterleavingString.DynamicProgramming_Top-Down
    set output_file "interleaving_memo.py"

    set template_content 'class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        if len(s1) + len(s2) != len(s3):
            return False

        dp = {}
        def dfs(i, j, k):
            if k == len(s3):
                return i == len(s1) and j == len(s2)
            if (i, j) in dp:
                return dp[(i, j)]

            res = False
            if i < len(s1) and s1[i] == s3[k]:
                res = dfs(i + 1, j, k + 1)
            if not res and j < len(s2) and s2[j] == s3[k]:
                res = dfs(i, j + 1, k + 1)

            dp[(i, j)] = res
            return res

        return dfs(0, 0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.InterleavingString.DynamicProgramming_Bottom-Up
    set output_file "interleaving_dp2d.py"

    set template_content 'class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        if len(s1) + len(s2) != len(s3):
            return False

        dp = [[False] * (len(s2) + 1) for _ in range(len(s1) + 1)]
        dp[len(s1)][len(s2)] = True

        for i in range(len(s1), -1, -1):
            for j in range(len(s2), -1, -1):
                if i < len(s1) and s1[i] == s3[i + j] and dp[i + 1][j]:
                    dp[i][j] = True
                if j < len(s2) and s2[j] == s3[i + j] and dp[i][j + 1]:
                    dp[i][j] = True
        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.InterleavingString.DynamicProgramming_SpaceOptimized
    set output_file "interleaving_dp1d.py"

    set template_content 'class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        m, n = len(s1), len(s2)
        if m + n != len(s3):
            return False
        if n < m:
            s1, s2 = s2, s1
            m, n = n, m

        dp = [False] * (n + 1)
        dp[n] = True
        for i in range(m, -1, -1):
            nextDp = [False] * (n + 1)
            if i == m:
                nextDp[n] = True
            for j in range(n, -1, -1):
                if i < m and s1[i] == s3[i + j] and dp[j]:
                    nextDp[j] = True
                if j < n and s2[j] == s3[i + j] and nextDp[j + 1]:
                    nextDp[j] = True
            dp = nextDp
        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.InterleavingString.DynamicProgramming_Optimal
    set output_file "interleaving_dp1d_opt.py"

    set template_content 'class Solution:
    def isInterleave(self, s1: str, s2: str, s3: str) -> bool:
        m, n = len(s1), len(s2)
        if m + n != len(s3):
            return False
        if n < m:
            s1, s2 = s2, s1
            m, n = n, m

        dp = [False] * (n + 1)
        dp[n] = True
        for i in range(m, -1, -1):
            nextDp = True if i == m else False
            for j in range(n, -1, -1):
                res = False if j < n else nextDp
                if i < m and s1[i] == s3[i + j] and dp[j]:
                    res = True
                if j < n and s2[j] == s3[i + j] and nextDp:
                    res = True
                dp[j] = res
                nextDp = dp[j]
        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end



function algoP.EditDistance.Recursion
    set output_file "edit_distance_dfs.py"

    set template_content 'class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m, n = len(word1), len(word2)

        def dfs(i, j):
            if i == m:
                return n - j
            if j == n:
                return m - i
            if word1[i] == word2[j]:
                return dfs(i + 1, j + 1)
            res = min(dfs(i + 1, j), dfs(i, j + 1))
            res = min(res, dfs(i + 1, j + 1))
            return res + 1

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.EditDistance.DynamicProgramming_Top-Down
    set output_file "edit_distance_memo.py"

    set template_content 'class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m, n = len(word1), len(word2)
        dp = {}

        def dfs(i, j):
            if i == m:
                return n - j
            if j == n:
                return m - i
            if (i, j) in dp:
                return dp[(i, j)]

            if word1[i] == word2[j]:
                dp[(i, j)] = dfs(i + 1, j + 1)
            else:
                res = min(dfs(i + 1, j), dfs(i, j + 1))
                res = min(res, dfs(i + 1, j + 1))
                dp[(i, j)] = res + 1
            return dp[(i, j)]

        return dfs(0, 0)
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.EditDistance.DynamicProgramming_Bottom-Up
    set output_file "edit_distance_dp2d.py"

    set template_content 'class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        dp = [[float("inf")] * (len(word2) + 1) for _ in range(len(word1) + 1)]

        for j in range(len(word2) + 1):
            dp[len(word1)][j] = len(word2) - j
        for i in range(len(word1) + 1):
            dp[i][len(word2)] = len(word1) - i

        for i in range(len(word1) - 1, -1, -1):
            for j in range(len(word2) - 1, -1, -1):
                if word1[i] == word2[j]:
                    dp[i][j] = dp[i + 1][j + 1]
                else:
                    dp[i][j] = 1 + min(dp[i + 1][j], dp[i][j + 1], dp[i + 1][j + 1])
        return dp[0][0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.EditDistance.DynamicProgramming_SpaceOptimized
    set output_file "edit_distance_dp1d_v1.py"

    set template_content 'class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m, n = len(word1), len(word2)
        if m < n:
            m, n = n, m
            word1, word2 = word2, word1

        dp = [0] * (n + 1)
        nextDp = [0] * (n + 1)

        for j in range(n + 1):
            dp[j] = n - j

        for i in range(m - 1, -1, -1):
            nextDp[n] = m - i
            for j in range(n - 1, -1, -1):
                if word1[i] == word2[j]:
                    nextDp[j] = dp[j + 1]
                else:
                    nextDp[j] = 1 + min(dp[j], nextDp[j + 1], dp[j + 1])
            dp = nextDp[:]

        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.EditDistance.DynamicProgramming_Optimal
    set output_file "edit_distance_dp1d_v2.py"

    set template_content 'class Solution:
    def minDistance(self, word1: str, word2: str) -> int:
        m, n = len(word1), len(word2)
        if m < n:
            m, n = n, m
            word1, word2 = word2, word1

        dp = [n - i for i in range(n + 1)]

        for i in range(m - 1, -1, -1):
            nextDp = dp[n]
            dp[n] = m - i
            for j in range(n - 1, -1, -1):
                temp = dp[j]
                if word1[i] == word2[j]:
                    dp[j] = nextDp
                else:
                    dp[j] = 1 + min(dp[j], dp[j + 1], nextDp)
                nextDp = temp
        return dp[0]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.DetectSquares.HashMapI
    set output_file "count_squares_list.py"

    set template_content 'from collections import defaultdict
from typing import List

class CountSquares:
    def __init__(self):
        self.ptsCount = defaultdict(int)
        self.pts = []

    def add(self, point: List[int]) -> None:
        self.ptsCount[tuple(point)] += 1
        self.pts.append(point)

    def count(self, point: List[int]) -> int:
        res = 0
        px, py = point
        for x, y in self.pts:
            if (abs(py - y) != abs(px - x)) or x == px or y == py:
                continue
            res += self.ptsCount[(x, py)] * self.ptsCount[(px, y)]
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.DetectSquares.HashMapII
    set output_file "count_squares_dict.py"

    set template_content 'from collections import defaultdict
from typing import List

class CountSquares:
    def __init__(self):
        self.ptsCount = defaultdict(lambda: defaultdict(int))

    def add(self, point: List[int]) -> None:
        self.ptsCount[point[0]][point[1]] += 1

    def count(self, point: List[int]) -> int:
        res = 0
        x1, y1 = point
        for y2 in self.ptsCount[x1]:
            side = y2 - y1
            if side == 0:
                continue

            x3, x4 = x1 + side, x1 - side
            res += (self.ptsCount[x1][y2] * self.ptsCount[x3][y1] *
                    self.ptsCount[x3][y2])

            res += (self.ptsCount[x1][y2] * self.ptsCount[x4][y1] *
                    self.ptsCount[x4][y2])
        return res
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.ContainsInt
    set output_file "check_contains_python.py"

    set template_content 'l = [3, 3, 4, 5, 2, 111, 5]
target = 111
print(target in l)  # True
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.ContainsInt
    set output_file "check_contains_go.go"

    set template_content 'package main

import (
    "fmt"
)

func contains(slice []int, target int) bool {
    for _, v := range slice {
        if v == target {
            return true
        }
    }
    return false
}

func main() {
    l := []int{3, 3, 4, 5, 2, 111, 5}
    target := 111
    fmt.Println(contains(l, target)) // true
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Duplicates
    set output_file "find_duplicates_python.py"

    set template_content 'def find_duplicates(elements):
    duplicates, seen = set(), set()
    for element in elements:
        if element in seen:
            duplicates.add(element)
        seen.add(element)
    return list(duplicates)

# Example usage
l = [3, 3, 4, 5, 2, 111, 5]
print(find_duplicates(l))  # [3, 5]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoG.Duplicates
    set output_file "find_duplicates_go.go"

    set template_content 'package main

import "fmt"

func findDuplicates(elements []int) []int {
    seen := make(map[int]bool)
    duplicates := make(map[int]bool)

    for _, e := range elements {
        if seen[e] {
            duplicates[e] = true
        }
        seen[e] = true
    }

    result := []int{}
    for k := range duplicates {
        result = append(result, k)
    }
    return result
}

func main() {
    l := []int{3, 3, 4, 5, 2, 111, 5}
    fmt.Println(findDuplicates(l)) // [3 5]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Anagram
    set output_file "is_anagram_python.py"

    set template_content 'def is_anagram(s1, s2):
    return sorted(s1) == sorted(s2)

# Example usage
print(is_anagram("elvis", "lives"))  # True
print(is_anagram("hello", "bello"))  # False
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoG.Anagram
    set output_file "is_anagram_go.go"

    set template_content 'package main

import (
    "fmt"
    "sort"
    "strings"
)

func isAnagram(s1, s2 string) bool {
    if len(s1) != len(s2) {
        return false
    }

    a := strings.Split(s1, "")
    b := strings.Split(s2, "")
    sort.Strings(a)
    sort.Strings(b)
    for i := range a {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}

func main() {
    fmt.Println(isAnagram("elvis", "lives")) // true
    fmt.Println(isAnagram("hello", "bello")) // false
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Duplicates
    set output_file "remove_duplicates_python.py"

    set template_content 'lst = list(range(10)) + list(range(10))
# Remove duplicates using set
lst = list(set(lst))
print(lst)  # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Duplicates
    set output_file "remove_duplicates_go.go"

    set template_content 'package main

import (
    "fmt"
)

func removeDuplicates(nums []int) []int {
    seen := make(map[int]bool)
    res := []int{}
    for _, n := range nums {
        if !seen[n] {
            res = append(res, n)
            seen[n] = true
        }
    }
    return res
}

func main() {
    nums := append([]int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}, []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9}...)
    nums = removeDuplicates(nums)
    fmt.Println(nums) // [0 1 2 3 4 5 6 7 8 9]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.PairsSum
    set output_file "find_pairs_python.py"

    set template_content 'def find_pairs(l, x):
    pairs = []
    for i, el_1 in enumerate(l):
        for j, el_2 in enumerate(l[i + 1:]):
            if el_1 + el_2 == x:
                pairs.append((el_1, el_2))
    return pairs

# Example usage
l = [1, 2, 3, 4, 5]
x = 5
print(find_pairs(l, x))  # [(1, 4), (2, 3)]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoG.PairsSum
    set output_file "find_pairs_go.go"

    set template_content 'package main

import "fmt"

func findPairs(nums []int, x int) [][2]int {
    pairs := [][2]int{}
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if nums[i]+nums[j] == x {
                pairs = append(pairs, [2]int{nums[i], nums[j]})
            }
        }
    }
    return pairs
}

func main() {
    nums := []int{1, 2, 3, 4, 5}
    x := 5
    fmt.Println(findPairs(nums, x)) // [[1 4] [2 3]]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.Palindrome
    set output_file "is_palindrome_python.py"

    set template_content 'def is_palindrome(phrase):
    return phrase == phrase[::-1]

# Example usage
print(is_palindrome("anna"))  # True
print(is_palindrome("hello")) # False
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoG.Palindrome
    set output_file "is_palindrome_go.go"

    set template_content 'package main

import (
    "fmt"
)

func isPalindrome(s string) bool {
    for i := 0; i < len(s)/2; i++ {
        if s[i] != s[len(s)-1-i] {
            return false
        }
    }
    return true
}

func main() {
    fmt.Println(isPalindrome("anna"))  // true
    fmt.Println(isPalindrome("hello")) // false
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.StackQueueArray
    set output_file "list_stack_queue_array.py"

    set template_content '# Using a list as an array
l := [3, 4]
l += [5, 6]  # l = [3, 4, 5, 6]

# Using as a stack (LIFO)
l.append(10)  # l = [3, 4, 5, 6, 10]
l.pop()       # l = [3, 4, 5, 6]

# Using as a queue (FIFO)
l.insert(0, 5)  # l = [5, 3, 4, 5, 6]
l.pop()         # l = [5, 3, 4, 5]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoG.StackQueueArray
    set output_file "slice_stack_queue_array.go"

    set template_content 'package main

import (
    "fmt"
)

func main() {
    // Using slice as an array
    l := []int{3, 4}
    l = append(l, 5, 6) // l = [3, 4, 5, 6]
    fmt.Println(l)

    // Using slice as a stack (LIFO)
    l = append(l, 10)       // l = [3, 4, 5, 6, 10]
    l = l[:len(l)-1]        // pop -> [3, 4, 5, 6]
    fmt.Println(l)

    // Using slice as a queue (FIFO)
    l = append([]int{5}, l...) // insert at beginning -> [5, 3, 4, 5, 6]
    l = l[:len(l)-1]            // pop from end -> [5, 3, 4, 5]
    fmt.Println(l)
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoP.MissingNumber
    set output_file "get_missing_number.py"

    set template_content 'def get_missing_number(lst):
    return set(range(1, lst[-1] + 1)) - set(lst)

l = list(range(1, 100))
l.remove(50)
print(get_missing_number(l))  # 50
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoG.MissingNumber
    set output_file "get_missing_number.go"

    set template_content 'package main

import (
    "fmt"
)

func getMissingNumber(lst []int) int {
    seen := make(map[int]bool)
    for _, v := range lst {
        seen[v] = true
    }
    for i := 1; i <= lst[len(lst)-1]; i++ {
        if !seen[i] {
            return i
        }
    }
    return -1 // not found
}

func main() {
    l := make([]int, 0, 99)
    for i := 1; i < 100; i++ {
        if i != 50 {
            l = append(l, i)
        }
    }
    fmt.Println(getMissingNumber(l)) // 50
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Intersection
    set output_file "list_intersection.py"

    set template_content 'def intersect(lst1, lst2):
    res, lst2_copy = [], lst2[:]
    for el in lst1:
        if el in lst2_copy:
            res.append(el)
            lst2_copy.remove(el)
    return res

a = [1, 2, 2, 3]
b = [2, 2, 4]
print(intersect(a, b))  # [2, 2]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoG.Intersection
    set output_file "list_intersection.go"

    set template_content 'package main

import (
    "fmt"
)

func intersect(lst1, lst2 []int) []int {
    res := []int{}
    lst2Copy := append([]int(nil), lst2...)
    for _, el1 := range lst1 {
        for i, el2 := range lst2Copy {
            if el1 == el2 {
                res = append(res, el1)
                lst2Copy = append(lst2Copy[:i], lst2Copy[i+1:]...)
                break
            }
        }
    }
    return res
}

func main() {
    a := []int{1, 2, 2, 3}
    b := []int{2, 2, 4}
    fmt.Println(intersect(a, b)) // [2 2]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.Intersection1
    set output_file "list_intersection.py"

    set template_content 'def intersect(lst1, lst2):
    res, lst2_copy = [], lst2[:]
    for el in lst1:
        if el in lst2_copy:
            res.append(el)
            lst2_copy.remove(el)
    return res

# Example usage
a = [1, 2, 2, 3]
b = [2, 2, 4]
print(intersect(a, b))  # Output: [2, 2]
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoG.Intersection1
    set output_file "list_intersection.go"

    set template_content 'package main

import (
    "fmt"
)

func intersect(lst1, lst2 []int) []int {
    res := []int{}
    lst2Copy := append([]int(nil), lst2...)
    for _, el1 := range lst1 {
        for i, el2 := range lst2Copy {
            if el1 == el2 {
                res = append(res, el1)
                lst2Copy = append(lst2Copy[:i], lst2Copy[i+1:]...)
                break
            }
        }
    }
    return res
}

func main() {
    a := []int{1, 2, 2, 3}
    b := []int{2, 2, 4}
    fmt.Println(intersect(a, b)) // Output: [2 2]
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.MaxMin
    set output_file "list_max_min.py"

    set template_content 'l = [4, 3, 6, 3, 4, 888, 1, -11, 22, 3]

max_val = max(l)
min_val = min(l)

print("Max:", max_val)  # 888
print("Min:", min_val)  # -11
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

function algoG.MaxMin
    set output_file "list_max_min.go"

    set template_content 'package main

import (
    "fmt"
    "math"
)

func main() {
    l := []int{4, 3, 6, 3, 4, 888, 1, -11, 22, 3}

    maxVal := math.MinInt64
    minVal := math.MaxInt64

    for _, v := range l {
        if v > maxVal {
            maxVal = v
        }
        if v < minVal {
            minVal = v
        }
    }

    fmt.Println("Max:", maxVal) // 888
    fmt.Println("Min:", minVal) // -11
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoP.ReverseRecursion
    set output_file "reverse_string_recursion.py"

    set template_content 'def reverse(string):
    if len(string) <= 1:
        return string
    return reverse(string[1:]) + string[0]

s = "hello"
print(reverse(s))  # olleh
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end


function algoG.ReverseRecursion
    set output_file "reverse_string_recursion.go"

    set template_content 'package main

import "fmt"

func reverse(s string) string {
    if len(s) <= 1 {
        return s
    }
    return reverse(s[1:]) + string(s[0])
}

func main() {
    s := "hello"
    fmt.Println(reverse(s)) // olleh
}
'
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
end

