# vim: ft=sls

{#-
    Removes the configuration of the keepalived service
    including configured scripts (if SELinux is enabled) and has a
    dependency on `keepalived.service.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

include:
  - {{ sls_service_clean }}

keepalived configuration/scripts are absent:
  file.absent:
    - names:
      - {{ keepalived.lookup.config }}
{%-   for name, contents in keepalived._scripts.items() %}
      - {{ keepalived.lookup.libexec | path_join(name ~ ".sh") }}
{%-   endfor %}
    - require:
      - sls: {{ sls_service_clean }}
