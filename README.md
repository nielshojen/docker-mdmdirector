## Usage

MDMDirector is a compiled binary - it has no external dependencies other than a Postgresql database, Redis and optionally a signing certificate for signing profiles. It is configured using flags.

### MicroMDM Setup

You must set the `-command-webhook-url` flag on MicroMDM to be the URL that your MDMDirector instance is served on (with the additon of `/webhook`)

### Flags

- `DEBUG` - Enable debug mode
- `PUSH_NEW_BUILD` - Re-push profiles if the device's build number changes. (default: true)
- `DIRECTOR_PORT` - Port number to run mdmdirector on. (default: 8000)
- `MICRO_URL` - MicroMDM Server URL.
- `MICRO_API_KEY` - MicroMDM Server API Key.
- `SIGN` - Sign profiles prior to sending to MicroMDM. (default: false)
- `SIGNING_PASSWORD` - Password to encrypt/read the signing key(optional) or p12 file.
- `SIGNING_KEY` - Path to the signing private key. Don't use with p12 file.
- `SIGNING_CERT` - Path to the signing certificate or p12 file.
- `DIRECTOR_PASSWORD` - Password used for basic authentication.
- `DB_USER` - The username associated with the Postgres instance.
- `DB_PASS` - The password of the db user account.
- `DB_NAME` - The name of the Postgres database to use.
- `DB_HOST` - The hostname or IP of the Postgres instance.
- `DB_PORT` - The port of the Postgres instance.
- `REDIS_HOST` - Redis hostname. (default: localhost)
- `REDIS_PORT` - Redis port. (default: 6379)
- `REDIS_PASSWORD` - Redis password.
- `DB_SSL` - The SSL Mode to use to connect to Postgres. (default: disable)
- `DB_MAX_CONN` - Maximum number of database connections. (default: 100)
- `LOG_LEVEL` - Log level. One of debug, info, warn, error. (default: warn)
- `ESCROW_URL` - HTTP endpoint to escrow erase and unlock PINs to.
- `CLEAR_DEVICE_ON_ENROLL` - Deletes device profiles and install applications when a device enrolls. (default: false)
- `LOG_FORMAT` - Format to output logs. Can be set to logfmt or json. (default: logfmt)
- `SCEP_CERT_ISSUER` - The issuer of your SCEP certificate. (default: OU=MICROMDM SCEP CA,O=MicroMDM,C=US)
- `SCEP_CERT_MIN_VALIDITY` - The number of days at which the SCEP certificate has remaining before the enrollment profile is re-sent. (default: 180)
- `ENROLLMENT_PROFILE` - Path to enrollment profile.
- `ENROLMENT_PROFILE_SIGNED` - Is the enrollment profile you are providing already signed. (default: false)
- `PROMETHEUS` - Enable Prometheus. (default: false)
