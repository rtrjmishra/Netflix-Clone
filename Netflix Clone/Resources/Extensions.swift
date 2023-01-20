//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/03/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import Foundation


extension String
{
    func capitalizeFirstLetter() -> String
    {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
