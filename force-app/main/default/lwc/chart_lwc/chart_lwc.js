import { LightningElement, track } from 'lwc';
import chartjs from '@salesforce/resourceUrl/ChartJs2_8';
import { loadScript } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Chart_lwc extends LightningElement {

    async renderedCallback() {
        if (this.chartjsInitialized) {
            return;
        }
        this.chartjsInitialized = true;
        await loadScript(this, chartjs);
    }

    @track chart;
    generateChart() {
        const ctx = this.template.querySelector('canvas.chart').getContext('2d');
        const chartData = {
            labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
            datasets: [
                {
                    label: '# of Votes',
                    data: [12, 19, 3, 5, 2, 3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }
            ]
        };
        const chartOptions = {
            responsive: true,
            legend: {
                position: 'right'
            },
            title: {
                display: true,
                text: 'Polar Area Chart'
            },
            scale: {
                ticks: {
                    beginAtZero: true
                },
                reverse: false
            },
            animation: {
                animateRotate: false,
                animateScale: true
            }
        };
        this.chart = new window.Chart(ctx, {
            type: 'polarArea',
            data: chartData,
            options: chartOptions
        });
    }

    connectedCallback() {
        this.renderedCallback();
        this.generateChart();
    }
    
    
}