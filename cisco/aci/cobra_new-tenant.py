import cobra
# check further dependencies


# New Tenant
topMo = md.lookupByDn('unl')
tenant = cobra.model.fv.Tenant(topMo, name='cobra_DM2020')

# Push Configuration to APIC
try:
   conn = cobra.mit.request.ConfigRequest()
   conn.addMo(topMo)
   md.commit(conn)
except Exception as e:
   print('[ERROR] Unable to push configuration {%s}.' % str(e))
else:
   print('[*] Configuration pushed successfully')
   print('JSON', cobra.internal.codec.jsoncodec.toJSONStr(topMo)) 
