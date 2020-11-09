package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

const (
	target1       = "http://gobyexample.com"
	target2       = "http://google.com"
	delay         = 10 * time.Second
	licenseFolder = "/license"
)

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
		resp, err := http.Get(target1)
		if err != nil {
			log.Println("Failed to get", target1, ":", err)
		} else {
			log.Println("Response status", target1, ":", resp.Status)
			resp.Body.Close()
		}
		resp, err = http.Get(target2)
		if err != nil {
			log.Println("Failed to get", target2, ":", err)
		} else {
			log.Println("Response status", target2, ":", resp.Status)
			resp.Body.Close()
		}
		time.Sleep(delay)
	}
}

