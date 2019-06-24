package main

import (
	"log"
	"net/http"
	"time"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// LoggerMiddleware add logger and metrics
func LoggerMiddleware(inner http.HandlerFunc, name string, histogram *prometheus.HistogramVec, counter *prometheus.CounterVec) http.Handler {

	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		start := time.Now()

		inner.ServeHTTP(w, r)

		time := time.Since(start)
		log.Printf(
			"%s\t%s\t%s\t%s",
			r.Method,
			r.RequestURI,
			name,
			time,
		)

		histogram.WithLabelValues(r.RequestURI).Observe(time.Seconds())
		if counter != nil {
			counter.WithLabelValues(r.RequestURI).Inc()
		}
	})
}

func main() {

	router := mux.NewRouter().StrictSlash(true)

	histogram := prometheus.NewHistogramVec(prometheus.HistogramOpts{
		Name: "webservice_uri_duration_seconds",
		Help: "Time to respond",
	}, []string{"uri"})

	promCounter := prometheus.NewCounterVec(prometheus.CounterOpts{
		Name: "webservice_count",
		Help: "counter for api",
	}, []string{"uri"})

	/// Root
	var handlerStatus http.Handler
	handlerStatus = LoggerMiddleware(handlerStatusFunc, "root", histogram, nil)
	router.
		Methods("GET").
		Path("/").
		Name("root").
		Handler(handlerStatus)

	/// Métier
	var handlerFacture http.Handler
	handlerFacture = LoggerMiddleware(handlerFactureFunc, "facture_get", histogram, promCounter)
	router.
		Methods("GET").
		Path("/facture").
		Name("facture_get").
		Handler(handlerFacture)

	var handlerClient http.Handler
	handlerClient = LoggerMiddleware(handlerClientFunc, "client_get", histogram, promCounter)
	router.
		Methods("GET").
		Path("/client").
		Name("client_get").
		Handler(handlerClient)

	/// Monitoring
	var handlerIP http.Handler
	handlerIP = LoggerMiddleware(handlerIPFunc, "ips_get", histogram, nil)
	router.
		Methods("GET").
		Path("/ips").
		Name("ips_get").
		Handler(handlerIP)

	var handlerHealth http.Handler
	handlerHealth = LoggerMiddleware(handlerHealthFunc, "heatlth", histogram, nil)
	router.
		Methods("GET").
		Path("/healthz").
		Name("heatlth").
		Handler(handlerHealth)

	var readyHealth http.Handler
	readyHealth = LoggerMiddleware(handlerHealthFunc, "ready", histogram, nil)
	router.
		Methods("GET").
		Path("/ready").
		Name("ready").
		Handler(readyHealth)

	//Hack
	var putLatencyHealth http.Handler
	putLatencyHealth = LoggerMiddleware(putLatencyFunc, "latency", histogram, nil)
	router.
		Methods("PUT").
		Path("/hack/latency/{latency_ms}").
		Name("latency").
		Handler(putLatencyHealth)

	var postFileHealth http.Handler
	postFileHealth = LoggerMiddleware(postFileFunc, "create_file", histogram, nil)
	router.
		Methods("POST").
		Path("/hack/file").
		Name("create_file").
		Handler(postFileHealth)

	// add prometheus
	prometheus.Register(histogram)
	prometheus.Register(promCounter)
	router.Methods("GET").Path("/metrics").Name("Metrics").Handler(promhttp.Handler())

	// CORS
	headersOk := handlers.AllowedHeaders([]string{"authorization", "content-type"})
	originsOk := handlers.AllowedOrigins([]string{"*"})
	methodsOk := handlers.AllowedMethods([]string{"GET", "HEAD", "POST", "PUT", "OPTIONS"})

	http.ListenAndServe(":8080", handlers.CORS(originsOk, headersOk, methodsOk)(router))
}
