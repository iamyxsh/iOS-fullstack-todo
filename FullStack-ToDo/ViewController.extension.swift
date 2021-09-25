//
//  ViewController.extension.swift
//  FullStack-ToDo
//
//  Created by Yash Sharma on 23/09/21.
//

import Foundation

extension ViewController : DataDelegate {
    func updateToDoArray(todoArray: [Note]) {
            notesArray = todoArray
        notesTableView?.reloadData()
    }
    
}
