Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0518C68DC16
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Feb 2023 15:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBGOul (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Feb 2023 09:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjBGOuh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Feb 2023 09:50:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716A8AD19
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 06:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED3B660CFA
        for <linux-nfs@vger.kernel.org>; Tue,  7 Feb 2023 14:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EBFC433EF;
        Tue,  7 Feb 2023 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675781432;
        bh=C1OXZIu6qJy4LjtmRuyjJEgvFal9hEgmuX6SLsXSvRk=;
        h=From:To:Cc:Subject:Date:From;
        b=rui5OBJaB2DOkcfDfCRPxQ/J6S7o7P/Fh/po2Bg4lM6mvYpzem2jZd9/6N1o12RZ7
         kYsXgMIcIUB1MPTnwhEZE6sKYLIeVfdR9TnylQggXJBcO7MbX95nZUO7/FXXBGfGUY
         CdqH9KtI1WsH+LsQb7rXNz5+8jFoeQYxFMk8tk3iniCcQN9MCiioTDDgTVJjbmRYmO
         nlCfxekSzY/sspn33B1GR+AUnwdVYbp/RvQH5z+6vX8abKBAeWMLSlnDz0Bh5u+S02
         W3jsJGqsxsFA+TMifGPYsmDF1xG/WHJPEYpVj4gxDK8AcUnyaUmRvIxtBoIaVyHiOX
         PwbyBK3xMRS1w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Pierguido Lambri <plambri@redhat.com>
Subject: [PATCH] nfsd: don't fsync nfsd_files on last close
Date:   Tue,  7 Feb 2023 09:50:30 -0500
Message-Id: <20230207145030.90123-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Most of the time, NFSv4 clients issue a COMMIT before the final CLOSE of
an open stateid, so with NFSv4, the fsync in the nfsd_file_free path is
usually a no-op and doesn't block.

We have a customer running knfsd over very slow storage (XFS over Ceph
RBD). They were using the "async" export option because performance was
more important than data integrity for this application. That export
option turns NFSv4 COMMIT calls into no-ops. Due to the fsync in this
codepath however, their final CLOSE calls would still stall (since a
CLOSE effectively became a COMMIT).

I think this fsync is not strictly necessary. We only use that result to
reset the write verifier. Instead of fsync'ing all of the data when we
free an nfsd_file, we can just check for writeback errors when one is
acquired and when it is freed.

If the client never comes back, then it'll never see the error anyway
and there is no point in resetting it. If an error occurs after the
nfsd_file is removed from the cache but before the inode is evicted,
then it will reset the write verifier on the next nfsd_file_acquire,
(since there will be an unseen error).

The only exception here is if something else opens and fsyncs the file
during that window. Given that local applications work with this
limitation today, I don't see that as an issue.

Reported-and-Tested-by: Pierguido Lambri <plambri@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 48 ++++++++++++++-------------------------------
 fs/nfsd/trace.h     | 31 -----------------------------
 2 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 136e543ae44b..fcd16ffbf9ad 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -233,37 +233,27 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 	return nf;
 }
 
+/**
+ * nfsd_file_check_write_error - check for writeback errors on a file
+ * @nf: nfsd_file to check for writeback errors
+ *
+ * Check whether a nfsd_file has an unseen error. Reset the write
+ * verifier if so.
+ */
 static void
-nfsd_file_fsync(struct nfsd_file *nf)
-{
-	struct file *file = nf->nf_file;
-	int ret;
-
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return;
-	ret = vfs_fsync(file, 1);
-	trace_nfsd_file_fsync(nf, ret);
-	if (ret)
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
-}
-
-static int
 nfsd_file_check_write_error(struct nfsd_file *nf)
 {
 	struct file *file = nf->nf_file;
 
-	if (!file || !(file->f_mode & FMODE_WRITE))
-		return 0;
-	return filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err));
+	if ((file->f_mode & FMODE_WRITE) &&
+	    filemap_check_wb_err(file->f_mapping, READ_ONCE(file->f_wb_err)))
+		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 }
 
 static void
 nfsd_file_hash_remove(struct nfsd_file *nf)
 {
 	trace_nfsd_file_unhash(nf);
-
-	if (nfsd_file_check_write_error(nf))
-		nfsd_reset_write_verifier(net_generic(nf->nf_net, nfsd_net_id));
 	rhltable_remove(&nfsd_file_rhltable, &nf->nf_rlist,
 			nfsd_file_rhash_params);
 }
@@ -289,22 +279,13 @@ nfsd_file_free(struct nfsd_file *nf)
 	this_cpu_add(nfsd_file_total_age, age);
 
 	nfsd_file_unhash(nf);
-
-	/*
-	 * We call fsync here in order to catch writeback errors. It's not
-	 * strictly required by the protocol, but an nfsd_file could get
-	 * evicted from the cache before a COMMIT comes in. If another
-	 * task were to open that file in the interim and scrape the error,
-	 * then the client may never see it. By calling fsync here, we ensure
-	 * that writeback happens before the entry is freed, and that any
-	 * errors reported result in the write verifier changing.
-	 */
-	nfsd_file_fsync(nf);
-
 	if (nf->nf_mark)
 		nfsd_file_mark_put(nf->nf_mark);
-	if (nf->nf_file)
+
+	if (nf->nf_file) {
+		nfsd_file_check_write_error(nf);
 		filp_close(nf->nf_file, NULL);
+	}
 
 	/*
 	 * If this item is still linked via nf_lru, that's a bug.
@@ -1080,6 +1061,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 out:
 	if (status == nfs_ok) {
 		this_cpu_inc(nfsd_file_acquisitions);
+		nfsd_file_check_write_error(nf);
 		*pnf = nf;
 	}
 	put_cred(cred);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 8f9c82d9e075..4183819ea082 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1202,37 +1202,6 @@ TRACE_EVENT(nfsd_file_close,
 	)
 );
 
-TRACE_EVENT(nfsd_file_fsync,
-	TP_PROTO(
-		const struct nfsd_file *nf,
-		int ret
-	),
-	TP_ARGS(nf, ret),
-	TP_STRUCT__entry(
-		__field(void *, nf_inode)
-		__field(int, nf_ref)
-		__field(int, ret)
-		__field(unsigned long, nf_flags)
-		__field(unsigned char, nf_may)
-		__field(struct file *, nf_file)
-	),
-	TP_fast_assign(
-		__entry->nf_inode = nf->nf_inode;
-		__entry->nf_ref = refcount_read(&nf->nf_ref);
-		__entry->ret = ret;
-		__entry->nf_flags = nf->nf_flags;
-		__entry->nf_may = nf->nf_may;
-		__entry->nf_file = nf->nf_file;
-	),
-	TP_printk("inode=%p ref=%d flags=%s may=%s nf_file=%p ret=%d",
-		__entry->nf_inode,
-		__entry->nf_ref,
-		show_nf_flags(__entry->nf_flags),
-		show_nfsd_may_flags(__entry->nf_may),
-		__entry->nf_file, __entry->ret
-	)
-);
-
 #include "cache.h"
 
 TRACE_DEFINE_ENUM(RC_DROPIT);
-- 
2.39.1

