import { LightningElement } from 'lwc';

import login from '@salesforce/apex/LoginUser.login';

export default class AmazonClone extends LightningElement {
    email;
    password;
    isError = false;
    errorMessage = '';

    handleUsername(event) {
        this.email = event.target.value;
    }

    handlePasswordChange(event) {
        this.password = event.target.value;
    }

    handleLogin() {
        console.log("Inside Login");
        console.log("Email value: ", this.email);
        console.log('Password ', this.password);
        if (this.email != null && this.password != null) {
            login({ userName: this.email, password: this.password })
                .then((result) => {
                    this.isError = false;
                    console.log('Result is: ', result);
                })
                .catch((error) => {
                    console.log('error: ', error);
                    this.isError = true;
                    this.errorMessage = error.body.message;
                })
        }

    }
}