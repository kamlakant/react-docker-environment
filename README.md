# Using environment variables in dockerized React application

React applications run on user's browsers so technically we can't have run-time environment variables for a pure frontend application running in docker container (without using any server-side rendering e.g. nginx). However, we can utilize environment variables to create environment specific Docker builds (e.g. DEV, QA, PROD).<br>

Here is a comprehensive guide on building environment specific React application with Docker:

### Step 1
Create the React application.
`npx create-react-app react-docker-environment`

### Step 2
Add `env-cmd` dependency.
`yarn add env-cmd`

### Step 3
Add environment specific files in application's root directory and declare KEY=VALUE variables.

### Step 4
Use the environment variables in React application code. Environment variables should be referenced using `${process.env.<VARIABLE_KEY>}` syntax.

### Step 5
Add below build scripts in `package.json`:
```
"build": "env-cmd .env.dev react-scripts build",
    "build:dev": "env-cmd .env.dev react-scripts build",
    "build:qa": "env-cmd .env.qa react-scripts build",
    "build:prod": "env-cmd .env.prod react-scripts build",
```

### Step 6
Add Dockerfile with build ARG `REACT_ENV`. Provide a default argument as fail-safe measure.

### Step 7
Build dockerfile.
`docker build --build-arg REACT_ENV=prod -t reactdocker .`

### Step 8
Run Docker container.
`docker run -p 3000:3000 --rm reactdocker`

### Step 9
Open http://localhost:300 in browser. We can see the API URL changes as per the given environment variable.