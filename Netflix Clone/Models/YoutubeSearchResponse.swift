//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Rituraj Mishra on 25/02/22.
//  Copyright © 2022 rtrjmishra. All rights reserved.
//

import Foundation

struct YoutubeSearchResponse: Codable
{
    let items: [VideoElement]
}

struct VideoElement: Codable
{
    let id: IdVideoElement
}

struct IdVideoElement: Codable
{
    let kind: String
    let videoId: String
}
