Return-Path: <linux-nfs+bounces-15587-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8959C06BF3
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB431C07894
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC1B2030A;
	Fri, 24 Oct 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7zGKQYF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC011E0083
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316991; cv=none; b=K2VN9Gk2xRZMnHu6mhmm62jQmK0OTyTnRNanxKvMKLrKfxBRSoGfqrMSWQQrKiZhnOmyFtsCybLHQ34Yh0I833c71CJX1aa0JbLIaEJiY/O9MqYz7ap9JsLlyaDKXL81lqwZdBv5bfIvFjGpQ0/EbyhCgiiZXv5RFGwd2WLlDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316991; c=relaxed/simple;
	bh=j6esweEXq0bH7daPMRBFZ12lmOQn08IOzpdgGVFgr00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHR/XQpnZfaz2KPfojBXjRQrCY/BiYDNTfn0A0KgRmYN3pn/zbQqa5aXKf926ZfMw1TbLFfwgH966Yet1T8osuI5g9R1kXZXEQa0N62hU8+bNqoGEysH5XoHZfrGyj/WOyxVfNYgi4/zElKdVUM2mnUVvEXgSD7v5LYZqD3Zfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7zGKQYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AEFC4CEF1;
	Fri, 24 Oct 2025 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316991;
	bh=j6esweEXq0bH7daPMRBFZ12lmOQn08IOzpdgGVFgr00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7zGKQYF6J0IOZA2HKhUclwMDdl86Lqw4Qk9IO4AndYIrKSmNLgcumVrKvrvN9lwR
	 GKNNrKn31SvG19IOnzrFOcR8qR5IPB/hekhxlZ/9W6N0v2zu/cwBe/K6cA8QhcSyCT
	 OfchG8LESfZqvpc/NTl3vIPpOYn1HO25BGNzMb37+co2f+ojVhMFlrhapQ9TdyV3v7
	 0AqmCjQGhz9vf/tDj3E22BXgHaenjqwX+ilx6C1bjafPZ00tvURyblTeZw//6DOiek
	 6Y3s29ugUYXyOU+XAfQc/LZWuA4hQ2wHf7FxaH4O95FKnOkzDbG/h3WmzFw5kNfCes
	 C//oc5ogtqpIg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v7 03/14] NFSD: Refactor nfsd_vfs_write()
Date: Fri, 24 Oct 2025 10:42:55 -0400
Message-ID: <20251024144306.35652-4-cel@kernel.org>
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

From: Mike Snitzer <snitzer@kernel.org>

Extract the common code that is to be used in the buffered and
dontcache I/O modes. This common code will also be used as the
fallback when direct I/O is requested but cannot be used.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index dc98182a9048..6076821bb541 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,22 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+static int
+nfsd_iocb_write(struct file *file, struct bio_vec *bvec, unsigned int nvecs,
+		unsigned long *cnt, struct kiocb *kiocb)
+{
+	struct iov_iter iter;
+	int host_err;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, bvec, nvecs, *cnt);
+	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
+	if (host_err < 0)
+		return host_err;
+
+	*cnt = host_err;
+	return 0;
+}
+
 /**
  * nfsd_vfs_write - write data to an already-open file
  * @rqstp: RPC execution context
@@ -1282,7 +1298,6 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
-	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1325,25 +1340,25 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
 
 	switch (nfsd_io_cache_write) {
-	case NFSD_IO_BUFFERED:
-		break;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
+		fallthrough;
+	case NFSD_IO_BUFFERED:
+		host_err = nfsd_iocb_write(file, rqstp->rq_bvec, nvecs, cnt,
+					   &kiocb);
 		break;
 	}
-	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
 	}
-	*cnt = host_err;
 	nfsd_stats_io_write_add(nn, exp, *cnt);
 	fsnotify_modify(file);
 	host_err = filemap_check_wb_err(file->f_mapping, since);
-- 
2.51.0


