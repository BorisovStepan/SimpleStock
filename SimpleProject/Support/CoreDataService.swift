
import CoreData

final class CoreDataService {
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WatchlistModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func fetchData() -> [Stock] {
        let request = Stock.fetchRequest()
        guard let stocks = try? CoreDataService.context.fetch(request) else { return .init() }
        return stocks
    }
}
