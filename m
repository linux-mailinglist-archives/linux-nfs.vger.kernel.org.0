Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C528F708723
	for <lists+linux-nfs@lfdr.de>; Thu, 18 May 2023 19:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjERRqJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 May 2023 13:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjERRqG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 May 2023 13:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24FE61
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 10:45:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80B0665152
        for <linux-nfs@vger.kernel.org>; Thu, 18 May 2023 17:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C55EC433D2;
        Thu, 18 May 2023 17:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684431957;
        bh=YGp7ohilP2ZwBHsR3MUlES5YLo6UxMmn4o5e8mCRsiU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hkf7mfXLjMzEXq16Okx5SzTjULIZzmByLW+YM2mZ5hc2oXSAO64yeOZz+iR8CdVna
         LWc3vc6aSxN2btkt0ckVWOukOTYxa6EE+w59WANIap4jEdm5v2S6k31/yfk72eNTjj
         1gUh9fVMyoPvkWOT9FgTpa0quvDtb0UUQxh0jjjkJrszAOPWtObkSxLKxPerwSrLD1
         3YpLb49krHDuBJTlSZor+HJhRf1EiBbdJTW1pQPsP46vaCiJcH34Zd8AiYOa0h3O3K
         jQagroSjkRg56wWGVcCHo6RttMOuQYELiHRzklNSrvHY1Y5dtzwYJFSVlzLIDCXxN4
         u40n7LITZyyqQ==
Subject: [PATCH v1 4/6] NFSD: Hoist rq_vec preparation into nfsd_read()
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, dhowells@redhat.com, jlayton@redhat.com
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date:   Thu, 18 May 2023 13:45:56 -0400
Message-ID: <168443195664.516083.12106288760156437793.stgit@klimt.1015granger.net>
In-Reply-To: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
References: <168443154055.516083.746756240848084451.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Accrue the following benefits:

a) Deduplicate this common bit of code.

b) Don't prepare rq_vec for NFSv2 and NFSv3 spliced reads, which
   don't use rq_vec. This is already the case for
   nfsd4_encode_read().

c) Eventually, converting NFSD's read path to use a bvec iterator
   will be simpler.

In the next patch, nfsd_iter_read() will replace nfsd_readv() for
all NFS versions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |   14 +----------
 fs/nfsd/nfsproc.c  |   14 +----------
 fs/nfsd/vfs.c      |   68 ++++++++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/vfs.h      |    8 +++++-
 4 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index e6bb8eeb5bc2..fc8d5b7db9f8 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -151,8 +151,6 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd3_readargs *argp = rqstp->rq_argp;
 	struct nfsd3_readres *resp = rqstp->rq_resp;
-	unsigned int len;
-	int v;
 
 	dprintk("nfsd: READ(3) %s %lu bytes at %Lu\n",
 				SVCFH_fmt(&argp->fh),
@@ -166,17 +164,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	if (argp->offset + argp->count > (u64)OFFSET_MAX)
 		argp->count = (u64)OFFSET_MAX - argp->offset;
 
-	v = 0;
-	len = argp->count;
 	resp->pages = rqstp->rq_next_page;
-	while (len > 0) {
-		struct page *page = *(rqstp->rq_next_page++);
-
-		rqstp->rq_vec[v].iov_base = page_address(page);
-		rqstp->rq_vec[v].iov_len = min_t(unsigned int, len, PAGE_SIZE);
-		len -= rqstp->rq_vec[v].iov_len;
-		v++;
-	}
 
 	/* Obtain buffer pointer for payload.
 	 * 1 (status) + 22 (post_op_attr) + 1 (count) + 1 (eof)
@@ -187,7 +175,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
-				 rqstp->rq_vec, v, &resp->count, &resp->eof);
+				 &resp->count, &resp->eof);
 	return rpc_success;
 }
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index c37195572fd0..a7315928a760 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -176,9 +176,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 {
 	struct nfsd_readargs *argp = rqstp->rq_argp;
 	struct nfsd_readres *resp = rqstp->rq_resp;
-	unsigned int len;
 	u32 eof;
-	int v;
 
 	dprintk("nfsd: READ    %s %d bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
@@ -187,17 +185,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	argp->count = min_t(u32, argp->count, NFSSVC_MAXBLKSIZE_V2);
 	argp->count = min_t(u32, argp->count, rqstp->rq_res.buflen);
 
-	v = 0;
-	len = argp->count;
 	resp->pages = rqstp->rq_next_page;
-	while (len > 0) {
-		struct page *page = *(rqstp->rq_next_page++);
-
-		rqstp->rq_vec[v].iov_base = page_address(page);
-		rqstp->rq_vec[v].iov_len = min_t(unsigned int, len, PAGE_SIZE);
-		len -= rqstp->rq_vec[v].iov_len;
-		v++;
-	}
 
 	/* Obtain buffer pointer for payload. 19 is 1 word for
 	 * status, 17 words for fattr, and 1 word for the byte count.
@@ -207,7 +195,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	resp->count = argp->count;
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
-				 rqstp->rq_vec, v, &resp->count, &eof);
+				 &resp->count, &eof);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c4ef24c5ffd0..054d58d01299 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1028,6 +1028,50 @@ __be32 nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+/**
+ * nfsd_iter_read - Perform a VFS read using an iterator
+ * @rqstp: RPC transaction context
+ * @fhp: file handle of file to be read
+ * @file: opened struct file of file to be read
+ * @offset: starting byte offset
+ * @count: IN: requested number of bytes; OUT: number of bytes read
+ * @base: offset in first page of read buffer
+ * @eof: OUT: set non-zero if operation reached the end of the file
+ *
+ * Some filesystems or situations cannot use nfsd_splice_read. This
+ * function is the slightly less-performant fallback for those cases.
+ *
+ * Returns nfs_ok on success, otherwise an nfserr stat value is
+ * returned.
+ */
+__be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		      struct file *file, loff_t offset, unsigned long *count,
+		      unsigned int base, u32 *eof)
+{
+	unsigned long v, total;
+	struct iov_iter iter;
+	loff_t ppos = offset;
+	struct page *page;
+	ssize_t host_err;
+
+	v = 0;
+	total = *count;
+	while (total) {
+		page = *(rqstp->rq_next_page++);
+		rqstp->rq_vec[v].iov_base = page_address(page) + base;
+		rqstp->rq_vec[v].iov_len = min_t(size_t, total, PAGE_SIZE - base);
+		total -= rqstp->rq_vec[v].iov_len;
+		++v;
+		base = 0;
+	}
+	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
+
+	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
+	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
+	host_err = vfs_iter_read(file, &iter, &ppos, 0);
+	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
+}
+
 /*
  * Gathered writes: If another process is currently writing to the file,
  * there's a high chance this is another nfsd (triggered by a bulk write
@@ -1153,14 +1197,24 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	return nfserr;
 }
 
-/*
- * Read data from a file. count must contain the requested read count
- * on entry. On return, *count contains the number of bytes actually read.
+/**
+ * nfsd_read - Read data from a file
+ * @rqstp: RPC transaction context
+ * @fhp: file handle of file to be read
+ * @offset: starting byte offset
+ * @count: IN: requested number of bytes; OUT: number of bytes read
+ * @eof: OUT: set non-zero if operation reached the end of the file
+ *
+ * The caller must verify that there is enough space in @rqstp.rq_res
+ * to perform this operation.
+ *
  * N.B. After this call fhp needs an fh_put
+ *
+ * Returns nfs_ok on success, otherwise an nfserr stat value is
+ * returned.
  */
 __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
-	loff_t offset, struct kvec *vec, int vlen, unsigned long *count,
-	u32 *eof)
+		 loff_t offset, unsigned long *count, u32 *eof)
 {
 	struct nfsd_file	*nf;
 	struct file *file;
@@ -1175,12 +1229,10 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (file->f_op->splice_read && test_bit(RQ_SPLICE_OK, &rqstp->rq_flags))
 		err = nfsd_splice_read(rqstp, fhp, file, offset, count, eof);
 	else
-		err = nfsd_readv(rqstp, fhp, file, offset, vec, vlen, count, eof);
+		err = nfsd_iter_read(rqstp, fhp, file, offset, count, 0, eof);
 
 	nfsd_file_put(nf);
-
 	trace_nfsd_read_done(rqstp, fhp, offset, *count);
-
 	return err;
 }
 
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 43fb57a301d3..6381a2890b0b 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -115,8 +115,12 @@ __be32		nfsd_readv(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct kvec *vec, int vlen,
 				unsigned long *count,
 				u32 *eof);
-__be32 		nfsd_read(struct svc_rqst *, struct svc_fh *,
-				loff_t, struct kvec *, int, unsigned long *,
+__be32		nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				struct file *file, loff_t offset,
+				unsigned long *count, unsigned int base,
+				u32 *eof);
+__be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				loff_t offset, unsigned long *count,
 				u32 *eof);
 __be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
 				struct kvec *, int, unsigned long *,


