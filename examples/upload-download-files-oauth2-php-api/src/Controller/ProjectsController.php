<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

class ProjectsController extends OAuthAuthenticatedController
{
    #[Route('/projects', name: 'list_projects')]
    public function index(): Response
    {
        if (!$this->checkToken()) {
            return $this->redirect($this->generateUrl('oauth_home'));
        }

        $projects = $this->client->request('GET', $this->getParameter('lokalise.api.endpoint') . 'projects', [
                'query' => [
                    'limit' => 50
                ]
            ])?->toArray() ?? [];

        $projects = array_map(fn($data) => ['id' => $data['project_id'], 'name' => $data['name']], $projects['projects']);

        return $this->render('projects/index.html.twig', [
            'projects' => $projects,
        ]);
    }

    #[Route('/select_project/{projectId}', name: 'oauth_select_project')]
    public function select(SessionInterface $session, string $projectId): Response
    {
        if ($this->checkToken()) {
            $session->set('lokalise.oauth.project_id', $projectId);
        }

        return $this->redirect($this->generateUrl('oauth_home'));
    }
}
