#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 26.10.2021 09:50
# Generated By: sorus
########################################################################

#region Import the Assemblies************************************************************
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#endregion Import the Assemblies---------------------------------------------------------

#-----------------------*****************************************************************
#**********************------------------------------------------------------------------
#Generated Form Objects-*****************************************************************
#**********************------------------------------------------------------------------
#-----------------------*****************************************************************

$GitHub_GUI = New-Object System.Windows.Forms.Form
$btn_open_project = New-Object System.Windows.Forms.Button
$btn_cloneGUI = New-Object System.Windows.Forms.Button
$btn_remove_file = New-Object System.Windows.Forms.Button
$btn_open_file = New-Object System.Windows.Forms.Button
$btn_git_add = New-Object System.Windows.Forms.Button
$btn_git_initialise = New-Object System.Windows.Forms.Button
$btn_show_files = New-Object System.Windows.Forms.Button
$btn_show_history = New-Object System.Windows.Forms.Button
$btn_show_status = New-Object System.Windows.Forms.Button
$btn_pull = New-Object System.Windows.Forms.Button
$btn_push = New-Object System.Windows.Forms.Button
$btn_commit = New-Object System.Windows.Forms.Button
$btn_branchGUI = New-Object System.Windows.Forms.Button

$global:lstbox_display_infos = New-Object System.Windows.Forms.ListBox
$txtbox_description = New-Object System.Windows.Forms.TextBox
$global:txtbox_branch = New-Object System.Windows.Forms.TextBox
$global:txtbox_repository = New-Object System.Windows.Forms.TextBox
$global:txtbox_path = New-Object System.Windows.Forms.TextBox
$txtbox_username = New-Object System.Windows.Forms.TextBox
$txtbox_token = New-Object System.Windows.Forms.MaskedTextBox

$label_description = New-Object System.Windows.Forms.Label
$label_branch = New-Object System.Windows.Forms.Label
$label_repository = New-Object System.Windows.Forms.Label
$label_path = New-Object System.Windows.Forms.Label
$label_title = New-Object System.Windows.Forms.Label
$label_username = New-Object System.Windows.Forms.Label
$label_token = New-Object System.Windows.Forms.Label

$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
#endregion Generated Form Objects--------------------------------------------------------


#Other Variables*************************************************************************
[bool]$global:files_loaded = $false
#endregion-------------------------------------------------------------------------------


#functions*******************************************************************************
function global:Get-GitStat {
	$global:lstbox_display_infos.Items.Clear()
	$status = git status
	$global:lstbox_display_infos.Items.AddRange($status)
	$global:files_loaded = $false
}

function global:Show-GitFiles {
	$global:lstbox_display_infos.Items.Clear()
	$repo_content = Get-ChildItem -Name -Recurse $global:txtbox_path.Text
	$global:lstbox_display_infos.Items.AddRange($repo_content)
	$global:files_loaded = $True
}
#endregion functions---------------------------------------------------------------------

#----------------------------------------------------------------------------------------
#*************************---------------------------------------------------------------
#Generated Event Handlers*---------------------------------------------------------------
#*************************---------------------------------------------------------------
#----------------------------------------------------------------------------------------

#region button event handlers************************************************************

#buttons opening other Windows
$btn_branchGUI_clicked= 
{
	Set-Location $PSScriptRoot
	.\GitGui_Branches.ps1
	Set-Location $global:txtbox_path.Text
}

$btn_cloneGUI_clicked= 
{
	Set-Location $PSScriptRoot
	.\Git_Clone_Repository.ps1
}
#----------------------------------------------------------------------------------------

#butten opening folder browser***********************************************************
$btn_open_project_clicked= 
{
	$Null = $FolderBrowser.ShowDialog()
	$global:txtbox_path.Text = $FolderBrowser.SelectedPath
	Set-Location $FolderBrowser.SelectedPath
	$PathSplit = $FolderBrowser.SelectedPath.Split("\")
	$global:txtbox_repository.Text = $PathSplit[$PathSplit.Length -1]
	if (($FolderBrowser.SelectedPath | Get-ChildItem -Name -Force).Contains(".git") -eq $True){
		$global:txtbox_branch.Text = git rev-parse --abbrev-ref HEAD 	
	}
	Show-GitFiles
} 
#----------------------------------------------------------------------------------------

#buttons providing information***********************************************************
$btn_show_files_clicked= 
{	
	Show-GitFiles
}

$btn_open_file_clicked= 
{
	if ($global:files_loaded -eq $True) {
		Invoke-Item $global:lstbox_display_infos.SelectedItem	
	}
}

$btn_remove_file_clicked= 
{
	if($global:files_loaded -eq $True){
		$global:lstbox_display_infos.SelectedItem | Remove-Item
		$global:lstbox_display_infos.Items.Clear()
		$repo_content = (Get-ChildItem -Name $global:txtbox_path.Text)
		$global:lstbox_display_infos.Items.AddRange($repo_content)
	}
}

$btn_show_history_clicked= 
{
	$global:lstbox_display_infos.Items.Clear()
	$history = git log 
	$global:lstbox_display_infos.Items.AddRange($history)
	$global:files_loaded = $false
}

$btn_show_status_clicked= 
{
	Get-GitStat
}
#----------------------------------------------------------------------------------------

#buttons for git management**************************************************************
$btn_pull_clicked= 
{
	git fetch
	git pull
	Get-GitStat
}


$btn_git_add_clicked= 
{
	git add *
	Get-GitStat
}

$btn_commit_clicked= 
{
	$global:lstbox_display_infos.Items.Clear()
	$commit_info = git commit -m $txtbox_description.Text
	$global:lstbox_display_infos.Items.AddRange($commit_info)
	$txtbox_description.Text = ''
	$global:files_loaded = $false
}

$btn_push_clicked= 
{
	git push	
	Get-GitStat
}

#----------------------------------------------------------------------------------------

#button creating repository on GitHub and initialisng git locally************************
$btn_git_initialise_clicked= 
{

	#region create repo on GitHub********************************************************
	# Use TLS 1.2
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	# create authentication header
	$username = $txtbox_username.Text
	$token = $txtbox_token.Text
	$RepoName = $global:txtbox_repository.Text
	$RepoDescription = $txtbox_description
	$Private = $false
	$Homepage = ''
	$HasIssues = $true
	$HasWiki = $true

	#converting username and token into machinge code
	$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$token)));
	#creating header
	$authHeader = @{"Authorization"="Basic $base64AuthInfo"};

	# creating the body of sent information
	$body = @{
		name = $RepoName;
		description = $RepoDescription;
		homepage = $Homepage;
		private = $Private.IsPresent;
		has_issues = $HasIssues.IsPresent;
		has_wiki = $HasWiki.IsPresent;
		has_downloads = $true;
		auto_init = $true;
	} | ConvertTo-Json -Compress; #converting it to Json and compressing it

	$creationUri = 'https://api.github.com/user/repos';
	
	Invoke-RestMethod -Uri $creationUri -Headers $authHeader -Method Post -Body $body;
	$txtbox_description.Clear()
	#endregion---------------------------------------------------------------------------

	#region initialising Git locally*****************************************************
	#initialise Git repository in selected folder
	$repo_url = "https://github.com/" + $username + "/" + $global:txtbox_repository.Text
	git init -b main
	$global:txtbox_branch.Text = git rev-parse --abbrev-ref HEAD 	
	git remote add origin $repo_url
	git pull --set-upstream origin main
	git add *
	git commit -m "initial commit"
	git push 
	git pull
}
	#endregion---------------------------------------------------------------------------
#endregion button event handlers---------------------------------------------------------


#region KeyDown event handlers***********************************************************

#KeyDown event enabling entering path directly into txtbox
$txtbox_path_KeyDown={
	if ($_.Keycode -eq "Enter" -and $global:txtbox_path.Text -ne ""){
		Set-Location $global:txtbox_path.Text
		$PathSplit = $global:txtbox_path.Text.Split("\")
		$global:txtbox_repository.Text = $PathSplit[$PathSplit.Length -1]
		$global:txtbox_branch.Text = git rev-parse --abbrev-ref HEAD 	
		Show-GitFiles	
	}
}

#endregion KeyDown event handlers--------------------------------------------------------


#----------------------------------------------------------------------------------------
#*************************************************---------------------------------------
#Definition and initialisation of WinForm Objects*---------------------------------------
#*************************************************---------------------------------------
#----------------------------------------------------------------------------------------


$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$GitHub_GUI.WindowState = $InitialFormWindowState
}

#----------------------------------------------
$GitHub_GUI.ClientSize = New-Object System.Drawing.Size(982, 412)
$GitHub_GUI.DataBindings.DefaultDataSourceUpdateMode = 0
$GitHub_GUI.FormBorderStyle = 1
$GitHub_GUI.Name = "GitHub_GUI"
$GitHub_GUI.Text = "GitHub GUI"

#region btn_open_project*****************************************************************
$btn_open_project.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_open_project.Location = New-Object System.Drawing.Point(22, 73)
$btn_open_project.Name = "btn_open_project"
$btn_open_project.Size = New-Object System.Drawing.Size(102, 38)
$btn_open_project.TabIndex = 24
$btn_open_project.Text = "Open Project"
$btn_open_project.UseVisualStyleBackColor = $True
$btn_open_project.add_Click($btn_open_project_clicked)

$GitHub_GUI.Controls.Add($btn_open_project)
#endregion-------------------------------------------------------------------------------

#region btn_clone_project****************************************************************
$btn_cloneGUI.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_cloneGUI.Location = New-Object System.Drawing.Point(143, 73)
$btn_cloneGUI.Name = "btn_clone_project"
$btn_cloneGUI.Size = New-Object System.Drawing.Size(96, 39)
$btn_cloneGUI.TabIndex = 23
$btn_cloneGUI.Text = "Clone Project"
$btn_cloneGUI.UseVisualStyleBackColor = $True
$btn_cloneGUI.add_Click($btn_cloneGUI_clicked)

$GitHub_GUI.Controls.Add($btn_cloneGUI)
#endregion btn_clone_project-------------------------------------------------------------


#region btn_remove_file******************************************************************
$btn_remove_file.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_remove_file.Location = New-Object System.Drawing.Point(854, 198)
$btn_remove_file.Name = "btn_remove_file"
$btn_remove_file.Size = New-Object System.Drawing.Size(102, 30)
$btn_remove_file.TabIndex = 22
$btn_remove_file.Text = "Delete"
$btn_remove_file.UseVisualStyleBackColor = $True
$btn_remove_file.add_Click($btn_remove_file_clicked)

$GitHub_GUI.Controls.Add($btn_remove_file)
#endregion btn_remove_file---------------------------------------------------------------

#region btn_open_file********************************************************************
$btn_open_file.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_open_file.Location = New-Object System.Drawing.Point(854, 151)
$btn_open_file.Name = "btn_open_file"
$btn_open_file.Size = New-Object System.Drawing.Size(102, 32)
$btn_open_file.TabIndex = 21
$btn_open_file.Text = "Open"
$btn_open_file.UseVisualStyleBackColor = $True
$btn_open_file.add_Click($btn_open_file_clicked)

$GitHub_GUI.Controls.Add($btn_open_file)
#endregion btn_open_file-----------------------------------------------------------------


#region btn_git_add**********************************************************************
$btn_git_add.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_git_add.Location = New-Object System.Drawing.Point(379, 200)
$btn_git_add.Name = "btn_git_add"
$btn_git_add.Size = New-Object System.Drawing.Size(149, 27)
$btn_git_add.TabIndex = 20
$btn_git_add.Text = "Git Add"
$btn_git_add.UseVisualStyleBackColor = $True
$btn_git_add.add_Click($btn_git_add_clicked)

$GitHub_GUI.Controls.Add($btn_git_add)
#endregion btn_git_add-------------------------------------------------------------------

#region btn_git_initialise***************************************************************
$btn_git_initialise.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_git_initialise.Location = New-Object System.Drawing.Point(260)
$btn_git_initialise.Name = "btn_git_initialise"
$btn_git_initialise.Size = New-Object System.Drawing.Size(73)
$btn_git_initialise.TabIndex = 19
$btn_git_initialise.Text = "Initialise Git here"
$btn_git_initialise.UseVisualStyleBackColor = $True
$btn_git_initialise.add_Click($btn_git_initialise_clicked)

$GitHub_GUI.Controls.Add($btn_git_initialise)
#endregion btn_git_initialise------------------------------------------------------------

#region btn_show_files*******************************************************************
$btn_show_files.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_show_files.Location = New-Object System.Drawing.Point(556, 117)
$btn_show_files.Name = "btn_show_files"
$btn_show_files.Size = New-Object System.Drawing.Size(86, 23)
$btn_show_files.TabIndex = 18
$btn_show_files.Text = "Show Files"
$btn_show_files.UseVisualStyleBackColor = $True
$btn_show_files.add_Click($btn_show_files_clicked)

$GitHub_GUI.Controls.Add($btn_show_files)
#endregion btn_show_files----------------------------------------------------------------


#region btn_show_history*****************************************************************
$btn_show_history.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_show_history.Location = New-Object System.Drawing.Point(658, 117)
$btn_show_history.Name = "btn_show_history"
$btn_show_history.Size = New-Object System.Drawing.Size(86, 23)
$btn_show_history.TabIndex = 17
$btn_show_history.Text = "History"
$btn_show_history.UseVisualStyleBackColor = $True
$btn_show_history.add_Click($btn_show_history_clicked)

$GitHub_GUI.Controls.Add($btn_show_history)
#endregion btn_show_history--------------------------------------------------------------

#region btn_show_status******************************************************************
$btn_show_status.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_show_status.Location = New-Object System.Drawing.Point(762, 117)
$btn_show_status.Name = "btn_show_status"
$btn_show_status.Size = New-Object System.Drawing.Size(86, 23)
$btn_show_status.TabIndex = 16
$btn_show_status.Text = "Status"
$btn_show_status.UseVisualStyleBackColor = $True
$btn_show_status.add_Click($btn_show_status_clicked)

$GitHub_GUI.Controls.Add($btn_show_status)
#endregion btn_show_status---------------------------------------------------------------


#region lstbox_display_info**************************************************************
$global:lstbox_display_infos.DataBindings.DefaultDataSourceUpdateMode = 0
$global:lstbox_display_infos.FormattingEnabled = $True

$global:lstbox_display_infos.Location = New-Object System.Drawing.Point(556, 151)
$global:lstbox_display_infos.Name = "lstbox_display_infos"
$global:lstbox_display_infos.Size = New-Object System.Drawing.Size(292,238)
$global:lstbox_display_infos.TabIndex = 15

$GitHub_GUI.Controls.Add($global:lstbox_display_infos)
#endregion lstbox_display_infos----------------------------------------------------------

#region label_description****************************************************************
$label_description.DataBindings.DefaultDataSourceUpdateMode = 0

$label_description.Location = New-Object System.Drawing.Point(130, 189)
$label_description.Name = "label_description"
$label_description.Size = New-Object System.Drawing.Size(157, 13)
$label_description.TabIndex = 14
$label_description.Text = "Commit/Repo Description:"

$GitHub_GUI.Controls.Add($label_description)
#endregion label_description-------------------------------------------------------------

#region btn_pull*************************************************************************
$btn_pull.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_pull.Location = New-Object System.Drawing.Point(17, 303)
$btn_pull.Name = "btn_pull"
$btn_pull.Size = New-Object System.Drawing.Size(107, 29)
$btn_pull.TabIndex = 13
$btn_pull.Text = "Pull Project"
$btn_pull.UseVisualStyleBackColor = $True
$btn_pull.add_Click($btn_pull_clicked)

$GitHub_GUI.Controls.Add($btn_pull)
#endregion btn_pull----------------------------------------------------------------------


#region txtbox_description***************************************************************
$txtbox_description.DataBindings.DefaultDataSourceUpdateMode = 0

$txtbox_description.Location = New-Object System.Drawing.Point(130, 205)
$txtbox_description.Name = "txtbox_description"
$txtbox_description.Size = New-Object System.Drawing.Size(204, 20)
$txtbox_description.TabIndex = 12

$GitHub_GUI.Controls.Add($txtbox_description)
#endregion txtbox_description------------------------------------------------------------

#region btn_push*************************************************************************
$btn_push.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_push.Location = New-Object System.Drawing.Point(17, 254)
$btn_push.Name = "btn_push"
$btn_push.Size = New-Object System.Drawing.Size(107, 33)
$btn_push.TabIndex = 11
$btn_push.Text = "Push Project"
$btn_push.UseVisualStyleBackColor = $True
$btn_push.add_Click($btn_push_clicked)

$GitHub_GUI.Controls.Add($btn_push)
#endregion btn_push----------------------------------------------------------------------

#region btn_commit***********************************************************************
$btn_commit.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_commit.Location = New-Object System.Drawing.Point(17, 189)
$btn_commit.Name = "btn_commit"
$btn_commit.Size = New-Object System.Drawing.Size(107, 38)
$btn_commit.TabIndex = 10
$btn_commit.Text = "Commit"
$btn_commit.UseVisualStyleBackColor = $True
$btn_commit.add_Click($btn_commit_clicked)

$GitHub_GUI.Controls.Add($btn_commit)
#endregion btn_commit--------------------------------------------------------------------


#region btn_branchGUI********************************************************************
$btn_branchGUI.DataBindings.DefaultDataSourceUpdateMode = 0

$btn_branchGUI.Location = New-Object System.Drawing.Point(443, 117)
$btn_branchGUI.Name = "btn_open_select_branch"
$btn_branchGUI.Size = New-Object System.Drawing.Size(85, 20)
$btn_branchGUI.TabIndex = 9
$btn_branchGUI.Text = "Select Branch"
$btn_branchGUI.UseVisualStyleBackColor = $True
$btn_branchGUI.add_Click($btn_branchGUI_clicked)

$GitHub_GUI.Controls.Add($btn_branchGUI)
#endregion btn_branchGUI-----------------------------------------------------------------


#region txtbox_branch********************************************************************
$global:txtbox_branch.DataBindings.DefaultDataSourceUpdateMode = 0

$global:txtbox_branch.Location = New-Object System.Drawing.Point(393, 154)
$global:txtbox_branch.Name = "txtbox_branch"
$global:txtbox_branch.Size = New-Object System.Drawing.Size(135, 20)
$global:txtbox_branch.TabIndex = 8
$global:txtbox_branch.ReadOnly = $True

$GitHub_GUI.Controls.Add($global:txtbox_branch)
#endregion txtbox_branch-----------------------------------------------------------------


#region label_branch*********************************************************************
$label_branch.DataBindings.DefaultDataSourceUpdateMode = 0

$label_branch.Location = New-Object System.Drawing.Point(389, 135)
$label_branch.Name = "label_branch"
$label_branch.Size = New-Object System.Drawing.Size(159, 27)
$label_branch.TabIndex = 7
$label_branch.Text = "Branch:"

$GitHub_GUI.Controls.Add($label_branch)
#endregion label_branch------------------------------------------------------------------


#region label_username*******************************************************************
$label_username.DataBindings.DefaultDataSourceUpdateMode = 0

$label_username.Location = New-Object System.Drawing.Point(131, 247)
$label_username.Name = "label_username"
$label_username.Size = New-Object System.Drawing.Size(203, 16)
$label_username.TabIndex = 6
$label_username.Text = "Username:"

$GitHub_GUI.Controls.Add($label_username)
#endregion label_username----------------------------------------------------------------

#region txtbox_username******************************************************************
$txtbox_username.DataBindings.DefaultDataSourceUpdateMode = 0
$txtbox_username.Location = New-Object System.Drawing.Point(131, 265)
$txtbox_username.Name = "txtbox_username"
$txtbox_username.Size = New-Object System.Drawing.Size(203, 20)
$txtbox_username.TabIndex = 8

$GitHub_GUI.Controls.Add($txtbox_username)
#endregion txtbox_username--------------------------------------------------------------

#region label_token*********************************************************************
$label_token.DataBindings.DefaultDataSourceUpdateMode = 0

$label_token.Location = New-Object System.Drawing.Point(131, 292)
$label_token.Name = "label_token"
$label_token.Size = New-Object System.Drawing.Size(203, 16)
$label_token.TabIndex = 6
$label_token.Text = "Personal Access Token:"

$GitHub_GUI.Controls.Add($label_token)
#endregion label_token-----------------------------------------------------------------

#region txtbox_token*******************************************************************
$txtbox_token.DataBindings.DefaultDataSourceUpdateMode = 0
$txtbox_token.Location = New-Object System.Drawing.Point(131, 311)
$txtbox_token.Name = "txtbox_token"
$txtbox_token.Size = New-Object System.Drawing.Size(203, 20)
$txtbox_token.TabIndex = 8
$txtbox_token.PasswordChar = '*'

$GitHub_GUI.Controls.Add($txtbox_token)
#endregion txtbox_token----------------------------------------------------------------

#region textbox_repository*************************************************************
$global:txtbox_repository.DataBindings.DefaultDataSourceUpdateMode = 0
$global:txtbox_repository.Location = New-Object System.Drawing.Point(218, 154)
$global:txtbox_repository.Name = "txtbox_repository"
$global:txtbox_repository.Size = New-Object System.Drawing.Size(154, 20)
$global:txtbox_repository.TabIndex = 5
$global:txtbox_repository.ReadOnly = $True

$GitHub_GUI.Controls.Add($global:txtbox_repository)
#endregion txtbox_repository-----------------------------------------------------------

#region label_repository***************************************************************
$label_repository.DataBindings.DefaultDataSourceUpdateMode = 0
$label_repository.Location = New-Object System.Drawing.Point(214, 135)
$label_repository.Name = "label_repository"
$label_repository.Size = New-Object System.Drawing.Size(159, 13)
$label_repository.TabIndex = 4
$label_repository.Text = "Repository:"

$GitHub_GUI.Controls.Add($label_repository)
#endregion label_repository-----------------------------------------------------------

#region label_path********************************************************************
$label_path.DataBindings.DefaultDataSourceUpdateMode = 0
$label_path.Location = New-Object System.Drawing.Point(21, 135)
$label_path.Name = "label_path"
$label_path.Size = New-Object System.Drawing.Size(50, 13)
$label_path.TabIndex = 3
$label_path.Text = "Path:"

$GitHub_GUI.Controls.Add($label_path)

#endregion label_path----------------------------------------------------------------

#region txtbox_path******************************************************************

$global:txtbox_path.DataBindings.DefaultDataSourceUpdateMode = 0
$global:txtbox_path.Location = New-Object System.Drawing.Point(21, 154)
$global:txtbox_path.Name = "txtbox_path"
$global:txtbox_path.Size = New-Object System.Drawing.Size(184, 20)
$global:txtbox_path.add_Keydown($txtbox_path_KeyDown)
$global:txtbox_path.TabIndex = 2

$GitHub_GUI.Controls.Add($global:txtbox_path)

#endregion txtbox_path--------------------------------------------------------------

#region label_title*****************************************************************

$label_title.DataBindings.DefaultDataSourceUpdateMode = 0
$label_title.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",30,0,3,1)
$label_title.Location = New-Object System.Drawing.Point(17, 14)
$label_title.Name = "label_title"
$label_title.Size = New-Object System.Drawing.Size(234, 48)
$label_title.TabIndex = 1
$label_title.Text = "GitHub GUI"

$GitHub_GUI.Controls.Add($label_title)
#endregion label_title--------------------------------------------------------------

#Save the initial state of the form
$InitialFormWindowState = $GitHub_GUI.WindowState
#Init the OnLoad event to correct the initial state of the form
$GitHub_GUI.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$GitHub_GUI.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
