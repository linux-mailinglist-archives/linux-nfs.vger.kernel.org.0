Return-Path: <linux-nfs+bounces-13959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 626FDB3CE45
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 19:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D0D2067F8
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Aug 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684CA2D6406;
	Sat, 30 Aug 2025 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7NowBou"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B05274668
	for <linux-nfs@vger.kernel.org>; Sat, 30 Aug 2025 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575537; cv=none; b=gxxjF3SNn8702Y5QUT+iaSLY8qnRhgBMWzY6CDYGab/HpVsl3xpeC3nJpbGyszRi/peoDYFDfsTr896ilvIuoaeWIStk0+y1UlIksjcR3KLUlTeC+kXkqj8YvZiqe5OQ87/Wk4kl5BJUoQL3PY2dMKDjnmNIxAOOBzQj2wp3Hc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575537; c=relaxed/simple;
	bh=L/JMD+bDKF66EUEKh28Z+l5O6h/igxLzwtqwrjcOUc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP7P3zyXILnTjYiZvwx6rPWV0cj71+OikbR2xlrqhK2zJ9Y2QVXypi0BIKZc7IP+5MJyWC7QCclZOSdROGRz1VGup+sXKoVRm04ZuCMiGRt1vPCplZikkx9u6J3Ul+ef6x0kv1Xmv9veJMFGkElIn8I7tZd5bVpDIpX3g9zpZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7NowBou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD74C4CEEB;
	Sat, 30 Aug 2025 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756575536;
	bh=L/JMD+bDKF66EUEKh28Z+l5O6h/igxLzwtqwrjcOUc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7NowBoudDE0DUtdOhTPqYvJSgwdUC2Ajzx1XSwk+asVQRBvROu6q7FXsM6Z2Hueq
	 78Utz+s/Q5nu1XzN4GY6R/P1Kw2pbLMRGNsWpz+37HD4SMNum2Ob+B5GsFyiFTYPe1
	 cCZmk0T2mY5McfBNyEGOSo9GOdnxE6QD2KxqCXi21iAoY4fMesQ5vbB5l43RDLbAla
	 Id2V7Z493fW+G8cFveZLVlIbMOuWZ9IdNfWViotIMW9ZFDlNxYsYdbtnGe5AfwXJ8t
	 GfZdEo8vch064nA+2j+dTHr1e60qtnsogWdSU7fsdAS3USLyO0HxGX27jWuEKRyfUS
	 hFA5W3GcvqDNQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/2] NFSD: use /end/ of rq_pages for front_pad page, simpler workaround for rpcrdma bug
Date: Sat, 30 Aug 2025 13:38:52 -0400
Message-ID: <20250830173852.26953-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250830173852.26953-1-snitzer@kernel.org>
References: <aLClcl08x4JJ1UJu@kernel.org>
 <20250830173852.26953-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

This patch also papers over what seems like an rpcrdma bug, and
Chuck Lever also clarified that this too shouldn't be needed:

    "Yes, the extra page needs to come from rq_pages. But I don't see why it
    should come from the /end/ of rq_pages."

But this patch at least isolates the same bug further? (by showing
that the bounds expressed in rqstp->rq_bvec[] don't cause manipulation
what READ payload memory is returned to the NFS RDMA client?)

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 762d745b1b15d..70571a78e7c25 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1263,7 +1263,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			if (read_dio.start_extra) {
 				len = read_dio.start_extra;
 				bvec_set_page(&rqstp->rq_bvec[v],
-					      *(rqstp->rq_next_page++),
+					      NULL, /* adjusted below */
 					      len, PAGE_SIZE - len);
 				total -= len;
 				++v;
@@ -1289,6 +1289,8 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		base = 0;
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
+	if ((kiocb.ki_flags & IOCB_DIRECT) && read_dio.start_extra)
+		rqstp->rq_bvec[0].bv_page = *(rqstp->rq_next_page++);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
-- 
2.44.0


