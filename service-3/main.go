package main
import (
	"fmt"
	"net/http"
	"strconv"
	"time"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		year, _ := strconv.Atoi(r.URL.Query().Get("year"))
		if year > 0 {
			age := time.Now().Year() - year
			fmt.Fprintf(w, "--- Age Service ---\nQuery parameters: ?year=YYYY\n\nYou are roughly %d years old.", age)
		} else {
			fmt.Fprint(w, "Usage: Append ?year=2004 to the URL")
		}
	})
	http.ListenAndServe(":8080", nil)
}
