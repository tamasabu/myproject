import UIKit

var str = "Hello, playground"

class IPhone{
    var language:String
    var passcode:String
    init(language:String, passcode:String) {
        self.language = language
        self.passcode = passcode
    }
}

var iPhone = IPhone(language: "日本語", passcode: "0123")

func areaOfTriangle(withBase base:Int, heigth:Int){
    print(base * heigth / 2)
}

class Triabgle{
    func area(withBase base:Int, height:Int){
        print(base * height / 2)
    }
}

let triangle = Triabgle()
triangle.area(withBase: 2, height: 3)

