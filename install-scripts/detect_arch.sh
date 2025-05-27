#!/usr/bin/env bash

# Outputs: amd64 or arm64

ARCH="$(uname -m)"
case "$ARCH" in
    x86_64)
        echo "amd64"
        ;;
    aarch64 | arm64)
        echo "arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH" >&2
        exit 1
        ;;
esac
