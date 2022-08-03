# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as keepalived with context %}

keepalived-package-install-pkg-installed:
  pkg.installed:
    - name: {{ keepalived.lookup.pkg.name }}
