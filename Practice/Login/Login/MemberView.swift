
import SwiftUI

struct MemberView: View {

    var fetchRequest: FetchRequest<UserInfo>
    init(loginid: String , pass: String) {
        fetchRequest = FetchRequest<UserInfo>(entity: UserInfo.entity(), sortDescriptors: [], predicate: NSPredicate(format: "loginID == %@ AND password == %@", [loginid,pass]))
    }
    var body: some View {
        VStack{
            Text("a")
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView(loginid: "", pass: "")
    }
}
