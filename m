Return-Path: <linux-nfs+bounces-19146-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLdeNuG1nGkNKAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19146-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:17:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19F17CCD1
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48360301BC05
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92078376BCA;
	Mon, 23 Feb 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nowheycreamery.com header.i=@nowheycreamery.com header.b="nALxLfxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k8YrQIpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C653382DE
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877817; cv=none; b=kC3EtZO1s7jtneS5pGejF1dE5fmdZ7dz7nca6BCLUDLaNAyJN7xVxnoAPPpZ/Hss6Fdr1zVW6xZ4XXY+4Ptb1jdUjz/8FcncXUVESbyGqt7ZTX6CofTj/+toXmqXjOl0C6xC3QaNjFwVcQ/VpYgl+lywhzqpEl2G29izrKVfUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877817; c=relaxed/simple;
	bh=+K8084vGL5cPwyDA4Mh/IzyoxblsT41ZEXXmTUddA5o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lqqMtwp6u+vunTeupFyCco3aQLFWHrVz0xvQo6ZQ+fC4B9SgqjqmK40kBX1+5XgZsJHBj1UJD2ZPfAY5FprGwWmZyWqQqyV5uQxBxcEN9EhNzzpdEHy0y09docPsrVXd2feicGPfUKAkK+kfvqlrQUeEQt8fB23lNnhk4kckAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nowheycreamery.com; spf=pass smtp.mailfrom=nowheycreamery.com; dkim=pass (2048-bit key) header.d=nowheycreamery.com header.i=@nowheycreamery.com header.b=nALxLfxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k8YrQIpX; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nowheycreamery.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nowheycreamery.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 859C51300CCE;
	Mon, 23 Feb 2026 15:16:54 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 15:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	nowheycreamery.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1771877814; x=1771881414; bh=16a6WDrz18
	8MbKYohvYp5o2Z6jOCLJEHe9FpgqNPSzk=; b=nALxLfxdgWIbHgHTxUzdCe0ePv
	GsODfjke1B+10EkdBjHjTE54dG9xD3E3d3TRzpexWSeUMUXQL1JtDtnAm5z4sjo6
	K8pXJxETgHxORz8IlUXEly5MWMrlSsr6iFdOA00qzDECn1aizfmDYkHRr5NXMDzW
	XYIPICTPNGqr0Bwf/4o/rpLQKfT/CeKWMncUHdnwu+IGnMaATDeL6Bwhdd4rmPFl
	n+YWDYj3pb1i1tG2UOAVs9/3HDAuvYqWXyZTUN8W3c8VTRmtWnXsTOaaCVt09IGs
	hczk6TyV29608AFFneXxydeVkVm8Xu+qnXq/LFIoWoHK7lLwZPGhERA1O0kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771877814; x=
	1771881414; bh=16a6WDrz188MbKYohvYp5o2Z6jOCLJEHe9FpgqNPSzk=; b=k
	8YrQIpXDcCrcOPD7j459SOv4CtuPfRdLSM00aAxy62wO5gsgK9gi7A/I2ntK1Cwf
	rC2xYCxgyabGnPdvRFgmIwpiH1/VR7TlGAjUmPdpK1kkWZkapikNBpS/H1yis3WH
	ckmZGYGH76I5c1fXvL7+lyRjj7fWIaLvVhL4u1BJ7m7Wbzb2hTOfku1g+cWFoLPk
	ASnoZHnjquMOXQov/A8BSGzNzsAd+NomQQivm/PLUFYsFLXtFz76aoDYc8VOnIxL
	qx0ahcSAcisOF491qE3CiNKpTVsz1MeAvPeBXwi/gOVVEGBVq33894bHUBJBIcne
	0qWrEZDnxaWvwWMHykGmw==
X-ME-Sender: <xms:trWcaUG0vGE9gDcJFU_CtCfQ5ftt3-OdOXlXSZNNjljbPiRoQP9yDg>
    <xme:trWcaYL5xYy9Pcct1AFlS_xLkxiILrbtvwxuPlTL7FZgLqe6-mokmU2BUpL-ulGe8
    afzXigtjhxiYbnVZm8BDW594Bq4OPLpX0nFWWPNbhbCIc_FYPhfL24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehnnhgr
    ucfutghhuhhmrghkvghrfdcuoegrnhhnrgesnhhofihhvgihtghrvggrmhgvrhihrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedttdekledtleeiffekfffhhfeghfehvddvtdehuedu
    geeiueeivdefleektdfgkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhhnrgesnhhofihhvgihtghrvggrmhgvrhihrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhgrhihtoh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrvghlrdhsthholhgvrhes
    vhgrshhtuggrthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:trWcadAnBpN0eRtbLefQU_nTTfoPbZPtWZrjxLPVmS7BhkdzUSFNyw>
    <xmx:trWcaTRX7h21t_2cW2uYcARr-vezPuQyb_8h_FBjk9a34P5dsmrHaw>
    <xmx:trWcabpUJccPMzHW-jTP42pPreg-kvBlCelXDVHKlxdL2jLvFnuxVw>
    <xmx:trWcaVywDccwKJfhHramkYUZUZmO7WS67deZU8kKeixjL2GafioyWA>
    <xmx:trWcadPhvnfAlfVaw5L07YbOGBiaGS3mI9IIO75mLrYJYlKR2_9Isv3a>
Feedback-ID: i67c64855:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EAD97B6006E; Mon, 23 Feb 2026 15:16:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlqJssKda3Mc
Date: Mon, 23 Feb 2026 15:16:32 -0500
From: "Anna Schumaker" <anna@nowheycreamery.com>
To: "Michael Stoler" <michael.stoler@vastdata.com>,
 "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Message-Id: <d3f9fb99-998c-4307-ac6f-351ec37c501b@app.fastmail.com>
In-Reply-To: <20260222134019.21516-1-michael.stoler@vastdata.com>
References: <20260222134019.21516-1-michael.stoler@vastdata.com>
Subject: Re: [PATCH] nfs: avoid triggering out-of-order write handling in nfs_setattr()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[nowheycreamery.com:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[nowheycreamery.com];
	TAGGED_FROM(0.00)[bounces-19146-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nowheycreamery.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@nowheycreamery.com,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,nowheycreamery.com:dkim,vastdata.com:email,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 0D19F17CCD1
X-Rspamd-Action: no action

Hi Michael,

On Sun, Feb 22, 2026, at 8:40 AM, Michael Stoler wrote:
> I=E2=80=99m seeing a performance issue with an NFS driver based on Lin=
ux 6.6. When

Linux 6.6 was from late 2023. Have you checked if this problem is still =
there
on a more recent upstream Linux kernel?

> untar extracts an archive, it sets file attributes and timestamps afte=
r each
> file is created. As a result, the inodes of these files are marked as =
OOO
> (out-of-order write), which causes valid page cache to be dropped on s=
ubsequent
> opens.
>     This false OOO tagging occurs during the nfs_setattr() inode metho=
d. The
> reason is that inode attributes are updated twice: first in the protoc=
ol version
> specific method nfs*_proc_setattr(), and then again in nfs_setattr() i=
tself via
> nfs_refresh_inode(), even though the inode state has already been upda=
ted by
> nfs_update_inode() in protocol-version-specific method. As a result,
> nfs_refresh_inode() falsely detects the second attempt to apply the sa=
me file
> attributes as an out-of-order operation and marks the inode with an OO=
O range.
>     The proposed patch resolves this issue by eliminating the second i=
node
> attribute update in nfs_refresh_inode() when the inode has already bee=
n updated.
>
> Signed-off-by: Michael Stoler <michael.stoler@vastdata.com>
> ---
>  fs/nfs/inode.c         | 10 ++++++----
>  fs/nfs/nfs3proc.c      |  2 +-
>  fs/nfs/nfs4proc.c      |  2 +-
>  fs/nfs/proc.c          |  2 +-
>  include/linux/nfs_fs.h |  2 +-
>  5 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 0d7facfdafb9..13ac5dffd3e6 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -657,8 +657,6 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry=
 *dentry,
>  	}
>=20
>  	error =3D NFS_PROTO(inode)->setattr(dentry, fattr, attr);
> -	if (error =3D=3D 0)
> -		error =3D nfs_refresh_inode(inode, fattr);

The code in this area has changed in the last 6 months and does an extra
ATTR_SIZE check in this if statement that you're removing. Any chance
you can rebase your patch on current upstream and resubmit?

Thanks,
Anna

>  	nfs_free_fattr(fattr);
>  out:
>  	trace_nfs_setattr_exit(inode, error);
> @@ -709,9 +707,11 @@ static int nfs_vmtruncate(struct inode * inode,=20
> loff_t offset)
>   * Note: we do this in the *proc.c in order to ensure that
>   *       it works for things like exclusive creates too.
>   */
> -void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
> +int nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
>  		struct nfs_fattr *fattr)
>  {
> +	int ret =3D 0;
> +
>  	/* Barrier: bump the attribute generation count. */
>  	nfs_fattr_set_barrier(fattr);
>=20
> @@ -780,8 +780,10 @@ void nfs_setattr_update_inode(struct inode *inode=
,=20
> struct iattr *attr,
>  					| NFS_INO_INVALID_CTIME);
>  	}
>  	if (fattr->valid)
> -		nfs_update_inode(inode, fattr);
> +		ret =3D nfs_update_inode(inode, fattr);
>  	spin_unlock(&inode->i_lock);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(nfs_setattr_update_inode);
>=20
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 715753f41fb0..dc9f33735cf2 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -144,7 +144,7 @@ nfs3_proc_setattr(struct dentry *dentry, struct=20
> nfs_fattr *fattr,
>  	nfs_fattr_init(fattr);
>  	status =3D rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
>  	if (status =3D=3D 0) {
> -		nfs_setattr_update_inode(inode, sattr, fattr);
> +		status =3D nfs_setattr_update_inode(inode, sattr, fattr);
>  		if (NFS_I(inode)->cache_validity & NFS_INO_INVALID_ACL)
>  			nfs_zap_acl_cache(inode);
>  	}
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index fe6986939bc9..a41c5b046205 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4436,7 +4436,7 @@ nfs4_proc_setattr(struct dentry *dentry, struct=20
> nfs_fattr *fattr,
>=20
>  	status =3D nfs4_do_setattr(inode, cred, fattr, sattr, ctx, NULL);
>  	if (status =3D=3D 0) {
> -		nfs_setattr_update_inode(inode, sattr, fattr);
> +		status =3D nfs_setattr_update_inode(inode, sattr, fattr);
>  		nfs_setsecurity(inode, fattr);
>  	}
>  	return status;
> diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
> index e3570c656b0f..edf3edf6720a 100644
> --- a/fs/nfs/proc.c
> +++ b/fs/nfs/proc.c
> @@ -147,7 +147,7 @@ nfs_proc_setattr(struct dentry *dentry, struct=20
> nfs_fattr *fattr,
>  	nfs_fattr_init(fattr);
>  	status =3D rpc_call_sync(NFS_CLIENT(inode), &msg, 0);
>  	if (status =3D=3D 0)
> -		nfs_setattr_update_inode(inode, sattr, fattr);
> +		status =3D nfs_setattr_update_inode(inode, sattr, fattr);
>  	dprintk("NFS reply setattr: %d\n", status);
>  	return status;
>  }
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 832b7e354b4e..a1bcec8d0992 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -434,7 +434,7 @@ extern bool=20
> nfs_mapping_need_revalidate_inode(struct inode *inode);
>  extern int nfs_revalidate_mapping(struct inode *inode, struct=20
> address_space *mapping);
>  extern int nfs_revalidate_mapping_rcu(struct inode *inode);
>  extern int nfs_setattr(struct mnt_idmap *, struct dentry *, struct=20
> iattr *);
> -extern void nfs_setattr_update_inode(struct inode *inode, struct iatt=
r=20
> *attr, struct nfs_fattr *);
> +extern int nfs_setattr_update_inode(struct inode *inode, struct iattr=20
> *attr, struct nfs_fattr *);
>  extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr=20
> *fattr);
>  extern struct nfs_open_context *get_nfs_open_context(struct=20
> nfs_open_context *ctx);
>  extern void put_nfs_open_context(struct nfs_open_context *ctx);
> --=20
> 2.53.0

