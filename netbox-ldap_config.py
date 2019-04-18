import ldap
from django_auth_ldap.config import LDAPSearch, GroupOfNamesType

# Server URI
AUTH_LDAP_SERVER_URI = "ldap://x.domain.com:3268"
AUTH_LDAP_START_TLS = True

# The following may be needed if you are binding to Active Directory.
AUTH_LDAP_CONNECTION_OPTIONS = {
    ldap.OPT_REFERRALS: 0
}

# Set the DN and password for the NetBox service account.
AUTH_LDAP_BIND_DN = "CN=netbox service account,OU=Service Accounts,OU=Users,DC=x,DC=domain,DC=com"
AUTH_LDAP_BIND_PASSWORD = "blah"

# This search matches users with the sAMAccountName equal to the provided username. This is required if the user's
# username is not in their DN (Active Directory).
AUTH_LDAP_USER_SEARCH = LDAPSearch("DC=x,DC=domain,DC=com",ldap.SCOPE_SUBTREE,"(sAMAccountName=%(user)s)")

# This search ought to return all groups to which the user belongs. django_auth_ldap uses this to determine group
# hierarchy.
AUTH_LDAP_GROUP_SEARCH = LDAPSearch("OU=Groups,DC=x,DC=domain,DC=com", ldap.SCOPE_SUBTREE,
                                    "(objectClass=group)")
AUTH_LDAP_GROUP_TYPE = GroupOfNamesType()

# Define a group required to login.
AUTH_LDAP_REQUIRE_GROUP = "CN=Netbox-Admins,OU=Application-Access,OU=Groups,DC=x,DC=domain,DC=com"

# Mirror LDAP group assignments.
AUTH_LDAP_MIRROR_GROUPS = True

# Define special user types using groups. Exercise great caution when assigning superuser status.
AUTH_LDAP_USER_FLAGS_BY_GROUP = {
    "is_active": "CN=Netbox-Admins,OU=Application-Access,OU=Groups,DC=x,DC=domain,DC=com",
    "is_staff": "CN=Netbox-Admins,OU=Application-Access,OU=Groups,DC=x,DC=domain,DC=com",
    "is_superuser": "CN=IT-Network-Team,OU=Groups,DC=x,DC=dp,aom,DC=com"
}

# For more granular permissions, we can map LDAP groups to Django groups.
AUTH_LDAP_FIND_GROUP_PERMS = True

# If a user's DN is producible from their username, we don't need to search.
AUTH_LDAP_USER_DN_TEMPLATE = None

# Include this setting if you want to ignore certificate errors. This might be needed to accept a self-signed cert.
# Note that this is a NetBox-specific setting which sets:
#     ldap.set_option(ldap.OPT_X_TLS_REQUIRE_CERT, ldap.OPT_X_TLS_NEVER)
LDAP_IGNORE_CERT_ERRORS = True
