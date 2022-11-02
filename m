Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAF616CE1
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Nov 2022 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiKBSo7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Nov 2022 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiKBSo6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Nov 2022 14:44:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB3A2FC08
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 11:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80BE4CE2070
        for <linux-nfs@vger.kernel.org>; Wed,  2 Nov 2022 18:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F539C433D6;
        Wed,  2 Nov 2022 18:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414693;
        bh=5F+tia+ZoQtUSZP7SXI99PM5T9RRioV7puxjuIAR6XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxWQYEuWZV3FZSkPlXkC6jDrFHkPTB2G4R0DUjdcmOUmO1/qY7jz4wwkQHfvTkmlh
         1Ljpuiqf6J4Rz1EmRKB33Doa+k4hgt317GSk0HYMmHjNYCZUs52cbXy7W7exVXSpzb
         OG/Iki9K3MsWBreWtwZecMMaoHo7Mk6QZglYdiuYpDEejlhlIFc1I9nYTP83GrnAJs
         AvmljoJaHOSDOWn0n7YFPotx2Acy47aRjennzcEzwwHWiprgs+sOk1vE94GmzEnUMf
         9WGycOhysN8vMU5pLgbxZtIvtfbKT2W3ZIlxe5oa5rJBNNVrQM3c2PPNQhbO8VlUV7
         IGN1dWoCYRFgw==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, neilb@suse.de
Subject: [PATCH v6 2/4] nfsd: reorganize filecache.c
Date:   Wed,  2 Nov 2022 14:44:48 -0400
Message-Id: <20221102184450.130397-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184450.130397-1-jlayton@kernel.org>
References: <20221102184450.130397-1-jlayton@kernel.org>
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
names: nfsd_file_flush becomes nfsd_file_fsync, and
nfsd_file_unhash_and_dispose is renamed to nfsd_file_unhash_and_queue.

Also, the nfsd_file_put_final tracepoint is renamed to nfsd_file_free,
to better match the name of the function from which it's called.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 111 ++++++++++++++++++++++----------------------
 fs/nfsd/trace.h     |   4 +-
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 001593ff23ae..c52c273df054 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -335,16 +335,59 @@ nfsd_file_alloc(struct nfsd_file_lookup_key *key, unsigned int may)
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
 	s64 age = ktime_to_ms(ktime_sub(ktime_get(), nf->nf_birthtime));
 	bool flush = false;
 
+	trace_nfsd_file_free(nf);
+
 	this_cpu_inc(nfsd_file_releases);
 	this_cpu_add(nfsd_file_total_age, age);
 
-	trace_nfsd_file_put_final(nf);
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
 	if (nf->nf_file) {
@@ -378,27 +421,6 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
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
@@ -412,31 +434,18 @@ static void nfsd_file_lru_remove(struct nfsd_file *nf)
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
@@ -474,7 +483,7 @@ nfsd_file_put(struct nfsd_file *nf)
 		nfsd_file_unhash_and_put(nf);
 
 	if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		nfsd_file_put_noref(nf);
 	} else if (nf->nf_file && test_bit(NFSD_FILE_GC, &nf->nf_flags)) {
 		nfsd_file_put_noref(nf);
@@ -483,14 +492,6 @@ nfsd_file_put(struct nfsd_file *nf)
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
@@ -499,7 +500,7 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		nfsd_file_put_noref(nf);
 	}
 }
@@ -513,7 +514,7 @@ nfsd_file_dispose_list_sync(struct list_head *dispose)
 	while(!list_empty(dispose)) {
 		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
 		list_del_init(&nf->nf_lru);
-		nfsd_file_flush(nf);
+		nfsd_file_fsync(nf);
 		if (!refcount_dec_and_test(&nf->nf_ref))
 			continue;
 		if (nfsd_file_free(nf))
@@ -713,7 +714,7 @@ __nfsd_file_close_inode(struct inode *inode, struct list_head *dispose)
 				       nfsd_file_rhash_params);
 		if (!nf)
 			break;
-		nfsd_file_unhash_and_dispose(nf, dispose);
+		nfsd_file_unhash_and_queue(nf, dispose);
 		count++;
 	} while (1);
 	rcu_read_unlock();
@@ -915,7 +916,7 @@ __nfsd_file_cache_purge(struct net *net)
 		nf = rhashtable_walk_next(&iter);
 		while (!IS_ERR_OR_NULL(nf)) {
 			if (!net || nf->nf_net == net)
-				nfsd_file_unhash_and_dispose(nf, &dispose);
+				nfsd_file_unhash_and_queue(nf, &dispose);
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

