
//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Playground - noun: a place where people can play
var course = "CS 436" //1
var credits : Int = 3 //2
let classNum : Int = 3146 //3

//Strings and Optionals

var semester = "Fall 2018" //4
var spaceIndex : String.Index? = semester.index(of: " ") //5

if spaceIndex != nil{  //6
    //let term = semester.substring(to: spaceIndex!) //7
    let term = String(semester[..<spaceIndex!]) //7
    // let yearStr = semester.substring(from: spaceIndex!) //8
    let yearStr = String(semester[spaceIndex!...])//8
    let yearInt : Int? = Int(yearStr) //9
    print("We are currently in the \(term) term of the year \(yearStr)") //10
    
}

// Arrays
var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]//11

for i in days{
    print(i)
}//12

var madScheduler = [String]() //13

for items in days{
    
    madScheduler.append(days[Int(arc4random_uniform(UInt32((items.count)-1)))])
    
}//14
var mSize = days.count
for things in madScheduler {
    
    print(madScheduler[mSize-1])
    mSize = mSize - 1
}//15

