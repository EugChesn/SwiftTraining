//
//  GuessNumber.swift
//  Practice1
//
//  Created by Евгений on 29.01.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import Foundation

// Границы рандомайзера
let max_thresh: UInt32 = 100
let min_thresh: UInt32 = 0

//Рандомайзер
func guess_num () -> UInt32{
    let randomNumber = arc4random_uniform(UInt32(max_thresh - min_thresh) + 1) + min_thresh
    return randomNumber
}


 
