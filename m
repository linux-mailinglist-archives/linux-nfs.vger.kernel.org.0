Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47A5F1D46
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Oct 2022 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJAPsQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Oct 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJAPsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Oct 2022 11:48:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C18F56BB0
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 08:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5BC4AB80113
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 15:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E971CC433C1
        for <linux-nfs@vger.kernel.org>; Sat,  1 Oct 2022 15:48:09 +0000 (UTC)
Subject: [PATCH RFC] NFSD: Hold rcu_read_lock while getting refs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sat, 01 Oct 2022 11:48:08 -0400
Message-ID: <166463917715.10124.3789034969503323129.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd_file is RCU-freed, so it's possible that one could be found
that's in the process of being freed and the memory recycled. Ensure
we hold the rcu_read_lock while attempting to get a reference on the
object.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   34 +++++++++++-----------------------
 fs/nfsd/trace.h     |   27 ---------------------------
 2 files changed, 11 insertions(+), 50 deletions(-)

This is what I was thinking... Compile-tested only.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index be152e3e3a80..6e17f74fb29f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1056,10 +1056,12 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 retry:
 	/* Avoid allocation if the item is already in cache */
-	nf = rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
-				    nfsd_file_rhash_params);
+	rcu_read_lock();
+	nf = rhashtable_lookup(&nfsd_file_rhash_tbl, &key,
+			       nfsd_file_rhash_params);
 	if (nf)
 		nf = nfsd_file_get(nf);
+	rcu_read_unlock();
 	if (nf)
 		goto wait_for_construction;
 
@@ -1069,21 +1071,14 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		goto out_status;
 	}
 
-	nf = rhashtable_lookup_get_insert_key(&nfsd_file_rhash_tbl,
-					      &key, &new->nf_rhash,
-					      nfsd_file_rhash_params);
-	if (!nf) {
-		nf = new;
-		goto open_file;
-	}
-	if (IS_ERR(nf))
-		goto insert_err;
-	nf = nfsd_file_get(nf);
-	if (nf == NULL) {
-		nf = new;
-		goto open_file;
+	if (rhashtable_lookup_insert_key(&nfsd_file_rhash_tbl,
+					 &key, &new->nf_rhash,
+					 nfsd_file_rhash_params)) {
+		nfsd_file_slab_free(&new->nf_rcu);
+		goto retry;
 	}
-	nfsd_file_slab_free(&new->nf_rcu);
+	nf = new;
+	goto open_file;
 
 wait_for_construction:
 	wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTERRUPTIBLE);
@@ -1143,13 +1138,6 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	smp_mb__after_atomic();
 	wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
 	goto out;
-
-insert_err:
-	nfsd_file_slab_free(&new->nf_rcu);
-	trace_nfsd_file_insert_err(rqstp, key.inode, may_flags, PTR_ERR(nf));
-	nf = NULL;
-	status = nfserr_jukebox;
-	goto out_status;
 }
 
 /**
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 06a96e955bd0..c15467b2e8d9 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -954,33 +954,6 @@ TRACE_EVENT(nfsd_file_create,
 	)
 );
 
-TRACE_EVENT(nfsd_file_insert_err,
-	TP_PROTO(
-		const struct svc_rqst *rqstp,
-		const struct inode *inode,
-		unsigned int may_flags,
-		long error
-	),
-	TP_ARGS(rqstp, inode, may_flags, error),
-	TP_STRUCT__entry(
-		__field(u32, xid)
-		__field(const void *, inode)
-		__field(unsigned long, may_flags)
-		__field(long, error)
-	),
-	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqstp->rq_xid);
-		__entry->inode = inode;
-		__entry->may_flags = may_flags;
-		__entry->error = error;
-	),
-	TP_printk("xid=0x%x inode=%p may_flags=%s error=%ld",
-		__entry->xid, __entry->inode,
-		show_nfsd_may_flags(__entry->may_flags),
-		__entry->error
-	)
-);
-
 TRACE_EVENT(nfsd_file_cons_err,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


