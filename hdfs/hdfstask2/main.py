from hdfs import Config
client = Config().get_client()

with client.read('/data/access_logs/big_log/access.log.2015-12-10', chunk_size=10) as reader:
	 for i in reader:
		print(i)
		break