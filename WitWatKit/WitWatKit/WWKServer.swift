//
//  WWKServer.swift
//  WitWatKit
//
//  Created by Nico Cvitak on 2015-10-18.
//  Copyright © 2015 UW-AppDEV. All rights reserved.
//

import Foundation
import Parse

public final class WWKServer {
    
    private static let serverInstance = WWKServer()
    
    public class func defaultServer() -> WWKServer {
        return serverInstance
    }

    private init() {
        Parse.enableLocalDatastore()
        Parse.setApplicationId("dbSRgndFtVlkxJUG1AcubhVaP814yfO0HAqrEjaU", clientKey: "LWqPDlBCoLfhG2bG7ZvjKdNpvcbl8JARkLHcaoWf")
    }
    
    public func queryPostsWithCompletionHandler(handler: ([WWKPost]) -> Void) {
        let query = PFQuery(className: "WWKPost")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            var posts: [WWKPost] = []
            if let objects = objects {
                for object in objects {
                    if let objectId = object.objectId,
                        let content = object["content"] as? String,
                        let score = object["score"] as? Int {
                        posts.append(WWKPost(parseId: objectId, content: content, score: score))
                    }
                }
            }
            handler(posts)
        }
    }
    
    public func queryCommentsForPost(post: WWKPost, completionHandler handler: ([WWKComment]) -> Void) {
        let query = PFQuery(className: "WWKComment")
        query.whereKey("postId", equalTo: post.parseId)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            var comments: [WWKComment] = []
            if let objects = objects {
                for object in objects {
                    if let objectId = object.objectId,
                        let content = object["content"] as? String,
                        let score = object["score"] as? Int {
                            comments.append(WWKComment(parseId: objectId, content: content, score: score))
                    }
                }
            }
            handler(comments)
        }
    }
}