#!/bin/bash
set -e

base="$(dirname "$(readlink -f "$0")")"
for variant in docker git-docker; do
for tag in 1.11 1.12 17 18 18.03 18.05 stable latest; do
	mkdir -p "$base/$variant/$tag"
	{
		echo "FROM docker:$tag"
		if [[ -e "$base/Dockerfile.$variant.before" ]]; then
			cat "$base/Dockerfile.$variant.before" 
		fi
		grep -v '^FROM ' "$base/Dockerfile"
		if [[ -e "$base/Dockerfile.$variant.after" ]]; then
			cat "$base/Dockerfile.$variant.after"
		fi
	} > "$base/$variant/$tag/Dockerfile"
done
done
