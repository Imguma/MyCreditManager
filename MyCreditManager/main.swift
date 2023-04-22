//
//  main.swift
//  MyCreditManager
//
//  Created by 임가영 on 2023/04/22.
//

import Foundation

enum CommonString {
    static let INVALID_MENU = "뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요."
    static let INVALID_INPUT = "입력이 잘못되었습니다. 다시 확인해주세요."
}

class table {
    var dicStudent: [String:[String:String]]
    
    init(dicStudent: [String : [String : String]]) {
        self.dicStudent = dicStudent
    }
    
    func addStudent(_ name: String) {
        if !name.isEmpty {
            if let _ = dicStudent[name] {
                print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            } else {
                dicStudent[name] = [:]
                print("\(name) 학생을 추가했습니다.")
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
    
    func removeStudent(_ name: String) {
        if !name.isEmpty {
            if dicStudent.keys.contains(name) {
                dicStudent.removeValue(forKey: name)
                print("\(name) 학생을 삭제하였습니다.")
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        }
        
    }
    
    func upsertScore(_ scoreInfo: [String?]) {
        if !scoreInfo.isEmpty, scoreInfo.count == 3 {
            if let name = scoreInfo[0], let subject = scoreInfo[1], let score = scoreInfo[2] {
                if let _ = dicStudent[name] {
                    dicStudent[name]?.updateValue(score, forKey: subject)
                    print("\(name) 학생의 \(subject) 과목이 \(score)로 추가(변경)되었습니다.")
                }
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
    
    func removeScore(_ removeInfo: [String?]) {
        if let name = removeInfo[0], let subject = removeInfo[1] {
            if var dic = dicStudent[name] {
                if let _ = dic.removeValue(forKey: subject) {
                    print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                } else {
                    print("\(name) 학생의 \(subject) 과목을 찾지 못했습니다.")
                }
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
    
    func sumScore(_ name: String) {
        var sum: Double = 0.0
        
        if let dic = dicStudent[name] {
            dic.forEach { element in
                print("\(element.key): \(element.value)")
                
                switch element.value {
                case "A+":
                    sum += 4.5
                case "A":
                    sum += 4
                case "B+":
                    sum += 3.5
                case "B":
                    sum += 3
                case "C+":
                    sum += 2.5
                case "C":
                    sum += 2
                case "D+":
                    sum += 1.5
                case "D":
                    sum += 1
                case "F":
                    sum += 0
                default: break
                }
            }
            print("평점 : \(String(format: "%.2f", sum/Double(dic.count)))")
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
}

var input: String = ""
var studentTable = table(dicStudent: [:])

while(true) {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    input = readLine()!
    
    if input == "X" {
        break
    }
    
    if !input.isEmpty {
        if let intInput = Int(input) {
            switch intInput {
            case 1:
                print("추가할 학생의 이름을 입력해주세요.")
                let name = readLine()!
                studentTable.addStudent(name)
            case 2:
                print("삭제할 학생의 이름을 입력해주세요.")
                let name = readLine()!
                studentTable.removeStudent(name)
            case 3:
                print("성적을 추가할 학생의 이름, 과목, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
                let scoreInfo = readLine()!.split(separator: " ").map { String($0) }
                studentTable.upsertScore(scoreInfo)
            case 4:
                print("삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
                let removeInfo = readLine()!.split(separator: " ").map { String($0) }
                studentTable.removeScore(removeInfo)
            case 5:
                print("평점을 알고싶은 학생의 이름을 입력해주세요.")
                let name = readLine()!
                studentTable.sumScore(name)
                
            default:
                print(CommonString.INVALID_MENU)
            }
            
        } else {
            print(CommonString.INVALID_MENU)
        }
    } else {
        print(CommonString.INVALID_MENU)
    }
}
