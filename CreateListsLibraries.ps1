# modify URL for target site
Connect-PnPOnline -Url https://xxxx.sharepoint.com/sites/xxxx


$list_url = "APApprovers"
$list_title = "AP Approvers"
New-PnPList -Title $list_title -url $list_url -Template Custom 
Add-PnPField -List $list_title -Type User -InternalName "ApproverName" -DisplayName "Approver Name" -Required -AddToDefaultView 


$list_url = "GLApprovers"
$list_title = "GL Approvers"
New-PnPList -Title $list_title -url  $list_url -Template Custom
Add-PnPField -List $list_title -Type User -InternalName "ApproverName" -DisplayName "Approver Name" -Required -AddToDefaultView


$list_url = "ManagerialApprovers"
$list_title = "Managerial Approvers"
New-PnPList -Title $list_title  -url $list_url -Template Custom
Add-PnPField -List $list_title -Type User -InternalName "Manager" -DisplayName "Manager" -Required -AddToDefaultView



$list_url = "AccrualRequests"
$list_title = "Accrual Requests"
New-PnPList -Title $list_title -url $list_url -Template Custom  -EnableVersioning
Set-PnPField -List $list_title -Identity Title -Values @{Title = "Description" } -UpdateExistingLists 
Add-PnPField -List $list_title -Type Note -InternalName "Comments" -DisplayName "Comments" 
Add-PnPField -List $list_title -Type Note -InternalName "ReviewerComments" -DisplayName "Reviewer Comments" 
# Need to update ReviewComments for appendX - currently, need to manually set append behavior
Add-PnPField -List $list_title -Type Choice -InternalName "State" -DisplayName "State"  -Required -Choices "Draft","In Progress","Approved","Rejected" -AddToDefaultView
Add-PnPField -List $list_title -Type Choice -InternalName "Status" -DisplayName "Status"  -Required  -Choices "Draft","Awaiting AP Team Review","Rejected by AP Team", "Awaiting Management Approval", "Rejected by Management", "Awaiting GL Team Approval", "Rejected by GL Team","Approved" -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "JournalName" -DisplayName "Journal Name" 
Add-PnPField -List $list_title -Type Text -InternalName "JournalDescription" -DisplayName "Journal Description"
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml ='<Field Type="DateTime" DisplayName="Entry Date" Viewable="TRUE" Required="TRUE" EnforceUniqueValues="FALSE" Indexed="FALSE" Format="DateOnly"  FriendlyDisplayFormat="Disabled" ID="' + $lookupColumnId + '" Name="EntryDate"></Field>'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title 
$lookupListName = "Managerial Approvers"
$lookupList = Get-PnPList -Identity $lookupListName
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml = '<Field Type="Lookup" DisplayName="Managerial Approver" Name="ManagerialApprover" Viewable="TRUE" ShowField="Title" EnforceUniqueValues="FALSE" Required="FALSE" ID="' + $lookupColumnId + '" RelationshipDeleteBehavior="None" List="' + $lookupList.Id + '" />'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title



$list_url = "AccrualRequestListItems"
$list_title = "Accrual Request List Items"
New-PnPList -Title $list_title -url $list_url -Template Custom 
Add-PnPField -List $list_title -Type Text -InternalName "TransactionText" -DisplayName "Transaction Text" -Required -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "Reversing" -DisplayName "Reversing"  -Required -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "Currency" -DisplayName "Currency" -Required -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "AccountType" -DisplayName "Account Type" -Required -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "CostCenter" -DisplayName "Cost Center" -Required -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "Market" -DisplayName "Market" -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "Account" -Required -DisplayName "Account" -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "Reaccrual" -Required -DisplayName "Reaccrual" -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "Customer" -DisplayName "Customer"
Add-PnPField -List $list_title -Type Text -InternalName "Category" -DisplayName "Category"
Add-PnPField -List $list_title -Type Text  -InternalName "CommercialLine" -DisplayName "Commercial Line"
Add-PnPField -List $list_title -Type Text  -InternalName "Project" -DisplayName "Project"
Add-PnPField -List $list_title -Type Text -InternalName "PLLine" -DisplayName "PLLine"
Add-PnPField -List $list_title -Type Number  -InternalName "Debit" -DisplayName "Debit" -AddToDefaultView
Add-PnPField -List $list_title -Type Number  -InternalName "Credit" -DisplayName "Credit" -AddToDefaultView
Add-PnPField -List $list_title -Type Text  -InternalName "OffsetAccountType" -DisplayName "Offset Account Type"
Add-PnPField -List $list_title -Type Text  -InternalName "OffsetAccount" -DisplayName "Offset Account"
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml ='<Field Type="DateTime" DisplayName="Reversing Date" Name="ReversingDate" Viewable="TRUE" Required="TRUE" EnforceUniqueValues="FALSE" Indexed="FALSE" Format="DateOnly"  FriendlyDisplayFormat="Disabled" ID="' + $lookupColumnId + '"> </Field>'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml ='<Field Type="DateTime" DisplayName="Date" Name="Date" Viewable="TRUE" Required="TRUE" EnforceUniqueValues="FALSE" Indexed="FALSE" Format="DateOnly"  FriendlyDisplayFormat="Disabled" ID="' + $lookupColumnId + '"> </Field>'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title
$lookupListName = "Accrual Requests"
$lookupList = Get-PnPList -Identity $lookupListName
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml = '<Field Type="Lookup" DisplayName="RequestID" Name="RequestID" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="TRUE" ShowField="ID" ID="' + $lookupColumnId + '" RelationshipDeleteBehavior="Cascade" List="' + $lookupList.Id + '" />'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title


$list_url = "AccrualRequestSupportingDocuments"
$list_title = "Accrual Request Supporting Documents"
New-PnPList -Title $list_title -url $list_url -Template DocumentLibrary
Add-PnPField -List $list_title -Type Choice -InternalName "DocumentType" -DisplayName "Document Type" -AddToDefaultView  -Required -Choices "Invoice","Quote","Co-Op Letter","Other"
$lookupListName = "Accrual Requests"
$lookupList = Get-PnPList -Identity $lookupListName
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml = '<Field Type="Lookup" DisplayName="RequestID" Name="RequestID" EnforceUniqueValues="FALSE" Indexed="TRUE" Required="TRUE" ShowField="ID" ID="' + $lookupColumnId + '" RelationshipDeleteBehavior="Cascade" List="' + $lookupList.Id + '" />'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title



$list_url = "AccrualRequestsHistory"
$list_title = "Accrual Requests History"
New-PnPList -Title $list_title -url $list_url -Template Custom
Add-PnPField -List $list_title -Type Text -InternalName "StartStatus" -DisplayName "Start Status" -AddToDefaultView -Required
Add-PnPField -List $list_title -Type Text -InternalName "NewStatus" -DisplayName "New Status" -AddToDefaultView -Required
Add-PnPField -List $list_title -Type Text -InternalName "ActionBy" -DisplayName "Action By" -AddToDefaultView -Required
Add-PnPField -List $list_title  -Type Text -InternalName "ActionDept" -DisplayName "Action Dept" -AddToDefaultView -Required
Add-PnPField -List $list_title -Type Integer -InternalName   "RequestID" -DisplayName "RequestID"  -AddToDefaultView -Required 



$list_url = "AccrualRequestCSVs"
$list_title = "Accrual Request CSVs"
New-PnPList -Title $list_title -url $list_url -Template DocumentLibrary
Add-PnPField -List $list_title -Type User -InternalName "RequestedBy" -DisplayName "RequestedBy" -Required     -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "JournalNumber" -DisplayName "Journal Number" -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "Log" -DisplayName "Log" -AddToDefaultView
Add-PnPField -List $list_title -Type Integer -InternalName   "RequestID" -DisplayName "RequestID"  -AddToDefaultView
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml ='<Field Type="DateTime" DisplayName="Posting Date" Name="PostingDate" Viewable="TRUE" Required="FALSE" EnforceUniqueValues="FALSE" Indexed="FALSE" Format="DateOnly"  FriendlyDisplayFormat="Disabled" ID="' + $lookupColumnId + '"> </Field>'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title


$list_url = "AccrualRequestWorksheets"
$list_title = "Accrual Request Worksheets"
New-PnPList -Title $list_title -url $list_url -Template DocumentLibrary
Add-PnPField -List $list_title -Type User -InternalName "RequestedBy" -DisplayName "Requested By" -Required     -AddToDefaultView
Add-PnPField -List $list_title -Type Text -InternalName "JournalNumber" -DisplayName "Journal Number" -AddToDefaultView
Add-PnPField -List $list_title -Type Integer -InternalName   "RequestID" -DisplayName "RequestID"  -AddToDefaultView
$lookupColumnId = [guid]::NewGuid().Guid
$schemaXml ='<Field Type="DateTime" DisplayName="Posting Date" Name="PostingDate" Viewable="TRUE" Required="FALSE" EnforceUniqueValues="FALSE" Indexed="FALSE" Format="DateOnly"  FriendlyDisplayFormat="Disabled" ID="' + $lookupColumnId + '"> </Field>'
Add-PnPFieldFromXml -FieldXml $schemaXml  -List $list_title

$list_url = "PostingStatus"
$list_title = "Posting Status"
New-PnPList -Title $list_title -url $list_url -Template DocumentLibrary


#Post Install Adjustments
#RequestID Lookup Fields - set display also for description
#Set Accrual Request ReviewerComments field for Append

