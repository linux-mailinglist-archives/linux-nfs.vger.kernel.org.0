Return-Path: <linux-nfs+bounces-15411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C995BF269E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0552E4F8A72
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Oct 2025 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA428751A;
	Mon, 20 Oct 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UteoNOFM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2F284883
	for <linux-nfs@vger.kernel.org>; Mon, 20 Oct 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977552; cv=none; b=JagW0md+OcN+sQXBFuNp4gZdHoVLMqSAyzmXh1vlR8C5F2cu6pc2qzf62wShnWDxytH+PB5Z16CKs2RUrk+Qnd266RiBMs/I1R7QXgqZ32K4Outs+F7ZCnu7u1cjUO2IvGTAjlqZrfqxGrID5HN/8DAHI88ilOuThNumcUKnyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977552; c=relaxed/simple;
	bh=zIHxuiQVelfLnPlBhbfFlqQvDsuLeCkNgzmMYojW6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnsSBMJl7Kcbd2Rjq41imH+Hq8zhPJIqew+iBAzivX4cYbgptNQhLfjX5WMWeaQ9d8zIj9uG8rCwy/43z7sC0aQQ69FeuTgv95lVtsRBWGClieMps8C6OMUFXzooI0ZMbG3VxV39BqLApx0ubuE52oAyXKZ4a/prauZBebfGDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UteoNOFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68635C113D0;
	Mon, 20 Oct 2025 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760977552;
	bh=zIHxuiQVelfLnPlBhbfFlqQvDsuLeCkNgzmMYojW6BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UteoNOFMmVKSjxI5r4a90bI3ETC8WjbjmqgJZuPcjuRXWVniuOtYLvny1BLiRYkh6
	 ZdVuBYLXdgaqvXKw4vGLxj9z+KWsy6KxetXRrrwoIYAUkhmj+Cphv75gBFEGvNNVRR
	 MlL46NYuoVzp1sSdRllIAaeThxNrPjjF6ym7O7cA2qk1dkLZuXwGmf+0C/Cd+V5gks
	 0Elnr4DrPmhgcZZlQtnWw7lVRjbSoMBZerrriP7uNKBGhpBRHbZ1ioEx00EpaypPuN
	 b2ecZ8QDfK6ueGJoYu9FVOyjO3t7kLPqbjrmRmXzfKcW+8WFHQPM1LH6xXSw53cJhW
	 MlXIlKedgFU1g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 2/4] NFSD: Refactor nfsd_vfs_write()
Date: Mon, 20 Oct 2025 12:25:44 -0400
Message-ID: <20251020162546.5066-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020162546.5066-1-cel@kernel.org>
References: <20251020162546.5066-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Extract the common code that is to be used in the buffered and
dontcache I/O modes. This common code will also be used as the
fallback when direct I/O is requested but cannot be used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8b2dc7a88aab..ae9c41f7374e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1254,6 +1254,22 @@ static int wait_for_concurrent_writes(struct file *file)
 	return err;
 }
 
+static int
+nfsd_iocb_write(struct svc_rqst *rqstp, struct file *file, unsigned int nvecs,
+		unsigned long *cnt, struct kiocb *kiocb)
+{
+	struct iov_iter iter;
+	int host_err;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
+	if (host_err < 0)
+		return host_err;
+	*cnt = host_err;
+
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
@@ -1319,25 +1334,24 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		kiocb.ki_flags |= IOCB_DSYNC;
 
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
+		host_err = nfsd_iocb_write(rqstp, file, nvecs, cnt, &kiocb);
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


