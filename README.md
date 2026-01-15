# Introduction
MIMDiscovery is a module containing cmdlets that obtain various pieces of MIM configuration.

# Cmdlets

## Get-MIMConfig

### Description

Discovers which MIM services are running on the local server and returns various configuration details. The cmdlet must be run from an administrative PowerShell prompt. For obtaining MIM Service configuration, the LithnetRMA module is expected to be present.

### Syntax

`Get-MIMConfig`

### Parameters

None

### Examples

`Get-MIMConfig`

`Get-MIMConfig | Out-GridView`

`$c = Get-MIMConfig`  
`$c | ConvertTo-Csv -Delimiter "``t" -NoTypeInformation | clip`

## Get-MIMBindings

### Description

Lists the attribute bindings of a resource.

### Syntax

`Get-MIMBindings -ObjectType <object type name>`

### Parameters

#### ObjectType

Identifies the system name of the ObjectTypeDescription resource for which a list of bound attributes is required.

### Examples

`Get-MIMBindings -ObjectType Person`

`Get-MIMBindings -ObjectType ManagementPolicyRule`

## Get-MIMBoundTo

### Description

Lists the object types that have an attribute binding for the supplied attribute name.

### Syntax

`Get-MIMBoundTo -AttributeType <attribute name>`

### Parameters

#### AttributeType

Identifies the system name of the attribute for which a list of objects to which it is bound is required.

### Examples

`Get-MIMBoundTo -AttributeType AccountName`

## Get-MIMObject

### Description

Retrieves the properties of an object identified either by ObjectID or by DisplayName.

### Syntax

`Get-MIMObject -ObjectID <ObjectID | DisplayName> [-ObjectType <object type name>] [-All]`

### Parameters

#### ObjectID

The ObjectID value of the object or the start of its DisplayName.

#### ObjectType

Identifies the system name of the ObjectTypeDescription resource for ObjectID; the default is Person.

#### All

Shows both populated and unpopulated attributes; the default is to show only populated attributes.

### Examples

`Get-MIMObject -ObjectID 7fb2b853-24f0-4498-9534-4e10589723c4`

`Get-MIMObject -ObjectID Administrators -ObjectType Set`

`Get-MIMObject -ObjectID Administrators -ObjectType Set -All`

## Get-MIMObjectTypes

### Description

Displays a list of all object types in MIM.

### Syntax

`Get-MIMObjectTypes`

### Parameters

None

### Examples

`Get-MIMObjectTypes`

## Get-MPRs

### Description

Displays a list of all management policy rules in MIM.

### Syntax

`Get-MPRs`

### Parameters

None

### Examples

`Get-MPRs`

## Get-Workflows

### Description

Displays a list of all workflows in MIM.

### Syntax

`Get-Workflows`

### Parameters

None

### Examples

`Get-Workflows`

## Get-Sets

### Description

Displays a list of all sets in MIM.

### Syntax

`Get-Sets`

### Parameters

None

### Examples

`Get-Sets`

## Get-WorkflowsMprsAndSetsAll

### Description

Obtain a list of all Action workflows triggered by management policy rules, highlighting whether they are connected to a set transition or request, and showing
set details, set transition type, and action parameters as applicable.

### Syntax

`Get-WorkflowsMprsAndSetsAll`

### Parameters

None

### Examples

`Get-WorkflowsMprsAndSetsAll`  

`Get-WorkflowsMprsAndSetsAll | Out-GridView`

## Get-WorkflowSteps

### Description

List the properties of steps contained in a workflow identified by the ObjectID of the workflow. A list of attributes can be supplied that name the attributes in the XOML definition of the workflow activity; the default list is: 'Name','LocalName', 'Description', 'ControlTitle', 'Script', 'Destination', 'FunctionExpression', and 'FunctionText'.

### Syntax

`Get-WorkflowSteps -ObjectID <object GUID of workflow> [-Attributes <string[]>]`

### Parameters

#### ObjectID

Identifies the ObjectID of the workflow.

#### Attributes

Identifies the list of attributes to obtain from the workflow activity.

### Examples

`Get-WorkflowSteps -ObjectID f45bd03e-713e-48b2-8142-bc4bbc769df0`  
`Get-WorkflowSteps -ObjectID f45bd03e-713e-48b2-8142-bc4bbc769df0 -Attributes @('Name','LocalName','Description','ControlTitle','Script','Destination','FunctionExpression','FunctionText')`

## Get-WorkflowStepsAll

### Description

Enumerates all workflows and lists the properties of steps contained in each workflow.

### Syntax

`Get-WorkflowStepsAll`

### Parameters

None

### Examples

`Get-WorkflowStepsAll`

## Get-MprsAndSetsForWorkflowsWithScripts

### Description

Lists all workflows that contain an activity step that contains a script, highlighting the managemnent policy rule that triggers the workflow and whether the rule is connected to a set transition or request, and showing
set details, set transition type, and action parameters as applicable.

### Syntax

`Get-MprsAndSetsForWorkflowsWithScripts`

### Parameters

#### ScriptAttributeName

Identifies the name of the attribute in the XOML of the activity that contains a script; the default is 'Script'.

### Examples

`Get-MprsAndSetsForWorkflowsWithScripts`  

`Get-MprsAndSetsForWorkflowsWithScripts -ScriptAttributeName 'Code'`
