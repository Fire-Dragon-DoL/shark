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

## Getting Started

### Requirements

- ruby
- bundler
- redis

### Environment Variables

To run the application without docker, it's necessary to set the following
environment variables:

- `REDIS_URL`

### Optional Dependencies

If the following dependencies are present on the machine, it's possible to
execute the interactive tests as well as the automated ones:

- bash
- curl
- docker
- docker-compose

### Testing

All the following commands should be executed from the root directory of the
project.

#### Automated

To execute the automated test suite it's sufficient to run the following
command:

```bash
./test.sh
```

It will start a redis instance on port 6400 through docker and execute
`bundle exec rails test`.

#### Interactive

Interactive tests are meant to be executed by an operator who can review the
output of such commands to verify the success or failure of the operations.

It's sufficient to execute one of the following commands:

- `./interactive/sign_up_and_sign_in.sh`
- `./interactive/sign_up_duplicate.sh` (Sign up twice)
- `./interactive/sign_up_invalid.sh` (Sign up with invalid parameters)

Redis and the rails application will be started through docker (port 3000).
`curl` will be executed to perform HTTP requests and verify the success of
the operations.

## Decisions

### Managing Secrets

The master.key file is included in this repository as an affordance.
Normally it shouldn't be part of the git repository and should be uploaded
separately.

### Documentation

Documentation has been ignored for this take-home assignement

### Conventions

- The top-level namespace is reserved to Rails
- The business logic is located into `lib/domain`, under `Domain` namespace
- Rubocop style-guide is being followed, the configuration can be found
  in the root directory of the project

### API Versioning

URLs for the API endpoint are prefixed with API version number. This allows
maintaining different endpoints when the API changes without breaking existing
clients.

### Samples

Sample modules are considered part of production code. Not only can be used in
testing environment, but are also useful in exploratory testing, exploratory
usage (irb), staging servers, development.

### Authentication

#### Password Encryption

Password is hashed using `Bcrypt`, however `argon2id` should be used if
a security expert is available to properly configure it, based on
[OWASP Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#introduction)
guidelines.

Rails `has_secure_password` is not used to allow the addition of a
[pepper](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#peppering)
after hashing is performed.
The pepper is added by encrypting the hash with
[AES with CBC mode](https://cheatsheetseries.owasp.org/cheatsheets/Cryptographic_Storage_Cheat_Sheet.html#cipher-modes).

#### Successful Authentication

A successful authentication results in a response with a token that can be
used to authorize following requests.

This part of the code should be expanded:
- Possibility to use JWT
- Token should be stored and decide if multiple tokens are allowed to support
  multiple devices being signed in at the same time
- Some form of code to blacklist JWT that have been compromised

## Further Development

The following improvements should be made before deploying the application:

- `rack-attack` for throttling and banning as part of application logic
- SSL certificate for HTTPS
- Nginx in front coupled with fail2ban to mitigate denial-of-service attacks
  and brute-force attacks

The `Password` and `Username` module should be namespaced under the
`Domain::User` module instead of being directly inside `Domain`.
