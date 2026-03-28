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
