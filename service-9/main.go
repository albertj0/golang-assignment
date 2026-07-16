package main
import (
	"fmt"
	"math/rand"
	"net/http"
	"time"
)
func main() {
	quotes := []string{
		"Talk is cheap. Show me the code. - Linus Torvalds",
		"Programs must be written for people to read, and only incidentally for machines to execute. - Abelson & Sussman",
		"Go will be the server language of the future. - Tobias Lütke",
	}
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		rand.Seed(time.Now().UnixNano())
		selected := quotes[rand.Intn(len(quotes))]
		fmt.Fprintf(w, "--- Quote of the Day ---\n\n%s", selected)
	})
	http.ListenAndServe(":8080", nil)
}
