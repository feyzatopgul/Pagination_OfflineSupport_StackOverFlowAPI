//
//  ImageLoader.swift
//  StackOverFlowQuestions
//
//  Created by fyz on 9/16/22.
//

import Foundation
import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private init(){}
    
    var cache = NSCache<NSString, UIImage>()
    
    func loadImage(urlString: String, completion: @escaping (UIImage) -> Void) {
        if let image = self.cache.object(forKey: urlString as NSString) {
            completion(image)
        } else {
            if let placeholder = UIImage(systemName: "person.crop.circle.fill"){
                completion(placeholder)
            }
            guard let url = URL(string: urlString) else {return}
            let task = URLSession.shared.downloadTask(with: url) { imageUrl, response , error in
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    return
                }
                guard let imageUrl = imageUrl else {
                    return
                }
                do {
                    let data = try Data(contentsOf: imageUrl)
                    if let image = UIImage(data: data){
                        self.cache.setObject(image, forKey: urlString as NSString)
                        completion(image)
                    }
                } catch let error {
                    print(error)
                }
            }
            task.resume()
        }
    }
    
}
