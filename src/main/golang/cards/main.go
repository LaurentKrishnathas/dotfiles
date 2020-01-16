package main

import "fmt"

func main() {
	cards := deck{"Ace of Spades"}
	cards = append(cards, "six of spades")

	fmt.Println("____________________________________________________________________________________________________ for loop ...")
	for i, card := range cards {
		fmt.Println(i, card)
	}

	fmt.Println("---------------------------------------------------------------------------------------------------- cards print")
	cards.print()

	fmt.Println("---------------------------------------------------------------------------------------------------- newDeck function")
	cards = newDeck()

	cards.print()

	fmt.Println("----------------------------------------------------------------------------------------------------  deal function hand")

	hand, remainingCards := deal(cards, 1)

	hand.print()
	fmt.Println("----------------------------------------------------------------------------------------------------  deal function remaining")
	remainingCards.print()

	fmt.Println("----------------------------------------------------------------------------------------------------  tostring function")

	//cards= newDeck()
	cards.toString()

	//cards.saveToFile("/tmp/hello")
	//cards:=newDeckFromFile("/tmp/hello")
}
