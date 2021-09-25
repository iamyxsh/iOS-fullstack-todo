//
//  ViewController.swift
//  FullStack-ToDo
//
//  Created by Yash Sharma on 20/09/21.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notesArray: [Note] = []
    
    @IBOutlet weak var notesTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        ToDo.functions.fetchToDos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        ToDo.functions.fetchToDos()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDo.functions.delegate = self
        notesTableView.delegate = self
        notesTableView.dataSource = self
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].title!
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNotesViewController
        
        if segue.identifier == "showNoteById" {
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
        }
    }
}

