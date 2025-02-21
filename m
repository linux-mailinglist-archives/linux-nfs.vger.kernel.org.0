Return-Path: <linux-nfs+bounces-10246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA3DA3EDEA
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 09:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529C1188BBD6
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2025 08:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614701DE892;
	Fri, 21 Feb 2025 08:09:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A51D7E2F;
	Fri, 21 Feb 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125343; cv=none; b=WweoyRCxA/LhZaFVizXn3BBRpotz1e3cZyfpSCzo19oQL4VMjediisY2Y/PV8GfR2lHTqrYUXzgVwKLWa7xNmWlkWFAufr7SGxpjiL8saplAIZtr9ecmzCKd9486EJM9vpgpCHdXPQKJPpWqq5smuwkiErKTzE3DGuH932MfnhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125343; c=relaxed/simple;
	bh=x6Je/MiGfzQ7gAuCruwEQwF7HP2I/8JRFgCqS/KI0K0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROLOgbH8aawCu2ruOLs06jLwkPdzU7OnRI8p+/ATZcvbWacArkJYQloPzbhOEEv9rm+xnw8BXL6vqmmg/h/3/BFompDhqaCaolAtCn49R6kDPNzh1qUKYhfouDjDUhBlcLo1APWMmgZNIY26XB+0CEUqfU35PZoXWlP0ITWlDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YzjMR1rbVz1GDcp;
	Fri, 21 Feb 2025 16:04:19 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id BA5641402E2;
	Fri, 21 Feb 2025 16:08:57 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 21 Feb
 2025 16:08:56 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <yukuai1@huaweicloud.com>, <houtao1@huawei.com>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfs: remove SB_RDONLY when remounting nfs
Date: Fri, 21 Feb 2025 16:26:13 +0800
Message-ID: <20250221082613.2674633-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In some scenarios, when mounting NFS, more than one superblock may be
created. The final superblock used is the last one created, but only the
first superblock carries the ro flag passed from user space. If a ro flag
is added to the superblock via remount, it will trigger the issue
described in Link[1].

Link[2] attempted to address this by marking the superblock as ro during
the initial mount. However, this introduced a new problem in scenarios
where multiple mount points share the same superblock:
[root@a ~]# mount /dev/sdb /mnt/sdb
[root@a ~]# echo "/mnt/sdb *(rw,no_root_squash)" > /etc/exports
[root@a ~]# echo "/mnt/sdb/test_dir2 *(ro,no_root_squash)" >> /etc/exports
[root@a ~]# systemctl restart nfs-server
[root@a ~]# mount -t nfs -o rw 127.0.0.1:/mnt/sdb/test_dir1 /mnt/test_mp1
[root@a ~]# mount | grep nfs4
127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (rw,relatime,...
[root@a ~]# mount -t nfs -o ro 127.0.0.1:/mnt/sdb/test_dir2 /mnt/test_mp2
[root@a ~]# mount | grep nfs4
127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (ro,relatime,...
127.0.0.1:/mnt/sdb/test_dir2 on /mnt/test_mp2 type nfs4 (ro,relatime,...
[root@a ~]#

When mounting the second NFS, the shared superblock is marked as ro,
causing the previous NFS mount to become read-only.

To resolve both issues, the ro flag is no longer applied to the superblock
during remount. Instead, the ro flag on the mount is used to control
whether the mount point is read-only.

Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
Link[1]: https://lore.kernel.org/all/20240604112636.236517-3-lilingfeng@huaweicloud.com/
Link[2]: https://lore.kernel.org/all/20241130035818.1459775-1-lilingfeng3@huawei.com/
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index aeb715b4a690..f08e1d7fb179 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1047,6 +1047,7 @@ int nfs_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
+	fc->sb_flags &= ~SB_RDONLY;
 	/*
 	 * Userspace mount programs that send binary options generally send
 	 * them populated with default values. We have no way to know which
-- 
2.31.1


