
import SwiftUI

struct carrerView: View {
    var company_name: String
    var carrer_startDay: Date
    var carrer_endDay: Date
    var body: some View {
        VStack(alignment: .leading){
            Text(company_name)
            HStack{
                Text("\(dateToString(date: carrer_startDay))　〜")
                Text(dateToString(date: carrer_endDay))
            }
        }
    }
}

struct carrerView_Previews: PreviewProvider {
    
    static var previews: some View {
        carrerView(company_name: "test", carrer_startDay: Date(), carrer_endDay: Date())
    }
}

public func dateToString(date: Date) -> String {
    let formatter: DateFormatter = DateFormatter()
    formatter.locale = Locale(identifier: "ja_JP")
    formatter.dateStyle = .short
    let reDate = formatter.string(from: date)
    return reDate
}
