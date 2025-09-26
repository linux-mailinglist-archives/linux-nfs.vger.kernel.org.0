Return-Path: <linux-nfs+bounces-14729-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B21BA2202
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 03:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5283881A9
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 01:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B9D158535;
	Fri, 26 Sep 2025 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OwybXz+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3/OYIVG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993210E0
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849231; cv=none; b=I447ZhqudYXVwYZdldXj8KWBScjLZDa9WsH63FvA8ttqaUxDZZPpFO/NXbn44F54EIfyBaPmE78gQjL13nQLVBPdfJPtj6apEVucfNfdUAzul7NXw55vvqI1XjVQnv5pWiwod/CO9Fs4KidOW8LwUZ8JaWbmNDdEblTbzxngSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849231; c=relaxed/simple;
	bh=9/kEhkAltOtaFuG7h/qxrMtZLivsTMXOoW1PdyweRU0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kWM1sjoxMJTwJ10jnarsdjAZeIWPpMSCZhyMoR5W00B2hGHRJTbcSEKrf2Og20MgnWGvQK3mLDy7yLdzSYZ6Yp1LeSQTtlpUyy8/BdlIemryMYnSeW/uRa4Ln/vagJywzq5+RjUQKXTivhJdrNItdU801JuLnPdZs1VhWhSymng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OwybXz+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3/OYIVG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C2214EC00B0;
	Thu, 25 Sep 2025 21:13:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 21:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758849227; x=1758935627; bh=dI91TKnILTub+iSRQNFi+HMUvMhtYzZEtuz
	DLdoOTUE=; b=OwybXz+/agzrjx+wjBGFYsQUbdzcS2h0QAIqrxhRQjiDs6tNztX
	MtQGOuRfWPZwSWZ7WmT9teHPhITBV+qcf/MkcRsPBIfxzjWzjtmxhTtTIkFMn5r0
	D5B7x5FV7UV7Ogov7bhjrqfEv45RbLNFgJMmTLGwjf+VuvqSJnXJicHVfJWwCNqt
	TKcddnwJ09XWA0KuDAX6LNlbA3JQKsi7pfKJnBtnQ2kU1NDycRh0vWfyIx6b3CKy
	k4brkw14aD59ukmi7vKjMneZAj17+mmi87HRXk0fCFrehO0lU76ZnIdKZnJfEHPe
	DEBZK5TnZfkRC3HvEqYjviPy6aVVZluS1EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758849227; x=
	1758935627; bh=dI91TKnILTub+iSRQNFi+HMUvMhtYzZEtuzDLdoOTUE=; b=k
	3/OYIVG0gNb+/E0x9JuluNxox+yt9xrIuqgZacZ5B766jsqwd7nqW9WCtY+7UXe6
	MtgPJ9nqfByJdCxw8DJ580zgJMuVy1n6SMm3HsM01z4KnmwY9zXNDGTZaL75c/b4
	BqWcv+jaOvZWtxsyePGtHeSf+3pFmgb7mMcF8/BUR9dXhLTCeLJDsgZMzo07hQeP
	UsmKw3l68yCc99KRz+TqbNhNgJqpkQPnZLOY94yb/icm6CiaDDh3D+hLNBghO8OX
	hr0lJ0NuCPy7tGKlnHVxpopQaR7KqIKHYd8g+UFHfovy1CZap/H8q47gesdReETL
	fvZ/BtS/Bwsd990TWwPaw==
X-ME-Sender: <xms:y-jVaOWYDOE7z58eySQAoFFgto9qlqK63GyjYo9YxdP8Ns-28tJkJQ>
    <xme:y-jVaCDPqF7wP2j60eMaGI9HbG7GaqMgayBiUdytavsFC-zzTrSd5qENvNKntedPl
    2xbhCBz7BL4UJc2ltFcH3sJnontCGYw58gppZJvkaofNztycA>
X-ME-Received: <xmr:y-jVaPz49N0iNerzL-ilNS45s4r56hRIRL2hXjwHk-QqQm_urFycjhYGXcEekHSN5LiGjv0l-nu7lkxVAZBcl1eR0ZlQsITckFPHiArLF1sx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeikedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthht
    oheptggvlheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:y-jVaPDuGpLYM__Q7lH7qYGAKwtdajeG73guP5r3-e4uaD-ZwxzS5g>
    <xmx:y-jVaMbXxDdwEVIKgA_ds_-yWdo-TL7eRfil2cAEJ9fdKTpfel5Wdg>
    <xmx:y-jVaHhExUG1OT0g3h5Ae3jqP6N90J3C5eGg3DkLip1WnMVZAddM7Q>
    <xmx:y-jVaO4A9diI57UYyaq1W6XfSdcm8dXAvOpYj8Oyybh9Tp0oWSqs1g>
    <xmx:y-jVaEaf9fMVYNxXfwcqtCSA7-5C5XClLW52OuF29EIVBuSYvJMZpjtL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 21:13:46 -0400 (EDT)
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
Cc: linux-nfs@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Relocate the xdr_reserve_space_vec() call site
In-reply-to: <20250924195128.2002-1-cel@kernel.org>
References: <20250924195128.2002-1-cel@kernel.org>
Date: Fri, 26 Sep 2025 11:13:39 +1000
Message-id: <175884921980.1696783.4211256086968875624@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 25 Sep 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> In order to detect when a direct READ is possible, we need the send
> buffer's .page_len to be zero when there is nothing in the buffer's
> .pages array yet.
>=20
> However, when xdr_reserve_space_vec() extends the size of the
> xdr_stream to accommodate a READ payload, it adds to the send
> buffer's .page_len.
>=20
> It should be safe to reserve the stream space /after/ the VFS read
> operation completes. This is, for example, how an NFSv3 READ works:
> the VFS read goes into the rq_bvec, and is then added to the send
> xdr_stream later by svcxdr_encode_opaque_pages().

"This is .. how an NFSv3 READ works" is the part of this that stands out
for me.  Increasing the consistence between v3 and v4 must be good.

v2 and v3 readlink, readdir, read; and v4 splice_read
all use svcxdr_encode_opaque_pages().

These are precisely the operations where there is precisely one
page-like component of the reply.  For other v4 operations there are a
mix of page-like and non-pagelike elements.  They use the more
traditional xdr_reserve_space() and xdr_truncate_encode.

direct_read is more like splice_read than it is like iter_read.
This is because there can be only one page-like element.
So it isn't clear to me that it should be integrated with
nfsd_iter_read().  It is quite different from splice_read too.

However I think for the v4 case, direct read fits better in
nsfd4_encode_splice_read() than it does in nfsd4_encode_readv().
In both cases the READ is the only OP that can used the page vec - all
other replies have to fit in the header page.

NeilBrown


>=20
> Nit: we could probably get rid of the xdr_truncate_encode(), now
> that maxcount reflects the actual count of bytes returned by the
> file system.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> Here's a brain-dead idea.
>=20
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 41f0d54d6e1b..e3efc7d24aa5 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4475,19 +4475,32 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compo=
undres *resp,
>  	__be32 zero =3D xdr_zero;
>  	__be32 nfserr;
> =20
> -	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
> -		return nfserr_resource;
> -
>  	nfserr =3D nfsd_iter_read(resp->rqstp, read->rd_fhp, read->rd_nf,
>  				read->rd_offset, &maxcount, base,
>  				&read->rd_eof);
>  	read->rd_length =3D maxcount;
>  	if (nfserr)
>  		return nfserr;
> +
> +	/*
> +	 * svcxdr_encode_opaque_pages() is not used here because
> +	 * we don't want to encode subsequent results in this
> +	 * COMPOUND into the xdr->buf's tail, but rather those
> +	 * results should follow the NFS READ payload in the
> +	 * buf's pages.
> +	 */
> +	if (xdr_reserve_space_vec(xdr, maxcount) < 0)
> +		return nfserr_resource;
> +
> +	/*
> +	 * Mark the buffer location of the NFS READ payload so that
> +	 * direct placement-capable transports send only the
> +	 * payload bytes out-of-band.
> +	 */
>  	if (svc_encode_result_payload(resp->rqstp, starting_len, maxcount))
>  		return nfserr_io;
> -	xdr_truncate_encode(xdr, starting_len + xdr_align_size(maxcount));
> =20
> +	xdr_truncate_encode(xdr, starting_len + xdr_align_size(maxcount));
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + maxcount, &zero,
>  			       xdr_pad_size(maxcount));
>  	return nfs_ok;
> --=20
> 2.51.0
>=20
>=20


