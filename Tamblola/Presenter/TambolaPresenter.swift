//
//  TambolaPresenter.swift
//  Tamblola
//
//  Created by Yash Bedi on 14/01/24.
//

import Foundation


final class TambolaPresenter {
    
    private(set) var lastGeneratedNum: Int = -1
    
    private(set) var mapForAlreadyGeneratedNums: Dictionary<Int,Bool> = [
        1: false, 2: false, 3: false, 4: false, 5: false, 6: false, 7: false, 8: false, 9: false, 10: false,
        11: false,12: false,13: false,14: false,15: false,16: false,17: false,18: false,19: false,20: false,
        21: false,22: false,23: false,24: false,25: false,26: false,27: false,28: false,29: false,30: false,
        31: false,32: false,33: false,34: false,35: false,36: false,37: false,38: false,39: false,40: false,
        41: false,42: false,43: false,44: false,45: false,46: false,47: false,48: false,49: false,50: false,
        51: false,52: false,53: false,54: false,55: false,56: false,57: false,58: false,59: false,60: false,
        61: false,62: false,63: false,64: false,65: false,66: false,67: false,68: false,69: false,70: false,
        71: false,72: false,73: false,74: false,75: false,76: false,77: false,78: false,79: false,80: false,
        81: false,82: false,83: false,84: false,85: false,86: false,87: false,88: false,89: false,90: false
    ]
    
    let dataSourceForGrid: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
                                    11,12,13,14,15,16,17,18,19,20,
                                    21,22,23,24,25,26,27,28,29,30,
                                    31,32,33,34,35,36,37,38,39,40,
                                    41,42,43,44,45,46,47,48,49,50,
                                    51,52,53,54,55,56,57,58,59,60,
                                    61,62,63,64,65,66,67,68,69,70,
                                    71,72,73,74,75,76,77,78,79,80,
                                    81,82,83,84,85,86,87,88,89,90]
    init(){
        generateFirstNum()
    }
}

// MARK: These API's are NOT exposed outside the class
private extension TambolaPresenter {
    func generateRandomNumber() -> Int {
        Int.random(in: Constants.minTambolaNum...Constants.maxTambolaNum)
    }
    
    func generateFirstNum(){
        let firstRandom = generateRandomNumber()
        mapForAlreadyGeneratedNums[firstRandom] = true
        lastGeneratedNum = firstRandom
    }
    
    func getNextRandom(_ number: Int) -> Int{
        if let numberIsCalled = mapForAlreadyGeneratedNums[number], numberIsCalled == true {
            return getNextRandom(generateRandomNumber())
        }else{
            mapForAlreadyGeneratedNums[number] = true
            lastGeneratedNum = number
            return number
        }
    }
}

// MARK: These API's are exposed outside the class
extension TambolaPresenter {
    
    func getNextTambolaNumber() -> Int{
        let random = getNextRandom(lastGeneratedNum)
        return random
    }
    
    func resetGame(){
        for (k,_) in mapForAlreadyGeneratedNums{
            mapForAlreadyGeneratedNums[k] = false
        }
        lastGeneratedNum = -1
        generateFirstNum()
    }
}
