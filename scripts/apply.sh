#!/bin/bash
set -e
cd env/dev
terraform apply -auto-approve tfplan
