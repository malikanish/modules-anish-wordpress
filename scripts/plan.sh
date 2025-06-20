#!/bin/bash
set -e
cd env/dev
terraform plan -out=finalplan
