from flask import Flask
from myapi import MyApi

app = Flask(__name__)
app.add_url_rule('/api/<company>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/<color>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/<color>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/<transmission>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<model>/<transmission>/<year>/', view_func=MyApi.main_csv_to_json, methods=['GET'])
app.add_url_rule('/api/<company>/<source>/csv/', view_func=MyApi.csv_downloads, methods=['GET'])

if __name__ == '__main__':
    app.run(debug=True, port=5050, host='0.0.0.0')