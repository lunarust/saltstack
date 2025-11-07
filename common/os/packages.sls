

{% if grains.os_family == 'RedHat' or grains.os_family == 'Suse' %}
# and grains.osmajorrelease >= 6 %}
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
      - unzip
      - lm-sensors
      - sudo
      - htop
