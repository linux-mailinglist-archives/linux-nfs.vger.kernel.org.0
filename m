Return-Path: <linux-nfs+bounces-7725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE39BF3C5
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 17:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3112819FB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 16:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1920514F;
	Wed,  6 Nov 2024 16:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrfhnFfB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B773202F6C
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912241; cv=none; b=h4GgJpl1X+fbeDJ6+X5TZHRq9mxrxbuuTqxfhIR85sYFtxaft+AIcjJBTpzbvrz4eSNO5BiaNosQK6ZDu4HiPRjgrKcABgC4xV+L5qqlapep8Pt3bvEs7U+SEixQ+4Cbrp/MZAR5WV0/LCQkzr3fwkRuMUnHKXKeN2gO8MefSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912241; c=relaxed/simple;
	bh=5e6TXUdJVPc0TFdTLv8aRyH+c6eoXTI4KsdR51tpSro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzWb9Jx3v9wzr9OdL6Rzz8lQTRIA6JZni9nApmHEQWgWMd/hG7Ma84eGpzsYRPxfS+MFMKTPFCYhagkGTzYRoKEaLUoMjxwAiEhoVagk5nCVGer7oNandGWlAGdLba6hAP3J1FhsxePwDodqdvRZLfrMcrUWmje+yfWO2EE0hc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrfhnFfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06269C4CED0;
	Wed,  6 Nov 2024 16:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912240;
	bh=5e6TXUdJVPc0TFdTLv8aRyH+c6eoXTI4KsdR51tpSro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WrfhnFfBbtF8cVOLvtunQJOhkmZJnnQ15Mg1AonLRH5rVJsUnMMS4u5sdRxl7vRGC
	 OsI1AEwWZM6R1EZ78cwPP/muoBrSy0M88Gd2J4y9ZA5vapUkN5tiL6hBovJMHbAeLi
	 ENviHV4bziLRYOBY9DQU2rS99PkZZ4ZGaUCTAO2LhU83H5nNMCxGgebZbT6SkpOCNd
	 blRQy/SyhMsixAjD1qerrkkBb1SyifnJvdMsJ4Enh95+JQs/pmGg376cAJVY9AD7O7
	 UupE4S5yU5UKeucVgnbKsf/nPDAcKIFnpg5WWhB2PeJcO1dfJJe9lgRBAzAUmb1GOy
	 1FzC5+TUmgY4w==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Return the actual stable_how value to clients
Date: Wed,  6 Nov 2024 11:57:15 -0500
Message-ID: <20241106165716.109681-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106165716.109681-1-cel@kernel.org>
References: <20241106165716.109681-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd_vfs_write() may alter the stable_how value of an NFS WRITE
operation. The current implementation does not convey that change
back to the client, however. Instead it always returns the same
value as the client sent in the request. This might cause a client
to believe a FILE_SYNC WRITE payload was durable when in fact it was
converted to an UNSTABLE WRITE.

In the future, nfsd_vfs_write() might make the converse alteration:
promoting an UNSTABLE WRITE to be a FILE_SYNC WRITE. This would
signal that the client does not need a subsequent COMMIT operation.
Therefore the change to stable_how has to appear in the server's
WRITE response.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsproc.c  |  3 ++-
 fs/nfsd/vfs.c      | 49 +++++++++++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h      |  8 ++++----
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..64abab971915 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -239,7 +239,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  rqstp->rq_vec, nvecs, &cnt,
-				  resp->committed, resp->verf);
+				  &resp->committed, resp->verf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d32f2dfd148f..51bae11d5d23 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1205,7 +1205,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
-				write->wr_how_written,
+				&write->wr_how_written,
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..b9b03ae56a94 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -250,6 +250,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	unsigned long cnt = argp->len;
+	u32 committed = NFS_DATA_SYNC;
 	unsigned int nvecs;
 
 	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
@@ -260,7 +261,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
 				  argp->offset, rqstp->rq_vec, nvecs,
-				  &cnt, NFS_DATA_SYNC, NULL);
+				  &cnt, &committed, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 22325b590e17..cd00d95c997f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1149,11 +1149,27 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+/**
+ * nfsd_vfs_write - Invoke vfs_write()
+ * @rqstp: RPC execution context
+ * @fhp: verified file handle
+ * @nf: open nfsd_file matching @fhp
+ * @offset: starting byte offset
+ * @vec: array of vectors containing write payload
+ * @vlen: size of @vec
+ * @cnt: count of bytes to write
+ * @stable: whether to persist the payload immediately
+ * @verf: NFS write verifier to be filled in
+ *
+ * Upon return, caller must fh_put @fhp .
+ *
+ * Returns nfs_ok on success, otherwise an nfserr stat value is
+ * returned.
+ */
 __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
-				loff_t offset, struct kvec *vec, int vlen,
-				unsigned long *cnt, int stable,
-				__be32 *verf)
+	       loff_t offset, struct kvec *vec, int vlen, unsigned long *cnt,
+	       u32 *stable, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
@@ -1190,9 +1206,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	exp = fhp->fh_export;
 
 	if (!EX_ISSYNC(exp))
-		stable = NFS_UNSTABLE;
+		*stable = NFS_UNSTABLE;
 
-	if (stable && !fhp->fh_use_wgather)
+	if (*stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
 	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
@@ -1211,7 +1227,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (host_err < 0)
 		goto out_nfserr;
 
-	if (stable && fhp->fh_use_wgather) {
+	if (*stable && fhp->fh_use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
 		if (host_err < 0)
 			commit_reset_write_verifier(nn, rqstp, host_err);
@@ -1293,14 +1309,25 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return err;
 }
 
-/*
- * Write data to a file.
- * The stable flag requests synchronous writes.
- * N.B. After this call fhp needs an fh_put
+/**
+ * nfsd_write - Write data to a file.
+ * @rqstp: RPC execution context
+ * @fhp: verified file handle
+ * @offset: starting byte offset
+ * @vec: array of vectors containing write payload
+ * @vlen: size of @vec
+ * @cnt: count of bytes to write
+ * @stable: whether to persist the payload immediately
+ * @verf: NFS write verifier to be filled in
+ *
+ * Upon return, caller must fh_put @fhp .
+ *
+ * Returns nfs_ok on success, otherwise an nfserr stat value is
+ * returned.
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
+	   struct kvec *vec, int vlen, unsigned long *cnt, u32 *stable,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3ff146522556..0b002f183046 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -128,13 +128,13 @@ bool		nfsd_read_splice_ok(struct svc_rqst *rqstp);
 __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, unsigned long *count,
 				u32 *eof);
-__be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
-				struct kvec *, int, unsigned long *,
-				int stable, __be32 *verf);
+__be32 		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+				loff_t offset, struct kvec *vec, int vlen,
+				unsigned long *cnt, u32 *stable, __be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				struct kvec *vec, int vlen, unsigned long *cnt,
-				int stable, __be32 *verf);
+				u32 *stable, __be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
 __be32		nfsd_symlink(struct svc_rqst *, struct svc_fh *,
diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
index 522067b7fd75..c0e443ef3a6b 100644
--- a/fs/nfsd/xdr3.h
+++ b/fs/nfsd/xdr3.h
@@ -152,7 +152,7 @@ struct nfsd3_writeres {
 	__be32			status;
 	struct svc_fh		fh;
 	unsigned long		count;
-	int			committed;
+	u32			committed;
 	__be32			verf[2];
 };
 
-- 
2.47.0


