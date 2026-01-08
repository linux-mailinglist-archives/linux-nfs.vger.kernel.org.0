Return-Path: <linux-nfs+bounces-17667-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4D4D05F90
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 21:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31AD8300EB8D
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 20:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEA328B43;
	Thu,  8 Jan 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7e+AY7F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C31DDC07;
	Thu,  8 Jan 2026 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902669; cv=none; b=Nr6DZ7zCEXvghrTNzo5hPW/4mRStaOJCyDUSMmHBDp0feXa4I/iah24tA8C9p4ZQ0n5hL19w/pEhwhQfnyJvpCMC2ZDvr/Uq69kfWVc+58rncbCUMa0RpfMGQA5RJLW5yzwlpKvs16IcDEQL1BPp7dSgqOUFVNNeZK8p0tNOIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902669; c=relaxed/simple;
	bh=lBrTB4QVmI0Qhx1ciWQ3Yr1uvnleRL1y77uGdPlq11E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sb9D3JJtlCWR7ugaiIkRR4k3aVSks6AXfhBnbPfI7FPw/yIwd9Cx5RlV9d5iXusKV17c8STY/Zr8r+/nUUGvzgwLxUjjcDf59H9fe5Oromjx1nxcPvbPKmJ9nH9sKYOx39yKeGuuTM7mqbC0BuiPdFoSSVzpOvBMwuEuc7Kj/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7e+AY7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD7BC116C6;
	Thu,  8 Jan 2026 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767902668;
	bh=lBrTB4QVmI0Qhx1ciWQ3Yr1uvnleRL1y77uGdPlq11E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d7e+AY7FiqqL2/Fh3kTOCLixpXWhro+SnpCs49yrYD6uNtaYqIwbUr5NNmNeXhlAY
	 DEgcjkkfyVPTFCkWldjil97guXcvbjSatVTTSYVO/EJrN3CbEbD9OOEVtfDskDp6VK
	 smrGB6wxYYMOWrDE3q4OjRFplQvVhGjefUPOU7/sZWpOg+PsZ+0qgcMzzDOLJEF07g
	 YLlwVGFv8RJBvzIZBnke9FjCZLdcDCNf5U+/OFxJUjKJFgWiRmv24N9YiCOR7s2iLd
	 F7zCiSHGIBW7cMf+uNFnjwGw8K+q034JqcaMi6+4dsaIx/csE0kHHySuy5f81FXPNP
	 ciXNsM3wNV+5g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B9CBDF4006D;
	Thu,  8 Jan 2026 15:04:27 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 08 Jan 2026 15:04:27 -0500
X-ME-Sender: <xms:yw1gabuge-Bt_coaCMc-eFQyij1-oLZy5_rdpO6hL0jdEDTMWKk2kA>
    <xme:yw1gaXRF_tjH2rvb5G2d6VXM_kZSFGuL9SvYekA4umFxhkzcr747-TqVm-GdQXbog
    BwUOz4nTh9FCTN4vj0P8rQD3N9D-pHi9wkHVTxbPUxyQS39E6QyAQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeikeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejvefhudehleetvdejhfejvefghfelgeejvedvgfduuefffeegtdejuefhiedukeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    peehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yw1gaV6EawdDJLaW_4zzvpfqkqZoTZvj55brzCI31rvSVGl_s5RVuQ>
    <xmx:yw1gab0pWFCSrKbr5ESDnE3tP83sQ0c8kIgCelXzEYpzqBT5kEcUrw>
    <xmx:yw1gaYDbfiF2HbPh_lUo3snrqqIF0AuQRoI6H91bfGd5HCNXk3Ji5w>
    <xmx:yw1gaeO2qY3uw9PB8b6mU1SqJgFXZEYOiuIp58wEEHhUUY-yRuhhWw>
    <xmx:yw1gaVYrmoeamgDQqX1ykwxt3f_idZeGzg4BlLx_8IkQxLUjb84Q8Oj0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C94378006C; Thu,  8 Jan 2026 15:04:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AUhaZbciXRC-
Date: Thu, 08 Jan 2026 15:04:07 -0500
From: "Chuck Lever" <cel@kernel.org>
To: stable@vger.kernel.org
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Sasha Levin" <sashal@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Message-Id: <e655c07e-cf69-4466-961d-ffc39586dea9@app.fastmail.com>
In-Reply-To: <20260108191002.4071603-2-cel@kernel.org>
References: <2025122941-civic-revered-b250@gregkh>
 <20260108191002.4071603-2-cel@kernel.org>
Subject: Re: [PATCH 6.6.y v2 1/4] nfsd: convert to new timestamp accessors
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Jan 8, 2026, at 2:09 PM, Chuck Lever wrote:
> From: Jeff Layton <jlayton@kernel.org>
>
> [ Upstream commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3 ]
>
> Convert to using the new inode timestamp accessor functions.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Link: https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kernel.org
> Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

> ---
>  fs/nfsd/blocklayout.c | 4 +++-
>  fs/nfsd/nfs3proc.c    | 4 ++--
>  fs/nfsd/nfs4proc.c    | 8 ++++----
>  fs/nfsd/nfsctl.c      | 2 +-
>  fs/nfsd/vfs.c         | 2 +-
>  5 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 59f119cce3dc..db4b67523934 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -117,11 +117,13 @@ static __be32
>  nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
>  		struct iomap *iomaps, int nr_iomaps)
>  {
> +	struct timespec64 mtime = inode_get_mtime(inode);
> +	loff_t new_size = lcp->lc_last_wr + 1;
>  	struct iattr iattr = { .ia_valid = 0 };
>  	int error;
> 
>  	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
> -	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
> +	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
>  		lcp->lc_mtime = current_time(inode);
>  	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
>  	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 268ef57751c4..666bad8182e5 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct 
> svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS3_CREATE_EXCLUSIVE:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
> +			    inode_get_atime_sec(d_inode(child)) == v_atime &&
>  			    d_inode(child)->i_size == 0) {
>  				break;
>  			}
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 886c09267544..37b918e4a53d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct 
> svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS4_CREATE_EXCLUSIVE:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
> +			    inode_get_atime_sec(d_inode(child)) == v_atime &&
>  			    d_inode(child)->i_size == 0) {
>  				open->op_created = true;
>  				break;		/* subtle */
> @@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct 
> svc_fh *fhp,
>  			status = nfserr_exist;
>  			break;
>  		case NFS4_CREATE_EXCLUSIVE4_1:
> -			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
> -			    d_inode(child)->i_atime.tv_sec == v_atime &&
> +			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
> +			    inode_get_atime_sec(d_inode(child)) == v_atime &&
>  			    d_inode(child)->i_size == 0) {
>  				open->op_created = true;
>  				goto set_attr;	/* subtle */
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 887035b74467..81e0b4726567 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1140,7 +1140,7 @@ static struct inode *nfsd_get_inode(struct 
> super_block *sb, umode_t mode)
>  	/* Following advice from simple_fill_super documentation: */
>  	inode->i_ino = iunique(sb, NFSD_MaxReserved);
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> +	simple_inode_init_ts(inode);
>  	switch (mode & S_IFMT) {
>  	case S_IFDIR:
>  		inode->i_fop = &simple_dir_operations;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 5ee7149ceaa5..1faf65147223 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -521,7 +521,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh 
> *fhp,
> 
>  	nfsd_sanitize_attrs(inode, iap);
> 
> -	if (check_guard && guardtime != inode_get_ctime(inode).tv_sec)
> +	if (check_guard && guardtime != inode_get_ctime_sec(inode))
>  		return nfserr_notsync;
> 
>  	/*
> -- 
> 2.52.0

-- 
Chuck Lever

