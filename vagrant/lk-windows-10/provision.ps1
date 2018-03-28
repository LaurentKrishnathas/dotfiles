iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

choco install -y git 
choco install -y sublimetext3 
choco install -y notepadplusplus 
choco install -y googlechrome 
choco install -y jdk8 

#cd \vagrant
#dir

#echo "installing version 11h50"

#echo "installing vs pro ..."
#Start-Process -FilePath "c:\vagrant\vs_professional_ENU__760670472.1485959288.exe" -ArgumentList "/full"  -Wait 

#echo "installing advinst ..."
#Start-Process -FilePath "c:\vagrant\advinst.msi" -ArgumentList "/full"  -Wait 

#echo "installing sdksetup ..."
#Start-Process -FilePath "c:\vagrant\sdksetup.exe" -ArgumentList "/full"  -Wait 

echo "done"
