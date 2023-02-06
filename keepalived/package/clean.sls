# vim: ft=sls

{#-
    Removes the keepalived package.
    Has a depency on `keepalived.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

include:
  - {{ sls_config_clean }}

keepalived is removed:
  pkg.removed:
    - name: {{ keepalived.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
