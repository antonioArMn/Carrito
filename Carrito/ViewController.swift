//
//  ViewController.swift
//  Carrito
//
//  Created by José Antonio Arellano Mendoza on 4/25/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, ArticleTableViewCellDelegate {
    
    //Outlets
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var goToCartButton: UIButton!
    
    //Variables
    var total: Float = 0.0
    //var selectedArticles: [Article] = []
    var selectedArticles = [Article]()
    var newArticles = [Article]()
    
    //Headers and Footers
    var sectionsHeaders: [String] = ["Fruits", "Vegetables"]
    var sectionsFooters: [String] = ["Delicious and fresh fruits", "Delicious and fresh vegetables"]
    
    //Arreglo de arreglos. Para usar secciones.
    var articles: [[Article]] = [
        [Article(symbol: "🍎", name: "Apple", price: 5),
         Article(symbol: "🍐", name: "Pear", price: 5.30),
         Article(symbol: "🍊", name: "Tangerine", price: 5),
         Article(symbol: "🍋", name: "Lemon", price: 5),
         Article(symbol: "🍌", name: "Banana", price: 5),
         Article(symbol: "🍉", name: "Watermelon", price: 5.75),
         Article(symbol: "🍇", name: "Grapes", price: 5),
         Article(symbol: "🍓", name: "Strawberry", price: 5.50),
         Article(symbol: "🍈", name: "Cantaloupe", price: 5),
         Article(symbol: "🍒", name: "Cherry", price: 5),
         Article(symbol: "🍑", name: "Peach", price: 5.25),
         Article(symbol: "🥭", name: "Mango", price: 5),
         Article(symbol: "🍍", name: "Pineapple", price: 5),
         Article(symbol: "🥥", name: "Coconut", price: 5),
         Article(symbol: "🥝", name: "Kiwi", price: 5),
         Article(symbol: "🥑", name: "Avocado", price: 5)],
        [Article(symbol: "🍅", name: "Tomato", price: 5),
         Article(symbol: "🍆", name: "Eggplant", price: 5),
         Article(symbol: "🥦", name: "Broccoli", price: 5),
         Article(symbol: "🥬", name: "Lettuce", price: 5.50),
         Article(symbol: "🥒", name: "Cucumber", price: 5),
         Article(symbol: "🌶", name: "Red pepper", price: 5),
         Article(symbol: "🌽", name: "Corn", price: 5.15),
         Article(symbol: "🥕", name: "Carrots", price: 5),
         Article(symbol: "🥔", name: "Potato", price: 5),
         Article(symbol: "🍠", name: "Sweet potato", price: 5)]
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation Item title
        navigationItem.title = "Fruit Store"
        
        //Table config
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        
        //Add constraints
        //goToCartButton
        goToCartButton.backgroundColor = UIColor(red:0.12, green:0.51, blue:0.30, alpha:1.0)
        goToCartButton.tintColor = .white
        goToCartButton.translatesAutoresizingMaskIntoConstraints = false
        goToCartButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        goToCartButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        goToCartButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        goToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //articleListTableView
        articleListTableView.translatesAutoresizingMaskIntoConstraints = false
        articleListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        articleListTableView.bottomAnchor.constraint(equalTo: goToCartButton.topAnchor).isActive = true
        articleListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        articleListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    }
    
    //Cada vez que la vista vaya a aparecer, refrescamos datos de la tabla. Buena práctica
    override func viewWillAppear(_ animated: Bool) {
        //articleListTableView.reloadData()
        //Array tomado de Car list
        //print(newArticles)
        selectedArticles = newArticles
        articleListTableView.reloadData()
        updateGoToCartButton()
    }
    
    //MARK: TableView Data Source
    //Numero de secciones
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsHeaders.count
    }
    
    //Headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsHeaders[section]
    }
    
    //Footers
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sectionsFooters[section]
    }
    
    //Numero de celdas en cada seccion.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Solo tenemos una sección, la cero.
        if section == 0 {
            return articles[0].count
        } else if section == 1 {
            return articles[1].count
        } else if section == 2 {
            return articles[2].count
        } else {
            return 0
        }
    }
    
    //Contenido de cada celda.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //1. Creamos la celda del mismo tipo que definimos en el storyboard: "ArticleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        
        //2. Get the appropiate model object to display on the cell
        let article = articles[indexPath.section][indexPath.row]
        
        //3. Configuramos celda
        //cell.textLabel?.text = "\(article.symbol) - \(article.name)"
        //cell.detailTextLabel?.text = "$\(article.price)"
        cell.update(with: article)
        //Reorder control button
        cell.showsReorderControl = true
        
        //Delegate del custom cell
        cell.delegate = self
        
        //4. Retornamos celda
        return cell
    }
    
    //MARK: TableView Delegate
    //Grosor de la celda
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 90.0
//    }
    //Que celda seleccionamos, deseleccionamos la que este seleccionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let article = articles[indexPath.section][indexPath.row]
        //print("\(article.symbol) \(indexPath)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //ArticleTableViewCellDelegate
    func didTapAdd(article: Article) {
        let alert = UIAlertController(title: "Item selected", message: "Would you like to add \(article.symbol) \(article.name) to your shopping cart?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            self.selectedArticles.append(article)
            //Imprimir lista
            //for article in self.selectedArticles {
            //    print("Articulo: \(article.symbol)")
            //}
            //print("---------------")
            self.updateGoToCartButton()
        }
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "No", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //Actions
    @IBAction func goToCart(_ sender: UIButton) {
        print("Go to cart!")
    }
    
    //Functions
    func updateGoToCartButton() {
        goToCartButton.setTitle("Go to Shopping Cart 🛒 (\(String(format: "$%.2f", getSubtotal())))", for: UIControl.State.normal)
    }
    
    func getSubtotal() -> Float {
        var subtotal: Float = 0
        for article in selectedArticles {
            subtotal = subtotal + article.price
        }
        return subtotal
    }
    
    //Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TableViewController {
            vc.selectedArticles = selectedArticles
            vc.delegate = self
        } else {
            print("Some other controller! \(segue.destination)")
        }
    }
}

extension ViewController: TableViewControllerDelegate {
    func update(_ carList: [Article]) {
        print("Paso por update")
        newArticles = carList
    }
}

