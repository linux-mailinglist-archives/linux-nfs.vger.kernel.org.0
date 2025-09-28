Return-Path: <linux-nfs+bounces-14756-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B6BA7956
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 01:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792A77A8A0B
	for <lists+linux-nfs@lfdr.de>; Sun, 28 Sep 2025 23:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E238DE1;
	Sun, 28 Sep 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eUJV2Hu+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p4IPUtFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BA1925BC
	for <linux-nfs@vger.kernel.org>; Sun, 28 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759102208; cv=none; b=Dosi5dgNiELwR6noC/outILBp/OXLPyVWl/z+t76cNdFg8zvFwIMYPYtxaDtpjP5UU9NLxP+CPshp2G5Bgq7xGwIjKlJY7UkGiw3NmClvwqD/gsO5KUmcahRJry2EqEBWLbg+2pASDIGHcH7HHnTTB7eAcJLMQlWFys+gXHYqgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759102208; c=relaxed/simple;
	bh=DMRQHjLSw1VCWcf3ldL1qLFHyTozspDLDa+x6M7CPKU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QZH6ZnoQJbxWqpNH4D/UH3lNaRy6VzRgTljIlvKx9MYeLvS3Ql4v9vlsLApIGu0XJqtB+Ga5Jcc8v6evMwIOge4BtKH4Bqs6ZiQHroxa9UuEb2bweM1AUFJS595TrZx9KxFk1ec/EGaGQcvfW7l5qDYm0qwZLoteXjRB5wAl45M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eUJV2Hu+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p4IPUtFj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D207A7A0035;
	Sun, 28 Sep 2025 19:30:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 28 Sep 2025 19:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759102204; x=1759188604; bh=4ahUixXHjBP5M8iod6LXmRiIaHvcATvU3tK
	vmfeS/4Y=; b=eUJV2Hu+mvRN8w5ASFdoDC5zwCGAbtiYeWywrTZjgj1amWUal8S
	71uQU8YIfsfhJLR6rvE8sBf+YRrmfC09Wp82Ehog8Vb2VwUh4FpVmQjUfgVYrt0e
	rv2ROwEFzOff/V1Y856/KhYQh1n7rVk8OChDdXWWZ+1ObBQd6WgmH8ORO8for1FZ
	2VH2hphg5zRG3k9cJBLSoDD92CwcoYOkLXgMDkzurlKSZsApBDWO5wYtiRwYeHYC
	jKlfiXTzOfxrJzw9jB3T9eWRFeEhwJ0aApJ1aubxk903NqRbOCUsW/I5AfbAbRlE
	RYtwsI2GH11gQwh4SkjWfnppSc91wpqtNTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759102204; x=
	1759188604; bh=4ahUixXHjBP5M8iod6LXmRiIaHvcATvU3tKvmfeS/4Y=; b=p
	4IPUtFjhYLM9xSvC2Ms1b6LlOjjUq1Ta1RHLSvc0S0r5CDf6SFmE9vfeq4MfM8ST
	7cqK7TrGUFywRdF23BaoXTYOFBWrbg6jRqIKIbkr7KEKXhF5+aYEJEqmZXao8YRb
	/X1uu1Qp2s0L30ZL6LM9+Rxj/BYiPGHjFKQnivrpnGAaMNHqJ3BbyD+Sv6Ooi+P9
	CTwoyUinw0MvyI3zImEy9WJml5iqXQgUCuzvxENRaoZIUO5x7YtBQwIVUbaWlU3y
	ai7eG+6zKt2D9OeoQeMnKqY2GbICMW1qiHRd9XjgN0E62kWawfnF4bAaqdOkbNsX
	xf6YEmPcgH+HRr6C+rcPA==
X-ME-Sender: <xms:_MTZaDJSuhZ866iHcT6pe1k_4Jf5qXiiBPUW8rH6AD62TH0A-yxx1A>
    <xme:_MTZaKPsumWZdiswajzhCP5R1VJ8ng3dcdvA3_zs8pfu6xvu6ko6brxBJNqtDI6oL
    Bc4gdwrazU1kdmGgKEYp__G_wOHz6lcyC_AWWFTqPYQE8zqjQ>
X-ME-Received: <xmr:_MTZaGULkx32EmTsRPu8lvj3ecXeYYHY6t7W-KB8dhm8no8D3h_5FzX3D9CJtmdPc-VcDfTMgSrWf0in-m1tk6gobI03OtNMxGxYBRBOdJN->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieeghecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:_MTZaIkP96M5eNNxJNLK3eOKxFoIdken9wZJb0lp5W7RBSvlw2_Rxg>
    <xmx:_MTZaFMcM3zJ4BRwUF5ZL-gl3RMtJ3u9eHDOlel_vI6GFd9APnhuEA>
    <xmx:_MTZaAKyK6YnE63auevcrgnp0yyyLELdnAW3fgAq43_BBo5HZsc6_w>
    <xmx:_MTZaP1Y22G07bVpXrcS-6f2-auTTnM5bZ6CPCKQSkE7hJuj0BA-VA>
    <xmx:_MTZaHqitHrLzS0_T4_5_AjdsGSA-VSqCeLMd48xxJ7lqEL-HMvB9M2f>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 19:30:01 -0400 (EDT)
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
 Re: [PATCH v2] nfsd: Avoid strlen conflict in nfsd4_encode_components_esc()
In-reply-to:
 <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
References:
 <20250928-nfsd-fix-trace-printk-strlen-error-v2-1-108def6ff41c@kernel.org>
Date: Mon, 29 Sep 2025 09:29:56 +1000
Message-id: <175910219642.1696783.1969092567455681202@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 29 Sep 2025, Nathan Chancellor wrote:
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
> altogether.
>=20
> At the same time, rename the strlen local variable to avoid any
> potential conflicts with strlen().
>=20
> Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() o=
utput to trace buffer")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> Changes in v2:
> - Remove dprintk() to remove usage of strlen()
> - Rename local strlen variable to avoid potential conflict in the future
> - Link to v1: https://patch.msgid.link/20250925-nfsd-fix-trace-printk-strle=
n-error-v1-1-1360530e4c6b@kernel.org
> ---
>  fs/nfsd/nfs4xdr.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..9fe8a413f688 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2640,11 +2640,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr=
_stream *xdr, char sep,
>  	__be32 *p;
>  	__be32 pathlen;
>  	int pathlen_offset;
> -	int strlen, count=3D0;
> +	int str_len, count=3D0;
>  	char *str, *end, *next;
> =20
> -	dprintk("nfsd4_encode_components(%s)\n", components);
> -
>  	pathlen_offset =3D xdr->buf->len;
>  	p =3D xdr_reserve_space(xdr, 4);
>  	if (!p)
> @@ -2670,9 +2668,9 @@ static __be32 nfsd4_encode_components_esc(struct xdr_=
stream *xdr, char sep,
>  			for (; *end && (*end !=3D sep); end++)
>  				/* find sep or end of string */;
> =20
> -		strlen =3D end - str;
> -		if (strlen) {
> -			if (xdr_stream_encode_opaque(xdr, str, strlen) < 0)
> +		str_len =3D end - str;
> +		if (str_len) {
> +			if (xdr_stream_encode_opaque(xdr, str, str_len) < 0)
>  				return nfserr_resource;

I probably should have said something earlier, and this is definitely
bike-shedding material, but .... "str_len" is not a whole lot nicer than
"strlen" (or "i") ...


   if (end > str) {
	if (xdr_stream_encode_opaque(xdr, str, end - str) < 0)

??

NeilBrown

