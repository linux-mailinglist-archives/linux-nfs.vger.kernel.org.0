Return-Path: <linux-nfs+bounces-15586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B04C06C08
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041E83B1723
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382F3191D6;
	Fri, 24 Oct 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u80nXgt5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75A1E0083
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316991; cv=none; b=BCpIBoKs8qHsuxJf5ZIl41nxJfxbhnKj7lRGTCEgZdIfYvBGqwSw74WIKy8HwEDJVeOBctSf7r4+BUFyD5uf5SVuqK+Ol2LOq7CDv+eGZXdkHzv8TjnJuvyaRXUaojw48zlucASLLKbKhhoZ8Cxtlz3cFrQ8N3wEmBvHsG/sQUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316991; c=relaxed/simple;
	bh=93WDKCnZzvdfjfCQdhTyVNg0lDzFUnPKCxvevN0YWqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cteH3ppo8ZpoPdJ2ibS419Xcf4h2bv1PLfthok95jwKbcsVfJLovT4mo6+hElb9GJ6O3RN3B3+N4cmpIyYDBZ83+jndREuBETVMfLES7fdlW0vEszDfcQLGtlR47mvCqt0HSj5EKLYkFNBcYRe0a+DliRhSIMLEksnkOz+Arpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u80nXgt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2A2C116B1;
	Fri, 24 Oct 2025 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316990;
	bh=93WDKCnZzvdfjfCQdhTyVNg0lDzFUnPKCxvevN0YWqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u80nXgt5AGnRNXIik88H/NXXKhv+TiEONjYfUwUstiSffzIFj/4dftvOIrWcuVntt
	 9Y3y8BOyzUsBNIF5XjKWZCioDbCdRGmB/pRpbOrn0Y/YCxu486m6QuXaY3GcA6XCd/
	 sf0s8WATC9xcu0RGk9qKrbI2Za/3ATFj1WKusG9jymJTAVGEiinHB+SXD6kIbmr2HP
	 vEqXJlBuhN5X+onC9h4k+Vvflz9kfHxezxmc5Z0br/iEO5PH7gb8YbAwgqDpRFu1tk
	 Ag7viUERCwZQUD7ycfQDVp+RA1uu964H9lwPSmkV/wcM25LHbTYYJCv+RXIrYZ0WyH
	 h99uvJ+KTfpVw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 02/14] NFSD: Enable return of an updated stable_how to NFS clients
Date: Fri, 24 Oct 2025 10:42:54 -0400
Message-ID: <20251024144306.35652-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

NFSv3 and newer protocols enable clients to perform a two-phase
WRITE. A client requests an UNSTABLE WRITE, which sends dirty data
to the NFS server, but does not persist it. The server replies that
it performed the UNSTABLE WRITE, and the client is then obligated to
follow up with a COMMIT request before it can remove the dirty data
from its own page cache. The COMMIT reply is the client's guarantee
that the written data has been persisted on the server.

The purpose of this protocol design is to enable clients to send
a large amount of data via multiple WRITE requests to a server, and
then wait for persistence just once. The server is able to start
persisting the data as soon as it gets it, to shorten the length of
time the client has to wait for the final COMMIT to complete.

It's also possible for the server to respond to an UNSTABLE WRITE
request in a way that indicates that the data was persisted anyway.
In that case, the client can skip the COMMIT and remove the dirty
data from its memory immediately. NetApp filers, for example, do
this because they have a battery-backed cache and can guarantee that
written data is persisted quickly and immediately.

NFSD has never implemented this kind of promotion. UNSTABLE WRITE
requests are unconditionally treated as UNSTABLE. However, in a
subsequent patch, nfsd_vfs_write() will be able to promote an
UNSTABLE WRITE to be a FILE_SYNC WRITE. This will be because NFSD
will handle some WRITE requests locally with O_DIRECT, which
persists written data immediately. The FILE_SYNC WRITE response
indicates to the client that no follow-up COMMIT is necessary.

This patch prepares for that change by enabling the modified
stable_how value to be passed along to NFSD's WRITE reply encoder.
No behavior change is expected.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c |  2 +-
 fs/nfsd/nfs4proc.c |  2 +-
 fs/nfsd/nfsproc.c  |  3 ++-
 fs/nfsd/vfs.c      | 11 ++++++-----
 fs/nfsd/vfs.h      |  6 ++++--
 fs/nfsd/xdr3.h     |  2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

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
index 5a9a2a69bc08..dc98182a9048 100644
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
@@ -1440,7 +1441,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * @offset: Byte offset of start
  * @payload: xdr_buf containing the write payload
  * @cnt: IN: number of bytes to write, OUT: number of bytes actually written
- * @stable: An NFS stable_how value
+ * @stable_how: IN: Client's requested stable_how, OUT: Actual stable_how
  * @verf: NFS WRITE verifier
  *
  * Upon return, caller must invoke fh_put on @fhp.
@@ -1450,7 +1451,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   const struct xdr_buf *payload, unsigned long *cnt, int stable,
+	   const struct xdr_buf *payload, unsigned long *cnt, u32 *stable_how,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1463,7 +1464,7 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
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


