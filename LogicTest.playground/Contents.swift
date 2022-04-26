import Foundation

var greeting = "Logic Test"

func findMiddleIndexOfElements(_ elements: [Int]) -> String {
    var middleIndex: Int = -1
    let lastIndex: Int = elements.count - 1
    var leftIndex: Int = 0
    var rightIndex: Int = lastIndex // last index
    var leftSum: Int = elements[leftIndex]// sum of all elements from the left to right until both of them met
    var rightSum: Int = elements[rightIndex]// sum of all elements from the right to left
    
    if rightIndex > 1 {// array has at least 3 elements
        while (leftIndex < rightIndex) {
            if leftSum <= rightSum {
                leftIndex += 1
                leftSum += elements[leftIndex]
            } else{
                rightIndex -= 1
                rightSum += elements[rightIndex]
            }
        }
        middleIndex = (leftSum == rightSum) ? (rightIndex) : -1
    }
    return "Input \(elements) => \(middleIndex > 0 ? "middle index is \(middleIndex)" : "index not found")"
}

func detectPalindromeString(_ string: String) -> String {

    let chars = Array(string.lowercased())
    let lastIndex = chars.count - 1
    var isPalindrome: Bool = true
    
    //check array count is even or odd, this lower the number of loop
    let middleIndex = lastIndex / 2
    for i in 0...middleIndex {
        if chars[i] != chars[lastIndex - i] {
            isPalindrome = false
            break
        }
    }
    return isPalindrome ? "\(string) is a palindrome" : "\(string) isn't a palindrome"
}

print("1. Please write a function to find the index that has the sum of left’s elements equal to the sum of right’s element.")
print(findMiddleIndexOfElements([1, 3, 5, 7, 9]))
print(findMiddleIndexOfElements([3, 6, 8, 1, 5, 10, 1, 7]))
print(findMiddleIndexOfElements([3, 5, 6]))
print(findMiddleIndexOfElements([3, 4, 3]))
print(findMiddleIndexOfElements([1, 2]))

print("\n")
print("\n")

print("2. Please write a function to detect that incoming string is palindrome or not")
print(detectPalindromeString("Hello"))
print(detectPalindromeString("level"))
print(detectPalindromeString("AbbA"))
print(detectPalindromeString("aka"))
print(detectPalindromeString("abc"))
print(detectPalindromeString("AbcdbA"))
print(detectPalindromeString("AbcCbA"))
