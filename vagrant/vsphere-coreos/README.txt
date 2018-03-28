How to install coreos on virtuabox:
  step1
    - update cloud-config.yml with password
        sudo openssl passwd -1
    - create a vm in virtualbox, attach the iso file, set the port forwarding, boot
    - file sharing via web with
        docker run -it -p 80:80  -v $(pwd):/usr/share/nginx/html nginx

  step2
    - launch install via
      curl http://192.168.64.101/install.bash|sudo bash

  step3
    - remove iso, reboot
    - ssh
        ssh -p 2022 core@127.0.0.1

  doc
    see https://deis.com/blog/2015/coreos-on-virtualbox/

    enabing vmware integration via docker
    see https://github.com/godmodelabs/docker-open-vm-tools


How to install coreos on vmware vsphere:
  - create a iso version
  - run open-vm-tools via docker to make the ip available to access the network
  - run webserver and get files via web and insall
  - remove iso, restart
  - create a template
  - make sure it works in vagrant
