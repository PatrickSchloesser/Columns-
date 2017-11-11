//
//  Math.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/2/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import Foundation
import UIKit
import EasyImagy
import MathSwift

class Math{
    
    var proc = ImageProcessor()
    
    // not sure if its right to have it as an RGBA array
    // need to find a way to print the array so i can check the values
    
    var arr = [[Double]]()
    var arrx = [Double]()

    init() {
        let w = proc.w
        let h = proc.h
        for var i in 0..<h {
            for var j in 0..<w {
                let pixel = proc.image[i,j]
                let grayOfPixel = pixel.grayInt
                arrx.append(Double(grayOfPixel))
            }
            arr.append(arrx)
            arrx.removeAll()
        }
        let m = Matrix(elements: arr)
        // SVD stuff not working, returning weird super small negative numbers
        let theU = m.singularValueDecomposition().U
        let theS = m.singularValueDecomposition().S
        let theVT = m.singularValueDecomposition().VT
        let SVDMatrix = theU * theS * theVT
        
        for element in m{
            print(element)
        }
    }
    
}
