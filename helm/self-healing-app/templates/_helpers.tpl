{{/*
Return the name of the chart
*/}}
{{- define "self-healing-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Return a full name combining release and chart name
*/}}
{{- define "self-healing-app.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}
