<############

MachineIdentifier.ps1

Machine Identifier to print basic information presented in GUI on screen

v0.01 
###########>



Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create Form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Machine Information"
$form.Size = New-Object System.Drawing.Size(600,400)
$form.StartPosition = "CenterScreen"

# Create Tab Control
$tabControl = New-Object System.Windows.Forms.TabControl
$tabControl.Dock = [System.Windows.Forms.DockStyle]::Fill
$form.Controls.Add($tabControl)

# Create Tab for Machine Information
$tabMachine = New-Object System.Windows.Forms.TabPage
$tabMachine.Text = "Machine"
$tabControl.Controls.Add($tabMachine)

# Create Labels for Machine Information
$lblName = New-Object System.Windows.Forms.Label
$lblName.Location = New-Object System.Drawing.Point(10,20)
$lblName.Size = New-Object System.Drawing.Size(280,20)
$lblName.Text = "Machine Name: " + $env:COMPUTERNAME
$tabMachine.Controls.Add($lblName)

$lblIP = New-Object System.Windows.Forms.Label
$lblIP.Location = New-Object System.Drawing.Point(10,50)
$lblIP.Size = New-Object System.Drawing.Size(280,20)
$lblIP.Text = "Machine IP: " + (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.InterfaceAlias -eq "Ethernet"}).IPAddress
$tabMachine.Controls.Add($lblIP)

$lblDomain = New-Object System.Windows.Forms.Label
$lblDomain.Location = New-Object System.Drawing.Point(10,80)
$lblDomain.Size = New-Object System.Drawing.Size(280,20)
$lblDomain.Text = "Machine Domain: " + $env:USERDOMAIN
$tabMachine.Controls.Add($lblDomain)

$lblOU = New-Object System.Windows.Forms.Label
$lblOU.Location = New-Object System.Drawing.Point(10,110)
$lblOU.Size = New-Object System.Drawing.Size(280,20)
$lblOU.Text = "Machine Active Directory OU: " + (Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Where-Object {$_.DistinguishedName -like "*$env:COMPUTERNAME*"}).DistinguishedName
$tabMachine.Controls.Add($lblOU)

# Create Tab for BIOS Information
$tabBIOS = New-Object System.Windows.Forms.TabPage
$tabBIOS.Text = "BIOS"
$tabControl.Controls.Add($tabBIOS)

# Create Label for BIOS Information
$lblBIOS = New-Object System.Windows.Forms.Label
$lblBIOS.Location = New-Object System.Drawing.Point(10,20)
$lblBIOS.Size = New-Object System.Drawing.Size(280,20)
$lblBIOS.Text = "BIOS Information: " + (Get-WmiObject -Class Win32_BIOS).SMBIOSBIOSVersion
$tabBIOS.Controls.Add($lblBIOS)

# Create Tab for Operating System Information
$tabOS = New-Object System.Windows.Forms.TabPage
$tabOS.Text = "Operating System"
$tabControl.Controls.Add($tabOS)

# Create Labels for Operating System Information
$lblOS = New-Object System.Windows.Forms.Label
$lblOS.Location = New-Object System.Drawing.Point(10,20)
$lblOS.Size = New-Object System.Drawing.Size(280,20)
$lblOS.Text = "Operating System: " + (Get-WmiObject -Class Win32_OperatingSystem).Caption + " " + (Get-WmiObject -Class Win32_OperatingSystem).Version
$tabOS.Controls.Add($lblOS)

# Create Tab for User Information
$tabUser = New-Object System.Windows.Forms.TabPage
$tabUser.Text = "User"
$tabControl.Controls.Add($tabUser)

# Create Label for User Information
$lblUser = New-Object System.Windows.Forms.Label
$lblUser.Location = New-Object System.Drawing.Point(10,20)
$lblUser.Size = New-Object System.Drawing.Size(280,20)
$lblUser.Text = "Logged in User: " + $env:USERNAME
$tabUser.Controls.Add($lblUser)

# Create Tab for Smart Card Information
$tabSmartCard = New-Object System.Windows.Forms.TabPage
$tabSmartCard.Text = "Smart Card"
$tabControl.Controls.Add($tabSmartCard)

# Create Label for Smart Card Information
$lblSmartCard = New-Object System.Windows.Forms.Label
$lblSmartCard.Location = New-Object System.Drawing.Point(10,20)
$lblSmartCard.Size = New-Object System.Drawing.Size(280,20)
$lblSmartCard.Text = "Smart Card Information: " + (Get-WmiObject -Class Win32_SmartCardReader).Manufacturer + " " + (Get-WmiObject -Class Win32_SmartCardReader).Name
$tabSmartCard.Controls.Add($lblSmartCard)

# Show Form
$form.ShowDialog() | Out-Null
