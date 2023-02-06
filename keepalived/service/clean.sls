# vim: ft=sls

{#-
    Stops the keepalived service and disables it at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

keepalived is dead:
  service.dead:
    - name: {{ keepalived.lookup.service.name }}
    - enable: false
