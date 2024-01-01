#### MASTER DATA MANAGEMENT - Contacts

#### Requirements
  Sales team has decided to use contacts from ACME, CRM, RAPID Sources. We need to master the contacts data into MDM.

##### Data from source system
<table>
  <thead>
      <tr> 
          <th>Source system</th> 
          <th>Count</th>
      </tr>
  </thead>
  <tbody>
      <tr>
        <td>ACME</td>
        <td>321</td>
      </tr>
      <tr>
        <td>CRM</td>
        <td>1049</td>
      </tr>
      <tr>
        <td>RAPID</td>
        <td>1192</td>
      </tr>
    </tbody>
</table>

#### MDM Data pipeline
![master-contacts](https://github.com/sivaprakashniet/hubspot-mdm/assets/10218839/bd0b7b8d-24d5-46e8-bc6c-e434376a3c7d)

**Seed Layer**

This is the seed layer for source data (.csv). It converts .csv contacts file into seed tables which has raw source data.

1. acme_contacts_seed
2. crm_contacts_seed
3. rapid_data_contacts_seed

**Prep Layer**

This is the prep model for seed data. It selects all columns from source and data quality checks have been applied.

1. acme_contacts_prep
2. crm_contacts_prep
3. rapid_data_contacts_prep

**Transform Layer**

dw_contacts: This is transform layer model which is used to combine all 3 prep model into one transform model and applied deduplication based on email, name and phone_number

**Master Layer**

master_contacts: This is master layer model which is used to access contacts data into different teams based on their requirement and we can create views on top of it.

**Mart view for consumption**

This is mart layer model which is used to access contacts data and we can access through this model.


**Stats:**

##### Total contacts - 2562
##### Deduplication by email_address - 1195
##### Deduplication by name and phone_number - 1013


#### Lineage:

<img width="1396" alt="mdm_lineage" src="https://github.com/sivaprakashniet/hubspot-mdm/assets/10218839/2a18b071-47e4-469d-a06c-b8a5b54d72ad">

#### Master contacts view details for Sales team.

<img width="629" alt="master_contact" src="https://github.com/sivaprakashniet/hubspot-mdm/assets/10218839/80837475-e4f4-4897-b679-9cbe55db15e3">




