Return-Path: <linux-nfs+bounces-15597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC581C06C1A
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A73B48BF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F631C56D;
	Fri, 24 Oct 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2cIYp2p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829C831B123
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316999; cv=none; b=jY8114eOZ2jF+O78D05A/6jO1sHDFB4kIcVnCABYmJTTADk/QOqJzvRDXjGnNu6K7hLYlFh/d1M4Dr2FcHww3bJb6WdLGf0khT5n+a98uLu06DJLBYulJh48Qxzi2HkvEVb/3wnyRciueygiZRQ9iA7D79Enn4FoknTu7R+JcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316999; c=relaxed/simple;
	bh=xgVgAi+5fsta0PMeFAkUiipZPXAVrvYuvoWUu3rKhyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcOdq6SF9N4PGev5Bf+dHMLD94m/aGR2VzyIcCQyShB6UtT6nisvFwEmFyHFwZoJkeRh++xtHDu05NvDIKJ4NtaRCfbT8kmk+F2UldLew69GI0GolAj6s6kjVvlrnTqlG1t8Hv2Wjc1re6bA5/t/sJja2ADtt6ZR6J0dTKArlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2cIYp2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D49C4CEFF;
	Fri, 24 Oct 2025 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316999;
	bh=xgVgAi+5fsta0PMeFAkUiipZPXAVrvYuvoWUu3rKhyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2cIYp2peDngVl4R9qkEj/SsXFyRvl8vSwmvR9XE524r1hJM4BFL/ATHwirCpzV7v
	 8/YEarZ92CSQRgDMVRPC1N11HjbZt5nfZJ7BR0FLW/qS8NnYk9on9a7ObRNqQRRN4X
	 Ed8V/c9BSJCpyEGfkbN4lBmzoUNY8dyr+kYedgV5aiH5OrW0+1SllfdcsVNdEBstRk
	 VvSuexmF0uzzmLMW9Fn0EA2NLH2SWELnzrF9vM73FoZwq1TClbgIrVC5E+GWNfmTG6
	 kG9Oblpj51F8VGHvoFyUt4A62eQCqdxbtvtrwB4BddFOhkCFY9gcVLY9o4RMdw6aLf
	 1v3Gx3PY/QNtg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 13/14] NFSD: Clean up direct write fall back error flow
Date: Fri, 24 Oct 2025 10:43:05 -0400
Message-ID: <20251024144306.35652-14-cel@kernel.org>
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

Clean up: Use the usual error flow form:

	if (uncommon condition) {
		handle it;
		return;
	}
	do common thing;

in nfsd_direct_write(). Now there is a single place where the direct
write path falls back to a single cached write.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b7f217aa4994..b0e4105e0075 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1373,10 +1373,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	ssize_t host_err;
 	size_t i;
 
-	if (!nfsd_setup_write_dio_iters(args, rqstp->rq_bvec, nvecs, *cnt))
-		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
-				       cnt, kiocb);
-
 	*cnt = 0;
 	segment = args->segment;
 	for (i = 0; i < ARRAY_SIZE(args->segment); i++) {
@@ -1388,7 +1384,6 @@ nfsd_issue_write_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 						segment->len);
 		} else
 			kiocb->ki_flags &= ~IOCB_DIRECT;
-
 		host_err = vfs_iocb_iter_write(file, kiocb, &segment->iter);
 		if (host_err < 0)
 			return host_err;
@@ -1429,11 +1424,13 @@ nfsd_direct_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
 
 	args.nf = nf;
-	if (nfsd_is_write_dio_possible(&args, kiocb->ki_pos, *cnt))
-		return nfsd_issue_write_dio(rqstp, fhp, &args, kiocb,
-					    nvecs, cnt);
+	if (!nfsd_is_write_dio_possible(&args, kiocb->ki_pos, *cnt) ||
+	    !nfsd_setup_write_dio_iters(&args, rqstp->rq_bvec, nvecs, *cnt))
+		/* fall back to writing through the page cache */
+		return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs,
+				       cnt, kiocb);
 
-	return nfsd_iocb_write(file, rqstp->rq_bvec, nvecs, cnt, kiocb);
+	return nfsd_issue_write_dio(rqstp, fhp, &args, kiocb, nvecs, cnt);
 }
 
 /**
-- 
2.51.0


