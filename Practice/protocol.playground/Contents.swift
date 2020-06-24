import UIKit

var str = "Hello, playground"

@objc protocol kyotoProtocol{
    func stopGlobalWarming()
    @objc optional func chargeCarbonTax()
}

class Japan:kyotoProtocol{
    func stopGlobalWarming() {
        print("クリーンエネルギーを推進します。")
        print("森林を増やします。")
    }
}

var country:kyotoProtocol = Japan()

enum Week {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

var today = Week.monday


protocol LawyerLicense{
    func defend()
}

class Lawyer:LawyerLicense{
    func defend() {
        print("異議あり‼︎")
    }
}


class Defender{
    var delegate:LawyerLicense?
}

let taro = Defender()
taro.delegate = Lawyer()
taro.delegate!.defend()

class Animal{}
class Mammal:Animal{}
class Dog:Mammal{}
class Cat:Mammal{}

//var dog:Mammal = Dog()
//これは失敗する。 var cat:Dog = Cat()

var mamals:[Mammal] = [Dog(),Cat()] //mamalの配列にDogとCatのインスタンスを作成
var dog:Dog = mamals[0] as! Dog     // Dog型のdogにmamals[0]に格納されたMamals型のDodインスタンスをダウンキャスティング

