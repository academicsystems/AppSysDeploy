### Shibboleth

You must have the admin email set in the settings. You will be locked out of AppSys if you enable SSO without setting this email to one that works with your SSO Identity Provider. Before moving forward, you will need to ask your for the url or your IDP's metadata. You will also need to give them the url of your SP metadata, which will be the same as your SERVICE-PROVIDER-ID -> `https://URL/PATH/appsys/shibboleth`

Now you need to edit the files in the appsys-shibboleth volume. You can do this by running: `docker exec -it appsys-edit ash`. Then use the `vi` command to edit the files in /appsys/shibboleth.

Add the name of the email attribute used by your SSO identity provider here: email_attr.txt
email

#### shibboleth2.xml

```
ApplicationDefaults entityID="https://DOMAIN/PATH/appsys/shibboleth"

Sessions handlerURL="/PATH/appsys/Shibboleth.sso"

SSO entityID="IDP-ENTITYID"

Errors supportContact="EMAIL"

MetadataProvider type="XML" uri="IDP-METADATA-URL" backingFilePath="IDP-ENTITY-ID.xml"
```

#### attribute-map.xml
Ask your IDP for the 'name' attribute

#### metadata.xml
Finally go to https://DOMAIN/PATH/appsys/Shibboleth.sso/Metadata
Save the metadata output to metadata.xml, add the xml below (fill it out first), and add it to the shibboleth folder

```
<md:Organization>
	<md:OrganizationName xml:lang="en">ORG-NAME</md:OrganizationName>
	<md:OrganizationDisplayName xml:lang="en">ORG-NAME-DISPLAY</md:OrganizationDisplayName>
	<md:OrganizationURL xml:lang="en">ORG-URL</md:OrganizationURL>
</md:Organization>

<md:ContactPerson contactType="support">
	<md:GivenName>TECH-NAME</md:GivenName>
	<md:EmailAddress>TECH-EMAIL</md:EmailAddress>
</md:ContactPerson>
```

Now go to the admin settings and click "Enable Shibboleth"
