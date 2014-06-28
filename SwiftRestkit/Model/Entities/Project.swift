//
//  Project.swift
//  SwiftRestkit
//
//  Created by Bhambhwani, Jaikumar (US - Mumbai) on 6/27/14.
//  Copyright (c) 2014 Jaikumar. All rights reserved.
//

import Foundation
import CoreData

@objc(Project)
class Project: NSManagedObject {
    
    @objc(identifier)
    @NSManaged var identifier: NSString
    
    @objc(name)
    @NSManaged var name: NSString
    
    @objc(descriptionText)
    @NSManaged var descriptionText: NSString

    @objc(favicon)
    @NSManaged var favicon: NSData
    
    @objc(disciplines)
    @NSManaged var disciplines : AnyObject
    
    @objc(appStore)
    @NSManaged var appStore: NSString
    
    @objc(playStore)
    @NSManaged var playStore: NSString
    
    @objc(website)
    @NSManaged var website: NSString
    
    @objc(hasTeamMembers)
    @NSManaged var hasTeamMembers: NSOrderedSet
    
    class var mappingDictionary: NSDictionary {        
        get {
            return [
                "id":"identifier",
                "name":"name",
                "description":"descriptionText",
                "favicon":"favicon",
                "disciplines":"disciplines",
                "appStore":"appStore",
                "playStore":"playStore",
                "website":"website"
            ]
        }
    }
    
    class var responseDescriptor: RKResponseDescriptor {
        
        var projectMapper = RKEntityMapping(forEntityForName: "Project", inManagedObjectStore: CoreDataStorageManager.sharedInstance.objectStore)
        projectMapper.addAttributeMappingsFromDictionary(self.mappingDictionary)
        
        var relationshipPropMapper: RKRelationshipMapping = RKRelationshipMapping(fromKeyPath: "teamMembers", toKeyPath: "hasTeamMembers", withMapping: TeamMember.teamMemberEntityMapper())
        projectMapper.addPropertyMapping(relationshipPropMapper)
        var projectResponseDescriptor = RKResponseDescriptor(mapping: projectMapper,
            method: .Any, pathPattern: nil, keyPath: "projects", statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful))
        
        return projectResponseDescriptor
    }
}