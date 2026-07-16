package main
import (
	"fmt"
	"net/http"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		text := r.URL.Query().Get("text")
		if text == "" { text = "Hello" }
		runes := []rune(text)
		for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
			runes[i], runes[j] = runes[j], runes[i]
		}
		fmt.Fprintf(w, "--- String Reverser ---\nQuery parameters: ?text=word\n\nOriginal: %s\nReversed: %s", text, string(runes))
	})
	http.ListenAndServe(":8080", nil)
}
