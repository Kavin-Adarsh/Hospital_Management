from flask import Flask, render_template, request, redirect, url_for
import pymysql

app = Flask(__name__)

# Database connection details

db_host = '127.0.0.1'
db_user = 'root'
db_password = 'Mylifesucks/0'
db_name = 'hospital'
# Function to connect to the database
def connect_to_database():
    return pymysql.connect(host=db_host, user=db_user, password=db_password, database=db_name)

# Route for the login page
@app.route('/')
def login():
    return render_template('login.html')

# Route for handling login form submission
@app.route('/login', methods=['POST'])
def login_post():
    email = request.form.get('email')
    password = request.form.get('password')

    # Check if it's a patient
    with connect_to_database().cursor() as cursor:
        cursor.execute("SELECT * FROM patient WHERE email = %s AND password = %s", (email, password))
        patient = cursor.fetchone()

    if patient:
        # Redirect to patient page
        return redirect(url_for('patient', patient_id=patient[0]))

        # Check if it's a patient
    with connect_to_database().cursor() as cursor:
        cursor.execute("SELECT * FROM admin WHERE email = %s AND password = %s", (email, password))
        patient = cursor.fetchone()

    if patient:
        # Redirect to admin page
        return redirect(url_for('patient', patient_id=patient[0]))

    # Check if it's a doctor
    with connect_to_database().cursor() as cursor:
        cursor.execute("SELECT * FROM doctor WHERE email = %s AND password = %s", (email, password))
        doctor = cursor.fetchone()

    if doctor:
        # Redirect to doctor page
        return redirect(url_for('doctor', doctor_id=doctor[0]))

    # If no matching user found, return to login page
    return render_template('login.html', error='Invalid email or password')

# Route for the patient page
@app.route('/patient/<int:patient_id>')
def patient(patient_id):
    # Retrieve patient details from the database using patient_id
    with connect_to_database().cursor() as cursor:
        cursor.execute("SELECT * FROM patient WHERE patient_id = %s", (patient_id,))
        patient = cursor.fetchone()

    # Check if patient exists
    if patient:
        return render_template('patient.html', patient=patient)
    else:
        return "Patient not found", 404

# Route for the doctor page
@app.route('/doctor/<int:doctor_id>')
def doctor(doctor_id):
    # Retrieve doctor details from the database using doctor_id
    with connect_to_database().cursor() as cursor:
        cursor.execute("SELECT * FROM doctor WHERE doctor_id = %s", (doctor_id,))
        doctor = cursor.fetchone()

    # Check if doctor exists
    if doctor:
        return render_template('doctor.html', doctor=doctor)
    else:
        return "Doctor not found", 404

if __name__ == '__main__':
    app.run(debug=True)
