import Foundation

struct GameResponse: ApiResponse {
    let total: Int
    var tops: [GameResponseTop] = []
    
     init?(json: [String : Any]) {
        guard let total = json["_total"] as? Int,
              let tTops = json["top"] as? [[String : Any]] else {
            return nil
        }
        
        self.total = total
        for top in tTops{
            guard let gameTop = GameResponseTop(json: top)  else {
                return
            }
            tops.append(gameTop)
        }
    }
}
