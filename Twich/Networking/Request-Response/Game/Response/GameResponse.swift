import Foundation

struct GameResponse: ApiResponse {
    let total: Int
    var tops: [GameResponseTop] = []
    
     init(json: [String : Any]) {
        total = json["_total"] as! Int        
        let tTops = (json["top"]) as! [[String : Any]]
        for top in tTops{
            tops.append(GameResponseTop(json: top))
        }
    }

}
