package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

type Point struct {
	x int
	y int
}

func main() {
	readder := bufio.NewReader(os.Stdin)
	data, err := readder.ReadString('\n')
	if err != nil {
		fmt.Println("Waat: %v", err)
	}
	data = strings.TrimSuffix(data, "\n")
	input, err := strconv.Atoi(data)
	if err != nil {
		fmt.Println("Waat: %v", err)
	}

	// part 1
	row := 0
	maxVal := 0
	for true {
		maxVal = int(math.Pow(float64(row*2)+math.Pow(1.0, float64(row)), 2))
		if input < maxVal {
			break
		}
		row++
	}
	fmt.Println(row + int(math.Abs(float64(row-(maxVal-input)%(2*row)))))

	// part 2
	curr := Point{0, 0}
	step := Point{1, 0}
	s := map[Point]int{curr: 1}
	for true {
		curr, step = nextPoint(curr, step)
		v := getPointVal(curr, s)
		if v > input {
			fmt.Println(v)
			break
		}
		s[curr] = v
	}
}

func getN(p Point) []Point {
	return []Point{
		Point{p.x + 1, p.y},
		Point{p.x + 1, p.y + 1},
		Point{p.x, p.y + 1},
		Point{p.x - 1, p.y + 1},
		Point{p.x - 1, p.y},
		Point{p.x - 1, p.y - 1},
		Point{p.x, p.y - 1},
		Point{p.x + 1, p.y - 1},
	}
}

func getPointVal(curr Point, s map[Point]int) int {
	sum := 0
	for _, p := range getN(curr) {
		v, ok := s[p]
		if ok {
			sum += v
		}
	}
	return sum
}

func nextPoint(p Point, prevStep Point) (Point, Point) {
	turning := map[Point]Point{
		Point{1, 0}:  Point{0, 1},
		Point{0, 1}:  Point{-1, 0},
		Point{-1, 0}: Point{0, -1},
		Point{0, -1}: Point{1, 0},
	}
	right := Point{1, 0}
	var nextStep Point
	x := int(math.Abs(float64(p.x)))
	y := int(math.Abs(float64(p.y)))
	var row int
	if x > y {
		row = x
	} else {
		row = y
	}

	if p.x+p.y == 0 && prevStep == right {
		return Point{p.x + prevStep.x, p.y + prevStep.y}, turning[prevStep]
	} else if int(math.Abs(float64(p.x)))+int(math.Abs(float64(p.y))) == 2*row {
		nextStep = turning[prevStep]
		return Point{p.x + nextStep.x, p.y + nextStep.y}, nextStep
	} else {
		nextStep = prevStep
		return Point{p.x + nextStep.x, p.y + nextStep.y}, nextStep
	}
}
