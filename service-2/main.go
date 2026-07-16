package main
import (
	"fmt"
	"net/http"
	"strconv"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		weight, _ := strconv.ParseFloat(r.URL.Query().Get("weight"), 64)
		height, _ := strconv.ParseFloat(r.URL.Query().Get("height"), 64)
		if height > 0 {
			bmi := weight / (height * height)
			fmt.Fprintf(w, "--- BMI Calculator Service ---\nQuery parameters: ?weight=kg&height=meters\n\nYour BMI: %.2f", bmi)
		} else {
			fmt.Fprint(w, "Usage: Append ?weight=70&height=1.75 to the URL")
		}
	})
	http.ListenAndServe(":8080", nil)
}
