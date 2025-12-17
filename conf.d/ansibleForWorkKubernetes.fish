function kubernetes.core.helm
    set output_file "helm_deploy_playbook.yml"

    set content "---
# Ansible playbook: Helm chart deployments

- hosts: localhost
  gather_facts: false
  tasks:

    # Deploy latest Prometheus chart
    - name: Deploy latest version of Prometheus chart inside monitoring namespace (and create it)
      kubernetes.core.helm:
        name: test
        chart_ref: stable/prometheus
        release_namespace: monitoring
        create_namespace: true

    # Add stable chart repo
    - name: Add stable chart repo
      kubernetes.core.helm_repository:
        name: stable
        repo_url: 'https://kubernetes.github.io/ingress-nginx'

    # Deploy latest Grafana chart with values
    - name: Deploy latest version of Grafana chart inside monitoring namespace with values
      kubernetes.core.helm:
        name: test
        chart_ref: stable/grafana
        release_namespace: monitoring
        values:
          replicas: 2

    # Deploy Grafana chart on specific version with template values
    - name: Deploy Grafana chart on 5.0.12 with values loaded from template
      kubernetes.core.helm:
        name: test
        chart_ref: stable/grafana
        chart_version: 5.0.12
        values: \"{{ lookup('template', 'somefile.yaml') | from_yaml }}\"

    # Deploy Grafana using local values file
    - name: Deploy Grafana chart using values files on target
      kubernetes.core.helm:
        name: test
        chart_ref: stable/grafana
        release_namespace: monitoring
        values_files:
          - /path/to/values.yaml

    # Remove test release
    - name: Remove test release and waiting suppression ending
      kubernetes.core.helm:
        name: test
        state: absent
        wait: true

    # Update repository cache separately
    - name: Separately update the repository cache
      kubernetes.core.helm:
        name: dummy
        namespace: kube-system
        state: absent
        update_repo_cache: true

    # Deploy Grafana using set values
    - name: Deploy Grafana chart using set values on target
      kubernetes.core.helm:
        name: test
        chart_ref: stable/grafana
        release_namespace: monitoring
        set_values:
          - value: phase=prod
            value_type: string

    # Git clone repo
    - name: Git clone stable repo on HEAD
      ansible.builtin.git:
        repo: 'http://github.com/helm/charts.git'
        dest: /tmp/helm_repo

    # Deploy Grafana from local path
    - name: Deploy Grafana chart from local path
      kubernetes.core.helm:
        name: test
        chart_ref: /tmp/helm_repo/stable/grafana
        release_namespace: monitoring

    # Deploy Grafana from URL
    - name: Deploy Grafana chart on 5.6.0 from url
      kubernetes.core.helm:
        name: test
        chart_ref: 'https://github.com/grafana/helm-charts/releases/download/grafana-5.6.0/grafana-5.6.0.tgz'
        release_namespace: monitoring

    # Deploy MongoDB from OCI registry
    - name: Deploy Bitnami's MongoDB latest chart from OCI registry
      kubernetes.core.helm:
        name: test
        chart_ref: 'oci://registry-1.docker.io/bitnamicharts/mongodb'
        release_namespace: database

    # Deploy New Relic chart with complex values
    - name: Deploy new-relic client chart
      kubernetes.core.helm:
        name: newrelic-bundle
        chart_ref: newrelic/nri-bundle
        release_namespace: default
        force: True
        wait: True
        replace: True
        update_repo_cache: True
        disable_hook: True
        values:
          global:
            licenseKey: \"{{ nr_license_key }}\"
            cluster: \"{{ site_name }}\"
          newrelic-infrastructure:
            privileged: True
          ksm:
            enabled: True
          prometheus:
            enabled: True
          kubeEvents:
            enabled: True
          logging:
            enabled: True

    # Deploy latest Grafana chart reusing values
    - name: Deploy latest version of Grafana chart using reuse_values
      kubernetes.core.helm:
        name: test
        chart_ref: stable/grafana
        release_namespace: monitoring
        reuse_values: true
        values:
          replicas: 2
          version: 3e8ec0b2dffa40fb97d5342e4af887de95faa8c61a62480dd7f8aa03dffcf533
"

    echo $content > $output_file
    set_color green
    echo "Playbook $output_file created."
    set_color normal
    echo ""
end


function kubernetes.core.helm_info
    set output_file "kubernetes.core.helm_info.yml"

    set template_content "---
- name: Gather information of Grafana chart inside monitoring namespace
  kubernetes.core.helm_info:
    name: test
    release_namespace: monitoring

- name: Gather information about test-chart with pending state
  kubernetes.core.helm_info:
    name: test-chart
    release_namespace: testenv
    release_state:
      - pending
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.helm_plugin
    set output_file "kubernetes.core.helm_plugin.yml"

    set template_content "---
- name: Install Helm env plugin
  kubernetes.core.helm_plugin:
    plugin_path: https://github.com/adamreese/helm-env
    state: present

- name: Install Helm plugin from local filesystem
  kubernetes.core.helm_plugin:
    plugin_path: https://domain/path/to/plugin.tar.gz
    state: present

- name: Remove Helm env plugin
  kubernetes.core.helm_plugin:
    plugin_name: env
    state: absent

- name: Install Helm plugin with a specific version
  kubernetes.core.helm_plugin:
    plugin_version: 2.0.1
    plugin_path: https://domain/path/to/plugin.tar.gz
    state: present

- name: Update Helm plugin
  kubernetes.core.helm_plugin:
    plugin_name: secrets
    state: latest
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.helm_plugin_info
    set output_file "kubernetes.core.helm_plugin_info.yml"

    set template_content "---
- name: Gather Helm plugin info
  kubernetes.core.helm_plugin_info:

- name: Gather Helm env plugin info
  kubernetes.core.helm_plugin_info:
    plugin_name: env
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.helm_pull
    set output_file "kubernetes.core.helm_pull.yml"

    set template_content "---
- name: Download chart using chart url
  kubernetes.core.helm_pull:
    chart_ref: https://github.com/grafana/helm-charts/releases/download/grafana-5.6.0/grafana-5.6.0.tgz
    destination: /path/to/chart

- name: Download Chart using chart_name and repo_url
  kubernetes.core.helm_pull:
    chart_ref: redis
    repo_url: https://charts.bitnami.com/bitnami
    untar_chart: yes
    destination: /path/to/chart

- name: Download Chart (skip tls certificate check)
  kubernetes.core.helm_pull:
    chart_ref: redis
    repo_url: https://charts.bitnami.com/bitnami
    untar_chart: yes
    destination: /path/to/chart
    skip_tls_certs_check: yes

- name: Download Chart using chart registry credentials
  kubernetes.core.helm_pull:
    chart_ref: redis
    repo_url: https://charts.bitnami.com/bitnami
    untar_chart: yes
    destination: /path/to/chart
    username: myuser
    password: mypassword123
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.helm_registry_auth
    set output_file "kubernetes.core.helm_registry_auth.yml"

    set template_content "---
- name: Login to remote registry
  kubernetes.core.helm_registry_auth:
    username: admin
    password: \"sample_password\"
    host: localhost:5000

- name: Logout from remote registry
  kubernetes.core.helm_registry_auth:
    state: absent
    host: localhost:5000
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.helm_repository
    set output_file "kubernetes.core.helm_repository.yml"

    set template_content "---
- name: Add a repository
  kubernetes.core.helm_repository:
    name: stable
    repo_url: https://kubernetes.github.io/ingress-nginx

- name: Add Red Hat Helm charts repository
  kubernetes.core.helm_repository:
    name: redhat-charts
    repo_url: https://redhat-developer.github.com/redhat-helm-charts
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function kubernetes.core.helm_template
    set output_file "kubernetes.core.helm_template.yml"

    set template_content "---
- name: Render templates to specified directory
  kubernetes.core.helm_template:
    chart_ref: stable/prometheus
    output_dir: mycharts

- name: Render templates
  kubernetes.core.helm_template:
    chart_ref: stable/prometheus
  register: result

- name: Write templates to file
  copy:
    dest: myfile.yaml
    content: \"{{ result.stdout }}\"

- name: Render MutatingWebhooksConfiguration for revision tag \"canary\", rev \"1-13-0\"
  kubernetes.core.helm_template:
    chart_ref: istio/istiod
    chart_version: \"1.13.0\"
    release_namespace: \"istio-system\"
    show_only:
      - \"templates/revision-tags.yaml\"
    release_values:
      revision: \"1-13-0\"
      revisionTags:
        - \"canary\"
  register: result

- name: Write templates to file
  copy:
    dest: myfile.yaml
    content: \"{{ result.stdout }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s
    set output_file "kubernetes.core.k8s.yml"

    set template_content "---
- name: Create a k8s namespace
  kubernetes.core.k8s:
    name: testing
    api_version: v1
    kind: Namespace
    state: present

- name: Create a Service object from an inline definition
  kubernetes.core.k8s:
    state: present
    definition:
      apiVersion: v1
      kind: Service
      metadata:
        name: web
        namespace: testing
        labels:
          app: galaxy
          service: web
      spec:
        selector:
          app: galaxy
          service: web
        ports:
        - protocol: TCP
          targetPort: 8000
          name: port-8000-tcp
          port: 8000

- name: Remove an existing Service object
  kubernetes.core.k8s:
    state: absent
    api_version: v1
    kind: Service
    namespace: testing
    name: web

- name: Create a Deployment by reading the definition from a local file
  kubernetes.core.k8s:
    state: present
    src: /testing/deployment.yml

- name: Read definition file from controller and decrypt if needed
  kubernetes.core.k8s:
    state: present
    definition: \"{{ lookup('file', '/testing/deployment.yml') | from_yaml }}\"

- name: Read multiple YAML documents from file
  kubernetes.core.k8s:
    state: present
    definition: \"{{ lookup('file', '/testing/deployment.yml') | from_yaml_all }}\"

- name: Read definition template file
  kubernetes.core.k8s:
    state: present
    template: '/testing/deployment.j2'

- name: Read template file with custom start/end strings
  kubernetes.core.k8s:
    state: present
    template:
      path: '/testing/deployment.j2'
      variable_start_string: '[['
      variable_end_string: ']]'

- name: Read multiple template files
  kubernetes.core.k8s:
    state: present
    template:
    - path: '/testing/deployment_one.j2'
    - path: '/testing/deployment_two.j2'
      variable_start_string: '[['
      variable_end_string: ']]'

- name: Fail on validation errors
  kubernetes.core.k8s:
    state: present
    definition: \"{{ lookup('template', '/testing/deployment.yml') | from_yaml }}\"
    validate:
      fail_on_error: yes

- name: Warn on validation errors, strict checking
  kubernetes.core.k8s:
    state: present
    definition: \"{{ lookup('template', '/testing/deployment.yml') | from_yaml }}\"
    validate:
      fail_on_error: no
      strict: yes

- name: Download metrics-server manifest
  ansible.builtin.get_url:
    url: https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
    dest: ~/metrics-server.yaml
    mode: '0664'

- name: Apply metrics-server manifest
  kubernetes.core.k8s:
    state: present
    src: ~/metrics-server.yaml

- name: Pause a Deployment
  kubernetes.core.k8s:
    definition:
      apiVersion: apps/v1
      kind: Deployment
      metadata:
        name: example
        namespace: testing
      spec:
        paused: True
    wait: yes
    wait_condition:
      type: Progressing
      status: Unknown
      reason: DeploymentPaused

- name: Add label to existing namespace
  kubernetes.core.k8s:
    state: patched
    kind: Namespace
    name: patch_namespace
    definition:
      metadata:
        labels:
          support: patch

- name: Create resource using server-generated name
  kubernetes.core.k8s:
    state: present
    generate_name: pod-
    definition:
      apiVersion: v1
      kind: Pod
      spec:
        containers:
        - name: py
          image: python:3.7-alpine
          imagePullPolicy: IfNotPresent

- name: Create ConfigMap using server-side apply
  kubernetes.core.k8s:
    namespace: testing
    definition:
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: my-configmap
    apply: yes
    server_side_apply:
      field_manager: ansible

- name: Delete all Deployments from specified namespace
  kubernetes.core.k8s:
    api_version: apps/v1
    namespace: testing
    kind: Deployment
    delete_all: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_cluster_info
    set output_file "kubernetes.core.k8s_cluster_info.yml"

    set template_content "---
- name: Get Cluster information
  kubernetes.core.k8s_cluster_info:
  register: api_status

- name: Do not invalidate cache before getting information
  kubernetes.core.k8s_cluster_info:
    invalidate_cache: False
  register: api_status
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function kubernetes.core.k8s_cp
    set output_file "kubernetes.core.k8s_cp.yml"

    set template_content "---
# kubectl cp /tmp/foo some-namespace/some-pod:/tmp/bar
- name: Copy /tmp/foo local file to /tmp/bar in a remote pod
  kubernetes.core.k8s_cp:
    namespace: some-namespace
    pod: some-pod
    remote_path: /tmp/bar
    local_path: /tmp/foo

# kubectl cp /tmp/foo_dir some-namespace/some-pod:/tmp/bar_dir
- name: Copy /tmp/foo_dir local directory to /tmp/bar_dir in a remote pod
  kubernetes.core.k8s_cp:
    namespace: some-namespace
    pod: some-pod
    remote_path: /tmp/bar_dir
    local_path: /tmp/foo_dir

# kubectl cp /tmp/foo some-namespace/some-pod:/tmp/bar -c some-container
- name: Copy /tmp/foo local file to /tmp/bar in a remote pod in a specific container
  kubernetes.core.k8s_cp:
    namespace: some-namespace
    pod: some-pod
    container: some-container
    remote_path: /tmp/bar
    local_path: /tmp/foo
    no_preserve: True
    state: to_pod

# kubectl cp some-namespace/some-pod:/tmp/foo /tmp/bar
- name: Copy /tmp/foo from a remote pod to /tmp/bar locally
  kubernetes.core.k8s_cp:
    namespace: some-namespace
    pod: some-pod
    remote_path: /tmp/foo
    local_path: /tmp/bar
    state: from_pod

# copy content into a file in the remote pod
- name: Copy content into a file in the remote pod
  kubernetes.core.k8s_cp:
    state: to_pod
    namespace: some-namespace
    pod: some-pod
    remote_path: /tmp/foo.txt
    content: \"This content will be copied into remote file\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_drain
    set output_file "kubernetes.core.k8s_drain.yml"

    set template_content "---
- name: Drain node \"foo\", even if there are pods not managed by a ReplicationController, Job, or DaemonSet on it.
  kubernetes.core.k8s_drain:
    state: drain
    name: foo
    delete_options:
      force: yes

- name: Drain node \"foo\", but abort if there are pods not managed by a ReplicationController, Job, or DaemonSet, and use a grace period of 15 minutes.
  kubernetes.core.k8s_drain:
    state: drain
    name: foo
    delete_options:
      terminate_grace_period: 900

- name: Mark node \"foo\" as schedulable.
  kubernetes.core.k8s_drain:
    state: uncordon
    name: foo

- name: Mark node \"foo\" as unschedulable.
  kubernetes.core.k8s_drain:
    state: cordon
    name: foo

- name: Drain node \"foo\" using label selector to filter the list of pods to be drained.
  kubernetes.core.k8s_drain:
    state: drain
    name: foo
    pod_selectors:
    - 'app!=csi-attacher'
    - 'app!=csi-provisioner'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_exec
    set output_file "kubernetes.core.k8s_exec.yml"

    set template_content "---
- name: Execute a command
  kubernetes.core.k8s_exec:
    namespace: myproject
    pod: zuul-scheduler
    command: zuul-scheduler full-reconfigure

- name: Check RC status of command executed
  kubernetes.core.k8s_exec:
    namespace: myproject
    pod: busybox-test
    command: cmd_with_non_zero_exit_code
  register: command_status
  ignore_errors: True

- name: Check last command status
  debug:
    msg: \"cmd failed\"
  when: command_status.rc != 0

- name: Specify a container name to execute the command on
  kubernetes.core.k8s_exec:
    namespace: myproject
    pod: busybox-test
    container: manager
    command: echo \"hello\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_info
    set output_file "kubernetes.core.k8s_info.yml"

    set template_content "---
- name: Get an existing Service object
  kubernetes.core.k8s_info:
    api_version: v1
    kind: Service
    name: web
    namespace: testing
  register: web_service

- name: Get a list of all service objects
  kubernetes.core.k8s_info:
    api_version: v1
    kind: Service
    namespace: testing
  register: service_list

- name: Get a list of all pods from any namespace
  kubernetes.core.k8s_info:
    kind: Pod
  register: pod_list

- name: Search for all Pods labelled app=web
  kubernetes.core.k8s_info:
    kind: Pod
    label_selectors:
      - app = web
      - tier in (dev, test)

- name: Using vars while using label_selectors
  kubernetes.core.k8s_info:
    kind: Pod
    label_selectors:
      - \"app = {{ app_label_web }}\"
  vars:
    app_label_web: web

- name: Search for all running pods
  kubernetes.core.k8s_info:
    kind: Pod
    field_selectors:
      - status.phase=Running

- name: List custom objects created using CRD
  kubernetes.core.k8s_info:
    kind: MyCustomObject
    api_version: \"stable.example.com/v1\"

- name: Wait till the Object is created
  kubernetes.core.k8s_info:
    kind: Pod
    wait: yes
    name: pod-not-yet-created
    namespace: default
    wait_sleep: 10
    wait_timeout: 360
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_json_patch
    set output_file "kubernetes.core.k8s_json_patch.yml"

    set template_content "---
- name: Apply multiple patch operations to an existing Pod
  kubernetes.core.k8s_json_patch:
    kind: Pod
    namespace: testing
    name: mypod
    patch:
      - op: add
        path: /metadata/labels/app
        value: myapp
      - op: replace
        path: /spec/containers/0/image
        value: nginx
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_log
    set output_file "kubernetes.core.k8s_log.yml"

    set template_content "---
- name: Get a log from a Pod
  kubernetes.core.k8s_log:
    name: example-1
    namespace: testing
  register: log

- name: Log a Pod matching a label selector
  kubernetes.core.k8s_log:
    namespace: testing
    label_selectors:
      - app=example
  register: log

- name: Get a log from a Deployment
  kubernetes.core.k8s_log:
    api_version: apps/v1
    kind: Deployment
    namespace: testing
    name: example
    since_seconds: \"4000\"
  register: log

- name: Get a log from a DeploymentConfig
  kubernetes.core.k8s_log:
    api_version: apps.openshift.io/v1
    kind: DeploymentConfig
    namespace: testing
    name: example
    tail_lines: 100
  register: log

- name: Get the logs from all containers in pod
  kubernetes.core.k8s_log:
    namespace: testing
    name: some-pod
    all_containers: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_rollback
    set output_file "kubernetes.core.k8s_rollback.yml"

    set template_content "---
- name: Rollback a failed deployment
  kubernetes.core.k8s_rollback:
    api_version: apps/v1
    kind: Deployment
    name: web
    namespace: testing
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_scale
    set output_file "kubernetes.core.k8s_scale.yml"

    set template_content "---
- name: Scale deployment up, and extend timeout
  kubernetes.core.k8s_scale:
    api_version: v1
    kind: Deployment
    name: elastic
    namespace: myproject
    replicas: 3
    wait_timeout: 60

- name: Scale deployment down when current replicas match
  kubernetes.core.k8s_scale:
    api_version: v1
    kind: Deployment
    name: elastic
    namespace: myproject
    current_replicas: 3
    replicas: 2

- name: Increase job parallelism
  kubernetes.core.k8s_scale:
    api_version: batch/v1
    kind: job
    name: pi-with-timeout
    namespace: testing
    replicas: 2

- name: Scale deployment based on a file from the local filesystem
  kubernetes.core.k8s_scale:
    src: /myproject/elastic_deployment.yml
    replicas: 3
    wait: no

- name: Scale deployment based on a template output
  kubernetes.core.k8s_scale:
    resource_definition: \"{{ lookup('template', '/myproject/elastic_deployment.yml') | from_yaml }}\"
    replicas: 3
    wait: no

- name: Scale deployment based on a file from the Ansible controller filesystem
  kubernetes.core.k8s_scale:
    resource_definition: \"{{ lookup('file', '/myproject/elastic_deployment.yml') | from_yaml }}\"
    replicas: 3
    wait: no

- name: Scale deployment using label selectors (continue operation in case error occured on one resource)
  kubernetes.core.k8s_scale:
    replicas: 3
    kind: Deployment
    namespace: test
    label_selectors:
      - app=test
    continue_on_error: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_service
    set output_file "kubernetes.core.k8s_service.yml"

    set template_content "---
- name: Expose https port with ClusterIP
  kubernetes.core.k8s_service:
    state: present
    name: test-https
    namespace: default
    ports:
    - port: 443
      protocol: TCP
    selector:
      key: special

- name: Expose https port with ClusterIP using spec
  kubernetes.core.k8s_service:
    state: present
    name: test-https
    namespace: default
    inline:
      spec:
        ports:
        - port: 443
          protocol: TCP
        selector:
          key: special
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function kubernetes.core.k8s_taint
    set output_file "kubernetes.core.k8s_taint.yml"

    set template_content "---
- name: Taint node \"foo\"
  kubernetes.core.k8s_taint:
    state: present
    name: foo
    taints:
    - effect: NoExecute
      key: \"key1\"

- name: Taint node \"foo\" with multiple taints
  kubernetes.core.k8s_taint:
    state: present
    name: foo
    taints:
    - effect: NoExecute
      key: \"key1\"
      value: \"value1\"
    - effect: NoSchedule
      key: \"key1\"
      value: \"value1\"

- name: Remove taint from \"foo\"
  kubernetes.core.k8s_taint:
    state: absent
    name: foo
    taints:
    - effect: NoExecute
      key: \"key1\"
      value: \"value1\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

