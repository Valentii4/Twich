//
//  DbHelper.swift
//  Twich
//
//  Created by Valentin Mironov on 07.12.2020.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shareInstance = CoreDataManager()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveContext(){
        do{
            try context.save()
            print("Context is saved")
        }catch{
            print(error.localizedDescription)
        }
    }
}

//MARK: - DataBaseProvider 
extension CoreDataManager: DataBaseProvider{
    func deleteObject(object: TopGame) {
        context.delete(object)
    }
    
    func createObject(game: GameResponseTop) -> TopGame? {
        guard let imageURL = URL(string: game.game.logo.large) else{
            print("Image url note valide")
            return nil
        }
        return createObject(name: game.game.name, viewers: Int64(game.viewers), channels: Int64(game.channels), image: nil, imageURL: imageURL)
    }
    
    func createObject(name: String, viewers: Int64, channels: Int64, image: Data?, imageURL: URL) -> TopGame {
        let object  = TopGame(context: context)
        object.channels = channels
        object.image = image
        object.name = name
        object.viewers = viewers
        object.imageURL = imageURL
        return object
    }
    
    func getObjectsTop() -> [TopGame]? {
        do {
            let result = try context.fetch(TopGame.fetchRequest())
            print("TopGame get from coredata")
            return result as? [TopGame]
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getObject(withName: String) -> TopGame? {
        do {
            let fetchRequest: NSFetchRequest<TopGame> = TopGame.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "%K == %@","name",withName)
            let result = try context.fetch(fetchRequest)
            print("TopGame get from coredata elemetn - \(result.first?.name ?? "nil")")
            return result.first
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
}
