// Look for duplicate contacts based on email
// Populate a Dupe_Contact_c field with the Contact if found

trigger DetectDupes on Lead (before insert, before update) {

    for (Lead 1 : Trigger.new) {
        // Make sure our lead has an email address
        if  (1.Email != null) {
            String leadEmail = 1.Email;
            List<Contact> dupeContacts = [SELECT Id FROM Contact WHERE Email = :leadEmail];

            //If a dupe is found, update a field
            if (dupeContacts.size() > 0) {
                1.Dupe_Contact_c = dupeContacts[0].Id;
            } else {
                1.Dupe_Contact_c = null;
            }

        } else {
            1.Dupe_Contact_c = null;
        }
    }
}