//
//  UserPreferences.swift
//  UnsplashPhotoPicker-Test
//
//  Created by Shuhrat Nurov on 17/10/22.
//

import Foundation

class UserPreferences {
    
    static let shared = UserPreferences()
    
    private let standard = UserDefaults.standard
    
    var favouritePhotos: Set<Photo> {
        get {
            if let user = standard.structData(Set<Photo>.self, forKey: "favouritePhotos") {
                return user
            }
            return []
        } set {
            standard.setStruct(newValue, forKey: "favouritePhotos")
            NotificationCenter.default.post(name:NSNotification.Name("favouritePhotosUpdated"),object: nil)
        }
    }
}

extension UserDefaults {
    
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String) {
        do {
            let data = try JSONEncoder().encode(value)
            set(data, forKey: defaultName)
        } catch {
            DLog("error", error)
        }
        
    }
    
    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        do {
            let data = try JSONDecoder().decode(type, from: encodedData)
            return data
        } catch {
            print("decodingError \(error)")
            return nil
        }
    }
    
}


extension Photo:Equatable, Hashable{
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
