Return-Path: <linux-nfs+bounces-15704-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7077C0F2A3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BCC425D08
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67C31AF3B;
	Mon, 27 Oct 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGfh12ni"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880431AF34
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580005; cv=none; b=AruF2YCqehKbhP9rHewbPRSN6cUh20QVn2+2EfvySYmwqDV/J8+Q1oawuDuqxWDNfmgJc/E/+CwYaMqpiSaHuttPEnoirMP+8bE+SP6QobypwYeeBRexwEGyeXAu3QnGVTQqntKYkH/GVd9Yus6UpMuidOM89WfFUKMPE5Zxd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580005; c=relaxed/simple;
	bh=JJWZjV9JqibE6GAP0RwFPWXKMmrX2Z8zeW6cdkUmVSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/hLrusdTCYQIUauhrcJNh/z3xykfVd1egXRoj2ZCaxBTfLroXCjwd1wGXRgJJtOYRiBURhULTl1tjuDM1kSevJ8tGy77aJVZQFIiem2BMEOQjwcCNWrVI3KfIy91V1r7DP8EYWA9xWOY0VljQQDw4EqaxGu2SHqtIUXP3xmNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGfh12ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56FAC4CEF1;
	Mon, 27 Oct 2025 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580005;
	bh=JJWZjV9JqibE6GAP0RwFPWXKMmrX2Z8zeW6cdkUmVSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGfh12niaJbbuDcLWXWJ0GfNNTbP5ANx76H/lfhMRtZAPRa/E2XYeZrGagqGB/Unt
	 RHAensR+fa4AvtQNJI/cYGeusePap8D9qEQPbN8rTXRHemVGdUcWMJD9tskEAo29rb
	 bILDGT+Fv2riE2Cl7+8dxcabsHXpdNRwOCngLTbGCwB0QTV/Y7ZtrGqRT2RHMOY9CD
	 aVhJnjI+tAUZxJzWXv5gLg33wYRvpFAjwLEq5RgGnDH3Xw9cGhxtTlQdxvpF04ZBbg
	 GIrpKFIv/0hHXjMFvJ3STWrPzmL5R9pLfbCMJQErqC0wBOd+XKi8Ipb6t3vQDjANTF
	 F8iA7H2j31b5g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 12/12] NFSD: Refactor nfsd_vfs_write
Date: Mon, 27 Oct 2025 11:46:30 -0400
Message-ID: <20251027154630.1774-13-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There is now only one caller of nfsd_buffered_write(), so it can
be folded back into nfsd_vfs_write().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3c78b3aeea4b..934090e168c6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1380,23 +1380,6 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 	args->nsegs = 1;
 }
 
-static int
-nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
-		    unsigned int nvecs, unsigned long *cnt,
-		    struct kiocb *kiocb)
-{
-	struct iov_iter iter;
-	int host_err;
-
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
-	if (host_err < 0)
-		return host_err;
-	*cnt = host_err;
-
-	return 0;
-}
-
 static int
 nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     struct kiocb *kiocb, unsigned int nvecs,
@@ -1480,6 +1463,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
+	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1540,10 +1524,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
-		fallthrough; /* must call nfsd_buffered_write */
+		fallthrough;
 	case NFSD_IO_BUFFERED:
-		host_err = nfsd_buffered_write(rqstp, file,
-					       nvecs, cnt, &kiocb);
+		iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+		host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
+		if (host_err < 0)
+			break;
+		*cnt = host_err;
 		break;
 	}
 	if (host_err < 0) {
-- 
2.51.0


