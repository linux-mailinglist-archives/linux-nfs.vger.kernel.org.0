Return-Path: <linux-nfs+bounces-15170-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F381BD163B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 06:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F497344FB1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 04:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662002727E0;
	Mon, 13 Oct 2025 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BeV1aHx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/LW8De/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91389221739
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760330692; cv=none; b=Y1i7rXyT9o73v0ILbPr92YNm4NTRTnhTM7bK2SmjuhzRsCuatOVwBFnE8oG/uSqcEIgV1l1fyLkdoR7HUGcWTTjKb3PlOCVhqbRNJ+drdk2HQ4zHM4GdKEM4OsXAI5ByzcuPkNXv0wIPDHqMczugMvAQBE0htnoQLtmTgZuizag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760330692; c=relaxed/simple;
	bh=tLuawrI+wsVSjMj+zP3HhHxj+H1r6Bx6Kipw/YmqrO0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IdCC+/mIedwAklyt0tN8piMdNlYkbtnfA9k/U8lnrAH6rZN3wY3uMPaqJ7iEqdpWdAP6U1zHp6v357JRCEhEiisSJWaCyMAOFHhBSvBlcqGiILvTchh0IzU0IMg3sQh4mw23oRpbE/bxAolP02nesgeBgxs9CQ4uD0J7rvuJuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BeV1aHx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/LW8De/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C71BC7A0059;
	Mon, 13 Oct 2025 00:44:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 13 Oct 2025 00:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760330689; x=1760417089; bh=3pE8elymTjIpPF0cS8D0/jG5LBRSS0BazEo
	dl04E+PI=; b=BeV1aHx+ypHZ580RpIP032UHCooywSDo883fEa4ACmB5UKzvNvU
	AbmQuAgyXUhZyRSh+r9lG2ikD1fAiHqm5mTMISuQ271/k43dcSZzLG0Mj3M7FAuy
	ghSn6ZL2LXsR1lSDqWr5pXmVbrwZ98EeuH7b4bZoBVJjvS/gNJOMXX1mol10tNee
	GDHVAVzzsUrlJOXan1dkEIwfqnLtd0hhcj6atBJXeGBJ8EFYH15+3LFH3kuyuR+6
	XNBLbT3uHswEVrP+p5XdaY1zByvygoIG4ZOzlVmH8Z/Vmp/kF/F8vRGv2ROMOrAJ
	6YetQYUxjoRjyJAuApSyxqB+uk58pshugsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760330689; x=
	1760417089; bh=3pE8elymTjIpPF0cS8D0/jG5LBRSS0BazEodl04E+PI=; b=a
	/LW8De/lWspW05WTXmGHYeUtBfrgVAp3jA84AzCn9CiZ9JwcAkGodRyD+eVWXcPz
	kX2UzfNrfMQuPXGJmQt1plEIlSZQ2dnL81A3Ptw/FBY2lb4AuHY2TbiB4mjAwlrL
	755OG8iE2xCIXTZPolfkW2CefOMSi1UuEIsbF2N/xodNtamS5NhyTHzNuhGbh4kL
	oU6oldLU4xeLnnye9+rPHu9S/r8rqbRmFBTCfc+TF+pP1Z9clZ/8s1U8a/kQCeYH
	kIctGqCdf3qcVcyDwDuipijFIavVW8o8+4hIilU/CVaFF2M5X8hk9xbUNxiqzh/T
	4qUC7vCZiZmV6f4itynOw==
X-ME-Sender: <xms:wYPsaGsW6ta6i6Vcs3iIWJ9BV-D-7OfYWNHWW-e5eU8MGnVgi5T5QA>
    <xme:wYPsaNuxQUWS3XGzMh9TT98mWLFZGsru_J4bGKBAsF8RyZEWPnM-R-55F0E5_cKWw
    lpdcxdFuVr9U6uj8iUdBEn2z0YNZNqE0JjAAqY2ckJeLPMQcw>
X-ME-Received: <xmr:wYPsaEBY600JeDQLDV9HRdOiItS-LkoaG_gZfZVx_kBmVlv64YrZV9800BLyaGFcExuqFlpcUdKYt1L_Zs2URB5SejjzPusdrFo0fb-3ea24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudeijeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlh
    gvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    gvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wYPsaHOBLQhJmyIvLahPcu4-Wc90fNt60mhxIJggBKLg9JJk8zL-iw>
    <xmx:wYPsaFxEZrW4RN9ZfIGGbUudXg2nCG2o21bnBnJKDIyKzdLHuV0Mfg>
    <xmx:wYPsaPUiEz2KuAauuxmuOdlXqAjPNt0XQ3zMcECV9Dld3vP_KEKmAg>
    <xmx:wYPsaPNbRFZAVXhz0jIFg_1Mo0qk3j0szS27lhst-m5N_yxIsPysoQ>
    <xmx:wYPsaFbXcl2vnrJ7547YivU-F_mKTK8u78mss7ah4MnxNOPSMHwwSUJw>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 00:44:47 -0400 (EDT)
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
Subject: Re: [PATCH v4 4/4] NFSD: Move nfsd4_cache_this()
In-reply-to: <20251012170746.9381-5-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>,
 <20251012170746.9381-5-cel@kernel.org>
Date: Mon, 13 Oct 2025 15:44:45 +1100
Message-id: <176033068550.1793333.1118224453685885375@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> nfsd4_cache_this() has one call site, and is not related to XDR at
> all. It doesn't belong in fs/nfsd/xdr4.h.
>=20
> As a clean-up, move this function (and its helper) to nfs4state.c,
> next to its only caller.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Reviewed-by: NeilBrown <neil@brown.name>

Definitely better having the code local when possible.

Thanks,
NeilBrown


> ---
>  fs/nfsd/nfs4state.c | 22 ++++++++++++++++++++++
>  fs/nfsd/xdr4.h      | 22 ----------------------
>  2 files changed, 22 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4b4467e54ec9..5fd2138cb074 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3476,6 +3476,28 @@ gen_callback(struct nfs4_client *clp, struct nfsd4_s=
etclientid *se, struct svc_r
>  	return;
>  }
> =20
> +static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
> +{
> +	struct nfsd4_compoundargs *args =3D resp->rqstp->rq_argp;
> +
> +	return args->opcnt =3D=3D 1;
> +}
> +
> +/*
> + * The session reply cache only needs to cache replies that the client
> + * actually asked us to.  But it's almost free for us to cache compounds
> + * consisting of only a SEQUENCE op, so we may as well cache those too.
> + * Also, the protocol doesn't give us a convenient response in the case
> + * of a replay of a solo SEQUENCE op that wasn't cached
> + * (RETRY_UNCACHED_REP can only be returned in the second op of a
> + * compound).
> + */
> +static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
> +{
> +	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
> +		|| nfsd4_is_solo_sequence(resp);
> +}
> +
>  /*
>   * Cache a reply. nfsd4_check_resp_size() has bounded the cache size.
>   */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index d4548a16a36e..6f0129ea754d 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -923,28 +923,6 @@ struct nfsd4_compoundres {
>  	struct nfsd4_compound_state	cstate;
>  };
> =20
> -static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
> -{
> -	struct nfsd4_compoundargs *args =3D resp->rqstp->rq_argp;
> -
> -	return args->opcnt =3D=3D 1;
> -}
> -
> -/*
> - * The session reply cache only needs to cache replies that the client
> - * actually asked us to.  But it's almost free for us to cache compounds
> - * consisting of only a SEQUENCE op, so we may as well cache those too.
> - * Also, the protocol doesn't give us a convenient response in the case
> - * of a replay of a solo SEQUENCE op that wasn't cached
> - * (RETRY_UNCACHED_REP can only be returned in the second op of a
> - * compound).
> - */
> -static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)
> -{
> -	return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)
> -		|| nfsd4_is_solo_sequence(resp);
> -}
> -
>  static inline bool nfsd4_last_compound_op(struct svc_rqst *rqstp)
>  {
>  	struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> --=20
> 2.51.0
>=20
>=20


