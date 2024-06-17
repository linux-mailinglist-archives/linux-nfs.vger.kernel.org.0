Return-Path: <linux-nfs+bounces-3871-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3B90A1BE
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 03:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CBCB21B70
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2024 01:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580514AAD;
	Mon, 17 Jun 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG/eWuyw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E79134DE
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587515; cv=none; b=fIhWPAMB8KOEsqnUvrGx83PhZ5AbEA57FhoMTvY0dtMGra0OiZK1LJLkQsZCOUMiCwTZUBH6t3f0+aR0PZinqgxEwJbnHTLEMOvh+DkMuwlJCkDmX2HPwpnwVcBLpGfcbN82VABeT+WRJV3tRfPbXtMLqfwKEw7OY546HRqWgD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587515; c=relaxed/simple;
	bh=7jHrEDTpbfBiepg57AbiuRBo43WqCZDBjBto7bdY/Uo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db2uoN8TWZ6YwbDNon/dRM6IVm4PZYI2JEUpg1SHZZtN2jOuYo7YJGu3q6OhkIHlGqAaGyb/c6YbE3/+uvzNVoBAxm9P+0mMwbtVt9nCugqHWqnSWlQLRAdZvnGsas1+rstUNeb+R8XhCbFK50+3jhnPqUCIGreAwDu5BAVSRh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG/eWuyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7964BC2BBFC
	for <linux-nfs@vger.kernel.org>; Mon, 17 Jun 2024 01:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718587514;
	bh=7jHrEDTpbfBiepg57AbiuRBo43WqCZDBjBto7bdY/Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DG/eWuywVXLczs5OFHJbbFBphukIuriwDWOy2hVtEANfID2BKj4avaB+JXOohj1Dl
	 r6uS+dz1nNdoPvSsUB4omc8ppF4V+2muKFIVNWv0CWPidu620Uj/fjruP3i05TG9wf
	 Pk2qxf55eFEAcOwjj3DyNDPIiGAa1jYs/077SO3FD4JtTn/C3l1z4U2pdh18i8kOgc
	 GOYN/sHHOEVjxlhzjVo2MjfsJWvgXurDcf/UcIw1h2sfYJewIHPeANz8sjM/9+4TXq
	 ttNdPed8mxSMmZkwEq77vBPZNNYWi2pAVQq3p8Yx2ppgxeh5s0fVMtD44rWLDQ9Ycu
	 xv/y1w4G1Zo4A==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/19] NFSv4: Fix up delegated attributes in nfs_setattr
Date: Sun, 16 Jun 2024 21:21:30 -0400
Message-ID: <20240617012137.674046-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617012137.674046-12-trondmy@kernel.org>
References: <20240617012137.674046-1-trondmy@kernel.org>
 <20240617012137.674046-2-trondmy@kernel.org>
 <20240617012137.674046-3-trondmy@kernel.org>
 <20240617012137.674046-4-trondmy@kernel.org>
 <20240617012137.674046-5-trondmy@kernel.org>
 <20240617012137.674046-6-trondmy@kernel.org>
 <20240617012137.674046-7-trondmy@kernel.org>
 <20240617012137.674046-8-trondmy@kernel.org>
 <20240617012137.674046-9-trondmy@kernel.org>
 <20240617012137.674046-10-trondmy@kernel.org>
 <20240617012137.674046-11-trondmy@kernel.org>
 <20240617012137.674046-12-trondmy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@primarydata.com>

nfs_setattr calls nfs_update_inode() directly, so we have to reset the
m/ctime there.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 2aaadcdd6946..70af8c91dda3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -606,6 +606,28 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 }
 EXPORT_SYMBOL_GPL(nfs_fhget);
 
+static void
+nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
+{
+	unsigned long cache_validity = NFS_I(inode)->cache_validity;
+
+	if (nfs_have_delegated_mtime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_CTIME))
+			fattr->valid &= ~(NFS_ATTR_FATTR_PRECTIME |
+					  NFS_ATTR_FATTR_CTIME);
+
+		if (!(cache_validity & NFS_INO_INVALID_MTIME))
+			fattr->valid &= ~(NFS_ATTR_FATTR_PREMTIME |
+					  NFS_ATTR_FATTR_MTIME);
+
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			fattr->valid &= ~NFS_ATTR_FATTR_ATIME;
+	} else if (nfs_have_delegated_atime(inode)) {
+		if (!(cache_validity & NFS_INO_INVALID_ATIME))
+			fattr->valid &= ~NFS_ATTR_FATTR_ATIME;
+	}
+}
+
 void nfs_update_delegated_atime(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
@@ -2164,6 +2186,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	 */
 	nfsi->read_cache_jiffies = fattr->time_start;
 
+	/* Fix up any delegated attributes in the struct nfs_fattr */
+	nfs_fattr_fixup_delegated(inode, fattr);
+
 	save_cache_validity = nfsi->cache_validity;
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
-- 
2.45.2


