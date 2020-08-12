import CoreData

extension NSPersistentCloudKitContainer{
    
    //viewConextで保存
    func saveContext(){
        savaContext(context: viewContext)
    }
    
    //指定したcontextで保存
    //マルチスレッド環境でのバックグラウンドコンテキストを使う場合など
    func savaContext(context: NSManagedObjectContext){
        //変更がなければ何もしない
        guard context.hasChanges else{
            return
        }
        
        do {
            try context.save()
        }catch let error as NSError{
            print("Error: \(error), \(error.userInfo)")
        }
    }
}
