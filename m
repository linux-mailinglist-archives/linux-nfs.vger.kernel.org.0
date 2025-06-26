Return-Path: <linux-nfs+bounces-12794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D53AE964B
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B49E189C68B
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 06:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D24318DB1C;
	Thu, 26 Jun 2025 06:31:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FC13A3F7
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919483; cv=none; b=m0bd4iMo6fk8svmqy1q+oGK3otFidF9HCV1+97IN/FxY0oavyHbtBLL5HPTekN+sAUawhWnL2Immr0GIy/0GnVvNC+1xpLHbLLJ2Z8dPpSvcBQo/DnW7qPrjXW5niZXY5Em5AP36HISfSfjA9cRi0b09Uyu593PvgOUFJzCONdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919483; c=relaxed/simple;
	bh=MwJBYj5//W8qUHniOdnf3Orqa1weU6aNkgtZauYo2vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PUVKPBEajJGaZE4VCILO/YLcrt74/5prmqrke9yaumF3GtoruQ5rEn6avnc3dkC0+TtIZKZJkU9IrNhnrCA3m6ds38SW+l3XexRJjyFV7v7ESUbg0oP1NiL4pd7mYUSJLXeu/cx+pstdg0novMpT9twabu1rOSrhITlCIJ73JZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bSTHk49pdz2CfgT;
	Thu, 26 Jun 2025 14:27:14 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 79391140145;
	Thu, 26 Jun 2025 14:31:12 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 14:31:11 +0800
Message-ID: <05135d45-3cdc-44a6-a777-bb0e72c164eb@huawei.com>
Date: Thu, 26 Jun 2025 14:31:11 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH V2] nfs:check for user input filehandle size
To: zhangjian <zhangjian496@huawei.com>
CC: <linux-nfs@vger.kernel.org>, <steved@redhat.com>,
	<joannelkoong@gmail.com>, <chuck.lever@oracle.com>, <djwong@kernel.org>,
	<jlayton@kernel.org>, <okorniev@redhat.com>, yangerkun
	<yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao
	<houtao1@huawei.com>, "yukuai (C)" <yukuai3@huawei.com>,
	"chengzhihao1@huawei.com" <chengzhihao1@huawei.com>
References: <20250626202023.3949694-1-zhangjian496@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250626202023.3949694-1-zhangjian496@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Hi, Zhang Jian

server_fh is obtained via (struct nfs_fh *)(p + EMBED_FH_OFF). Shouldn't
the condition (char*)server_fh <= (char*)p always be false?
Additionally, (u32*)server_fh - (u32*)p + 1 appears to be a fixed value.
Why use such an expression?
Finally, fh_len is derived from user-provided handle->handle_bytes. Is
this reliable?

By the way, you shouldn't add Anna and Benjamin's Reviewd-by, because they
haven't seen this version of your changes, and they also have some
comments on your previous version of changes. Also, Jeff only gave
Reviewd-by for your previous version of changes, and your new version of
changes is different from the previous one, so you shouldn't add it.

Thanks,
Lingfeng.
在 2025/6/27 4:20, zhangjian 写道:
> Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memory
> of server_fh is not passed from user space. So I add a check for input size.
>
> Log is snipped as following:
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in nfs_fh_to_dentry+0x4ad/0x6d0 fs/nfs/export.c:70
> Read of size 2 at addr ffff888100b9ffd4 by task syz-executor301/755
>
> CPU: 1 PID: 755 Comm: syz-executor301 Tainted: G        W         5.10.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>   __dump_stack lib/dump_stack.c:82 [inline]
>   dump_stack+0x107/0x167 lib/dump_stack.c:123
>   print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
>   __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
>   kasan_report+0x3a/0x50 mm/kasan/report.c:585
>   nfs_fh_to_dentry+0x4ad/0x6d0 fs/nfs/export.c:70
>   exportfs_decode_fh_raw+0x128/0x680 fs/exportfs/expfs.c:436
>   exportfs_decode_fh+0x3d/0x90 fs/exportfs/expfs.c:575
>   do_handle_to_path fs/fhandle.c:152 [inline]
>   handle_to_path fs/fhandle.c:207 [inline]
>   do_handle_open+0x2c3/0x8d0 fs/fhandle.c:223
>   do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x67/0xd1
> ==================================================================
>
> Signed-off-by: zhangjian <zhangjian496@huawei.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Anna Schumaker <anna.schumaker@oracle.com>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>   fs/nfs/export.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index e9c233b6f..565e01788 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
>   {
>   	struct nfs_fattr *fattr = NULL;
>   	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
> -	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
> +	size_t fh_size;
>   	const struct nfs_rpc_ops *rpc_ops;
>   	struct dentry *dentry;
>   	struct inode *inode;
> -	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
> +	int len;
>   	u32 *p = fid->raw;
>   	int ret;
>   
> +	/* check for user input size */
> +	if ((char*)server_fh <= (char*)p || (int)((u32*)server_fh - (u32*)p + 1) < fh_len)
> +		return ERR_PTR(-EINVAL);
> +
> +	fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
> +	len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
> +
>   	/* NULL translates to ESTALE */
>   	if (fh_len < len || fh_type != len)
>   		return NULL;

