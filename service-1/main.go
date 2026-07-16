package main
import (
	"fmt"
	"net/http"
	"strconv"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		a, _ := strconv.ParseFloat(r.URL.Query().Get("a"), 64)
		b, _ := strconv.ParseFloat(r.URL.Query().Get("b"), 64)
		fmt.Fprintf(w, "--- Calculator Service ---\nQuery parameters: ?a=num&b=num\n\nResult:\nAdd: %.2f\nSub: %.2f\nMult: %.2f", a+b, a-b, a*b)
	})
	http.ListenAndServe(":8080", nil)
}
