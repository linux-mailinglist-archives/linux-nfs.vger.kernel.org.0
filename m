Return-Path: <linux-nfs+bounces-10455-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5CBA4DE3E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 13:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AE1188937E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315B202F8C;
	Tue,  4 Mar 2025 12:48:37 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98F78F33;
	Tue,  4 Mar 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092517; cv=none; b=NkQkVxMPWeaNZbQZSSn0NwIj+ESbU4/vwTfbuq7O4oVc5zShvzmfztpGnlxJ9fALutay58bLO8jX5zfMZH+mqBz2hna7PMzOvog+eo2kqnjOh/A99EC1obGDiKM83O/sW1f295O+ktDfJORal7qY1E7545B9CECQLb9xenBOCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092517; c=relaxed/simple;
	bh=kjNK2jKld4KcF4Y0efWpkVK5wFuSz/egehvSXV1w8JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaMMB8kQDftetW71hfGG9eWYtLSqEndZvcd1DagfEUBvNnJfO0UdDZUvu4TLH0OQm+kkQnxcs/tLQzn77Fl72YpeUiwzozsVbvdozCEPswY+d0C8Drsx7sup/IoWAyDETIfSsBFmaTasn0FeGctHRqij4IyrbWuOwmjOsdoxS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z6b4h1v4Wz21p0j;
	Tue,  4 Mar 2025 20:45:24 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CE70140361;
	Tue,  4 Mar 2025 20:48:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Mar
 2025 20:48:30 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <linux-nfs@dimebar.com>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 1/2] nfs: clear SB_RDONLY before getting superblock
Date: Tue, 4 Mar 2025 21:05:32 +0800
Message-ID: <20250304130533.549840-2-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250304130533.549840-1-lilingfeng3@huawei.com>
References: <20250304130533.549840-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

As described in the link, commit 52cb7f8f1778 ("nfs: ignore SB_RDONLY when
mounting nfs") removed the check for the ro flag when determining whether
to share the superblock, which caused issues when mounting different
subdirectories under the same export directory via NFSv3. However, this
change did not affect NFSv4.

For NFSv3:
1) A single superblock is created for the initial mount.
2) When mounted read-only, this superblock carries the SB_RDONLY flag.
3) Before commit 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs"):
Subsequent rw mounts would not share the existing ro superblock due to
flag mismatch, creating a new superblock without SB_RDONLY.
After the commit:
  The SB_RDONLY flag is ignored during superblock comparison, and this leads
  to sharing the existing superblock even for rw mounts.
  Ultimately results in write operations being rejected at the VFS layer.

For NFSv4:
1) Multiple superblocks are created and the last one will be kept.
2) The actually used superblock for ro mounts doesn't carry SB_RDONLY flag.
Therefore, commit 52cb7f8f1778 doesn't affect NFSv4 mounts.

Clear SB_RDONLY before getting superblock when NFS_MOUNT_UNSHARED is not
set to fix it.

Fixes: 52cb7f8f1778 ("nfs: ignore SB_RDONLY when mounting nfs")
Closes: https://lore.kernel.org/all/12d7ea53-1202-4e21-a7ef-431c94758ce5@app.fastmail.com/T/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/super.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index aeb715b4a690..3e5528c2c822 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1304,8 +1304,17 @@ int nfs_get_tree_common(struct fs_context *fc)
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
+	/*
+	 * When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
+	 * superblock among each filesystem that mounts sub-directories
+	 * belonging to a single exported root path.
+	 * To prevent interference between different filesystems, the
+	 * SB_RDONLY flag should be removed from the superblock.
+	 */
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
+	else
+		fc->sb_flags &= ~SB_RDONLY;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
-- 
2.31.1


