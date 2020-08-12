
import SwiftUI

//値がnilかチェックする
func checknil(st: String) -> Bool {
    if st.isEmpty{
        return true
    }else{
        return false
    }
}

//from to の日付が正しいかチェックする
func checkFromTo(from: Date, to: Date) -> Bool {
    if from > to {
        return true
    }else{
        return false
    }
}


//職歴追加時に入力がOKかチェック
func checkWorkHistory(checknil: Bool, checkFromTo: Bool ) -> Bool {
    if checknil == false && checkFromTo == false {
        return true
    }
    return false
}
