//
//  RecipeParser.swift
//  PRORecipies
//
//  Created by Victoria Spirchina on 14.04.2023.
//

import Foundation

enum InstructionsParser {
    static func parse(instruction: String) -> [String] {
        instruction.split(separator: /\.\s*/).map({String($0)})
    }
}
