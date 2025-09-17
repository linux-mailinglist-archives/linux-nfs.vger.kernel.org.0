Return-Path: <linux-nfs+bounces-14511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9EB80077
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9652D2A2472
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Sep 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57C2EC099;
	Wed, 17 Sep 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJG8fhD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178982EB5D1
	for <linux-nfs@vger.kernel.org>; Wed, 17 Sep 2025 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119502; cv=none; b=Xpuat7wBj4D+hWsZnYa3ukmlN+1gcFTCxOMpRyM4ouM+4MsK2pjxwpdcmYqqfBGmjegzrnLJqXhWHvekeWG+RjEdotGzt6Q+IM5Nn+HVGwTu2hEFKyJHo4UMc3tdDeOudjDG6v4rdnRly3JOL+MvogaC/OtL8XBaYSgxzXjfEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119502; c=relaxed/simple;
	bh=XCRHaMrNLH8BjD2I2p2oUZ3EL3erflpHobJ2eD+Q+Fg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYWmMHoV5ROFqzR/tWEG8iou9c2hfrJYAdic/EhH8Ck3Hx9qYw8G+icjlXmlANseaurrrfbqKkju+M3/qcFIWLtJJdkI2nayzisR9boEFpGLgogYVNGPxHK6Z7ICBPMjOg1wKIFbxMtQBqTFxcnzv1ZPcPgk7m57zRvKHA5+a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJG8fhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77265C4CEE7;
	Wed, 17 Sep 2025 14:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758119502;
	bh=XCRHaMrNLH8BjD2I2p2oUZ3EL3erflpHobJ2eD+Q+Fg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UxJG8fhD2e0GHXnzPHyqiYPmC+c/KnvnwjOPYbG2CGZ1oAhtnWt86RBqs9H/N10N2
	 MwtUeNqZluca419QNn1LbO7tDTuSkRh8WwA4/Sx3t0Ng5rJ2j9cna88t3xUMA1H4es
	 aCafdWI8SFXrWRFvWpURTNnzMvS/Ezaf69Why9WGRr8q20nqbX8MtwwMprOlfI+m0c
	 Ut/9lvaswrkjJgffYkI2PL26nv+sxIA/LVvRYdUdIuEiNDIvsD8nfh3KMifOUgD6eH
	 lYRvCkVuaIELogdi/K6KhAJxmlTmhf9WOz9u/cHkj6i7NWl2dLjnwZoK15B3I/x1MG
	 QGeZKkeMX/ENw==
Subject: [PATCH v2 1/4] NFSD: Add array bounds-checking in nfsd_iter_read()
From: Chuck Lever <cel@kernel.org>
To: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
 dai.ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Date: Wed, 17 Sep 2025 10:31:40 -0400
Message-ID: 
 <175811950060.19474.9133241842109562565.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: 
 <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
References: 
 <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

The *count parameter does not appear to be explicitly restricted
to being smaller than rsize, so it might be possible to overrun
the rq_bvec or rq_pages arrays.

Rather than overrunning these arrays (damage done!) and then WARNING
once, let's harden the loop so that it terminates before the end of
the arrays are reached. This should result in a short read, which is
OK -- clients recover by sending additional READ requests for the
remaining unread bytes.

Reported-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 714777c221ed..2026431500ec 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1115,18 +1115,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v = 0;
 	total = *count;
-	while (total) {
+	while (total && v < rqstp->rq_maxpages &&
+	       rqstp->rq_next_page < rqstp->rq_page_end) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
-		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
+		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
 			      len, base);
+
 		total -= len;
+		++rqstp->rq_next_page;
 		++v;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
-	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+	trace_nfsd_read_vector(rqstp, fhp, offset, *count - total);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count - total);
 	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }



