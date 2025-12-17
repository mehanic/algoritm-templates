function helm_firstchart_name
    set output_file "firstchart_name.tpl"

    echo "{
{{/*
Expand the name of the chart.
*/}}
{{- define \"firstchart.name\" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix \"-\" }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_firstchart_fullname
    set output_file "firstchart_fullname.tpl"

    echo "{
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define \"firstchart.fullname\" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix \"-\" }}
{{- else }}
{{- \$name := default .Chart.Name .Values.nameOverride }}
{{- if contains \$name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix \"-\" }}
{{- else }}
{{- printf \"%s-%s\" .Release.Name \$name | trunc 63 | trimSuffix \"-\" }}
{{- end }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_firstchart_version
    set output_file "firstchart_version_chart.tpl"

    echo "{
{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define \"firstchart.chart\" -}}
{{- printf \"%s-%s\" .Chart.Name .Chart.Version | replace \"+\" \"_\" | trunc 63 | trimSuffix \"-\" }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_firstchart_labels
    set output_file "firstchart_labels.tpl"

    echo "{
{{/*
Common labels
*/}}
{{- define \"firstchart.labels\" -}}
helm.sh/chart: {{ include \"firstchart.chart\" . }}
{{ include \"firstchart.selectorLabels\" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_firstchart_selectorLabels
    set output_file "firstchart_selectorLabels.tpl"

    echo "{
{{/*
Selector labels
*/}}
{{- define \"firstchart.selectorLabels\" -}}
app.kubernetes.io/name: {{ include \"firstchart.name\" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_firstchart_serviceAccountName
    set output_file "firstchart_serviceAccountName.tpl"

    echo "{
{{/*
Create the name of the service account to use
*/}}
{{- define \"firstchart.serviceAccountName\" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include \"firstchart.fullname\" .) .Values.serviceAccount.name }}
{{- else }}
{{- default \"default\" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_wishlist_helpers
    set output_file "wishlist_helpers.tpl"

    echo "{
{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define \"wishlist.name\" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define \"wishlist.fullname\" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix \"-\" -}}
{{- else -}}
{{- \$name := default .Chart.Name .Values.nameOverride -}}
{{- if contains \$name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix \"-\" -}}
{{- else -}}
{{- printf \"%s-%s\" .Release.Name \$name | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}
{{- end -}}
{{- end -}}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_read_values_from_file
    set output_file "read_values_from_file.tpl"

    echo "{
{{- define \"read_values_from_file\" }}
{{- \$filename := cat \"values-\" .Values.env \".yaml\" | nospace }}
{{- \$dict := . }}
{{- \$_ := set \$dict \"envValues\" (dict) }}
{{- range \$path, \$_ := .Files.Glob \$filename }}
{{- \$envValues := \$.Files.Get \$path | fromYaml }}
{{- \$_ := set \$dict \"envValues\" \$envValues }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_resources
    set output_file "raw_resources.tpl"

    echo "{
{{/*
Create manifests (supports slice and map)
*/}}
{{- define \"raw.resources\" -}}
{{- \$dot := index . 0 }}
{{- \$resources := index . 1 }}
{{- \$type := index . 2 }}
{{- if (kindIs \"slice\" \$resources) }}
{{- include \"raw.manifests\" (list \$dot \$resources \$type) }}
{{- else if (kindIs \"map\" \$resources) }}
{{- range \$group, \$resources := \$resources }}
{{- include \"raw.manifests\" (list \$dot \$resources \$type) }}
{{- end }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_manifests
    set output_file "raw_manifests.tpl"

    echo "{
{{/*
Create manifests and append labels (support both resources and templates)
*/}}
{{- define \"raw.manifests\" -}}
{{- \$dot := index . 0 }}
{{- \$resources := index . 1 }}
{{- \$type := index . 2 }}
{{- \$chartLabels := fromYaml (include \"raw.appendChartLabels\" \$dot) }}
{{- \$commonLabels := fromYaml (include \"raw.commonLabels\" \$dot) }}
{{- range \$resource := \$resources }}
---
{{- if eq \$type \"templates\" }}
{{- toYaml (merge (tpl \$resource \$dot | fromYaml) \$chartLabels \$commonLabels) -}}
{{- else }}
{{- toYaml (merge \$resource \$chartLabels \$commonLabels) }}
{{- end }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_raw_appendChartLabels
    set output_file "raw_appendChartLabels.tpl"

    echo "{
{{/*
Append Chart labels if \"appendChartLabels\" is set
*/}}
{{- define \"raw.appendChartLabels\" }}
{{- \$chartLabels := dict \"metadata\" (dict \"labels\" dict) }}
{{- if .Values.appendChartLabels }}
{{- \$chartLabels = fromYaml (include \"raw.chartLabels\" .) }}
{{- end }}
{{- toYaml \$chartLabels }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_commonLabels
    set output_file "raw_commonLabels.tpl"

    echo "{
{{/*
Common labels
*/}}
{{- define \"raw.commonLabels\" -}}
{{- with .Values.commonLabels }}
metadata:
  labels:
    {{ toYaml . | nindent 4 }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_chartLabels
    set output_file "raw_chartLabels.tpl"

    echo "{
{{/*
Chart labels
*/}}
{{- define \"raw.chartLabels\" -}}
metadata:
  labels:
    {{- include \"raw.labels\" . | nindent 4 }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_selectorLabels
    set output_file "raw_selectorLabels.tpl"

    echo "{
{{/*
Selector labels
*/}}
{{- define \"raw.selectorLabels\" -}}
app.kubernetes.io/name: {{ include \"raw.name\" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_raw_labels
    set output_file "raw_labels.tpl"

    echo "{
{{/*
Common chart labels
*/}}
{{- define \"raw.labels\" -}}
helm.sh/chart: {{ include \"raw.chart\" . }}
{{ include \"raw.selectorLabels\" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_serviceAccountName
    set output_file "serviceAccountName.tpl"

    echo "{
{{/*
Create the name of the service account to use
*/}}
{{- define \"lemmy.serviceAccountName\" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include \"lemmy.fullname\" .) .Values.serviceAccount.name }}
{{- else }}
{{- default \"default\" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_name
    set output_file "chartmuseum_name.tpl"

    echo "{
{{- /*
name defines a template for the name of the chartmuseum chart.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- .Values.nameOverride: Replaces the computed name with this given name
- .Values.namePrefix: Prefix
- .Values.global.namePrefix: Global prefix
- .Values.nameSuffix: Suffix
- .Values.global.nameSuffix: Global suffix

The applied order is: \"global prefix + prefix + name + suffix + global suffix\"

Usage: 'name: \"{{- template \"chartmuseum.name\" . -}}\"'
*/ -}}
{{- define \"chartmuseum.name\"}}
{{- \$global := default (dict) .Values.global -}}
{{- \$base := default .Chart.Name .Values.nameOverride -}}
{{- \$gpre := default \"\" \$global.namePrefix -}}
{{- \$pre := default \"\" .Values.namePrefix -}}
{{- \$suf := default \"\" .Values.nameSuffix -}}
{{- \$gsuf := default \"\" \$global.nameSuffix -}}
{{- \$name := print \$gpre \$pre \$base \$suf \$gsuf -}}
{{- \$name | lower | trunc 54 | trimSuffix \"-\" -}}
{{- end -}}
}" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_fullname
    set output_file "chartmuseum_fullname.tpl"

    set template_content "{
{{- /*
fullname defines a suitably unique name for a resource by combining
the release name and the chartmuseum chart name.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- .Values.fullnameOverride: Replaces the computed name with this given name
- .Values.fullnamePrefix: Prefix
- .Values.global.fullnamePrefix: Global prefix
- .Values.fullnameSuffix: Suffix
- .Values.global.fullnameSuffix: Global suffix

The applied order is: \"global prefix + prefix + name + suffix + global suffix\"

Usage: 'name: \"{{- template \"chartmuseum.fullname\" . -}}\"'
*/ -}}
{{- define \"chartmuseum.fullname\"}}
{{- \$global := default (dict) .Values.global -}}
{{- \$base := default (printf \"%s-%s\" .Release.Name .Chart.Name) .Values.fullnameOverride -}}
{{- \$gpre := default \"\" \$global.fullnamePrefix -}}
{{- \$pre := default \"\" .Values.fullnamePrefix -}}
{{- \$suf := default \"\" .Values.fullnameSuffix -}}
{{- \$gsuf := default \"\" $global.fullnameSuffix -}}
{{- \$name := print \$gpre \$pre \$base \$suf \$gsuf -}}
{{- \$name | lower | trunc 54 | trimSuffix \"-\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_labels_standard
    set output_file "chartmuseum_labels_standard.tpl"

    set template_content "{
{{- /*
chartmuseum.labels.standard prints the standard chartmuseum Helm labels.

The standard labels are frequently used in metadata.
*/ -}}
{{- define \"chartmuseum.labels.standard\" -}}
app: {{ template \"chartmuseum.name\" . }}
chart: {{ template \"chartmuseum.chartref\" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
{{- end -}}
}"

    # Write to file
    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_chartref
    set output_file "chartmuseum_chartref.tpl"

    set template_content "{
{{- /*
chartmuseum.chartref prints a chart name and version.

It does minimal escaping for use in Kubernetes labels.

Example output:

chartmuseum-0.4.5
*/ -}}
{{- define \"chartmuseum.chartref\" -}}
{{- replace \"+\" \"_\" .Chart.Version | printf \"%s-%s\" .Chart.Name -}}
{{- end -}}
}"

    # Write to file
    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_chartref
    set output_file "chartmuseum_chartref.tpl"

    set template_content "{
{{- /*
chartmuseum.chartref prints a chart name and version.

It does minimal escaping for use in Kubernetes labels.

Example output:

chartmuseum-0.4.5
*/ -}}
{{- define \"chartmuseum.chartref\" -}}
{{- replace \"+\" \"_\" .Chart.Version | printf \"%s-%s\" .Chart.Name -}}
{{- end -}}
}"

    # Write to file
    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_chartmuseum_volumePermissions_image
    set output_file "chartmuseum_volumePermissions_image.tpl"

    set template_content "{
{{/*
Return the proper image name to change the volume permissions
*/}}
{{- define \"chartmuseum.volumePermissions.image\" -}}
{{- \$registryName := .Values.volumePermissions.image.registry -}}
{{- \$repositoryName := .Values.volumePermissions.image.repository -}}
{{- \$tag := .Values.volumePermissions.image.tag | toString -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 doesn't support it, so we need to implement this if-else logic.
Also, we can't use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
    {{- if .Values.global.imageRegistry }}
        {{- printf \"%s/%s:%s\" .Values.global.imageRegistry \$repositoryName \$tag -}}
    {{- else -}}
        {{- printf \"%s/%s:%s\" \$registryName \$repositoryName \$tag -}}
    {{- end -}}
{{- else -}}
    {{- printf \"%s/%s:%s\" \$registryName \$repositoryName \$tag -}}
{{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_chartmuseum_imagePullSecrets
    set output_file "chartmuseum_imagePullSecrets.tpl"

    set template_content "{
{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define \"chartmuseum.imagePullSecrets\" -}}
{{/*
Helm 2.11 supports the assignment of a value to a variable defined in a different scope,
but Helm 2.9 and 2.10 does not support it, so we need to implement this if-else logic.
Also, we can not use a single if because lazy evaluation is not an option
*/}}
{{- if .Values.global }}
{{- if .Values.global.imagePullSecrets }}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- else if or .Values.image.pullSecrets .Values.volumePermissions.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- range .Values.volumePermissions.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- else if or .Values.image.pullSecrets .Values.volumePermissions.image.pullSecrets }}
imagePullSecrets:
{{- range .Values.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- range .Values.volumePermissions.image.pullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_infra_values
    set output_file "infra_values.tpl"

    set template_content "{
Zone: {{ quote .Values.infra.zone }}
Region: {{ quote .Values.infra.region }}
ProjectCode: {{ upper .Values.projectCode }}
}"

    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_infra_ha
    set output_file "infra_ha.tpl"

    set template_content "{
{{- if eq .Values.infra.region \"us-e\" }}
ha: true
{{- end }}
}"

    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_utils_concat
    set output_file "utils_concat.tpl"

    set template_content "{
{{/*
Universal Helm helper function for passing multiple arguments
Usage:
  {{ include \"utils.concat\" (list \"foo\" \"bar\") }}            → foobar
  {{ include \"utils.concat\" (list .Release.Name \"-config\") }} → myrelease-config
  {{ include \"utils.concat\" (list \"env-\" .Values.env \"-db\") }} → env-prod-db
*/}}

{{- define \"utils.concat\" -}}
  {{- \$args := . -}}
  {{- \$result := \"\" -}}
  {{- range \$args }}
    {{- \$result = printf \"%s%s\" \$result . -}}
  {{- end -}}
  {{- \$result -}}
{{- end -}}
}"

    echo $template_content > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_testFunc_context
    set output_file "testFunc_context.tpl"

    set template_content "{
{{/*
Demonstration of passing both root and current contexts into an include
*/}}

{{- define \"testFunc\" -}}
  {{- \$ := index . 0 }}
  {{- \$ctx := index . 1 }}
  {{- \$stringArg := index . 2 }}

  {{- with \$ctx }}
    # Root value: {{ \$ .Values.key }}
    # Current value: {{ .Values.key }}
    # Custom argument: {{ \$stringArg }}
    # Combined output:
    {{ cat \$stringArg \" \" \$.Values.key \" \" .Values.key }}
  {{- end }}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_utils_passContext
    set output_file "utils_passContext.tpl"

    set template_content "{
{{/*
Universal Helm helper for safely including templates with preserved root and current context
*/}}
{{- define \"utils.passContext\" -}}
  {{- \$args := . -}}
  {{- \$templateName := index \$args 0 -}}
  {{- \$root := index \$args 1 -}}
  {{- \$ctx := index \$args 2 -}}

  {{- \$extraArgs := slice -}}
  {{- if gt (len \$args) 3 }}
    {{- \$extraArgs = slice \$args 3 -}}
  {{- end -}}

  {{- \$callArgs := prepend \$extraArgs \$ctx -}}
  {{- \$callArgs = prepend \$callArgs \$root -}}

  {{- include \$templateName \$callArgs -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_utils_passContext
    set output_file "utils_passContext.tpl"

    set template_content "{
{{/*
Universal Helm helper for safely including templates with preserved root and current context
Usage:
  {{ include \"utils.passContext\" (list \"myTemplate\" \$ .) }}
*/}}
{{- define \"utils.passContext\" -}}
  {{- \$args := . -}}
  {{- \$templateName := index \$args 0 -}}
  {{- \$root := index \$args 1 -}}
  {{- \$ctx := index \$args 2 -}}

  {{- \$extraArgs := slice -}}
  {{- if gt (len \$args) 3 }}
    {{- \$extraArgs = slice \$args 3 -}}
  {{- end -}}

  {{- \$callArgs := prepend \$extraArgs \$ctx -}}
  {{- \$callArgs = prepend \$callArgs \$root -}}

  {{- include \$templateName \$callArgs -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D; echo -n "$output_file created"; set_color normal; echo ''
    cat $output_file
end


function helm_utils_withOptional
    set output_file "utils_withOptional.tpl"

    set template_content "{
{{/*
utils.withOptional — universal Helm include helper with optional args
Usage:
  {{ include \"utils.withOptional\" (list \"templateName\" \$ . (dict \"flag\" true \"suffix\" \"-dev\")) }}
*/}}
{{- define \"utils.withOptional\" -}}
  {{- \$args := . -}}
  {{- \$templateName := index \$args 0 }}
  {{- \$root := index \$args 1 }}
  {{- \$context := index \$args 2 }}
  {{- \$optional := dict }}

  {{- if ge (len \$args) 4 }}
    {{- \$optional = index \$args 3 }}
  {{- end }}

  {{- include \$templateName (list \$root \$context \$optional) -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D; echo -n "$output_file created"; set_color normal; echo ''
    cat $output_file
end


function helm_myTemplate
    set output_file "myTemplate.tpl"

    set template_content "{
{{/*
Demo template for utils.passContext and utils.withOptional
*/}}
{{- define \"myTemplate\" -}}
  {{- \$ := index . 0 }}
  {{- \$ctx := index . 1 }}
  {{- \$opts := index . 2 }}

  release: {{ \$.Release.Name }}
  context: {{ \$ctx.Values.env }}
  opts.flag: {{ \$opts.flag | default false }}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D; 
    echo -n "$output_file created"; 
    set_color normal; 
    echo ''
    cat $output_file
end


function helm_example_usage
    set output_file "example_usage.tpl"

    set template_content "{
---
# Example include usage of utils.withOptional
{{ include \"utils.withOptional\" (list \"myTemplate\" \$ . (dict \"flag\" true)) }}
}"

    echo $template_content > $output_file
    set_color FFAD8D; 
    echo -n "$output_file created"; 
    set_color normal; 
    echo ''
    cat $output_file
end



function helm_recursiveTemplate
    set output_file "recursiveTemplate.tpl"

    set template_content "{
{{/*
Demo template: recursive include example
Counts from a starting number up to 9
*/}}
{{- define \"printNum\" -}}
  {{- print . -}}
{{- end -}}

{{- define \"recursiveCounter\" -}}
  {{- $num := . -}}

  {{- if lt $num 10 }}
    {{- /* Include another template */ -}}
    {{- include \"printNum\" $num -}}
    {{- /* Include itself recursively */ -}}
    {{- include \"recursiveCounter\" (add 1 $num) -}}
  {{- end -}}
{{- end -}}

---
# Example usage: start counting from 0
{{- include \"recursiveCounter\" 0 }}
# Result: 0123456789
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_returnJson
    set output_file "returnJson.tpl"

    set template_content "{
{{/*
Demo template: returning structured data (dictionary) from a template
Serialized as JSON
*/}}
{{- define \"returnJson\" -}}
  {{- $data := dict \"numbers\" (list 1 2 3 4 5) \"info\" (dict \"env\" \"prod\" \"enabled\" true) -}}
  {{- $data | toJson -}}
{{- end -}}

---
# Example usage
{{- include \"returnJson\" . }}
# The result is a JSON string: {\"numbers\":[1,2,3,4,5],\"info\":{\"env\":\"prod\",\"enabled\":true}}

# Deserialize back to a dictionary:
{{- $result := include \"returnJson\" . | fromJson -}}
# Access nested values:
{{- $result.info.env }}
{{- $result.numbers | first }}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_recursiveJson
    set output_file "recursiveJson.tpl"

    set template_content "{
{{/*
Demo template: recursive include example
Builds a JSON object with numbers from start up to 9
*/}}
{{- define \"addNumber\" -}}
  {{- $num := index . 0 -}}
  {{- $acc := index . 1 -}}  {{/* accumulating list */}}

  {{- if lt $num 10 }}
    {{- $acc = append $acc $num -}}
    {{- include \"addNumber\" (list (add 1 $num) $acc) -}}
  {{- else -}}
    {{- $acc | toJson -}}
  {{- end -}}
{{- end -}}

---
# Start recursion with empty list
{{- include \"addNumber\" (list 0 (list)) }}
# Resulting JSON: [0,1,2,3,4,5,6,7,8,9]
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_includeIfElse
    set output_file "includeIfElse.tpl"

    set template_content "{
{{/*
Demo: Using include in if-else conditions with pseudo-boolean values
*/}}

{{- define \"returnPseudoBoolean\" -}}
  {{- if eq . \"pleaseReturnTrue\" }}
true
  {{- else if eq . \"pleaseReturnFalse\" }}
  {{- end }}
{{- end }}

---
# Example usage in if-blocks

{{- if include \"returnPseudoBoolean\" \"pleaseReturnTrue\" }}
The first if returns True
{{- end }}

{{- if include \"returnPseudoBoolean\" \"pleaseReturnFalse\" }}
{{- else }}
The second if returns False
{{- end }}

---
# Using ternary function
{{- define \"returnBoolean\" -}}
  {{- if eq . \"pleaseReturnTrue\" }}true{{- else }}false{{- end -}}
{{- end }}

{{- ternary \"Here is True\" \"Here is False\" (include \"returnBoolean\" \"pleaseReturnTrue\" | not | empty) }}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_valuesWrapper
    set output_file "valuesWrapper.tpl"

    set template_content '{
key1: "Value of key2: {{ $.Values.key2 }}"
key2: "value2"

-------------------------------------------------------------
.helm/templates/test.yaml:
-------------------------------------------------------------
{{- define "value" -}}
  # Let’s pass the contexts - we will need them later:
  {{- $ := index . 0 }}
  {{- $ctx := index . 1 }}
  {{- $val := index . 2 }}

  {{- with $ctx }}
    {{- tpl $val $ }}
  {{- end }}
{{- end -}}

---
# Example usage:

{{- include "value" (list $ . $.Values.key1) }}
#   ==> String "Value of key2: value2"
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_valuesWrapper
    set output_file "valuesWrapper.tpl"

    set template_content '{
key1: "Value of key2: {{ .key2 }}"
key2: "value2"

-------------------------------------------------------------
.helm/templates/test.yaml:
-------------------------------------------------------------
{{- define "value" -}}
  # $ — root context, $val — шаблонний рядок, $ctx — поточний контекст
  {{- $ := index . 0 }}
  {{- $ctx := index . 1 }}
  {{- $val := index . 2 }}

  {{- with $ctx }}
    # Обгортка with для відновлення поточного контексту
    {{- tpl (cat "{{- with $.RelativeScope -}}" $val "{{- end }}") (merge (dict "RelativeScope" .) $) }}
  {{- end }}
{{- end -}}

---
# Використання прикладу:

{{- with $.Values }}
  # Використовуємо відносний доступ до key1
  {{- include "value" (list $ . .key1) }}
{{- end }}
#   ==> String "Value of key2: value2"
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_valuesWrapper
    set output_file "valuesWrapper.tpl"

    set template_content '{
key1: "Value of key2: {{ .key2 }}"
key2: "value2"

-------------------------------------------------------------
.helm/templates/test.yaml:
-------------------------------------------------------------
{{- define "value" -}}
  # $ — root context, $val — шаблонний рядок, $ctx — поточний контекст
  {{- $ := index . 0 }}
  {{- $ctx := index . 1 }}
  {{- $val := index . 2 }}

  {{- with $ctx }}
    # Викликаємо tpl тільки якщо рядок містить {{ }}
    {{- if contains "{{" $val }}
      {{- tpl (cat "{{- with $.RelativeScope -}}" $val "{{- end }}") (merge (dict "RelativeScope" .) $) }}
    {{- else }}
      {{- $val }}
    {{- end }}
  {{- end }}
{{- end -}}

---
# Використання прикладу:

{{- with $.Values }}
  # Використовуємо відносний доступ до key1
  {{- include "value" (list $ . .key1) }}
{{- end }}
#   ==> String "Value of key2: value2"
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_debugWrapper
    set output_file "debugWrapper.tpl"

    set template_content '{
key1: "Value of key2: {{ .key2 }}"
key2: "value2"

-------------------------------------------------------------
.helm/templates/test.yaml:
-------------------------------------------------------------
{{- define "value" -}}
  # $ — root context, $val — шаблонний рядок, $ctx — поточний контекст
  {{- $ := index . 0 }}
  {{- $ctx := index . 1 }}
  {{- $val := index . 2 }}

  {{- with $ctx }}
    # Виклик tpl тільки якщо рядок містить {{ }}
    {{- if contains "{{" $val }}
      {{- tpl (cat "{{- with $.RelativeScope -}}" $val "{{- end }}") (merge (dict "RelativeScope" .) $) }}
    {{- else }}
      {{- $val }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Debugging examples
*/}}
{{- define "debugExample" -}}
  # Дамп всіх значень $.Values
  {{- fail (toYaml $.Values) }}
{{- end -}}

{{- define "debugCycle" -}}
  # Приклад циклу з записом проміжних значень у $.Values.global
  {{- range (list "val1" "val2") }}
    {{- $_ := set $.Values.global (toString now) (toYaml .) }}
  {{- end }}
  {{- fail (toYaml $.Values.global) }}
{{- end -}}

---
# Використання value шаблону:
{{- with $.Values }}
  {{- include "value" (list $ . .key1) }}
{{- end }}

# Приклад debug:
{{- include "debugExample" . }}
# Приклад циклу з fail:
{{- include "debugCycle" . }}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_nameFunctions
    set output_file "nameFunctions.tpl"

    set template_content "{
{{/*
Expand the name of the chart.
*/}}
{{- define \"name\" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
Truncate at 63 chars to comply with DNS naming.
*/}}
{{- define \"fullname\" -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- printf \"%s-%s\" .Release.Name $name | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}

{{/*
Run \"fullname\" as if it was in another chart.
Useful to reference services/pods from other charts.

Usage example:
{{- include \"otherChart.fullname\" (dict \"context\" . \"chartName\" \"name-of-other-chart\") -}}
*/}}
{{- define \"otherChart.fullname\" -}}
  {{- $ctx := .context -}}
  {{- $chartName := .chartName -}}
  {{- $name := default $chartName $ctx.Values.nameOverride -}}
  {{- printf \"%s-%s\" $ctx.Release.Name $name | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_nameFunctions
    set output_file "nameFunctions.tpl"

    set template_content "{
{{/*
Expand the name of the chart.
*/}}
{{- define \"name\" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
Truncate at 63 chars to comply with DNS naming.
*/}}
{{- define \"fullname\" -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- printf \"%s-%s\" .Release.Name $name | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}

{{/*
Run \"fullname\" as if it was in another chart.
Useful to reference services/pods from other charts.

Usage example:
{{- include \"otherChart.fullname\" (dict \"context\" . \"chartName\" \"name-of-other-chart\") -}}
*/}}
{{- define \"otherChart.fullname\" -}}
  {{- $ctx := .context -}}
  {{- $chartName := .chartName -}}
  {{- $name := default $chartName $ctx.Values.nameOverride -}}
  {{- printf \"%s-%s\" $ctx.Release.Name $name | trunc 63 | trimSuffix \"-\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_assembleHost
    set output_file "assembleHost.tpl"

    set template_content "{
{{/*
  A helper function for assembling a hostname using the base domain specified in `global.hosts.domain`.
  Arguments: dict with keys `name` (hostname prefix) and `context` (chart's \$ object).
  Example: `include \"gitlab.assembleHost\" (dict \"name\" \"minio\" \"context\" .)`
  Produces: minio.example.com or minio-beta.example.com if hostSuffix is set.
*/}}
{{- define \"gitlab.assembleHost\" -}}
  {{- $name := .name -}}
  {{- $context := .context -}}
  {{- $result := dict -}}

  {{- if $context.Values.global.hosts.domain -}}
    {{- $_ := set $result \"domainHost\" (printf \".%s\" $context.Values.global.hosts.domain) -}}
    {{- if $context.Values.global.hosts.hostSuffix -}}
      {{- $_ := set $result \"domainHost\" (printf \"-%s%s\" $context.Values.global.hosts.hostSuffix $result.domainHost) -}}
    {{- end -}}
    {{- $_ := set $result \"domainHost\" (printf \"%s%s\" $name $result.domainHost) -}}
  {{- end -}}

  {{- $result.domainHost -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlDatabase
    set output_file "gitlabPsqlDatabase.tpl"

    set template_content "{
{{/*
Return the db database name
*/}}
{{- define \"gitlab.psql.database\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- coalesce (pluck \"database\" \$local .Values.global.psql | first) \"gitlabhq_production\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlUsername
    set output_file "gitlabPsqlUsername.tpl"

    set template_content "{
{{/*
Return the db username
If the postgresql username is provided, it will use that, otherwise it will fallback
to \"gitlab\" default
*/}}
{{- define \"gitlab.psql.username\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- coalesce (pluck \"username\" \$local .Values.global.psql | first) \"gitlab\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlPort
    set output_file "gitlabPsqlPort.tpl"

    set template_content "{
{{/*
Return the db port
If the postgresql port is provided in subchart values or global values, it will use that, otherwise it will fallback
to 5432 default
*/}}
{{- define \"gitlab.psql.port\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- default 5432 (pluck \"port\" \$local \$.Values.global.psql | first ) | int -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlPasswordSecret
    set output_file "gitlabPsqlPasswordSecret.tpl"

    set template_content "{
{{/*
Return the secret name
Defaults to a release-based name and falls back to .Values.global.psql.secretName
when using an external PostgreSQL
*/}}
{{- define \"gitlab.psql.password.secret\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- \$localPass := pluck \"password\" \$local | first -}}
  {{- default (printf \"%s-%s\" .Release.Name \"postgresql-password\") (pluck \"secret\" \$localPass \$.Values.global.psql.password | first ) | quote -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlPasswordKey
    set output_file "gitlabPsqlPasswordKey.tpl"

    set template_content "{
{{/*
Return the name of the key in a secret that contains the postgres password
Uses `postgresql-password` to match upstream postgresql chart when not using an
external postgresql
*/}}
{{- define \"gitlab.psql.password.key\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- \$localPass := pluck \"password\" \$local | first -}}
  {{- default \"postgresql-password\" (pluck \"key\" \$localPass \$.Values.global.psql.password | first ) | quote -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlApplicationName
    set output_file "gitlabPsqlApplicationName.tpl"

    set template_content "{
{{/*
Return the application name that should be presented to PostgreSQL.
A blank string tells the client NOT to send an application name.
A nil value will use the process name by default.
See https://github.com/Masterminds/sprig/issues/53 for how we distinguish these.
Defaults to nil.
*/}}
{{- define \"gitlab.psql.applicationName\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- \$appname := pluck \"applicationName\" \$local .Values.global.psql | first -}}
  {{- if not ( kindIs \"invalid\" \$appname ) -}}
    {{- \$appname | quote -}}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_gitlabPsqlPreparedStatements
    set output_file "gitlabPsqlPreparedStatements.tpl"

    set template_content "{
{{/*
Return if prepared statements should be used by PostgreSQL.
Defaults to false
*/}}
{{- define \"gitlab.psql.preparedStatements\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- eq true (default false (pluck \"preparedStatements\" \$local .Values.global.psql | first)) -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlDatabaseTasks
    set output_file "gitlabPsqlDatabaseTasks.tpl"

    set template_content "{
{{/*
Return if database tasks should be used by GitLab Rails for a given configuration.
Defaults to true
*/}}
{{- define \"gitlab.psql.databaseTasks\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- \$databaseTasks := pluck \"databaseTasks\" \$local .Values.global.psql | first -}}
  {{- if not ( kindIs \"invalid\" \$databaseTasks ) -}}
    {{- eq true \$databaseTasks -}}
  {{- else -}}
    {{- true -}}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlConnectTimeout
    set output_file "gitlabPsqlConnectTimeout.tpl"

    set template_content "{
{{/*
Return connect_timeout value
Defaults to nil
*/}}
{{- define \"gitlab.psql.connectTimeout\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"connectTimeout\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlKeepalives
    set output_file "gitlabPsqlKeepalives.tpl"

    set template_content "{
{{/*
Return keepalives value
Defaults to nil
*/}}
{{- define \"gitlab.psql.keepalives\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"keepalives\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlKeepalivesIdle
    set output_file "gitlabPsqlKeepalivesIdle.tpl"

    set template_content "{
{{/*
Return keepalives_idle value
Defaults to nil
*/}}
{{- define \"gitlab.psql.keepalivesIdle\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"keepalivesIdle\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlKeepalivesInterval
    set output_file "gitlabPsqlKeepalivesInterval.tpl"

    set template_content "{
{{/*
Return keepalives_interval value
Defaults to nil
*/}}
{{- define \"gitlab.psql.keepalivesInterval\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"keepalivesInterval\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlKeepalivesCount
    set output_file "gitlabPsqlKeepalivesCount.tpl"

    set template_content "{
{{/*
Return keepalives_count value
Defaults to nil
*/}}
{{- define \"gitlab.psql.keepalivesCount\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"keepalivesCount\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_gitlabPsqlTcpUserTimeout
    set output_file "gitlabPsqlTcpUserTimeout.tpl"

    set template_content "{
{{/*
Return tcp_user_timeout value
Defaults to nil
*/}}
{{- define \"gitlab.psql.tcpUserTimeout\" -}}
  {{- \$local := pluck \"psql\" \$.Values | first -}}
  {{- pluck \"tcpUserTimeout\" \$local .Values.global.psql | first -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_registryDatabaseUsername
    set output_file "registryDatabaseUsername.tpl"

    set template_content "{
{{/*
Return the registry database username
Checks both main chart context (.Values.registry.database.user) and 
subchart context (.Values.database.user) for maximum compatibility.
Priority: local > global > default (\"registry\")
*/}}
{{- define \"registry.database.username\" -}}
  {{- \$localRegistry := default (dict) .Values.registry -}}
  {{- \$localDatabase := default (dict) .Values.database -}}
  {{- \$global := default (dict) .Values.global -}}

  {{- \$localUser := dig \"database\" \"user\" \"\" \$localRegistry | default (dig \"user\" \"\" \$localDatabase) -}}
  {{- \$globalUser := dig \"registry\" \"database\" \"user\" \"\" \$global -}}
  {{- coalesce \$localUser \$globalUser \"registry\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_registryDatabaseName
    set output_file "registryDatabaseName.tpl"

    set template_content "{
{{/*
Return the registry database name
Checks both main chart context (.Values.registry.database.name) and 
subchart context (.Values.database.name) for maximum compatibility.
Priority: local > global > default (\"registry\")
*/}}
{{- define \"registry.database.name\" -}}
  {{- \$localRegistry := default (dict) .Values.registry -}}
  {{- \$localDatabase := default (dict) .Values.database -}}
  {{- \$global := default (dict) .Values.global -}}

  {{- \$localName := dig \"database\" \"name\" \"\" \$localRegistry | default (dig \"name\" \"\" \$localDatabase) -}}
  {{- \$globalName := dig \"registry\" \"database\" \"name\" \"\" \$global -}}
  {{- coalesce \$localName \$globalName \"registry\" -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_serviceAnnotations
    set output_file "serviceAnnotations.tpl"

    set template_content "{
{{/*
Handles merging a set of service annotations
*/}}
{{- define \"gitlab.serviceAnnotations\" -}}
  {{- \$allAnnotations := merge (default (dict) (default (dict) .Values.service).annotations) .Values.global.service.annotations -}}
  {{- if \$allAnnotations }}
    {{- toYaml \$allAnnotations -}}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_deploymentAnnotations
    set output_file "deploymentAnnotations.tpl"

    set template_content "{
{{/*
Handles merging a set of deployment annotations
*/}}
{{- define \"gitlab.deploymentAnnotations\" -}}
  {{- \$allAnnotations := merge (default (dict) (default (dict) .Values.deployment).annotations) .Values.global.deployment.annotations -}}
  {{- if \$allAnnotations -}}
    {{- toYaml \$allAnnotations -}}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_podLabels
    set output_file "podLabels.tpl"

    set template_content "{
{{/*
Handles merging a set of non-selector labels
*/}}
{{- define \"gitlab.podLabels\" -}}
  {{- \$allLabels := merge (default (dict) .Values.podLabels) .Values.global.pod.labels -}}
  {{- if \$allLabels -}}
    {{- range \$key, \$value := \$allLabels }}
{{ \$key }}: {{ \$value | quote }}
    {{- end }}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_serviceLabels
    set output_file "serviceLabels.tpl"

    set template_content "{
{{/*
Handles merging a set of labels for services
*/}}
{{- define \"gitlab.serviceLabels\" -}}
  {{- \$allLabels := merge (default (dict) .Values.serviceLabels) .Values.global.service.labels -}}
  {{- if \$allLabels -}}
    {{- range \$key, \$value := \$allLabels }}
{{ \$key }}: {{ \$value | quote }}
    {{- end }}
  {{- end -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_wildcardSelfSignedCertName
    set output_file "wildcardSelfSignedCertName.tpl"

    set template_content "{
{{/* selfsigned cert for when other options aren't provided */}}
{{- define \"gitlab.wildcard-self-signed-cert-name\" -}}
  {{- default (printf \"%s-wildcard-tls\" .Release.Name) .Values.global.ingress.tls.secretName -}}
{{- end -}}
}"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function helm_ingressTlsConfigured
    set output_file "ingressTlsConfigured.tpl"

    set template_content '{
{{/*
Detect if `x.ingress.tls.secretName` are set.
Return value if either `global.ingress.tls.secretName` or all components have `x.ingress.tls.secretName` set.
Return empty if not.

We are explicitly checking for an actual value being present, not just the existence of map.
*/}}
{{- define "gitlab.ingress.tls.configured" -}}
  {{/* Pull the value, if it exists */}}
  {{- \$global      := pluck "secretName" (default (dict) \$.Values.global.ingress.tls) | first -}}
  {{- \$webservice  := pluck "secretName" \$.Values.gitlab.webservice.ingress.tls | first -}}
  {{- \$registry    := pluck "secretName" \$.Values.registry.ingress.tls | first -}}
  {{- \$minio       := pluck "secretName" \$.Values.minio.ingress.tls | first -}}
  {{- \$pages       := pluck "secretName" ((index \$.Values.gitlab "gitlab-pages").ingress).tls | first -}}
  {{- \$kas         := pluck "secretName" \$.Values.gitlab.kas.ingress.tls | first -}}
  {{- \$workspaces  := pluck "workspacesSecretName" \$.Values.gitlab.kas.ingress.tls | first -}}
  {{- \$smartcard   := pluck "smartcardSecretName" \$.Values.gitlab.webservice.ingress.tls | first -}}

  {{/* Set each item to configured value, or !enabled */}}
  {{- \$webservice  := default \$webservice (not \$.Values.gitlab.webservice.enabled) -}}
  {{- \$registry    := default \$registry (not \$.Values.registry.enabled) -}}
  {{- \$minio       := default \$minio (not \$.Values.global.minio.enabled) -}}
  {{- \$pages       := default \$pages (not \$.Values.global.pages.enabled) -}}
  {{- \$kas         := default \$kas (not \$.Values.global.kas.enabled) -}}
  {{- \$workspaces  := default \$workspaces (not \$.Values.global.workspaces.enabled) -}}
  {{- \$smartcard   := default \$smartcard (not \$.Values.global.appConfig.smartcard.enabled) -}}

  {{/* Check that all enabled items have been configured */}}
  {{- if or \$global (and \$webservice \$registry \$minio \$pages \$kas \$smartcard) -}}
    true
  {{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_globalIngressTlsEnabled
    set output_file "globalIngressTlsEnabled.tpl"

    set template_content '{
{{/*
Detect if `.Values.ingress.tls.enabled` is set
Returns `global.ingress.tls.enabled` if it is a boolean.
Return true in any other case.
*/}}
{{- define "gitlab.global.ingress.tls.enabled" -}}
{{- \$globalSet := and (hasKey \$.Values.global.ingress "tls") (and (hasKey \$.Values.global.ingress.tls "enabled") (kindIs "bool" \$.Values.global.ingress.tls.enabled)) -}}
{{- if \$globalSet }}
{{-  \$.Values.global.ingress.tls.enabled }}
{{- else }}
{{-   true }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_ingressTlsEnabled
    set output_file "ingressTlsEnabled.tpl"

    set template_content '{
{{/*
Detect if `.Values.ingress.tls.enabled` is set
Returns `ingress.tls.enabled` if it is a boolean,
Returns `global.ingress.tls.enabled` if it is a boolean, and `ingress.tls.enabled` is not.
Return true in any other case.
*/}}
{{- define "gitlab.ingress.tls.enabled" -}}
{{- \$localSet := and (hasKey \$.Values "ingress") (hasKey \$.Values.ingress "tls") (and (hasKey \$.Values.ingress.tls "enabled") (kindIs "bool" \$.Values.ingress.tls.enabled)) -}}
{{- if \$localSet }}
{{-   \$.Values.ingress.tls.enabled }}
{{- else }}
{{-   include "gitlab.global.ingress.tls.enabled" . }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function helm_ingressEnabled
    set output_file "ingressEnabled.tpl"

    set template_content '{
{{/*
Detect if `.Values.ingress.enabled` is set
Returns `ingress.enabled` if it is a boolean,
Returns `global.ingress.enabled` if it is a boolean, and `ingress.enabled` is not.
Return true in any other case.
*/}}
{{- define "gitlab.ingress.enabled" -}}
{{- \$globalSet := and (hasKey \$.Values.global.ingress "enabled") (kindIs "bool" \$.Values.global.ingress.enabled) -}}
{{- \$localSet := and (hasKey \$.Values.ingress "enabled") (kindIs "bool" \$.Values.ingress.enabled) -}}
{{- if \$localSet }}
{{-   \$.Values.ingress.enabled }}
{{- else if \$globalSet }}
{{-   \$.Values.global.ingress.enabled }}
{{- else }}
{{-   true }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_ingressEnabled
    set output_file "ingressEnabled.tpl"

    set template_content '{
{{/*
Detect if `.Values.ingress.enabled` is set
Returns `ingress.enabled` if it is a boolean,
Returns `global.ingress.enabled` if it is a boolean, and `ingress.enabled` is not.
Return true in any other case.
*/}}
{{- define "gitlab.ingress.enabled" -}}
{{- \$globalSet := and (hasKey \$.Values.global.ingress "enabled") (kindIs "bool" \$.Values.global.ingress.enabled) -}}
{{- \$localSet := and (hasKey \$.Values.ingress "enabled") (kindIs "bool" \$.Values.ingress.enabled) -}}
{{- if \$localSet }}
{{-   \$.Values.ingress.enabled }}
{{- else if \$globalSet }}
{{-   \$.Values.global.ingress.enabled }}
{{- else }}
{{-   true }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_redisSecretTemplates
    set output_file "redisSecretTemplates.tpl"

    set template_content '{
{{/*
Override upstream redis chart naming
*/}}
{{- define "redis.secretName" -}}
{{- template "gitlab.redis.password.secret" . -}}
{{- end -}}

{{/*
Override upstream redis secret key name
*/}}
{{- define "redis.secretPasswordKey" -}}
{{- template "gitlab.redis.password.key" . -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_sharedSecretsFullname
    set output_file "sharedSecretsFullname.tpl"

    set template_content '{
{{/*
Return the fullname template for shared-secrets job.
*/}}
{{- define "shared-secrets.fullname" -}}
{{- printf "%s-shared-secrets" .Release.Name -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_sharedSecretsName
    set output_file "sharedSecretsName.tpl"

    set template_content '{
{{/*
Return the name template for shared-secrets job.
*/}}
{{- define "shared-secrets.name" -}}
{{- $sharedSecretValues := index .Values "shared-secrets" -}}
{{- default "shared-secrets" $sharedSecretValues.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_sharedSecretsJobname
    set output_file "sharedSecretsJobname.tpl"

    set template_content '{
{{/*
Create a default fully qualified job name for shared-secrets.
*/}}
{{- define "shared-secrets.jobname" -}}
{{- $name := include "shared-secrets.fullname" . | trunc 55 | trimSuffix "-" -}}
{{- printf "%s-%s" $name ( include "gitlab.jobNameSuffix" . ) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_sharedSecretsServiceAccountName
    set output_file "sharedSecretsServiceAccountName.tpl"

    set template_content '{
{{/*
Create the name of the service account to use for shared-secrets job
*/}}
{{- define "shared-secrets.serviceAccountName" -}}
{{- $sharedSecretValues := index .Values "shared-secrets" -}}
{{- if $sharedSecretValues.serviceAccount.create -}}
    {{ default (include "shared-secrets.fullname" .) $sharedSecretValues.serviceAccount.name }}
{{- else -}}
    {{ coalesce $sharedSecretValues.serviceAccount.name .Values.global.serviceAccount.name "default" }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_automountServiceAccountToken
    set output_file "automountServiceAccountToken.tpl"

    set template_content '{
{{/*
Set if the default ServiceAccount token should be mounted by Kubernetes or not.
Default is "false"
*/}}
{{- define "gitlab.automountServiceAccountToken" -}}
automountServiceAccountToken: {{ pluck "automountServiceAccountToken" .Values.serviceAccount .Values.global.serviceAccount | first }}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_volumeEmptyDir
    set output_file "volumeEmptyDir.tpl"

    set template_content '{
{{/*
Return an emptyDir definition for Volume declarations
Scope is the configuration of that emptyDir.
Only accepts sizeLimit and/or medium
*/}}
{{- define "gitlab.volume.emptyDir" -}}
{{- $values := pick . "sizeLimit" "medium" -}}
{{- if not $values -}}
emptyDir: {}
{{- else -}}
emptyDir: {{ toYaml $values | nindent 2 }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_upgradeCheckContainerSecurityContext
    set output_file "upgradeCheckContainerSecurityContext.tpl"

    set template_content '{
{{/*
Return upgradeCheck container specific securityContext template
*/}}
{{- define "upgradeCheck.containerSecurityContext" -}}
{{- if .Values.upgradeCheck.containerSecurityContext -}}
securityContext:
  {{- toYaml .Values.upgradeCheck.containerSecurityContext | nindent 2 }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_initContainerSecurityContext
    set output_file "initContainerSecurityContext.tpl"

    set template_content '{
{{/*
Return init container specific securityContext template
*/}}
{{- define "gitlab.init.containerSecurityContext" -}}
{{- if .Values.init.containerSecurityContext -}}
securityContext:
  {{- toYaml .Values.init.containerSecurityContext | nindent 2 }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_containerSecurityContext
    set output_file "containerSecurityContext.tpl"

    set template_content '{
{{/*
Return container specific securityContext template
*/}}
{{- define "gitlab.containerSecurityContext" -}}
{{- if .Values.containerSecurityContext -}}
securityContext:
  {{- toYaml .Values.containerSecurityContext | nindent 2 }}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_podSecurityContext
    set output_file "podSecurityContext.tpl"

    set template_content '{
{{/*
Return a PodSecurityContext definition.

Usage:
  {{ include "gitlab.podSecurityContext" .Values.securityContext }}
*/}}
{{- define "gitlab.podSecurityContext" -}}
{{- $psc := . -}}
{{- if $psc -}}
securityContext:
{{-   if not (empty $psc.runAsUser) -}}
  runAsUser: {{ $psc.runAsUser }}
{{-   end -}}
{{-   if not (empty $psc.runAsGroup) -}}
  runAsGroup: {{ $psc.runAsGroup }}
{{-   end -}}
{{-   if not (empty $psc.fsGroup) -}}
  fsGroup: {{ $psc.fsGroup }}
{{-   end -}}
{{-   if not (empty $psc.fsGroupChangePolicy) -}}
  fsGroupChangePolicy: {{ $psc.fsGroupChangePolicy }}
{{-   end -}}
{{-   if $psc.seccompProfile -}}
  seccompProfile:
    {{- toYaml $psc.seccompProfile | nindent 4 }}
{{-   end -}}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_podSecurityContextRoot
    set output_file "podSecurityContextRoot.tpl"

    set template_content '{
{{/*
Return a PodSecurityContext definition that allows it to run as root.

Usage:
  {{ include "gitlab.podSecurityContextRoot" .Values.securityContext }}
*/}}
{{- define "gitlab.podSecurityContextRoot" -}}
{{- $psc := . -}}
{{- if $psc -}}
securityContext:
{{-   if not (eq $psc.runAsUser nil) -}}
  runAsUser: {{ $psc.runAsUser }}
{{-   end -}}
{{-   if not (eq $psc.runAsGroup nil) -}}
  runAsGroup: {{ $psc.runAsGroup }}
{{-   end -}}
{{-   if not (eq $psc.fsGroup nil) -}}
  fsGroup: {{ $psc.fsGroup }}
{{-   end -}}
{{-   if not (eq $psc.fsGroupChangePolicy nil) -}}
  fsGroupChangePolicy: {{ $psc.fsGroupChangePolicy }}
{{-   end -}}
{{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_jobNameSuffix
    set output_file "jobNameSuffix.tpl"

    set template_content '{
{{/*
Returns `.Values.global.job.nameSuffixOverride` if set.
If not set, generates a hash-based suffix from chart version and values.
*/}}
{{- define "gitlab.jobNameSuffix" -}}
{{-   if .Values.global.job.nameSuffixOverride -}}
{{-     tpl .Values.global.job.nameSuffixOverride . -}}
{{-   else -}}
{{-     $values := unset (deepCopy .Values) "local" -}}
{{-     printf "%s-%s-%s" .Chart.Version .Chart.AppVersion (($values | toYaml | b64enc) | sha256sum) | trunc 7 -}}
{{-   end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_checkDuplicateKeyFromEnv
    set output_file "checkDuplicateKeyFromEnv.tpl"

    set template_content '{
{{/*
Return a boolean indicating whether a key exists in environment variables
from local, global, or deployment scope.
Usage: {{- include "checkDuplicateKeyFromEnv" (dict "rootScope" $ "keyToFind" "MY_KEY") -}}
*/}}
{{- define "checkDuplicateKeyFromEnv" -}}
  {{- $keyToFind := .keyToFind -}}
  {{- $rootScope := .rootScope -}}
  {{- $deploymentScope := .deploymentScope -}}
  {{- $localHasKey := and $rootScope.Values.extraEnv (hasKey $rootScope.Values.extraEnv $keyToFind) -}}
  {{- $globalHasKey := and $rootScope.Values.global.extraEnv (hasKey $rootScope.Values.global.extraEnv $keyToFind) -}}
  {{- $localHasKeyFrom := and $rootScope.Values.extraEnvFrom (hasKey $rootScope.Values.extraEnvFrom $keyToFind) -}}
  {{- $globalHasKeyFrom := and $rootScope.Values.global.extraEnvFrom (hasKey $rootScope.Values.global.extraEnvFrom $keyToFind) -}}
  {{- $deploymentHasKey := and $deploymentScope $deploymentScope.extraEnv (hasKey $deploymentScope.extraEnv $keyToFind) -}}
  {{- $deploymentHasKeyFrom := and $deploymentScope $deploymentScope.extraEnvFrom (hasKey $deploymentScope.extraEnvFrom $keyToFind) -}}
  {{- if or $localHasKey $globalHasKey $localHasKeyFrom $globalHasKeyFrom $deploymentHasKey $deploymentHasKeyFrom -}}
true
  {{- else -}}
false
  {{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_godebugEnv
    set output_file "godebugEnv.tpl"

    set template_content '{
{{/*
Render GODEBUG environment variable if not already defined in extraEnv.
Usage: {{- include "gitlab.godebug.env" $ -}}
*/}}
{{- define "gitlab.godebug.env" -}}
  {{- $godebugIsDuplicate := include "checkDuplicateKeyFromEnv" (dict "rootScope" (hasKey . "rootScope" | ternary .rootScope . ) "keyToFind" "GODEBUG" "deploymentScope" .deploymentScope) -}}
  {{- if eq $godebugIsDuplicate "false" -}}
- name: GODEBUG
  value: "tlsmlkem=0,tlskyber=0"
  {{- end -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_topologyServiceTlsSecret
    set output_file "topologyServiceTlsSecret.tpl"

    set template_content '{
{{/*
Return the Topology Service TLS Secret name
*/}}
{{- define "topology-service.tls.secret" -}}
  {{- default (printf "%s-topology-service-tls" .Release.Name) $.Values.global.appConfig.cell.topologyServiceClient.tls.secret | quote -}}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_topologyServiceMountSecrets
    set output_file "topologyServiceMountSecrets.tpl"

    set template_content '{
{{/*
Mount topology service TLS secrets in projected volume sources
Usage: {{ include "gitlab.topologyService.mountSecrets" $ | nindent 10 }}
*/}}
{{- define "gitlab.topologyService.mountSecrets" -}}
{{- if and $.Values.global.appConfig.cell.enabled $.Values.global.appConfig.cell.topologyServiceClient.tls.enabled }}
- secret:
    name: {{ template "topology-service.tls.secret" $ }}
    items:
      - key: "tls.crt"
        path: "topology-service/tls.crt"
      - key: "tls.key"
        path: "topology-service/tls.key"
{{- end }}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function helm_topologyServiceVolumeMounts
    set output_file "topologyServiceVolumeMounts.tpl"

    set template_content '{
{{/*
Volume mounts for topology service TLS files
Usage: {{ include "gitlab.topologyService.volumeMounts" (dict "context" $ "secretsVolumeName" "webservice-secrets") | nindent 12 }}
*/}}
{{- define "gitlab.topologyService.volumeMounts" -}}
{{- $context := .context -}}
{{- if and $context.Values.global.appConfig.cell.enabled $context.Values.global.appConfig.cell.topologyServiceClient.tls.enabled }}
- name: {{ .secretsVolumeName }}
  mountPath: /srv/gitlab/config/topology-service/tls.crt
  subPath: topology-service/tls.crt
  readOnly: true
- name: {{ .secretsVolumeName }}
  mountPath: /srv/gitlab/config/topology-service/tls.key
  subPath: topology-service/tls.key
  readOnly: true
{{- end }}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function helm_topologyServiceConfigureScript
    set output_file "topologyServiceConfigureScript.tpl"

    set template_content '{
{{/*
Configure script for topology service TLS secrets
Usage: {{ include "gitlab.topologyService.configureScript" $ | nindent 4 }}
*/}}
{{- define "gitlab.topologyService.configureScript" -}}
{{- if and $.Values.global.appConfig.cell.enabled $.Values.global.appConfig.cell.topologyServiceClient.tls.enabled }}
  if [ -d /init-config/topology-service ]; then
    mkdir -p /init-secrets/topology-service
    cp -v -L /init-config/topology-service/tls.key /init-secrets/topology-service/tls.key
    cp -v -L /init-config/topology-service/tls.crt /init-secrets/topology-service/tls.crt
  fi
{{- end }}
{{- end -}}
}'

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

