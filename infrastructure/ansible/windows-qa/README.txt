Ansible on windows

making winrm works on windows 10:
  created a test user, then enabled read write via winrm
  see
  http://nokitel.im/index.php/2016/11/09/how-to-manage-windows-server-2016-with-ansible/

  winrm configSDDL default 
  #Then choose the account and enalbe read and execute rights, or full access

  winrm set winrm/config/service/auth '@{Basic="true"}'
  winrm set winrm/config/service/auth '@{AllowUnencrypted="true"}'
  
  PB: Administrator account didnt work