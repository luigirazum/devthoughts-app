<a name="readme-top"></a>

<div align="center">

  <img src="app/assets/images/logos/devthoughts-logo.svg" alt="logo" width="150" height="auto" />
  <br/>

### DevThoughts Blog
**DevThoughts** is a _Blog App_ oriented for Developers where they will be able to learn or teach from other's experiencies. It's a fully functional _website_ that will show the _Posts_ made by the Developers and empower other Developers to interact with them by _Adding Comments_ to the _Post_ or _showing their support by giving_ a _Like_ to that _Post_.

</div>

<div align="center"><hr width="250px"/></div>

# 📗 Table of Contents

- [💬 About the project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
  - [Key Features](#key-features)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Usage](#usage)
  - [Run](#run)
  - [Open](#open)
- [👥 Author](#author)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<div align="center"><hr width="250px"/></div>

# 💬 **DevThoughts** Blog <a name="about-project"></a>

**DevThoughts** is a _Blog App_ oriented for Developers where they will be able to learn or teach from other's experiencies. It's a fully functional _website_ created with [Rails](https://rubyonrails.org/) that will show the _Posts_ made by the Developers and empower other Developers to interact with them by _Adding Comments_ to the _Post_ or _showing their support by giving_ a _Like_ to that _Post_.

To _preserve_ the data we are going to create a [PostgreSQL](https://www.postgresql.org/) **Database** based on the **ERD Diagram** showed below.

- ### How to build the **DevThoughts** Blog <a name="howto-build"></a>

  The end result should follow the next data model (Entity Relationship Diagram):

  <p align="center">
    <img src="app/assets/images/erd/sneak_peak_erd.png" alt="Data model" width="500px"  />
  </p>

  This project keep the following wireframes:

  <p align="center">
    <img src="app/assets/images/wireframes/sneak_peak_login.png" alt="Login page wireframe" width="200px" />
    <img src="app/assets/images/wireframes/sneak_peak_users.png" alt="All users page wireframe"  width="200px"  />
    <img src="app/assets/images/wireframes/sneak_peak_user.png" alt="Single user page wireframe"  width="200px"  />
  </p>

  <p align="center">
    <img src="app/assets/images/wireframes/sneak_peak_posts.png" alt="All posts by a given user page wireframe"  width="200px"  />
    <img src="app/assets/images/wireframes/sneak_peak_post.png" alt="Single post page wireframe"  width="200px"  />
  </p>

  We will be guided **step by step**, and because of that we will have a chance to practice our knowledge and learn more about basic [**Ruby on Rails**](https://rubyonrails.org/) concepts - starting from the _**Views**_ and finishing the _**database connection**_.

  We will also **implement** ideas like _**authentication**_, _**authorization**_, and all kinds of _**tests**_.

  In the last step, we will have a chance to **create** an _**API**_ instead of _API consumption_, so the project could be implemented on mobile platforms as well.


## 🛠 Built With <a name="built-with"></a>

- ### Tech Stack <a name="tech-stack"></a>

  <ul>
     <li>
      <a href="https://www.ruby-lang.org/en/">
      <img align="center" width="19" height="auto" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/198px-Ruby_logo.svg.png?20101129171534" alt="ruby logo" />
      Ruby
      </a>
    </li>
    <li>
      <a href="https://rubyonrails.org/">
      <img align="center" width="19" height="auto" src="app/assets/images/logos/rails-red-logo.svg" alt="ruby logo" />
      Rails
      </a>
    </li>
    <li>
      <a href="https://www.postgresql.org/">
      <img align="center" width="19" height="auto" src="https://wiki.postgresql.org/images/3/30/PostgreSQL_logo.3colors.120x120.png" alt="postgreSQL logo" />
      PostgreSQL
      </a>
    </li>
  </ul>

<!-- Features -->

- ### Key Features <a name="key-features"></a>

  As we go through the creation of this project, we'll be adding all the features implemented.
  - Uses a **PostgreSQL** database to persist the data.
  - The **MVC** software design pattern is used.
  - It is a **Blog** App that will allow us to:
    - **Create** _Posts_.
    - Leave a _Comment_ (**create**) to any _Post_.
    - Support a _Post_ by giving(**create**) a _Like_ to that _Post_.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO

## 🚀 Live Demo <a name="live-demo"></a>

> Add a link to your deployed project.

- [Live Demo Link](<replace-with-your-deployment-URL>)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->
<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy of this project up and running, follow these steps.

- ### Prerequisites

  - `git` installed. Please got to [Getting Started - Installing Git guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and follow the steps described for your system to install `git`.
  - `Ruby` installed, you can go to the [Installing Ruby](https://www.ruby-lang.org/en/documentation/installation/) documentation and follow the steps for your computer OS.
  - `Rails` installed, you can follow the [GoRails Tutorial](https://gorails.com/setup/) and follow the steps for your computer OS.
  - `PostgreSQL` installed, you can follow the [PostgreSQL Tutorial](https://www.postgresqltutorial.com/) and follow the steps for your computer OS.

- ### Setup
  Clone this repository to your `local-folder`:
  ```sh
  cd local-folder
  git clone git@github.com:luigirazum/devthoughts-app.git
  ```
- ### Usage
  In the `local-folder` where you cloned the project, go into the project folder
  ```sh
  cd devthoughts-app
  ```
- ### Prepare
  In the `devthoughts-app` folder, use the following code to install the app dependencies
  ```rb
  bundle install
  ```
- ### Run
  In the `devthoughts-app` folder, use the following code to run the app
  ```rb
  rails server
  ```
- ### Open
  Open your favorite `browser` and type in the address bar
  ```sh
  http://localhost:3000
  ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>
<!-- AUTHORS -->

## 👥 Author <a name="author"></a>

👨‍💻 **Luis Zubia**

<ul>
  <li>
    <a href="https://github.com/luigirazum">
    <img align="center" width="18px" src="https://upload.wikimedia.org/wikipedia/commons/2/24/Github_logo_svg.svg" alt="github logo" />
    <b>@luigirazum</b>
    </a>
  </li>
  <li>
  <!-- TODO: Change X-Logo source file -->
    <a href="https://twitter.com/LuigiRazum">
    <img align="center" width="18px" src="app/assets/images/logos/x-new-logo.svg" alt="twitter logo" />
    <b>@LuigiRazum</b>
    </a>
  </li>
  <li>
    <a href="https://linkedin.com/in/luiszubia">
    <img align="center" width="18px" src="https://upload.wikimedia.org/wikipedia/commons/c/ca/LinkedIn_logo_initials.png" alt="linkedin logo" />
    <b>/luiszubia</b>
    </a>
  </li>
</ul>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- **Delete** a _Post_ previously created.
- **Delete** a _Comment_ previously created.
- **Unlike** a certain _Post_.
- Implement **Authentication** options like _Registration_(**sign-up**), _LogIn_(**log-in**), _LogOut_(**log-out**), _Change Password_ for `Users`
- Implement **Authorization**, so _Post_'s, _Comment_'s and _Like_'s that weren't created by the logged user can be modified or deleted only by the user who created it.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, typos, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

If you like this project, your support giving a ⭐ will be highly appreciated.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

- I would like to thank [Yukihiro “Matz” Matsumoto](http://www.rubyist.net/~matz/) for creating the [Ruby Programming Language](https://www.ruby-lang.org/en/).
- Thanks [David Heinemeier Hansson](https://en.wikipedia.org/wiki/David_Heinemeier_Hansson) for sharing [Rails](https://rubyonrails.org/) to the world.\
_**Wikipedia:** [Ruby on Rails - History](https://en.wikipedia.org/wiki/Ruby_on_Rails)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FAQ (optional)

## ❓ FAQ <a name="faq"></a>

> Add at least 2 questions new developers would ask when they decide to use your project.

- **[Question_1]**

  - [Answer_1]

- **[Question_2]**

  - [Answer_2]

<p align="right">(<a href="#readme-top">back to top</a>)</p>
-->
<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
