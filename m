Return-Path: <linux-nfs+bounces-14580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2522B86A68
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823257C4D36
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE6027F759;
	Thu, 18 Sep 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UK2cwURD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262812571BE
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223049; cv=none; b=GlenWDLHonFBFc9NFd02ZbpauUksm31Ma3s54fHg63wp13MKLi5by3iafalCHguwObT/E6Oj3LN3kCvxNx5kfIyLacA58JV2v2m6XFdNgBOzV6QOTimqcHgXF+BOjdNDQIzxYroZn/l26Q7SwJS5RY1NfGKEYFR4hyQ3d4UEXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223049; c=relaxed/simple;
	bh=lwwVscgQoXHpXC+tr+0qNLB9CddR8mqskirSRouh5l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4o37Zt0FrIV1FHcMiWmDNjIkuAC+PoWkvSB52OuwDibWyGUvxgZhGJpZfyD1baF0utk02VFnBpb3LqfVHMIOHox/yACS41qTu/Dd4vKY8N+WssMMW7/w8V63DtnqG6lRAGtVg6Ho6q2s5g6aHISPBjtLL1hYHZF/Ks/OFCYNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UK2cwURD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE72C4CEE7;
	Thu, 18 Sep 2025 19:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223048;
	bh=lwwVscgQoXHpXC+tr+0qNLB9CddR8mqskirSRouh5l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UK2cwURDa5WeYcoC4psZnzOBaXb6euP/pSgplaDp5OJBqUTfeJjJKEwjDRdt1NjNd
	 /HFhh+1f6Q0BZtQcU4AY9gExOSML14jxitZ8u//CzogwXPB3ERLlbbdYunW0Pvgsj/
	 BpejEk1nfI05iW+584D7p9YGduOJzrfBA9uwMqdxrMUXpqYjpyA3DXoBpV4DiXZb1L
	 iHA2vvz9Kt3tbHZRxT7Vseyj//yMcXk3IYiEycxMOHk8NdainHF6DllUz5RWDxQT65
	 BauBa+sgSYxCN+uV3rPFpwb+HPF2N6wk4u0egKbfkNa5qR21Sq4+Y9QPZ3DYf1hVIy
	 NoidWGUSF0e5g==
Date: Thu, 18 Sep 2025 15:17:27 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v10 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
Message-ID: <aMxax9SBQLML8_Se@kernel.org>
References: <20250917181843.33865-1-snitzer@kernel.org>
 <20250917181843.33865-3-snitzer@kernel.org>
 <404a4c49-9e16-46d1-8901-f7a8a6a9701b@oracle.com>
 <1f740990-edac-4c41-9572-4397c138e0f3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f740990-edac-4c41-9572-4397c138e0f3@oracle.com>

On Thu, Sep 18, 2025 at 11:55:59AM -0700, Chuck Lever wrote:
> On 9/18/25 10:15 AM, Anna Schumaker wrote:
> >> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> >> index 269fa9391dc46..be710d809a3ba 100644
> >> --- a/fs/nfsd/localio.c
> >> +++ b/fs/nfsd/localio.c
> > I'll need an acked-by from Chuck or Jeff for the NFSD portions of this patch.
> 
> Doesn't this series need
> 
> https://lore.kernel.org/linux-nfs/175811950708.19474.3966708920934397510.stgit@91.116.238.104.host.secureserver.net/T/#u
> 
> as a prerequisite?

Correct, that one is needed (along with its prereqs).  Here is a git
branch I just pushed (because I'm chasing a nfstrace.h compiler issue
with/for Anna):

https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=anna-linux-next-6.18

It has the 4 NFSD prereq commits Anna needs to apply this NFS client
series (which will be going through your NFSD tree if you decide the
NFSD Direct READ support is ready).

Mike


> 
> 
> > Thanks,
> > Anna
> > 
> >> @@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
> >>  	return localio;
> >>  }
> >>  
> >> +static void nfsd_file_dio_alignment(struct nfsd_file *nf,
> >> +				    u32 *nf_dio_mem_align,
> >> +				    u32 *nf_dio_offset_align,
> >> +				    u32 *nf_dio_read_offset_align)
> >> +{
> >> +	*nf_dio_mem_align = nf->nf_dio_mem_align;
> >> +	*nf_dio_offset_align = nf->nf_dio_offset_align;
> >> +	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
> >> +}
> >> +
> >>  static const struct nfsd_localio_operations nfsd_localio_ops = {
> >>  	.nfsd_net_try_get  = nfsd_net_try_get,
> >>  	.nfsd_net_put  = nfsd_net_put,
> >>  	.nfsd_open_local_fh = nfsd_open_local_fh,
> >>  	.nfsd_file_put_local = nfsd_file_put_local,
> >>  	.nfsd_file_file = nfsd_file_file,
> >> +	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
> >>  };
> >>  
> >>  void nfsd_localio_ops_init(void)
> >> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> >> index 59ea90bd136b6..3d91043254e64 100644
> >> --- a/include/linux/nfslocalio.h
> >> +++ b/include/linux/nfslocalio.h
> >> @@ -64,6 +64,8 @@ struct nfsd_localio_operations {
> >>  						const fmode_t);
> >>  	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
> >>  	struct file *(*nfsd_file_file)(struct nfsd_file *);
> >> +	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
> >> +					u32 *, u32 *, u32 *);
> >>  } ____cacheline_aligned;
> >>  
> >>  extern void nfsd_localio_ops_init(void);
> 
> For the above hunks:
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> 
> 
> -- 
> Chuck Lever

