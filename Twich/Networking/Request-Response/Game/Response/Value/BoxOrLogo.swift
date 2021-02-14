import Foundation

struct BoxOrLogo: ApiResponse {
    let large: String
    let medium: String
    let small: String
    let template: String
    
    init?(json: [String : Any]) {
        guard let large = json["large"] as? String,
              let medium = json["medium"] as? String,
              let small = json["small"] as? String,
              let template = json["template"] as? String
        else{
            return nil
        }
        self.large = large
        self.medium = medium
        self.small = small
        self.template = template
    }
    
    
}
