
import SwiftUI

struct personRowView: View {
    var person: Person
    var body: some View {
        Text(person.name ?? "No Name")
    }
}

