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
	configMsg          = "CONFIG_MESSAGE" // See environments/local/config.yaml
	vaultSecretsFolder = "/vault/secrets"
	databaseSecret     = "/vault/secrets/database-config.json" // See chart's podAnnotations in values.yaml
)

var msg string

func main() {
	msg = os.Getenv(configMsg)
	walk(vaultSecretsFolder)
	dumpFile(databaseSecret)
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
	fmt.Fprintln(w, msg)
}

func walk(root string) {
	err := filepath.Walk(root,
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				return err
			}
			log.Println(path, info.Size())
			return nil
		})
	if err != nil {
		log.Println(err)
	}
}

func dumpFile(fileName string) {
	content, err := ioutil.ReadFile(fileName)

	if err != nil {
		log.Printf("Unable to open %s: %s", fileName, err)
		return
	}

	log.Printf("%s: %s", fileName, string(content))
}
