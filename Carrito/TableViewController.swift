//
//  TableViewController.swift
//  Carrito
//
//  Created by José Antonio Arellano Mendoza on 5/22/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func update(_ carList: [Article])
}

class TableViewController: UITableViewController {
    
    //Delegate
    weak var delegate: TableViewControllerDelegate?
    
    //Outlets
    @IBOutlet weak var buyButton: UIButton!
    
    //Properties
    //var articlesList: [Article] = []
    var selectedArticles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add edit button, instead of add an action
        navigationItem.rightBarButtonItem = editButtonItem
        
        //Add constraints
        //goToCartButton
        buyButton.backgroundColor = UIColor(red:0.12, green:0.51, blue:0.30, alpha:1.0)
        buyButton.tintColor = .white
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        buyButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //Update buy button
        updateBuyButton()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    //Cada vez que la vista vaya a aparecer, refrescamos datos de la tabla. Buena práctica
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    //Number of sections, only will be one
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArticles.count
    }

    //Cell content
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //1. Creamos la celda del mismo tipo que definimos en el storyboard: "EmojiCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCartCell", for: indexPath)
        
        //2. Get the appropiate model object to display on the cell
        //Solo contemplamos propiedad "row", ya que "section" va a ser la misma en todos los casos. (Solo tenemos una seccion).
        let article = selectedArticles[indexPath.row]
        //let emoji = emojis[indexPath.section][indexPath.row]
        
        //3. Configuramos celda
        cell.textLabel?.text = "\(article.symbol) - \(article.name)"
        cell.detailTextLabel?.text = "\(String(format: "$%.2f", article.price))"
        
        //4. Retornamos celda
        return cell
        
    }
    
    //Metodo para eliminar items
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedArticles.remove(at: indexPath.row)
            delegate?.update(selectedArticles)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateBuyButton()
        }
    }
    
    //Metodos del Delegate.
    //Ver que celda presionamos
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let article = selectedArticles[indexPath.row]
        //print("\(article.symbol) \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Cuando esta en modo edit: Delete
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    //Actions
    @IBAction func buyButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are your sure to buy your shopping cart?", message: "\(String(format: "$%.2f", getSubtotal()))", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    

    //Functions
    func updateBuyButton() {
        buyButton.setTitle("Buy (\(String(format: "$%.2f", getSubtotal())))", for: UIControl.State.normal)
    }
    
    func getSubtotal() -> Float {
        var subtotal: Float = 0
        for article in selectedArticles {
            subtotal = subtotal + article.price
        }
        return subtotal
    }

}
