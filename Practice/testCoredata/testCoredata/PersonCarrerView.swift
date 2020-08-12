
import SwiftUI

struct PersonCarrerView: View {
    var person: Person
    var career = [Career]()
    @Environment(\.presentationMode) var presentaitionMode
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                Text(" 氏名")
                    .textColor()
                Text(person.name ?? "No Name")
                    .titelColor()
                Text(" 生年月日")
                    .textColor()
                Text(dateToString(date: person.birthday!))
                    .titelColor()
                Text(" 職歴")
                    .textColor()
                if career.isEmpty{
                    Text("職歴なし")
                }else{
                    List{
                        ForEach( self.career, id: \.self){ careers in
                            VStack(alignment: .leading){
                                Text(careers.company!)
                                Text("\(dateToString(date:careers.startDate!))~\(dateToString(date: careers.endDate!))")
                            }
                        }
                    }
                }
            Spacer()
            }.navigationBarTitle("個人情報画面" ,displayMode: .inline)
                .navigationBarItems(trailing: Button(action:{
                    self.presentaitionMode.wrappedValue.dismiss()
                }){
                    Text("close")
                })
        }
    }
}

struct PersonCarrerView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCarrerView(person: Person(),career: [])
    }
}

extension View {
    func titelColor() -> some View {
        self.modifier(titleModifire())
    }
    func textColor() -> some View {
        self.modifier(textModifire())
    }
    
}

struct textModifire:ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(width: 375, height: 30, alignment: .leading)
            .font(.footnote)
            .background(LinearGradient(gradient: Gradient(colors: [.blue,.white]), startPoint: .leading, endPoint: .trailing))
    }
}

struct titleModifire: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .frame(width: 365, height: 40, alignment: .leading)
            .font(.headline)
    }
}
