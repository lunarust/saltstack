

{% if grains.os_family == 'RedHat' and grains.osmajorrelease >= 6 %}
## All RedHat - Rocky - Alma
{% else %}
## Debian based
{% endif %}

install_extra_packages:
  pkg.installed:
    - pkgs:
      - nc
      - wget
      - vim
    - unless:
      - which nc
      - which wget
