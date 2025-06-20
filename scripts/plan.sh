#!/bin/bash
set -ex
cd env/dev
terraform plan -var-file="dev.auto.tfvars" -out=tfplan
