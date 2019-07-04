//
//  UIImageView+Extention.swift
//  Football Leagues
//
//  Created by Ayman Fathy on 7/4/19.
//  Copyright © 2019 Technivance. All rights reserved.
//

import Foundation
import UIKit

private let tasks: NSMapTable<UIImageView, URLSessionTask> = .weakToWeakObjects()
    
    extension UIImageView {
        
        func loadImage(_ URLString: String, placeHolder: UIImage?) {
            self.image = placeHolder
            ImagesSqlManager.shared.getImageData(imageURL: URLString) { [weak self] imageData in
                if imageData != nil  {
                    self?.image = UIImage.init(data:imageData!)
                     return
                }else if let url = URL(string: URLString) {
                    self?.image = placeHolder
                    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                        if error != nil {
                            if let urlError = error as? URLError, urlError.code == URLError.Code.cancelled { return }
                            print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                            DispatchQueue.main.async {
                                self?.image = placeHolder
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data {
                                if let downloadedImage = UIImage(data: data) {
                                    ImagesSqlManager.shared.insertNewImage(imageURL: URLString , imagedata: data)
                                    self?.image = downloadedImage
                                }
                            }
                        }
                    })
                    tasks.setObject(task, forKey: self)
                    task.resume()
                }
            }
            
           
        }
        
        func cancelImageLoad() {
            if let task = tasks.object(forKey: self) {
                tasks.removeObject(forKey: self)
                task.cancel()
            }
        }
    }

