# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

include:
  - {{ sls_service_clean }}

keepalived-config-clean-file-absent:
  file.absent:
    - name: {{ keepalived.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
