public class ParkLocator {
    
    public static String[] country(String name) {
        
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        String[] parks = park.byCountry(name);
        
        return parks;
    }

}