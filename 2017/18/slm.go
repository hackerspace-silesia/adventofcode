package main

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func readInput() []Cmd {
	cmds := []Cmd{}
	var line string
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		line = scanner.Text()
		s := strings.Split(line, " ")
		cmd := Cmd{ins: s[0]}
		if v, err := strconv.Atoi(s[1]); err == nil {
			cmd.v1 = v
		} else {
			cmd.r1 = s[1]
		}
		if len(s) == 3 {
			if v, err := strconv.Atoi(s[2]); err == nil {
				cmd.v2 = v
			} else {
				cmd.r2 = s[2]
			}
		}
		cmds = append(cmds, cmd)
	}
	return cmds
}

type Duet struct {
	id        int
	registers map[string]int
	lastFreq  int
	sends     int
	sBuffer   chan int
	rBuffer   chan int
}

type Cmd struct {
	ins string
	r1  string
	v1  int
	r2  string
	v2  int
}

func (d *Duet) set(reg string, val int) {
	d.registers[reg] = val
}

func (d *Duet) add(reg string, val int) {
	d.set(reg, d.get(reg)+val)
}

func (d *Duet) mul(reg string, val int) {
	d.set(reg, d.get(reg)*val)
}

func (d *Duet) mod(reg string, val int) {
	d.set(reg, d.get(reg)%val)
}

func (d *Duet) get(name string) int {
	val, ok := d.registers[name]
	if !ok {
		val = 0
	}
	return val
}

func (d *Duet) snd(v int) error {
	select {
	case d.sBuffer <- v:
		d.sends++
	default:
		return errors.New("")
	}
	return nil
}

func (d *Duet) rcv(reg string) error {
	select {
	case val := <-d.rBuffer:
		d.set(reg, val)
	default:
		return errors.New("")
	}
	return nil
}

func get1(c Cmd, d *Duet) int {
	if c.r1 != "" {
		return d.get(c.r1)
	} else {
		return c.v1
	}
}

func get2(c Cmd, d *Duet) int {
	if c.r2 != "" {
		return d.get(c.r2)
	} else {
		return c.v2
	}
}

func process(d *Duet, cmds []Cmd, index int) int {
	cmdIndex := index
	for {
		if cmdIndex < 0 || cmdIndex >= len(cmds) {
			break
		}
		cmd := cmds[cmdIndex]

		//fmt.Printf("%d: %+v, %d, %+v\n", d.id, cmd, cmdIndex, d.registers)
		switch cmd.ins {
		case "snd":
			err := d.snd(get1(cmd, d))
			if err != nil {
				return cmdIndex
			}
		case "set":
			d.set(cmd.r1, get2(cmd, d))
		case "add":
			d.add(cmd.r1, get2(cmd, d))
		case "mul":
			d.mul(cmd.r1, get2(cmd, d))
		case "mod":
			d.mod(cmd.r1, get2(cmd, d))
		case "rcv":
			err := d.rcv(cmd.r1)
			if err != nil {
				return cmdIndex
			}
		case "jgz":
			v := get1(cmd, d)
			v2 := get2(cmd, d)
			if v > 0 {
				cmdIndex += v2
				continue
			}
		}
		cmdIndex++
	}
	return d.lastFreq
}

func run(cmds []Cmd) *Duet {
	buf1 := make(chan int, 100)
	buf2 := make(chan int, 100)
	d1 := &Duet{id: 0, registers: map[string]int{"p": 0}, sBuffer: buf1, rBuffer: buf2}
	d2 := &Duet{id: 1, registers: map[string]int{"p": 1}, sBuffer: buf2, rBuffer: buf1}
	i1 := 0
	i2 := 0
	for {
		i1 = process(d1, cmds, i1)
		i2 = process(d2, cmds, i2)
		// fmt.Println(i1, i2, len(d1.rBuffer), len(d2.rBuffer))

		if len(d1.rBuffer) == 0 && len(d2.rBuffer) == 0 {
			break
		}
	}
	return d2
}

func part1(cmds []Cmd) int {
	d1 := &Duet{registers: map[string]int{}, sBuffer: make(chan int, 10000), rBuffer: make(chan int, 100)}
	process(d1, cmds, 0)
	var v int
	for {
		select {
		case v = <-d1.sBuffer:
		//	fmt.Println(v)
		default:
			return v
		}
	}
}

func main() {
	cmds := readInput()
	// part1
	fmt.Println(part1(cmds))
	// part2
	fmt.Println(run(cmds).sends)
}
