#!/bin/sh

execServe="/usr/local/bin/mdmdirector"

# Path to the signing certificate or p12 file
if [[ ${CERT_FILE} ]]; then
  execServe="${execServe} -cert ${CERT_FILE}"
fi

# Database connection string - Required
if [[ ${DB_SSL} = true ]]; then
  DB_SSL="enable"
else
  DB_SSL="disable"
fi

if [[ ${DB_HOST} ]] && [[ ${DB_PORT} ]] && [[ ${DB_USER} ]] && [[ ${DB_NAME} ]] && [[ ${DB_PASS} ]] && [[ ${DB_SSL} ]]; then
  execServe="${execServe} -dbconnection host=${DB_HOST} port=${DB_PORT} user=${DB_USER} dbname=${DB_NAME} password=${DB_PASS} sslmode=${DB_SSL}"
else
  /bin/echo "No DB connection set up - Exiting"
  exit 1
fi

# Enable debug mode
if [[ ${DEBUG} = true ]]; then
  execServe="${execServe} -debug"
fi

# Password to decrypt the signing key or p12 file
if [[ ${CERT_PASS} ]] && [[ ${CERT_FILE} ]]; then
  execServe="${execServe} -key-password ${CERT_PASS}"
fi

# Log level
if [[ ${LOGLEVEL} ]]; then
  execServe="${execServe} -loglevel ${LOGLEVEL}"
fi

# MicroMDM Server API Key - Required
if [[ ${API_KEY} ]]; then
  execServe="${execServe} -micromdmapikey ${API_KEY}"
else
  /bin/echo "No MicroMDM API Key Set - Exiting"
  exit 1
fi

# MicroMDM Server URL - Required
if [[ ${MDM_URL} ]]; then
  execServe="${execServe} -micromdmurl ${MDM_URL}"
else
  /bin/echo "No MicroMDM URL Set - Exiting"
  exit 1
fi

# Password used for basic authentication - Required
if [[ ${PASSWORD} ]]; then
  execServe="${execServe} -password ${PASSWORD}"
else
  /bin/echo "No Password Set - Exiting"
  exit 1
fi

# Port number to run mdmdirector on
if [[ ${PORT} ]]; then
  execServe="${execServe} -port ${PORT}"
fi

# Path to the signing private key
if [[ ${CERT_KEY} ]] && [[ ${CERT_FILE} ]]; then
  execServe="${execServe} -private-key ${CERT_KEY}"
fi

# Re-push profiles if the device's build number changes
if [[ ${PUSH_BUILD} = false ]]; then
  execServe="${execServe} -push-new-build ${PUSH_BUILD}"
fi

# Sign profiles prior to sending to MicroMDM
if [[ ${SIGN_PROFILE} = true ]] && [[ ${CERT_FILE} ]]; then
  execServe="${execServe} -sign ${SIGN_PROFILE}"
fi

echo "Starting using: $execServe"

eval $execServe
