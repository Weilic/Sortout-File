# Sortout-File
## 简介
用Powershell编写的文件整理脚本,只需要将脚本放在需要整理的目录下，然后执行即可。
### sortout.ps1
以文件的最后修改时间为依据进行分类，脚本会将同一天修改的文件放在以该日期命名的目录下。
### sortout with extension.ps1
以文件的最后修改时间和后缀名为依据进行分类，在日期目录下还会有不同后缀名目录，但有部分后缀名无法为系统保留字无法作为目录名，这类文件会被整理在日期目录下。
## 注意
windows7以后系统虽然自带powershell，但系统可能默认不允许执行powershell脚本。  
如果要执行该脚本请在管理员权限下打开powershell并执行如下命令，然后在弹出的对话框中确认即可。  
`set-executionpolicy remotesigned`  

(开启该选项有可能会让恶意脚本有可乘之机)
