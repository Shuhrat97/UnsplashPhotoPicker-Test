//
//  Extensions+Date.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 18/10/22.
//

import Foundation


extension Date {

    func toString(withFormat format: String = "d MMMM yyyy") -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)

        return str
    }
}
