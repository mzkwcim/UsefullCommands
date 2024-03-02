Add-Type -AssemblyName System.Windows.Forms

# Utwórz formularz
$form = New-Object System.Windows.Forms.Form
$form.Text = "Dynamiczne CheckBoxy"
$form.Size = New-Object System.Drawing.Size(400, 500)
$form.StartPosition = "CenterScreen"

#FlowLayoutPanel, aby dynamicznie zarządzać CheckBoxami
$flowLayoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$flowLayoutPanel.Dock = [System.Windows.Forms.DockStyle]::Top
$flowLayoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$flowLayoutPanel.WrapContents = $false
$flowLayoutPanel.Size = New-Object System.Drawing.Size(200, 350) 
$flowLayoutPanel.AutoScroll = $true
$form.Controls.Add($flowLayoutPanel)

# Przykładowa lista opcji
$options = (gci C:\Users\mzkwcim).FullName

#CheckBoxy i etykiety do FlowLayoutPanel na podstawie listy opcji
foreach ($option in $options) {
    $checkBox = New-Object System.Windows.Forms.CheckBox
    $checkBox.Text = $option
    $checkBox.AutoSize = $true
    $flowLayoutPanel.Controls.Add($checkBox)
}
# Przycisk do zapisywania wybranych opcji
$buttonSave = New-Object System.Windows.Forms.Button
$buttonSave.Location = New-Object System.Drawing.Point(5, 360)  # Ustaw lokalizację przycisku (x, y)
$buttonSave.Size = New-Object System.Drawing.Size(100, 30)  # Ustaw rozmiar przycisku (szerokość, wysokość)
$buttonSave.Text = "Zapisz opcje"
$buttonSave.Add_Click({
    $selectedOptions = $flowLayoutPanel.Controls | Where-Object { $_.Checked -and $_.GetType().Name -eq 'CheckBox' } | ForEach-Object { $_.Text }
    [System.Windows.Forms.MessageBox]::Show("Wybrane opcje: $($selectedOptions -join ', ')", "Zapisane opcje")
})
$form.Controls.Add($buttonSave)

# Uruchom formularz
$form.ShowDialog()


