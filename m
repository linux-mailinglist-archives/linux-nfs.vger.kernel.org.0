Return-Path: <linux-nfs+bounces-15736-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA53FC17227
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 23:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23D6C4F3B00
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770092C3244;
	Tue, 28 Oct 2025 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Bundu3/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ak17bhMB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9429C33F
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689252; cv=none; b=gn7OzBmj7ea18MiFZgnwsYh0wZspgFtjq3WaYjoUzqum0ReYaIttZbyU+Nf2vxtZpCGljqzhyM6dg9KdGWdKi4Y00saHi7iKzqq4q1Gr/UO0HgteH2zflvXAj5tNH58AvKMDy60Ij0vkqVy6ccHgShW3g7iBuK9Ykn6HbQX/4Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689252; c=relaxed/simple;
	bh=pApDfF4GqKJDWADyZrgb/GMmlmnJmCZqYzGaTrz4n5U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AvvXLkh53p6kOqcmzL1a6wbUQqbUgO0UOJmPFkat3EqPFTgnndR1vXtCb08nEmMIA82J2MuVMVfvc1IJLXa5N0GUWXQYitisJLehRfF+szlcN86Y1PRw37Q8TT1vwPltDPgILVrbBYrqv3ZQVh717D+Va3Sd/3fuHa2B5XV9r2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Bundu3/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ak17bhMB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD0DF7A0102;
	Tue, 28 Oct 2025 18:07:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 18:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761689248; x=1761775648; bh=f8/Dy+WyTl1c6LJ8XDq6NGUpbA+gW3mqIlw
	8u3a1OEo=; b=Bundu3/uxMllg35DuGrXhAtfFMSwykJwgnCg89b9KdzaxRzb6IB
	t8sY8RYVepv2kNJNZHv8Umm6OhEiKAyQvCMngcJC3Oh46dRMbfqYU+seHpaDDUHL
	Qsik6UmmrJEy6jxRMFw4EiwwliY0h6f4Qo0bJ0EbN2/PsggTZhvAywXpAbXwwKh5
	xPzmwazL49PUYEXr2mH+oKAqQZshAt2cO1CLgf7CV3QrROlkeRHAi0YTtkcXlUEh
	wEUJjOi2iasYeIepqh5+rbIdfHurjPbbizZrK3FdTyIyWRmzEHwSkCnH68TG2Ofb
	xs4u4N0dmqNgcYgfk6+nIPeIDhSIDcoebow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761689248; x=
	1761775648; bh=f8/Dy+WyTl1c6LJ8XDq6NGUpbA+gW3mqIlw8u3a1OEo=; b=A
	k17bhMBk/IaNIviksjIKXx/DjyR43DfyZmhZYjtk6BqmUCvuqfCwFcoWWRb18JJe
	LsSwb0/DAeGxirfAWBGYECwGGc10cf+gCMHjAlmenVXrtDBhXpCvWuVliekgT5kW
	+tpCy0+1qBhb5yEuDdDtImUaQXXT5dAEkT7VjGZcEmJ1HMs8Pv941bow+mqzfpjf
	wXd0zpm9IxCDAqcN4GDx1+v/C5OSJQs2IOR8B8uH7j25oLgFe+eqAo4pHgad6KeG
	DQmiDNz264+eIwHWe2qQs/xfubHROIqkHtQdrXWCsKR/cZDGKPR4z9REYt2qmmYE
	EMcFciUDwr+Xud0OCpeIg==
X-ME-Sender: <xms:oD4Bab6nUTe5EfF4cfv1tE6QX-0ASkec5kOfX1nfqn4w09KLThl1TQ>
    <xme:oD4BaX7gz7QJXfdNhynB8JDdA8ZkmCyf6ioOEgEkURGW5F3bgPk7alBgX49Z8z90h
    aZ7HASYQukr-BPKIxDHA9slIwxpPSnWzSOdeZhGDz27i2xHeg>
X-ME-Received: <xmr:oD4BaXfXRWbLV5SU2Y_4iDhz2oTrqAhmtLdiSE0e0Tm6_GyGJonXgU-W2q4Wa53rervEL8cE3CthbrOA04-Y7AjqOZRnEmQnhs2fyRb80FOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    nhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrsggsvghnvgekjeesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:oD4BabC1JfhrvX9JTXGw9kJgZzl1_St9UZYh4K8uvNd-nJn0LlJoxg>
    <xmx:oD4Baa-xy1QfC9tbLljqvuDE64A1zxpO5IIiPPt8D29zCLDwPjvT-g>
    <xmx:oD4BaWIvSPoN7Rdl7PCD3RE0WZsGOa9rlf3RT8btOND1zZucogJL6g>
    <xmx:oD4BaThMkZ0ynciEIN-1xTC-dsTqh8rdMTnnc_cVo4eQeb4XsBiT4Q>
    <xmx:oD4BabvYYMUajj6A9cttmuGhrtIk9Ngti9f4T5YbP3jQfVGQXr0LaSkN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 18:07:26 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Trond Myklebust" <trondmy@kernel.org>
Cc: "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 "Stephen Abbene" <sabbene87@gmail.com>
Subject: Re: [PATCH v2 2/2] NFSv2/v3: Fix handling of O_DIRECTORY in
 nfs_atomic_open_v23()
In-reply-to: =?utf-8?q?=3C733195cf9970e6590f556548a18a57dfe6114ab9=2E1761686?=
 =?utf-8?q?833=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E?=
References: =?utf-8?q?=3C03e3a5a82187cfc7936b87ce92ee001b27e18878=2E17616868?=
 =?utf-8?q?33=2Egit=2Etrond=2Emyklebust=40hammerspace=2Ecom=3E=2C_=3C733195c?=
 =?utf-8?q?f9970e6590f556548a18a57dfe6114ab9=2E1761686833=2Egit=2Etrond=2Emy?=
 =?utf-8?q?klebust=40hammerspace=2Ecom=3E?=
Date: Wed, 29 Oct 2025 09:07:19 +1100
Message-id: <176168923910.1793333.9587671564912340853@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 29 Oct 2025, Trond Myklebust wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> If the application sets the O_DIRECTORY flag, and tries to open a
> regular file, the correct response is to return -ENOTDIR as is done in
> the NFSv4 atomic open case.
>=20
> Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC corr=
ectly.")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/dir.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index ea9f6ca8f30f..dedd12cc1fc8 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2259,6 +2259,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct den=
try *dentry,
>  			umode_t mode)
>  {
>  	struct dentry *res =3D NULL;
> +	struct inode *inode;
>  	/* Same as look+open from lookup_open(), but with different O_TRUNC
>  	 * handling.
>  	 */
> @@ -2267,7 +2268,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct den=
try *dentry,
>  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
>  		return -ENAMETOOLONG;
> =20
> -	if (open_flags & O_CREAT) {
> +	if ((open_flags & O_CREAT) && !(open_flags & O_DIRECTORY)) {

Since=20
Commit: 43b450632676 ("open: return EINVAL for O_DIRECTORY | O_CREAT")

the new test is redundant.  Doesn't hurt for documentation purposes though.

>  		error =3D nfs_do_create(dir, dentry, mode, open_flags);
>  		if (!error) {
>  			file->f_mode |=3D FMODE_CREATED;
> @@ -2275,12 +2276,27 @@ int nfs_atomic_open_v23(struct inode *dir, struct d=
entry *dentry,
>  		} else if (error !=3D -EEXIST || open_flags & O_EXCL)
>  			return error;
>  	}
> +
>  	if (d_in_lookup(dentry)) {
>  		/* The only flags nfs_lookup considers are
>  		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
>  		 * we want those to be zero so the lookup isn't skipped.
>  		 */
>  		res =3D nfs_lookup(dir, dentry, 0);
> +		if (!res) {
> +			inode =3D d_inode(dentry);
> +			if ((open_flags & O_DIRECTORY) && inode &&
> +			    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
> +				res =3D ERR_PTR(-ENOTDIR);
> +		} else if (!IS_ERR(res)) {
> +			inode =3D d_inode(res);
> +			if ((open_flags & O_DIRECTORY) && inode &&
> +			    !(S_ISDIR(inode->i_mode) ||
> +			      S_ISLNK(inode->i_mode))) {
> +				dput(res);
> +				res =3D ERR_PTR(-ENOTDIR);
> +			}

I think do_open() in namei.c provides these checks

	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
		return -ENOTDIR;

Does this patch add something not covered there?

Thanks,
NeilBrown


> +		}
>  	}
>  	return finish_no_open(file, res);
> =20
> --=20
> 2.51.0
>=20
>=20


