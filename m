Return-Path: <linux-nfs+bounces-16077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52082C372DC
	for <lists+linux-nfs@lfdr.de>; Wed, 05 Nov 2025 18:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A9114F649D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Nov 2025 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC4F3385A6;
	Wed,  5 Nov 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFhz0E5n"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11E337BB2
	for <linux-nfs@vger.kernel.org>; Wed,  5 Nov 2025 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364533; cv=none; b=i0auOQv7jO22SE5TdMGT4KOHvHokcM7aa5RjKdTv0pOpCHcJdHK0gLluuoAWYErNCqjcrMGU3h+1p3rYS958gXin9SDWORGpEyWvesOVPc3QOT+BVF2aRKkzoHuXtbDLYymYONC0+0BknIaxmKN0wteK+/gmKkGZsG/8UHwjjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364533; c=relaxed/simple;
	bh=sO29klfv4yrZNsBr+TzQhiHDSOqLyH/H5lTJOpu4AMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaIuu4xqSA+4W9n4U0ixZ+pKqhSl4UjNtvFUR0UKs3UWSAHzDVLcfzaHSZo1FxDDPglhBqTeQcnXzHg26pe7G5g+b81JW3VvCj36gk5XmYI0Cq2kOg6mOIfBiRQ/nH8HtrJ9bcQqiHJk8wt8bhaENFS9kudTIUA1dIjPsesP/3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFhz0E5n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE474C4CEF8;
	Wed,  5 Nov 2025 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364533;
	bh=sO29klfv4yrZNsBr+TzQhiHDSOqLyH/H5lTJOpu4AMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFhz0E5nrHpZH+EAjxTdGd59N+6VRmexxfCobS+PtrWeY9kOUSgixJwvBGNEt0U3/
	 vr0CLSI7r5AcWm0gmg+CU31bwGnriLzjVw/9d/NSFLv2VMJuOqVEbGIodnePWF7PiK
	 YLEtUwqM98zMxK4zJ3b6zyPWF5+2KTWb8OzG2bi8qouORBJC2bWdwGNbfIXCC334Z1
	 2qJc4SYp2S+ucynAVnT1lVrSnJR50Wfy/Ml+nHdJgR3aw/I6l0iuOoM/oOITD9q+IE
	 XCsMrk6tkG3lj5+mXWzLg3F6mqSCks1JFC9DSlt0r/BtcDHU3fJcJXXCD0Vd9Yry+J
	 MSTmevEJES5pg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/3] NFSD: avoid DONTCACHE for misaligned ends of misaligned DIO WRITE
Date: Wed,  5 Nov 2025 12:42:08 -0500
Message-ID: <20251105174210.54023-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251105174210.54023-1-snitzer@kernel.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
performance if it uses buffered IO (without DONTCACHE) for the
misaligned end segment(s) and O_DIRECT for the aligned middle
segment's IO.

On one capable testbed, this commit improved streaming 47008 byte
write performance from 0.3433 GB/s to 1.26 GB/s.

This commit also merges nfsd_issue_dio_write into its only caller
(nfsd_direct_write).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 73 ++++++++++++++++++++++-----------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 701dd261c252..a4700c917c72 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1296,12 +1296,13 @@ nfsd_write_dio_seg_init(struct nfsd_write_dio_seg *segment,
 
 static void
 nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
-			  loff_t offset, unsigned long total,
+			  struct kiocb *kiocb, unsigned long total,
 			  struct nfsd_write_dio_args *args)
 {
 	u32 offset_align = args->nf->nf_dio_offset_align;
 	u32 mem_align = args->nf->nf_dio_mem_align;
 	loff_t prefix_end, orig_end, middle_end;
+	loff_t offset = kiocb->ki_pos;
 	size_t prefix, middle, suffix;
 
 	args->nsegs = 0;
@@ -1347,6 +1348,8 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 		++args->nsegs;
 	}
 
+	args->flags_buffered = kiocb->ki_flags;
+	args->flags_direct = kiocb->ki_flags | IOCB_DIRECT;
 	return;
 
 no_dio:
@@ -1354,39 +1357,14 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 	nfsd_write_dio_seg_init(&args->segment[0], bvec, nvecs, total,
 				0, total);
 	args->nsegs = 1;
-}
 
-static int
-nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
-		     struct kiocb *kiocb, unsigned int nvecs,
-		     unsigned long *cnt, struct nfsd_write_dio_args *args)
-{
-	struct file *file = args->nf->nf_file;
-	ssize_t host_err;
-	unsigned int i;
-
-	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb->ki_pos,
-				  *cnt, args);
-
-	*cnt = 0;
-	for (i = 0; i < args->nsegs; i++) {
-		if (args->segment[i].use_dio) {
-			kiocb->ki_flags = args->flags_direct;
-			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
-						args->segment[i].iter.count);
-		} else
-			kiocb->ki_flags = args->flags_buffered;
-
-		host_err = vfs_iocb_iter_write(file, kiocb,
-					       &args->segment[i].iter);
-		if (host_err < 0)
-			return host_err;
-		*cnt += host_err;
-		if (host_err < args->segment[i].iter.count)
-			break;	/* partial write */
-	}
-
-	return 0;
+	/*
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
+	 * falling back to buffered IO if the entire WRITE is unaligned.
+	 */
+	args->flags_buffered = kiocb->ki_flags;
+	if (args->nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
+		args->flags_buffered |= IOCB_DONTCACHE;
 }
 
 static noinline_for_stack int
@@ -1395,20 +1373,31 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  unsigned long *cnt, struct kiocb *kiocb)
 {
 	struct nfsd_write_dio_args args;
+	ssize_t host_err;
+	unsigned int i;
 
 	args.nf = nf;
+	nfsd_write_dio_iters_init(rqstp->rq_bvec, nvecs, kiocb, *cnt, &args);
 
-	/*
-	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
-	 * writing unaligned segments or handling fallback I/O.
-	 */
-	args.flags_buffered = kiocb->ki_flags;
-	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-		args.flags_buffered |= IOCB_DONTCACHE;
+	*cnt = 0;
+	for (i = 0; i < args.nsegs; i++) {
+		if (args.segment[i].use_dio) {
+			kiocb->ki_flags = args.flags_direct;
+			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
+						args.segment[i].iter.count);
+		} else
+			kiocb->ki_flags = args.flags_buffered;
 
-	args.flags_direct = kiocb->ki_flags | IOCB_DIRECT;
+		host_err = vfs_iocb_iter_write(nf->nf_file, kiocb,
+					       &args.segment[i].iter);
+		if (host_err < 0)
+			return host_err;
+		*cnt += host_err;
+		if (host_err < args.segment[i].iter.count)
+			break;	/* partial write */
+	}
 
-	return nfsd_issue_dio_write(rqstp, fhp, kiocb, nvecs, cnt, &args);
+	return 0;
 }
 
 /**
-- 
2.44.0


