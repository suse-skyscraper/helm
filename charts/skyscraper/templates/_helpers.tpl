{{/*
Expand the name of the chart.
*/}}
{{- define "skyscraper-web.name" -}}
{{- printf "%s-web" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "skyscraper-server.name" -}}
{{- printf "%s-server" .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "skyscraper.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 56 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 56 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 56 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "skyscraper-web.fullname" -}}
{{- (printf "%s-web" (include "skyscraper.fullname" .)) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "skyscraper-server.fullname" -}}
{{- (printf "%s-server" (include "skyscraper.fullname" .)) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "skyscraper.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "skyscraper-web.labels" -}}
helm.sh/chart: {{ include "skyscraper.chart" . }}
{{ include "skyscraper-web.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "skyscraper-server.labels" -}}
helm.sh/chart: {{ include "skyscraper.chart" . }}
{{ include "skyscraper-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "skyscraper-web.selectorLabels" -}}
app.kubernetes.io/name: {{ include "skyscraper-web.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "skyscraper-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "skyscraper-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "skyscraper-web.serviceAccountName" -}}
{{- if .Values.skyscraper_web.serviceAccount.create }}
{{- default (include "skyscraper-web.fullname" .) .Values.skyscraper_web.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.skyscraper_web.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "skyscraper-server.serviceAccountName" -}}
{{- if .Values.skyscraper_server.serviceAccount.create }}
{{- default (include "skyscraper-server.fullname" .) .Values.skyscraper_server.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.skyscraper_server.serviceAccount.name }}
{{- end }}
{{- end }}
