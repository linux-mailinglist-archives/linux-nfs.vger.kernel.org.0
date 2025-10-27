Return-Path: <linux-nfs+bounces-15703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35FC0F1CC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 16:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3E0464E52
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878831280D;
	Mon, 27 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAHyjrDZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4531280B
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580004; cv=none; b=gvKIPfP9ZgSC/PZGt9kYoQ63PSsuQ741q+PNUncsCh4MTdl4rIBoTUr/YkFfPRrBeQKecKxnBgPU4Vxr3hu1pBTnv+g+R5vzYqA8PNPS8HWjY+MWlsTSZoAVeGbSrnnCLrLdc9cZgAMW64e4l02vOOoYU6eIDGTC39R4wYNT6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580004; c=relaxed/simple;
	bh=F00EZcyONm2bTtHF5bQQSpRQjMCQhruwVjHWUjRh1Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9min7hkYxvzTPrtFFmoP2gyHei6DkmCDX19c39nv2dyMOR3DWYpnUo5EUkbZxE8uGFEK3wn2u23TKy0deiwvxNZVjoGjf8A3O0RFoFGL4cnayBd9hQFiDAz/s/DkgGRUb5W9+orS04kMTcXuvi37KnpJJA3NZCX+n9EQsZmPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAHyjrDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B492FC4CEFF;
	Mon, 27 Oct 2025 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580004;
	bh=F00EZcyONm2bTtHF5bQQSpRQjMCQhruwVjHWUjRh1Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAHyjrDZTwId0tEAQRireG+NgqFvCIgmizFroyQZ/125l/FCeGlXvK2CbY87dkiJz
	 CanxPzvaD+YwVsRIepMAMBt6iIhHFi2RHVQoHRrvfV4n0nHAJdkuWUF7VHFhMrapq4
	 /LbOdrrFdByD1o0T4aRiXAw0wlm4Z9aXljTB4CaYHh5b2lcgduRhcrl2ThuzGwDpDG
	 4M+CSzbv8BWtpDrMqYAKc/yvj/2DlaVRVBs6gH3zxqStW1gEUfjDZsEcbRg7FiBw5K
	 36QzgB3Anyp5rXAbaoJTj05RLRWc3pgSDtkXalckBOkmPCwo0jgErpicrZM3jv35SF
	 CK+uwKNIvnS+Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 11/12] NFSD: Handle kiocb->ki_flags correctly
Date: Mon, 27 Oct 2025 11:46:29 -0400
Message-ID: <20251027154630.1774-12-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Christoph says:
> > +	if (file->f_op->fop_flags & FOP_DONTCACHE)
> > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> IOCB_DONTCACHE isn't defined for IOCB_DIRECT.  So this should
> move into a branch just for buffered I/O.

and

> > Promoting all NFSD_IO_DIRECT writes to FILE_SYNC was my idea,
> > based on the assumption that IOCB_DIRECT writes to local file
> > systems left nothing to be done by a later commit. My assumption
> > is based on the behavior of O_DIRECT on NFS files.
> >
> > If that assumption is not true, then I agree there is no
> > technical reason to promote NFSD_IO_DIRECT writes to FILE_SYNC,
> > and I can remove that built-in assumption for v8 of this series.
>
> It is not true, or rather only true for a tiny subset of use cases
> (which NFS can't even query a head of time).

So, observe the existing setting of ki_flags rather than forcing
persistence unconditionally, and ensure that DONTCACHE is not set
for IOCB_DIRECT writes.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index be0688f2ab3d..3c78b3aeea4b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1261,6 +1261,8 @@ struct nfsd_write_dio_seg {
 
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
+	int				flags_buffered;
+	int				flags_direct;
 	unsigned int			nsegs;
 	struct nfsd_write_dio_seg	segment[3];
 };
@@ -1396,33 +1398,25 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
 }
 
 static int
-nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp, u32 *stable_how,
-		     struct kiocb *kiocb, unsigned int nvecs, unsigned long *cnt,
-		     struct nfsd_write_dio_args *args)
+nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		     struct kiocb *kiocb, unsigned int nvecs,
+		     unsigned long *cnt, struct nfsd_write_dio_args *args)
 {
 	struct file *file = args->nf->nf_file;
 	ssize_t host_err;
 	unsigned int i;
 
-	/*
-	 * Any buffered IO issued here will be misaligned, use
-	 * sync IO to ensure it has completed before returning.
-	 * Also update @stable_how to avoid need for COMMIT.
-	 */
-	kiocb->ki_flags |= (IOCB_DSYNC|IOCB_SYNC);
-	*stable_how = NFS_FILE_SYNC;
-
 	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
 				  *cnt, args);
 
 	*cnt = 0;
 	for (i = 0; i < args->nsegs; i++) {
 		if (args->segment[i].use_dio) {
-			kiocb->ki_flags |= IOCB_DIRECT;
+			kiocb->ki_flags = args->flags_direct;
 			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
 						args->segment[i].iter.count);
 		} else
-			kiocb->ki_flags &= ~IOCB_DIRECT;
+			kiocb->ki_flags = args->flags_buffered;
 
 		host_err = vfs_iocb_iter_write(file, kiocb,
 					       &args->segment[i].iter);
@@ -1446,15 +1440,16 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	args.nf = nf;
 
 	/*
-	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
-	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
-	 * be ignored for any DIO issued here).
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
+	 * writing unaligned segments or handling fallback I/O.
 	 */
+	args.flags_buffered = kiocb->ki_flags;
 	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-		kiocb->ki_flags |= IOCB_DONTCACHE;
+		args.flags_buffered |= IOCB_DONTCACHE;
 
-	return nfsd_issue_dio_write(rqstp, fhp, stable_how, kiocb, nvecs,
-				    cnt, &args);
+	args.flags_direct = kiocb->ki_flags | IOCB_DIRECT;
+
+	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
 }
 
 /**
-- 
2.51.0


