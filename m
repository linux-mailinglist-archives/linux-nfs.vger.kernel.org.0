Return-Path: <linux-nfs+bounces-15598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D2C06C1D
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B73B4AC8
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A17831B123;
	Fri, 24 Oct 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh+1ozTE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E1031D727
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317000; cv=none; b=sNobWiaGzWd6QCSgYpD+ntlPrrAYJOZ+jHKO3iS2IsNMmzOqqq/VCO+KdZVX0UF/VOlZnAy0IqafPSTB7hGXCH7PE05twtMg7Drt4lNGJXCDblnKLEfNhOYyq/l8Kvqc1hwqRn6jujUAESC1yaEHvoIaC+WJzHXqEWeAPVUtauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317000; c=relaxed/simple;
	bh=UYYPY912ovgj9y0/KfwmblqjDfSGcx5wjihyn8YEru0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epsZptHBnUA0c1iDRnXmc6iNuW/pTxqxZDVWDPTXb1cAouUOny/hCB0jHbuwal6OIXtNdnRBcfjXwcRlTFzQrHkCIsFV2E3NACkUvCu14sLn7Lv84Chc8IToJ779V5TI/EXTpqkEX/4wLy8YR3Kr/i5fATOiAyWYfa5ltrnkt4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh+1ozTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5752CC4CEF1;
	Fri, 24 Oct 2025 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761317000;
	bh=UYYPY912ovgj9y0/KfwmblqjDfSGcx5wjihyn8YEru0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eh+1ozTEpFyQFewzK6dT27A0PXQ8A1V99PdBiBHvQqA3STpdZbHyZb77zxR3de8ae
	 Ps07VySaH05jFr7dRTX20RlmTXzWLjmz9Gm0q9fpbJusM/DpEC985GiQpfOPMLgZkM
	 XMlpfBVy7uFTEkL7PnZVmflkswAt3BHuwYVQDql+UeMODX0Tzaiwf2hWVM6dqcsNtP
	 yTAhzhgVDBSxD230Xy49Id9/KrDC+mycm1k+/3MycIoXxF0+kzHX/g0AQ08fKss61V
	 nfVcJWkJt5IfVDaDrHf2a66HEvLPxB17z3XTEXzsCbPzQgqrWxo/zaFMzq9tdF2bIn
	 Q+NXzYTXz5SLA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Date: Fri, 24 Oct 2025 10:43:06 -0400
Message-ID: <20251024144306.35652-15-cel@kernel.org>
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

Christoph says:
> > +	if (file->f_op->fop_flags & FOP_DONTCACHE)
> > +		kiocb->ki_flags |= IOCB_DONTCACHE;
> IOCB_DONTCACHE isn't defined for IOCB_DIRECT.  So this should
> move into a branch just for buffered I/O.

Instead, let's set up separate ki_flags for buffered I/O and for
direct I/O requests. Then we don't have to set a jumble of flag
bits in a single flags field.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b0e4105e0075..b7b9f8cf0452 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1262,6 +1262,8 @@ struct nfsd_write_dio_seg {
 
 struct nfsd_write_dio_args {
 	struct nfsd_file		*nf;
+	int				flags_buffered;
+	int				flags_direct;
 	struct nfsd_write_dio_seg	segment[3];
 };
 
@@ -1379,11 +1381,11 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		if (segment->len == 0)
 			continue;
 		if (segment->use_dio) {
-			kiocb->ki_flags |= IOCB_DIRECT;
+			kiocb->ki_flags = args->flags_direct;
 			trace_nfsd_write_direct(rqstp, fhp, kiocb->ki_pos,
 						segment->len);
 		} else
-			kiocb->ki_flags &= ~IOCB_DIRECT;
+			kiocb->ki_flags = args->flags_buffered;
 		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
 		if (host_err < 0)
 			return host_err;
@@ -1405,30 +1407,27 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct nfsd_write_dio_args args;
 
 	/*
-	 * Check if IOCB_DONTCACHE can be used when issuing buffered IO;
-	 * if so, set it to preserve intent of NFSD_IO_DIRECT (it will
-	 * be ignored for any DIO issued here).
+	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
+	 * writing unaligned segments or handling fallback I/O.
 	 */
+	args.flags_buffered = kiocb->ki_flags | IOCB_SYNC | IOCB_DSYNC;
 	if (file->f_op->fop_flags & FOP_DONTCACHE)
-		kiocb->ki_flags |= IOCB_DONTCACHE;
+		args.flags_buffered |= IOCB_DONTCACHE;
 
 	/*
-	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
-	 * both written data and dirty time stamps.
-	 *
-	 * When falling back to buffered I/O or handling the unaligned
-	 * first and last segments, the data and time stamps must be
-	 * durable before nfsd_vfs_write() returns to its caller, matching
-	 * the behavior of direct I/O.
+	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
+	 * persist both written data and dirty time stamps.
 	 */
-	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
+	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;
 
 	args.nf = nf;
 	if (!nfsd_is_write_dio_possible(&args, kiocb->ki_pos, *cnt) ||
-	    !nfsd_setup_write_dio_iters(&args, rqstp->rq_bvec, nvecs, *cnt))
+	    !nfsd_setup_write_dio_iters(&args, rqstp->rq_bvec, nvecs, *cnt)) {
 		/* fall back to writing through the page cache */
+		kiocb->ki_flags = args.flags_buffered;
 		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
 				       cnt, kiocb);
+	}
 
 	return nfsd_issue_write_dio(rqstp, fhp, &args, kiocb, nvecs, cnt);
 }
-- 
2.51.0


