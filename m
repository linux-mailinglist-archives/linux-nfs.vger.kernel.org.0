Return-Path: <linux-nfs+bounces-10408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFBBA4B5B5
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 02:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E054E3AEB8C
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 01:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECA978F39;
	Mon,  3 Mar 2025 01:09:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDC4C85;
	Mon,  3 Mar 2025 01:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740964145; cv=none; b=BDFaAX6tKan/pacw+3gUpQCJ/ImaPa5f9Vbhm1CVijcA/Th2kh8WFd1jQLLv6vCKMArQMXUMTEf48te0Yn1wophXmM3EGLg7d5a2GD2bENJ1LehbyXLP25I4cmwWt28wFikRfX81BKP3clal58DWyr6GvA5Ixhx+RffhubtPynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740964145; c=relaxed/simple;
	bh=1HiOL9RH+rvFiD7Cn3Np2M9s38IDFzHffazjCCdTCpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O/h1yzIxWvv+aIub77Zt8a83CFmduBRzrw+XtIs7S6hviBNaNd/ah+9071F1uL0fhoqb43gsLX76+SQCzP6AzW72ZW/xe1R9IlHR9ieIAVjI+QSVjPpNXqoW2zvMtBmz/py7VuH9ASWHHOwrmTj4S0iI94hPaAiYimtbTynzIUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z5gb63h0lzvWpr;
	Mon,  3 Mar 2025 09:05:06 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id EAA34140156;
	Mon,  3 Mar 2025 09:08:52 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Mar 2025 09:08:51 +0800
Message-ID: <95a2cb76-bade-47e0-a6fb-e22d50c13501@huawei.com>
Date: Mon, 3 Mar 2025 09:08:51 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfs: remove SB_RDONLY when remounting nfs
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <yukuai1@huaweicloud.com>, <houtao1@huawei.com>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250221082613.2674633-1-lilingfeng3@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250221082613.2674633-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Friendly ping.

Thanks.

在 2025/2/21 16:26, Li Lingfeng 写道:
> In some scenarios, when mounting NFS, more than one superblock may be
> created. The final superblock used is the last one created, but only the
> first superblock carries the ro flag passed from user space. If a ro flag
> is added to the superblock via remount, it will trigger the issue
> described in Link[1].
>
> Link[2] attempted to address this by marking the superblock as ro during
> the initial mount. However, this introduced a new problem in scenarios
> where multiple mount points share the same superblock:
> [root@a ~]# mount /dev/sdb /mnt/sdb
> [root@a ~]# echo "/mnt/sdb *(rw,no_root_squash)" > /etc/exports
> [root@a ~]# echo "/mnt/sdb/test_dir2 *(ro,no_root_squash)" >> /etc/exports
> [root@a ~]# systemctl restart nfs-server
> [root@a ~]# mount -t nfs -o rw 127.0.0.1:/mnt/sdb/test_dir1 /mnt/test_mp1
> [root@a ~]# mount | grep nfs4
> 127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (rw,relatime,...
> [root@a ~]# mount -t nfs -o ro 127.0.0.1:/mnt/sdb/test_dir2 /mnt/test_mp2
> [root@a ~]# mount | grep nfs4
> 127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (ro,relatime,...
> 127.0.0.1:/mnt/sdb/test_dir2 on /mnt/test_mp2 type nfs4 (ro,relatime,...
> [root@a ~]#
>
> When mounting the second NFS, the shared superblock is marked as ro,
> causing the previous NFS mount to become read-only.
>
> To resolve both issues, the ro flag is no longer applied to the superblock
> during remount. Instead, the ro flag on the mount is used to control
> whether the mount point is read-only.
>
> Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
> Link[1]: https://lore.kernel.org/all/20240604112636.236517-3-lilingfeng@huaweicloud.com/
> Link[2]: https://lore.kernel.org/all/20241130035818.1459775-1-lilingfeng3@huawei.com/
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   fs/nfs/super.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index aeb715b4a690..f08e1d7fb179 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1047,6 +1047,7 @@ int nfs_reconfigure(struct fs_context *fc)
>   
>   	sync_filesystem(sb);
>   
> +	fc->sb_flags &= ~SB_RDONLY;
>   	/*
>   	 * Userspace mount programs that send binary options generally send
>   	 * them populated with default values. We have no way to know which

