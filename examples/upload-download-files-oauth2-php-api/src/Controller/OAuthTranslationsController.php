<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Finder\Finder;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Translation\Reader\TranslationReaderInterface;
use Symfony\Contracts\Translation\TranslatorInterface;

class OAuthTranslationsController extends OAuthAuthenticatedController
{
    #[Route('/oauth/upload', name: 'oauth_upload')]
    public function upload(SessionInterface $session): Response
    {
        if (!$this->checkToken() || !$this->checkProjectId()) {
            return $this->redirect($this->generateUrl('oauth_home'));
        }

        // Get all the message translation files
        $finder = new Finder();
        $files = $finder->files()
            ->in($this->getParameter('kernel.project_dir') . '/translations')
            ->name('messages.*.yaml');

        // If any files were found
        if ($files->hasResults()) {
            foreach ($files as $file) {
                $projectId = $session->get('lokalise.oauth.project_id');

                $contents = $file->getContents();
                $fileName = $file->getFilename();
                $languageIso = explode('.', $fileName)[1];

                $this->client->request('POST', $this->getParameter('lokalise.api.endpoint') . 'projects/' . $projectId . '/files/upload', [
                    'json' => [
                        'data' => base64_encode($contents),
                        'filename' => $fileName,
                        'lang_iso' => $languageIso
                    ]
                ]);
            }
        }

        // Redirect back home.
        return $this->redirect($this->generateUrl('oauth_home'));
    }

    #[Route('/oauth/download', name: 'oauth_download')]
    public function download(SessionInterface $session): Response
    {
        if (!$this->checkToken() || !$this->checkProjectId()) {
            return $this->redirect($this->generateUrl('oauth_home'));
        }

        $projectId = $session->get('lokalise.oauth.project_id');

        $response = $this->client->request('POST', $this->getParameter('lokalise.api.endpoint') . 'projects/' . $projectId . '/files/download', [
            'json' => [
                'format' => 'yaml',
                'yaml_include_root' => false,
                'original_filenames' => true,
                'directory_prefix' => '',
                'indentation' => '4sp',
            ]
        ]);

        $url = $response->toArray()['bundle_url'] ?? null;

        $tempFile = tempnam(sys_get_temp_dir(), 'lokalise');
        copy($url, $tempFile);
        file_put_contents($tempFile, file_get_contents($url));

        $zip = new \ZipArchive();

        if ($zip->open($tempFile)) {
            $zip->extractTo($this->getParameter('kernel.project_dir') . '/translations');
            $zip->close();
        }

        unlink($tempFile);

        return $this->redirect($this->generateUrl('oauth_home'));
    }
}
