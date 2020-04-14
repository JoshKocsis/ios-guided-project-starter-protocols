import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.

// Getter - Read Access
// Setter - Write Access

protocol FullyNamed {
    var fullName: String { get }
    
}

// 1. Adoption
// 2. Conformance
struct Person: FullyNamed {
    var fullName: String
}

let johnny = Person(fullName: "Johnny Hicks")
let ben = Person(fullName: "Ben")

print(johnny.fullName)

class StarShip: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    // Computed Property (Calculated Property)
    var fullName: String {
        // Ternary Operators
        return (prefix != nil ? prefix! + "": "") + self.name
    }
}

var ncc1701 = StarShip(name: "Enterprise", prefix: "USS")
ncc1701.fullName

var fireFly = StarShip(name: "Serenity")
fireFly.fullName

//: Protocols can also require that conforming types implement certain methods.
protocol GeneratesRandomNumbers {
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let rand = OneThroughTen()
rand.random()

//: Using built-in Protocols
extension StarShip: Equatable {
    static func == (lhs: StarShip, rhs: StarShip) -> Bool {
        if lhs.fullName == rhs.fullName { return true }
        else { return false }
    }
}

if ncc1701 == fireFly {
    print("Same Starship!")
}


//: ## Protocols as Types
class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers
    
    init(sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() % sides) + 1
        // Dice 6 sides
        // 1 % 6 + 1 = 6
        // 2 % 6 + 1 = 5
        // 3 % 6 + 1 = 4
        // 4 % 6 + 1 = 3
        // 5 % 6 + 1 = 2
        // 6 % 6 + 1 = 1
        // 7 % 6 + 1 = 2
        // 8 % 6 + 1 = 3
        // 9 % 6 + 1 = 4
        // 10 % 6 + 1 = 5
    }
}

var d6 = Dice(sides: 6, generator: OneThroughTen())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
