from flask import Flask, request, jsonify
from datetime import datetime
import os
from urllib.parse import unquote

app = Flask(__name__)

# Configuration
LOG_FILE = "received_texts.log"  # File where texts will be appended
MAX_FILE_SIZE = 1048576  # 1MB maximum file size (in bytes)

def log_text(text_data):
    """Helper function to log text to file"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] {text_data}\n"
    
    # Check if log file exists, create if not
    if not os.path.exists(LOG_FILE):
        with open(LOG_FILE, 'w', encoding='utf-8') as f:
            f.write("# Text Log File - Created on {}\n\n".format(
                datetime.now().strftime("%Y-%m-%d")))
    
    # Check current file size
    current_size = os.path.getsize(LOG_FILE) if os.path.exists(LOG_FILE) else 0
    if current_size + len(log_entry) > MAX_FILE_SIZE:
        return False, "Log file size limit reached"
    
    # Append the text to the log file
    with open(LOG_FILE, 'a', encoding='utf-8') as f:
        f.write(log_entry)
    
    return True, "Text successfully logged"

@app.route('/receive_text', methods=['GET', 'POST'])
def receive_text():
    """Endpoint to receive text data via GET or POST and append it to a log file."""
    
    # Handle GET request
    if request.method == 'GET':
        text_data = request.args.get('text')
        if not text_data:
            return jsonify({'error': 'No text parameter provided in GET request'}), 400
        # URL decode the text
        text_data = unquote(text_data)
    
    # Handle POST request
    else:
        if not request.data:
            return jsonify({'error': 'No data received'}), 400
        text_data = request.data.decode('utf-8')
    
    # Validate text is not empty
    if not text_data.strip():
        return jsonify({'error': 'Empty text received'}), 400
    
    # Log the text
    success, message = log_text(text_data)
    if not success:
        return jsonify({'error': message}), 413
    
    # Return success response
    return jsonify({
        'status': 'success',
        'method': request.method,
        'message': message,
        'text_length': len(text_data),
        'received_text': text_data
    }), 200

@app.route('/view_logs', methods=['GET'])
def view_logs():
    """Endpoint to view the contents of the log file."""
    try:
        # Check if log file exists
        if not os.path.exists(LOG_FILE):
            return jsonify({'error': 'Log file does not exist yet'}), 404
            
        # Read and return the log file contents
        with open(LOG_FILE, 'r', encoding='utf-8') as f:
            contents = f.read()
            
        return jsonify({
            'status': 'success',
            'file_size': os.path.getsize(LOG_FILE),
            'contents': contents
        }), 200
        
    except Exception as e:
        return jsonify({
            'error': 'Error reading log file',
            'details': str(e)
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)