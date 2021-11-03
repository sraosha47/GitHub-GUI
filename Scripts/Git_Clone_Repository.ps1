#Generated Form Function
function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 26.10.2021 09:52
# Generated By: sorus
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
#endregion

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$btn_clone = New-Object System.Windows.Forms.Button
$btn_select_path = New-Object System.Windows.Forms.Button
$global:txtbox_cloning_destination = New-Object System.Windows.Forms.TextBox
$label_cloning_destination = New-Object System.Windows.Forms.Label
$label_github_link = New-Object System.Windows.Forms.Label
$txtbox_github_link = New-Object System.Windows.Forms.TextBox
$label_clone_title = New-Object System.Windows.Forms.Label
$folder_browser = New-Object System.Windows.Forms.FolderBrowserDialog
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$btn_clone_clicked= 
{
	if ($global:txtbox_cloning_destination.Text -ne "" -and $txtbox_github_link.Text -ne "") {
		$repo_url = $txtbox_github_link.Text
		$repo_name = $repo_url.Split("/")
		$repo_name = $repo_name[$repo_name.Length-1].Replace(".git", "")
		$new_path = $global:txtbox_cloning_destination.text + "\" + $repo_name
		git clone $repo_url
		Set-Location $new_path
		git add *
		git commit -m "Repository cloned"
		git remote add origin $repo_url
		git push --set-upstream origin main
		$global:txtbox_cloning_destination.Clear()
		$txtbox_github_link.Clear()
	}
}

$txtbox_github_link_KeyDown=
{
	if ($_.KeyCode -eq "Enter") {
		if ($global:txtbox_cloning_destination.Text -ne "" -and $txtbox_github_link.Text -ne "") {
			
		}
		$repo_url = $txtbox_github_link.Text
		$repo_name = $repo_url.Split("/")
		$repo_name = $repo_name[$repo_name.Length-1].Replace(".git", "")
		$new_path = $global:txtbox_cloning_destination.text + "\" + $repo_name
		git clone $repo_url
		Set-Location $new_path
		git add *
		git commit -m "Repository cloned"
		git remote add origin $repo_url
		git push --set-upstream origin main
		$global:txtbox_cloning_destination.Clear()
		$txtbox_github_link.Clear()
	
	}
}

$btn_select_path_clicked= 
{
	$null = $folder_browser.ShowDialog()
	$global:txtbox_cloning_destination.Text = $folder_browser.SelectedPath
	Set-Location $global:txtbox_cloning_destination.Text
}

$txtbox_cloning_destination_KeyDown=
{
	if ($global:txtbox_cloning_destination.Text -ne "") {
		if ($_.KeyCode -eq "Enter") {
			Set-Location $global:txtbox_cloning_destination.Text		
		}
	}
}

$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 274
$System_Drawing_Size.Width = 352
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.FormBorderStyle = 1
$form1.Name = "form1"
$form1.Text = "Clone Repository"


$btn_clone.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 208
$btn_clone.Location = $System_Drawing_Point
$btn_clone.Name = "btn_clone"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 37
$System_Drawing_Size.Width = 85
$btn_clone.Size = $System_Drawing_Size
$btn_clone.TabIndex = 7
$btn_clone.Text = "Clone"
$btn_clone.UseVisualStyleBackColor = $True
$btn_clone.add_Click($btn_clone_clicked)

$form1.Controls.Add($btn_clone)


$btn_select_path.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 237
$System_Drawing_Point.Y = 166
$btn_select_path.Location = $System_Drawing_Point
$btn_select_path.Name = "btn_select_path"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 100
$btn_select_path.Size = $System_Drawing_Size
$btn_select_path.TabIndex = 6
$btn_select_path.Text = "Open"
$btn_select_path.UseVisualStyleBackColor = $True
$btn_select_path.add_Click($btn_select_path_clicked)

$form1.Controls.Add($btn_select_path)

$global:txtbox_cloning_destination.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 166
$global:txtbox_cloning_destination.Location = $System_Drawing_Point
$global:txtbox_cloning_destination.Name = "global:txtbox_cloning_destination"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 201
$global:txtbox_cloning_destination.Size = $System_Drawing_Size
$global:txtbox_cloning_destination.add_KeyDown($txtbox_cloning_destination_KeyDown)
$global:txtbox_cloning_destination.TabIndex = 5

$form1.Controls.Add($global:txtbox_cloning_destination)

$label_cloning_destination.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 140
$label_cloning_destination.Location = $System_Drawing_Point
$label_cloning_destination.Name = "label_cloning_destination"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 120
$label_cloning_destination.Size = $System_Drawing_Size
$label_cloning_destination.TabIndex = 4
$label_cloning_destination.Text = "Clone To:"

$form1.Controls.Add($label_cloning_destination)

$label_github_link.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 63
$label_github_link.Location = $System_Drawing_Point
$label_github_link.Name = "label_github_link"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 29
$System_Drawing_Size.Width = 201
$label_github_link.Size = $System_Drawing_Size
$label_github_link.TabIndex = 2
$label_github_link.Text = "GitHub Link"

$form1.Controls.Add($label_github_link)

$txtbox_github_link.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 95
$txtbox_github_link.Location = $System_Drawing_Point
$txtbox_github_link.Name = "txtbox_github_link"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 325
$txtbox_github_link.Size = $System_Drawing_Size
$txtbox_github_link.add_KeyDown($txtbox_github_link_KeyDown)
$txtbox_github_link.TabIndex = 1

$form1.Controls.Add($txtbox_github_link)

$label_clone_title.DataBindings.DefaultDataSourceUpdateMode = 0
$label_clone_title.Font = New-Object System.Drawing.Font("Microsoft Sans Serif",20,0,3,1)

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 9
$label_clone_title.Location = $System_Drawing_Point
$label_clone_title.Name = "label_clone_title"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 42
$System_Drawing_Size.Width = 229
$label_clone_title.Size = $System_Drawing_Size
$label_clone_title.TabIndex = 0
$label_clone_title.Text = "Clone Repository"

$form1.Controls.Add($label_clone_title)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
