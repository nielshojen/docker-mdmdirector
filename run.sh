#!/bin/sh

execServe="/usr/local/bin/mdmdirector"

# Path to the signing certificate or p12 file
#if [[ ${CERT_FILE} ]]; then
#  execServe="${execServe} -cert=${CERT_FILE}"
#fi

# Database connection string - Required
if [[ "${DB_SSL}" = "true" ]]; then
  DB_SSL="enable"
else
  DB_SSL="disable"
fi

if [[ ${DB_HOST} ]] && [[ ${DB_PORT} ]] && [[ ${DB_USER} ]] && [[ ${DB_NAME} ]] && [[ ${DB_PASS} ]] && [[ ${DB_SSL} ]]; then
  execServe="${execServe} -db-host=${DB_HOST} -db-port=${DB_PORT} -db-username=${DB_USER} -db-name=${DB_NAME} -db-password=${DB_PASS} -db-sslmode=${DB_SSL}"
else
  /bin/echo "No DB connection set up - Exiting"
  exit 1
fi

# Enable debug mode
#if [[ "${DEBUG}" = "true" ]]; then
#  execServe="${execServe} -debug"
#fi

# Password to decrypt the signing key or p12 file
#if [[ ${CERT_PASS} ]] && [[ ${CERT_FILE} ]]; then
#  execServe="${execServe} -key-password=${CERT_PASS}"
#fi

# Log level
#if [[ ${LOGLEVEL} ]]; then
#  execServe="${execServe} -loglevel=${LOGLEVEL}"
#fi

# MicroMDM Server API Key - Required
if [[ ! ${MICRO_API_KEY} ]]; then
#  execServe="${execServe} -micromdmapikey=\"${MICRO_API_KEY}\""
#else
  /bin/echo "No MicroMDM API Key Set - Exiting"
  exit 1
fi

# MicroMDM Server URL - Required
if [[ ! ${MICRO_URL} ]]; then
#  execServe="${execServe} -micromdmurl=\"${MICRO_URL}\""
#else
  /bin/echo "No MicroMDM URL Set - Exiting"
  exit 1
fi

# Password used for basic authentication - Required
if [[ ! ${DIRECTOR_PASSWORD} ]]; then
#  execServe="${execServe} -password=${PASSWORD}"
#else
  /bin/echo "No Password Set - Exiting"
  exit 1
fi

#  HTTP endpoint to escrow erase and unlock PINs to
#if [[ ${ESCROWURL} ]]; then
#  execServe="${execServe} -escrowurl=\"${ESCROWURL}\""
#fi


# Port number to run mdmdirector on
#if [[ ${PORT} ]]; then
#  execServe="${execServe} -port ${PORT}"
#fi

# Path to the signing private key
#if [[ ${CERT_KEY} ]] && [[ ${CERT_FILE} ]]; then
#  execServe="${execServe} -private-key ${CERT_KEY}"
#fi

# Re-push profiles if the device's build number changes
#if [[ "${PUSH_NEW_BUILD}" = "true" ]]; then
#  execServe="${execServe} -push-new-build ${PUSH_NEW_BUILD}"
#fi

# Sign profiles prior to sending to MicroMDM
#if [[ "${SIGN}" = "true" ]] && [[ ${CERT_FILE} ]]; then
#  execServe="${execServe} -sign ${SIGN}"
#fi

echo "Starting using: $execServe"

eval $execServe
