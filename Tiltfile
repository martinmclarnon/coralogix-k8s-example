# Tiltfile
# Ports:
# Zookeeper: 2181
# kafka: 9092
# akhq ui: 8080
# mongo db: 27017
# create-order-command: 8084
# create-order-audit: 8085

# Function to create namespace for all worker nodes
def create_namespace_service():
    k8s_yaml('./local-cicd-manifests/demo-namespace.yaml')

# Function to build and deploy: zookeeper service
def zookeeper_service():
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-zookeeper.yaml')
    # Assign port
    k8s_resource('demo-zookeeper',
                 port_forwards=['2181:2181'],
                 labels="message-queue")

# Function to build and deploy: kafka service
def kafka_service():
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-kafka.yaml')
    # Assign port
    k8s_resource('demo-kafka',
                 port_forwards=['9092:9092'],
                 resource_deps=['demo-zookeeper'],
                 labels="message-queue")

# Function to build and deploy: akhq service
def akhq_service():
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-akhq.yaml')
    # Assign port
    k8s_resource('demo-akhq',
                 port_forwards=['8080:8080'],
                 resource_deps=['demo-kafka'],
                 labels="message-queue")

def mongodb_service():
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-mongodb.yaml')
    # Assign port
    k8s_resource('demo-mongodb',
                 port_forwards=['27017:27017'],
                 labels="persistent-storage")

# Function to build and deploy: producer service
def create_order_command_service():
    # Build from Dockerfile
    docker_build('demo-create-order-command', context='./src/store/create-order-command', dockerfile='./src/store/create-order-command/Dockerfile')
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-create-order-command.yaml')
    # Assign port
    k8s_resource('demo-create-order-command',
                 port_forwards='8084:8080',
                 resource_deps=['demo-kafka'],
                 trigger_mode=TRIGGER_MODE_MANUAL,
                 labels="service")

# Function to build and deploy: consumer service
def create_order_audit_service():
    # Build from Dockerfile
    docker_build('demo-create-order-audit', context='./src/store/create-order-audit', dockerfile='./src/store/create-order-audit/Dockerfile')
    # Specify the Kubernetes manifest for the deployment
    k8s_yaml('./local-cicd-manifests/demo-create-order-audit.yaml')
    # Assign port
    k8s_resource('demo-create-order-audit',
                 port_forwards='8085:8080',
                 resource_deps=['demo-kafka','demo-create-order-command'],
                 trigger_mode=TRIGGER_MODE_MANUAL,
                 labels="service")

create_namespace_service()
zookeeper_service()
kafka_service()
akhq_service()
mongodb_service()
create_order_command_service()
create_order_audit_service()