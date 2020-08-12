
import SwiftUI
import CoreData

struct NewMemberRegistrationView: View {
    @Environment(\.managedObjectContext) var userEnt: NSManagedObjectContext
    
    @State var name: String = ""
    @State var birthday: Date = Date()
    @State var LoginID: String = ""
    @State var password: String = ""
    @State var checkPass: String = ""
    @State var seniFlg: Bool = false
    @State var nameErrorFlg = false
    @State var loginErrorFlg = false
    @State var passErrorFlg = false
    @State var checkPassErrorFlg = false
    @State var passSameErrorFlg = false
    
    var from = Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    var to = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    
    var body: some View {
        NavigationView{
            VStack{
                //エラーメッセージ用ビュー
                ErrorMessageView(nameErrorFlg: $nameErrorFlg, loginErrorFlg: $loginErrorFlg, passErrorFlg: $passErrorFlg, checkPassErrorFlg: $checkPassErrorFlg, passSameErrorFlg: $passSameErrorFlg)
                Form{
                    Section(header: Text("顧客情報入力")){
                        TextField("氏名を入力してください。", text: $name)
                        DatePicker(selection: $birthday,
                                   in: from...to,
                                   displayedComponents: [.date],
                                   label: {Text("生年月日")})
                    }
                    Section(header: Text("ログイン情報入力")){
                        TextField("ログインIDを入力してください。", text: $LoginID)
                        SecureField("パスワードを入力してください。", text: $password)
                    }
                    Section(header: Text("パスワード確認")){
                        SecureField("再度パスワードを入力してください。", text: $checkPass)
                    }
                    //登録ボタン
                    Button(action:{
                        //入力項目チェック
                        self.nameErrorFlg = checkName(name: self.name)
                        self.loginErrorFlg = checkLoginID(logonID: self.LoginID)
                        self.passErrorFlg = checkPassword(pass: self.password)
                        self.checkPassErrorFlg = checkPassCheck(passCheck: self.checkPass)
                        self.passSameErrorFlg = checkSamePass(passA: self.password, passB: self.checkPass)
                        //画面遷移チェック
                        if checkAllOk(flgA: self.nameErrorFlg,
                                      flgB: self.loginErrorFlg,
                                      flgC: self.passErrorFlg,
                                      flgD: self.checkPassErrorFlg,
                                      flgE: self.passSameErrorFlg){
                            //エンティティを生成
                            let userInfo = UserInfo(entity: UserInfo.entity(), insertInto: self.userEnt)
                            userInfo.username = self.name
                            userInfo.birthday = self.birthday
                            userInfo.loginID = self.LoginID
                            userInfo.password = self.password
                            //エンティティに追加
                            try! self.userEnt.save()
                            self.seniFlg = true
                        }
                    }){
                        Text("登録")
                    }
                }
                .navigationBarTitle("新規会員登録")
                NavigationLink( destination:CompletionOfRegistrationView(), isActive: $seniFlg){
                    EmptyView()
                }.hidden()
            }
        }
    }
}

struct NewMemberRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        NewMemberRegistrationView()
    }
}

//エラー用モディファイア
struct ErrorModifire: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.footnote)
            .foregroundColor(.red)
            .frame(width: 400, height: 20, alignment: .leading)
    }
}
extension View {
    func errorText() -> some View {
        self.modifier(ErrorModifire())
    }
}

//エラーメッセージ用ビュー
struct ErrorMessageView: View {
    @Binding var nameErrorFlg: Bool
    @Binding var loginErrorFlg: Bool
    @Binding var passErrorFlg: Bool
    @Binding var checkPassErrorFlg: Bool
    @Binding var passSameErrorFlg: Bool
    
    var body: some View{
        VStack{
            //氏名が入力されていない場合表示
            if nameErrorFlg {
                Text("※氏名が入力されていません。")
                    .errorText()
            }
            //ログインIDが入力されていない場合表示
            if loginErrorFlg {
                Text("※ログインIDが入力されていません。")
                    .errorText()
            }
            //パスワードが入力されていない場合表示
            if passErrorFlg {
                Text("※パスワードが入力されていません。")
                    .errorText()
            }
            //確認用パスワードが入力されていない場合表示
            if checkPassErrorFlg {
                Text("※確認用のパスワードが入力されていません。")
                    .errorText()
            }
            //パスワードが不一致の場合表示
            if passSameErrorFlg {
                Text("※パスワードが一致しません。")
                    .errorText()
            }
        }
    }
}
