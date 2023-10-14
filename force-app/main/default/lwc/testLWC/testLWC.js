import { LightningElement, track } from 'lwc';
import getActiveAccounts from '@salesforce/apex/AboutAccounts.getActiveAccounts';

export default class TestLWC extends LightningElement {


   @track data = [];
   @track columns = [
        {label: 'Account Name', fieldName: 'Name', type: 'text'},
        {label: 'Industry', fieldName: 'Industry', type: 'text'},
        {label: 'Phone', fieldName: 'Phone', type: 'text'},
    ];
    @track searchKey = '';


    connectedCallback() {
        getActiveAccounts()
            .then(result => {
                this.data = result;
            })
            .catch(error => {
                console.error(error);
            });
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
            getActiveAccounts()
                .then(result => {
                    this.data = result;
                })
                .catch(error => {
                    console.error(error);
                });
        }
    }



}