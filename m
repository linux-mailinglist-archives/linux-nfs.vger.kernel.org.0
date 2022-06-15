Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6F754C146
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jun 2022 07:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345669AbiFOFkW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 01:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFOFkV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 01:40:21 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31ACE4A3C3;
        Tue, 14 Jun 2022 22:40:20 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E30811E80D27;
        Wed, 15 Jun 2022 13:38:51 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J5ZCcSn-ymiE; Wed, 15 Jun 2022 13:38:49 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 6322C1E80CFF;
        Wed, 15 Jun 2022 13:38:48 +0800 (CST)
From:   Yu ZHe <yuzhe@nfschina.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe <yuzhe@nfschina.com>
Subject: [PATCH] nfs: remove unnecessary (void*) conversions.
Date:   Wed, 15 Jun 2022 13:39:24 +0800
Message-Id: <20220615053924.829-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: yuzhe <yuzhe@nfschina.com>

remove unnecessary void* type castings.

Signed-off-by: yuzhe <yuzhe@nfschina.com>
---
 fs/nfs/inode.c      | 6 +++---
 fs/nfs/nfs42xattr.c | 2 +-
 fs/nfs/nfs4idmap.c  | 2 +-
 fs/nfs/nfs4proc.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..a3a88fd09809 100644
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
@@ -2270,7 +2270,7 @@ static inline void nfs4_init_once(struct nfs_inode *nfsi)
 
 static void init_once(void *foo)
 {
-	struct nfs_inode *nfsi = (struct nfs_inode *) foo;
+	struct nfs_inode *nfsi = foo;
 
 	inode_init_once(&nfsi->vfs_inode);
 	INIT_LIST_HEAD(&nfsi->open_files);
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index e7b34f7e0614..f10ea5652037 100644
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
index f331866dd418..01e54dd9301c 100644
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
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c0fdcf8c0032..937e379c9906 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6601,7 +6601,7 @@ static void nfs4_delegreturn_prepare(struct rpc_task *task, void *data)
 	struct nfs4_delegreturndata *d_data;
 	struct pnfs_layout_hdr *lo;
 
-	d_data = (struct nfs4_delegreturndata *)data;
+	d_data = data;
 
 	if (!d_data->lr.roc && nfs4_wait_on_layoutreturn(d_data->inode, task)) {
 		nfs4_sequence_done(task, &d_data->res.seq_res);
@@ -8894,7 +8894,7 @@ int nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cred)
 void nfs4_test_session_trunk(struct rpc_clnt *clnt, struct rpc_xprt *xprt,
 			    void *data)
 {
-	struct nfs4_add_xprt_data *adata = (struct nfs4_add_xprt_data *)data;
+	struct nfs4_add_xprt_data *adata = data;
 	struct rpc_task *task;
 	int status;
 
-- 
2.11.0

