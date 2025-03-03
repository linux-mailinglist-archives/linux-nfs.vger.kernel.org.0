Return-Path: <linux-nfs+bounces-10412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32BA4C118
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 13:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39E7B188B014
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FA20C013;
	Mon,  3 Mar 2025 12:58:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB720E323;
	Mon,  3 Mar 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006711; cv=none; b=k4Q/T1Mwclu77cxbIgLQf2T8ywEaJJ5aXPbeQIUL1tpFr3An1CGax7LPevuKjezOGFXlSyya/F8gJUYAbONhLtxAiLE2rJPRRNe/v/LHc8T8xCcTm1YWzBpqGI8Ypuu8QUxkaBVjswrZA6yo6IsjyS6ngH1Mn+Fq5m9oB8JgbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006711; c=relaxed/simple;
	bh=iWahLqMzdktqbshB5XT5hdP9Q547FiwDU5UH2GtTHhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RX0tnXAaLB+6HAlHpqtA3APLWsfv+8YuW+YcDxE21H5WT/cQQBn3Y9BK5cJtGaGc22o+VNWz6D57V8DLo6DwGhrCLIV5zGcBmPiz+vpJai2Eky5soHlmpGj/IBcMeq8gejMuBKdoGtW0csOrTdRA9AITNYMdV7HYXfGTlvGxYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z5zQj1rJxz17NWr;
	Mon,  3 Mar 2025 20:58:53 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 067D3180069;
	Mon,  3 Mar 2025 20:58:20 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Mar 2025 20:58:19 +0800
Message-ID: <9cb1493b-b2b2-4a5a-a71f-bfae5c2db8bc@huawei.com>
Date: Mon, 3 Mar 2025 20:58:18 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nfs: remove SB_RDONLY when remounting nfs
To: Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <yukuai1@huaweicloud.com>, <houtao1@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>, <trondmy@kernel.org>,
	<anna@kernel.org>
References: <20250221082613.2674633-1-lilingfeng3@huawei.com>
 <aaef9940-8510-404f-bbc5-f0260ef90d21@huaweicloud.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <aaef9940-8510-404f-bbc5-f0260ef90d21@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/3/3 11:33, Zhang Yi 写道:
> On 2025/2/21 16:26, Li Lingfeng wrote:
>> In some scenarios, when mounting NFS, more than one superblock may be
>> created. The final superblock used is the last one created, but only the
>> first superblock carries the ro flag passed from user space. If a ro flag
>> is added to the superblock via remount, it will trigger the issue
>> described in Link[1].
>>
>> Link[2] attempted to address this by marking the superblock as ro during
>> the initial mount. However, this introduced a new problem in scenarios
>> where multiple mount points share the same superblock:
>> [root@a ~]# mount /dev/sdb /mnt/sdb
>> [root@a ~]# echo "/mnt/sdb *(rw,no_root_squash)" > /etc/exports
>> [root@a ~]# echo "/mnt/sdb/test_dir2 *(ro,no_root_squash)" >> /etc/exports
>> [root@a ~]# systemctl restart nfs-server
>> [root@a ~]# mount -t nfs -o rw 127.0.0.1:/mnt/sdb/test_dir1 /mnt/test_mp1
>> [root@a ~]# mount | grep nfs4
>> 127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (rw,relatime,...
>> [root@a ~]# mount -t nfs -o ro 127.0.0.1:/mnt/sdb/test_dir2 /mnt/test_mp2
>> [root@a ~]# mount | grep nfs4
>> 127.0.0.1:/mnt/sdb/test_dir1 on /mnt/test_mp1 type nfs4 (ro,relatime,...
>> 127.0.0.1:/mnt/sdb/test_dir2 on /mnt/test_mp2 type nfs4 (ro,relatime,...
>> [root@a ~]#
>>
>> When mounting the second NFS, the shared superblock is marked as ro,
>> causing the previous NFS mount to become read-only.
>>
>> To resolve both issues, the ro flag is no longer applied to the superblock
>> during remount. Instead, the ro flag on the mount is used to control
>> whether the mount point is read-only.
>>
>> Fixes: 281cad46b34d ("NFS: Create a submount rpc_op")
>> Link[1]: https://lore.kernel.org/all/20240604112636.236517-3-lilingfeng@huaweicloud.com/
>> Link[2]: https://lore.kernel.org/all/20241130035818.1459775-1-lilingfeng3@huawei.com/
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfs/super.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
>> index aeb715b4a690..f08e1d7fb179 100644
>> --- a/fs/nfs/super.c
>> +++ b/fs/nfs/super.c
>> @@ -1047,6 +1047,7 @@ int nfs_reconfigure(struct fs_context *fc)
>>   
>>   	sync_filesystem(sb);
>>   
>> +	fc->sb_flags &= ~SB_RDONLY;
> What about change sb_flags_mask instead? Something like below,
>
> 	fc->sb_flags_mask &= ~SB_RDONLY;
>
> and I'd also suggested to add a comment to explain the reason in detail.
>
> Thanks,
> Yi.

Thanks for your advice.  I will send v2 soon.


