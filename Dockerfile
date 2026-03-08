# Use the official Python image
FROM python:3.12.1

# Install uv package manager
RUN pip install uv

# Set the working directory inside the container
WORKDIR /app

# Copy dependency files (Separated by spaces, NO COMMAS)
COPY pyproject.toml .python-version uv.lock ./

# Install dependencies using uv
RUN uv sync --locked

# Copy the prediction script and the model file
COPY predict.py model.bin ./

# Inform Docker that the container listens on port 9696
EXPOSE 9696

# The command to run your app
ENTRYPOINT ["uv", "run", "uvicorn", "predict:app", "--host", "0.0.0.0", "--port", "9696"]