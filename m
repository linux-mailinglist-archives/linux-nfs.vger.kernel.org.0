Return-Path: <linux-nfs+bounces-15985-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA0C2E606
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 00:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E7BB3404FE
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E022EFDA5;
	Mon,  3 Nov 2025 23:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="g4irhmhZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ybq54Ybu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF72517AA
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211236; cv=none; b=DCW6CV1C6vNLyHF+Ln3MRvJXs9Ub9i/3ovaBhmghYX9bNH3SDfvEbx1qFgFJNc7NY3avnelTM8W8UNM9ZNVYjFYujwGxR0tTLSvoKxFHDMBnYTVnggb9CAEcRTDmvZECu7ai1AjKXSMU6groGjrrSh15gK4DicNqAyxutsKh1HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211236; c=relaxed/simple;
	bh=f/On7mGtD5Cl55bSdMkscWJBOwhc0Q4kveY06aH5QV8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j9NxSW44Psomi3HkfP7fwItrijws0hwVjuNmpDnmBjJJJTUOtZSBWzm4UZ90sCAo2Zopjx+5ZMbBcU7Lg2ofpyZ51cxX6yTcjp379ulsu3Ow6cau7aLnzk3cgfap5zBoIxQRF1F8eBVn6/eEQmN31CvJsNH4OXXYx5hD2j+Ga7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=g4irhmhZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ybq54Ybu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id CA9E5EC02B1;
	Mon,  3 Nov 2025 18:07:13 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 03 Nov 2025 18:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762211233; x=1762297633; bh=ejNYP10LTdtD/jPlLg4Ge6aSFYD/LctHsLX
	XRMBBZiA=; b=g4irhmhZWA6ZEJyRL44dVRcLgTOwH6YK/omOloXXJnAmcpDCCOy
	7loz3N8uRs92+qA8zREUDLorbCqsGbzqsIHH+RzkiFv0b3kr9lu1+lGZU6qSfx0g
	YZA5aSvATsNnsMGpHDCe/Vh/iL3fb6pToMPx4nLAoi5YoB6zm3UPlLjTjgndxxAq
	oiWnKjJ5rphKX2H2POJdnhYW6I7kkT24ta2v7X/bFI90tILe9p7x7YyEngqFM9qW
	1clUEbwTBab+JmY0dQx5RKkQo1ie3NpXjdZjM6Qnd4UMRzaAoHSra+QON7z38ciE
	PEKft2KC8DL3uK+8QDl8+384s+uMYq2A15g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762211233; x=
	1762297633; bh=ejNYP10LTdtD/jPlLg4Ge6aSFYD/LctHsLXXRMBBZiA=; b=Y
	bq54Ybuo50bgqj1aTiBLmDW56TTGiEfKTLzvh6XRwdTv00ql6wy7nODOlIgsQVVw
	SBBeBnAQ3oRMKJB6nXd4FrOpaSw+ge+0QstQpWZh5rGzdZRGSxjAZd436f2/ByZt
	53Ev+npf9BSasLB39ZuxMcdx+BU2GX4XFL9VXraxUpFh624SNu3XXPtcEztsAqd7
	r2/U/GKvhS2jsRUJoCdDXJjdJjrpJyufIBFHYYKJMpaKvHWTII0ejceiSpriP/zK
	Bmo/foRgJ267MuMNNoTCpq13lcKjw3+GpTcUr0VZ74Ca16nnEzuE/4gJgNoy6U5p
	U0m6fRFWCK1OgZIcWr+RQ==
X-ME-Sender: <xms:oTUJadZJOAya8NcP6UNM-xi7YybTZeoRwHgjgYdoLcps2zAt8OxTdw>
    <xme:oTUJaR-Q2VYCOD1qiE-elHnv9XsH3gWBivR7W1n3Y1U72p-M81w7gGVHUo0JwZMRZ
    gASW2Y2zXBQgEIA1Gl40tg0UvYI0ZFLNvx7o1zvuOgp40TH>
X-ME-Received: <xmr:oTUJaWalYb9ZG_WhEwGzlrMBpiI-IAKpxXN7mcIhyVB01x2MSKPYMqBBZgErSycaahiKO4XkCVL7GI73ZSvZKVhNkVSqH1YWYkyCjOdnuE-2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvihhlsgessghrohifnhdrnhgrmhgv
X-ME-Proxy: <xmx:oTUJadPk6Wz9lvFJQ9NjpXgdP9Gtbm_bYeDv17UY4mYlVTufMK2V6Q>
    <xmx:oTUJaaBf_cHG1S-LAHUdcPIZO4qHgO4sf-HA9xYgYl77rJMbinANjw>
    <xmx:oTUJacLSJZiVUrIOJiZ5fkGs9Reaog6jtReZiMaKr279x4YaJkfoig>
    <xmx:oTUJabMDttj9e1SRYYepuEEAidz9_kIA7E5a1toRmMeCoPIuCVMV6w>
    <xmx:oTUJaSPfnJeXzZZ1k_MHZwWL5-yacB4kh0SnvJxJmQ40RWs8A-iZvhqk>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 18:07:11 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Subject: Re: [PATCH v2 1/1] NFSD: don't start nfsd if sv_permsocks is empty
In-reply-to: <20251103175734.38634-1-okorniev@redhat.com>
References: <20251103175734.38634-1-okorniev@redhat.com>
Date: Tue, 04 Nov 2025 10:07:08 +1100
Message-id: <176221122874.1793333.14089821595280392064@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Olga Kornievskaia wrote:
> Previously, while trying to create a server instance, if no
> listening sockets were present then default parameter udp
> and tcp listeners were created. It's unclear what purpose
> was of starting these listeners were and how this could have
> been triggered by the userland setup. This patch proposed
> to ensure the reverse that we never end in a situation where
> no listener sockets are created and we are trying to create
> nfsd threads.
>=20
> The problem it solves is: when nfs.conf only has tcp=3Dn (and
> nothing else for the choice of transports), nfsdctl would
> still start the server and create udp and tcp listeners.
>=20
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfssvc.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 7057ddd7a0a8..b08ae85d53ef 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
>  	return rv;
>  }
> =20
> -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> -{
> -	int error;
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> -		return 0;
> -
> -	error =3D svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	error =3D svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
> -				SVC_SOCK_DEFAULTS, cred);
> -	if (error < 0)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static int nfsd_users =3D 0;
> =20
>  static int nfsd_startup_generic(void)
> @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const str=
uct cred *cred)
>  	ret =3D nfsd_startup_generic();
>  	if (ret)
>  		return ret;
> -	ret =3D nfsd_init_socks(net, cred);
> -	if (ret)
> +
> +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> +		pr_warn("NFSD: Failed to start, no listeners configured.\n");
> +		ret =3D -EIO;
>  		goto out_socks;
> +	}
> =20
>  	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
>  		ret =3D lockd_up(net, cred);
> --=20
> 2.47.3
>=20
>=20
>=20

We have a winner!

Reviewed-by: NeilBrown <neil@brown.name>


