import cv2
import requests
import ultralytics
import os
import matplotlib.pyplot as plt
import io
import logging

from ultralytics import YOLO
from PIL import Image,ImageDraw,ImageFont
from werkzeug.utils import secure_filename
from flask import send_file
from flask import Flask, request, jsonify, redirect
from base64 import encodebytes

# model_path = 'C:/YOLO/yolov8/best_flound_15.pt'
model_path = './best_flound_15.pt'
model = YOLO(model_path)


logger = logging.getLogger(__name__)
formatter = logging.Formatter('[%(asctime)s][%(levelname)s|%(filename)s:%(lineno)s] >> %(message)s')

# handler 생성 (stream, file)
streamHandler = logging.StreamHandler()
fileHandler = logging.FileHandler('./flound_srv.log')

# logger instance에 fomatter 설정
streamHandler.setFormatter(formatter)
fileHandler.setFormatter(formatter)

# logger instance에 handler 설정
logger.addHandler(streamHandler)
logger.addHandler(fileHandler)

# logger instnace로 log 찍기
logger.setLevel(level=logging.DEBUG)
logger.debug('my DEBUG log')

app = Flask(__name__)

def html_root():
    return """<!DOCTYPE html>
            <html>
            <head> 
            <title> Test Page </title>
            </head>
            <body>

            <h1> 테스트 페이지 </h1>

            </body>
            </html>"""

@app.route('/')
def input_data():
    return html_root()

@app.route('/return_json', methods=['POST'])
def return_json():
    file = request.files['image']
    org_file_name = secure_filename(file.filename)
    save_file_name = './images/' + org_file_name

    file.save(save_file_name)
    result = model.predict(source=save_file_name, conf=0.25, save=True)

    logger.debug(f'result[0].boxes.cls : {result[0].boxes.cls}')

    names = model.names

    cls_name = []
    for c in result[0].boxes.cls:
        cls_name.append(names[int(c)])

    return {'detect_sym_code': cls_name}

@app.route('/return_image', methods=['POST'])
def return_image():
    file = request.files['image']
    org_file_name = secure_filename(file.filename)
    save_file_name = './images/' + org_file_name
    predict_file_name = './images/pred_' + org_file_name

    file.save(save_file_name)
    result = model(save_file_name)[0].plot()
    pil_image = Image.fromarray(result[:, :, ::-1])
    pil_image.save(predict_file_name)

    return send_file(predict_file_name)

def get_response_image(image_path):
    pil_img = Image.open(image_path, mode='r')
    byte_arr = io.BytesIO()
    pil_img.save(byte_arr, format='png')
    encoded_img = encodebytes(byte_arr.getvalue()).decode('ascii')
    return encoded_img

@app.route('/detect_disease', methods=['POST'])
def detect_disease():
    file = request.files['image']
    org_file_name = secure_filename(file.filename)
    save_file_name = './images/' + org_file_name
    predict_file_name = './images/pred_' + org_file_name

    file.save(save_file_name)
    result = model(save_file_name)[0].plot()
    pil_image = Image.fromarray(result[:, :, ::-1])
    pil_image.save(predict_file_name)

    result_pred = model.predict(source=save_file_name, conf=0.25, save=True)
    logger.debug(f'result[0].boxes.cls : {result_pred[0].boxes.cls}')

    names = model.names
    cls_name = []
    for c in result_pred[0].boxes.cls:
        cls_name.append(names[int(c)])

    # predict_file_name = 'C:/YOLO/yolov8/images/pred_AMA2221019_02_JPG.rf.10078aa2d64d346f04e32ec25090b38c.jpg'
    logger.debug(f'predict_file_name : {predict_file_name}')
    encoded_img = get_response_image(predict_file_name)

    # response = {'Status': 'Success', 'detect_sym_code': cls_name}
    response = {'Status': 'Success', 'detect_sym_code': cls_name, 'ImageBytes': encoded_img}
    logger.debug(f'response : {response}')
    return jsonify(response)

@app.route('/detect_dis', methods=['POST'])
def detect_dis():
    msg = 'start'
    logger.debug(f'detect_dis : {msg}')
    file = request.files['org_image']

    org_file_name = secure_filename(file.filename)
    save_file_name = 'org_' + org_file_name
    predict_file_name = 'pred_' + org_file_name

    file = request.files['org_image']
    dd_email = request.form['dd_email']
    logger.debug(f'dd_email : {dd_email}')

    file.save(save_file_name)
    result = model(save_file_name)[0].plot()
    pil_image = Image.fromarray(result[:, :, ::-1])
    pil_image.save(predict_file_name)

    result_pred = model.predict(source=save_file_name, conf=0.25, save=True)
    logger.debug(f'result[0].boxes.cls : {result_pred[0].boxes.cls}')

    names = model.names
    cls_name = []
    for c in result_pred[0].boxes.cls:
        cls_name.append(names[int(c)])

    logger.debug(f'predict_file_name : {predict_file_name}')
    response = {'Status': 'Success', 'detect_sym_code': cls_name, 'pred_file_name': predict_file_name}
    logger.debug(f'response : {response}')
    dict_dis = {'PO':'정상', 'VI': '비브리오증', 'SP': '연쇄구균병', 'MA': '스쿠티카병'}

    if len(cls_name) > 0:
        dis_name=dict_dis[cls_name[0][0:2]]
    else:
        dis_name = '정상'

    logger.debug(f'pred_img : {predict_file_name}, org_img={save_file_name}')
    # return redirect(f"http://121.179.7.40:8081/flounder_V03/detect_reg?pred_image={predict_file_name}&org_image={save_file_name}&dis_name={dis_name}")
    return redirect(f"http://211.223.106.39:8081/flounder_V05/detect_reg?pred_image={predict_file_name}&org_image={save_file_name}&dis_name={dis_name}")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

