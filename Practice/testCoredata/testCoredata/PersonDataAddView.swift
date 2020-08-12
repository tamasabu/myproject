
import SwiftUI

struct PersonDataAddView: View {
    @State private var name: String = ""
    @State private var birthday: Date = Date()
    @State private var company: String = ""
    @State private var startDay: Date = Date()
    @State private var endDate: Date = Date()
    @State private var showingAlert: Bool = false
    @State private var showWorkError: Bool = false
    @State private var showNameError: Bool = false
    @ObservedObject var careerData = CareerData()
    @Environment(\.presentationMode) var presentaitionMode
    
    var from = Calendar.current.date(byAdding: .year, value: -120, to: Date())!
    var to = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
    
    var body: some View {
        NavigationView{
            VStack{
                //職歴に関するエラーメッセージを表示
                if showWorkError{
                    ErrorMessageView(companyCheck:
                        self.careerData.checknil,
                                     fromtoCheck:
                        self.careerData.checkfromto)
                }
                if showNameError{
                    RegisterErrorView(namenilcheck: self.showNameError)
                }
                
                Form{
                    Section(header: Text("個人情報")){
                        //氏名入力
                        TextField("氏名を入力して下さい。", text: $name)
                        //生年月日入力
                        DatePicker(selection: $birthday,
                                   in: from...to,
                                   displayedComponents: [.date],
                                   label: {Text("生年月日")})
                    }
                    Section(header: Text("職歴")){
                        //会社名入力
                        TextField("会社名を入力して下さい。", text: $company)
                        //入社日入力
                        DatePicker(selection: $startDay,
                                   in: from...Date(),
                                   displayedComponents: [.date],
                                   label: {Text("入社日")})
                        //退職日入力
                        DatePicker(selection: $endDate,
                                   in: from...Date(),
                                   displayedComponents: [.date],
                                   label: {Text("退職日")})
                    }
                }
                Divider()
                HStack{
                    //職歴追加ボタン
                    Button(action:{
                        //会社名がnilじゃないかチェック
                        if checknil(st: self.company){
                            self.careerData.checknil = true
                        }else{
                            self.careerData.checknil = false
                        }
                        //FromToが正しく入力されているかチェック
                        if checkFromTo(from: self.startDay, to: self.endDate){
                            self.careerData.checkfromto = true
                        }else{
                            self.careerData.checkfromto = false
                        }
                        //職歴に追加していいかチェック
                        if checkWorkHistory(checknil: self.careerData.checknil, checkFromTo: self.careerData.checkfromto){
                            self.careerData.company_name.append(self.company)
                            self.careerData.career_startDay.append(self.startDay)
                            self.careerData.career_endDay.append(self.endDate)
                            self.careerData.count += 1
                            self.showWorkError = false
                        }else{
                            self.showWorkError = true
                        }
                    }){
                        Text("職歴追加")
                            .padding(5)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue,lineWidth: 1))
                    //登録ボタン
                    Button(action:{
                        //氏名がnilかチェック
                        if checknil(st: self.name){
                            self.showNameError = true
                        }else{
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy/MM/dd"
                            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
                            // Person作成
                            let person = CoreDataModel.newPerson()
                            person.name = self.name
                            person.birthday = dateFormatter.date(from: dateToString(date: self.birthday))
                            //careerを繰り返し保存
                            for i in 0..<self.careerData.count{
                                let career = CoreDataModel.newCareer(into: person)
                                career.company = self.careerData.company_name[i]
                                career.startDate = dateFormatter.date(from: dateToString(date: self.careerData.career_startDay[i]))
                                career.endDate = dateFormatter.date(from: dateToString(date: self.careerData.career_endDay[i]))
                            }
                            //データを保存
                            CoreDataModel.save()
                            self.showNameError = false
                            self.showingAlert = true
                        }
                    }){
                        Text("登録")
                            .padding(5)
                    }
                    .foregroundColor(.red)
                    .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.red,lineWidth: 1))
                        //登録完了アラートを出して画面を閉じる
                        .alert(isPresented: $showingAlert){
                            Alert.init(title: Text("登録しました。"), dismissButton: .destructive(Text("OK"), action: {self.presentaitionMode.wrappedValue.dismiss()}))
                    }
                }
                Spacer()
                if self.careerData.count == 0{
                }else{
                    List{
                        Section(header: Text("職歴一覧")){
                            ForEach(0..<self.careerData.count,id: \.self){ index in
                                carrerView(company_name: self.careerData.company_name[index],
                                           carrer_startDay: self.careerData.career_startDay[index],
                                           carrer_endDay: self.careerData.career_endDay[index])
                            }.onDelete{ offsets in
                                self.careerData.company_name.remove(atOffsets: offsets)
                                self.careerData.career_startDay.remove(atOffsets: offsets)
                                self.careerData.career_endDay.remove(atOffsets: offsets)
                                self.careerData.count -= 1
                            }
                        }
                    }
                }
            }.navigationBarTitle("個人情報登録画面" ,displayMode: .inline)
                .navigationBarItems(trailing: Button(action:{
                    self.presentaitionMode.wrappedValue.dismiss()
                }){
                    Text("close")
                })
        }
    }
}


struct PersonDataAddView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDataAddView()
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
