# jenkins container files & volumes
/opt/jenkins:
  file.directory:
    - user: rust
    - group: root
    - mode: 744
    - makedirs: True

# jenkins container files & volumes
jenkins_docker:
  file.recurse:
    - name: /opt/jenkins/
    - source: salt://jenkins/docker
    - user: rust
    - group: root
    #- clean: true
    - create: True
    - include_empty: True

jenkins_compose_tanit:
  file.managed:
    - name: /opt/jenkins/docker-compose.yml
    - source: salt://jenkins/docker/tanit_docker-compose.yml
    - template: jinja
    - create: True

# jenkins container files & volumes
tanit_script:
  file.recurse:
    - name: /opt/jenkins/scripts
    - source: salt://jenkins/scripts
    - user: rust
    - group: root
    - file_mode: '755'
    - create: True
    - include_empty: True
