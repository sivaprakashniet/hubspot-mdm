{% docs rapid_data_contacts_seed %}

Rapid Data Contacts
==============================================
Stakeholders: 

---

| Type    | Date      | Contributors | Ticket       |
|:-------:|:---------:|:------------:|:------------:|
|Created  |01/01/2024 |Prakash       |[0001](https://atlassian.net/browse/0001)|

---

Contacts sourced from RapidData, a data broker known for sourcing contacts using web tracking pixels, strategic partner’s web traffic data, and myriad other automated means. These contacts tend to have higher error rates and duplicated records, but provide for a large sample of contacts.


| Field Name | Description |
|:--------|:----------|
| `name` | The contact's full name |
| `email_address` | The contact's work email address |
| `phone_number` | The contact's primary phone number |
| `title` | The contact's business title with their employer |
| `company_name` | The name of the contact's employer |
| `company_domain` | The domain name for the contact's employer |
| `intent_signals` | A list of all intent signals received for this contact. |
| `do_not_call` | A boolean indicator that the Contact does not want to be called |
| `created_at` | The date that the Contact was first created |
| `updated_at` | The date that the Contact was most recently updated |


{% enddocs %}