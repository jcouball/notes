# SSL/TLS Certificates

X.509 is an ITU standard defining the format of public key certificates. X.509 are
used in TLS/SSL, which is the basis for HTTPS. An X.509 certificate binds an identity
to a public key using a digital signature. A certificate contains an identity
(hostname, organization, etc.) and a public key (RSA, DSA, ECDSA, ed25519, etc.), and
is either signed by a Certificate Authority or is Self-Signed.

* [Self-Signed Certificates](#self-signed-certificates)
    * [Generate CA](#generate-ca)
    * [Optional Stage: View Certificate's Content](#optional-stage-view-certificates-content)
    * [Generate Certificate](#generate-certificate)
* [Certificate Formats](#certificate-formats)
    * [Convert Certs](#convert-certs)
* [Verify Certificates](#verify-certificates)
* [Install the CA Cert as a trusted root CA](#install-the-ca-cert-as-a-trusted-root-ca)
    * [On Android](#on-android)
    * [On Arch](#on-arch)
    * [On Debian and Derivatives](#on-debian-and-derivatives)
    * [On Fedora](#on-fedora)
    * [On iOS](#on-ios)
    * [On macOS](#on-macos)
    * [On Windows](#on-windows)

## Self-Signed Certificates

### Generate CA

1. Generate RSA

   ```bash
   openssl genrsa -aes256 -out ca-key.pem 4096
   ```

2. Generate a public CA Cert

   ```bash
   openssl req -new -x509 -sha256 -days 365 -key ca-key.pem -out ca.pem
   ```

### Optional Stage: View Certificate's Content

   ```bash
   openssl x509 -in ca.pem -text
   openssl x509 -in ca.pem -purpose -noout -text
   ```

### Generate Certificate

1. Create a RSA key

   ```bash
   openssl genrsa -out cert-key.pem 4096
   ```

2. Create a Certificate Signing Request (CSR)

   ```bash
   openssl req -new -sha256 -subj "/CN=yourcn" -key cert-key.pem -out cert.csr
   ```

3. Create a `extfile` with all the alternative names

   ```bash
   echo "subjectAltName=DNS:your-dns.record,IP:257.10.10.1" >> extfile.cnf
   ```

   ```bash
   # optional
   echo extendedKeyUsage = serverAuth >> extfile.cnf
   ```

4. Create the certificate

   ```bash
   openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial
   ```

## Certificate Formats

X.509 Certificates exist in Base64 Formats **PEM (.pem, .crt, .ca-bundle)**, **PKCS#7
(.p7b, p7s)** and Binary Formats **DER (.der, .cer)**, **PKCS#12 (.pfx, p12)**.

### Convert Certs

COMMAND | CONVERSION
---|---
`openssl x509 -outform der -in cert.pem -out cert.der` | PEM to DER
`openssl x509 -inform der -in cert.der -out cert.pem` | DER to PEM
`openssl pkcs12 -in cert.pfx -out cert.pem -nodes` | PFX to PEM

## Verify Certificates

`openssl verify -CAfile ca.pem -verbose cert.pem`

## Install the CA Cert as a trusted root CA

### On Android

The exact steps vary device-to-device, but here is a generalised guide:

1. Open Phone Settings
2. Locate `Encryption and Credentials` section. It is generally found under `Settings
   > Security > Encryption and Credentials`
3. Choose `Install a certificate`
4. Choose `CA Certificate`
5. Locate the certificate file `ca.pem` on your SD Card/Internal Storage using the
   file manager.
6. Select to load it.
7. Done!

### On Arch

System-wide – Arch(p11-kit)
(From arch wiki)

* Run (As root)

```bash
trust anchor --store myCA.crt
```

* The certificate will be written to /etc/ca-certificates/trust-source/myCA.p11-kit
  and the "legacy" directories automatically updated.
* If you get "no configured writable location" or a similar error, import the CA
  manually:
* Copy the certificate to the /etc/ca-certificates/trust-source/anchors directory.
* and then

```bash
update-ca-trust
```

wiki page  [here](https://wiki.archlinux.org/title/User:Grawity/Adding_a_trusted_CA_certificate)

### On Debian and Derivatives

* Move the CA certificate (`ca.pem`) into `/usr/local/share/ca-certificates/ca.crt`.
* Update the Cert Store with:

```bash
sudo update-ca-certificates
```

Refer the documentation [here](https://wiki.debian.org/Self-Signed_Certificate) and
[here.](https://manpages.debian.org/buster/ca-certificates/update-ca-certificates.8.en.html)

### On Fedora

* Move the CA certificate (`ca.pem`) to `/etc/pki/ca-trust/source/anchors/ca.pem` or `/usr/share/pki/ca-trust-source/anchors/ca.pem`
* Now run (with sudo if necessary):

```bash
update-ca-trust
```

Refer the documentation
[here.](https://docs.fedoraproject.org/en-US/quick-docs/using-shared-system-certificates/)

### On iOS

Apple makes this far more difficult than it should be:

1. Send `ca.pem` to the iOS device through iCloud, AirDrop, or a direct download from
   your server.
2. After downloading a dialog will appear on screen telling you that the profile has
   been downloaded.
3. Open the Settings app, and a `Profile Downloaded` item will be at the top. If it
   is not there you may find it in `General → VPN & Device Management`.
4. Click `Install`.
5. The device will ask for your passcode. Enter it.
6. The device will then warn you about the certificate. Click `Install` again.
7. And, as if clicking `Install` twice wasn't enough a confirmation button will
   appear at the bottom of the screen. Click `Install` one last time.
8. Done!

### On macOS

Assuming the path to your generated CA certificate is `~/ca.pem`, run (as root):

```bash
security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ~/ca.pem
```

A dialog box will appear asking for an administrator's username and password. Enter
it, and it will be stored in the system keychain. This can be verified by opening the
`Keychain Access` application (`/Applications/Utilities/Keychain Access.app`). On the
sidebar under `System Keychains` select `System`, and the new certificate should be
listed.

### On Windows

Assuming the path to your generated CA certificate as `C:\ca.pem`, run:

```powershell
Import-Certificate -FilePath "C:\ca.pem" -CertStoreLocation Cert:\LocalMachine\Root
```

* Set `-CertStoreLocation` to `Cert:\CurrentUser\Root` in case you want to trust
  certificates only for the logged in user.

OR

In Command Prompt, run:

```sh
certutil.exe -addstore root C:\ca.pem
```

* `certutil.exe` is a built-in tool (classic `System32` one) and adds a system-wide trust anchor.
