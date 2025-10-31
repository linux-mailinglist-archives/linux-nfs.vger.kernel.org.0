Return-Path: <linux-nfs+bounces-15859-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED07C27344
	for <lists+linux-nfs@lfdr.de>; Sat, 01 Nov 2025 00:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E413A80FE
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 23:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931D131D378;
	Fri, 31 Oct 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SR4MlKA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1Wzq4sjQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211332C921
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954083; cv=none; b=Yry4aqGuhBmV1qFGIIyGKKtbfJJ+5n3InE/9KTykkKCw7PqVaUwEYbab/V3X7Icv6JfQbUW5kiB828FPbkgeItz8/bVxI/+AzuN7/8s1AMWU/Ikv1TWeG5bLC7EH9+OLHF07eD9Q+7Zltw0agNKhkxdq4i8dml7dR9YNL8jXAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954083; c=relaxed/simple;
	bh=e26dtzSSEfnKruUr6u8Oki3zsv76C/3KWddnzI7U4pA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gItWBQseCugl97JGEMViyyP/60SAUC7G8HG1QRIUrT10IkTuvJZkJePM/KQ1pnS9tuke4bB2ilvn7wxVRfQXz6LBwL3bnYYZfOUDZ3vEaxpDjLC/S/iKqwfInZB25sgpJMdeTRyMQcAzuEGAiQpFzy0meCl+j8k0iHHcTCCmRvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SR4MlKA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1Wzq4sjQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E1119140015A;
	Fri, 31 Oct 2025 19:41:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 31 Oct 2025 19:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761954079; x=1762040479; bh=pfvYKszoXSbR23sHnR0yx6Ut+qNFrYiV+P5
	BD8vDhxE=; b=SR4MlKA4rFTRkk4GvXQ6XU/i577/Z0U1BIx8QEY5JLYMwh/m1tK
	hhpgaWJOa6DSd2SwkM69kJ0+wsDOyblxEcjGj9e7AIWkObCBzU095qU/pId+pvPB
	YVN6WpzYmA78+okFWMcNZeMyL009Z3R2MbL5C589TjnOFusp/MknFbhH/nVse8yJ
	Zi5scxyCnfFLAuiF60R9ugLZYsmqFray7EJbo7uwxu9hHnQvPrMJ62spKZkDmjuO
	e0nYPeGaN1YK38TnVJoyweIUMjaeZ7kxj1dDEdtCReld8GnAD46twi9xQCHLNsE2
	F886Wu1MiA54FWrqbizy6BSHWOHFaZ+e9bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761954079; x=
	1762040479; bh=pfvYKszoXSbR23sHnR0yx6Ut+qNFrYiV+P5BD8vDhxE=; b=1
	Wzq4sjQ3JFUmaQzcZ9KKuJz6vL6BQUeXc+VbmZcCL9OCgZTiyQEdwpasXpFhbfzJ
	+1Y2y+WqMa/PH3PbExmxn4vXiZLte8Ycm3M2nerJGP90zThgT0UIa/l6WBNHb7Ra
	z5avAOz48qfXu1/HIbzGwkaZp/IG0S5p/aKozSQnTbZQCby8FaJilLphp7baVu0o
	5FmkWEdLQAEQTw9Jyn84lkxCvsBMhbcJeFjan5R5eY0Q8Yx+OEcvlzCjbXNN6lFU
	gmohTTNXj1YE+JEUZjCCB73T/a6Ft5JaIo18IyhWZ4pSLOpwuxSv0KynqwSOn0pL
	WqulnmuTtTYKqrTiVXKKw==
X-ME-Sender: <xms:H0kFacLGTXt2QEaqBSg9UkMuzoMeskm3E10NmUfWUurg9UGp_XhgTw>
    <xme:H0kFaebwVdaNeo99GQMFmnZkkHzLSjgweXgQw1nGDmjIsbPvEYE1odxKG3eeF3df0
    ivYxx_fcz5UlEeGAT70QXPa1aGbdPlDA9-2_--Has8LivOxSGo>
X-ME-Received: <xmr:H0kFae8RUuxkv8TPHB9CM9p5L5QfjshPhhcaT6DL1LuOoW9jfxLBXhvYd4qCk9sE0fe_7Vvq4gpj3ppjCtjvCyNqQsHhup2QyWm8ZEqJEyss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:H0kFafbKEbQtmJpGZlVEFfqZiS-jZCRYRhfs_qHSyZ_vrLYqbweggg>
    <xmx:H0kFaSNDaV6dYSby-bwlu3gUFmQua7hHpwCX4rbXilP26efBGtw4KA>
    <xmx:H0kFabBntFUuFkMO1HaJh865pv8PpI9-5k6-BFk8fTz3UkN9XJtO3g>
    <xmx:H0kFaZKhEj2iQCSlNbE-fvouOMUA7hTY-9Vfz-4rNOR65Tq9T-jTVQ>
    <xmx:H0kFaTsT7dWh7BF7Wq0mVThEmDK1rr7TmSznIHyrXN3Qzm-VHNLZCKa0>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 19:41:17 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
In-reply-to: <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
References: <20251030163532.54626-1-okorniev@redhat.com>,
 <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>
Date: Sat, 01 Nov 2025 10:41:08 +1100
Message-id: <176195406890.1793333.13442574969390728435@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 31 Oct 2025, Chuck Lever wrote:
> On 10/30/25 12:35 PM, Olga Kornievskaia wrote:
> > Previously, while trying to create a server instance, if no
> > listening sockets were present then default parameter udp
> > and tcp listeners were created. It's unclear what purpose
> > was of starting these listeners were and how this could have
> > been triggered by the userland setup. This patch proposed
> > to ensure the reverse that we never end in a situation where
> > no listener sockets are created and we are trying to create
> > nfsd threads.
> >=20
> > The problem it solves is: when nfs.conf only has tcp=3Dn (and
> > nothing else for the choice of transports), nfsdctl would
> > still start the server and create udp and tcp listeners.
> >=20
>=20
> Fixes: ?
>=20
> One more below.
>=20
>=20
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfssvc.c | 28 +++++-----------------------
> >  1 file changed, 5 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 7057ddd7a0a8..40592b61b04b 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
> >  	return rv;
> >  }
> > =20
> > -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> > -{
> > -	int error;
> > -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> > -		return 0;
> > -
> > -	error =3D svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_PORT,
> > -				SVC_SOCK_DEFAULTS, cred);
> > -	if (error < 0)
> > -		return error;
> > -
> > -	error =3D svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_PORT,
> > -				SVC_SOCK_DEFAULTS, cred);
> > -	if (error < 0)
> > -		return error;
> > -
> > -	return 0;
> > -}
> > -
> >  static int nfsd_users =3D 0;
> > =20
> >  static int nfsd_startup_generic(void)
> > @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const s=
truct cred *cred)
> >  	ret =3D nfsd_startup_generic();
> >  	if (ret)
> >  		return ret;
> > -	ret =3D nfsd_init_socks(net, cred);
> > -	if (ret)
> > +
> > +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> > +		pr_warn("NFSD: not starting because no listening sockets found\n");
>=20
> I know the code refers to sockets, but the term doesn't refer to RDMA
> listeners at all, and this warning seems applicable to both socket-based
> and RDMA transports. How about:
>=20
> NFSD: No available listeners

"configured" rather than "available" ??
"network listeners"?  "network request listeners" ??
"ports" rather than "sockets" ??

 NFSD: No network ports configured for listening
??

I did consider suggesting that the message isn't needed.

NeilBrown

