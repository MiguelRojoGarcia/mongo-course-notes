### Create a mongo atlas cluster by CLI

atlas setup --clusterName CLUSTERNAME --provider AWS --currentIp --skipSampleData --username DB_USER --password DB_PASSWORD | tee atlas_cluster_details.txt

### Load sample data to your cluster
atlas clusters sampleData load CLUSTERNAME