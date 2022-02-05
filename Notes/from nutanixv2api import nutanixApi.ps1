from nutanixv2api import nutanixApi
import pprint


vm_uuid = 'ad9058e1-5c77-423c-bcf5-b09fa4cb3654'

body = {  
  "spec_list":[  
    {  
      "memory_mb":6048,
      "name":"vasya2",
      "num_vcpus":1
    }
  ]
}

def main():
	base_url = "https://10.XX.XX.55:9440/PrismGateway/services/rest/v2.0/" 
	api = nutanixApi(base_url, 'admin', 'Nutanix/1234')
	response = api.vm_clone(vm_uuid, body=body)
	try:
	    pprint.pprint(response.json())
	except:
		pprint.pprint(response.text)

if __name__ == "__main__":
  main()