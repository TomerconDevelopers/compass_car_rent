// THIS FILE HOLDS GLOBAL VARIABLES USED BY VARIOUS UTILITIES
/*
DO not modify or edit variables here
*/

String app_version;String versioncode;String packagename;//Stores app version, versioncode and packagename
bool devmode = false;//Hold whether devmode screen visible or not - devmode.dart
bool dashboard = true;// Hold whether navigator is in dashboard or homepage
//THEME
String default_font = 'Montserrat';
//THIS VARIABLE DETERMINES WHETHER LOADING OR NOT DURING HTTP REQUEST OR ANY OTHER ASYNC TASK
bool loading = false;
String loadingtext; // This is the display text in loading widget
//
//====================== USER VARIABLES ======================
String cu_name; // Username
String cu_id; //User id
String cu_type; // user_type
//====================== END =================================
//THis holds key from firebase remoteconfig, For adding extra security to Strings
String key = null; // The length must be 32 characters

/*
THis variable holds date and time from epoch as milliseconds. 
Refer NTP (Network time Protocol) for more details
USES: To prevent clock mode exploit in smartphones
*/
int ntptime; // 

bool update = false;String updatetxt;int updatecode;// THEse variables holds update information