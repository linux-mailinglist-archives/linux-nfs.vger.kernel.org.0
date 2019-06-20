Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0CD4D0E3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfFTOv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:27 -0400
Received: from fieldses.org ([173.255.197.46]:43436 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfFTOvV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 00456206B; Thu, 20 Jun 2019 10:51:20 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 02/16] nfsd: rename cl_refcount
Date:   Thu, 20 Jun 2019 10:51:01 -0400
Message-Id: <1561042275-12723-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Rename this to a more descriptive name: it counts the number of
in-progress rpc's referencing this client.

Next I'm going to add a second refcount with a slightly different use.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 26 +++++++++++++-------------
 fs/nfsd/state.h     |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 618e66078ee5..2a13b6cbb695 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -138,7 +138,7 @@ static __be32 get_client_locked(struct nfs4_client *clp)
 
 	if (is_client_expired(clp))
 		return nfserr_expired;
-	atomic_inc(&clp->cl_refcount);
+	atomic_inc(&clp->cl_rpc_users);
 	return nfs_ok;
 }
 
@@ -170,7 +170,7 @@ static void put_client_renew_locked(struct nfs4_client *clp)
 
 	lockdep_assert_held(&nn->client_lock);
 
-	if (!atomic_dec_and_test(&clp->cl_refcount))
+	if (!atomic_dec_and_test(&clp->cl_rpc_users))
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
@@ -180,7 +180,7 @@ static void put_client_renew(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (!atomic_dec_and_lock(&clp->cl_refcount, &nn->client_lock))
+	if (!atomic_dec_and_lock(&clp->cl_rpc_users, &nn->client_lock))
 		return;
 	if (!is_client_expired(clp))
 		renew_client_locked(clp);
@@ -1857,7 +1857,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	clp->cl_name.len = name.len;
 	INIT_LIST_HEAD(&clp->cl_sessions);
 	idr_init(&clp->cl_stateids);
-	atomic_set(&clp->cl_refcount, 0);
+	atomic_set(&clp->cl_rpc_users, 0);
 	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
 	INIT_LIST_HEAD(&clp->cl_idhash);
 	INIT_LIST_HEAD(&clp->cl_openowners);
@@ -1936,7 +1936,7 @@ unhash_client(struct nfs4_client *clp)
 
 static __be32 mark_client_expired_locked(struct nfs4_client *clp)
 {
-	if (atomic_read(&clp->cl_refcount))
+	if (atomic_read(&clp->cl_rpc_users))
 		return nfserr_jukebox;
 	unhash_client_locked(clp);
 	return nfs_ok;
@@ -4092,7 +4092,7 @@ static __be32 lookup_clientid(clientid_t *clid,
 		spin_unlock(&nn->client_lock);
 		return nfserr_expired;
 	}
-	atomic_inc(&found->cl_refcount);
+	atomic_inc(&found->cl_rpc_users);
 	spin_unlock(&nn->client_lock);
 
 	/* Cache the nfs4_client in cstate! */
@@ -6584,7 +6584,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
 static inline void
 put_client(struct nfs4_client *clp)
 {
-	atomic_dec(&clp->cl_refcount);
+	atomic_dec(&clp->cl_rpc_users);
 }
 
 static struct nfs4_client *
@@ -6702,7 +6702,7 @@ nfsd_inject_add_lock_to_list(struct nfs4_ol_stateid *lst,
 		return;
 
 	lockdep_assert_held(&nn->client_lock);
-	atomic_inc(&clp->cl_refcount);
+	atomic_inc(&clp->cl_rpc_users);
 	list_add(&lst->st_locks, collect);
 }
 
@@ -6731,7 +6731,7 @@ static u64 nfsd_foreach_client_lock(struct nfs4_client *clp, u64 max,
 				 * Despite the fact that these functions deal
 				 * with 64-bit integers for "count", we must
 				 * ensure that it doesn't blow up the
-				 * clp->cl_refcount. Throw a warning if we
+				 * clp->cl_rpc_users. Throw a warning if we
 				 * start to approach INT_MAX here.
 				 */
 				WARN_ON_ONCE(count == (INT_MAX / 2));
@@ -6855,7 +6855,7 @@ nfsd_foreach_client_openowner(struct nfs4_client *clp, u64 max,
 		if (func) {
 			func(oop);
 			if (collect) {
-				atomic_inc(&clp->cl_refcount);
+				atomic_inc(&clp->cl_rpc_users);
 				list_add(&oop->oo_perclient, collect);
 			}
 		}
@@ -6863,7 +6863,7 @@ nfsd_foreach_client_openowner(struct nfs4_client *clp, u64 max,
 		/*
 		 * Despite the fact that these functions deal with
 		 * 64-bit integers for "count", we must ensure that
-		 * it doesn't blow up the clp->cl_refcount. Throw a
+		 * it doesn't blow up the clp->cl_rpc_users. Throw a
 		 * warning if we start to approach INT_MAX here.
 		 */
 		WARN_ON_ONCE(count == (INT_MAX / 2));
@@ -6993,7 +6993,7 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
 			if (dp->dl_time != 0)
 				continue;
 
-			atomic_inc(&clp->cl_refcount);
+			atomic_inc(&clp->cl_rpc_users);
 			WARN_ON(!unhash_delegation_locked(dp));
 			list_add(&dp->dl_recall_lru, victims);
 		}
@@ -7001,7 +7001,7 @@ static u64 nfsd_find_all_delegations(struct nfs4_client *clp, u64 max,
 		/*
 		 * Despite the fact that these functions deal with
 		 * 64-bit integers for "count", we must ensure that
-		 * it doesn't blow up the clp->cl_refcount. Throw a
+		 * it doesn't blow up the clp->cl_rpc_users. Throw a
 		 * warning if we start to approach INT_MAX here.
 		 */
 		WARN_ON_ONCE(count == (INT_MAX / 2));
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0b74d371ed67..f79ad7202e82 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -347,7 +347,7 @@ struct nfs4_client {
 	struct nfsd4_clid_slot	cl_cs_slot;	/* create_session slot */
 	u32			cl_exchange_flags;
 	/* number of rpc's in progress over an associated session: */
-	atomic_t		cl_refcount;
+	atomic_t		cl_rpc_users;
 	struct nfs4_op_map      cl_spo_must_allow;
 
 	/* for nfs41 callbacks */
-- 
2.21.0

