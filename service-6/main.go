package main
import (
	"fmt"
	"math/rand"
	"net/http"
	"time"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		rand.Seed(time.Now().UnixNano())
		roll := rand.Intn(6) + 1
		fmt.Fprintf(w, "--- Virtual Dice Roller ---\n\nYou rolled a: %d 🎲", roll)
	})
	http.ListenAndServe(":8080", nil)
}
