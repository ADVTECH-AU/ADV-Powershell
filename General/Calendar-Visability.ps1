#This script will allow a user to see the calendar of anyone.

param (
    [string]$Calendar,
    [string]$User
)

Connect-ExchangeOnline 

Set-MailboxFolderPermission -Identity $Calendar':\calendar' -User $User -AccessRights LimitedDetails

#Use this instead to allow everyone to see Subject aswell
#Set-CalendarProcessing -Identity Meetingroom -AddOrganizerToSubject $true -DeleteComments $false -DeleteSubject $false