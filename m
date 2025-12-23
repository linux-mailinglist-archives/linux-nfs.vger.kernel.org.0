Return-Path: <linux-nfs+bounces-17284-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E670CD9C82
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 16:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C5A6302E05C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DE029ACDB;
	Tue, 23 Dec 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWh1+MFP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5029993D
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766503987; cv=none; b=Rc8VDzjTXgygQwHEwDjIMxJNPQ2snTxhlZ1UjeqjBHcAl7BSMRoIoaK8uS98KSWO4XFiHklANh5UECbG+TXZF61KWHfQ/ry2myeCHkgaLWUeak2pCsm5J8SxHLp6jYF8Yi7iN48GqQBt7xW1JekV9dW0prJGmtEZs/YmhhLEgjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766503987; c=relaxed/simple;
	bh=Io3kqIxBK6BGESoICdJDYv23debj8rPPpL7dnJtWnuA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XiX0YivMisuu3GtsHy9aPFeH7Rt9uaEUDHU5+endARC2yi3Tv2CUUmkEZR/bENISx0PUOGNrm3vt0cTvWXLKH9Oklf2+0POpcix0iAjkSAaWL/CbGbo7oL1KtticcWgH/VV1JvUKuG5qOVg0JsuX+2EqblcfvaO4qgZfsqtM3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWh1+MFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6898C113D0;
	Tue, 23 Dec 2025 15:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766503987;
	bh=Io3kqIxBK6BGESoICdJDYv23debj8rPPpL7dnJtWnuA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pWh1+MFPFR2Mtl2h0uhmTMtNnMKNdh4Ciz9sKKlJ+LqcthLG2TNqiGh56nHxaYnu8
	 hccoeJb+KqhNW3VPcKhq6pbQ7WRp5eUDtWFpE9ULKdcwjgwRYB6Hflrw/XsiPJFBS3
	 IuO98oWQWJ3phJgtqEGIVYXaX1mdWRWTI0RRI6XZFl9SgJR7G5ISpotY2eq717bJSP
	 EWb1RU0ZC5HI3rI38cmxNomL7FW1W5AtpWG4qTHIfEy1AQK/Qrw6GXAQAbOZF6+TmB
	 O5TC2/PC8i7knefRd1SJevDPWdPybkYYDeIUC4i4kELPywNzn2MtNLFfn1zXVjZfqp
	 +GdH/2A/jMEig==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id F19ABF4006B;
	Tue, 23 Dec 2025 10:33:05 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 23 Dec 2025 10:33:05 -0500
X-ME-Sender: <xms:MbZKadub_-YJPwSGQWYSDorH78VpFSgyasJ-4C7pyrFw106BJq5u9g>
    <xme:MbZKaRTyTnSi5tPo7GEPVAy4T9OLZfXMFYf3JEdCqA3l_Pe0Pdczk3Y38CI_hFwmf
    LJZvjVLcv1hD5yuKSTLmgh0aG6GhfZUKXvLGMkyOwb7gkP1zTDHu9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhsehlsh
    htrdguvgdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehnvg
    hilhgssehofihnmhgrihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtth
    hopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MbZKafDKBF5RpTRYJ8scXly6UlxHlsV3B0KIWxyqAnYot8fbc90eEw>
    <xmx:MbZKafglhwCtbU1zWUvdDi0Q1uYQjecDlr2KbUw52VBFCHl6D4vbZw>
    <xmx:MbZKaROJht7UCpDDvciQ3U14-d2y6Kyqk6xMNdhFBPnODZiOFEW8vQ>
    <xmx:MbZKaf9sq1bJdPKEkqiZetJHp9-ZOLdmZjIesFFBU76ZxhW8-Ra0mw>
    <xmx:MbZKaSfTwQrynh6Fb-lGFKkIHug3SOt-ApR8e-uXKWJxP6p0oHubZao->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB61D78006C; Tue, 23 Dec 2025 10:33:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqDldx0SSSOk
Date: Tue, 23 Dec 2025 10:32:44 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <f6acff74-5276-4ad5-867c-e5236624ff95@app.fastmail.com>
In-Reply-To: <20251222190735.307006-1-dai.ngo@oracle.com>
References: <20251222190735.307006-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey Dai -

This is getting closer, so I'm going to give more detailed comments.

On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:

The patch description needs to open with explaining why this change
is needed.

In particular, are you trying to prevent duplicate fencing to
avoid a protocol error, or is this only a performance optimization?


> Update the NFS server to handle SCSI persistent registration fencing on
> a per-client and per-device basis by utilizing an xarray associated with
> the nfs4_client structure.
>
> Each xarray entry is indexed by the dev_t of a block device registered
> by the client. The entry maintains a flag indicating whether this device
> has already been fenced for the corresponding client.
>
> When the server issues a persistent registration key to a client, it
> creates a new xarray entry at the dev_t index with the fenced flag
> initialized to 0.
>
> Before performing a fence via nfsd4_scsi_fence_client, the server
> checks the corresponding entry using the device's dev_t. If the fenced
> flag is already set, the fence operation is skipped; otherwise, the
> flag is set to 1 and fencing proceeds.
>
> The xarray is destroyed when the nfs4_client is released in
> __destroy_client.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 26 ++++++++++++++++++++++++++
>  fs/nfsd/nfs4state.c   |  6 ++++++
>  fs/nfsd/state.h       |  2 ++
>  3 files changed, 34 insertions(+)
>
> V2:
>    . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>      memory allocation in nfsd4_scsi_fence_client.
>    . Remove cl_fence_lock, use xa_lock instead.
> V3:
>    . handle xa_store error.
>    . add xa_lock and xa_unlock when calling xas_clear_mark
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..bcacd030d84a 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>  	struct pnfs_block_volume *b;
>  	const struct pr_ops *ops;
>  	int ret;
> +	void *entry;
> 
>  	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>  	if (!dev)
> @@ -357,6 +358,13 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>  		goto out_free_dev;
>  	}
> 
> +	/* create a record for this client with the fenced flag set to 0 */
> +	entry = xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
> +				xa_mk_value(0), GFP_KERNEL);

What if there's already an entry for bd_dev in the xarray?


> +	if (xa_is_err(entry)) {
> +		ret = xa_err(entry);
> +		goto out_free_dev;

Does this error flow also need to release the newly acquired
persistent reservation for bd_dev?


> +	}
>  	return 0;

Perhaps it would be better to check the array first before
attempting the pr_register call, to see if the device has
already been registered, since xa_load() will be an atomic
check. That would avoid a double persistent registration
(but please confirm that avoids all races... it might not).


> 
>  out_free_dev:
> @@ -400,10 +408,28 @@ nfsd4_scsi_fence_client(struct 
> nfs4_layout_stateid *ls, struct nfsd_file *file)
>  	struct nfs4_client *clp = ls->ls_stid.sc_client;
>  	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>  	int status;
> +	void *entry;
> +	XA_STATE(xas, &clp->cl_fenced_devs, bdev->bd_dev);
> +
> +	xa_lock(&clp->cl_fenced_devs);
> +	entry = xas_load(&xas);
> +	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
> +		/* device already fenced */
> +		xa_unlock(&clp->cl_fenced_devs);
> +		return;
> +	}
> +	/* Set the fenced flag for this device. */
> +	xas_set_mark(&xas, XA_MARK_0);
> +	xa_unlock(&clp->cl_fenced_devs);
> 
>  	status = bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp),
>  			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> +	if (status) {
> +		xa_lock(&clp->cl_fenced_devs);
> +		xas_clear_mark(&xas, XA_MARK_0);
> +		xa_unlock(&clp->cl_fenced_devs);

After the xa_lock is released above, cl_fenced_devs can be altered
by another process. So you can't trust that "xas" is not stale in
the error flow.

Actually I don't see a need to open-code the array walk to mark
the device fenced, unless I've missed something. For setting the
mark, you could simply do this:

  xa_lock(&clp->cl_fenced_devs);
  if (xa_get_mark(&clp->cl_fenced_devs, bdev->bd_dev, XA_MARK_0)) {
  	xa_unlock(&clp->cl_fenced_devs);
  	return;
  }
  __xa_set_mark(&clp->cl_fenced_devs, bdev->bd_dev, XA_MARK_0);
  xa_unlock(&clp->cl_fenced_devs);

And then just use xa_clear_mark() in the error flow, which has
its own XA_STATE and does a fresh array walk, instead of
xas_clear_mark().

And then you won't need XA_STATE at all.


> +	}
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>  }
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 808c24fb5c9a..2d4a198fe41d 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct 
> xdr_netobj name,
>  	INIT_LIST_HEAD(&clp->cl_revoked);
>  #ifdef CONFIG_NFSD_PNFS
>  	INIT_LIST_HEAD(&clp->cl_lo_states);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_init(&clp->cl_fenced_devs);
> +#endif
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> @@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
>  		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>  	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>  	nfsd4_dec_courtesy_client_count(nn, clp);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_destroy(&clp->cl_fenced_devs);
> +#endif
>  	free_client(clp);
>  	wake_up_all(&expiry_wq);
>  }
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index b052c1effdc5..8dd6f82e57de 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -527,6 +527,8 @@ struct nfs4_client {
> 
>  	struct nfsd4_cb_recall_any	*cl_ra;
>  	time64_t		cl_ra_time;
> +
> +	struct xarray		cl_fenced_devs;

Please wrap the definition of cl_fenced_devs with
"#ifdef CONFIG_NFSD_SCSILAYOUT" followed by "#endif"


>  };
> 
>  /* struct nfs4_client_reset
> -- 
> 2.47.3

-- 
Chuck Lever

