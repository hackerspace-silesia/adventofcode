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
	return time%(sRange*2-2) == 0
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

type Tester struct {
	layer, timeStarted int
}

func whenToStart(f Firewall, layers int) int {
	var tester *Tester
	testers := []*Tester{}
	time := 0
	startTime := 0
loop:
	for {
		newTester := Tester{0, time}
		testers = append(testers, &newTester)
		for i := len(testers) - 1; i >= 0; i-- {
			tester = testers[i]
			sRange, ok := f[tester.layer]
			if ok {
				if isCaught(time, sRange) {
					testers = removeTester(testers, i)
					continue
				}
			}
			if tester.layer == layers {
				startTime = tester.timeStarted
				break loop
			}
			tester.layer++
		}
		time++
	}
	return startTime
}

func removeTester(s []*Tester, i int) []*Tester {
	s[len(s)-1], s[i] = s[i], s[len(s)-1]
	return s[:len(s)-1]
}

func main() {
	f, layers := readInput()
	fmt.Println(getSeverity(f, layers))
	fmt.Println(whenToStart(f, layers))
}
