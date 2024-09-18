from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from flask_cors import CORS
import re
import random
import smtplib
from email.message import EmailMessage


app = Flask(__name__)
CORS(app)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = 'root'
app.config["MYSQL_PASSWORD"] = "3122005x"
app.config["MYSQL_DB"] = "programingappflut"

mysql = MySQL(app)

def is_invalid_email(email):
    pattern =  r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    return re.match(pattern, email)

def is_invalid_password(password):
    if (len(password) >= 8 and re.search(r'[a-zA-Z]',password) and re.search(r'[0-9]', password)):
        return True

def email_SMTP(email):
    otp = ""
    for _ in range(6):
        otp += str(random.randint(0,9))

    cursor = mysql.connection.cursor()
    cursor.execute("UPDATE users SET OTP = %s WHERE email = %s", (otp,email))
    mysql.connection.commit()
    cursor.close()

    server = smtplib.SMTP("smtp.gmail.com", 587)
    server.starttls()

    from_mail = "appoaep@gmail.com"
    to_mail = email;
    server.login(from_mail, "uogw ruhh izjd rrpk")

    msg = EmailMessage()
    msg["Subject"] = "OTP Doğrulama"
    msg["From"] = from_mail
    msg["To"] = to_mail
    msg.set_content(f"OTP {otp}")

    server.send_message(msg)

    return jsonify({
        "message" : "Doğrulama kodu başarıyla gönderildi"
    })

@app.route("/register", methods = ["POST"])
def register():
    data = request.get_json()
    username = data['username']
    email = data['email']
    password = data['password']
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT*FROM users WHERE username = %s OR email = %s",(username,email))
    user = cursor.fetchone()
    if (username != ""):
        if (is_invalid_password(password)):
            if (is_invalid_email(email) is not None):
                if user is None:
                    cursor = mysql.connection.cursor()
                    cursor.execute("INSERT INTO users (username, email, password) VALUES (%s,%s,%s)",(username,email,password))
                    cursor.execute('INSERT INTO status_users (username, status_1, status_2,status_3,status_4,status_5) VALUES(%s, false , false,false,false,false)', (username,))
                    mysql.connection.commit()
                    email_SMTP(email)
                    cursor.close()
                    return jsonify({'message' : 'Kayıt başarıyla oluşturuldu'}),200
                else:
                    return jsonify({"message" : "Eposta yada Kullanıcı adı mevcut"}),400
            else:
                return jsonify({
                    "message" : "Eposta formatı yanlış"
                }),400
        else:
            return jsonify({
                "message" : "Şifre en az bir harf bir rakam ve 8 karakter olması gerekiyor"
            }),400
    else:
        return jsonify({
            "message" : "Lütfen isim formunu doldurun"
        }),400

@app.route("/login", methods = ["POST"])
def login():
    data = request.get_json();
    email = data['email']
    password = data['password']
    if (is_invalid_email(email) is not None):
        cursor = mysql.connection.cursor()
        cursor.execute("SELECT*FROM users WHERE email = %s AND password = %s", (email,password))
        user = cursor.fetchone()
        if (user):
            if (user[4] == "True"):
                return jsonify({
                    "message" : "Giriş başarılı"
                }),200
            else:
                return jsonify({
                    "message" : "Epostayı doğrulaman gerek"
                }),400
        else:
            return jsonify({
                "message" : "Giriş başarısız"
            }),400
    else:
        return jsonify({
            "message" : "Eposta formatı yanlış"
        }),400



@app.route("/verify_OTP", methods = ["POST"])
def verify_OTP():
    data = request.get_json()
    otp = data["OTP"]

    cursor = mysql.connection.cursor()
    cursor.execute("SELECT*FROM users WHERE OTP = %s", (otp,))
    user = cursor.fetchone()
    if (user):
        cursor.execute("UPDATE users SET OTP = %s WHERE OTP = %s", ("True", otp))
        mysql.connection.commit()
        cursor.close()
        return jsonify({
            "message" : "Epostan doğrulandı"
        }),200
    else:
        return jsonify({
            "message" : "Doğrulama kodu yanlış"
        }),400


@app.route('/get_username', methods = ["GET"])
def get_username():
    data = request.args
    email = data.get('email')
    password = data.get('password')
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT*FROM users WHERE email = %s AND password = %s", (email, password))
    user = cursor.fetchone()
    cursor.close()
    if (user):
        return jsonify({
            "username" : user[1]
        })
    else:
        return jsonify({
            "username" : "invalid"
        })


@app.route('/get_missions', methods = ["GET"])
def get_missions():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT*FROM missions")
    missions = cursor.fetchall()
    cursor.close()
    all_missions = list()
    for mission in missions:
        all_missions.append({
            'id' : mission[0],
            'mission' : mission[1],
            'image' : mission[2],
            'description' : mission[3]
        })
    return jsonify(all_missions)

@app.route("/update_status", methods = ["POST"])
def update_status():
    data = request.get_json()
    username = data['username']
    status = data['id']
    cursor = mysql.connection.cursor()
    cursor.execute(f'UPDATE status_users SET status_{status} = 1 WHERE username = %s',(username,))
    mysql.connection.commit()
    cursor.close()
    return jsonify({
        "message" : "Görev Tamamlandı"
    })


@app.route("/check_status", methods = ["GET"])
def check_status():
    data = request.args;
    username = data.get("username")
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT*FROM status_users WHERE username = %s",(username,))
    user_status_info = cursor.fetchone()
    return jsonify({
        "status_1" : user_status_info[1],
        "status_2" : user_status_info[2],
        "status_3" : user_status_info[3],
        "status_4" : user_status_info[4],
        "status_5" : user_status_info[5]
    })


if (__name__ == "__main__"):
    app.run(debug=True);
