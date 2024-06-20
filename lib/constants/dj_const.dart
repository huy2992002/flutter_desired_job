class DJConst {
  static const apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV5aXdvemVqcHR6aWlhcXRibGd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk3NDAxNDUsImV4cCI6MjAyNTMxNjE0NX0.T5RT7J3ApQEheh4T9X-vjpFrJ75AFy9BqNPCsoF4Bno';

  static const baseUrlApi = 'https://uyiwozejptziiaqtblgt.supabase.co/rest/v1';
  static const baseUploadImage =
      'https://api.cloudinary.com/v1_1/dwkiqkpv4/upload';
  // static const endPointGetAccounts = '$baseUrlApi/accounts?select=*';
  // static const endPointGetUsers = '$baseUrlApi/users?select=*';
  // static const endPointGetJobs = '$baseUrlApi/jobs?select=*';
  static const endPointAccounts = '$baseUrlApi/accounts';
  static const endPointUsers = '$baseUrlApi/users';
  static const endPointBusiness = '$baseUrlApi/business';
  static const endPointJob = '$baseUrlApi/jobs';

  static String endPointFavoriteJob(String id) {
    return '$baseUrlApi/users?accountId=eq.$id&select=favoriteJobs';
  }

  static String endPointBusinessJobs(String businessId) {
    return '$baseUrlApi/jobs?businessId=eq.$businessId';
  }

  static String endPointMyAccount(String id) {
    return '$baseUrlApi/accounts?id=eq.$id&select=*';
  }

  static String endPointRemoveAccount(String id) {
    return '$baseUrlApi/accounts?id=eq.$id';
  }

  static String endPointRemoveUser(String id) {
    return '$baseUrlApi/users?id=eq.$id';
  }

  static String endPointRemoveBusiness(String id) {
    return '$baseUrlApi/business?id=eq.$id';
  }

  static String endPointMyBusiness(String id) {
    return '$baseUrlApi/business?accountId=eq.$id&select=*';
  }

  // static String endPointMyUser(String email) {
  //   return '$baseUrlApi/users?email=eq.$email&select=*';
  // }

  static String endPointUpdateFavoriteJob(String id) {
    return '$baseUrlApi/users?accountId=eq.$id';
  }

  static const baseUploadSendEmail =
      'https://api.emailjs.com/api/v1.0/email/send';
  static const servicesId = 'service_bss1ru7';
  static const templateId = 'template_4cdg9ng';
  static const userId = '9DVcPZVV5Bue-ysi3';
}
