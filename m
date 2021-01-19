Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522DE2FC3A5
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Jan 2021 23:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhASWi3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Jan 2021 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbhASWg6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Jan 2021 17:36:58 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED5C0613ED
        for <linux-nfs@vger.kernel.org>; Tue, 19 Jan 2021 14:35:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 837736F4B; Tue, 19 Jan 2021 17:35:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 837736F4B
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 7/8] nfsd: simplify nfsd4_check_open_reclaim
Date:   Tue, 19 Jan 2021 17:35:28 -0500
Message-Id: <1611095729-31104-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611095729-31104-1-git-send-email-bfields@redhat.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The set_client() was already taken care of by process_open1().

The comments here are mostly redundant with the code.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4proc.c  |  3 +--
 fs/nfsd/nfs4state.c | 18 +++---------------
 fs/nfsd/state.h     |  3 +--
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 4727b7f03c5b..567af1f10d2c 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -423,8 +423,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				goto out;
 			break;
 		case NFS4_OPEN_CLAIM_PREVIOUS:
-			status = nfs4_check_open_reclaim(&open->op_clientid,
-							 cstate, nn);
+			status = nfs4_check_open_reclaim(cstate->clp);
 			if (status)
 				goto out;
 			open->op_openowner->oo_flags |= NFS4_OO_CONFIRMED;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2c580ef6e337..860805ffde1a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7221,25 +7221,13 @@ nfsd4_find_reclaim_client(struct xdr_netobj name, struct nfsd_net *nn)
 	return NULL;
 }
 
-/*
-* Called from OPEN. Look for clientid in reclaim list.
-*/
 __be32
-nfs4_check_open_reclaim(clientid_t *clid,
-		struct nfsd4_compound_state *cstate,
-		struct nfsd_net *nn)
+nfs4_check_open_reclaim(struct nfs4_client *clp)
 {
-	__be32 status;
-
-	/* find clientid in conf_id_hashtbl */
-	status = set_clientid(clid, cstate, nn);
-	if (status)
-		return nfserr_reclaim_bad;
-
-	if (test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags))
+	if (test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &clp->cl_flags))
 		return nfserr_no_grace;
 
-	if (nfsd4_client_record_check(cstate->clp))
+	if (nfsd4_client_record_check(clp))
 		return nfserr_reclaim_bad;
 
 	return nfs_ok;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9eae11a9d21c..73deea353169 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -649,8 +649,7 @@ void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *)
 extern void nfs4_release_reclaim(struct nfsd_net *);
 extern struct nfs4_client_reclaim *nfsd4_find_reclaim_client(struct xdr_netobj name,
 							struct nfsd_net *nn);
-extern __be32 nfs4_check_open_reclaim(clientid_t *clid,
-		struct nfsd4_compound_state *cstate, struct nfsd_net *nn);
+extern __be32 nfs4_check_open_reclaim(struct nfs4_client *);
 extern void nfsd4_probe_callback(struct nfs4_client *clp);
 extern void nfsd4_probe_callback_sync(struct nfs4_client *clp);
 extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *);
-- 
2.29.2

