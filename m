Return-Path: <linux-nfs+bounces-17107-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F9CBF797
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 941FA30084EF
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CF426D4DF;
	Mon, 15 Dec 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSGb39cU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAF26462E
	for <linux-nfs@vger.kernel.org>; Mon, 15 Dec 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765825151; cv=none; b=dQdQ6mlzWgwq8S/yxzFUe8nMzYYGeCOGgug3Nqwo21FHKvIyPvHTNwsEPesuIOwQzKpxUbfgaSaA+2KwUbyW/PPTfguSkj0ugwSR1huaKzML0GcQGKoIsJhk73cIxJR30YSAOQp6wrYyNvRZAPl/IkjTC/bAkdCLPR58HySsgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765825151; c=relaxed/simple;
	bh=ANU4TMH/meE0YQ/m/UWEINZvjQGpl5VXmoBd0nO1VJY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XFzLQcHEj54i7LDtqxWb8KL35ORSrpdN55fjERSHHxZDh+JXwU09A7WoPtyKXtN1SXKY09e+eFBPTsB8kxaUmLgNPviqRAadOezlF1SoDiwF4kJtbH1w1aqyMjo85D/xLlFf/Ln1//7w9nTGg6dP38BLAMj6sOli+qFrwiH7Vt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSGb39cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3D6C116B1;
	Mon, 15 Dec 2025 18:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765825151;
	bh=ANU4TMH/meE0YQ/m/UWEINZvjQGpl5VXmoBd0nO1VJY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GSGb39cUHo973zAsyhZGXeQbLt57byyJ9JUOCdyHoz3tdr1qUa126B7/5/fVtz6hh
	 5mawABjThuY4wcS4QpqDOvnaFzNFTXAuLABSE6NMWgaf1SxYt1JUa8deaVD4jvP7TH
	 mFMDWThQQDLCzoQiiNsUE1OAS1VTKlGRxUvkSaUqihTFRuTApHjsVkmX74kXflxdL/
	 UcXTNOklFfHjW6WxX1+xPvpm1VT7YZL4Of095B5wyg4eV6K/WS5o1Mpzux2VH14OHZ
	 X/vsYtkHIqKCV5mqWxVD6X2mPuNvzLBcRvLgC1wKzESWHYQp3dNwCQHLlAC22K4v3x
	 okIYpNouRAH6Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A0F0F4008A;
	Mon, 15 Dec 2025 13:59:10 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 15 Dec 2025 13:59:10 -0500
X-ME-Sender: <xms:flpAaUPBxeiVYVpPhIRUvUlaeBuSybq8J6ddIHc6zkMtKbbr-I1jcw>
    <xme:flpAaVxPKOe1ZK0As9bb4l9A5D4NmvzxNWbULXOV4X2V3IXg2ClrfdwLG0sV6WiFC
    UGrsm9uF0PmAeoz4S-_eHXsQ6HXgGDW1m7FgxBemfOxnLl_Dd8I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefjeehlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:flpAadi8SEK6MX6iaB1aVyMSrlRUnGrUrw6KHJ92uMlTTcw3E_quQg>
    <xmx:flpAacCVq26mfh7mgpOWyf1yQcSfnpPN4l4Xim7ce14kvcRci1Ypsg>
    <xmx:flpAaTvR1_zSPZLFcAyAGeZQa9BKUsTrBoSNQfv8f9ie_cHtY-4DAw>
    <xmx:flpAaQcW-3oT10S1JJZ9rb4xx52BkShqUwtXAHJLwdO8XAGsTg52Pw>
    <xmx:flpAaY_76dXXphV7EiCLELvKlt0ygGiXliLV81u2ywthig9fYIZXqca6>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 14E57780054; Mon, 15 Dec 2025 13:59:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEa6kMrq8Ft3
Date: Mon, 15 Dec 2025 13:58:49 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Dai Ngo" <dai.ngo@oracle.com>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, neilb@ownmail.net,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Tom Talpey" <tom@talpey.com>,
 "Christoph Hellwig" <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
Message-Id: <f8b4865f-044c-4a5c-b4a6-6e1ea9e756e4@app.fastmail.com>
In-Reply-To: <20251215181418.2201035-2-dai.ngo@oracle.com>
References: <20251215181418.2201035-1-dai.ngo@oracle.com>
 <20251215181418.2201035-2-dai.ngo@oracle.com>
Subject: Re: [PATCH 1/3] NFSD: Move clientid_hashval and same_clid to header files
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Dec 15, 2025, at 1:13 PM, Dai Ngo wrote:
> As preparation for introducing infrastructure to track SCSI fencing ev=
ents,
> relocate the clientid_hashval function from nfs4state.c to nfsd.h and =
the
> same_clid function from nfs4state.c to state.h.
>
> No functional changes are introduced in this commit=E2=80=94only movem=
ent of code
> to improve accessibility for forthcoming enhancements.
>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 15 ---------------
>  fs/nfsd/nfsd.h      |  5 +++++
>  fs/nfsd/state.h     |  5 +++++
>  3 files changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..13b4dc89b1e8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1423,15 +1423,6 @@ static void revoke_delegation(struct nfs4_deleg=
ation *dp)
>  	destroy_unhashed_deleg(dp);
>  }
>=20
> -/*
> - * SETCLIENTID state
> - */
> -
> -static unsigned int clientid_hashval(u32 id)
> -{
> -	return id & CLIENT_HASH_MASK;
> -}
> -
>  static unsigned int clientstr_hashval(struct xdr_netobj name)
>  {
>  	return opaque_hashval(name.data, 8) & CLIENT_HASH_MASK;
> @@ -2621,12 +2612,6 @@ same_verf(nfs4_verifier *v1, nfs4_verifier *v2)
>  	return 0 =3D=3D memcmp(v1->data, v2->data, sizeof(v1->data));
>  }
>=20
> -static int
> -same_clid(clientid_t *cl1, clientid_t *cl2)
> -{
> -	return (cl1->cl_boot =3D=3D cl2->cl_boot) && (cl1->cl_id =3D=3D cl2-=
>cl_id);
> -}
> -
>  static bool groups_equal(struct group_info *g1, struct group_info *g2)
>  {
>  	int i;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 50be785f1d2c..369efe6ed665 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -510,6 +510,11 @@ static inline bool nfsd_attrs_supported(u32=20
> minorversion, const u32 *bmval)
>  	return bmval_is_subset(bmval, nfsd_suppattrs[minorversion]);
>  }
>=20
> +static inline unsigned int clientid_hashval(u32 id)
> +{
> +	return id & CLIENT_HASH_MASK;
> +}
> +

I can't comment on the overall purpose of this series yet, but
there are one or two mechanical issues that I see already.

Let's not add NFSv4- or pNFS-specific functions to fs/nfsd/nfsd.h.
Same comment applies to the function declarations this series moves
in a subsequent patch.

Why can't clientid_hashval() go into fs/nfsd/state.h instead?

Also, when a function becomes accessible outside of one source
file (like a "static inline" function or a callback function),
it needs to get a kdoc comment that documents its API contract.


>  /* These will return ERR_INVAL if specified in GETATTR or READDIR. */
>  #define NFSD_WRITEONLY_ATTRS_WORD1 \
>  	(FATTR4_WORD1_TIME_ACCESS_SET   | FATTR4_WORD1_TIME_MODIFY_SET)
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 1e736f402426..b737e8cfe6d5 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -865,6 +865,11 @@ static inline bool try_to_expire_client(struct=20
> nfs4_client *clp)
>  	return clp->cl_state =3D=3D NFSD4_EXPIRABLE;
>  }
>=20
> +static inline int same_clid(clientid_t *cl1, clientid_t *cl2)
> +{
> +	return (cl1->cl_boot =3D=3D cl2->cl_boot) && (cl1->cl_id =3D=3D cl2-=
>cl_id);
> +}
> +
>  extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>  		struct dentry *dentry, struct nfs4_delegation **pdp);
>  #endif   /* NFSD4_STATE_H */
> --=20
> 2.47.3

--=20
Chuck Lever

