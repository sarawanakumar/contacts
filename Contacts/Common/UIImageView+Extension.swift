import Foundation
import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageFromCache(url: String) {
        guard let imageUrl = URL(string: url) else {
            image = nil
            return
        }

        if let cachedImage = imageCache.object(forKey: url as NSString) as? UIImage {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }

        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data,
                let image = UIImage(data: data),
                error == nil else {
                self.image = nil
                return
            }

            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: url as NSString)
                self.image = image
            }
        }.resume()
    }
}
