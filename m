Return-Path: <linux-nfs+bounces-17286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA71CD9F8C
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 17:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 977E930022FE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Dec 2025 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9623A984;
	Tue, 23 Dec 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0MlH8Dd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FA927A103
	for <linux-nfs@vger.kernel.org>; Tue, 23 Dec 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507522; cv=none; b=gZFG2ocHMNv1tw+RnChjkydbW4aXiSncu2zdE84Lerj8aY8tFpPKZv6bymJVccZXkF6IPZaGMRJS0f7Ecss6WAYF6+9j8pS5tYfY7+qa2euLA4qvrK5A9YknSfQMDEihQEk3q4DwfqfpXrsBupm1iODYiyjATf8SaHDQg8Q1oPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507522; c=relaxed/simple;
	bh=rKd0Y+07ufyjtLxVCuIk89AJ2IIDiwSGxh3yvkeoei0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=C+8eBItC/cBsZ8pbeesbU8iwboPyCBULs9QWm8dqfOdClGR0Jb0tu0Qkb67ThIDI6euSa5oiz0mjzr2jssS/86nRRgReMpqCvMn4CoTZzFVw/7Qsyt7FnvNn9GX6fKXEZlpJaBo/vx6uazhBjX0LjDq4hFu+3m0UKQPbwJwCkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0MlH8Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B609C16AAE;
	Tue, 23 Dec 2025 16:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507521;
	bh=rKd0Y+07ufyjtLxVCuIk89AJ2IIDiwSGxh3yvkeoei0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=F0MlH8DdEaw/3UxuDLR2MMSP5fdHD2WWGtE956Fl0GnACvea19zhWKvm4YQcGdqAX
	 K4Hf+wB6s0apf5VqAJJnyqykWWIRa4h49wZbrkuXKTMqBcp6pc5eU4BloyBnY04lrx
	 9dPzkwDYK74Ua1ATJlZom+6BbGCCRc7ujOyxV4QUPmyJ3whw0GwAmMXLIFvrawuXxS
	 CebaYZJXmox4rC2OZklXFXYkFSGm2F0GQzH54ucBIdUB2vUh1v5lS2tZA9Hq4JB8gM
	 RKfdZBg6jYbNMs+ro08NhuEHVPNzU1X2D4PaLXvK+hCOEcWtsGdxMW6/soMhtxzfs6
	 RqIjZz/bGrCsw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5316FF40068;
	Tue, 23 Dec 2025 11:32:00 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 23 Dec 2025 11:32:00 -0500
X-ME-Sender: <xms:AMRKaaTt4RCto40xlOfCw60hkusTGlwP1OJzBFoYfLTEK1nXjfvpVA>
    <xme:AMRKaalaclJ2d09NkSAxN-dgsYapc4UlIuex9Rn8OeteoBB0niGabpUluPjez2K3I
    GPYC6weICGRDxYH6P7mxbZ0zhqQEUIsXYhmsZVh5xIfsRI8qOCPQL4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeitdefudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:AMRKaQmZzd1FO5j2P-ScVZx0XyjTKKJgd7wUVf5iUIUU-1K3kMMBKQ>
    <xmx:AMRKaZ1cPX9_XK5iD1VP5x7f0dUk7GW7epv0H2P7aSvAo5m-w31R_A>
    <xmx:AMRKaVQLUP3g7MvHrEKfYMWqyXMMCqCwqEXDm73riZHd11DBj5ZlAg>
    <xmx:AMRKaaxIau91lDo8H7Jueg2ngX8QOP01zsIp7N7zqq7I-1BV4Fzanw>
    <xmx:AMRKadDJ3hajBlqx8s0-c6WGwfw5Q1B0rvR4rY5MAS36yC-hqEAw8XPk>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3255A78006C; Tue, 23 Dec 2025 11:32:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqDldx0SSSOk
Date: Tue, 23 Dec 2025 11:31:40 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <6ffa2b50-c0fc-4532-908e-951b224fcb10@app.fastmail.com>
In-Reply-To: <20251222190735.307006-1-dai.ngo@oracle.com>
References: <20251222190735.307006-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v3 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Dec 22, 2025, at 2:07 PM, Dai Ngo wrote:
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
> +	if (xa_is_err(entry)) {
> +		ret = xa_err(entry);
> +		goto out_free_dev;
> +	}
>  	return 0;
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
>  };
> 
>  /* struct nfs4_client_reset
> -- 
> 2.47.3

Another question is: Can cl_fenced_devs grow without bounds? What
trims items out of this xarray if the nfs4_client is long-lived?

And, let's rename the xarray cl_dev_fences, since it contains
all devices, not just fenced ones.


-- 
Chuck Lever

