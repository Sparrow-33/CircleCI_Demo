@isTest
public class ParkLocatorTest {
    
    @isTest
    Static void testCallout() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        String pays = 'Germany';
       
        String[] parks = ParkLocator.country(pays);
        
        List<String> testCountries = new List<String>{'Hamburg Wadden Sea National Park', 'Hainich National Park', 'Bavarian Forest National Park'};

        System.assertEquals(
         testCountries,
            parks
        );
    }

}