function community.crypto.acme_certificate
    set output_file "community.crypto.acme_certificate.yml"

    set template_content "---
### Example with HTTP challenge ###

- name: Create a challenge for sample.com using a account key from a variable.
  community.crypto.acme_certificate:
    account_key_content: \"{{ account_private_key }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
    dest: /etc/httpd/ssl/sample.com.crt
    modify_account: false
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key from Hashi Vault.
  community.crypto.acme_certificate:
    account_key_content: >-
      {{ lookup('community.hashi_vault.hashi_vault', 'secret=secret/account_private_key:value') }}
    csr: /etc/pki/cert/csr/sample.com.csr
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    modify_account: false
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key file.
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    csr_content: \"{{ lookup('file', '/etc/pki/cert/csr/sample.com.csr') }}\"
    dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    modify_account: false
  register: sample_com_challenge

- name: Let the challenge be validated and retrieve the cert and intermediate certificate
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt
    data: \"{{ sample_com_challenge }}\"
    modify_account: false

### Example with DNS challenge against production ACME server ###

- name: Create a challenge for sample.com using a account key file.
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    account_email: myself@sample.com
    src: /etc/pki/cert/csr/sample.com.csr
    cert: /etc/httpd/ssl/sample.com.crt
    challenge: dns-01
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    remaining_days: 60
    modify_account: false
  register: sample_com_challenge

- name: Let the challenge be validated and retrieve the cert and intermediate certificate
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    account_email: myself@sample.com
    src: /etc/pki/cert/csr/sample.com.csr
    cert: /etc/httpd/ssl/sample.com.crt
    fullchain: /etc/httpd/ssl/sample.com-fullchain.crt
    chain: /etc/httpd/ssl/sample.com-intermediate.crt
    challenge: dns-01
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    remaining_days: 60
    data: \"{{ sample_com_challenge }}\"
    modify_account: false
  when: sample_com_challenge is changed

- name: Let the challenge be validated and retrieve the cert and intermediate certificate
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    account_email: myself@sample.com
    src: /etc/pki/cert/csr/sample.com.csr
    cert: /etc/httpd/ssl/sample.com.crt
    fullchain: /etc/httpd/ssl/sample.com-fullchain.crt
    chain: /etc/httpd/ssl/sample.com-intermediate.crt
    challenge: tls-alpn-01
    remaining_days: 60
    data: \"{{ sample_com_challenge }}\"
    acme_directory: https://acme-v02.api.letsencrypt.org/directory
    select_chain:
      - test_certificates: last
        issuer:
          CN: DST Root CA X3
          O: Digital Signature Trust Co.
    modify_account: false
  when: sample_com_challenge is changed
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_account
    set output_file "community.crypto.acme_account.yml"

    set template_content "---
- name: Make sure account exists and has given contacts. We agree to TOS.
  community.crypto.acme_account:
    account_key_src: /etc/pki/cert/private/account.key
    state: present
    terms_agreed: true
    contact:
      - mailto:me@example.com
      - mailto:myself@example.org

- name: Make sure account has given email address. Do not create account if it does not exist
  community.crypto.acme_account:
    account_key_src: /etc/pki/cert/private/account.key
    state: present
    allow_creation: false
    contact:
      - mailto:me@example.com

- name: Change account's key to the one stored in the variable new_account_key
  community.crypto.acme_account:
    account_key_src: /etc/pki/cert/private/account.key
    new_account_key_content: '{{ new_account_key }}'
    state: changed_key

- name: Delete account (we have to use the new key)
  community.crypto.acme_account:
    account_key_content: '{{ new_account_key }}'
    state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_account_info
    set output_file "community.crypto.acme_account_info.yml"

    set template_content "---
- name: Check whether an account with the given account key exists
  community.crypto.acme_account_info:
    account_key_src: /etc/pki/cert/private/account.key
  register: account_data

- name: Verify that account exists
  ansible.builtin.assert:
    that:
      - account_data.exists

- name: Print account URI
  ansible.builtin.debug:
    var: account_data.account_uri

- name: Print account contacts
  ansible.builtin.debug:
    var: account_data.account.contact

- name: Check whether the account exists and is accessible with the given account key
  community.crypto.acme_account_info:
    account_key_content: \"{{ acme_account_key }}\"
    account_uri: \"{{ acme_account_uri }}\"
  register: account_data

- name: Verify that account exists
  ansible.builtin.assert:
    that:
      - account_data.exists

- name: Print account contacts
  ansible.builtin.debug:
    var: account_data.account.contact
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_ari_info
    set output_file "community.crypto.acme_ari_info.yml"

    set template_content "---
- name: Retrieve renewal information for a certificate
  community.crypto.acme_ari_info:
    certificate_path: /etc/httpd/ssl/sample.com.crt
  register: cert_data

- name: Show the certificate renewal information
  ansible.builtin.debug:
    var: cert_data.renewal_info
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_deactivate_authz
    set output_file "community.crypto.acme_certificate_deactivate_authz.yml"

    set template_content "---
- name: Deactivate all authzs for an order
  community.crypto.acme_certificate_deactivate_authz:
    account_key_content: \"{{ account_private_key }}\"
    order_uri: \"{{ certificate_result.order_uri }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_order
    set output_file "community.crypto.acme_certificate_order.yml"

    set template_content "---
### Example with HTTP-01 challenge ###

- name: Create a challenge for sample.com using a account key from a variable
  community.crypto.acme_certificate_order_create:
    account_key_content: \"{{ account_private_key }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key from Hashi Vault
  community.crypto.acme_certificate_order_create:
    account_key_content: >-
      {{ lookup('community.hashi_vault.hashi_vault', 'secret=secret/account_private_key:value') }}
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key file
  community.crypto.acme_certificate_order_create:
    account_key_src: /etc/pki/cert/private/account.key
    csr_content: \"{{ lookup('file', '/etc/pki/cert/csr/sample.com.csr') }}\"
  register: sample_com_challenge

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: http-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt

### Example with DNS challenge against production ACME server ###

- name: Create a challenge for sample.com using a account key file.
  community.crypto.acme_certificate_order_create:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: dns-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_order_finalize
    set output_file "community.crypto.acme_certificate_order.yml"

    set template_content "---
### Example with HTTP-01 challenge ###

- name: Create a challenge for sample.com using a account key from a variable
  community.crypto.acme_certificate_order_create:
    account_key_content: \"{{ account_private_key }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key from Hashi Vault
  community.crypto.acme_certificate_order_create:
    account_key_content: >-
      {{ lookup('community.hashi_vault.hashi_vault', 'secret=secret/account_private_key:value') }}
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Create a challenge for sample.com using a account key file
  community.crypto.acme_certificate_order_create:
    account_key_src: /etc/pki/cert/private/account.key
    csr_content: \"{{ lookup('file', '/etc/pki/cert/csr/sample.com.csr') }}\"
  register: sample_com_challenge

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: http-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt

### Example with DNS challenge against production ACME server ###

- name: Create a challenge for sample.com using a account key file
  community.crypto.acme_certificate_order_create:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: dns-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_order_info
    set output_file "community.crypto.acme_certificate_order_info.yml"

    set template_content "---
- name: Create a challenge for sample.com using a account key from a variable
  community.crypto.acme_certificate_order_create:
    account_key_content: \"{{ account_private_key }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
  register: order

- name: Obtain information on the order
  community.crypto.acme_certificate_order_info:
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ order.order_uri }}\"
  register: order_info

- name: Show information
  ansible.builtin.debug:
    var: order_info
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_order_full
    set output_file "community.crypto.acme_certificate_order_full.yml"

    set template_content "---
### Example with HTTP-01 challenge ###

- name: Create a challenge for sample.com using a account key from a variable
  community.crypto.acme_certificate_order_create:
    account_key_content: \"{{ account_private_key }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

# Alternative first step:
- name: Create a challenge for sample.com using a account key from Hashi Vault
  community.crypto.acme_certificate_order_create:
    account_key_content: >-
      {{ lookup('community.hashi_vault.hashi_vault', 'secret=secret/account_private_key:value') }}
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

# Alternative first step:
- name: Create a challenge for sample.com using a account key file
  community.crypto.acme_certificate_order_create:
    account_key_src: /etc/pki/cert/private/account.key
    csr_content: \"{{ lookup('file', '/etc/pki/cert/csr/sample.com.csr') }}\"
  register: sample_com_challenge

# Perform the necessary steps to fulfill the challenge. For example:
#
# - name: Copy http-01 challenges
#   ansible.builtin.copy:
#     dest: /var/www/{{ item.identifier }}/{{ item.challenges['http-01'].resource }}
#     content: \"{{ item.challenges['http-01'].resource_value }}\"
#   loop: \"{{ sample_com_challenge.challenge_data }}\"
#   when: \"'http-01' in item.challenges\"

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: http-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt

---
### Example with DNS challenge against production ACME server ###

- name: Create a challenge for sample.com using a account key file.
  community.crypto.acme_certificate_order_create:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
  register: sample_com_challenge

# Perform the necessary steps to fulfill the challenge. For example:
#
# - name: Create DNS records for dns-01 challenges
#   community.aws.route53:
#     zone: sample.com
#     record: \"{{ item.key }}\"
#     type: TXT
#     ttl: 60
#     state: present
#     wait: true
#     # Note: item.value is a list of TXT entries, and route53
#     # requires every entry to be enclosed in quotes
#     value: \"{{ item.value | map('community.dns.quote_txt', always_quote=true) | list }}\"
#   loop: \"{{ sample_com_challenge.challenge_data_dns | dict2items }}\"

- name: Let the challenge be validated
  community.crypto.acme_certificate_order_validate:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    challenge: dns-01

- name: Retrieve the cert and intermediate certificate
  community.crypto.acme_certificate_order_finalize:
    acme_directory: https://acme-v01.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    csr: /etc/pki/cert/csr/sample.com.csr
    order_uri: \"{{ sample_com_challenge.order_uri }}\"
    cert_dest: /etc/httpd/ssl/sample.com.crt
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    chain_dest: /etc/httpd/ssl/sample.com-intermediate.crt
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_renewal_info_example
    set output_file "community.crypto.acme_certificate_renewal_info_example.yml"

    set template_content "---
- name: Retrieve renewal information for a certificate
  community.crypto.acme_certificate_renewal_info:
    certificate_path: /etc/httpd/ssl/sample.com.crt
  register: cert_data

- name: Should the certificate be renewed?
  ansible.builtin.debug:
    var: cert_data.should_renew
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_certificate_revoke_example
    set output_file "community.crypto.acme_certificate_revoke_example.yml"

    set template_content "---
- name: Revoke certificate with account key
  community.crypto.acme_certificate_revoke:
    account_key_src: /etc/pki/cert/private/account.key
    certificate: /etc/httpd/ssl/sample.com.crt

- name: Revoke certificate with certificate's private key
  community.crypto.acme_certificate_revoke:
    private_key_src: /etc/httpd/ssl/sample.com.key
    certificate: /etc/httpd/ssl/sample.com.crt
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_challenge_cert_helper
    set output_file "community.crypto.acme_certificate_tls_alpn_example.yml"

    set template_content "---
- name: Create challenges for a given CRT for sample.com
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    challenge: tls-alpn-01
    csr: /etc/pki/cert/csr/sample.com.csr
    dest: /etc/httpd/ssl/sample.com.crt
    modify_account: false
  register: sample_com_challenge

- name: Create certificates for challenges
  community.crypto.acme_challenge_cert_helper:
    challenge: tls-alpn-01
    challenge_data: \"{{ item.value['tls-alpn-01'] }}\"
    private_key_src: /etc/pki/cert/key/sample.com.key
  loop: \"{{ sample_com_challenge.challenge_data | dictsort }}\"
  register: sample_com_challenge_certs

- name: Install challenge certificates
  # We need to set up HTTPS such that for the domain,
  # regular_certificate is delivered for regular connections,
  # except if ALPN selects the 'acme-tls/1'; then, the
  # challenge_certificate must be delivered.
  # This can for example be achieved with very new versions
  # of NGINX; search for ssl_preread and
  # ssl_preread_alpn_protocols for information on how to
  # route by ALPN protocol.
  ...:
    domain: \"{{ item.domain }}\"
    challenge_certificate: \"{{ item.challenge_certificate }}\"
    regular_certificate: \"{{ item.regular_certificate }}\"
    private_key: /etc/pki/cert/key/sample.com.key
  loop: \"{{ sample_com_challenge_certs.results }}\"

- name: Create certificate for a given CSR for sample.com
  community.crypto.acme_certificate:
    account_key_src: /etc/pki/cert/private/account.key
    challenge: tls-alpn-01
    csr: /etc/pki/cert/csr/sample.com.csr
    dest: /etc/httpd/ssl/sample.com.crt
    data: \"{{ sample_com_challenge }}\"
    modify_account: false
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.acme_inspect
    set output_file "community.crypto.acme_inspect.yml"

    set template_content "---
- name: Get directory
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    method: directory-only
  register: directory

- name: Create an account
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    url: \"{{ directory.newAccount}}\"
    method: post
    content: '{\"termsOfServiceAgreed\":true}'
  register: account_creation
  # account_creation.headers.location contains the account URI
  # if creation was successful

- name: Get account information
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ account_creation.headers.location }}\"
    method: get

- name: Update account contacts
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ account_creation.headers.location }}\"
    method: post
    content: '{{ account_info | to_json }}'
  vars:
    account_info:
      # For valid values, see
      # https://tools.ietf.org/html/rfc8555#section-7.3
      contact:
        - mailto:me@example.com

- name: Create certificate order
  community.crypto.acme_certificate:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    csr: /etc/pki/cert/csr/sample.com.csr
    fullchain_dest: /etc/httpd/ssl/sample.com-fullchain.crt
    challenge: http-01
    modify_account: false
  register: certificate_request

# Assume something went wrong. certificate_request.order_uri contains
# the order URI.

- name: Get order information
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ certificate_request.order_uri }}\"
    method: get
  register: order

- name: Get first authz for order
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ order.output_json.authorizations[0] }}\"
    method: get
  register: authz

- name: Get HTTP-01 challenge for authz
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ authz.output_json.challenges | selectattr('type', 'equalto', 'http-01') }}\"
    method: get
  register: http01challenge

- name: Activate HTTP-01 challenge manually
  community.crypto.acme_inspect:
    acme_directory: https://acme-staging-v02.api.letsencrypt.org/directory
    account_key_src: /etc/pki/cert/private/account.key
    account_uri: \"{{ account_creation.headers.location }}\"
    url: \"{{ http01challenge.url }}\"
    method: post
    content: '{}'
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.certificate_complete_chain
    set output_file "community.crypto.certificate_complete_chain.yml"

    set template_content "---
# Example playbook: community.crypto.certificate_complete_chain

- hosts: localhost
  gather_facts: false
  tasks:

    # Find root certificate from a fullchain file
    - name: Find root certificate from fullchain
      community.crypto.certificate_complete_chain:
        input_chain: \"{{ lookup('ansible.builtin.file', '/etc/ssl/csr/www.ansible.com-fullchain.pem') }}\"
        root_certificates:
          - /etc/ca-certificates/
      register: www_ansible_com_fullchain

    - name: Write root certificate to disk
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com-root.pem
        content: \"{{ www_ansible_com_fullchain.root }}\"

    # Find root certificate with intermediates listed separately
    - name: Find root certificate using separate intermediate certificates
      community.crypto.certificate_complete_chain:
        input_chain: \"{{ lookup('ansible.builtin.file', '/etc/ssl/csr/www.ansible.com.pem') }}\"
        intermediate_certificates:
          - /etc/ssl/csr/www.ansible.com-chain.pem
        root_certificates:
          - /etc/ca-certificates/
      register: www_ansible_com_chain

    - name: Write complete chain to disk (leaf + intermediates + root)
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com-completechain.pem
        content: \"{{ ''.join(www_ansible_com_chain.complete_chain) }}\"

    - name: Write root chain (intermediates + root only)
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com-rootchain.pem
        content: \"{{ ''.join(www_ansible_com_chain.chain) }}\"
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.crypto_info
    set output_file "community.crypto.crypto_info.yml"

    set template_content "---
# Example playbook: community.crypto.crypto_info

- hosts: localhost
  gather_facts: false
  tasks:

    # Retrieve crypto/account information using an account key
    - name: Retrieve information
      community.crypto.crypto_info:
        account_key_src: /etc/pki/cert/private/account.key
      register: crypto_information

    - name: Show retrieved information
      ansible.builtin.debug:
        var: crypto_information
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.get_certificate
    set output_file "community.crypto.get_certificate.yml"

    set template_content "---
# Example playbook: Retrieve certificates with community.crypto.get_certificate

- hosts: localhost
  gather_facts: false
  tasks:

    # Get the cert from an RDP port
    - name: Get the cert from an RDP port
      community.crypto.get_certificate:
        host: \"1.2.3.4\"
        port: 3389
      delegate_to: localhost
      run_once: true
      register: cert

    # Get a cert from an HTTPS port
    - name: Get a cert from an https port
      community.crypto.get_certificate:
        host: \"www.google.com\"
        port: 443
      delegate_to: localhost
      run_once: true
      register: cert

    # Calculate how many days until cert expires
    - name: How many days until cert expires
      ansible.builtin.debug:
        msg: \"cert expires in: {{ expire_days }} days.\"
      vars:
        expire_days: >-
          {{ (
            (cert.not_after | ansible.builtin.to_datetime('%Y%m%d%H%M%SZ')) -
            (ansible_date_time.iso8601 | ansible.builtin.to_datetime('%Y-%m-%dT%H:%M:%SZ'))
          ).days }}

    # Allow legacy insecure renegotiation for a legacy device
    - name: Allow legacy insecure renegotiation to get a cert from a legacy device
      community.crypto.get_certificate:
        host: \"legacy-device.domain.com\"
        port: 443
        ciphers:
          - HIGH
        tls_ctx_options:
          - OP_ALL
          - OP_NO_SSLv3
          - OP_CIPHER_SERVER_PREFERENCE
          - OP_ENABLE_MIDDLEBOX_COMPAT
          - OP_NO_COMPRESSION
          - 4 # OP_LEGACY_SERVER_CONNECT
      delegate_to: localhost
      run_once: true
      register: legacy_cert
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.luks_device
    set output_file "community.crypto.luks_device.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Create LUKS container (remains unchanged if it already exists)
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        keyfile: \"/vault/keyfile\"

    - name: Create LUKS container with a passphrase
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        passphrase: \"foo\"

    - name: Create LUKS container with specific encryption
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        cipher: \"aes\"
        hash: \"sha256\"

    - name: (Create and) open the LUKS container; name it \"mycrypt\"
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"opened\"
        name: \"mycrypt\"
        keyfile: \"/vault/keyfile\"

    - name: Close the existing LUKS container \"mycrypt\"
      community.crypto.luks_device:
        state: \"closed\"
        name: \"mycrypt\"

    - name: Make sure LUKS container exists and is closed
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"closed\"
        keyfile: \"/vault/keyfile\"

    - name: Create container if it does not exist and add new key to it
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        keyfile: \"/vault/keyfile\"
        new_keyfile: \"/vault/keyfile2\"

    - name: Add new key to the LUKS container (container has to exist)
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        keyfile: \"/vault/keyfile\"
        new_keyfile: \"/vault/keyfile2\"

    - name: Add new passphrase to the LUKS container
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        keyfile: \"/vault/keyfile\"
        new_passphrase: \"foo\"

    - name: Remove existing keyfile from the LUKS container
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        remove_keyfile: \"/vault/keyfile2\"

    - name: Remove existing passphrase from the LUKS container
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        remove_passphrase: \"foo\"

    - name: Completely remove the LUKS container and its contents
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"absent\"

    - name: Create a container with label
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        keyfile: \"/vault/keyfile\"
        label: personalLabelName

    - name: Open the LUKS container based on label without device; name it \"mycrypt\"
      community.crypto.luks_device:
        label: \"personalLabelName\"
        state: \"opened\"
        name: \"mycrypt\"
        keyfile: \"/vault/keyfile\"

    - name: Close container based on UUID
      community.crypto.luks_device:
        uuid: 03ecd578-fad4-4e6c-9348-842e3e8fa340
        state: \"closed\"
        name: \"mycrypt\"

    - name: Create a container using luks2 format
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        keyfile: \"/vault/keyfile\"
        type: luks2

    - name: Create a container with key in slot 4
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        state: \"present\"
        keyfile: \"/vault/keyfile\"
        keyslot: 4

    - name: Add a new key in slot 5
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        keyfile: \"/vault/keyfile\"
        new_keyfile: \"/vault/keyfile\"
        new_keyslot: 5

    - name: Remove the key from slot 4 (given keyfile must not be slot 4)
      community.crypto.luks_device:
        device: \"/dev/loop0\"
        keyfile: \"/vault/keyfile\"
        remove_keyslot: 4
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssh_cert
    set output_file "community.crypto.openssh_cert.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSH user certificate that is valid forever and for all users
      community.crypto.openssh_cert:
        type: user
        signing_key: /path/to/private_key
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: always
        valid_to: forever

    - name: Generate an OpenSSH host certificate with valid_from, valid_to and valid_at parameters
      community.crypto.openssh_cert:
        type: host
        signing_key: /path/to/private_key
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: +0s
        valid_to: +32w
        valid_at: +2w
        ignore_timestamps: true

    - name: Generate an OpenSSH host certificate that is valid forever and only for example.com and examplehost
      community.crypto.openssh_cert:
        type: host
        signing_key: /path/to/private_key
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: always
        valid_to: forever
        principals:
          - example.com
          - examplehost

    - name: Generate an OpenSSH host Certificate that is valid from 21.1.2001 to 21.1.2019
      community.crypto.openssh_cert:
        type: host
        signing_key: /path/to/private_key
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: \"2001-01-21\"
        valid_to: \"2019-01-21\"

    - name: Generate an OpenSSH user Certificate with clear and force-command option
      community.crypto.openssh_cert:
        type: user
        signing_key: /path/to/private_key
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: always
        valid_to: forever
        options:
          - \"clear\"
          - \"force-command=/tmp/bla/foo\"

    - name: Generate an OpenSSH user certificate using a PKCS#11 token
      community.crypto.openssh_cert:
        type: user
        signing_key: /path/to/ca_public_key.pub
        pkcs11_provider: libpkcs11.so
        public_key: /path/to/public_key.pub
        path: /path/to/certificate
        valid_from: always
        valid_to: forever
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function community.crypto.openssh_keypair
    set output_file "community.crypto.openssh_keypair.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSH keypair with the default values (4096 bits, rsa)
      community.crypto.openssh_keypair:
        path: /tmp/id_ssh_rsa

    - name: Generate an OpenSSH keypair with the default values (4096 bits, rsa) and encrypted private key
      community.crypto.openssh_keypair:
        path: /tmp/id_ssh_rsa
        passphrase: super_secret_password

    - name: Generate an OpenSSH rsa keypair with a different size (2048 bits)
      community.crypto.openssh_keypair:
        path: /tmp/id_ssh_rsa
        size: 2048

    - name: Force regenerate an OpenSSH keypair if it already exists
      community.crypto.openssh_keypair:
        path: /tmp/id_ssh_rsa
        force: true

    - name: Regenerate SSH keypair only if format or options mismatch
      community.crypto.openssh_keypair:
        path: /home/devops/.ssh/id_ed25519
        type: ed25519
        regenerate: full_idempotence
        private_key_format: ssh

    - name: Generate an OpenSSH keypair with a different algorithm (dsa)
      community.crypto.openssh_keypair:
        path: /tmp/id_ssh_dsa
        type: dsa
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_csr
    set output_file "community.crypto.openssl_csr.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL Certificate Signing Request
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com

    - name: Generate an OpenSSL Certificate Signing Request with an inline key
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_content: \"{{ private_key_content }}\"
        common_name: www.ansible.com

    - name: Generate an OpenSSL Certificate Signing Request with a passphrase protected private key
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        privatekey_passphrase: ansible
        common_name: www.ansible.com

    - name: Generate an OpenSSL Certificate Signing Request with Subject information
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        country_name: FR
        organization_name: Ansible
        email_address: jdoe@ansible.com
        common_name: www.ansible.com

    - name: Generate an OpenSSL Certificate Signing Request with subjectAltName extension
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        subject_alt_name: 'DNS:www.ansible.com,DNS:m.ansible.com'

    - name: Generate an OpenSSL CSR with subjectAltName extension with dynamic list
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        subject_alt_name: \"{{ item.value | map('regex_replace', '^', 'DNS:') | list }}\"
      with_dict:
        dns_server:
          - www.ansible.com
          - m.ansible.com

    - name: Force regenerate an OpenSSL Certificate Signing Request
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        force: true
        common_name: www.ansible.com

    - name: Generate an OpenSSL Certificate Signing Request with special key usages
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com
        key_usage:
          - digitalSignature
          - keyAgreement
        extended_key_usage:
          - clientAuth

    - name: Generate an OpenSSL Certificate Signing Request with OCSP Must Staple
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com
        ocsp_must_staple: true

    - name: Generate an OpenSSL Certificate Signing Request for WinRM Certificate authentication
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/winrm.auth.csr
        privatekey_path: /etc/ssl/private/winrm.auth.pem
        common_name: username
        extended_key_usage:
          - clientAuth
        subject_alt_name: otherName:1.3.6.1.4.1.311.20.2.3;UTF8:username@localhost

    - name: Generate an OpenSSL Certificate Signing Request with a CRL distribution point
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com
        crl_distribution_points:
          - full_name:
              - \"URI:https://ca.example.com/revocations.crl\"
            crl_issuer:
              - \"URI:https://ca.example.com/\"
            reasons:
              - key_compromise
              - ca_compromise
              - cessation_of_operation
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_csr_info
    set output_file "community.crypto.openssl_csr_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL Certificate Signing Request
      community.crypto.openssl_csr:
        path: /etc/ssl/csr/www.ansible.com.csr
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com

    - name: Get information on the CSR
      community.crypto.openssl_csr_info:
        path: /etc/ssl/csr/www.ansible.com.csr
      register: result

    - name: Dump information
      ansible.builtin.debug:
        var: result
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_csr_pipe
    set output_file "community.crypto.openssl_csr_pipe.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL Certificate Signing Request using pipe
      community.crypto.openssl_csr_pipe:
        privatekey_path: /etc/ssl/private/ansible.com.pem
        common_name: www.ansible.com
      register: result

    - name: Print CSR
      ansible.builtin.debug:
        var: result.csr

    - name: Generate an OpenSSL Certificate Signing Request with inline CSR
      community.crypto.openssl_csr:
        content: \"{{ lookup('ansible.builtin.file', '/etc/ssl/csr/www.ansible.com.csr') }}\"
        privatekey_content: \"{{ private_key_content }}\"
        common_name: www.ansible.com
      register: result

    - name: Store CSR
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com.csr
        content: \"{{ result.csr }}\"
      when: result is changed
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

function community.crypto.openssl_privatekey
    set output_file "community.crypto.openssl_privatekey.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL private key with the default values (4096 bits, RSA)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem

    - name: Generate an OpenSSL private key with a passphrase
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem
        passphrase: ansible
        cipher: auto

    - name: Generate an OpenSSL private key with a different size (2048 bits)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem
        size: 2048

    - name: Force regenerate an OpenSSL private key if it already exists
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem
        force: true

    - name: Generate an OpenSSL private key with a different algorithm (DSA)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem
        type: DSA

    - name: Generate an OpenSSL private key with elliptic curve cryptography (ECC)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem
        type: ECC
        curve: secp256r1
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_privatekey_convert
    set output_file "community.crypto.openssl_privatekey_convert.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Convert private key to PKCS8 format with passphrase
      community.crypto.openssl_privatekey_convert:
        src_path: /etc/ssl/private/ansible.com.pem
        dest_path: /etc/ssl/private/ansible.com.key
        dest_passphrase: '{{ private_key_passphrase }}'
        format: pkcs8
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_signature
    set output_file "community.crypto.openssl_signature.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Sign example file
      community.crypto.openssl_signature:
        privatekey_path: private.key
        path: /tmp/example_file
      register: sig

    - name: Verify signature of example file
      community.crypto.openssl_signature_info:
        certificate_path: cert.pem
        path: /tmp/example_file
        signature: \"{{ sig.signature }}\"
      register: verify

    - name: Make sure the signature is valid
      ansible.builtin.assert:
        that:
          - verify.valid
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_signature
    set output_file "community.crypto.openssl_signature.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Sign example file
      community.crypto.openssl_signature:
        privatekey_path: private.key
        path: /tmp/example_file
      register: sig

    - name: Verify signature of example file
      community.crypto.openssl_signature_info:
        certificate_path: cert.pem
        path: /tmp/example_file
        signature: \"{{ sig.signature }}\"
      register: verify

    - name: Make sure the signature is valid
      ansible.builtin.assert:
        that:
          - verify.valid
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_privatekey_info
    set output_file "community.crypto.openssl_privatekey_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL private key with the default values (4096 bits, RSA)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem

    - name: Get information on generated key
      community.crypto.openssl_privatekey_info:
        path: /etc/ssl/private/ansible.com.pem
      register: result

    - name: Dump information
      ansible.builtin.debug:
        var: result
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_privatekey_pipe
    set output_file "community.crypto.openssl_privatekey_pipe.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL private key with the default values (4096 bits, RSA)
      community.crypto.openssl_privatekey_pipe:
      register: output
      no_log: true

    - name: Show generated key
      ansible.builtin.debug:
        msg: \"{{ output.privatekey }}\"
      # DO NOT OUTPUT KEY MATERIAL TO CONSOLE OR LOGS IN PRODUCTION!

    - name: Generate or update a CNCF SOPS encrypted key
      block:
        - name: Update SOPS-encrypted key with the community.sops collection
          community.crypto.openssl_privatekey_pipe:
            content: \"{{ lookup('community.sops.sops', 'private_key.pem.sops') }}\"
            size: 2048
          register: output
          no_log: true

        - name: Update encrypted key when openssl_privatekey_pipe reported a change
          community.sops.sops_encrypt:
            path: private_key.pem.sops
            content_text: \"{{ output.privatekey }}\"
          when: output is changed

      always:
        - name: Make sure that output (which contains the private key) is overwritten
          ansible.builtin.set_fact:
            output: ''
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_publickey
    set output_file "community.crypto.openssl_publickey.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL public key in PEM format
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        privatekey_path: /etc/ssl/private/ansible.com.pem

    - name: Generate an OpenSSL public key in PEM format from an inline key
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        privatekey_content: \"{{ private_key_content }}\"

    - name: Generate an OpenSSL public key in OpenSSH v2 format
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        privatekey_path: /etc/ssl/private/ansible.com.pem
        format: OpenSSH

    - name: Generate an OpenSSL public key with a passphrase protected private key
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        privatekey_path: /etc/ssl/private/ansible.com.pem
        privatekey_passphrase: ansible

    - name: Force regenerate an OpenSSL public key if it already exists
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        privatekey_path: /etc/ssl/private/ansible.com.pem
        force: true

    - name: Remove an OpenSSL public key
      community.crypto.openssl_publickey:
        path: /etc/ssl/public/ansible.com.pem
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_publickey_info
    set output_file "community.crypto.openssl_publickey_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate an OpenSSL private key with the default values (4096 bits, RSA)
      community.crypto.openssl_privatekey:
        path: /etc/ssl/private/ansible.com.pem

    - name: Create public key from private key
      community.crypto.openssl_publickey:
        privatekey_path: /etc/ssl/private/ansible.com.pem
        path: /etc/ssl/ansible.com.pub

    - name: Get information on public key
      community.crypto.openssl_publickey_info:
        path: /etc/ssl/ansible.com.pub
      register: result

    - name: Dump information
      ansible.builtin.debug:
        var: result
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_certificate_info
    set output_file "community.crypto.x509_certificate.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate a Self Signed OpenSSL certificate
      community.crypto.x509_certificate:
        path: /etc/ssl/crt/ansible.com.crt
        privatekey_path: /etc/ssl/private/ansible.com.pem
        csr_path: /etc/ssl/csr/ansible.com.csr
        provider: selfsigned

    - name: Generate an OpenSSL certificate signed with your own CA certificate
      community.crypto.x509_certificate:
        path: /etc/ssl/crt/ansible.com.crt
        csr_path: /etc/ssl/csr/ansible.com.csr
        ownca_path: /etc/ssl/crt/ansible_CA.crt
        ownca_privatekey_path: /etc/ssl/private/ansible_CA.pem
        provider: ownca

    - name: Generate a Let's Encrypt Certificate
      community.crypto.x509_certificate:
        path: /etc/ssl/crt/ansible.com.crt
        csr_path: /etc/ssl/csr/ansible.com.csr
        provider: acme
        acme_accountkey_path: /etc/ssl/private/ansible.com.pem
        acme_challenge_path: /etc/ssl/challenges/ansible.com/

    - name: Force (re-)generate a new Let's Encrypt Certificate
      community.crypto.x509_certificate:
        path: /etc/ssl/crt/ansible.com.crt
        csr_path: /etc/ssl/csr/ansible.com.csr
        provider: acme
        acme_accountkey_path: /etc/ssl/private/ansible.com.pem
        acme_challenge_path: /etc/ssl/challenges/ansible.com/
        force: true

    - name: Get certificate information
      community.crypto.x509_certificate_info:
        path: /etc/ssl/crt/ansible.com.crt
        valid_at:
          one_day_ten_hours: \"+1d10h\"
          fixed_timestamp: 20200331202428Z
          ten_seconds: \"+10\"
      register: result

    - name: Get CSR information
      community.crypto.openssl_csr_info:
        path: /etc/ssl/csr/ansible.com.csr
      register: result_csr

    - name: Get private key information
      community.crypto.openssl_privatekey_info:
        path: /etc/ssl/csr/ansible.com.key
      register: result_privatekey

    - name: Check conditions on certificate, CSR, and private key
      ansible.builtin.assert:
        that:
          - result.public_key == result_privatekey.public_key
          - result.public_key == result_csr.public_key
          - result.subject_ordered == result_csr.subject_ordered
          - result.extensions_by_oid == result_csr.extensions_by_oid
          - \"result.signature_algorithm == 'sha256WithRSAEncryption' or result.signature_algorithm == 'sha512WithRSAEncryption'\"
          - \"result.subject.commonName == 'ansible.com'\"
          - \"result.subject | length == 1\"
          - \"result.issuer.commonName == 'ansible.com'\"
          - \"result.issuer | length == 1\"
          - not result.expired
          - result.version == 3
          - \"'Data Encipherment' in result.key_usage\"
          - \"result.key_usage | length == 1\"
          - \"'DVCS' in result.extended_key_usage\"
          - \"result.extended_key_usage | length == 1\"
          - \"'dns:ansible.com' in result.subject_alt_name\"
          - \"result.subject_alt_name | length == 1\"
          - \"result.not_before == '20190331202428Z'\"
          - \"result.not_after == '20190413202428Z'\"
          - result.valid_at.one_day_ten_hours
          - not result.valid_at.fixed_timestamp
          - result.valid_at.ten_seconds
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_certificate_convert_info
    set output_file "community.crypto.x509_certificate_convert.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Convert PEM X.509 certificate to DER format
      community.crypto.x509_certificate_convert:
        src_path: /etc/ssl/cert/ansible.com.pem
        dest_path: /etc/ssl/cert/ansible.com.der
        format: der
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_certificate_info_fish
    set output_file "community.crypto.x509_certificate_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate a Self Signed OpenSSL certificate
      community.crypto.x509_certificate:
        path: /etc/ssl/crt/ansible.com.crt
        privatekey_path: /etc/ssl/private/ansible.com.pem
        csr_path: /etc/ssl/csr/ansible.com.csr
        provider: selfsigned

    - name: Get information on generated certificate
      community.crypto.x509_certificate_info:
        path: /etc/ssl/crt/ansible.com.crt
      register: result

    - name: Dump information
      ansible.builtin.debug:
        var: result

    - name: Test whether that certificate is valid tomorrow and/or in three weeks
      community.crypto.x509_certificate_info:
        path: /etc/ssl/crt/ansible.com.crt
        valid_at:
          point_1: '+1d'
          point_2: '+3w'
      register: result

    - name: Validate that certificate is valid tomorrow, but not in three weeks
      ansible.builtin.assert:
        that:
          - result.valid_at.point_1
          - not result.valid_at.point_2
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_certificate_pipe_fish
    set output_file "community.crypto.x509_certificate_pipe.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate a Self Signed OpenSSL certificate
      community.crypto.x509_certificate_pipe:
        provider: selfsigned
        privatekey_path: /etc/ssl/private/ansible.com.pem
        csr_path: /etc/ssl/csr/ansible.com.csr
      register: result

    - name: Print the certificate
      ansible.builtin.debug:
        var: result.certificate

    - name: (1/2) Generate an OpenSSL Certificate with the CSR provided inline
      community.crypto.x509_certificate_pipe:
        provider: ownca
        content: \"{{ lookup('ansible.builtin.file', '/etc/ssl/csr/www.ansible.com.crt') }}\"
        csr_content: \"{{ lookup('ansible.builtin.file', '/etc/ssl/csr/www.ansible.com.csr') }}\"
        ownca_cert: /path/to/ca_cert.crt
        ownca_privatekey: /path/to/ca_cert.key
        ownca_privatekey_passphrase: hunter2
      register: result

    - name: (2/2) Store certificate
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com.crt
        content: \"{{ result.certificate }}\"
      delegate_to: localhost
      when: result is changed

    - name: (1/3) Read certificate's contents from remote machine
      ansible.builtin.slurp:
        src: /etc/ssl/csr/www.ansible.com.crt
      register: certificate_content

    - name: (2/3) Generate an OpenSSL Certificate with the CSR provided inline
      community.crypto.x509_certificate_pipe:
        provider: ownca
        content: \"{{ certificate_content.content | b64decode }}\"
        csr_content: \"{{ the_csr }}\"
        ownca_cert: /path/to/ca_cert.crt
        ownca_privatekey: /path/to/ca_cert.key
        ownca_privatekey_passphrase: hunter2
      delegate_to: localhost
      register: result

    - name: (3/3) Store certificate
      ansible.builtin.copy:
        dest: /etc/ssl/csr/www.ansible.com.crt
        content: \"{{ result.certificate }}\"
      when: result is changed
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_crl_fish
    set output_file "community.crypto.x509_crl.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate a CRL
      community.crypto.x509_crl:
        path: /etc/ssl/my-ca.crl
        privatekey_path: /etc/ssl/private/my-ca.pem
        issuer:
          CN: My CA
        last_update: '+0s'
        next_update: '+7d'
        revoked_certificates:
          - serial_number: 1234
            revocation_date: 20190331202428Z
            issuer:
              CN: My CA
          - serial_number: 2345
            revocation_date: 20191013152910Z
            reason: affiliation_changed
            invalidity_date: 20191001000000Z
          - path: /etc/ssl/crt/revoked-cert.pem
            revocation_date: 20191010010203Z
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.x509_crl_info_fish
    set output_file "community.crypto.x509_crl_info.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Get information on CRL
      community.crypto.x509_crl_info:
        path: /etc/ssl/my-ca.crl
      register: result

    - name: Print the information
      ansible.builtin.debug:
        msg: \"{{ result }}\"

    - name: Get information on CRL without list of revoked certificates
      community.crypto.x509_crl_info:
        path: /etc/ssl/very-large.crl
        list_revoked_certificates: false
      register: result
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_pkcs12_fish
    set output_file "community.crypto.openssl_pkcs12.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate PKCS#12 file
      community.crypto.openssl_pkcs12:
        action: export
        path: /opt/certs/ansible.p12
        friendly_name: raclette
        privatekey_path: /opt/certs/keys/key.pem
        certificate_path: /opt/certs/cert.pem
        other_certificates: /opt/certs/ca.pem
        state: present

    - name: Generate PKCS#12 file with inline key and multiple other certificates
      community.crypto.openssl_pkcs12:
        action: export
        path: /opt/certs/ansible.p12
        friendly_name: raclette
        privatekey_content: '{{ private_key_contents }}'
        certificate_path: /opt/certs/cert.pem
        other_certificates_parse_all: true
        other_certificates:
          - /opt/certs/ca_bundle.pem
          - /opt/certs/intermediate.pem
        state: present

    - name: Change PKCS#12 file permission
      community.crypto.openssl_pkcs12:
        action: export
        path: /opt/certs/ansible.p12
        friendly_name: raclette
        privatekey_path: /opt/certs/keys/key.pem
        certificate_path: /opt/certs/cert.pem
        other_certificates: /opt/certs/ca.pem
        state: present
        mode: '0600'

    - name: Regen PKCS#12 file
      community.crypto.openssl_pkcs12:
        action: export
        src: /opt/certs/ansible.p12
        path: /opt/certs/ansible.p12
        friendly_name: raclette
        privatekey_path: /opt/certs/keys/key.pem
        certificate_path: /opt/certs/cert.pem
        other_certificates: /opt/certs/ca.pem
        state: present
        mode: '0600'
        force: true

    - name: Dump/Parse PKCS#12 file
      community.crypto.openssl_pkcs12:
        action: parse
        src: /opt/certs/ansible.p12
        path: /opt/certs/ansible.pem
        state: present

    - name: Remove PKCS#12 file
      community.crypto.openssl_pkcs12:
        path: /opt/certs/ansible.p12
        state: absent
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end


function community.crypto.openssl_dhparam_fish
    set output_file "community.crypto.openssl_dhparam.yml"

    set template_content "---
- hosts: localhost
  gather_facts: false
  tasks:

    - name: Generate Diffie-Hellman parameters with the default size (4096 bits)
      community.crypto.openssl_dhparam:
        path: /etc/ssl/dhparams.pem

    - name: Generate DH Parameters with a different size (2048 bits)
      community.crypto.openssl_dhparam:
        path: /etc/ssl/dhparams.pem
        size: 2048

    - name: Force regenerate DH parameters if they already exist
      community.crypto.openssl_dhparam:
        path: /etc/ssl/dhparams.pem
        force: true
"

    echo $template_content > $output_file
    set_color FFAD8D
    echo -n "$output_file created"
    set_color normal
    echo ''
    cat $output_file
end

