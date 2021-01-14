# OpenSSH Secure File Copy by Utahcon

scp copies files between hosts on a network.  It uses ssh for data transfer, and uses the same authentication and provides the same security as ssh.

## Usage

Store your username and password in your repos secrets vault, more info on this [here](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets).

From within your GitHub Workflow simply add a job/step to deploy your codebase to the appropriate server:

```
jobs:
  deploy:
    - uses: utahcon/action-scp@v1.1.3
      with:
        server: example.org
        username: ${{ secrets.SCP_USERNAME }}
        private-key: ${{ secrets.SCP_PRIVATE_KEY }}
        source: "public/*"
        destination: "/var/www/public"
        recursive: true
```

### Inputs

The following are the inputs expected/accepted when using `action-scp`

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| server |  Specifies the remote host to send files to | true | |
| port | Specifies the remote hosts port for sending files to | false | 22 |
| username | Username for authentication with server (use GitHub Secrets only) | true | |
| password | Password for authentication with server (use GitHub Secrets only) | false | |
| private-key | Private key used for key-based authentication with server (use GitHub Secrets only) | false | |
| source | Path you wisht to send to remote host. | true | `.` |
| destination | Path on remote host to store files | true | `.` |
| recursive | Flag to denote recrusive copy of directory. Note that scp follows symbolic links encountered in the tree traversal | false | |
| jumps | Connect to the target host by first making an scp connection to the jump host described by destination and then establishing a TCP forwarding to the ultimate destination from there.  Multiple jump hops may be specified separated by comma characters. | false | |
| ssh-options | Can be used to pass options to ssh in the format used in ssh_config.  This is useful for specifying options for which there is no separate scp command-line flag.  For full details of the options listed below, and their possible values, see ssh_config. Comma separated. <br><br>&nbsp;&nbsp;AddressFamily<br>&nbsp;&nbsp;BatchMode<br>&nbsp;&nbsp;BindAddress<br>&nbsp;&nbsp;BindInterface<br>&nbsp;&nbsp;CanonicalDomains<br>&nbsp;&nbsp;CanonicalizeFallbackLocal<br>&nbsp;&nbsp;CanonicalizeHostname<br>&nbsp;&nbsp;CanonicalizeMaxDots<br>&nbsp;&nbsp;CanonicalizePermittedCNAMEs<br>&nbsp;&nbsp;CASignatureAlgorithms<br>&nbsp;&nbsp;CertificateFile<br>&nbsp;&nbsp;ChallengeResponseAuthentication<br>&nbsp;&nbsp;CheckHostIP<br>&nbsp;&nbsp;Ciphers<br>&nbsp;&nbsp;Compression<br>&nbsp;&nbsp;ConnectionAttempts<br>&nbsp;&nbsp;ConnectTimeout<br>&nbsp;&nbsp;ControlMaster<br>&nbsp;&nbsp;ControlPath<br>&nbsp;&nbsp;ControlPersist<br>&nbsp;&nbsp;GlobalKnownHostsFile<br>&nbsp;&nbsp;GSSAPIAuthentication<br>&nbsp;&nbsp;GSSAPIDelegateCredentials<br>&nbsp;&nbsp;HashKnownHosts<br>&nbsp;&nbsp;Host<br>&nbsp;&nbsp;HostbasedAuthentication<br>&nbsp;&nbsp;HostbasedKeyTypes<br>&nbsp;&nbsp;HostKeyAlgorithms<br>&nbsp;&nbsp;HostKeyAlias<br>&nbsp;&nbsp;Hostname<br>&nbsp;&nbsp;IdentitiesOnly<br>&nbsp;&nbsp;IdentityAgent<br>&nbsp;&nbsp;IdentityFile<br>&nbsp;&nbsp;IPQoS<br>&nbsp;&nbsp;KbdInteractiveAuthentication<br>&nbsp;&nbsp;KbdInteractiveDevices<br>&nbsp;&nbsp;KexAlgorithms<br>&nbsp;&nbsp;LogLevel<br>&nbsp;&nbsp;MACs<br>&nbsp;&nbsp;NoHostAuthenticationForLocalhost<br>&nbsp;&nbsp;NumberOfPasswordPrompts<br>&nbsp;&nbsp;PasswordAuthentication<br>&nbsp;&nbsp;PKCS11Provider<br>&nbsp;&nbsp;Port<br>&nbsp;&nbsp;PreferredAuthentications<br>&nbsp;&nbsp;ProxyCommand<br>&nbsp;&nbsp;ProxyJump<br>&nbsp;&nbsp;PubkeyAcceptedKeyTypes<br>&nbsp;&nbsp;PubkeyAuthentication<br>&nbsp;&nbsp;RekeyLimit<br>&nbsp;&nbsp;SendEnv<br>&nbsp;&nbsp;ServerAliveInterval<br>&nbsp;&nbsp;ServerAliveCountMax<br>&nbsp;&nbsp;SetEnv<br>&nbsp;&nbsp;StrictHostKeyChecking<br>&nbsp;&nbsp;TCPKeepAlive<br>&nbsp;&nbsp;UpdateHostKeys<br>&nbsp;&nbsp;User<br>&nbsp;&nbsp;UserKnownHostsFile<br>&nbsp;&nbsp;VerifyHostKeyDNS| false | |

