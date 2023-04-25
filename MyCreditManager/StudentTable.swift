//
//  StudentTable.swift
//  MyCreditManager
//
//  Created by 임가영 on 2023/04/25.
//

import Foundation

class StudentTable {
    var dicStudent: [String:[String:String]]
    
    init(dicStudent: [String : [String : String]]) {
        self.dicStudent = dicStudent
    }
    
    // 학생 추가
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
    
    // 학생 삭제
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
    
    // 성적 추가 및 변경
    func upsertScore(_ scoreInfo: [String?]) {
        if !scoreInfo.isEmpty, scoreInfo.count == 3 {
            if let name = scoreInfo[0], let subject = scoreInfo[1], let score = scoreInfo[2] {
                if let _ = dicStudent[name] {
                    dicStudent[name]?.updateValue(score, forKey: subject)
                    print("\(name) 학생의 \(subject) 과목이 \(score)로 추가(변경)되었습니다.")
                } else {
                    print("\(name) 학생을 찾지 못했습니다.")
                }
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
    
    // 성적 삭제
    func removeScore(_ removeInfo: [String?]) {
        if !removeInfo.isEmpty, removeInfo.count == 2 {
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
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
    
    // 평점 보기
    func sumScore(_ name: String) {
        var sum: Double = 0.0
        
        if !name.isEmpty {
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
                        
                    default:
                        print(CommonString.INVALID_INPUT)
                    }
                }
                print("평점 : \(String(format: "%.2f", sum/Double(dic.count)))")
            } else {
                print("\(name) 학생을 찾지 못했습니다.")
            }
        } else {
            print(CommonString.INVALID_INPUT)
        }
    }
}
