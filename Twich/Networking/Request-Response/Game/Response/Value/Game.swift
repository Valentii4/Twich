import Foundation

struct Game: ApiResponse {
    let id: Int
    let giantbombId: Int
    let name: String
    let box: BoxOrLogo
    let logo: BoxOrLogo
    
     init(json: [String : Any]) {
        id = json["_id"] as! Int
        giantbombId = json["giantbomb_id"] as! Int
        name = json["name"] as! String
        let tBox = json["box"] as! [String:Any]
        let tLogo = json["logo"] as! [String:Any]
        box = BoxOrLogo(json: tBox)
        logo = BoxOrLogo(json: tLogo)
    }
    
}
