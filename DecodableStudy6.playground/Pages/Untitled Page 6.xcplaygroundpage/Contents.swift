//: [Previous](@previous)

import Foundation

//오류 처리 패턴, 에러 핸들링
//if - else, switch - case
//do try = catch

func checkDateFormat(text: String) -> Bool{
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    
    return format.date(from: text) == nil ? false : true//slrspdla dhksfy qj
}

func validateUserInput(text: String) -> Bool{
    //입력한 값이 비었는지
    guard !(text.isEmpty) else{
        
        print("빈값")
        return false
    }
    
    guard Int(text) != nil else{
        print("숫자가 아닙니다.")
        return false
    }
    
    guard checkDateFormat(text: text) else{
        print("날짜 형태가 잘못되었습니다.")
        return false
    }
    
    return true
}
    

//닉네임 완려 버튼 누른 경우
if validateUserInput(text: "20240101"){
    print("가능")
}else{
    print("불가능")
}

//오류 처리 패턴
enum ValidationError: Error{
    case emptyString
    case isNotInt
    case isNotDate
}

//에러를 발생시킬 수 있다는 것을 알리기 위해 throw 키워들를 함수 선언부의 파라미터 뒤에 붙임
//throwing function
func validateUserInputError(text: String) throws -> Bool{
    guard !(text.isEmpty) else{
        
        print("빈값")
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else{
        print("숫자가 아닙니다.")
        throw ValidationError.isNotInt
    }
    
    guard checkDateFormat(text: text) else{
        print("날짜 형태가 잘못되었습니다.")
        throw ValidationError.isNotDate
    }
    
    return true
}

//try! 오류가 던져지면 런타임 오류 발생
do{
    try validateUserInputError(text: "")
}catch { //throw
    switch error as? ValidationError{
    case .emptyString:
        print("빈값입니다.")
    default:
        print("나머지 오류 처리")
    }
}

let result = try! validateUserInputError(text: "")
print(result)

//200번 오류거 터압울 규채족욿 종우ㅏ헐  =슈 옵ㅇ소오소,타입캐팅으로 종의할 수 없어서 다니백하개 인정


//: [Next](@next)
