package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var programRegexp = regexp.MustCompile(`(\D+) \((\d+)\)( -> ([a-z, ]+))?`)

type Program struct {
	name     string
	parent   *Program
	weight   int
	sum      int
	children []*Program
}

func readInput() *Program {
	programs := map[string]*Program{}
	readder := bufio.NewReader(os.Stdin)
	var name string
	for {
		data, _ := readder.ReadString('\n')
		data = strings.TrimSuffix(data, "\n")
		match := programRegexp.FindStringSubmatch(data)
		if len(match) == 0 {
			break
		}

		weight, _ := strconv.Atoi(match[2])
		name = match[1]
		program, ok := programs[name]
		if !ok {
			program = &Program{name: name, weight: weight}
			programs[name] = program
		} else {
			program.weight = weight
		}
		if len(match) == 5 {
			for _, child := range strings.Fields(match[4]) {
				child = strings.TrimSuffix(string(child), ",")
				p, ok := programs[child]
				if !ok {
					p = &Program{name: child}
					programs[child] = p
				}
				p.parent = program
				program.children = append(program.children, p)
			}
		}
	}
	// find the head
	program := programs[name]
	for program.parent != nil {
		program = program.parent
	}
	return program
}

func updateWeights(head *Program) int {
	sum := 0
	if head.children != nil {
		for _, child := range head.children {
			sum += updateWeights(child)
		}
	}
	head.sum = head.weight + sum
	return head.sum
}

func findUnique(programs []*Program) *Program {
	curr := programs[0]
	var prev *Program
	unique := true
	for _, p := range programs[1:] {
		if curr.sum == p.sum {
			unique = false
		} else {
			prev = curr
			curr = p
			unique = true
		}
	}
	if unique {
		return curr
	} else {
		return prev
	}
}

func findBadProgram(head *Program) *Program {
	unique := findUnique(head.children)
	if unique == nil {
		// children are ok
		return head
	}
	return findBadProgram(unique)
}

func correctWeight(bad *Program) int {
	badSum := bad.sum
	var goodSum int
	for _, c := range bad.parent.children {
		if c.sum != badSum {
			goodSum = c.sum
			break
		}
	}
	diff := goodSum - badSum
	return bad.weight + diff
}

func main() {
	// part 1
	head := readInput()
	updateWeights(head)
	fmt.Println(head.name)
	// part 2
	badProgram := findBadProgram(head)
	fmt.Println(correctWeight(badProgram))
}
