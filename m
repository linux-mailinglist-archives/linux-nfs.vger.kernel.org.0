Return-Path: <linux-nfs+bounces-17254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF3CD6661
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 685B030275F5
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Dec 2025 14:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67B26CE2D;
	Mon, 22 Dec 2025 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCW2nevr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C88B67E
	for <linux-nfs@vger.kernel.org>; Mon, 22 Dec 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414451; cv=none; b=KYaTs4/6eIhdGuoJWvuIBVgInTUfa/43SnVyMA4SA/VuR2xB/hAMhpkLH/AKb+XLZ0sn1Fh/LUghho6XxXAwE2ehP6OU+NcWcRh9FbZ0pNkWTl99cfFpZ7Q2eUs028EPpRCG968fOkrp1vcb4S9Tvq4Tfvu98b9wkRxwxxuzgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414451; c=relaxed/simple;
	bh=iawAXp2lDNdNF3VHv3agrdVz9kmsmmECNQhKIDii5ng=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fwWD4r7Pr7abJ1fLWLdH3bmm6+qMLCNW+urU5RIfR0zEmb5AWzdLm9SpU8Zo8P4LmXuGpcLHBLFF2RiGtI9eXVDeiNqnlUq66+/6RO1/KuAiwZXJjeCZBCjDqgDwBRejXCYyTDx3Tc/amZcW+aPeVTINzkPN0bsOiAPTvIUP/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCW2nevr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D528C4AF0B;
	Mon, 22 Dec 2025 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766414450;
	bh=iawAXp2lDNdNF3VHv3agrdVz9kmsmmECNQhKIDii5ng=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fCW2nevro8S1GSIH3/5xFqL3qt/yHnY/LVa6A75M2E9LCM6YVYDkglo8hoMh43iNZ
	 +wCY/PYP/+YVXzPUl5QaIG06yM0PznF0RAQfYEu12F1lSeq+yfQ8sFQPFTJ+MC7ecq
	 A7TRyIcXpmghVXwWfHxe5KA5q7m186jAQ1kabP0wczVf7gWadbeFwPQbDdrrmGuQre
	 MdBNuLHFGRPw91mDe31OWmIbFthbxq2WuNJYjHF5/0dn10VeEQHhiyZCCprb8KKWiT
	 IpFVDnb1Az6umRf9hwlfiqfw3Sl9pOTJzyr+j2VZ9J4AuvoOs+nvuRHtf+TJ7B7o0P
	 mi79IrAvqbsYA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54BC5F4006C;
	Mon, 22 Dec 2025 09:40:49 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 22 Dec 2025 09:40:49 -0500
X-ME-Sender: <xms:cVhJaVpaNJOctuedjOn_wQmtYEM8JDjxdeQOqDHZlGDLw9CXRjIwUg>
    <xme:cVhJaSco_ujcGJvyLyjvvSYSwj4s6b6Pe8VBg2iP7vmcEQS3ijcYYGhW4iJ6sPG1F
    kweEGSdBeGy4_MGlNUG5A5K16g6u1i6xyWta5AgxpX6nxLfrFfZXmM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehjedvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cVhJaZ-PMrwE3imdDdUuCwUJ-kVaX_pD8QYNxxf85yr2L7CXirCWkA>
    <xmx:cVhJaXseDUzFA4Ih_FUe9QEj35LSYxgQKnteD61Ykvabo25E953DOA>
    <xmx:cVhJadoKmxawil8IIAeEK2EtjRED90R_VAAQqxw4Ol4Hc2in2-bmZg>
    <xmx:cVhJabp4c9lyM3T3aIRiMysQ42A3WK8iR0PJ2Su8Nx8LaxArKUilIg>
    <xmx:cVhJacbT3G6mLYtFJd146nkWKlbwpuAsi_nrQd0ahDaMTXBuzKmDqxa6>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DAF078006C; Mon, 22 Dec 2025 09:40:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHTVCwCj6khg
Date: Mon, 22 Dec 2025 09:40:29 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <65feb177-2555-44d8-883f-cb18aa4d5321@app.fastmail.com>
In-Reply-To: <20251222021002.165582-1-dai.ngo@oracle.com>
References: <20251222021002.165582-1-dai.ngo@oracle.com>
Subject: Re: [PATCH v2 1/3] NFSD: Track SCSI Persistent Registration Fencing per Client
 with xarray
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Dec 21, 2025, at 9:09 PM, Dai Ngo wrote:
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

A few mechanical issues, see below...


> ---
>  fs/nfsd/blocklayout.c | 18 ++++++++++++++++++
>  fs/nfsd/nfs4state.c   |  6 ++++++
>  fs/nfsd/state.h       |  2 ++
>  3 files changed, 26 insertions(+)
>
> V2:
>    . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>      memory allocation in nfsd4_scsi_fence_client.
>    . Remove cl_fence_lock, use xa_lock instead.
>
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..348083488823 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -357,6 +357,9 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>  		goto out_free_dev;
>  	}
> 
> +	/* create a record for this client with the fenced flag set to 0 */
> +	xa_store(&clp->cl_fenced_devs, (unsigned long)sb->s_bdev->bd_dev,
> +				xa_mk_value(0), GFP_KERNEL);

xa_store() can still fail occasionally, so check the return code
and fail nfsd4_block_get_device_info_scsi() if the xa_store()
does not work.


>  	return 0;
> 
>  out_free_dev:
> @@ -400,10 +403,25 @@ nfsd4_scsi_fence_client(struct 
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
> +	if (status)
> +		xas_clear_mark(&xas, XA_MARK_0);

xas_clear_mark() calls require xa_lock to be held.


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

#ifdef CONFIG_NFSD_SCSILAYOUT

> +	struct xarray		cl_fenced_devs;

#endif

>  };
> 
>  /* struct nfs4_client_reset
> -- 
> 2.47.3

-- 
Chuck Lever

