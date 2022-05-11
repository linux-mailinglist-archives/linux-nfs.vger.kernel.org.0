Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D84523FBE
	for <lists+linux-nfs@lfdr.de>; Wed, 11 May 2022 23:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbiEKVw5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 May 2022 17:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiEKVwz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 May 2022 17:52:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD83102774
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 14:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD9161B9D
        for <linux-nfs@vger.kernel.org>; Wed, 11 May 2022 21:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28E5C34114;
        Wed, 11 May 2022 21:52:52 +0000 (UTC)
Subject: [PATCH RFC 1/2] NFSD: nfsd4_release_lockowner() should drop
 clp->cl_lock sooner
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com, bfields@fieldses.org, jlayton@redhat.com,
        dai.ngo@oracle.com
Date:   Wed, 11 May 2022 17:52:51 -0400
Message-ID: <165230597191.5906.5961060184718742042.stgit@klimt.1015granger.net>
In-Reply-To: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
References: <165230584037.5906.5496655737644872339.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev1+g8516920
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd4_release_lockowner() mustn't hold clp->cl_lock when
check_for_locks() invokes nfsd_file_put(), which can sleep.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org>
---
 fs/nfsd/nfs4state.c |   56 +++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 234e852fcdfa..e2eb6d031643 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6611,8 +6611,8 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 		deny->ld_type = NFS4_WRITE_LT;
 }
 
-static struct nfs4_lockowner *
-find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
+static struct nfs4_stateowner *
+find_stateowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
 {
 	unsigned int strhashval = ownerstr_hashval(owner);
 	struct nfs4_stateowner *so;
@@ -6624,11 +6624,22 @@ find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
 		if (so->so_is_open_owner)
 			continue;
 		if (same_owner_str(so, owner))
-			return lockowner(nfs4_get_stateowner(so));
+			return nfs4_get_stateowner(so);
 	}
 	return NULL;
 }
 
+static struct nfs4_lockowner *
+find_lockowner_str_locked(struct nfs4_client *clp, struct xdr_netobj *owner)
+{
+	struct nfs4_stateowner *so;
+
+	so = find_stateowner_str_locked(clp, owner);
+	if (!so)
+		return NULL;
+	return lockowner(so);
+}
+
 static struct nfs4_lockowner *
 find_lockowner_str(struct nfs4_client *clp, struct xdr_netobj *owner)
 {
@@ -7305,10 +7316,8 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	struct nfsd4_release_lockowner *rlockowner = &u->release_lockowner;
 	clientid_t *clid = &rlockowner->rl_clientid;
 	struct nfs4_stateowner *sop;
-	struct nfs4_lockowner *lo = NULL;
+	struct nfs4_lockowner *lo;
 	struct nfs4_ol_stateid *stp;
-	struct xdr_netobj *owner = &rlockowner->rl_owner;
-	unsigned int hashval = ownerstr_hashval(owner);
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfs4_client *clp;
@@ -7322,32 +7331,18 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 		return status;
 
 	clp = cstate->clp;
-	/* Find the matching lock stateowner */
 	spin_lock(&clp->cl_lock);
-	list_for_each_entry(sop, &clp->cl_ownerstr_hashtbl[hashval],
-			    so_strhash) {
-
-		if (sop->so_is_open_owner || !same_owner_str(sop, owner))
-			continue;
-
-		/* see if there are still any locks associated with it */
-		lo = lockowner(sop);
-		list_for_each_entry(stp, &sop->so_stateids, st_perstateowner) {
-			if (check_for_locks(stp->st_stid.sc_file, lo)) {
-				status = nfserr_locks_held;
-				spin_unlock(&clp->cl_lock);
-				return status;
-			}
-		}
+	sop = find_stateowner_str_locked(clp, &rlockowner->rl_owner);
+	spin_unlock(&clp->cl_lock);
+	if (!sop)
+		return nfs_ok;
 
-		nfs4_get_stateowner(sop);
-		break;
-	}
-	if (!lo) {
-		spin_unlock(&clp->cl_lock);
-		return status;
-	}
+	lo = lockowner(sop);
+	list_for_each_entry(stp, &sop->so_stateids, st_perstateowner)
+		if (check_for_locks(stp->st_stid.sc_file, lo))
+			return nfserr_locks_held;
 
+	spin_lock(&clp->cl_lock);
 	unhash_lockowner_locked(lo);
 	while (!list_empty(&lo->lo_owner.so_stateids)) {
 		stp = list_first_entry(&lo->lo_owner.so_stateids,
@@ -7360,8 +7355,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
 	free_ol_stateid_reaplist(&reaplist);
 	remove_blocked_locks(lo);
 	nfs4_put_stateowner(&lo->lo_owner);
-
-	return status;
+	return nfs_ok;
 }
 
 static inline struct nfs4_client_reclaim *


