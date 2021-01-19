Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EA72FC3EE
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbhASWkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 17:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbhASWgx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 17:36:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E4CC0613D3
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 14:35:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 5DE3C42A8; Tue, 19 Jan 2021 17:35:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 5DE3C42A8
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/8] nfsd: refactor lookup_clientid
Date:   Tue, 19 Jan 2021 17:35:25 -0500
Message-Id: <1611095729-31104-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611095729-31104-1-git-send-email-bfields@redhat.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

I think set_client is a better name, and the lookup itself I want to
use somewhere else.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ba955bbf21df..d7128e16c86e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4633,40 +4633,40 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 	return nfserr_bad_seqid;
 }
 
-static __be32 lookup_clientid(clientid_t *clid,
+static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
+						struct nfsd_net *nn)
+{
+	struct nfs4_client *found;
+
+	spin_lock(&nn->client_lock);
+	found = find_confirmed_client(clid, sessions, nn);
+	if (found)
+		atomic_inc(&found->cl_rpc_users);
+	spin_unlock(&nn->client_lock);
+	return found;
+}
+
+static __be32 set_client(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
 		struct nfsd_net *nn,
 		bool sessions)
 {
-	struct nfs4_client *found;
-
 	if (cstate->clp) {
-		found = cstate->clp;
-		if (!same_clid(&found->cl_clientid, clid))
+		if (!same_clid(&cstate->clp->cl_clientid, clid))
 			return nfserr_stale_clientid;
 		return nfs_ok;
 	}
-
 	if (STALE_CLIENTID(clid, nn))
 		return nfserr_stale_clientid;
-
 	/*
 	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
 	 * cached already then we know this is for is for v4.0 and "sessions"
 	 * will be false.
 	 */
 	WARN_ON_ONCE(cstate->session);
-	spin_lock(&nn->client_lock);
-	found = find_confirmed_client(clid, sessions, nn);
-	if (!found) {
-		spin_unlock(&nn->client_lock);
+	cstate->clp = lookup_clientid(clid, sessions, nn);
+	if (!cstate->clp)
 		return nfserr_expired;
-	}
-	atomic_inc(&found->cl_rpc_users);
-	spin_unlock(&nn->client_lock);
-
-	/* Cache the nfs4_client in cstate! */
-	cstate->clp = found;
 	return nfs_ok;
 }
 
@@ -4688,7 +4688,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = lookup_clientid(clientid, cstate, nn, false);
+	status = set_client(clientid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5298,7 +5298,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	trace_nfsd_clid_renew(clid);
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn, false);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5681,8 +5681,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
-				 false);
+	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -5821,7 +5820,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 
 	cps->cpntf_time = ktime_get_boottime_seconds();
 	memset(&cstate, 0, sizeof(cstate));
-	status = lookup_clientid(&cps->cp_p_clid, &cstate, nn, true);
+	status = set_clientid(&cps->cp_p_clid, &cstate, nn, true);
 	if (status)
 		goto out;
 	status = nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
@@ -6900,8 +6899,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = lookup_clientid(&lockt->lt_clientid, cstate, nn,
-					 false);
+		status = set_client(&lockt->lt_clientid, cstate, nn, false);
 		if (status)
 			goto out;
 	}
@@ -7085,7 +7083,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn, false);
 	if (status)
 		return status;
 
@@ -7232,7 +7230,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = lookup_clientid(clid, cstate, nn, false);
+	status = set_clientid(clid, cstate, nn, false);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
2.29.2

