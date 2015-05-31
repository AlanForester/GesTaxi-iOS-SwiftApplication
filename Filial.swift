//
//  Filial.swift
//  GestaoTaxis
//
//  Created by Paulo Alves on 27/05/15.
//  Copyright (c) 2015 Paulo Alves. All rights reserved.
//

import Foundation
import CoreData

class Filial: NSManagedObject {

    @NSManaged var nome: String
    @NSManaged var cidade: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var telefone: String

    
}
