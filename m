Return-Path: <linux-nfs+bounces-15074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B999BC6B1D
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 23:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1393419E21BE
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 21:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D72C0F63;
	Wed,  8 Oct 2025 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PqONjsUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OObFnJYL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBC2609E3;
	Wed,  8 Oct 2025 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959174; cv=none; b=JrJrA5Fx6KH777rQZ8GpoMuYcc/q82UihRidpNAMsJP04VyPvdjs+Jv7uaIcYV98n6O7SG+ddD318xdwSUo1Jb3oNqLrT2Hc5mcVR2XtLM+0H/FmZrvN9RZB+C+GjBXZ7BnncQyXDXkgxts8sHkgB0KnVRevqfXhoSTiVWNB4CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959174; c=relaxed/simple;
	bh=0Q5umw7pBsgTjar/RMfgnAEPeKFl92ZfPjJmHvPQlgY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qhR+GxVy265sVMGmGv7G5mwwXa8ijWaXSmJIvnxfrqFqPYtbL1zWo7bc3e/vJG+km6SpLotZkA5ndwxtmYbi2vxamHAJ1k7ofDhmhpyHs3Y5VeDZzcNzLqmETgwIzz45lrXS/hZjjOYhqmCAadHB5DmtDuZMi4YULRCsR/yvr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PqONjsUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OObFnJYL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADDED14001F5;
	Wed,  8 Oct 2025 17:32:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Oct 2025 17:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1759959169; x=1760045569; bh=KSF5yCxc0mwEE4ly6YJeqHekAnsjAvS65nW
	FUaDTTgs=; b=PqONjsUHmM/ZDrak9ENjQ18vZFAISsBaicLHx6z+uHw27r73Gg0
	5m+dQqXy/zJhEYKtXpqU0e1n0B5LN7OcZUI61+Yu9WNxBIbXXCaaj9go8wwOTA5m
	NXr8RsfT7DJPasYaieKUg743hkd7aN3W/7QQbWSjJxAWTgrBQr+HKu76pkbEQV7W
	rs2n2rhxgD9U5mxByannVm/XR9l3NPZTEZyZaK3pWx4/G1fcak/oCnniTNzBUyc7
	dWY1Qzz1C36iavzMvujXZwvctuxwhhpocDm3hYvwQn3VWMdj0ZJNkSstKAU2S08m
	zR7wl9AjR/g88KCx53i4B0qgSUeSKyRBkZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759959169; x=
	1760045569; bh=KSF5yCxc0mwEE4ly6YJeqHekAnsjAvS65nWFUaDTTgs=; b=O
	ObFnJYLYxBiUYUAI3QqQ0YNVWWyVDy4HAfKMi1TwugzYIEZi1h5eUz0xclOukeVF
	L9RhgG01a7GUUFcq9QqKqRcdqBcH/a3iyQqGs/hAXoJX8MfrJWVZBhDpX/PBbtpy
	/JgykvSfDQHlhfcIFJAOLTdzzGil7fsSu0k5h0JDiiWsiV41JPjUBLpfYJiAFhnR
	LVmii4RDIDFuYmZWwQ5a3nhRFKa0uk1kzEiqyZSUdg64N073klIREvI4Y557gdGJ
	X/IbD4yzMQTm0YmiAww8Lpe0i9LU+Tbo/3PCOEBpfFdVzBXr+utR7XfeT/pQgsPP
	KPjcmVMn9ExiS1zrv68AA==
X-ME-Sender: <xms:gdjmaBacNbqCjmU4CcnQPA1xfzled0XBX_D4pO-RiMXcw4ZY3gReKA>
    <xme:gdjmaJW3j6d6xLNl8SoJvEE7wlUvzP9-2JpwuQH2LPGPOycRPth4K6QNAearc7GAi
    ScKvQ7y7eVYkh4Bo_Z8iIpfRgpqqGJ7ZRjan7qGBNHYTfKSJyk>
X-ME-Received: <xmr:gdjmaEQOKsmhpbWbsUSrnFJv0S0CbUTobJ2hV78FzumXgPfPjcqPXqG2LPtfKf1-VIofJzxTweUcC1q7wX36HU2zl9YE6ywXDzuvueTY5pwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepughhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthho
    pegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegurghird
    hnghhosehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:gdjmaOH06jtNE-i2Q-9-V_PcQiOu_8PiHaCqxXuwM8qzYIShVuwlHg>
    <xmx:gdjmaDcMbjKcdhm75lMilWP-MQibukI-Go_j36c-UAFWQxkAlFX8qg>
    <xmx:gdjmaFJczZWwz7rJDspw6Ea9M97YiqQs-Odzfq3CDYED6lhL5BsJcA>
    <xmx:gdjmaCqX20PW4Ftnt2u2Qj83AWsHoYseCW9D2WTIswEs3VJuBRVIYg>
    <xmx:gdjmaEPaK1xWb00oeDBF5CWfDXs6N6dIGxUTsZlKpuSLPmo6OHyLJfzT>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 17:32:44 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "David Howells" <dhowells@redhat.com>, "Brandon Adams" <brandona@meta.com>,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/2] sunrpc: account for TCP record marker in rq_bvec
 array when sending
In-reply-to: <20251008-rq_bvec-v2-1-823c0a85a27c@kernel.org>
References: <20251008-rq_bvec-v2-0-823c0a85a27c@kernel.org>,
 <20251008-rq_bvec-v2-1-823c0a85a27c@kernel.org>
Date: Thu, 09 Oct 2025 08:32:43 +1100
Message-id: <175995916318.1793333.16943216276808147348@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 09 Oct 2025, Jeff Layton wrote:
> The call to xdr_buf_to_bvec() in svc_tcp_sendto() passes in the second
> slot to the bvec array as the starting slot, but doesn't decrease the
> length of the array by one.
>=20
> Fixes: 59cf7346542b ("sunrpc: Replace the rq_bvec array with dynamically-al=
located memory")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/sunrpc/svcsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> index 7b90abc5cf0ee1520796b2f38fcb977417009830..377fcaaaa061463fc5c85fc09c7=
a8eab5e06af77 100644
> --- a/net/sunrpc/svcsock.c
> +++ b/net/sunrpc/svcsock.c
> @@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, str=
uct svc_rqst *rqstp,
>  	memcpy(buf, &marker, sizeof(marker));
>  	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
> =20
> -	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages,
> +	count =3D xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
>  				&rqstp->rq_res);

oh - that's embarrassing :-(

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

> =20
>  	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
>=20
> --=20
> 2.51.0
>=20
>=20


