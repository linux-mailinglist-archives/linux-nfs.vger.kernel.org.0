Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77794D0D6
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2019 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFTOvX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jun 2019 10:51:23 -0400
Received: from fieldses.org ([173.255.197.46]:43458 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbfFTOvW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 Jun 2019 10:51:22 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 3DBC76082; Thu, 20 Jun 2019 10:51:21 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 15/16] nfsd: create xdr_netobj_dup helper
Date:   Thu, 20 Jun 2019 10:51:14 -0400
Message-Id: <1561042275-12723-16-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561042275-12723-1-git-send-email-bfields@redhat.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Move some repeated code to a common helper.  No change in behavior.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c        | 11 ++++-------
 include/linux/sunrpc/xdr.h |  7 +++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 12e370e62453..8f35e440ef14 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1857,7 +1857,7 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 	clp = kmem_cache_zalloc(client_slab, GFP_KERNEL);
 	if (clp == NULL)
 		return NULL;
-	clp->cl_name.data = kmemdup(name.data, name.len, GFP_KERNEL);
+	xdr_netobj_dup(&clp->cl_name, &name, GFP_KERNEL);
 	if (clp->cl_name.data == NULL)
 		goto err_no_name;
 	clp->cl_ownerstr_hashtbl = kmalloc_array(OWNER_HASH_SIZE,
@@ -1867,7 +1867,6 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name)
 		goto err_no_hashtbl;
 	for (i = 0; i < OWNER_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&clp->cl_ownerstr_hashtbl[i]);
-	clp->cl_name.len = name.len;
 	INIT_LIST_HEAD(&clp->cl_sessions);
 	idr_init(&clp->cl_stateids);
 	atomic_set(&clp->cl_rpc_users, 0);
@@ -4000,12 +3999,11 @@ static inline void *alloc_stateowner(struct kmem_cache *slab, struct xdr_netobj
 	if (!sop)
 		return NULL;
 
-	sop->so_owner.data = kmemdup(owner->data, owner->len, GFP_KERNEL);
+	xdr_netobj_dup(&sop->so_owner, owner, GFP_KERNEL);
 	if (!sop->so_owner.data) {
 		kmem_cache_free(slab, sop);
 		return NULL;
 	}
-	sop->so_owner.len = owner->len;
 
 	INIT_LIST_HEAD(&sop->so_stateids);
 	sop->so_client = clp;
@@ -6093,12 +6091,11 @@ nfs4_set_lock_denied(struct file_lock *fl, struct nfsd4_lock_denied *deny)
 
 	if (fl->fl_lmops == &nfsd_posix_mng_ops) {
 		lo = (struct nfs4_lockowner *) fl->fl_owner;
-		deny->ld_owner.data = kmemdup(lo->lo_owner.so_owner.data,
-					lo->lo_owner.so_owner.len, GFP_KERNEL);
+		xdr_netobj_dup(&deny->ld_owner, &lo->lo_owner.so_owner,
+						GFP_KERNEL);
 		if (!deny->ld_owner.data)
 			/* We just don't care that much */
 			goto nevermind;
-		deny->ld_owner.len = lo->lo_owner.so_owner.len;
 		deny->ld_clientid = lo->lo_owner.so_client->cl_clientid;
 	} else {
 nevermind:
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 9ee3970ba59c..8a87d8bcb197 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -164,6 +164,13 @@ xdr_decode_opaque_fixed(__be32 *p, void *ptr, unsigned int len)
 	return p + XDR_QUADLEN(len);
 }
 
+static inline void xdr_netobj_dup(struct xdr_netobj *dst,
+				  struct xdr_netobj *src, gfp_t gfp_mask)
+{
+	dst->data = kmemdup(src->data, src->len, gfp_mask);
+	dst->len = src->len;
+}
+
 /*
  * Adjust kvec to reflect end of xdr'ed data (RPC client XDR)
  */
-- 
2.21.0

