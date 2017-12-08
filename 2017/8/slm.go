package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

var commandRegexp = regexp.MustCompile(`(\D+) (\D+) ([0-9-]+) if (\D+) ([=<>!]+) ([0-9-]+)`)

type Cmd struct {
	reg string
	op  string
	val int

	regC string
	cmp  string
	valC int
}

func readInput() []Cmd {
	cmds := []Cmd{}
	readder := bufio.NewReader(os.Stdin)
	for {
		data, _ := readder.ReadString('\n')
		data = strings.TrimSuffix(data, "\n")
		match := commandRegexp.FindStringSubmatch(data)
		if len(match) == 0 {
			break
		}
		val, _ := strconv.Atoi(match[3])
		valC, _ := strconv.Atoi(match[6])
		cmds = append(cmds, Cmd{reg: match[1], op: match[2], val: val, regC: match[4], cmp: match[5], valC: valC})
	}
	return cmds
}

func compute(cmds []Cmd) (map[string]int, int) {
	maxVal := 0
	regs := map[string]int{}
	for _, c := range cmds {
		fmt.Println(c, regs, c.valC)
		regCval, ok := regs[c.regC]
		if !ok {
			regCval = 0
		}
		do := false
		if c.cmp == ">" && regCval > c.valC {
			fmt.Println(">")
			do = true
		} else if c.cmp == "<" && regCval < c.valC {
			fmt.Println("<")
			do = true
		} else if c.cmp == "==" && regCval == c.valC {
			fmt.Println("==")
			do = true
		} else if c.cmp == "<=" && regCval <= c.valC {
			fmt.Println("<=")
			do = true
		} else if c.cmp == ">=" && regCval >= c.valC {
			fmt.Println(">=")
			do = true
		} else if c.cmp == "!=" && regCval != c.valC {
			fmt.Println("!=")
			do = true
		}
		if do {
			regVal, ok := regs[c.reg]
			if !ok {
				regVal = 0
			}
			if c.op == "inc" {
				regVal += c.val
			} else {
				regVal -= c.val
			}
			if regVal > maxVal {
				maxVal = regVal
			}
			regs[c.reg] = regVal
		}
	}
	return regs, maxVal
}

func maxVal(regs map[string]int) int {
	var max int
	for _, v := range regs {
		if v > max {
			max = v
		}
	}
	return max
}

func main() {
	cmds := readInput()
	regs, everMax := compute(cmds)
	fmt.Println(maxVal(regs))
	fmt.Println(everMax)
}
