Return-Path: <linux-nfs+bounces-17249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E204CD435E
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Dec 2025 18:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D870030019DF
	for <lists+linux-nfs@lfdr.de>; Sun, 21 Dec 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B9221264;
	Sun, 21 Dec 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4WFkdbd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE01EEA49
	for <linux-nfs@vger.kernel.org>; Sun, 21 Dec 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766337756; cv=none; b=kC0zTVJPFESQB6gru1Iy1j+auAMmlIsrP9fRZMcbj3mEVcqfNILv1LbAABB2hfGwfWogLjMc7rP/DQrU10UNjDdsGYbG0Z3T9ZZtKVtmopnTTT21P/esxrpklA7Uei1zJXSiPs0fKFdzEgrtsBtpSc5RRCePH4ybzDqIjG2ScyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766337756; c=relaxed/simple;
	bh=nxyQ+FUEmVsS+R5Vp7wUHvZFY+HLzFGP4Y5uOy8rjYg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eY/06DW5QSAHLUA/N+Mj9glfJXGhTOToNaSrjZ/I2yVya28DA3M0WOwNU7p8EyoPe1471ivlS5c3QNTGEOwhP0QLMe+CO6EldFfWrKgm124z4X/kkSWMpHQeRIT1ohgj+236p+J2Vj209fdk+LOUve25ks+KiIVLdmrfBcOhE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4WFkdbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4AC4AF0B;
	Sun, 21 Dec 2025 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766337755;
	bh=nxyQ+FUEmVsS+R5Vp7wUHvZFY+HLzFGP4Y5uOy8rjYg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H4WFkdbdgjgu5LpSnTK5iL3sZ8J4p9gxgj2SJD5LP3An1ZfMf0kwD1Mm4aYJVjHx0
	 2Z1fP0Fm0B0b9gBfaUoZtJu8Ku2e4FMHZulcRrcjJQ79Afh4YM78dDYlXWxNvsW9GZ
	 ARQ/phtXkW1DJYGSTBa84ChyllkeNJcGJHEoHpVsZEO61NIZSg6OXsfUZFivxN1cAg
	 zkR2h4y01oSTN67iVRo7+nT3Zzk72je/msiyIpWhrBU2AEi3Rm4R4LTeMmHuHwV6eQ
	 phx0ZcwIZ7AQxyC9QEmeDfBr51BZuVgUpLBNclTZLebkNsrwYdrlYs8xfmokcDcB+Y
	 0bbiJG+47egVA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B0EFEF4006C;
	Sun, 21 Dec 2025 12:22:34 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 21 Dec 2025 12:22:34 -0500
X-ME-Sender: <xms:2ixIafYHbifxPn9hK5wYK7sKmj3VU5ItvzlznBeGRnjNqCF6mDcA3A>
    <xme:2ixIaZM7VytbxLvRWRN9s9z78mJDHi9AwfveRN5lSEbKCT_3qXnR2Jxn46c3TLytU
    RRAfU3kt81UObGy7cdBOqL_IZUtyVueywLxlnKtlUA3_u-udxWbTvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgffhgeeutdeiieevuefgvedtjeefudekvefggefguefgtefgledtteeuleelleetnecu
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
X-ME-Proxy: <xmx:2ixIafvnXfd0ki5YQMk8RjS6FtHcGUzaXtz702duBZoVhe_h4l2cfw>
    <xmx:2ixIaadltKvIP8lOTqNp5dQ2XkMT5JxmxKn1Wkd1d14RrLEiL0g5Fg>
    <xmx:2ixIaZbgVd-IsZ-a7wG86y3c0uUd96Yv1kIQB2a-i-GX2T4XpwAtBw>
    <xmx:2ixIacZhVz7gfOKV3G8y0irBS05XdujW28PWrjUU7-AekLwnSu00KA>
    <xmx:2ixIaeLVV2ZK4LQ5fSPRWEXOo0kVh-mQNWLYV9xfl0f56ZDd-YhNAGZ0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EA38780054; Sun, 21 Dec 2025 12:22:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5F7wq9iGfVk
Date: Sun, 21 Dec 2025 12:21:29 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <0788a953-b5d8-4468-8db3-b1afa00ab844@app.fastmail.com>
In-Reply-To: <20251220231816.31848-1-dai.ngo@oracle.com>
References: <20251220231816.31848-1-dai.ngo@oracle.com>
Subject: Re: [PATCH 1/1] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Dec 20, 2025, at 6:17 PM, Dai Ngo wrote:
> Update the NFS server to handle SCSI persistent registration fencing on
> a per-client and per-device basis by utilizing an xarray associated wi=
th
> the nfs4_client structure.
>
> Each xarray entry is indexed by the dev_t of a block device registered
> by the client. The entry maintains a flag indicating whether this devi=
ce
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
> All entries in the xarray, as well as the xarray itself, are freed
> when the nfs4_client is released in __destroy_client.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 27 ++++++++++++++++++++++++++-
>  fs/nfsd/nfs4state.c   |  7 +++++++
>  fs/nfsd/state.h       |  3 +++
>  3 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..f619de53eec6 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_bloc=
k *sb,
>  		goto out_free_dev;
>  	}
>=20
> +	/* create a record for this client with the fenced flag set to 0 */
> +	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
> +				xa_mk_value(0), GFP_KERNEL);
>  	return 0;
>=20
>  out_free_dev:
> @@ -400,10 +403,31 @@ nfsd4_scsi_fence_client(struct=20
> nfs4_layout_stateid *ls, struct nfsd_file *file)
>  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
>  	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_b=
dev;
>  	int status;
> -
> +	void *val;
> +
> +	spin_lock(&clp->cl_fence_lock);
> +	val =3D xa_load(&clp->cl_fenced_devs, bdev->bd_dev);
> +	if (xa_is_value(val) && xa_to_value(val)) {
> +		/* device already fenced */
> +		spin_unlock(&clp->cl_fence_lock);
> +		return;
> +	}
> +	/*
> +	 * Set the fenced flag for this device.
> +	 *
> +	 * A record for this device should already exist, so no memory
> +	 * allocation is required. The GFP_ATOMIC flag is specified for
> +	 * safety, as the spinlock cl_fence_lock is held.
> +	 */
> +	xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
> +				xa_mk_value(1), GFP_ATOMIC);
> +	spin_unlock(&clp->cl_fence_lock);
>  	status =3D bdev->bd_disk->fops->pr_ops->pr_preempt(bdev,=20
> NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp),
>  			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> +	if (status)
> +		xa_store(&clp->cl_fenced_devs, (unsigned long)bdev->bd_dev,
> +				xa_mk_value(0), GFP_KERNEL);
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>  }
>=20
> @@ -426,4 +450,5 @@ const struct nfsd4_layout_ops scsi_layout_ops =3D {
>  	.proc_layoutcommit	=3D nfsd4_scsi_proc_layoutcommit,
>  	.fence_client		=3D nfsd4_scsi_fence_client,
>  };
> +
>  #endif /* CONFIG_NFSD_SCSILAYOUT */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 808c24fb5c9a..44e6222ad9e5 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2381,6 +2381,10 @@ static struct nfs4_client *alloc_client(struct=20
> xdr_netobj name,
>  	INIT_LIST_HEAD(&clp->cl_revoked);
>  #ifdef CONFIG_NFSD_PNFS
>  	INIT_LIST_HEAD(&clp->cl_lo_states);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	spin_lock_init(&clp->cl_fence_lock);
> +	xa_init(&clp->cl_fenced_devs);
> +#endif
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> @@ -2537,6 +2541,9 @@ __destroy_client(struct nfs4_client *clp)
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
> index b052c1effdc5..db6980f112ce 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -527,6 +527,9 @@ struct nfs4_client {
>=20
>  	struct nfsd4_cb_recall_any	*cl_ra;
>  	time64_t		cl_ra_time;
> +

#ifdef CONFIG_NFSD_SCSILAYOUT

> +	spinlock_t		cl_fence_lock;
> +	struct xarray		cl_fenced_devs;

#endif

>  };
>=20
>  /* struct nfs4_client_reset
> --=20
> 2.47.3

Hey Dai -

This version looks narrower and cleaner. Kudos!

But notice that xarray has the ability to mark and unmark the items
it stores. I asked Claude Code if that mechanism might be used here:

> Using marks would be a significant improvement. Here's why:
>
>  Current Approach (Value Entries)
>
>  xa_store(..., xa_mk_value(0), GFP_KERNEL);   // not fenced
>  xa_store(..., xa_mk_value(1), GFP_ATOMIC);   // fenced (under spinloc=
k!)
>
>  Problems:
>  - xa_store() may allocate memory even when replacing a value
>  - Requires GFP_ATOMIC under spinlock with uncertain allocation behavi=
or
>  - Must check return value for errors
>
>  Marks Approach
>
>  // Registration (GETDEVICEINFO):
>  xa_store(&clp->cl_fenced_devs, dev, xa_mk_value(0), GFP_KERNEL);
>
>  // Fence check-and-set (using xarray's internal lock):
>  xa_lock(&clp->cl_fenced_devs);
>  entry =3D xas_load(&xas);
>  if (entry && xas_get_mark(&xas, XA_MARK_0)) {
>      xa_unlock(&clp->cl_fenced_devs);
>      return;  // already fenced
>  }
>  xas_set_mark(&xas, XA_MARK_0);
>  xa_unlock(&clp->cl_fenced_devs);
>
>  // On fence failure:
>  xa_clear_mark(&clp->cl_fenced_devs, dev, XA_MARK_0);
>
>  Benefits:
>
>  1. No memory allocation - xas_set_mark() and xas_clear_mark() just fl=
ip bits in existing nodes (see lib/xarray.c:884-901)
>  2. Eliminates GFP_ATOMIC concern - No allocation means no GFP flags n=
eeded for mark operations
>  3. Can remove cl_fence_lock - Use xarray's built-in xa_lock()/xa_unlo=
ck() instead of a separate spinlock
>  4. Cleaner semantics:
>    - Entry presence =E2=86=92 device registered
>    - XA_MARK_0 set =E2=86=92 device fenced
>  5. No error returns to check - Mark operations are void functions
>  6. Defines available - Could use XA_MARK_0 directly or define #define=
 NFSD_SCSI_FENCED XA_MARK_0 for clarity
>
>  The only xa_store() that needs error checking would be the initial re=
gistration in nfsd4_block_get_device_info_scsi(), which already uses GFP=
_KERNEL in a sleepable context.

This approach should make remembering fences more reliable.
Would you consider using XA_MARK ?


--=20
Chuck Lever

