package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"unicode"
)

func readInput() [][]string {
	lab := [][]string{}
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		line := scanner.Text()
		row := strings.Split(line, "")
		lab = append(lab, row)
	}
	return lab
}

func findExit(lab [][]string) (string, int) {
	passed := ""
	startX := -1
	for i := 0; i < len(lab[0]); i++ {
		if lab[0][i] == "|" {
			startX = i
			break
		}
	}

	dirX := 0
	dirY := 1
	x, y := startX, 0
	steps := 0
	for {
		steps++
		x += dirX
		y += dirY
		s := lab[y][x]
		if strings.IndexAny(s, "|-") != -1 {
			continue
		} else if s == "+" {
			// turn
			if dirX != 0 {
				dirX = 0
				if y+1 < len(lab) && lab[y+1][x] != " " {
					dirY = 1
				} else {
					dirY = -1
				}
			} else {
				dirY = 0
				if x+1 < len(lab[y]) && lab[y][x+1] != " " {
					dirX = 1
				} else {
					dirX = -1
				}
			}
		} else if unicode.IsLetter(rune(s[0])) {
			passed = passed + s
		} else {
			// end
			break
		}
	}
	return passed, steps
}

func main() {
	lab := readInput()
	findExit(lab)
	passed, steps := findExit(lab)
	fmt.Println(passed)
	fmt.Println(steps)
}
