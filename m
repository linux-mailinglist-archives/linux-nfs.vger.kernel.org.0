Return-Path: <linux-nfs+bounces-11571-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8DAAAE268
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824691BC4E5F
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E37A28A739;
	Wed,  7 May 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3EYfivp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE27C2874F1
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626854; cv=none; b=CiZXgVmxZhOcaq/viWuMxpIp47eab2zGvpADg0Rgq9409/Oks/0nhI5tf1r7Bb930nQklQsN2GiQV2XDwWgGzp51jO1VR4/nt3PwfU9ymkb4rK43ZIyofR2cXu8FBR06WWBHm9jEcJwlDjm4ME62pM2XuWhhYgpEnQr8BKa2KBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626854; c=relaxed/simple;
	bh=6CARtAa13g2DPvjxDDxNwNETfqfu54Ljk35FBWrW3zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOk3uIrc/f3t10g1rTShONnyLjQCtW0x/twKxBVFscNDlB9ScMslPTUO0PVNsnpk4617OYPIGvmeQ+KWqGDDSNiMO8XniBY/qOKyFeBMALjSEY0JGJ5CGC8HL1cpLA57TMVCqz13X7FVOF0x0rJ9/GlHnZ3sn300mlLeEW0/7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3EYfivp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32210C4CEF2;
	Wed,  7 May 2025 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626853;
	bh=6CARtAa13g2DPvjxDDxNwNETfqfu54Ljk35FBWrW3zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3EYfivpz+M1MPUh0tptVTmTa7Smi3dQQxoBD2WU0BZvNdykbRfeuOi4/S7vU2JBl
	 ThfRJdBoFNFbVFBmVWP1hGhVUU3wy+2SwqrCDih9GFrfIzsXcuXd2PxLWjiZae6Hm/
	 anMq9iy7/v/SnaJFfmMsMLd687pcryW1u/DFfOCRmzXgE2hNmu8Dc5DXkl2/xK2yG/
	 cTGgJnPTHLwCcqaUv5d0ukVFpIsLn4Sgu1jMvupf89MPQovbewF/+wFDns9dyS9FdY
	 KdXYz3laGI6rDtDVZNZDSEfMEmEI8GsrXr8CAtxdM3a+8iYTmQDt1pkeMi6rhX+cPP
	 uLiGWKLHCbhbA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 2/4] NFSD: De-duplicate the svc_fill_write_vector() call sites
Date: Wed,  7 May 2025 10:07:26 -0400
Message-ID: <20250507140728.6497-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507140728.6497-1-cel@kernel.org>
References: <20250507140728.6497-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

All three call sites do the same thing. Instead, simply pass the
xdr_buf containing the write payload directly to nfsd_write() and
nfsd_vfs_write().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c         |  5 +---
 fs/nfsd/nfs4proc.c         |  8 ++-----
 fs/nfsd/nfsproc.c          |  9 +++----
 fs/nfsd/vfs.c              | 49 +++++++++++++++++++++++++++++---------
 fs/nfsd/vfs.h              | 10 ++++----
 include/linux/sunrpc/svc.h |  2 +-
 net/sunrpc/svc.c           |  4 ++--
 7 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..3eecaabd96ce 100644
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
index ba1c5e16172a..57dbc1162ea9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1211,7 +1211,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
-	int nvecs;
 
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
@@ -1226,12 +1225,9 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
index 5d842671fe6f..14641cf58680 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -250,17 +250,14 @@ nfsd_proc_write(struct svc_rqst *rqstp)
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
index d3aa5b82d02d..9673ab33ee5d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1141,11 +1141,25 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+/**
+ * nfsd_vfs_write - write data to a file
+ * @rqstp: RPC execution context
+ * @fhp: File handle of file to write into
+ * @nf: An open file matching @fhp
+ * @offset: Byte offset of start
+ * @payload: xdr_buf containing the write payload
+ * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
+ * @stable: An NFS stable_how value
+ * @verf: NFS WRITE verifier
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
@@ -1160,6 +1174,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
 	bool			restore_flags = false;
+	unsigned int		nvecs;
+
+	nvecs = svc_fill_write_vector(rqstp, payload);
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1187,7 +1204,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
@@ -1287,14 +1304,24 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 }
 
-/*
- * Write data to a file.
- * The stable flag requests synchronous writes.
+/**
+ * nfsd_write - write data to a file
+ * @rqstp: RPC execution context
+ * @fhp: File handle of file to write into; nfsd_write() may modify it
+ * @offset: Byte offset of start
+ * @payload: xdr_buf containing the write payload
+ * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
+ * @stable: An NFS stable_how value
+ * @verf: NFS WRITE verifier
+ *
+ * Return values:
+ *   An nfsstat value in network byte order.
+ *
  * N.B. After this call fhp needs an fh_put
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
+	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1306,8 +1333,8 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
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
index 088c162ae7d6..513b5ee88293 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -464,7 +464,7 @@ int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
 unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 struct xdr_buf *payload);
+					 const struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 930a10cac90b..7ad65e562470 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1733,10 +1733,10 @@ EXPORT_SYMBOL_GPL(svc_encode_result_payload);
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


