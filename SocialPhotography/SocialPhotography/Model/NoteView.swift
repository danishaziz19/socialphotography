//
//  NoteView.swift
//  SocialPhotography
//
//  Created by Danish Aziz on 12/10/19.
//  Copyright © 2019 Danish Aziz. All rights reserved.
//

import MapKit

class NoteView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            guard let note = newValue as? Note else {return}
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            if let imageName = note.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = note.message
            detailCalloutAccessoryView = detailLabel
        }
    }
}
