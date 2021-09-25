//
//  AddNotesViewController.swift
//  FullStack-ToDo
//
//  Created by Yash Sharma on 25/09/21.
//

import UIKit

class AddNotesViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var bodyField: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if note?.title != nil {
            titleField.text = note?.title
            bodyField.text = note?.body
            dateLabel.text = note?.date
        }
    }
    

    @IBAction func onSave(_ sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = formatter.string(from: NSDate() as Date)
        if note == nil {
            let notesBody = Note(_id: "", title: titleField.text, body: bodyField.text, date: date)
            let status  = ToDo.functions.createTodo(notesBody: notesBody)
           
                self.navigationController?.popViewController(animated: true)
            
        } else {
            let status = ToDo.functions.updateTodo(notesBody: Note(_id: note?._id, title: titleField.text, body: bodyField.text, date: date))
            print(status)
            
                self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func onDelete(_ sender: UIBarButtonItem) {
        if note != nil {
            let status = ToDo.functions.deleteTodo(id: note!._id!)
            note = nil
            
                self.navigationController?.popViewController(animated: true)
            
        }
        
    }
}
