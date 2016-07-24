//
//  NSDGitResponseType.h
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#ifndef NSDGitResponseType_h
#define NSDGitResponseType_h

typedef enum NSDGithubResponseType
{
    NSDGithubNoContentResponse = 0,                  // No content expected
    NSDGithubUsersResponse,                          // One or more users
    NSDGithubUserResponse,							// Exactly one user
    NSDGithubEmailsResponse,                         // One or more email addresses
    NSDGithubRepositoriesResponse,					// One or more repositories
    NSDGithubRepositoryResponse,						// Exactly one repository
    NSDGithubRepositoryTeamsResponse,                // One or more teams
    NSDGithubDeployKeysResponse,                     // One or more deploy keys
    NSDGithubDeployKeyResponse,                      // Exactly one deploy key
    NSDGithubDownloadsResponse,                      // One or more downloads
    NSDGithubDownloadResponse,                       // Exactly one download
    NSDGithubRepositoryLanguageBreakdownResponse,	// Breakdown in language-bytes pairs
    NSDGithubBranchesResponse,						// One or more branches
    NSDGithubCollaboratorsResponse,					// One or more users
    NSDGithubRepositoryHooksResponse,                // One or more repository hooks
    NSDGithubRepositoryHookResponse,                 // Exactly one repository hook
    NSDGithubCommitsResponse,						// One or more commits
    NSDGithubCommitResponse,							// Exactly one commit
    NSDGithubCommitCommentsResponse,                 // One or more commit comments
    NSDGithubCommitCommentResponse,                  // Exactly one commit comment
    NSDGithubIssuesResponse,							// One or more issues
    NSDGithubIssueResponse,							// Exactly one issue
    NSDGithubIssueCommentsResponse,					// One or more issue comments
    NSDGithubIssueCommentResponse,					// Exactly one issue comment
    NSDGithubIssueLabelsResponse,					// One or more issue labels
    NSDGithubIssueLabelResponse,                     // Exactly one issue label
    NSDGithubRepositoryLabelsResponse,				// One or more repository-wide issue labels
    NSDGithubRepositoryLabelResponse,                // Exactly one repository-wide issue label
    NSDGithubBlobsResponse,							// Name and SHA for all files in given tree SHA
    NSDGithubBlobResponse,							// Metadata and file data for given tree SHA and path
    NSDGithubFollowingResponse,                      // Following
    NSDGithubFollowersResponse,                      // Followers
    NSDGithubFollowedResponse,                       // User was followed
    NSDGithubUnfollowedResponse,                     // User was unfollowed
    NSDGithubMilestonesResponse,                     // One or more milestones
    NSDGithubMilestoneResponse,                      // Exactly one milestone
    NSDGithubPublicKeysResponse,                     // One or more public keys
    NSDGithubPublicKeyResponse,                      // Exactly one public key
    NSDGithubSHAResponse,                            // SHA
    NSDGithubTreeResponse,							// Metadata for all files in given commit
    NSDGithubReferencesResponse,                     // One or more references
    NSDGithubReferenceResponse,                      // Exactly one reference
    NSDGithubAnnotatedTagsResponse,                  // One or more annotated tag objects
    NSDGithubAnnotatedTagResponse,                   // Exactly one annotated tag object
    NSDGithubRawCommitResponse,                      // Exactly one raw commit
    NSDGithubGistsResponse,                          // One or more gists
    NSDGithubGistResponse,                           // Exactly one gist
    NSDGithubGistCommentsResponse,                   // One or more gist comments
    NSDGithubGistCommentResponse,                    // Exactly one gist comment
    NSDGithubIssueEventsResponse,                    // One or more issue events
    NSDGithubIssueEventResponse,                     // Exactly one issue event
    NSDGithubPullRequestsResponse,                   // One or more pull requests
    NSDGithubPullRequestResponse,                    // Exactly one pull request
    NSDGithubPullRequestMergeSuccessStatusResponse,  // Success or failure of merge attempt
    NSDGithubPullRequestCommitsResponse,             // One or more pull request commits
    NSDGithubPullRequestFilesResponse,               // One or more pull request files
    NSDGithubPullRequestCommentsResponse,            // One or more pull request comments
    NSDGithubPullRequestCommentResponse,             // Exactly one pull request comment
    NSDGithubTagsResponse,							// Tags in name-SHA pairs
    NSDGithubNotificationsResponse,                  // One or more notifications
    NSDGithubNotificationThreadsResponse,            // One or more notification threads
    NSDGithubNotificationThreadSubscriptionResponse, // Exactly one notification thread subscription
    NSDGithubEventsResponse,                         // One or more events of unspecified type
    NSDGithubOrganizationsResponse,                  // One or more organizations
    NSDGithubOrganizationResponse,                   // Exactly one organization
    NSDGithubTeamsResponse,                          // One or more organization teams
    NSDGithubTeamResponse,                           // Exactly one team
    NSDGithubMarkdownResponse,                       // HTML from Markdown
} NSDGithubResponseType;


#endif /* NSDGitResponseType_h */
