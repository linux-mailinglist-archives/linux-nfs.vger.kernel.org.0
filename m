Return-Path: <linux-nfs+bounces-8268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF409DEED7
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 04:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E5C163637
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Nov 2024 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817757080D;
	Sat, 30 Nov 2024 03:44:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B84C91;
	Sat, 30 Nov 2024 03:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732938298; cv=none; b=JD63awIS9i+GmsCiH2vGk9p+F80XFp6PcwC9hjnTkGYEKnkmLHO4Sfw6rxKyqlC7rvk6x3m8QdN/DoWeYTjLPA8MwHLjKmYpIMS3X4NDxYU2nxJK6dwqsGgQ0X8WPUCf5UKJ6LNMqJBT5jW4lla96lzap3KuTjZgs5U8UKlzHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732938298; c=relaxed/simple;
	bh=w6wIyl4oSgwtkrTkqr9kBN08s9lyvuxOirJvQfE70wc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4li7XygfpGAJenM9WH5S1nv8uNw46TVvK6mVwTdS2b2RvyA1MpAj8LfOSVH8OwHUh2RmnGGpETdDJne1DA2oZrHp8b5z84gSD0bN5+onra2tOfm7jmNL6OuGkFaZ08/ol0T7oDUHWA0863+1/TTIPu7xej+RwlWjvbFF7iCMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y0bT01c2FzPppP;
	Sat, 30 Nov 2024 11:41:56 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 18B221800D9;
	Sat, 30 Nov 2024 11:44:44 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 30 Nov
 2024 11:44:43 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <trond.myklebust@hammerspace.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfs: pass ro flag to second superblock
Date: Sat, 30 Nov 2024 11:58:18 +0800
Message-ID: <20241130035818.1459775-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
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

During the process of mounting an NFSv4 client, two superblocks will be
created in sequence. The first superblock corresponds to the root
directory exported by the server, and the second superblock corresponds to
the directory that will be actually mounted. The first superblock will
eventually be destroyed.
The flag passed from user mode will only be passed to the first
superblock, resulting in the actual used superblock not carrying the flag
passed from user mode(fs_context_for_submount() will set sb_flags as 0).

Since the superblock of NFS does not carry the ro tag, the file system
status displayed by /proc/self/mountstats shows that NFS is always in the
rw state, which may mislead users.

Pass ro flag passed by user carried by the fc to second superblock to fix
it.

Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b29a26923ce0..6c3ea620b75d 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -233,6 +233,7 @@ static int do_nfs4_mount(struct nfs_server *server,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry->d_sb->s_flags |= (fc->sb_flags & SB_RDONLY);
 	fc->root = dentry;
 	return 0;
 }
-- 
2.31.1


