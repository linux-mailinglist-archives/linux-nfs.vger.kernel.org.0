Return-Path: <linux-nfs+bounces-17312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFD4CDF2F1
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 01:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A20130062D7
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 00:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5BD215F5C;
	Sat, 27 Dec 2025 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TJgasK/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="au3yV8ND"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC771487BE
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766795215; cv=none; b=f/KN2bL5UyqJLA8w5pYbu/WCrRgEy26LdE34DcAhcrvkrA7lSSb9xhC68ZgrDAPRVKcpAJ/BXivm9uSK+AOYFbzdU/5QFmG1deGrVaip59VX7c1UCDdHWLzENPqztyIotF3FpUV1qrHXe3QFW9SbVnZG8WzIex7z8hdmubLZ8SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766795215; c=relaxed/simple;
	bh=txob0uvIQmHlkj2CwcN7wI0T9Zvfg5BVnrj7OV4GVT8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=a9ot0d2w3IPCA7YSNu6ZWJ6lmMrK41gGuWKNCzMxMUgaAhLODXbjSVsd6HbHCLposo0/ZRDF+lcntW+OlNYWMmgTOVoto8CC1pGHRsUC8l+JHw5Y5BKO3aQHw7t336LilrrlXG+SIBwxYeJlmUkcSGSdb6wfmImXkXd5OIYsa0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TJgasK/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=au3yV8ND; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16B6F7A0065;
	Fri, 26 Dec 2025 19:26:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 26 Dec 2025 19:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766795211; x=1766881611; bh=yLHq3UaC0lW+UUhVy9tUviondHs/CLsAyw2
	hFiJxbeY=; b=TJgasK/oipdN9LcujyCrB2hkAEg368DQwtsMnfCAvAsrSTmzKXW
	epYypA6u7qpx1vq23BxjLQ9xv9z22rwzyBojDSR+iIqti7rFlFJ6d0G6a82Tiek9
	ZSMFFJjJcAq5lkv56YdK6ahlMPOoDrJ5zSfmq5X4Cc/hc51MTZYGfoQsRnRdCCDi
	bTyvBvNQf2YI21VTVAI14oamJR8fSEV3tEq2RY5VQ0PWhjZU7wU+es/K9ePfDGqr
	XELdaulXNvwpiKzIFh5aRoSj4fY0J4dYHjw5ChhXsY7/T+uGVGaRZnK4le/FtWPj
	Mc6CPBroQf8cXt9tkIJedrrbiuNl1n3roXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766795211; x=
	1766881611; bh=yLHq3UaC0lW+UUhVy9tUviondHs/CLsAyw2hFiJxbeY=; b=a
	u3yV8NDEQotuvhhR4KWy14pJ59KtFTpyNdeaOdY/SrSh8eFlcSv7OGo2M0MjhK3A
	E/p2AQyuO1pfOmM0uAl8MWm0TraFiEufuxR0f6OxZtzoFQxh/UTWl11YV0Q1Tsay
	Ic+bqbBdLsuAovlg7CmPqXdffuUH8taCCcsXa3GkXBSOdSQN+0TD9Nxv7+C2eZZB
	zXntad3QBzLPK4CvwqYJ9qRi03nchMevKUiE/OERf2XJUAgSmoQLxMRGPNhE6pCz
	ybUOhZG0RgLeIvMpkeZQRSCwx5huwhvUKgJlxhWUs76G6QknWySm/ZF/1Ix2jaUf
	tmVFyNDW6gh/1LadPae/Q==
X-ME-Sender: <xms:yydPaZJ4o-vA_lJlbWrmkZE-8jPRoaFdZpa9CXIfx-jcBiKXBiWfLQ>
    <xme:yydPaXaGU_SJBeZAK1AehR0QNYMl_AvQ64WxPqymhR_6a3hLlH8GqrQXxNd7zXEXC
    BsqgQjJCl8MIFDG4T_IynoJbLPPHeSypiKXO132JSSwheUvMA>
X-ME-Received: <xmr:yydPaT8gakYOYd2bfafJTgvgSuJBZSrWQwPnIOSG5vXB1Xa54uOLXdU7dyFgSqZv2RHg2qCbDQXL5O87UDletASyita4Fjcn35yk6kPwagNP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeileeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvg
    drtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehjlhgrhihtohhnsehkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yydPaQbD6z40mk2lS2-zp3aST1C12bOaJo5b9AOjGokX4W-WBL4vQQ>
    <xmx:yydPafNB1uD5SMV3RNtka1ChxisseJX_mZy49O6pt-Xa4UWB-xfbsw>
    <xmx:yydPaUDGyxKQVrJokTPTJIOTaSmWvPeUPW8DPakfs1FF2ME_kzqXkg>
    <xmx:yydPaeJEu8sLK0pynHTC6CCosF4rPKy0c4b19PWF24FP1Xn9sZpvSQ>
    <xmx:yydPabegI9VMqwlSlEXY_Gv_lO9pTqNOVGz9Q28koVsRBbJJw3-33jpC>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 19:26:49 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Dai Ngo" <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, okorniev@redhat.com,
 tom@talpey.com, hch@lst.de, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/1] NFSD: Track SCSI Persistent Registration Fencing
 per Client with xarray
In-reply-to: <20251226212213.1385803-1-dai.ngo@oracle.com>
References: <20251226212213.1385803-1-dai.ngo@oracle.com>
Date: Sat, 27 Dec 2025 11:26:47 +1100
Message-id: <176679520754.16766.9950497518646716091@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Dec 2025, Dai Ngo wrote:
> Update the NFS server to handle SCSI persistent registration fencing on
> a per-client and per-device basis by utilizing an xarray associated with
> the nfs4_client structure.
>=20
> Each xarray entry is indexed by the dev_t of a block device registered
> by the client. The entry maintains a flag indicating whether this device
> has already been fenced for the corresponding client.
>=20
> When the server issues a persistent registration key to a client, it
> creates a new xarray entry at the dev_t index with the fenced flag
> initialized to 0.
>=20
> Before performing a fence via nfsd4_scsi_fence_client, the server
> checks the corresponding entry using the device's dev_t. If the fenced
> flag is already set, the fence operation is skipped; otherwise, the
> flag is set to 1 and fencing proceeds.
>=20
> The xarray is destroyed when the nfs4_client is released in
> __destroy_client.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/blocklayout.c | 33 +++++++++++++++++++++++++++++++++
>  fs/nfsd/nfs4state.c   |  6 ++++++
>  fs/nfsd/state.h       |  2 ++
>  3 files changed, 41 insertions(+)
>=20
> V2:
>    . Replace xa_store with xas_set_mark and xas_get_mark to avoid
>      memory allocation in nfsd4_scsi_fence_client.
>    . Remove cl_fence_lock, use xa_lock instead.
> V3:
>    . handle xa_store error.
>    . add xa_lock and xa_unlock when calling xas_clear_mark
> V4:
>    . rename cl_fenced_devs to cl_dev_fences
>    . add comment in nfsd4_block_get_device_info_scsi
>=20
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index afa16d7a8013..e4c63e07686c 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -318,6 +318,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
>  	struct pnfs_block_volume *b;
>  	const struct pr_ops *ops;
>  	int ret;
> +	void *entry;
> =20
>  	dev =3D kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
>  	if (!dev)
> @@ -357,6 +358,20 @@ nfsd4_block_get_device_info_scsi(struct super_block *s=
b,
>  		goto out_free_dev;
>  	}
> =20
> +	/*
> +	 * Create an entry for this client with the fenced flag set to 0.
> +	 *
> +	 * The atomicity of xa_store ensures that only a single entry
> +	 * is created for each device. The maximun number of entries
> +	 * in this array is determined by the number of pNFS exports
> +	 * accessed by this client that use the SCSI layout type.
> +	 */
> +	entry =3D xa_store(&clp->cl_dev_fences, (unsigned long)sb->s_bdev->bd_dev,
> +				xa_mk_value(0), GFP_KERNEL);
> +	if (xa_is_err(entry)) {
> +		ret =3D xa_err(entry);
> +		goto out_free_dev;
> +	}
>  	return 0;
> =20
>  out_free_dev:
> @@ -400,10 +415,28 @@ nfsd4_scsi_fence_client(struct nfs4_layout_stateid *l=
s, struct nfsd_file *file)
>  	struct nfs4_client *clp =3D ls->ls_stid.sc_client;
>  	struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt_sb->s_bdev;
>  	int status;
> +	void *entry;
> +	XA_STATE(xas, &clp->cl_dev_fences, bdev->bd_dev);
> +
> +	xa_lock(&clp->cl_dev_fences);
> +	entry =3D xas_load(&xas);
> +	if (entry && xas_get_mark(&xas, XA_MARK_0)) {
> +		/* device already fenced */

If two threads race, we could reach this point before any thread has
called ->pr_preempt().  So I think the comment is strictly speaking
wrong.
It isn't the case that "device [is] already fenced" but that "we have
already committed to fencing the device".

Is that an important difference?  I don't know as I don't know the
purpose of fencing here.

Does the second thread need to wait for the fence to complete, or should
the comment acknowledge that might not have completed yet?

Thanks,
NeilBrown



> +		xa_unlock(&clp->cl_dev_fences);
> +		return;
> +	}
> +	/* Set the fenced flag for this device. */
> +	xas_set_mark(&xas, XA_MARK_0);
> +	xa_unlock(&clp->cl_dev_fences);
> =20
>  	status =3D bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
>  			nfsd4_scsi_pr_key(clp),
>  			PR_EXCLUSIVE_ACCESS_REG_ONLY, true);
> +	if (status) {
> +		xa_lock(&clp->cl_dev_fences);
> +		xas_clear_mark(&xas, XA_MARK_0);
> +		xa_unlock(&clp->cl_dev_fences);
> +	}
>  	trace_nfsd_pnfs_fence(clp, bdev->bd_disk->disk_name, status);
>  }
> =20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 808c24fb5c9a..12537e0a783f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2381,6 +2381,9 @@ static struct nfs4_client *alloc_client(struct xdr_ne=
tobj name,
>  	INIT_LIST_HEAD(&clp->cl_revoked);
>  #ifdef CONFIG_NFSD_PNFS
>  	INIT_LIST_HEAD(&clp->cl_lo_states);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_init(&clp->cl_dev_fences);
> +#endif
>  #endif
>  	INIT_LIST_HEAD(&clp->async_copies);
>  	spin_lock_init(&clp->async_lock);
> @@ -2537,6 +2540,9 @@ __destroy_client(struct nfs4_client *clp)
>  		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>  	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
>  	nfsd4_dec_courtesy_client_count(nn, clp);
> +#ifdef CONFIG_NFSD_SCSILAYOUT
> +	xa_destroy(&clp->cl_dev_fences);
> +#endif
>  	free_client(clp);
>  	wake_up_all(&expiry_wq);
>  }
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index b052c1effdc5..eead2b420201 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -527,6 +527,8 @@ struct nfs4_client {
> =20
>  	struct nfsd4_cb_recall_any	*cl_ra;
>  	time64_t		cl_ra_time;
> +
> +	struct xarray		cl_dev_fences;
>  };
> =20
>  /* struct nfs4_client_reset
> --=20
> 2.47.3
>=20
>=20


