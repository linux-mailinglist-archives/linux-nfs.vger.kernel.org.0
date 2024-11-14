Return-Path: <linux-nfs+bounces-7967-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826BB9C81FF
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476F4284609
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A561632DE;
	Thu, 14 Nov 2024 04:33:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35613B5AE;
	Thu, 14 Nov 2024 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731558832; cv=none; b=WYfKY20tpx03C8EncODJR/+dFkLpj5Fxl06F9HRQUoSlrvFIcpYjt8PWIo64wdaTuYk0JCueiR40sfsE/X2RQid1RJgcVMA42lA9KXQ1brM0nEbYQsEvbrrPH5ISzUqWzj9OHkeC8hkEkEsG1nheG8I8Mdb7IFU36mh2iVD7LgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731558832; c=relaxed/simple;
	bh=o5bFctkQj1da8lcuxfcwUve1PD7PcLcSTlrEMgb3iS0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o2dLdWh4HzZzENJ3RQpffFO4nwjboBj4y9QXrUHIwO1z/QyVXSbO3j1nfhNY/m9V37t+xeuNnBuYwk0Gsjx9PTLyfxstiTejLG04mkkHoSQyOEw3RHdatf/aBHcgjd4uGLlGzMNUhVD0dQYxZ3IiU6FkI15+jq/eDJgz845IgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XpnGh3wlkz1JCH5;
	Thu, 14 Nov 2024 12:29:00 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 11E771A016C;
	Thu, 14 Nov 2024 12:33:45 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Nov
 2024 12:33:43 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <trond.myklebust@hammerspace.com>, <jlayton@kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfs: pass flags to second superblock
Date: Thu, 14 Nov 2024 12:47:38 +0800
Message-ID: <20241114044738.1582373-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Pass sb_flags of the fc which carry flags passed by user to second
superblock to fix it.

Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b29a26923ce0..9a3b73a33fbf 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -233,6 +233,7 @@ static int do_nfs4_mount(struct nfs_server *server,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry->d_sb->s_flags = fc->sb_flags;
 	fc->root = dentry;
 	return 0;
 }
-- 
2.31.1


