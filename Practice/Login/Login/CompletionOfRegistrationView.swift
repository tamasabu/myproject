
import SwiftUI

struct CompletionOfRegistrationView: View {
    @FetchRequest(entity:UserInfo.entity() , sortDescriptors: [NSSortDescriptor(keyPath: \UserInfo.username, ascending: true)]) var userName: FetchedResults<UserInfo>
    
    var body: some View {
        VStack{
        Text("登録が完了しました。")
            List(userName, id: \.self){
                _userName in
                Text(_userName.username.description)
            }
            List(userName, id: \.self){
                _userName in
                Text(_userName.birthday.description)
            }
            List(userName, id: \.self){
                _userName in
                Text(_userName.loginID.description)
            }
            List(userName, id: \.self){
                _userName in
                Text(_userName.password.description)
            }
        }
    }
}

struct CompletionOfRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionOfRegistrationView().environment(\.managedObjectContext, (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
