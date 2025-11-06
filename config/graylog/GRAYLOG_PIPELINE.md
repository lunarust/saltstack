Create new Pipeline
Connect the pipeline to a stream

SYSLOG_Identity
gl_mapping_identity_1



Identity - Policies


rule "audit_add_keys"
when
  has_field("is_auditd")
then
  // extract all key-value from "message" and prefix it with auditd_
  set_fields(
    fields:
      key_value(
        value: to_string($message.original_message),
        trim_value_chars: "\""
      ),
      prefix: "auditd_"
  );
end

Events:

newuser
newgroup
deluser

connect
disconnect

sudo

Fiels:
Status: FAILED - SUCCESS
Username:
From:
COMMAND:
action: Disconnected,authentication

REF.
https://go2docs.graylog.org/current/making_sense_of_your_log_data/writing_search_queries.html?tocpath=Search%20Your%20Log%20Data%7C_____1
https://graylog.org/post/what-is-syslog-and-how-does-it-work/
