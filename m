Return-Path: <linux-nfs+bounces-14306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE42B53D00
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0771CC2181
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Sep 2025 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE6621D5AA;
	Thu, 11 Sep 2025 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFVaXwWB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE4B672
	for <linux-nfs@vger.kernel.org>; Thu, 11 Sep 2025 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621941; cv=none; b=Mh6PZD4AHuvXpkEDYlorMD0INu6us3SkuVcPjL//Rouuv9/5glkTnJIoFF0lNvnxI+fi4RPfAQRlG6MeXRNpduOa2pSgRSKOoP0SyMowT2FSY+GwcRlb/7WgIzgGXhapxvwnPbgzM5ALD17Jz2XBjVzkXwBGO4XeWTSmxfqzsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621941; c=relaxed/simple;
	bh=qaeM4/MOFJVUdlmmrAb3sSBH291/G9haa8zMhbBHtsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E34Pr7fNQGLuM6Pm2Ynn0xziKfnWO5dFOCV7E1njxe+URNUfZK4T0Sk1mA8APY+A+LKIjxOjTppkraxJg6WVmsF48yzeK7g+Rz7Oo2QKLfvPOEfT7PtM+xjShb2u6TZeeA42Z2gfeU5MjLGFKAKuqfFv1w/Y1NkaKuZ0b2m/6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFVaXwWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9A1C4CEF0;
	Thu, 11 Sep 2025 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757621940;
	bh=qaeM4/MOFJVUdlmmrAb3sSBH291/G9haa8zMhbBHtsc=;
	h=From:To:Cc:Subject:Date:From;
	b=nFVaXwWBMDg7Y+Lf8tu7d7Tt0yqTT22jgbJp5x+CRYLFuhahRV4TKfXQfIAYivMFa
	 GLi2KfM6/t4AUz5BKyz6e4GGY3pLbAU2N8T0N5ypp5NB4o3Xat2i7+IMeX1I/6OlnC
	 ivIsWgGZLBetLzHIYCYHO7zRauJmnT5PsqU8JVL3lV/ha2R5tUIvps4ZkXxYpEjhRq
	 in9MJezA1CxrssoN9DuMyUCj/rRcXShgMembMmrGL7OjyO81r+Rd6kx9+bglFXfCx6
	 /DV49ebc4hVohrnTviWaCHv1I/Uy5fjru7jFDvxAoWLsvzM+wCg/UQwI7GEcWxaQBE
	 8/PkqtsuP27GQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH] NFSD: Remove WARN_ON_ONCE in nfsd_iter_read()
Date: Thu, 11 Sep 2025 16:18:58 -0400
Message-ID: <20250911201858.1630-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The *count parameter does not appear to be explicitly restricted
to being smaller than rsize, so it might be possible to overrun
the rq_bvec array.

Rather than overrunning the array (damage done!) and then WARNING
once, let's harden the loop so that it terminates before the end of
rq_bvec. This should result in a short read, which is OK (clients
recover by sending additional READ requests for the remaining unread
bytes).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

There might be a similar issue with rq_next_page in this loop?

Suppose that nfsd4_encode_readv() encounters a second READ operation
in a COMPOUND, and the two READ operations together comprise more
than "rsize" total bytes of payload. Each rq_bvec is under the page
limit, but the total number of pages consumed from rq_pages might
exceed rq_maxpages.

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 714777c221ed..e2f0fe3f82c0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1120,13 +1120,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
 			      len, base);
 		total -= len;
-		++v;
 		base = 0;
+		if (++v >= rqstp->rq_maxpages)
+			break;
 	}
-	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
 	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
-- 
2.50.0


