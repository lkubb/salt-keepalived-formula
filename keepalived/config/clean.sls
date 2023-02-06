# vim: ft=sls

{#-
    Removes the configuration of the keepalived service and has a
    dependency on `keepalived.service.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

include:
  - {{ sls_service_clean }}

keepalived configuration is absent:
  file.absent:
    - name: {{ keepalived.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
