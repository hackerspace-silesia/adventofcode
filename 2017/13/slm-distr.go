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

func checkTime(f Firewall, layers int, timeChan chan int, respChan chan int) {
	for {
		time := <-timeChan
		startTime := time
		layer := 0
		for {
			sRange, ok := f[layer]
			if ok {
				if isCaught(time, sRange) {
					break
				}
			}
			if layer == layers {
				respChan <- startTime
				return
			}
			layer++
			time++
		}
	}
}

func whenToStart(f Firewall, layers int) int {
	workers := 100
	timeChan := make(chan int, workers)
	respChan := make(chan int)
	for i := 0; i < workers; i++ {
		go checkTime(f, layers, timeChan, respChan)
	}
	time := 0
	for {
		select {
		case timeChan <- time:
			time++
		case resp := <-respChan:
			return resp
		}
	}
}

func main() {
	f, layers := readInput()
	fmt.Println(getSeverity(f, layers))
	fmt.Println(whenToStart(f, layers))
}
