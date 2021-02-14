import Foundation

struct Game: ApiResponse {
    let id: Int
    let giantbombId: Int
    let name: String
    let box: BoxOrLogo
    let logo: BoxOrLogo
    
    init?(json: [String : Any]) {
        guard let id = json["_id"] as? Int,
              let giantbombId = json["giantbomb_id"] as? Int,
              let name = json["name"] as? String,
              let tBox = json["box"] as? [String:Any],
              let tLogo = json["logo"] as? [String:Any],
              let box = BoxOrLogo(json: tBox),
              let logo = BoxOrLogo(json: tLogo)
        else{
            return nil
        }
        self.id = id
        self.giantbombId = giantbombId
        self.name = name
        self.box = box
        self.logo = logo
    }
    
}
