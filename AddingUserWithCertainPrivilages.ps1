Add-Type -AssemblyName System.Windows.Forms

# Definiuj funkcję do wyświetlania drugiego formularza
function Show-SecondForm {
    param (
        [string]$Data
    )

    # Utwórz formularz z CheckBoxami na podstawie danych z pierwszego formularza
    $secondForm = New-Object System.Windows.Forms.Form
    $secondForm.Text = "Dynamiczne CheckBoxy"
    $secondForm.Size = New-Object System.Drawing.Size(400, 500)
    $secondForm.StartPosition = "CenterScreen"

    # Utwórz FlowLayoutPanel, aby dynamicznie zarządzać CheckBoxami
    $flowLayoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $flowLayoutPanel.Dock = [System.Windows.Forms.DockStyle]::Top
    $flowLayoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
    $flowLayoutPanel.WrapContents = $false
    $flowLayoutPanel.Size = New-Object System.Drawing.Size(200, 350) 
    $flowLayoutPanel.AutoScroll = $true
    $secondForm.Controls.Add($flowLayoutPanel)

    # Przykładowa lista opcji (możesz ją dostosować do własnych potrzeb)
    $options = (gci $Data -Directory).FullName  # Użyj danych z pierwszego formularza

    # Dodaj CheckBoxy i etykiety do FlowLayoutPanel na podstawie listy opcji
    foreach ($option in $options) {
        $checkBox = New-Object System.Windows.Forms.CheckBox
        $checkBox.Text = $option
        $checkBox.AutoSize = $true
        $flowLayoutPanel.Controls.Add($checkBox)
    }

    # Przycisk do zapisywania wybranych opcji
    $buttonSave = New-Object System.Windows.Forms.Button
    $buttonSave.Location = New-Object System.Drawing.Point(5, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSave.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSave.Text = "Zapisz opcje"
    $buttonSave.Add_Click({
        $selectedOptions = $flowLayoutPanel.Controls | Where-Object { $_.Checked -and $_.GetType().Name -eq 'CheckBox' } | ForEach-Object { $_.Text }
        $global:ResultVariable = $selectedOptions -join ','  # Zapisz wynik w zmiennej globalnej
        [System.Windows.Forms.MessageBox]::Show("Wybrane opcje: $($global:ResultVariable)", "Zapisane opcje")
        $secondForm.Close()  # Zamknij drugi formularz po zatwierdzeniu
    })
    $secondForm.Controls.Add($buttonSave)


     # Dodaj przycisk do zaznaczania wszystkich opcji
    $buttonSelectAll = New-Object System.Windows.Forms.Button
    $buttonSelectAll.Location = New-Object System.Drawing.Point(115, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSelectAll.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSelectAll.Text = "Zaznacz wszystkie"
    $buttonSelectAll.Add_Click({
    $anyChecked = $false
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($checkBox.Checked) {$anyChecked = $true; break}
        }
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($anyChecked -eq $false){
                $checkBox.Checked = $true
            }else{
                $checkBox.Checked = $false
            }
        }
    })
    $secondForm.Controls.Add($buttonSelectAll)

    # Uruchom formularz
    $secondForm.ShowDialog()
}

function Show-ThirdForm{
    # Utwórz formularz z CheckBoxami na podstawie danych z pierwszego formularza
    $thirdForm = New-Object System.Windows.Forms.Form
    $thirdForm.Text = "Dynamiczne CheckBoxy"
    $thirdForm.Size = New-Object System.Drawing.Size(400, 500)
    $thirdForm.StartPosition = "CenterScreen"

    # Utwórz FlowLayoutPanel, aby dynamicznie zarządzać CheckBoxami
    $flowLayoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $flowLayoutPanel.Dock = [System.Windows.Forms.DockStyle]::Top
    $flowLayoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
    $flowLayoutPanel.WrapContents = $false
    $flowLayoutPanel.Size = New-Object System.Drawing.Size(200, 350) 
    $flowLayoutPanel.AutoScroll = $true
    $thirdForm.Controls.Add($flowLayoutPanel)

    # Przykładowa lista opcji (możesz ją dostosować do własnych potrzeb)
    $options = (glg).name  # Użyj danych z pierwszego formularza

    # Dodaj CheckBoxy i etykiety do FlowLayoutPanel na podstawie listy opcji
    foreach ($option in $options) {
        $checkBox = New-Object System.Windows.Forms.CheckBox
        $checkBox.Text = $option
        $checkBox.AutoSize = $true
        $flowLayoutPanel.Controls.Add($checkBox)
    }

    # Przycisk do zapisywania wybranych opcji
    $buttonSave = New-Object System.Windows.Forms.Button
    $buttonSave.Location = New-Object System.Drawing.Point(5, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSave.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSave.Text = "Zapisz opcje"
    $buttonSave.Add_Click({
        $selectedOptions = $flowLayoutPanel.Controls | Where-Object { $_.Checked -and $_.GetType().Name -eq 'CheckBox' } | ForEach-Object { $_.Text }
        $global:GroupsVariable = $selectedOptions -join ','  # Zapisz wynik w zmiennej globalnej
        [System.Windows.Forms.MessageBox]::Show("Wybrane opcje: $($global:GroupsVariable)", "Zapisane opcje")
        $thirdForm.Close()  # Zamknij drugi formularz po zatwierdzeniu
    })
    $thirdForm.Controls.Add($buttonSave)

     # Dodaj przycisk do zaznaczania wszystkich opcji
    $buttonSelectAll = New-Object System.Windows.Forms.Button
    $buttonSelectAll.Location = New-Object System.Drawing.Point(115, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSelectAll.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSelectAll.Text = "Zaznacz wszystkie"
    $buttonSelectAll.Add_Click({
    $anyChecked = $false
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($checkBox.Checked) {$anyChecked = $true; break}
        }
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($anyChecked -eq $false){
                $checkBox.Checked = $true
            }else{
                $checkBox.Checked = $false
            }
        }
    })
    $thirdForm.Controls.Add($buttonSelectAll)

    # Dodaj TextBox i przycisk "Zatwierdź"
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(225, 360)
    $textBox.Size = New-Object System.Drawing.Size(120, 20)
    $thirdForm.Controls.Add($textBox)

    $buttonSubmit = New-Object System.Windows.Forms.Button
    $buttonSubmit.Text = "Wprowadź dopisane grupy"
    $buttonSubmit.Location = New-Object System.Drawing.Point(225, 390)
    $buttonSubmit.Size = New-Object System.Drawing.Size(120,25)
    $global:GroupsVariable = $options
    $buttonSubmit.Add_Click({
        $global:GroupsVariable = $global:GroupsVariable + ($textBox.Text).Split(" ")
        foreach ($option in ($textBox.Text).Split(",")) {
            $checkBox = New-Object System.Windows.Forms.CheckBox
            $checkBox.Text = $option
            $checkBox.AutoSize = $true
            $flowLayoutPanel.Controls.Add($checkBox)
        }
        $textBox.Text = ""
    })
    $thirdForm.Controls.Add($buttonSubmit)

    $thirdForm.ShowDialog()
}

function Show-FourthForm{
    # Utwórz formularz z CheckBoxami na podstawie danych z pierwszego formularza
    $fourthForm = New-Object System.Windows.Forms.Form
    $fourthForm.Text = "Dynamiczne CheckBoxy"
    $fourthForm.Size = New-Object System.Drawing.Size(400, 500)
    $fourthForm.StartPosition = "CenterScreen"

    # Utwórz FlowLayoutPanel, aby dynamicznie zarządzać CheckBoxami
    $flowLayoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
    $flowLayoutPanel.Dock = [System.Windows.Forms.DockStyle]::Top
    $flowLayoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
    $flowLayoutPanel.WrapContents = $false
    $flowLayoutPanel.Size = New-Object System.Drawing.Size(200, 350) 
    $flowLayoutPanel.AutoScroll = $true
    $fourthForm.Controls.Add($flowLayoutPanel)

    # Przykładowa lista opcji (możesz ją dostosować do własnych potrzeb)
    $i=[System.Security.AccessControl.FileSystemRights]
    $options = $i::GetValues($i)|select -unique|%{$_}  # Użyj danych z pierwszego formularza

    # Dodaj CheckBoxy i etykiety do FlowLayoutPanel na podstawie listy opcji
    foreach ($option in $options) {
        $checkBox = New-Object System.Windows.Forms.CheckBox
        $checkBox.Text = $option
        $checkBox.AutoSize = $true
        $flowLayoutPanel.Controls.Add($checkBox)
    }

    # Przycisk do zapisywania wybranych opcji
    $buttonSave = New-Object System.Windows.Forms.Button
    $buttonSave.Location = New-Object System.Drawing.Point(5, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSave.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSave.Text = "Zapisz opcje"
    $buttonSave.Add_Click({
        $selectedOptions = $flowLayoutPanel.Controls | Where-Object { $_.Checked -and $_.GetType().Name -eq 'CheckBox' } | ForEach-Object { $_.Text }
        $global:PermissionVariable = $selectedOptions -join ','  # Zapisz wynik w zmiennej globalnej
        [System.Windows.Forms.MessageBox]::Show("Wybrane opcje: $($global:PermissionVariable)", "Zapisane opcje")
        $fourthForm.Close()  # Zamknij drugi formularz po zatwierdzeniu
    })
    $fourthForm.Controls.Add($buttonSave)


     # Dodaj przycisk do zaznaczania wszystkich opcji
    $buttonSelectAll = New-Object System.Windows.Forms.Button
    $buttonSelectAll.Location = New-Object System.Drawing.Point(115, 360)  # Ustaw lokalizację przycisku (x, y)
    $buttonSelectAll.Size = New-Object System.Drawing.Size(100, 40)  # Ustaw rozmiar przycisku (szerokość, wysokość)
    $buttonSelectAll.Text = "Zaznacz wszystkie"
    $buttonSelectAll.Add_Click({
    $anyChecked = $false
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($checkBox.Checked) {$anyChecked = $true; break}
        }
        foreach ($checkBox in $flowLayoutPanel.Controls | Where-Object { $_.GetType().Name -eq 'CheckBox' }) {
            if ($anyChecked -eq $false){
                $checkBox.Checked = $true
            }else{
                $checkBox.Checked = $false
            }
        }
    })
    $fourthForm.Controls.Add($buttonSelectAll)

    # Uruchom formularz
    $fourthForm.ShowDialog()
}

function Show-FifthForm{
    #struktura formularza
    $fifthForm = New-Object System.Windows.Forms.Form
    $fifthForm.Text = "Potwierdzenie"
    $fifthForm.Size = New-Object System.Drawing.Size(300, 100)
    $fifthForm.StartPosition = "CenterScreen"

    #etykieta
    $locallbl = New-Object System.Windows.Forms.Label
    $locallbl.Text = "Would you like to confirm your choices?" 
    $locallbl.Location = New-Object System.Drawing.Point(10,10)
    $locallbl.Size = New-Object System.Drawing.Size(250, 20)
    $fifthForm.Controls.Add($locallbl)

    #przycisk nie
    $buttonNo = New-Object System.Windows.Forms.Button
    $buttonNo.Location = New-Object System.Drawing.Point(80,35)
    $buttonNo.Size = New-Object System.Drawing.Size(60, 25)
    $buttonNo.Text = "No"
    $buttonNo.Add_Click({
        $fifthForm.Close()
    })
    $fifthForm.Controls.Add($buttonNo)

    #przycisk tak
    $buttonYes = New-Object System.Windows.Forms.Button
    $buttonYes.Location = New-Object System.Drawing.Point(10,35)
    $buttonYes.Size = New-Object System.Drawing.Size(60, 25)
    $buttonYes.Text = "Yes"
    $buttonYes.Add_Click({
        $global:ResultVariable
        $global:GroupsVariable
        $global:PermissionVariable
        foreach($dir in $global:ResultVariable.Split(",")){
            foreach($group in $global:GroupsVariable.Split(",")){
                foreach($permission in $global:PermissionVariable.Split(",")){
                    $acl = Get-Acl $dir
                    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$group", $permission, "ContainerInherit, ObjectInherit", "None", "Allow")
                    $acl.AddAccessRule($rule)
                    Set-Acl -Path $dir -AclObject $acl
                } 
            }
        }
        [System.Windows.Forms.MessageBox]::Show("Wybrane opcje: $($global:ResultVariable) `nWybrane grupy: $($global:GroupsVariable) `nWybrane dostępy: $($global:PermissionVariable)", "Zapisane opcje")
        $fifthForm.Close()
    })
    $fifthForm.Controls.Add($buttonYes)
    $fifthForm.ShowDialog()
}

# Utwórz formularz z polami tekstowymi
$firstForm = New-Object System.Windows.Forms.Form
$firstForm.Text = "Pierwszy formularz"
$firstForm.Size = New-Object System.Drawing.Size(400, 400)
$firstForm.StartPosition = "CenterScreen"

#Etykieta nad polem tekstowym
$lblFirstform =  New-Object System.Windows.Forms.Label
$lblFirstform.Location = New-Object System.Drawing.Point(10, 10)
$lblFirstform.Size = New-Object System.Drawing.Size(220, 20)
$lblFirstform.Text = "Wprowadź Ścieżkę do katalogu głównego:"
$firstForm.Controls.Add($lblFirstform)

# Dodaj TextBox i przycisk "Zatwierdź"
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 35)
$textBox.Size = New-Object System.Drawing.Size(200, 20)
$firstForm.Controls.Add($textBox)

$buttonSubmit = New-Object System.Windows.Forms.Button
$buttonSubmit.Text = "Wybierz podfoldery"
$buttonSubmit.Location = New-Object System.Drawing.Point(10, 65)
$buttonSubmit.Size = New-Object System.Drawing.Size(120,25)
$buttonSubmit.Add_Click({
    # Zapisz dane z pierwszego formularza do zmiennej
    $global:FirstFormData = $textBox.Text
    Show-SecondForm -Data $global:FirstFormData  # Wywołaj funkcję do wyświetlenia drugiego formularza
})
$firstForm.Controls.Add($buttonSubmit)


$buttonSelectGroups = New-Object System.Windows.Forms.Button
$buttonSelectGroups.Location = New-Object System.Drawing.Point(130, 65)
$buttonSelectGroups.Size = New-Object System.Drawing.Size(120,25)
$buttonSelectGroups.Text = "Wybierz grupy"
$buttonSelectGroups.Add_Click({
    Show-ThirdForm 
})
$firstForm.Controls.Add($buttonSelectGroups)

$buttonSelectPermisions = New-Object System.Windows.Forms.Button
$buttonSelectPermisions.Location = New-Object System.Drawing.Point(250, 65)
$buttonSelectPermisions.Size = New-Object System.Drawing.Size(120,25)
$buttonSelectPermisions.Text = "Wybierz dostępy"
$buttonSelectPermisions.Add_Click({
    Show-FourthForm
})
$firstForm.Controls.Add($buttonSelectPermisions)

$buttonConfirmChoices = New-Object System.Windows.Forms.Button
$buttonConfirmChoices.Location = New-Object System.Drawing.Point(10, 95)
$buttonConfirmChoices.Size = New-Object System.Drawing.Size(120,25)
$buttonConfirmChoices.Text = "Potwierdź"
$buttonConfirmChoices.Add_Click({
    Show-FifthForm
})
$firstForm.Controls.Add($buttonConfirmChoices)

# Uruchom pierwszy formularz
[System.Windows.Forms.Application]::Run($firstForm)
