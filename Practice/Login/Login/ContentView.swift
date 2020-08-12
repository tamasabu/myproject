
import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var loginID: String = ""
    @State var passWord: String = ""
    @State var kariButton = false
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    var core: CoreDataModel = CoreDataModel()


    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Text("ログイン画面")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(30)
                    .padding()
                VStack{
                    HStack{
                        Text("ログインID:")
                        TextField("ログインIDを入力", text: $loginID)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack{
                        Text("パスワード:")
                        SecureField("パスワードを入力", text: $passWord)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding()
                Button(action:{
                    if self.core.Fech(ID: self.loginID, pass: self.passWord){
                        self.kariButton = true
                    }else{
                        self.kariButton = false
                    }
                }){
                    Text("テスト")
                }
                
                if self.kariButton{
                     Text("OK")
                 }else{
                     Text("NG")
                 }
                
                NavigationLink(destination: MemberView(loginid: self.loginID, pass: self.passWord)){
                    Text("ログイン")
                }
                .padding()
                NavigationLink(destination: NewMemberRegistrationView()){
                    Text("新規会員登録")
                }
                .padding()
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

