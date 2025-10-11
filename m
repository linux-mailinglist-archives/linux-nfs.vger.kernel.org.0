Return-Path: <linux-nfs+bounces-15142-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6780BCEC9F
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 02:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0193E0A39
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473228E5;
	Sat, 11 Oct 2025 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="gtBK9mgZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tsHOSyii"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445B8F40
	for <linux-nfs@vger.kernel.org>; Sat, 11 Oct 2025 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760141088; cv=none; b=sQyne2n+kvWar/t/FGlaJZpduIR1qQiXdyCv7u6Ejip/Fz88jV8e2P0htzNbC+aYUKI0XJhyDaLv57ySv44kVW/lOer9yKshFqvTe5fNQEerRqNcAJCH/NEUXlgMlZDB1lQaK3hl4L6bTEfzohjw1l43QJ9sJX3iUiLwzpCDZ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760141088; c=relaxed/simple;
	bh=Q8OdcSIDrZgTMMIqbSym9DnVu0kpaJHLVrX+3Fzmkog=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=myoty69H7Bgrbyqh1oP3T5fGWQ8XoncjuIdxfY2kcaJksu4Vl7bCF5E1Q111gZ1QPsRwnbFuHEL95uKjZ1C9tIMZ0/oarl4E5NTuWxQ03qESHyAEyK1xjUQaAXdW/KpZuUiS7YtEbKwBeB/J5OCbYTJpJPbq9ZMpzQ5DtjmnKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=gtBK9mgZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tsHOSyii; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A01101D00158;
	Fri, 10 Oct 2025 20:04:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 10 Oct 2025 20:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760141085; x=1760227485; bh=Q4/8Pw0xu8MYmRPc6/m534DujI65X/9gUlW
	TjLLIv2o=; b=gtBK9mgZpgeW4VDx+Qa1OajCRqC04kh65qXy6QlaFaB1RD6Cic7
	1z88b7G5N7y7DVuSp1LAobvJ9EXdDWU2AgpZlhSihvAS3A8e0D6j2cCY+eEwXaHE
	kkRjXm7FA/6HdbJJV3XpdoXAslpA4L+n7mhI8p3NoMLSs1hKKj7htRO370jBt7/c
	tC3cqEU4ay7PiOcZF5CkiqRB9KUuUjbdgMK4BvuLjyRUjAecisDvNO3kBdwnPMJI
	75ky7NLb1yK1KnsEN7bTZbzDVDKkteYwA3TH6zbNZQPgmehVx8+fjCQw4BEiNr5U
	G+Bk7/dpgBTGx2x0dTVeSRtTpdgxlMi1iJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760141085; x=
	1760227485; bh=Q4/8Pw0xu8MYmRPc6/m534DujI65X/9gUlWTjLLIv2o=; b=t
	sHOSyii++3qIGmSRz5YVZq+INJQKCrAAh0yboDtNHpUluVTuY9NbLcD6BxMh+78w
	mtzpuIZpCgikNc59xTrzhNWaN7E3G7zFVeQ/A/1mbqNxuJLkDR7Aij3z9k/4IET1
	y704LUO/l5xrHy1cuQegLdZWN1M7c1p5NGRaTYyIyXI8JHxnfBiwTRmow2D/S3Y7
	2SLlcX7V2JUD8SoT3EHN+AeqQuUAi3I14ZJ8UOrQucDUqRP3ISkvJ4nrQB5vU8gU
	0+sV7EOaqSE33hmDXLdPODvF5y7oT8Xcu2rLBB1etMlSB2NBpXNZybisyromKE7T
	PhxigmPIAq3cTsvoB4wIg==
X-ME-Sender: <xms:HZ_paGPsH4RD4uhOsDYF701CLeENyCGiV5sXTmg9zowIdS88d_m5Ig>
    <xme:HZ_paHOcCrQyi9Wab6ytezW8NqVAUtuLen9C22DjYwndRX9I-QxHt1wYAzKbAbbyn
    PzGc34uqG4CFdac2TDuxm_Yy83fpKopI2OiOB1nyyHA3rRU>
X-ME-Received: <xmr:HZ_paPjKWxAXEgoxPVycTtp0AHeTQZ4vf196VMLTVV7yT3O_e45ppdsMob2hfdKxZd9-az7_5Wt1L8Zs-txdBhQNbMJ1tBV0YxAIwNGMos2a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtgedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:HZ_paMupvyojKAEkE-tMlabenUU7tQVnzTfDsI7bIOt5wFTD8-wDTg>
    <xmx:HZ_paNSBAD_XXwNprF09cF3Og3xrTt8rxn1swr2_7DaH0ksgn3i4kg>
    <xmx:HZ_paA0fmSHgdBIv-IUkRJ-lKDGY7DQZhkjJ8jZIibcPTJ6kpkFtcg>
    <xmx:HZ_paCtC7jk7SctjP6VaUkti2Y8WcjAsk4HAjg1v1vU6FSdYFa2D6A>
    <xmx:HZ_paO7v-Q7fH5OJDUYeE6KuUEXftg1Ug5YZRz7D0qujsEamC2OPgbeW>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 20:04:42 -0400 (EDT)
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
Subject: Re: [PATCH v3 4/5] NFSD: Increase minimum size of slot replay cache
In-reply-to: <20251010135623.1723-5-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>,
 <20251010135623.1723-5-cel@kernel.org>
Date: Sat, 11 Oct 2025 11:04:39 +1100
Message-id: <176014107992.1793333.5592909195665364583@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 11 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> NFSD caches solo SEQUENCE even when sa_cachethis is false. Ensure
> there is enough space in each slot replay cache, even when the
> client requested a zero ca_maxresponsesize_cached.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b80f00fb32c..7d297ac2bf2b 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2024,11 +2024,12 @@ static struct nfsd4_slot *nfsd4_alloc_slot(struct n=
fsd4_channel_attrs *fattrs,
>  	size_t size;
> =20
>  	/*
> -	 * The RPC and NFS session headers are never saved in
> -	 * the slot reply cache buffer.
> +	 * Reserve enough space to handle solo SEQUENCE operations,
> +	 * which are always cached.
>  	 */
>  	size =3D fattrs->maxresp_cached < NFSD_MIN_HDR_SEQ_SZ ?
> -		0 : fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;
> +		NFSD_MIN_HDR_SEQ_SZ :
> +		fattrs->maxresp_cached - NFSD_MIN_HDR_SEQ_SZ;

This seems incoherent.
The existence of, and documentation for, NFSD_MIN_HDR_SEQ_SZ implies
that the SEQUENCE reply is NOT stored in sl_data.  When maxresp_cached
is large, we STILL don't allocate space to store the SEQUENCE reply in
sl_data, only the subsequent ops.  So allocating NFSD_MIN_HDR_SEQ_SZ
(which is more that just the SEQUENCE reply, it is also the COMPOUND
reply and the RPC header) makes no sense.

It appears that (this part of) the code is designed to generate the
SEQUENCE reply (like the COMPOUND reply and the RPC reply) anew each
time, and only replay the remainder from sl_data.  Certainly that is
what the comment above NFSD_MIN_HDR_SEQ_SZ says.

nfsd4_encode_sequence() sets cstate.data_offset *after* encoding the
sequence reply.  So that seems to be doing the right thing.
nfsd4_replay_cache_entry() encodes a SEQUENCE reply before including the
data from sl_data.

So where is a problem occurring?

Looking back at the bug report, I think that the only problem was that
nfsd4_is_solo_sequence() was always reporting true, so we always try to
cache the result, even when too big.

Though ...  the bug report has the client send a maxresp_cached which is
LARGER than maxresp_size.  That is weird.  I'm not sure we handle that
well.  I think that if maxresp_cache is larger, we need to clip it to
maxresp_size as it makes no sense to try to cache a reply large than we
are willing to handle....

NeilBrown


> =20
>  	slot =3D kzalloc(struct_size(slot, sl_data, size), gfp);
>  	if (!slot)
> --=20
> 2.51.0
>=20
>=20


