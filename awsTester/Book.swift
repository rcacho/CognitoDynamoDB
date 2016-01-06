//
//  Book.swift
//  awsTester
//
//  Created by ricardo antonio cacho on 2016-01-06.
//  Copyright © 2016 ricardo antonio cacho. All rights reserved.
//

import Foundation
import AWSDynamoDB

public class Book: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    // this is the primary key and is unique
    var ISBN: String?
    // this is the range key, items in this table are organized alphabetically by this attribute
    
    var Author: String?
    
    // additionally the table is currently also suborganized by price under the Author's name
    // books by the same author will be organized by their price
    var Price: Int?
    
    // currenlty the Database will accept this attribute as empty
    var Title: String?

    // required
    public static func dynamoDBTableName() -> String! {
        return "Books"
    }
    
    // required
    // note this is the the name of the attribute not the attribute

    public static func hashKeyAttribute() -> String! {
        return "ISBN"
    }
    
    // optional
    // required in this case as we declared in AWS that the table should be organized alphabetically be Author
    public static func rangeKeyAttribute() -> String! {
        return "Author"
    }
    
    
}