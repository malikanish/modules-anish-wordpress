#!/bin/bash
set -ex
cd env/dev
terraform destroy -var-file="dev.auto.tfvars" -auto-approve