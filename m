Return-Path: <linux-nfs+bounces-15817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20582C22A5B
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 00:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F6426DFC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 23:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66447331A6F;
	Thu, 30 Oct 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AyWmzkyH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acdgfQDn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED82F5A1E
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865569; cv=none; b=D4CEp78lwKBVddWAMHbqPJPE7fJSILmv4yI3qaSek2ghn4eBA+1x6Wyzi2Yo7igtIKyzx+B7iDlYHtCt0aQKw/sLpbBAzxh2GsHUW5tZVXB50aG2K/qKnEZ/yukYCssAVipcUHbRAWQemfRAu/zPqhVhdUrXSG8xRA8GEI4ttiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865569; c=relaxed/simple;
	bh=9GHkiOQs95KUu8C7PpIm4fqviefayPxZG7KMhSSJb34=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jYqu8gytzKUYe0jGonTGEM3GK5TSXgAI2fQTlgJfp/q8m4m1qI5m9PC2ef3azX4CBP04daBM7wKhYlOtGr8vHG8S1uuj8hU7y7YehbWqLpCZ7qqfIzAJQ9FkSLewlE96BvE1uL9xqWo8ezLP2vONQoa8bpoIpmIZoMurVg9LqE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AyWmzkyH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=acdgfQDn; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2868F7A009D;
	Thu, 30 Oct 2025 19:06:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 19:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1761865561; x=1761951961; bh=k992u1izlaQoYHYrXBvzPhHVthXEZPqJV67
	MldlOA6U=; b=AyWmzkyHz4va5PeZHdCVk6NNDtkx4shv3FVfRecRHxZc6RbsVaE
	l5PeZgufr4ergOjpZD4RHsxaBkxTGA+6TvdRHhAol/+FGHaSCVnfkdTJ6W6yDpRu
	ZzKHG/+M46R6wyk667xieAGzvgnEy5RMGFgVweTodF2A4o+IuX1WEsAI2pNAZ8IT
	bpdPksIbl6+1kE4/CSSDOpiIG1I41mHSL2mou9Jvk2w8ZAZ8m7qOLy91u7LdIwDX
	oFeiKdyhnlhFoq6cA2U6fKKDkGZt4pxihKrE+SFhxX4lvuB+lunwimoPcpOdtBe4
	scebNu49WpFcGo064cL2UQ/okzGoJ/Qq8QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761865561; x=
	1761951961; bh=k992u1izlaQoYHYrXBvzPhHVthXEZPqJV67MldlOA6U=; b=a
	cdgfQDnxoAjAgWZXrXdxQY/+m3Z8M9cuV9+55jGjjoHj2QPpeEosYIi4c6fp5+ir
	Hc9AJzxhf8/CYmk602oJRznJOpRlj3/LSoVxP5MWIlg34EG93l1dlJ77l1B0+prL
	yJuxhuXJ343TMtw7Q2dbfgrr3IEkAaDac5w3JHymYcZZeNFGFISW2Rh2n7atcCoW
	xgUv7VfDKKocri1JOZFzwEUcFHoA1MUq/3tpCTTJnnoEDX2KBbXBC12ileJN845w
	7rztUDpA7zNbmVceF2c1Ok9YfPnDCJoylbNK3k9HOR0hUAfht2qCVPjJbKD8yghX
	lQlcEntEdyEDUxQ06e/8w==
X-ME-Sender: <xms:WO8DaZ5cxNzVsgqSNCFA44YFzMbhRd1y0JIzniSHK0TecGDGZyXmMw>
    <xme:WO8DaZJnR8-qWT6eZOY7wGgQysqXD0IwET3GFFhUjo7cxpaxGD8u5S2fONf8aqeQ2
    zUNoxxTIZTGe-AR5pH-XXDZtGbVwuuw6msYPLgSH3zVEU1d>
X-ME-Received: <xmr:WO8DaSshUGoZIwldBkWZCPD5fLfklwLG9X4WeEIZHv_DP7VxO_OtvsuYurtCEalIpcJsdLYvSQmHvwVF2EO8ORoJft_vzIl7UndSh-FUnYJJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieejkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WO8DaYIvPq4UVjDdkPbRFjQ6TBx7V_9O-HYHKKO6-f8gd3lPYVBZcw>
    <xmx:WO8Dab_atd5E-vXf0tRL_qHVrYSkyKtdgJEYwIXMCcqPJLspv1Nh5g>
    <xmx:WO8DaRwdV9IiYhud3hDVDoeycXjrkKds99lq8pj13WQ6dTMeNbvpCg>
    <xmx:WO8DaY7o6GSaLcnz-x26q05dVng03MOLWO-zXdM3sgSCwCnMd-Bong>
    <xmx:WO8DaWfFPS7pSNymPNtOLWxUwAlopxN6fkYDnVosWqwiTvcAN8CtyHm1>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 19:05:58 -0400 (EDT)
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
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject: Re: [PATCH 1/1] NFSD: don't start nfsd if sv_permsocks is empty
In-reply-to: <18c5ba1652045fb20bc74972d4024e9f42762875.camel@kernel.org>
References: <20251030163532.54626-1-okorniev@redhat.com>,
 <18c5ba1652045fb20bc74972d4024e9f42762875.camel@kernel.org>
Date: Fri, 31 Oct 2025 10:05:50 +1100
Message-id: <176186555062.1793333.4924387058849853332@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 31 Oct 2025, Jeff Layton wrote:
> On Thu, 2025-10-30 at 12:35 -0400, Olga Kornievskaia wrote:
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
> > +		ret =3D -EIO;
> >  		goto out_socks;
> > +	}
> > =20
> >  	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
> >  		ret =3D lockd_up(net, cred);
>=20
>=20
> Assuming that there is no regression with rpc.nfsd startup, this looks
> good to me.
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20
>=20
Agreed.

Reviewed-by: NeilBrown <neil@brown.name>


