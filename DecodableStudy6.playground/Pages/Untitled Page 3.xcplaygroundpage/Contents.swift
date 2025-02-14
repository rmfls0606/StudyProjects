//: [Previous](@previous)

import Foundation

//서버에서 응답 값에 대한 키가 갑자기 이상하게 온다면? 갑자기 타입이 바뀐다면?
//Server > String > Data > Struct : decodable, 디코딩, 역직렬화
let json = """
{
    "product": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall": "네이버"
}
"""

/*
 1. json과 동일한 키를 사용하기
 2. 런타임 이슈를 방지하기 위한 옵셔널 사용 (but. 데이터를 유실)
 3. CodingKey로 서버 키와 다른 키를 매핑
 */
struct Product: Decodable{
    let item: String
    let price: Int?
    let mall: String
    let influencer: Bool
    
    enum CodingKeys: String, CodingKey{
        case item = "product"
        case price
        case mall
    }
    
    //커스텀 디코딩 전략
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item = try container.decode(String.self, forKey: .item)
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0
        mall = try container.decode(String.self, forKey: .mall)
        influencer = (100000000..<200000000).contains(price ?? 0) ? true : false
    }
}

//String > Data
guard let result = json.data(using: .utf8) else{
    fatalError("변환 실패")
}

//Data > Struct
do{
    let value = try JSONDecoder().decode(Product.self, from: result)
    dump(value)
} catch{
    print(error)
}

//: [Next](@next)
