package main
import (
    "fmt"
    "net/http"
)
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Golang Service 6!")
    })
    fmt.Println("Service 6 listening on port 8080...")
    http.ListenAndServe(":8080", nil)
}
