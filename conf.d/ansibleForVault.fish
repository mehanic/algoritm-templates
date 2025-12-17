function vault.vault_write
    set output_file "community.hashi_vault_vault.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Write a value to the cubbyhole via the remote host with userpass auth
      community.hashi_vault.vault_write:
        url: https://vault:8201
        path: cubbyhole/mysecret
        data:
          key1: val1
          key2: val2
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: result

    - name: Display the result of the write (this can be empty)
      ansible.builtin.debug:
        msg: \"{{ result.data }}\"

    - name: Write secret to Vault using key value V2 engine
      community.hashi_vault.vault_write:
        path: secret/data/mysecret
        data:
          data:
            key1: val1
            key2: val2

    - name: Retrieve an approle role ID from Vault via the remote host
      community.hashi_vault.vault_read:
        url: https://vault:8201
        path: auth/approle/role/role-name/role-id
      register: approle_id

    - name: Generate a secret-id for the given approle
      community.hashi_vault.vault_write:
        url: https://vault:8201
        path: auth/approle/role/role-name/secret-id
      register: secret_id

    - name: Display the role ID and secret ID
      ansible.builtin.debug:
        msg:
          - \"role-id: {{ approle_id.data.data.role_id }}\"
          - \"secret-id: {{ secret_id.data.data.secret_id }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_token
    set output_file "community.hashi_vault_vault_token.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Login via userpass and create a child token
      community.hashi_vault.vault_token_create:
        url: https://vault:8201
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: token_data

    - name: Retrieve an approle role ID using the child token (token via filter)
      community.hashi_vault.vault_read:
        url: https://vault:8201
        auth_method: token
        token: '{{ token_data | community.hashi_vault.vault_login_token }}'
        path: auth/approle/role/role-name/role-id
      register: approle_id

    - name: Retrieve an approle role ID using the child token (token via direct dict access)
      community.hashi_vault.vault_read:
        url: https://vault:8201
        auth_method: token
        token: '{{ token_data.login.auth.client_token }}'
        path: auth/approle/role/role-name/role-id
      register: approle_id

    - name: Create an orphaned token with a short TTL
      community.hashi_vault.vault_token_create:
        url: https://vault:8201
        orphan: true
        ttl: 60s
      register: token_data

    - name: Display the full response
      ansible.builtin.debug:
        var: token_data.login
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_read
    set output_file "community.hashi_vault_vault_read.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Read a kv2 secret from Vault via the remote host with userpass auth
      community.hashi_vault.vault_read:
        url: https://vault:8201
        path: secret/data/hello
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: secret

    - name: Display the secret data
      ansible.builtin.debug:
        msg: \"{{ secret.data.data.data }}\"

    - name: Retrieve an approle role ID from Vault via the remote host
      community.hashi_vault.vault_read:
        url: https://vault:8201
        path: auth/approle/role/role-name/role-id
      register: approle_id

    - name: Display the role ID
      ansible.builtin.debug:
        msg: \"{{ approle_id.data.data.role_id }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_login
    set output_file "community.hashi_vault_vault_pki.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Login and use the resulting token
      community.hashi_vault.vault_login:
        url: https://localhost:8200
        auth_method: ldap
        username: \"john.doe\"
        password: \"{{ user_passwd }}\"
      register: login_data

    - name: Generate a certificate with an existing token
      community.hashi_vault.vault_pki_generate_certificate:
        role_name: test.example.org
        common_name: test.example.org
        ttl: 8760h
        alt_names:
          - test2.example.org
          - test3.example.org
        url: https://vault:8201
        auth_method: token
        token: \"{{ login_data.login.auth.client_token }}\"
      register: cert_data

    - name: Display generated certificate
      ansible.builtin.debug:
        msg: \"{{ cert_data.data.data.certificate }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_login1
    set output_file "community.hashi_vault_vault_login.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Login and use the resulting token
      community.hashi_vault.vault_login:
        url: https://vault:8201
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: login_data

    - name: Retrieve an approle role ID (token via filter)
      community.hashi_vault.vault_read:
        url: https://vault:8201
        auth_method: token
        token: '{{ login_data | community.hashi_vault.vault_login_token }}'
        path: auth/approle/role/role-name/role-id
      register: approle_id

    - name: Retrieve an approle role ID (token via direct dict access)
      community.hashi_vault.vault_read:
        url: https://vault:8201
        auth_method: token
        token: '{{ login_data.login.auth.client_token }}'
        path: auth/approle/role/role-name/role-id
      register: approle_id
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_list
    set output_file "community.hashi_vault_vault_list.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: List kv2 secrets from Vault via the remote host with userpass auth
      community.hashi_vault.vault_list:
        url: https://vault:8201
        path: secret/metadata
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: secret

    - name: Display the secrets found at the path provided above
      ansible.builtin.debug:
        msg: \"{{ secret.data.data['keys'] }}\"

    - name: List access policies from Vault via the remote host
      community.hashi_vault.vault_list:
        url: https://vault:8201
        path: sys/policies/acl
      register: policies

    - name: Display the policy names
      ansible.builtin.debug:
        msg: \"{{ policies.data.data['keys'] }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function vault.vault_kv2_write
    set output_file "community.hashi_vault_kv2.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Write/create a secret
      community.hashi_vault.vault_kv2_write:
        url: https://vault:8200
        path: hello
        data:
          foo: bar

    - name: Create a secret with CAS (the secret must not exist)
      community.hashi_vault.vault_kv2_write:
        url: https://vault:8200
        path: caspath
        cas: 0
        data:
          foo: bar

    - name: Update a secret with CAS
      community.hashi_vault.vault_kv2_write:
        url: https://vault:8200
        path: caspath
        cas: 2
        data:
          hello: world

    - name: Retrieve current secret
      community.hashi_vault.vault_kv2_get:
        url: https://vault:8200
        path: hello
      register: current

    ## patch without CAS
    - name: Update the secret
      vars:
        values_to_update:
          foo: baz
          hello: goodbye
      community.hashi_vault.vault_kv2_write:
        url: https://vault:8200
        path: hello
        data: >-
          {{
            current.secret
            | combine(values_to_update)
          }}

    ## patch with CAS
    - name: Update the secret
      vars:
        values_to_update:
          foo: baz
          hello: goodbye
      community.hashi_vault.vault_kv2_write:
        url: https://vault:8200
        path: hello
        cas: '{{ current.metadata.version | int }}'
        data: >-
          {{
            current.secret
            | combine(values_to_update)
          }}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function vault.vault_kv2_get
    set output_file "community.hashi_vault_kv2_get.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Read the latest version of a kv2 secret from Vault via the remote host with userpass auth
      community.hashi_vault.vault_kv2_get:
        url: https://vault:8201
        path: hello
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: response
      # equivalent API path is secret/data/hello

    - name: Display the results
      ansible.builtin.debug:
        msg:
          - \"Secret: {{ response.secret }}\"
          - \"Data: {{ response.data }} (contains secret data & metadata in kv2)\"
          - \"Metadata: {{ response.metadata }}\"
          - \"Full response: {{ response.raw }}\"
          - \"Value of key 'password' in the secret: {{ response.secret.password }}\"

    - name: Read version 5 of a secret from kv2 with a different mount via the remote host
      community.hashi_vault.vault_kv2_get:
        url: https://vault:8201
        engine_mount_point: custom/kv2/mount
        path: hello
        version: 5
      register: response
      # equivalent API path is custom/kv2/mount/data/hello

    - name: Assert that the version returned is as expected
      ansible.builtin.assert:
        that:
          - response.metadata.version == 5
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_kv2_delete
    set output_file "community.hashi_vault_kv2_delete.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Delete the latest version of the secret/mysecret secret
      community.hashi_vault.vault_kv2_delete:
        url: https://vault:8201
        path: secret/mysecret
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: result

    - name: Display result of latest secret deletion
      ansible.builtin.debug:
        var: result

    - name: Delete versions 1 and 3 of the secret/mysecret secret
      community.hashi_vault.vault_kv2_delete:
        url: https://vault:8201
        path: secret/mysecret
        versions: [1, 3]
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: result_old_versions

    - name: Display result of versioned secret deletion
      ansible.builtin.debug:
        var: result_old_versions
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_kv1_get
    set output_file "community_hashi_vault_kv1_get.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Read a kv1 secret from Vault via the remote host with userpass auth
      community.hashi_vault.vault_kv1_get:
        url: https://vault:8201
        path: hello
        auth_method: userpass
        username: user
        password: '{{ passwd }}'
      register: response
      # equivalent API path is kv/hello

    - name: Display the results
      ansible.builtin.debug:
        msg:
          - 'Secret: {{ response.secret }}'
          - 'Data: {{ response.data }} (same as secret in kv1)'
          - 'Metadata: {{ response.metadata }} (response info in kv1)'
          - 'Full response: {{ response.raw }}'
          - 'Value of key password in the secret: {{ response.secret.password }}'

    - name: Read a secret from kv1 with a different mount via the remote host
      community.hashi_vault.vault_kv1_get:
        url: https://vault:8201
        engine_mount_point: custom/kv1/mount
        path: hello
      register: response
      # equivalent API path is custom/kv1/mount/hello

    - name: Display the results
      ansible.builtin.debug:
        msg:
          - 'Secret: {{ response.secret }}'
          - 'Data: {{ response.data }} (same as secret in kv1)'
          - 'Metadata: {{ response.metadata }} (response info in kv1)'
          - 'Full response: {{ response.raw }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_static_roles_list
    set output_file "community_hashi_vault_database_static_roles_list.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: List static roles with the default mount point
      community.hashi_vault.vault_database_static_roles_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
      register: response

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ response }}'

    - name: List static roles with a custom mount point
      community.hashi_vault.vault_database_static_roles_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
      register: response

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ response }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_static_role_rotate_credentials
    set output_file "community_hashi_vault_database_static_role_rotate_credentials.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Rotate credentials of a static role with the default mount point
      community.hashi_vault.vault_database_static_role_rotate_credentials:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Rotate credentials of a static role with a custom mount point
      community.hashi_vault.vault_database_static_role_rotate_credentials:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_static_role_read
    set output_file "community_hashi_vault_database_static_role_read.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Read Static Role with a default mount point
      community.hashi_vault.vault_database_static_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Read Static Role with a custom mount point
      community.hashi_vault.vault_database_static_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_static_role_read
    set output_file "community_hashi_vault_database_static_role_read_credentials.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Returns the current credentials based on the named static role with the default mount point
      community.hashi_vault.vault_database_static_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Returns the current credentials based on the named static role with a custom mount point
      community.hashi_vault.vault_database_static_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function vault.vault_database_static_role_create
    set output_file "community_hashi_vault_database_static_role_create.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
    db_username: db_user
  tasks:

    - name: Generate rotation statement
      ansible.builtin.set_fact:
        rotation_statements: [\"ALTER USER \\\"{{ name }}\\\" WITH PASSWORD '{{ password }}';\"]

    - name: Create / update Static Role with the default mount point
      community.hashi_vault.vault_database_static_role_create:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeConnection
        role_name: SomeRole
        db_username: '{{ db_username }}'
        rotation_statements: '{{ rotation_statements }}'
      register: response

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ response }}'

    - name: Create / update Static Role with a custom mount point
      community.hashi_vault.vault_database_static_role_create:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: SomeConnection
        role_name: SomeRole
        db_username: '{{ db_username }}'
        rotation_statements: '{{ rotation_statements }}'
      register: response

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ response }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function vault.vault_database_rotate_root_credentials
    set output_file "community_hashi_vault_database_rotate_root_credentials.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Trigger root credential rotation with the default mount point
      community.hashi_vault.vault_database_rotate_root_credentials:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Trigger root credential rotation with a custom mount point
      community.hashi_vault.vault_database_rotate_root_credentials:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_roles_list
    set output_file "community_hashi_vault_database_roles_list.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: List all roles with the default mount point
      community.hashi_vault.vault_database_roles_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: List all roles with a custom mount point
      community.hashi_vault.vault_database_roles_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function vault.vault_database_role_read
    set output_file "community_hashi_vault_database_role_read.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Read Role with a default mount point
      community.hashi_vault.vault_database_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Read Role with a custom mount point
      community.hashi_vault.vault_database_role_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function vault.vault_database_role_delete
    set output_file "community_hashi_vault_database_role_delete.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Delete a Role with the default mount point
      community.hashi_vault.vault_database_role_delete:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Delete a Role with a custom mount point
      community.hashi_vault.vault_database_role_delete:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_path: db1
        role_name: SomeRole
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function vault.vault_database_role_create
    set output_file "community_hashi_vault_database_role_create.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
    db_username: my_db_user
  tasks:

    - name: Generate creation statement
      ansible.builtin.set_fact:
        creation_statements:
          - \"CREATE ROLE \\\"{{name}}\\\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';\"
          - \"GRANT SELECT ON ALL TABLES IN SCHEMA public TO \\\"{{name}}\\\";\"

    - name: Create / update Role with the default mount point
      community.hashi_vault.vault_database_role_create:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeConnection
        role_name: SomeRole
        db_username: '{{ db_username }}'
        creation_statements: '{{ creation_statements }}'
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Create / update Role with a custom mount point
      community.hashi_vault.vault_database_role_create:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: SomeConnection
        role_name: SomeRole
        db_username: '{{ db_username }}'
        creation_statements: '{{ creation_statements }}'
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.vault_database_connections_list
    set output_file "community_hashi_vault_database_connections_list.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: List Database Connections with the default mount point
      community.hashi_vault.vault_database_connections_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: List Database Connections with a custom mount point
      community.hashi_vault.vault_database_connections_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function vault.vault_database_connections_list
    set output_file "community_hashi_vault_database_connections_list.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: List Database Connections with the default mount point
      community.hashi_vault.vault_database_connections_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: List Database Connections with a custom mount point
      community.hashi_vault.vault_database_connections_list:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.vault_database_connection_reset
    set output_file "community_hashi_vault_database_connection_reset.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Reset a Database Connection with the default mount point
      community.hashi_vault.vault_database_connection_reset:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Reset a Database Connection with a custom mount point
      community.hashi_vault.vault_database_connection_reset:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.vault_database_connection_read
    set output_file "community_hashi_vault_database_connection_read.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Read a Database Connection with the default mount point
      community.hashi_vault.vault_database_connection_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Read a Database Connection with a custom mount point
      community.hashi_vault.vault_database_connection_read:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.vault_database_connection_delete
    set output_file "community_hashi_vault_database_connection_delete.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Delete a Database Connection with the default mount point
      community.hashi_vault.vault_database_connection_delete:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Delete a Database Connection with a custom mount point
      community.hashi_vault.vault_database_connection_delete:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: SomeName
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.vault_database_connection_configure
    set output_file "community_hashi_vault_database_connection_configure.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    user: vault_user
    passwd: vault_password
  tasks:

    - name: Create a new Database Connection with the default mount point
      community.hashi_vault.vault_database_connection_configure:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        connection_name: MyName
        plugin_name: postgresql-database-plugin
        connection_url: postgresql://{{'{{username}}'}}:{{'{{password}}'}}@postgres:5432/postgres?sslmode=disable
        connection_username: SomeUser
        connection_password: SomePass
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'

    - name: Create a new Database Connection with a custom mount point
      community.hashi_vault.vault_database_connection_configure:
        url: https://vault:8201
        auth_method: userpass
        username: '{{ user }}'
        password: '{{ passwd }}'
        engine_mount_point: db1
        connection_name: MyName
        plugin_name: postgresql-database-plugin
        connection_url: postgresql://{{'{{username}}'}}:{{'{{password}}'}}@postgres:5432/postgres?sslmode=disable
        connection_username: SomeUser
        connection_password: SomePass
      register: result

    - name: Display the result of the operation
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.amazon_aws_backup_vault
    set output_file "amazon_aws_backup_vault.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    aws_access_key: YOUR_AWS_ACCESS_KEY
    aws_secret_key: YOUR_AWS_SECRET_KEY
    aws_region: us-west-2
  tasks:

    - name: Create backup vault
      amazon.aws.backup_vault:
        state: present
        backup_vault_name: default-vault
        encryption_key_arn: arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab
        tags:
          environment: dev
          Name: default
        region: '{{ aws_region }}'
        access_key: '{{ aws_access_key }}'
        secret_key: '{{ aws_secret_key }}'
      register: result

    - name: Display result
      ansible.builtin.debug:
        msg: '{{ result }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.amazon_aws_backup_vault_info
    set output_file "amazon_aws_backup_vault_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    aws_access_key: YOUR_AWS_ACCESS_KEY
    aws_secret_key: YOUR_AWS_SECRET_KEY
    aws_region: us-west-2
  tasks:

    - name: Gather information about all backup vaults
      amazon.aws.backup_vault_info:
        region: '{{ aws_region }}'
        access_key: '{{ aws_access_key }}'
        secret_key: '{{ aws_secret_key }}'
      register: all_vaults

    - name: Display all vaults info
      ansible.builtin.debug:
        msg: '{{ all_vaults.backup_vaults }}'

    - name: Gather information about a specific backup vault
      amazon.aws.backup_vault_info:
        backup_vault_names:
          - 'arn:aws:backup_vault:us-east-2:123456789012:backup_vault/defaultvault'
        region: '{{ aws_region }}'
        access_key: '{{ aws_access_key }}'
        secret_key: '{{ aws_secret_key }}'
      register: specific_vault

    - name: Display specific vault info
      ansible.builtin.debug:
        msg: '{{ specific_vault.backup_vaults }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function vault.community_general_ipa_vault
    set output_file "community_general_ipa_vault.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    ipa_host: ipa.example.com
    ipa_user: admin
    ipa_pass: topsecret
    vault_name: vault01
    vault_user: user01
  tasks:

    - name: Ensure vault is present
      community.general.ipa_vault:
        name: '{{ vault_name }}'
        vault_type: standard
        user: '{{ vault_user }}'
        ipa_host: '{{ ipa_host }}'
        ipa_user: '{{ ipa_user }}'
        ipa_pass: '{{ ipa_pass }}'

    - name: Ensure vault is present for Admin user
      community.general.ipa_vault:
        name: '{{ vault_name }}'
        vault_type: standard
        ipa_host: '{{ ipa_host }}'
        ipa_user: '{{ ipa_user }}'
        ipa_pass: '{{ ipa_pass }}'

    - name: Ensure vault is absent
      community.general.ipa_vault:
        name: '{{ vault_name }}'
        vault_type: standard
        user: '{{ vault_user }}'
        state: absent
        ipa_host: '{{ ipa_host }}'
        ipa_user: '{{ ipa_user }}'
        ipa_pass: '{{ ipa_pass }}'

    - name: Modify vault if already exists
      community.general.ipa_vault:
        name: '{{ vault_name }}'
        vault_type: standard
        description: 'Vault for test'
        ipa_host: '{{ ipa_host }}'
        ipa_user: '{{ ipa_user }}'
        ipa_pass: '{{ ipa_pass }}'
        replace: true

    - name: Get vault info if already exists
      community.general.ipa_vault:
        name: '{{ vault_name }}'
        ipa_host: '{{ ipa_host }}'
        ipa_user: '{{ ipa_user }}'
        ipa_pass: '{{ ipa_pass }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

