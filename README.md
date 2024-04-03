<div id="top"></div>

[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<br />
<div align="center">
  <a href="https://github.com/blesten/financial-planner">
    <img src="client/assets/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Budget Buddy</h3>

  <p align="center">
    An awesome financial planner application based on mobile
    <br />
    <a href="https://github.com/blesten/financial-planner"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://youtu.be/l8LGt690G04">View Demo</a>
    ·
    <a href="https://github.com/blesten/financial-planner/issues">Report Bug</a>
    ·
    <a href="https://github.com/blesten/financial-planner/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## About The Project

Welcome to the **Budget Buddy** Github repository! Here, you'll find the source code for our sleek and sophisticated financial planner application. Built with modern technologies and a focus on user experience, our application aims to provide users with an effortless financial planning experience.

<p align="right"><a href="#top">back to top</a></p>

### Built With

Main technology used to built this application are listed below:

* [Flutter](https://www.flutter.dev/)
* [Typescript](https://www.typescriptlang.org/)
* [Node.js](https://www.nodejs.org/)
* [Express.js](https://www.expressjs.com/)
* [MongoDB](https://www.mongodb.com/cloud/atlas/)

<p align="right"><a href="#top">back to top</a></p>

## Getting Started

To get started with this project locally, follow below steps:

### Prerequisites

Make sure you have your device emulator, Flutter, Node.js, and package manager (either npm or yarn) installed

>**FYI**: This project uses **yarn** as the server package manager, but you're free to use **npm** too.

### Installation

Below steps will guide you through the local installation process of this application

1. Clone the repo
   ```
   git clone https://github.com/blesten/financial-planner.git
   ```
2. Complete the .env variable at /server directory
Rename .env.example file at ```/config``` directory become ```.env```, then fill the value for every key. Below is the guideline for filling the .env value:<br/>
    | Key | What to Fill | Example Value |
    | :---: | :---: | :---: |
    | PORT | Your server port | 5000 |
    | MONGO_URL | Your MongoDB connection URL | mongodb+srv://username:password@main.14znatw.mongodb.net/DBName?retryWrites=true&w=majority |
    | ACCESS_TOKEN_SECRET | Your JWT access token secret | NzeWG39JJNWASRKTeM85Ki77yZbdXZapvfIfepxz7d2WG |
    | TWILIO_ACCOUNT_SID | Your <a href="https://www.twilio.com/">Twilio</a> account SID | ACu893432jfoif |
    | TWILIO_AUTH_TOKEN | Your <a href="https://www.twilio.com/">Twilio</a> auth token | 7cdjsfsf9df |
    | TWILIO_SERVICE_SID | Your <a href="https://www.twilio.com/">Twilio</a> service SID | VA8293303 |
4. Go to ```lib/utils/constants.dart``` at ```/client``` directory, and replace the ```serverURL``` port with the ```PORT``` defined previously at ```.env``` file. And for the domain itself, match it with the device that you're currently using. (For Android, http://10.0.2.2 can be used as the domain)
5. Open your terminal and ```cd``` to the ```/server``` directory, then run ```yarn install``` to install all the server dependencies
6. Open your terminal and ```cd``` to the ```/client``` directory, then run ```flutter pub get``` to install all the client dependencies
7. After installing the dependencies for both client and server, run ```yarn dev``` at the terminal that currently pointing at ```/server``` directory to start the server
8. To start the flutter application, run ```flutter run``` at the terminal that currently pointing at ```/client``` directory

<p align="right"><a href="#top">back to top</a></p>

## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right"><a href="#top">back to top</a></p>

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right"><a href="#top">back to top</a></p>

## Contact

LinkedIn: [Stanley Claudius](https://www.linkedin.com/in/stanleyclaudius)

Project Link: [https://github.com/blesten/financial-planner](https://github.com/blesten/financial-planner)

<p align="right"><a href="#top">back to top</a></p>

## Acknowledgments

Special thanks to:

* [Othneildrew](https://github.com/othneildrew/) for providing an amazing README template.

<p align="right"><a href="#top">back to top</a></p>

[forks-shield]: https://img.shields.io/github/forks/blesten/financial-planner.svg?style=for-the-badge
[forks-url]: https://github.com/blesten/financial-planner/network/members
[stars-shield]: https://img.shields.io/github/stars/blesten/financial-planner.svg?style=for-the-badge
[stars-url]: https://github.com/blesten/financial-planner/stargazers
[issues-shield]: https://img.shields.io/github/issues/blesten/financial-planner.svg?style=for-the-badge
[issues-url]: https://github.com/blesten/financial-planner/issues
[license-shield]: https://img.shields.io/github/license/blesten/financial-planner.svg?style=for-the-badge
[license-url]: https://github.com/blesten/financial-planner/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/stanleyclaudius