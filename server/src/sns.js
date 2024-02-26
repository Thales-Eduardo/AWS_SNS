// É preciso que um tópico ja esteja criado
const { SNSClient, PublishBatchCommand } = require("@aws-sdk/client-sns");

const enviarMensagem = async () => {
  const client = new SNSClient({
    region: "us-east-1",
    credentials: {
      accessKeyId: process.env.AWS_ACCESS_KEY_ID,
      secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    },
  });

  const params = {
    TopicArn: process.env.TOPIC_ARN,
    PublishBatchRequestEntries: [
      {
        Id: "1234", // required
        Message: "testando sns", // required
      },
    ],
  };
  const command = new PublishBatchCommand(params);

  try {
    const data = await client.send(command);
    console.log(data);
  } catch (error) {
    console.log(error);
  }
};

module.exports = enviarMensagem;
