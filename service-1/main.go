package main
import (
    "fmt"
    "net/http"
)
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Golang Service 1!")
    })
    fmt.Println("Service 1 listening on port 8080...")
    http.ListenAndServe(":8080", nil)
}
