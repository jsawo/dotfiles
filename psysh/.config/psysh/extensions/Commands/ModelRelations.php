<?php

namespace X\Commands;

use Illuminate\Database\Eloquent\Relations\Relation;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use X\Tinker;
use ReflectionClass;
use ReflectionMethod;

class ModelRelations extends Command
{
    protected function configure(): void
    {
        $this->setName('model-relations')
            ->setAliases(['mr'])
            ->setDescription('show all relations of a given Model class')
            ->setDefinition([
                new CodeArgument('target', CodeArgument::REQUIRED, 'model to analyze'),
            ]);
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $target = $input->getArgument('target');

        // Find the best candidate - make sure we're working with a Model and not e.g. a Resource
        $actualTarget = collect(Tinker::getSubclasses(Model::class))
            ->first(function ($class) use ($target) {
                return Str::of($class)->endsWith($target);
            });
        if (is_null($actualTarget)) throw new \Exception("Model \"$target\" was not found");

        $output->writeln("<info>Model:</info> $actualTarget");

        $table = new Table($output);
        $table->setHeaders(['Name', 'Type']);

        $relationships = $this->getRelationships($actualTarget);
        foreach ($relationships as $relationship) {
            $table->addRow([
                $relationship['name'],
                $relationship['type'],
            ]);
        }

        $table->render();

        return 0;
    }

    private function getRelationships(string $target): array
    {
        $rc = new ReflectionClass($target);

        $relationships = [];

        foreach ($rc->getMethods(ReflectionMethod::IS_PUBLIC) as $method) {
            if ($method->class != $rc->getName()) {
                continue;
            }
            if (!empty($method->getParameters())) {
                continue;
            }

            $return = $method->getReturnType();

            if (is_null($return)) continue;

            try {
                $return = (new ReflectionClass($return->getName()));
            } catch (\ReflectionException $e) {
                continue;
            }

            if (!$return->isSubclassOf(Relation::class)) continue;

            $relationships[$method->getName()] = [
                'name' => $method->getName(),
                'type' => $return->getShortName(),
            ];
        }

        return $relationships;
    }
}
