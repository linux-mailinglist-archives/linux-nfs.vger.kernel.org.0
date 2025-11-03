Return-Path: <linux-nfs+bounces-15944-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B4C2D4FF
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434483B224D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0663531A7F4;
	Mon,  3 Nov 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zi2x2VBg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67423195EC
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188843; cv=none; b=tNgksYBA+RZ+Efxw4GvJhINpzEflj1bnJ4vabTPOgTIXJrptNuQxOniqAJ12IRJEDQ1TDFFT4qIt7PJxBMkZi7cKHSRF4jAyJUd3nXoJQEl8nQc660g1y+kUqf6NabcS+UiCkLB6puA45DuL9JnOcW6w8zWHShpGfWtihs4yahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188843; c=relaxed/simple;
	bh=GZDT5CfCPf3m5+vDjhazTAVVQ2TLvZZxIDaU4z74Zxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DiNuAULrwDY992/NC1AC+1/h73Qhh4WaxlY/QVbArdlUDVWZ7jMybwCvP4nWCQBwiTsRoB9DfMTz9mWu6IdatuB+Wr54vClHrjH6Q5RfmGYXjKOFx/GLOCXNyEyXJ33JMG3lw7LyHxUD4lISWow15IwgsYsKkyvBXBL9U0lG8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zi2x2VBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CA9C4CEE7;
	Mon,  3 Nov 2025 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188843;
	bh=GZDT5CfCPf3m5+vDjhazTAVVQ2TLvZZxIDaU4z74Zxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zi2x2VBg7VWUqUHsN8hHkBcXxemGf5C7zjWy6hs4CcPLwehy9fPRub2ILJJiaqmx2
	 ycsdrFlAdhMVwKl5SBZ7rGHQfs4xzLuarKo6WK2VWhC2VdE1ttfZC5xJn/afZv0z+A
	 qVuU2qvagU52+yrNqRjmfqB8a536y/o6th4wm0HrLNlkDiLmKVIspgNizZWYaQBN9Y
	 1nvKZA/wZWKpwE8rlaTaq+q6/qz4WRsEUKaswIfQwzthbZ9YYeY2PI8uw/8HlXAeda
	 vPvB/xkRJLPosIfjfS0zSzula1f/U7X8wn0sinccpK5aXWLnKUy1auPLfJrlPNk+Vy
	 gxppFKItnvJZQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 10/12] NFSD: Handle kiocb->ki_flags correctly
Date: Mon,  3 Nov 2025 11:53:49 -0500
Message-ID: <20251103165351.10261-11-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1b1173de4f78..0e5e82b286f1 100644
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
@@ -1373,33 +1375,25 @@ nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
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
@@ -1423,15 +1417,16 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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


