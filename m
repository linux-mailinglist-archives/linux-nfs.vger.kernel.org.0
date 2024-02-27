Return-Path: <linux-nfs+bounces-2096-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B86869D4C
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 18:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418C81C241EC
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDBD47A7D;
	Tue, 27 Feb 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKkcplWq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A341EB5F;
	Tue, 27 Feb 2024 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054038; cv=none; b=M+aNogxWeDObA6HO3WfVPb95W0mk5UQ9Gdmfsg+CVZOf7mOw2OD8DXO/4UmZu6NahcEtvNg1aPLF4Et8LpuuZOa+peYx/z6Z2vT0dXkEogZp9RUAP8KEOVriqyfP79cwcE8O9CnSKLT9eF9j/284MZ6HMYRu3eLEzhIjEY3O1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054038; c=relaxed/simple;
	bh=0v37LSswSidVW0pKThr3A58o/LFcsnWv3nI9rF6I7WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FigZtNRxj8bQOdKAZLAg9DsRor9KGn4MqN7/mkTeR2PyMV0ux4kqwnomkKO0C5u8/bLwhrP0WR/0INxt2imM0gVB0pdUEQsAFG0NkaZmogLbWCtpuNqifIXM0ZTPxk8JwfG1dERZ2mB8qUyRIEqgyxL7E1q4FOMSpRgVEcmLOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKkcplWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C38BC43390;
	Tue, 27 Feb 2024 17:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054038;
	bh=0v37LSswSidVW0pKThr3A58o/LFcsnWv3nI9rF6I7WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKkcplWqBftp302sFfb73n4HFlP8h0nfXp5zGxsdrf63ucryOf7WlnPFif/5Kx9AM
	 +V+/TBEIXaEDsVTVaRH7LxUYNU4yh/NNdzXxt/cx7js7IvdeTjCxodSiyoSZW2rLg+
	 nb1fNxujU/l9gdgXjvpNjfUew9utN30906mr/Pm1rhCNtKkpN3pawSMTFWkK6fVJoY
	 M6gY7PubyKo4h/8fXha/LfiypAKbtJym89Je4S5VWm/fTpg9ExIQRkSVm6w6hGD2LG
	 sbAIMWg1w0cKXeSOxylc1aUSk6CT/LqPzH1tyMl1Bq0HI2AU3Iv0dliPcrMsTDtvib
	 TXLn7R6QLGmvg==
Date: Tue, 27 Feb 2024 17:13:53 +0000
From: Simon Horman <horms@kernel.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: trond.myklebust@hammerspace.com, anna@kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com
Subject: Re: [PATCH] sunrpc: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240227171353.GE277116@kernel.org>
References: <20240224135149.830234-1-chengming.zhou@linux.dev>
 <382360c0-a120-46fc-bc59-c3c090994b83@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382360c0-a120-46fc-bc59-c3c090994b83@linux.dev>

On Mon, Feb 26, 2024 at 12:23:49PM +0800, Chengming Zhou wrote:
> On 2024/2/24 21:51, chengming.zhou@linux.dev wrote:
> > From: Chengming Zhou <zhouchengming@bytedance.com>
> > 
> > The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> > its usage so we can delete it from slab. No functional change.
> 
> Update changelog to make it clearer:
> 
> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
> removed as of v6.8-rc1, so it became a dead flag since the commit
> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
> series[1] went on to mark it obsolete to avoid confusion for users.
> Here we can just remove all its users, which has no functional change.
> 
> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
> 
> Thanks!

Thanks Chengming Zhou,

As per my comment on a similar patch [*], this seems reasonable to me. But
I think it would be best to post a v2 of this patch with the updated patch
description (which is very helpful, BTW).

[*] https://lore.kernel.org/all/20240227170937.GD277116@kernel.org/

> 
> > 
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  net/sunrpc/rpc_pipe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
> > index dcc2b4f49e77..910a5d850d04 100644
> > --- a/net/sunrpc/rpc_pipe.c
> > +++ b/net/sunrpc/rpc_pipe.c
> > @@ -1490,7 +1490,7 @@ int register_rpc_pipefs(void)
> >  	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
> >  				sizeof(struct rpc_inode),
> >  				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
> > -						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
> > +						SLAB_ACCOUNT),
> >  				init_once);

Also, while we are here, perhaps the indentation can be improved.
Something like:

	rpc_inode_cachep = kmem_cache_create("rpc_inode_cache",
				sizeof(struct rpc_inode),
				0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
				    SLAB_ACCOUNT),
				init_once);

> >  	if (!rpc_inode_cachep)
> >  		return -ENOMEM;
> 

