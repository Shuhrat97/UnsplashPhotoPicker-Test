//
//  Extensions+String.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 18/10/22.
//

import Foundation

extension String {

    func toDate(withFormat format: String = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
