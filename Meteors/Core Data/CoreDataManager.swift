//
//  CoreDataManager.swift
//  Meteors
//
//  Created by Carl Wainwright on 14/02/2020.
//  Copyright © 2020 Carl Wainwright. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    class var shared: CoreDataManager {
        struct Singleton {
            static let instance = CoreDataManager()
        }
        return Singleton.instance
    }
    
    func saveMeteorData (meteorID: String, meteorSize: Int32, name: String, year: String, longitude: String, latitude: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Meteor", in: managedContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        managedObject.setValue(meteorID, forKey: "meteorID")
        managedObject.setValue(meteorSize, forKey: "meteorSize")
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(year, forKey: "year")
        managedObject.setValue(longitude, forKey: "longitude")
        managedObject.setValue(latitude, forKey: "latitude")
        
        do {
            try managedContext.save()
        } catch {
            let error = error as NSError
            fatalError("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchSavedData() -> [DataForMeteors]? {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meteor")
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            var savedObjects: [DataForMeteors] = []
            
            objects.forEach { (savedObject) in
                savedObjects.append(DataForMeteors(object: savedObject))
            }
            
            return savedObjects
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func fetchDataForID(meteorID: String) -> [DataForMeteors]? {
        //Fetch data for selected date
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let predicate = NSPredicate(format: "meteorID = %@", meteorID)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Meteor")
        fetchRequest.predicate = predicate
        
        do {
            let tasks = try managedContext.fetch(fetchRequest)
            var taskObjects: [DataForMeteors] = []
            
            tasks.forEach { (taskObject) in
                taskObjects.append(DataForMeteors(object: taskObject))
            }
            
            return taskObjects
        } catch let error as NSError {
            print ("Could not fetch. \(error) \(error.userInfo)")
            return nil
        }
    }
    
    func deleteAllSavedData() {
        //Remove all data saved with coreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Meteor", in: context)
        fetchRequest.includesPropertyValues = false
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for result in results {
                context.delete(result)
            }
            try context.save()
            
        } catch {
            
            print("fetch error -\(error.localizedDescription)")
        }
    }
    
}
