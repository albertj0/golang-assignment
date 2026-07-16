package main
import (
	"fmt"
	"net/http"
	"strings"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		text := r.URL.Query().Get("text")
		count := len(strings.Fields(text))
		fmt.Fprintf(w, "--- Word Counter ---\nQuery parameters: ?text=your sentence here\n\nWord Count: %d", count)
	})
	http.ListenAndServe(":8080", nil)
}
