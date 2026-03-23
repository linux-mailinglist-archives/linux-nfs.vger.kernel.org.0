Return-Path: <linux-nfs+bounces-20329-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPncJtlIwWlmSAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20329-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 15:06:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB962F3D22
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 15:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D704730D3A40
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 13:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748CB3AC0C9;
	Mon, 23 Mar 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9AhWagX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513543AC0C2
	for <linux-nfs@vger.kernel.org>; Mon, 23 Mar 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274035; cv=none; b=hSNKBV4Fh5c2mgnjgevV7Ls6ej6pM0Ct8+ldohOrT1HHfym+y0ZHRV+ZcCS93xP3N2z1ndsDp7U1r1BM00fme+yqQO73Q1bBRkhfCQbUJ79fpQJEEUKEG7bYdxyCTW1otxh5Y6MhvlZW4Hgx6ypDlR4ZNIjdvrQ9zooNMflYrco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274035; c=relaxed/simple;
	bh=IQ8jMniHFPenBN3fU91Tv+PRwr1LuFt0rHFb85iIBdY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oYYhdeskyvXIGpB8vjRUdy75uBF4ps+h1YMlEKM9NzTIugRbKIx6GNksSRCa9D2FIG8j3AqruzwREJ3l3G9gLcc/jtOxIPphIHq0IoSJx3XHOVFtjH6K8KD9i/7n78xsVFfyJnXRQ3tJNPafBamS5YeS/G9utRFaPB55JTITQR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9AhWagX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE344C2BCB3;
	Mon, 23 Mar 2026 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274035;
	bh=IQ8jMniHFPenBN3fU91Tv+PRwr1LuFt0rHFb85iIBdY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B9AhWagX9qR/nsvxZXFzRcW8P8QfpPiBGPOVzPKWQMMxUDnd9ebY3MirinGYzuVwc
	 d0m1kGwWPQf7Z0fbBqecWknToLWogZ496tQuo39zbAy6eWmA2MqsoExUPS7IpIis/6
	 cF5a/3sQWcV/5ej5f1NgdZs1xNT/xVMeEpWitcfejtPW1m2v6MCPLFH/1FZLvMEyNZ
	 YeNGCOEQ+qiU1WQ05gHZIqosUtZvcyoauDckROcy9417voTd5+3ltHzw7jYh+xZDHp
	 uDUKDQTsFanPmRyxL9FxqzSRhE21OMyjgERIKLRlIhrBvPceOex61t/E0yG2g22ogk
	 Kk1vZNiPk8+YQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E599CF4007A;
	Mon, 23 Mar 2026 09:53:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 23 Mar 2026 09:53:53 -0400
X-ME-Sender: <xms:8UXBaRXa2BJv_2dGvxmO6U8XNV6hZ6uPzJz_RBDSqFDIO3RJj61BCw>
    <xme:8UXBacaMLveU2ppd49EEst3xRMKCGEj-y9ViAG5q7qV027uO8MVNSk6hdv-9txJVN
    jIgWZwyj4VlFReaok30lZ57Vw8iQEmda69QvK4YqRQAVAXki0OoIf_n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefghfeguedtieeiveeugfevtdejfedukeevgfeggfeugfetgfeltdetueelleelteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprghmihhrjeefih
    hlsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggvmheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgthh
    eslhhsthdruggvpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhmpdhr
    tghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoh
    epohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhmsehtrghl
    phgvhidrtghomh
X-ME-Proxy: <xmx:8UXBaZRXaRACEforABpTg0eCdB3mqplm7uM-O_KC_Hwo9MzSa0uwDg>
    <xmx:8UXBaZLAYwgNonoDwpdbHNAzEl-Uv9oD65ks0xJ9uu5zdYf-vIuJ9A>
    <xmx:8UXBabFLBNHVzHBE2RBj_vHxou6osumgPRCy_CK7zHM8dUWA2nwOgg>
    <xmx:8UXBae3fboWr66KIrkZ3cLySWQPE_SCvpjxA_xGIhJ6LGcXAdwVqqw>
    <xmx:8UXBabJQyvrEHl9Sj7Z9D-OA7qM4yEW_H3Ymitb17V0T3egGNgJjpXkn>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BB392780070; Mon, 23 Mar 2026 09:53:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Av6uBezOhwSJ
Date: Mon, 23 Mar 2026 09:53:33 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Carlos Maiolino" <cem@kernel.org>, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-Id: <736ddc8a-7a28-4900-b3c1-0368cad24085@app.fastmail.com>
In-Reply-To: <20260323070746.2940140-6-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
 <20260323070746.2940140-6-hch@lst.de>
Subject: Re: [PATCH 5/7] nfsd/blocklayout: support GETDEVICEINFO for multiple devices
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lst.de,oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20329-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.957];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0AB962F3D22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, Mar 23, 2026, at 3:07 AM, Christoph Hellwig wrote:
> diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
> index 8ca8fd8f70cb..fb13f86f8eb5 100644
> --- a/fs/nfsd/blocklayout.c
> +++ b/fs/nfsd/blocklayout.c
> @@ -303,15 +303,19 @@ nfsd4_block_get_unique_id(struct gendisk *disk,=20
> struct pnfs_block_volume *b)
>  }
>=20
>  static int
> -nfsd4_block_get_device_info_scsi(struct super_block *sb,
> -		struct nfs4_client *clp,
> -		struct nfsd4_getdeviceinfo *gdp)
> +nfsd4_block_get_device_info_scsi(struct block_device *bdev,
> +		struct nfs4_client *clp, struct nfsd4_getdeviceinfo *gdp)
>  {
>  	struct pnfs_block_deviceaddr *dev;
>  	struct pnfs_block_volume *b;
>  	const struct pr_ops *ops;
>  	int ret;
>=20
> +	if (bdev_is_partition(bdev))
> +		return -EINVAL;
> +	if (!exportfs_bdev_supports_out_of_band_id(bdev))
> +		return -EINVAL;
> +
>  	dev =3D kzalloc_flex(*dev, volumes, 1);
>  	if (!dev)
>  		return -ENOMEM;
> @@ -323,30 +327,28 @@ nfsd4_block_get_device_info_scsi(struct super_bl=
ock *sb,
>  	b->type =3D PNFS_BLOCK_VOLUME_SCSI;
>  	b->scsi.pr_key =3D nfsd4_scsi_pr_key(clp);
>=20
> -	ret =3D nfsd4_block_get_unique_id(sb->s_bdev->bd_disk, b);
> +	ret =3D nfsd4_block_get_unique_id(bdev->bd_disk, b);
>  	if (ret < 0)
>  		goto out_free_dev;
>=20
>  	ret =3D -EINVAL;
> -	ops =3D sb->s_bdev->bd_disk->fops->pr_ops;
> +	ops =3D bdev->bd_disk->fops->pr_ops;
>  	if (!ops) {
> -		pr_err("pNFS: device %s does not support PRs.\n",
> -			sb->s_id);
> +		pr_err("pNFS: device %pg does not support persistent reservations.\=
n",
> +			bdev);
>  		goto out_free_dev;
>  	}
>=20
> -	ret =3D ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
> +	ret =3D ops->pr_register(bdev, 0, NFSD_MDS_PR_KEY, true);
>  	if (ret) {
> -		pr_err("pNFS: failed to register key for device %s.\n",
> -			sb->s_id);
> +		pr_err("pNFS: failed to register key for device %pg.\n", bdev);
>  		goto out_free_dev;
>  	}
>=20
> -	ret =3D ops->pr_reserve(sb->s_bdev, NFSD_MDS_PR_KEY,
> +	ret =3D ops->pr_reserve(bdev, NFSD_MDS_PR_KEY,
>  			PR_EXCLUSIVE_ACCESS_REG_ONLY, 0);
>  	if (ret) {
> -		pr_err("pNFS: failed to reserve device %s.\n",
> -			sb->s_id);
> +		pr_err("pNFS: failed to reserve device %pd.\n", bdev);
>  		goto out_free_dev;
>  	}
>=20
> @@ -364,9 +366,16 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block =
*sb,
>  		struct nfs4_client *clp,
>  		struct nfsd4_getdeviceinfo *gdp)
>  {
> -	if (bdev_is_partition(sb->s_bdev))
> -		return nfserr_inval;
> -	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
> +	struct block_device *bdev =3D sb->s_bdev;
> +
> +	if (sb->s_export_op->block_ops->devid_to_bdev) {
> +		bdev =3D sb->s_export_op->block_ops->devid_to_bdev(sb,
> +					gdp->gd_devid.dev_idx);
> +		if (IS_ERR(bdev))
> +			return nfserrno(PTR_ERR(bdev));
> +	}
> +
> +	return nfserrno(nfsd4_block_get_device_info_scsi(bdev, clp, gdp));
>  }
>  static __be32
>  nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rq=
stp,

LLM review identified this issue:

402 static void
403 nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_=
file *file)
404 {
405         struct nfs4_client *clp =3D ls->ls_stid.sc_client;
406         struct block_device *bdev =3D file->nf_file->f_path.mnt->mnt=
_sb->s_bdev;
407         int status;
408=20

This always gets the data device. For an RT inode whose layout was
granted with dev_idx=3D1, PR registration happened on the RT bdev (in
nfsd4_block_get_device_info_scsi after devid_to_bdev), but the
preempt here fires against the data bdev.
                                                                        =
                                          =20
The difficulty is that fence_client receives a nfs4_layout_stateid
and nfsd_file, neither of which carries the dev_idx that was encoded
in the device ID at layout grant time.

So the fix isn't just a one-liner =E2=80=94 it requires threading the de=
vice
index (or the bdev) through to the fence path, likely by storing it
in the layout stateid when the layout is granted.

Pre-series invariant (broken by this series):                           =
               =20
                                                                        =
                                          =20
Before the series, nfsd4_setup_layout_type checked
sb->s_bdev->bd_disk->fops->pr_ops directly before enabling LAYOUT_SCSI.
That guaranteed fence_client could safely dereference sb->s_bdev's
pr_ops. After the series, the check delegates to
xfs_fs_layouts_supported, which uses:
                 =20
  if (exportfs_bdev_supports_out_of_band_id(sb->s_bdev) ||
      (mp->m_rtdev_targp &&
       exportfs_bdev_supports_out_of_band_id(mp->m_rtdev_targp->bt_bdev)=
))
      supported |=3D EXPFS_BLOCK_OUT_OF_BAND_ID;                        =
                                            =20

This means LAYOUT_SCSI can be enabled when only the RT device has
pr_ops and get_unique_id.

Concrete path to NULL deref:

  1. XFS with RT: data device is plain SATA (no pr_ops), RT device is NV=
Me (has pr_ops + get_unique_id)
  2. xfs_fs_layouts_supported =E2=86=92 EXPFS_BLOCK_OUT_OF_BAND_ID set (=
via RT device)
  3. nfsd4_setup_layout_type =E2=86=92 enables LAYOUT_SCSI
  4. Client does LAYOUTGET for RT inode =E2=86=92 map_blocks sets dev_id=
x=3D1
  5. Client does GETDEVICEINFO with dev_idx=3D1 =E2=86=92 devid_to_bdev =
returns RT bdev =E2=86=92 PR register/reserve on RT bdev succeeds
  6. Recall fails =E2=86=92 nfsd4_scsi_fence_client (line 406): bdev =3D=
 ...->s_bdev (data device)
  7. Line 409: bdev->bd_disk->fops->pr_ops->pr_preempt(...) =E2=80=94 pr=
_ops is NULL =E2=86=92 kernel oops

Even when both devices have pr_ops, the fence still targets the
wrong device: the client's PR registration is on the RT bdev (done
during GETDEVICEINFO), but the preempt fires on the data bdev,
leaving the RT device unfenced.

The issue is reachable on any XFS+RT configuration where the RT
device supports SCSI persistent reservations but the data device
does not.


--=20
Chuck Lever

