Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC62FF854
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbhAUW7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 17:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAUW7a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 17:59:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E313C061352
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 14:57:48 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id E57F96F60; Thu, 21 Jan 2021 17:57:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E57F96F60
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v3 7/9] nfsd: remove unused set_client argument
Date:   Thu, 21 Jan 2021 17:57:43 -0500
Message-Id: <1611269865-30153-7-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611269865-30153-1-git-send-email-bfields@redhat.com>
References: <20210121204251.GB13298@pick.fieldses.org>
 <1611269865-30153-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Every caller is setting this argument to false, so we don't need it.

Also cut this comment a bit and remove an unnecessary warning.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index db10fef1c1d2..6d4b77b536fb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4648,8 +4648,7 @@ static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessions,
 
 static __be32 set_client(clientid_t *clid,
 		struct nfsd4_compound_state *cstate,
-		struct nfsd_net *nn,
-		bool sessions)
+		struct nfsd_net *nn)
 {
 	if (cstate->clp) {
 		if (!same_clid(&cstate->clp->cl_clientid, clid))
@@ -4659,12 +4658,10 @@ static __be32 set_client(clientid_t *clid,
 	if (STALE_CLIENTID(clid, nn))
 		return nfserr_stale_clientid;
 	/*
-	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
-	 * cached already then we know this is for is for v4.0 and "sessions"
-	 * will be false.
+	 * We're in the 4.0 case (otherwise the SEQUENCE op would have
+	 * set cstate->clp), so session = false:
 	 */
-	WARN_ON_ONCE(cstate->session);
-	cstate->clp = lookup_clientid(clid, sessions, nn);
+	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
 	return nfs_ok;
@@ -4688,7 +4685,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = set_client(clientid, cstate, nn, false);
+	status = set_client(clientid, cstate, nn);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5298,7 +5295,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	trace_nfsd_clid_renew(clid);
-	status = set_client(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5681,7 +5678,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
+	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -6905,7 +6902,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = set_client(&lockt->lt_clientid, cstate, nn, false);
+		status = set_client(&lockt->lt_clientid, cstate, nn);
 		if (status)
 			goto out;
 	}
@@ -7089,7 +7086,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = set_client(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn);
 	if (status)
 		return status;
 
@@ -7236,7 +7233,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = set_client(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
2.29.2

