Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6F2FC3A4
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 23:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbhASWhx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 17:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhASWg6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 17:36:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76224C061793
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 14:35:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 825EC6C0D; Tue, 19 Jan 2021 17:35:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 825EC6C0D
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 6/8] nfsd: remove unused set_clientid argument
Date:   Tue, 19 Jan 2021 17:35:27 -0500
Message-Id: <1611095729-31104-7-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611095729-31104-1-git-send-email-bfields@redhat.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Every caller is setting this argument to false, so we don't need it.

Also clarify comments a little.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 01191d2dddc8..2c580ef6e337 100644
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
@@ -4658,13 +4657,10 @@ static __be32 set_client(clientid_t *clid,
 	}
 	if (STALE_CLIENTID(clid, nn))
 		return nfserr_stale_clientid;
-	/*
-	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
-	 * cached already then we know this is for is for v4.0 and "sessions"
-	 * will be false.
-	 */
+	/* For v4.1+ we should have gotten the client in the SEQUENCE op: */
 	WARN_ON_ONCE(cstate->session);
-	cstate->clp = lookup_clientid(clid, sessions, nn);
+	/* So we're looking for a 4.0 client (sessions = false): */
+	cstate->clp = lookup_clientid(clid, false, nn);
 	if (!cstate->clp)
 		return nfserr_expired;
 	return nfs_ok;
@@ -4688,7 +4684,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cstate,
 	if (open->op_file == NULL)
 		return nfserr_jukebox;
 
-	status = set_client(clientid, cstate, nn, false);
+	status = set_client(clientid, cstate, nn);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5298,7 +5294,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
 	trace_nfsd_clid_renew(clid);
-	status = set_client(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn);
 	if (status)
 		return status;
 	clp = cstate->clp;
@@ -5681,7 +5677,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
-	status = set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
+	status = set_client(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
 		if (cstate->session)
 			return nfserr_bad_stateid;
@@ -6905,7 +6901,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	if (!nfsd4_has_session(cstate)) {
-		status = set_client(&lockt->lt_clientid, cstate, nn, false);
+		status = set_client(&lockt->lt_clientid, cstate, nn);
 		if (status)
 			goto out;
 	}
@@ -7089,7 +7085,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
 		clid->cl_boot, clid->cl_id);
 
-	status = set_client(clid, cstate, nn, false);
+	status = set_client(clid, cstate, nn);
 	if (status)
 		return status;
 
@@ -7236,7 +7232,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 	__be32 status;
 
 	/* find clientid in conf_id_hashtbl */
-	status = set_clientid(clid, cstate, nn, false);
+	status = set_clientid(clid, cstate, nn);
 	if (status)
 		return nfserr_reclaim_bad;
 
-- 
2.29.2

