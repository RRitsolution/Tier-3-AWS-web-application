from flask import Flask
import pymysql

app = Flask(__name__)

# This route handles the request for the root path, which is now handled
# by Apache serving the index.html file.
# The previous version of this route is now a placeholder.
@app.route('/')
def index():
    return "This page is served by the Flask application, not the index.html file."

# This new route is specifically for the '/api' path.
# Apache will forward requests to your_load_balancer_dns/api to this route.
@app.route('/api')
def api_status():
    try:
        conn = pymysql.connect(
            host="10.0.134.199",
            user="appuser",
            passwd="newPassword123!",
            database="demoapp"
        )
        conn.close()
        return "✅ Flask app working and connected to database!"
    except Exception as e:
        return f"❌ Error: {str(e)}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
	
	to run back-end
	
	nohup python3 app.py > app.log 2>&1 &
