package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"sync"
)

func main() {
	target := flag.String("u", "http://localhost:5000/", "URL target")
	wordlist := flag.String("w", "3chars.txt", "Wordlist of payloads")
	threads := flag.Int("t", 1000, "Threads")

	flag.Parse()

	file, err := os.Open(*wordlist)

	if err != nil {
		log.Fatalf("failed opening file: %s", err)
	}

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	lineCounter := 0

	var batch []string
	var currentBatchID = 0

	for scanner.Scan() {
		url := *target + scanner.Text()
		if lineCounter != *threads {
			batch = append(batch, url)
			lineCounter++
			continue
		}

		curler(batch, currentBatchID)
		batch = make([]string, 0)
		lineCounter = 0
		currentBatchID++
	}
	if lineCounter != 0 {
		curler(batch, currentBatchID)
	}

	file.Close()
}

func curler(targets []string, batchID int) {
	var wg sync.WaitGroup
	for i := 0; i < len(targets); i++ {
		wg.Add(1)
		go func(url string) {
			defer wg.Done()
			fmt.Printf("Batch: %d Curl %s\n", batchID, url)
			resp, err := http.Get(url)
			if err != nil {
				log.Fatal(err)
			}
			if resp.StatusCode >= 200 && resp.StatusCode <= 399 {
				fmt.Println(url)
			}
			defer resp.Body.Close()
		}(targets[i])
	}
	wg.Wait()
}
