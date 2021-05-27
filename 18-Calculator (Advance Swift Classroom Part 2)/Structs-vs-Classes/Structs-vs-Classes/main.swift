//
//  main.swift
//  Structs-vs-Classes
//
//  Created by JLCS on 5/26/21.
//

import Foundation

var hero = StructHero(name: "Chabby", universe: "Marvel")
var anotherMarvelHero = hero
anotherMarvelHero.name = "The Hulk"

print("Hero Name: \(hero.name)")
print("anotherMarvelHero: \(anotherMarvelHero.name)")

hero.reverseName()
print("reverse: \(hero.name)")
