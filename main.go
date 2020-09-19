package main

import (
	"log"
	"sync"
	"time"
)

func main() {
	var wg sync.WaitGroup
	wg.Add(1)
	go func() {
		for {
				time.Sleep(5 * time.Second)
				log.Println("TICK")
			}
		wg.Done()
	}()
	wg.Wait()
}

