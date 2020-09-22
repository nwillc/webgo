{{/*
Flatten a map to a dictionary, prepending a prefix label, and upercasing the names.

Map:

  max: "42"
  database:
    name: "server.name.com"
    port: "2056"

Dictionary:

  - name: "PREFIX_MAX"
    value: "42"
  - name: "PREFIX_DATABASE_NAME"
    value: "server.name.com"
  - name: "PREFIX_DATABASE_PORT"
    value: "2056"

*/}}
{{- define "flattenMap" -}}
{{- $map := first . -}}
{{- $label := last . -}}
{{- range $key, $val := $map -}}
  {{- $sublabel := list $label $key | join "_" | upper -}}
  {{- if kindOf $val | eq "map" -}}
    {{- list $val $sublabel | include "flattenMap" -}}
  {{- else -}}
- name: {{ $sublabel | quote }}
  value: {{ $val | quote }}
{{ end -}}
{{- end -}}
{{- end -}}
