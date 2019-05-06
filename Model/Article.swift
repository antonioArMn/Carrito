//
//  Article.swift
//  Carrito
//
//  Created by José Antonio Arellano Mendoza on 5/6/19.
//  Copyright © 2019 José Antonio Arellano Mendoza. All rights reserved.
//

import Foundation

//This is our model. (MVC)
class Article {
    
    //Properties
    var symbol: String
    var name: String
    var price: Float
    
    //Constructor
    init(symbol: String, name: String, price: Float) {
        self.symbol = symbol
        self.name = name
        self.price = price
    }
}
