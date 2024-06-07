let admin=document.querySelector(".admin");
let admin2=document.querySelector(".admin2");
let SignIn=document.querySelector(".SignIn");
let User_Login=document.querySelector(".User_Login");
let Admin_Login=document.querySelector(".Admin_Login");
let git_btn=document.querySelector('.get_in_touch_container');
let git=document.querySelector('.get_in_touch');
let SignUp=document.querySelector('.User_SignUp');
let SignUpBtn=document.querySelector('.SignUp');


let burger=document.getElementById('burger');


//This Event Listener is used to (remove) or (add) popup menu when user click on class="ham_burger" 
burger.addEventListener('click',()=>{
    //Add and Remove burger Pop Up Menu 
    document.getElementById('pop1').classList.toggle('ShowPopUpMenu');
    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");

    //Remove Sign Up Menu
    SignUp.classList.remove('show_login_Page');
    //remove User login Menu
    User_Login.classList.remove('show_login_Page');
    //remove Admin login Menu
    Admin_Login.classList.remove('show_login_Page');
    //remove get in touch menu
    git.classList.remove('show_login_Page');
})

// Arrow Pop UP Menu
function rightPopUp(){
    document.getElementById("pop2").classList.toggle("ShowPopUpMenu");
    document.getElementById("arrow").classList.toggle("arrow_direction");
    //remove burger Pop Up Menu
    document.getElementById('pop1').classList.remove('ShowPopUpMenu');

    //Remove Sign Up Menu
    SignUp.classList.remove('show_login_Page');
    //remove User login Menu
    User_Login.classList.remove('show_login_Page');
    //remove Admin login Menu
    Admin_Login.classList.remove('show_login_Page');
    //remove get in touch menu
    git.classList.remove('show_login_Page');
}





admin.addEventListener('click',()=>{
    //Add and Remove Admin Login Menu
    Admin_Login.classList.toggle('show_login_Page');
    //Remove Login Page of User Login Menu
    User_Login.classList.remove('show_login_Page');
    //Remove Get In Touch Menu
    git.classList.remove('show_login_Page');
    //Remove Sign Up Menu
    SignUp.classList.remove('show_login_Page');

    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");
})

admin2.addEventListener('click',()=>{
    //Add and Remove Admin2 Login Menu
    Admin_Login.classList.toggle('show_login_Page');
    User_Login.classList.remove('show_login_Page');
    git.classList.remove('show_login_Page');
    SignUp.classList.remove('show_login_Page');

    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");
})

SignIn.addEventListener('click',()=>{
    //Add and Remove User Login Menu
    User_Login.classList.toggle('show_login_Page');
    Admin_Login.classList.remove('show_login_Page');
    git.classList.remove('show_login_Page');
    SignUp.classList.remove('show_login_Page');

    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");
})

git_btn.addEventListener('click',()=>{
    //Add and Remove Get In Touch Menu
    git.classList.toggle('show_login_Page');
    Admin_Login.classList.remove('show_login_Page');
    User_Login.classList.remove('show_login_Page');
    SignUp.classList.remove('show_login_Page');

    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");
})

SignUpBtn.addEventListener('click',()=>{
    //Add and Remove Sign Up Menu
    SignUp.classList.toggle('show_login_Page');
    //remove User login Menu
    User_Login.classList.remove('show_login_Page');
    //remove Admin login Menu
    Admin_Login.classList.remove('show_login_Page');
    //remove get in touch menu
    git.classList.remove('show_login_Page');

    // Remove Arrow Pop UP Menu
    document.getElementById("pop2").classList.remove("ShowPopUpMenu");
    document.getElementById("arrow").classList.remove("arrow_direction");
})



