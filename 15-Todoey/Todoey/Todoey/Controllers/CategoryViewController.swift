//
//  CategoryViewController.swift
//  Todoey
//
//  Created by JLCS on 3/28/21.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: UITableViewController {

    // MARK: - Properties
    let realm = try! Realm()
        
    var categories: Results<Category>?
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve Data
        self.loadCategories()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Change navbar color
        let navBarAppearance = createNavBarAppearance(backgroundColor: FlatBlue(), titleTextColor: .white, largeTitleTextColor: .white)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    // MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var addCategoryTextField: UITextField?
        
        let ac = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { action in
            guard let titleString = addCategoryTextField?.text, titleString != "" else { return }
            
            let category = Category()
            category.name = titleString
            category.categoryCellColor = UIColor.randomFlat().hexValue()
            self.addNewCategory(category)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            addCategoryTextField = alertTextField
        }
        
        ac.addAction(action)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Helper Methods
    private func addNewCategory(_ category: Category) {
//        self.categories.append(category) // No need to append, `Results` auto updates
        self.saveCategory(category: category)
        
        guard let categoriesCount = self.categories?.count else { return }
        
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [IndexPath(row: categoriesCount - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
}

// MARK: - Table view data source
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") else { return UITableViewCell() }
        
        // Setup cell
        if let category = self.categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            cell.backgroundColor = UIColor(hexString: category.categoryCellColor)
        }
        
        return cell
    }
}

extension CategoryViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToItems":
            let destVC = segue.destination as! TodoListViewController
            let row = sender as! Int
            destVC.selectedCategory = self.categories?[row]
        default: break
        }
    }
}

// MARK: - Table view delegate
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToItems", sender: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let category = categories?[indexPath.row] {
                do {
                    try realm.write{
                        realm.delete(category.items)
                        realm.delete(category)
                        
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        tableView.endUpdates()
                    }
                } catch {
                    print("Error deleting category(\(category.name)): \(error.localizedDescription)")
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Data Manipulation
extension CategoryViewController {
    private func loadCategories() {
        self.categories = realm.objects(Category.self)
    }
    
    private func saveCategory(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error Saving Category: \(error.localizedDescription)")
        }
    }
}
