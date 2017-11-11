//
//  ImageProcessor.swift
//  Column Quest Alpha
//
//  Created by Henry Jacobs on 11/1/17.
//  Copyright © 2017 Henry Jacobs. All rights reserved.
//

import Foundation
import UIKit
import EasyImagy
import MathSwift

class ImageProcessor{
    var w: Int
    var h: Int
    var image: Image = Image<RGBA>(named: "Corinthian.jpg")!
    
    init() {
        image = image.resize(width: 500, height: 500)
        image = image.map { (pixel: RGBA) -> RGBA in
            pixel.gray < 128 ? RGBA.black : RGBA.white}
        w = image.width
        h = image.height
    }
   
}
