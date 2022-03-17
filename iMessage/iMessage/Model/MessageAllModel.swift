//
//  MessageAllModel.swift
//  iMessage
//
//  Created by Fabio Martinez on 17/03/22.
//

import Foundation

//MARK: Model Message

class Message {
    
    var text: String?
    var idUser: String?
    
    init(dicionario:[String: Any]) {
        self.text = dicionario["texto"] as? String
        self.idUser = dicionario["idUser"] as? String
    }
    
}

//MARK: Model Conversation

class Conversation {
    
    var name: String?
    var lastMassage: String?
    var idDestination:String?
    
    init(dicionario:[String: Any]) {
        self.name = dicionario["nomeUsuario"] as? String
        self.lastMassage = dicionario["ultimaMessagem"] as? String
        self.idDestination = dicionario["idDestinatario"] as? String
    }
    
}

//MARK: Model User

class User {
    
    var name: String?
    var email: String?
    
    init(dicionario:[String: Any]) {
        self.name = dicionario["name"] as? String
        self.email = dicionario["email"] as? String
    }
    
}

//MARK: Model Contact

class Contact {
    
    var id: String?
    var name: String?
    
    init(dicionario:[String: Any]?) {
        self.id = dicionario?["id"] as? String
        self.name = dicionario?["name"] as? String
    }
    
    convenience init(id: String?, name: String?) {
        self.init(dicionario: nil)
        self.id = id
        self.name = name
    }
    
}
