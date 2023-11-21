import { LightningElement, wire } from 'lwc';
import BOOKS from '@salesforce/resourceUrl/Books';
import getAllBooks from '@salesforce/apex/Books.getAllBooks';

export default class Books extends LightningElement {
    // directly reference this
    // create a variable and you can refer that variable
    bookResources=BOOKS+'/Books/AtomicHabits.jpg';
    bookInfo;

    @wire(getAllBooks)
    books({error,data}){
        if(data){
            console.log("Book records: ",data);
            this.bookInfo=data;
        }
        else if(error){
            console.log("error : ",error);
        }
    }
}