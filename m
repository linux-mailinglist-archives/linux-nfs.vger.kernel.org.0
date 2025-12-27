Return-Path: <linux-nfs+bounces-17314-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BFCDF45D
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 05:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF4E53005FDA
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Dec 2025 04:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1358A23D297;
	Sat, 27 Dec 2025 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Zk/yvbSn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GA0pzL6I"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41AE1A9F9D
	for <linux-nfs@vger.kernel.org>; Sat, 27 Dec 2025 04:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766810998; cv=none; b=EkaYP2xZUEBMS2KbSCPduo8rcxl4TiqAm1Z8FhTt+NQi9Vl4O+Y6pp2G2Ewz2XoGxMMo1N4I3b1KAnnjETwCg5n8fPZveQLY7N26KxS53AN8nkDOA+Qk8OSrFv1PfnQHLNQ/xPOo8nA9BlWfvqGkWmSQxyHWkJML18KXip6nLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766810998; c=relaxed/simple;
	bh=gimT4TfoeYTFrER4A2nAZ4NQAC+bryepfoO8CeW6maI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BbKSsI1Eb3sLM0DlZTX2slMnEP7UkLZUai/0k/+xFZwelZ6ZAOEi0Yk40jGpX8E9LS2iuKCdoG+Usb4fPfSQBHMdh+UJnaAlXvtzSZOwLGW604B/IbUjHcdfkKpMKb12CKs51MqewBdLTLzpvYU2K1gYKwXnUIY7YfTJu7PL0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Zk/yvbSn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GA0pzL6I; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D1C6E7A00F7;
	Fri, 26 Dec 2025 23:49:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 26 Dec 2025 23:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1766810994; x=1766897394; bh=PuLZ7v6S04yedRvzbNZBDgkulifAQGyv/RL
	8UZmB2zY=; b=Zk/yvbSnJo/zO2YFy4PyUd0nHs82iA2OAwVhLBKFyatGUEGjOoa
	4olHOAITEMWoJvC8tvCaTSuDHIWn+Oal7L1QbKoNq8zMLai6M9ZdPLJKVWEKsepV
	NUBsrpdjC0Cff9c0NAMuxUk3V5mU/iIasbRKKVHEOSi+7Ta07r3K5KddWVL/zM7U
	+VSNlOWzFejP/jCQHLbwo/hUEp6QvzFIAt82GW9ublmUPMKzuG48uzviKcSXoNP1
	bPpdyIohgjLpfxsK+S2Rsszs8D8uh5fe36hvQ62PhER0pNz8+rlS3Uclzw3WkY/+
	qe/WhbithsmCP0X85fooNizrfek4PjfDChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766810994; x=
	1766897394; bh=PuLZ7v6S04yedRvzbNZBDgkulifAQGyv/RL8UZmB2zY=; b=G
	A0pzL6I5Qjb9BCk0rwJYJsYdLaHMdwSJMOmplypsyEBSsgyWHb8WBJL3VGE7nE/J
	j/ycoDWMqpe0T+Z4m/Fux22TUzdGHvugjeS/nheEA9aTPI9/HtTuD/mb6s47h3Iw
	W4l6s32DZGDkn0P+OHbhixg8SqC72n2whX3Zz8c0sIZif4hIfC7/25dy+UutVIdV
	YHKE/iSxibgmpyqraZlL3s6fIT2yh+oBZfGxiwsJI4xRqFjfmRDBHztS+jbipwHo
	JzC7aAhQ6uu99VX9kwi8WqRELQ3n0TRIWRFeJx7potflk9DJ+hGJHMzjbTu/tTnD
	qCtXTuzOrRtTxiIpWW1Bg==
X-ME-Sender: <xms:cmVPaeSvkw1e_e86D7jqxJScHdXKOXHIxER8rOAbYUNbTE69UHXybw>
    <xme:cmVPaWDA5lQQSmeDQjIt48370LxThHMWCPxdnDSUqBkfDOYkNRqURIQSljPY32X0W
    MMAM-MiQmSmqfLc0ostH8gIbDRTqWL27vwirfbVOJTtXgGfBA>
X-ME-Received: <xmr:cmVPaeEE2vpqoYAjcUidUU8wYQXHecNDHEzfDBUNfa4fjVqdLj2o0oUrxTjFpPAyZ412ld6iMIBlK9AdttMrMxOq_QWp6kkpayclKyjvCGjd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejtdegvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:cmVPaQCoUduFhRXy6agUe9OFKP1Tng3oNn4w3PurT7zQ0x3Dh_yIOQ>
    <xmx:cmVPaWVcaebZKnB3Guh5aKz23oZf6j3EHYx5pi8HLIAJI5keCjLUeg>
    <xmx:cmVPacp0SNmrME7wHRCMsulEE4mIq_qUedy2cu_dnVttRON9UsaLpA>
    <xmx:cmVPaaSR2eZh7GAejS98QjJ26CfnGUOEjNaSHPmcpT8aE278T0Srbw>
    <xmx:cmVPaRte5Hx2Ygnix5ZxO5Yx2_Pk1ztCeK0zTzKaACuclA0cjEBQ-Aaf>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Dec 2025 23:49:52 -0500 (EST)
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
 Re: [PATCH] SUNRPC: xdrgen: Initialize data pointer for zero-length items
In-reply-to: <20251220154109.1361512-1-cel@kernel.org>
References: <20251220154109.1361512-1-cel@kernel.org>
Date: Sat, 27 Dec 2025 15:49:50 +1100
Message-id: <176681099060.16766.17841184868646158398@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 21 Dec 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> The xdrgen decoders for strings and opaque data had an
> optimization that skipped calling xdr_inline_decode() when the
> item length was zero. This left the data pointer uninitialized,
> which could lead to unpredictable behavior when callers access
> it.
>=20
> Remove the zero-length check and always call xdr_inline_decode().
> When passed a length of zero, xdr_inline_decode() returns the
> current buffer position, which is valid and matches the behavior
> of hand-coded XDR decoders throughout the kernel.
>=20
> Fixes: 4b132aacb076 ("tools: Add xdrgen")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  include/linux/sunrpc/xdrgen/_builtins.h | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/linux/sunrpc/xdrgen/_builtins.h b/include/linux/sunrpc=
/xdrgen/_builtins.h
> index 52ed9a9151c4..a723fb1da9c8 100644
> --- a/include/linux/sunrpc/xdrgen/_builtins.h
> +++ b/include/linux/sunrpc/xdrgen/_builtins.h
> @@ -248,12 +248,10 @@ xdrgen_decode_string(struct xdr_stream *xdr, string *=
ptr, u32 maxlen)
>  		return false;
>  	if (unlikely(maxlen && len > maxlen))
>  		return false;
> -	if (len !=3D 0) {
> -		p =3D xdr_inline_decode(xdr, len);
> -		if (unlikely(!p))
> -			return false;
> -		ptr->data =3D (unsigned char *)p;
> -	}
> +	p =3D xdr_inline_decode(xdr, len);
> +	if (unlikely(!p))
> +		return false;
> +	ptr->data =3D (unsigned char *)p;
>  	ptr->len =3D len;
>  	return true;
>  }
> @@ -279,12 +277,10 @@ xdrgen_decode_opaque(struct xdr_stream *xdr, opaque *=
ptr, u32 maxlen)
>  		return false;
>  	if (unlikely(maxlen && len > maxlen))
>  		return false;
> -	if (len !=3D 0) {
> -		p =3D xdr_inline_decode(xdr, len);
> -		if (unlikely(!p))
> -			return false;
> -		ptr->data =3D (u8 *)p;
> -	}
> +	p =3D xdr_inline_decode(xdr, len);
> +	if (unlikely(!p))
> +		return false;
> +	ptr->data =3D (u8 *)p;
>  	ptr->len =3D len;
>  	return true;
>  }

Much nicer.  Some "optimisations" really aren't!

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> --=20
> 2.52.0
>=20
>=20
>=20


