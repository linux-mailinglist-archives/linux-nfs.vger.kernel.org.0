Return-Path: <linux-nfs+bounces-16011-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59633C31F80
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6A23348C2F
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E09026F445;
	Tue,  4 Nov 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byNeot7A"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EAF1C3BE0
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272353; cv=none; b=Oo4BrNErDg6LrCJD4weGDq88yjSZwL2kgFkhEVvjaRmU8WZOWEz0WcTaDqByNKLmMHl869LeTwBPX45VOnbd6VRLxS7XUXuztMnUGcTUfJ2w9KQYQ4hPWkpl1Zav7u7nzz9UdLLZFBge/znDGVhogOJEjLNeKuZJ+Nx8FRRzZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272353; c=relaxed/simple;
	bh=H4G0GRVMQgrr/g3RwV27W7ICFEHQKDZk4GBp/ofOOLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NN79rbUhh1CCKR9w/nUHz7r4nlxbr7dPrGt29RzbQmJjmQlw0ii34+xoRz1XCBTRS1Q6RCJGjQwOMmLCELLxzjMI8VLpfkuGwJvTmHQ2D67E4DawMB63ONGITTotWfryLkqMk2mptVOdx3IYaCnXa3gscoSzyNwbxHtU3d+dkaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byNeot7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1398BC4CEF8;
	Tue,  4 Nov 2025 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762272352;
	bh=H4G0GRVMQgrr/g3RwV27W7ICFEHQKDZk4GBp/ofOOLw=;
	h=From:To:Cc:Subject:Date:From;
	b=byNeot7Aa0DUoNDYp3+tKddm/IaoIrEgDNuABgyQDpJ270I1eearOusnGl7jMvFMc
	 qNvsLk8uuKBsLs0mRrZf7fjBMT00+9iQs0IZkF3l+BMw5TdQ407w1/LijzAF5SCTBz
	 at5U4EQjpLu297Qmw9uK4Hf+adfwhujgsebslQAeQmv8RwoYT2lMmOCahe7QCeJb/y
	 vSzAdcG1/d0lvdZ+uusM2tXy7REi7euzrFSaHjcJmG+vfHmsiR2QrZUFBQH0yPAJO7
	 QY+Vy7n2O3YIjpElBao5UXhLq5PQyLBBc9vmC3fbYAg009cYMkXiDaRlpoSYKCaVbg
	 1R+P59a9PV3fA==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] NFSD: Prevent a NULL pointer dereference in fh_getattr()
Date: Tue,  4 Nov 2025 11:05:49 -0500
Message-ID: <20251104160550.39212-1-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

In general, fh_getattr() can be called after the target dentry has
gone negative. For a negative dentry, d_inode(p.dentry) will return
NULL. S_ISREG() will dereference that pointer.

Avoid this potential regression by using the d_is_reg() helper
instead.

Suggested-by: NeilBrown <neil@brown.name>
Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Hi Anna -

nfsd-fixes is still based on v6.17-rc, so this patch does not apply
to it. Can you take it for v6.18-rc ?

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..16182936828f 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -696,10 +696,9 @@ __be32 fh_getattr(const struct svc_fh *fhp, struct kstat *stat)
 		.mnt		= fhp->fh_export->ex_path.mnt,
 		.dentry		= fhp->fh_dentry,
 	};
-	struct inode *inode = d_inode(p.dentry);
 	u32 request_mask = STATX_BASIC_STATS;
 
-	if (S_ISREG(inode->i_mode))
+	if (d_is_reg(p.dentry))
 		request_mask |= (STATX_DIOALIGN | STATX_DIO_READ_ALIGN);
 
 	if (fhp->fh_maxsize == NFS4_FHSIZE)
-- 
2.51.0


