# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

keepalived-service-clean-service-dead:
  service.dead:
    - name: {{ keepalived.lookup.service.name }}
    - enable: False
