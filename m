Return-Path: <linux-nfs+bounces-15200-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A753FBD5D3C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 21:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B3A188E954
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83E27B359;
	Mon, 13 Oct 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5hj6Lca"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364711E32CF
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382077; cv=none; b=RBj1F/yykVyoAJarxGUyyeKx5QZ5KuZ1BY4EpuWX9mAnGBDLD3aatauwKUfdmitboTevZVAJAHMs6wRzfSsFYxfggUHTDeFv5WbOukwYWLP6WM+buP3wYx9nWsD2h9sra79tOwixZ3rZydEoALKFmtzdE8OC6SJdcsfzthPetO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382077; c=relaxed/simple;
	bh=AuDMUQ0BNrafK3DDOfhsEOrVuDWS8YnzeFfX4WL/FGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAk1klrX4gXBKuqYXBEIQRA5C0WVqvuXXN3ptlJFPL6pxYu3/88MDt8CzRhBuV+iRBPxXgBvXbUthf1NjXkBI+hlsoz8wuCLCLPzLhN4gtBTbVCrzq0B/DZnyPhdNh2Fm9owtWeKtEsqeaIC7T65WpnjlppUqPrvrGkyhvJSvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5hj6Lca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DF6C4CEE7;
	Mon, 13 Oct 2025 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760382076;
	bh=AuDMUQ0BNrafK3DDOfhsEOrVuDWS8YnzeFfX4WL/FGM=;
	h=From:To:Cc:Subject:Date:From;
	b=u5hj6LcaqDiK6c3YqIK6cE4xW4363tIPnR4hb0pfGzvyZzgGrdvgWwL0KApYR50A8
	 90ZJHEFZx8DuTh2jAmYdCkleBQ+03RRxYuSQwegHMh2xBh6GmY0K6dFiAU8UIy1s9Z
	 6c0hU04tDBw0umpyf7cO0nPLd26vwGB/9pFlcb6END+E/05PxsSEgaWoXUv7Gsosk/
	 CbS9Rt8cIuOJ8lknhkFEjXKUWAWR6jpS0HRqyFFc+jzAAcUqc0h8BbeNelSnkgM9IW
	 /8R1tofpe4RTBbFCuuutxg2sXRx/d7hjZdrr92aTiz/RTcVrp9J0VQx1E8wyE9tM84
	 4b3LaLWYLDMzQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] NFSD: Enable return of an updated stable_how to NFS clients
Date: Mon, 13 Oct 2025 15:01:13 -0400
Message-ID: <20251013190113.252097-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In a subsequent patch, nfsd_vfs_write() will promote an UNSTABLE
WRITE to be a FILE_SYNC WRITE. This indicates that the client does
not need a subsequent COMMIT operation, saving a round trip and
allowing the client to dispense with cached dirty data as soon as
it receives the server's WRITE response.

This patch refactors nfsd_vfs_write() to return a possibly modified
stable_how value to its callers. No behavior change is expected.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsproc.c  |  3 ++-
 fs/nfsd/vfs.c      | 11 ++++++-----
 fs/nfsd/vfs.h      |  6 ++++--
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

Here's what I had in mind, based on a patch I did a year ago but
never posted.

If nfsd_vfs_write() promotes an NFS_UNSTABLE write to NFS_FILE_SYNC,
it can now set *stable_how and the WRITE encoders will return the
updated value to the client.


diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index b6d03e1ef5f7..ad14b34583bb 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -236,7 +236,7 @@ nfsd3_proc_write(struct svc_rqst *rqstp)
 	resp->committed = argp->stable;
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
 				  &argp->payload, &cnt,
-				  resp->committed, resp->verf);
+				  &resp->committed, resp->verf);
 	resp->count = cnt;
 	resp->status = nfsd3_map_status(resp->status);
 	return rpc_success;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7f7e6bb23a90..2222bb283baf 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1285,7 +1285,7 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	write->wr_how_written = write->wr_stable_how;
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
 				write->wr_offset, &write->wr_payload,
-				&cnt, write->wr_how_written,
+				&cnt, &write->wr_how_written,
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
 
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 8f71f5748c75..706401ed6f8d 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -251,6 +251,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 	struct nfsd_writeargs *argp = rqstp->rq_argp;
 	struct nfsd_attrstat *resp = rqstp->rq_resp;
 	unsigned long cnt = argp->len;
+	u32 committed = NFS_DATA_SYNC;
 
 	dprintk("nfsd: WRITE    %s %u bytes at %d\n",
 		SVCFH_fmt(&argp->fh),
@@ -258,7 +259,7 @@ nfsd_proc_write(struct svc_rqst *rqstp)
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_write(rqstp, &resp->fh, argp->offset,
-				  &argp->payload, &cnt, NFS_DATA_SYNC, NULL);
+				  &argp->payload, &cnt, &committed, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f537a7b4ee01..8b2dc7a88aab 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1262,7 +1262,7 @@ static int wait_for_concurrent_writes(struct file *file)
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1274,11 +1274,12 @@ __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	       struct nfsd_file *nf, loff_t offset,
 	       const struct xdr_buf *payload, unsigned long *cnt,
-	       int stable, __be32 *verf)
+	       u32 *stable_how, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
+	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
@@ -1434,7 +1435,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1444,7 +1445,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
+	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1457,7 +1458,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 		goto out;
 
 	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt,
-			     stable, verf);
+			     stable_how, verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index fa46f8b5f132..c713ed0b04e0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -130,11 +130,13 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				u32 *eof);
 __be32		nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, u32 *stable_how,
+				__be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
 				const struct xdr_buf *payload,
-				unsigned long *cnt, int stable, __be32 *verf);
+				unsigned long *cnt, u32 *stable_how,
+				__be32 *verf);
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
2.51.0


