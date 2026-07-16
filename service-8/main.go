package main
import (
	"fmt"
	"net/http"
	"strconv"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		usd, _ := strconv.ParseFloat(r.URL.Query().Get("usd"), 64)
		inr := usd * 83.50 // Fixed sample exchange rate reference
		fmt.Fprintf(w, "--- Currency Converter (USD to INR) ---\nQuery parameters: ?usd=num\n\n$%.2f USD is approximately ₹%.2f INR", usd, inr)
	})
	http.ListenAndServe(":8080", nil)
}
