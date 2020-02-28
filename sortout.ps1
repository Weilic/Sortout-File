#该脚本可以将当前目录下的文件以最后修改时间为依据分类整理
#使用方法：将该脚本放在需要整理的目录下，鼠标右键“使用 PowerShell 运行” 即可
$CurrentScriptName= $MyInvocation.MyCommand.Name #获取当前脚本名字
$FileDir=dir|Where-Object{$_.Name -ne $CurrentScriptName} #获取当前文件目录并删去脚本本身
$CurrentCheckFile=0
do{
    if($FileDir[$CurrentCheckFile].Mode -like "*a*"){
        $FileCmd=dir $FileDir[$CurrentCheckFile].Name
        $FileCmd=$FileCmd.LastWriteTime
        $FileTime=$FileCmd.Date #获取文件最后修改时间
        $NewFileName="{0:D}" -f $FileTime #将获取的最后修改时间处理成文件名
        $CurrentCheckFileName=$FileDir[$CurrentCheckFile].Name
        if(Test-Path -Path $NewFileName){
            move .\$CurrentCheckFileName .\$NewFileName #将文件移入
        } #如果文件夹已经存在就直接移入
        else{
            md $NewFileName #创建以时间命名的文件夹
            move .\$CurrentCheckFileName .\$NewFileName #将文件移入
        }#如果文件夹不存在则创建该文件夹后再移入
    } #不处理文件夹
    $CurrentCheckFile=$CurrentCheckFile+1
}while($CurrentCheckFile -lt $FileDir.Count)