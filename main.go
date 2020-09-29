package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"path/filepath"
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
	log.Println("Username:", os.Getenv("SECRET_USERNAME"))
	licenseCheck(licenseFolder)
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

func licenseCheck(licenseFolder string) {
	var files []string
	err := filepath.Walk(licenseFolder, func(path string, info os.FileInfo, err error) error {
		files = append(files, path)
		return nil
	})
	if err != nil {
		log.Println("Error walking", licenseFolder, err)
		return
	}
	log.Println("Found")
	for _, file := range files {
		log.Println(file)
	}
	contents, err := ioutil.ReadFile(licenseFolder + "/license")
	if err != nil {
		log.Println("Could not open", licenseFolder, "/license")
		return
	}
	log.Println("License:", string(contents))
}
