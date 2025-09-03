Return-Path: <linux-nfs+bounces-14024-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12AB42B56
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8476174D07
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6DE2E92C5;
	Wed,  3 Sep 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4yXvwow"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7CD2E0927
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932694; cv=none; b=NUeA5FAxb/6zXrIpPPTqBZttdie80Dni3oT7CSRmPnPSldo1uByrCK1GQOBuSM7Q4c1iLBMF2pRyp/9iURj0EHAS5dx3A5mmdsHL8Cy5G9/HS3wGnkpuknCYvA91MUbvl5TZzFTbwo4vNsvnmL5xOLgkPIxdjZPEjII5rwoFXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932694; c=relaxed/simple;
	bh=SGERbahJAImAx+dav2H8ZhiXDkNAQAvTXs8dacIU9N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXTH0869pzJrmoBn38FnsjUrW8l2by7a0emhYTe3TVyb8p1UTNQmseCoGFKhJnGtAR+cio+/eneM2kdb/OOddXuQUadQDUfGeAv+jZSl8v8G/ZmpI5KydAr2+R3P1Ae/h+Z7vwhx4XfbUU2Gkgb0SVDJ9nf0fiPNRMDGho8DFcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4yXvwow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F97C4CEE7;
	Wed,  3 Sep 2025 20:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932694;
	bh=SGERbahJAImAx+dav2H8ZhiXDkNAQAvTXs8dacIU9N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4yXvwowdnex2TdGlcyW+YyEPP3OpelJZKv+nLn7ysAbm48UfqvNE6q70BRYaQuT+
	 hJueIIVI/Hg6rwYth/bK1uM4yPMLnLT+QngnupkQju3RoQtIEDp04fBQ1wJDvc0d3V
	 JP2/ljldq0O8AREMELBTOhknUKaVe368uHBLhgHpZxrKDulPQk2hZtlWkYCKIIOlOs
	 jkYlqRzd87qcNp+2624yTNvJsip+MqcJWLfGs64te05KQT2MivunEoZWSzD4843w/t
	 K5iLNAyTm1OgCoWu8ESfjlZtale9Xic/Ej+7x3hyiSsYz6tTdi4enEOj7zXvAzHP1Z
	 8jIN9Rh0mtOsw==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 9/9] NFSD: use /end/ of rq_pages for misaligned DIO READ's start_extra page
Date: Wed,  3 Sep 2025 16:51:21 -0400
Message-ID: <20250903205121.41380-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250903205121.41380-1-snitzer@kernel.org>
References: <20250903205121.41380-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit works around what seems like a flexfiles+rpcrdma bug, and
Chuck Lever clarified that this shouldn't be needed:

    "Yes, the extra page needs to come from rq_pages. But I don't see
    why it should come from the /end/ of rq_pages."

However, when using NFSD DIRECT for READ and NFS 4.2 client with pNFS
flexfiles (and client gets a layout to use a v3 DS) over RDMA it is
easy to see data mismatch when NFSD handles a misaligned DIO READ. If
the same misaligned DIO READ is issued directly to the v3 DS over RDMA
(so flexfiles is _not_ used) then no data mismatch occurs.

Therefore, until this bug can be found, must use a 'start_extra' page
from rq_pages that follows the NFS client requested READ payload (RDMA
memory) if/when expanding the misaligned READ requires reading an
extra partial page at the start of the READ so that its DIO-aligned.

Otherwise if the 'start_extra' page is taken from the beginning of
rq_pages the pNFS flexfiles client will see data mismatch corruption.
As found, and then this fix of using the end of rq_pages verified,
using the 'dt' utility:
      dt of=/mnt/share1/dt_a.test passes=1 bs=47008 count=2 \
         iotype=sequential pattern=iot onerr=abort oncerr=abort
    see: https://github.com/RobinTMiller/dt.git

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/vfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5b3c6072b6f5c..e9ddeec3c9a32 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1263,7 +1263,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			if (read_dio.start_extra) {
 				len = read_dio.start_extra;
 				bvec_set_page(&rqstp->rq_bvec[v],
-					      *(rqstp->rq_next_page++),
+					      NULL, /* set below */
 					      len, PAGE_SIZE - len);
 				total -= len;
 				++v;
@@ -1288,6 +1288,11 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		base = 0;
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
+	/* FIXME: having the start_extra page come from the end of
+	 * rq_pages[] works around what seems to be a flexfiles+rpcrdma bug.
+	 */
+	if ((kiocb.ki_flags & IOCB_DIRECT) && read_dio.start_extra)
+		rqstp->rq_bvec[0].bv_page = *(rqstp->rq_next_page++);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
-- 
2.44.0


