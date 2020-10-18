package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

const (
	delay         = 10 * time.Second
)

var targets = []string {"http://gobyexample.com", "http://google.com", "http://wikipedia.com"}
var msg string

func init() {
	msg = os.Getenv("CONFIG_MESSAGE")
	if msg == "" {
		msg = "UNSET"
	}
}

func main() {
	go pinger()
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8888", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, msg)
}

func pinger() {
	for {
		log.Println(msg)
		for _, target := range targets {
			resp, err := http.Get(target)
			if err != nil {
				log.Println("Failed to get", target, ":", err)
			} else {
				log.Println("Response status", target, ":", resp.Status)
				resp.Body.Close()
			}
		}
		time.Sleep(delay)
	}
}
