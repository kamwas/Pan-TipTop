//
//  UIImage+CLIImageHelpers.m
//  ComposeImageLib
//
//  Created by Kamil Wasag on 27.09.2014.
//  Copyright (c) 2014 Figure-Eight. All rights reserved.
//

import UIKit

extension UIImage {
    func imageFromView(view:UIView) -> UIImage{
    
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!);
        
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return img;
    }
    
}
