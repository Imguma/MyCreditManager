//
//  main.swift
//  MyCreditManager
//
//  Created by 임가영 on 2023/04/22.
//

import Foundation

var input: String = ""
var studentTable = StudentTable(dicStudent: [:])

while(true) {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    input = readLine()!
    
    if input == "X" {
        print("프로그램을 종료합니다...")
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
                print("입력예) Mickey Swift A+")
                print("만약에 학생의 성적 중 해당 과목이 존재하면 기본 점수가 갱신됩니다.")
                let scoreInfo = readLine()!.split(separator: " ").map { String($0) }
                studentTable.upsertScore(scoreInfo)
                
            case 4:
                print("삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
                print("입력예) Mickey Swift")
                let removeInfo = readLine()!.split(separator: " ").map { String($0) }
                studentTable.removeScore(removeInfo)
                
            case 5:
                print("평점을 알고싶은 학생의 이름을 입력해주세요.")
                let name = readLine()!
                studentTable.sumScore(name)
                
            default:
                print(CommonString.INVALID_MENU_INPUT)
            }
        } else {
            print(CommonString.INVALID_MENU_INPUT)
        }
    } else {
        print(CommonString.INVALID_MENU_INPUT)
    }
}
