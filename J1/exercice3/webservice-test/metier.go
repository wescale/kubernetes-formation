package main

import (
	"encoding/json"
	"net/http"
	"time"
)

// Facture a test facture struct
type Facture struct {
	Contrat string  `json:"contrat"`
	Days    float32 `json:"days"`
	Cost    float32 `json:"cost"`
}

// Client a test client struct
type Client struct {
	Name    string `json:"name"`
	Service string `json:"service"`
}

func handlerFactureFunc(w http.ResponseWriter, r *http.Request) {
	clt := Facture{Contrat: "Gemalto", Days: 1.5, Cost: 22.2}

	// wait for latency
	time.Sleep(time.Duration(latency) * time.Millisecond)

	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(clt); err != nil {
		panic(err)
	}
}

func handlerClientFunc(w http.ResponseWriter, r *http.Request) {
	clt := Client{Name: "Gemalto", Service: "Formation"}

	// wait for latency
	time.Sleep(time.Duration(latency) * time.Millisecond)

	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(clt); err != nil {
		panic(err)
	}
}
