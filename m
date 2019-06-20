Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EBA4D0D4
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFTOvV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: from fieldses.org ([173.255.197.46]:43438 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfFTOvV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:21 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 07A2324D0; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 03/16] nfsd4: use reference count to free client
Date:   Thu, 20 Jun 2019 10:51:02 -0400
Message-Id: <1561042275-12723-4-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Keep a second reference count which is what is really used to decide
when to free the client's memory.

Next I'm going to add an nfsd/clients/ directory with a subdirectory for
each NFSv4 client.  File objects under nfsd/clients/ will hold these
references.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c | 26 +++++++++++++++++++++-----
 fs/nfsd/state.h     |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2a13b6cbb695..d2ea41add566 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1879,6 +1879,24 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	return NULL;
 }
 
+static void __free_client(struct kref *k)
+{
+	struct nfs4_client *clp = container_of(k, struct nfs4_client, cl_ref);
+
+	free_svc_cred(&clp->cl_cred);
+	kfree(clp->cl_ownerstr_hashtbl);
+	kfree(clp->cl_name.data);
+	idr_destroy(&clp->cl_stateids);
+	if (clp->cl_nfsd_dentry)
+		nfsd_client_rmdir(clp->cl_nfsd_dentry);
+	kmem_cache_free(client_slab, clp);
+}
+
+void drop_client(struct nfs4_client *clp)
+{
+	kref_put(&clp->cl_ref, __free_client);
+}
+
 static void
 free_client(struct nfs4_client *clp)
 {
@@ -1891,11 +1909,7 @@ free_client(struct nfs4_client *clp)
 		free_session(ses);
 	}
 	rpc_destroy_wait_queue(&clp->cl_cb_waitq);
-	free_svc_cred(&clp->cl_cred);
-	kfree(clp->cl_ownerstr_hashtbl);
-	kfree(clp->cl_name.data);
-	idr_destroy(&clp->cl_stateids);
-	kmem_cache_free(client_slab, clp);
+	drop_client(clp);
 }
 
 /* must be called under the client_lock */
@@ -2216,6 +2230,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 		free_client(clp);
 		return NULL;
 	}
+
+	kref_init(&clp->cl_ref);
 	nfsd4_init_cb(&clp->cl_cb_null, clp, NULL, NFSPROC4_CLNT_CB_NULL);
 	clp->cl_time = get_seconds();
 	clear_bit(0, &clp->cl_cb_slot_busy);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f79ad7202e82..8eacdbc50cd7 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -348,6 +348,7 @@ struct nfs4_client {
 	u32			cl_exchange_flags;
 	/* number of rpc's in progress over an associated session: */
 	atomic_t		cl_rpc_users;
+	struct kref		cl_ref;
 	struct nfs4_op_map      cl_spo_must_allow;
 
 	/* for nfs41 callbacks */
-- 
2.21.0

