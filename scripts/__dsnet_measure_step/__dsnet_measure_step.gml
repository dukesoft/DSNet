if (current_time-_lastmeasure > 1000) {
	//1 second has passed;
	_lastmeasure = current_time;

	packets_sent_last_second = _packets_sent_s;
	bytes_sent_last_second = _bytes_sent_s;
	packets_received_last_second = _packets_received_s;
	bytes_received_last_second = _bytes_received_s;
	
	var seconds = (current_time - created)/1000;

	packets_sent_avarage = packets_sent/seconds;
	bytes_sent_avarage = bytes_sent/seconds;
	packets_received_avarage = packets_received/seconds;
	bytes_received_avarage = bytes_received/seconds;

	_packets_sent_s = 0;
	_bytes_sent_s = 0;
	_packets_received_s = 0;
	_bytes_received_s = 0;
}