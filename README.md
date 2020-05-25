# Shark

Authentication application for internal services

## Introduction

The first step during the development of a project where security is highly
important would be to brainstorm ideas with other team members and to security
experts what they have to share on the topic. Authentication system is
usually developed at the beginning of a project and as is worth a greater
resource investment.

## Project Setup

The rails application has been generated using the following command:

```bash
rails new shark --api --skip-action-mailer --skip-active-record \
  --skip-action-text --skip-action-mailbox --skip-active-storage \
  --skip-action-cable --skip-sprockets --skip-spring --skip-listen \
  --skip-javascript --skip-turbolinks --skip-bootsnap --skip-webpack-install
```

## Managing Secrets

The master.key file is included in this repository as an affordance.
Normally it shouldn't be part of the git repository and should be uploaded
separately.

## Operations

The following improvements should be made before deploying the application:

- `rack-attack` for throttling and banning as part of application logic
- SSL certificate for HTTPS
- Nginx in front coupled with fail2ban to mitigate denial-of-service attacks
  and brute-force attacks

## Authentication

### Password Encryption

Password is hashed using `Bcrypt`, however `argon2id` should be used if
a security expert is available to properly configure it, based on
[OWASP Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#introduction)
guidelines.

Rails `has_secure_password` is not used to allow the addition of a
[pepper](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#peppering)
after hashing is performed.
The pepper is added by encrypting the hash with
[AES with CBC mode](https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html#cipher-modes).

### Successful Authentication

A successful authentication results in a response with `{ "success": true }`
inside the body.
This is not very useful and should be expanded to return some kind of token to
authorize following requests.

## Environment Variables

To run the application without docker, it's necessary to set the following
environment variables:

- `REDIS_URL`
