
import SwiftUI

struct RegisterErrorView: View {
    var namenilcheck = false
    var body: some View {
        VStack{
            if namenilcheck {
                Text("※氏名が入力されていません。")
            }
        }.foregroundColor(.red)
            .font(.footnote)
    }
}


