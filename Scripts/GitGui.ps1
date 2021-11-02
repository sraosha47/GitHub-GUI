#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 26.10.2021 09:50
# Generated By: sorus
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#endregion

#region Generated Form Objects
$GitHub_GUI = New-Object System.Windows.Forms.Form
$btn_open_project = New-Object System.Windows.Forms.Button
$btn_new_project = New-Object System.Windows.Forms.Button
$btn_remove_file = New-Object System.Windows.Forms.Button
$btn_open_file = New-Object System.Windows.Forms.Button
$btn_git_add = New-Object System.Windows.Forms.Button
$btn_git_initialise = New-Object System.Windows.Forms.Button
$btn_show_files = New-Object System.Windows.Forms.Button
$btn_show_history = New-Object System.Windows.Forms.Button
$btn_show_status = New-Object System.Windows.Forms.Button
$lstbox_display_infos = New-Object System.Windows.Forms.ListBox
$label_commit_description = New-Object System.Windows.Forms.Label
$btn_pull = New-Object System.Windows.Forms.Button
$txtbox_commit_description = New-Object System.Windows.Forms.TextBox
$btn_push = New-Object System.Windows.Forms.Button
$btn_commit = New-Object System.Windows.Forms.Button
$btn_open_select_branch = New-Object System.Windows.Forms.Button
$txtbox_branch = New-Object System.Windows.Forms.TextBox
$label_branch = New-Object System.Windows.Forms.Label
$txtbox_repository = New-Object System.Windows.Forms.TextBox
$label_repository = New-Object System.Windows.Forms.Label
$label_path = New-Object System.Windows.Forms.Label
$txtbox_path = New-Object System.Windows.Forms.TextBox
$label_title = New-Object System.Windows.Forms.Label
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
$FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$btn_open_select_branch_clicked= 
{

}

$btn_show_files_clicked= 
{	
	$lstbox_display_infos.Items.Clear()
	$repo_content = (Get-ChildItem -Path $txtbox_path.Text -Recurse -Directory).FullName
	$lstbox_display_infos.Items.AddRange($repo_content)
}

$btn_remove_file_clicked= 
{

}

$btn_git_initialise_clicked= 
{

}

$btn_open_file_clicked= 
{

}

$btn_commit_clicked= 
{
	git commit -m $txtbox_commit_description.Text
}

$btn_new_project_clicked= 
{

}

$btn_show_status_clicked= 
{

}

$btn_show_history_clicked= 
{

}

$btn_open_project_clicked= 
{
	$Null = $FolderBrowser.ShowDialog()
	$txtbox_path.Text = $FolderBrowser.SelectedPath
	Set-Location $FolderBrowser.SelectedPath
	$FolderSplit = $FolderBrowser.SelectedPath.Split("\")
	$txtbox_repository.Text = $FolderSplit[$FolderSplit.Length -1]
	$txtbox_branch.Text = git rev-parse --abbrev-ref HEAD 	
} 

$btn_pull_clicked= 
{
	git pull
}

$btn_push_clicked= 
{
	git push
}

$btn_git_add_clicked= 
{
	git add *
}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$GitHub_GUI.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 412
$System_Drawing_Size.Width = 982
$GitHub_GUI.ClientSize = $System_Drawing_Size
$GitHub_GUI.DataBindings.DefaultDataSourceUpdateMode = 0
$GitHub_GUI.FormBorderStyle = 1
$GitHub_GUI.Name = "GitHub_GUI"
$GitHub_GUI.Text = "GitHub GUI"


$btn_open_project.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 22
$System_Drawing_Point.Y = 73
$btn_open_project.Location = $System_Drawing_Point
$btn_open_project.Name = "btn_open_project"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 38
$System_Drawing_Size.Width = 102
$btn_open_project.Size = $System_Drawing_Size
$btn_open_project.TabIndex = 22
$btn_open_project.Text = "Open Project"
$btn_open_project.UseVisualStyleBackColor = $True
$btn_open_project.add_Click($btn_open_project_clicked)

$GitHub_GUI.Controls.Add($btn_open_project)


$btn_new_project.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 143
$System_Drawing_Point.Y = 73
$btn_new_project.Location = $System_Drawing_Point
$btn_new_project.Name = "btn_new_project"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 39
$System_Drawing_Size.Width = 96
$btn_new_project.Size = $System_Drawing_Size
$btn_new_project.TabIndex = 21
$btn_new_project.Text = "Clone Project"
$btn_new_project.UseVisualStyleBackColor = $True
$btn_new_project.add_Click($btn_new_project_clicked)

$GitHub_GUI.Controls.Add($btn_new_project)


$btn_remove_file.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 854
$System_Drawing_Point.Y = 198
$btn_remove_file.Location = $System_Drawing_Point
$btn_remove_file.Name = "btn_remove_file"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 30
$System_Drawing_Size.Width = 102
$btn_remove_file.Size = $System_Drawing_Size
$btn_remove_file.TabIndex = 20
$btn_remove_file.Text = "Delete"
$btn_remove_file.UseVisualStyleBackColor = $True
$btn_remove_file.add_Click($btn_remove_file_clicked)

$GitHub_GUI.Controls.Add($btn_remove_file)


$btn_open_file.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 854
$System_Drawing_Point.Y = 151
$btn_open_file.Location = $System_Drawing_Point
$btn_open_file.Name = "btn_open_file"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 32
$System_Drawing_Size.Width = 102
$btn_open_file.Size = $System_Drawing_Size
$btn_open_file.TabIndex = 19
$btn_open_file.Text = "Open"
$btn_open_file.UseVisualStyleBackColor = $True
$btn_open_file.add_Click($btn_open_file_clicked)

$GitHub_GUI.Controls.Add($btn_open_file)


$btn_git_add.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 379
$System_Drawing_Point.Y = 200
$btn_git_add.Location = $System_Drawing_Point
$btn_git_add.Name = "btn_git_add"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 27
$System_Drawing_Size.Width = 149
$btn_git_add.Size = $System_Drawing_Size
$btn_git_add.TabIndex = 18
$btn_git_add.Text = "Git Add"
$btn_git_add.UseVisualStyleBackColor = $True
$btn_git_add.add_Click($btn_git_add_clicked)

$GitHub_GUI.Controls.Add($btn_git_add)


$btn_git_initialise.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 260
$System_Drawing_Point.Y = 73
$btn_git_initialise.Location = $System_Drawing_Point
$btn_git_initialise.Name = "btn_git_initialise"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 38
$System_Drawing_Size.Width = 149
$btn_git_initialise.Size = $System_Drawing_Size
$btn_git_initialise.TabIndex = 17
$btn_git_initialise.Text = "Initialise Git here"
$btn_git_initialise.UseVisualStyleBackColor = $True
$btn_git_initialise.add_Click($btn_git_initialise_clicked)

$GitHub_GUI.Controls.Add($btn_git_initialise)


$btn_show_files.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 556
$System_Drawing_Point.Y = 117
$btn_show_files.Location = $System_Drawing_Point
$btn_show_files.Name = "btn_show_files"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 86
$btn_show_files.Size = $System_Drawing_Size
$btn_show_files.TabIndex = 16
$btn_show_files.Text = "Show Files"
$btn_show_files.UseVisualStyleBackColor = $True
$btn_show_files.add_Click($btn_show_files_clicked)

$GitHub_GUI.Controls.Add($btn_show_files)


$btn_show_history.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 658
$System_Drawing_Point.Y = 117
$btn_show_history.Location = $System_Drawing_Point
$btn_show_history.Name = "btn_show_history"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 86
$btn_show_history.Size = $System_Drawing_Size
$btn_show_history.TabIndex = 15
$btn_show_history.Text = "History"
$btn_show_history.UseVisualStyleBackColor = $True
$btn_show_history.add_Click($btn_show_history_clicked)

$GitHub_GUI.Controls.Add($btn_show_history)


$btn_show_status.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 762
$System_Drawing_Point.Y = 117
$btn_show_status.Location = $System_Drawing_Point
$btn_show_status.Name = "btn_show_status"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 86
$btn_show_status.Size = $System_Drawing_Size
$btn_show_status.TabIndex = 14
$btn_show_status.Text = "Status"
$btn_show_status.UseVisualStyleBackColor = $True
$btn_show_status.add_Click($btn_show_status_clicked)

$GitHub_GUI.Controls.Add($btn_show_status)

$lstbox_display_infos.DataBindings.DefaultDataSourceUpdateMode = 0
$lstbox_display_infos.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 556
$System_Drawing_Point.Y = 151
$lstbox_display_infos.Location = $System_Drawing_Point
$lstbox_display_infos.Name = "lstbox_display_infos"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 238
$System_Drawing_Size.Width = 292
$lstbox_display_infos.Size = $System_Drawing_Size
$lstbox_display_infos.TabIndex = 13

$GitHub_GUI.Controls.Add($lstbox_display_infos)

$label_commit_description.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 130
$System_Drawing_Point.Y = 189
$label_commit_description.Location = $System_Drawing_Point
$label_commit_description.Name = "label_commit_description"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 13
$System_Drawing_Size.Width = 157
$label_commit_description.Size = $System_Drawing_Size
$label_commit_description.TabIndex = 12
$label_commit_description.Text = "Description:"

$GitHub_GUI.Controls.Add($label_commit_description)


$btn_pull.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 17
$System_Drawing_Point.Y = 303
$btn_pull.Location = $System_Drawing_Point
$btn_pull.Name = "btn_pull"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 29
$System_Drawing_Size.Width = 107
$btn_pull.Size = $System_Drawing_Size
$btn_pull.TabIndex = 11
$btn_pull.Text = "Pull Project"
$btn_pull.UseVisualStyleBackColor = $True
$btn_pull.add_Click($btn_pull_clicked)

$GitHub_GUI.Controls.Add($btn_pull)

$txtbox_commit_description.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 130
$System_Drawing_Point.Y = 205
$txtbox_commit_description.Location = $System_Drawing_Point
$txtbox_commit_description.Name = "txtbox_commit_description"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 204
$txtbox_commit_description.Size = $System_Drawing_Size
$txtbox_commit_description.TabIndex = 10

$GitHub_GUI.Controls.Add($txtbox_commit_description)


$btn_push.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 17
$System_Drawing_Point.Y = 254
$btn_push.Location = $System_Drawing_Point
$btn_push.Name = "btn_push"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 33
$System_Drawing_Size.Width = 107
$btn_push.Size = $System_Drawing_Size
$btn_push.TabIndex = 9
$btn_push.Text = "Push Project"
$btn_push.UseVisualStyleBackColor = $True
$btn_push.add_Click($btn_push_clicked)

$GitHub_GUI.Controls.Add($btn_push)


$btn_commit.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 17
$System_Drawing_Point.Y = 189
$btn_commit.Location = $System_Drawing_Point
$btn_commit.Name = "btn_commit"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 38
$System_Drawing_Size.Width = 107
$btn_commit.Size = $System_Drawing_Size
$btn_commit.TabIndex = 8
$btn_commit.Text = "Commit"
$btn_commit.UseVisualStyleBackColor = $True
$btn_commit.add_Click($btn_commit_clicked)

$GitHub_GUI.Controls.Add($btn_commit)


$btn_open_select_branch.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 443
$System_Drawing_Point.Y = 117
$btn_open_select_branch.Location = $System_Drawing_Point
$btn_open_select_branch.Name = "btn_open_select_branch"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 85
$btn_open_select_branch.Size = $System_Drawing_Size
$btn_open_select_branch.TabIndex = 7
$btn_open_select_branch.Text = "Select Branch"
$btn_open_select_branch.UseVisualStyleBackColor = $True
$btn_open_select_branch.add_Click($btn_open_select_branch_clicked)

$GitHub_GUI.Controls.Add($btn_open_select_branch)

$txtbox_branch.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 393
$System_Drawing_Point.Y = 154
$txtbox_branch.Location = $System_Drawing_Point
$txtbox_branch.Name = "txtbox_branch"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 135
$txtbox_branch.Size = $System_Drawing_Size
$txtbox_branch.TabIndex = 6

$GitHub_GUI.Controls.Add($txtbox_branch)

$label_branch.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 389
$System_Drawing_Point.Y = 121
$label_branch.Location = $System_Drawing_Point
$label_branch.Name = "label_branch"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 30
$System_Drawing_Size.Width = 56
$label_branch.Size = $System_Drawing_Size
$label_branch.TabIndex = 5
$label_branch.Text = "Branch"

$GitHub_GUI.Controls.Add($label_branch)

$txtbox_repository.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 218
$System_Drawing_Point.Y = 154
$txtbox_repository.Location = $System_Drawing_Point
$txtbox_repository.Name = "txtbox_repository"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 154
$txtbox_repository.Size = $System_Drawing_Size
$txtbox_repository.TabIndex = 4

$GitHub_GUI.Controls.Add($txtbox_repository)

$label_repository.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 214
$System_Drawing_Point.Y = 124
$label_repository.Location = $System_Drawing_Point
$label_repository.Name = "label_repository"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 27
$System_Drawing_Size.Width = 159
$label_repository.Size = $System_Drawing_Size
$label_repository.TabIndex = 3
$label_repository.Text = "Repository"

$GitHub_GUI.Controls.Add($label_repository)

$label_path.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 21
$System_Drawing_Point.Y = 125
$label_path.Location = $System_Drawing_Point
$label_path.Name = "label_path"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 154
$label_path.Size = $System_Drawing_Size
$label_path.TabIndex = 2
$label_path.Text = "Path:"

$GitHub_GUI.Controls.Add($label_path)

$txtbox_path.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 21
$System_Drawing_Point.Y = 154
$txtbox_path.Location = $System_Drawing_Point
$txtbox_path.Name = "txtbox_path"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 184
$txtbox_path.Size = $System_Drawing_Size
$txtbox_path.TabIndex = 1

$GitHub_GUI.Controls.Add($txtbox_path)

$label_title.DataBindings.DefaultDataSourceUpdateMode = 0
$label_title.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",30,0,3,1)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 17
$System_Drawing_Point.Y = 14
$label_title.Location = $System_Drawing_Point
$label_title.Name = "label_title"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 48
$System_Drawing_Size.Width = 234
$label_title.Size = $System_Drawing_Size
$label_title.TabIndex = 0
$label_title.Text = "GitHub GUI"

$GitHub_GUI.Controls.Add($label_title)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $GitHub_GUI.WindowState
#Init the OnLoad event to correct the initial state of the form
$GitHub_GUI.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$GitHub_GUI.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
