# Usage:
# Install-BoxstarterPackage -PackageName <this-script-url> -DisableReboots

# TODO: do some verification of the boxstarter install script before running it
# (Open PowerShell as Administrator)
# Set-ExecutionPolicy Bypass -Scope Process -Force
# . { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force

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
# Enable-RemoteDesktop  # TODO: broken on 11?
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableOpenFileExplorerToQuickAccess -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder -EnableShowRibbon
# TODO: Boxstarter Dock Left may be broken on Win11
# Set-BoxstarterTaskbarOptions -Dock Left

# Set-ExecutionPolicy Unrestricted -Scope CurrentUser

# TODO: remove built-in bloatware:
# TikTok, CandyCrush, Sotify, Solitare, Disney+, Clipchamp, Prime Video, Instagram, Facebook
# some may be added back later based on profile, but definitely don't have them by default
# TODO: some of these, like Spotify, should not be installed from an Admin prompt?

# Exit  # TODO: for testing

$wapps = {@()}.Invoke()
# Once WinGet supports zip files and other installation methods, chocolatey can
# likely be retired, but until then there are still a few items we require from
# it.
$capps = {@()}.Invoke()

# TODO: lots of apps in here, like SublimeText, whose install names don't match their list names later on when we query for them, causing them to be re-installed over and over

# Core:
$wapps.Add(@{name = "Google.Chrome"})
$wapps.Add(@{name = "Mozilla.Firefox"})
$wapps.Add(@{name = "Google.Drive"})
$wapps.Add(@{name = "7zip.7zip"})
$wapps.Add(@{name = "VideoLAN.VLC"})
$wapps.Add(@{name = "Microsoft.Teams"})
$wapps.Add(@{name = "Microsoft.Office"})
$wapps.Add(@{name = "Zoom.Zoom"})
$wapps.Add(@{name = "Malwarebytes.Malwarebytes"})
$wapps.Add(@{name = "Foxit.FoxitReader"})  # TODO: this or adobereader?
# pdfcreator
$capps.Add("paint.net")
$wapps.Add(@{name = "TimKosse.FileZilla.Client"})
$wapps.Add(@{name = "Apple.iTunes"})
$wapps.Add(@{name = "CodecGuide.K-LiteCodecPack.Full"})
$wapps.Add(@{name = "Spotify.Spotify"})
$wapps.Add(@{name = "Dropbox.Dropbox"})
$wapps.Add(@{name = "SlackTechnologies.Slack"})
$wapps.Add(@{name = "voidtools.Everything"})
# TODO: this may not be necessary on Win11 now?
# winget install --exact AntibodySoftware.WizMouse
$wapps.Add(@{name = "AntibodySoftware.WizTree"})
$wapps.Add(@{name = "QL-Win.QuickLook"})
$wapps.Add(@{name = "Streamlink.Streamlink"})
$wapps.Add(@{name = "Streamlink.Streamlink.TwitchGui"})
# TODO: chatterino
# winget install --exact Twitch.Twitch
$wapps.Add(@{name = "GPSoftware.DirectoryOpus"})
# TODO: decide if PowerToys Run is good enough
$wapps.Add(@{name = "OliverSchwendener.ueli"})
# things
# twitter client
# vmware remote console
# flow
# adium
# icloud
# jre
# netflix
# driver sweeper
$wapps.Add(@{name = "IDRIX.VeraCrypt"})
$wapps.Add(@{name = "Element.Element"})
$wapps.Add(@{name = "Cockos.LICEcap"})
$wapps.Add(@{name = "Resilio.ResilioSync"})
$wapps.Add(@{name = "TorProject.TorBrowser"})
# vpn
# backups
$wapps.Add(@{name = "WireGuard.WireGuard"})
# using choco's 1password for v7.x
$capps.Add("1password")
# $wapps.Add(@{name = "AgileBits.1Password"})
$wapps.Add(@{name = "Anki.Anki"})
$wapps.Add(@{name = "DelugeTeam.Deluge"})
$wapps.Add(@{name = "flux.flux"})
$wapps.Add(@{name = "HandBrake.HandBrake"})
$wapps.Add(@{name = "Microsoft.MouseWithoutBorders"})
$wapps.Add(@{name = "PeterBClements.QuickPar"})
$wapps.Add(@{name = "Piriform.Defraggler"})
$wapps.Add(@{name = "Piriform.Recuva"})
$wapps.Add(@{name = "RevoUninstaller.RevoUninstaller"})
$wapps.Add(@{name = "Netflix"; id = "9WZDNCRFJ3TJ"; source = "msstore"})

# Artistry:
$wapps.Add(@{name = "Inkscape.Inkscape"})
$wapps.Add(@{name = "Audacity.Audacity"})
$wapps.Add(@{name = "BlenderFoundation.Blender"})
$wapps.Add(@{name = "KDE.Krita"})
$wapps.Add(@{name = "darktable.darktable"})
$wapps.Add(@{name = "Figma.Figma"})
$wapps.Add(@{name = "MiXXX.MiXXX"})
$wapps.Add(@{name = "Meltytech.Shotcut"})
$wapps.Add(@{name = "Autodesk.sketchbook"})
# natron
$wapps.Add(@{name = "OBSProject.OBSStudio"})
$wapps.Add(@{name = "VB-Audio.Voicemeeter.Banana"})
$wapps.Add(@{name = "Cockos.REAPER"})
# davinci resolve

# Dev Tools:
$wapps.Add(@{name = "Notepad++.NotePad++"})
# TODO: which dotnet runtime/compiler to get? Microsoft.dotnet?
$wapps.Add(@{name = "Microsoft.PowerShell"})
$capps.Add("powershell-core")
$wapps.Add(@{name = "Sysinternals Suite"; id = "9P7KNL5RWT25"; source = "msstore"})
$wapps.Add(@{name = "Lexikos.AutoHotkey"})
$wapps.Add(@{name = "Microsoft.VisualStudioCode"})
# cinst winlogbeat
$wapps.Add(@{name = "Microsoft.WindowsTerminal"})
$wapps.Add(@{name = "WiresharkFoundation.Wireshark"})
$wapps.Add(@{name = "Oracle.Virtualbox"})
# cinst virtualbox.extensionpack
$wapps.Add(@{name = "Microsoft.PowerToys"})
$wapps.Add(@{name = "Docker.DockerDesktop"})
$capps.Add("cmder")
$wapps.Add(@{name = "SublimeHQ.SublimeMerge"})
$wapps.Add(@{name = "SublimeHQ.SublimeText.4"})
$capps.Add("starship")
$wapps.Add(@{name = "gerardog.gsudo"})
$wapps.Add(@{name = "WinMerge.WinMerge"})
$wapps.Add(@{name = "Insomnia.Insomnia"})
$wapps.Add(@{name = "Insomnia.InsomniaDesigner"})
$wapps.Add(@{name = "WinDbg Preview"; id = "9PGJGD53TN86"; source = "msstore"})
$wapps.Add(@{name = "Google.AndroidStudio"})
$wapps.Add(@{name = "Hashicorp.Vagrant"})
$wapps.Add(@{name = "PuTTY.PuTTY"})
$wapps.Add(@{name = "RealVNC.VNCViewer"})
$wapps.Add(@{name = "WinSCP.WinSCP"})
# TODO: eventually when need .net dev, evaluate: codetrack, linqpad, nuget package explorer, fusion+
$wapps.Add(@{name = "AndreasWascher.RepoZ"})
$capps.Add("godot")
$wapps.Add(@{name = "UnityTechnologies.Unity.2021"})
# dash/zeal
# ghidra
# vmware workstation
# Some tools are duplicated in Windows and WSL, due to their need in native development
$wapps.Add(@{name = "Git.Git"})
# jdk
# python

# WSL:
# see available distros with: wsl --list --online
# TODO: idempotence check
# wsl --install -d Debian  # TODO: arch?
# wsl --set-default-version 2
# wsl --setdefault Debian
# TODO: setup initial username/password besides root, window will prompt after install

# Gaming:
$capps.Add("gamesavemanager")
$wapps.Add(@{name = "NexusMods.Vortex"})
$wapps.Add(@{name = "Discord.Discord"})
# TODO: is emulationstation a frontend or does it include all the emulators?
# winget install --exact DolphinEmulator.Dolphin
$wapps.Add(@{name = "Valve.Steam"})
$wapps.Add(@{name = "GOG.Galaxy"})
$capps.Add("battle.net")
$capps.Add("retroarch")
$wapps.Add(@{name = "Emulationstation.Emulationstation"})
$wapps.Add(@{name = "Codeusa.BorderlessGaming"})
$wapps.Add(@{name = "EpicGames.EpicGamesLauncher"})
$wapps.Add(@{name = "ElectronicArts.EADesktop"})
$wapps.Add(@{name = "Ubisoft.Connect"})
# rockstar launcher
$capps.Add("legendary")
# TODO: valorant, legends of runeterra, riot client?
$wapps.Add(@{name = "Xbox"; id = "9MV0B5HZVK9Z"; source = "msstore"})
$wapps.Add(@{name = "Xbox Console Companion"; id = "9WZDNCRFJBD8"; source = "msstore"})
# xbox game bar should come by default
# guild wars 2
# samsung hmd odyssey+ setup
# zam minion
# gamecompanion
# playnite
$wapps.Add(@{name = "FlawlessWidescreen.FlawlessWidescreen"})
$wapps.Add(@{name = "LOOT.LOOT"})  # TODO: boss?
$wapps.Add(@{name = "Mumble.Mumble"})
$wapps.Add(@{name = "PlayStation.PSRemotePlay"})
$wapps.Add(@{name = "Mixed Reality Portal"; id = "9NG1H8B3ZC7M"; source = "msstore"})
# HMD Odyssey Plus?
$wapps.Add(@{name = "Xbox Accessories"; id = "9NBLGGH30XJ3"; source = "msstore"})

# Performance:
# $capps.Add("3dmark")
# $capps.Add("pcmark8")
# userbenchmark
# memtest86
# thaiphoon burner
$capps.Add("cinebench")
$capps.Add("twitch-bandwidth-tester")
# winget install --exact CPUID.CPU-Z
$wapps.Add(@{name = "CPUID.CPU-Z.MSI"})
$wapps.Add(@{name = "CPUID.HWMonitor"})
$wapps.Add(@{name = "TechPowerUp.GPU-Z"})
$capps.Add("speedfan")

# Build Specific:
$capps.Add("msiafterburner")
# ryzen master
$capps.Add("amd-ryzen-chipset")
$wapps.Add(@{name = "RyzenControllerTeam.RyzenController"})
$wapps.Add(@{name = "MSI Center"; id = "9NVMNJCR03XV"; source = "msstore"})
# trident z lighting control
# l-connect
$wapps.Add(@{name = "NZXT.CAM"})
$capps.Add("nvidia-display-driver")
$wapps.Add(@{name = "Nvidia.GeForceExperience"})
$wapps.Add(@{name = "Logitech.GHUB"})
# astro command center
# avermedia recentral
$wapps.Add(@{name = "Microsoft.MouseandKeyboardCenter"})
# nahimic from msstore
# realtek audio control from msstore
# winget install --exact Logitech.Options  # TODO: for builds with MX Master
# Logitech G500S still not available from G HUB
$capps.Add("logitechgaming")
# TODO: change to
# $wapps.Add(@{name = "Logitech.LGS"})

Foreach ($app in $wapps) {
    $id = $app.name
    if ($app.id -ne $null) {
        $WingetArgs = @("--id", $app.id)
    } else {
        $WingetArgs = @("--exact", $app.name)
    }

    $listText = winget list --accept-source-agreements --query $id --exact
    if ([String]::Join("", $listText).Contains($id)) {
        continue
    }

    if ($app.source -ne $null) {
        winget install @WingetArgs --source $app.source --accept-source-agreements --accept-package-agreements
    } else {
        winget install @WingetArgs --accept-source-agreements --accept-package-agreements
    }
}

# $listText = choco list --local
$listText = clist --local
Foreach ($app in $capps) {
    if ([String]::Join("", $listText).Contains($app)) {
        continue
    }
    cinst --cacheLocation="c:\temp" --yes $app
    # depending on the formula, may have to resort to manual checks and some combo of:
    # --ignore-checksum --allow-empty-checksums --allow-empty-checksums-secure
}

# winget upgrade
# winget upgrade -all
# winget import -i <list.json>
# cup all
# choco upgrade all

Enable-UAC

# After success:
# Restart-Computer

# Manual Configuration:

# TODO:
# Add the following to the end of ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 'Invoke-Expression (&starship init powershell)'

# BIOS
# CPU Overclocking > SVM ON

# L-Connect

# f.lux
# Enter zip code

# Docker Desktop
# TODO: must enable hardware assisted virt and DEP in BIOS

# GOG Galaxy
# Settings > General > Uncheck Launch at system startup

# Discord
# Settings > Windows Settings > Uncheck Open Discord

# Nvidia Control Panel
# Gsync in both fullscreen and windowed mode

# MSI Center
# Feature Sets: Mystic Light

# Epic Games
# https://old.reddit.com/r/EpicGamesPC/comments/ie63nl/how_to_detect_existing_installations_of_game/gbhr1x7/

# Settings

# System
# Activate now

# Display
# Arrange monitor layout
# Set primary monitor to 144 hz refresh rate

# Personalization
# Taskbar
# Uncheck Show my taskbar on all displays
# TODO: can't do above until 11 allows taskbar to be moved, so until then:
# When using multiple displays, show my taskbar apps on: All taskbars

# Desktop App Groups/Folders:
# - Game
# - Design
# - Develop
# - Control
# - Talk
# - Listen
# - Watch
# - Work
# - Share
# - Look Up
# - Configure
# - Utilities

# Taskbar Pins:
# Start, Search, Desktops, Talk, Explorer, Store, Firefox, Terminal, Code
