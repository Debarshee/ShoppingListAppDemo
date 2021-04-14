//
//  ViewController.swift
//  DebarsheeShoppingListDemo
//
//  Created by Debarshee on 4/3/21.
//

import UIKit

class ShoppingListViewController: UIViewController {
    
    @IBOutlet weak var shoppingTableView: UITableView! {
        didSet {
            self.shoppingTableView.delegate = self
            self.shoppingTableView.dataSource = self
            self.shoppingTableView.tableFooterView = UIView()
            self.shoppingTableView.register(UINib(nibName: ShoppingListTableViewCell.cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: ShoppingListTableViewCell.cellIdentifier)
            
        }
    }
    private var dataSource: [ShoppingList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shopping List"
        self.shoppingTableView.isEditing = true
        getJsonData()
    }
    
    private func getJsonData() {
        if let path = Bundle.main.path(forResource: "product", ofType: "json") {
            do {
                let dataJson = try Data(contentsOf: URL(fileURLWithPath: path))
                let jsonDict = try JSONSerialization.jsonObject(with: dataJson, options: .mutableContainers)
                if let jsonResults = jsonDict as? [String: Any],
                   let results = jsonResults["product"] as? [[String: Any]] {
                    results.forEach { dict in
                        self.dataSource.append(ShoppingList(productName: dict["name"] as? String, productDescription: dict["description"] as? String, productCategories: dict["category"] as? String, productImage: dict["image"] as? String, productFavorite: dict["favourite"] as? Bool, productPrice: dict["price"] as? Double))
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = shoppingTableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.cellIdentifier, for: indexPath) as? ShoppingListTableViewCell
        else {
            fatalError("Failed to dequeue the cell")
        }
        let product = self.dataSource[indexPath.row]
        
        
        cell.configure(name: product.productName ?? "", price: product.productPrice ?? 0.0 , image: product.productImage ?? "")
        return cell
    }
    
    
}

extension ShoppingListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
