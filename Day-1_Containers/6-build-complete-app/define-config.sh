#!/bin/bash

# Define the configuration for the frontend applications

cat <<EOF > ./config/frontend-user.json
{
  "apiArticlesEndpoint": "https://8080-${WEB_HOST}/api-article",
  "apiCartEndpoint": "https://8080-${WEB_HOST}/api-cart"
}
EOF

cat <<EOF > ./config/frontend-admin.json
{
  "apiArticlesEndpoint": "https://8080-${WEB_HOST}/api-article"
}
EOF
