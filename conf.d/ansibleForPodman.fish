function podman.podman_container
    set output_file "containers_podman_container.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Run container
      containers.podman.podman_container:
        name: container
        image: quay.io/bitnami/wildfly
        state: started

    - name: Create a data container
      containers.podman.podman_container:
        name: mydata
        image: busybox
        volume:
          - /tmp/data

    - name: Re-create a redis container with systemd service file generated in /tmp/
      containers.podman.podman_container:
        name: myredis
        image: redis
        command: redis-server --appendonly yes
        state: present
        recreate: true
        expose:
          - 6379
        volumes_from:
          - mydata
        generate_systemd:
          path: /tmp/
          restart_policy: always
          stop_timeout: 120
          names: true
          container_prefix: ainer

    - name: Restart a container
      containers.podman.podman_container:
        name: myapplication
        image: redis
        state: started
        restart: true
        etc_hosts:
            other: '127.0.0.1'
        restart_policy: 'no'
        device: '/dev/sda:/dev/xvda:rwm'
        ports:
            - '8080:9000'
            - '127.0.0.1:8081:9001/udp'
        env:
            SECRET_KEY: 'ssssh'
            BOOLEAN_KEY: 'yes'

    - name: Container present
      containers.podman.podman_container:
        name: mycontainer
        state: present
        image: ubuntu:14.04
        command: 'sleep 1d'

    - name: Stop a container
      containers.podman.podman_container:
        name: mycontainer
        state: stopped

    - name: Start 4 load-balanced containers
      containers.podman.podman_container:
        name: 'container{{ item }}'
        recreate: true
        image: someuser/anotherappimage
        command: sleep 1d
      with_sequence: count=4

    - name: Remove container
      containers.podman.podman_container:
        name: ohno
        state: absent

    - name: Writing output
      containers.podman.podman_container:
        name: myservice
        image: busybox
        log_options: path=/var/log/container/mycontainer.json
        log_driver: k8s-file

    - name: Run container with complex command with quotes
      containers.podman.podman_container:
        name: mycontainer
        image: certbot/certbot
        command:
          - renew
          - --deploy-hook
          - 'echo 1 > /var/lib/letsencrypt/complete'

    - name: Create a Quadlet file
      containers.podman.podman_container:
        name: quadlet-container
        image: nginx
        state: quadlet
        quadlet_filename: custome-container
        quadlet_file_mode: '0640'
        device: '/dev/sda:/dev/xvda:rwm'
        ports:
          - '8080:80'
        volumes:
          - '/var/www:/usr/share/nginx/html'
        quadlet_options:
          - 'AutoUpdate=registry'
          - 'Pull=newer'
          - |
            [Install]
            WantedBy=default.target
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.container.copy_example
    set output_file "containers_podman_container_copy.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Copy file 'test.yml' on the host to the 'apache' container's root folder
      containers.podman.podman_container_copy:
        src: test.yml
        dest: /
        container: apache

    - name: Copy file 'test.yml' in the 'apache' container's root folder to the playbook's folder
      containers.podman.podman_container_copy:
        src: /test.yml
        dest: ./
        container: apache
        from_container: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.container.exec
    set output_file "containers_podman_container_exec.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Execute a command with workdir
      containers.podman.podman_container_exec:
        name: ubi8
        command: \"cat redhat-release\"
        workdir: /etc

    - name: Execute a command with a list of args and environment variables
      containers.podman.podman_container_exec:
        name: test_container
        argv:
          - /bin/sh
          - -c
          - echo \$HELLO \$BYE
        env:
          HELLO: hello world
          BYE: goodbye world

    - name: Execute command in background by using detach
      containers.podman.podman_container_exec:
        name: detach_container
        command: \"cat redhat-release\"
        detach: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman_container.info
    set output_file "containers_podman_container_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Gather facts for all containers
      containers.podman.podman_container_info:

    - name: Gather facts on a specific container
      containers.podman.podman_container_info:
        name: web1

    - name: Gather facts on several containers
      containers.podman.podman_container_info:
        name:
          - redis
          - web1
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.containers
    set output_file "podman_containers.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Run three containers at once
      podman_containers:
        containers:
          - name: alpine
            image: alpine
            command: sleep 1d
          - name: web
            image: nginx
          - name: test
            image: python:3.10-alpine
            command: python -V
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.export.example
    set output_file "containers_podman_export.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Export a container to a tar file
      containers.podman.podman_export:
        container: container-name
        dest: /path/to/tar/file

    - name: Export a volume to a tar file
      containers.podman.podman_export:
        volume: volume-name
        dest: /path/to/tar/file
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function podman.generate.systemd_example
    set output_file "containers_podman_generate_systemd.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Create postgres container with rm:true for idempotence
    - name: Create postgres container
      containers.podman.podman_container:
        name: postgres
        image: docker.io/library/postgres:latest
        rm: true
        state: created

    - name: Generate systemd unit file for postgres container
      containers.podman.podman_generate_systemd:
        name: postgres
        new: true
        no_header: true
        dest: /etc/systemd/system

    - name: Ensure postgres container is started and enabled
      ansible.builtin.systemd:
        name: container-postgres
        daemon_reload: true
        state: started
        enabled: true

    # Create a stopped container and integrate into systemd
    - name: A postgres container must exist, stopped
      containers.podman.podman_container:
        name: postgres_local
        image: docker.io/library/postgres:latest
        state: stopped

    - name: Systemd unit files for postgres container must exist
      containers.podman.podman_generate_systemd:
        name: postgres_local
        dest: ~/.config/systemd/user/

    - name: Postgres container must be started and enabled on systemd
      ansible.builtin.systemd:
        name: container-postgres_local
        scope: user
        daemon_reload: true
        state: started
        enabled: true

    # Generate systemd unit files into a variable
    - name: Systemd unit files for postgres container must be generated
      containers.podman.podman_generate_systemd:
        name: postgres_local
      register: postgres_local_systemd_unit

    # Generate unit files with environment variables
    - name: Systemd unit files for postgres container must be generated
      containers.podman.podman_generate_systemd:
        name: postgres_local
        env:
          POSTGRES_USER: my_app
          POSTGRES_PASSWORD: example
      register: postgres_local_systemd_unit
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_image
    set output_file "containers_podman_image.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    vault_registry_password: mysecret
  tasks:

    - name: Pull an image
      containers.podman.podman_image:
        name: quay.io/bitnami/wildfly

    - name: Remove an image
      containers.podman.podman_image:
        name: quay.io/bitnami/wildfly
        state: absent

    - name: Remove an image with image id
      containers.podman.podman_image:
        name: 0e901e68141f
        state: absent

    - name: Pull a specific version of an image
      containers.podman.podman_image:
        name: redis
        tag: 4

    - name: Build a basic OCI image
      containers.podman.podman_image:
        name: nginx
        path: /path/to/build/dir

    - name: Build a basic OCI image with advanced parameters
      containers.podman.podman_image:
        name: nginx
        path: /path/to/build/dir
        build:
          cache: no
          force_rm: true
          format: oci
          annotation:
            app: nginx
            function: proxy
            info: Load balancer for my cool app
          extra_args: \"--build-arg KEY=value\"

    - name: Build a Docker formatted image
      containers.podman.podman_image:
        name: nginx
        path: /path/to/build/dir
        build:
          format: docker

    - name: Build and push an image using existing credentials
      containers.podman.podman_image:
        name: nginx
        path: /path/to/build/dir
        push: true
        push_args:
          dest: quay.io/acme

    - name: Build and push an image using an auth file
      containers.podman.podman_image:
        name: nginx
        push: true
        auth_file: /etc/containers/auth.json
        push_args:
          dest: quay.io/acme

    - name: Build and push an image using username and password
      containers.podman.podman_image:
        name: nginx
        push: true
        username: bugs
        password: \"{{ vault_registry_password }}\"
        push_args:
          dest: quay.io/acme

    - name: Build and push an image to multiple registries
      containers.podman.podman_image:
        name: \"{{ item }}\"
        path: /path/to/build/dir
        push: true
        auth_file: /etc/containers/auth.json
      loop:
        - quay.io/acme/nginx
        - docker.io/acme/nginx

    - name: Build and push an image to multiple registries with separate parameters
      containers.podman.podman_image:
        name: \"{{ item.name }}\"
        tag: \"{{ item.tag }}\"
        path: /path/to/build/dir
        push: true
        auth_file: /etc/containers/auth.json
        push_args:
          dest: \"{{ item.dest }}\"
      loop:
        - name: nginx
          tag: 4
          dest: docker.io/acme
        - name: nginx
          tag: 3
          dest: docker.io/acme

    - name: Push image to a remote host via scp transport
      containers.podman.podman_image:
        name: testimage
        pull: false
        push: true
        push_args:
          dest: user@server
          transport: scp

    - name: Pull an image for a specific CPU architecture
      containers.podman.podman_image:
        name: nginx
        arch: amd64

    - name: Build a container from file inline
      containers.podman.podman_image:
        name: mycustom_image
        state: build
        build:
          container_file: |-
            FROM alpine:latest
            CMD echo \"Hello, World!\"

    - name: Create a quadlet file for an image
      containers.podman.podman_image:
        name: docker.io/library/alpine:latest
        state: quadlet
        quadlet_dir: /etc/containers/systemd
        quadlet_filename: alpine-latest
        quadlet_file_mode: '0640'
        quadlet_options:
          - Variant=arm/v7
          - |
            [Install]
            WantedBy=default.target
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function podman.image_info
    set output_file "containers_podman_image_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Gather info for all images
      containers.podman.podman_image_info:

    - name: Gather info on a specific image
      containers.podman.podman_image_info:
        name: nginx

    - name: Gather info on several images
      containers.podman.podman_image_info:
        name:
          - redis
          - quay.io/bitnami/wildfly
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_import
    set output_file "containers_podman_import.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Import an image from a tar file with changes
      containers.podman.podman_import:
        src: /path/to/tar/file
        change:
          - CMD: /bin/bash
          - User: root
        commit_message: \"Importing image\"

    - name: Import a volume from a tar file
      containers.podman.podman_import:
        src: /path/to/tar/file
        volume: myvolume
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.load
    set output_file "containers_podman_load.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Load an image from a tar file
      containers.podman.podman_load:
        input: /path/to/tar/file
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_login
    set output_file "containers_podman_login.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Login to default registry and create \${XDG_RUNTIME_DIR}/containers/auth.json
      containers.podman.podman_login:
        username: user
        password: 'p4ssw0rd'

    - name: Login to quay.io and create \${XDG_RUNTIME_DIR}/containers/auth.json
      containers.podman.podman_login:
        username: user
        password: 'p4ssw0rd'
        registry: quay.io

    - name: Login to quay.io using existing secret called password
      containers.podman.podman_login:
        username: user
        secret: password
        registry: quay.io
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function podman.podman_login_info
    set output_file "containers_podman_login_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Return the logged-in user for docker hub registry
      containers.podman.podman_login_info:
        registry: docker.io

    - name: Return the logged-in user for quay.io registry
      containers.podman.podman_login_info:
        registry: quay.io
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.logout
    set output_file "podman_logout.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Log out of default registry
      podman_logout:

    - name: Log out of quay.io
      podman_logout:
        registry: quay.io

    - name: Log out of all registries in auth file
      podman_logout:
        all: true

    - name: Log out of all registries in specified auth file
      podman_logout:
        authfile: $HOME/.docker/config.json
        all: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.network_network
    set output_file "podman_network.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Create a podman network
      containers.podman.podman_network:
        name: podman_network
      become: true

    - name: Create internal podman network
      containers.podman.podman_network:
        name: podman_internal
        internal: true
        ip_range: 192.168.22.128/25
        subnet: 192.168.22.0/24
        gateway: 192.168.22.1
      become: true

    - name: Create Quadlet file for podman network
      containers.podman.podman_network:
        name: podman_network
        state: quadlet
        quadlet_options:
          - IPv6=true
          - Label=\"ipv6 network\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.network_info
    set output_file "podman_network_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Gather info about all present networks
      containers.podman.podman_network_info:

    - name: Gather info about specific network
      containers.podman.podman_network_info:
        name: podman
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_play
    set output_file "podman_play.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Play kube file
      containers.podman.podman_play:
        kube_file: ~/kube.yaml
        state: started

    - name: Recreate pod from a kube file with options
      containers.podman.podman_play:
        kube_file: ~/kube.yaml
        state: started
        recreate: true
        annotations:
          greeting: hello
          greet_to: world
        userns: host
        log_opt:
          path: /tmp/my-container.log
          max_size: 10mb

    - name: Create a Quadlet file
      containers.podman.podman_play:
        kube_file: ~/kube.yaml
        state: quadlet
        annotations:
          greeting: hello
          greet_to: world
        userns: host
        quadlet_filename: kube-pod
        quadlet_file_mode: '0640'
        quadlet_options:
          - 'SetWorkingDirectory=yaml'
          - 'ExitCodePropagation=any'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_pod
    set output_file "podman_pod.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Start a pod with a mapped port
    - name: Start pod1 and map port 4444:5555
      containers.podman.podman_pod:
        name: pod1
        state: started
        ports:
          - '4444:5555'

    # Connect random port from localhost to port 80 on pod2
    - name: Connect random port from localhost to port 80 on pod2
      containers.podman.podman_pod:
        name: pod2
        state: started
        publish: '127.0.0.1::80'

    # Full workflow example with pod and containers
    - name: Create a pod with parameters
      containers.podman.podman_pod:
        name: mypod
        state: created
        network: host
        share: net
        userns: auto
        security_opt:
          - seccomp=unconfined
          - apparmor=unconfined
        hostname: mypod
        dns:
          - 1.1.1.1
        volumes:
          - /tmp:/tmp/:ro
        label:
          key: cval
          otherkey: kddkdk
          somekey: someval
        add_host:
          - 'google:5.5.5.5'

    - name: Create containers attached to the pod
      containers.podman.podman_container:
        name: '{{ item }}'
        state: created
        pod: mypod
        image: alpine
        command: sleep 1h
      loop:
        - 'container1'
        - 'container2'

    - name: Start pod
      containers.podman.podman_pod:
        name: mypod
        state: started
        network: host
        share: net
        userns: auto
        security_opt:
          - seccomp=unconfined
          - apparmor=unconfined
        hostname: mypod
        dns:
          - 1.1.1.1
        volumes:
          - /tmp:/tmp/:ro
        label:
          key: cval
          otherkey: kddkdk
          somekey: someval
        add_host:
          - 'google:5.5.5.5'

    # Create a Quadlet file for a pod
    - name: Create a Quadlet file for pod qpod
      containers.podman.podman_pod:
        name: qpod
        state: quadlet
        ports:
          - '4444:5555'
        volume:
          - /var/run/docker.sock:/var/run/docker.sock
        quadlet_dir: /custom/dir
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_pod_info
    set output_file "podman_pod_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Gather info about all present pods
    - name: Gather info about all present pods
      containers.podman.podman_pod_info:

    # Gather info about a specific pod
    - name: Gather info about specific pods
      containers.podman.podman_pod_info:
        name: special_pod
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.prune
    set output_file "podman_prune.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Prune containers older than 24h
    - name: Prune containers older than 24h
      containers.podman.podman_prune:
        containers: true
        containers_filters:
          until: 24h

    # Prune everything
    - name: Prune everything
      containers.podman.podman_prune:
        system: true

    # Prune everything (including non-dangling images and volumes)
    - name: Prune everything (including non-dangling images)
      containers.podman.podman_prune:
        system: true
        system_all: true
        system_volumes: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function podman.runlabel
    set output_file "podman_runlabel.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Run a container using a specific label from the image
    - name: Run label INSTALL from miniconda3 image
      containers.podman.podman_runlabel:
        image: docker.io/continuumio/miniconda3
        label: INSTALL
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.podman_save
    set output_file "podman_save.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Save a single image to a tar file
    - name: Save nginx image to /tmp/file123.tar
      containers.podman.podman_save:
        image: nginx
        dest: /tmp/file123.tar

    # Save multiple images into a single multi-image archive
    - name: Save nginx and fedora images to /tmp/file456.tar as multi-image archive
      containers.podman.podman_save:
        image:
          - nginx
          - fedora
        dest: /tmp/file456.tar
        multi_image_archive: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function podman.search
    set output_file "podman_search.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Search for any RHEL images, limit to 3 results
    - name: Search for any rhel images
      containers.podman.podman_search:
        term: \"rhel\"
        limit: 3

    # Gather info on a specific remote image
    - name: Gather info on a specific remote image
      containers.podman.podman_search:
        term: \"myimageregistry.com/ansible-automation-platform/ee-minimal-rhel8\"

    # Gather tag info on a known remote image
    - name: Gather tag info on a known remote image
      containers.podman.podman_search:
        term: \"myimageregistry.com/ansible-automation-platform/ee-minimal-rhel8\"
        list_tags: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



function podman.podman_secret
    set output_file "podman_secret.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Create secret
    - name: Create secret
      containers.podman.podman_secret:
        state: present
        name: mysecret
        data: \"my super secret content\"

    # Create container that uses the secret
    - name: Create container that uses the secret
      containers.podman.podman_container:
        name: showmysecret
        image: docker.io/alpine:3.14
        secrets:
          - mysecret
        detach: false
        command: cat /run/secrets/mysecret
      register: container

    # Output secret data
    - name: Output secret data
      debug:
        msg: '{{ container.stdout }}'

    # Remove secret
    - name: Remove secret
      containers.podman.podman_secret:
        state: absent
        name: mysecret
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function podman.secret_info
    set output_file "podman_secret_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    # Gather info about all present secrets
    - name: Gather info about all present secrets
      podman_secret_info:

    # Gather info about a specific secret
    - name: Gather info about specific secret
      podman_secret_info:
        name: specific_secret
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function podman.system_connection
    set output_file "podman_system_connection.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Add a basic SSH connection
      containers.podman.podman_system_connection:
        name: production
        destination: root@server.example.com
        state: present

    - name: Add SSH connection with custom port and identity
      containers.podman.podman_system_connection:
        name: staging
        destination: user@staging.example.com
        port: 2222
        identity: ~/.ssh/staging_rsa
        state: present

    - name: Add connection and set as default
      containers.podman.podman_system_connection:
        name: development
        destination: dev@dev.example.com
        default: true
        state: present

    - name: Add unix socket connection
      containers.podman.podman_system_connection:
        name: local
        destination: unix:///run/podman/podman.sock
        state: present

    - name: Add TCP connection
      containers.podman.podman_system_connection:
        name: remote_tcp
        destination: tcp://remote.example.com:8080
        state: present

    - name: Rename a connection
      containers.podman.podman_system_connection:
        name: old_name
        new_name: new_name
        state: present

    - name: Remove a connection
      containers.podman.podman_system_connection:
        name: old_connection
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function podman.system_connection_info
    set output_file "podman_system_connection_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Gather info about all connections
      containers.podman.podman_system_connection_info:

    - name: Gather info about specific connection
      containers.podman.podman_system_connection_info:
        name: production

    - name: Get connection info and register result
      containers.podman.podman_system_connection_info:
        name: staging
      register: staging_connection

    - name: Display connection URI
      debug:
        msg: \"Staging connection URI: {{ staging_connection.connections[0].URI }}\"
      when: staging_connection.connections | length > 0
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function podman.system_info
    set output_file "podman_system_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Get Podman system information
      containers.podman.podman_system_info:

    - name: Get Podman system information into a variable
      containers.podman.podman_system_info:
      register: podman_info

    - name: Printing Podman System info
      debug:
        msg: \"{{ podman_info['podman_system_info'] }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function podman_tag_example
    set output_file "podman_tag.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Tag an image with multiple target names
      containers.podman.podman_tag:
        image: docker.io/continuumio/miniconda3
        target_names:
          - miniconda3
          - miniconda
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function podman.volume
    set output_file "podman_volume.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Create a volume
      containers.podman.podman_volume:
        state: present
        name: volume1
        label:
          key: value
          key2: value2
        options:
          - \"device=/dev/loop1\"
          - \"type=ext4\"

    - name: Create a Quadlet file for a volume
      containers.podman.podman_volume:
        state: quadlet
        name: quadlet_volume
        quadlet_filename: custom-name
        quadlet_file_mode: '0640'
        quadlet_options:
          - Group=192
          - Copy=true
          - Image=quay.io/centos/centos:latest
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function podman.volume_info
    set output_file "podman_volume_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Gather info about all present volumes
      podman_volume_info:

    - name: Gather info about specific volume
      podman_volume_info:
        name: specific_volume
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end



