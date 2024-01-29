#!/bin/bash

# Define the configuration for the frontend applications

cat <<EOF > ./config/front-user.json
{
  "apiArticlesEndpoint": "https://8080-${WEB_HOST}/api-article/article",
  "apiCartEndpoint": "https://8080-${WEB_HOST}/api-cart/cart"
}
EOF

cat <<EOF > ./config/front-admin.json
{
  "apiArticlesEndpoint": "https://8080-${WEB_HOST}/api-article/article"
}
EOF
