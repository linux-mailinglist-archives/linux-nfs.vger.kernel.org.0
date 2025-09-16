Return-Path: <linux-nfs+bounces-14490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509EDB59C04
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1088817BC01
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Sep 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856634573A;
	Tue, 16 Sep 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txt/g4XB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234134AAFB
	for <linux-nfs@vger.kernel.org>; Tue, 16 Sep 2025 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036263; cv=none; b=GpfHR/bF8cUxllAcpXGF7QNh3UQ2cT4gzw/37RqQnY/PpefynTVng+j2IFePvg8ALO87qyOjxrXNVEo8qEzYS0SwtcTAc8jEc99p+JfUjj9KfiXJo00i8Qcgn1ilBsl8dDwtkE6+k53+w4TWffZo1N2BY/WUTbtCsc6+Y7H9TRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036263; c=relaxed/simple;
	bh=FR0Xa0qVXV5H8zj7t6GU0+6JWZulfZN/+RCEqHydS3Q=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=dexFLJGB3Ufy9jpp2XSG91qYb663H2QudLcpoE1CnciQYEVuG96akR9NZRhqH4qsJVdl7hCaoZVDduN5d7UN836KaXvrQeLkLLeWYdap215tpOg7bjpU3NWmvPZOvdWgSsrf/w3TuaYF0gEvALDAWdOd63T73iIzTGndUUrZtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txt/g4XB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F7C4CEEB;
	Tue, 16 Sep 2025 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758036262;
	bh=FR0Xa0qVXV5H8zj7t6GU0+6JWZulfZN/+RCEqHydS3Q=;
	h=Subject:From:To:Cc:Date:From;
	b=txt/g4XB+BWUHug20zfkxc2oM47e03RGdM0ZZDXq7nL8mpwCeY1IFfPaxALgCuWAG
	 R/qyex6xxGbMwVpGdKtavBNrvNAAjfDBttw1AOumyIWqICrfWS6US/w0BWtJNBtzzO
	 00E9HvCZClW2T9CuuL78suv8khIZ3d4sOFTvfmY4T5CWVBECp8grHQBfX7u53vJRwk
	 V9wWpX5Ol0xF/q4rAhQKWFFHsByqMuq7ukw7l3W8QJa47PeY8T5PlpXAa5Rog2vXR9
	 Vfn/urG1s3rMWag3X70d7ATuIvrQjcy06Y02CE5BsdLpqQ1BYPWnMfbOv2JtUQZlG4
	 h0e8+8vKiiW8g==
Subject: [PATCH v2] NFSD: Add array bounds-checking in nfsd_iter_read()
From: Chuck Lever <cel@kernel.org>
To: neil@brown.name, jlayton@kernel.org, okorniev@redhat.com,
 dai.ngo@oracle.com, tom@talpey.com
Cc: linux-nfs@vger.kernel.org
Date: Tue, 16 Sep 2025 11:24:19 -0400
Message-ID: 
 <175803617610.13710.7007300747292684854.stgit@oracle-102.nfsv4bat.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

Changes since v1:
- Check for overrunning rq_pages as well
- Move bounds checking to top of the loop
- Move incrementing to the bottom of the loop

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



