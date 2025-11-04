Return-Path: <linux-nfs+bounces-16013-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE58C321C4
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1178C3B5B91
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 16:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05371335082;
	Tue,  4 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0NnlbiR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2881334C22
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274552; cv=none; b=DbKaOUnObIYvsd/xFyIjdlK2PUW08gwW9j2MNZtnfYTNCLGhXLmnq23Yxl42iJhwP+JV8/fF4IJAluBGpCnzDRBe/tgRrxyemtCA8uf7r+emdD1E8ncq+kB4Jc86Be8YIbyCdPH4qHGsirK13Izx+Lur+DvdxWFyS7EJtYmMjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274552; c=relaxed/simple;
	bh=PZ+qALRA07lZ3KEt+2YJEpgt+mPWC+A8c7BR/OxGjno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjQwUPYJM6b+307TjigHW03yGo/hZK6S1mhhyFw5w1brh0zCFDwX0h8w9Gr7PYrLGhIuDWaKTcWkZLWRTuVUhhugd+HaMvhNwf0EMU6gs4Shzdi4kZ5jyZtB7uSqHVSyLnx7cGhGLQ2zr9pZUuoQMQ080H4zHJTimxym4zz5RMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0NnlbiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D0C4CEF7;
	Tue,  4 Nov 2025 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762274551;
	bh=PZ+qALRA07lZ3KEt+2YJEpgt+mPWC+A8c7BR/OxGjno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0NnlbiRuxcz/P/U6sUby994yBLUt7gmrff43pBOtMqOOPhhWkrQNSixcK3L543OW
	 jkoJxdGn1BHGgu1y5w2JupMXrk/xNUR9bynyL1kkVqNsI9ocCMrTeGOU+WiwRJNJcv
	 fAS8hja4qG0mX27+zG8BQZvS0+2AEy1zpkYgma5hV0F92Lgp7CIdX8DD6Ysl6JK22S
	 tUNdumPNP19bkJh5zT1IqfhqzfbBzJSiLRt38mpDLtsZvqdOqtYqX2Lq4KOdJ0I5Q7
	 KmLalbc0mBrm1LdhKSZ7yafPR01xhFGkyweaISVdbY4b6LWfhWLOrtha7VsdC4zUdl
	 7QLdxqh6JjeLA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] nfsd: avoid using DONTCACHE for misaligned DIO's buffered IO fallback
Date: Tue,  4 Nov 2025 11:42:27 -0500
Message-ID: <20251104164229.43259-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20251104164229.43259-1-snitzer@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, use buffered IO (without DONTCACHE) if READ is less than 32K.
But do use DONTCACHE if an entire WRITE is misaligned, this preserves
intent of NFSD_IO_DIRECT.

The misaligned ends of a misaligned DIO WRITE will use buffered IO
(without DONTCACHE) but the middle DIO-aligned segment with use direct
IO.  This provides ideal performance for streaming misaligned DIO
(e.g. IO500's IOR_HARD) because buffered IO is used to benefit RMW.

On one capable testbed, this commit improved IOR_HARD WRITE
performance from 0.3433GB/s to 1.26GB/s.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/vfs.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 701dd261c252..9403ec8bb2da 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -104,6 +104,7 @@ nfserrno (int errno)
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
 		{ nfserr_io, -EBADMSG },
+		{ nfserr_eagain, -ENOTBLK },
 	};
 	int	i;
 
@@ -1099,13 +1100,18 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	size_t len;
 
 	init_sync_kiocb(&kiocb, nf->nf_file);
-	kiocb.ki_flags |= IOCB_DIRECT;
 
 	/* Read a properly-aligned region of bytes into rq_bvec */
 	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
 	dio_end = round_up((u64)offset + *count, nf->nf_dio_read_offset_align);
 
+	/* Don't use expanded DIO READ for IO less than 32K */
+	if ((*count < (32 << 10)) &&
+	    (((offset - dio_start) > 0) || ((dio_end - (offset + *count)) > 0)))
+		return nfserrno(-ENOTBLK); /* fallback to buffered */
+
 	kiocb.ki_pos = dio_start;
+	kiocb.ki_flags |= IOCB_DIRECT;
 
 	v = 0;
 	total = dio_end - dio_start;
@@ -1184,10 +1190,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		break;
 	case NFSD_IO_DIRECT:
 		/* When dio_read_offset_align is zero, dio is not supported */
-		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len)
-			return nfsd_direct_read(rqstp, fhp, nf, offset,
+		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len) {
+			__be32 nfserr = nfsd_direct_read(rqstp, fhp, nf, offset,
 						count, eof);
-		fallthrough;
+			if (nfserr != nfserr_eagain)
+				return nfserr;
+		}
+		break; /* fallback to buffered */
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags = IOCB_DONTCACHE;
@@ -1347,6 +1356,15 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 		++args->nsegs;
 	}
 
+	/*
+	 * Don't use IOCB_DONTCACHE if misaligned DIO WRITE (args->nsegs > 1),
+	 * because it compromises unaligned segments' RMW IO being able to
+	 * benefit from buffered IO (especially important for streaming
+	 * misaligned DIO WRITE performance).
+	 */
+	if (args->nsegs > 1 && (args->flags_buffered & IOCB_DONTCACHE))
+		args->flags_buffered &= ~IOCB_DONTCACHE;
+
 	return;
 
 no_dio:
@@ -1400,7 +1418,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/*
 	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
-	 * writing unaligned segments or handling fallback I/O.
+	 * falling back to buffered IO if entire WRITE is unaligned.
 	 */
 	args.flags_buffered = kiocb->ki_flags;
 	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-- 
2.44.0


