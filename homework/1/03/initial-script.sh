set -e
echo "start quickbite setup"
echo "[1/4] Updating symtem package..."
sudo apt-get update
sudo apt-get upgrade -y
echo "[2/4] Installing required package..."
sudo apt-get install -y \
     openjdk-17-jdk \
    git \
    curl
echo "[3/4] Checking quickbite group..."
if getent group quickbite > /dev/null; then
        echo "Group 'quickbite' already exists."
else
sudo groupadd quickbite
echo "Group 'quickbite' created successfully."
fi

echo "[4/4] Checking quickbite system user..."
if id quickbite > /dev/null 2>&1; then
        echo "User 'quickbite' already exists."
else
        sudo useradd \
             -- system \
             -- gid quickbite \
             -- no-create-home \
             -- shell /bin/false \
             quickbite
         echo "System user 'quickbite' created successfully."
fi

echo " QuickBite setup completed successfully!"
