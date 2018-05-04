global class chatterAssassin {
    static webservice void hitPost(string postID)
    {
        //database.delete(postID);
        //string postID = '0D53000000EucCl';
        Map<String, Schema.SObjectType> globalDesc = Schema.getGlobalDescribe();
        Map<String,String> keyPrefixMap = new Map<String,string>();
        
        set<String>keyPrefixSet = globalDesc.keyset();
        for(String so : keyPrefixSet)
        {
            Schema.DescribeSObjectResult r = globalDesc.get(so).getDescribe();
            string tempName = r.getName();
            string tempPrefix = r.getKeyPrefix();
            keyPrefixMap.put(tempPrefix,tempName);
        }
        string tPrefix = postID.substring(0,3);
        string feedPrefix = keyPrefixMap.get(tPrefix);
        
        //if(feedPrefix.endsWith('_c'))
        //{
            //custom object
            //feedPrefix = feedPrefix.substring(0, feedPrefix.length()-1);//cut off c
        //}
        
        //string feedObject = feedPrefix + 'feed';
        Sobject soToKill = database.query('select id from ' + feedPrefix + ' where id = \'' + postID + '\' with USERID = \'' + UserInfo.getUserID() + '\'');
        //delete soToKill;
    }
    
    static testMethod void myTest(){
        chatterAssassin.hitPost([select id from AccountFeed limit 1].id);
    }
}