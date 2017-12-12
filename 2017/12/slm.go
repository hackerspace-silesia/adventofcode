package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

type Node struct {
	children []string
	visited  bool
}

type Graph map[string]*Node

func readInput() Graph {
	readder := bufio.NewReader(os.Stdin)
	g := map[string]*Node{}
	for {
		line, _ := readder.ReadString('\n')
		line = strings.TrimSuffix(line, "\n")
		if line == "" {
			break
		}
		s := strings.Split(line, " <-> ")
		node := s[0]
		nodes := strings.Split(s[1], ", ")
		g[node] = &Node{nodes, false}
	}
	return g
}

func GetUnvisited(G Graph) string {
	for k, v := range G {
		if !v.visited {
			return k
		}
	}
	return ""
}

func count(G Graph, start string) int {
	sum := 1
	node, ok := G[start]
	if !ok {
		return sum
	}
	node.visited = true
	for _, child := range node.children {
		childNode, ok := G[child]
		if ok && !childNode.visited {
			sum += count(G, child)
		}
	}
	return sum
}

func countGroups(G Graph) int {
	groups := 0
	for {
		node := GetUnvisited(G)
		if node == "" {
			break
		}
		groups++
		count(G, node)
	}
	return groups
}

func main() {
	G := readInput()
	members := count(G, "0")
	fmt.Println(members)
	fmt.Println(countGroups(G) + 1)
}
