import Foundation
struct GameRequest: ApiRequest {
    func getArray() -> [String : Any] {
        return ["offset":offset,
                "limit":limit]
    }
    let limit: Int
    let offset: Int
    
    
    
}
