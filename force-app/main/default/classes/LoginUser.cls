global class LoginUser {
    @AuraEnabled
    global static String login(String userName, String password) {
        String homeUrl ='https://kasirga-dev-ed.develop.my.site.com/s/';
        ApexPages.PageReference pageRef =Site.login(userName, password, homeUrl);
        return pageRef.getUrl();
    } 
}