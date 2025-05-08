Return-Path: <linux-nfs+bounces-11605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15156AB0189
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721879E3BFB
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29DB28468B;
	Thu,  8 May 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLEwO+1l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CF283FD9
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725865; cv=none; b=hm3W1sg2UgTgXH+j748JZQmiCvCCRqKfnkarf09tsAH7u+EttaMvTtsJQl97+I3ze3rsUoKMPFv2WOdANVzwD6RaHDRLqLYhm6lfRet3bN2bQBHHI1hj4KnRMnypfXfnARn89yPYvtCqnEYJVa9Vs1j6Q9yUesFN3BRALc7g0ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725865; c=relaxed/simple;
	bh=C6/0+wZ/hojkC7K7OIxa8M8rZ2WKs9mueSFEwQNkGn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMQ1xSDMnvbuCmdAVJPIem6nasnhvrJIvcTTxMaUb/xD9kVNzats+JpIAbsmPzsesg30HwIOvb14Thu/ymE0cxzpHpCf4no9qg/tLNYkVtGVxkSclEjMVUyzh0f5mam30gZ/d7GsgewE56nYVZdoobi+UYKsr4METZtle/5B2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLEwO+1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77223C4CEEB;
	Thu,  8 May 2025 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725865;
	bh=C6/0+wZ/hojkC7K7OIxa8M8rZ2WKs9mueSFEwQNkGn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLEwO+1lZ/IzC+UKmrkEGaH1qrR8Rtpf0F97+eEU6RUl1AyZk2imqYUovQ3wSjtjY
	 KOt1EqusKYI0h5au7zdVO7+Lgeq24PUA9QfPYzg/9eZbHNYAbmcObPAXycc5qhrvoD
	 GELwcglMj3r3yznWyoYyip6l38wyVvjRfM7XE6gxOVhiaaYjkODtSKr36pm73IXj1A
	 IjLrBXiNSDZRishQTDdsAn2REtizndImrMtpvvKgFhzP7NDaS2WBIWfpiHCobA7vzR
	 p8HoeBvBEEeANBZfrROBcg4XG6EjzMdzf8jgo/cBXVGaYDny5lLjff4O7nj1uJH6/b
	 g3N7A5RKM80hA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/6] NFSD: De-duplicate the svc_fill_write_vector() call sites
Date: Thu,  8 May 2025 13:37:37 -0400
Message-ID: <20250508173740.5475-4-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
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
 fs/nfsd/nfs3proc.c |  5 +----
 fs/nfsd/nfs4proc.c |  8 ++-----
 fs/nfsd/nfsproc.c  |  9 +++-----
 fs/nfsd/vfs.c      | 52 +++++++++++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h      | 10 ++++-----
 5 files changed, 51 insertions(+), 33 deletions(-)

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
index f964fd393f8a..e92036251ee7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1141,11 +1141,27 @@ static int wait_for_concurrent_writes(struct file *file)
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
+	       struct xdr_buf *payload, unsigned long *cnt,
+	       int stable, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
@@ -1160,6 +1176,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
 	bool			restore_flags = false;
+	unsigned int		nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1187,7 +1204,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
+	nvecs = svc_fill_write_vector(rqstp, payload);
+	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
@@ -1287,14 +1305,24 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+	   struct xdr_buf *payload, unsigned long *cnt, int stable,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1306,8 +1334,8 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
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
index f9b09b842856..a8578b976fdf 100644
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
+				loff_t offset, struct xdr_buf *payload,
+				unsigned long *cnt, int stable, __be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
-				struct kvec *vec, int vlen, unsigned long *cnt,
-				int stable, __be32 *verf);
+				struct xdr_buf *payload,
+				unsigned long *cnt, int stable, __be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
-- 
2.49.0


