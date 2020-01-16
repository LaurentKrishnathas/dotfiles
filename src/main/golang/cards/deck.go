package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

//deck extend string
type deck []string

func newDeck() deck {
	cards := deck{}
	cardSuits := []string{"spades", "diamons"}
	cardValues := []string{"Ace", "Two"}

	for _, suit := range cardSuits {
		for _, value := range cardValues {
			cards = append(cards, value+" of "+suit)
		}
	}

	return cards
}

func (d deck) print() {
	for i, card := range d {
		fmt.Println(i, card)
	}
}

//This return 2 deck
func deal(d deck, handSize int) (deck, deck) {
	return d[:handSize], d[handSize:]
}

func (d deck) toString() string {
	return strings.Join([]string(d), ",")
}

func (d deck) saveToFile(filename string) error {
	return ioutil.WriteFile(filename, []byte(d.toString()), 0666)
}

func newDeckFromFile(filename string) deck {
	bs, err := ioutil.ReadFile(filename)
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(0)
	}
	s := strings.Split(string(bs), ",")
	return deck(s)
}
