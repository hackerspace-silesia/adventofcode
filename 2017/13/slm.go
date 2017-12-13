package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Firewall map[int]int

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
		f[depth] = scannerRange
		layers = depth
	}
	return f, layers
}

func isCaught(time, sRange int) bool {
	return time%(2*(sRange-1)) == 0
}

func getSeverity(f Firewall, layers int) int {
	severity := 0
	for i := 0; i < layers+1; i++ {
		sRange, ok := f[i]
		if !ok {
			continue
		}
		if isCaught(i, sRange) {
			severity += i * sRange
		}
	}
	return severity
}

func whenToStart(f Firewall, layers int) int {
	time := 0
loop:
	for {
		for layer := 0; layer < layers+1; layer++ {
			sRange, ok := f[layer]
			if ok {
				if isCaught(time+layer, sRange) {
					break
				}
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