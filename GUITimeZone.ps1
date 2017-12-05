Function Set-TimezoneGUI
{
#Requires -runasadministrator
#Requires -version 3.0
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms").location | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.drawing") | out-null
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms.filedialog") | out-null
Add-Type -AssemblyName "System.windows.forms" | Out-Null
    function Import-csvFile 
    {
         $inputbox = New-Object System.Windows.Forms.OpenFileDialog
         $inputbox.Filter = "CSV Files (*.csv)|*.csv|TXT Files (*.txt)|*.txt"
         $inputbox.ShowDialog()
         $inputbox.OpenFile()
         $subnetlist = get-content -Path $inputbox.FileName
         foreach ($subnet in $subnetlist)
                {
                 $Listbox.Items.Add($subnet)
                }
      
          $Clear.Enabled = $true
          $ImportFile.Enabled = $false
          $Listbox.Refresh()
          $forms.controls.add($action)
          $action.enabled=$true
          

    }

    Function Set-RemotetimeZone
{

         if ($combobox.SelectedItem -like "" -or $Listbox.SelectedItem -like "")
          {
            [System.Windows.MessageBox]::Show("Please select timezone ID and computername'","Select correct timezone and computernames","Ok")
             break
             $action.enabled = $true                    
          }
         elseif($combobox.SelectedItem -like "(UTC*")
          {
            $selected = $combobox.SelectedItem
            $index =0 
            foreach ($timeinfo in $timeinfos)
            {
            if ($timeinfo -like $selected)
                {
                 $index++
                 $combobox.SelectedItem = $combobox.Items.Item($index)
                 break
                }
                $index++
              }
            
          }
         else{}
         $computername = $Listbox.SelectedItems
         $zone = $combobox.SelectedItem
         foreach ($computer in $computername)
           {
              try 
                 {
                      $currenttimezone= Get-wmiobject -ClassName Win32_SystemTimeZone -computername $computer -ErrorAction Stop | select-object setting
                      if ($currenttimezone -like "*$zone*")
                       {
                         Write-verbose "On $computer time zone is already set to $zone" -Verbose
                       }
                       else
                       {
                          Invoke-Command -ComputerName $computer -ScriptBlock {tzutil.exe /s $args[0]} -ErrorAction Stop -ArgumentList $Zone
                          Write-verbose "On $computer time zone is now set to $selected" -Verbose
                       }
                   }
              catch
                 {
                      Write-error "Failed to set $computer time zone to $zone, Kindly check if Remoting and Access is enabled on computer" -Verbose
                   }
            }
            $ImportFile.enabled = $true   
}

    function Clear-listbox 
    {
        $messageboxtitle="Clear List box"
        $message="Are you sure to clear listbox Items"
        $result = [System.Windows.MessageBox]::Show($message,$messageboxtitle,"YesNO")
            if ($result -eq "Yes")
            {
                $itemcount = $Listbox.Items.Count
                    if ($itemcount -gt 0) 
                    {
                        $Listbox.Items.Clear()
                    }
                $ImportFile.Enabled=$true
                $action.Enabled = $False
                $Clear.Enabled = $false
            }
            else
            {
                return 
            }
    }
    
    $ImportFile = New-Object System.Windows.Forms.Button
    $ImportFile.Location = New-Object System.Drawing.size(380,60)
    $ImportFile.Size = New-Object System.Drawing.size(80,20)
    $ImportFile.Text = "Import"
    $ImportFile.add_click({Import-CSVFile})

    $Action = New-Object System.Windows.Forms.Button
    $Action.Location = New-Object System.Drawing.size(380,110)
    $Action.Size = New-Object System.Drawing.size(90,20)
    $Action.Text = "Set Timezone"
    $Action.add_click({Set-RemotetimeZone})
    $Action.Enabled = $false

    $Clear = New-Object System.Windows.Forms.Button
    $clear.Location = New-Object System.Drawing.size(380,160)
    $clear.Size = New-Object System.Drawing.size(80,20)
    $clear.Text = "Clear"
    $clear.add_click({Clear-listbox})
    $clear.Enabled = $false

    
    $global:Listbox = New-Object System.Windows.Forms.Listbox
    $Listbox.Location = New-Object System.Drawing.Size(40,175)
    $Listbox.size = New-Object System.Drawing.size(100,150)
    $Listbox.AutoSize = $true
    $Listbox.SelectionMode = "multiextended"
    $Listbox.ScrollAlwaysVisible = $true

    $global:combobox = New-Object System.Windows.Forms.ComboBox
    $combobox.Location = New-Object System.Drawing.Size(180,175)
    $combobox.size = New-Object System.Drawing.size(180,150)
    $Timezones = $data = tzutil.exe /l
    foreach ($timezone in $Timezones)
    {
      $combobox.Items.Add($timezone) | Out-Null
    }

    $Label = New-Object System.Windows.Forms.Label
    $Label.Location = New-Object System.Drawing.Size(5,5)
    $Label.Size = New-Object System.Drawing.size(375,145)
    $Label.Font = New-Object System.Drawing.Font("Times New Roman",10,[System.Drawing.FontStyle]::Bold)
    $Label.Text = "Steps to follow:
1.Select TimeZone from dropdown menu of Timezone (combo box) box given below, TimeZone box shows Timezone available in your Computer 
2.Import files containing Computername using 'Import' button
3.Select one or more Computers from Computername (Listbox) Box
4.Click Set TimeZone  button
5.Verbose message will appear in powershell console"

    $Label1 = New-Object System.Windows.Forms.Label
    $Label1.Location = New-Object System.Drawing.Size(45,155)
    $Label1.Size = New-Object System.Drawing.size(110,20)
    $Label1.Font = New-Object System.Drawing.Font("Times New Roman",11,[System.Drawing.FontStyle]::Bold)
    $Label1.Text = "Computername"

    $Label2 = New-Object System.Windows.Forms.Label
    $Label2.Location = New-Object System.Drawing.Size(205,155)
    $Label2.Size = New-Object System.Drawing.size(80,20)
    $Label2.Font = New-Object System.Drawing.Font("Times New Roman",11,[System.Drawing.FontStyle]::Bold)
    $Label2.Text = "TimeZone"
    
    $forms = New-Object System.Windows.Forms.Form
    $forms.Width = 800
    $forms.Height = 400
    $forms.Text = "Set-TimeZone"
    $forms.AutoScale = $false

    $timeinfos = tzutil.exe /l
    
$forms.Controls.Add($Label)

$forms.Controls.Add($Label1)

$forms.Controls.Add($Label2)

$forms.Controls.Add($Label3)

$forms.Controls.Add($ImportFile)
 
$forms.Controls.Add($Action)

$forms.Controls.Add($combobox)

$forms.controls.add($Listbox)

$forms.Controls.Add($clear)

$forms.ShowDialog()
}
Set-TimezoneGUI
