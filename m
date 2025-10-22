Return-Path: <linux-nfs+bounces-15535-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ABBBFE03B
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 21:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4626B357C01
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DB3370F5;
	Wed, 22 Oct 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEmaF6MI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958613491CE
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160940; cv=none; b=P/cVSDrHa9Jcs9LkaWGk4AS6YbR5JTlolf+H3OXi0PLqHYHXbafZ+5FYVIW3YjmYbSJW7sVS7SMWrvP7WSdQ8eCZQmxMukTHITVpmnXyA3KYW1pVFF2Fz78Bjssthe57+gxX99YtOb33Y4Hl+1MbFGC2Is5i5FLQ0YaBsO8jyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160940; c=relaxed/simple;
	bh=O2jgoHjAduxZmiyhE1fq2d6x6WE3Rv5Zkou9K0zw65s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4AU+QPkmZ975VZZ40+3HZlUjUW16nsEOzWZD4mb9Tj2tA+S0ZyZBLaDjUuturkgsI/ntGghMPC+5O8nPlwoxDI/RF/r35mdP/Rb/GQuMAsVqqMvh+gcgfr/4GUZVEK3K0RoYX8YjmwFkd87DQ2diruS4aUm4azUPsQNNkets/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEmaF6MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95CEC4CEF7;
	Wed, 22 Oct 2025 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160939;
	bh=O2jgoHjAduxZmiyhE1fq2d6x6WE3Rv5Zkou9K0zw65s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JEmaF6MItKELO5Lss18lQgFaSmrmCZuo+wgoJO91d+tmGlzao1Q3igAFzApIfROeG
	 pHIRJsy+8mPferyHiEMRvKzSyWJmQ6r0ZfZrUvEZjW+g49mJiykcv+Jujs9epHidnv
	 8q5XGAJittp1rWWK+CRtToUeNiaU32Y7wA5n9Lq90KYVio4twaEbGzVxw93NSIcl8H
	 gLrtmhxIAOY1WiMeBa9AFw/hlWIpfYpE/h5RfG90UWb4E1DGj3tCPEIIcOApLahUpu
	 hnqH7hay7OV7ivmYIz3ru03jslhNxIw9vhHGnk/lqDgBM8aOZqS2XUKd3iTK3HYZuT
	 59quH8mjo5WPA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v6 3/5] NFSD: Refactor nfsd_vfs_write()
Date: Wed, 22 Oct 2025 15:22:06 -0400
Message-ID: <20251022192208.1682-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022192208.1682-1-cel@kernel.org>
References: <20251022192208.1682-1-cel@kernel.org>
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
 fs/nfsd/vfs.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 2b238d07f1ba..41cd2b53d803 100644
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
@@ -1320,25 +1335,24 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			(stable == NFS_FILE_SYNC ? IOCB_SYNC : IOCB_DSYNC);
 
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


