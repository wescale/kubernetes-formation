{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{/* 
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "simpleapp.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simpleapp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 |        trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- define "simplebackend.fullname" -}}
{{- printf "%s-%s-backend" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simplefrontend.fullname" -}}
{{- printf "%s-%s-frontend" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simplebackend-deployment.fullname" -}}
{{- printf "%s-%s-backend-dpl" .Release.Name .Chart.Name|       trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simplebackend-service.url" -}}
{{- if .Values.frontend.env.backend -}}
{{- .Values.frontend.env.backend | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "http://%s-%s-backend-svc:8080" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- define "simplefrontend-deployment.fullname" -}}
{{- printf "%s-%s-frontend-dpl" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simplebackend-service.fullname" -}}
{{- printf "%s-%s-backend-svc" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- define "simplefrontend-service.fullname" -}}
{{- printf "%s-%s-frontend-svc" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/* Create chart name and version as used by the chart label. */}}
{{- define "simpleapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{/* Common labels */}}
{{- define "simpleapp.labels" -}}
helm.sh/chart: {{ include "simpleapp.chart" . }}
{{ include "simpleapp.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
{{/* Selector labels */}}
{{- define "simpleapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simpleapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
{{/* Create the name of the service account to use */}}
{{- define "simpleapp.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "simpleapp.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}