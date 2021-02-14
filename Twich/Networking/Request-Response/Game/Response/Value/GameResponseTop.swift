import Foundation

struct GameResponseTop: ApiResponse {
    private(set) var image: Data?
    let channels: Int
    let viewers: Int
    var game: Game 
    
    init?(json: [String : Any]) {
        guard let channels = json["channels"] as? Int,
              let viewers = json["viewers"] as? Int,
              let tGame = json["game"] as? [String:Any],
              let game = Game(json: tGame)
        else{
            return nil
        }
        self.channels = channels
        self.viewers = viewers
        self.game = game
    }
    
    
}

