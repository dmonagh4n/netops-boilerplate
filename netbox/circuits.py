import csv
import xlrd
from collections import namedtuple

''' 
Build out class to handle interpretation (and potential conversion to csv file) from traditional spreadsheet based circuit tracker for use with netbox
'''

class Circuits:

    def convert_to_csv():
	# Gather xlsx format circuit tracker and convert to csv - if already csv skip to import
	workbook = xlrd.open_workbook('circuits.xlsx')
	sheet = workbook.sheet_by_name('Sheet1')
	circuit_csv = open('circuits.csv', 'w')
	write = csv.writer(circuit_csv, quoting=csv.QUOTE_ALL)
	
	for rownum in range(sheet.nrows):
	    write.writerow(sheet.row_values(rownum))
	
    # ADD - return new csv file details to user/details to stdout?

	circuit_csv.close()

    def output_to_netbox():
        # Take converted csv file, extract layout and update to netbox

    def print_circuits(circuit_id):
	# Display contents of circuit tracker rows, if required
        circuits = []
        Circuit = namedtuple("Circuit", "status customer project_id address postcode product pstn_id bearer bandwidth ping_po order_no service_provider cct_id rfs cos wan lan router vrf presentation floor cabinet xconnect site_details contract notes auto_task handover_accounts handover_sharepoints contract_change empty_string")

        with open("circuits.csv", "r") as circuits_csv:
            reader = csv.reader(circuits_csv, skipinitialspace=True)
            next(reader)
            for row in reader:
                current_circuit = Circuit(*row)
                circuits.append(current_circuit)
            #print(f"{circuits[circuit_id]}")
            print(f"Status: {circuits[circuit_id][0]}\nCustomer: {circuits[circuit_id][1]}\nProject ID: {circuits[circuit_id][2]}\nAddress: {circuits[circuit_id][3]}\n{circuits[circuit_id][4]}\nType:{circuits[circuit_id][5]}")

#Circuits.print_circuits(40)