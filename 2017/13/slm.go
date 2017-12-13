package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Firewall [][2]int

func readInput() (Firewall, int) {
	f := Firewall{}
	layers := 0
	readder := bufio.NewReader(os.Stdin)
	for {
		line, _ := readder.ReadString('\n')
		line = strings.Trim(line, "\n")
		if line == "" {
			break
		}
		s := strings.Split(line, ": ")
		depth, _ := strconv.Atoi(s[0])
		scannerRange, _ := strconv.Atoi(s[1])
		f = append(f, [2]int{depth, scannerRange})
		layers = depth
	}
	return f, layers
}

func isCaught(time, sRange int) bool {
	return time%(2*(sRange-1)) == 0
}

func getSeverity(f Firewall, layers int) int {
	severity := 0
	for _, rule := range f {
		layer, sRange := rule[0], rule[1]
		if isCaught(layer, sRange) {
			severity += layer * sRange
		}
	}
	return severity
}

func whenToStart(f Firewall, layers int) int {
	time := 0
loop:
	for {
		for _, rule := range f {
			layer, sRange := rule[0], rule[1]
			if isCaught(time+layer, sRange) {
				break
			}
			if layer == layers {
				break loop
			}
		}
		time++
	}
	return time
}

func main() {
	f, layers := readInput()
	fmt.Println(getSeverity(f, layers))
	fmt.Println(whenToStart(f, layers))
}
