# generate server and client certificate using openssl #

```cmd

    VAULTFQDN=vault.testdomain.dom
    USERNAME=vagrant


    cat << EOF > caconf.certAuth.conf
    [ req ]
    # Options for the req tool (man req).
    default_bits        = 4096
    distinguished_name  = req_distinguished_name
    string_mask         = utf8only
    # SHA-1 is deprecated, please use SHA-2 or greater instead.
    default_md          = sha384
    # Extension to add when the -x509 option is used.
    x509_extensions     = v3_ca
    [ req_distinguished_name ]
    countryName                     = IN
    stateOrProvinceName             = GJ
    localityName                    = Locality Name
    0.organizationName              = ROI
    organizationalUnitName          = IT
    commonName                      = Common Name
    emailAddress                    = Vijayendra_rathod@live.com
    # Optionally, specify some defaults.
    countryName_default             = India
    stateOrProvinceName_default     = AH
    localityName_default            = Ahmedabad
    0.organizationName_default      = HashiCorp
    organizationalUnitName_default  = Test
    emailAddress_default            = vijayendra_rathid@live.com
    [ v3_ca ]
    subjectKeyIdentifier = hash
    authorityKeyIdentifier = keyid:always,issuer
    basicConstraints = critical, CA:true
    keyUsage = critical, digitalSignature, cRLSign, keyCertSign
    EOF


    openssl genrsa -out certAuth.key 2048

    openssl req -x509 -new -nodes -key certAuth.key -sha256 -days 2014 -out certAuth.pem -config caconf.certAuth.conf -extensions v3_ca -subj "/CN=vaultca"

    openssl req -new -newkey rsa:2048 -nodes -keyout vault.key -out vault.csr -subj "/CN=$VAULTFQDN"

    cat << EOF > caconf.vault.conf
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = localhost
    IP.1 = 127.0.0.1
    DNS.2 = vault.testdomain.dom
    IP.2 = 192.168.50.102
    EOF

    openssl x509 -req -in vault.csr -CA certAuth.pem -CAkey certAuth.key -CAcreateserial -out vault.crt -days 365 -sha256 -extfile caconf.vault.conf

    openssl req -new -newkey rsa:2048 -nodes -keyout user.key -out user.csr -subj "/CN=$USERNAME"

    cat << EOF > caconf.user.conf
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = $USERNAME
    EOF

    openssl x509 -req -in user.csr -CA certAuth.pem -CAkey certAuth.key -CAcreateserial -out user.crt -days 365 -sha256 -extfile caconf.user.conf


    sudo sh -c 'echo "127.0.0.1 vault.testdomain.dom >> /etc/hosts'
    sudo sh -c 'echo "192.168.50.102 vault.testdomain.dom >> /etc/hosts'
    sudo mkdir /usr/local/share/ca-certificates/vault/
    sudo cp vault.crt /usr/local/share/ca-certificates/vault/vault.crt
    sudo update-ca-certificates

    openssl req -new -newkey rsa:2048 -nodes -keyout user_app.key -out user_app.csr -subj "/CN=$USERNAME"


    cat << EOF > caconf.user_app.conf
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
    subjectAltName = @alt_names
    [alt_names]
    DNS.1 = localhost
    IP.1 = 127.0.0.1
    DNS.2 = vault.testdomain.dom
    IP.2 = 192.168.50.102
    EOF

    openssl x509 -req -in user_app.csr -CA certAuth.pem -CAkey certAuth.key -CAcreateserial -out user_app.crt -days 365 -sha256 -extfile caconf.user_app.conf
```

## copy generated certificate vault.crt,vault.key,certAuth.pen to /opt/vault/tls ##

sudo chown -R vault:vault /opt/vault/tls/

## configure the environment variable ##

export VAULT_ADDR=<https://vault.testdomain.dom:8200>

## vault.hcl file configuration ##

```hcl

    # HTTPS listener
    listener "tcp" {
    address       = "0.0.0.0:8200"
    tls_cert_file = "/opt/vault/tls/vault.crt"
    tls_key_file  = "/opt/vault/tls/vault.key"
    tls_client_ca_file = "/opt/vault/tls/certAuth.pem"
    tls_disable = false
    tls_require_and_verify_client_cert = false
    }

```

## restart the vault service ##

sudo systemctl restart vault.service

## apply policies ##

:one: vault write auth/cert/certs/app display_name=appcert policies=default,app certificate=@certAuth.pem ttl=3600

:two: vault write auth/cert/certs/web display_name=webcert policies=default,web certificate=@certAuth.pem ttl=3600
