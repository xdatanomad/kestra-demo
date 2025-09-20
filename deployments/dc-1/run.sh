#/bin/bash
# This script initializes ta kestra deployment running via docker-compose

usage() {
    echo "Usage: $0"
    echo "This script initializes a Kestra deployment."
    echo ""
    echo "  $0 start    starts kestra via docker-compose up -d"
    echo "  $0 stop     stops the kestra deployment"
    echo "  $0 help     shows this help message"
}

start() {
    set -e
    CUR_DIR="$(pwd)"
    cd "$(dirname "$0")"
    echo "Initializing Kestra deployment..."
    if [ ! -d "kestra-wd" ]; then
        mkdir kestra-wd
        echo "Created directory kestra-wd."
    fi
    if [ ! -f ".env" ]; then
        echo "WARNING: .env file not found! This file MUST exist and contain secrets.\n"
        cat << EOF
# Example .env file
POSTGRES_USER="kestra"
POSTGRES_PASSWORD="your_postgres_password_here"
KESTRA_SECRET_JDBC_SECRET="your_jdbc_secret_here"
KESTRA_ENCRYPTION_SECRET_KEY="your_encryption_secret_key_here"
KESTRA_BASIC_AUTH_USERNAME="your_basic_auth_username_here"
KESTRA_BASIC_AUTH_PASSWORD="your_basic_auth_password_here"
KESTRA_GEMINI_API_KEY="your_gemini_api_key_here"
KESTRA_EE_LICENSE_FINGERPRINT="your_license_fingerprint_here"
KESTRA_EE_LICENSE_ID="your_license_id_here"
KESTRA_EE_LICENSE_KEY="your_license_key_here"

EOF
        exit 1
    fi
    # run docker-compose to start the services
    docker-compose up -d
    # change back to the original directory
    cd "$CUR_DIR"
    echo "Kestra deployment initialized."
    echo "Kestra UI at http://localhost:18080"
}

stop() {
    echo "Stopping Kestra deployment..."
    CUR_DIR="$(pwd)"
    cd "$(dirname "$0")"
    docker-compose down
    # change back to the original directory
    cd "$CUR_DIR"
    echo "Kestra deployment stopped."
}

case "$1" in
    help|--help)
        usage
        ;;
    stop|down)
        stop
        ;;
    start|up)
        start
        ;;
    restart)
        echo "Restarting Kestra deployment..."
        docker-compose down
        run
        ;;
    *)
        echo "Error: Unknown command '$1'." >&2
        usage
        exit 1
        ;;
esac
