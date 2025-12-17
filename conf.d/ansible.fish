function ansible.builtin.apt
    set output_file "ansible.builtin.apt.yml"

    set template_content "---
- name: Install apache httpd (state=present is optional)
  ansible.builtin.apt:
    name: apache2
    state: present

- name: Update repositories cache and install \"foo\" package
  ansible.builtin.apt:
    name: foo
    update_cache: yes

- name: Remove \"foo\" package
  ansible.builtin.apt:
    name: foo
    state: absent

- name: Install the package \"foo\"
  ansible.builtin.apt:
    name: foo

- name: Install a list of packages
  ansible.builtin.apt:
    pkg:
    - foo
    - foo-tools

- name: Install the version '1.00' of package \"foo\"
  ansible.builtin.apt:
    name: foo=1.00

- name: Update the repository cache and update package \"nginx\" to latest version using default release squeeze-backport
  ansible.builtin.apt:
    name: nginx
    state: latest
    default_release: squeeze-backports
    update_cache: yes

- name: Install the version '1.18.0' of package \"nginx\" and allow potential downgrades
  ansible.builtin.apt:
    name: nginx=1.18.0
    state: present
    allow_downgrade: yes

- name: Install zfsutils-linux with ensuring conflicted packages (e.g. zfs-fuse) will not be removed.
  ansible.builtin.apt:
    name: zfsutils-linux
    state: latest
    fail_on_autoremove: yes

- name: Install latest version of \"openjdk-6-jdk\" ignoring \"install-recommends\"
  ansible.builtin.apt:
    name: openjdk-6-jdk
    state: latest
    install_recommends: no

- name: Update all packages to their latest version
  ansible.builtin.apt:
    name: \"*\"
    state: latest

- name: Upgrade the OS (apt-get dist-upgrade)
  ansible.builtin.apt:
    upgrade: dist

- name: Run the equivalent of \"apt-get update\" as a separate step
  ansible.builtin.apt:
    update_cache: yes

- name: Only run \"update_cache=yes\" if the last one is more than 3600 seconds ago
  ansible.builtin.apt:
    update_cache: yes
    cache_valid_time: 3600

- name: Pass options to dpkg on run
  ansible.builtin.apt:
    upgrade: dist
    update_cache: yes
    dpkg_options: 'force-confold,force-confdef'

- name: Install a .deb package
  ansible.builtin.apt:
    deb: /tmp/mypackage.deb

- name: Install the build dependencies for package \"foo\"
  ansible.builtin.apt:
    pkg: foo
    state: build-dep

- name: Install a .deb package from the internet
  ansible.builtin.apt:
    deb: https://example.com/python-ppq_0.1-1_all.deb

- name: Remove useless packages from the cache
  ansible.builtin.apt:
    autoclean: yes

- name: Remove dependencies that are no longer required
  ansible.builtin.apt:
    autoremove: yes

- name: Remove dependencies that are no longer required and purge their configuration files
  ansible.builtin.apt:
    autoremove: yes
    purge: true

- name: Run the equivalent of \"apt-get clean\" as a separate step
  ansible.builtin.apt:
    clean: yes
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.add_host
    set output_file "ansible.builtin.add_host.yml"

    set template_content "---
- name: Add host to group 'just_created' with variable foo=42
  ansible.builtin.add_host:
    name: '{{ ip_from_ec2 }}'
    groups: just_created
    foo: 42

- name: Add host to multiple groups
  ansible.builtin.add_host:
    hostname: '{{ new_ip }}'
    groups:
    - group1
    - group2

- name: Add a host with a non-standard port local to your machines
  ansible.builtin.add_host:
    name: '{{ new_ip }}:{{ new_port }}'

- name: Add a host alias that we reach through a tunnel (Ansible 1.9 and older)
  ansible.builtin.add_host:
    hostname: '{{ new_ip }}'
    ansible_ssh_host: '{{ inventory_hostname }}'
    ansible_ssh_port: '{{ new_port }}'

- name: Add a host alias that we reach through a tunnel (Ansible 2.0 and newer)
  ansible.builtin.add_host:
    hostname: '{{ new_ip }}'
    ansible_host: '{{ inventory_hostname }}'
    ansible_port: '{{ new_port }}'

- name: Ensure inventory vars are set to the same value as the inventory_hostname has (close to pre Ansible 2.4 behaviour)
  ansible.builtin.add_host:
    hostname: charlie
    inventory_dir: '{{ inventory_dir }}'

- name: Add all hosts running this playbook to the done group
  ansible.builtin.add_host:
    name: '{{ item }}'
    groups: done
  loop: \"{{ ansible_play_hosts }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.apt_key
    set output_file "ansible.builtin.apt_key.yml"

    set template_content "---
- name: One way to avoid apt_key once it is removed from your distro, armored keys should use .asc extension, binary should use .gpg
  block:
    - name: somerepo | no apt key
      ansible.builtin.get_url:
        url: https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x36a1d7869245c8950f966e92d8576a8ba88d21e9
        dest: /etc/apt/keyrings/myrepo.asc
        checksum: sha256:bb42f0db45d46bab5f9ec619e1a47360b94c27142e57aa71f7050d08672309e0

    - name: somerepo | apt source
      ansible.builtin.apt_repository:
        repo: \"deb [arch=amd64 signed-by=/etc/apt/keyrings/myrepo.asc] https://download.example.com/linux/ubuntu {{ ansible_distribution_release }} stable\"
        state: present

- name: Add an apt key by id from a keyserver
  ansible.builtin.apt_key:
    keyserver: keyserver.ubuntu.com
    id: 36A1D7869245C8950F966E92D8576A8BA88D21E9

- name: Add an Apt signing key, uses whichever key is at the URL
  ansible.builtin.apt_key:
    url: https://ftp-master.debian.org/keys/archive-key-6.0.asc
    state: present

- name: Add an Apt signing key, will not download if present
  ansible.builtin.apt_key:
    id: 9FED2BCBDCD29CDF762678CBAED4B06F473041FA
    url: https://ftp-master.debian.org/keys/archive-key-6.0.asc
    state: present

- name: Remove a Apt specific signing key, leading 0x is valid
  ansible.builtin.apt_key:
    id: 0x9FED2BCBDCD29CDF762678CBAED4B06F473041FA
    state: absent

- name: Add a key from a file on the Ansible server
  ansible.builtin.apt_key:
    data: \"{{ lookup('ansible.builtin.file', 'apt.asc') }}\"
    state: present

- name: Add an Apt signing key to a specific keyring file
  ansible.builtin.apt_key:
    id: 9FED2BCBDCD29CDF762678CBAED4B06F473041FA
    url: https://ftp-master.debian.org/keys/archive-key-6.0.asc
    keyring: /etc/apt/trusted.gpg.d/debian.gpg

- name: Add Apt signing key on remote server to keyring
  ansible.builtin.apt_key:
    id: 9FED2BCBDCD29CDF762678CBAED4B06F473041FA
    file: /tmp/apt.gpg
    state: present
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.apt_repository
    set output_file "ansible.builtin.apt_repository.yml"

    set template_content "---
- name: Add specified repository into sources list
  ansible.builtin.apt_repository:
    repo: deb http://archive.canonical.com/ubuntu hardy partner
    state: present

- name: Add specified repository into sources list using specified filename
  ansible.builtin.apt_repository:
    repo: deb http://dl.google.com/linux/chrome/deb/ stable main
    state: present
    filename: google-chrome

- name: Add source repository into sources list
  ansible.builtin.apt_repository:
    repo: deb-src http://archive.canonical.com/ubuntu hardy partner
    state: present

- name: Remove specified repository from sources list
  ansible.builtin.apt_repository:
    repo: deb http://archive.canonical.com/ubuntu hardy partner
    state: absent

- name: Add nginx stable repository from PPA and install its signing key on Ubuntu target
  ansible.builtin.apt_repository:
    repo: ppa:nginx/stable

- name: Add nginx stable repository from PPA and install its signing key on Debian target
  ansible.builtin.apt_repository:
    repo: 'ppa:nginx/stable'
    codename: trusty

- name: One way to avoid apt_key once it is removed from your distro
  block:
    - name: somerepo |no apt key
      ansible.builtin.get_url:
        url: https://download.example.com/linux/ubuntu/gpg
        dest: /etc/apt/keyrings/somerepo.asc

    - name: somerepo | apt source
      ansible.builtin.apt_repository:
        repo: \"deb [arch=amd64 signed-by=/etc/apt/keyrings/somerepo.asc] https://download.example.com/linux/ubuntu {{ ansible_distribution_release }} stable\"
        state: present
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.assemble
    set output_file "ansible.builtin.assemble.yml"

    set template_content "---
- name: Assemble from fragments from a directory
  ansible.builtin.assemble:
    src: /etc/someapp/fragments
    dest: /etc/someapp/someapp.conf

- name: Insert the provided delimiter between fragments
  ansible.builtin.assemble:
    src: /etc/someapp/fragments
    dest: /etc/someapp/someapp.conf
    delimiter: '### START FRAGMENT ###'

- name: Assemble a new \"sshd_config\" file into place, after passing validation with sshd
  ansible.builtin.assemble:
    src: /etc/ssh/conf.d/
    dest: /etc/ssh/sshd_config
    validate: /usr/sbin/sshd -t -f %s
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.assert
    set output_file "ansible.builtin.assert.yml"

    set template_content "---
- name: A single condition can be supplied as string instead of list
  ansible.builtin.assert:
    that: \"ansible_os_family != 'RedHat'\"

- name: Use yaml multiline strings to ease escaping
  ansible.builtin.assert:
    that:
      - \"'foo' in some_command_result.stdout\"
      - number_of_the_counting == 3
      - >
        \"reject\" not in some_command_result.stderr

- name: After version 2.7 both O(msg) and O(fail_msg) can customize failing assertion message
  ansible.builtin.assert:
    that:
      - my_param <= 100
      - my_param >= 0
    fail_msg: \"'my_param' must be between 0 and 100\"
    success_msg: \"'my_param' is between 0 and 100\"

- name: Please use O(msg) when ansible version is smaller than 2.7
  ansible.builtin.assert:
    that:
      - my_param <= 100
      - my_param >= 0
    msg: \"'my_param' must be between 0 and 100\"

- name: Use quiet to avoid verbose output
  ansible.builtin.assert:
    that:
      - my_param <= 100
      - my_param >= 0
    quiet: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.async_status
    set output_file "ansible.builtin.async_status.yml"

    set template_content "---
- name: Asynchronous dnf task
  ansible.builtin.dnf:
    name: docker-io
    state: present
  async: 1000
  poll: 0
  register: dnf_sleeper

- name: Wait for asynchronous job to end
  ansible.builtin.async_status:
    jid: '{{ dnf_sleeper.ansible_job_id }}'
  register: job_result
  until: job_result is finished
  retries: 100
  delay: 10

- name: Clean up async file
  ansible.builtin.async_status:
    jid: '{{ dnf_sleeper.ansible_job_id }}'
    mode: cleanup
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.blockinfile
    set output_file "ansible.builtin.blockinfile.yml"

    set template_content "---
- name: Insert/Update \"Match User\" configuration block in /etc/ssh/sshd_config prepending and appending a new line
  ansible.builtin.blockinfile:
    path: /etc/ssh/sshd_config
    append_newline: true
    prepend_newline: true
    block: |
      Match User ansible-agent
      PasswordAuthentication no

- name: Insert/Update eth0 configuration stanza in /etc/network/interfaces
  ansible.builtin.blockinfile:
    path: /etc/network/interfaces
    block: |
      iface eth0 inet static
          address 192.0.2.23
          netmask 255.255.255.0

- name: Insert/Update configuration using a local file and validate it
  ansible.builtin.blockinfile:
    block: \"{{ lookup('ansible.builtin.file', './local/sshd_config') }}\"
    path: /etc/ssh/sshd_config
    backup: yes
    validate: /usr/sbin/sshd -T -f %s

- name: Insert/Update HTML surrounded by custom markers after <body> line
  ansible.builtin.blockinfile:
    path: /var/www/html/index.html
    marker: \"<!-- {mark} ANSIBLE MANAGED BLOCK -->\"
    insertafter: \"<body>\"
    block: |
      <h1>Welcome to {{ ansible_hostname }}</h1>
      <p>Last updated on {{ ansible_date_time.iso8601 }}</p>

- name: Remove HTML as well as surrounding markers
  ansible.builtin.blockinfile:
    path: /var/www/html/index.html
    marker: \"<!-- {mark} ANSIBLE MANAGED BLOCK -->\"
    block: \"\"

- name: Add mappings to /etc/hosts
  ansible.builtin.blockinfile:
    path: /etc/hosts
    block: |
      {{ item.ip }} {{ item.name }}
    marker: \"# {mark} ANSIBLE MANAGED BLOCK {{ item.name }}\"
  loop:
    - { name: host1, ip: 10.10.1.10 }
    - { name: host2, ip: 10.10.1.11 }
    - { name: host3, ip: 10.10.1.12 }

- name: Search with a multiline search flags regex and if found insert after
  blockinfile:
    path: listener.ora
    block: \"{{ listener_line | indent(width=8, first=True) }}\"
    insertafter: '(?m)SID_LIST_LISTENER_DG =\\n.*\\(SID_LIST ='
    marker: \"    <!-- {mark} ANSIBLE MANAGED BLOCK -->\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.command
    set output_file "ansible.builtin.command.yml"

    set template_content "---
- name: Return motd to registered var
  ansible.builtin.command: cat /etc/motd
  register: mymotd

- name: Run command if /path/to/database does not exist (without 'args')
  ansible.builtin.command: /usr/bin/make_database.sh db_user db_name creates=/path/to/database

- name: Run command if /path/to/database does not exist (with 'args' keyword)
  ansible.builtin.command: /usr/bin/make_database.sh db_user db_name
  args:
    creates: /path/to/database

- name: Run command if /path/to/database does not exist (with 'cmd' parameter)
  ansible.builtin.command:
    cmd: /usr/bin/make_database.sh db_user db_name
    creates: /path/to/database

- name: Change the working directory to somedir/ and run the command as db_owner if /path/to/database does not exist
  ansible.builtin.command: /usr/bin/make_database.sh db_user db_name
  become: yes
  become_user: db_owner
  args:
    chdir: somedir/
    creates: /path/to/database

- name: Use 'argv' to send a command as a list - leave 'command' empty
  ansible.builtin.command:
    argv:
      - /usr/bin/make_database.sh
      - Username with whitespace
      - dbname with whitespace
    creates: /path/to/database

- name: Run command using argv with mixed argument formats
  ansible.builtin.command:
    argv:
      - /path/to/binary
      - -v
      - --debug
      - --longopt
      - value for longopt
      - --other-longopt=value for other longopt
      - positional

- name: Safely use templated variable to run command. Always use the quote filter to avoid injection issues
  ansible.builtin.command: cat {{ myfile|quote }}
  register: myoutput
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.copy
    set output_file "ansible.builtin.copy.yml"

    set template_content "---
- name: Copy file with owner and permissions
  ansible.builtin.copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: '0644'

- name: Copy file with owner and permission, using symbolic representation
  ansible.builtin.copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: u=rw,g=r,o=r

- name: Another symbolic mode example, adding some permissions and removing others
  ansible.builtin.copy:
    src: /srv/myfiles/foo.conf
    dest: /etc/foo.conf
    owner: foo
    group: foo
    mode: u+rw,g-wx,o-rwx

- name: Copy a new \"ntp.conf\" file into place, backing up the original if it differs from the copied version
  ansible.builtin.copy:
    src: /mine/ntp.conf
    dest: /etc/ntp.conf
    owner: root
    group: root
    mode: '0644'
    backup: yes

- name: Copy a new \"sudoers\" file into place, after passing validation with visudo
  ansible.builtin.copy:
    src: /mine/sudoers
    dest: /etc/sudoers
    validate: /usr/sbin/visudo -csf %s

- name: Copy a \"sudoers\" file on the remote machine for editing
  ansible.builtin.copy:
    src: /etc/sudoers
    dest: /etc/sudoers.edit
    remote_src: yes
    validate: /usr/sbin/visudo -csf %s

- name: Copy using inline content
  ansible.builtin.copy:
    content: '# This file was moved to /etc/other.conf'
    dest: /etc/mine.conf

- name: If follow=yes, /path/to/file will be overwritten by contents of foo.conf
  ansible.builtin.copy:
    src: /etc/foo.conf
    dest: /path/to/link
    follow: yes

- name: If follow=no, /path/to/link will become a file and be overwritten by contents of foo.conf
  ansible.builtin.copy:
    src: /etc/foo.conf
    dest: /path/to/link
    follow: no
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.cron
    set output_file "ansible.builtin.cron.yml"

    set template_content "---
- name: Ensure a job that runs at 2 and 5 exists. Creates an entry like \"0 5,2 * * ls -alh > /dev/null\"
  ansible.builtin.cron:
    name: \"check dirs\"
    minute: \"0\"
    hour: \"5,2\"
    job: \"ls -alh > /dev/null\"

- name: 'Ensure an old job is no longer present. Removes any job that is prefixed by \"#Ansible: an old job\" from the crontab'
  ansible.builtin.cron:
    name: \"an old job\"
    state: absent

- name: Creates an entry like \"@reboot /some/job.sh\"
  ansible.builtin.cron:
    name: \"a job for reboot\"
    special_time: reboot
    job: \"/some/job.sh\"

- name: Creates an entry like \"PATH=/opt/bin\" on top of crontab
  ansible.builtin.cron:
    name: PATH
    env: yes
    job: /opt/bin

- name: Creates an entry like \"APP_HOME=/srv/app\" and insert it after PATH declaration
  ansible.builtin.cron:
    name: APP_HOME
    env: yes
    job: /srv/app
    insertafter: PATH

- name: Creates a cron file under /etc/cron.d
  ansible.builtin.cron:
    name: yum autoupdate
    weekday: \"2\"
    minute: \"0\"
    hour: \"12\"
    user: root
    job: \"YUMINTERACTIVE=0 /usr/sbin/yum-autoupdate\"
    cron_file: ansible_yum-autoupdate

- name: Removes a cron file from under /etc/cron.d
  ansible.builtin.cron:
    name: \"yum autoupdate\"
    cron_file: ansible_yum-autoupdate
    state: absent

- name: Removes \"APP_HOME\" environment variable from crontab
  ansible.builtin.cron:
    name: APP_HOME
    env: yes
    state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.deb822_repository
    set output_file "ansible.builtin.deb822_repository.yml"

    set template_content "---
- name: Add debian repo
  deb822_repository:
    name: debian
    types: deb
    uris: http://deb.debian.org/debian
    suites: stretch
    components:
      - main
      - contrib
      - non-free

- name: Add debian repo with key
  deb822_repository:
    name: debian
    types: deb
    uris: https://deb.debian.org
    suites: stable
    components:
      - main
      - contrib
      - non-free
    signed_by: |-
      -----BEGIN PGP PUBLIC KEY BLOCK-----

      mDMEYCQjIxYJKwYBBAHaRw8BAQdAD/P5Nvvnvk66SxBBHDbhRml9ORg1WV5CvzKY
      CuMfoIS0BmFiY2RlZoiQBBMWCgA4FiEErCIG1VhKWMWo2yfAREZd5NfO31cFAmAk
      IyMCGyMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AACgkQREZd5NfO31fbOwD6ArzS
      dM0Dkd5h2Ujy1b6KcAaVW9FOa5UNfJ9FFBtjLQEBAJ7UyWD3dZzhvlaAwunsk7DG
      3bHcln8DMpIJVXht78sL
      =IE0r
      -----END PGP PUBLIC KEY BLOCK-----

- name: Add repo using key from URL
  deb822_repository:
    name: example
    types: deb
    uris: https://download.example.com/linux/ubuntu
    suites: '{{ ansible_distribution_release }}'
    components: stable
    architectures: amd64
    signed_by: https://download.example.com/linux/ubuntu/gpg
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.debconf
    set output_file "ansible.builtin.debconf.yml"

    set template_content "---
- name: Set default locale to fr_FR.UTF-8
  ansible.builtin.debconf:
    name: locales
    question: locales/default_environment_locale
    value: fr_FR.UTF-8
    vtype: select

- name: Set to generate locales
  ansible.builtin.debconf:
    name: locales
    question: locales/locales_to_be_generated
    value: en_US.UTF-8 UTF-8, fr_FR.UTF-8 UTF-8
    vtype: multiselect

- name: Accept oracle license
  ansible.builtin.debconf:
    name: oracle-java7-installer
    question: shared/accepted-oracle-license-v1-1
    value: 'true'
    vtype: select

- name: Specifying package you can register/return the list of questions and current values
  ansible.builtin.debconf:
    name: tzdata

- name: Pre-configure tripwire site passphrase
  ansible.builtin.debconf:
    name: tripwire
    question: tripwire/site-passphrase
    value: \"{{ site_passphrase }}\"
    vtype: password
  no_log: True
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.debug
    set output_file "ansible.builtin.debug.yml"

    set template_content "---
- name: Print the gateway for each host when defined
  ansible.builtin.debug:
    msg: System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}
  when: ansible_default_ipv4.gateway is defined

- name: Get uptime information
  ansible.builtin.shell: /usr/bin/uptime
  register: result

- name: Print return information from the previous task
  ansible.builtin.debug:
    var: result
    verbosity: 2

- name: Display all variables/facts known for a host
  ansible.builtin.debug:
    var: hostvars[inventory_hostname]
    verbosity: 4

- name: Prints two lines of messages, but only if there is an environment value set
  ansible.builtin.debug:
    msg:
    - \"Provisioning based on YOUR_KEY which is: {{ lookup('ansible.builtin.env', 'YOUR_KEY') }}\"
    - \"These servers were built using the password of '{{ password_used }}'. Please retain this for later use.\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.dnf
    set output_file "ansible.builtin.dnf.yml"

    set template_content "---
- name: Install the latest version of Apache
  ansible.builtin.dnf:
    name: httpd
    state: latest

- name: Install Apache >= 2.4
  ansible.builtin.dnf:
    name: httpd >= 2.4
    state: present

- name: Install the latest version of Apache and MariaDB
  ansible.builtin.dnf:
    name:
      - httpd
      - mariadb-server
    state: latest

- name: Remove the Apache package
  ansible.builtin.dnf:
    name: httpd
    state: absent

- name: Install the latest version of Apache from the testing repo
  ansible.builtin.dnf:
    name: httpd
    enablerepo: testing
    state: present

- name: Upgrade all packages
  ansible.builtin.dnf:
    name: \"*\"
    state: latest

- name: Update the webserver, depending on which is installed on the system. Do not install the other one
  ansible.builtin.dnf:
    name:
      - httpd
      - nginx
    state: latest
    update_only: yes

- name: Install the nginx rpm from a remote repo
  ansible.builtin.dnf:
    name: 'http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm'
    state: present

- name: Install nginx rpm from a local file
  ansible.builtin.dnf:
    name: /usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present

- name: Install Package based upon the file it provides
  ansible.builtin.dnf:
    name: /usr/bin/cowsay
    state: present

- name: Install the 'Development tools' package group
  ansible.builtin.dnf:
    name: '@Development tools'
    state: present

- name: Autoremove unneeded packages installed as dependencies
  ansible.builtin.dnf:
    autoremove: yes

- name: Uninstall httpd but keep its dependencies
  ansible.builtin.dnf:
    name: httpd
    state: absent
    autoremove: no

- name: Install a modularity appstream with defined stream and profile
  ansible.builtin.dnf:
    name: '@postgresql:9.6/client'
    state: present

- name: Install a modularity appstream with defined stream
  ansible.builtin.dnf:
    name: '@postgresql:9.6'
    state: present

- name: Install a modularity appstream with defined profile
  ansible.builtin.dnf:
    name: '@postgresql/client'
    state: present
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.expect
    set output_file "ansible.builtin.expect.yml"

    set template_content "---
- name: Case insensitive password string match
  ansible.builtin.expect:
    command: passwd username
    responses:
      (?i)password: \"MySekretPa\$\$word\"
  no_log: true

- name: Match multiple regular expressions and demonstrate individual and repeated responses
  ansible.builtin.expect:
    command: /path/to/custom/command
    responses:
      Question:
        - response1
        - response2
        - response3
      \"^Match another prompt\$\": response

- name: Multiple questions with responses
  ansible.builtin.expect:
    command: /path/to/custom/command
    responses:
        \"Please provide your name\":
            - Anna
        \"Database user\":
            - \"{{ db_username }}\"
        \"Database password\":
            - \"{{ db_password }}\""

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.fail
    set output_file "ansible.builtin.fail.yml"

    set template_content "---
- name: Example using fail and when together
  ansible.builtin.fail:
    msg: The system may not be provisioned according to the CMDB status.
  when: cmdb_status != \"to-be-staged\""

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.fetch
    set output_file "ansible.builtin.fetch.yml"

    set template_content "---
- name: Store file into /tmp/fetched/host.example.com/tmp/somefile
  ansible.builtin.fetch:
    src: /tmp/somefile
    dest: /tmp/fetched

- name: Specifying a path directly
  ansible.builtin.fetch:
    src: /tmp/somefile
    dest: /tmp/prefix-{{ inventory_hostname }}
    flat: yes

- name: Specifying a destination path
  ansible.builtin.fetch:
    src: /tmp/uniquefile
    dest: /tmp/special/
    flat: yes

- name: Storing in a path relative to the playbook
  ansible.builtin.fetch:
    src: /tmp/uniquefile
    dest: special/prefix-{{ inventory_hostname }}
    flat: yes"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.file
    set output_file "ansible.builtin.file.yml"

    set template_content "---
- name: Change file ownership, group and permissions
  ansible.builtin.file:
    path: /etc/foo.conf
    owner: foo
    group: foo
    mode: '0644'

- name: Give insecure permissions to an existing file
  ansible.builtin.file:
    path: /work
    owner: root
    group: root
    mode: '1777'

- name: Create a symbolic link
  ansible.builtin.file:
    src: /file/to/link/to
    dest: /path/to/symlink
    owner: foo
    group: foo
    state: link

- name: Create two hard links
  ansible.builtin.file:
    src: '/tmp/{{ item.src }}'
    dest: '{{ item.dest }}'
    state: hard
  loop:
    - { src: x, dest: y }
    - { src: z, dest: k }

- name: Touch a file, using symbolic modes to set the permissions (equivalent to 0644)
  ansible.builtin.file:
    path: /etc/foo.conf
    state: touch
    mode: u=rw,g=r,o=r

- name: Touch the same file, but add/remove some permissions
  ansible.builtin.file:
    path: /etc/foo.conf
    state: touch
    mode: u+rw,g-wx,o-rwx

- name: Touch again the same file, but do not change times this makes the task idempotent
  ansible.builtin.file:
    path: /etc/foo.conf
    state: touch
    mode: u+rw,g-wx,o-rwx
    modification_time: preserve
    access_time: preserve

- name: Create a directory if it does not exist
  ansible.builtin.file:
    path: /etc/some_directory
    state: directory
    mode: '0755'

- name: Update modification and access time of given file
  ansible.builtin.file:
    path: /etc/some_file
    state: file
    modification_time: now
    access_time: now

- name: Set access time based on seconds from epoch value
  ansible.builtin.file:
    path: /etc/another_file
    state: file
    access_time: '{{ \"%Y%m%d%H%M.%S\" | strftime(stat_var.stat.atime) }}'

- name: Recursively change ownership of a directory
  ansible.builtin.file:
    path: /etc/foo
    state: directory
    recurse: yes
    owner: foo
    group: foo

- name: Remove file (delete file)
  ansible.builtin.file:
    path: /etc/foo.txt
    state: absent

- name: Recursively remove directory
  ansible.builtin.file:
    path: /etc/foo
    state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.find
    set output_file "ansible.builtin.find.yml"

    set template_content "---
- name: Recursively find /tmp files older than 2 days
  ansible.builtin.find:
    paths: /tmp
    age: 2d
    recurse: yes

- name: Recursively find /tmp files older than 4 weeks and equal or greater than 1 megabyte
  ansible.builtin.find:
    paths: /tmp
    age: 4w
    size: 1m
    recurse: yes

- name: Recursively find /var/tmp files with last access time greater than 3600 seconds
  ansible.builtin.find:
    paths: /var/tmp
    age: 3600
    age_stamp: atime
    recurse: yes

- name: Find /var/log files equal or greater than 10 megabytes ending with .old or .log.gz
  ansible.builtin.find:
    paths: /var/log
    patterns: ['*.old','*.log.gz']
    size: 10m

- name: Find /var/log files equal or greater than 10 megabytes via regex
  ansible.builtin.find:
    paths: /var/log
    patterns: '^.*?\\.(?:old|log\\.gz)\$'
    size: 10m
    use_regex: yes

- name: Find /var/log all directories, exclude nginx and mysql
  ansible.builtin.find:
    paths: /var/log
    recurse: no
    file_type: directory
    excludes: 'nginx,mysql'

- name: Use a single pattern containing a comma formatted as a list
  ansible.builtin.find:
    paths: /var/log
    file_type: file
    use_regex: yes
    patterns: ['^_[0-9]{2,4}_.*.log\$']

- name: Use multiple patterns containing a comma formatted as a YAML list
  ansible.builtin.find:
    paths: /var/log
    file_type: file
    use_regex: yes
    patterns:
      - '^_[0-9]{2,4}_.*.log\$'
      - '^[a-z]{1,5}_.*log\$'

- name: Find file containing \"wally\" without necessarily reading all files
  ansible.builtin.find:
    paths: /var/log
    file_type: file
    contains: wally
    read_whole_file: true
    patterns: ['^.*\\.log\$']
    use_regex: true
    recurse: true
    limit: 1
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.get_url
    set output_file "ansible.builtin.get_url.yml"

    set template_content "---
- name: Download foo.conf
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    mode: '0440'

- name: Download file and force basic auth
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    force_basic_auth: yes

- name: Download file with custom HTTP headers
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    headers:
      key1: one
      key2: two

- name: Download file with check (sha256)
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    checksum: sha256:b5bb9d8014a0f9b1d61e21e796d78dccdf1352f23cd32812f4850b878ae4944c

- name: Download file with check (md5)
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    checksum: md5:66dffb5228a211e61d6d7ef4a86f5758

- name: Download file with checksum url (sha256)
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    checksum: sha256:http://example.com/path/sha256sum.txt

- name: Download file from a file path
  ansible.builtin.get_url:
    url: file:///tmp/a_file.txt
    dest: /tmp/afilecopy.txt

- name: Fetch file that requires authentication
  ansible.builtin.get_url:
    url: http://example.com/path/file.conf
    dest: /etc/foo.conf
    username: bar
    password: '{{ mysecret }}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.git
    set output_file "ansible.builtin.git.yml"

    set template_content "---
- name: Git checkout
  ansible.builtin.git:
    repo: 'https://github.com/ansible/ansible.git'
    dest: /tmp/checkout
    version: release-0.22

- name: Read-write git checkout from github
  ansible.builtin.git:
    repo: git@github.com:ansible/ansible.git
    dest: /tmp/checkout

- name: Just ensuring the repo checkout exists
  ansible.builtin.git:
    repo: 'https://github.com/ansible/ansible.git'
    dest: /tmp/checkout
    update: no

- name: Just get information about the repository whether or not it has already been cloned locally
  ansible.builtin.git:
    repo: git@github.com:ansible/ansible.git
    dest: /tmp/checkout
    clone: no
    update: no

- name: Checkout a github repo and use refspec to fetch all pull requests
  ansible.builtin.git:
    repo: 'https://github.com/ansible/ansible.git'
    dest: /tmp/checkout
    refspec: '+refs/pull/*:refs/heads/*'

- name: Create git archive from repo
  ansible.builtin.git:
    repo: git@github.com:ansible/ansible.git
    dest: /tmp/checkout
    archive: /tmp/ansible.zip

- name: Clone a repo with separate git directory
  ansible.builtin.git:
    repo: 'https://github.com/ansible/ansible.git'
    dest: /tmp/checkout
    separate_git_dir: /tmp/repo

- name: Example clone of a single branch
  ansible.builtin.git:
    repo: git@github.com:ansible/ansible.git
    dest: /tmp/checkout
    single_branch: yes
    version: master

- name: Avoid hanging when http(s) password is missing
  ansible.builtin.git:
    repo: 'https://github.com/ansible/ansible.git'
    dest: /tmp/checkout
  environment:
    GIT_TERMINAL_PROMPT: 0
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.group
    set output_file "ansible.builtin.group.yml"

    set template_content "---
- name: Ensure group \"somegroup\" exists
  ansible.builtin.group:
    name: somegroup
    state: present

- name: Ensure group \"docker\" exists with correct gid
  ansible.builtin.group:
    name: docker
    state: present
    gid: 1750
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.hostname
    set output_file "ansible.builtin.hostname.yml"

    set template_content "---
- name: Set a hostname
  ansible.builtin.hostname:
    name: web01

- name: Set a hostname specifying strategy
  ansible.builtin.hostname:
    name: web01
    use: systemd
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.import_role
    set output_file "ansible.builtin.import_role.yml"

    set template_content "---
- hosts: all
  tasks:
    - ansible.builtin.import_role:
        name: myrole

    - name: Run tasks/other.yaml instead of 'main'
      ansible.builtin.import_role:
        name: myrole
        tasks_from: other

    - name: Pass variables to role
      ansible.builtin.import_role:
        name: myrole
      vars:
        rolevar1: value from task

    - name: Apply condition to each task in role
      ansible.builtin.import_role:
        name: myrole
      when: not idontwanttorun
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.import_playbook
    set output_file "ansible.builtin.import_playbook.yml"

    set template_content "---
- hosts: localhost
  tasks:
    - ansible.builtin.debug:
        msg: play1

- name: Include a play after another play
  ansible.builtin.import_playbook: otherplays.yaml

- name: Set variables on an imported playbook
  ansible.builtin.import_playbook: otherplays.yml
  vars:
    service: httpd

- name: Include a playbook from a collection
  ansible.builtin.import_playbook: my_namespace.my_collection.my_playbook

- name: This DOES NOT WORK
  hosts: all
  tasks:
    - ansible.builtin.debug:
        msg: task1

    - name: This fails because I'm inside a play already
      ansible.builtin.import_playbook: stuff.yaml
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.getent
    set output_file "ansible.builtin.getent.yml"

    set template_content "---
- name: Get root user info
  ansible.builtin.getent:
    database: passwd
    key: root
- ansible.builtin.debug:
    var: ansible_facts.getent_passwd

- name: Get all groups
  ansible.builtin.getent:
    database: group
    split: ':'
- ansible.builtin.debug:
    var: ansible_facts.getent_group

- name: Get all hosts, split by tab
  ansible.builtin.getent:
    database: hosts
- ansible.builtin.debug:
    var: ansible_facts.getent_hosts

- name: Get http service info, no error if missing
  ansible.builtin.getent:
    database: services
    key: http
    fail_key: False
- ansible.builtin.debug:
    var: ansible_facts.getent_services

- name: Get user password hash (requires sudo/root)
  ansible.builtin.getent:
    database: shadow
    key: www-data
    split: ':'
- ansible.builtin.debug:
    var: ansible_facts.getent_shadow
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.group_by
    set output_file "ansible.builtin.group_by.yml"

    set template_content "---
- name: Create groups based on the machine architecture
  ansible.builtin.group_by:
    key: machine_{{ ansible_machine }}

- name: Create groups like 'virt_kvm_host'
  ansible.builtin.group_by:
    key: virt_{{ ansible_virtualization_type }}_{{ ansible_virtualization_role }}

- name: Create nested groups
  ansible.builtin.group_by:
    key: el{{ ansible_distribution_major_version }}-{{ ansible_architecture }}
    parents:
      - el{{ ansible_distribution_major_version }}

- name: Add all active hosts to a static group
  ansible.builtin.group_by:
    key: done
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.dpkg_selections
    set output_file "ansible.builtin.dpkg_selections.yml"

    set template_content "---
- name: Prevent python from being upgraded
  ansible.builtin.dpkg_selections:
    name: python
    selection: hold

- name: Allow python to be upgraded
  ansible.builtin.dpkg_selections:
    name: python
    selection: install
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.import_tasks
    set output_file "ansible.builtin.import_tasks.yml"

    set template_content "---
- hosts: all
  tasks:
    - ansible.builtin.debug:
        msg: task1

    - name: Include task list in play
      ansible.builtin.import_tasks:
        file: stuff.yaml

    - ansible.builtin.debug:
        msg: task10

- hosts: all
  tasks:
    - ansible.builtin.debug:
        msg: task1

    - name: Apply conditional to all imported tasks
      ansible.builtin.import_tasks: stuff.yaml
      when: hostvar is defined
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.include_role
    set output_file "ansible.builtin.include_role.yml"

    set template_content "---
- ansible.builtin.include_role:
    name: myrole

- name: Run tasks/other.yaml instead of 'main'
  ansible.builtin.include_role:
    name: myrole
    tasks_from: other

- name: Pass variables to role
  ansible.builtin.include_role:
    name: myrole
  vars:
    rolevar1: value from task

- name: Use role in loop
  ansible.builtin.include_role:
    name: '{{ roleinputvar }}'
  loop:
    - '{{ roleinput1 }}'
    - '{{ roleinput2 }}'
  loop_control:
    loop_var: roleinputvar

- name: Conditional role
  ansible.builtin.include_role:
    name: myrole
  when: not idontwanttorun

- name: Apply tags to tasks within included file
  ansible.builtin.include_role:
    name: install
    apply:
      tags:
        - install
  tags:
    - always
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.include_tasks
    set output_file "ansible.builtin.include_tasks.yml"

    set template_content "---
- hosts: all
  tasks:
    - ansible.builtin.debug:
        msg: task1

    - name: Include task list in play
      ansible.builtin.include_tasks:
        file: stuff.yaml

    - ansible.builtin.debug:
        msg: task10

- hosts: all
  tasks:
    - ansible.builtin.debug:
        msg: task1

    - name: Include task list in play only if the condition is true
      ansible.builtin.include_tasks: \"{{ hostvar }}.yaml\"
      when: hostvar is defined

- name: Apply tags to tasks within included file
  ansible.builtin.include_tasks:
    file: install.yml
    apply:
      tags:
        - install
  tags:
    - always

- name: Apply tags to tasks within included file when using free-form
  ansible.builtin.include_tasks: install.yml
  args:
    apply:
      tags:
        - install
  tags:
    - always
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.include_vars
    set output_file "ansible.builtin.include_vars module.yml"

    set template_content "---
- name: Include vars of stuff.yaml into the 'stuff' variable (2.2).
  ansible.builtin.include_vars:
    file: stuff.yaml
    name: stuff

- name: Conditionally decide to load in variables into 'plans' when x is 0, otherwise do not. (2.2)
  ansible.builtin.include_vars:
    file: contingency_plan.yaml
    name: plans
  when: x == 0

- name: Load a variable file based on the OS type, or a default if not found. Using free-form to specify the file.
  ansible.builtin.include_vars: \"{{ lookup('ansible.builtin.first_found', params) }}\"
  vars:
    params:
      files:
        - '{{ansible_distribution}}.yaml'
        - '{{ansible_os_family}}.yaml'
        - default.yaml
      paths:
        - 'vars'

- name: Bare include (free-form)
  ansible.builtin.include_vars: myvars.yaml

- name: Include all .json and .jsn files in vars/all and all nested directories (2.3)
  ansible.builtin.include_vars:
    dir: vars/all
    extensions:
      - 'json'
      - 'jsn'

- name: Include all default extension files in vars/all and all nested directories and save the output in test. (2.2)
  ansible.builtin.include_vars:
    dir: vars/all
    name: test

- name: Include default extension files in vars/services (2.2)
  ansible.builtin.include_vars:
    dir: vars/services
    depth: 1

- name: Include only files matching bastion.yaml (2.2)
  ansible.builtin.include_vars:
    dir: vars
    files_matching: bastion.yaml

- name: Include all .yaml files except bastion.yaml (2.3)
  ansible.builtin.include_vars:
    dir: vars
    ignore_files:
      - 'bastion.yaml'
    extensions:
      - 'yaml'

- name: Ignore warnings raised for files with unknown extensions while loading (2.7)
  ansible.builtin.include_vars:
    dir: vars
    ignore_unknown_extensions: True
    extensions:
      - ''
      - 'yaml'
      - 'yml'
      - 'json'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.known_hosts
    set output_file "ansible.builtin.known_hosts.yml"

    set template_content "---
- name: Tell the host about our servers it might want to ssh to
  ansible.builtin.known_hosts:
    path: /etc/ssh/ssh_known_hosts
    name: foo.com.invalid
    key: \"{{ lookup('ansible.builtin.file', 'pubkeys/foo.com.invalid') }}\"

- name: Another way to call known_hosts
  ansible.builtin.known_hosts:
    name: host1.example.com   # or 10.9.8.77
    key: host1.example.com,10.9.8.77 ssh-rsa ASDeararAIUHI324324
    path: /etc/ssh/ssh_known_hosts
    state: present

- name: Add host with custom SSH port
  ansible.builtin.known_hosts:
    name: '[host1.example.com]:2222'
    key: '[host1.example.com]:2222 ssh-rsa ASDeararAIUHI324324'
    path: /etc/ssh/ssh_known_hosts
    state: present
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.iptables
    set output_file "ansible.builtin.iptables.yml"

    set template_content "---
- name: Block specific IP
  ansible.builtin.iptables:
    chain: INPUT
    source: 8.8.8.8
    jump: DROP
  become: yes

- name: Forward port 80 to 8600
  ansible.builtin.iptables:
    table: nat
    chain: PREROUTING
    in_interface: eth0
    protocol: tcp
    match: tcp
    destination_port: 80
    jump: REDIRECT
    to_ports: 8600
    comment: Redirect web traffic to port 8600
  become: yes

- name: Allow related and established connections
  ansible.builtin.iptables:
    chain: INPUT
    ctstate: ESTABLISHED,RELATED
    jump: ACCEPT
  become: yes

- name: Allow new incoming SYN packets on TCP port 22 (SSH)
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_port: 22
    ctstate: NEW
    syn: match
    jump: ACCEPT
    comment: Accept new SSH connections.

- name: Match on IP ranges
  ansible.builtin.iptables:
    chain: FORWARD
    src_range: 192.168.1.100-192.168.1.199
    dst_range: 10.0.0.1-10.0.0.50
    jump: ACCEPT

- name: Allow source IPs defined in ipset \"admin_hosts\" on port 22
  ansible.builtin.iptables:
    chain: INPUT
    match_set: admin_hosts
    match_set_flags: src
    destination_port: 22
    jump: ALLOW

- name: Tag all outbound tcp packets with DSCP mark 8
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DSCP
    table: mangle
    set_dscp_mark: 8
    protocol: tcp

- name: Tag all outbound tcp packets with DSCP DiffServ class CS1
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DSCP
    table: mangle
    set_dscp_mark_class: CS1
    protocol: tcp

- iptables:
    chain: ALLOWLIST
    chain_management: true

- iptables:
    chain: ALLOWLIST
    chain_management: true
    state: absent

- name: Insert a rule on line 5
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_port: 8080
    jump: ACCEPT
    action: insert
    rule_num: 5

- name: Set the policy for the INPUT chain to DROP
  ansible.builtin.iptables:
    chain: INPUT
    policy: DROP

- name: Reject tcp with tcp-reset
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    reject_with: tcp-reset
    ip_version: ipv4

- name: Set tcp flags
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DROP
    protocol: tcp
    tcp_flags:
      flags: ALL
      flags_set:
        - ACK
        - RST
        - SYN
        - FIN

- name: Iptables flush filter
  ansible.builtin.iptables:
    chain: \"{{ item }}\"
    flush: yes
  with_items: [ 'INPUT', 'FORWARD', 'OUTPUT' ]

- name: Iptables flush nat
  ansible.builtin.iptables:
    table: nat
    chain: \"{{ item }}\"
    flush: yes
  with_items: [ 'INPUT', 'OUTPUT', 'PREROUTING', 'POSTROUTING' ]

- name: Log packets arriving into an user-defined chain
  ansible.builtin.iptables:
    chain: LOGGING
    action: append
    state: present
    limit: 2/second
    limit_burst: 20
    log_prefix: \"IPTABLES:INFO: \"
    log_level: info

- name: Allow connections on multiple ports
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_ports:
      - \"80\"
      - \"443\"
      - \"8081:8083\"
    jump: ACCEPT
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.iptables
    set output_file "ansible.builtin.iptables.yml"

    set template_content "---
- name: Block specific IP
  ansible.builtin.iptables:
    chain: INPUT
    source: 8.8.8.8
    jump: DROP
  become: yes

- name: Forward port 80 to 8600
  ansible.builtin.iptables:
    table: nat
    chain: PREROUTING
    in_interface: eth0
    protocol: tcp
    match: tcp
    destination_port: 80
    jump: REDIRECT
    to_ports: 8600
    comment: Redirect web traffic to port 8600
  become: yes

- name: Allow related and established connections
  ansible.builtin.iptables:
    chain: INPUT
    ctstate: ESTABLISHED,RELATED
    jump: ACCEPT
  become: yes

- name: Allow new incoming SYN packets on TCP port 22 (SSH)
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_port: 22
    ctstate: NEW
    syn: match
    jump: ACCEPT
    comment: Accept new SSH connections.

- name: Match on IP ranges
  ansible.builtin.iptables:
    chain: FORWARD
    src_range: 192.168.1.100-192.168.1.199
    dst_range: 10.0.0.1-10.0.0.50
    jump: ACCEPT

- name: Allow source IPs defined in ipset \"admin_hosts\" on port 22
  ansible.builtin.iptables:
    chain: INPUT
    match_set: admin_hosts
    match_set_flags: src
    destination_port: 22
    jump: ALLOW

- name: Tag all outbound tcp packets with DSCP mark 8
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DSCP
    table: mangle
    set_dscp_mark: 8
    protocol: tcp

- name: Tag all outbound tcp packets with DSCP DiffServ class CS1
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DSCP
    table: mangle
    set_dscp_mark_class: CS1
    protocol: tcp

- iptables:
    chain: ALLOWLIST
    chain_management: true

- iptables:
    chain: ALLOWLIST
    chain_management: true
    state: absent

- name: Insert a rule on line 5
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_port: 8080
    jump: ACCEPT
    action: insert
    rule_num: 5

- name: Set the policy for the INPUT chain to DROP
  ansible.builtin.iptables:
    chain: INPUT
    policy: DROP

- name: Reject tcp with tcp-reset
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    reject_with: tcp-reset
    ip_version: ipv4

- name: Set tcp flags
  ansible.builtin.iptables:
    chain: OUTPUT
    jump: DROP
    protocol: tcp
    tcp_flags:
      flags: ALL
      flags_set:
        - ACK
        - RST
        - SYN
        - FIN

- name: Iptables flush filter
  ansible.builtin.iptables:
    chain: \"{{ item }}\"
    flush: yes
  with_items: [ 'INPUT', 'FORWARD', 'OUTPUT' ]

- name: Iptables flush nat
  ansible.builtin.iptables:
    table: nat
    chain: \"{{ item }}\"
    flush: yes
  with_items: [ 'INPUT', 'OUTPUT', 'PREROUTING', 'POSTROUTING' ]

- name: Log packets arriving into an user-defined chain
  ansible.builtin.iptables:
    chain: LOGGING
    action: append
    state: present
    limit: 2/second
    limit_burst: 20
    log_prefix: \"IPTABLES:INFO: \"
    log_level: info

- name: Allow connections on multiple ports
  ansible.builtin.iptables:
    chain: INPUT
    protocol: tcp
    destination_ports:
      - \"80\"
      - \"443\"
      - \"8081:8083\"
    jump: ACCEPT
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.lineinfile
    set output_file "ansible.builtin.lineinfile.yml"

    set template_content "---
- name: Ensure SELinux is set to enforcing mode
  ansible.builtin.lineinfile:
    path: /etc/selinux/config
    regexp: '^SELINUX='
    line: SELINUX=enforcing

- name: Make sure group wheel is not in the sudoers configuration
  ansible.builtin.lineinfile:
    path: /etc/sudoers
    state: absent
    regexp: '^%wheel'

- name: Replace a localhost entry with our own
  ansible.builtin.lineinfile:
    path: /etc/hosts
    regexp: '^127\\.0\\.0\\.1'
    line: 127.0.0.1 localhost
    owner: root
    group: root
    mode: '0644'

- name: Replace a localhost entry searching for a literal string to avoid escaping
  ansible.builtin.lineinfile:
    path: /etc/hosts
    search_string: '127.0.0.1'
    line: 127.0.0.1 localhost
    owner: root
    group: root
    mode: '0644'

- name: Ensure the default Apache port is 8080
  ansible.builtin.lineinfile:
    path: /etc/httpd/conf/httpd.conf
    regexp: '^Listen '
    insertafter: '^#Listen '
    line: Listen 8080

- name: Ensure php extension matches new pattern
  ansible.builtin.lineinfile:
    path: /etc/httpd/conf/httpd.conf
    search_string: '<FilesMatch \".php[45]?\$\">'
    insertafter: '^\\t<Location \\/>\\n'
    line: '        <FilesMatch \".php[34]?\$\">'

- name: Ensure we have our own comment added to /etc/services
  ansible.builtin.lineinfile:
    path: /etc/services
    regexp: '^# port for http'
    insertbefore: '^www.*80/tcp'
    line: '# port for http by default'

- name: Add a line to a file if the file does not exist, without passing regexp
  ansible.builtin.lineinfile:
    path: /tmp/testfile
    line: 192.168.1.99 foo.lab.net foo
    create: yes

- name: Ensure the JBoss memory settings are exactly as needed
  ansible.builtin.lineinfile:
    path: /opt/jboss-as/bin/standalone.conf
    regexp: '^(.*)Xms(\\d+)m(.*)\$'
    line: '\\1Xms\${xms}m\\3'
    backrefs: yes

- name: Validate the sudoers file before saving
  ansible.builtin.lineinfile:
    path: /etc/sudoers
    state: present
    regexp: '^%ADMIN ALL='
    line: '%ADMIN ALL=(ALL) NOPASSWD: ALL'
    validate: /usr/sbin/visudo -cf %s

- name: Use backrefs with alternative group syntax to avoid conflicts with variable values
  ansible.builtin.lineinfile:
    path: /tmp/config
    regexp: '^(host=).*'
    line: '\\g<1>{{ hostname }}'
    backrefs: yes
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.meta
    set output_file "ansible.builtin.meta.yml"

    set template_content "---
# Example showing flushing handlers on demand, not at end of play
- ansible.builtin.template:
    src: new.j2
    dest: /etc/config.txt
  notify: myhandler

- name: Force all notified handlers to run at this point, not waiting for normal sync points
  ansible.builtin.meta: flush_handlers

# Example showing how to refresh inventory during play
- name: Reload inventory, useful with dynamic inventories when play makes changes to the existing hosts
  cloud_guest:            # this is fake module
    name: newhost
    state: present

- name: Refresh inventory to ensure new instances exist in inventory
  ansible.builtin.meta: refresh_inventory

# Example showing how to clear all existing facts of targeted hosts
- name: Clear gathered facts from all currently targeted hosts
  ansible.builtin.meta: clear_facts

# Example showing how to continue using a failed target, for the next play
- name: Bring host back to play after failure
  ansible.builtin.copy:
    src: file
    dest: /etc/file
  remote_user: imightnothavepermission

- ansible.builtin.meta: clear_host_errors

# Example showing how to reset an existing connection
- ansible.builtin.user:
    name: '{{ ansible_user }}'
    groups: input

- name: Reset ssh connection to allow user changes to affect 'current login user'
  ansible.builtin.meta: reset_connection

# Example showing how to end the play for specific targets
- name: End the play for hosts that run CentOS 6
  ansible.builtin.meta: end_host
  when:
    - ansible_distribution == 'CentOS'
    - ansible_distribution_major_version == '6'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.ping
    set output_file "ansible.builtin.ping.yml"

    set template_content "---
# Test we can logon to 'webservers' and execute python with json lib.
# ansible webservers -m ansible.builtin.ping

- name: Example from an Ansible Playbook
  ansible.builtin.ping:

- name: Induce an exception to see what happens
  ansible.builtin.ping:
    data: crash
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.mount_facts
    set output_file "mount_facts_examples.yml"

    set template_content "---
- name: Get non-local devices
  mount_facts:
    devices: \"[!/]*\"

- name: Get FUSE subtype mounts
  mount_facts:
    fstypes:
      - \"fuse.*\"

- name: Get NFS mounts during gather_facts with timeout
  hosts: all
  gather_facts: true
  vars:
    ansible_facts_modules:
      - ansible.builtin.mount_facts
  module_default:
    ansible.builtin.mount_facts:
      timeout: 10
      fstypes:
        - nfs
        - nfs4

- name: Get mounts from a non-default location
  mount_facts:
    sources:
      - /usr/etc/fstab

- name: Get mounts from the mount binary
  mount_facts:
    sources:
      - mount
    mount_binary: /sbin/mount
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.package
    set output_file "ansible.builtin.package.yml"

    set template_content "---
- name: Install ntpdate
  ansible.builtin.package:
    name: ntpdate
    state: present

- name: Remove the apache package using a variable
  ansible.builtin.package:
    name: \"{{ apache }}\"
    state: absent

- name: Install the latest version of Apache and MariaDB
  ansible.builtin.package:
    name:
      - httpd
      - mariadb-server
    state: latest

- name: Use the dnf package manager to install httpd
  ansible.builtin.package:
    name: httpd
    state: present
    use: dnf
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.pause
    set output_file "ansible.builtin.pause.yml"

    set template_content "---
- name: Pause for 5 minutes to build app cache
  ansible.builtin.pause:
    minutes: 5

- name: Pause until you can verify updates to an application were successful
  ansible.builtin.pause:

- name: A helpful reminder of what to look out for post-update
  ansible.builtin.pause:
    prompt: \"Make sure org.foo.FooOverload exception is not present\"

- name: Pause to get some sensitive input
  ansible.builtin.pause:
    prompt: \"Enter a secret\"
    echo: no
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.package_facts
    set output_file "ansible.builtin.package_facts.yml"

    set template_content "---
- name: Gather the package facts
  ansible.builtin.package_facts:
    manager: auto

- name: Print the package facts
  ansible.builtin.debug:
    var: ansible_facts.packages

- name: Check whether a package called foobar is installed
  ansible.builtin.debug:
    msg: \"{{ ansible_facts.packages['foobar'] | length }} versions of foobar are installed!\"
  when: \"'foobar' in ansible_facts.packages\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.pip
    set output_file "ansible.builtin.pip.yml"

    set template_content "---
- name: Install bottle python package
  ansible.builtin.pip:
    name: bottle

- name: Install bottle python package on version 0.11
  ansible.builtin.pip:
    name: bottle==0.11

- name: Install bottle python package with version specifiers
  ansible.builtin.pip:
    name: bottle>0.10,<0.20,!=0.11

- name: Install multiple python packages with version specifiers
  ansible.builtin.pip:
    name:
      - django>1.11.0,<1.12.0
      - bottle>0.10,<0.20,!=0.11

- name: Install python package using a proxy
  ansible.builtin.pip:
    name: six
  environment:
    http_proxy: 'http://127.0.0.1:8080'
    https_proxy: 'https://127.0.0.1:8080'

- name: Install MyApp from a git repository
  ansible.builtin.pip:
    name: git+http://myrepo/app/MyApp

- name: Install MyApp from a local tarball
  ansible.builtin.pip:
    name: file:///path/to/MyApp.tar.gz

- name: Install bottle into a virtualenv (no global packages)
  ansible.builtin.pip:
    name: bottle
    virtualenv: /my_app/venv

- name: Install bottle into a virtualenv (with global packages)
  ansible.builtin.pip:
    name: bottle
    virtualenv: /my_app/venv
    virtualenv_site_packages: yes

- name: Install bottle using Python 3.13
  ansible.builtin.pip:
    name: bottle
    virtualenv: /my_app/venv
    virtualenv_command: virtualenv-3.13

- name: Install python requirements file
  ansible.builtin.pip:
    requirements: /my_app/requirements.txt

- name: Install requirements with custom index URL
  ansible.builtin.pip:
    requirements: /my_app/requirements.txt
    extra_args: -i https://example.com/pypi/simple

- name: Install requirements offline from local packages
  ansible.builtin.pip:
    requirements: /my_app/requirements.txt
    extra_args: \"--no-index --find-links=file:///my_downloaded_packages_dir\"

- name: Install bottle for Python 3.13 specifically
  ansible.builtin.pip:
    name: bottle
    executable: pip3.13

- name: Force reinstall bottle
  ansible.builtin.pip:
    name: bottle
    state: forcereinstall

- name: Install bottle ensuring umask 0022
  ansible.builtin.pip:
    name: bottle
    umask: \"0022\"
  become: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.raw
    set output_file "ansible.builtin.raw.yml"

    set template_content "---
- name: Bootstrap a host without Python installed
  ansible.builtin.raw: dnf install -y python3 python3-libdnf

- name: Run a command that uses non-posix shell-isms
  ansible.builtin.raw: cat < /tmp/*txt
  args:
    executable: /bin/bash

- name: Safely use templated variables. Always use quote filter to avoid injection issues.
  ansible.builtin.raw: \"{{ package_mgr|quote }} {{ pkg_flags|quote }} install {{ python|quote }}\"

- name: List user accounts on a Windows system
  ansible.builtin.raw: Get-WmiObject -Class Win32_UserAccount
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.reboot
    set output_file "ansible.builtin.reboot.yml"

    set template_content "---
- name: Unconditionally reboot the machine with all defaults
  ansible.builtin.reboot:

- name: Reboot a slow machine that might have lots of updates to apply
  ansible.builtin.reboot:
    reboot_timeout: 3600

- name: Reboot a machine with shutdown command in unusual place
  ansible.builtin.reboot:
    search_paths:
      - '/lib/molly-guard'

- name: Reboot machine using a custom reboot command
  ansible.builtin.reboot:
    reboot_command: launchctl reboot userspace
    boot_time_command: uptime | cut -d ' ' -f 5

- name: Reboot machine and send a message
  ansible.builtin.reboot:
    msg: \"Rebooting machine in 5 seconds\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.replace
    set output_file "ansible.builtin.replace.yml"

    set template_content "---
- name: Unconditionally reboot the machine with all defaults
  ansible.builtin.reboot:

- name: Reboot a slow machine that might have lots of updates to apply
  ansible.builtin.reboot:
    reboot_timeout: 3600

- name: Reboot a machine with shutdown command in unusual place
  ansible.builtin.reboot:
    search_paths:
      - '/lib/molly-guard'

- name: Reboot machine using a custom reboot command
  ansible.builtin.reboot:
    reboot_command: launchctl reboot userspace
    boot_time_command: uptime | cut -d ' ' -f 5

- name: Reboot machine and send a message
  ansible.builtin.reboot:
    msg: \"Rebooting machine in 5 seconds\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.script
    set output_file "ansible.builtin.script.yml"

    set template_content "---
- name: Replace old hostname with new hostname (requires Ansible >= 2.4)
  ansible.builtin.replace:
    path: /etc/hosts
    regexp: '(\\s+)old\\.host\\.name(\\s+.*)?\$'
    replace: '\\1new.host.name\\2'

- name: Replace after the expression till the end of the file (requires Ansible >= 2.4)
  ansible.builtin.replace:
    path: /etc/apache2/sites-available/default.conf
    after: 'NameVirtualHost [*]'
    regexp: '^(.+)\$'
    replace: '# \\1'

- name: Replace before the expression from the beginning of the file (requires Ansible >= 2.4)
  ansible.builtin.replace:
    path: /etc/apache2/sites-available/default.conf
    before: '# live site config'
    regexp: '^(.+)\$'
    replace: '# \\1'

# Prior to Ansible 2.7.10, using before and after in combination did the opposite of what was intended.
# see https://github.com/ansible/ansible/issues/31354 for details.
# Note (?m) which turns on MULTILINE mode so ^ matches any line's beginning
- name: Replace between the expressions (requires Ansible >= 2.4)
  ansible.builtin.replace:
    path: /etc/hosts
    after: '(?m)^<VirtualHost [*]>'
    before: '</VirtualHost>'
    regexp: '^(.+)\$'
    replace: '# \\1'

- name: Supports common file attributes
  ansible.builtin.replace:
    path: /home/jdoe/.ssh/known_hosts
    regexp: '^old\\.host\\.name[^\\n]*\\n'
    owner: jdoe
    group: jdoe
    mode: '0644'

- name: Supports a validate command
  ansible.builtin.replace:
    path: /etc/apache/ports
    regexp: '^(NameVirtualHost|Listen)\\s+80\\s*\$'
    replace: '\\1 127.0.0.1:8080'
    validate: '/usr/sbin/apache2ctl -f %s -t'

- name: Short form task (in ansible 2+) necessitates backslash-escaped sequences
  ansible.builtin.replace: path=/etc/hosts regexp='\\\\b(localhost)(\\\\d*)\\\\b' replace='\\\\1\\\\2.localdomain\\\\2 \\\\1\\\\2'

- name: Long form task does not
  ansible.builtin.replace:
    path: /etc/hosts
    regexp: '\\b(localhost)(\\d*)\\b'
    replace: '\\1\\2.localdomain\\2 \\1\\2'

- name: Explicitly specifying positional matched groups in replacement
  ansible.builtin.replace:
    path: /etc/ssh/sshd_config
    regexp: '^(ListenAddress[ ]+)[^\\n]+\$'
    replace: '\\g<1>0.0.0.0'

- name: Explicitly specifying named matched groups
  ansible.builtin.replace:
    path: /etc/ssh/sshd_config
    regexp: '^(?P<dctv>ListenAddress[ ]+)(?P<host>[^\\n]+)\$'
    replace: '#\\g<dctv>\\g<host>\\n\\g<dctv>0.0.0.0'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.rpm_key
    set output_file "ansible.builtin.rpm_key.yml"

    set template_content "---
- name: Import a key from a url
  ansible.builtin.rpm_key:
    state: present
    key: http://apt.sw.be/RPM-GPG-KEY.dag.txt

- name: Import a key from a file
  ansible.builtin.rpm_key:
    state: present
    key: /path/to/key.gpg

- name: Ensure a key is not present in the db
  ansible.builtin.rpm_key:
    state: absent
    key: DEADB33F

- name: Verify the key, using a fingerprint, before import
  ansible.builtin.rpm_key:
    key: /path/to/RPM-GPG-KEY.dag.txt
    fingerprint: EBC6 E12C 62B1 C734 026B  2122 A20E 5214 6B8D 79E6

- name: Verify the key, using multiple fingerprints, before import
  ansible.builtin.rpm_key:
    key: /path/to/RPM-GPG-KEY.dag.txt
    fingerprint:
      - EBC6 E12C 62B1 C734 026B  2122 A20E 5214 6B8D 79E6
      - 19B7 913E 6284 8E3F 4D78 D6B4 ECD9 1AB2 2EB6 8D86
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.shell
    set output_file "ansible.builtin.shell.yml"

    set template_content "---
- name: Execute the command in remote shell; stdout goes to the specified file on the remote
  ansible.builtin.shell: somescript.sh >> somelog.txt

- name: Change the working directory to somedir/ before executing the command
  ansible.builtin.shell: somescript.sh >> somelog.txt
  args:
    chdir: somedir/

# You can also use the 'args' form to provide the options.
- name: This command will change the working directory to somedir/ and will only run when somedir/somelog.txt doesn't exist
  ansible.builtin.shell: somescript.sh >> somelog.txt
  args:
    chdir: somedir/
    creates: somelog.txt

# You can also use the 'cmd' parameter instead of free form format.
- name: This command will change the working directory to somedir/
  ansible.builtin.shell:
    cmd: ls -l | grep log
    chdir: somedir/

- name: Run a command that uses non-posix shell-isms (in this example /bin/sh doesn't handle redirection and wildcards together but bash does)
  ansible.builtin.shell: cat < /tmp/*txt
  args:
    executable: /bin/bash

- name: Run a command using a templated variable (always use quote filter to avoid injection)
  ansible.builtin.shell: cat {{ myfile|quote }}

# You can use shell to run other executables to perform actions inline
- name: Run expect to wait for a successful PXE boot via out-of-band CIMC
  ansible.builtin.shell: |
    set timeout 300
    spawn ssh admin@{{ cimc_host }}

    expect \"password:\"
    send \"{{ cimc_password }}\\n\"

    expect \"\\n{{ cimc_name }}\"
    send \"connect host\\n\"

    expect \"pxeboot.n12\"
    send \"\\n\"

    exit 0
  args:
    executable: /usr/bin/expect
  delegate_to: localhost
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.service
    set output_file "ansible.builtin.service.yml"

    set template_content "---
- name: Start service httpd, if not started
  ansible.builtin.service:
    name: httpd
    state: started

- name: Stop service httpd, if started
  ansible.builtin.service:
    name: httpd
    state: stopped

- name: Restart service httpd, in all cases
  ansible.builtin.service:
    name: httpd
    state: restarted

- name: Reload service httpd, in all cases
  ansible.builtin.service:
    name: httpd
    state: reloaded

- name: Enable service httpd, and not touch the state
  ansible.builtin.service:
    name: httpd
    enabled: yes

- name: Start service foo, based on running process /usr/bin/foo
  ansible.builtin.service:
    name: foo
    pattern: /usr/bin/foo
    state: started

- name: Restart network service for interface eth0
  ansible.builtin.service:
    name: network
    state: restarted
    args: eth0
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.service_facts
    set output_file "ansible.builtin.service_facts.yml"

    set template_content "---
- name: Populate service facts
  ansible.builtin.service_facts:

- name: Print service facts
  ansible.builtin.debug:
    var: ansible_facts.services

- name: Show names of existing systemd services, sometimes systemd knows about services that were never installed
  ansible.builtin.debug:
    msg: {{ existing_systemd_services | map(attribute='name') }}
  vars:
    known_systemd_services: \"{{ ansible_facts['services'].values() | selectattr('source', 'equalto', 'systemd') }}\"
    existing_systemd_services: \"{{ known_systemd_services | rejectattr('status', 'equalto', 'not-found') }}\"

- name: Restart systemd service if it exists
  ansible.builtin.service:
    state: restarted
    name: ntpd.service
  when: ansible_facts['services']['ntpd.service']['status'] | default('not-found') != 'not-found'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.stat
    set output_file "ansible.builtin.stat.yml"

    set template_content "---
# Obtain the stats of /etc/foo.conf, and check that the file still belongs
# to 'root'. Fail otherwise.
- name: Get stats of a file
  ansible.builtin.stat:
    path: /etc/foo.conf
  register: st

- name: Fail if the file does not belong to 'root'
  ansible.builtin.fail:
    msg: \"Whoops! file ownership has changed\"
  when: st.stat.pw_name != 'root'

# Determine if a path exists and is a symlink.
- name: Get stats of the FS object
  ansible.builtin.stat:
    path: /path/to/something
  register: sym

- name: Print a debug message
  ansible.builtin.debug:
    msg: \"islnk isn't defined (path doesn't exist)\"
  when: sym.stat.islnk is not defined

- name: Print a debug message
  ansible.builtin.debug:
    msg: \"islnk is defined (path must exist)\"
  when: sym.stat.islnk is defined

- name: Print a debug message
  ansible.builtin.debug:
    msg: \"Path exists and is a symlink\"
  when: sym.stat.islnk is defined and sym.stat.islnk

- name: Print a debug message
  ansible.builtin.debug:
    msg: \"Path exists and isn't a symlink\"
  when: sym.stat.islnk is defined and sym.stat.islnk == False

# Determine if a path exists and is a directory.
- name: Get stats of the FS object
  ansible.builtin.stat:
    path: /path/to/something
  register: p

- name: Print a debug message
  ansible.builtin.debug:
    msg: \"Path exists and is a directory\"
  when: p.stat.isdir is defined and p.stat.isdir

- name: Do not calculate the checksum
  ansible.builtin.stat:
    path: /path/to/myhugefile
    get_checksum: no

- name: Use sha256 to calculate the checksum
  ansible.builtin.stat:
    path: /path/to/something
    checksum_algorithm: sha256
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.set_fact
    set output_file "ansible.builtin.set_fact.yml"

    set template_content "---
- name: Setting host facts using key=value pairs, this format can only create strings or booleans
  ansible.builtin.set_fact: one_fact=\"something\" other_fact=\"{{ local_var }}\"

- name: Setting host facts using complex arguments
  ansible.builtin.set_fact:
    one_fact: something
    other_fact: \"{{ local_var * 2 }}\"
    another_fact: \"{{ some_registered_var.results | map(attribute='ansible_facts.some_fact') | list }}\"

- name: Setting facts so that they will be persisted in the fact cache
  ansible.builtin.set_fact:
    one_fact: something
    other_fact: \"{{ local_var * 2 }}\"
    cacheable: yes

- name: Creating list and dictionary variables
  ansible.builtin.set_fact:
    one_dict:
        something: here
        other: there
    one_list:
        - a
        - b
        - c

# As of Ansible 1.8, Ansible will convert boolean strings ('true', 'false', 'yes', 'no')
# to proper boolean values when using the key=value syntax.
- name: Setting booleans using complex argument style
  ansible.builtin.set_fact:
    one_fact: yes
    other_fact: no

- name: Creating list and dictionary variables using 'shorthand' YAML
  ansible.builtin.set_fact:
    two_dict: {'something': here2, 'other': somewhere}
    two_list: [1,2,3]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.set_stats
    set output_file "ansible.builtin.set_stats.yml"

    set template_content "---
- name: Aggregating packages_installed stat per host
  ansible.builtin.set_stats:
    data:
      packages_installed: 31
    per_host: yes

- name: Aggregating random stats for all hosts using complex arguments
  ansible.builtin.set_stats:
    data:
      one_stat: 11
      other_stat: \"{{ local_var * 2 }}\"
      another_stat: \"{{ some_registered_var.results | map(attribute='ansible_facts.some_fact') | list }}\"
    per_host: no

- name: Setting stats (not aggregating)
  ansible.builtin.set_stats:
    data:
      the_answer: 42
    aggregate: no
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.setup
    set output_file "ansible.builtin.setup.yml"

    set template_content "---
# Display facts from all hosts and store them indexed by hostname
- name: Display facts from all hosts and store them indexed by hostname
  ansible.builtin.setup:
    gather_subset: all
  register: all_facts

# Display only facts regarding memory
- name: Display only facts regarding memory
  ansible.builtin.setup:
    filter:
      - 'ansible_*_mb'

# Display only facts returned by facter
- name: Display only facts returned by facter
  ansible.builtin.setup:
    filter:
      - 'facter_*'

# Collect only facts returned by facter
- name: Collect only facts returned by facter
  ansible.builtin.setup:
    gather_subset:
      - '!all'
      - facter

# Filter and return only selected facts
- name: Filter and return only selected facts
  ansible.builtin.setup:
    filter:
      - 'ansible_distribution'
      - 'ansible_machine_id'
      - 'ansible_*_mb'

# Display only facts about certain interfaces
- name: Display facts about certain interfaces
  ansible.builtin.setup:
    filter:
      - 'ansible_eth[0-2]'

# Gather only network and virtual facts
- name: Gather only network and virtual facts
  ansible.builtin.setup:
    gather_subset:
      - network
      - virtual

# Gather only network and virtual facts (exclude default)
- name: Gather only network and virtual facts (exclude default)
  ansible.builtin.setup:
    gather_subset:
      - '!all'
      - network
      - virtual

# Gather facts excluding facter and ohai
- name: Gather facts excluding facter and ohai
  ansible.builtin.setup:
    gather_subset:
      - '!facter'
      - '!ohai'

# Gather only default minimum facts
- name: Gather only default minimum facts
  ansible.builtin.setup:
    gather_subset:
      - '!all'

# Gather no facts
- name: Gather no facts
  ansible.builtin.setup:
    gather_subset:
      - '!all'
      - '!min'

# Gather facts from Windows hosts with custom fact path
- name: Gather facts from Windows hosts with custom fact path
  ansible.builtin.setup:
    fact_path: \"c:\\\\custom_facts\"

# Gather facts from dbservers group (delegating)
- hosts: app_servers
  tasks:
    - name: Gather facts from db servers
      ansible.builtin.setup:
        gather_subset: all
      delegate_to: \"{{ item }}\"
      delegate_facts: true
      loop: \"{{ groups['dbservers'] }}\"

# Standard gather_subset=!all example
- name: Gather only default minimum facts (subset !all)
  ansible.builtin.setup:
    gather_subset:
      - '!all'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.slurp
    set output_file "ansible.builtin.slurp.yml"

    set template_content "---
# Playbook: Slurp examples

- name: Gather mounts from remote machine
  hosts: all
  gather_facts: no
  tasks:
    - name: Find out what the remote machine's mounts are
      ansible.builtin.slurp:
        src: /proc/mounts
      register: mounts

    - name: Print returned mounts information
      ansible.builtin.debug:
        msg: \"{{ mounts['content'] | b64decode }}\"


- name: Gather SSHD PID file from remote host
  hosts: host
  gather_facts: no
  tasks:
    - name: Slurp the SSHD PID file
      ansible.builtin.slurp:
        src: /var/run/sshd.pid
      register: sshd_pid_file

    - name: Show the decoded PID
      ansible.builtin.debug:
        msg: \"{{ sshd_pid_file.content | b64decode }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.systemd_service
    set output_file "ansible.builtin.systemd_service.yml"

    set template_content "---
# Playbook: Systemd service examples

- name: Manage systemd services
  hosts: all
  become: true
  gather_facts: yes
  tasks:

    - name: Make sure a service unit is running
      ansible.builtin.systemd_service:
        name: httpd
        state: started

    - name: Stop service cron on Debian, if running
      ansible.builtin.systemd_service:
        name: cron
        state: stopped

    - name: Restart service cron on CentOS, always reload daemon to pick up config changes
      ansible.builtin.systemd_service:
        name: crond
        state: restarted
        daemon_reload: true

    - name: Reload service httpd, in all cases
      ansible.builtin.systemd_service:
        name: httpd.service
        state: reloaded

    - name: Enable service httpd and ensure it is not masked
      ansible.builtin.systemd_service:
        name: httpd
        enabled: true
        masked: no

    - name: Enable a timer unit for dnf-automatic
      ansible.builtin.systemd_service:
        name: dnf-automatic.timer
        state: started
        enabled: true

    - name: Force systemd to reread configs (Ansible >= 2.4)
      ansible.builtin.systemd_service:
        daemon_reload: true

    - name: Force systemd to re-execute itself (Ansible >= 2.8)
      ansible.builtin.systemd_service:
        daemon_reexec: true

    - name: Run a user service when XDG_RUNTIME_DIR is not set on remote login
      ansible.builtin.systemd_service:
        name: myservice
        state: started
        scope: user
      environment:
        XDG_RUNTIME_DIR: \"/run/user/{{ myuid }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.tempfile
    set output_file "ansible.builtin.tempfile.yml"

    set template_content "---
# Playbook: Temporary file examples

- name: Create temporary build directory
  ansible.builtin.tempfile:
    state: directory
    suffix: build

- name: Create temporary file
  ansible.builtin.tempfile:
    state: file
    suffix: temp
  register: tempfile_1

- name: Create a temporary file with a specific prefix
  ansible.builtin.tempfile:
    state: file
    suffix: txt
    prefix: myfile_

- name: Use the registered var and the file module to remove the temporary file
  ansible.builtin.file:
    path: \"{{ tempfile_1.path }}\"
    state: absent
  when: tempfile_1.path is defined
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.unarchive
    set output_file "ansible.ansible.builtin.unarchive.yml"

    set template_content "---
# Playbook: Unarchive examples

- name: Extract foo.tgz into /var/lib/foo
  ansible.builtin.unarchive:
    src: foo.tgz
    dest: /var/lib/foo

- name: Unarchive a file that is already on the remote machine
  ansible.builtin.unarchive:
    src: /tmp/foo.zip
    dest: /usr/local/bin
    remote_src: yes

- name: Unarchive a file that needs to be downloaded
  ansible.builtin.unarchive:
    src: https://example.com/example.zip
    dest: /usr/local/bin
    remote_src: yes

- name: Unarchive a file with extra options
  ansible.builtin.unarchive:
    src: /tmp/foo.zip
    dest: /usr/local/bin
    extra_opts:
      - --transform
      - s/^xxx/yyy/
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.uri
    set output_file "ansible.builtin.uri.yml"

    set template_content "---
# Playbook: URI module examples

- name: Check that you can connect (GET) to a page and it returns a status 200
  hosts: all
  gather_facts: no
  tasks:
    - name: Connect to example.com
      ansible.builtin.uri:
        url: http://www.example.com

    - name: Check that a page returns successfully but fail if the word AWESOME is not in the page contents
      ansible.builtin.uri:
        url: http://www.example.com
        return_content: true
      register: this
      failed_when: \"this is failed or 'AWESOME' not in this.content\"

    - name: Create a JIRA issue
      ansible.builtin.uri:
        url: https://your.jira.example.com/rest/api/2/issue/
        user: your_username
        password: your_pass
        method: POST
        body: \"{{ lookup('ansible.builtin.file','issue.json') }}\"
        force_basic_auth: true
        status_code: 201
        body_format: json

    - name: Login to a form based webpage, then use the returned cookie to access the app in later tasks
      ansible.builtin.uri:
        url: https://your.form.based.auth.example.com/index.php
        method: POST
        body_format: form-urlencoded
        body:
          name: your_username
          password: your_password
          enter: Sign in
        status_code: 302
      register: login

    - name: Login to a form based webpage using a list of tuples
      ansible.builtin.uri:
        url: https://your.form.based.auth.example.com/index.php
        method: POST
        body_format: form-urlencoded
        body:
          - [ name, your_username ]
          - [ password, your_password ]
          - [ enter, Sign in ]
        status_code: 302
      register: login_list

    - name: Upload a file via multipart/form-multipart
      ansible.builtin.uri:
        url: https://httpbin.org/post
        method: POST
        body_format: form-multipart
        body:
          file1:
            filename: /bin/true
            mime_type: application/octet-stream
            multipart_encoding: base64
          file2:
            content: text based file content
            filename: fake.txt
            mime_type: text/plain
            multipart_encoding: 7or8bit
          text_form_field: value

    - name: Connect to website using a previously stored cookie
      ansible.builtin.uri:
        url: https://your.form.based.auth.example.com/dashboard.php
        method: GET
        return_content: true
        headers:
          Cookie: \"{{ login.cookies_string }}\"

    - name: Queue build of a project in Jenkins
      ansible.builtin.uri:
        url: http://{{ jenkins.host }}/job/{{ jenkins.job }}/build?token={{ jenkins.token }}
        user: \"{{ jenkins.user }}\"
        password: \"{{ jenkins.password }}\"
        method: GET
        force_basic_auth: true
        status_code: 201

    - name: POST from contents of local file
      ansible.builtin.uri:
        url: https://httpbin.org/post
        method: POST
        src: file.json

    - name: POST from contents of remote file
      ansible.builtin.uri:
        url: https://httpbin.org/post
        method: POST
        src: /path/to/my/file.json
        remote_src: true

    - name: Create workspaces in Log analytics Azure
      ansible.builtin.uri:
        url: https://www.mms.microsoft.com/Embedded/Api/ConfigDataSources/LogManagementData/Save
        method: POST
        body_format: json
        status_code: [200, 202]
        return_content: true
        headers:
          Content-Type: application/json
          x-ms-client-workspace-path: /subscriptions/{{ sub_id }}/resourcegroups/{{ res_group }}/providers/microsoft.operationalinsights/workspaces/{{ w_spaces }}
          x-ms-client-platform: ibiza
          x-ms-client-auth-token: \"{{ token_az }}\"
        body: 

    - name: Pause play until a URL is reachable from this host
      ansible.builtin.uri:
        url: \"http://192.0.2.1/some/test\"
        follow_redirects: none
        method: GET
      register: _result
      until: _result.status == 200
      retries: 720
      delay: 5

    - name: Provide SSL/TLS ciphers as a list
      ansible.builtin.uri:
        url: https://example.org
        ciphers:
          - '@SECLEVEL=2'
          - ECDH+AESGCM
          - ECDH+CHACHA20
          - ECDH+AES
          - DHE+AES
          - '!aNULL'
          - '!eNULL'
          - '!aDSS'
          - '!SHA1'
          - '!AESCCM'

    - name: Provide SSL/TLS ciphers as an OpenSSL formatted cipher list
      ansible.builtin.uri:
        url: https://example.org
        ciphers: '@SECLEVEL=2:ECDH+AESGCM:ECDH+CHACHA20:ECDH+AES:DHE+AES:!aNULL:!eNULL:!aDSS:!SHA1:!AESCCM'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.template
    set output_file "ansible.builtin.template.yml"

    set template_content "---
# Playbook: Template module examples

- name: Template a file to /etc/file.conf
  hosts: all
  gather_facts: no
  tasks:
    - name: Template a file to /etc/file.conf
      ansible.builtin.template:
        src: /mytemplates/foo.j2
        dest: /etc/file.conf
        owner: bin
        group: wheel
        mode: '0644'

    - name: Template a file, using symbolic modes (equivalent to 0644)
      ansible.builtin.template:
        src: /mytemplates/foo.j2
        dest: /etc/file.conf
        owner: bin
        group: wheel
        mode: u=rw,g=r,o=r

    - name: Copy a version of named.conf that is dependent on the OS
      ansible.builtin.template:
        src: named.conf_{{ ansible_os_family }}.j2
        dest: /etc/named.conf
        group: named
        setype: named_conf_t
        mode: '0640'

    - name: Create a DOS-style text file from a template
      ansible.builtin.template:
        src: config.ini.j2
        dest: /share/windows/config.ini
        newline_sequence: '\\r\\n'

    - name: Copy a new sudoers file into place, after passing validation with visudo
      ansible.builtin.template:
        src: /mine/sudoers
        dest: /etc/sudoers
        validate: /usr/sbin/visudo -cf %s

    - name: Update sshd configuration safely, avoid locking yourself out
      ansible.builtin.template:
        src: etc/ssh/sshd_config.j2
        dest: /etc/ssh/sshd_config
        owner: root
        group: root
        mode: '0600'
        validate: /usr/sbin/sshd -t -f %s
        backup: yes
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.user
    set output_file "ansible.builtin.user.yml"

    set template_content "---
# Playbook: User module examples

- hosts: all
  gather_facts: no
  tasks:

    - name: Add the user 'johnd' with a specific uid and a primary group of 'admin'
      ansible.builtin.user:
        name: johnd
        comment: John Doe
        uid: 1040
        group: admin

    - name: Create a user 'johnd' with a home directory
      ansible.builtin.user:
        name: johnd
        create_home: yes

    - name: Add the user 'james' with a bash shell, appending the group 'admins' and 'developers'
      ansible.builtin.user:
        name: james
        shell: /bin/bash
        groups: admins,developers
        append: yes

    - name: Remove the user 'johnd'
      ansible.builtin.user:
        name: johnd
        state: absent
        remove: yes

    - name: Create a 2048-bit SSH key for user jsmith in ~jsmith/.ssh/id_rsa
      ansible.builtin.user:
        name: jsmith
        generate_ssh_key: yes
        ssh_key_bits: 2048
        ssh_key_file: .ssh/id_rsa

    - name: Add a consultant whose account you want to expire
      ansible.builtin.user:
        name: james18
        shell: /bin/zsh
        groups: developers
        expires: 1422403387

    - name: Starting at Ansible 2.6, modify user, remove expiry time
      ansible.builtin.user:
        name: james18
        expires: -1

    - name: Set maximum expiration date for password
      ansible.builtin.user:
        name: ram19
        password_expire_max: 10

    - name: Set minimum expiration date for password
      ansible.builtin.user:
        name: pushkar15
        password_expire_min: 5

    - name: Set number of warning days for password expiration
      ansible.builtin.user:
        name: jane157
        password_expire_warn: 30

    - name: Set number of days after password expires until account is disabled
      ansible.builtin.user:
        name: jimholden2016
        password_expire_account_disable: 15
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.validate_argument_spec
    set output_file "ansible.builtin.validate_argument_spec.yml"

    set template_content "---
# Playbook: validate_argument_spec examples

- hosts: all
  gather_facts: no
  tasks:

    - name: Verify vars needed for this task file are present when included
      ansible.builtin.validate_argument_spec:
        argument_spec: '{{ required_data }}'
      vars:
        required_data:
          stuff:
            description: stuff
            type: str
            choices: ['who', 'knows', 'what']
            default: what
          but:
            description: i guess we need one
            type: str
            required: true

    - name: Verify vars needed for this task file are present when included, with spec from a spec file
      ansible.builtin.validate_argument_spec:
        argument_spec: \"{{ (lookup('ansible.builtin.file', 'myargspec.yml') | from_yaml )['specname']['options'] }}\"

    - name: Verify vars needed for next include and not from inside it, also with params i'll only define there
      block:
        - ansible.builtin.validate_argument_spec:
            argument_spec: \"{{ lookup('ansible.builtin.file', 'nakedoptions.yml') }}\"
            provided_arguments:
              but: \"that i can define on the include itself, like in its `vars:` keyword\"

        - name: The include itself
          vars:
            stuff: knows
            but: nobuts!
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.wait_for
    set output_file "ansible.builtin.wait_for.yml"

    set template_content "---
# Playbook: wait_for examples

- hosts: all
  gather_facts: no
  tasks:

    - name: Sleep for 300 seconds and continue with play
      ansible.builtin.wait_for:
        timeout: 300
      delegate_to: localhost

    - name: Wait for port 8000 to become open on the host, don't start checking for 10 seconds
      ansible.builtin.wait_for:
        port: 8000
        delay: 10

    - name: Waits for port 8000 of any IP to close active connections, don't start checking for 10 seconds
      ansible.builtin.wait_for:
        host: 0.0.0.0
        port: 8000
        delay: 10
        state: drained

    - name: Wait for port 8000 of any IP to close active connections, ignoring connections for specified hosts
      ansible.builtin.wait_for:
        host: 0.0.0.0
        port: 8000
        state: drained
        exclude_hosts: 10.2.1.2,10.2.1.3

    - name: Wait until the file /tmp/foo is present before continuing
      ansible.builtin.wait_for:
        path: /tmp/foo

    - name: Wait until the string \"completed\" is in the file /tmp/foo before continuing
      ansible.builtin.wait_for:
        path: /tmp/foo
        search_regex: completed

    - name: Wait until the string \"tomcat up\" is in syslog, use regex character set to avoid self match
      ansible.builtin.wait_for:
        path: /var/log/syslog
        search_regex: 'tomcat [u]p'

    - name: Wait until regex pattern matches in the file /tmp/foo and print the matched group
      ansible.builtin.wait_for:
        path: /tmp/foo
        search_regex: completed (?P<task>\\w+)
      register: waitfor

    - ansible.builtin.debug:
        msg: Completed {{ waitfor['match_groupdict']['task'] }}

    - name: Wait until the lock file is removed
      ansible.builtin.wait_for:
        path: /var/lock/file.lock
        state: absent

    - name: Wait until the process is finished and pid was destroyed
      ansible.builtin.wait_for:
        path: /proc/3466/status
        state: absent

    - name: Output customized message when failed
      ansible.builtin.wait_for:
        path: /tmp/foo
        state: present
        msg: Timeout to find file /tmp/foo

    - name: Wait 300 seconds for port 22 to become open and contain \"OpenSSH\"
      ansible.builtin.wait_for:
        port: 22
        host: '{{ (ansible_ssh_host|default(ansible_host))|default(inventory_hostname) }}'
        search_regex: OpenSSH
        delay: 10
        timeout: 300
      delegate_to: localhost

    - name: Wait 300 seconds for port 22 to become open and contain \"OpenSSH\" using config lookup
      ansible.builtin.wait_for:
        port: 22
        host: \"{{ lookup('config', 'host', plugin_name='ssh', plugin_type='connection') }}\"
        search_regex: OpenSSH
        delay: 10
        timeout: 300
      delegate_to: localhost
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.wait_for_connection
    set output_file "ansible.builtin.wait_for_connection.yml"

    set template_content "---
# Playbook: wait_for_connection examples

- hosts: all
  gather_facts: no
  tasks:

    - name: Wait 600 seconds for target connection to become reachable/usable
      ansible.builtin.wait_for_connection:

    - name: Wait 300 seconds, but only start checking after 60 seconds
      ansible.builtin.wait_for_connection:
        delay: 60
        timeout: 300

# Wake desktops, wait for them to become ready and continue playbook
- hosts: all
  gather_facts: no
  tasks:

    - name: Send magic Wake-On-Lan packet to turn on individual systems
      community.general.wakeonlan:
        mac: '{{ mac }}'
        broadcast: 192.168.0.255
      delegate_to: localhost

    - name: Wait for system to become reachable
      ansible.builtin.wait_for_connection:

    - name: Gather facts for first time
      ansible.builtin.setup:

# Build a new VM, wait for it to become ready and continue playbook
- hosts: all
  gather_facts: no
  tasks:

    - name: Clone new VM, if missing
      community.vmware.vmware_guest:
        hostname: '{{ vcenter_ipaddress }}'
        name: '{{ inventory_hostname_short }}'
        template: Windows 2012R2
        customization:
          hostname: '{{ vm_shortname }}'
          runonce:
            - cmd.exe /c winrm.cmd quickconfig -quiet -force
      delegate_to: localhost

    - name: Wait for system to become reachable over WinRM
      ansible.builtin.wait_for_connection:
        timeout: 900

    - name: Gather facts for first time
      ansible.builtin.setup:
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.yum_repository
    set output_file "ansible.builtin.yum_repository.yml"

    set template_content "---
# Playbook: yum_repository examples

- name: Add repository
  ansible.builtin.yum_repository:
    name: epel
    description: EPEL YUM repo
    baseurl: https://download.fedoraproject.org/pub/epel/$releasever/$basearch/

- name: Add multiple repositories into the same file (1/2)
  ansible.builtin.yum_repository:
    name: epel
    description: EPEL YUM repo
    file: external_repos
    baseurl: https://download.fedoraproject.org/pub/epel/$releasever/$basearch/
    gpgcheck: no

- name: Add multiple repositories into the same file (2/2)
  ansible.builtin.yum_repository:
    name: rpmforge
    description: RPMforge YUM repo
    file: external_repos
    baseurl: http://apt.sw.be/redhat/el7/en/$basearch/rpmforge
    mirrorlist: http://mirrorlist.repoforge.org/el7/mirrors-rpmforge
    enabled: no

# Handler showing how to clean yum metadata cache
- name: yum-clean-metadata
  ansible.builtin.command: yum clean metadata

# Example removing a repository and cleaning up metadata cache
- name: Remove repository (and clean up left-over metadata)
  ansible.builtin.yum_repository:
    name: epel
    state: absent
  notify: yum-clean-metadata

- name: Remove repository from a specific repo file
  ansible.builtin.yum_repository:
    name: epel
    file: external_repos
    state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sysvinit
    set output_file "ansible.builtin.sysvinit.yml"

    set template_content "---
# Playbook: sysvinit examples

- name: Make sure apache2 is started
  ansible.builtin.sysvinit:
    name: apache2
    state: started
    enabled: yes

- name: Sleep for 5 seconds between stop and start command of badly behaving service
  ansible.builtin.sysvinit:
    name: apache2
    state: restarted
    sleep: 5

- name: Make sure apache2 is started on runlevels 3 and 5
  ansible.builtin.sysvinit:
    name: apache2
    state: started
    enabled: yes
    runlevels:
      - 3
      - 5
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sudo
    set output_file "ansible.builtin.sudo.yml"

    set template_content "---
# Playbook: ansible.builtin.sudo examples

- name: Example playbook using ansible.builtin.sudo become plugin
  hosts: all
  gather_facts: no
  become: yes
  become_method: ansible.builtin.sudo
  become_user: root
  become_flags: \"-H -S -n\"
  vars:
    my_sudo_pass: \"my_secret_password\"
    my_target_dir: \"/tmp\"

  tasks:
    - name: Run a command as root
      ansible.builtin.command:
        cmd: whoami
      become_pass: \"{{ my_sudo_pass }}\"

    - name: Create a file in /tmp as root
      ansible.builtin.file:
        path: \"{{ my_target_dir }}/example_root_file\"
        state: touch
        owner: root
        group: root
        mode: '0644'

    - name: Run a command as another user (e.g., deploy)
      ansible.builtin.command:
        cmd: whoami
      become_user: deploy
      become_pass: \"{{ my_sudo_pass }}\"

    - name: Run command in a custom directory before sudo
      ansible.builtin.command:
        cmd: pwd
      sudo_chdir: /var/log
      become_pass: \"{{ my_sudo_pass }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.su
    set output_file "ansible.builtin.su.yml"

    set template_content "---
# Playbook: ansible.builtin.su examples

- name: Example playbook using ansible.builtin.su become plugin
  hosts: all
  gather_facts: no
  become: yes
  become_method: ansible.builtin.su      # Explicitly use the su become plugin
  become_user: root                       # User to escalate to
  become_flags: \"\"                      # Optional flags for su
  vars:
    my_su_pass: \"my_secret_password\"    # Example su password
    my_target_dir: \"/tmp\"

  tasks:
    - name: Run a command as root
      ansible.builtin.command:
        cmd: whoami
      become_pass: \"{{ my_su_pass }}\"

    - name: Create a file in /tmp as root
      ansible.builtin.file:
        path: \"{{ my_target_dir }}/example_root_file_su\"
        state: touch
        owner: root
        group: root
        mode: '0644'
      become_pass: \"{{ my_su_pass }}\"

    - name: Run a command as another user (e.g., deploy)
      ansible.builtin.command:
        cmd: whoami
      become_user: deploy
      become_pass: \"{{ my_su_pass }}\"

    - name: Run command with localized prompt detection
      ansible.builtin.command:
        cmd: pwd
      vars:
        ansible_su_prompt_l10n:
          - \"Password\"
      become_pass: \"{{ my_su_pass }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.dnf5
    set output_file "ansible.builtin.dnf5.yml"

    set template_content "---
# Playbook: dnf5 examples

- name: Install the latest version of Apache
  ansible.builtin.dnf5:
    name: httpd
    state: latest

- name: Install Apache >= 2.4
  ansible.builtin.dnf5:
    name: httpd >= 2.4
    state: present

- name: Install the latest version of Apache and MariaDB
  ansible.builtin.dnf5:
    name:
      - httpd
      - mariadb-server
    state: latest

- name: Remove the Apache package
  ansible.builtin.dnf5:
    name: httpd
    state: absent

- name: Install the latest version of Apache from the testing repo
  ansible.builtin.dnf5:
    name: httpd
    enablerepo: testing
    state: present

- name: Upgrade all packages
  ansible.builtin.dnf5:
    name: \"*\"
    state: latest

- name: Update the webserver, depending on which is installed on the system. Do not install the other one
  ansible.builtin.dnf5:
    name:
      - httpd
      - nginx
    state: latest
    update_only: yes

- name: Install the nginx rpm from a remote repo
  ansible.builtin.dnf5:
    name: 'http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm'
    state: present

- name: Install nginx rpm from a local file
  ansible.builtin.dnf5:
    name: /usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm
    state: present

- name: Install Package based upon the file it provides
  ansible.builtin.dnf5:
    name: /usr/bin/cowsay
    state: present

- name: Install the 'Development tools' package group
  ansible.builtin.dnf5:
    name: '@Development tools'
    state: present

- name: Autoremove unneeded packages installed as dependencies
  ansible.builtin.dnf5:
    autoremove: yes

- name: Uninstall httpd but keep its dependencies
  ansible.builtin.dnf5:
    name: httpd
    state: absent
    autoremove: no
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.runas
    set output_file "ansible.runas_example.yml"

    set template_content "---
- name: Example playbook using ansible.builtin.runas become plugin
  hosts: windows
  gather_facts: no
  connection: winrm
  become: yes
  become_method: ansible.builtin.runas
  become_user: \"SomeDomain\\\\targetuser\"
  vars:
    runas_password: \"{{ vault_runas_password | default('P@ssw0rd') }}\"
    my_remote_path: 'C:\\\\Temp'
    ps_script: |
      Write-Output \"Running as: \$env:USERNAME\"
      Get-ChildItem -Path C:\\\\Windows\\\\System32 -Filter *.dll | Select-Object -First 3

  tasks:
    - name: Run simple whoami (as the become_user)
      ansible.windows.win_command:
        cmd: whoami
      become_pass: \"{{ runas_password }}\"

    - name: Create a directory as the become_user
      ansible.windows.win_file:
        path: \"{{ my_remote_path }}\\\\runas_example\"
        state: directory
      become_pass: \"{{ runas_password }}\"

    - name: Run a small PowerShell script as the become_user (demonstrates multi-line)
      ansible.windows.win_shell:
        ps: \"{{ ps_script }}\"
      become_pass: \"{{ runas_password }}\"

    - name: Run a command with extra flags passed to runas (example)
      ansible.windows.win_command:
        cmd: whoami /all
      become_flags: \"some_flag=value\"
      become_pass: \"{{ runas_password }}\"

    - name: Show a warning about seclogon requirement (informational)
      ansible.builtin.debug:
        msg: \"Ensure Secondary Logon (seclogon) service is running on target Windows host for runas to work.\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.jsonfile
    set output_file "ansible.jsonfile_cache.yml"

    set template_content "---
- name: Example playbook using ansible.builtin.jsonfile cache plugin
  hosts: all
  gather_facts: yes
  vars:
    cache_path: \"/tmp/ansible_json_cache\"
    cache_prefix: \"myhost_\"
    cache_timeout: 3600

  tasks:
    - name: Debug gathered facts
      ansible.builtin.debug:
        msg:
          - \"Hostname: {{ ansible_hostname }}\"
          - \"OS: {{ ansible_os_family }}\"

    - name: Show cache location
      ansible.builtin.debug:
        msg: \"Facts are cached in: {{ cache_path }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.memory
    set output_file "ansible.memory_cache.yml"

    set template_content "---
- name: Example playbook using ansible.builtin.memory cache plugin
  hosts: all
  gather_facts: yes
  tasks:
    - name: Show hostname and OS family
      ansible.builtin.debug:
        msg:
          - \"Hostname: {{ ansible_hostname }}\"
          - \"OS: {{ ansible_os_family }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.tree
    set output_file "ansible.tree_callback.yml"

    set template_content "---
- name: Example playbook demonstrating ansible.builtin.tree callback
  hosts: all
  gather_facts: yes
  tasks:
    - name: Ping all hosts
      ansible.builtin.ping:

    - name: Create a test file on remote host
      ansible.builtin.file:
        path: \"/tmp/test_file_{{ inventory_hostname }}\"
        state: touch

    - name: Show hostname and OS family
      ansible.builtin.debug:
        msg:
          - \"Hostname: {{ ansible_hostname }}\"
          - \"OS: {{ ansible_os_family }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.local
    set output_file "ansible.local_connection.yml"

    set template_content "---
# Playbook: examples for ansible.builtin.local connection
# This playbook runs tasks on the controller (local machine) using the 'local' connection plugin.

- name: Run tasks on the Ansible controller using local connection
  hosts: localhost
  connection: ansible.builtin.local     # execute on controller
  gather_facts: yes
  vars:
    # Optional variables to demonstrate plugin-related options (can be set in inventory/ansible.cfg or as env vars)
    ansible_local_become_strip_preamble: true
    ansible_local_become_success_timeout: 10
    ansible_pipelining: false

  tasks:
    - name: Show which user runs the playbook on the controller
      ansible.builtin.command: whoami
      register: whoami_out

    - name: Print whoami output
      ansible.builtin.debug:
        msg:
          - \"Controller user: {{ whoami_out.stdout }}\"

    - name: Create a temp file on the controller
      ansible.builtin.tempfile:
        state: file
        prefix: local_demo_
      register: local_tmp

    - name: Show created temporary path
      ansible.builtin.debug:
        var: local_tmp.path

    - name: Write a small note to the temp file (controller)
      ansible.builtin.copy:
        content: \"This file was created by ansible.builtin.local connection on {{ ansible_date_time.iso8601 }}\\n\"
        dest: \"{{ local_tmp.path }}\"

    - name: Show the first line of the created file
      ansible.builtin.shell: head -n 1 {{ local_tmp.path }} 
      register: note_line

    - name: Debug note line
      ansible.builtin.debug:
        msg: \"Note: {{ note_line.stdout }}\"

    - name: Cleanup - remove the temporary file
      ansible.builtin.file:
        path: \"{{ local_tmp.path }}\"
        state: absent

# Example of running an escalated command on controller (will use controller's become mechanism)
# You can run the playbook with become if needed:
# ansible-playbook ansible.local_connection.yml --ask-become-pass
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.paramiko_ssh
    set output_file "ansible.paramiko_ssh_connection.yml"

    set template_content "---
# Playbook: examples using ansible.builtin.paramiko_ssh connection
# This playbook runs tasks via Paramiko SSH on remote hosts.

- name: Run tasks via Paramiko SSH
  hosts: all
  connection: ansible.builtin.paramiko_ssh
  gather_facts: yes
  vars:
    ansible_user: my_remote_user
    ansible_port: 22
    ansible_password: my_secret_password
    ansible_ssh_private_key_file: ~/.ssh/id_rsa
    ansible_paramiko_host_key_checking: true
    ansible_paramiko_banner_timeout: 30
    ansible_paramiko_pty: true
    ansible_paramiko_timeout: 15
    ansible_paramiko_host_key_auto_add: true
    ansible_paramiko_use_rsa_sha2_algorithms: true

  tasks:
    - name: Show hostname on remote host
      ansible.builtin.command:
        cmd: hostname
      register: host_out

    - name: Print remote hostname
      ansible.builtin.debug:
        msg: \"Remote host: {{ host_out.stdout }}\"

    - name: Run uname to get OS info
      ansible.builtin.command:
        cmd: uname -a
      register: os_out

    - name: Print OS info
      ansible.builtin.debug:
        msg: \"OS Info: {{ os_out.stdout }}\"

    - name: Create a temporary file on the remote host
      ansible.builtin.tempfile:
        state: file
        prefix: paramiko_demo_
      register: tmp_file

    - name: Display created temp file path
      ansible.builtin.debug:
        var: tmp_file.path

    - name: Clean up temp file
      ansible.builtin.file:
        path: \"{{ tmp_file.path }}\"
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible_ssh_connection
    set output_file "ansible.ssh_connection.yml"

    set template_content "---
# Playbook: examples using ansible.builtin.ssh connection
# This playbook runs tasks via the SSH client binary on remote hosts.

- name: Run tasks via SSH client
  hosts: all
  connection: ansible.builtin.ssh
  gather_facts: yes
  vars:
    ansible_user: my_remote_user
    ansible_port: 22
    ansible_ssh_private_key_file: ~/.ssh/id_rsa
    ansible_ssh_pass: my_secret_password
    ansible_ssh_timeout: 15
    ansible_ssh_use_tty: true
    ansible_ssh_transfer_method: smart
    ansible_control_path_dir: ~/.ansible/cp
    ansible_ssh_args: '-C -o ControlMaster=auto -o ControlPersist=60s'
    ansible_ssh_common_args: ''
    ansible_scp_executable: scp
    ansible_scp_extra_args: ''
    ansible_sftp_executable: sftp
    ansible_sftp_extra_args: ''
    ansible_host_key_checking: true
    ansible_ssh_retries: 2
    ansible_pipelining: false
    ansible_ssh_verbosity: 1

  tasks:
    - name: Show hostname on remote host
      ansible.builtin.command:
        cmd: hostname
      register: host_out

    - name: Print remote hostname
      ansible.builtin.debug:
        msg: \"Remote host: {{ host_out.stdout }}\"

    - name: Run uname to get OS info
      ansible.builtin.command:
        cmd: uname -a
      register: os_out

    - name: Print OS info
      ansible.builtin.debug:
        msg: \"OS Info: {{ os_out.stdout }}\"

    - name: Create a temporary file on the remote host
      ansible.builtin.tempfile:
        state: file
        prefix: ssh_demo_
      register: tmp_file

    - name: Display created temp file path
      ansible.builtin.debug:
        var: tmp_file.path

    - name: Clean up temp file
      ansible.builtin.file:
        path: \"{{ tmp_file.path }}\"
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.oneline
    set output_file "ansible.oneline_callback.yml"

    set template_content "---
# Playbook: examples using ansible.builtin.oneline callback
# This playbook demonstrates compact single-line output for Ansible tasks.

- name: Demo playbook with oneline callback
  hosts: all
  gather_facts: yes
  vars:
    ansible_stdout_callback: ansible.builtin.oneline

  tasks:
    - name: Show hostname of remote host
      ansible.builtin.command:
        cmd: hostname
      register: host_out

    - name: Display remote hostname
      ansible.builtin.debug:
        msg: \"Remote host: {{ host_out.stdout }}\"

    - name: Run uname to get OS info
      ansible.builtin.command:
        cmd: uname -a
      register: os_out

    - name: Display OS info
      ansible.builtin.debug:
        msg: \"OS Info: {{ os_out.stdout }}\"

    - name: Create a temporary file
      ansible.builtin.tempfile:
        state: file
        prefix: oneline_demo_
      register: tmp_file

    - name: Show created temp file path
      ansible.builtin.debug:
        var: tmp_file.path

    - name: Remove temp file
      ansible.builtin.file:
        path: \"{{ tmp_file.path }}\"
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.junit
    set output_file "ansible.junit_callback.yml"

    set template_content "---
# Playbook: examples using ansible.builtin.junit callback
# This playbook demonstrates writing playbook output to a JUnit XML file.

- name: Demo playbook with junit callback
  hosts: all
  gather_facts: yes
  vars:
    ansible_stdout_callback: default        # stdout callback (any)
    ansible_callback_whitelist:
      - ansible.builtin.junit               # enable junit callback

  tasks:
    - name: Show hostname of remote host
      ansible.builtin.command:
        cmd: hostname
      register: host_out

    - name: Display remote hostname
      ansible.builtin.debug:
        msg: \"Remote host: {{ host_out.stdout }}\"

    - name: Run uname to get OS info
      ansible.builtin.command:
        cmd: uname -a
      register: os_out

    - name: Display OS info
      ansible.builtin.debug:
        msg: \"OS Info: {{ os_out.stdout }}\"

    - name: Create a temporary file
      ansible.builtin.tempfile:
        state: file
        prefix: junit_demo_
      register: tmp_file

    - name: Show created temp file path
      ansible.builtin.debug:
        var: tmp_file.path

    - name: Remove temp file
      ansible.builtin.file:
        path: \"{{ tmp_file.path }}\"
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.default
    set output_file "ansible.default_callback.yml"

    set template_content "---
# Playbook: examples using ansible.builtin.default callback
# This playbook demonstrates the default stdout callback output.

- name: Demo playbook with default callback
  hosts: all
  gather_facts: yes
  vars:
    ansible_stdout_callback: default        # use default callback
    ansible_callback_whitelist:             # additional callbacks can be enabled
      - ansible.builtin.default

  tasks:
    - name: Show hostname of remote host
      ansible.builtin.command:
        cmd: hostname
      register: host_out

    - name: Display remote hostname
      ansible.builtin.debug:
        msg: \"Remote host: {{ host_out.stdout }}\"

    - name: Check OS type
      ansible.builtin.setup:
        gather_subset:
          - '!all'
          - 'min'
      register: system_info

    - name: Display OS family
      ansible.builtin.debug:
        msg: \"OS Family: {{ system_info.ansible_facts.ansible_os_family }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sh
    set output_file "ansible.sh_shell.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.sh (POSIX shell)
# Demonstrates executing shell commands on Unix systems

- name: Demo playbook with ansible.builtin.sh shell
  hosts: all
  gather_facts: yes
  tasks:
    - name: Show current user
      ansible.builtin.shell:
        cmd: whoami
      register: user_out

    - name: Display the current user
      ansible.builtin.debug:
        msg: \"Current user: {{ user_out.stdout }}\"

    - name: List /tmp directory
      ansible.builtin.shell:
        cmd: ls -l /tmp
      register: tmp_list

    - name: Display /tmp contents
      ansible.builtin.debug:
        msg: \"Contents of /tmp:\\n{{ tmp_list.stdout }}\"

    - name: Print OS type
      ansible.builtin.shell:
        cmd: uname -a
      register: os_info

    - name: Display OS information
      ansible.builtin.debug:
        msg: \"OS info: {{ os_info.stdout }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.abs
    set output_file "ansible.abs_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.abs filter
# Demonstrates calculating absolute values in Ansible

- name: Demo playbook with ansible.builtin.abs filter
  hosts: all
  gather_facts: no
  vars:
    negative_number: -42
    positive_number: 17
  tasks:
    - name: Show absolute value of a negative number
      ansible.builtin.debug:
        msg: \"Absolute value of {{ negative_number }} is {{ negative_number | ansible.builtin.abs }}\"

    - name: Show absolute value of a positive number
      ansible.builtin.debug:
        msg: \"Absolute value of {{ positive_number }} is {{ positive_number | ansible.builtin.abs }}\"

    - name: Use abs filter in a calculation
      ansible.builtin.debug:
        msg: \"Difference between numbers using abs: {{ (negative_number - positive_number) | ansible.builtin.abs }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.attr
    set output_file "ansible.attr_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.attr filter
# Demonstrates accessing attributes of objects in Ansible

- name: Demo playbook with ansible.builtin.attr filter
  hosts: all
  gather_facts: no
  vars:
    my_dict:
      name: Alice
      age: 30
      location: Wonderland
  tasks:
    - name: Get the 'name' attribute from the dictionary
      ansible.builtin.debug:
        msg: \"Name is {{ my_dict | ansible.builtin.attr('name') }}\"

    - name: Get the 'age' attribute from the dictionary
      ansible.builtin.debug:
        msg: \"Age is {{ my_dict | ansible.builtin.attr('age') }}\"

    - name: Attempt to get a missing attribute with default
      ansible.builtin.debug:
        msg: \"Nickname is {{ my_dict | ansible.builtin.attr('nickname', 'unknown') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.b64decode
    set output_file "ansible.b64decode_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.b64decode filter
# Demonstrates decoding Base64 strings

- name: Demo playbook with ansible.builtin.b64decode filter
  hosts: all
  gather_facts: no
  vars:
    encoded_str: 'bG9sYQ=='
    encoded_utf16: 'QQBuAHMAaQBiAGwAZQAgAC0AIABPMIkwaDB/MAoA'
    encoded_urlsafe: 'aHR0cHM6Ly93d3cucHl0aG9uLm9yZy9leGFtcGxlLTE='
  tasks:
    - name: Decode Base64 string
      ansible.builtin.debug:
        msg: \"Decoded string: {{ encoded_str | ansible.builtin.b64decode }}\"

    - name: Decode Base64 string with UTF-16-LE encoding
      ansible.builtin.debug:
        msg: \"Decoded UTF-16 string: {{ encoded_utf16 | ansible.builtin.b64decode(encoding='utf-16-le') }}\"

    - name: Decode URL-safe Base64 string
      ansible.builtin.debug:
        msg: \"Decoded URL-safe string: {{ encoded_urlsafe | ansible.builtin.b64decode(urlsafe=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.b64encode
    set output_file "ansible.b64encode_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.b64encode filter
# Demonstrates encoding strings to Base64

- name: Demo playbook with ansible.builtin.b64encode filter
  hosts: all
  gather_facts: no
  vars:
    plain_str: 'lola'
    utf16_str: 'Ansible - くらとみ\n'
    url_str: 'https://www.python.org/example-1'
  tasks:
    - name: Encode string to Base64
      ansible.builtin.debug:
        msg: \"Encoded string: {{ plain_str | ansible.builtin.b64encode }}\"

    - name: Encode string to Base64 with UTF-16-LE encoding
      ansible.builtin.debug:
        msg: \"Encoded UTF-16 string: {{ utf16_str | ansible.builtin.b64encode(encoding='utf-16-le') }}\"

    - name: Encode string to URL-safe Base64
      ansible.builtin.debug:
        msg: \"Encoded URL-safe string: {{ url_str | ansible.builtin.b64encode(urlsafe=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.basename
    set output_file "ansible.basename_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.basename filter
# Demonstrates extracting the base name from a path

- name: Demo playbook with ansible.builtin.basename filter
  hosts: all
  gather_facts: no
  vars:
    mypath1: '/etc/asdf/foo.txt'
    mypath2: '/var/log/messages'
    mypath3: '/home/user/'
  tasks:
    - name: Get base name from first path
      ansible.builtin.debug:
        msg: \"Base name: {{ mypath1 | ansible.builtin.basename }}\"

    - name: Get base name from second path
      ansible.builtin.debug:
        msg: \"Base name: {{ mypath2 | ansible.builtin.basename }}\"

    - name: Get base name from directory path
      ansible.builtin.debug:
        msg: \"Base name: {{ mypath3 | ansible.builtin.basename }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.bool
    set output_file "ansible.bool_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.bool filter
# Demonstrates coercing values to boolean

- name: Demo playbook with ansible.builtin.bool filter
  hosts: all
  gather_facts: no
  vars:
    val1: 'yes'
    val2: 'No'
    val3: 1
    val4: 0
    val5: 'random_string'
  tasks:
    - name: Convert 'yes' to boolean
      ansible.builtin.debug:
        msg: \"val1 | bool = {{ val1 | ansible.builtin.bool }}\"

    - name: Convert 'No' to boolean
      ansible.builtin.debug:
        msg: \"val2 | bool = {{ val2 | ansible.builtin.bool }}\"

    - name: Convert 1 to boolean
      ansible.builtin.debug:
        msg: \"val3 | bool = {{ val3 | ansible.builtin.bool }}\"

    - name: Convert 0 to boolean
      ansible.builtin.debug:
        msg: \"val4 | bool = {{ val4 | ansible.builtin.bool }}\"

    - name: Convert unknown string to boolean
      ansible.builtin.debug:
        msg: \"val5 | bool = {{ val5 | ansible.builtin.bool }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.batch
    set output_file "ansible.batch_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.batch filter
# Demonstrates batching items in a list

- name: Demo playbook with ansible.builtin.batch filter
  hosts: all
  gather_facts: no
  vars:
    mylist: [1, 2, 3, 4, 5, 6, 7]
    batch_size: 3
  tasks:
    - name: Show original list
      ansible.builtin.debug:
        msg: \"Original list: {{ mylist }}\"

    - name: Batch the list into chunks of 3
      ansible.builtin.debug:
        msg: \"Batched list: {{ mylist | ansible.builtin.batch(batch_size) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.capitalize
    set output_file "ansible.capitalize_filter.yml"

    set template_content "---
# Playbook: Example using ansible.builtin.capitalize filter
# Demonstrates capitalizing a string

- name: Demo playbook with ansible.builtin.capitalize filter
  hosts: all
  gather_facts: no
  vars:
    mystring: \"hello world\"
  tasks:
    - name: Show original string
      ansible.builtin.debug:
        msg: \"Original string: {{ mystring }}\"

    - name: Capitalize the string
      ansible.builtin.debug:
        msg: \"Capitalized string: {{ mystring | ansible.builtin.capitalize }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.config
    set output_file "ansible.builtin.config.yml"

    set template_content "---
# Playbook: ansible.builtin.config examples

- name: Show configured default become user
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.config', 'DEFAULT_BECOME_USER') }}\"

- name: Print out role paths
  ansible.builtin.debug:
    msg: \"These are the configured role paths: {{ lookup('ansible.builtin.config', 'DEFAULT_ROLES_PATH') }}\"

- name: Find retry files, skip if missing that key
  ansible.builtin.find:
    paths: \"{{ lookup('ansible.builtin.config', 'RETRY_FILES_SAVE_PATH') | default(playbook_dir, True) }}\"
    patterns: \"*.retry\"

- name: See the colors
  ansible.builtin.debug:
    msg: \"{{ item }}\"
  loop: \"{{ lookup('ansible.builtin.config', 'COLOR_OK', 'COLOR_CHANGED', 'COLOR_SKIP', wantlist=True) }}\"

- name: Skip if bad value in var
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.config', config_in_var, on_missing='skip') }}\"
  vars:
    config_in_var: UNKNOWN

- name: Show remote user and port for ssh connection
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.config', 'remote_user', 'port', plugin_type='connection', plugin_name='ssh', on_missing='skip') }}\"

- name: Show remote_tmp setting for shell (sh) plugin
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.config', 'remote_tmp', plugin_type='shell', plugin_name='sh') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.csvfile
    set output_file "ansible.builtin.csvfile.yml"

    set template_content "---
# Playbook: ansible.builtin.csvfile examples

- name: Match 'Li' on the first column, return the second column (0 based index)
  ansible.builtin.debug:
    msg: \"The atomic number of Lithium is {{ lookup('ansible.builtin.csvfile', 'Li file=elements.csv delimiter=,') }}\"

- name: Match 'Li' on the first column, but return the 3rd column (columns start counting after the match)
  ansible.builtin.debug:
    msg: \"The atomic mass of Lithium is {{ lookup('ansible.builtin.csvfile', 'Li file=elements.csv delimiter=, col=2') }}\"

- name: Define values from CSV file
  ansible.builtin.set_fact:
    '{{ columns[item|int] }}': \"{{ csvline }}\"
  vars:
    csvline: \"{{ lookup('csvfile', bgp_neighbor_ip, file='bgp_neighbors.csv', delimiter=',', col=item) }}\"
    columns: ['loop_ip', 'int_ip', 'int_mask', 'int_name', 'local_as', 'neighbour_as', 'neight_int_ip']
    bgp_neighbor_ip: '127.0.0.1'
  loop: '{{ range(columns|length|int) }}'
  delegate_to: localhost
  delegate_facts: true

- name: Specify the column (by keycol) in which the string should be searched
  ansible.builtin.assert:
    that:
      - lookup('ansible.builtin.csvfile', 'Jane', file='people.csv', delimiter=',', col=0, keycol=1) == 'Smith'

- name: Lookup multiple keynames in the first column (index 0), returning the values from the second column (index 1)
  ansible.builtin.debug:
    msg: \"{{ lookup('csvfile', 'test1', 'test2', file='debug.csv', delimiter=' ') }}\"

- name: Lookup multiple keynames using old style syntax
  ansible.builtin.debug:
    msg: \"{{ lookup('csvfile', term1, term2) }}\"
  vars:
    term1: \"test1 file=debug.csv delimiter=' '\"
    term2: \"test2 file=debug.csv delimiter=' '\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.dict
    set output_file "ansible.builtin.dict.yml"

    set template_content "---
# Playbook: ansible.builtin.dict examples

vars:
  users:
    alice:
      name: Alice Appleworth
      telephone: 123-456-7890
    bob:
      name: Bob Bananarama
      telephone: 987-654-3210

tasks:
  # with predefined vars
  - name: Print phone records
    ansible.builtin.debug:
      msg: \"User {{ item.key }} is {{ item.value.name }} ({{ item.value.telephone }})\"
    loop: \"{{ lookup('ansible.builtin.dict', users) }}\"

  # with inline dictionary
  - name: show dictionary
    ansible.builtin.debug:
      msg: \"{{item.key}}: {{item.value}}\"
    with_dict: {a: 1, b: 2, c: 3}

  # Items from loop can be used in when: statements
  - name: set_fact when alice in key
    ansible.builtin.set_fact:
      alice_exists: true
    loop: \"{{ lookup('ansible.builtin.dict', users) }}\"
    when: \"'alice' in item.key\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.env
    set output_file "ansible.builtin.env.yml"

    set template_content "---
# Playbook: ansible.builtin.env examples

tasks:
  - name: Basic usage
    ansible.builtin.debug:
      msg: \"'{{ lookup('ansible.builtin.env', 'HOME') }}' is the HOME environment variable.\"

  - name: Before 2.13, how to set default value if the variable is not defined
    ansible.builtin.debug:
      msg: \"Hello {{ lookup('ansible.builtin.env', 'UNDEFINED_VARIABLE') | default('World', True) }}\"

  - name: Example how to set default value if the variable is not defined
    ansible.builtin.debug:
      msg: \"Hello {{ lookup('ansible.builtin.env', 'UNDEFINED_VARIABLE', default='World') }}\"

  - name: Fail if the variable is not defined by setting default value to 'undef()'
    ansible.builtin.debug:
      msg: \"Hello {{ lookup('ansible.builtin.env', 'UNDEFINED_VARIABLE', default=undef()) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.file
    set output_file "ansible.builtin.file.yml"

    set template_content "---
# Playbook: ansible.builtin.file lookup examples

tasks:
  - name: Read a single file
    ansible.builtin.debug:
      msg: \"the value of foo.txt is {{ lookup('ansible.builtin.file', '/etc/foo.txt') }}\"

  - name: Display multiple file contents
    ansible.builtin.debug:
      var: item
    with_file:
      - \"/path/to/foo.txt\"
      - \"bar.txt\"  # will be looked in files/ dir relative to play or in role
      - \"/path/to/biz.txt\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.fileglob
    set output_file "ansible.builtin.file.yml"

    set template_content "---
# Playbook: ansible.builtin.file and fileglob examples

tasks:
  - name: Read a single file
    ansible.builtin.debug:
      msg: \"the value of foo.txt is {{ lookup('ansible.builtin.file', '/etc/foo.txt') }}\"

  - name: Display multiple file contents
    ansible.builtin.debug:
      var: item
    with_file:
      - \"/path/to/foo.txt\"
      - \"bar.txt\"  # will be looked in files/ dir relative to play or in role
      - \"/path/to/biz.txt\"

  - name: Display paths of all .txt files in dir
    ansible.builtin.debug:
      msg: \"{{ lookup('ansible.builtin.fileglob', '/my/path/*.txt') }}\"

  - name: Copy each file over that matches the given pattern
    ansible.builtin.copy:
      src: \"{{ item }}\"
      dest: \"/etc/fooapp/\"
      owner: \"root\"
      mode: 0600
    with_fileglob:
      - \"/playbooks/files/fooapp/*\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.first_found
    set output_file "ansible.builtin.first_found.yml"

    set template_content "---
# Playbook: ansible.builtin.first_found lookup examples

tasks:
  - name: Set _found_file to the first existing file, raising an error if a file is not found
    ansible.builtin.set_fact:
      _found_file: \"{{ lookup('ansible.builtin.first_found', findme) }}\"
    vars:
      findme:
        - /path/to/foo.txt
        - bar.txt  # will be looked in files/ dir relative to role and/or play
        - /path/to/biz.txt

  - name: Set _found_file to the first existing file, or an empty list if no files found
    ansible.builtin.set_fact:
      _found_file: \"{{ lookup('ansible.builtin.first_found', files, paths=['/extra/path'], skip=True) }}\"
    vars:
      files:
        - /path/to/foo.txt
        - /path/to/bar.txt

  - name: Include tasks only if one of the files exist, otherwise skip the task
    ansible.builtin.include_tasks:
      file: \"{{ item }}\"
    with_first_found:
      - files:
        - path/tasks.yaml
        - path/other_tasks.yaml
        skip: True

  - name: Include tasks only if one of the files exists, otherwise skip
    ansible.builtin.include_tasks: '{{ tasks_file }}'
    when: tasks_file != \"\"
    vars:
      tasks_file: \"{{ lookup('ansible.builtin.first_found', files=['tasks.yaml', 'other_tasks.yaml'], errors='ignore') }}\"

  - name: Copy first existing file found to /some/file
    ansible.builtin.copy:
      src: \"{{ lookup('ansible.builtin.first_found', findme) }}\"
      dest: /some/file
    vars:
      findme:
        - foo
        - \"{{ inventory_hostname }}\"
        - bar

  - name: Same copy but specific paths
    ansible.builtin.copy:
      src: \"{{ lookup('ansible.builtin.first_found', params) }}\"
      dest: /some/file
    vars:
      params:
        files:
          - foo
          - \"{{ inventory_hostname }}\"
          - bar
        paths:
          - /tmp/production
          - /tmp/staging

  - name: INTERFACES | Create Ansible header for /etc/network/interfaces
    ansible.builtin.template:
      src: \"{{ lookup('ansible.builtin.first_found', findme) }}\"
      dest: \"/etc/foo.conf\"
    vars:
      findme:
        - \"{{ ansible_virtualization_type }}_foo.conf\"
        - \"default_foo.conf\"

  - name: Read vars from first file found, use 'vars/' relative subdir
    ansible.builtin.include_vars: \"{{ lookup('ansible.builtin.first_found', params) }}\"
    vars:
      params:
        files:
          - '{{ ansible_distribution }}.yml'
          - '{{ ansible_os_family }}.yml'
          - default.yml
        paths:
          - 'vars'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.indexed_items
    set output_file "ansible_indexed_loop_demo.yml"

    set template_content "---
# Playbook: Indexed loop demo

vars:
  some_list:
    - apple
    - banana
    - cherry

tasks:
  - name: Indexed loop demo
    ansible.builtin.debug:
      msg: \"At array position {{ item.0 }} there is a value {{ item.1 }}\"
    with_indexed_items:
      - \"{{ some_list }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.ini
    set output_file "ansible.builtin.ini.yml"

    set template_content "---
# Playbook: ansible.builtin.ini lookup examples

tasks:
  - name: User in integration
    ansible.builtin.debug:
      msg: \"User in integration is {{ lookup('ansible.builtin.ini', 'user', section='integration', file='users.ini') }}\"

  - name: User in production
    ansible.builtin.debug:
      msg: \"User in production  is {{ lookup('ansible.builtin.ini', 'user', section='production', file='users.ini') }}\"

  - name: Read user.name from properties file
    ansible.builtin.debug:
      msg: \"user.name is {{ lookup('ansible.builtin.ini', 'user.name', type='properties', file='user.properties') }}\"

  - name: Loop through all keys matching regex
    ansible.builtin.debug:
      msg: \"{{ item }}\"
    loop: \"{{ q('ansible.builtin.ini', '.*', section='section1', file='test.ini', re=True) }}\"

  - name: Read an ini file with allow_no_value
    ansible.builtin.debug:
      msg: \"{{ lookup('ansible.builtin.ini', 'user', file='mysql.ini', section='mysqld', allow_no_value=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.inventory_hostnames
    set output_file "ansible.builtin.inventory_hostnames.yml"

    set template_content "---
# Playbook: ansible.builtin.inventory_hostnames lookup examples

tasks:
  - name: Show all hosts matching a pattern (all but the group 'www')
    ansible.builtin.debug:
      msg: \"{{ item }}\"
    with_inventory_hostnames:
      - all:!www
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.items
    set output_file "ansible.builtin.with_items.yml"

    set template_content "---
# Playbook: ansible.builtin.with_items examples

tasks:
  - name: \"loop through list\"
    ansible.builtin.debug:
      msg: \"An item: {{ item }}\"
    with_items:
      - 1
      - 2
      - 3

  - name: add several users
    ansible.builtin.user:
      name: \"{{ item }}\"
      groups: \"wheel\"
      state: present
    with_items:
      - testuser1
      - testuser2

  - name: \"loop through list from a variable\"
    ansible.builtin.debug:
      msg: \"An item: {{ item }}\"
    with_items: \"{{ somelist }}\"

  - name: more complex items to add several users
    ansible.builtin.user:
      name: \"{{ item.name }}\"
      uid: \"{{ item.uid }}\"
      groups: \"{{ item.groups }}\"
      state: present
    with_items:
      - { name: testuser1, uid: 1002, groups: \"wheel, staff\" }
      - { name: testuser2, uid: 1003, groups: staff }
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.lines
    set output_file "ansible.builtin.with_lines.yml"

    set template_content "---
# Playbook: ansible.builtin.with_lines examples

tasks:
  - name: We could read the file directly, but this shows output from command
    ansible.builtin.debug:
      msg: \"{{ item }} is an output line from running cat on /etc/motd\"
    with_lines: cat /etc/motd

  - name: Always use quote filter to make sure your variables are safe to use with shell
    ansible.builtin.debug:
      msg: \"{{ item }} is an output line from running given command\"
    with_lines: \"cat {{ file_name | quote }}\"

  - name: More useful example of looping over a command result
    ansible.builtin.shell: \"/usr/bin/frobnicate {{ item }}\"
    with_lines:
      - \"/usr/bin/frobnications_per_host --param {{ inventory_hostname }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.list
    set output_file "ansible.builtin.with_list.yml"

    set template_content "---
# Playbook: ansible.builtin.with_list examples

tasks:
  - name: Unlike with_items, you will get 3 items from this loop, the 2nd one being a list
    ansible.builtin.debug:
      var: item
    with_list:
      - 1
      - [2, 3]
      - 4
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.nested
    set output_file "ansible.builtin.with_nested.yml"

    set template_content "---
# Playbook: ansible.builtin.with_nested examples

tasks:
  - name: Give users access to multiple databases
    community.mysql.mysql_user:
      name: \"{{ item[0] }}\"
      priv: \"{{ item[1] }}.*:ALL\"
      append_privs: yes
      password: \"foo\"
    with_nested:
      - [ 'alice', 'bob' ]
      - [ 'clientdb', 'employeedb', 'providerdb' ]

  # As with 'with_items', you can use previously defined variables
  - name: Use 'users' variable containing the list of employees
    community.mysql.mysql_user:
      name: \"{{ item[0] }}\"
      priv: \"{{ item[1] }}.*:ALL\"
      append_privs: yes
      password: \"foo\"
    with_nested:
      - \"{{ users }}\"
      - [ 'clientdb', 'employeedb', 'providerdb' ]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.password
    set output_file "ansible.builtin.password.yml"

    set template_content "---
# Playbook: ansible.builtin.password lookup examples

tasks:
  - name: Create a MySQL user with a random password
    community.mysql.mysql_user:
      name: \"{{ client }}\"
      password: \"{{ lookup('ansible.builtin.password', 'credentials/' + client + '/' + tier + '/' + role + '/mysqlpassword', length=15) }}\"
      priv: \"{{ client }}_{{ tier }}_{{ role }}.*:ALL\"

  - name: Create a MySQL user with a random password using only ASCII letters
    community.mysql.mysql_user:
      name: \"{{ client }}\"
      password: \"{{ lookup('ansible.builtin.password', '/tmp/passwordfile', chars=['ascii_letters']) }}\"
      priv: \"{{ client }}_{{ tier }}_{{ role }}.*:ALL\"

  - name: Create a MySQL user with an 8-character random password using only digits
    community.mysql.mysql_user:
      name: \"{{ client }}\"
      password: \"{{ lookup('ansible.builtin.password', '/tmp/passwordfile', length=8, chars=['digits']) }}\"
      priv: \"{{ client }}_{{ tier }}_{{ role }}.*:ALL\"

  - name: Create a MySQL user with a random password using multiple char sets
    community.mysql.mysql_user:
      name: \"{{ client }}\"
      password: \"{{ lookup('ansible.builtin.password', '/tmp/passwordfile', chars=['ascii_letters', 'digits', 'punctuation']) }}\"
      priv: \"{{ client }}_{{ tier }}_{{ role }}.*:ALL\"

  - name: Create lowercase 8-character name for Kubernetes pod
    ansible.builtin.set_fact:
      random_pod_name: \"web-{{ lookup('ansible.builtin.password', '/dev/null', chars=['ascii_lowercase', 'digits'], length=8) }}\"

  - name: Create random but idempotent password
    ansible.builtin.set_fact:
      password: \"{{ lookup('ansible.builtin.password', '/dev/null', seed=inventory_hostname) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.pipe
    set output_file "ansible.builtin.pipe.yml"

    set template_content "---
# Playbook: ansible.builtin.pipe lookup examples

tasks:
  - name: Raw result of running date command
    ansible.builtin.debug:
      msg: \"{{ lookup('ansible.builtin.pipe', 'date') }}\"

  - name: Always use quote filter to make sure your variables are safe to use with shell
    ansible.builtin.debug:
      msg: \"{{ lookup('ansible.builtin.pipe', 'getent passwd ' + myuser | quote) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.random_choice
    set output_file "ansible.builtin.with_random_choice.yml"

    set template_content "---
# Playbook: ansible.builtin.with_random_choice examples

tasks:
  - name: Magic 8 ball for MUDs
    ansible.builtin.debug:
      msg: \"{{ item }}\"
    with_random_choice:
      - \"go through the door\"
      - \"drink from the goblet\"
      - \"press the red button\"
      - \"do nothing\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sequence
    set output_file "ansible.builtin.with_sequence.yml"

    set template_content "---
# Playbook: ansible.builtin.with_sequence examples

tasks:
  - name: Create some test users
    ansible.builtin.user:
      name: \"{{ item }}\"
      state: present
      groups: \"evens\"
    with_sequence: start=0 end=32 format=testuser%02x

  - name: Create a series of directories with even numbers for some reason
    ansible.builtin.file:
      dest: \"/var/stuff/{{ item }}\"
      state: directory
    with_sequence: start=4 end=16 stride=2

  - name: A simpler way to use the sequence plugin create 4 groups
    ansible.builtin.group:
      name: \"group{{ item }}\"
      state: present
    with_sequence: count=4

  - name: The final countdown
    ansible.builtin.debug:
      msg: \"{{ item }} seconds to detonation\"
    with_sequence: start=10 end=0 stride=-1

  - name: Use of variable
    ansible.builtin.debug:
      msg: \"{{ item }}\"
    with_sequence: start=1 end={{ end_at }}
    vars:
      end_at: 10
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.subelements
    set output_file "ansible.builtin.with_subelements.yml"

    set template_content "---
# Playbook: ansible.builtin.with_subelements examples
- name: Show var structure as it is needed for example to make sense
  hosts: all
  vars:
    users:
      - name: alice
        authorized:
          - /tmp/alice/onekey.pub
          - /tmp/alice/twokey.pub
        mysql:
          password: mysql-password
          hosts:
            - \"%\"
            - \"127.0.0.1\"
            - \"::1\"
            - \"localhost\"
          privs:
            - \"*.*:SELECT\"
            - \"DB1.*:ALL\"
        groups:
          - wheel
      - name: bob
        authorized:
          - /tmp/bob/id_rsa.pub
        mysql:
          password: other-mysql-password
          hosts:
            - \"db1\"
          privs:
            - \"*.*:SELECT\"
            - \"DB2.*:ALL\"
  tasks:
    - name: Set authorized ssh key, extracting just that data from 'users'
      ansible.posix.authorized_key:
        user: \"{{ item.0.name }}\"
        key: \"{{ lookup('file', item.1) }}\"
      with_subelements:
        - \"{{ users }}\"
        - authorized

    - name: Setup MySQL users, given the mysql hosts and privs subkey lists
      community.mysql.mysql_user:
        name: \"{{ item.0.name }}\"
        password: \"{{ item.0.mysql.password }}\"
        host: \"{{ item.1 }}\"
        priv: \"{{ item.0.mysql.privs | join('/') }}\"
      with_subelements:
        - \"{{ users }}\"
        - mysql.hosts

    - name: List groups for users that have them, don't error if groups key is missing
      ansible.builtin.debug:
        var: item
      loop: \"{{ q('ansible.builtin.subelements', users, 'groups', {'skip_missing': True}) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.template
    set output_file "ansible.builtin.template.lookup.yml"

    set template_content "---
# Playbook: ansible.builtin.template lookup examples

- name: Show templating results
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.template', './some_template.j2') }}\"

- name: Show templating results with different variable start and end string
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.template', './some_template.j2', variable_start_string='[%', variable_end_string='%]') }}\"

- name: Show templating results with different comment start and end string
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.template', './some_template.j2', comment_start_string='[#', comment_end_string='#]') }}\"

- name: Show templating results with trim_blocks
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.template', './some_template.j2', trim_blocks=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.together
    set output_file "ansible.builtin.with_together.yml"

    set template_content "---
# Playbook: ansible.builtin.with_together examples

- name: Item.0 returns from the 'a' list, item.1 returns from the '1' list
  ansible.builtin.debug:
    msg: \"{{ item.0 }} and {{ item.1 }}\"
  with_together:
    - ['a', 'b', 'c', 'd']
    - [1, 2, 3, 4]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.unvault
    set output_file "ansible.builtin.unvault.yml"

    set template_content "---
# Playbook: ansible.builtin.unvault lookup examples

- name: Read vaulted file content
  ansible.builtin.debug:
    msg: \"the value of foo.txt is {{ lookup('ansible.builtin.unvault', '/etc/foo.txt') | string | trim }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.url
    set output_file "ansible.builtin.url.yml"

    set template_content "---
# Playbook: ansible.builtin.url lookup examples

- name: URL lookup splits lines by default
  ansible.builtin.debug:
    msg: \"{{item}}\"
  loop: \"{{ lookup('ansible.builtin.url', 'https://github.com/gremlin.keys', wantlist=True) }}\"

- name: Display IP ranges
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.url', 'https://ip-ranges.amazonaws.com/ip-ranges.json', split_lines=False) }}\"

- name: URL lookup using authentication
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.url', 'https://some.private.site.com/file.txt', username='bob', password='hunter2') }}\"

- name: URL lookup using basic authentication
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.url', 'https://some.private.site.com/file.txt', username='bob', password='hunter2', force_basic_auth='True') }}\"

- name: URL lookup using headers
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.url', 'https://some.private.site.com/api/service', headers={'header1':'value1', 'header2':'value2'} ) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.varnames
    set output_file "ansible.builtin.varnames.yml"

    set template_content "---
# Playbook: ansible.builtin.varnames lookup examples

- name: List variables that start with qz_
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.varnames', '^qz_.+') }}\"
  vars:
    qz_1: hello
    qz_2: world
    qa_1: \"I won't show\"
    qz_: \"I won't show either\"

- name: Show all variables
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.varnames', '.+') }}\"

- name: Show variables with 'hosts' in their names
  ansible.builtin.debug:
    msg: \"{{ q('varnames', 'hosts') }}\"

- name: Find several related variables that end specific way
  ansible.builtin.debug:
    msg: \"{{ query('ansible.builtin.varnames', '.+_zone\$', '.+_location\$') }}\"

- name: Display values from variables found via varnames (note '*' is used to dereference the list to a 'list of arguments')
  ansible.builtin.debug:
    msg: \"{{ lookup('vars', *lookup('varnames', 'ansible_play_.+')) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.vars
    set output_file "ansible.builtin.vars.yml"

    set template_content "---
# Playbook: ansible.builtin.vars lookup examples

- name: Show value of 'variablename'
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.vars', 'variabl' + myvar) }}\"
  vars:
    variablename: hello
    myvar: ename

- name: Show default empty since i dont have 'variablnotename'
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.vars', 'variabl' + myvar, default='') }}\"
  vars:
    variablename: hello
    myvar: notename

- name: Produce an error since i dont have 'variablnotename'
  ansible.builtin.debug:
    msg: \"{{ q('vars', 'variabl' + myvar) }}\"
  ignore_errors: True
  vars:
    variablename: hello
    myvar: notename

- name: Find several related variables
  ansible.builtin.debug:
    msg: \"{{ query('ansible.builtin.vars', 'ansible_play_hosts', 'ansible_play_batch', 'ansible_play_hosts_all') }}\"

- name: Show values from variables found via varnames (note '*' is used to dereference the list to a 'list of arguments')
  ansible.builtin.debug:
    msg: \"{{ q('vars', *q('varnames', 'ansible_play_.+')) }}\"

- name: Access nested variables
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.vars', 'variabl' + myvar).sub_var }}\"
  ignore_errors: True
  vars:
    variablename:
        sub_var: 12
    myvar: ename

- name: Alternate way to find some 'prefixed vars' in loop
  ansible.builtin.debug:
    msg: \"{{ lookup('ansible.builtin.vars', 'ansible_play_' + item) }}\"
  loop:
    - hosts
    - batch
    - hosts_all
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.zip
    set output_file "ansible.builtin.zip.yml"

    set template_content "---
# Playbook: ansible.builtin.zip filter examples

vars:
  two: \"{{ [1,2,3,4,5,6] | zip(['a','b','c','d','e','f']) }}\"
  three: \"{{ [1,2,3] | zip(['a','b','c'], ['d','e','f']) }}\"
  shorter: \"{{ [1,2,3] | zip(['a','b','c','d','e','f']) }}\"
  mydict:
    keys_list: [ 'name', 'age', 'city' ]
    values_list: [ 'Alice', 30, 'Paris' ]
    dict: \"{{ dict(keys_list | zip(values_list)) }}\"

tasks:
  - name: Show two zipped lists
    ansible.builtin.debug:
      var: two

  - name: Show three zipped lists
    ansible.builtin.debug:
      var: three

  - name: Show shorter zipped list
    ansible.builtin.debug:
      var: shorter

  - name: Compose dict from keys and values
    ansible.builtin.debug:
      var: dict
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.xmlattr
    set output_file "ansible.builtin.xmlattr.yml"

    set template_content "---
# Playbook: ansible.builtin.xmlattr filter examples

vars:
  xml_attributes:
    id: \"item123\"
    class: \"highlight\"
    data-value: \"42\"

tasks:
  - name: Show XML/SGML attributes string
    ansible.builtin.debug:
      msg: \"<div {{ xml_attributes | xmlattr }}></div>\"

  - name: Another example with different attributes
    ansible.builtin.debug:
      msg: \"<input {{ {'type':'text','name':'username','value':'Alice'} | xmlattr }}> \"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.zip_longest
    set output_file "ansible.builtin.zip_longest.yml"

    set template_content "---
# Playbook: ansible.builtin.zip_longest filter examples

vars:
  list1: [1, 2, 3]
  list2: ['a','b','c','d','e','f']
  list3: [21, 22, 23]

tasks:
  - name: Combine lists using zip_longest with filler 'X'
    ansible.builtin.debug:
      msg: \"{{ list1 | zip_longest(list2, list3, fillvalue='X') }}\"

  - name: Another example with different filler
    ansible.builtin.debug:
      msg: \"{{ [10, 20] | zip_longest(['p','q','r'], [100], fillvalue='NA') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.to_json
    set output_file "ansible.builtin.to_json.yml"

    set template_content "---
# Playbook: ansible.builtin.to_json filter examples

vars:
  docker_config:
    version: '3'
    services:
      web:
        image: nginx
        ports:
          - 80:80

tasks:
  - name: Dump variable as JSON string
    ansible.builtin.debug:
      msg: \"{{ docker_config | ansible.builtin.to_json }}\"

  - name: Dump variable as pretty JSON
    ansible.builtin.debug:
      msg: \"{{ docker_config | ansible.builtin.to_json(indent=4, sort_keys=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.sum
    set output_file "ansible.builtin.sum.yml"

    set template_content "---
# Playbook: ansible.builtin.sum filter examples

vars:
  numbers: [1, 2, 3, 4, 5]

tasks:
  - name: Sum numbers in a list
    ansible.builtin.debug:
      msg: \"Sum of {{ numbers }} is {{ numbers | ansible.builtin.sum }}\"

  - name: Sum numbers with a start value
    ansible.builtin.debug:
      msg: \"Sum of {{ numbers }} with start=10 is {{ numbers | ansible.builtin.sum(start=10) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.slice
    set output_file "ansible.builtin.slice.yml"

    set template_content "---
# Playbook: ansible.builtin.slice filter examples

vars:
  mylist: [1, 2, 3, 4, 5, 6, 7, 8, 9]

tasks:
  - name: Slice list into 3 parts
    ansible.builtin.debug:
      msg: \"{{ mylist | ansible.builtin.slice(3) }}\"

  - name: Slice list into 4 parts
    ansible.builtin.debug:
      msg: \"{{ mylist | ansible.builtin.slice(4) }}\"

  - name: Slice list with step 2
    ansible.builtin.debug:
      msg: \"{{ mylist | ansible.builtin.slice(3, 2) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.tojson
    set output_file "ansible.builtin.tojson.yml"

    set template_content "---
# Playbook: ansible.builtin.tojson filter examples

vars:
  mydata:
    name: Alice
    age: 30
    skills:
      - Python
      - Ansible
      - Docker

tasks:
  - name: Convert variable to JSON string
    ansible.builtin.debug:
      msg: \"{{ mydata | ansible.builtin.tojson }}\"

  - name: Convert variable to pretty JSON string
    ansible.builtin.debug:
      msg: \"{{ mydata | ansible.builtin.tojson(indent=4, sort_keys=True) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.unique
    set output_file "ansible.builtin.unique.yml"

    set template_content "---
# Playbook: ansible.builtin.unique filter examples

vars:
  list1: [1, 2, 5, 1, 3, 4, 10]
  sample:
    - name: a
      age: 12
    - name: b
      age: 14
    - name: c
      age: 14

tasks:
  - name: Return only unique elements from list1
    ansible.builtin.debug:
      msg: \"{{ list1 | ansible.builtin.unique }}\"

  - name: Return case sensitive unique elements
    ansible.builtin.debug:
      msg: \"{{ ['a', 'A', 'a'] | ansible.builtin.unique(case_sensitive='true') }}\"

  - name: Return case insensitive unique elements
    ansible.builtin.debug:
      msg: \"{{ ['b', 'B', 'b'] | ansible.builtin.unique() }}\"

  - name: Return unique elements of list based on attribute 'age'
    ansible.builtin.debug:
      msg: \"{{ sample | ansible.builtin.unique(attribute='age') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.urlize
    set output_file "ansible.builtin.urlize.yml"

    set template_content "---
# Playbook: ansible.builtin.urlize filter examples

vars:
  text: \"Check out https://www.example.com and http://foo.com/page.\"

tasks:
  - name: Convert URLs in text into clickable links
    ansible.builtin.debug:
      msg: \"{{ text | ansible.builtin.urlize }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.to_uuid
    set output_file "ansible.builtin.to_uuid.yml"

    set template_content "---
# Playbook: ansible.builtin.to_uuid filter examples

vars:
  my_string: \"example-string\"

tasks:
  - name: Generate a namespaced UUID using the default Ansible namespace
    ansible.builtin.debug:
      msg: \"UUID for '{{ my_string }}' is {{ my_string | ansible.builtin.to_uuid }}\"

  - name: Generate a namespaced UUID using a custom namespace
    ansible.builtin.debug:
      msg: \"UUID for '{{ my_string }}' with custom namespace is {{ my_string | ansible.builtin.to_uuid(namespace='11111111-2222-3333-4444-555555555555') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.vault
    set output_file "ansible.builtin.vault.yml"

    set template_content "---
# Playbook: ansible.builtin.vault filter examples

vars:
  my_secret: \"super_secret_value\"

tasks:
  - name: Encrypt a value using the vault filter
    ansible.builtin.debug:
      msg: \"Vaulted secret: {{ my_secret | ansible.builtin.vault('my_vault_password') }}\"

  - name: Encrypt a value with a random salt and save to a template
    ansible.builtin.set_fact:
      template_data: \"{{ 'my_sensitive_data' | ansible.builtin.vault('another_vault_password', salt=(2**256 | random(seed=inventory_hostname))) }}\"

  - name: Save vaulted data to a file
    ansible.builtin.template:
      src: dump_template_data.j2
      dest: /some/key/vault.txt
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.split
    set output_file "ansible.builtin.split.yml"

    set template_content "---
# Playbook: ansible.builtin.split filter examples

vars:
  sample_string1: 'jojo is a'
  sample_string2: 'jojo is, a'

tasks:
  - name: Split a string by spaces
    ansible.builtin.debug:
      msg: \"{{ sample_string1 | ansible.builtin.split }}\"

  - name: Split a string by comma
    ansible.builtin.debug:
      msg: \"{{ sample_string2 | ansible.builtin.split(',') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.to_nice_json
    set output_file "ansible.builtin.to_nice_json.yml"

    set template_content "---
# Playbook: ansible.builtin.to_nice_json filter examples

vars:
  docker_config:
    image: nginx
    tag: latest
    ports:
      - 80
      - 443

tasks:
  - name: Convert variable to nicely formatted JSON
    ansible.builtin.debug:
      msg: \"{{ docker_config | ansible.builtin.to_nice_json }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.unvault
    set output_file "ansible.builtin.unvault.yml"

    set template_content "---
# Playbook: ansible.builtin.unvault filter examples

vars:
  myvaultedkey: !vault |
        $ANSIBLE_VAULT;1.1;AES256
        6162636465666768696a6b6c6d6e6f70

  secretdata: !vault |
        $ANSIBLE_VAULT;1.1;AES256
        11223344556677889900aabbccddeeff

  passphrase: my_vault_password
  vaultsecret: another_secret_password

tasks:
  - name: Decrypt a vaulted key
    ansible.builtin.debug:
      msg: \"{{ myvaultedkey | ansible.builtin.unvault(passphrase) }}\"

  - name: Save unvaulted templated data
    ansible.builtin.template:
      src: dump_template_data.j2
      dest: /some/key/clear.txt
    vars:
      template_data: \"{{ secretdata | ansible.builtin.unvault(vaultsecret) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.root
    set output_file "ansible.builtin.root.yml"

    set template_content "---
# Playbook: ansible.builtin.root filter examples

hosts: localhost
gather_facts: false

vars:
  me: 125

tasks:
  - name: Calculate square root (default)
    ansible.builtin.debug:
      msg: \"Square root of 4 is {{ 4 | ansible.builtin.root }}\"

  - name: Calculate cube root
    ansible.builtin.debug:
      msg: \"Cube root of 27 is {{ 27 | ansible.builtin.root(3) }}\"

  - name: Calculate 5th root
    ansible.builtin.debug:
      msg: \"5th root of 32768 is {{ 32768 | ansible.builtin.root(5) }}\"

  - name: Calculate nth root of a variable
    ansible.builtin.debug:
      msg: \"3rd root of me (125) is {{ me | ansible.builtin.root(3) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.string
    set output_file "ansible.builtin.string.yml"

    set template_content "---
# Playbook: ansible.builtin.string filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_number: 42
    my_boolean: true
    my_list: [1, 2, 3]
  tasks:
    - name: Convert number to string
      ansible.builtin.debug:
        msg: \"Number as string: {{ my_number | ansible.builtin.string }}\"

    - name: Convert boolean to string
      ansible.builtin.debug:
        msg: \"Boolean as string: {{ my_boolean | ansible.builtin.string }}\"

    - name: Convert list to string
      ansible.builtin.debug:
        msg: \"List as string: {{ my_list | ansible.builtin.string }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.from_json
    set output_file "ansible.builtin.from_json.yml"

    set template_content "---
# Playbook: ansible.builtin.from_json filter examples

- hosts: localhost
  gather_facts: false
  vars:
    json_string: '{\"a\": true, \"b\": 54, \"c\": [1,2,3]}'
  tasks:
    - name: Convert JSON string into variable structure
      ansible.builtin.debug:
        msg: \"Converted variable: {{ json_string | ansible.builtin.from_json }}\"

    - name: Access individual elements from JSON
      ansible.builtin.debug:
        msg: \"a={{ (json_string | ansible.builtin.from_json).a }}, b={{ (json_string | ansible.builtin.from_json).b }}, c={{ (json_string | ansible.builtin.from_json).c }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.to_datetime 
    set output_file "ansible.builtin.to_datetime.yml"

    set template_content "---
# Playbook: ansible.builtin.to_datetime filter examples

- hosts: localhost
  gather_facts: false
  vars:
    date1: '2022-11-15T03:23:13.686956Z'
    date2: '2021-12-15T16:06:24.400087Z'
    iso8601format: '%Y-%m-%dT%H:%M:%S.%fZ'
  tasks:
    - name: Convert string to datetime object
      ansible.builtin.debug:
        msg: \"Date1 as datetime: {{ date1 | ansible.builtin.to_datetime(iso8601format) }}\"

    - name: Calculate total seconds difference between two dates
      ansible.builtin.debug:
        msg: \"Total seconds difference: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).total_seconds() }}\"

    - name: Calculate remaining seconds after delta
      ansible.builtin.debug:
        msg: \"Remaining seconds: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).seconds }}\"

    - name: Calculate difference in days
      ansible.builtin.debug:
        msg: \"Difference in days: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).days }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end 

function ansible.builtin.to_datetime
    set output_file "ansible.builtin.to_datetime.yml"

    set template_content "---
# Playbook: ansible.builtin.to_datetime filter examples

- hosts: localhost
  gather_facts: false
  vars:
    date1: '2022-11-15T03:23:13.686956Z'
    date2: '2021-12-15T16:06:24.400087Z'
    iso8601format: '%Y-%m-%dT%H:%M:%S.%fZ'
  tasks:
    - name: Convert string to datetime object
      ansible.builtin.debug:
        msg: \"Date1 as datetime: {{ date1 | ansible.builtin.to_datetime(iso8601format) }}\"

    - name: Calculate total seconds difference between two dates
      ansible.builtin.debug:
        msg: \"Total seconds difference: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).total_seconds() }}\"

    - name: Calculate remaining seconds after delta
      ansible.builtin.debug:
        msg: \"Remaining seconds: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).seconds }}\"

    - name: Calculate difference in days
      ansible.builtin.debug:
        msg: \"Difference in days: {{ (date1 | ansible.builtin.to_datetime(iso8601format) - date2 | ansible.builtin.to_datetime(iso8601format)).days }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.dirname
    set output_file "ansible.builtin.dirname.yml"

    set template_content "---
# Playbook: ansible.builtin.dirname filter examples

- hosts: localhost
  gather_facts: false
  vars:
    mypath1: '/etc/asdf/foo.txt'
    mypath2: '/var/log/nginx/access.log'
  tasks:
    - name: Get directory of first path
      ansible.builtin.debug:
        msg: \"Directory of {{ mypath1 }} is {{ mypath1 | ansible.builtin.dirname }}\"

    - name: Get directory of second path
      ansible.builtin.debug:
        msg: \"Directory of {{ mypath2 }} is {{ mypath2 | ansible.builtin.dirname }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.items
    set output_file "ansible.builtin.items.yml"

    set template_content "---
# Playbook: ansible.builtin.items filter examples

- hosts: localhost
  gather_facts: false
  vars:
    mydict:
      name: Alice
      age: 30
      city: Wonderland
  tasks:
    - name: Loop over dictionary items using ansible.builtin.items
      ansible.builtin.debug:
        msg: \"Key={{ item.0 }}, Value={{ item.1 }}\"
      loop: \"{{ mydict | ansible.builtin.items }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.join
    set output_file "ansible.builtin.join.yml"

    set template_content "---
# Playbook: ansible.builtin.join filter examples

- hosts: localhost
  gather_facts: false
  vars:
    mylist:
      - hello
      - world
      - ansible
  tasks:
    - name: Join list elements with a space
      ansible.builtin.debug:
        msg: \"{{ mylist | ansible.builtin.join(' ') }}\"

    - name: Join list elements with a comma
      ansible.builtin.debug:
        msg: \"{{ mylist | ansible.builtin.join(',') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.regex_search
    set output_file "ansible.builtin.regex_search.yml"

    set template_content "---
# Playbook: ansible.builtin.regex_search filter examples

vars:
  my_string1: 'server1/database42'
  my_string2: 'foo\nBAR'
  my_string3: '21/42'

tasks:
  - name: Extract database number
    ansible.builtin.debug:
      msg: \"{{ my_string1 | ansible.builtin.regex_search('database[0-9]+') }}\"
      # => 'database42'

  - name: Extract server number case-insensitively
    ansible.builtin.debug:
      msg: \"{{ my_string1 | ansible.builtin.regex_search('(?i)server([0-9]+)') }}\"
      # => '1'

  - name: Match 'BAR' in multiline and ignore case
    ansible.builtin.debug:
      msg: \"{{ my_string2 | ansible.builtin.regex_search('^bar', ignorecase=True, multiline=True) }}\"
      # => 'BAR'

  - name: Extract dividend and divisor from fraction using named groups
    ansible.builtin.debug:
      msg: \"{{ my_string3 | ansible.builtin.regex_search('(?P<dividend>[0-9]+)/(?P<divisor>[0-9]+)', '\\\\g<dividend>', '\\\\g<divisor>') }}\"
      # => ['21', '42']
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.relpath
    set output_file "ansible.builtin.relpath.yml"

    set template_content "---
# Playbook: ansible.builtin.relpath filter examples

vars:
  mypath: '/tmp/test/me.txt'
  mydir: '/tmp/other'

tasks:
  - name: Make path relative to a given start
    ansible.builtin.debug:
      msg: \"{{ mypath | ansible.builtin.relpath(mydir) }}\"
      # => '../test/me.txt'

  - name: Make path relative to current directory
    ansible.builtin.debug:
      msg: \"{{ mypath | ansible.builtin.relpath }}\"
      # => relative path from current working directory
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.int
    set output_file "ansible.builtin.int.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    string_number: \"42\"
    float_number: 3.14
    hex_number: \"0x1A\"
  tasks:
    - name: Convert string to integer
      ansible.builtin.debug:
        msg: \"{{ string_number | ansible.builtin.int }}\"  # => 42

    - name: Convert float to integer
      ansible.builtin.debug:
        msg: \"{{ float_number | ansible.builtin.int }}\"   # => 3

    - name: Convert hexadecimal string to integer
      ansible.builtin.debug:
        msg: \"{{ hex_number | ansible.builtin.int(base=16) }}\"  # => 26
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.first
    set output_file "ansible.builtin.first.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    my_list: [10, 20, 30, 40]
  tasks:
    - name: Get the first item of a list
      ansible.builtin.debug:
        msg: \"First item is {{ my_list | ansible.builtin.first }}\"  # => 10
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.extract
    set output_file "ansible.builtin.extract.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    my_list: ['a', 'b', 'c']
    my_dict: {'a': 1, 'b': 2, 'c': 3}
    my_nested_list: [{'a': 1, 'b': 2, 'c': 3}, {'x': 9, 'y': 10}]
  tasks:
    - name: Extract from list
      ansible.builtin.debug:
        msg: \"Second item of list: {{ 1 | ansible.builtin.extract(my_list) }}\"  # => 'b'

    - name: Extract from dictionary
      ansible.builtin.debug:
        msg: \"Value of key 'b': {{ 'b' | ansible.builtin.extract(my_dict) }}\"  # => 2

    - name: Extract from nested list of dicts
      ansible.builtin.debug:
        msg: \"Value of key 'b' in first dict: {{ 0 | ansible.builtin.extract(my_nested_list, morekeys='b') }}\"  # => 2
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.fileglob
    set output_file "ansible.builtin.fileglob.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:
    - name: List files matching a glob pattern
      ansible.builtin.debug:
        msg: \"Matching files: {{ '/etc/h?sts' | ansible.builtin.fileglob }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.regex_findall
    set output_file "ansible.builtin.regex_findall.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    sample_text1: \"CAR\ntar\nfoo\nbar\n\"
    sample_text2: \"Some DNS servers are 8.8.8.8 and 8.8.4.4\"
  tasks:
    - name: Extract words matching pattern
      ansible.builtin.debug:
        msg: \"Matching words: {{ sample_text1 | ansible.builtin.regex_findall('^.ar\$', multiline=True, ignorecase=True) }}\"

    - name: Extract IP addresses
      ansible.builtin.debug:
        msg: \"IP addresses: {{ sample_text2 | ansible.builtin.regex_findall('\\\\b(?:[0-9]{1,3}\\\\.){3}[0-9]{1,3}\\\\b') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.select
    set output_file "ansible.builtin.select.yml"

    set template_content "---
# Playbook: ansible.builtin.select filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [1, 2, 3, 4, 5, 6]
  tasks:
    - name: Select odd numbers
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.select('odd') }}\"

    - name: Select numbers greater than 3
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.select('greaterthan', 3) }}\"

    - name: Select strings that contain 'foo'
      vars:
        str_list: ['foo', 'bar', 'foobar', 'baz']
      ansible.builtin.debug:
        msg: \"{{ str_list | ansible.builtin.select('search', 'foo') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.replace
    set output_file "ansible.builtin.replace.yml"

    set template_content "---
# Playbook: ansible.builtin.replace filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"hello world, hello universe\"
  tasks:
    - name: Replace 'hello' with 'hi'
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.replace('hello', 'hi') }}\"
      # => \"hi world, hi universe\"

    - name: Replace first occurrence only
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.replace('hello', 'hi', replace_all=false) }}\"
      # => \"hi world, hello universe\"

    - name: Case-insensitive replacement
      ansible.builtin.debug:
        msg: \"{{ 'Hello World' | ansible.builtin.replace('hello', 'hi', ignorecase=true) }}\"
      # => \"hi World\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.reverse
    set output_file "ansible.builtin.reverse.yml"

    set template_content "---
# Playbook: ansible.builtin.reverse filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [1, 2, 3, 4, 5]
    my_string: \"Ansible\"
  tasks:
    - name: Reverse a list
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.reverse }}\"
      # => [5, 4, 3, 2, 1]

    - name: Reverse a string
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.reverse }}\"
      # => 'elbisnA'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sha1
    set output_file "ansible.builtin.sha1.yml"

    set template_content "---
# Playbook: ansible.builtin.sha1 filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"testing\"
    another_string: \"AnsibleSHA1Demo\"
  tasks:
    - name: Get SHA-1 hash of a string
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.sha1 }}\"
      # => \"dc724af18fbdd4e59189f5fe768a5f8311527050\"

    - name: Get SHA-1 hash of another string
      ansible.builtin.debug:
        msg: \"{{ another_string | ansible.builtin.sha1 }}\"
      # => Example: \"c8d6bb4e4d65b7fd9248c2a0b8a7d861c8a6d0a7\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n \"$output_file created\"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.shuffle
    set output_file "ansible.builtin.shuffle.yml"

    set template_content "---
# Playbook: ansible.builtin.shuffle filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: ['a', 'b', 'c', 'd', 'e']
  tasks:
    - name: Shuffle list randomly
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.shuffle }}\"
      # => Example: ['c', 'a', 'e', 'b', 'd']

    - name: Shuffle list with repeatable seed
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.shuffle(seed='my_seed_value') }}\"
      # => Example: ['b', 'e', 'a', 'd', 'c']

    - name: Shuffle list using inventory hostname as seed
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.shuffle(seed=inventory_hostname) }}\"
      # => Repeatable per host
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.sort
    set output_file "ansible.builtin.sort.yml"

    set template_content "---
# Playbook: ansible.builtin.sort filter examples

- hosts: localhost
  gather_facts: false
  vars:
    numbers: [5, 2, 9, 1, 3]
    words: ['banana', 'apple', 'cherry']
    complex_list:
      - { name: 'carrot',  type: 'vegetable' }
      - { name: 'apple',   type: 'fruit' }
      - { name: 'broccoli', type: 'vegetable' }

  tasks:
    - name: Sort numbers ascending
      ansible.builtin.debug:
        msg: \"{{ numbers | ansible.builtin.sort }}\"
      # => [1, 2, 3, 5, 9]

    - name: Sort numbers descending
      ansible.builtin.debug:
        msg: \"{{ numbers | ansible.builtin.sort(reverse=true) }}\"
      # => [9, 5, 3, 2, 1]

    - name: Sort words alphabetically
      ansible.builtin.debug:
        msg: \"{{ words | ansible.builtin.sort }}\"
      # => ['apple', 'banana', 'cherry']

    - name: Sort complex list by key 'name'
      ansible.builtin.debug:
        msg: \"{{ complex_list | ansible.builtin.sort(attribute='name') }}\"
      # => [{'name': 'apple', ...}, {'name': 'broccoli', ...}, {'name': 'carrot', ...}]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.round
    set output_file "ansible.builtin.round.yml"

    set template_content "---
# Playbook: ansible.builtin.round filter examples

- hosts: localhost
  gather_facts: false
  vars:
    pi_value: 3.14159
    negative_value: -2.718
  tasks:
    - name: Round to nearest integer
      ansible.builtin.debug:
        msg: \"{{ pi_value | ansible.builtin.round }}\"
      # => 3

    - name: Round to 2 decimal places
      ansible.builtin.debug:
        msg: \"{{ pi_value | ansible.builtin.round(2) }}\"
      # => 3.14

    - name: Round negative number to 1 decimal place
      ansible.builtin.debug:
        msg: \"{{ negative_value | ansible.builtin.round(1) }}\"
      # => -2.7

    - name: Round number to nearest 10
      ansible.builtin.debug:
        msg: \"{{ 123 | ansible.builtin.round(-1) }}\"
      # => 120
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.quote
    set output_file "ansible.builtin.quote.yml"

    set template_content "---
# Playbook: ansible.builtin.quote filter examples

- hosts: localhost
  gather_facts: false
  vars:
    string_value: \"Hello World!\"
    command_value: \"echo Hello && rm -rf /tmp/test\"
  tasks:
    - name: Quote a simple string
      ansible.builtin.debug:
        msg: \"{{ string_value | ansible.builtin.quote }}\"
      # => 'Hello World!'

    - name: Quote a potentially unsafe shell command
      ansible.builtin.debug:
        msg: \"{{ command_value | ansible.builtin.quote }}\"
      # => 'echo Hello && rm -rf /tmp/test'

    - name: Run a safely quoted command
      ansible.builtin.shell: \"echo {{ string_value | ansible.builtin.quote }}\"
      register: quoted_result

    - name: Show the quoted command result
      ansible.builtin.debug:
        var: quoted_result.stdout
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.reject
    set output_file "ansible.builtin.reject.yml"

    set template_content "---
# Playbook: ansible.builtin.reject filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [1, 2, 3, 4, 5, 6]
  tasks:
    - name: Reject odd numbers
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.reject('odd') | list }}\"
      # => [2, 4, 6]

    - name: Reject numbers greater than 3
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.reject('greaterthan', 3) | list }}\"
      # => [1, 2, 3]

    - name: Reject strings that contain 'foo'
      vars:
        str_list: ['foo', 'bar', 'foobar', 'baz']
      ansible.builtin.debug:
        msg: \"{{ str_list | ansible.builtin.reject('search', 'foo') | list }}\"
      # => ['bar', 'baz']
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.regex_replace
    set output_file "ansible.builtin.regex_replace.yml"

    set template_content "---
# Playbook: ansible.builtin.regex_replace filter examples

- hosts: localhost
  gather_facts: false
  vars:
    example_string: 'ansible'
    host_port: 'localhost:80'
    pirates: \"CAR\ntar\nfoo\nbar\n\"
    key_value_str: 'foo=bar=baz'
  tasks:
    - name: Extract part of word using regex
      ansible.builtin.debug:
        msg: \"{{ example_string | ansible.builtin.regex_replace('^a.*i(.*)\$', 'a\\1') }}\"
      # => 'able'

    - name: Replace ':' with ', ' using named groups
      ansible.builtin.debug:
        msg: \"{{ host_port | ansible.builtin.regex_replace('^(?P<host>.+):(?P<port>\\\\d+)\$', '\\\\g<host>, \\\\g<port>') }}\"
      # => 'localhost, 80'

    - name: Comment out lines matching pattern (case-insensitive, multiline)
      ansible.builtin.debug:
        msg: \"{{ pirates | ansible.builtin.regex_replace('^(.ar)\$', '#\\\\1', multiline=True, ignorecase=True) }}\"
      # => '#CAR\n#tar\nfoo\n#bar\n'

    - name: Replace only the first occurrence
      ansible.builtin.debug:
        msg: \"{{ key_value_str | ansible.builtin.regex_replace('=', ':', count=1) }}\"
      # => 'foo:bar=baz'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.pow
    set output_file "ansible.builtin.pow.yml"

    set template_content "---
# Playbook: ansible.builtin.pow filter examples

- hosts: localhost
  gather_facts: false
  vars:
    me: 5
  tasks:
    - name: 8 to the power of 5
      ansible.builtin.debug:
        msg: \"{{ 8 | ansible.builtin.pow(5) }}\"
      # => 32768

    - name: 2 squared
      ansible.builtin.debug:
        msg: \"{{ 2 | ansible.builtin.pow(2) }}\"
      # => 4

    - name: 5 cubed
      ansible.builtin.debug:
        msg: \"{{ me | ansible.builtin.pow(3) }}\"
      # => 125
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.upper
    set output_file "ansible.builtin.upper.yml"

    set template_content "---
# Playbook: ansible.builtin.upper filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: 'hello world'
  tasks:
    - name: Convert string to uppercase
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.upper }}\"
      # => 'HELLO WORLD'

    - name: Convert inline string to uppercase
      ansible.builtin.debug:
        msg: \"{{ 'ansible rocks!' | ansible.builtin.upper }}\"
      # => 'ANSIBLE ROCKS!'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.urlsplit
    set output_file "ansible.builtin.urlsplit.yml"

    set template_content "---
# Playbook: ansible.builtin.urlsplit filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_url: 'http://user:password@www.acme.com:9000/dir/index.html?query=term#fragment'
  tasks:
    - name: Split URL into all components
      ansible.builtin.debug:
        msg: \"{{ my_url | ansible.builtin.urlsplit }}\"
      # => dictionary with keys: scheme, username, password, hostname, port, path, query, fragment, netloc

    - name: Get hostname from URL
      ansible.builtin.debug:
        msg: \"{{ my_url | ansible.builtin.urlsplit('hostname') }}\"
      # => 'www.acme.com'

    - name: Get path from URL
      ansible.builtin.debug:
        msg: \"{{ my_url | ansible.builtin.urlsplit('path') }}\"
      # => '/dir/index.html'

    - name: Get query from URL
      ansible.builtin.debug:
        msg: \"{{ my_url | ansible.builtin.urlsplit('query') }}\"
      # => 'query=term'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.trim
    set output_file "ansible.builtin.trim.yml"

    set template_content "---
# Playbook: ansible.builtin.trim filter examples

- hosts: localhost
  gather_facts: false
  vars:
    padded_string: '   hello world   '
    custom_padded: '***important***'
  tasks:
    - name: Trim whitespace from string
      ansible.builtin.debug:
        msg: \"{{ padded_string | ansible.builtin.trim }}\"
      # => 'hello world'

    - name: Trim custom characters
      ansible.builtin.debug:
        msg: \"{{ custom_padded | ansible.builtin.trim('*') }}\"
      # => 'important'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.urldecode
    set output_file "ansible.builtin.urldecode.yml"

    set template_content "---
# Playbook: ansible.builtin.urldecode filter examples

- hosts: localhost
  gather_facts: false
  vars:
    encoded_url1: '%7e/abc+def'
    encoded_url2: 'El+Ni%C3%B1o'
  tasks:
    - name: Decode simple URL
      ansible.builtin.debug:
        msg: \"{{ encoded_url1 | ansible.builtin.urldecode }}\"
      # => '~/abc def'

    - name: Decode URL with plus and special character
      ansible.builtin.debug:
        msg: \"{{ encoded_url2 | ansible.builtin.urldecode }}\"
      # => 'El Niño'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.urlencode
    set output_file "ansible.builtin.urlencode.yml"

    set template_content "---
# Playbook: ansible.builtin.urlencode filter examples

- hosts: localhost
  gather_facts: false
  vars:
    text1: '~/abc def'
    text2: 'El Niño'
  tasks:
    - name: Encode simple URL
      ansible.builtin.debug:
        msg: \"{{ text1 | ansible.builtin.urlencode }}\"
      # => '%7E/abc%20def'

    - name: Encode text with special character
      ansible.builtin.debug:
        msg: \"{{ text2 | ansible.builtin.urlencode }}\"
      # => 'El%20Ni%C3%B1o'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.union
    set output_file "ansible.builtin.union.yml"

    set template_content "---
# Playbook: ansible.builtin.union filter examples

- hosts: localhost
  gather_facts: false
  vars:
    list1: [1, 2, 5, 1, 3, 4, 10]
    list2: [1, 2, 3, 4, 5, 11, 99]
  tasks:
    - name: Union of two lists
      ansible.builtin.debug:
        msg: \"{{ list1 | ansible.builtin.union(list2) }}\"
      # => [1, 2, 5, 3, 4, 10, 11, 99]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.truncate
    set output_file "ansible.builtin.truncate.yml"

    set template_content "---
# Playbook: ansible.builtin.truncate filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"The quick brown fox jumps over the lazy dog\"
  tasks:
    - name: Truncate to 10 characters
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.truncate(10) }}\"

    - name: Truncate to 15 characters with custom suffix
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.truncate(15, suffix='>>>') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible_builtin_to_yaml
    set output_file "ansible.builtin.to_yaml.yml"

    set template_content "---
# Playbook: ansible.builtin.to_yaml filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_dict:
      name: Alice
      age: 30
      skills:
        - Python
        - Ansible
        - Docker
  tasks:
    - name: Convert variable to YAML string
      ansible.builtin.debug:
        msg: \"{{ my_dict | ansible.builtin.to_yaml }}\"

    - name: Convert variable to YAML string with indentation
      ansible.builtin.debug:
        msg: \"{{ my_dict | ansible.builtin.to_yaml(indent=4) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible_builtin_flatten
    set output_file "ansible.builtin.flatten.yml"

    set template_content "---
# Playbook: ansible.builtin.flatten filter examples

- hosts: localhost
  gather_facts: false
  vars:
    nested_list: [1, 2, [3, [4, 5]], 6]
  tasks:
    - name: Fully flatten the list
      ansible.builtin.debug:
        msg: \"{{ nested_list | ansible.builtin.flatten }}\"
      # => [1, 2, 3, 4, 5, 6]

    - name: Flatten the list by one level
      ansible.builtin.debug:
        msg: \"{{ nested_list | ansible.builtin.flatten(1) }}\"
      # => [1, 2, 3, [4, 5], 6]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.from_yaml
    set output_file "ansible.builtin.from_yaml.yml"

    set template_content "---
# Playbook: ansible.builtin.from_yaml filter examples

- hosts: localhost
  gather_facts: false
  vars:
    yaml_string: |
      a: true
      b: 54
      c:
        - 1
        - 2
        - 3
  tasks:
    - name: Convert YAML string variable into a structured variable
      ansible.builtin.debug:
        msg: \"{{ yaml_string | ansible.builtin.from_yaml }}\"
      # => {'a': True, 'b': 54, 'c': [1, 2, 3]}

    - name: Convert JSON string using from_yaml
      vars:
        json_string: '{\"x\": 10, \"y\": 20}'
      ansible.builtin.debug:
        msg: \"{{ json_string | ansible.builtin.from_yaml }}\"
      # => {'x': 10, 'y': 20}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.count
    set output_file "ansible.builtin.count.yml"

    set template_content "---
# Playbook: ansible.builtin.count filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [1, 2, 3, 4]
    my_dict: { a: 1, b: 2, c: 3 }
    my_string: \"hello\"
  tasks:
    - name: Count items in list
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.count }}\"

    - name: Count items in dictionary
      ansible.builtin.debug:
        msg: \"{{ my_dict | ansible.builtin.count }}\"

    - name: Count characters in string
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.count }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtin.to_nice_yaml
    set output_file "ansible.builtin.to_nice_yaml.yml"

    set template_content "---
# Playbook: ansible.builtin.to_nice_yaml filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_dict:
      name: Alice
      age: 30
      skills:
        - Python
        - Ansible
        - YAML
  tasks:
    - name: Convert variable to nicely formatted YAML
      ansible.builtin.debug:
        msg: \"{{ my_dict | ansible.builtin.to_nice_yaml(indent=4, sort_keys=true) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.strftime
    set output_file "ansible.builtin.strftime.yml"

    set template_content "---
# Playbook: ansible.builtin.strftime filter examples

- hosts: localhost
  gather_facts: true
  tasks:
    - name: Display current date in YYYY-MM-DD format
      ansible.builtin.debug:
        msg: \"{{ '%Y-%m-%d' | ansible.builtin.strftime }}\"

    - name: Display current time in HH:MM:SS format
      ansible.builtin.debug:
        msg: \"{{ '%H:%M:%S' | ansible.builtin.strftime }}\"

    - name: Display date and time from epoch fact
      ansible.builtin.debug:
        msg: \"{{ '%Y-%m-%d %H:%M:%S' | ansible.builtin.strftime(ansible_date_time.epoch) }}\"

    - name: Display specific epoch date in UTC
      ansible.builtin.debug:
        msg: \"{{ '%Y-%m-%d' | ansible.builtin.strftime(seconds=1441357287, utc=true) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.escape
    set output_file "ansible.builtin.escape.yml"

    set template_content "---
# Playbook: ansible.builtin.escape filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"Tom & Jerry <Cartoon> 'Fun' \\\"Show\\\"\"
  tasks:
    - name: Escape special HTML characters
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.escape }}\"
# => \"Tom &amp; Jerry &lt;Cartoon&gt; &#39;Fun&#39; &quot;Show&quot;\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.hash
    set output_file "ansible.builtin.hash.yml"

    set template_content "---
# Playbook: ansible.builtin.hash filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"test2\"
  tasks:
    - name: Compute SHA-1 hash (default)
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.hash('sha1') }}\"
      # => \"109f4b3c50d7b0df729d299bc6f8e9ef9066971f\"

    - name: Compute MD5 hash
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.hash('md5') }}\"
      # => \"5a105e8b9d40e1329780d62ea2265d8a\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible_builtin_log
    set output_file "ansible.builtin.log.yml"

    set template_content "---
# Playbook: ansible.builtin.log filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_number: 8
  tasks:
    - name: Compute log base 5
      ansible.builtin.debug:
        msg: \"{{ my_number | ansible.builtin.log(5) }}\"
      # => 1.2920296742201791

    - name: Compute natural log (default base e)
      ansible.builtin.debug:
        msg: \"{{ my_number | ansible.builtin.log() }}\"
      # => 2.0794415416798357
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.lower
    set output_file "ansible.builtin.lower.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"Hello WORLD\"
  tasks:
    - name: Convert string to lowercase
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.lower }}\""

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtin.items2dict
    set output_file "ansible.builtin.items2dict.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  vars:
    tags:
      - key: Application
        value: payment
      - key: Environment
        value: dev
    consolidated: \"{{ tags | ansible.builtin.items2dict }}\"
  tasks:
    - name: Show consolidated dictionary
      ansible.builtin.debug:
        var: consolidated"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.buitlin.map
    set output_file "ansible.builtin.map.yml"

    set template_content "---
# Playbook: ansible.builtin.map filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list:
      - { name: alice, age: 25 }
      - { name: bob, age: 30 }
  tasks:
    - name: Extract names from list of dictionaries
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.map(attribute='name') | list }}\"

    - name: Convert all names to uppercase
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.map(attribute='name') | ansible.builtin.map('upper') | list }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.type_debug
    set output_file "ansible.builtin.type_debug.yml"

    set template_content "---
# Playbook: ansible.builtin.type_debug filter examples

- hosts: localhost
  gather_facts: false
  vars:
    myvar_list: [1, 2, 3]
    myvar_dict: { a: 1, b: 2 }
    myvar_string: \"hello\"
  tasks:
    - name: Show type of list
      ansible.builtin.debug:
        msg: \"{{ myvar_list | ansible.builtin.type_debug }}\"

    - name: Show type of dictionary
      ansible.builtin.debug:
        msg: \"{{ myvar_dict | ansible.builtin.type_debug }}\"

    - name: Show type of string
      ansible.builtin.debug:
        msg: \"{{ myvar_string | ansible.builtin.type_debug }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.center
    set output_file "ansible.builtin.center.yml"

    set template_content "---
# Playbook: ansible.builtin.center filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"hello\"
  tasks:
    - name: Center string with width 10
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.center(10) }}\"
      # => '  hello   '

    - name: Center string with width 10 using a custom fill character
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.center(10, '*') }}\"
      # => '**hello***'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.combine
    set output_file "ansible.builtin.combine.yml"

    set template_content "---
# Playbook: ansible.builtin.combine filter examples

- hosts: localhost
  gather_facts: false
  vars:
    dict1:
      a: 1
      b: 2
    dict2:
      b: 3
      c: 4
    defaults:
      a:
        b: 3
        c: 4
      d: 5
    customization:
      a:
        c: 20
  tasks:
    - name: Combine two dictionaries
      ansible.builtin.debug:
        msg: \"{{ dict1 | ansible.builtin.combine(dict2) }}\"
      # => {'a': 1, 'b': 3, 'c': 4}

    - name: Combine multiple dictionaries
      ansible.builtin.debug:
        msg: \"{{ dict1 | ansible.builtin.combine(dict2, {'d':5}) }}\"
      # => {'a':1, 'b':3, 'c':4, 'd':5}

    - name: Recursive combine dictionaries
      ansible.builtin.debug:
        msg: \"{{ defaults | ansible.builtin.combine(customization, recursive=true) }}\"
      # => {'a': {'b':3, 'c':20}, 'd':5}
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function ansible.builtins.combinations
    set output_file "ansible.builtin.combinations.yml"

    set template_content "---
# Playbook: ansible.builtin.combinations filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [1, 2, 3, 4, 5]
  tasks:
    - name: Generate combinations of 2 elements
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.combinations(2) }}\"
      # => [ [1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5] ]
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.comment
    set output_file "ansible.builtin.comment.yml"

    set template_content "---
# Playbook: ansible.builtin.comment filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_string: \"Plain style (default)\"
  tasks:
    - name: Comment a string in default plain style
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.comment }}\"
      # => #
      #    # Plain style (default)
      #    #

    - name: Comment a string with custom style
      vars:
        custom_string: \"Custom style\"
      ansible.builtin.debug:
        msg: \"{{ custom_string | ansible.builtin.comment('plain', prefix='#######\\n#', postfix='#\\n#######\\n   ###\\n    #') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.default
    set output_file "ansible.builtin.default.yml"

    set template_content "---
# Playbook: ansible.builtin.default filter examples

- hosts: localhost
  gather_facts: false
  vars:
    defined_var: \"I exist\"
  tasks:
    - name: Use defined variable
      ansible.builtin.debug:
        msg: \"{{ defined_var | ansible.builtin.default('Default value') }}\"
      # => 'I exist'

    - name: Use undefined variable with default
      ansible.builtin.debug:
        msg: \"{{ undefined_var | ansible.builtin.default('Default value') }}\"
      # => 'Default value'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.max
    set output_file "ansible.builtin.max.yml"

    set template_content "---
# Playbook: ansible.builtin.max filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [5, 3, 9, 1, 7]
  tasks:
    - name: Find the maximum value in a list
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.max }}\"
      # => 9

    - name: Find the maximum of individual numbers
      ansible.builtin.debug:
        msg: \"{{ [12, 45, 7, 33] | ansible.builtin.max }}\"
      # => 45
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function ansible.builtins.last
    set output_file "ansible.builtin.last.yml"

    set template_content "---
# Playbook: ansible.builtin.last filter examples

- hosts: localhost
  gather_facts: false
  vars:
    my_list: [10, 20, 30, 40, 50]
  tasks:
    - name: Get the last item from a list
      ansible.builtin.debug:
        msg: \"{{ my_list | ansible.builtin.last }}\"
      # => 50

    - name: Get the last character of a string
      vars:
        my_string: 'hello'
      ansible.builtin.debug:
        msg: \"{{ my_string | ansible.builtin.last }}\"
      # => 'o'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end



function ansible.builtin.checksum
    set output_file "ansible_checksum_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.checksum filter
  hosts: localhost
  gather_facts: false
  vars:
    mydata: \"test2\"
  tasks:
    - name: Compute checksum of a string
      ansible.builtin.debug:
        msg: \"Checksum: {{ mydata | ansible.builtin.checksum }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.commonpath
    set output_file "ansible_commonpath_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.commonpath filter
  hosts: localhost
  gather_facts: false
  vars:
    listofpaths:
      - /foo/bar/foobar
      - /foo/bar/baz
      - /foo/bar/qux
  tasks:
    - name: Get the longest common path
      ansible.builtin.debug:
        msg: \"Common path: {{ listofpaths | ansible.builtin.commonpath }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.d
    set output_file "ansible_d_filter_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.d filter
  hosts: localhost
  gather_facts: false
  vars:
    existing_var: \"I exist\"
  tasks:
    - name: Show existing variable
      ansible.builtin.debug:
        msg: \"Value of existing_var: {{ existing_var | ansible.builtin.d('default value') }}\"

    - name: Show undefined variable with default
      ansible.builtin.debug:
        msg: \"Value of undefined_var: {{ undefined_var | ansible.builtin.d('default value') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.dictsort
    set output_file "ansible_dictsort_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.dictsort filter
  hosts: localhost
  gather_facts: false
  vars:
    my_dict:
      zeta: 3
      alpha: 1
      gamma: 2
  tasks:
    - name: Show dictionary sorted by keys
      ansible.builtin.debug:
        msg: \"Sorted dictionary: {{ my_dict | ansible.builtin.dictsort }}\"

    - name: Show dictionary sorted by values
      ansible.builtin.debug:
        msg: \"Sorted by values: {{ my_dict | ansible.builtin.dictsort(attribute='value') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.dict2items
    set output_file "ansible_dict2items_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.dict2items filter
  hosts: localhost
  gather_facts: false
  vars:
    my_dict:
      a: 1
      b: 2
      c: 3
    files:
      users: /etc/passwd
      groups: /etc/group
  tasks:
    - name: Convert simple dict to itemized list
      ansible.builtin.debug:
        msg: \"Items: {{ my_dict | ansible.builtin.dict2items }}\"

    - name: Convert dict to itemized list with custom key/value names
      ansible.builtin.debug:
        msg: \"Files as items: {{ files | ansible.builtin.dict2items(key_name='file', value_name='path') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.difference
    set output_file "ansible_difference_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.difference filter
  hosts: localhost
  gather_facts: false
  vars:
    list1: [1, 2, 5, 1, 3, 4, 10]
    list2: [1, 2, 3, 4, 5, 11, 99]
  tasks:
    - name: Show elements of list1 not in list2
      ansible.builtin.debug:
        msg: \"Difference: {{ list1 | ansible.builtin.difference(list2) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.filesize.format
    set output_file "ansible_filesizeformat_example.yml"

    set template_content "---
- name: Show human-readable file size
  hosts: localhost
  gather_facts: false

  vars:
    my_size: 12345678

  tasks:
    - name: Format file size
      ansible.builtin.debug:
        msg: \"{{ my_size | ansible.builtin.filesizeformat }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.expandvars
    set output_file "ansible_expandvars_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.expandvars filter
  hosts: localhost
  gather_facts: false
  vars:
    mypath: \"\$HOME/stuff.txt\"
  tasks:
    - name: Expand environment variables in path
      ansible.builtin.debug:
        msg: \"Expanded path: {{ mypath | ansible.builtin.expandvars }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.expanduser
    set output_file "ansible_expanduser_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.expanduser filter
  hosts: localhost
  gather_facts: false
  vars:
    mypath: \"~/stuff.txt\"
  tasks:
    - name: Expand tilde to home directory
      ansible.builtin.debug:
        msg: \"Expanded path: {{ mypath | ansible.builtin.expanduser }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.indent
    set output_file "ansible_indent_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.indent filter
  hosts: localhost
  gather_facts: false
  vars:
    my_text: |
      This is line one.
      This is line two.
  tasks:
    - name: Show text indented by 4 spaces
      ansible.builtin.debug:
        msg: \"{{ my_text | ansible.builtin.indent(4) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo \"$output_file created\"
    set_color normal
    cat $output_file
end


function ansible.builtin.host_pinned
    set output_file "ansible_host_pinned_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.host_pinned strategy
  hosts: all
  strategy: ansible.builtin.host_pinned
  gather_facts: false

  tasks:
    - name: Task 1 - run independently on each host
      ansible.builtin.debug:
        msg: \"Starting task 1 on {{ inventory_hostname }}\"

    - name: Task 2 - continues without waiting for other hosts
      ansible.builtin.debug:
        msg: \"Finishing task 2 on {{ inventory_hostname }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end



function ansible.builtin.debug
    set output_file "ansible_debug_strategy_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.debug strategy
  hosts: localhost
  strategy: ansible.builtin.debug
  gather_facts: false

  tasks:
    - name: Example task to trigger debug mode
      ansible.builtin.debug:
        msg: \"This task runs in debug strategy mode\"

    - name: Another task for step execution
      ansible.builtin.debug:
        msg: \"You can step through tasks interactively in debug mode\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.free
    set output_file "ansible_free_strategy_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.free strategy
  hosts: all
  strategy: ansible.builtin.free
  gather_facts: false

  tasks:
    - name: Simulate independent task execution
      ansible.builtin.debug:
        msg: \"This task runs as soon as each host is ready, without waiting for others.\"

    - name: Another quick example
      ansible.builtin.shell: sleep 3 && echo 'Task finished on host'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.linear
    set output_file "ansible_linear_strategy_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.linear strategy
  hosts: all
  strategy: ansible.builtin.linear
  gather_facts: false

  tasks:
    - name: Run task one sequentially across hosts
      ansible.builtin.debug:
        msg: \"Task one executed linearly across all hosts.\"

    - name: Run task two after all hosts complete task one
      ansible.builtin.debug:
        msg: \"Task two starts only after all hosts finish task one.\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.powershell
    set output_file "ansible_powershell_shell_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.powershell shell usage
  hosts: windows
  gather_facts: false
  vars:
    ansible_shell_type: ansible.builtin.powershell
    ansible_connection: winrm

  tasks:
    - name: Run a PowerShell command
      ansible.builtin.shell: |
        Get-Process | Select-Object -First 5

    - name: Show PowerShell environment variable
      ansible.builtin.shell: |
        Write-Output \"Temp directory: $env:TEMP\"

    - name: Example with async_dir and remote_tmp configuration
      ansible.builtin.shell: |
        Write-Output \"Async dir: $env:USERPROFILE\\.ansible_async\"
      vars:
        ansible_async_dir: \"%USERPROFILE%\\.ansible_async\"
        ansible_remote_tmp: \"%TEMP%\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.regex_escape
    set output_file "ansible_regex_escape_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.regex_escape filter
  hosts: localhost
  gather_facts: false

  vars:
    unsafe_regex: '^f.*o(.*)\$'
    safe_regex_python: \"{{ unsafe_regex | ansible.builtin.regex_escape('python') }}\"
    safe_regex_posix: \"{{ unsafe_regex | ansible.builtin.regex_escape('posix_basic') }}\"

  tasks:
    - name: Show escaped regex (Python style)
      ansible.builtin.debug:
        msg: \"Escaped (Python): {{ safe_regex_python }}\"

    - name: Show escaped regex (POSIX Basic style)
      ansible.builtin.debug:
        msg: \"Escaped (POSIX Basic): {{ safe_regex_posix }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.password_hash
    set output_file "ansible_password_hash_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.password_hash filter
  hosts: localhost
  gather_facts: false

  vars:
    plain_password: \"vagrant-libvirt\"

    # Default SHA512 hash
    hash_default: \"{{ plain_password | ansible.builtin.password_hash }}\"

    # Explicit bcrypt hash
    hash_bcrypt: \"{{ plain_password | ansible.builtin.password_hash(hashtype='bcrypt') }}\"

    # Bcrypt hash with fixed salt (for idempotency)
    hash_bcrypt_salted: \"{{ plain_password | ansible.builtin.password_hash(hashtype='bcrypt', salt='abcdefghijklmnopqrstuv') }}\"

  tasks:
    - name: Show default password hash (SHA512)
      ansible.builtin.debug:
        msg: \"Default SHA512 Hash: {{ hash_default }}\"

    - name: Show bcrypt password hash
      ansible.builtin.debug:
        msg: \"Bcrypt Hash: {{ hash_bcrypt }}\"

    - name: Show bcrypt password hash with fixed salt
      ansible.builtin.debug:
        msg: \"Bcrypt Hash (with salt): {{ hash_bcrypt_salted }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.min
    set output_file "ansible_min_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.min filter
  hosts: localhost
  gather_facts: false

  vars:
    numbers: [10, 5, 23, 7, 1, 99, 3]
    letters: ['d', 'a', 'z', 'b', 'c']

  tasks:
    - name: Show smallest number
      ansible.builtin.debug:
        msg: \"Smallest number: {{ numbers | ansible.builtin.min }}\"

    - name: Show smallest letter (lexicographically)
      ansible.builtin.debug:
        msg: \"Smallest letter: {{ letters | ansible.builtin.min }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.list
    set output_file "ansible_list_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.list filter
  hosts: localhost
  gather_facts: false

  vars:
    single_value: hello
    tuple_value: [1, 2]

  tasks:
    - name: Convert single value to list
      ansible.builtin.debug:
        msg: \"List from single value: {{ single_value | ansible.builtin.list }}\"

    - name: Convert tuple to list (idempotent)
      ansible.builtin.debug:
        msg: \"List from tuple: {{ tuple_value | ansible.builtin.list }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.from_yaml_all
    set output_file "ansible_from_yaml_all_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.from_yaml_all filter
  hosts: localhost
  gather_facts: false

  vars:
    multi_yaml: |
      ---
      a: true
      b: 54
      c:
        - 1
        - 2
        - 3
      ---
      x: 1
      y: hello

  tasks:
    - name: Parse multiple YAML documents
      ansible.builtin.debug:
        msg: \"Parsed YAML documents: {{ multi_yaml | ansible.builtin.from_yaml_all }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.length
    set output_file "ansible_length_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.length filter
  hosts: localhost
  gather_facts: false

  vars:
    my_list:
      - apple
      - banana
      - cherry
      - date

  tasks:
    - name: Show the number of items in the list
      ansible.builtin.debug:
        msg: \"The list has {{ my_list | ansible.builtin.length }} items\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.normpath
    set output_file "ansible_normpath_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.normpath filter
  hosts: localhost
  gather_facts: false

  vars:
    my_path: '/foo//bar/../baz/./'

  tasks:
    - name: Show normalized path
      ansible.builtin.debug:
        msg: \"Normalized path: {{ my_path | ansible.builtin.normpath }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.human_readable
    set output_file "ansible_human_readable_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.human_readable filter
  hosts: localhost
  gather_facts: false

  vars:
    byte_value: 1232345345
    bit_value: 1232345345

  tasks:
    - name: Show human-readable size in bytes
      ansible.builtin.debug:
        msg: \"Bytes: {{ byte_value | ansible.builtin.human_readable }}\"

    - name: Show human-readable size in bits
      ansible.builtin.debug:
        msg: \"Bits: {{ bit_value | ansible.builtin.human_readable(true) }}\"

    - name: Force output in megabytes
      ansible.builtin.debug:
        msg: \"In MB: {{ byte_value | ansible.builtin.human_readable(unit='M') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.groupby
    set output_file "ansible_groupby_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.groupby filter
  hosts: localhost
  gather_facts: false

  vars:
    users:
      - name: Alice
        role: admin
      - name: Bob
        role: user
      - name: Carol
        role: admin
      - name: Dave
        role: user

  tasks:
    - name: Group users by role
      ansible.builtin.debug:
        msg: \"Grouped users: {{ users | ansible.builtin.groupby('role') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.path_join
    set output_file "ansible_path_join_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.path_join filter
  hosts: localhost
  gather_facts: false

  vars:
    base_dir: /etc
    subdir: app
    filename: config.yaml

  tasks:
    - name: Join path components
      ansible.builtin.debug:
        msg: \"Full path: {{ (base_dir, subdir, filename) | ansible.builtin.path_join }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

function ansible.builtin.permutations
    set output_file "ansible_permutations_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.permutations filter
  hosts: localhost
  gather_facts: false

  vars:
    mylist: [1, 2, 3]
    size: 2

  tasks:
    - name: Show all permutations of size 2
      ansible.builtin.debug:
        msg: \"Permutations: {{ mylist | ansible.builtin.permutations(size) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.realpath
    set output_file "ansible_realpath_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.realpath filter
  hosts: localhost
  gather_facts: false

  vars:
    mypath: /usr/bin/python3  # or any symlink path

  tasks:
    - name: Show real path of a symlink
      ansible.builtin.debug:
        msg: \"Real path: {{ mypath | ansible.builtin.realpath }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.symmetric_difference
    set output_file "ansible_symmetric_difference_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.symmetric_difference filter
  hosts: localhost
  gather_facts: false

  vars:
    list1: [1, 2, 5, 1, 3, 4, 10]
    list2: [1, 2, 3, 4, 5, 11, 99]

  tasks:
    - name: Show unique elements in each list
      ansible.builtin.debug:
        msg: \"Symmetric difference: {{ list1 | ansible.builtin.symmetric_difference(list2) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.ternary
    set output_file "ansible_ternary_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.ternary filter
  hosts: localhost
  gather_facts: false

  vars:
    my_number: 7

  tasks:
    - name: Set mode based on number
      ansible.builtin.debug:
        msg: \"Mode is {{ (my_number > 10) | ansible.builtin.ternary('high', 'low') }}\"

    - name: Choose service manager based on system
      ansible.builtin.debug:
        msg: \"Service module to use: {{ (ansible_service_mgr == 'upstart') | ansible.builtin.ternary('service', 'systemd') }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end


function ansible.builtin.rejectattr
    set output_file "ansible_rejectattr_example.yml"

    set template_content "---
- name: Demonstrate ansible.builtin.rejectattr filter
  hosts: localhost
  gather_facts: false

  vars:
    users:
      - name: alice
        active: true
      - name: bob
        active: false
      - name: carol
        active: true

  tasks:
    - name: Show only inactive users
      ansible.builtin.debug:
        msg: \"Inactive users: {{ users | ansible.builtin.rejectattr('active', 'equalto', true) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo "$output_file created"
    set_color normal
    cat $output_file
end

