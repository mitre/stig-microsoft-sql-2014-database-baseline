control "V-67415" do
  title "Trace or Audit records must be generated  when unsuccessful attempts
to access categorized information (e.g., classification levels/security levels)
occur."
  desc  "Changes in categorized information must be tracked. Without an audit
trail, unauthorized access to protected data could go undetected.

    To aid in diagnosis, it is necessary to keep track of failed attempts in
addition to the successful ones.

    For detailed information on categorizing information, refer to FIPS
Publication 199, Standards for Security Categorization of Federal Information
and Information Systems, and FIPS Publication 200, Minimum Security
Requirements for Federal Information and Information Systems.

    Use of SQL Server Audit is recommended.  All features of SQL Server Audit
are available in the Enterprise and Developer editions of SQL Server 2014.  It
is not available at the database level in other editions.  For this or legacy
reasons, the instance may be using SQL Server Trace for auditing, which remains
an acceptable solution for the time being.  Note, however, that Microsoft
intends to remove most aspects of Trace at some point after SQL Server 2016.
Note also that Trace does not support auditing of SELECT statements, whereas
Audit does.

    Since Trace does not provide for tracking SELECT statements, it is
necessary to provide this tracking at the application level, if Trace is used
for audit purposes.

    Use of SQL Server Audit's SCHEMA_OBJECT_ACCESS_GROUP causes capture of all
accesses, successful and otherwise, to all schema-scoped objects.  The
[Succeeded] column in the audit output indicates the success or failure of the
attempted action.  Be aware, however, that it may report True in some cases
where one would intuitively expect False.  For example, SELECT 1/0 FROM
SYS.ALL_OBJECTS will appear in the audit trail as successful, if the user has
permission to perform that action, even though it contains an invalid
expression.  Some other actions that one would consider failures (such as
selecting from a table that does not exist) may not appear at all.
  "
  impact 0.7
  tag "gtitle": "SRG-APP-000494-DB-000345"
  tag "gid": "V-67415"
  tag "rid": "SV-81905r2_rule"
  tag "stig_id": "SQL4-00-035900"
  tag "fix_id": "F-73529r1_fix"
  tag "cci": ["CCI-000172"]
  tag "nist": ["AU-12 c", "Rev_4"]
  tag "false_negatives": nil
  tag "false_positives": nil
  tag "documentable": false
  tag "mitigations": nil
  tag "severity_override_guidance": false
  tag "potential_impacts": nil
  tag "third_party_tools": nil
  tag "mitigation_controls": nil
  tag "responsibility": nil
  tag "ia_controls": nil
  tag "check": "Review the system documentation to determine whether it is
required to track categories of information, such as classification or
sensitivity level.  If it is not, this is not applicable (NA).

If neither SQL Server Audit nor SQL Server Trace is in use for audit purposes,
this is a finding.

If SQL Server Trace is in use for audit purposes, review the application(s)
using the database to verify that all SELECT actions on categorized data,
including unsuccessful attempts, are being audited;  and that the tracking
records are written to the SQL Server Trace used for audit purposes.  If not,
this is a finding.


If SQL Server Audit is in use, proceed as follows.

The basic SQL Server Audit configuration provided in the supplemental file
Audit.sql uses the broad, server-level audit action group
SCHEMA_OBJECT_ACCESS_GROUP for this purpose.  SQL Server Audit's flexibility
makes other techniques possible.

If an alternative technique is in use and demonstrated effective, this is not a
finding.

Determine the name(s) of the server audit specification(s) in use.

To look at audits and audit specifications, in Management Studio's object
explorer, expand
<server name> >> Security >> Audits
and
<server name> >> Security >> Server Audit Specifications.
Also,
<server name> >> Databases >> <database name> >> Security >> Database Audit
Specifications.

Alternatively, review the contents of the system views with \"audit\" in their
names.

Run the following to verify that all SELECT, INSERT, UPDATE, and DELETE actions
on tables and views are being audited:
USE [master];
GO
SELECT * FROM sys.server_audit_specification_details WHERE
server_specification_id =
(SELECT server_specification_id FROM sys.server_audit_specifications WHERE
[name] = '<server_audit_specification_name>')
AND audit_action_name = 'SCHEMA_OBJECT_ACCESS_GROUP';

If no row is returned, this is a finding.

If the audited_result column is not \"FAILURE\" or \"SUCCESS AND FAILURE\",
this is a finding."
  tag "fix": "Where SQL Server Trace is in use, implement tracking of SELECTs
on categorized data at the application level, using the system stored procedure
sp_trace_generateevent to write the tracking records to the Trace used for
audit purposes. Include failed attempts in the tracking.

If SQL Server Audit is in use, design and deploy an Audit that captures all
auditable events and data items.  The script provided in the supplemental file
Audit.sql can be used as the basis for this.  Supplement the standard audit
data as necessary, using Extended Events and/or triggers.

Alternatively, to add the necessary data capture to an existing server audit
specification, run the script:
USE [master];
GO
ALTER SERVER AUDIT SPECIFICATION <server_audit_specification_name> WITH (STATE
= OFF);
GO
ALTER SERVER AUDIT SPECIFICATION <server_audit_specification_name> ADD
(SCHEMA_OBJECT_ACCESS_GROUP);
GO
ALTER SERVER AUDIT SPECIFICATION <server_audit_specification_name> WITH (STATE
= ON);
GO"
end
