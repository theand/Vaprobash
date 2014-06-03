<?php
require_once 'vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\RotatingFileHandler;
use Monolog\ErrorHandler;

// create a log channel
$log = new Logger('boris');
$log->pushHandler(new RotatingFileHandler('./logs/boris.log', 0, Logger::WARNING));

ErrorHandler::register($log);

$boris = new \Boris\Boris();

\Boris\Loader\Loader::load($boris, array(
    new \Boris\Loader\Provider\Composer(),
));

$boris->setPrompt('REPL> ');

$boris->setLocal(array('log' => $log));

$boris->start();
