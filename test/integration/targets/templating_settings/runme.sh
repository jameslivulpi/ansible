#!/usr/bin/env bash

set -eux

ansible-playbook test_templating_settings.yml -i ../../inventory -v "$@"
[ "$(ansible-playbook dont_warn_register.yml -i ../../inventory -v "$@" 2>&1| grep -c 'is not templatable, but we found')" == "0" ]

ansible-playbook test_templating_settings.yml -i ../../inventory -v "$@"

ANSIBLE_CONFIG=template_null_representation/tasks/ansible_null_rep.cfg ansible-playbook template_null_representation/tasks/null_rep_empty_string.yml -i ../../inventory -v "$@"
ANSIBLE_CONFIG=template_null_representation/tasks/ansible_null_rep_default.cfg ansible-playbook template_null_representation/tasks/null_rep_default.yml -i ../../inventory -v "$@"
