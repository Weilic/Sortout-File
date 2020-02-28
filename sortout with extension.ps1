#该脚本可以将当前目录下的文件以最后修改时间和文件扩展名为依据分类整理
#使用方法：将该脚本放在需要整理的目录下，鼠标右键“使用 PowerShell 运行” 即可
#部分文件的扩展名无法命名为文件夹，该脚本会将该文件移入时间文件夹内
$CurrentScriptName= $MyInvocation.MyCommand.Name #获取当前脚本名字
$FileDir=dir|Where-Object{$_.Name -ne $CurrentScriptName} #获取当前文件目录并删去脚本本身
#$FileDir=$FileDir.name #仅保留文件名
$CurrentCheckFile=0
do{
    if($FileDir[$CurrentCheckFile].Mode -like "*a*"){
        $FileCmd=dir $FileDir[$CurrentCheckFile].Name
        $FileCmd=$FileCmd.LastWriteTime
        $FileTime=$FileCmd.Date #获取文件最后修改时间
        $NewFileName="{0:D}" -f $FileTime #将获取的最后修改时间处理成文件名
        $FileExtension=$FileDir[$CurrentCheckFile].Extension.Split(".")[-1]#获取文件扩展名
        $CurrentCheckFileName=$FileDir[$CurrentCheckFile].Name
        if(Test-Path -Path $NewFileName){
            cd .\$NewFileName
            if(Test-Path -Path $FileExtension){
                cd ..
                move .\$CurrentCheckFileName .\$NewFileName\$FileExtension -ErrorAction "SilentlyContinue" #将文件移入
            }
            else{
                md $FileExtension #创建以扩展名命名的文件夹
                cd ..
                move .\$CurrentCheckFileName .\$NewFileName\$FileExtension -ErrorAction "SilentlyContinue" #将文件移入
            }
        }
        else{
            md $NewFileName -ErrorAction "SilentlyContinue" #创建以时间命名的文件夹
            cd .\$NewFileName
            if(Test-Path -Path $FileExtension){
                cd ..
                move .\$CurrentCheckFileName .\$NewFileName\$FileExtension -ErrorAction "SilentlyContinue" #将文件移入
            }
            else{
                md $FileExtension -ErrorAction "SilentlyContinue" #创建以扩展名命名的文件夹
                cd ..
                move .\$CurrentCheckFileName .\$NewFileName\$FileExtension -ErrorAction "SilentlyContinue" #将文件移入
                if(!$?){
                    move .\$CurrentCheckFileName .\$NewFileName
                }
            }
        }#如果文件夹不存在则创建该文件夹后再移入
    }#不对文件夹进行处理
    $CurrentCheckFile=$CurrentCheckFile+1
}while($CurrentCheckFile -lt $FileDir.Count)