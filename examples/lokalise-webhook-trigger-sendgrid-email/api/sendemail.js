const sgMail = require('@sendgrid/mail');
require('dotenv').config();


export default async function handler(request, response) {
   await  sgMail.setApiKey(process.env.SENDGRID_API_KEY);
    
    const webhookData = request.body;
    console.log('webhookData --->', JSON.stringify(webhookData), typeof webhookData);
    
    const { email } = request.query;
    const to = email || 'anil.kumar@lokalise.com';
    const subject = webhookData && webhookData.user? `${webhookData.user.email} triggered ${webhookData.event} on project - ${webhookData.project.name} `: 'webhook triggered';

    const msg = {
        to, // Change to your recipient
        from: 'product.demo+sendgrid@lokalise.com', // Change to your verified sender
        subject,
        // text: 'Localization with Lokalise is easy to do anywhere, even with Figma',
        html: `for more details check your <a href="https://app.lokalise.com/">Lokalise</a> project.`,
    }
    await sgMail
        .send(msg)
        .then(() => {
            console.log('Email sent')
        })
        .catch((error) => {
            console.error(error)
        })

    response.end(`Request process done!`);
}