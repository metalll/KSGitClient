//
//  NSDGitRequestType.h
//  gitClient
//
//  Created by NullStackDev on 23.07.16.
//  Copyright © 2016 nullStackDev. All rights reserved.
//

#ifndef NSDGitRequestType_h
#define NSDGitRequestType_h

//
//  UAGithubEngineRequestTypes.h
//  UAGithubEngine
//
//  Created by Owain Hunt on 05/04/2010.
//  Copyright 2010 Owain R Hunt. All rights reserved.
//



typedef enum NSDGithubRequestType
{
    NSDGithubUsersRequest = 0,						// Get more than one non-specific user
    NSDGithubUserRequest,							// Get exactly one specific user
    NSDGithubUserEditRequest,                        // Edit the authenticated user
    NSDGithubEmailsRequest,                          // Get one or more email addresses
    NSDGithubEmailAddRequest,                        // Add one or more email addresses
    NSDGithubEmailDeleteRequest,                     // Delete one or more email addresses
    NSDAGithubRepositoriesRequest,					// Get more than one non-specific repository
    NSDGithubRepositoryRequest,						// Get exactly one specific repository
    NSDGithubRepositoryUpdateRequest,				// Update repository metadata
    NSDGithubRepositoryWatchingRequest,              // Auth'd user watching a specific repository?
    NSDGithubRepositoryWatchRequest,					// Watch a repository
    NSDGithubRepositoryUnwatchRequest,				// Unwatch a repository
    NSDGithubRepositoryForksRequest,                 // Get one or more forks
    NSDGithubRepositoryForkRequest,					// Fork a repository
    NSDGithubRepositoryCreateRequest,				// Create a repository
    NSDGithubRepositoryPrivatiseRequest,				// Make a repository private
    NSDGithubRepositoryPubliciseRequest,				// Make a repository public
    NSDGithubRepositoryDeleteRequest,				// Delete a repository
    NSDGithubRepositoryDeleteConfirmationRequest,	// Confirm deletion of a repository
    NSDGithubDeployKeysRequest,						// Get repository-specific deploy keys
    NSDGithubDeployKeyRequest,                       // Get exactly one specific deploy key
    NSDGithubDeployKeyAddRequest,					// Add a repository-specific deploy key
    NSDGithubDeployKeyEditRequest,                   // Edit a deploy key
    NSDGithubDeployKeyDeleteRequest,					// Delete a repository-specific deploy key
    NSDGithubRepositoryLanguageBreakdownRequest,		// Get the language breakdown for a repository
    NSDGithubRepositoryContributorsRequest,          // Get one or more contributors
    NSDGithubRepositoryTeamsRequest,                 // Get one or more teams
    NSDGithubTagsRequest,							// Tags for a repository
    NSDGithubBranchesRequest,						// Branches for a repository
    NSDGithubCollaboratorsRequest,					// Collaborators for a repository
    NSDGithubCollaboratorAddRequest,					// Add a collaborator
    NSDGithubCollaboratorRemoveRequest,				// Remove a collaborator
    NSDGithubDownloadsRequest,                       // Get one or more downloads
    NSDGithubDownloadRequest,                        // Get exactly one specific download
    NSDGithubDownloadAddRequest,                     // Add a download
    NSDGithubDownloadDeleteRequest,                  // Delete a download
    NSDGithubRepositoryHooksRequest,                 // Get one or more repository hooks
    NSDGithubRepositoryHookRequest,                  // Get one specific repository hook
    NSDGithubRepositoryHookAddRequest,               // Add a repository hook
    NSDGithubRepositoryHookEditRequest,              // Edit a repository hook
    NSDGithubRepositoryHookTestRequest,              // Test a repository hook
    NSDGithubRepositoryHookDeleteRequest,            // Delete a repository hook
    NSDGithubCommitsRequest,							// Get more than one non-specific commit
    NSDGithubCommitRequest,							// Get exactly one specific commit
    NSDGithubCommitCommentsRequest,                  // Get one or more commit comments
    NSDGithubCommitCommentRequest,                   // Get exactly one commit comment
    NSDGithubCommitCommentAddRequest,                // Add a commit comment
    NSDGithubCommitCommentEditRequest,               // Edit a commit comment
    NSDGithubCommitCommentDeleteRequest,             // Delete a commit comment
    NSDGithubIssuesOpenRequest,						// Get open issues
    NSDGithubIssuesClosedRequest,					// Get closed issues
    NSDGithubIssuesRequest,                          // Get all issues
    NSDGithubIssueRequest,							// Get exactly one specific issue
    NSDGithubIssueAddRequest,						// Add an issue
    NSDGithubIssueEditRequest,						// Edit an issue
    NSDGithubIssueCloseRequest,						// Close an issue
    NSDGithubIssueReopenRequest,						// Reopen a closed issue
    NSDGithubIssueDeleteRequest,                     // Delete an issue
    NSDGithubRepositoryLabelsRequest,				// Get repository-wide issue labels
    NSDGithubRepositoryLabelAddRequest,				// Add a repository-wide issue label
    NSDGithubRepositoryLabelEditRequest,             // Edit a repository-wide issue label
    NSDGithubRepositoryLabelRemoveRequest,			// Remove a repository-wide issue label
    NSDGithubIssueLabelsRequest,                     // Get one or more issue labels
    NSDGithubIssueLabelRequest,                      // Get exactly one specific issue label
    NSDGithubIssueLabelAddRequest,					// Add a label to a specific issue
    NSDGithubIssueLabelRemoveRequest,				// Remove a label from a specific issue
    NSDGithubIssueLabelReplaceRequest,               // Replace all labels on a specific issue
    NSDGithubIssueCommentsRequest,					// Get more than one non-specific issue comment
    NSDGithubIssueCommentRequest,					// Get exactly one specific issue comment
    NSDGithubIssueCommentAddRequest,					// Add a comment to an issue
    NSDGithubIssueCommentEditRequest,                // Edit an issue comment
    NSDGithubIssueCommentDeleteRequest,              // Delete an issue comment
    NSDGithubFollowingRequest,                       // Following
    NSDGithubFollowersRequest,                       // Followers
    NSDGithubFollowRequest,                          // Follow a User
    NSDGithubUnfollowRequest,                        // Unfollow a user
    NSDGithubMilestonesRequest,                      // Get one or more milestones
    NSDGithubMilestoneRequest,                       // Get exactly one specific milestone
    NSDGithubMilestoneCreateRequest,                 // Create a new milestone
    NSDGithubMilestoneUpdateRequest,                 // Edit an existing milestone
    NSDGithubMilestoneDeleteRequest,                 // Delete a milestone
    NSDGithubPublicKeysRequest,                      // Get one or more public keys
    NSDGithubPublicKeyRequest,                       // Get exactly one public key
    NSDGithubPublicKeyAddRequest,                    // Add a public key
    NSDGithubPublicKeyEditRequest,                   // Edit a public key
    NSDGithubPublicKeyDeleteRequest,                 // Delete a public key
    NSDGithubTreeRequest,							// Get the listing of a tree by SHA
    NSDGithubTreeCreateRequest,                      // Create a new tree
    NSDGithubBlobsRequest,							// Get the names and SHAs of all blobs for a specific tree SHA
    NSDGithubBlobRequest,							// Get data about a single blob by tree SHA and path
    NSDGithubBlobCreateRequest,                      // Create a new blob
    NSDGithubRawBlobRequest,							// Get the raw data for a blob
    NSDGithubReferencesRequest,                      // Get one or more references
    NSDGithubReferenceRequest,                       // Get exactly one reference
    NSDGithubReferenceCreateRequest,                 // Create a new reference
    NSDGithubReferenceUpdateRequest,                 // Edit an existing reference
    NSDGithubTagObjectRequest,                       // Get exactly one annotated tag object
    NSDGithubTagObjectCreateRequest,                 // Create a new annotated tag object
    NSDGithubRawCommitRequest,                       // Get exactly one raw commit
    NSDGithubRawCommitCreateRequest,                 // Create a new raw commit
    NSDGithubGistsRequest,                           // Get one or more gists
    NSDGithubGistRequest,                            // Get exactly one gist
    NSDGithubGistCreateRequest,                      // Create a new gist
    NSDGithubGistUpdateRequest,                      // Edit a gist
    NSDGithubGistStarRequest,                        // Star a gist
    NSDGithubGistUnstarRequest,                      // Unstar a gist
    NSDGithubGistStarStatusRequest,                  // Get star status of a gist
    NSDGithubGistForkRequest,                        // Fork a gist
    NSDGithubGistDeleteRequest,                      // Delete a gist
    NSDGithubGistCommentsRequest,                    // Get one or more gist comments
    NSDGithubGistCommentRequest,                     // Get exactly one gist comment
    NSDGithubGistCommentCreateRequest,               // Create a new gist comment
    NSDGithubGistCommentUpdateRequest,               // Edit a gist comment
    NSDGithubGistCommentDeleteRequest,               // Delete a gist comment
    NSDGithubNotificationsRequest,                   // List all notifications for the current user, grouped by repository
    NSDGithubNotificationsMarkReadRequest,           // Mark a notification as read
    NSDGithubNotificationsMarkThreadReadRequest,     // Mark a notification thread as read
    NSDGithubNotificationThreadSubscriptionRequest,  // Subscribe or unsubscribe from a notification thread
    NSDGithubNotificationDeleteSubscriptionRequest,  // Delete a notification thread subscription
    NSDGithubIssueEventsRequest,                     // Get one or more issue events
    NSDGithubIssueEventRequest,                           // Get exactly one issue event
    NSDGithubPullRequestsRequest,                    // Get one or more pull requests
    NSDGithubPullRequestRequest,                     // Get exactly one pull request
    NSDGithubPullRequestCreateRequest,               // Create a pull request
    NSDGithubPullRequestUpdateRequest,               // Edit a pull request
    NSDGithubPullRequestCommitsRequest,              // Get commits in a pull request
    NSDGithubPullRequestFilesRequest,                // Get files in a pull request
    NSDGithubPullRequestMergeStatusRequest,          // Get the merge status of a pull request
    NSDGithubPullRequestMergeRequest,                // Merge a pull request
    NSDGithubPullRequestCommentsRequest,             // Get one or more pull request comments
    NSDGithubPullRequestCommentRequest,              // Get exactly one pull request comments
    NSDGithubPullRequestCommentCreateRequest,        // Create a pull request comment
    NSDGithubPullRequestCommentUpdateRequest,        // Update a pull request comment
    NSDGithubPullRequestCommentDeleteRequest,        // Delete a pull request comment
    NSDGithubEventsRequest,                          // Get one or more events of unspecified type
    NSDGithubOrganizationsRequest,                   // Get one or more organizations
    NSDGithubOrganizationRequest,                    // Get exactly one organization
    NSDGithubOrganizationUpdateRequest,              // Update an existing organization
    NSDGithubOrganizationMembersRequest,             // Get one or more organization members
    NSDGithubOrganizationMembershipStatusRequest,    // Get whether user is member of a specified organization
    NSDGithubOrganizationMemberRemoveRequest,        // Remove a user from am organization
    NSDGithubOrganizationMembershipPublicizeRequest, // Publicize user's membership of organization
    NSDGithubOrganizationMembershipConcealRequest,   // Concel user's membership of organization
    NSDGithubTeamsRequest,                           // Get one or more organization teams
    NSDGithubTeamRequest,                            // Get exactly one organization team
    NSDGithubTeamCreateRequest,                      // Create a new team
    NSDGithubTeamUpdateRequest,                      // Update an existing team
    NSDGithubTeamDeleteRequest,                      // Delete an existing team
    NSDGithubTeamMembersRequest,                     // Get one or more team members
    NSDGithubTeamMembershipStatusRequest,
    NSDGithubTeamMemberAddRequest,
    NSDGithubTeamMemberRemoveRequest,                // Remove a user from a team
    NSDGithubTeamRepositoryManagershipStatusRequest, // Get whether a team manages a specific repository
    NSDGithubTeamRepositoryManagershipAddRequest,    // Add a specific repository to a team
    NSDGithubTeamRepositoryManagershipRemoveRequest, // Remove a specific repository from a team
    NSDGithubAssigneesRequest,                       // Get one or more assignees
    NSDGithubAssigneeRequest,                        // Get whether one user is an assignee on a repository
    NSDGithubMarkdownRequest,                        // Get a string as Markdown
    NSDGithubRepositoryMergeRequest,                 // Merge one branch into another
} NSDGithubRequestType;



#endif /* NSDGitRequestType_h */
