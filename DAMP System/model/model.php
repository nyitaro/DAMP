<?
	
	// The application title is defined here 
	$application_title = "Delivery Access Managment System";
	
	// The application database and the connection string are defined here
	// syntax is: 'username@database.server/database_name IDENTIFIED BY PASSWORD ' 
	define('MYACTIVERECORD_CONNECTION_STR', 'mysql://root@localhost/DAMP');
	
	// includes used implementation of MyActiveRecord class 
	include './include/MyActiveRecord.0.4.php';
	
	//in this array we list all and only those classes we like to CRUD manage from the main menu 
	$classes = array('vehicle', 'delivery', 'title', 'state', 'card', 'driver', 'entry_log', 'supplier', 'venue');  
	
	// in this array we list all join tables which hold many to many relationships between two given classes of objects
	$join_tables = array();	
	
	// in this array below we list all foreign keys: this array MUST EXIST: if empty then uncomment line below (and comment the following one!)
	//foreign_keys=array();
	$foreign_keys = array('venue_id', 'driver_id', 'supplier_id', 'delivery_id', 'title_id', 'state_id', 'vehicle_id'); 
	
	// relationships between entities/classes are named below: if no name has
	// been given to a certain relationship, the bare foreign key would be displayed
	function name_child_relationship($class_name,$foreign_key)
	{
		
	}
	
	// this array has been initiated, but its usage will be defined in future versions of VF1
	$objects = array();
	
	// classes are defined below as extensions of MyActiveRecord class
	class delivery extends MyActiveRecord{
			function destroy(){
			}	
		} 
		
	class driver extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class card extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class supplier extends MyActiveRecord{
			function destroy(){
			}	
		}
	
	class venue extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class entry_log extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class vehicle extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class title extends MyActiveRecord{
			function destroy(){
			}	
		}
		
	class state extends MyActiveRecord{
			function destroy(){
			}	
		}
	

?>