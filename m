Return-Path: <linux-nfs+bounces-17362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA8CEAF48
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9323016351
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 00:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D450B1E49F;
	Wed, 31 Dec 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Nj/TJaED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lx8M387N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5801DFF7
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767140183; cv=none; b=jBtP5plIy/jKSFLBPYtw6l3TU3kJS7hRQEYT6mOdLgxv1rwVLclD5+iWWJAca6lKyuUz80fG5znzSnt/yNNz8XV5AboCdmgRJzBECJdawYEZL6GptdSvHtFgrO2MD8l5gQzsxJ+9SfhrLta9KtWknh1/6gE3uQr7eHRBvywd6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767140183; c=relaxed/simple;
	bh=YFQEUGnUO1C/G+g410qawP0msPEbctUaJ8rl/9sl5YY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LJAYiS+wlKRipmhrjpzMLw8Ya+7q2iMKp6enkYtoUumM367Ink1V53N3+8Beg8a0P48YGatZZrGn9q3bPUelye9U+D3fSLHGvdoblYDCGjUewbirXJCugLWb/XpeEYHvA0KzR/k/fhwvIu7Y+LL9KEO/FwzdVb4EDM9fzoTPPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Nj/TJaED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lx8M387N; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8010B1400100;
	Tue, 30 Dec 2025 19:16:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 19:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1767140180; x=1767226580; bh=yRQaQloQjKM4x/5sLXoUtLk6mK3QeKWNfA3
	qr5EwSgI=; b=Nj/TJaEDliNqWOnnXvwXHDuJ9/qqfX8eKN+LKVuz+w2qWxOIlHo
	ivk1EG4c4Apk3x87Nj3ip0V4Vkg/4fHgryQk8XsMDIj/sl1wnwGbkIUdhsA2Ltaw
	4z9fGbL70jweBeLFm8t+PTG66cKTKPxP6akZt2Ttu9g2yyn7K/qVzOdk0Eu3KVok
	46zpnhVh6hv+sjrLYPHuEkQtODL13SFbuqOuX5dPkX3EDQrol/6A5ksMM5xO6MdR
	4QR5+3gALoFtoVSk10JRhyvqzbI2sTVncTByC7DlEwVyRnwprPhXyoMFRlFL+GWw
	KTh7/3/MX6iBAQSz/crx/qpzqZOUewGN0uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767140180; x=
	1767226580; bh=yRQaQloQjKM4x/5sLXoUtLk6mK3QeKWNfA3qr5EwSgI=; b=l
	x8M387NVdHeQCvZVG1hI3prjYlXwLzYJ4SWPwiLoGlDqbYq97DldCggwMPB5gALd
	m2KXg1IizlHm7cp4CFmysk6kjGSMObz4gelNLgZxpA/uRGPmHUvTdQZfCAlN07Xy
	PdF0VeTMRUc7TVTmudnsn1NUiBQlaqpdCKxuqZObWUckiuJEy90zNVzf/Dy1jaP+
	FOZ0dEBt/kol+u4CPti0cJqe+ohyp2fj8F8g9OC9BX2sWkFRSobsINOVidJEr8u2
	HFMNX8xFwZCbxRuj5Y8DpDJagh2qWdGSbgsTGzLSXco5LlSkBsLhIBMIotRiZl6p
	EVDqKaOE8whFQiQABKYbg==
X-ME-Sender: <xms:VGtUabm501dAt2vL_jLRn1eSKNHPIB6w93F0fe6Ezxs2yQraeg0GNA>
    <xme:VGtUaRFOXEE6ef7Ldih3L_P9t8VDiAow1OujozYhp1Qmmdf2eR4ui8mKE5mCJV6y0
    JZ4ZDDdcJ-OTXvoRB1pPEyF1sLRAo21K77-fX_XmldJw9zgAA>
X-ME-Received: <xmr:VGtUaT5fYGOLH4yIG1dcIp1TNbPgiYLaxKNQ7KXqlSFYJwK37MHZ75hAQhrxUJCh4dR752LhKtq7K_aE5ggglxSsWPC9DTzQcqjt8yYZ6_7t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudeggecutefuodetggdotefrod
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
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvg
    hlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VGtUaZmvcQVGUj246Q94eBWZUwKsF7P5QeHIurWCHDe9_93yQEZdeQ>
    <xmx:VGtUaYoO7EtYrLWfyTQ8e_BigDJ8JAgYF6M4xlrdoXdlralxxo0x0Q>
    <xmx:VGtUaYuMF85HxhtOGOqRnFyjumptKD_6QDaUpvA7qSfHrqDcgksqYQ>
    <xmx:VGtUadEUSnaFkyHCznI69nvRgw3Ez2QNjT0FDkeSwHQ9ITnOUoRJ-w>
    <xmx:VGtUaQyTYKDB0S11m-lDN2s55p2uEWkXHFIwCXLkBm6qQVIdniuruEN2>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 19:16:18 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v1 5/5] nfsd: close cached files on filesystem unmount
In-reply-to: <20251230141838.2547848-6-cel@kernel.org>
References: <20251230141838.2547848-1-cel@kernel.org>,
 <20251230141838.2547848-6-cel@kernel.org>
Date: Wed, 31 Dec 2025 11:16:16 +1100
Message-id: <176714017638.16766.126850013779418280@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 31 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> When a filesystem is unmounted while NFS is exporting it, the
> unmount can fail with EBUSY even after NFSv4 state has been revoked.
> This is because the nfsd_file cache can hold open NFSv2/3 file
> handles that pin the filesystem, preventing the unmount from
> completing.
>=20
> Extend the mechanism that revokes NFSv4 state on unmount to also
> close cached file handles. nfsd_file_close_sb() walks the nfsd_file
> cache and disposes of entries belonging to the target superblock.
> It runs after NFSv4 state revocation, so it handles only NFSv2/3
> file handles that remain in the cache.
>=20
> Entries still under construction (with nf_file not yet set) are
> skipped; these have no open file to close.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/filecache.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/filecache.h |  1 +
>  fs/nfsd/pin.c       |  6 ++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 93798575b807..bbef58c1caa9 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -894,6 +894,45 @@ __nfsd_file_cache_purge(struct net *net)
>  	nfsd_file_dispose_list(&dispose);
>  }
> =20
> +/**
> + * nfsd_file_close_sb - close GC-managed cached files for a superblock
> + * @sb: target superblock
> + *
> + * Walk the nfsd_file cache and close out GC-managed entries (those
> + * acquired via nfsd_file_acquire_gc) that belong to @sb. Called during
> + * filesystem unmount after NFSv4 state revocation to release remaining
> + * cached file handles that may be pinning the filesystem.
> + */
> +void nfsd_file_close_sb(struct super_block *sb)
> +{
> +	struct rhashtable_iter iter;
> +	struct nfsd_file *nf;
> +	LIST_HEAD(dispose);
> +
> +	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 0)
> +		return;

It is only valid to test NFSD_FILE_CACHE_UP while holding nfsd_mutex.

Otherwise this patch looks good.

Thanks,
NeilBrown


> +
> +	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
> +	do {
> +		rhashtable_walk_start(&iter);
> +
> +		nf =3D rhashtable_walk_next(&iter);
> +		while (!IS_ERR_OR_NULL(nf)) {
> +			if (test_bit(NFSD_FILE_GC, &nf->nf_flags) =3D=3D 0)
> +				goto next;
> +			if (nf->nf_file && file_inode(nf->nf_file)->i_sb =3D=3D sb)
> +				nfsd_file_cond_queue(nf, &dispose);
> +next:
> +			nf =3D rhashtable_walk_next(&iter);
> +		}
> +
> +		rhashtable_walk_stop(&iter);
> +	} while (nf =3D=3D ERR_PTR(-EAGAIN));
> +	rhashtable_walk_exit(&iter);
> +
> +	nfsd_file_dispose_list(&dispose);
> +}
> +
>  static struct nfsd_fcache_disposal *
>  nfsd_alloc_fcache_disposal(void)
>  {
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index b383dbc5b921..66ca7fc6189b 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -70,6 +70,7 @@ struct net *nfsd_file_put_local(struct nfsd_file __rcu **=
nf);
>  struct nfsd_file *nfsd_file_get(struct nfsd_file *nf);
>  struct file *nfsd_file_file(struct nfsd_file *nf);
>  void nfsd_file_close_inode_sync(struct inode *inode);
> +void nfsd_file_close_sb(struct super_block *sb);
>  void nfsd_file_net_dispose(struct nfsd_net *nn);
>  bool nfsd_file_is_cached(struct inode *inode);
>  __be32 nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> diff --git a/fs/nfsd/pin.c b/fs/nfsd/pin.c
> index f8d0d7cda404..0c1de8fd0e43 100644
> --- a/fs/nfsd/pin.c
> +++ b/fs/nfsd/pin.c
> @@ -19,6 +19,7 @@
>  #include "nfsd.h"
>  #include "netns.h"
>  #include "state.h"
> +#include "filecache.h"
> =20
>  #define NFSDDBG_FACILITY	NFSDDBG_PROC
> =20
> @@ -49,8 +50,8 @@ static void nfsd_fs_pin_free_rcu(struct rcu_head *rcu)
> =20
>  /*
>   * Work function for nfsd_fs_pin - runs in process context.
> - * Cancels async COPYs, releases NLM locks, and revokes NFSv4 state for
> - * the superblock.
> + * Cancels async COPYs, releases NLM locks, revokes NFSv4 state, and closes
> + * cached NFSv2/3 files for the superblock.
>   */
>  static void nfsd_fs_pin_work(struct work_struct *work)
>  {
> @@ -63,6 +64,7 @@ static void nfsd_fs_pin_work(struct work_struct *work)
>  	/* Errors are logged by lockd; no recovery is possible. */
>  	(void)nlmsvc_unlock_all_by_sb(p->sb);
>  	nfsd4_revoke_states(nn, p->sb);
> +	nfsd_file_close_sb(p->sb);
> =20
>  	pr_info("nfsd: state revocation for %s complete\n", p->sb->s_id);
> =20
> --=20
> 2.52.0
>=20
>=20


