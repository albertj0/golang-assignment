#!/bin/bash
for i in {1..10}
do
  mkdir service-$i
  cd service-$i
  
  go mod init service-$i
  
  cat <<EOF > main.go
package main
import (
    "fmt"
    "net/http"
)
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Golang Service $i!")
    })
    fmt.Println("Service $i listening on port 8080...")
    http.ListenAndServe(":8080", nil)
}
EOF

  cat <<EOF > Dockerfile
FROM golang:1.20-alpine
WORKDIR /app
COPY . .
RUN go build -o main .
EXPOSE 8080
CMD ["./main"]
EOF

  cd ..
  echo "Created Service $i"
done
