Return-Path: <linux-nfs+bounces-14757-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B728EBA7E26
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 05:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F078118915AD
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171E20B7ED;
	Mon, 29 Sep 2025 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="p6OFoepB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i08ob0Sq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283791F099C
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 03:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118109; cv=none; b=FZsjqJweIPAIZJyXVaEkLen0DxANubrJeAOsNab6qTyrQIrMVnJjRsKK0H8xTATqtXQ/oyVNcy91HSoUVSijjOGkDIse/2vxhH3JSawjVCdaaIaMyklbsI8pXnqciZzyQjsa87rVJixOvQGpp9iMLnmbUDx55LNfPtJMpRhEMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118109; c=relaxed/simple;
	bh=1UxmfiLhWV97wkZv/EF5ix0lwcOfw6R0Wor/qOT39sQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FZvTy2XIIRA+ccWukmzyN9erxmdO6ZKctTTBdp1onEo1JCpjcMSe/smps/SZKrRqF0NC5oqYDYv5VTiqLMeaaQQUxLwrOf3H8odKeXtVNSxirmvWwEXijMjaQnqHETADMTzWHhYJtfOgFcOPUBqQNjBJqSIlgvwdlBRclUMqlzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=p6OFoepB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i08ob0Sq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3C124EC01E1;
	Sun, 28 Sep 2025 23:55:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 28 Sep 2025 23:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759118107; x=1759204507; bh=QGkRXn2nemA/b2J3rJ4hveiFppQ6FW7ZCCz
	56HZ2s1I=; b=p6OFoepBgmZ6fxX3h+TKjK/1twtNFOyEiivRNwlPL7JrvpraX21
	J0IOD9EPtuBcQEKiDY6yGNZsngpCuMpWWJvhXSXmPfv6sghweAvxDnjYL8n902yg
	4QqDi3IcQcn/toGRUFYYRfXYSGVXqON0Nixi4CNnQknfVGTUKbwB0J431nuBpTct
	OXjoqlfOgf8OeZAyaQZyYEli7Itndynet7n33SitE5uuYlfyOHtkQC0f5yKoDzqz
	V+1WDCxhUPHa47GH9vsdjWjclzuXUFciAw3CZpBw+84ulLXT+rxYB4qr4CpKSl8M
	lx2RkrSgT5UmqMJdzg6g/d55LWpXCAVFksQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759118107; x=
	1759204507; bh=QGkRXn2nemA/b2J3rJ4hveiFppQ6FW7ZCCz56HZ2s1I=; b=i
	08ob0SqcyD/kTZessyIHuqzZVF+OFf9q3o6czdIdArClHIs2iSJcUT1nqgX+5jGU
	1WuT1kcAhYStJKf15EFXG5RBXe9+E4+ujfk6dCTmgWw4SytsMxJ9JcpGqHgkpbrC
	U450iWyp+lSmnpBp0TDGoFP7fbbHavX/805rxFkggEemo057O+jg5/MjPbxJIH0Z
	bvZfwxPm6gGBmBxLbmJv+4vN5EefP38IR+gEv8HUkN2iNhV0vrUhm/sHAJgeYr/7
	HVIj4302N5Mg0HrIdqjaF/MoN1UITVjaQnu+2TOWGILupZfUkn8w9hdiKkFWM936
	kpdcUIJ2+9IORo3Qv4tFA==
X-ME-Sender: <xms:GgPaaNj5smAXPNwfd5NC6lIeDDfymP2CDbJVYZ7HsetDpV7LScnmLQ>
    <xme:GgPaaER1mppHQmXVm5T1J6rCbCizt6vdM8JGJ-xlV8tO2yqtTn-uLN5tHQihjSAxk
    rM3fK-9wbYfrjvb4FYDmilhRMBb9XrRAdvd9ABOqATt5FXjPg>
X-ME-Received: <xmr:GgPaaPXhEpfu1ZNu6FlHvDwYADmmFRGynlqEtZoKPLQMN9OjZqGkUhp9mr3lZIsvvirjwBosU8ELPJoZf2auUcUqi0bSF8qjSFq_lNHqza-j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieelkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:GgPaaITBl5xiTMcQ7xxF6vbspoJYzp4Oru0ccymMLMdWUKNrFFmfnw>
    <xmx:GgPaaJnR3ilYhsP3EJoSzIW7RPMTcspQXP_Oqz55XRzfZ0TkUPcBWw>
    <xmx:GgPaaO4TiD2CccTjWEWbwnI9fnIyFA36EB1eOPrvBlK806ET-weoxQ>
    <xmx:GgPaaPirGqywKnsXYLKbzSArb-RKrOrZTKVl9gTkcke21-oyv7Gt4w>
    <xmx:GwPaaP-XEXnAjfnq5EAzrfZt7FRfUxB4izkxcyUqdfeWcNlrK0cO6Mcj>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 23:55:04 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 3/4] NFSD: Relocate the xdr_reserve_space_vec() call site
In-reply-to: <20250926145151.59941-4-cel@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>,
 <20250926145151.59941-4-cel@kernel.org>
Date: Mon, 29 Sep 2025 13:55:02 +1000
Message-id: <175911810201.1696783.2332186811049371761@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 27 Sep 2025, Chuck Lever wrote:
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
>=20
> Nit: we could probably get rid of the xdr_truncate_encode(), now
> that maxcount reflects the actual count of bytes returned by the
> file system.

Nit: you made the suggested change, but didn't update this comment :-)

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs4xdr.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 41f0d54d6e1b..3a5c7a0e2db8 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -4475,18 +4475,30 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compo=
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
>  	write_bytes_to_xdr_buf(xdr->buf, starting_len + maxcount, &zero,
>  			       xdr_pad_size(maxcount));
> --=20
> 2.51.0
>=20
>=20


