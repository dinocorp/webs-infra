#!/usr/bin/env bash

# spot_prices.sh - generate a default map suitable for Terraform vars

set -e -o pipefail

# Set this to whatever you're happy to pay as max spot_price.
# Example: 1.5 if you're happy paying up to 1.5x on demand price which can help with small price spikes.
# Note that the default spot_pric limit AWS sets is the same as the on demand price.
# If you specify above on demand AWS will silently set the spot_price to the on-demand price.
multiple=1
aws_region="eu-west-1"

json_data=$(curl -s --fail https://raw.githubusercontent.com/powdahound/ec2instances.info/master/www/instances.json)

# Build the map
echo
echo "variable \"spot_prices\" {"
echo "  type = map"
echo "  default = {"
echo $json_data | jq -r '.[] |
	.instance_type as $it |
	.pricing | to_entries[] |
	select(.key == "'${aws_region}'") |
		"    \"" + $it + "\" = \"" +
        (.value.linux.ondemand | tonumber * '${multiple}' | tostring | .[0:5]) + "\""' | sort
echo "  }"
echo "}"
