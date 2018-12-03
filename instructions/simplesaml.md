### SimpleSAML

You must have the admin email set in the settings. You will be locked out of AppSys if you enable SSO without setting this email to one that works with your SSO Identity Provider. Before moving forward, you will need to ask for the url or your IDP's metadata. You will also need to give them the url of your SP metadata, which will be the same as your SERVICE-PROVIDER-ID -> `https://URL/PATH/appsys/sp/simplesaml/module.php/saml/sp/metadata.php/SERVICE-PROVIDER-NAME`

Now you need to edit the files in the appsys-simplesaml volume. You can do this by running: `docker exec -it appsys-edit ash`. Then use the `vi` command to edit the files in /appsys/simplesaml.

You can use the pwgen.php file to generate an SSO admin password.
You can use this command to generate random salts: tr -c -d '0123456789abcdefghijklmnopqrstuvwxyz' </dev/urandom | dd bs=32 count=1 2>/dev/null;echo
You can find available timezones at: http://php.net/manual/en/timezones.php 

#### config.php 
```
'baseurlpath' => PATH/appsys/sp/simplesaml
'auth.adminpassword' => 'SSO-ADMIN-PASS'
'secretsalt' => 'SECRET-SALT'
'technicalcontact_name' => 'CONTACT-NAME'
'technicalcontact_email' => 'CONTACT-EMAIL'
'timezone' => 'TIMEZONE'
```

#### config-metarefresh.php 
```
'src' => 'URL-WHERE-IDP-METADATA-CAN-BE-RETRIEVED'
```

#### authsources.php 
```
'SERVICE-PROVIDER-NAME' => array(
        'saml:SP',
        'privatekey' => 'saml.pem',
        'certificate' => 'saml.crt',
        'entityID' => null,
		'idp' => 'IDENTITY-PROVIDER-ID',
		'discoURL' => null,
     ),
```

#### module_cron.php 
```
'key' => 'SECRET-SALT'
```

In the file below, enter the attribute key used to retrieve the user's email from the Identity Provider's supplied user data.

#### email_attr.txt 
```
email
```

Now go to the admin settings and click "Enable SimpleSaml"

Finally, create a cronjob on your host with the following two lines. Make sure to replace "SALT" with the SECRET-SALT you generated for config-metarefresh.php. These cronjobs will refresh the Identity Provider's metadata every day and every hour. You can choose one or both.

```
02 0 * * * curl --silent "https://DOMAIN/sp/simplesaml/module.php/cron/cron.php?key=SALT&tag=daily" > /dev/null 2>&1
01 * * * * curl --silent "https://DOMAIN/sp/simplesaml/module.php/cron/cron.php?key=SALT&tag=hourly" > /dev/null 2>&1
```
