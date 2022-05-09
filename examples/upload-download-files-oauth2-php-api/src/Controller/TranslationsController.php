<?php

namespace App\Controller;

use Lokalise\LokaliseApiClient;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Finder\Finder;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Translation\Reader\TranslationReaderInterface;
use Symfony\Contracts\Translation\TranslatorInterface;

class TranslationsController extends AbstractController
{
    #[Route('/translations/upload', name: 'translations_upload', methods: ['POST'])]
    public function upload(): Response
    {
        // Get all the message translation files
        $finder = new Finder();
        $files = $finder->files()
            ->in($this->getParameter('kernel.project_dir') . '/translations')
            ->name('messages.*.yaml');

        // If any files were found
        if ($files->hasResults()) {
            $client = new \Lokalise\LokaliseApiClient($this->getParameter('lokalise.api_token'));

            foreach ($files as $file) {
                $contents = $file->getContents();
                $fileName = $file->getFilename();
                $languageIso = explode('.', $fileName)[1];

                // Upload the file
                $client->files->upload($this->getParameter('lokalise.project_id'), [
                    'data' => base64_encode($contents),
                    'filename' => $fileName,
                    'lang_iso' => $languageIso
                ]);
            }
        }

        // Redirect back home.
        return $this->redirect($this->generateUrl('app_home'));
    }

    #[Route('/translations/download', name: 'translations_download', methods: ['POST'])]
    public function download(): Response
    {
        $client = new \Lokalise\LokaliseApiClient($this->getParameter('lokalise.api_token'));
        $response = $client->files->download($this->getParameter('lokalise.project_id'), [
            'format' => 'yaml',
            'yaml_include_root' => false,
            'original_filenames' => true,
            'directory_prefix' => '',
            'indentation' => '4sp',
        ]);

        $url = $response->getContent()['bundle_url'] ?? null;

        $tempFile = tempnam(sys_get_temp_dir(), 'lokalise');
        copy($url, $tempFile);
        file_put_contents($tempFile, file_get_contents($url));

        $zip = new \ZipArchive();

        if ($zip->open($tempFile)) {
            $zip->extractTo($this->getParameter('kernel.project_dir') . '/translations');
            $zip->close();
        }

        unlink($tempFile);

        return $this->redirect($this->generateUrl('app_home'));
    }
}
