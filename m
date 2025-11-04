Return-Path: <linux-nfs+bounces-16026-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC3C32949
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C958F18900F8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D47341656;
	Tue,  4 Nov 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2Kt/XCe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCE341650
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279916; cv=none; b=CWwwfW1zEmDkcBEGAca3QDGvOXSBvfQIc4XB22cywb752zroPelkIhkwf2Puj5ZpTK7vUqh3BrnPmQgb0DOB5HL1pn8ngPRvLhTfPS6R4wTuE02ZyRvoiIwHl3U/1a4x1xbnRUaIGFTNYA1PU5O9fXlvQbw1eroEStP7MPdSqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279916; c=relaxed/simple;
	bh=Lslt3GipZ4ptIMDI8vVjVbXCAj6R0orrK5Cdkg4b4Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTjBjyj0IKtl0KOOq36a7HPwXd5XlMjyqh1VaZtfDoJJXQ+XrG9MATDmLPbWfMzCsQpkATNgbYNVoMOky2JkvnytT347kXNGYys4dh99IV4DWQ4n+LdWRdHGDQsdMSIPxzWvkbv59FZvoryQoGyiXNKBhcWqQV7hurqtumxesig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2Kt/XCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504C2C19424;
	Tue,  4 Nov 2025 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279915;
	bh=Lslt3GipZ4ptIMDI8vVjVbXCAj6R0orrK5Cdkg4b4Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2Kt/XCet5PB0jXNsOgMWuktCbDOnLxjnRrHZ8L9NNQmtbFTJSIlSb5Kw3hQBBG+x
	 cw0MAcJaZhQ9amNPxqH9MNhRgmCgk9VCWoa+iqAI29qS53cl191XszVEPxNP9/GE3i
	 iM43b77+jaaQ3AoBFjNJhXV0jc4yGKpTNzlUtHDDiI1OylGYwxsZ1nEb0I2s3NHpoj
	 mZpqScwj/EZBdbCJ6zfM3QAIJgRjvKr+4xnrW+CXn7bzH7rHcxmIcdMtzy69ntZUHY
	 JVUpRsAz2f0lG0gZBG447mP6SLcIe6uYFMINkesFW7Sz2FDqIgMEr2LkZyQwTUKnsQ
	 rBycRF4yywOhA==
Date: Tue, 4 Nov 2025 13:11:54 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/3] nfsd: avoid using DONTCACHE for misaligned DIO's
 buffered IO fallback
Message-ID: <aQpB6olvU-feiunt@kernel.org>
References: <20251104164229.43259-1-snitzer@kernel.org>
 <20251104164229.43259-2-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104164229.43259-2-snitzer@kernel.org>

Also, use buffered IO (without DONTCACHE) if READ is less than 32K.
But do use DONTCACHE if an entire WRITE is misaligned, this preserves
intent of NFSD_IO_DIRECT.

The misaligned ends of a misaligned DIO WRITE will use buffered IO
(without DONTCACHE) but the middle DIO-aligned segment with use direct
IO.  This provides ideal performance for streaming misaligned DIO
(e.g. IO500's IOR_HARD) because buffered IO is used to benefit RMW.

On one capable testbed, this commit improved IOR_HARD WRITE
performance from 0.3433GB/s to 1.26GB/s.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

v2: don't use nfserrno(), just return nfserr_eagain directly from nfsd_direct_read

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 701dd261c252..a87ee9736d66 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1099,13 +1099,18 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	size_t len;
 
 	init_sync_kiocb(&kiocb, nf->nf_file);
-	kiocb.ki_flags |= IOCB_DIRECT;
 
 	/* Read a properly-aligned region of bytes into rq_bvec */
 	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
 	dio_end = round_up((u64)offset + *count, nf->nf_dio_read_offset_align);
 
+	/* Don't use expanded DIO READ for IO less than 32K */
+	if ((*count < (32 << 10)) &&
+	    (((offset - dio_start) > 0) || ((dio_end - (offset + *count)) > 0)))
+		return nfserr_eagain; /* fallback to buffered */
+
 	kiocb.ki_pos = dio_start;
+	kiocb.ki_flags |= IOCB_DIRECT;
 
 	v = 0;
 	total = dio_end - dio_start;
@@ -1184,10 +1189,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		break;
 	case NFSD_IO_DIRECT:
 		/* When dio_read_offset_align is zero, dio is not supported */
-		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len)
-			return nfsd_direct_read(rqstp, fhp, nf, offset,
-						count, eof);
-		fallthrough;
+		if (nf->nf_dio_read_offset_align && !rqstp->rq_res.page_len) {
+			__be32 nfserr = nfsd_direct_read(rqstp, fhp, nf, offset,
+							 count, eof);
+			if (nfserr != nfserr_eagain)
+				return nfserr;
+		}
+		break; /* fallback to buffered */
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags = IOCB_DONTCACHE;
@@ -1347,6 +1355,15 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
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
@@ -1400,7 +1417,7 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	/*
 	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT when
-	 * writing unaligned segments or handling fallback I/O.
+	 * falling back to buffered IO if entire WRITE is unaligned.
 	 */
 	args.flags_buffered = kiocb->ki_flags;
 	if (args.nf->nf_file->f_op->fop_flags & FOP_DONTCACHE)
-- 
2.44.0


