package main

import (
	"encoding/json"
	"net"
	"net/http"
	"os"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
)

type Facture struct {
	Contrat string  `json:"contrat"`
	Days    float32 `json:"days"`
	Cost    float32 `json:"cost"`
}

type Client struct {
	Name    string `json:"name"`
	Service string `json:"service"`
}

func handlerFactureFunc(w http.ResponseWriter, r *http.Request) {
	var clt Facture
	clt = Facture{Contrat: "Gemalto", Days: 1.5, Cost: 22.2}
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(clt); err != nil {
		panic(err)
	}
}

func handlerClientFunc(w http.ResponseWriter, r *http.Request) {
	clt := Client{Name: "Gemalto", Service: "Formation"}
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(clt); err != nil {
		panic(err)
	}
}

func handlerIPFunc(w http.ResponseWriter, r *http.Request) {
	var clt []string

	addrs, err := net.InterfaceAddrs()
	if err != nil {
		os.Stderr.WriteString("Oops: " + err.Error() + "\n")
		os.Exit(1)
	}

	for _, a := range addrs {
		if ipnet, ok := a.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
			if ipnet.IP.To4() != nil {
				clt = append(clt, ipnet.IP.String())
				os.Stdout.WriteString(ipnet.IP.String() + "\n")
			}
		}
	}

	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	if err := json.NewEncoder(w).Encode(clt); err != nil {
		panic(err)
	}
}

func main() {

	router := mux.NewRouter().StrictSlash(true)

	var handlerFacture http.HandlerFunc
	handlerFacture = handlerFactureFunc

	var handlerClient http.HandlerFunc
	handlerClient = handlerClientFunc

	var handlerIP http.HandlerFunc
	handlerIP = handlerIPFunc

	router.
		Methods("GET").
		Path("/facture").
		Name("facture_get").
		Handler(handlerFacture)

	router.
		Methods("GET").
		Path("/client").
		Name("client_get").
		Handler(handlerClient)

	router.
		Methods("GET").
		Path("/ips").
		Name("ips_get").
		Handler(handlerIP)

	headersOk := handlers.AllowedHeaders([]string{"authorization", "content-type"})
	originsOk := handlers.AllowedOrigins([]string{"*"})
	methodsOk := handlers.AllowedMethods([]string{"GET", "HEAD", "POST", "PUT", "OPTIONS"})

	http.ListenAndServe(":8080", handlers.CORS(originsOk, headersOk, methodsOk)(router))
}
