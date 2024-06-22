 #!/bin/bash

# Check if the token parameter is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <github_personal_access_token>"
  exit 1
fi

# Variables
TOKEN=$1
REPO="agussmkertjhaan/TA"
TITLE="Request for Access Code"
BODY="Dear Mr. Agus,\n\nI would like to request access to the code. Please provide the necessary access details.\n\nThank you.\n\nBest regards,\n[Your Name]"

# Create the JSON payload
PAYLOAD=$(cat <<EOF
{
  "title": "$TITLE",
  "body": "$BODY"
}
EOF
)

# Make the API request to create an issue
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" -X POST \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/$REPO/issues \
    -d "$PAYLOAD")

# Check the status code of the response
if [ "$RESPONSE" -eq 201 ]; then
    echo "Issue has been successfully created in the repository $REPO."
else
    echo "Failed to create issue in the repository $REPO. HTTP status code: $RESPONSE"
fi
