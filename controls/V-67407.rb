control 'V-67407' do
  title "Time stamps in database tables, intended for auditing or
activity-tracking purposes, must include both date and time of day, with a
minimum granularity of one second."
  desc  "If time stamps are not consistently applied and there is no common
time reference, it is difficult to perform forensic analysis, in audit files,
trace files/tables, and application data tables.

    Time stamps generated by SQL Server must include date and time, to a
granularity of one second or finer. Time is commonly expressed in Coordinated
Universal Time (UTC), a modern continuation of Greenwich Mean Time (GMT), or
local time with an offset from UTC. Granularity of time measurements refers to
the precision available in time stamp values. Granularity coarser than one
second is not sufficient for audit trail purposes, and granularity finer than
one second is recommended. Time stamp values are typically presented with three
or more decimal places of seconds; however, the actual granularity may be
coarser than the apparent precision. For example, SQL Server's
GETDATE()/CURRENT_TMESTAMP values are presented to three decimal places, but
the granularity is not one millisecond: it is about 1/300 of a second.

    The data types that can be used for this purpose in SQL Server are:
    DATETIME2 - precision variable from a whole second down to a ten-millionth
(subject to the actual precision of the hardware and operating system)
    DATETIMEOFFSET - as datetime2, together with local offset from UTC
    DATE, together with TIME (same precision considerations as for datetime2)
    DATETIME - precision 1/300 of a second
    Character-string data types allowing for at least 20 characters are also
permissible, but not recommended.

    SQL Server built-in functions for retrieving current timestamps are:  (high
precision) sysdatetime(), sysdatetimeoffset(), sysutcdatetime();  (lower
precision) CURRENT_TIMESTAMP or getdate(), getutcdate().

    Ensure that values recorded for tracking purposes in data tables are
correctly defined and maintained.  (Design decisions about which tables require
audit-trail or activity-tracking columns are outside the scope of this STIG.
This requirement applies only to the data type and maintenance of such columns
if they do exist.)

    The SMALLDATETIME data type is not precise enough for this purpose.
Although it gives the impression of including a seconds component, the seconds
value is always \"00\".

    SQL Server offers a data type called TIMESTAMP that is not a representation
of date and time. Rather, it is a database state counter and does not
correspond to calendar and clock time. This requirement does not refer to that
meaning of TIMESTAMP.  To avoid confusion, Microsoft recommends using the newer
name for this data type, ROWVERSION, instead.
  "
  impact 0.5
  tag "gtitle": 'SRG-APP-000375-DB-000323'
  tag "gid": 'V-67407'
  tag "rid": 'SV-81897r1_rule'
  tag "stig_id": 'SQL4-00-033700'
  tag "fix_id": 'F-73519r1_fix'
  tag "cci": ['CCI-001889']
  tag "nist": ['AU-8 b', 'Rev_4']
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
  tag "check": "Review the column definitions and contents of audit-trail and
activity-tracking timestamps in database tables.

If these are not defined and maintained to include date and time of day,
accurate to a granularity of one second or finer, this is a finding."
  tag "fix": "Modify applications and/or column/field definitions so that the
time stamps in audit-trail and activity-tracking columns/fields in application
data include date and time of day, to a granularity of one second or finer, and
are recorded accurately."

  describe 'This test currently has no automated tests, you must check manually' do
    skip 'This check must be preformed manually'
  end
end
