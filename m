Return-Path: <linux-nfs+bounces-14831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0ABAEA3C
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51F61941E2D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539C4C81;
	Tue, 30 Sep 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="RvkNr/fi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="buq5W8z8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B039ACF
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759269785; cv=none; b=myAbXYZEGYvhSAZjtzqQBnwHg/TO6Y3O5KV00vfkDtGDxsFus6Q6r5CRcR2hSWaJiW+BemeYzDRs8bdqLfcsdCH6sHymfOA/WtdvPJQIbL5MGhylP3APe7YCox8pbOgBY1GE7P/L/fgGxw2SWm7Vaat3dnL1iMIFAo0JyDmdVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759269785; c=relaxed/simple;
	bh=/41JNrz0g7iRbGlujyL2p+eN+QGCZ09XZBdb1Kz5A/I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=AM56XW1ugowfpSTqchogFm0gecNz/eQlw3QHIw/WzqKmKSfEd1qQA4XnDqVMrI+V2HHoYLuOpskI23sXmJK85BDX4LcXF4750pg5XJoDrMEvnF24oTXF2uWd/HxWDzMkv26NWqG2vXydNFnKRZ96mveqphVw9w+57R7wq6NSDw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=RvkNr/fi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=buq5W8z8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B9311D000B4;
	Tue, 30 Sep 2025 18:03:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 30 Sep 2025 18:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759269781; x=1759356181; bh=JciTx/6iZy4K4i2v9NjmQtlRHCxI5/CHe2M
	zSjIqMho=; b=RvkNr/fiJFcCI3h1sgwtLc1oJq1CpQc3xQQ3AZpWKom0uV9IcPS
	zzsFgYW1cm/uUAW8BRue44hqzri+30o0ayHk+lSiJqCTNRsiVupZ8ClXnKY+0b8/
	2pjz/wv/3Bn0RQt7779Jwuu99C7b4uFVIv0QnufBvKP9+or0TvElCvbHxcUftS3c
	YzPHiyguDbgT4AfE1bDSzIxPIik9v9ZjQqLRoBcwXN5YyJANrzjUZElkjbB7qPsw
	w0ed8AMS5i2I3rBUVg8lp7OdXWtE31hgIpXu9745fntV3tGEvBWYcOtPLrxZ/HWz
	HRHxdcoLUaEI7gAOXKkA5srM/zIZG+VMrmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759269781; x=
	1759356181; bh=JciTx/6iZy4K4i2v9NjmQtlRHCxI5/CHe2MzSjIqMho=; b=b
	uq5W8z8J9f1z7oJybqpuvoOEjvBOjxLKGCZ9Of6XTEvqXYWS2l81KYPUcLhDW2Ge
	CcJhmgwOxuN2v3b9v6ZGPFNQ2oFnD06d9c60vPLve0LxugY5elrbzkazJ618WQRV
	9w8AHpP6rRbaITa0CIrLCaA688PJasRYlRAg2jwDZovN6QZV41aJURxbzZXkmU7w
	k7mclegapDJrDVeoDcpi0SqVNZoW+BCuY2rzzevu1XiT+n5HFi+bfXEEMitZzijd
	KUAk9HDnt9xVOpt8VR42a7Vrik9HRShjb4eky2MrIKTe+M1zUiKxV/f/dXgA5sn+
	B2jkDnWdDDOmaxjuQQ3EQ==
X-ME-Sender: <xms:lFPcaIpqJJsSlqejQwnqSCJpECbk9DXKhoOnc-wLcLm3-7kHav7Hxg>
    <xme:lFPcaBta5tnLDmv7pKh_s8Nl5HuT1RrhunKXB7QhEOXoM-zGeprp6jUNwWndOffrY
    CgybiiuhfbRc-yVn2BACVDeD7cOotdsR8ZmV0skhkhRy36RfQ>
X-ME-Received: <xmr:lFPcaH13CpMEnlCc8nahutjYkLj2Rq_zXP8Q_rYeS_Psp_0zGkhecxSCedfgdEMlNLwAMnBFwMFRqoEzrncEePD_s2DjZSqJob1JSSVGPL4G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    ffteefvdegveejlefhhfekgfffjedvtdevffdtgeeuieevffejueekffekfeekhfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepnhgvihhlsgesohifnhhmrghilhdrnhgvthdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pegrnhhnrgdrshgthhhumhgrkhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepug
    grihdrnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepphgrthgthhgvsheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lFPcaMGlDWkShzayVtv7kcFMm9TGA2gcMZGyUZAm6ydLgmr4nLUZjg>
    <xmx:lFPcaCtiZ70aiq6Pmi06yY9du7EpJiRWcR3TlVTt3aGCiM4lbZRRSg>
    <xmx:lFPcaPp-TROlKsPOCrXjjWSCMq1XFZNn0foqFHW_Q9-m7BKbem8bZw>
    <xmx:lFPcaJVuBjw0feRwrXly9Da6nUZvucSoa9bz0jB13ka3DhNFzQrm8w>
    <xmx:lVPcaFKm8RAsoB_61si5GVwu-UGo8PvGyu-4QMpMDSwbo4Pa76CE7WGs>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Sep 2025 18:02:57 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Nathan Chancellor" <nathan@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Anna Schumaker" <anna.schumaker@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Simon Horman" <horms@kernel.org>,
 linux-nfs@vger.kernel.org, patches@lists.linux.dev,
 "Nathan Chancellor" <nathan@kernel.org>
Subject:
 Re: [PATCH v3] nfsd: Avoid strlen conflict in nfsd4_encode_components_esc()
In-reply-to:
 <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
References:
 <20250930-nfsd-fix-trace-printk-strlen-error-v3-1-536cc9822ee6@kernel.org>
Date: Wed, 01 Oct 2025 08:02:46 +1000
Message-id: <175926976627.1696783.15337965299766035409@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Wed, 01 Oct 2025, Nathan Chancellor wrote:
> There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=3Dy
> and CONFIG_FORTIFY_SOURCE=3Dn due to the local variable strlen conflicting
> with the function strlen():
>=20
>   In file included from include/linux/cpumask.h:11,
>                    from arch/x86/include/asm/paravirt.h:21,
>                    from arch/x86/include/asm/irqflags.h:102,
>                    from include/linux/irqflags.h:18,
>                    from include/linux/spinlock.h:59,
>                    from include/linux/mmzone.h:8,
>                    from include/linux/gfp.h:7,
>                    from include/linux/slab.h:16,
>                    from fs/nfsd/nfs4xdr.c:37:
>   fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
>   include/linux/kernel.h:321:46: error: called object 'strlen' is not a fun=
ction or function pointer
>     321 |                 __trace_puts(_THIS_IP_, str, strlen(str));       =
       \
>         |                                              ^~~~~~
>   include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
>     265 |                 trace_puts(fmt);                        \
>         |                 ^~~~~~~~~~
>   include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_pr=
intk'
>      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_=
ARGS__)
>         |                                         ^~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc=
_printk'
>      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);             =
       \
>         |                 ^~~~~~~~~~~~~~~
>   include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
>      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
>         |         ^~~~~~~~
>   fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
>    2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
>         |         ^~~~~~~
>   fs/nfsd/nfs4xdr.c:2643:13: note: declared here
>    2643 |         int strlen, count=3D0;
>         |             ^~~~~~
>=20
> This dprintk() instance is not particularly useful, so just remove it
> altogether to get rid of the immediate strlen() conflict.
>=20
> At the same time, eliminate the local strlen variable to avoid potential
> conflicts with strlen() in the future.
>=20
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() o=
utput to trace buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: NeilBrown <neil@brown.name>

Thanks for doing this,

NeilBrown


> ---
> Changes in v3:
> - Eliminate local strlen variable altogether (NeilBrown)
> - Link to v2: https://patch.msgid.link/20250928-nfsd-fix-trace-printk-strle=
n-error-v2-1-108def6ff41c@kernel.org
>=20
> Changes in v2:
> - Remove dprintk() to remove usage of strlen()
> - Rename local strlen variable to avoid potential conflict in the future
> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strle=
n-error-v1-1-1360530e4c6b@kernel.org
> ---
>  fs/nfsd/nfs4xdr.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..07350931488d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr=
_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=3D0;
> +	int count=3D0;
>  	char *str, *end, *next;
> =20
> -	dprintk("nfsd4_encode_components(%s)\n", components);
> -
>  	pathlen_offset =3D xdr->buf->len;
>  	p =3D xdr_reserve_space(xdr, 4);
>  	if (!p)
> @@ -2670,9 +2668,8 @@ static __be32 nfsd4_encode_components_esc(struct xdr_=
stream *xdr, char sep,
>  			for (; *end && (*end !=3D sep); end++)
>  				/* find sep or end of string */;
> =20
> -		strlen =3D end - str;
> -		if (strlen) {
> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> +		if (end > str) {
> +			if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)
>  				return nfserr_resource;
>  			count++;
>  		} else
>=20
> ---
> base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
> change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
>=20
> Best regards,
> -- =20
> Nathan Chancellor <nathan@kernel.org>
>=20
>=20


