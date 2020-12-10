import Foundation

struct GameResponseTop: ApiResponse {
    private(set) var image: Data?
    let channels: Int
    let viewers: Int
    var game: Game 
    
    init(json: [String : Any]) {
        channels = json["channels"] as! Int
        viewers = json["viewers"] as! Int
        let tGame = json["game"] as! [String:Any]
        game = Game(json: tGame)
    }
    
    
}

