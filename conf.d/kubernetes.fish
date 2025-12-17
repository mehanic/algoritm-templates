function create-clusterrole-pod-reader
    set name "pod-reader"
    set verbs "get list watch"
    set resources "pods"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
rules:
  - apiGroups: [\"\"]  # core API group
    resources: [\"$resources\"]
    verbs: [\"get\", \"list\", \"watch\"]" > clusterrole-pod-reader.yaml

    set_color FFAD8D
    echo -n 'clusterrole-pod-reader.yaml created'
    set_color normal
    echo ''
    cat clusterrole-pod-reader.yaml
    
end



function create-clusterrole-pod-reader-names
    set name "pod-reader"
    set verbs "get"
    set resources "pods"
    set resource_names "readablepod anotherpod"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
rules:
  - apiGroups: [\"\"]  # core API group
    resources: [\"$resources\"]
    resourceNames:
$(for r in (string split " " $resource_names); echo "    - $r"; end)
    verbs: [\"$verbs\"]" > clusterrole-pod-reader-names.yaml

    set_color FFAD8D
    echo -n 'clusterrole-pod-reader-names.yaml created'
    set_color normal
    echo ''
    cat clusterrole-pod-reader-names.yaml
end

function create-clusterrole-foo-apigroup
    set name "foo"
    set verbs "get list watch"
    set api_group "apps"
    set resources "rs"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
rules:
  - apiGroups: [\"$api_group\"]
    resources: [\"$resources\"]
    verbs: [\"get\", \"list\", \"watch\"]" > clusterrole-foo-apigroup.yaml

    set_color FFAD8D
    echo -n 'clusterrole-foo-apigroup.yaml created'
    set_color normal
    echo ''
    cat clusterrole-foo-apigroup.yaml
end

function create-clusterrole-foo-subresource
    set name "foo"
    set verbs "get list watch"
    set resources "pods pods/status"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
rules:
  - apiGroups: [\"\"]  # core API group
    resources:
$(for r in (string split " " $resources); echo "    - $r"; end)
    verbs:
$(for v in (string split " " $verbs); echo "    - $v"; end)" > clusterrole-foo-subresource.yaml

    set_color FFAD8D
    echo -n 'clusterrole-foo-subresource.yaml created'
    set_color normal
    echo ''
    cat clusterrole-foo-subresource.yaml
end

function create-clusterrole-foo-nonresourceurl
    set name "foo"
    set verbs "get"
    set non_resource_url "/logs/*"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
rules:
  - nonResourceURLs: [\"$non_resource_url\"]
    verbs: [\"$verbs\"]" > clusterrole-foo-nonresourceurl.yaml

    set_color FFAD8D
    echo -n 'clusterrole-foo-nonresourceurl.yaml created'
    set_color normal
    echo ''
    cat clusterrole-foo-nonresourceurl.yaml
end

function create-clusterrole-monitoring
    set name "monitoring"
    set aggregation_label "rbac.example.com/aggregate-to-monitoring=true"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $name
aggregationRule:
  clusterRoleSelectors:
    - matchLabels:
        $aggregation_label" > clusterrole-monitoring.yaml

    set_color FFAD8D
    echo -n 'clusterrole-monitoring.yaml created'
    set_color normal
    echo ''
    cat clusterrole-monitoring.yaml
end


function create-role
    set namespace "infrustucture"
    set name "role-example"
    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: $name
  namespace: $namespace
rules:
  - apiGroups: [\"\"]  # core API group
    resources: [\"pods\", \"deployments\", \"services\"]
    verbs: [\"get\", \"list\", \"watch\", \"create\", \"update\", \"patch\", \"delete\"]" > role-template.yaml

    echo -n ''
    set_color FFAD8D
    echo -n 'role-template.yaml created'
    set_color normal
    echo ''
    cat role-template.yaml
end

function create-role-readonly
    set role_name "read-only"
    set namespace "default"
    set api_group1 ""
    set resources1 "pods services"
    set verbs1 "list get watch"
    set api_group2 "apps"
    set resources2 "deployments"
    set verbs2 "list get watch"
    set output_file "role-readonly-template.yaml"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: $role_name
  namespace: $namespace
rules:
- apiGroups:
  - \"$api_group1\"
  resources:
$(for r in (string split " " $resources1); echo "  - $r"; end)
  verbs:
$(for v in (string split " " $verbs1); echo "  - $v"; end)
- apiGroups:
  - \"$api_group2\"
  resources:
$(for r in (string split " " $resources2); echo "  - $r"; end)
  verbs:
$(for v in (string split " " $verbs2); echo "  - $v"; end)
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-rolebinding-readonly
    set namespace "default"
    set rolebinding_name "read-only-binding"
    set role_name "read-only"
    set subject_kind "User"
    set subject_name "captainua"
    set api_group "rbac.authorization.k8s.io"
    set output_file "rolebinding-readonly-template.yaml"

    echo "apiVersion: $api_group/v1
kind: RoleBinding
metadata:
  name: $rolebinding_name
  namespace: $namespace
roleRef:
  apiGroup: $api_group
  kind: Role
  name: $role_name
subjects:
- apiGroup: $api_group
  kind: $subject_kind
  name: $subject_name
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-clusterrolebinding-multiuser
    set name "cluster-admin-binding"
    set clusterrole "cluster-admin"
    set users "user1 user2"
    set groups "group1 group2"
    set output_file "clusterrolebinding-multi.yaml"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $name
subjects:" > $output_file

    for u in (string split " " $users)
        echo "  - kind: User
    name: $u" >> $output_file
    end

    for g in (string split " " $groups)
        echo "  - kind: Group
    name: $g" >> $output_file
    end

    echo "roleRef:
  kind: ClusterRole
  name: $clusterrole
  apiGroup: rbac.authorization.k8s.io" >> $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-rolebinding-user
    set namespace "infrustucture"
    set name "rolebinding-example"
    set role "role-example"
    set user "user"
    set group "group"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: $name
  namespace: $namespace
subjects:
  - kind: User
    name: $user
  - kind: Group
    name: $group
roleRef:
  kind: Role
  name: $role
  apiGroup: rbac.authorization.k8s.io
" > rolebinding-template.yaml

    echo -n ''
    set_color FFAD8D
    echo -n 'rolebinding-template.yaml created'
    set_color normal
    echo ''
    cat rolebinding-template.yaml
end



function create-rolebinding-sa
    set namespace "infrustucture"
    set binding_name "rolebinding-example-sa"
    set role_name "role-example-sa"
    set sa_name "my-serviceaccount"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: $binding_name
  namespace: $namespace
subjects:
  - kind: ServiceAccount
    name: $sa_name
    namespace: $namespace
roleRef:
  kind: Role
  name: $role_name
  apiGroup: rbac.authorization.k8s.io
" > rolebinding-template-sa.yaml

    echo -n ''
    set_color FFAD8D
    echo -n 'rolebinding-template-sa.yaml created'
    set_color normal
    echo ''
    cat rolebinding-template-sa.yaml
end


function create-clusterrole
    set role_name "clusterrole-example"
    set verbs "get,list,watch"
    set resources "pods"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $role_name
rules:
  - apiGroups: [\"\"] 
    resources: [\"$resources\"] 
    verbs: [\"get\", \"list\", \"watch\"]
" > clusterrole-template.yaml

    echo -n ''
    set_color FFAD8D
    echo -n 'clusterrole-template.yaml created'
    set_color normal
    echo ''

    echo ''
    cat clusterrole-template.yaml
end



function create-clusterrolebinding-user
    set name "clusterrolebinding-example-user"
    set user "user"
    set group "group"
    set role_name "clusterrole-example"
    set output_file "clusterrolebinding-template-user.yaml"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $name
subjects:
  - kind: User
    name: $user
  - kind: Group
    name: $group
roleRef:
  kind: ClusterRole
  name: $role_name
  apiGroup: rbac.authorization.k8s.io
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-clusterrolebinding-sa
    set name "clusterrolebinding-example-sa"
    set sa_name "my-serviceaccount"
    set sa_namespace "infrustucture"
    set role_name "clusterrole-example"
    set output_file "clusterrolebinding-template-sa.yaml"

    echo "apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: $name
subjects:
  - kind: ServiceAccount
    name: $sa_name
    namespace: $sa_namespace
roleRef:
  kind: ClusterRole
  name: $role_name
  apiGroup: rbac.authorization.k8s.io
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-resourcequota
    set quota_name "quotas-ns"
    set namespace "quotas-ns"
    set requests_cpu "1"
    set requests_memory "1Gi"
    set limits_cpu "2"
    set limits_memory "2Gi"
    set output_file "resourcequota-template.yaml"

    echo "apiVersion: v1
kind: ResourceQuota
metadata:
  name: $quota_name
  namespace: $namespace
spec:
  hard:
    requests.cpu: \"$requests_cpu\"
    requests.memory: $requests_memory
    limits.cpu: \"$limits_cpu\"
    limits.memory: $limits_memory
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



 function create-limitrange
    set limitrange_name "ns-memory-limit"
    set namespace "limitrange"
    set max_memory "500Mi"
    set max_cpu "200m"
    set min_memory "100Mi"
    set min_cpu "200m"
    set limit_type "Container"
    set output_file "limitrange-template.yaml"

    echo "apiVersion: v1
kind: LimitRange
metadata:
  name: $limitrange_name
  namespace: $namespace
spec:
  limits:
  - max:  # max and min define the limit range
      memory: \"$max_memory\"
      cpu: \"$max_cpu\"
    min:
      memory: \"$min_memory\"
      cpu: \"$min_cpu\"
    type: $limit_type
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''

    echo ''
    cat $output_file
end
 
function create-storageclass
    set storageclass_name "local-storage"
    set provisioner "kubernetes.io/no-provisioner"
    set volume_binding_mode "WaitForFirstConsumer"
    set output_file "storageclass-template.yaml"

    echo "apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: $storageclass_name
provisioner: $provisioner
volumeBindingMode: $volume_binding_mode
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-persistentvolume
    set pv_name "pv-log"
    set reclaim_policy "Retain"
    set access_mode "ReadWriteMany"
    set storage_capacity "100Mi"
    set hostpath "/pv/log"
    set output_file "persistentvolume-template.yaml"

    echo "apiVersion: v1
kind: PersistentVolume
metadata:
  name: $pv_name
spec:
  persistentVolumeReclaimPolicy: $reclaim_policy
  accessModes:
    - $access_mode
  capacity:
    storage: $storage_capacity
  hostPath:
    path: $hostpath
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-cm-from-folder
    set name "my-config"
    set folder_path "path/to/bar"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $name
data:" > configmap-from-folder.yaml

    for f in (ls $folder_path 2>/dev/null)
        set key (basename $f)
        echo "  $key: |" >> configmap-from-folder.yaml
        sed 's/^/    /' "$folder_path/$f" >> configmap-from-folder.yaml
    end

    set_color FFAD8D
    echo "configmap-from-folder.yaml created"
    set_color normal
end


function create-cm-with-keys
    set name "my-config"
    set file1 "/path/to/bar/file1.txt"
    set file2 "/path/to/bar/file2.txt"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $name
data:
  key1: |-
$(sed 's/^/    /' $file1)
  key2: |-
$(sed 's/^/    /' $file2)" > configmap-with-keys.yaml

    set_color FFAD8D
    echo "configmap-with-keys.yaml created"
    set_color normal
end

function create-cm-literals
    set name "my-config"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $name
data:
  key1: \"config1\"
  key2: \"config2\"" > configmap-literals.yaml

    set_color FFAD8D
    echo "configmap-literals.yaml created"
    set_color normal
end

function create-cm-from-env
    set name "my-config"
    set env1 "/path/to/foo.env"
    set env2 "/path/to/bar.env"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $name
data:" > configmap-from-env.yaml

    for env_file in $env1 $env2
        if test -f $env_file
            grep -v '^#' $env_file | grep '=' | while read line
                set key (echo $line | cut -d'=' -f1)
                set value (echo $line | cut -d'=' -f2-)
                echo "  $key: \"$value\"" >> configmap-from-env.yaml
            end
        end
    end

    set_color FFAD8D
    echo "configmap-from-env.yaml created"
    set_color normal
end


function create-cm-literal
    set cm_name "my-cm"
    set namespace "prod"
    set username "username"
    set password "MyPasswd"
    set host "localhost"
    set output_file "configmap-literal-template.yaml"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $cm_name
  namespace: $namespace
data:
  username: \"$username\"
  password: \"$password\"
  host: \"$host\"
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-cm-from-file
    set cm_name "app-config"
    set namespace "staging"
    set config_file "app.conf"
    set output_file "configmap-from-file-template.yaml"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $cm_name
  namespace: $namespace
data:
  app.conf: |
$(cat $config_file | sed 's/^/    /')
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (from file: $config_file)"
    set_color normal
    echo ''
    cat $output_file
end


function create-cm-app-settings
    set cm_name "app-settings"
    set namespace "dev"
    set app_port "8080"
    set log_level "info"
    set db_url "postgres://user:pass@localhost:5432/db"
    set output_file "configmap-app-settings-template.yaml"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $cm_name
  namespace: $namespace
data:
  APP_PORT: \"$app_port\"
  LOG_LEVEL: \"$log_level\"
  DATABASE_URL: \"$db_url\"
" > $output_file

    echo -n ' '
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-cm-nginx
    set cm_name "nginx-config"
    set namespace "web"
    set output_file "configmap-nginx-template.yaml"

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $cm_name
  namespace: $namespace
data:
  nginx.conf: |
    events {}
    http {
      server {
        listen 80;
        location / {
          return 200 'Hello from Nginx ConfigMap!';
        }
      }
    }
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-cm-binary
    set cm_name "cert-config"
    set namespace "security"
    set cert_key_name "tls.key"
    set cert_crt_name "tls.crt"
    set output_file "configmap-binary-template.yaml"
    set cert_key_base64 (echo "-----BEGIN PRIVATE KEY-----\nFAKEKEYDATA\n-----END PRIVATE KEY-----" | base64 | tr -d '\n')
    set cert_crt_base64 (echo "-----BEGIN CERTIFICATE-----\nFAKECERTDATA\n-----END CERTIFICATE-----" | base64 | tr -d '\n')

    echo "apiVersion: v1
kind: ConfigMap
metadata:
  name: $cm_name
  namespace: $namespace
binaryData:
  $cert_key_name: \"$cert_key_base64\"
  $cert_crt_name: \"$cert_crt_base64\"
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created with binaryData"
    set_color normal
    echo ''
    echo ''
    cat $output_file
end


function create-persistentvolumeclaim
    set pvc_name "local-pvc"
    set access_mode "ReadWriteOnce"
    set storage_class "local-storage"
    set storage_request "500Mi"
    set output_file "persistentvolumeclaim-template.yaml"

    echo "apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: $pvc_name
spec:
  accessModes:
    - $access_mode
  storageClassName: $storage_class
  resources:
    requests:
      storage: $storage_request
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''

    echo ''
    cat $output_file
end


function create-networkpolicy-deny-all
    set name "deny-all"
    set namespace "monitoring"
    set policy_types "Ingress,Egress"
    set output_file "networkpolicy-deny-all.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
$(for type in (string split "," $policy_types); echo "  - $type"; end)
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-networkpolicy-api-allow
    set name "api-allow"
    set namespace "default"
    set pod_label_key "run"
    set pod_label_value "my-app"
    set from_label_key "run"
    set from_label_value "app2"
    set output_file "networkpolicy-api-allow.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $name
  namespace: $namespace
spec:
  podSelector:
    matchLabels:
      $pod_label_key: $pod_label_value
  ingress:
  - from:
    - podSelector:
        matchLabels:
          $from_label_key: $from_label_value
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-networkpolicy-allow-all
    set name "allow-all"
    set namespace "default"
    set policy_types "Ingress,Egress"
    set output_file "networkpolicy-allow-all.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
$(for type in (string split "," $policy_types); echo "  - $type"; end)
  ingress: {}
  egress: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-networkpolicy-deny-ingress-only
    set name "deny-ingress-only"
    set namespace "monitoring"
    set policy_types "Ingress"
    set output_file "networkpolicy-deny-ingress-only.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
$(for type in (string split "," $policy_types); echo "  - $type"; end)
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-networkpolicy-deny-egress-only
    set name "deny-egress-only"
    set namespace "monitoring"
    set policy_types "Egress"
    set output_file "networkpolicy-deny-egress-only.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
$(for type in (string split "," $policy_types); echo "  - $type"; end)
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deny-all-allow-metadata-access
    set policy_name "deny-all-allow-metadata-access"
    set namespace "monitoring"
    set cidr "0.0.0.0/0"
    set except_cidr "1.1.1.1/32"
    set output_file "networkpolicy-deny-all-allow-metadata-access.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: $cidr
        except:
        - $except_cidr
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deny-all-allow-metadata-access
    set policy_name "deny-all-allow-metadata-access"
    set namespace "monitoring"
    set cidr "0.0.0.0/0"
    set except_cidr "1.1.1.1/32 2.2.2.2/32 3.3.3.3/32"
    set output_file "networkpolicy-deny-all-allow-metadata-access.yaml"

    set except_yaml "        except:"
    for except in $except_cidr
        set except_yaml "$except_yaml
        - $except"
    end

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: $cidr
$except_yaml
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-cross-namespace-networkpolicy-multi
    set policy_name "cross-ns-policy"
    set namespace "monitoring"
    set ingress_namespaces "app-space logging-space"
    set egress_namespaces "app-space logging-space"
    set output_file "networkpolicy-cross-ns-multi.yaml"

    set ingress_yaml "ingress:"
    for ns in $ingress_namespaces
        set ingress_yaml "$ingress_yaml
  - from:
    - namespaceSelector:
        matchLabels:
          name: $ns"
    end

    set egress_yaml "egress:"
    for ns in $egress_namespaces
        set egress_yaml "$egress_yaml
  - to:
    - namespaceSelector:
        matchLabels:
          name: $ns"
    end

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
$ingress_yaml
$egress_yaml
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-crossNamespace-networkpolicy-multi1
    set policy_name "cross-ns-policy"
    set namespace "monitoring"
    set ingress_namespaces "app-space logging-space"
    set egress_namespaces "app-space logging-space"
    set ingress_ports "80 443"
    set egress_ports "53"
    set protocol "TCP"
    set output_file "networkpolicy-cross-ns-multi.yaml"
    set ingress_yaml "ingress:"
    for ns in $ingress_namespaces
        set ingress_yaml "$ingress_yaml
  - from:
    - namespaceSelector:
        matchLabels:
          name: $ns
    ports:"
        for port in $ingress_ports
            set ingress_yaml "$ingress_yaml
      - protocol: $protocol
        port: $port"
        end
    end

    set egress_yaml "egress:"
    for ns in $egress_namespaces
        set egress_yaml "$egress_yaml
  - to:
    - namespaceSelector:
        matchLabels:
          name: $ns
    ports:"
        for port in $egress_ports
            set egress_yaml "$egress_yaml
      - protocol: $protocol
        port: $port"
        end
    end

    echo "# NetworkPolicy $policy_name for cross-namespace ingress & egress
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
$ingress_yaml
$egress_yaml
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-crossNamespace-networkpolicy-multi2
    set policy_name "cross-ns-policy"
    set namespace "monitoring"
    set ingress_namespaces "app-space logging-space"
    set egress_namespaces "app-space logging-space"
    set ingress_ports "80 443"
    set egress_ports "53"
    set protocol "TCP"

    set output_file "networkpolicy-cross-ns-multi.yaml"

    set ingress_yaml "ingress:"
    for ns in $ingress_namespaces
        set ingress_yaml "$ingress_yaml
  - from:
    - namespaceSelector:
        matchLabels:
          name: $ns"
        if test (count $ingress_ports) -gt 0
            set ingress_yaml "$ingress_yaml
    ports:"
            for port in $ingress_ports
                set ingress_yaml "$ingress_yaml
      - protocol: $protocol
        port: $port"
            end
        end
    end

    set egress_yaml "egress:"
    for ns in $egress_namespaces
        set egress_yaml "$egress_yaml
  - to:
    - namespaceSelector:
        matchLabels:
          name: $ns"
        if test (count $egress_ports) -gt 0
            set egress_yaml "$egress_yaml
    ports:"
            for port in $egress_ports
                set egress_yaml "$egress_yaml
      - protocol: $protocol
        port: $port"
            end
        end
    end

    echo "# NetworkPolicy $policy_name for cross-namespace ingress & egress
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
$ingress_yaml
$egress_yaml
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



 function create-networkpolicy-multiPortEgress
    set policy_name "multi-port-egress"
    set namespace "default"
    set pod_label_key "role"
    set pod_label_value "db"
    set ipblock_cidr "10.0.0.0/24"
    set port_protocol "TCP"
    set port_start 32000
    set port_end 32768
    set output_file "networkpolicy.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector:
    matchLabels:
      $pod_label_key: $pod_label_value
  policyTypes:
    - Egress
  egress:
    - to:
        - ipBlock:
            cidr: $ipblock_cidr
      ports:
        - protocol: $port_protocol
          port: $port_start
          endPort: $port_end
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file

end


function create-egress-policymultiple-namespaces
    set policy_name "egress-namespaces"
    set namespace "default"
    set pod_label_key "app"
    set pod_label_value "myapp"
    set ns_selector_key "namespace"
    set ns_operator "In"
    set ns_values "frontend backend" # пробіл-розділений список namespace
    set output_file "networkpolicy-egress-namespaces.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: $policy_name
  namespace: $namespace
spec:
  podSelector:
    matchLabels:
      $pod_label_key: $pod_label_value
  policyTypes:
  - Egress
  egress:
  - to:
    - namespaceSelector:
        matchExpressions:
        - key: $ns_selector_key
          operator: $ns_operator
          values: ["$(string join '", "' $ns_values)"]
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-csr-yaml
    set username "iuser@internal.users"
    set key_file "iuser.key"
    set csr_file "iuser.csr"
    set csr_b64 ""
    set output_file "csr-$username.yaml"
    openssl genrsa -out $key_file 2048
    openssl req -new -key $key_file -out $csr_file -subj "/CN=$username"
    set csr_b64 (cat $csr_file | base64 -w 0)

    echo "apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $username
spec:
  groups:
    - system:authenticated
  request: $csr_b64
  signerName: kubernetes.io/kube-apiserver-client
  usages:
    - client auth
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-csr-and-config
    set username "iuser@internal.users"
    set key_file "iuser.key"
    set csr_file "iuser.csr"
    set crt_file "iuser.crt"
    set ca_cert "/etc/kubernetes/pki/ca.crt"
    set ca_key "/etc/kubernetes/pki/ca.key"
    set days_valid "500"
    set cluster_name "kubernetes"
    set context_name $username
    set kubeconfig "$HOME/.kube/config"

    openssl genrsa -out $key_file 2048
    openssl req -new -key $key_file -out $csr_file -subj "/CN=$username"
    openssl x509 -req -in $csr_file -CA $ca_cert -CAkey $ca_key -CAcreateserial -out $crt_file -days $days_valid

    kubectl config set-credentials $username --client-key=$key_file --client-certificate=$crt_file --kubeconfig=$kubeconfig
    kubectl config set-context $context_name --cluster=$cluster_name --user=$username --kubeconfig=$kubeconfig

    kubectl config get-contexts --kubeconfig=$kubeconfig
    kubectl config use-context $context_name --kubeconfig=$kubeconfig

    echo "CSR, сертифікат та kubectl контекст створені для користувача $username"
end


function create-pod-with-dns1
    set pod_name "dns-example"
    set namespace "default"
    set container_name "test"
    set container_image "nginx"
    set dns_policy "None"
    set nameservers "192.0.2.1"
    set searches "ns1.svc.cluster-domain.example my.dns.search.suffix"
    set options "ndots=2 edns0"
    set output_file "pod-with-dns.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  namespace: $namespace
  name: $pod_name
spec:
  containers:
  - name: $container_name
    image: $container_image
  dnsPolicy: \"$dns_policy\"
  dnsConfig:
    nameservers:
    - $nameservers
    searches:
$(for s in $searches
    echo "      - $s"
end)
    options:
$(for opt in $options
    echo "      - name: (string split '=' $opt)[1]; value: (string split '=' $opt)[2]"
end)
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-with-dns2
    set pod_name "dns-example"
    set namespace "default"
    set container_name "test"
    set container_image "nginx"
    set dns_policy "None"
    set nameservers "192.0.2.1" "8.8.8.8"
    set searches "ns1.svc.cluster-domain.example" "my.dns.search.suffix"
    set options "ndots=2" "edns0"
    set output_file "pod-with-dns.yaml"
 
    echo "apiVersion: v1
kind: Pod
metadata:
  namespace: $namespace
  name: $pod_name
spec:
  containers:
  - name: $container_name
    image: $container_image
  dnsPolicy: \"$dns_policy\"
  dnsConfig:
    nameservers:" > $output_file

    for ns in $nameservers
        echo "    - $ns" >> $output_file
    end

    echo "    searches:" >> $output_file
    for search in $searches
        echo "    - $search" >> $output_file
    end

    echo "    options:" >> $output_file
    for opt in $options
        if string match -r "=" $opt
            set opt_name (string split "=" $opt)[1]
            set opt_value (string split "=" $opt)[2]
            echo "    - name: $opt_name" >> $output_file
            echo "      value: \"$opt_value\"" >> $output_file
        else
            echo "    - name: $opt" >> $output_file
        end
    end
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-securityContext
    set pod_name "sec-con-pod"
    set namespace "default"
    set label_run "sec-con-pod"
    set container_name "sec-con-pod"
    set container_image "redis"
    set run_as_user "1000"
    set run_as_group "1000"
    set run_as_non_root "true"
    set output_file "secure-pod-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
  namespace: $namespace
spec:
  securityContext:
    runAsUser: $run_as_user
    runAsGroup: $run_as_group
    runAsNonRoot: $run_as_non_root
  containers:
  - image: $container_image
    name: $container_name
    securityContext:
      runAsUser: $run_as_user
      runAsGroup: $run_as_group
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-secure-capabilities
    set pod_name "sec-capa-pod"
    set namespace "default"
    set label_run "sec-capa-pod"
    set container_name "sec-capa-pod"
    set container_image "redis"
    set run_as_user "1000"
    set run_as_group "1000"
    set capabilities_add "MAC_ADMIN,SYS_ADMIN"
    set output_file "secure-capabilities-pod-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
  namespace: $namespace
spec:
  containers:
  - image: $container_image
    name: $container_name
    resources: {}
    securityContext:
      runAsUser: $run_as_user
      runAsGroup: $run_as_group
      capabilities:
        add: [\"(string join \"\", (string split \",\" $capabilities_add))\"]
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-automountServiceAccountToken
    set sa_name "build-robot"
    set sa_namespace "default"
    set pod_name "cks-pod"
    set pod_namespace "default"
    set ns_name "default"
    set ns_label "default"
    set output_file "serviceaccount-pod-namespace.yaml"
    echo "--- 
apiVersion: v1
kind: ServiceAccount
automountServiceAccountToken: false
metadata:
  name: $sa_name
  namespace: $sa_namespace

---
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  serviceAccountName: $sa_namespace
  automountServiceAccountToken: false

---
apiVersion: v1
kind: Namespace
metadata:
  labels:
    kubernetes.io/metadata.name: $ns_label
  name: $ns_name
automountServiceAccountToken: false
spec:
  finalizers:
    - kubernetes
status:
  phase: Active
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-with-seccomp
    set pod_name "app1"
    set pod_namespace "app1"
    set container_image "nginx"
    set container_name "app1"
    set seccomp_profile_type "Localhost"
    set seccomp_profile_local "custom.json"
    set output_file "pod-seccomp.yaml"
    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $pod_namespace
spec:
  containers:
  - image: $container_image
    name: $container_name
    securityContext:
      seccompProfile:
        type: $seccomp_profile_type
        localhostProfile: $seccomp_profile_local
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-with-apparmor
    set pod_name "pod-with-apparmor"
    set security_apparmor_type "Localhost"
    set security_apparmor_profile "docker-default"
    set container_name "hello"
    set container_image "busybox:1.28"
    set container_command "sh -c \"echo 'Hello AppArmor!' && sleep 1h\""
    set output_file "pod-apparmor.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  securityContext:
    appArmorProfile:
      type: $security_apparmor_type
      localhostProfile: $security_apparmor_profile
  containers:
  - name: $container_name
    image: $container_image
    command: [ $container_command ]
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-allowPrivilegeEscalation
    set pod_name "application"
    set pod_namespace "sun"
    set pod_label "my-ro-pod"
    set container_name "my-ro-pod"
    set container_image "busybox:1.32.0"
    set container_command "sh -c sleep 1d"
    set allow_privilege_escalation "false"
    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-with-securitycontext.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: $pod_label
  name: $pod_name
  namespace: $pod_namespace
spec:
  containers:
  - command:
    - sh
    - -c
    - sleep 1d
    image: $container_image
    name: $container_name
    securityContext:
      allowPrivilegeEscalation: $allow_privilege_escalation
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-with-secOptions
    set pod_name "ziflechage"
    set namespace "default"
    set label_key "run"
    set label_value "ziflechage"
    set container_name "ziflechage"
    set container_image "ghcr.io/adfinis/potz-holzoepfel-und-zipfelchape"
    set container_port "8080"
    set restart_policy "Never"
    set output_file "pod-secure.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    $label_key: $label_value
  name: $pod_name
  namespace: $namespace
spec:
  securityContext:
    runAsNonRoot: true
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: $container_name
      image: $container_image
      ports:
        - containerPort: $container_port
      resources: {}
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop:
            - \"ALL\"
  dnsPolicy: ClusterFirst
  restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-privileged
    set pod_name "privileged-pod"
    set pod_namespace "default"
    set pod_label "privileged-pod"
    set container_name "privileged-pod"
    set container_image "nginx:alpine"
    set container_command "sh -c sleep 1d"
    set privileged "true"
    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-privileged.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: $pod_label
  name: $pod_name
  namespace: $pod_namespace
spec:
  containers:
  - command:
    - sh
    - -c
    - sleep 1d
    image: $container_image
    name: $container_name
    securityContext:
      privileged: $privileged
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-nonRoot
    set pod_name "non-root-pod"
    set pod_namespace "default"
    set pod_label "non-root-pod"
    set container_name "non-root-pod"
    set container_image "nginx:alpine"
    set run_as_non_root "false"
    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-non-root.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: $pod_label
  name: $pod_name
  namespace: $pod_namespace
spec:
  containers:
  - image: $container_image
    name: $container_name
    securityContext:
      runAsNonRoot: $run_as_non_root
    resources: {}
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-runAsUser
    set pod_name "run-as-user-pod"
    set pod_namespace "default"
    set pod_label "run-as-user-pod"
    set container_name "run-as-user-pod"
    set container_image "nginx:alpine"
    set run_as_user "1001"
    set run_as_group "1001"
    set allow_privilege_escalation "false"
    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-run-as-user.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: $pod_label
  name: $pod_name
  namespace: $pod_namespace
spec:
  securityContext:
    runAsUser: $run_as_user
    runAsGroup: $run_as_group
  containers:
  - image: $container_image
    name: $container_name
    resources: {}
    securityContext:
      allowPrivilegeEscalation: $allow_privilege_escalation
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-audit-policy
    set api_version "audit.k8s.io/v1"
    set policy_kind "Policy"
    set omit_stages "RequestReceived"
    set rule1_level "Metadata"
    set rule1_namespaces "prod"
    set rule1_verbs "create"
    set rule1_group "" # core
    set rule1_resources "pods"
    set rule2_level "Request"
    set rule2_group1 "" # core API group
    set rule2_group2 "extensions"
    set rule3_level "RequestResponse"
    set rule3_group "" # core
    set rule3_resources "pods"
    set rule4_level "None"
    set output_file "audit-policy.yaml"

    echo "--- 
apiVersion: $api_version
kind: $policy_kind
omitStages:
- \"$omit_stages\"
rules:
- level: $rule1_level
  namespaces: [\"$rule1_namespaces\"]
  verbs: [\"$rule1_verbs\"]
  resources:
  - group: \"$rule1_group\"
    resources: [\"$rule1_resources\"]
- level: $rule2_level
  resources:
  - group: \"$rule2_group1\"
  - group: \"$rule2_group2\"
- level: $rule3_level
  resources:
  - group: \"$rule3_group\"
    resources: [\"$rule3_resources\"]
- level: $rule4_level
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-readonlyroot
    set pod_name "application"
    set namespace "sun"
    set label_key "run"
    set label_value "my-ro-pod"
    set container_name "my-ro-pod"
    set container_image "busybox:1.32.0"
    set command "sh -c sleep 1d"
    set output_file "pod-readonlyroot.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  labels:
    $label_key: $label_value
  name: $pod_name
  namespace: $namespace
spec:
  containers:
  - command:
    - sh
    - -c
    - sleep 1d
    image: $container_image
    name: $container_name
    securityContext:
      readOnlyRootFilesystem: true
  dnsPolicy: ClusterFirst
  restartPolicy: Always
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod
    set pod_name "pod-example"
    set namespace "dev-namespace"
    set app_label "pod-example"
    set env_label "dev"
    set container_name "nginx-container"
    set image "nginx"
    set command "/bin/sh -c 'echo Hello from pod && sleep 3600'"
    set container_port "80"
    set cpu_limit "500m"
    set memory_limit "256Mi"
    set cpu_request "250m"
    set memory_request "128Mi"
    set service_account "i-service-account"
    set output_file "pod-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    app: $app_label
    env: $env_label
spec:
  serviceAccountName: $service_account
  containers:
    - name: $container_name
      image: $image
      command:
        - /bin/sh
        - -c
        - echo Hello from pod && sleep 3600
      ports:
        - containerPort: $container_port
      resources:
        limits:
          cpu: \"$cpu_limit\"
          memory: \"$memory_limit\"
        requests:
          cpu: \"$cpu_request\"
          memory: \"$memory_request\"
  restartPolicy: Never
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-with-pvc
    set pod_name "nginx"
    set pod_label "nginx"
    set container_name "nginx"
    set container_image "nginx:alpine"
    set volume_name "local-persistent-storage"
    set mount_path "/var/www/html"
    set pvc_claim_name "local-pvc"
    set output_file "pod-with-pvc-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    name: $pod_label
spec:
  containers:
  - name: $container_name
    image: $container_image
    volumeMounts:
      - name: $volume_name
        mountPath: $mount_path
  volumes:
    - name: $volume_name
      persistentVolumeClaim:
        claimName: $pvc_claim_name
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-with-init
    set pod_name "myapp-pod"
    set app_label "myapp"
    set container_name "myapp-container"
    set container_image "busybox:1.28"
    set container_command "['sh', '-c', 'echo The app is running! && sleep 3600']"
    set init1_name "init-myservice"
    set init1_image "busybox:1.28"
    set init1_command "['sh', '-c', 'until nslookup myservice; do echo waiting for myservice; sleep 2; done;']"
    set init2_name "init-mydb"
    set init2_image "busybox:1.28"
    set init2_command "['sh', '-c', 'until nslookup mydb; do echo waiting for mydb; sleep 2; done;']"
    set output_file "pod-with-init-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    app: $app_label
spec:
  containers:
  - name: $container_name
    image: $container_image
    command: $container_command
  initContainers:
  - name: $init1_name
    image: $init1_image
    command: $init1_command
  - name: $init2_name
    image: $init2_image
    command: $init2_command
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-with-adapter
    set pod_name "webserver-1"
    set app_label "webserver"
    set volume_name "nginx-conf"
    set configmap_name "nginx-conf"
    set configmap_key "default.conf"
    set configmap_path "default.conf"
    set container1_name "webserver"
    set container1_image "nginx"
    set container1_port 80
    set container2_name "adapter"
    set container2_image "nginx/nginx-prometheus-exporter:0.4.2"
    set container2_args '["-nginx.scrape-uri","http://localhost/nginx_status"]'
    set container2_port 9113
    set output_file "pod-with-volumes-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    app: $app_label
spec:
  volumes:
    - name: $volume_name
      configMap:
        name: $configmap_name
        items:
          - key: $configmap_key
            path: $configmap_path
  containers:
    - name: $container1_name
      image: $container1_image
      ports:
        - containerPort: $container1_port
      volumeMounts:
        - mountPath: /etc/nginx/conf.d
          name: $volume_name
          readOnly: true
    - name: $container2_name
      image: $container2_image
      args: $container2_args
      ports:
        - containerPort: $container2_port
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-with-sidecar
    set pod_name "pod-with-sidecar"
    set volume_name "shared-logs"
    set app_container_name "app-container"
    set app_image "alpine"
    set app_command "/bin/sh"
    set app_args '["-c", "while true; do date >> /var/log/app.txt; sleep 5;done"]'
    set app_mount_path "/var/log"
    set sidecar_container_name "sidecar-container"
    set sidecar_image "nginx:1.7.9"
    set sidecar_port 80
    set sidecar_mount_path "/usr/share/nginx/html"
    set output_file "pod-with-sidecar-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  volumes:
  - name: $volume_name
    emptyDir: {}

  containers:
  - name: $app_container_name
    image: $app_image
    command: [$app_command]
    args: $app_args
    volumeMounts:
    - name: $volume_name
      mountPath: $app_mount_path

  - name: $sidecar_container_name
    image: $sidecar_image
    ports:
      - containerPort: $sidecar_port
    volumeMounts:
    - name: $volume_name
      mountPath: $sidecar_mount_path
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-secret-env
    set pod_name "sec-env-var"
    set label_run "sec-env-var"
    set container_name "sec-env-var"
    set container_image "nginx"
    set secret_name "new-secret"
    set secret_key "user"
    set env_name "new-secret-username"
    set output_file "pod-secret-env-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    env:
    - name: $env_name
      valueFrom:
        secretKeyRef:
          name: $secret_name
          key: $secret_key
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-secret-envfrom
    set pod_name "sec-env-var"
    set label_run "sec-env-var"
    set container_name "sec-env-var"
    set container_image "nginx"
    set secret_name "new-secret"
    set output_file "pod-secret-envfrom-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    envFrom:
    - secretRef:
        name: $secret_name
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-secret-volume
    set pod_name "sec-volume-var"
    set label_run "sec-volume-var"
    set container_name "sec-volume-var"
    set container_image "nginx"
    set secret_name "new-secret"
    set volume_name "new-secret"
    set mount_path "/etc"
    set output_file "pod-secret-volume-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  volumes:
  - name: $volume_name
    secret:
      secretName: $secret_name
  containers:
  - image: $container_image
    name: $container_name
    volumeMounts:
    - name: $volume_name
      mountPath: $mount_path
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (Secret mounted as volume)"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-secret-volume-items
    set pod_name "sec-volume-var"
    set label_run "sec-volume-var"
    set container_name "sec-volume-var"
    set container_image "nginx"
    set secret_name "new-secret"
    set volume_name "new-secret"
    set secret_key "user"
    set file_path "username"
    set mount_path "/etc"
    set output_file "pod-secret-volume-items-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  volumes:
  - name: $volume_name
    secret:
      secretName: $secret_name
      items:
      - key: $secret_key
        path: $file_path
  containers:
  - image: $container_image
    name: $container_name
    volumeMounts:
    - name: $volume_name
      mountPath: $mount_path
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (Secret volume with items)"
    set_color normal
    echo ''
    cat $output_file
end

function create-secret-generic
    set secret_name "new-secret"
    set namespace "default"
    set username "username"
    set password "password"
    set output_file "secret-generic-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: Opaque
stringData:
  user: $username
  password: $password
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-secret-binary
    set secret_name "tls-secret"
    set namespace "default"
    set cert_base64 (echo "-----BEGIN CERTIFICATE-----EXAMPLE-----END CERTIFICATE-----" | base64)
    set key_base64 (echo "-----BEGIN PRIVATE KEY-----EXAMPLE-----END PRIVATE KEY-----" | base64)
    set output_file "secret-binary-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: Opaque
binaryData:
  tls.crt: \"$cert_base64\"
  tls.key: \"$key_base64\"
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-secret-docker
    set secret_name "docker-registry-secret"
    set namespace "default"
    set registry_url "https://index.docker.io/v1/"
    set username "myuser"
    set password "mypassword"
    set email "user@example.com"
    set output_file "secret-docker-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: kubernetes.io/dockerconfigjson
stringData:
  .dockerconfigjson: '{
    \"auths\": {
      \"$registry_url\": {
        \"username\": \"$username\",
        \"password\": \"$password\",
        \"email\": \"$email\",
        \"auth\": \"'\"(printf '%s:%s' $username $password | base64)\"'\"
      }
    }
  }'
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (docker-registry secret)"
    set_color normal
    echo ''
    cat $output_file
end


function create-secret-tls
    set secret_name "tls-secret"
    set namespace "default"
    set tls_crt "base64encodedcert"
    set tls_key "base64encodedkey"
    set output_file "secret-tls-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: kubernetes.io/tls
data:
  tls.crt: $tls_crt
  tls.key: $tls_key
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (TLS secret)"
    set_color normal
    echo ''
    cat $output_file
end

function create-secret-from-files
    set secret_name "file-secret"
    set namespace "default"
    set file1 "config.json"
    set file2 "id_rsa"
    set output_file "secret-from-files-template.yaml"
    set file1_b64 (base64 -w0 $file1 2>/dev/null; or echo "")
    set file2_b64 (base64 -w0 $file2 2>/dev/null; or echo "")

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: Opaque
data:
  $file1: $file1_b64
  $file2: $file2_b64
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (Secret from files)"
    set_color normal
    echo ''
    cat $output_file
end

function create-secret-stringdata-from-files
    set secret_name "file-secret-stringdata"
    set namespace "default"
    set file1 "config.json"
    set file2 "id_rsa"
    set output_file "secret-stringdata-template.yaml"
    set file1_content (cat $file1 2>/dev/null; or echo "")
    set file2_content (cat $file2 2>/dev/null; or echo "")

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: Opaque
stringData:
  $file1: |-
$(echo \"$file1_content\" | sed 's/^/    /')
  $file2: |-
$(echo \"$file2_content\" | sed 's/^/    /')
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (Secret with stringData)"
    set_color normal
    echo ''
    cat $output_file
end

function create-secret-both-data-stringdata
    set secret_name "file-secret-both"
    set namespace "default"
    set output_file "secret-both-template.yaml"
    set files $argv
    if test (count $files) -eq 0
        echo "No files provided. Usage: create-secret-both-data-stringdata file1 file2 ..."
        return 1
    end

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
type: Opaque
data:" > $output_file

    echo "stringData:" >> $output_file

    for file in $files
        if test -f $file
            set content_plain (cat $file)
            set content_base64 (base64 -w0 $file)
            echo "  $file: $content_base64" >> $output_file
            echo "  $file: |-" >> $output_file
            echo "$content_plain" | sed 's/^/    /' >> $output_file
        else
            echo "File not found: $file"
        end
    end

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (Secret with both data and stringData)"
    set_color normal
    echo ''
    cat $output_file
end


function create-encryption-config
    set encryption_file "encryption-template.yaml"
    set encryption_name "encryption-config"
    set key_name "key1"
    set secret_phrase "Secret-ETCD-Encryption"
    set resource_type "secrets"

    set secret_base64 (echo -n $secret_phrase | base64 -w0)
    echo "--- 
apiVersion: apiserver.config.k8s.io/v1
kind: EncryptionConfiguration
metadata:
  name: $encryption_name
resources:
- resources:
  - $resource_type
  providers:
  - aesgcm:
      keys:
      - name: $key_name
        secret: $secret_base64
  - identity: {}
" > $encryption_file

    echo -n ''
    set_color FFAD8D
    echo -n "$encryption_file"
    set_color normal
    echo ''
    cat $encryption_file
end

function create-sa-rolebinding-all-yaml
    set namespace "prod"
    set sa_name "my-custom-sa"
    set clusterrole_name "my-custom-role"
    set verbs "create,delete"
    set resources "deployments"
    set rolebinding_name "my-custom-rb"
    set output_file "sa-rolebinding-template.yaml"

    echo "apiVersion: v1
kind: ServiceAccount
metadata:
  name: $sa_name
  namespace: $namespace
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: $clusterrole_name
rules:
- apiGroups: [\"\"]
  resources: [\"$resources\"]
  verbs: [\"create\", \"delete\"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: $rolebinding_name
  namespace: $namespace
subjects:
- kind: ServiceAccount
  name: $sa_name
  namespace: $namespace
roleRef:
  kind: ClusterRole
  name: $clusterrole_name
  apiGroup: rbac.authorization.k8s.io
" > $output_file

    set_color FFAD8D
    echo " $output_file created (ServiceAccount + ClusterRole + RoleBinding)"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-env-config
    set pod_name "env-pod-vars"
    set label_run "env-pod-vars"
    set namespace "prod"
    set container_name "env-pod-vars"
    set container_image "nginx"
    set volume_name "config-volume"
    set configmap_volume "my-cm2"
    set env_name "password"
    set env_configmap "my-cm"
    set env_key "password"
    set mount_path "/etc"
    set output_file "pod-env-config-keyref-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
  namespace: $namespace
spec:
  volumes:
  - name: $volume_name
    configMap:
      name: $configmap_volume
  containers:
  - image: $container_image
    name: $container_name
    volumeMounts:
    - name: $volume_name
      mountPath: $mount_path
    env:
    - name: $env_name
      valueFrom:
        configMapKeyRef:
          name: $env_configmap
          key: $env_key
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-envfrom-config
    set pod_name "env-pod-vars"
    set label_run "env-pod-vars"
    set namespace "prod"
    set container_name "env-pod-vars"
    set container_image "nginx"
    set volume_name "config-volume"
    set configmap_volume "my-cm2"
    set configmap_env "my-cm"
    set mount_path "/etc"
    set output_file "pod-envfrom-config-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
  namespace: $namespace
spec:
  volumes:
  - name: $volume_name
    configMap:
      name: $configmap_volume
  containers:
  - image: $container_image
    name: $container_name
    volumeMounts:
    - name: $volume_name
      mountPath: $mount_path
    envFrom:
      - configMapRef:
          name: $configmap_env
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created (envFrom configMapRef)"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-readiness-probe-httpGet
    set pod_name "readiness-probe-httpget"
    set label_run "readiness-probe-httpget"
    set container_name "readiness-probe-httpget"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set readiness_path "/"
    set readiness_port 8080
    set initial_delay 2
    set period_seconds 8
    set output_file "pod-readiness-probe-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    readinessProbe:
      httpGet:
        path: $readiness_path
        port: $readiness_port
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function create-pod-readiness-probe-exec
    set pod_name "readiness-probe-exec"
    set label_run "readiness-probe-exec"
    set container_name "readiness-probe-exec"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set exec_command "nc -z -v localhost 8080"
    set initial_delay 5
    set period_seconds 5
    set output_file "pod-readiness-probe-exec-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    readinessProbe:
      exec:
        command:
        - \"nc\"
        - \"-z\"
        - \"-v\"
        - \"localhost\"
        - \"$container_port\"
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-readiness-probe-tcpsocket
    set pod_name "readiness-probe-tcpsocket"
    set label_run "readiness-probe-tcpsocket"
    set container_name "readiness-probe-tcpsocket"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set initial_delay 15
    set period_seconds 10
    set output_file "pod-readiness-probe-tcpsocket-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    readinessProbe:
      tcpSocket:
        port: $container_port
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-liveness-probe-httpget
    set pod_name "liveness-probe-httpget"
    set label_run "liveness-probe-httpget"
    set container_name "liveness-probe-httpget"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set path "/"
    set initial_delay 5
    set period_seconds 30
    set output_file "pod-liveness-probe-httpget-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    livenessProbe:
      httpGet:
        path: $path
        port: $container_port
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
end


function create-pod-liveness-probe-exec
    set pod_name "liveness-probe-exec"
    set label_run "liveness-probe-exec"
    set container_name "liveness-probe-exec"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set exec_command '["nc", "-z", "-v", "localhost", "8080"]'
    set initial_delay 5
    set period_seconds 5
    set output_file "pod-liveness-probe-exec-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    readinessProbe:
      exec:
        command: $exec_command
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
end


function create-pod-liveness-probe-tcpsocket
    set pod_name "liveness-probe-tcpsocket"
    set label_run "liveness-probe-tcpsocket"
    set container_name "liveness-probe-tcpsocket"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set initial_delay 15
    set period_seconds 10
    set output_file "pod-liveness-probe-tcpsocket-template.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: $label_run
  name: $pod_name
spec:
  containers:
  - image: $container_image
    name: $container_name
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    readinessProbe:
      tcpSocket:
        port: $container_port
      initialDelaySeconds: $initial_delay
      periodSeconds: $period_seconds
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
end

function create-pod-startup-probe
    set pod_name "startup-probe-httpget"
    set namespace "default"
    set label_run "startup-probe-httpget"
    set container_name "startup-probe-httpget"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"
    set probe_path "/"
    set probe_initial_delay 3
    set probe_period 15
    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-startup-probe.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    run: $label_run
spec:
  containers:
  - name: $container_name
    image: $container_image
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    startupProbe:
      httpGet:
        path: $probe_path
        port: $container_port
      initialDelaySeconds: $probe_initial_delay
      periodSeconds: $probe_period
    resources: {}
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-startup-probe-exec
    set pod_name "startup-probe-exec"
    set namespace "default"
    set label_run "startup-probe-exec"
    set container_name "startup-probe-exec"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"

    set probe_command "nc -z -v localhost 8080"
    set probe_initial_delay 5
    set probe_period 5

    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-startup-probe-exec.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    run: $label_run
spec:
  containers:
  - name: $container_name
    image: $container_image
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    startupProbe:
      exec:
        command:" > $output_file

    for cmd in (string split " " $probe_command)
        echo "          - \"$cmd\"" >> $output_file
    end
    echo "      initialDelaySeconds: $probe_initial_delay
      periodSeconds: $probe_period
    resources: {}
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
status: {}
" >> $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-startup-probe-tcpsocket
    set pod_name "startup-probe-tcpsocket"
    set namespace "default"
    set label_run "startup-probe-tcpsocket"
    set container_name "startup-probe-tcpsocket"
    set container_image "nginx"
    set container_port 8080
    set container_protocol "TCP"

    set probe_tcp_port 8080
    set probe_initial_delay 15
    set probe_period 10

    set dns_policy "ClusterFirst"
    set restart_policy "Always"
    set output_file "pod-startup-probe-tcpsocket.yaml"

    echo "--- 
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    run: $label_run
spec:
  containers:
  - name: $container_name
    image: $container_image
    ports:
    - containerPort: $container_port
      protocol: $container_protocol
    startupProbe:
      tcpSocket:
        port: $probe_tcp_port
      initialDelaySeconds: $probe_initial_delay
      periodSeconds: $probe_period
    resources: {}
  dnsPolicy: $dns_policy
  restartPolicy: $restart_policy
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-daemonset
    set daemonset_name "fluentd-elasticsearch"
    set namespace "kube-system"
    set label_key "k8s-app"
    set label_value "fluentd-logging"

    set container_name "fluentd-elasticsearch"
    set container_image "quay.io/fluentd_elasticsearch/fluentd:v5.0.1"
    set cpu_request "100m"
    set memory_request "200Mi"
    set memory_limit "200Mi"
    set mount_name "varlog"
    set mount_path "/var/log"
    set host_path "/var/log"
    set termination_grace_seconds 30
    set output_file "daemonset.yaml"

    echo "apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: $daemonset_name
  namespace: $namespace
  labels:
    $label_key: $label_value
spec:
  selector:
    matchLabels:
      name: $daemonset_name
  template:
    metadata:
      labels:
        name: $daemonset_name
    spec:
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
      containers:
      - name: $container_name
        image: $container_image
        resources:
          limits:
            memory: $memory_limit
          requests:
            cpu: $cpu_request
            memory: $memory_request
        volumeMounts:
        - name: $mount_name
          mountPath: $mount_path
      terminationGracePeriodSeconds: $termination_grace_seconds
      volumes:
      - name: $mount_name
        hostPath:
          path: $host_path
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-statefulset-with-service
    # 🔹 Загальні змінні
    set service_name "nginx"
    set service_label_key "app"
    set service_label_value "nginx"
    set service_port 80
    set service_port_name "web"
    set cluster_ip "None"
    set statefulset_name "web"
    set replicas 3
    set min_ready_seconds 10
    set termination_grace_seconds 10
    set container_name "nginx"
    set container_image "registry.k8s.io/nginx-slim:0.24"
    set container_port 80
    set container_port_name "web"
    set volume_name "www"
    set mount_path "/usr/share/nginx/html"
    set storage_class "my-storage-class"
    set storage_request "1Gi"
    set output_file "statefulset-with-service.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  labels:
    $service_label_key: $service_label_value
spec:
  ports:
  - port: $service_port
    name: $service_port_name
  clusterIP: $cluster_ip
  selector:
    $service_label_key: $service_label_value
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: $statefulset_name
spec:
  selector:
    matchLabels:
      $service_label_key: $service_label_value
  serviceName: \"$service_name\"
  replicas: $replicas
  minReadySeconds: $min_ready_seconds
  template:
    metadata:
      labels:
        $service_label_key: $service_label_value
    spec:
      terminationGracePeriodSeconds: $termination_grace_seconds
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
          name: $container_port_name
        volumeMounts:
        - name: $volume_name
          mountPath: $mount_path
  volumeClaimTemplates:
  - metadata:
      name: $volume_name
    spec:
      accessModes: [ \"ReadWriteOnce\" ]
      storageClassName: \"$storage_class\"
      resources:
        requests:
          storage: $storage_request
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-daemonset-fluentd
    set ds_name "fluentd"
    set namespace "kube-system"
    set label_name "fluentd"
    set container_name "fluentd"
    set container_image "fluent/fluentd-kubernetes-daemonset:v1.11.5-debian"
    set volume1_name "varlog"
    set volume1_hostpath "/var/log"
    set volume1_mountpath "/var/log"
    set volume2_name "varlibdockercontainers"
    set volume2_hostpath "/var/lib/docker/containers"
    set volume2_mountpath "/var/lib/docker/containers"
    set output_file "daemonset-fluentd-template.yaml"

    echo "apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: $ds_name
  namespace: $namespace
spec:
  selector:
    matchLabels:
      name: $label_name
  template:
    metadata:
      labels:
        name: $label_name
    spec:
      containers:
      - name: $container_name
        image: $container_image
        volumeMounts:
        - name: $volume1_name
          mountPath: $volume1_mountpath
        - name: $volume2_name
          mountPath: $volume2_mountpath
      volumes:
      - name: $volume1_name
        hostPath:
          path: $volume1_hostpath
      - name: $volume2_name
        hostPath:
          path: $volume2_hostpath
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-crd-operator
    set crd_name "operators.stable.example.com"
    set group "stable.example.com"
    set version_name "v1"
    set scope "Namespaced"
    set plural "operators"
    set singular "operator"
    set kind "Operator"
    set short_name "op"
    set output_file "crd-operator-template.yaml"

    echo "apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: $crd_name
spec:
  group: $group
  versions:
    - name: $version_name
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                email:
                  type: string
                name:
                  type: string
                age:
                  type: integer
  scope: $scope
  names:
    plural: $plural
    singular: $singular
    kind: $kind
    shortNames:
    - $short_name
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-deployment-blue-green1
    set deployment_name "blue-app"
    set app_label "blue-app"
    set env_label "blue"
    set namespace "blue-green"
    set replicas 4
    set container_name "nginx"
    set container_image "nginx:1.19"
    set container_port 80
    set strategy_type "RollingUpdate"
    set max_surge "25%"
    set max_unavailable "25%"
    set output_file "deployment-template.yaml"

    echo "apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: $app_label
    env: $env_label
  name: $deployment_name
  namespace: $namespace
spec:
  replicas: $replicas
  selector:
    matchLabels:
      app: $app_label
  strategy:
    rollingUpdate:
      maxSurge: $max_surge
      maxUnavailable: $max_unavailable
    type: $strategy_type
  template:
    metadata:
      labels:
        app: $app_label
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
        resources: {}
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deployment-blue-green2
    set deployment_name "green-app"
    set deployment_namespace "blue-green"
    set deployment_label_app "green-app"
    set deployment_label_env "green"
    set deployment_replicas "4"
    set container_name "httpd"
    set container_image "httpd:2.4"
    set container_port "80"

    set output_file "blue-green-deployment.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: $deployment_label_app
    env: $deployment_label_env
  name: $deployment_name
  namespace: $deployment_namespace
spec:
  replicas: $deployment_replicas
  selector:
    matchLabels:
      app: $deployment_label_app
  strategy: {}
  template:
    metadata:
      labels:
        app: $deployment_label_app
    spec:
      containers:
      - image: $container_image
        name: $container_name
        ports:
        - containerPort: $container_port
        resources: {}
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-service-blue-green
    set service_name "blue-green-svc"
    set service_namespace "blue-green"
    set service_label_app "blue-app"
    set service_label_env "blue"
    set service_port "80"
    set service_nodePort "32298"
    set service_protocol "TCP"
    set service_targetPort "80"

    set output_file "blue-green-service.yaml"

    echo "--- 
apiVersion: v1
kind: Service
metadata:
  labels:
    app: $service_label_app
    env: $service_label_env
  name: $service_name
  namespace: $service_namespace
spec:
  ports:
  - nodePort: $service_nodePort
    port: $service_port
    protocol: $service_protocol
    targetPort: $service_targetPort
  selector:
    env: $service_label_env
  type: NodePort
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-blue-green-deploymentAll
    set blue_deployment_name "blue-deployment"
    set blue_app_label "my-app"
    set blue_version "v1"
    set blue_replicas "3"
    set blue_container_name "nginx"
    set blue_container_image "nginx"
    set blue_container_port "80"
    set blue_initcontainer_name "install"
    set blue_initcontainer_image "busybox:1.28"
    set blue_initcommand "echo version-1 > /work-dir/index.html"
    set blue_volume_name "workdir"
    set blue_volume_mount_path "/usr/share/nginx/html"
    set blue_init_volume_mount_path "/work-dir"

    set service_name "blue-green-svc"
    set service_app_label "my-app"
    set service_port "80"
    set service_target_port "80"
    set service_type "ClusterIP"

    set green_deployment_name "green-deployment"
    set green_app_label "my-app"
    set green_version "v2"
    set green_replicas "3"
    set green_container_name "nginx"
    set green_container_image "nginx"
    set green_container_port "80"
    set green_initcontainer_name "install"
    set green_initcontainer_image "busybox:1.28"
    set green_initcommand "echo version-2 > /work-dir/index.html"
    set green_volume_name "workdir"
    set green_volume_mount_path "/usr/share/nginx/html"
    set green_init_volume_mount_path "/work-dir"

    set output_file "blue-green-deployment.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $blue_deployment_name
  labels:
    app: $blue_app_label
spec:
  replicas: $blue_replicas
  selector:
    matchLabels:
      app: $blue_app_label
      version: $blue_version
  template:
    metadata:
      labels:
        app: $blue_app_label
        version: $blue_version
    spec:
      containers:
      - name: $blue_container_name
        image: $blue_container_image
        ports:
        - containerPort: $blue_container_port
        volumeMounts:
        - name: $blue_volume_name
          mountPath: $blue_volume_mount_path
      initContainers:
      - name: $blue_initcontainer_name
        image: $blue_initcontainer_image
        command:
        - /bin/sh
        - -c
        - \"$blue_initcommand\"
        volumeMounts:
        - name: $blue_volume_name
          mountPath: $blue_init_volume_mount_path
      volumes:
      - name: $blue_volume_name
        emptyDir: {}

---
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  labels:
    app: $service_app_label
spec:
  type: $service_type
  ports:
  - name: http
    port: $service_port
    targetPort: $service_target_port
  selector:
    app: $service_app_label
    version: $blue_version

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $green_deployment_name
  labels:
    app: $green_app_label
spec:
  replicas: $green_replicas
  selector:
    matchLabels:
      app: $green_app_label
      version: $green_version
  template:
    metadata:
      labels:
        app: $green_app_label
        version: $green_version
    spec:
      containers:
      - name: $green_container_name
        image: $green_container_image
        ports:
        - containerPort: $green_container_port
        volumeMounts:
        - name: $green_volume_name
          mountPath: $green_volume_mount_path
      initContainers:
      - name: $green_initcontainer_name
        image: $green_initcontainer_image
        command:
        - /bin/sh
        - -c
        - \"$green_initcommand\"
        volumeMounts:
        - name: $green_volume_name
          mountPath: $green_init_volume_mount_path
      volumes:
      - name: $green_volume_name
        emptyDir: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deployment-canary1
    set deployment_name "primary-app"
    set deployment_namespace "canary"
    set deployment_app_label "primary-app"
    set deployment_type "RollingUpdate"
    set deployment_replicas "4"
    set deployment_strategy_max_surge "25%"
    set deployment_strategy_max_unavailable "25%"

    set container_name "nginx"
    set container_image "nginx:1.19"
    set container_port "80"
    set container_protocol "TCP"

    set output_file "canary-deployment.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: $deployment_app_label
    deployment: canary
    env: primary
  name: $deployment_name
  namespace: $deployment_namespace
spec:
  replicas: $deployment_replicas
  selector:
    matchLabels:
      app: $deployment_app_label
  strategy:
    rollingUpdate:
      maxSurge: $deployment_strategy_max_surge
      maxUnavailable: $deployment_strategy_max_unavailable
    type: $deployment_type
  template:
    metadata:
      labels:
        app: $deployment_app_label
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
          protocol: $container_protocol
        resources: {}
      securityContext: {}
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-canary-service
    set service_name "canary-svc"
    set service_namespace "canary"
    set service_label_app "primary-app"
    set service_label_deployment "canary"
    set service_label_env "primary"
    set service_port "80"
    set service_nodePort "30378"
    set service_protocol "TCP"
    set service_targetPort "80"

    set output_file "canary-service.yaml"

    echo "--- 
apiVersion: v1
kind: Service
metadata:
  labels:
    app: $service_label_app
    deployment: $service_label_deployment
    env: $service_label_env
  name: $service_name
  namespace: $service_namespace
spec:
  ports:
  - nodePort: $service_nodePort
    port: $service_port
    protocol: $service_protocol
    targetPort: $service_targetPort
  selector:
    app: $service_label_app
  type: NodePort
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-deployment-canary2
    set deployment_name "canary-app"
    set deployment_namespace "canary"
    set deployment_app "primary-app"
    set deployment_replicas "2"
    set rolling_update_maxSurge "25%"
    set rolling_update_maxUnavailable "25%"
    set container_name "httpd"
    set container_image "httpd:2.4"
    set container_port "80"
    set output_file "canary-deployment.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
  namespace: $deployment_namespace
  labels:
    app: $deployment_app
spec:
  replicas: $deployment_replicas
  selector:
    matchLabels:
      app: $deployment_app
  strategy:
    rollingUpdate:
      maxSurge: $rolling_update_maxSurge
      maxUnavailable: $rolling_update_maxUnavailable
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: $deployment_app
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
        resources: {}
status: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deployment-canaryAll
    set primary_deployment_name "primary-deployment"
    set primary_app "my-app"
    set primary_version "v1"
    set primary_replicas "3"
    set primary_container_name "nginx"
    set primary_container_image "nginx"
    set primary_container_port "80"
    set primary_initcontainer_name "install"
    set primary_initcontainer_image "busybox:1.28"
    set primary_initcontainer_command "echo version-1 > /work-dir/index.html"

    set service_name "canary-svc"
    set service_app "my-app"
    set service_type "ClusterIP"
    set service_port "80"
    set service_targetPort "80"
    set service_port_name "http"

    set canary_deployment_name "canary-deployment"
    set canary_app "my-app"
    set canary_version "v2"
    set canary_replicas "1"
    set canary_container_name "nginx"
    set canary_container_image "nginx"
    set canary_container_port "80"
    set canary_initcontainer_name "install"
    set canary_initcontainer_image "busybox:1.28"
    set canary_initcontainer_command "echo version-2 > /work-dir/index.html"
    set output_file "primary-canary.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $primary_deployment_name
  labels:
    app: $primary_app
spec:
  replicas: $primary_replicas
  selector:
    matchLabels:
      app: $primary_app
      version: $primary_version
  template:
    metadata:
      labels:
        app: $primary_app
        version: $primary_version
    spec:
      containers:
      - name: $primary_container_name
        image: $primary_container_image
        ports:
        - containerPort: $primary_container_port
        volumeMounts:
        - name: workdir
          mountPath: /usr/share/nginx/html
      initContainers:
      - name: $primary_initcontainer_name
        image: $primary_initcontainer_image
        command:
        - /bin/sh
        - -c
        - \"$primary_initcontainer_command\"
        volumeMounts:
        - name: workdir
          mountPath: \"/work-dir\"
      volumes:
      - name: workdir
        emptyDir: {}

---
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  labels:
    app: $service_app
spec:
  type: $service_type
  ports:
  - name: $service_port_name
    port: $service_port
    targetPort: $service_targetPort
  selector:
    app: $service_app

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $canary_deployment_name
  labels:
    app: $canary_app
spec:
  replicas: $canary_replicas
  selector:
    matchLabels:
      app: $canary_app
      version: $canary_version
  template:
    metadata:
      labels:
        app: $canary_app
        version: $canary_version
    spec:
      containers:
      - name: $canary_container_name
        image: $canary_container_image
        ports:
        - containerPort: $canary_container_port
        volumeMounts:
        - name: workdir
          mountPath: /usr/share/nginx/html
      initContainers:
      - name: $canary_initcontainer_name
        image: $canary_initcontainer_image
        command:
        - /bin/sh
        - -c
        - \"$canary_initcontainer_command\"
        volumeMounts:
        - name: workdir
          mountPath: \"/work-dir\"
      volumes:
      - name: workdir
        emptyDir: {}
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-deployment-recreate
    set deployment_name "web-server"
    set replicas 4
    set strategy_type "Recreate"
    set app_label "httpd"
    set container_name "httpd"
    set container_image "httpd:2.4.23-alpine"
    set container_port 80
    set container_protocol "TCP"
    set output_file "deployment-recreate-template.yaml"

    echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
spec:
  replicas: $replicas
  strategy:
    type: $strategy_type
  selector:
    matchLabels:
      app: $app_label
  template:
    metadata:
      labels:
        app: $app_label
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
          protocol: $container_protocol
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-deployment-surge-unavailable
    set deployment_name "my-deploy"
    set app_label "my-deploy"
    set replicas 7
    set strategy_type "RollingUpdate"
    set max_unavailable 2
    set max_surge 2
    set container_name "httpd"
    set container_image "httpd:2.4"
    set container_port 80
    set output_file "deployment-with-variables.yaml"

    echo "apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: $app_label
  name: $deployment_name
spec:
  replicas: $replicas
  selector:
    matchLabels:
      app: $app_label
  strategy:
    type: $strategy_type
    rollingUpdate:
      maxUnavailable: $max_unavailable
      maxSurge: $max_surge
  template:
    metadata:
      labels:
        app: $app_label
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
        resources: {}
status: {}
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deployment-testingAB
    set app_a_name "app-a"
    set app_a_label_app "test-app"
    set app_a_label_version "a"
    set app_a_replicas 3
    set app_a_image "nginx:1.19"
    set app_a_container_name "app-a"

    set app_b_name "app-b"
    set app_b_label_app "test-app"
    set app_b_label_version "b"
    set app_b_replicas 2
    set app_b_image "nginx:1.21"
    set app_b_container_name "app-b"

    set service_name "ab-test-svc"
    set service_label_app "test-app"
    set service_port 80
    set service_targetPort 80
    set service_type "ClusterIP"
    set output_file "ab-testing.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $app_a_name
  labels:
    app: $app_a_label_app
    version: $app_a_label_version
spec:
  replicas: $app_a_replicas
  selector:
    matchLabels:
      app: $app_a_label_app
      version: $app_a_label_version
  template:
    metadata:
      labels:
        app: $app_a_label_app
        version: $app_a_label_version
    spec:
      containers:
      - name: $app_a_container_name
        image: $app_a_image
        ports:
        - containerPort: 80
        volumeMounts:
        - name: workdir
          mountPath: /usr/share/nginx/html
      initContainers:
      - name: init-a
        image: busybox:1.28
        command:
        - sh
        - -c
        - \"echo 'Version A' > /work-dir/index.html\"
        volumeMounts:
        - name: workdir
          mountPath: /work-dir
      volumes:
      - name: workdir
        emptyDir: {}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $app_b_name
  labels:
    app: $app_b_label_app
    version: $app_b_label_version
spec:
  replicas: $app_b_replicas
  selector:
    matchLabels:
      app: $app_b_label_app
      version: $app_b_label_version
  template:
    metadata:
      labels:
        app: $app_b_label_app
        version: $app_b_label_version
    spec:
      containers:
      - name: $app_b_container_name
        image: $app_b_image
        ports:
        - containerPort: 80
        volumeMounts:
        - name: workdir
          mountPath: /usr/share/nginx/html
      initContainers:
      - name: init-b
        image: busybox:1.28
        command:
        - sh
        - -c
        - \"echo 'Version B' > /work-dir/index.html\"
        volumeMounts:
        - name: workdir
          mountPath: /work-dir
      volumes:
      - name: workdir
        emptyDir: {}

---
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  labels:
    app: $service_label_app
spec:
  selector:
    app: $service_label_app
  ports:
  - name: http
    port: $service_port
    targetPort: $service_targetPort
  type: $service_type
" > $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-deployment-shadow
    set app_name "shop"
    set namespace "default"

    set main_deploy_name "main-app"
    set main_role "primary"
    set main_image "nginx:1.19"
    set main_replicas 3

    set shadow_deploy_name "shadow-app"
    set shadow_role "shadow"
    set shadow_image "nginx:1.21"
    set shadow_replicas 1

    set service_name "shop-svc"
    set service_type "ClusterIP"
    set service_port 80
    set service_target_port 80
    set service_protocol "TCP"

    set ingress_name "shop-ingress"
    set ingress_host "shop.example.com"
    set mirror_target "shadow-svc"
    set mirror_body "on"

    set output_file "shadow-deployment.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $main_deploy_name
  labels:
    app: $app_name
    role: $main_role
spec:
  replicas: $main_replicas
  selector:
    matchLabels:
      app: $app_name
      role: $main_role
  template:
    metadata:
      labels:
        app: $app_name
        role: $main_role
    spec:
      containers:
      - name: $main_deploy_name
        image: $main_image
        ports:
        - containerPort: 80

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $shadow_deploy_name
  labels:
    app: $app_name
    role: $shadow_role
spec:
  replicas: $shadow_replicas
  selector:
    matchLabels:
      app: $app_name
      role: $shadow_role
  template:
    metadata:
      labels:
        app: $app_name
        role: $shadow_role
    spec:
      containers:
      - name: $shadow_deploy_name
        image: $shadow_image
        ports:
        - containerPort: 80

---
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app: $app_name
spec:
  selector:
    app: $app_name
    role: $main_role
  ports:
  - port: $service_port
    targetPort: $service_target_port
    protocol: $service_protocol
  type: $service_type

---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  annotations:
    nginx.ingress.kubernetes.io/mirror-target: \"$mirror_target\"
    nginx.ingress.kubernetes.io/mirror-target-request-body: \"$mirror_body\"
spec:
  rules:
  - host: $ingress_host
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $service_name
            port:
              number: $service_port
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-topologySpread
    set pod_name "mypod"
    set pod_label_key "foo"
    set pod_label_value "bar"
    set container_name "pause"
    set container_image "registry.k8s.io/pause:3.1"

    set topology_key_1 "zone"
    set max_skew_1 1
    set when_unsatisfiable_1 "DoNotSchedule"

    set topology_key_2 "node"
    set max_skew_2 1
    set when_unsatisfiable_2 "DoNotSchedule"
    set output_file "pod-topology-spread.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    $pod_label_key: $pod_label_value
spec:
  topologySpreadConstraints:
  - maxSkew: $max_skew_1
    topologyKey: $topology_key_1
    whenUnsatisfiable: $when_unsatisfiable_1
    labelSelector:
      matchLabels:
        $pod_label_key: $pod_label_value
  - maxSkew: $max_skew_2
    topologyKey: $topology_key_2
    whenUnsatisfiable: $when_unsatisfiable_2
    labelSelector:
      matchLabels:
        $pod_label_key: $pod_label_value
  containers:
  - name: $container_name
    image: $container_image
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


 function create-pod-topology-affinity
    set pod_name "mypod"
    set pod_label_key "foo"
    set pod_label_value "bar"
    set container_name "pause"
    set container_image "registry.k8s.io/pause:3.1"

    set topology_key "zone"
    set max_skew 1
    set when_unsatisfiable "DoNotSchedule"

    set node_affinity_key "zone"
    set node_affinity_operator "NotIn"
    set node_affinity_values "zoneC"  # можна передати список зон через пробіл для NotIn або In
    set output_file "pod-topology-affinity.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    $pod_label_key: $pod_label_value
spec:
  topologySpreadConstraints:
  - maxSkew: $max_skew
    topologyKey: $topology_key
    whenUnsatisfiable: $when_unsatisfiable
    labelSelector:
      matchLabels:
        $pod_label_key: $pod_label_value
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: $node_affinity_key
            operator: $node_affinity_operator
            values:" > $output_file

    for v in $node_affinity_values
        echo "            - $v" >> $output_file
    end

    echo "  containers:
  - name: $container_name
    image: $container_image
" >> $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-resourceClaimTemplate
    set claim_template_name "prioritized-list-claim-template"
    set device_class_name "resource.example.com"
    set request_name_0 "req-0"
    set request_0_name_1 "large-black"
    set request_0_expr_1 'device.attributes["resource-driver.example.com"].color == "black" && device.attributes["resource-driver.example.com"].size == "large"'
    set request_0_name_2 "small-white"
    set request_0_expr_2 'device.attributes["resource-driver.example.com"].color == "white" && device.attributes["resource-driver.example.com"].size == "small"'
    set request_0_count_2 2
    set output_file "resource-claim-template.yaml"

    echo "apiVersion: resource.k8s.io/v1
kind: ResourceClaimTemplate
metadata:
  name: $claim_template_name
spec:
  spec:
    devices:
      requests:
      - name: $request_name_0
        firstAvailable:
        - name: $request_0_name_1
          deviceClassName: $device_class_name
          selectors:
          - cel:
              expression: |-
                $request_0_expr_1
        - name: $request_0_name_2
          deviceClassName: $device_class_name
          selectors:
          - cel:
              expression: |-
                $request_0_expr_2
          count: $request_0_count_2
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end
 
function create-resourceSlice
    set slice_name "cat-slice"
    set driver_name "resource-driver.example.com"
    set pool_generation 1
    set pool_name "black-cat-pool"
    set resource_slice_count 1
    set all_nodes true

    set device_name "large-black-cat"
    set attribute_color "black"
    set attribute_size "large"
    set attribute_cat true
    set output_file "resource-slice.yaml"

    echo "apiVersion: resource.k8s.io/v1
kind: ResourceSlice
metadata:
  name: $slice_name
spec:
  driver: \"$driver_name\"
  pool:
    generation: $pool_generation
    name: \"$pool_name\"
    resourceSliceCount: $resource_slice_count
  allNodes: $all_nodes
  devices:
  - name: \"$device_name\"
    attributes:
      color:
        string: \"$attribute_color\"
      size:
        string: \"$attribute_size\"
      cat:
        bool: $attribute_cat
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


 function create-pod-priorityClass
    set priority_class_name "high-priority"
    set priority_value 1000000
    set global_default "false"
    set priority_description "This priority class should be used for XYZ service pods only."

    set pod_name "nginx"
    set pod_label_key "env"
    set pod_label_value "test"
    set container_name "nginx"
    set container_image "nginx"
    set image_pull_policy "IfNotPresent"
    set output_file "priorityclass-and-pod.yaml"

    echo "apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: $priority_class_name
value: $priority_value
globalDefault: $global_default
description: \"$priority_description\"

---
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    $pod_label_key: $pod_label_value
spec:
  containers:
  - name: $container_name
    image: $container_image
    imagePullPolicy: $image_pull_policy
  priorityClassName: $priority_class_name
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-priorityClass1
    set priority_class_name "high-priority-nonpreempting"
    set priority_value 1000000
    set preemption_policy "Never"
    set global_default "false"
    set priority_description "This priority class will not cause other pods to be preempted."

    set pod_name "safe-pod"
    set container_name "nginx"
    set container_image "nginx"
    set output_file "priorityclass-pod.yaml"

    echo "apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: $priority_class_name
value: $priority_value
preemptionPolicy: $preemption_policy
globalDefault: $global_default
description: \"$priority_description\"

---
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  containers:
  - name: $container_name
    image: $container_image
  priorityClassName: $priority_class_name
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-admissionWebhooks
    set kubeconfig_path "<path-to-kubeconfig-file>"
    set ca_bundle "<CA_BUNDLE>"

    set validating_webhook_name "pod-policy.example.com"
    set validating_namespace "example-namespace"
    set validating_service_name "example-service"
    set validating_timeout_seconds 5

    set mutating_webhook_name "pod-mutator.example.com"
    set mutating_namespace "example-namespace"
    set mutating_service_name "example-mutator-service"
    set mutating_timeout_seconds 10

    set output_file "admission-webhooks.yaml"

    echo "apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ValidatingAdmissionWebhook
  configuration:
    apiVersion: apiserver.config.k8s.io/v1
    kind: WebhookAdmissionConfiguration
    kubeConfigFile: \"$kubeconfig_path\"
- name: MutatingAdmissionWebhook
  configuration:
    apiVersion: apiserver.config.k8s.io/v1
    kind: WebhookAdmissionConfiguration
    kubeConfigFile: \"$kubeconfig_path\"

---

apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: \"$validating_webhook_name\"
webhooks:
- name: \"$validating_webhook_name\"
  rules:
  - apiGroups: [\"\"]               
    apiVersions: [\"v1\"]
    operations: [\"CREATE\"]         
    resources: [\"pods\"]            
    scope: \"Namespaced\"            
  clientConfig:
    service:
      namespace: \"$validating_namespace\"
      name: \"$validating_service_name\"
    caBundle: $ca_bundle
  admissionReviewVersions: [\"v1\"]
  sideEffects: None
  timeoutSeconds: $validating_timeout_seconds

---

apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  name: \"$mutating_webhook_name\"
webhooks:
- name: \"$mutating_webhook_name\"
  rules:
  - apiGroups: [\"\"]               
    apiVersions: [\"v1\"]
    operations: [\"CREATE\", \"UPDATE\"]   
    resources: [\"pods\"]            
    scope: \"Namespaced\"            
  clientConfig:
    service:
      namespace: \"$mutating_namespace\"
      name: \"$mutating_service_name\"
    caBundle: $ca_bundle
  admissionReviewVersions: [\"v1\"]
  sideEffects: None
  timeoutSeconds: $mutating_timeout_seconds
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function create-resourceSlice-bandwidth
    set slice_name "resourceslice"
    set api_version "resource.k8s.io/v1"
    set node_name "worker-1"
    set pool_name "pool"
    set pool_generation 1
    set resource_slice_count 1
    set driver_name "dra.example.com"

    set device_name "eth1"
    set allow_multiple_allocations "true"
    set attribute_name "eth1"

    set bandwidth_default "1M"
    set bandwidth_min "1M"
    set bandwidth_step "8"
    set bandwidth_value "10G"
    set output_file "resource-slice-bandwidth.yaml"

    echo "apiVersion: $api_version
kind: ResourceSlice
metadata:
  name: $slice_name
spec:
  nodeName: $node_name
  pool:
    name: $pool_name
    generation: $pool_generation
    resourceSliceCount: $resource_slice_count
  driver: $driver_name
  devices:
  - name: $device_name
    allowMultipleAllocations: $allow_multiple_allocations
    attributes:
      name:
        string: \"$attribute_name\"
    capacity:
      bandwidth:
        requestPolicy:
          default: \"$bandwidth_default\"
          validRange:
            min: \"$bandwidth_min\"
            step: \"$bandwidth_step\"
        value: \"$bandwidth_value\"
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-resourceSlice-counters
    set slice_name "resourceslice"
    set api_version "resource.k8s.io/v1"
    set node_name "worker-1"
    set pool_name "pool"
    set pool_generation 1
    set resource_slice_count 1
    set driver_name "dra.example.com"
    set counter_name "gpu-1-counters"
    set counter_memory "8Gi"

    set device1_name "device-1"
    set device2_name "device-2"
    set device_memory "6Gi"

    set output_file "resource-slice-with-counters.yaml"

    echo "apiVersion: $api_version
kind: ResourceSlice
metadata:
  name: $slice_name
spec:
  nodeName: $node_name
  pool:
    name: $pool_name
    generation: $pool_generation
    resourceSliceCount: $resource_slice_count
  driver: $driver_name
  sharedCounters:
  - name: $counter_name
    counters:
      memory:
        value: $counter_memory
  devices:
  - name: $device1_name
    consumesCounters:
    - counterSet: $counter_name
      counters:
        memory:
          value: $device_memory
  - name: $device2_name
    consumesCounters:
    - counterSet: $counter_name
      counters:
        memory:
          value: $device_memory
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-topology
    set pod_name "mypod"
    set pod_label_key "foo"
    set pod_label_value "bar"
    set container_name "pause"
    set container_image "registry.k8s.io/pause:3.1"

    set topology_key "zone"
    set max_skew 1
    set when_unsatisfiable "DoNotSchedule"
    set output_file "pod-topology.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  labels:
    $pod_label_key: $pod_label_value
spec:
  topologySpreadConstraints:
  - maxSkew: $max_skew
    topologyKey: $topology_key
    whenUnsatisfiable: $when_unsatisfiable
    labelSelector:
      matchLabels:
        $pod_label_key: $pod_label_value
  containers:
  - name: $container_name
    image: $container_image
" > $output_file

    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-deployment-rollingUpdatewithPause
    set deployment_name "progressive-app"
    set namespace "default"
    set app_label "progressive-app"
    set replicas 5
    set strategy_type "RollingUpdate"
    set max_unavailable 1
    set max_surge 1
    set container_name "nginx"
    set container_image "nginx:1.19"
    set container_port 80
    set output_file "deployment-progressive.yaml"

    echo "--- 
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
  namespace: $namespace
  labels:
    app: $app_label
spec:
  replicas: $replicas
  strategy:
    type: $strategy_type
    rollingUpdate:
      maxUnavailable: $max_unavailable
      maxSurge: $max_surge
  selector:
    matchLabels:
      app: $app_label
  template:
    metadata:
      labels:
        app: $app_label
    spec:
      containers:
      - name: $container_name
        image: $container_image
        ports:
        - containerPort: $container_port
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-service-labelSelector
    set service_name "my-service"
    set namespace "default"
    set app_label "MyApp"
    set protocol "TCP"
    set port 80
    set output_file "service.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app.kubernetes.io/name: $app_label
spec:
  selector:
    app.kubernetes.io/name: $app_label
  ports:
    - protocol: $protocol
      port: $port
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-service-headless
    set service_name "my-headless-service"
    set namespace "default"
    set app_label "MyApp"
    set protocol "TCP"
    set port 80
    set output_file "headless-service.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app.kubernetes.io/name: $app_label
spec:
  clusterIP: None
  selector:
    app.kubernetes.io/name: $app_label
  ports:
    - protocol: $protocol
      port: $port
" > $output_file

    echo "$output_file created"
    cat $output_file
end

function create-service-with-ipDualStack
    set service_name "my-service"
    set namespace "default"
    set app_label "MyApp"
    set ip_family_policy "PreferDualStack"
    set ip_families "IPv6 IPv4" # список ip-фамілій
    set protocol "TCP"
    set port 80
    set output_file "service-ipfamilies.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app.kubernetes.io/name: $app_label
spec:
  ipFamilyPolicy: $ip_family_policy
  ipFamilies:" > $output_file

    for family in $ip_families
        echo "  - $family" >> $output_file
    end

    echo "  selector:
    app.kubernetes.io/name: $app_label
  ports:
    - protocol: $protocol
      port: $port
" >> $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-endpointsliceController
    set endpoint_slice_name "example-hints"
    set service_name "example-svc"
    set address_type "IPv4"
    set port_name "http"
    set protocol "TCP"
    set port_number 80
    set addresses "10.1.2.3"
    set hostname "pod-1"
    set zone "zone-a"
    set output_file "endpointslice.yaml"

    echo "apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: $endpoint_slice_name
  labels:
    kubernetes.io/service-name: $service_name
addressType: $address_type
ports:
  - name: $port_name
    protocol: $protocol
    port: $port_number
endpoints:
  - addresses:" > $output_file

    for addr in $addresses
        echo "      - \"$addr\"" >> $output_file
    end

    echo "    conditions:
      ready: true
    hostname: $hostname
    zone: $zone
    hints:
      forZones:
        - name: \"$zone\"" >> $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

  
function create-service-clusterIp
    set service_name "service-example"
    set namespace "default"
    set app_label "service-example"
    set env_label "dev"
    set service_type "ClusterIP"
    set protocol "TCP"
    set port "80"
    set target_port "80"
    set output_file "service-template.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app: $app_label
    env: $env_label
spec:
  type: $service_type
  selector:
    app: $app_label
  ports:
    - protocol: $protocol
      port: $port
      targetPort: $target_port
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-security-labels
    set namespace "restricted-ns"
    set enforce_level "restricted"
    set enforce_version "latest"
    set audit_level "baseline"
    set audit_version "v1.34"
    set warn_level "privileged"
    set warn_version "latest"
    set output_file "namespace-pod-security.yaml"

    echo "apiVersion: v1
kind: Namespace
metadata:
  name: $namespace
  labels:
    pod-security.kubernetes.io/enforce: $enforce_level
    pod-security.kubernetes.io/enforce-version: $enforce_version
    pod-security.kubernetes.io/audit: $audit_level
    pod-security.kubernetes.io/audit-version: $audit_version
    pod-security.kubernetes.io/warn: $warn_level
    pod-security.kubernetes.io/warn-version: $warn_version
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx-test
  namespace: $namespace
spec:
  containers:
    - name: nginx
      image: nginx:1.27
      securityContext:
        allowPrivilegeEscalation: false
        runAsNonRoot: true
        capabilities:
          drop: [\"ALL\"]
" > $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-pod-nodeAffinity
    set pod_name "with-node-affinity"
    set namespace "default"
    set image "registry.k8s.io/pause:3.8"

    set required_key "topology.kubernetes.io/zone"
    set required_operator "In"
    set required_values "antarctica-east1 antarctica-west1"

    set preferred_key "another-node-label-key"
    set preferred_operator "In"
    set preferred_values "another-node-label-value"
    set preferred_weight 1
    set output_file "pod-node-affinity.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: $required_key
            operator: $required_operator
            values:" > $output_file

    for val in $required_values
        echo "            - $val" >> $output_file
    end
    echo "      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: $preferred_weight
        preference:
          matchExpressions:
          - key: $preferred_key
            operator: $preferred_operator
            values:" >> $output_file
    for val in $preferred_values
        echo "            - $val" >> $output_file
    end
    echo "  containers:
  - name: $pod_name
    image: $image
" >> $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-nodeAffinity
    set pod_name "with-node-affinity"
    set namespace "default"
    set image "registry.k8s.io/pause:3.8"

    set required_key "topology.kubernetes.io/zone"
    set required_operator "In"
    set required_values "antarctica-east1 antarctica-west1"

    set preferred_key "another-node-label-key"
    set preferred_operator "In"
    set preferred_values "another-node-label-value"
    set preferred_weight 1
    set output_file "pod-node-affinity.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: $required_key
            operator: $required_operator
            values:" > $output_file
    for val in $required_values
        echo "            - $val" >> $output_file
    end
    echo "      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: $preferred_weight
        preference:
          matchExpressions:
          - key: $preferred_key
            operator: $preferred_operator
            values:" >> $output_file
    for val in $preferred_values
        echo "            - $val" >> $output_file
    end
    echo "  containers:
  - name: $pod_name
    image: $image
" >> $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-affinity
    set pod_name "with-pod-affinity"
    set namespace "default"
    set image "registry.k8s.io/pause:3.8"

    set affinity_key "security"
    set affinity_operator "In"
    set affinity_values "S1"
    set affinity_topology_key "topology.kubernetes.io/zone"

    set anti_key "security"
    set anti_operator "In"
    set anti_values "S2"
    set anti_weight 100
    set anti_topology_key "topology.kubernetes.io/zone"

    set output_file "pod-with-affinity.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
spec:
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
          - key: $affinity_key
            operator: $affinity_operator
            values:" > $output_file

    for val in $affinity_values
        echo "            - $val" >> $output_file
    end

    echo "        topologyKey: $affinity_topology_key
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
      - weight: $anti_weight
        podAffinityTerm:
          labelSelector:
            matchExpressions:
            - key: $anti_key
              operator: $anti_operator
              values:" >> $output_file
    for val in $anti_values
        echo "              - $val" >> $output_file
    end
 
    echo "          topologyKey: $anti_topology_key
  containers:
  - name: $pod_name
    image: $image
" >> $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-runtimeclass-and-pod
    set runtime_class_name "kata-fc"
    set handler_name "kata-fc"
    set overhead_memory "120Mi"
    set overhead_cpu "250m"

    set pod_name "test-pod"
    set runtime_class_ref "kata-fc"
    set container1_name "busybox-ctr"
    set container1_image "busybox:1.28"
    set container1_cpu_limit "500m"
    set container1_mem_limit "100Mi"

    set container2_name "nginx-ctr"
    set container2_image "nginx:latest"
    set container2_cpu_limit "1500m"
    set container2_mem_limit "100Mi"
    set output_file "runtimeclass-and-pod.yaml"

    echo "apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: $runtime_class_name
handler: $handler_name
overhead:
  podFixed:
    memory: \"$overhead_memory\"
    cpu: \"$overhead_cpu\"

---
apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  runtimeClassName: $runtime_class_ref
  containers:
  - name: $container1_name
    image: $container1_image
    stdin: true
    tty: true
    resources:
      limits:
        cpu: $container1_cpu_limit
        memory: $container1_mem_limit
  - name: $container2_name
    image: $container2_image
    resources:
      limits:
        cpu: $container2_cpu_limit
        memory: $container2_mem_limit
" > $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pod-schedulingGates
    set pod_name "test-pod"
    set container_name "pause"
    set container_image "registry.k8s.io/pause:3.6"
    set scheduling_gate1 "example.com/foo"
    set scheduling_gate2 "example.com/bar"
    set output_file "pod-scheduling-gates.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
spec:
  schedulingGates:
  - name: $scheduling_gate1
  - name: $scheduling_gate2
  containers:
  - name: $container_name
    image: $container_image
" > $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

  
function create-pod-nominatedNode
    set pod_name "nginx"
    set namespace "default"
    set app_label "nginx"
    set image "nginx:1.27"
    set container_port 80
    set nominated_node "kube-01"
    set output_file "pod-nominated.yaml"

    echo "apiVersion: v1
kind: Pod
metadata:
  name: $pod_name
  namespace: $namespace
  labels:
    app: $app_label
spec:
  containers:
    - name: $pod_name
      image: $image
      ports:
        - containerPort: $container_port
status:
  nominatedNodeName: $nominated_node
" > $output_file

    echo ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-service-nodeport
    set service_name "redis-service"
    set namespace "default"
    set app_label "redis"
    set tier_label "backend"
    set service_type "NodePort"
    set protocol "TCP"
    set port "6379"
    set target_port "6379"
    set node_port "30009"
    set output_file "service-nodeport-template.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  labels:
    app: $app_label
    tier: $tier_label
spec:
  type: $service_type
  selector:
    app: $app_label
  ports:
    - protocol: $protocol
      port: $port
      targetPort: $target_port
      nodePort: $node_port
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-service
    set service_name "redis-service"
    set namespace "default"
    set label_key "tier"
    set label_value "db"
    set port "6379"
    set protocol "TCP"
    set target_port "6379"
    set cluster_ip "10.43.0.18"
    set service_type "LoadBalancer"
    set ingress_ip "192.0.2.127"
    set output_file "service-template.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    $label_key: $label_value
  name: $service_name
  namespace: $namespace
spec:
  ports:
  - port: $port
    protocol: $protocol
    targetPort: $target_port
  selector:
    $label_key: $label_value
  clusterIP: $cluster_ip
  type: $service_type
status:
  loadBalancer:
    ingress:
    - ip: $ingress_ip
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-ingress-template
    # 🔧 Змінні
    set ing_name "simple"
    set ing_class "default"
    set rules "foo.com/bar=svc1:8080"  # Можна додавати через пробіл для кількох правил
    set tls_secret "my-cert"           # Порожнє якщо TLS не потрібен
    set default_backend ""             # Порожнє якщо не потрібен
    set output_file "ingress-template.yaml"

    # 🧱 Генерація YAML
    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ing_name
  annotations:
    kubernetes.io/ingress.class: \"$ing_class\"
spec:" > $output_file

    if test -n "$tls_secret"
        echo "  tls:
  - secretName: $tls_secret" >> $output_file
    end

    if test -n "$default_backend"
        echo "  defaultBackend:
    service:
      name: (string split ':' $default_backend)[1]
      port:
        number: (string split ':' $default_backend)[2]" >> $output_file
    end

    if test -n "$rules"
        echo "  rules:" >> $output_file
        for r in $rules
            set host_path (string split '=' $r)
            set host_and_path $host_path[1]
            set svc_port $host_path[2]

            # Розділяємо хост і шлях
            set host (string split '/' $host_and_path)[1]
            set path "/"(string join "/" (string split '/' $host_and_path)[2..-1])
            set svc_name (string split ':' $svc_port)[1]
            set svc_port_num (string split ':' $svc_port)[2]

            echo "  - host: $host
    http:
      paths:
      - path: $path
        pathType: Prefix
        backend:
          service:
            name: $svc_name
            port:
              number: $svc_port_num" >> $output_file
        end
    end

    # 🎨 Вивід результату
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-ingress-nginx-annotation
    set ingress_name "ingress-wear-watch"
    set namespace "app-space"
    set annotation_rewrite "nginx.ingress.kubernetes.io/rewrite-target: /"
    set annotation_ssl "nginx.ingress.kubernetes.io/ssl-redirect: \"false\""
    set service1_name "wear-service"
    set service1_port "8080"
    set service1_path "/wear"
    set service2_name "video-service"
    set service2_port "8080"
    set service2_path "/stream"
    set path_type "Prefix"
    set output_file "ingress-template.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: \"false\"
  name: $ingress_name
  namespace: $namespace
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: $service1_name
            port:
              number: $service1_port
        path: $service1_path
        pathType: $path_type
      - backend:
          service:
            name: $service2_name
            port:
              number: $service2_port
        path: $service2_path
        pathType: $path_type
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-ingress-tls
    set ingress_name "ingress-app1"
    set ingress_class "nginx"
    set host_name "app1.local"
    set service_name "app1-svc"
    set service_port "80"
    set tls_secret "app1-tls"
    set output_file "ingress-app1-template.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: $ingress_class
  rules:
  - host: $host_name
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: $service_name
            port:
              number: $service_port
  tls:
  - hosts:
    - $host_name
    secretName: $tls_secret
" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-ingress-wildcard
    set ingress_name "ingress-wildcard-host"
    set host1 "foo.bar.com"
    set path1 "/bar"
    set service1 "service1"
    set port1 80

    set host2 "*.foo.com"
    set path2 "/foo"
    set service2 "service2"
    set port2 80

    set output_file "ingress-wildcard.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
spec:
  rules:
  - host: \"$host1\"
    http:
      paths:
      - pathType: Prefix
        path: \"$path1\"
        backend:
          service:
            name: $service1
            port:
              number: $port1
  - host: \"$host2\"
    http:
      paths:
      - pathType: Prefix
        path: \"$path2\"
        backend:
          service:
            name: $service2
            port:
              number: $port2
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-ingress-fanout
    set ingress_name "simple-fanout-example"
    set host "foo.bar.com"
    set path1 "/foo"
    set service1 "service1"
    set port1 4200
    set path2 "/bar"
    set service2 "service2"
    set port2 8080
    set output_file "ingress-fanout.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
spec:
  rules:
  - host: $host
    http:
      paths:
      - path: $path1
        pathType: Prefix
        backend:
          service:
            name: $service1
            port:
              number: $port1
      - path: $path2
        pathType: Prefix
        backend:
          service:
            name: $service2
            port:
              number: $port2
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-ingress-virtual-host
    set ingress_name "name-virtual-host-ingress"
    set host1 "foo.bar.com"
    set path1 "/"
    set service1 "service1"
    set port1 80
    set host2 "bar.foo.com"
    set path2 "/"
    set service2 "service2"
    set port2 80
    set output_file "ingress-virtual-host.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
spec:
  rules:
  - host: $host1
    http:
      paths:
      - pathType: Prefix
        path: \"$path1\"
        backend:
          service:
            name: $service1
            port:
              number: $port1
  - host: $host2
    http:
      paths:
      - pathType: Prefix
        path: \"$path2\"
        backend:
          service:
            name: $service2
            port:
              number: $port2
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-ingress-no-third
    set ingress_name "name-virtual-host-ingress-no-third-host"

    set host1 "first.bar.com"
    set path1 "/"
    set service1 "service1"
    set port1 80

    set host2 "second.bar.com"
    set path2 "/"
    set service2 "service2"
    set port2 80

    set path3 "/"
    set service3 "service3"
    set port3 80

    set output_file "ingress-no-third.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
spec:
  rules:
  - host: $host1
    http:
      paths:
      - pathType: Prefix
        path: \"$path1\"
        backend:
          service:
            name: $service1
            port:
              number: $port1
  - host: $host2
    http:
      paths:
      - pathType: Prefix
        path: \"$path2\"
        backend:
          service:
            name: $service2
            port:
              number: $port2
  - http:
      paths:
      - pathType: Prefix
        path: \"$path3\"
        backend:
          service:
            name: $service3
            port:
              number: $port3
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-ingress-cilium
    set ingress_name "basic-ingress"
    set namespace "default"
    set ingress_class "cilium"

    set path1 "/details"
    set service1 "details"
    set port1 9080

    set path2 "/"
    set service2 "productpage"
    set port2 9080

    set output_file "basic-ingress.yaml"

    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  namespace: $namespace
spec:
  ingressClassName: $ingress_class
  rules:
  - http:
      paths:
      - path: $path1
        pathType: Prefix
        backend:
          service:
            name: $service1
            port:
              number: $port1
      - path: $path2
        pathType: Prefix
        backend:
          service:
            name: $service2
            port:
              number: $port2
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-gateway-with-httproute
    set gateway_class_name "example-class"
    set controller_name "example.com/gateway-controller"

    set gateway_name "example-gateway"
    set gateway_class_ref $gateway_class_name
    set listener_name "http"
    set listener_protocol "HTTP"
    set listener_port 80

    set httproute_name "example-httproute"
    set parent_gateway_name $gateway_name
    set hostname "www.example.com"
    set path_value "/login"
    set path_type "PathPrefix"
    set backend_service_name "example-svc"
    set backend_service_port 8080

    set output_file "gateway-with-httproute.yaml"

    echo "apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: $gateway_class_name
spec:
  controllerName: $controller_name

---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: $gateway_name
spec:
  gatewayClassName: $gateway_class_ref
  listeners:
  - name: $listener_name
    protocol: $listener_protocol
    port: $listener_port

---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: $httproute_name
spec:
  parentRefs:
  - name: $parent_gateway_name
  hostnames:
  - \"$hostname\"
  rules:
  - matches:
    - path:
        type: $path_type
        value: $path_value
    backendRefs:
    - name: $backend_service_name
      port: $backend_service_port
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


 function create-gateway-with-multiple-rules
    set gateway_class_name "example-class"
    set controller_name "example.com/gateway-controller"

    set gateway_name "example-gateway"
    set gateway_class_ref $gateway_class_name
    set listener_name "http"
    set listener_protocol "HTTP"
    set listener_port 80

    set httproute_name "example-httproute"
    set parent_gateway_name $gateway_name
    set hostname "www.example.com"

    set rule_paths "/login" "/details" "/products"
    set rule_path_types "PathPrefix" "PathPrefix" "Exact"
    set backend_service_names "login-svc" "details-svc" "products-svc"
    set backend_service_ports 8080 9080 5000

    set output_file "gateway-with-multiple-rules.yaml"

    echo "apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: $gateway_class_name
spec:
  controllerName: $controller_name

---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: $gateway_name
spec:
  gatewayClassName: $gateway_class_ref
  listeners:
  - name: $listener_name
    protocol: $listener_protocol
    port: $listener_port

---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: $httproute_name
spec:
  parentRefs:
  - name: $parent_gateway_name
  hostnames:
  - \"$hostname\"
  rules:" > $output_file

    for i in (seq (count $rule_paths))
        echo "  - matches:
    - path:
        type: (echo $rule_path_types[$i])
        value: (echo $rule_paths[$i])
    backendRefs:
    - name: (echo $backend_service_names[$i])
      port: (echo $backend_service_ports[$i])
" >> $output_file
    end
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-endpointslice
    set endpointslice_name "example-abc"
    set service_name "example"
    set address_type "IPv4"
    set port_name "http"
    set port_protocol "TCP"
    set port_number 80
    set endpoint_address "10.1.2.3"
    set endpoint_ready "true"
    set endpoint_hostname "pod-1"
    set endpoint_node "node-1"
    set endpoint_zone "us-west2-a"
    set output_file "endpointslice.yaml"

    echo "apiVersion: discovery.k8s.io/v1
kind: EndpointSlice
metadata:
  name: $endpointslice_name
  labels:
    kubernetes.io/service-name: $service_name
addressType: $address_type
ports:
  - name: $port_name
    protocol: $port_protocol
    port: $port_number
endpoints:
  - addresses:
      - \"$endpoint_address\"
    conditions:
      ready: $endpoint_ready
    hostname: $endpoint_hostname
    nodeName: $endpoint_node
    zone: $endpoint_zone
" > $output_file
    
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-serviceaccount-token-template
    set sa_name "myapp"
    set namespace "default"
    set duration "10m"
    set audience "https://example.com"
    set bound_kind "Secret"
    set bound_name "mysecret"
    set bound_uid "0d4691ed-659b-4935-a832-355f77ee47cc"
    set output_file "serviceaccount-token-template.yaml"

    echo "apiVersion: authentication.k8s.io/v1
kind: TokenRequest
metadata:
  name: $sa_name
  namespace: $namespace
spec:
  audiences:
    - $audience
  expirationSeconds: 600
  boundObjectRef:
    apiVersion: v1
    kind: $bound_kind
    name: $bound_name
    uid: $bound_uid" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


 function create-externalname-service-template
    set svc_name "my-ns"
    set external_name "bar.com"
    set namespace "default"
    set output_file "service-externalname-template.yaml"

    echo "apiVersion: v1
kind: Service
metadata:
  name: $svc_name
  namespace: $namespace
spec:
  type: ExternalName
  externalName: $external_name" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end
 
function create-tls-secret-template
    set secret_name "tls-secret"
    set cert_file "path/to/tls.cert"
    set key_file "path/to/tls.key"
    set output_file "tls-secret-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
type: kubernetes.io/tls
data:" > $output_file

    if test -f $cert_file
        set cert_b64 (base64 -i $cert_file | tr -d '\n')
        echo "  tls.crt: \"$cert_b64\"" >> $output_file
    end

    if test -f $key_file
        set key_b64 (base64 -i $key_file | tr -d '\n')
        echo "  tls.key: \"$key_b64\"" >> $output_file
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-tlsCertificate-ingress
    set ingress_name "ingress-wear-watch"
    set namespace "app-space"
    set annotation_rewrite "nginx.ingress.kubernetes.io/rewrite-target: /"
    set annotation_ssl "nginx.ingress.kubernetes.io/ssl-redirect: \"false\""
    set service1_name "wear-service"
    set service1_port "8080"
    set service1_path "/wear"
    set service2_name "video-service"
    set service2_port "8080"
    set service2_path "/stream"
    set path_type "Prefix"
    set tls_secret_name "local-domain-tls"
    set cert_cn "local.domain.name"
    set cert_days "365"
    set cert_key "cert.key"
    set cert_crt "cert.crt"
    set output_file "ingress-template.yaml"

    echo "🔹 Generating TLS certificate for $cert_cn"
    openssl req -x509 -nodes -days $cert_days -newkey rsa:2048 \
        -keyout $cert_key -out $cert_crt \
        -subj "/CN=$cert_cn/O=$cert_cn"

    echo "🔹 Creating TLS secret: $tls_secret_name in namespace: $namespace"
    kubectl -n $namespace create secret tls $tls_secret_name \
        --key $cert_key --cert $cert_crt

    echo "🔹 Creating Ingress: $ingress_name"
    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: \"false\"
  name: $ingress_name
  namespace: $namespace
spec:
  tls:
  - hosts:
    - $cert_cn
    secretName: $tls_secret_name
  rules:
  - http:
      paths:
      - backend:
          service:
            name: $service1_name
            port:
              number: $service1_port
        path: $service1_path
        pathType: $path_type
      - backend:
          service:
            name: $service2_name
            port:
              number: $service2_port
        path: $service2_path
        pathType: $path_type
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-ingress-traefic
    set deployment_name "my-custom-container"
    set replicas "1"
    set match_label_key "app"
    set match_label_value "nginx"
    set container_name "my-container"
    set image "ravindrasingh6969/my-app:latest"
    set image_pull_policy "Always"
    set container_port "80"

    set service_name "app-service"
    set service_type "ClusterIP"
    set service_port "80"
    set target_port "80"

    set ingress_name "foo"
    set ingress_class "traefik"
    set ingress_host "traefik.captainua.local"
    set ingress_path "/"
    set path_type "Prefix"
    set output_file "app-deployment-service-ingress.yaml"

    echo "---" > $output_file
    echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: $deployment_name
spec:
  replicas: $replicas
  selector:
    matchLabels:
      $match_label_key: $match_label_value
  template:
    metadata:
      labels:
        $match_label_key: $match_label_value
    spec:
      containers:
        - name: $container_name
          imagePullPolicy: $image_pull_policy
          image: $image
          ports:
            - containerPort: $container_port
" >> $output_file

    echo "---" >> $output_file
    echo "apiVersion: v1
kind: Service
metadata:
  name: $service_name
  labels:
    $match_label_key: $match_label_value
spec:
  type: $service_type
  selector:
    $match_label_key: $match_label_value
  ports:
    - protocol: TCP
      port: $service_port
      targetPort: $target_port
" >> $output_file

    echo "---" >> $output_file
    echo "apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  annotations:
    kubernetes.io/ingress.class: $ingress_class
    traefik.ingress.kubernetes.io/rule-type: PathPrefixStrip
    nginx.ingress.kubernetes.io/ssl-redirect: \"false\"
spec:
  ingressClassName: $ingress_class
  rules:
  - host: $ingress_host
    http:
      paths:
      - path: $ingress_path
        pathType: $path_type
        backend:
          service:
            name: $service_name
            port:
              number: $service_port
" >> $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-job
    set job_name "my-job-1"
    set image_name "nginx"
    set command_date "date"
    set backoff_limit "4"
    set parallelism "4"
    set completions "4"
    set ttl_seconds "300"
    set output_file "job-template.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
spec:
  backoffLimit: $backoff_limit
  parallelism: $parallelism
  completions: $completions
  ttlSecondsAfterFinished: $ttl_seconds
  template:
    metadata:
      labels:
        job: $job_name
    spec:
      containers:
      - name: $job_name
        image: $image_name
        command:
        - $command_date
        resources: {}
      restartPolicy: Never
status: {}" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-job-backoffLimit
    set job_name "pi"
    set namespace "default"
    set container_name "pi"
    set container_image "perl:5.34.0"
    set container_command '["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]'
    set restart_policy "Never"
    set backoff_limit 4
    set output_file "job-backoffLimit.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  template:
    spec:
      containers:
      - name: $container_name
        image: $container_image
        command: $container_command
      restartPolicy: $restart_policy
  backoffLimit: $backoff_limit
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

 function create-job-backoff-limit
    set job_name "job-backoff-limit-per-index-example"
    set namespace "default"
    set completions 10
    set parallelism 3
    set completion_mode "Indexed"
    set backoff_limit_per_index 1
    set max_failed_indexes 5
    set restart_policy "Never"
    set container_name "example"
    set container_image "python"
    set cmd1 "python3"
    set cmd2 "-c"
    set cmd3 "import os, sys\nprint(\"Hello world\")\nif int(os.environ.get(\"JOB_COMPLETION_INDEX\")) % 2 == 0:\n  sys.exit(1)"
    set output_file "job-backoff-limit.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  completions: $completions
  parallelism: $parallelism
  completionMode: $completion_mode
  backoffLimitPerIndex: $backoff_limit_per_index
  maxFailedIndexes: $max_failed_indexes
  template:
    spec:
      restartPolicy: $restart_policy
      containers:
      - name: $container_name
        image: $container_image
        command:
          - $cmd1
          - $cmd2
          - |
            $cmd3
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-job-pod-failure-policy
    set job_name "job-pod-failure-policy-example"
    set namespace "default"
    set completions 12
    set parallelism 3
    set restart_policy "Never"
    set backoff_limit 6
    set container_name "main"
    set container_image "docker.io/library/bash:5"
    set cmd "bash"
    set arg1 "-c"
    set arg2 "echo \"Hello world!\" && sleep 5 && exit 42"
    set failure_action_1 "FailJob"
    set failure_container_name "main"
    set failure_operator "In"
    set failure_values "[42]"
    set failure_action_2 "Ignore"
    set pod_condition_type "DisruptionTarget"
    set output_file "job-pod-failure-policy.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  completions: $completions
  parallelism: $parallelism
  template:
    spec:
      restartPolicy: $restart_policy
      containers:
      - name: $container_name
        image: $container_image
        command:
          - $cmd
        args:
          - $arg1
          - $arg2
  backoffLimit: $backoff_limit
  podFailurePolicy:
    rules:
    - action: $failure_action_1
      onExitCodes:
        containerName: $failure_container_name
        operator: $failure_operator
        values: $failure_values
    - action: $failure_action_2
      onPodConditions:
      - type: $pod_condition_type
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-job-success-policy
    # 🔹 Загальні змінні
    set job_name "job-success"
    set namespace "default"
    set parallelism 10
    set completions 10
    set completion_mode "Indexed"

    # 🔹 Success Policy
    set succeeded_indexes "0,2-3"
    set succeeded_count 1

    # 🔹 Контейнер
    set container_name "main"
    set container_image "python"
    set cmd "python3"
    set arg1 "-c"
    set arg2 "import os, sys
if os.environ.get(\"JOB_COMPLETION_INDEX\") == \"2\":
    sys.exit(0)
else:
    sys.exit(1)"

    set restart_policy "Never"
    set output_file "job-success-policy.yaml"

    # 🔹 Формування YAML
    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  parallelism: $parallelism
  completions: $completions
  completionMode: $completion_mode
  successPolicy:
    rules:
      - succeededIndexes: $succeeded_indexes
        succeededCount: $succeeded_count
  template:
    spec:
      containers:
      - name: $container_name
        image: $container_image
        command:
          - $cmd
        args:
          - $arg1
          - |
            $arg2
      restartPolicy: $restart_policy
" > $output_file

    # 🔹 Вивід результату
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-job-success-policy
    set job_name "job-success"
    set namespace "default"
    set parallelism 10
    set completions 10
    set completion_mode "Indexed"
    set succeeded_indexes "0,2-3"
    set succeeded_count 1
    set container_name "main"
    set container_image "python"
    set cmd "python3"
    set arg1 "-c"
    set arg2 "import os, sys
if os.environ.get(\"JOB_COMPLETION_INDEX\") == \"2\":
    sys.exit(0)
else:
    sys.exit(1)"
    set restart_policy "Never"
    set output_file "job-success-policy.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  parallelism: $parallelism
  completions: $completions
  completionMode: $completion_mode
  successPolicy:
    rules:
      - succeededIndexes: $succeeded_indexes
        succeededCount: $succeeded_count
  template:
    spec:
      containers:
      - name: $container_name
        image: $container_image
        command:
          - $cmd
        args:
          - $arg1
          - |
            $arg2
      restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-job-activeDeadlineSecond
    set job_name "pi-with-timeout"
    set namespace "default"
    set backoff_limit 5
    set active_deadline_second:s 100
    set ttl_seconds_after_finished 100
    set container_name "pi"
    set container_image "perl:5.34.0"
    set cmd "perl"
    set args "-Mbignum=bpi" "-wle" "print bpi(2000)"
    set restart_policy "Never"
    set output_file "job.yaml"

    echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
  namespace: $namespace
spec:
  backoffLimit: $backoff_limit
  activeDeadlineSeconds: $active_deadline_seconds
  ttlSecondsAfterFinished: $ttl_seconds_after_finished
  template:
    spec:
      containers:
      - name: $container_name
        image: $container_image
        command:
          - $cmd
        args:
          - $args[1]
          - $args[2]
          - $args[3]
      restartPolicy: $restart_policy
" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-job-template
    set job_name "my-job"
    set image "busybox"
    set command "date"              # Можна задати список команд, наприклад: "sh -c 'echo hello'"
    set from_cronjob ""             # Якщо створюємо Job з CronJob, вкажи: "a-cronjob"
    set output_file "job-template.yaml"

    if test -n "$from_cronjob"
        echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
spec:
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: $job_name
        image: $image
        command: [\"/bin/sh\", \"-c\", \"echo From CronJob $from_cronjob\"]" > $output_file
    else
        echo "apiVersion: batch/v1
kind: Job
metadata:
  name: $job_name
spec:
  template:
    spec:
      restartPolicy: OnFailure
      containers:
      - name: $job_name
        image: $image
        command: [\"sh\", \"-c\", \"$command\"]" > $output_file
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-cronjob-template
    set job_name "my-job"
    set image "busybox"
    set schedule "*/1 * * * *"
    set command "date"
    set output_file "cronjob-template.yaml"

    echo "apiVersion: batch/v1
kind: CronJob
metadata:
  name: $job_name
spec:
  schedule: \"$schedule\"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: $job_name
            image: $image
            command: [\"sh\", \"-c\", \"$command\"]
          restartPolicy: OnFailure" > $output_file

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function create-cronjob
    set cronjob_name "my-cronjob-1"
    set image_name "nginx"
    set completions "3"
    set parallelism "3"
    set backoff_limit "25"
    set active_deadline_seconds "20"
    set starting_deadline_seconds "10"
    set concurrency_policy "Forbid"  # варіанти: Allow, Forbid, Replace
    set schedule "00 00 * * *"
    set output_file "cronjob-template.yaml"

    echo "apiVersion: batch/v1
kind: CronJob
metadata:
  creationTimestamp: null
  name: $cronjob_name
spec:
  schedule: \"$schedule\"
  concurrencyPolicy: $concurrency_policy
  jobTemplate:
    metadata:
      creationTimestamp: null
      name: $cronjob_name
    spec:
      completions: $completions
      parallelism: $parallelism
      backoffLimit: $backoff_limit
      activeDeadlineSeconds: $active_deadline_seconds
      startingDeadlineSeconds: $starting_deadline_seconds
      template:
        metadata:
          creationTimestamp: null
        spec:
          containers:
          - name: $cronjob_name
            image: $image_name
            resources: {}
          restartPolicy: OnFailure
status: {}" > $output_file

    echo -n ''
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-pdb-template
    set pdb_name "my-pdb"
    set selector "app=rails"
    set min_available "1"       # Можна замінити на відсоток "50%"
    set max_unavailable ""      # Альтернатива min_available, якщо потрібен

    set output_file "pdb-template.yaml"

    echo "apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: $pdb_name
spec:
  selector:
    matchLabels:
      $(string replace "=" ": " $selector)" > $output_file

    if test -n "$min_available"
        echo "  minAvailable: $min_available" >> $output_file
    end

    if test -n "$max_unavailable"
        echo "  maxUnavailable: $max_unavailable" >> $output_file
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-priorityclass-template
    set class_name "high-priority"
    set value 1000
    set description "high priority"
    set global_default "false"      # "true" якщо це глобальний дефолт
    set preemption_policy ""        # "Never" або залишити пустим

    set output_file "priorityclass-template.yaml"

    echo "apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: $class_name
value: $value
description: \"$description\"" > $output_file

    if test "$global_default" = "true"
        echo "globalDefault: true" >> $output_file
    end

    if test -n "$preemption_policy"
        echo "preemptionPolicy: $preemption_policy" >> $output_file
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-resourcequota
    set quota_name "my-quota"
    set namespace "default"
    set hard_rules "cpu=1 memory=1G pods=2 services=3 replicationcontrollers=2 resourcequotas=1 secrets=5 persistentvolumeclaims=10"
    set scopes ""  # Наприклад: "BestEffort" або залиш пустим
    set output_file "resourcequota-template.yaml"

    echo "apiVersion: v1
kind: ResourceQuota
metadata:
  name: $quota_name
  namespace: $namespace
spec:" > $output_file

    echo "  hard:" >> $output_file
    for rule in $hard_rules
        set key (string split '=' $rule)[1]
        set value (string split '=' $rule)[2]
        echo "    $key: \"$value\"" >> $output_file
    end

    if test -n "$scopes"
        echo "  scopes:" >> $output_file
        for s in (string split " " $scopes)
            echo "  - $s" >> $output_file
        end
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function create-docker-secret-template
    set secret_name "my-secret"
    set docker_server "DOCKER_REGISTRY_SERVER"
    set docker_user "DOCKER_USER"
    set docker_password "DOCKER_PASSWORD"
    set docker_email "DOCKER_EMAIL"
    set docker_config_file "~/.docker/config.json"  # використовуйте для другого варіанту
    set output_file "docker-secret-template.yaml"

    echo "apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
type: kubernetes.io/dockerconfigjson
data:" > $output_file

    if test -f $docker_config_file
        set base64_data (base64 -i $docker_config_file | tr -d '\n')
        echo "  .dockerconfigjson: \"$base64_data\"" >> $output_file
    else
        set auth (echo -n "$docker_user:$docker_password" | base64)
        set docker_json "{\"auths\":{\"$docker_server\":{\"username\":\"$docker_user\",\"password\":\"$docker_password\",\"email\":\"$docker_email\",\"auth\":\"$auth\"}}}"
        set docker_json_b64 (echo -n $docker_json | base64)
        echo "  .dockerconfigjson: \"$docker_json_b64\"" >> $output_file
    end

    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

