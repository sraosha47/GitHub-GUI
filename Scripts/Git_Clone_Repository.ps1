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

function New-CloneOrder {
	if ($global:txtbox_branch.Text -eq "Not a repository"){
		Set-Location $global:txtbox_path.Text
		$global:txtbox_cloning_destination.Text = $global:txtbox_path.Text			
	}
}


#region functions------------------------------
function New-Clone {
	$repo_url = $txtbox_github_link.Text
	$repo_name = $repo_url.Split("/")
	$repo_name = $repo_name[$repo_name.Length-1].Replace(".git", "")
	$new_path = $global:txtbox_cloning_destination.text + "\" + $repo_name
	git clone $repo_url
	Set-Location $new_path
	$global:txtbox_path.Text = $new_path
	$global:txtbox_repository.Text = $repo_name
	$global:txtbox_branch.Text = git rev-parse --abbrev-ref HEAD
	git add *
	git commit -m "Repository cloned"
	git remote add origin $repo_url
	git push --set-upstream origin main
	$global:txtbox_cloning_destination.Clear()
	$txtbox_github_link.Clear()
}

function Set-AllPaths {
	Set-Location $global:txtbox_cloning_destination.Text
	$global:txtbox_path.Text = $global:txtbox_cloning_destination.Text
	Show-GitFiles	
}

function Get-LinkError {
	$wshell = New-Object -ComObject Wscript.Shell
	$wshell.Popup("Please insert a link to a GitHub repository",0,"Error")	
}

function Get-DestError {
	$wshell = New-Object -ComObject Wscript.Shell
	$wshell.Popup("Selected directory already is a Repository. Please choose a different location.",0,"Error")
}

function New-WinObject {
	param (
	[string]$object,
	[string]$name,
	[switch]$read_only,
	[array]$location,
	[array]$size,
	[string]$text,
	[array]$font,
	[int]$tab_index,
	$clicked,
	$keydown
	)
	
	$object_name = New-Object System.Windows.Forms.$object
	$object_name.DataBindings.DefaultDataSourceUpdateMode = 0
	$object_name.Location = New-Object System.Drawing.Point($location)
	$object_name.Name = $name
	$object_name.Size = New-Object System.Drawing.Size($size)
	$object_name.TabIndex = $tab_index
	$object_name.Text = $text
	if($object -eq "ListBox"){$object_name.FormattingEnabled = $True}
	if($null -ne $font){$object_name.Font = New-Object System.Drawing.Font($font)}
	if($object -eq "Button"){$object_name.UseVisualStyleBackColor = $True}
	if($object -eq "MaskedTextBox"){$object_name.PasswordChar = '*'}
	if($object -eq "Form"){$object_name.FormBorderStyle = 1}
	if($object -eq "TextBox" -and $read_only){$object_name.ReadOnly = $True}
	if($object -eq "TextBox" -and $null -ne $keydown){$object_name.add_Keydown($keydown)}
	if($object -eq "Button"){$object_name.add_Click($clicked)}
	Set-Variable -Name $name -Value $object_name -Scope global
	$Clone_Repository.Controls.Add($object_name)
}

#endregion-------------------------------------

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#region event handlers
$btn_clone_clicked= 
{
	if($txtbox_github_link.Text -notmatch "https://github.com/.+/.+"){ Get-LinkError } 
	elseif ($global:txtbox_cloning_destination.Text -ne "") { New-Clone }
}

$txtbox_github_link_KeyDown=
{
	if ($_.KeyCode -eq "Enter") {
		if($txtbox_github_link.Text -notmatch "https://github.com/.+/.+"){Get-LinkError} 
		elseif ($global:txtbox_cloning_destination.Text -ne "") {	New-Clone }
	}
}

$btn_select_path_clicked= 
{
	$null = $folder_browser.ShowDialog()
	if ($null -ne ($folder_browser.SelectedPath | Get-ChildItem)) {
		if (($folder_browser.SelectedPath | Get-ChildItem -Name -Force).Contains(".git") -eq $True){Get-DestError} 
		else {
			$global:txtbox_cloning_destination.Text = $folder_browser.SelectedPath
			Set-AllPaths
		}	
	} else {
		$global:txtbox_cloning_destination.Text = $folder_browser.SelectedPath
		Set-AllPaths	
	}	
}

$txtbox_cloning_destination_KeyDown=
{
	if ($global:txtbox_cloning_destination.Text -ne "") {
		if ($_.KeyCode -eq "Enter") {
			if (($global:txtbox_cloning_destination.Text | Get-ChildItem -Name -Force).Contains(".git") -eq $True){
				Get-DestError
				$global:txtbox_cloning_destination.Clear()	
			} else {
				Set-AllPaths		
			}	
		}
	}
}
#endregion------------
$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$Clone_Repository.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Object Creation

$Clone_Repository = New-Object System.Windows.Forms.Form
$folder_browser = New-Object System.Windows.Forms.FolderBrowserDialog
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

$Clone_Repository.ClientSize = New-Object System.Drawing.Size(352, 274)
$Clone_Repository.DataBindings.DefaultDataSourceUpdateMode = 0
$Clone_Repository.FormBorderStyle = 1
$Clone_Repository.Name = "Clone_Repository"
$Clone_Repository.Text = "Clone Repository"


New-WinObject -object "Button" -name "btn_clone" -location (12, 208) -size (85, 37) -text "Clone" -tab_index 0 -clicked $btn_clone_clicked
New-WinObject -object "Button" -name "btn_select_path" -location (237, 166) -size (100, 20) -text "Open" -tab_index 0 -clicked $btn_select_path_clicked

New-WinObject -object "Label" -name "label_cloninc_destination" -location (12, 140) -size (120, 23) -text "Clone to:" -tab_index 0 
New-WinObject -object "Label" -name "label_github_link" -location (12, 63) -size (201, 29) -text "Repository Link:" -tab_index 0 
New-WinObject -object "Label" -name "label_clone_titel" -location (12, 9) -size (229, 42) -text "Clone Repository" -tab_index 0 -font ("Microsoft Sans Serif",20,0,3,1)

New-WinObject -object "TextBox" -name "txtbox_cloning_destination" -location (12, 166) -size (201, 20) -tab_index 0 -keydown $txtbox_cloning_destination_KeyDown
New-WinObject -object "TextBox" -name "txtbox_github_link" -location (12, 95) -size (325, 20) -tab_index 0 -keydown $txtbox_github_link_KeyDown

New-CloneOrder
#endregion

#Save the initial state of the form
$InitialFormWindowState = $Clone_Repository.WindowState
#Init the OnLoad event to correct the initial state of the form
$Clone_Repository.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$Clone_Repository.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
