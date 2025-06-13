Return-Path: <linux-nfs+bounces-12460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065DAD95ED
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4787A6607
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CA9242D9E;
	Fri, 13 Jun 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAHx/8zk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1572608
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845333; cv=none; b=F/Tbrk/5KtZBWIOxhmQ1q3h1DF5MmMDG4sO0btxRT1QNkEinvvytVrohEQkevOq3JxCLbM0NugFu7w7OCiSh8FvgyCTPBq63RuHqTqlhoJKHD7EFq4dtR4kSq3GVMKzxEftKxwvXnMDTOI5y8CUckC1ut9e2Xmb5rcRlXxtDiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845333; c=relaxed/simple;
	bh=Qal6sAjHLR3q6jpezuUlWUGx5hVVQMwr5NzsWyTs848=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GixNE0Yb+DacXv7D54tkL7RIvIUpV73IVpuTXGAeUxZ8lO/HUE7nun2gsf1Zs3WIcVPtRro5Us5Qt0R8nb0F3XuDAp+1sBQMOVnfGofcbFFV4JUX2OuCZO30DSeEflwvplRdl29LdIGGb1guJ3xnduDwXP8xGsy0pVxVnyPBZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAHx/8zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EC2C4CEF2;
	Fri, 13 Jun 2025 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845332;
	bh=Qal6sAjHLR3q6jpezuUlWUGx5hVVQMwr5NzsWyTs848=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FAHx/8zkvLt5PGcvO9BpJcg6N2jz50D8A1qiAhh2v0z1XRkl4z3btNwv49yHs6818
	 z9OQKL/Iu7Bo7KjzljcYSTG+j4hWn+HpME6JyTvSLq7psCyn9f7hJIQaO+EWPxgvwC
	 YVhhzJevJkYQiLsmi8WTAy4WnHwNR5tkwdeosmopvQ6ZvqxXux1oNE+6Yv25KQQvi3
	 9041osAupd/qq79pNs7s6M/wXMUFC7il4vuBgWPrdZ1MTFnL+Tr62dHWUoERacSp6x
	 CXqwkL7+dncmO/T8d2D60YwluJ8i9uYwWtrTJz2ky68Cj90YoWVWz35ZaXU7G7aUWo
	 7cr80ATfNLksw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v2 2/2] NFSD: Use vfs_iocb_iter_write()
Date: Fri, 13 Jun 2025 16:08:47 -0400
Message-ID: <20250613200847.7155-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613200847.7155-1-cel@kernel.org>
References: <20250613200847.7155-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor: Enable the use of IOCB flags to control NFSD's individual
write operations. This allows the eventual use of atomic, uncached,
direct, or asynchronous writes.

Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 7b3bd141d54f..66adeb6ffff5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1174,15 +1174,14 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	struct nfsd_net		*nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct file		*file = nf->nf_file;
 	struct super_block	*sb = file_inode(file)->i_sb;
+	struct kiocb		kiocb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
-	loff_t			pos = offset;
 	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
-	rwf_t			flags = 0;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
 
@@ -1208,16 +1207,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	if (!EX_ISSYNC(exp))
 		stable = NFS_UNSTABLE;
-
+	init_sync_kiocb(&kiocb, file);
+	kiocb.ki_pos = offset;
+	kiocb.ki_flags = 0;
 	if (stable && !fhp->fh_use_wgather)
-		flags |= RWF_SYNC;
+		kiocb.ki_flags |= IOCB_DSYNC;
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-	host_err = vfs_iter_write(file, &iter, &pos, flags);
+	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
 		goto out_nfserr;
-- 
2.49.0


