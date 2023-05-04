#This script will force a sync of Autopilot devices in Intune. This is useful if you have a device that is not showing up in the Autopilot device list in Intune.

#connect to MS-Graph with your creds
connect-msgraph
#run a sync from a web request.
Invoke-MSGraphRequest -HttpMethod POST -Url "https://graph.microsoft.com/beta/deviceManagement/windowsAutopilotSettings/sync"