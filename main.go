package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	log.Printf("CONFIG_FOO set to: %s\n", os.Getenv("CONFIG_FOO"))
	log.Printf("CONFIG_DATABASE_NAME set to: %s\n", os.Getenv("CONFIG_DATABASE_NAME"))
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
