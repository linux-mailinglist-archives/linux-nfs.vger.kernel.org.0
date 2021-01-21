Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD42FF4B4
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbhAUThb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbhAUSu7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 13:50:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB42C0617AB
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 10:50:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id D11BA6EB7; Thu, 21 Jan 2021 13:49:58 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D11BA6EB7
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 8/9] nfsd: simplify nfsd4_check_open_reclaim
Date:   Thu, 21 Jan 2021 13:49:54 -0500
Message-Id: <1611254995-23131-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611254995-23131-1-git-send-email-bfields@redhat.com>
References: <6D288689-85E5-4E3E-9117-B71FB45FFABB@oracle.com>
 <1611254995-23131-1-git-send-email-bfields@redhat.com>
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
index 7c95f8808324..860805ffde1a 100644
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
-	status = set_client(clid, cstate, nn, false);
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

