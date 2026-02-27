Return-Path: <linux-nfs+bounces-19422-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMJFOaLAoWnPwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19422-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:04:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC671BA809
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 17:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2CC4303663E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CCA3ECBFA;
	Fri, 27 Feb 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxNu/QHc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B36329C5F
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207953; cv=none; b=cU7Atk5pt3uL/9AoGCChzgYG9xELqlLSpWNzMJX+iVjgUPTeY9Ni4ObjJGcD/wgeiy49nVqBzeL1x9S+wSx4UdwPZVO09jJTlAr0Qmc2W2+iOgKMbHMfxtXqMtBqhck7O4KN6v4zjVWzoLy2aDgiYBm0dRLEK7M3gSRpRaMPclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207953; c=relaxed/simple;
	bh=XrVoy8xjLNPfd1wS5auMCANauxnpnXG12SU37vLWqIc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A07ZWFJJ8QXoeKXntMK8GBMft5+ci0GiXuNdpdrcntxWIooFFsw7y3UZLGppa/OcH8peOnnwlacKdP91tpl4SbPf74Y0gmJlFxKwAn4LJaIL0aKxiKlyKgIL0avA5azMgRqHBw1h2qHmJVrIU9nPyDknhSd2iNzO49I/XmnRz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxNu/QHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BE8C2BC87;
	Fri, 27 Feb 2026 15:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772207952;
	bh=XrVoy8xjLNPfd1wS5auMCANauxnpnXG12SU37vLWqIc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MxNu/QHc46NTd9U+paOULKGAtmU6jgcl8a89KxuG/IsjOivMruHAYlx7pzJwzg5/0
	 +7IIrjLRox7ripKRM1NbNLGTkFO2p1y2RG4BpXDOE/1PxwCGcxffjieRneMm6SRuoU
	 4HJZiPqp7Vxrt4TYZ+pIkC65qF7xjmPDncndA/W1EGeTICJH/Y45r5POnvlnM0P97a
	 4UuCgKUy5nDaPi4U6YAymhv5gi1/9gIzRcTeQlPgA20NY2YPFHXsQ5VeGfcEk/lRdd
	 XOCvXg0P3stPZIo3p9m+cyfK7cVaHDwmSIp81wCTNf8wuNHW97AGNW8lkMHpOGwXku
	 JKgBXA+W+PHiw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D769F40068;
	Fri, 27 Feb 2026 10:59:11 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 27 Feb 2026 10:59:11 -0500
X-ME-Sender: <xms:T7-haU1wgZN2gpsfC0f0EbU8STovcaoT5jf5oP4h2szqfSv6SHfglw>
    <xme:T7-haZ7SjEHkryI_Y_3XCvt8rUS7YhVVawgICr6xe-o-Vh16C9gBbC4soHHPNOQ5a
    _UUKDwmwMSdRuBvL08fcSJWLT0OhCQfJ-NOfuFaFgoDqgi0LhHL5kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshgvrghnfigrshgtohguihhnghesghhmrghilhdrtghomhdprhgtphhtthhope
    htrhhonhgurdhmhihklhgvsghushhtsehhrghmmhgvrhhsphgrtggvrdgtohhmpdhrtghp
    thhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslh
    hunhhnrdgthhdprhgtphhtthhopehnihgtohhlrghsrdhfvghrrhgvsehmihgtrhhotghh
    ihhprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrsggviihnvggrsehtuhigohhnrd
    guvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:T7-hab12ofOY9pKsJk5dBA_ieiOBIj0dHCK0NZZUverr0jeeJIS1Jg>
    <xmx:T7-haWpDdaAbLTI8sUuD8vw31nVsHyC1l58CwVmuB77Of3FNh_9Xiw>
    <xmx:T7-haQUp3TEr2X7VcVQoX_254bDbI7JRSvuJXRoI6VJ9_sFz3aceIA>
    <xmx:T7-haXr2FUVM5i0d7EtCjVgZfWPgstpoMMynM3WiKQ5Nq8plA-6f3g>
    <xmx:T7-hafBlYYZ6hO_Iaex8gtHKupAJv3qcvzdD-_yFUb_6sgX81zGXmtI5>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1DE83780070; Fri, 27 Feb 2026 10:59:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7BSLXbSElHV
Date: Fri, 27 Feb 2026 10:58:26 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Sean Chang" <seanwascoding@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 "Trond Myklebust" <trond.myklebust@hammerspace.com>,
 "Anna Schumaker" <anna@kernel.org>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <68618f03-7d77-4cab-b223-29ae16d5b230@app.fastmail.com>
In-Reply-To: <20260227152624.164964-2-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
 <20260227152624.164964-2-seanwascoding@gmail.com>
Subject: Re: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19422-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4AC671BA809
X-Rspamd-Action: no action



On Fri, Feb 27, 2026, at 10:26 AM, Sean Chang wrote:
> When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
> expand to empty do-while loops. This causes variables used solely
> within these calls to appear unused, triggering -Wunused-variable
> warnings.
>
> Instead of marking every affected variable with __maybe_unused,
> update the dfprintk and dfprintk_rcu stubs to use no_printk().
> This allows the compiler to see the variables and perform type
> checking without emitting any code, thus silencing the warnings
> globally for these macros.
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>
> ---
>  include/linux/sunrpc/debug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
> index eb4bd62df319..55c54df8bc7d 100644
> --- a/include/linux/sunrpc/debug.h
> +++ b/include/linux/sunrpc/debug.h
> @@ -52,8 +52,8 @@ do {									\
>  # define RPC_IFDEBUG(x)		x
>  #else
>  # define ifdebug(fac)		if (0)
> -# define dfprintk(fac, fmt, ...)	do {} while (0)
> -# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
> +# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
> +# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
>  # define RPC_IFDEBUG(x)
>  #endif
> 
> -- 
> 2.34.1

Seems obviously good to me.

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

