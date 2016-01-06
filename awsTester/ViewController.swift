//
//  ViewController.swift
//  awsTester
//
//  Created by ricardo antonio cacho on 2016-01-06.
//  Copyright © 2016 ricardo antonio cacho. All rights reserved.
//

import UIKit
import AWSDynamoDB

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //AWSLogger.defaultLogger().logLevel = .Verbose
        
//        let dynamoDB = AWSDynamoDB.defaultDynamoDB()
//        let listTableInput = AWSDynamoDBListTablesInput()
//        dynamoDB.listTables(listTableInput).continueWithBlock{ (task: AWSTask!) -> AnyObject! in
//            if let error = task.error {
//                print("Error occurred: \(error)")
//                return nil
//            }
//            
//            let listTablesOutput = task.result as! AWSDynamoDBListTablesOutput
//            
//            for tableName : AnyObject in listTablesOutput.tableNames! {
//                print("\(tableName)")
//            }
//            
//            return nil
//        }
        
        
        let newBook = Book()
        newBook.ISBN = "1231231231234"
        newBook.Author = "AuthorPerson"
        newBook.Title = "TitleName"
        newBook.Price = 0
        
        //  get the singleton object mapper
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        
        // save the object
        dynamoDBObjectMapper.save(newBook).continueWithBlock { (task: AWSTask) -> AnyObject? in
            if ((task.error) != nil) {
                NSLog("The request failed. Error: [%@]", task.error!);
            }
            if ((task.exception) != nil) {
                NSLog("The request failed. Exception: [%@]", task.exception!);
            }
            if ((task.result) != nil) {
                //Do something with the result.
            }
            return nil
        }
        
        // load up an object from the table
        dynamoDBObjectMapper.load(Book.self, hashKey: "2221113331234", rangeKey: "Ricardo").continueWithBlock { (task: AWSTask) -> AnyObject? in
            if ((task.error) != nil) {
                NSLog("The request failed. Error: [%@]", task.error!);
            }
            if ((task.exception) != nil) {
                NSLog("The request failed. Exception: [%@]", task.exception!);
            }
            if ((task.result) != nil) {
                //Do something with the result.
                let oldBook = task.result
                print("\(oldBook)")
            }
           return nil
        }
        
        
        let scanExpression = AWSDynamoDBScanExpression()
        
        dynamoDBObjectMapper.scan(Book.self, expression: scanExpression).continueWithBlock {
            (task: AWSTask) -> AnyObject? in
            if ((task.error) != nil) {
                NSLog("The request failed. Error: [%@]", task.error!);
            }
            if ((task.exception) != nil) {
                NSLog("The request failed. Exception: [%@]", task.exception!);
            }
            if ((task.result) != nil) {
                if let paginatedOutput = task.result as? AWSDynamoDBPaginatedOutput {
                    for book in paginatedOutput.items {
                        print("\(book)")
                    }
                }
            }
            return nil
        }

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

