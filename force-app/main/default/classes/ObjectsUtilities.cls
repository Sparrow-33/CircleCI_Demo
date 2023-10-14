global class ObjectsUtilities {

    global static List<String> getOrgObjectsNames() {
        List<String> objectNames = new List<String>();
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
       for (Schema.SObjectType objectType : globalDescribe.values()) {
           objectNames.add(objectType.getDescribe().getName());
            }
        
       return objectNames;
    }
}