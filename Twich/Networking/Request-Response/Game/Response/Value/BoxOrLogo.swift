import Foundation

struct BoxOrLogo: ApiResponse {
    let large: String
    let medium: String
    let small: String
    let template: String
    
     init(json: [String : Any]) {
        large = json["large"] as! String
        medium = json["medium"] as! String
        small = json["small"] as! String
        template = json["template"] as! String
    }
    
    
}
