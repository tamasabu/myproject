import UIKit
import CoreData

class CoreDataModel {
    //AppDelegateに定義されたものを参照
    private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //インスタンスの生成
    static func newPerson() -> Person {
        let context = persistentContainer.viewContext
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        return person
    }
    static func newCareer(into person : Person) -> Career{
        let context = persistentContainer.viewContext
        let career = NSEntityDescription.insertNewObject(forEntityName: "Career", into: context) as! Career
        person.addToCarrers(career)
        return career
    }
    //保存処理を呼んで変更を確定させる
    static func save(){
        persistentContainer.saveContext()
    }
    //削除処理
    static func delete(person: Person){
        let context = persistentContainer.viewContext
        context.delete(person)
    }
    static func delete(career: Career){
        let context = persistentContainer.viewContext
        context.delete(career)
    }
    
    //全件取得
    static func getPersons() -> [Person] {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let persons = try context.fetch(request) as! [Person]
            return persons
        } catch {
            fatalError()
        }
    }
    //絞り込む条件
    static func getPerson(onlyAfter birthday: Date)-> [Person]{
        let predicate = NSPredicate(format: "birthday >= %@", birthday as NSDate)
        return getPerson(with: predicate)
    }
    //条件をもとに値を返す
    static func getPerson(with predicate: NSPredicate) -> [Person]{
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        request.predicate = predicate
        
        do{
            let persons = try context.fetch(request) as! [Person]
            return persons
        }catch{
            fatalError()
        }
    }
    //サブエンティティのデータも条件に絞り込む
    static func getPerson(onlyAfterStartDate data: Date) -> [Person]{
        let predicate = NSPredicate(format: "SUBQUERY(careers, $c, $c.startDate >= %@).@count > 0",data as NSDate)
        return getPerson(with: predicate)
    }
    //特定のpersonに紐づくcareerを取得する
    static func getCareers(with predicate: NSPredicate?) -> [Career]{
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Career")
        request.predicate = predicate
        
        //ソートを追加
        request.sortDescriptors = [
        NSSortDescriptor(key: "startDate", ascending: true)]
        
        do{
            let carrers = try context.fetch(request) as! [Career]
            return carrers
        }catch{
            fatalError()
        }
    }
}




