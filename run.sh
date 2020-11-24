#!/bin/sh

execServe="/usr/local/bin/mdmdirector"

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

# MicroMDM Server API Key - Required
if [[ ! ${MICRO_API_KEY} ]]; then
  /bin/echo "No MicroMDM API Key Set - Exiting"
  exit 1
fi

# MicroMDM Server URL - Required
if [[ ! ${MICRO_URL} ]]; then
  /bin/echo "No MicroMDM URL Set - Exiting"
  exit 1
fi

# Password used for basic authentication - Required
if [[ ! ${DIRECTOR_PASSWORD} ]]; then
  /bin/echo "No Password Set - Exiting"
  exit 1
fi

echo "Starting using: $execServe"

eval $execServe
