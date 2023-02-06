# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

keepalived is installed:
  pkg.installed:
    - name: {{ keepalived.lookup.pkg.name }}
