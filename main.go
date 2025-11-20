package main

import (
	"fmt"
	"go-echo-server/router"
	"io"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	r.Get("/helloworld", func(w http.ResponseWriter, r *http.Request) {
		sum := router.Add(1, 2)
		w.Write([]byte(fmt.Sprintf("hello world, sum: %d", sum)))
	})

	r.Post("/echo", func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		r.Body.Close()
		
		if err != nil {
			http.Error(w, "unable to read body", http.StatusBadRequest)
			return
		}
		w.Write(body)
	})

	addr := ":8080"
	fmt.Printf("🚀 Server running at http://localhost%v\n", addr)

	http.ListenAndServe(addr, r)
}
