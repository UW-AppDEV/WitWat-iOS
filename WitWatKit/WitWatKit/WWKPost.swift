//
//  WWKPost.swift
//  WitWatKit
//
//  Created by Nico Cvitak on 2015-10-18.
//  Copyright © 2015 UW-AppDEV. All rights reserved.
//

import Foundation

public final class WWKPost {
    
    internal let parseId: String
    
    public let content: String
    public let score: Int
    
    internal init(parseId: String, content: String, score: Int) {
        self.parseId = parseId
        self.content = content
        self.score = score
    }
}