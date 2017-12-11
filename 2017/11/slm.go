package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strings"
	"unicode"
)

type move struct {
	x, y, z int
}

func (m *move) Add(n move) {
	m.x += n.x
	m.y += n.y
	m.z += n.z
}

var d = map[string]move{
	"nw": move{1, 0, -1},
	"n":  move{1, -1, 0},
	"ne": move{0, -1, 1},
	"se": move{-1, 0, 1},
	"s":  move{-1, 1, 0},
	"sw": move{0, 1, -1},
}

func readInput() []string {
	readder := bufio.NewReader(os.Stdin)
	data, _ := readder.ReadString('\n')
	data = strings.TrimSuffix(data, "\n")
	f := func(c rune) bool {
		return !unicode.IsLetter(c) && !unicode.IsNumber(c)
	}
	return strings.FieldsFunc(data, f)
}

func distance(m move) int {
	return int(math.Abs(float64(m.x))+math.Abs(float64(m.y))+math.Abs(float64(m.z))) / 2
}

func walk(steps []string) (int, int) {
	pos := move{0, 0, 0}
	maxD := 0
	for _, step := range steps {
		pos.Add(d[step])
		dist := distance(pos)
		if dist > maxD {
			maxD = dist
		}
	}
	return distance(pos), maxD
}

func main() {
	steps := readInput()
	dist, maxDist := walk(steps)
	fmt.Println(dist)
	fmt.Println(maxDist)
}
