import Foundation

var width: Float = 1.5
var height: Float = 2.3

//var width: Float = 5
//var height: Float = 10

let paintCoverage: Float = 3.0

// 1 Bucket of Paint covers 1.5sqm
// My solution
var bucketsOfPaint: Int {
    get {
        let area = width * height
        let areaCoveredPerBucket: Float = 1.5
        let numberOfBuckets = area / areaCoveredPerBucket
        return Int(numberOfBuckets.rounded(.up))
    } set {
        print("\(newValue) bucket/s of paint can cover \(Double(newValue) * 1.5)sqm area")
    }
    
}
bucketsOfPaint = 4
print(bucketsOfPaint)
