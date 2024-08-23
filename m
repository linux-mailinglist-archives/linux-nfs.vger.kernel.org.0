Return-Path: <linux-nfs+bounces-5605-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFC95C5D1
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72941F2350D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778E139CFC;
	Fri, 23 Aug 2024 06:50:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672A753E15;
	Fri, 23 Aug 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395852; cv=none; b=JBfhu1HZOvrA5/oGhDiwgzlKA7M7vmD7qCqafByjKy1qqwPNTF5k6YLXyVCz2QqNEJuaJSil0lJPDTmXGfo5OSKwjeydQ1hWqmW0kGa2320k6Pm7DQOCB/hIpkG7pwKE5G7jR6JaSWTbqoVxbInXvP9JBNtWbFKqRmPk9cf+GBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395852; c=relaxed/simple;
	bh=ln7nj3CVBqs/Nyw39xnFIK0Qn6bGh4O29aiJlDvojQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj4R25aMqUl0J6YOGdqCyNeqosDpDYSgpHKod0nLJ3VnbsGZCM6y7kkPbwE9COlcqiZC+RGq8zvFx3pEw3QeIE/4MK1mTHFcd315QkdR3lS9Ui5l5nnC6plqTV0FAgqOa9YGgIwbgX+OZefXdALuVrLA/I89juIyKiyuUIc+7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WqrLV4KsDz1S8XF;
	Fri, 23 Aug 2024 14:50:42 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D25E01402C7;
	Fri, 23 Aug 2024 14:50:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:50:46 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 1/4] nfsd: fix the comment of nfs_get_root
Date: Fri, 23 Aug 2024 15:00:46 +0800
Message-ID: <20240823070049.3499625-2-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240823070049.3499625-1-lilingfeng3@huawei.com>
References: <20240823070049.3499625-1-lilingfeng3@huawei.com>
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


