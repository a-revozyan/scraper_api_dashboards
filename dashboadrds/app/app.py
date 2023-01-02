import dash
from dash import dcc
from dash import html
import pandas as pd
import numpy as np
from dash.dependencies import Output, Input
from csv_module import generating_csvs_test


generating_csvs_test()
data_price = pd.read_csv("files/finished.csv")
data_price["year"] = pd.to_datetime(data_price["year"], format="%Y")
data_price.sort_values("year", inplace=True)

external_stylesheets = [
    {
        "href": "https://fonts.googleapis.com/css2?"
        "family=Lato:wght@400;700&display=swap",
        "rel": "stylesheet",
    },
]
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
app.title = "Cars Analytics"

app.layout = html.Div(
    children=[
        html.Div(
            children=[
                html.P(children="🚙", className="header-emoji"),
                html.H1(
                    children="Cars Analytics", className="header-title"
                ),
                html.P(
                    children="Analyze the current market of cars in Tashkent",
                    className="header-description",
                ),
            ],
            className="header",
        ),
        html.Div(
            children=[
                html.Div(
                    children=[
                        html.Div(children="Model", className="menu-title"),
                        dcc.Dropdown(
                            id="model-filter",
                            options=[
                                {"label": model, "value": model}
                                for model in np.sort(data_price.model.unique())
                            ],
                            # value="Chevrolet Nexia",
                            clearable=False,
                            className="dropdown",
                        ),
                    ]
                ),
                html.Div(
                    children=[
                        html.Div(children="Color", className="menu-title"),
                        dcc.Dropdown(
                            id="color-filter",
                            options=[
                                {"label": car_color, "value": car_color}
                                for car_color in data_price.color.unique()
                            ],
                            value="excellent",
                            clearable=False,
                            searchable=False,
                            className="dropdown",
                        ),
                    ],
                ),
                html.Div(
                    children=[
                        html.Div(
                            children="Date Range",
                            className="menu-title"
                            ),
                        dcc.DatePickerRange(
                            id="date-range",
                            min_date_allowed=data_price.year.min().date(),
                            max_date_allowed=data_price.year.max().date(),
                            start_date=data_price.year.min().date(),
                            end_date=data_price.year.max().date(),
                        ),
                    ]
                ),
            ],
            className="menu",
        ),
        html.Div(
            children=[
                html.Div(
                    children=dcc.Graph(
                        id="price-chart", config={"displayModeBar": False},
                    ),
                    className="card",
                ),
                html.Div(
                    children=dcc.Graph(
                        id="volume-chart", config={"displayModeBar": False},
                    ),
                    className="card",
                ),
            ],
            className="wrapper",
        ),
    ]
)


@app.callback(
    [Output("price-chart", "figure"), Output("volume-chart", "figure")],
    [
        Input("model-filter", "value"),
        Input("color-filter", "value"),
        Input("date-range", "start_date"),
        Input("date-range", "end_date"),
    ],
)
def update_charts(model_car, car_color, start_date, end_date):
    mask = (
        (data_price.model == model_car)
        & (data_price.color == car_color)
        & (data_price.year >= start_date)
        & (data_price.year <= end_date)
    )
    filtered_data = data_price.loc[mask, :]
    price_chart_figure = {
        "data": [
            {
                "x": filtered_data["year"],
                "y": filtered_data["price"],
                "type": "lines",
                "hovertemplate": "$%{y:.2f}<extra></extra>",
            },
        ],
        "layout": {
            "title": {
                "text": "Average Price of the model",
                "x": 0.05,
                "xanchor": "left",
            },
            "xaxis": {"fixedrange": True},
            "yaxis": {"tickprefix": "$", "fixedrange": True},
            "colorway": ["#17B897"],
        },
    }
    volume_chart_figure = {
        "data": [
            {
                "x": filtered_data["price"],
                "y": filtered_data["year"],
                "type": "scatter",
            },
        ],
        "layout": {
            "title": {"text": "Another view", "x": 0.05, "xanchor": "left"},
            "xaxis": {"fixedrange": True},
            "yaxis": {"fixedrange": True},
            "colorway": ["#E12D39"],
        },
    }
    return price_chart_figure, volume_chart_figure


if __name__ == "__main__":
    app.run_server(debug=True,
                   host='0.0.0.0', port=5000)