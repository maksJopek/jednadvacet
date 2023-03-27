import Foundation

let values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "W", "D", "K", "A"]
let colors = ["♠", "♥", "♦", "♣"]
let valuesToPoints = ["2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10, "W": 2, "D": 3, "K": 4, "A": 11]

class Card: Hashable {
    var color = "";
    var value = "";

    init(_ c: String, _ v: String) {
        color = c;
        value = v;
    }

    func points() -> Int {
        valuesToPoints[value]!
    }
    func str() -> String {
        color + value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(color + value)
    }
}
func ==(card1: Card, card2: Card) -> Bool {
    return card1.str() == card2.str()
}

func persianEye(_ cs: Set<Card>) -> Bool {
    if cs.count == 2 {
        for c in cs {
            if c.value != "A" {
                return false
            }
        }
        return true
    }
    return false
}

var cards: Set<Card> = []
var player: Set<Card> = []
var playerPoints = 0
var bot: Set<Card> = []
var botPoints = 0

for c in colors {
    for v in values {
        cards.insert(Card(c, v)) 
    }
}

var choice = ""
print("Player:")
while choice.lowercased() != "pas" {
    let card = cards.randomElement()!
    cards.remove(card)
    player.insert(card)
    playerPoints += card.points()
    for (i, c) in player.enumerated() {
        var term = ", "
        if i == player.count - 1 {
            term = ""
        }
        print(c.str() + " " + "(\(c.points()))", terminator: term)
    }
    print("\t\tΣ \(playerPoints)")
    if playerPoints == 21 || persianEye(player) {
        print("\nPlayer won!!!")
        exit(0)
    } else if playerPoints > 21 {
        print("\nComputer won!!!")
        exit(0)
    }
    choice = readLine()!
}

print("\nComputer:")
while true {
    let card = cards.randomElement()!
    cards.remove(card)
    bot.insert(card)
    botPoints += card.points()
    for (i, c) in bot.enumerated() {
        var term = ", "
        if i == bot.count - 1 {
            term = ""
        }
        print(c.str() + " " + "(\(c.points()))", terminator: term)
    }
    print("\t\tΣ \(botPoints)")
    if botPoints == 21 || persianEye(bot) {
        print("\nComputer won!!!")
        exit(0)
    } else if botPoints > 21 {
        print("\nPlayer won!!!")
        exit(0)
    } else if playerPoints < botPoints && (botPoints + 5 > 21) {
        print("Pas")
        break
    } else {
        print("Dobieram")
    }
    usleep(500_000)
}

if playerPoints > botPoints {
    print("\nPlayer won!!!")
} else if playerPoints == botPoints {
    print("\nRemis!!!")
} else {
    print("\nComputer won!!!")
}
