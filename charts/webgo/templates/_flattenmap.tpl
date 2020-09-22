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
