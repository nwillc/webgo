package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello World!")
}

func main() {
	http.HandleFunc("/", handler)
	go pinger()
	log.Fatal(http.ListenAndServe(":8888", nil))
}

func pinger() {
	for {
		time.Sleep(5 * time.Second)
		log.Println("Ping")
	}
}
