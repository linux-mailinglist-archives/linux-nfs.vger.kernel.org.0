Return-Path: <linux-nfs+bounces-2083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77056866953
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 05:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B0FB221CA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Feb 2024 04:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D61B810;
	Mon, 26 Feb 2024 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MYV/7Uc6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7951C1B7FB
	for <linux-nfs@vger.kernel.org>; Mon, 26 Feb 2024 04:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921449; cv=none; b=sqSSJaXxgVn0/6iyC7VWIea1lm/Rf+Zwp2bYU9weElktTMlsTGj8ZvD6qAgtbK3Me6HSujojqmMYao1DN2pWRPNJcSgU0O4jqpBITPqJKSlkyDZ0U3F87bQCVYtAi5tnPgVhxmNd+vFewkOawwbMbACNpovdm+ue2A3DqOxRoI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921449; c=relaxed/simple;
	bh=jP2Ym/M+PdBLVrz55q8zbolMHuXaATFfBtA5RROiS1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6gi7khUTC/5BApGzzLYGMLoT2eEAeeOeCZXgxk+EOrOJtK4URvYuJVFFNElYbjCDO1HVXjeq76mhsk/PoHxeEo6kVQ64DAnKe/U0p9mO4RmfIpyMR3qIFbQNAcVH441yLZnAMPgrUjpxRP6zMmTIdiHbdr/Iicq6qgCsa5rWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MYV/7Uc6; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <382360c0-a120-46fc-bc59-c3c090994b83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708921445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzrMk8FgJa5LDzJik8D276TdB01ODO8SlJG3MdCuN2A=;
	b=MYV/7Uc6JQzreEl1TddFIIj2+1eDzFegXu3wZfaKIAqGyhNQ1s+ljn1xFtLwRQg1sKn6fm
	idxCm/d4CNvlmmp4RhKqh9o/p1p2rFFkiSLfRW40pzNsIkMIv2o7WdJqDjKxsKlZe4Hmfd
	fahyE4kVgkxO7twEnf0AMd7ef5MNTsY=
Date: Mon, 26 Feb 2024 12:23:49 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sunrpc: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: trond.myklebust@hammerspace.com, anna@kernel.org, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, kolga@netapp.com
Cc: Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com
References: <20240224135149.830234-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224135149.830234-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:51, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  net/sunrpc/rpc_pipe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> index dcc2b4f49e77..910a5d850d04 100644
> --- a/net/sunrpc/rpc_pipe.c
> +++ b/net/sunrpc/rpc_pipe.c
> @@ -1490,7 +1490,7 @@ int register_rpc_pipefs(void)
>  	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
>  				sizeof(struct rpc_inode),
>  				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> +						SLAB_ACCOUNT),
>  				init_once);
>  	if (!rpc_inode_cachep)
>  		return -ENOMEM;

