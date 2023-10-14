import { LightningElement, api, track, wire } from 'lwc';
import getContacts from '@salesforce/apex/AboutContacts.getContacts';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.Name',
    'Contact.Title',
    'Contact.Phone',
    'Contact.Email',
];
export default class Account_record_lwc extends LightningElement {    
    
       @track data = [];
       @track columns = [
            {label: 'Contact Name', fieldName: 'Name', type: 'text'},
            {label: 'Email', fieldName: 'Email', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'text'},
        ];
      
        @track searchKey = '';
    
        @api recordId;

        
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;


    
    get name() {
        return this.contact.data.fields.Name.value;
    }

    get title() {
        return this.contact.data.fields.Title.value;
    }

    get phone() {
        return this.contact.data.fields.Phone.value;
    }

    get email() {
        return this.contact.data.fields.Email.value;
    }
    
        connectedCallback() {

            console.log('Record ID : ', this.recordId);
            // getContacts()
            //     .then(result => {
            //         this.data = result;
            //     })
            //     .catch(error => {
            //         console.error(error);
            //     });
        }
    
        handleSearch(event) {
            
            const searchKey = event.target.value.toLowerCase();
            console.log('value of searchKey',searchKey);
            if (searchKey) {
                console.log('handleSearch condition');
                const regex = new RegExp(searchKey, 'i');
                this.data = this.data.filter(record => regex.test(record.Name));
                console.log('after filtering : ', this.data);
            } else {
                console.log('the else');
                getContacts()
                    .then(result => {
                        this.data = result;
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }
        }
    
    
    
    }