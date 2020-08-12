
import SwiftUI

struct ErrorMessageView: View {
    var companyCheck = false
    var fromtoCheck = false
    var body: some View {
        VStack{
            if companyCheck {
                Text("※会社名が入力されていません。")
            }
            if fromtoCheck {
                Text("※入社日と退職日の入力に誤りがあります。")
            }
        }.foregroundColor(.red)
            .font(.footnote)
    }
}
