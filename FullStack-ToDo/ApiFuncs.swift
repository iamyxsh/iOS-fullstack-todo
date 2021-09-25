//
//  ApiFuncs.swift
//  FullStack-ToDo
//
//  Created by Yash Sharma on 23/09/21.
//
protocol DataDelegate {
    func updateToDoArray(todoArray: [Note])
}

import Foundation
import Alamofire
import SwiftUI

struct Note: Codable {
    var _id: String?
    var title: String?
    var body: String?
    var date: String?
    
    var dictionary : [String: Any] {
        return [
            "title": title ?? "",
            "_id": _id ?? "",
            "body": body ?? "",
            "date": date ?? "",
        ]
    }
}

class ToDo {
    var delegate : DataDelegate?
    static let functions = ToDo()
    
    func fetchToDos() {
        AF.request("http://localhost:5000").response { response in
            let data = String(data: response.data!, encoding: .utf8)
            
            var todoArray: [Note] = []
            do {
                todoArray = try JSONDecoder().decode([Note].self, from: (data!.data(using: .utf8)!))
            } catch let err as NSError {
                print("cannot decode - \(err.localizedDescription)")
            }
            
            self.delegate?.updateToDoArray(todoArray: todoArray)
        }
    }
    
    func createTodo(notesBody: Note) -> Int {
        var status: Int = 0
        AF.request("http://localhost:5000", method: .post, parameters: notesBody, encoder: JSONParameterEncoder.default).response { response in
            status = Int(response.response!.statusCode)
        }
        
        return status
    }
    
    func deleteTodo(id: String) -> Int {
        var status = 0
        
        AF.request("http://localhost:5000/\(id)", method: .delete).response {response in
            status = Int(response.response!.statusCode)
        }
        
        return status
    }
    
    func updateTodo(notesBody: Note) -> Int {
        var status = 0
        
        do {
            try AF.request("http://localhost:5000/\(notesBody._id!)", method: .patch, parameters: notesBody, encoder: JSONParameterEncoder.default).response { response in
            status = Int(response.response!.statusCode)
        }
        } catch let err as NSError {
                print(err.localizedDescription)
            }
        return status
    }
}
