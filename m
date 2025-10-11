Return-Path: <linux-nfs+bounces-15143-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D7BCECFD
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 02:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763273E7BD2
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Oct 2025 00:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55C632;
	Sat, 11 Oct 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ZbbMnJcU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RHH9nNna"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5A229CEB
	for <linux-nfs@vger.kernel.org>; Sat, 11 Oct 2025 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760142405; cv=none; b=WWI5uV0kjkkvHeqU/zBDozETwZRNkePTMhKLhUcCxx/A1cpCv9HaUhQR6crUPmMYNls4RsL1SOruyW5tkxeuGa66XZQeEmtySmrxdmaE++u86pGlyMUYxy53urUpdTsbHIPuez1592unS8gkIsvD4XN5kAnad8YyrFnV2QOX4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760142405; c=relaxed/simple;
	bh=+UuTwJPJliPPZLBS6zU6OoigpIaSwOZ7COxkZV7f6X8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NPCtNBZJUMeNJ0hXzRe7c/pjv1q24UqvGlt20SFGgixIAjytsY8YOXIOfuSlTGCMs4HZjqfFlqR4H6QXVZtU8yjcvHSOjPg1YL4M6DT8lXRmlDbK8Jo1rBWG78qAACVjepz2yrDFlocwP/nBcUJhIu5p9lnulK0wTFleIGrX20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ZbbMnJcU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RHH9nNna; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 165741D000FF;
	Fri, 10 Oct 2025 20:26:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Oct 2025 20:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1760142400; x=1760228800; bh=EfXWA1KzHD8mcBh2sBZvrrHq6Yj52QQyvzU
	vpKcXWRI=; b=ZbbMnJcUhBG3oa7thloyjhHnaCYr8eNCkDKw58YV6RGWzP4gmED
	KQvKpm7wGY8gvxdHU7fYuZW4bit4SgNV69U2BiVvpBE4o4IKZ7+ihyzRlRE9xMlL
	Lup0wNrchG6XQAWijMGabZ3F8oLZM2t0pBSBhnxmQTm7aw+LCUTlCriseZZ24OPf
	8YjDG1W2tuM+/qCBDTLAwNkvcxQlYQpzRW+7HburRBcdEV0endEd7jadeeE41mpB
	OuMDETg7ErSfKfUbvaAuJGpDpzpWNCtT+R1IlBttsuPKxN2IF3ClkHRkIpdOVRdK
	2+EBfyw6nWNEezlTSexValdYDhY4TbBMWQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760142400; x=
	1760228800; bh=EfXWA1KzHD8mcBh2sBZvrrHq6Yj52QQyvzUvpKcXWRI=; b=R
	HH9nNnamrnIOHfd2SESYJuGOA+j3ZjGpNS93ExURnA+IUwnS/cMgDHMhsGt9BbWh
	vMSgMa+tRzZwxqR2O+8xTHcS38KHAmVK6jSLKmCZYvgnatQu6TWwbsEQUv52i4Yk
	NBMcpbeX74VC/gSKvo+ABl3E0bnaiiDen3whAGpV7ASAQiEWwLp4K9u+C2TVmfcs
	xCZW7UsZ9DTGtwT3spu17I9ScAW4VUlaP2OmCb4nInMctDNvXc6gbDfZnn0q7vRn
	cPO2XWtbRFTZwO9jYAw07rvtNstJAy758mF0Sb82IPkwEC2vG9k8FY+8pE82P82h
	ttmjJBhUHrid8m3FjlV5g==
X-ME-Sender: <xms:QKTpaInpWx-ukViZCkGFscORcbYTgkUNOg8EOP7mYEREKBWw3DTHDg>
    <xme:QKTpaNATfi6PzSyteG7EVHWDX839ZbNWtPOseqz7TrPFD1rIt9X3-AxqQ6vunK_dX
    eSZbe0xalm0P-tjoAoBW1yZtphYvmnVn0_l5tqM1Pg23NSI3x8>
X-ME-Received: <xmr:QKTpaHhN85Wsf2sZ0HAYUFdDiolNritk__L0HDAQUUadlKYQwntyulwULKWb-YF22_uNm4kA095xxpjmUpnZgrkeTlnXfmCBu9CEmTIORKrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehrthhmsegtshgrihhlrdhmihhtrdgvughu
X-ME-Proxy: <xmx:QKTpaKwclW2uYQa3QIuwxEoviUmm-jG6h5iG8WxIGmYek2XKmn72Sg>
    <xmx:QKTpaI2dg2mYO6tqhNq3CDtq35fI3Lbfct8ct0LXD-cTzMc-ggYruw>
    <xmx:QKTpaP-XsDeVU9x5K7wiiekd5O7KevjxqPsi4p13QmIsIK75bEAQSQ>
    <xmx:QKTpaAqHYK3Pr9JuO9runONIJ4Svt-Z67cQNqttvpiQ1HqZZJ9ByAQ>
    <xmx:QKTpaPdsUSmBjoztIfOrJlgvToTFTg60CRDU1jyiI9qzGXQCEwvE4xtI>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 20:26:38 -0400 (EDT)
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
 "Chuck Lever" <chuck.lever@oracle.com>, rtm@csail.mit.edu
Subject: Re: [PATCH v3 2/5] NFSD: Fix the "is this a solo SEQUENCE" predicate
In-reply-to: <20251010135623.1723-3-cel@kernel.org>
References: <20251010135623.1723-1-cel@kernel.org>,
 <20251010135623.1723-3-cel@kernel.org>
Date: Sat, 11 Oct 2025 11:26:34 +1100
Message-id: <176014239402.1793333.16351546016862648537@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 11 Oct 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> RFC 8881 Section 2.10.6.4 says:
>=20
> > If sa_cachethis or csa_cachethis is TRUE, then the replier MUST
> > cache a reply except if an error is returned by the SEQUENCE or
> > CB_SEQUENCE operation (see Section 2.10.6.1.2).
>=20
> This text also appears in RFC 5661. Further, Section 2.10.6.1.2
> says:
>=20
> > Any time SEQUENCE or CB_SEQUENCE returns an error, the sequence ID
> > of the slot MUST NOT change. The replier MUST NOT modify the reply
> > cache entry for the slot whenever an error is returned from
> > SEQUENCE or CB_SEQUENCE.
>=20
> NFSD caches the result of solo SEQUENCE operations, but rtm's
> reproducer sends two operations in the failing COMPOUND. NFSD should
> not attempt to cache the reply.
>=20
> The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
> current operation index, not the total count of operations in the
> COMPOUND. If the SEQUENCE operation, which is always operation 1,
> fails in a multi-operation compound, resp->opcnt is always 1. Thus
> when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
> returns true.
>=20
> Reported-by: <rtm@csail.mit.edu>
> Closes: https://lore.kernel.org/linux-nfs/c3628d57-94ae-48cf-8c9e-49087a28c=
ec9@oracle.com/T/#t
> Fixes: 468de9e54a90 ("nfsd41: expand solo sequence check")
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/xdr4.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index ee0570cbdd9e..d1837a10b0c2 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -926,7 +926,8 @@ struct nfsd4_compoundres {
>  static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
>  {
>  	struct nfsd4_compoundargs *args =3D resp->rqstp->rq_argp;
> -	return resp->opcnt =3D=3D 1 && args->ops[0].opnum =3D=3D OP_SEQUENCE;
> +
> +	return args->opcnt =3D=3D 1 && args->ops[0].opnum =3D=3D OP_SEQUENCE;

This looks right, but .....

nfsd4_is_solo_sequence() is only called from nfsd4_cache_this().

nfsd4_cache_this() is only called from nfsd4_store_cache_entry() from
nfsd4_sequence_done() from nfs4svc_encode_compound() which is *after*
all ops have been encoded.  So resp->opcnt will be a count of all
successful ops, plus possibly one unsuccessful op.

So if resp->opcnt is one then either the SEQUENCE failed, or there is
only a SEQUENCE.

So while I think this patch is good, I think the justification is more
subtle that given in the commit message.

(digs through the code some more).

Ah-ha.  The root cause for the reported bug is that the data to cache is
determined (in part) but cstate.data_offset, and that is not set if
SEQUENCE is no successful.  So we absolutely must not call
nfsd4_store_cache_entry() is SEQUENCE failed.

Patch 3/5 does that.  With that in place, this patch is just cosmetic.

NeilBrown



>  }
> =20
>  /*
> --=20
> 2.51.0
>=20
>=20


