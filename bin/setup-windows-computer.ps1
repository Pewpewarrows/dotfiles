# Usage:
# Install-BoxstarterPackage -PackageName <this-script-url> -DisableReboots

# TODO: do some verification of the boxstarter install script before running it
# . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

# Once WinGet supports zip files and other installation methods, chocolatey can
# likely be retired, but until then there are still a few items we require from
# it.

# Install winget
$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
    Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

    $releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1

    Add-AppxPackage -Path $latestRelease.browser_download_url

    # alternatively, can ask for user input on the install...
    # Start-Process ms-appinstaller:?source=https://aka.ms/getwinget
    # Read-Host -Prompt "Press enter to continue..."
}

Disable-UAC  # only for this script, re-enabled at end

Enable-MicrosoftUpdate
Install-WindowsUpdate -Full -acceptEula

Disable-BingSearch
Enable-RemoteDesktop
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableOpenFileExplorerToQuickAccess -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder -EnableShowRibbon
Set-BoxstarterTaskbarOptions -Dock Left

# Set-ExecutionPolicy Bypass -Scope Process -Force
# Set-ExecutionPolicy Unrestricted -Scope CurrentUser

# TODO: remove built-in bloatware like TikTok and CandyCrush

# Exit  # TODO: for testing

# Core:
winget install --exact Google.Chrome
winget install --exact Mozilla.Firefox
winget install --exact Google.Drive
winget install --exact 7zip.7zip
winget install --exact VideoLAN.VLC
winget install --exact Microsoft.Teams  # TODO: is this included in office?
winget install --exact Microsoft.Office
winget install --exact Zoom.Zoom
winget install --exact Malwarebytes.Malwarebytes
winget install --exact Foxit.FoxitReader  # TODO: this or adobereader?
# pdfcreator
cinst paint.net  # not yet on winget
winget install --exact TimKosse.FileZilla.Client
winget install --exact Apple.iTunes
winget install --exact CodecGuide.K-LiteCodecPack.Full
winget install --exact Spotify.Spotify
winget install --exact Dropbox.Dropbox
winget install --exact SlackTechnologies.Slack
winget install --exact voidtools.Everything
winget install --exact AntibodySoftware.WizMouse
winget install --exact AntibodySoftware.WizTree
winget install --exact QL-Win.QuickLook
winget install --exact Streamlink.Streamlink
winget install --exact Streamlink.Streamlink.TwitchGui
# TODO: chatterino
# winget install --exact Twitch.Twitch
# TODO: only pick one of these three
winget install --exact GPSoftware.DirectoryOpus
# winget install --exact Ghisler.TotalCommander
# winget install --exact alexx2000.DoubleCommander
# TODO: only pick one of these two
winget install --exact Wox.Wox
# winget install --exact OliverSchwendener.ueli
# things
# twitter client
# vmware remote console
# flow
# adium
# game streams
# icloud
# jre
# netflix
# driver sweeper
winget install --exact IDRIX.VeraCrypt
winget install --exact Element.Element
winget install --exact Cockos.LICEcap
winget install --exact Resilio.ResilioSync
winget install --exact TorProject.TorBrowser
winget install --exact WireGuard.WireGuard
winget install --exact AgileBits.1Password
winget install --exact Anki.Anki
winget install --exact DelugeTeam.Deluge
winget install --exact flux.flux
winget install --exact HandBrake.HandBrake
winget install --exact Microsoft.MouseandKeyboardCenter
winget install --exact Microsoft.MouseWithoutBorders
winget install --exact PeterBClements.QuickPar
winget install --exact Piriform.Defraggler
winget install --exact Piriform.Recuva
winget install --exact RevoUninstaller.RevoUninstaller
winget install --exact VB-Audio.Voicemeeter.Banana

# Artistry:
winget install --exact Inkscape.Inkscape
winget install --exact Audacity.Audacity
winget install --exact BlenderFoundation.Blender
winget install --exact KDE.Krita
winget install --exact darktable.darktable
winget install --exact Figma.Figma
winget install --exact MiXXX.MiXXX
winget install --exact Meltytech.Shotcut
winget install --exact Autodesk.sketchbook
# natron
# obs studio
# davinci resolve

# Dev Tools:
winget install --exact Notepad++.NotePad++
# TODO: which dotnet runtime/compiler to get? Microsoft.dotnet?
winget install --exact Microsoft.PowerShell
cinst powershell-core  # not yet on winget
winget install --exact Sysinternals.Suite --source msstore  # TODO: name is likely wrong
winget install --exact Lexikos.AutoHotkey
winget install --exact Microsoft.VisualStudioCode
# cinst winlogbeat
winget install --exact Microsoft.WindowsTerminal
winget install --exact WiresharkFoundation.Wireshark
winget install --exact Oracle.Virtualbox
# cinst virtualbox.extensionpack
winget install --exact Microsoft.PowerToys
winget install --exact Docker.DockerDesktop
cinst cmder  # not yet on winget
winget install --exact SublimeHQ.SublimeMerge
winget install --exact SublimeHQ.SublimeText.4
cinst starship  # not yet on winget
winget install --exact geardog.gsudo
winget install --exact WinMerge.WinMerge
winget install --exact Insomnia.Insomnia
winget install --exact Insomnia.InsomniaDesigner
winget install --exact Microsoft.WinDbg --source msstore
winget install --exact Google.AndroidStudio
winget install --exact Hashicorp.Vagrant
winget install --exact PuTTY.PuTTY
winget install --exact RealVNC.VNCViewer
winget install --exact WinMerge.WinMerge
winget install --exact WinSCP.WinSCP
# TODO: eventually when need .net dev, evaluate: codetrack, linqpad, nuget package explorer, fusion+
# TODO: repoz
# godot
# dash/zeal
# ghidra
# vmware workstation
# Some tools are duplicated in Windows and WSL, due to their need in native development
# git
# jdk
# python

# WSL:
# see available distros with: wsl --list --online
wsl --install -d Debian  # TODO: arch?
wsl --set-default-version 2
wsl --setdefault Debian
# TODO: setup initial username/password besides root

# Gaming:
cinst gamesavemanager
winget install --exact NexusMods.Vortex
winget install --exact Discord.Discord
# TODO: is emulationstation a frontend or does it include all the emulators?
# winget install --exact DolphinEmulator.Dolphin
winget install --exact Valve.Steam
winget install --exact GOG.Galaxy
winget install --exact Blizzard.BattleNet  # TODO: this may be msstore
cinst retroarch
# cinst logitechgaming
# winget install --exact Logitech.Options
winget install --exact Emulationstation.Emulationstation
winget install --exact Codeusa.BorderlessGaming
winget install --exact EpicGames.EpicGamesLauncher
winget install --exact ElectronicArts.EADesktop
winget install --exact Ubisoft.Connect
# rockstar launcher
cinst legendary
# TODO: valorant, legends of runeterra, riot client?
winget install --exact OBSProject.OBSStudio
# xbox
# xbox game pass
# xbox smartglass 360/one
# guild wars 2
# samsung hmd odyssey+ setup
# uplay, ,
# logitech gaming
# zam minion
# gamecompanion
winget install --exact FlawlessWidescreen.FlawlessWidescreen
winget install --exact LOOT.LOOT  # TODO: boss?
winget install --exact Mumble.Mumble
winget install --exact PlayStation.PSRemotePlay

# Performance:
cinst 3dmark
cinst pcmark8
# userbenchmark
# memtest86
# thaiphoon burner
# cinebench
cinst twitch-bandwidth-tester
# winget install --exact CPUID.CPU-Z
winget install --exact CPUID.CPU-Z.MSI
winget install --exact CPUID.HWMonitor
winget install --exact TechPowerUp.GPU-Z

# Build Specific:
# msi afterburner
# ryzen master
winget install --exact RyzenControllerTeam.RyzenController
# msi center (older: dragon center)
# trident z lighting control
# l-connect
winget install --exact NZXT.CAM
cinst nvidia-display-driver
winget install --exact Nvidia.GeForceExperience
# logitech capture
# astro command center
# avermedia recentral

# winget upgrade
# winget upgrade -all
# winget import -i <list.json>

Enable-UAC
