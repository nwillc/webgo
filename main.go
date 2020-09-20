package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	msg := os.Getenv("CONFIG_MESSAGE")
	go func() {
		for {
			time.Sleep(5 * time.Second)
			log.Println(msg)
		}
	}()
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8888", nil))
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "ACK")
}
