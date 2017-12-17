package main

import "fmt"

type Item struct {
	val  int
	next *Item
}

func insert(curr *Item, items, val, steps int) *Item {
	after := steps % items
	new := &Item{val: val}
	for i := 0; i < after; i++ {
		curr = curr.next
	}
	new.next = curr.next
	curr.next = new
	return new
}

func printList(start *Item) {
	end := start
	for {
		fmt.Printf("%d ->", start.val)
		start = start.next
		if start == end {
			break
		}
	}
}

func iterate(steps int, cycles int) (int, int) {
	head := &Item{val: 0}
	head.next = head
	curr := head
	items := 1
	for i := 1; i < cycles; i++ {
		curr = insert(curr, items, i, steps)
		items++
	}
	//printList(head)
	//fmt.Println()
	return curr.next.val, head.next.val
}

func main() {
	var steps int
	fmt.Scanf("%d", &steps)
	fmt.Println(iterate(steps, 2018))
	fmt.Println(iterate(steps, 50000001))
}
