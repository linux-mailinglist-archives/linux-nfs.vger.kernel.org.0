Return-Path: <linux-nfs+bounces-11563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6AAADDD5
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311A47A886E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 11:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF1221F13;
	Wed,  7 May 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3eMDaQt7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC9257441
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618990; cv=none; b=HeQXeOmEUviHXodP4dGqQXgi0q8pT5eYvUw7QIQ864Q+zvdsmZONUHceLA1oiBQmAlSsRDm1dz7E812IsDetgEtHXyXnqc8gqtZ4touqR9eI0MY9zM6BgMa0D4aNxZ4ZL50noSJOLqpFGo7wlTUJcqq0X+6dz1Try7UjTeOrFdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618990; c=relaxed/simple;
	bh=Tq9bWRnW+U1cnpjkLku4wdyb/zuMLenILzX+sXqzioA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQd/KdhWlnxbgnKsNmVPP1ZnJBu0M5CJl9AI1Eo4pmymvK2pm9mwJ3S3do5voPJx780xAVjvEQdjWGA1b5qNXblVGUrX7flSQb18VDQRQQDkcH4YJkyb8OIhWbVBzGOdb5egYH4yrPSqSuPf980CPpiSa70mFKcbbS/8pvVQ1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3eMDaQt7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dJ0CgcFCXROq5w7z90QBAUNEY9IUhbXHusV+lrIpxMU=; b=3eMDaQt75efU8qJIljSIkjvagx
	TR5QyNgczos7RforrTxJZWhc7QThyUv1t0atU6/y+oPvZp5S01pNLw3T7QWGW+zUSX7nXZmz3KrAI
	4eW0m9nRlRp8dGZ4yIbkxkiH2E77Dw9Uxhz6sbczh+Iqedd/yvpoJ0J/HRNWxbhFTbFcmT5CJeCJC
	oUqA42IbkfzR3AUT80aHOdxjBlXdHLEjOLPJNMKZgRk4lfOGbXxXhtlSWZ3iXsVjB4+kk6cgxRF39
	suA1fUmOR1M+mGYiayXyCsFrQBFvTlhyrUX9cqAPLXEURt+wK4oVpQhIoxh2pqm7tGtjJ5WDiJZwr
	B0CBCZ6g==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdNx-0000000FHn5-362U;
	Wed, 07 May 2025 11:56:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfsd: call svc_fill_write_vector from nfsd_vfs_write
Date: Wed,  7 May 2025 13:55:50 +0200
Message-ID: <20250507115617.3995150-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507115617.3995150-1-hch@lst.de>
References: <20250507115617.3995150-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Creating the kvec is always done so that nfsd_vfs_write can use them.
Move the call there Instead of doing it in the first and second degree
callers, which just makes the code more complicated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/nfs3proc.c |  5 +----
 fs/nfsd/nfs4proc.c |  7 +------
 fs/nfsd/nfsproc.c  |  7 ++-----
 fs/nfsd/vfs.c      | 18 +++++++++++-------
 fs/nfsd/vfs.h      |  4 ++--
 5 files changed, 17 insertions(+), 24 deletions(-)

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
index b397246dae7b..2b814fc4c8cc 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1211,7 +1211,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_file *nf = NULL;
 	__be32 status = nfs_ok;
 	unsigned long cnt;
-	int nvecs;
 
 	if (write->wr_offset > (u64)OFFSET_MAX ||
 	    write->wr_offset + write->wr_buflen > (u64)OFFSET_MAX)
@@ -1226,12 +1225,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return status;
 
 	write->wr_how_written = write->wr_stable_how;
-
-	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
-	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
-
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
-				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
+				write->wr_offset, &write->wr_payload, &cnt,
 				write->wr_how_written,
 				(__be32 *)write->wr_verifier.data);
 	nfsd_file_put(nf);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..b4520b6fd9ee 100644
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
 	resp->status = nfsd_write(rqstp, fh_copy(&resp->fh, &argp->fh),
-				  argp->offset, rqstp->rq_vec, nvecs,
-				  &cnt, NFS_DATA_SYNC, NULL);
+				  argp->offset, &argp->payload, &cnt,
+				  NFS_DATA_SYNC, NULL);
 	if (resp->status == nfs_ok)
 		resp->status = fh_getattr(&resp->fh, &resp->stat);
 	else if (resp->status == nfserr_jukebox)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9abdc4b75813..da62082d06dc 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1141,9 +1141,8 @@ static int wait_for_concurrent_writes(struct file *file)
 
 __be32
 nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
-				loff_t offset, struct kvec *vec, int vlen,
-				unsigned long *cnt, int stable,
-				__be32 *verf)
+		loff_t offset, struct xdr_buf *payload, unsigned long *cnt,
+		int stable, __be32 *verf)
 {
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
@@ -1158,9 +1157,14 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
 	bool			restore_flags = false;
+	unsigned int		nvecs;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
+	nvecs = svc_fill_write_vector(rqstp, payload);
+	if (WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec)))
+		return -EIO;
+
 	if (sb->s_export_op)
 		exp_op_flags = sb->s_export_op->flags;
 
@@ -1185,7 +1189,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, vec, vlen, *cnt);
+	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
@@ -1290,7 +1294,7 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
  */
 __be32
 nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
-	   struct kvec *vec, int vlen, unsigned long *cnt, int stable,
+	   struct xdr_buf *payload, unsigned long *cnt, int stable,
 	   __be32 *verf)
 {
 	struct nfsd_file *nf;
@@ -1302,8 +1306,8 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 	if (err)
 		goto out;
 
-	err = nfsd_vfs_write(rqstp, fhp, nf, offset, vec,
-			vlen, cnt, stable, verf);
+	err = nfsd_vfs_write(rqstp, fhp, nf, offset, payload, cnt, stable,
+			verf);
 	nfsd_file_put(nf);
 out:
 	trace_nfsd_write_done(rqstp, fhp, offset, *cnt);
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index f9b09b842856..97c509e0d170 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -129,11 +129,11 @@ __be32		nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				loff_t offset, unsigned long *count,
 				u32 *eof);
 __be32 		nfsd_write(struct svc_rqst *, struct svc_fh *, loff_t,
-				struct kvec *, int, unsigned long *,
+				struct xdr_buf *payload, unsigned long *cnt,
 				int stable, __be32 *verf);
 __be32		nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				struct nfsd_file *nf, loff_t offset,
-				struct kvec *vec, int vlen, unsigned long *cnt,
+				struct xdr_buf *payload, unsigned long *cnt,
 				int stable, __be32 *verf);
 __be32		nfsd_readlink(struct svc_rqst *, struct svc_fh *,
 				char *, int *);
-- 
2.47.2


