Return-Path: <linux-nfs+bounces-13183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B69CB0DE89
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D610582B5D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E424467B;
	Tue, 22 Jul 2025 14:18:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2163548EE
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193884; cv=none; b=RiehEqXtVgqaz0tCd3U6KE7JtLU/kiS1rQdtyMPN7Fzppubp6x3FmObxkgjok/2Ip7tgzrlLVDFRKn+LdjP1SJ7QcmMKAT8NF6Jp0IUgtkNaUt54sgELjlvL+GBTySyvmTLzzaCUc3t5bixr6kmq4Q4lfaJzU/820KrncPfqYrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193884; c=relaxed/simple;
	bh=MtWRh3nPljD/IVhRVpH/zDibaKjEVd079oq2v8V5tso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JccpYjey8EJsyjMkUM9Bkx+/PEh+YVshrXJB2w2LQfj/YSLfXmdS6qidjHUThBOsFrsEKBuFo8sSmOasA5sPW10hUxXc3XY5GuVgHFOW3LZA7eLuQ+UihVU2zlApQurNNw8JX8+rop3fq2LkdGv/qpU2it0V8ttaLQ/oS/ntffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bmfRn0nKxz1R8d3;
	Tue, 22 Jul 2025 22:15:17 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B7A01402C1;
	Tue, 22 Jul 2025 22:17:57 +0800 (CST)
Received: from [10.174.186.66] (10.174.186.66) by
 kwepemp200004.china.huawei.com (7.202.195.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 22 Jul 2025 22:17:56 +0800
Message-ID: <838a9fd6-2a22-4677-9a50-c48341faf08b@huawei.com>
Date: Tue, 22 Jul 2025 22:17:55 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFS: Fix filehandle bounds checking in nfs_fh_to_dentry()
To: Trond Myklebust <trondmy@kernel.org>, <linux-nfs@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>
References: <ef93a685e01a281b5e2a25ce4e3428cf9371a205.1753192530.git.trond.myklebust@hammerspace.com>
From: "zhangjian (CG)" <zhangjian496@huawei.com>
In-Reply-To: <ef93a685e01a281b5e2a25ce4e3428cf9371a205.1753192530.git.trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemp200004.china.huawei.com (7.202.195.99)



On 2025/7/22 21:58, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> The function needs to check the minimal filehandle length before it can
> access the embedded filehandle.
> 
> Reported-by: zhangjian <zhangjian496@huawei.com>
> Fixes: 20fa19027286 ("nfs: add export operations")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/export.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfs/export.c b/fs/nfs/export.c
> index e9c233b6fd20..a10dd5f9d078 100644
> --- a/fs/nfs/export.c
> +++ b/fs/nfs/export.c
> @@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
>  {
>  	struct nfs_fattr *fattr = NULL;
>  	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
> -	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
> +	size_t fh_size = offsetof(struct nfs_fh, data);
>  	const struct nfs_rpc_ops *rpc_ops;
>  	struct dentry *dentry;
>  	struct inode *inode;
> -	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
> +	int len = EMBED_FH_OFF;
>  	u32 *p = fid->raw;
>  	int ret;
>  
> +	/* Initial check of bounds */
> +	if (fh_len < len + XDR_QUADLEN(fh_size) ||
> +	    fh_len > XDR_QUADLEN(NFS_MAXFHSIZE))
> +		return NULL;

May this return ERR_PTR(-EINVAL) instead of NULL?
I'm not sure if it is expected to be translated as ESTALE.

> +	/* Calculate embedded filehandle size */
> +	fh_size += server_fh->size;
> +	len += XDR_QUADLEN(fh_size);
>  	/* NULL translates to ESTALE */
>  	if (fh_len < len || fh_type != len)
>  		return NULL;


