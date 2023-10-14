@IsTest
private class AccountManagerTest {

    @IsTest
    static void testGetAccount() {
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create test Contacts related to the Account
        Contact testContact1 = new Contact(AccountId = testAccount.Id, FirstName = 'John', LastName = 'Doe');
        Contact testContact2 = new Contact(AccountId = testAccount.Id, FirstName = 'Jane', LastName = 'Smith');
        insert new List<Contact>{testContact1, testContact2};

        // Prepare the request
        RestRequest request = new RestRequest();
        request.requestUri = 'https://resourceful-shark-rkcl0c-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/'+ testAccount.Id+'/contacts'; 
        request.httpMethod = 'GET'; 
        RestContext.request = request;

        // Call the getAccount method
        Account result = AccountManager.getAccount();

        // Assert the returned Account details
        System.assertNotEquals(result, null);
        System.assertEquals(testAccount.Id, result.Id);
        System.assertEquals(testAccount.Name, result.Name);


        // Assert the related Contacts
        System.assertEquals(2, result.Contacts.size());
        System.assertEquals(testContact1.Id, result.Contacts[0].Id);
        System.assertEquals('John Doe', result.Contacts[0].Name);
        System.assertEquals(testContact2.Id, result.Contacts[1].Id);
        System.assertEquals('Jane Smith', result.Contacts[1].Name);


        RestRequest request1 = new RestRequest();
        request1.requestUri = 'https://resourceful-shark-rkcl0c-dev-ed.trailblaze.my.salesforce.com/services/apexrest/Accounts/randomTextForTestingPurpose/contacts'; 
        request1.httpMethod = 'GET'; 
        RestContext.request = request1;

        // Call the getAccount method
        Account result1 = AccountManager.getAccount();

        // Assert the returned Account details
        System.assertEquals(result1, null);
    }
}