
$title = "Daily Builds Main Menu"
$message = "Choose your build option below: "

$fullBuild = New-Object System.Management.Automation.Host.ChoiceDescription "&Full Build", `
    "Dev & Integrations pull with 'clean;compile;refresh"

$wwwBuild = New-Object System.Management.Automation.Host.ChoiceDescription "&WWW Build", `
    "Builds WWW only with 'clean;compile;refresh"

$status = New-Object System.Management.Automation.Host.ChoiceDescription "&Check Status", `
    "Provides information about the current status of the server"    

$repair = New-Object System.Management.Automation.Host.ChoiceDescription "&Repair Build", `
    "Repairs a build by running: hg revert -a & hg update -C"

$viewLog = New-Object System.Management.Automation.Host.ChoiceDescription "&View Build Log", `
    "Opens the log generated during www build"
    
$fixIntJunct = New-Object System.Management.Automation.Host.ChoiceDescription "&Repair Integrations Junctions", `
    "Repairs the integrations junction issues"
    
$acceptanceBuild = New-Object System.Management.Automation.Host.ChoiceDescription "&Acceptance Builds", `
    "Gives various acceptance build options that are available"

$custom = New-Object System.Management.Automation.Host.ChoiceDescription "&Custom WWW Builds", `
    "Allows for custom www build options to be passed in instead of the defaults"

$options = [System.Management.Automation.Host.ChoiceDescription[]]($fullBuild, $wwwBuild, $status, $repair, $viewLog, $fixIntJunct, $acceptanceBuild, $custom)

$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

switch ($result)
    {
        0 {"You selected: Full Build."}
        1 {"You selected: WWW Build"}
        2 {"You selected: Check Status"}
        3 {"You selected: Repair Build"} 
        4 {"You selected: View Build log"}
        5 {"You selected: Repair Integrations"}
        6 {"You selected: Acceptance Build"}
        7 {"You selected: Custom"}
    }