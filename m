Return-Path: <linux-nfs+bounces-5678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B204495DA63
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 03:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFE1283063
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 01:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3749475;
	Sat, 24 Aug 2024 01:33:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146079C0;
	Sat, 24 Aug 2024 01:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463220; cv=none; b=Gc8HpN00BboiXyr9/XY2VkLMIhCOrfKqLNKbHedMeFZnPqw67L8tuCUQ4PRA19WfD7BYXXBLKBOBt8Nk3emLKxkzOQH2V1KS99Xz7pamBAigFQHEX0Nq2uiXWm7cvzsVC1TAutwF9CBKEOXc0xB2clBH2y+UsbAkvYQFiu5GcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463220; c=relaxed/simple;
	bh=C1qzAROpQX+5CLGxGPOi/CR+56hkg15UA/Y2oi9ekVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nTQGN8hl8MBIt9ZuB28K8hA5/mowhMXW9IOmfyQEJ6Xs+Hii/3QwU2een3tVsNeC57Au02KisNwfGaca62TK1GLgzpZCUysmHH1WZogruM28I5Jz/snR1hn37S0ebp3vU/J4v7Mb8UVoXwvLvvMa33qbqwBbHNHlJmQQjAa6IXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrKG16QxMz1j6Hr;
	Sat, 24 Aug 2024 09:33:29 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F0E21A0188;
	Sat, 24 Aug 2024 09:33:35 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 09:33:34 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2 1/2] nfs: fix the comment of nfs_get_root
Date: Sat, 24 Aug 2024 09:43:35 +0800
Message-ID: <20240824014336.537937-2-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240824014336.537937-1-lilingfeng3@huawei.com>
References: <20240824014336.537937-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)

The comment for nfs_get_root() needs to be updated as it would also be
used by NFS4 as follows:
@x[
    nfs_get_root+1
    nfs_get_tree_common+1819
    nfs_get_tree+2594
    vfs_get_tree+73
    fc_mount+23
    do_nfs4_mount+498
    nfs4_try_get_tree+134
    nfs_get_tree+2562
    vfs_get_tree+73
    path_mount+2776
    do_mount+226
    __se_sys_mount+343
    __x64_sys_mount+106
    do_syscall_64+69
    entry_SYSCALL_64_after_hwframe+97
, mount.nfs4]: 1

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/getroot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 11ff2b2e060f..f13d25d95b85 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -62,7 +62,7 @@ static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *i
 }
 
 /*
- * get an NFS2/NFS3 root dentry from the root filehandle
+ * get a root dentry from the root filehandle
  */
 int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
-- 
2.31.1


