
import SwiftUI
import CoreData
import UIKit

//氏名が入力されているかチェック
func checkName(name: String) -> Bool{
    if name.isEmpty {
        return true
    }else{
        return false
    }
}

//ログインIDが入力されているかチェック
func checkLoginID(logonID: String) -> Bool{
    if logonID.isEmpty {
        return true
    }else{
        return false
    }
}

//パスワードが入力されているかチェック
func checkPassword(pass: String) -> Bool{
    if pass.isEmpty {
        return true
    }else{
        return false
    }
}

//確認用パスワードが入力されているかチェック
func checkPassCheck(passCheck: String) -> Bool{
    if passCheck.isEmpty {
        return true
    }else{
        return false
    }
}

//パスワードが同一かチェック
func checkSamePass(passA: String, passB: String) -> Bool {
    if passA != passB {
        return true
    }else{
        return false
    }
}

//全てフラグが立っていないかチェック
func checkAllOk(flgA: Bool, flgB: Bool, flgC: Bool, flgD: Bool, flgE: Bool) -> Bool{
    if flgA == false && flgB == false && flgC == false && flgD == false && flgE == false{
        return true
    }else{
        return false
    }
}
class CoreDataModel :NSManagedObjectContext{
    var res = [UserInfo]()
//
//    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    private static var persistentContainer: NSPersistentCloudKitContainer! = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer

    private static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func Fech(ID:String, pass: String) -> Bool {
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")

        req.predicate = NSPredicate(format: "loginID == %@ AND password == %@", [ID,pass])
        do {
            res = try context.fetch(req) as! [UserInfo]
        }catch{
            print(error)
        }
        if res.count > 0 {
            return true
        }else{
            return false
        }
    }
}

