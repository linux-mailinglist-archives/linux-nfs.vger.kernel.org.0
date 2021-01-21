Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FBF2FF851
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbhAUW72 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 17:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbhAUW7G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 17:59:06 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9268CC061354
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 14:57:48 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E47211297; Thu, 21 Jan 2021 17:57:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E47211297
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v3 9/9] nfsd: cstate->session->se_client -> cstate->clp
Date:   Thu, 21 Jan 2021 17:57:45 -0500
Message-Id: <1611269865-30153-9-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611269865-30153-1-git-send-email-bfields@redhat.com>
References: <20210121204251.GB13298@pick.fieldses.org>
 <1611269865-30153-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I'm not sure why we're writing this out the hard way in so many places.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4proc.c  |  5 ++---
 fs/nfsd/nfs4state.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 567af1f10d2c..f63a12a5278a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -373,8 +373,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	 * Before RECLAIM_COMPLETE done, server should deny new lock
 	 */
 	if (nfsd4_has_session(cstate) &&
-	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE,
-		      &cstate->session->se_client->cl_flags) &&
+	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags) &&
 	    open->op_claim_type != NFS4_OPEN_CLAIM_PREVIOUS)
 		return nfserr_grace;
 
@@ -1882,7 +1881,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
 	nfserr = nfs_ok;
 	if (gdp->gd_maxcount != 0) {
 		nfserr = ops->proc_getdeviceinfo(exp->ex_path.mnt->mnt_sb,
-				rqstp, cstate->session->se_client, gdp);
+				rqstp, cstate->clp, gdp);
 	}
 
 	gdp->gd_notify_types &= ops->notify_types;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 389456937bbe..f554e3480bb1 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3891,6 +3891,7 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
 {
 	struct nfsd4_reclaim_complete *rc = &u->reclaim_complete;
+	struct nfs4_client *clp = cstate->clp;
 	__be32 status = 0;
 
 	if (rc->rca_one_fs) {
@@ -3904,12 +3905,11 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 	}
 
 	status = nfserr_complete_already;
-	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE,
-			     &cstate->session->se_client->cl_flags))
+	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &clp->cl_flags))
 		goto out;
 
 	status = nfserr_stale_clientid;
-	if (is_client_expired(cstate->session->se_client))
+	if (is_client_expired(clp))
 		/*
 		 * The following error isn't really legal.
 		 * But we only get here if the client just explicitly
@@ -3920,8 +3920,8 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
 		goto out;
 
 	status = nfs_ok;
-	nfsd4_client_record_create(cstate->session->se_client);
-	inc_reclaim_complete(cstate->session->se_client);
+	nfsd4_client_record_create(clp);
+	inc_reclaim_complete(clp);
 out:
 	return status;
 }
@@ -5918,7 +5918,7 @@ nfsd4_test_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 {
 	struct nfsd4_test_stateid *test_stateid = &u->test_stateid;
 	struct nfsd4_test_stateid_id *stateid;
-	struct nfs4_client *cl = cstate->session->se_client;
+	struct nfs4_client *cl = cstate->clp;
 
 	list_for_each_entry(stateid, &test_stateid->ts_stateid_list, ts_id_list)
 		stateid->ts_id_status =
@@ -5964,7 +5964,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	stateid_t *stateid = &free_stateid->fr_stateid;
 	struct nfs4_stid *s;
 	struct nfs4_delegation *dp;
-	struct nfs4_client *cl = cstate->session->se_client;
+	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
 	spin_lock(&cl->cl_lock);
@@ -6693,7 +6693,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (nfsd4_has_session(cstate))
 			/* See rfc 5661 18.10.3: given clientid is ignored: */
 			memcpy(&lock->lk_new_clientid,
-				&cstate->session->se_client->cl_clientid,
+				&cstate->clp->cl_clientid,
 				sizeof(clientid_t));
 
 		/* validate and update open stateid and open seqid */
-- 
2.29.2

