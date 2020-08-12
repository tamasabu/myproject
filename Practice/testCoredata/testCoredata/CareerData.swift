
import SwiftUI
import Combine

class CareerData: ObservableObject {
    @Published var count:Int = 0
    @Published var company_name = [String]()
    @Published var career_startDay = [Date]()
    @Published var career_endDay = [Date]()
    @Published var checknil = false
    @Published var checkfromto = false
}
