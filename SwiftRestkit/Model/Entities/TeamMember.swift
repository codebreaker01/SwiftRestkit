//
//  TeamMember.swift
//  SwiftRestkit
//
//  Created by Bhambhwani, Jaikumar (US - Mumbai) on 6/27/14.
//  Copyright (c) 2014 Jaikumar. All rights reserved.
//

import Foundation
import CoreData

@objc(TeamMember)
class TeamMember: NSManagedObject {
    
    @objc(identifier)
    @NSManaged var identifier: NSString
    
    @objc(name)
    @NSManaged var name: NSString
    
    @objc(role)
    @NSManaged var role: NSString
    
    @objc(inProject)
    @NSManaged var inProject: NSOrderedSet
    
    class var mappingDictionary: NSDictionary {
            get {
                return [
                    "id":"identifier",
                    "name":"name",
                    "role":"role"
                ]
            }
    }
    
    class func teamMemberEntityMapper() -> RKEntityMapping {
        var teamMemberMapper: RKEntityMapping = RKEntityMapping(forEntityForName: "TeamMember", inManagedObjectStore: CoreDataStorageManager.sharedInstance.objectStore)
        teamMemberMapper.addAttributeMappingsFromDictionary(self.mappingDictionary)
        return teamMemberMapper
    }
    
    class var responseDescriptor: RKResponseDescriptor {
        
        var teamMemberMapper = TeamMember.teamMemberEntityMapper()
        var teamMemberResponseDescriptor = RKResponseDescriptor(mapping: teamMemberMapper,
            method: .Any, pathPattern: nil, keyPath: "teamMembers", statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful))
        
        return teamMemberResponseDescriptor
    }
}