@isTest
public class AnimalLocatorTest {

    @isTest
    static void testGetCallout() {
        
         String testAnimal = 'chicken';
        
        // Set up the mock callout response
        AnimalLocatorMock animalLocatorMock = new AnimalLocatorMock();
        Test.setMock(HttpCalloutMock.class, animalLocatorMock);
        
        // Call the method under test
        Test.startTest();
        AnimalLocator.getAnimalNameById(1);
        Test.stopTest();
        
        System.assertEquals('chicken', animalLocatorMock.name);
    }
        
    }