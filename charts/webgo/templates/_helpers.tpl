{{/*
Expand the name of the chart.
*/}}
{{- define "webgo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "webgo.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "webgo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "webgo.labels" -}}
helm.sh/chart: {{ include "webgo.chart" . }}
{{ include "webgo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "webgo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "webgo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "webgo.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "webgo.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Flatten a map to a dictionary, prepending a label, and upercasing the names.

Map:

  config:
    max: "42"
    database:
      name: "server.name.com"
      port: "2056"

Dictionary:

  - name: "CONFIG_MAX"
    value: "42"
  - name: "CONFIG_DATABASE_NAME"
    value: "server.name.com"
  - name: "CONFIG_DATABASE_PORT"
    value: "2056"

*/}}
{{- define "webgo.flattenmap" -}}
{{- $map := first . -}}
{{- $label := last . -}}
{{- range $key, $val := $map -}}
  {{- $sublabel := list $label $key | join "_" | upper -}}
  {{- if kindOf $val | eq "map" -}}
    {{- list $val $sublabel | include "flattenmap" -}}
  {{- else -}}
- name: {{ $sublabel | quote }}
  value: {{ $val | quote }}
{{ end -}}
{{- end -}}
{{- end -}}
