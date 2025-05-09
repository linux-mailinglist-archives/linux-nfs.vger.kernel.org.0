Return-Path: <linux-nfs+bounces-11629-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB21AB1D09
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE6317C80C
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600FC243956;
	Fri,  9 May 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Y9WeYK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38239242D71;
	Fri,  9 May 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817443; cv=none; b=RsqxeB1ka/HTl7rjP6/mLLa+XkjTebLE+jWHiQwasXwc1xR0dF/iFKWllqpzvAwqYtP1Y+J0CFJAnOTt+ss4Bm9QySC7neUIORXJF2wxFV2EnbxPksYo6832lRaD38oqebcxsXliZj/fMAvAYDK26Ay1yyyo6Rcf19E4L51TIVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817443; c=relaxed/simple;
	bh=yw5EM980QZV7PwXx+pTAHbY99loam6nQkvyCmIkoB/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUR9p0yrhqrV8iz5TCijiI/I2LYZRGe3NHRaXUmEx8TcuTuotU+fVjeWuFljqBWKsxyCdMTnIoFRKNy8m2JSVk8x+4H/56DAsXGN3hHUlpxFb2RlTvxNYIVUTDRiqoATVHqpNgEiPIuDqrn5D1I8SYFJwIpepoAo6/IUM3JlRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Y9WeYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1700EC4CEF1;
	Fri,  9 May 2025 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817442;
	bh=yw5EM980QZV7PwXx+pTAHbY99loam6nQkvyCmIkoB/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/Y9WeYKf2OwjDLUlqKBh81qi3+ySMlLtSrJxW/COFDZ1FQX/m15KMBhVjrKVjh5p
	 wfEpVtkUmtLPwIdIxKmwMoHupizBHrxJYj3ZcSivcR7alQWSchwWQn87RNUSXMmtSD
	 BNt9ujZ1H95vBj0J2dWMSfgiPFKPXHv8Sctl4aIH4QU+z1DRbaet8J8YB1hIobLKl8
	 tJx8G5zBMDoybKlKHuTIP5OFwYGa3CXhsy8+uIrwBPIVjziCbvzhDSFS+VumGEIDO6
	 qDPop2j12Lj8G0zG6TVERIDp1/MJJXUS8w9OUTUwB8aWYREfPlC9sRqP/vJ7tL4daO
	 ccjOePqoQyCzA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 07/19] NFSD: De-duplicate the svc_fill_write_vector() call sites
Date: Fri,  9 May 2025 15:03:41 -0400
Message-ID: <20250509190354.5393-8-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

All three call sites do the same thing.

I'm struggling with this a bit, however. struct xdr_buf is an XDR
layer object and unmarshaling a WRITE payload is clearly a task
intended to be done by the proc and xdr functions, not by VFS. This
feels vaguely like a layering violation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c         |  5 +---
 fs/nfsd/nfs4proc.c         |  8 ++----
 fs/nfsd/nfsproc.c          |  9 +++----
 fs/nfsd/vfs.c              | 52 +++++++++++++++++++++++++++++---------
 fs/nfsd/vfs.h              | 10 ++++----
 include/linux/sunrpc/svc.h |  2 +-
 net/sunrpc/svc.c           |  4 +--
 7 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8902fae8c62d..12e1eef810e7 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -220,7 +220,6 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	struct nfsd3_writeargs *argp = rqstp->rq_argp;
 	struct nfsd3_writeres *resp = rqstp->rq_resp;
 	unsigned long cnt = argp->len;
-	unsigned int nvecs;
 
 	dprintk("nfsd: WRITE(3)    %s %d bytes at %Lu%s\n",
 				SVCFH_fmt(&argp->fh),
@@ -235,10 +234,8 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->committed = argp->stable;
-	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
-
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
-				  rqstp->rq_vec, nvecs, &cnt,
+				  &argp->payload, &cnt,
 				  resp->committed, resp->verf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2b16ee1ae461..ffd8b1d499df 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1216,7 +1216,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
-	int nvecs;
 
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
@@ -1231,12 +1230,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return status;
 
 	write->wr_how_written = write->wr_stable_how;
-
-	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
-
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
-				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
-				write->wr_how_written,
+				write->wr_offset, &write->wr_payload,
+				&cnt, write->wr_how_written,
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7c573d792252..65cbe04184f3 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -251,17 +251,14 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	unsigned long cnt = argp->len;
-	unsigned int nvecs;
 
 	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
 		argp->len, argp->offset);
 
-	nvecs = svc_fill_write_vector(rqstp, &argp->payload);
-
-	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
-				  argp->offset, rqstp->rq_vec, nvecs,
-				  &cnt, NFS_DATA_SYNC, NULL);
+	fh_copy(&resp->fh, &argp->fh);
+	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
+				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7cfd26dec5a8..43ecc5ae0c3f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1143,11 +1143,27 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+/**
+ * nfsd_vfs_write - write data to an already-open file
+ * @rqstp: RPC execution context
+ * @fhp: File handle of file to write into
+ * @nf: An open file matching @fhp
+ * @offset: Byte offset of start
+ * @payload: xdr_buf containing the write payload
+ * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
+ * @stable: An NFS stable_how value
+ * @verf: NFS WRITE verifier
+ *
+ * Upon return, caller must invoke fh_put on @fhp.
+ *
+ * Return values:
+ *   An nfsstat value in network byte order.
+ */
 __be32
-nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
-				loff_t offset, struct kvec *vec, int vlen,
-				unsigned long *cnt, int stable,
-				__be32 *verf)
+nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+	       struct nfsd_file *nf, loff_t offset,
+	       const struct xdr_buf *payload, unsigned long *cnt,
+	       int stable, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
@@ -1162,6 +1178,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
 	bool			restore_flags = false;
+	unsigned int		nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1189,7 +1206,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
+	nvecs = svc_fill_write_vector(rqstp, payload);
+	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
@@ -1289,14 +1307,24 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 }
 
-/*
- * Write data to a file.
- * The stable flag requests synchronous writes.
- * N.B. After this call fhp needs an fh_put
+/**
+ * nfsd_write - open a file and write data to it
+ * @rqstp: RPC execution context
+ * @fhp: File handle of file to write into; nfsd_write() may modify it
+ * @offset: Byte offset of start
+ * @payload: xdr_buf containing the write payload
+ * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
+ * @stable: An NFS stable_how value
+ * @verf: NFS WRITE verifier
+ *
+ * Upon return, caller must invoke fh_put on @fhp.
+ *
+ * Return values:
+ *   An nfsstat value in network byte order.
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
+	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1308,8 +1336,8 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	if (err)
 		goto out;
 
-	err = nfsd_vfs_write(rqstp, fhp, nf, offset, vec,
-			vlen, cnt, stable, verf);
+	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
+			     stable, verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index f9b09b842856..eff04959606f 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -128,13 +128,13 @@ bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
 __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, unsigned long *count,
 				u32 *eof);
-__be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
-				struct kvec *, int, unsigned long *,
-				int stable, __be32 *verf);
+__be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				loff_t offset, const struct xdr_buf *payload,
+				unsigned long *cnt, int stable, __be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
-				struct kvec *vec, int vlen, unsigned long *cnt,
-				int stable, __be32 *verf);
+				const struct xdr_buf *payload,
+				unsigned long *cnt, int stable, __be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 538bea716c6b..dec636345ee2 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -471,7 +471,7 @@ int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
 unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 struct xdr_buf *payload);
+					 const struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2c1c4aa93f43..a8861a80bc04 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1727,10 +1727,10 @@ EXPORT_SYMBOL_GPL(svc_encode_result_payload);
  * Fills in rqstp::rq_vec, and returns the number of elements.
  */
 unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
-				   struct xdr_buf *payload)
+				   const struct xdr_buf *payload)
 {
+	const struct kvec *first = payload->head;
 	struct page **pages = payload->pages;
-	struct kvec *first = payload->head;
 	struct kvec *vec = rqstp->rq_vec;
 	size_t total = payload->len;
 	unsigned int i;
-- 
2.49.0


