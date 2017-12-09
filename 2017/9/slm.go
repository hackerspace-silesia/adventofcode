package main

import (
	"bufio"
	"fmt"
	"os"
)

func skipGarbage(reader *bufio.Reader) (int, error) {
	c := 0
	for {
		b, err := reader.ReadByte()
		if err != nil {
			return c, err
		}
		if b == '!' {
			_, err := reader.ReadByte()
			if err != nil {
				return c, err
			}
			c--
		}
		if b == '>' {
			break
		}
		c++
	}
	return c, nil
}

func countGroups(reader *bufio.Reader, score int) (int, int) {
	endScore := score
	garbage := 0
	for {
		b, err := reader.ReadByte()
		if err != nil {
			break
		}
		if b == '<' {
			g, err := skipGarbage(reader)
			garbage += g
			if err != nil {
				panic("Whaaat")
			}
		}
		if b == '}' {
			break
		}
		if b == '{' {
			s, g := countGroups(reader, score+1)
			endScore += s
			garbage += g
		}

	}
	return endScore, garbage
}

func main() {
	readder := bufio.NewReader(os.Stdin)
	score, garbage := countGroups(readder, 0)
	fmt.Println(score)
	fmt.Println(garbage)
}
