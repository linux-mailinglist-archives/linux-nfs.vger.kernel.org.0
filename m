Return-Path: <linux-nfs+bounces-12741-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62CAE77C0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 09:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA1E1BC3B9F
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933EF1F5849;
	Wed, 25 Jun 2025 07:07:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C851DF273
	for <linux-nfs@vger.kernel.org>; Wed, 25 Jun 2025 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835220; cv=none; b=WsemDysGW+wgAEeJy9oMmGrQ7JuS/Xoa29HtVWmFGd9NEWKdUxcng/QqQpAJN5daZBBu//Dv80ACY5THPMQe0qRZKWE+qlZDzB3oTwwW0zMjrgY/OS4aPl1b1BNxeZ3JWKU1oKLqN40bh1OxwiMub3xM1d21xUGR/eHybb9ExYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835220; c=relaxed/simple;
	bh=JkKRrjXW4u7N1q5p1D7xgAU9C0VPGkq/XLcMk0Gwf+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y6NxN/KUlLGpheXTo95rh5IZ8os+/R7sL3bf05q44VyXPJS5QPRpOUS3Gsx+3K+zGQsiY40VPqeEiCUn8md0TLDy+IrapIwjl0HIpb8rZ7ppAY17cZo/ITKs3Ad5wGg84Gha5Ms4chkNOcn+vcunxDOzOZGVsShJlX6DSDiWu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bRtB51fy2z1QBn2;
	Wed, 25 Jun 2025 15:05:17 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 0FBAE180043;
	Wed, 25 Jun 2025 15:06:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 15:06:54 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <steved@redhat.com>, <joannelkoong@gmail.com>, <chuck.lever@oracle.com>,
	<djwong@kernel.org>, <jlayton@kernel.org>, <okorniev@redhat.com>,
	<kernel-team@meta.com>
CC: <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfs:check for user input filehandle size
Date: Thu, 26 Jun 2025 08:20:26 +0800
Message-ID: <20250626002026.110999-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memory
of server_fh is not passed from user space. So I add a check for input size.
---
 fs/nfs/export.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index e9c233b6f..e0e77f8ca 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -65,8 +65,8 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 		 int fh_len, int fh_type)
 {
 	struct nfs_fattr *fattr = NULL;
-	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
-	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	struct nfs_fh *server_fh;
+	size_t fh_size;
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
@@ -74,6 +74,14 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 	u32 *p = fid->raw;
 	int ret;
 
+	/* check for user input size */
+	if ((char*)server_fh <= (char*)p 
+	    || (int)((u32*)server_fh - (u32*)p + 1) < fh_len)
+		return ERR_PTR(-EINVAL);	
+
+	fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+
 	/* NULL translates to ESTALE */
 	if (fh_len < len || fh_type != len)
 		return NULL;
-- 
2.33.0


