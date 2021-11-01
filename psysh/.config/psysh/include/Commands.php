<?php

namespace X;

use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Helper\Table;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Database\Eloquent\Model;

class ModelsCommand extends Command
{
  protected function configure()
  {
    $this->setName('models')
      ->setAliases(['m'])
      ->setDescription('List all models')
      ->setDefinition([
        new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only models matching this string'),
    ]);
  }

  protected function execute(InputInterface $input, OutputInterface $output)
  {
    $filter = $input->getArgument('filter');

    $table = new Table($output);
    $table->setHeaders(['Namespace', 'Model']);

    $classes = Tinker::getSubclasses(\Illuminate\Database\Eloquent\Model::class);
    foreach ($classes as $class) {
      if (Str::of($filter)->trim()->isNotEmpty && !Str::of($class)->contains($filter)) continue;

      $table->addRow([
        Str::of($class)->beforeLast('\\'),
        Str::of($class)->afterLast('\\'),
      ]);
    }

    $table->render();

    return 0;
  }
}

class ControllersCommand extends Command
{
  protected function configure()
  {
    $this->setName('controllers')
    ->setAliases(['c'])
      ->setDescription('List all controllers')
      ->setDefinition([
        new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only controllers matching this string'),
      ]);
  }

  protected function execute(InputInterface $input, OutputInterface $output)
  {
    $filter = $input->getArgument('filter');

    $table = new Table($output);
    $table->setHeaders(['Namespace', 'Controller']);

    $classes = Tinker::getSubclasses(\Illuminate\Routing\Controller::class);
    foreach ($classes as $class) {
      if (Str::of($filter)->trim()->isNotEmpty && !Str::of($class)->contains($filter)) continue;

      $table->addRow([
        Str::of($class)->beforeLast('\\'),
        Str::of($class)->afterLast('\\'),
      ]);
    }

    $table->render();

    return 0;
  }
}

class RoutesCommand extends Command
{
  protected function configure()
  {
    $this->setName('routes')
      ->setAliases(['r'])
      ->setDescription('List all routes')
      ->setDefinition([
        new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only routes with uri matching this string'),
      ]);
  }

  protected function execute(InputInterface $input, OutputInterface $output)
  {
    $table = new Table($output);
    $table->setHeaders(['URI', 'Method', 'Middleware', 'Action']);

    $filter = $input->getArgument('filter');

    collect(Route::getRoutes()->getRoutes())
      ->sortBy('uri')
      ->each(function($r) use ($table, $filter) {
        $uri = Str::of($r->uri);
        if (Str::of($filter)->trim()->isNotEmpty && !$uri->contains($filter)) return;

        $action = Arr::has($r->action, 'controller')
          ? Str::of($r->action['controller'])->afterLast('\\')
            ->replaceLast('@', ' @ <info>')->finish('</info>')
          : '<comment>closure</comment>';

        $middleware = Arr::has($r->action, 'middleware')
          ? Str::of(collect($r->action['middleware'])->implode(' '))->limit(20)
          : '';

        $table->addRow([
          $uri->replaceMatches('/{.*?}/', function ($match) {
              return "<info>{$match[0]}</info>";
          }),
          Str::of(collect($r->methods)->reject("HEAD")->implode(' '))->limit(10),
          $middleware,
          $action,
        ]);
      });

    $table->render();

    return 0;
  }
}

class ArtisanCommand extends Command
{
  protected function configure()
  {
    $this->setName('artisan')
      ->setAliases(['a'])
      ->setDescription('run artisan commands')
      ->setDefinition([
        new CodeArgument('target', CodeArgument::OPTIONAL, 'actual command to run'),
      ]);
  }

  protected function execute(InputInterface $input, OutputInterface $output)
  {
    $target = $input->getArgument('target');

    $cmd = $target;
    if (empty($target)) {
      $cmd = 'list';
    }

    \Artisan::call($cmd);
    $output->writeln(\Artisan::output());

    return 0;
  }
}

class ModelRelationsCommand extends Command
{
  protected function configure()
  {
    $this->setName('model-relations')
    ->setAliases(['mr'])
      ->setDescription('show all relations of a given Model class')
      ->setDefinition([
        new CodeArgument('target', CodeArgument::REQUIRED, 'model to analyze'),
      ]);
  }

  private function getRelationships($target)
  {
    $rc = new \ReflectionClass($target);
    if (!$rc->isSubclassOf(Model::class)) {
      throw new \InvalidArgumentException("$target is not a valid model class");
    }

    $target = new $target;

    $relationships = [];

    foreach ($rc->getMethods(\ReflectionMethod::IS_PUBLIC) as $method) {

      if ($method->class != $rc->getName()) continue;
      if (!empty($method->getParameters())) continue;
      if ($method->getName() == __FUNCTION__) continue;

      $return = $method->invoke($target);

      if ($return instanceof Relation) {
        $relationships[$method->getName()] = [
          'name' => $method->getName(),
          'type' => (new \ReflectionClass($return))->getShortName(),
          'model' => (new \ReflectionClass($return->getRelated()))->getName(),
        ];
      }
    }

    return $relationships;
  }

  protected function execute(InputInterface $input, OutputInterface $output)
  {
    $target = $input->getArgument('target');

    $table = new Table($output);
    $table->setHeaders(['Name', 'Type', 'Model', 'Namespace']);

    $relationships = $this->getRelationships($target);
    foreach ($relationships as $relationship) {
      $table->addRow([
        $relationship['type'],
        $relationship['name'],
        Str::of($relationship['model'])->afterLast('\\'),
        Str::of($relationship['model'])->beforeLast('\\'),
      ]);
    }

    $table->render();

    return 0;
  }
}