

import UIKit

struct AdvModel {
    var albumId:Int
    var ID : Int
    var title : String
    var url  : String
    var thumbnailUrl : String
    
    init(_ item: [String:Any]){
        albumId            = item["albumId"] as? Int ?? 0
        ID                 = item["id"] as? Int ?? 0
        title              = item["title"] as? String ?? ""
        url                = item["url"] as? String ?? ""
        thumbnailUrl       = item["thumbnailUrl"] as? String ?? ""
       
        
    }
}


