package main
import (
	"fmt"
	"net/http"
	"strconv"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		celsius, _ := strconv.ParseFloat(r.URL.Query().Get("celsius"), 64)
		fahrenheit := (celsius * 9 / 5) + 32
		fmt.Fprintf(w, "--- Temperature Converter ---\nQuery parameters: ?celsius=num\n\n%.2f°C is equal to %.2f°F", celsius, fahrenheit)
	})
	http.ListenAndServe(":8080", nil)
}
