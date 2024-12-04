#!/bin/bash
# Author: Nick Wlodychak
# Date: 12/04/2024
# Brief script to query the Perplexity API

# PerplexityAPO - Add PPX API key here
PERPLEXITY_API_KEY=$2

user_input=$(jq -aRs . <<< "$1")

# Response Task
# Change the model to any of the options
# Change the content to intializtion prompt
response=$(curl -X POST \
     --url https://api.perplexity.ai/chat/completions \
     --header 'accept: application/json' \
     --header 'content-type: application/json' \
     --header "Authorization: Bearer ${PERPLEXITY_API_KEY}" \
     --data "{
        \"model\": \"llama-3.1-sonar-small-128k-online\",
        \"stream\": false,
        \"max_tokens\": 1024,
        \"frequency_penalty\": 1,
        \"temperature\": 0.0,
        \"messages\": [
            {
                \"role\": \"system\",
                \"content\": \"Be precise and concise in your responses..\"
            },
            {
                \"role\": \"user\",
                \"content\": $user_input
            }
        ]
    }")

# Extract the message content using jq and echo it
output=$(echo $response | jq -r '.choices[0].message.content')

echo $output
