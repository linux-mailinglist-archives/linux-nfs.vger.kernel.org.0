Return-Path: <linux-nfs+bounces-10410-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808FA4B6C4
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 04:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C271F18874A5
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 03:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D731D517E;
	Mon,  3 Mar 2025 03:34:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5829078F54;
	Mon,  3 Mar 2025 03:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972841; cv=none; b=s+0Vye2vWLBN+Y5xxmp64Bj46Ed8zBaDX2JJPoLNm8KBDcZ/4tFTLw3uIXBjaNFCKsd0ht51GB4SPgB6jbtUoRG/FdN53uLVD/D5xc2OTQMXuMJgsMqUJhWyFY3jsu4pKPJcpmqluDJArW6u06fd8IFQWabPW4sRdMO3Xw5h53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972841; c=relaxed/simple;
	bh=bmgWyZ5dxhv2OH9PEfh+oG70EmiwdOasmha5vumDgVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nzw5Xdx9ZCf4a+D95Iri82QrfoCQRmz5vBu8XlJbHY0eWWI1ejVHBgqwsS0zcTVBZvgF2qZvPIO14XvjJh2EEkUvZNs1i0U9D31MY5SxEtNggjevRWJS7B3RXi8SpjwpgSvYy1tnuyNFB4eI6Vyh4Y5I/tqhkRHYVZJ8zFvTDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z5ktN4yCXz4f3mJF;
	Mon,  3 Mar 2025 11:33:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AFF111A06D7;
	Mon,  3 Mar 2025 11:33:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgA3m18eI8Vnqo+QFQ--.30568S3;
	Mon, 03 Mar 2025 11:33:52 +0800 (CST)
Message-ID: <aaef9940-8510-404f-bbc5-f0260ef90d21@huaweicloud.com>
Date: Mon, 3 Mar 2025 11:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs: remove SB_RDONLY when remounting nfs
To: Li Lingfeng <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ehagberg@janestreet.com, yukuai1@huaweicloud.com, houtao1@huawei.com,
 yangerkun@huawei.com, lilingfeng@huaweicloud.com, trondmy@kernel.org,
 anna@kernel.org
References: <20250221082613.2674633-1-lilingfeng3@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250221082613.2674633-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3m18eI8Vnqo+QFQ--.30568S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1rCw1rAr1xAFy3tr1DWrg_yoW5Jr47pr
	4xAF42krs5AF1agayvkF4rJ3WFqw48A3W5t3sxXw42vrWrK347XrZakr15W3yqgrZ3ua4f
	Z3W7try7Ja4DXFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/2/21 16:26, Li Lingfeng wrote:
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
>  fs/nfs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index aeb715b4a690..f08e1d7fb179 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -1047,6 +1047,7 @@ int nfs_reconfigure(struct fs_context *fc)
>  
>  	sync_filesystem(sb);
>  
> +	fc->sb_flags &= ~SB_RDONLY;

What about change sb_flags_mask instead? Something like below,

	fc->sb_flags_mask &= ~SB_RDONLY;

and I'd also suggested to add a comment to explain the reason in detail.

Thanks,
Yi.


