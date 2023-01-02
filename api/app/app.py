from flask import Flask
from myapi import MyApi, csv_downloads

app = Flask(__name__)
app.add_url_rule('/api/<model>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<model>/<color>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<model>/<color>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<model>/<transmission>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<model>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<model>/<transmission>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/csv/', view_func=csv_downloads, methods=['GET'])

if __name__ == '__main__':
    app.run(debug=True, port=5050, host='0.0.0.0')