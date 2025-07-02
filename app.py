from flask import Flask, render_template, request
import tensorflow as tf
from PIL import Image
import numpy as np
import os
import openai

app = Flask(__name__)
model = tf.keras.models.load_model('plant_disease_model.h5')
openai.api_key = os.getenv("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")

# Dummy dictionary for simple advice
disease_advice = {
    "Healthy": "Your plant looks great! Keep it up!",
    "Powdery mildew": "Remove infected leaves and avoid overhead watering.",
    # Add more...
}

def predict_disease(img_path):
    img = Image.open(img_path).resize((224, 224))
    img_array = np.array(img) / 255.0
    img_array = np.expand_dims(img_array, axis=0)
    prediction = model.predict(img_array)
    class_index = np.argmax(prediction)
    class_names = ["Healthy", "Powdery mildew"]  # Update this list
    return class_names[class_index]

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        image = request.files["image"]
        filepath = os.path.join("uploads", image.filename)
        image.save(filepath)

        disease = predict_disease(filepath)
        advice = disease_advice.get(disease, "No advice available.")
        tips = generate_care_tips(disease)

        return render_template("index.html", disease=disease, advice=advice, tips=tips)

    return render_template("index.html")

if __name__ == "__main__":
    app.run(debug=True)
