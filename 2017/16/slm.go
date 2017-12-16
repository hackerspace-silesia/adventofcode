package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func spin(p []string, start int) []string {
	x := len(p) - start
	return append(p[x:], p[:x]...)
}

func exchange(p []string, x, y int) []string {
	p[x], p[y] = p[y], p[x]
	return p
}

func partner(p []string, a, b string) []string {
	indA, indB := -1, -1
	for i := 0; i < len(p) && (indA == -1 || indB == -1); i++ {
		if p[i] == a {
			indA = i
		} else if p[i] == b {
			indB = i
		}
	}
	p[indA], p[indB] = p[indB], p[indA]
	return p
}

func readInput() []string {
	readder := bufio.NewReader(os.Stdin)
	data, _ := readder.ReadString('\n')
	data = strings.TrimSuffix(data, "\n")
	f := func(c rune) bool {
		return c == ','
	}
	return strings.FieldsFunc(data, f)
}

func dance(input []string, p []string) []string {
	for _, i := range input {
		switch i[0] {
		case 's':
			start, _ := strconv.Atoi(i[1:])
			p = spin(p, start)
		case 'x':
			parts := strings.Split(i[1:], "/")
			x, _ := strconv.Atoi(parts[0])
			y, _ := strconv.Atoi(parts[1])
			p = exchange(p, x, y)
		case 'p':
			parts := strings.Split(i[1:], "/")
			x := parts[0]
			y := parts[1]
			p = partner(p, x, y)
		}
	}
	return p
}

func part2(input []string, dances int) string {
	p := strings.Split("abcdefghijklmnop", "")
	cyclesMap := map[string]bool{"abcdefghijklmnop": true}
	cycles := []string{"abcdefghijklmnop"}
	for {
		p = dance(input, p)
		result := strings.Join(p, "")
		_, ok := cyclesMap[result]
		if ok {
			break
		}
		cyclesMap[result] = true
		cycles = append(cycles, result)
	}
	return cycles[dances%len(cycles)]

}

func main() {
	input := readInput()
	fmt.Println(strings.Join(dance(input, strings.Split("abcdefghijklmnop", "")), ""))
	fmt.Println(part2(input, 1000000000))
}
