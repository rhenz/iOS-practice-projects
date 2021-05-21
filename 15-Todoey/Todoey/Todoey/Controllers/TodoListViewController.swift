//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Lawrence on 3/16/21.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class TodoListViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var todoItems: Results<Item>?
    var selectedCategory: Category?
    let realm = try! Realm()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadItems()
        
        // Set searchbar delegate
        self.searchBar.delegate = self
        
        tableView.separatorStyle = .none
        
        // Change navbar title
        title = selectedCategory?.name ?? "No Category Name"
        
        // Change bar tint color
        if let hexColor = selectedCategory?.categoryCellColor, let color = UIColor(hexString: hexColor) {
            let titleTextColor = ContrastColorOf(.black, returnFlat: true)
            let largeTitleTextColor = ContrastColorOf(.black, returnFlat: true)
            
            let navBarAppearance = createNavBarAppearance(backgroundColor: color, titleTextColor: titleTextColor, largeTitleTextColor: largeTitleTextColor)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            navigationController?.navigationBar.tintColor = ContrastColorOf(color, returnFlat: true) // Title text color
            
            searchBar.barTintColor = color
        }
        
    }
    
    // MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addItemTextField: UITextField? // Textfield inside UIAlertController
        
        let ac = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            guard let titleString = addItemTextField?.text, titleString != "" else { return }
                        
            if let currentCategory = self.selectedCategory {
                self.saveItem(with: titleString, category: currentCategory)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            addItemTextField = alertTextField
        }
        
        ac.addAction(action)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    
    
    // MARK: - Realm Methods
    private func saveItem(with title: String, category: Category) {
        do {
            try realm.write {
                let newItem = Item()
                newItem.title = title
                category.items.append(newItem)
                tableView.reloadData()
            }
        } catch {
            print("Saving error: \(error.localizedDescription)")
        }
    }
    
    private func loadItems( shouldReloadTableView: Bool = false) {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        if shouldReloadTableView { self.tableView.reloadData() }
    }
}

// MARK: - Table View Data Sources
extension TodoListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell") else {
            return UITableViewCell()
        }
        
        // Setup cell
        guard let item = self.todoItems?[indexPath.row],
              let todoItemCount = self.todoItems?.count
        else {
            cell.textLabel?.text = "No Items Added"
            return cell
        }
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        let value = CGFloat(indexPath.row) / CGFloat(todoItemCount)
        
        guard let hexValueColor = self.selectedCategory?.categoryCellColor,
              let categoryColor = UIColor(hexString: hexValueColor),
              let color = categoryColor.darken(byPercentage: value)
        else {
            return cell
        }
        
        cell.backgroundColor = color
        cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        return cell
    }
}

// MARK: - Table View Delegate
extension TodoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Update item status
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.isDone.toggle()
                }
                tableView.reloadRows(at: [indexPath], with: .automatic)
            } catch {
                print("Error saving done status: \(error.localizedDescription)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = todoItems?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(item)
                        
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.endUpdates()
                    }
                } catch {
                    print("Error deleting item: \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - UISearchBarDelegate
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText != "" else { return }
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchText).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadItems(shouldReloadTableView: true)
            DispatchQueue.main.async { searchBar.resignFirstResponder() }
        }
    }
}
