Return-Path: <linux-nfs+bounces-11083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D39A84589
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 16:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366AC16915A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82B528A412;
	Thu, 10 Apr 2025 14:00:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F428CF48;
	Thu, 10 Apr 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293614; cv=none; b=p0KvVkMKOxS4r/CqZVhjR6IMXHpVbH/kPyE6Q71pqZGzjsjbKhZOVEQffJb6PlqmR5VcxDkyEBLwb7weE7tPGErK8XtGKceLjUcVAcKOu3XaqzltdNbG7EquJlUE4O42NzdyoJjbjxmflJ+5QJBotojcUhkAgFsrGrsj52jLzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293614; c=relaxed/simple;
	bh=7wF8LCmsUqEp2NjHInH4TmmaQeJYNPP+02n9VYtEBHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U+/4uwgy71v+fgSXmC3y4uG2egkhl7Fe+Dra6heD7605z/h02HsnElPkez1nkTcBjq7mayUhGqwTwbzc7lpcyQLTjTu9Ug8lD+7nHNU44iole8Sxvc9sZ/8gL32XUXfbjuqQz4jdUNtuTW3qXTQNgUMOX11cJ2AGnhkQVsQ8YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZYLv11WnYzvWty;
	Thu, 10 Apr 2025 21:55:57 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AAA08140147;
	Thu, 10 Apr 2025 22:00:00 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 21:59:59 +0800
Message-ID: <6df264b9-7d87-4b35-8f56-b593097124a6@huawei.com>
Date: Thu, 10 Apr 2025 21:59:58 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nfs: Fix shift-out-of-bounds UBSAN warning with
 negative retrans
To: <trondmy@kernel.org>, <anna@kernel.org>, <rdunlap@infradead.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20250410073525.1982010-1-wangzhaolong1@huawei.com>
From: Wang Zhaolong <wangzhaolong1@huawei.com>
In-Reply-To: <20250410073525.1982010-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Friendly ping.

Perhaps the easiest way to avoid the UBSAN warning is to add a check at
the location where the warning is triggered. If a check is to be added during
the NFS mount process, then the calculation results of the two parameters passed
from user space must first be verified. This approach, however, seems somewhat
redundant.

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 0eab15465511..b714671fa418 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -654,13 +654,20 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
  static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
  		const struct rpc_timeout *to)
  {
  	unsigned long majortimeo = req->rq_timeout;
  
-	if (to->to_exponential)
-		majortimeo <<= to->to_retries;
-	else
+	if (to->to_exponential) {
+		unsigned long shifted_value;
+
+		/* Use safe left shift to avoid undefined behavior */
+		if (check_shl_overflow(majortimeo, to->to_retries,
+				       &shifted_value))
+			majortimeo = to->to_maxval;
+		else
+			majortimeo = shifted_value;
+	} else
  		majortimeo += to->to_increment * to->to_retries;
  	if (majortimeo > to->to_maxval || majortimeo == 0)
  		majortimeo = to->to_maxval;
  	return majortimeo;
  }
-- 
2.34.3

Best regards,
Wang Zhaolong


> The previous commit c09f11ef3595 ("NFS: fs_context: validate UDP retrans
> to prevent shift out-of-bounds") attempted to address UBSAN warnings by
> validating retrans values, but had two key limitations[1]:
> 
> 1. It only handled binary mount options, not validating string options
> 2. It failed to account for negative retrans values, which bypass the
>     check `data->retrans >= 64` but then get converted to large positive
>     numbers when assigned to unsigned context->retrans
> 
> When these large numbers are later used as shift amounts in
> xprt_calc_majortimeo(), they trigger the UBSAN shift-out-of-bounds
> warning. This issue has existed since early kernel versions (2.6.x series)
> as the code historically lacks proper validation of retrans values from
> userspace.
> 
> As the NFS maintainer has previously indicated that fixes to
> xprt_calc_majortimeo() wouldn't be accepted for this issue, this patch
> takes the approach of properly validating input parameters instead:
> 
> This patch:
> - Adds a proper validation check in nfs_validate_transport_protocol(),
>    which is a common code path for all mount methods (binary or string)
> - Defines a reasonable upper limit (15) that is still generous for
>    real-world requirements while preventing undefined behavior
> - Provides a clearer error message to users when rejecting values
> - Removes the incomplete check from the binary mount path
> 
> By validating the retrans parameter in a common code path, we ensure
> all mount operations have consistent behavior regardless of how the
> mount options are provided to the kernel.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219988
> [2] https://lore.kernel.org/all/5850f8a65c59436b607c9d1ac088402d14873577.camel@hammerspace.com/#t
> 
> Fixes: c09f11ef3595 ("NFS: fs_context: validate UDP retrans to prevent shift out-of-bounds")
> Signed-off-by: Wang Zhaolong <wangzhaolong1@huawei.com>
> ---
>   fs/nfs/fs_context.c | 25 +++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index 13f71ca8c974..cb3683d5d37f 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -33,10 +33,11 @@
>   #else
>   #define NFS_DEFAULT_VERSION 2
>   #endif
>   
>   #define NFS_MAX_CONNECTIONS 16
> +#define NFS_MAX_UDP_RETRANS 15
>   
>   enum nfs_param {
>   	Opt_ac,
>   	Opt_acdirmax,
>   	Opt_acdirmin,
> @@ -358,10 +359,19 @@ static int nfs_validate_transport_protocol(struct fs_context *fc,
>   {
>   	switch (ctx->nfs_server.protocol) {
>   	case XPRT_TRANSPORT_UDP:
>   		if (nfs_server_transport_udp_invalid(ctx))
>   			goto out_invalid_transport_udp;
> +		/*
> +		 * For UDP transport, retrans is used as a shift value in
> +		 * xprt_calc_majortimeo(). To prevent shift-out-of-bounds
> +		 * and overflow, limit it to 15 bits which is a reasonable
> +		 * upper limit for any real-world scenario (typical values
> +		 * are 3-5).
> +		 */
> +		if (ctx->retrans > NFS_MAX_UDP_RETRANS)
> +			goto out_invalid_udp_retrans;
>   		break;
>   	case XPRT_TRANSPORT_TCP:
>   	case XPRT_TRANSPORT_RDMA:
>   		break;
>   	default:
> @@ -378,10 +388,13 @@ static int nfs_validate_transport_protocol(struct fs_context *fc,
>   	}
>   
>   	return 0;
>   out_invalid_transport_udp:
>   	return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
> +out_invalid_udp_retrans:
> +	return nfs_invalf(fc, "NFS: UDP protocol requires retrans <= %d (got %d)",
> +			  NFS_MAX_UDP_RETRANS, ctx->retrans);
>   out_invalid_xprtsec_policy:
>   	return nfs_invalf(fc, "NFS: Transport does not support xprtsec");
>   }
>   
>   /*
> @@ -1155,19 +1168,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
>   		memcpy(mntfh->data, data->root.data, mntfh->size);
>   		if (mntfh->size < sizeof(mntfh->data))
>   			memset(mntfh->data + mntfh->size, 0,
>   			       sizeof(mntfh->data) - mntfh->size);
>   
> -		/*
> -		 * for proto == XPRT_TRANSPORT_UDP, which is what uses
> -		 * to_exponential, implying shift: limit the shift value
> -		 * to BITS_PER_LONG (majortimeo is unsigned long)
> -		 */
> -		if (!(data->flags & NFS_MOUNT_TCP)) /* this will be UDP */
> -			if (data->retrans >= 64) /* shift value is too large */
> -				goto out_invalid_data;
> -
>   		/*
>   		 * Translate to nfs_fs_context, which nfs_fill_super
>   		 * can deal with.
>   		 */
>   		ctx->flags	= data->flags & NFS_MOUNT_FLAGMASK;
> @@ -1270,13 +1274,10 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
>   out_no_address:
>   	return nfs_invalf(fc, "NFS: mount program didn't pass remote address");
>   
>   out_invalid_fh:
>   	return nfs_invalf(fc, "NFS: invalid root filehandle");
> -
> -out_invalid_data:
> -	return nfs_invalf(fc, "NFS: invalid binary mount data");
>   }
>   
>   #if IS_ENABLED(CONFIG_NFS_V4)
>   struct compat_nfs_string {
>   	compat_uint_t len;


