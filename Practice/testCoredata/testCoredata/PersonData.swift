
import SwiftUI
import CoreData

struct PersonData: View {
    @State private var searchText: String = ""
    @State private var persons: [Person] = []
    @State private var careers: [Career] = []
    @State private var showingDetail: Bool = false
    
    var body: some View {
        VStack{
            searchView(searchText: $searchText, persons: $persons)
                .frame(width: 350, height: 65,alignment: .top)
            List{
                ForEach(self.persons, id: \.self){ person in
                    Button(action:{
                        self.showingDetail.toggle()
                        let predicate = NSPredicate(format: "person == %@", person)
                        self.careers = CoreDataModel.getCareers(with: predicate)
                        
                    })
                    { personRowView(person: person)
                    }.sheet(isPresented: self.$showingDetail){
                        PersonCarrerView(person: person, career: self.careers)
                    }
                    //行削除処理
                }.onDelete{ offset in
                    offset.forEach{ index in
                        CoreDataModel.delete(person: self.persons[index])
                    }
                    CoreDataModel.save()
                    self.persons.remove(atOffsets: offset)
                }
            }
        }
    }
}

struct PersonData_Previews: PreviewProvider {
    static var previews: some View {
        PersonData()
    }
}

struct searchView: View {
    @Binding var searchText: String
    @Binding var persons: [Person]
    var body: some View{
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(width: 20, height: 30, alignment: .center)
                TextField("検索", text: $searchText)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blue,lineWidth: 1))
                .padding()
            Button(action:{
                if self.searchText.isEmpty {
                    let re = CoreDataModel.getPersons()
                    self.persons = re
                }else{
                    let predicate = NSPredicate(format: "name == %@", self.searchText)
                    let re = CoreDataModel.getPerson(with: predicate)
                    self.persons = re
                }
            }){
                Text("検索")
                    .padding(5)
            }
            .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color.blue,lineWidth: 1))
        }
    }
}

