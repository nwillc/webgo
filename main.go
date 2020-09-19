package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	log.Printf("foo set to: %s\n", os.Getenv("foo"))
	http.HandleFunc("/", handler)
	go func() {
		for {
				time.Sleep(5 * time.Second)
				log.Println("TICK")
			}
	}()
	log.Fatal(http.ListenAndServe(":8888", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "ACK")
}
