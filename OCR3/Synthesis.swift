import Foundation
/*
文字列を合成するクラス
*/
class Synthesis {
    
    func connect(str1:String,str2:String)->String{
        var str = ""
        var str11 = "http://www.ait.ac"
        var str12 = "t.ac.jp/index.html"
        var num:Int = count(str11)//str11の文字数を格納
        
        //str2の先頭から適当に3文字を抽出"t.a"をgetstr2に代入、str1内からこの文字列を探す
        let getstr2 = (str2 as NSString).substringWithRange(NSRange(location:0,length:3))
        
        
        //適当にstr1の後ろから３文字目から後ろから７文字目までgetstr2と被ってる箇所を探す。
        for i in 3...7{
            //getstr1にstr1の後ろから３文字を代入、被りが見つかるまで１文字ずらして続ける。
            var getstr1 = (str1 as NSString).substringWithRange(NSRange(location: num-i, length: 3))
            
            if getstr1==getstr2{
                //被りが見つかった場合、被った部分とそれ以降を削除
                str = (str1 as NSString).substringWithRange(NSRange(location: 0, length: num-i))
                //str1の被った部分を削除したstrとstr12をくっつける
                str = str+str2
                break
                
            }else{
                //被りがなかった場合、str1とstr2をそのままくっつける
                str=str1+str2
            }
        }
        
        
        return str
    }
    
}
