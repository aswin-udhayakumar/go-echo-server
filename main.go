package main

import (
	"fmt"
	"io"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func main() {
	r := chi.NewRouter()
	r.Use(middleware.Logger)

	r.Get("/helloworld", func(w http.ResponseWriter, _ *http.Request) {
		_, _ = w.Write([]byte("hello world"))
	})

	r.Post("/echo", func(w http.ResponseWriter, r *http.Request) {
		body, err := io.ReadAll(r.Body)
		if err != nil {
			http.Error(w, "unable to read body", http.StatusBadRequest)
			return
		}

		if err := r.Body.Close(); err != nil {
			http.Error(w, "unable to close body", http.StatusInternalServerError)
			return
		}

		_, _ = w.Write(body)
	})

	addr := ":8080"
	fmt.Printf("🚀 Server running at http://localhost%v\n", addr)

	_ = http.ListenAndServe(addr, r)
}
