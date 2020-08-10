//
//  Array+Only.swift
//  Memorize
//
//  Created by Marlon Trujillo Ariza on 8/6/20.
//  Copyright © 2020 Marlon Trujillo Ariza. All rights reserved.
//

import Foundation
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
