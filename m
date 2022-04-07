Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9E4F782C
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 09:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiDGHyY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 03:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbiDGHyX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 03:54:23 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E21C31B84ED;
        Thu,  7 Apr 2022 00:52:23 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 014CC1E80D17;
        Thu,  7 Apr 2022 15:52:06 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WxWf7QKsoZzt; Thu,  7 Apr 2022 15:52:03 +0800 (CST)
Received: from ubuntu.localdomain (unknown [101.228.248.165])
        (Authenticated sender: yuzhe@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 3F7C61E80C8C;
        Thu,  7 Apr 2022 15:52:02 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] NFS: remove unnecessary type castings
Date:   Thu,  7 Apr 2022 00:52:16 -0700
Message-Id: <20220407075216.116940-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

remove unnecessary casts.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 fs/nfs/inode.c      | 6 +++---
 fs/nfs/nfs42xattr.c | 2 +-
 fs/nfs/nfs4idmap.c  | 4 ++--
 fs/nfs/nfs4proc.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 7eb3b08d702f..c1d0f10cbc67 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -318,7 +318,7 @@ struct nfs_find_desc {
 static int
 nfs_find_actor(struct inode *inode, void *opaque)
 {
-	struct nfs_find_desc	*desc = (struct nfs_find_desc *)opaque;
+	struct nfs_find_desc	*desc = opaque;
 	struct nfs_fh		*fh = desc->fh;
 	struct nfs_fattr	*fattr = desc->fattr;
 
@@ -336,7 +336,7 @@ nfs_find_actor(struct inode *inode, void *opaque)
 static int
 nfs_init_locked(struct inode *inode, void *opaque)
 {
-	struct nfs_find_desc	*desc = (struct nfs_find_desc *)opaque;
+	struct nfs_find_desc	*desc = opaque;
 	struct nfs_fattr	*fattr = desc->fattr;
 
 	set_nfs_fileid(inode, fattr->fileid);
@@ -2271,7 +2271,7 @@ static inline void nfs4_init_once(struct nfs_inode *nfsi)
 
 static void init_once(void *foo)
 {
-	struct nfs_inode *nfsi = (struct nfs_inode *) foo;
+	struct nfs_inode *nfsi = foo;
 
 	inode_init_once(&nfsi->vfs_inode);
 	INIT_LIST_HEAD(&nfsi->open_files);
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index ad3405c64b9e..34245aa7e9de 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -981,7 +981,7 @@ nfs4_xattr_entry_count(struct shrinker *shrink, struct shrink_control *sc)
 
 static void nfs4_xattr_cache_init_once(void *p)
 {
-	struct nfs4_xattr_cache *cache = (struct nfs4_xattr_cache *)p;
+	struct nfs4_xattr_cache *cache = p;
 
 	spin_lock_init(&cache->listxattr_lock);
 	atomic_long_set(&cache->nent, 0);
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index f331866dd418..3cba5a225f5f 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -585,7 +585,7 @@ static int nfs_idmap_legacy_upcall(struct key *authkey, void *aux)
 	struct request_key_auth *rka = get_request_key_auth(authkey);
 	struct rpc_pipe_msg *msg;
 	struct idmap_msg *im;
-	struct idmap *idmap = (struct idmap *)aux;
+	struct idmap *idmap = aux;
 	struct key *key = rka->target_key;
 	int ret = -ENOKEY;
 
@@ -668,7 +668,7 @@ idmap_pipe_downcall(struct file *filp, const char __user *src, size_t mlen)
 {
 	struct request_key_auth *rka;
 	struct rpc_inode *rpci = RPC_I(file_inode(filp));
-	struct idmap *idmap = (struct idmap *)rpci->private;
+	struct idmap *idmap = rpci->private;
 	struct key *authkey;
 	struct idmap_msg im;
 	size_t namelen_in;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e3f5b380cefe..4131d27c382d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6564,7 +6564,7 @@ static void nfs4_delegreturn_prepare(struct rpc_task *task, void *data)
 	struct nfs4_delegreturndata *d_data;
 	struct pnfs_layout_hdr *lo;
 
-	d_data = (struct nfs4_delegreturndata *)data;
+	d_data = data;
 
 	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task)) {
 		nfs4_sequence_done(task, &d_data->res.seq_res);
@@ -8808,7 +8808,7 @@ int nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cred)
 void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 			    void *data)
 {
-	struct nfs4_add_xprt_data *adata = (struct nfs4_add_xprt_data *)data;
+	struct nfs4_add_xprt_data *adata = data;
 	struct rpc_task *task;
 	int status;
 
-- 
2.25.1

