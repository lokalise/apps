<?php

namespace App\Controller;

use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ProcessorController extends AbstractController
{
    #[Route('/preprocess', name: 'app_preprocess')]
    public function preprocess(Request $request, LoggerInterface $logger): Response
    {
        $payload = $request->getContent();

        if (empty($payload)) {
            return new Response(json_encode(['error' => 'Missing body!'], JSON_THROW_ON_ERROR));
        }

        $data = json_decode($payload, true, 512, JSON_THROW_ON_ERROR);
        $data = $this->filterBannedWords($data, ['banned', 'offensive']);

        return new Response(json_encode($data, JSON_THROW_ON_ERROR));
    }

    #[Route('/postprocess', name: 'app_postprocess')]
    public function postprocess(Request $request): Response
    {
        $payload = $request->getContent();

        if (empty($payload)) {
            return new Response(json_encode(['error' => 'Missing body!'], JSON_THROW_ON_ERROR));
        }

        $data = json_decode($payload, true, 512, JSON_THROW_ON_ERROR);
        $data = $this->filterBannedWords($data, ['banned', 'offensive'], $logger);

        return new Response(json_encode($data, JSON_THROW_ON_ERROR));
    }

    /**
     * Filter payload by removing the list of provided words from translations.
     *
     * @param array $translationPayload
     * @param array $bannedWords
     * @return array
     */
    private function filterBannedWords(array $translationPayload, array $bannedWords): array
    {
        foreach ($translationPayload['collection']['keys'] ?? [] as $keyId => $keyValue) {
            foreach ($keyValue['translations'] ?? [] as $language => $translationData) {
                $translationPayload['collection']['keys'][$keyId]['translations'][$language]['translation'] = str_ireplace($bannedWords, '', $translationData['translation']);
            }
        }

        return $translationPayload;
    }
}
