Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0148D2FF39B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 19:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbhAUSwR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 13:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhAUSux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:50:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32D8C06178C
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:49:59 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 898646EA0; Thu, 21 Jan 2021 13:49:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 898646EA0
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 5/9] nfsd: refactor lookup_clientid
Date:   Thu, 21 Jan 2021 13:49:51 -0500
Message-Id: <1611254995-23131-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611254995-23131-1-git-send-email-bfields@redhat.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This'll be useful elsewhere.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 4bdd90074e24..c74bf3b5b0de 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4633,40 +4633,40 @@ static __be32 nfsd4_check_seqid(struct nfsd4_compound_state *cstate, struct nfs4
 	return nfserr_bad_seqid;
 }
 
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
 static __be32 set_client(clientid_t *clid,
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
 
-- 
2.29.2

