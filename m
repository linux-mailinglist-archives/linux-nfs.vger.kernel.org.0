Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF6613498
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJaLhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJaLhs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 07:37:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256FE0A7
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 04:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E19D611C0
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 11:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A45C433D7;
        Mon, 31 Oct 2022 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667216265;
        bh=01+9zdy/NptaxWDfpRytXB1U4udNQqVz6kMoM5Tq3R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwf0W8cZihq9uS6LAAE8RD7EF6xdhR1DS0p+j49U5wtuRO+mjM8Vh8r94tzKBSpap
         HVVPYgb1zvAbMX1W0K6j14DrSrFY+8VgTIFqI0YAc6IVQVYiKUSZhTW532GbEMpgdY
         A5fDAlit08SdTrguILHjjST6+gLvNwkAR2s8f6lXPJwoxf+Crxoa6DWoaJGzm8uBMx
         1xC8yYrqzGgR9l2zLfdH8QHKAxtYZ0LzqAbi+WUcSKbWO3BUH+lB7T2Xu8XKVH5lBa
         ly8YVJno9RRfTYAPA1DKeDljpPKf/NdbKRhOi5Nc51xrYedYpWKGZq0YWyqS+IiKLu
         NiLqymVTI5ndw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/5] nfsd: reorganize filecache.c
Date:   Mon, 31 Oct 2022 07:37:39 -0400
Message-Id: <20221031113742.26480-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031113742.26480-1-jlayton@kernel.org>
References: <20221031113742.26480-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In a coming patch, we're going to rework how the filecache refcounting
works. Move some code around in the function to reduce the churn in the
later patches, and rename some of the functions with (hopefully) clearer
names. This should introduce no functional changes.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 134 ++++++++++++++++++++++----------------------
 fs/nfsd/trace.h     |   4 +-
 2 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f8ebbf7daa18..ce80b6a80ffc 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -309,6 +309,48 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
 	return nf;
 }
 
+static void
+nfsd_file_fsync(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return;
+	if (vfs_fsync(file, 1) != 0)
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
+}
+
+static int
+nfsd_file_check_write_error(struct nfsd_file *nf)
+{
+	struct file *file = nf->nf_file;
+
+	if (!file || !(file->f_mode & FMODE_WRITE))
+		return 0;
+	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
+}
+
+static void
+nfsd_file_hash_remove(struct nfsd_file *nf)
+{
+	trace_nfsd_file_unhash(nf);
+
+	if (nfsd_file_check_write_error(nf))
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
+	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
+			       nfsd_file_rhash_params);
+}
+
+static bool
+nfsd_file_unhash(struct nfsd_file *nf)
+{
+	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+		nfsd_file_hash_remove(nf);
+		return true;
+	}
+	return false;
+}
+
 static bool
 nfsd_file_free(struct nfsd_file *nf)
 {
@@ -318,7 +360,7 @@ nfsd_file_free(struct nfsd_file *nf)
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
-	trace_nfsd_file_put_final(nf);
+	trace_nfsd_file_free(nf);
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
@@ -352,27 +394,6 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
 		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 }
 
-static int
-nfsd_file_check_write_error(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return 0;
-	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
-}
-
-static void
-nfsd_file_flush(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return;
-	if (vfs_fsync(file, 1) != 0)
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-}
-
 static void nfsd_file_lru_add(struct nfsd_file *nf)
 {
 	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
@@ -386,31 +407,18 @@ static void nfsd_file_lru_remove(struct nfsd_file *nf)
 		trace_nfsd_file_lru_del(nf);
 }
 
-static void
-nfsd_file_hash_remove(struct nfsd_file *nf)
-{
-	trace_nfsd_file_unhash(nf);
-
-	if (nfsd_file_check_write_error(nf))
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-	rhashtable_remove_fast(&nfsd_file_rhash_tbl, &nf->nf_rhash,
-			       nfsd_file_rhash_params);
-}
-
-static bool
-nfsd_file_unhash(struct nfsd_file *nf)
+struct nfsd_file *
+nfsd_file_get(struct nfsd_file *nf)
 {
-	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_hash_remove(nf);
-		return true;
-	}
-	return false;
+	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
+		return nf;
+	return NULL;
 }
 
 static void
-nfsd_file_unhash_and_dispose(struct nfsd_file *nf, struct list_head *dispose)
+nfsd_file_unhash_and_queue(struct nfsd_file *nf, struct list_head *dispose)
 {
-	trace_nfsd_file_unhash_and_dispose(nf);
+	trace_nfsd_file_unhash_and_queue(nf);
 	if (nfsd_file_unhash(nf)) {
 		/* caller must call nfsd_file_dispose_list() later */
 		nfsd_file_lru_remove(nf);
@@ -448,7 +456,7 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_unhash_and_put(nf);
 
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		nfsd_file_put_noref(nf);
 	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
 		nfsd_file_put_noref(nf);
@@ -457,14 +465,6 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_put_noref(nf);
 }
 
-struct nfsd_file *
-nfsd_file_get(struct nfsd_file *nf)
-{
-	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
-		return nf;
-	return NULL;
-}
-
 static void
 nfsd_file_dispose_list(struct list_head *dispose)
 {
@@ -473,7 +473,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		nfsd_file_put_noref(nf);
 	}
 }
@@ -487,7 +487,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		if (!refcount_dec_and_test(&nf->nf_ref))
 			continue;
 		if (nfsd_file_free(nf))
@@ -687,7 +687,7 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
-		nfsd_file_unhash_and_dispose(nf, dispose);
+		nfsd_file_unhash_and_queue(nf, dispose);
 		count++;
 	} while (1);
 	rcu_read_unlock();
@@ -695,37 +695,37 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 }
 
 /**
- * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
+ * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put, then flush and fput all cache items associated with @inode.
+ * Unhash and put all cache item associated with @inode.
  */
-void
-nfsd_file_close_inode_sync(struct inode *inode)
+static void
+nfsd_file_close_inode(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 	unsigned int count;
 
 	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode_sync(inode, count);
-	nfsd_file_dispose_list_sync(&dispose);
+	trace_nfsd_file_close_inode(inode, count);
+	nfsd_file_dispose_list_delayed(&dispose);
 }
 
 /**
- * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
+ * nfsd_file_close_inode_sync - attempt to forcibly close a nfsd_file
  * @inode: inode of the file to attempt to remove
  *
- * Unhash and put all cache item associated with @inode.
+ * Unhash and put, then flush and fput all cache items associated with @inode.
  */
-static void
-nfsd_file_close_inode(struct inode *inode)
+void
+nfsd_file_close_inode_sync(struct inode *inode)
 {
 	LIST_HEAD(dispose);
 	unsigned int count;
 
 	count = __nfsd_file_close_inode(inode, &dispose);
-	trace_nfsd_file_close_inode(inode, count);
-	nfsd_file_dispose_list_delayed(&dispose);
+	trace_nfsd_file_close_inode_sync(inode, count);
+	nfsd_file_dispose_list_sync(&dispose);
 }
 
 /**
@@ -890,7 +890,7 @@ __nfsd_file_cache_purge(struct net *net)
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (net && nf->nf_net != net)
 				continue;
-			nfsd_file_unhash_and_dispose(nf, &dispose);
+			nfsd_file_unhash_and_queue(nf, &dispose);
 			nf = rhashtable_walk_next(&iter);
 		}
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b09ab4f92d43..940252482fd4 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -903,10 +903,10 @@ DEFINE_EVENT(nfsd_file_class, name, \
 	TP_PROTO(struct nfsd_file *nf), \
 	TP_ARGS(nf))
 
-DEFINE_NFSD_FILE_EVENT(nfsd_file_put_final);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_free);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash);
 DEFINE_NFSD_FILE_EVENT(nfsd_file_put);
-DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_dispose);
+DEFINE_NFSD_FILE_EVENT(nfsd_file_unhash_and_queue);
 
 TRACE_EVENT(nfsd_file_alloc,
 	TP_PROTO(
-- 
2.38.1

