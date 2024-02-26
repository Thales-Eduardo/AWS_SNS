require("dotenv/config");

const cors = require("cors");
const express = require("express");
const helmet = require("helmet");
require("express-async-errors");

const enviarMensagem = require("./sns");

const processId = process.pid;
const app = express();
const port = 3333;

app.use(helmet());
app.use(express.json());
app.use(cors());

app.use((err, req, res, next) => {
  if (err) {
    return res.status(err.statusCode).json({
      status: "error",
      message: err.message,
    });
  }

  console.error(err);

  return res.status(500).json({
    status: "error",
    message: "Internal server error",
  });
});

app.get("/", async (req, res) => {
  const ipAddress =
    req.headers["x-forwarded-for"] || req.connection.remoteAddress;
  const origin = req.headers.host;

  const obj = {
    host: origin,
    ip: "seu ip: " + ipAddress,
  };
  res.send(obj);
});

app.post("/enviar_mensagem", async (req, res) => {
  await enviarMensagem();
  res.json({ ok: true });
});

const server = app.listen(port, () => {
  console.log(`http://localhost:${port} 🔥🔥🚒 ${processId}`);
});

// ---- Graceful Shutdown
function gracefulShutdown(event) {
  const data = new Date().toLocaleString();
  return (code) => {
    console.log(`${event} - server ending ${code}`, data);
    server.close(async () => {
      process.exit(0);
    });
  };
}

//disparado no ctrl+c => multiplataforma
process.on("SIGINT", gracefulShutdown("SIGINT"));
//Para aguardar as conexões serem encerradas para só então encerrar a aplicação.
process.on("SIGTERM", gracefulShutdown("SIGTERM"));

// captura erros não tratados
process.on("uncaughtException", (error, origin) => {
  console.log(`${origin} uncaughtException -  signal received ${error}`);
});
process.on("unhandledRejection", (error) => {
  console.log(`unhandledRejection - signal received ${error}`);
});
process.on("exit", (code) => {
  console.log(`exit signal received ${code}`);
});

// // simular um erro
// setTimeout(() => {
//   process.exit(1);
// }, Math.random() * 1e4); // 10.000
