function docker.current_container_facts
    set output_file "community_docker_current_container_facts.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Get facts on current container
      community.docker.current_container_facts:

    - name: Print information on current container when running in a container
      ansible.builtin.debug:
        msg: \"Container ID is {{ ansible_module_container_id }}\"
      when: ansible_module_running_in_container
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function docker.docker_compose_v2
    set output_file "community_docker_docker_compose_v2.yml"

    set template_content "---
# Examples use the django example at https://docs.docker.com/compose/django. Follow it to create the
# flask directory

- name: Run using a project directory
  hosts: localhost
  gather_facts: false
  tasks:

    - name: Tear down existing services
      community.docker.docker_compose_v2:
        project_src: flask
        state: absent

    - name: Create and start services
      community.docker.docker_compose_v2:
        project_src: flask
      register: output

    - name: Show results
      ansible.builtin.debug:
        var: output

    - name: Run `docker compose up` again
      community.docker.docker_compose_v2:
        project_src: flask
      register: output

    - name: Show results
      ansible.builtin.debug:
        var: output

    - ansible.builtin.assert:
        that: not output.changed

    - name: Stop all services
      community.docker.docker_compose_v2:
        project_src: flask
        state: stopped
      register: output

    - name: Show results
      ansible.builtin.debug:
        var: output

    - name: Verify that web and db services are not running
      ansible.builtin.assert:
        that:
          - web_container.State != 'running'
          - db_container.State != 'running'
      vars:
        web_container: >-
          {{ output.containers | selectattr(\"Service\", \"equalto\", \"web\") | first }}
        db_container: >-
          {{ output.containers | selectattr(\"Service\", \"equalto\", \"db\") | first }}

    - name: Restart services
      community.docker.docker_compose_v2:
        project_src: flask
        state: restarted
      register: output

    - name: Show results
      ansible.builtin.debug:
        var: output

    - name: Verify that web and db services are running
      ansible.builtin.assert:
        that:
          - web_container.State == 'running'
          - db_container.State == 'running'
      vars:
        web_container: >-
          {{ output.containers | selectattr(\"Service\", \"equalto\", \"web\") | first }}
        db_container: >-
          {{ output.containers | selectattr(\"Service\", \"equalto\", \"db\") | first }}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function community_docker_docker_compose_v2_exec_example
    set output_file "community_docker_docker_compose_v2_exec.yml"

    set template_content "---
- name: Run a simple command (command)
  community.docker.docker_compose_v2_exec:
    service: foo
    command: /bin/bash -c \"ls -lah\"
    chdir: /root
  register: result

- name: Print stdout
  ansible.builtin.debug:
    var: result.stdout

- name: Run a simple command (argv)
  community.docker.docker_compose_v2_exec:
    service: foo
    argv:
      - /bin/bash
      - \"-c\"
      - \"ls -lah > /dev/stderr\"
    chdir: /root
  register: result

- name: Print stderr lines
  ansible.builtin.debug:
    var: result.stderr_lines
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function community_docker_docker_compose_v2_pull_example
    set output_file "community_docker_docker_compose_v2_pull.yml"

    set template_content "---
- name: Pull images for flask project
  community.docker.docker_compose_v2_pull:
    project_src: /path/to/flask
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function community_docker_docker_compose_v2_run_example
    set output_file "community_docker_docker_compose_v2_run.yml"

    set template_content "---
- name: Run a simple command (command)
  community.docker.docker_compose_v2_run:
    service: foo
    command: /bin/bash -c \"ls -lah\"
    chdir: /root
  register: result

- name: Print stdout
  ansible.builtin.debug:
    var: result.stdout

- name: Run a simple command (argv)
  community.docker.docker_compose_v2_run:
    service: foo
    argv:
      - /bin/bash
      - \"-c\"
      - \"ls -lah > /dev/stderr\"
    chdir: /root
  register: result

- name: Print stderr lines
  ansible.builtin.debug:
    var: result.stderr_lines
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function community_docker_docker_config_example
    set output_file "community_docker_docker_config.yml"

    set template_content "---
- name: Create config foo (from a file on the control machine)
  community.docker.docker_config:
    name: foo
    data: \"{{ lookup('file', '/path/to/config/file') | b64encode }}\"
    data_is_b64: true
    state: present

- name: Create config foo (from a file on the target machine)
  community.docker.docker_config:
    name: foo
    data_src: /path/to/config/file
    state: present

- name: Change the config data
  community.docker.docker_config:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
    state: present

- name: Add a new label
  community.docker.docker_config:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
      two: '2'
    state: present

- name: No change
  community.docker.docker_config:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
    state: present

- name: Update an existing label
  community.docker.docker_config:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: monkey
      one: '1'
    state: present

- name: Force the (re-)creation of the config
  community.docker.docker_config:
    name: foo
    data: Goodnight everyone!
    force: true
    state: present

- name: Remove config foo
  community.docker.docker_config:
    name: foo
    state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

function community_docker_docker_container_example
    set output_file "community_docker_docker_container.yml"

    set template_content "---
- name: Create a data container
  community.docker.docker_container:
    name: mydata
    image: busybox
    volumes:
      - /data

- name: Re-create a redis container
  community.docker.docker_container:
    name: myredis
    image: redis
    command: redis-server --appendonly yes
    state: present
    recreate: true
    exposed_ports:
      - 6379
    volumes_from:
      - mydata

- name: Restart a container
  community.docker.docker_container:
    name: myapplication
    image: someuser/appimage
    state: started
    restart: true
    links:
      - \"myredis:aliasedredis\"
    devices:
      - \"/dev/sda:/dev/xvda:rwm\"
    ports:
      - \"8080:9000\"
      - \"127.0.0.1:8081:9001/udp\"
      - \"9002\"
      - \"8000-8100:9003\"
      - \"7000-7010:9010-9020\"
    env:
      SECRET_KEY: \"ssssh\"
      BOOLEAN_KEY: \"yes\"

- name: Container present
  community.docker.docker_container:
    name: mycontainer
    state: present
    image: ubuntu:14.04
    command: sleep infinity

- name: Stop a container
  community.docker.docker_container:
    name: mycontainer
    state: stopped

- name: Start 4 load-balanced containers
  community.docker.docker_container:
    name: \"container{{ item }}\"
    recreate: true
    image: someuser/anotherappimage
    command: sleep 1d
  with_sequence: count=4

- name: Remove container
  community.docker.docker_container:
    name: ohno
    state: absent

- name: Syslogging output
  community.docker.docker_container:
    name: myservice
    image: busybox
    log_driver: syslog
    log_options:
      syslog-address: tcp://my-syslog-server:514
      syslog-facility: daemon
      tag: myservice

- name: Create db container and connect to network
  community.docker.docker_container:
    name: db_test
    image: \"postgres:latest\"
    networks:
      - name: \"{{ docker_network_name }}\"

- name: Start container, connect to network and link
  community.docker.docker_container:
    name: sleeper
    image: ubuntu:14.04
    networks:
      - name: TestingNet
        ipv4_address: \"172.16.1.100\"
        aliases:
          - sleepyzz
        links:
          - db_test:db
      - name: TestingNet2

# ... Additional container examples omitted for brevity ...
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_container_copy_into_example
    set output_file "community_docker_docker_container_copy_into.yml"

    set template_content "---
- name: Copy a file into the container
  community.docker.docker_container_copy_into:
    container: mydata
    path: /home/user/data.txt
    container_path: /data/input.txt

- name: Copy a file into the container with owner, group, and mode set
  community.docker.docker_container_copy_into:
    container: mydata
    path: /home/user/bin/runme.o
    container_path: /bin/runme
    owner_id: 0  # root
    group_id: 0  # root
    mode: \"0755\"  # readable and executable by all users, writable by root
    mode_parse: modern  # ensure that strings passed for 'mode' are passed as octal numbers
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_container_exec_example
    set output_file "community_docker_docker_container_exec.yml"

    set template_content "---
- name: Run a simple command (command)
  community.docker.docker_container_exec:
    container: foo
    command: /bin/bash -c \"ls -lah\"
    chdir: /root
  register: result

- name: Print stdout
  ansible.builtin.debug:
    var: result.stdout

- name: Run a simple command (argv)
  community.docker.docker_container_exec:
    container: foo
    argv:
      - /bin/bash
      - \"-c\"
      - \"ls -lah > /dev/stderr\"
    chdir: /root
  register: result

- name: Print stderr lines
  ansible.builtin.debug:
    var: result.stderr_lines
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function community_docker_docker_container_info_example
    set output_file "community_docker_docker_container_info.yml"

    set template_content "---
- name: Get infos on container
  community.docker.docker_container_info:
    name: mydata
  register: result

- name: Does container exist?
  ansible.builtin.debug:
    msg: \"The container {{ 'exists' if result.exists else 'does not exist' }}\"

- name: Print information about container
  ansible.builtin.debug:
    var: result.container
  when: result.exists
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function community_docker_docker_context_info_example
    set output_file "community_docker_docker_context_info.yml"

    set template_content "---
- name: Get infos on contexts
  community.docker.docker_context_info:
  register: result

- name: Show all contexts
  ansible.builtin.debug:
    msg: \"{{ result.contexts }}\"

- name: Get current context
  community.docker.docker_context_info:
    only_current: true
  register: docker_current_context

- name: Run community.docker modules with current context
  module_defaults:
    group/community.docker.docker: \"{{ docker_current_context.contexts[0].config }}\"
  block:
    - name: Task using the current context
      community.docker.docker_container:
        image: ubuntu:latest
        name: ubuntu
        state: started
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_host_info_example
    set output_file "community_docker_docker_host_info.yml"

    set template_content "---
- name: Get info on docker host
  community.docker.docker_host_info:
  register: result

- name: Get info on docker host and list images
  community.docker.docker_host_info:
    images: true
  register: result

- name: Get info on docker host and list images matching the filter
  community.docker.docker_host_info:
    images: true
    images_filters:
      label: \"mylabel\"
  register: result

- name: Get info on docker host and verbose list images
  community.docker.docker_host_info:
    images: true
    verbose_output: true
  register: result

- name: Get info on docker host and used disk space
  community.docker.docker_host_info:
    disk_usage: true
  register: result

- name: Get info on docker host and list containers matching the filter
  community.docker.docker_host_info:
    containers: true
    containers_filters:
      label:
        - key1=value1
        - key2=value2
  register: result

- name: Show host information
  ansible.builtin.debug:
    var: result.host_info
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_example
    set output_file "community_docker_docker_image.yml"

    set template_content "---
- name: Pull an image
  community.docker.docker_image:
    name: pacur/centos-7
    source: pull
    pull:
      platform: amd64

- name: Tag and push to docker hub
  community.docker.docker_image:
    name: pacur/centos-7:56
    repository: dcoppenhagan/myimage:7.56
    push: true
    source: local

- name: Tag and push to local registry
  community.docker.docker_image:
    name: centos
    repository: localhost:5000/centos
    tag: 7
    push: true
    source: local

- name: Add tag latest to image
  community.docker.docker_image:
    name: myimage:7.1.2
    repository: myimage:latest
    force_tag: true
    source: local

- name: Remove image
  community.docker.docker_image:
    state: absent
    name: registry.ansible.com/chouseknecht/sinatra
    tag: v1

- name: Build an image and push it to a private repo
  community.docker.docker_image:
    build:
      path: ./sinatra
    name: registry.ansible.com/chouseknecht/sinatra
    tag: v1
    push: true
    source: build

- name: Archive image
  community.docker.docker_image:
    name: registry.ansible.com/chouseknecht/sinatra
    tag: v1
    archive_path: my_sinatra.tar
    source: local

- name: Load image from archive and push to a private registry
  community.docker.docker_image:
    name: localhost:5000/myimages/sinatra
    tag: v1
    push: true
    load_path: my_sinatra.tar
    source: load

- name: Build image and with build args
  community.docker.docker_image:
    name: myimage
    build:
      path: /path/to/build/dir
      args:
        log_volume: /var/log/myapp
        listen_port: 8080
    source: build

- name: Build image using cache source
  community.docker.docker_image:
    name: myimage:latest
    build:
      path: /path/to/build/dir
      cache_from:
        - nginx:latest
        - alpine:3.8
    source: build
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_build_example
    set output_file "community_docker_docker_image_build.yml"

    set template_content "---
- name: Build Python 3.12 image
  community.docker.docker_image_build:
    name: localhost/python/3.12:latest
    path: /home/user/images/python
    dockerfile: Dockerfile-3.12

- name: Build multi-platform image
  community.docker.docker_image_build:
    name: multi-platform-image
    tag: '1.5.2'
    path: /home/user/images/multi-platform
    platform:
      - linux/amd64
      - linux/arm64/v8
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_export_example
    set output_file "community_docker_docker_image_export.yml"

    set template_content "---
- name: Export an image
  community.docker.docker_image_export:
    name: pacur/centos-7
    path: /tmp/centos-7.tar

- name: Export multiple images
  community.docker.docker_image_export:
    names:
      - hello-world:latest
      - pacur/centos-7:latest
    path: /tmp/various.tar
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_info_example
    set output_file "community_docker_docker_image_info.yml"

    set template_content "---
- name: Inspect a single image
  community.docker.docker_image_info:
    name: pacur/centos-7

- name: Inspect multiple images
  community.docker.docker_image_info:
    name:
      - pacur/centos-7
      - sinatra
  register: result

- name: Make sure that both images pacur/centos-7 and sinatra exist locally
  ansible.builtin.assert:
    that:
      - result.images | length == 2
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_load_example
    set output_file "community_docker_docker_image_load.yml"

    set template_content "---
- name: Load all image(s) from the given tar file
  community.docker.docker_image_load:
    path: /path/to/images.tar
  register: result

- name: Print the loaded image names
  ansible.builtin.debug:
    msg: \"Loaded the following images: {{ result.image_names | join(', ') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function community_docker_docker_image_pull_example
    set output_file "community_docker_docker_image_pull.yml"

    set template_content "---
- name: Pull an image
  community.docker.docker_image_pull:
    name: pacur/centos-7
    # Select platform for pulling. If not specified, will pull whatever docker prefers.
    platform: amd64
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function community_docker_docker_image_push_example
    set output_file "community_docker_docker_image_push.yml"

    set template_content "---
- name: Push an image
  community.docker.docker_image_push:
    name: registry.example.com:5000/repo/image
    tag: latest
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function community_docker_docker_image_remove_example
    # Output file name
    set output_file "community_docker_docker_image_remove.yml"

    # Template content for the Ansible task
    set template_content "---
- name: Remove an image
  community.docker.docker_image_remove:
    name: pacur/centos-7
"

    # Write the template to the file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display the file content
    cat $output_file
end

function community_docker_docker_image_tag_example
    # Output file name
    set output_file "community_docker_docker_image_tag.yml"

    # Template content for the Ansible task
    set template_content "---
- name: Tag Python 3.12 image with two new names
  community.docker.docker_image_tag:
    name: python:3.12
    repository:
      - python-3:3.12
      - local-registry:5000/python-3/3.12:latest
"

    # Write the template to the file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display the file content
    cat $output_file
end


function community_docker_docker_login_example
    # Output file name
    set output_file "community_docker_docker_login.yml"

    # Template content for the Ansible task
    set template_content "---
- name: Log into DockerHub
  community.docker.docker_login:
    username: docker
    password: rekcod

- name: Log into private registry and force re-authorization
  community.docker.docker_login:
    registry_url: your.private.registry.io
    username: yourself
    password: secrets3
    reauthorize: true

- name: Log into DockerHub using a custom config file
  community.docker.docker_login:
    username: docker
    password: rekcod
    config_path: /tmp/.mydockercfg

- name: Log out of DockerHub
  community.docker.docker_login:
    state: absent
"

    # Write the template to the file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display the file content
    cat $output_file
end


function community_docker_docker_network_example
    # Output file name
    set output_file "community_docker_docker_network.yml"

    # Template content
    set template_content "---
- name: Create a network
  community.docker.docker_network:
    name: network_one

- name: Remove all but selected list of containers
  community.docker.docker_network:
    name: network_one
    connected:
      - container_a
      - container_b
      - container_c

- name: Remove a single container
  community.docker.docker_network:
    name: network_one
    connected: \"{{ fulllist|difference(['container_a']) }}\"

- name: Add a container to a network, leaving existing containers connected
  community.docker.docker_network:
    name: network_one
    connected:
      - container_a
    appends: true

- name: Create a network with driver options
  community.docker.docker_network:
    name: network_two
    driver_options:
      com.docker.network.bridge.name: net2

- name: Create a network with custom IPAM config
  community.docker.docker_network:
    name: network_three
    ipam_config:
      - subnet: 172.23.27.0/24
        gateway: 172.23.27.2
        iprange: 172.23.27.0/26
        aux_addresses:
          host1: 172.23.27.3
          host2: 172.23.27.4

- name: Create a network with labels
  community.docker.docker_network:
    name: network_four
    labels:
      key1: value1
      key2: value2

- name: Create a network with IPv6 IPAM config
  community.docker.docker_network:
    name: network_ipv6_one
    enable_ipv6: true
    ipam_config:
      - subnet: fdd1:ac8c:0557:7ce1::/64

- name: Create a network with IPv6 and custom IPv4 IPAM config
  community.docker.docker_network:
    name: network_ipv6_two
    enable_ipv6: true
    ipam_config:
      - subnet: 172.24.27.0/24
      - subnet: fdd1:ac8c:0557:7ce2::/64

- name: Delete a network, disconnecting all containers
  community.docker.docker_network:
    name: network_one
    state: absent
"

    # Write template to file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo "$output_file created"
    set_color normal

    # Display the file content
    cat $output_file
end



function community_docker_docker_network_info_example
    # Output file name
    set output_file "community_docker_docker_network_info.yml"

    # Template content
    set template_content "---
- name: Get infos on network
  community.docker.docker_network_info:
    name: mydata
  register: result

- name: Does network exist?
  ansible.builtin.debug:
    msg: \"The network {{ 'exists' if result.exists else 'does not exist' }}\"

- name: Print information about network
  ansible.builtin.debug:
    var: result.network
  when: result.exists
"

    # Write template to file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal

    # Display the file content
    cat $output_file
end



function community_docker_docker_node_example
    # Output file name
    set output_file "community_docker_docker_node.yml"

    # Template content
    set template_content "---
- name: Set node role
  community.docker.docker_node:
    hostname: mynode
    role: manager

- name: Set node availability
  community.docker.docker_node:
    hostname: mynode
    availability: drain

- name: Replace node labels with new labels
  community.docker.docker_node:
    hostname: mynode
    labels:
      key: value
    labels_state: replace

- name: Merge node labels and new labels
  community.docker.docker_node:
    hostname: mynode
    labels:
      key: value

- name: Remove all labels assigned to node
  community.docker.docker_node:
    hostname: mynode
    labels_state: replace

- name: Remove selected labels from the node
  community.docker.docker_node:
    hostname: mynode
    labels_to_remove:
      - key1
      - key2
"

    # Write template to file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal

    # Display the file content
    cat $output_file
end


function community_docker_docker_node_info_example
    # Output file name
    set output_file "community_docker_docker_node_info.yml"

    # Template content
    set template_content "---
- name: Get info on all nodes
  community.docker.docker_node_info:
  register: result

- name: Get info on node
  community.docker.docker_node_info:
    name: mynode
  register: result

- name: Get info on list of nodes
  community.docker.docker_node_info:
    name:
      - mynode1
      - mynode2
  register: result

- name: Get info on host if it is Swarm Manager
  community.docker.docker_node_info:
    self: true
  register: result
"

    # Write template to file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal

    # Display the file content
    cat $output_file
end


function community_docker_docker_plugin_example
    # Output file name
    set output_file "community_docker_docker_plugin.yml"

    # Template content
    set template_content "---
- name: Install a plugin
  community.docker.docker_plugin:
    plugin_name: plugin_one
    state: present

- name: Remove a plugin
  community.docker.docker_plugin:
    plugin_name: plugin_one
    state: absent

- name: Enable the plugin
  community.docker.docker_plugin:
    plugin_name: plugin_one
    state: enable

- name: Disable the plugin
  community.docker.docker_plugin:
    plugin_name: plugin_one
    state: disable

- name: Install a plugin with options
  community.docker.docker_plugin:
    plugin_name: weaveworks/net-plugin:latest_release
    plugin_options:
      IPALLOC_RANGE: \"10.32.0.0/12\"
      WEAVE_PASSWORD: \"PASSWORD\"
"

    # Write template to file
    echo $template_content > $output_file

    # Print message in FFAD8D
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal

    # Display the file content
    cat $output_file
end


function community_docker_docker_prune_example
    # Output file name
    set output_file "community_docker_docker_prune.yml"

    # Template content
    set template_content "---
- name: Prune containers older than 24h
  community.docker.docker_prune:
    containers: true
    containers_filters:
      until: 24h

- name: Prune containers with labels
  community.docker.docker_prune:
    containers: true
    containers_filters:
      label:
        - foo=bar
        - bam=baz
      \"label!\": bar=baz

- name: Prune everything
  community.docker.docker_prune:
    containers: true
    images: true
    networks: true
    volumes: true
    builder_cache: true

- name: Prune everything (including non-dangling images)
  community.docker.docker_prune:
    containers: true
    images: true
    images_filters:
      dangling: false
    networks: true
    volumes: true
    builder_cache: true
"
    echo $template_content > $output_file

    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function community_docker_docker_secret_example
    set output_file "community_docker_docker_secret.yml"

    set template_content "---
- name: Create secret foo (from a file on the control machine)
  community.docker.docker_secret:
    name: foo
    data: \"{{ lookup('file', '/path/to/secret/file') | b64encode }}\"
    data_is_b64: true
    state: present

- name: Create secret foo (from a file on the target machine)
  community.docker.docker_secret:
    name: foo
    data_src: /path/to/secret/file
    state: present

- name: Change the secret data
  community.docker.docker_secret:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
    state: present

- name: Add a new label
  community.docker.docker_secret:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
      two: '2'
    state: present

- name: No change
  community.docker.docker_secret:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: baz
      one: '1'
    state: present

- name: Update an existing label
  community.docker.docker_secret:
    name: foo
    data: Goodnight everyone!
    labels:
      bar: monkey
      one: '1'
    state: present

- name: Force the removal/creation of the secret
  community.docker.docker_secret:
    name: foo
    data: Goodnight everyone!
    force: true
    state: present

- name: Remove secret foo
  community.docker.docker_secret:
    name: foo
    state: absent
"
    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function community_docker_docker_volume_example
    set output_file "community_docker_docker_volume.yml"

    set template_content "---
- name: Create a volume
  community.docker.docker_volume:
    name: volume_one

- name: Remove a volume
  community.docker.docker_volume:
    name: volume_one
    state: absent

- name: Create a volume with options
  community.docker.docker_volume:
    name: volume_two
    driver_options:
      type: btrfs
      device: /dev/sda2
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal

    cat $output_file
end


function community_docker_docker_volume_info_example
    set output_file "community_docker_docker_volume_info.yml"

    set template_content "---
- name: Get infos on volume
  community.docker.docker_volume_info:
    name: mydata
  register: result

- name: Does volume exist?
  ansible.builtin.debug:
    msg: \"The volume {{ 'exists' if result.exists else 'does not exist' }}\"

- name: Print information about volume
  ansible.builtin.debug:
    var: result.volume
  when: result.exists
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end

