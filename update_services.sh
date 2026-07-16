#!/bin/bash

echo "Upgrading services to interactive utilities..."

# 1. Calculator Service
cat << 'EOF' > service-1/main.go
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
		fmt.Fprintf(w, "--- Calculator Service ---\nQuery parameters: ?a=num\&b=num\n\nResult:\nAdd: %.2f\nSub: %.2f\nMult: %.2f", a+b, a-b, a*b)
	})
	http.ListenAndServe(":8080", nil)
}
EOF

# 2. BMI Calculator Service
cat << 'EOF' > service-2/main.go
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
			fmt.Fprintf(w, "--- BMI Calculator Service ---\nQuery parameters: ?weight=kg\&height=meters\n\nYour BMI: %.2f", bmi)
		} else {
			fmt.Fprint(w, "Usage: Append ?weight=70&height=1.75 to the URL")
		}
	})
	http.ListenAndServe(":8080", nil)
}
EOF

# 3. Age Calculator Service
cat << 'EOF' > service-3/main.go
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
EOF

# 4. Temperature Converter Service
cat << 'EOF' > service-4/main.go
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
EOF

# 5. String Reverser Service
cat << 'EOF' > service-5/main.go
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
EOF

# 6. Dice Roller Service
cat << 'EOF' > service-6/main.go
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
EOF

# 7. Word Counter Service
cat << 'EOF' > service-7/main.go
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
EOF

# 8. Currency Sample Converter (USD to INR fixed mock data)
cat << 'EOF' > service-8/main.go
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
EOF

# 9. Predefined Quote of the Day Service
cat << 'EOF' > service-9/main.go
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
EOF

# 10. Server Timestamp Service
cat << 'EOF' > service-10/main.go
package main
import (
	"fmt"
	"net/http"
	"time"
)
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "--- System Timestamp Service ---\n\nCurrent Server Time: %s", time.Now().Format(time.RFC1123))
	})
	http.ListenAndServe(":8080", nil)
}
EOF

echo "All 10 services updated successfully with unique code configurations!"
