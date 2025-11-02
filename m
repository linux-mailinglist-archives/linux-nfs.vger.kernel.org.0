Return-Path: <linux-nfs+bounces-15874-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B30C2982F
	for <lists+linux-nfs@lfdr.de>; Sun, 02 Nov 2025 23:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E52A83AADDF
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Nov 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F91A9FB5;
	Sun,  2 Nov 2025 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GmwePEN/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RW1mUJcJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0589460
	for <linux-nfs@vger.kernel.org>; Sun,  2 Nov 2025 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121490; cv=none; b=QvIgogkcCqcitdkzocMKujvdw8uGWD20dQ0PchmwuS1/LjondL7SA0K99MrunI9y+MwZAg0JOScJDoR236aryoIQmtBBZx1rdndo5WE4+ps/hiOwNMMDD6XYBqks1cXBXkonjHFpbQR9J5jMz7mEFxdkX8q2yRzD2kYImQvZzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121490; c=relaxed/simple;
	bh=+/SsiXBbbw7ZCsqhV/24Yjl81puGIENCNheZGSrTo+Q=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=btSs73EVHkjaLbXYXxoWWf6A++UxNnt7lcs2tS4ba/dRTjohS0wvZJ8zqa7nGgpfxnwk3vv/Bh5Cq9dvVp5BE161r9VcTP7YIkKmtytW5pzXpFS3+8gA4spO4pzbrOCOMf63Uhe5s6scthy9sYt1nYaIT2Gm+aVogB5iU9LG5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GmwePEN/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RW1mUJcJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B1D4140009C;
	Sun,  2 Nov 2025 17:11:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 02 Nov 2025 17:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762121486; x=1762207886; bh=NvDhFK/yYTOVaaoBd2hDBMT5prCQHSaOxWb
	z23Jb2Z4=; b=GmwePEN/YkAEv3K9PEkMDueHw3inYSL997/SLIf+AsChevmiGtc
	VnZqWkWEGejKvkRTsFIpT0T/MC2+J1Et57NALY5Y8DOffdjmxLIyh5TlHGNPMxLp
	RfTOqq2bDLf+IziPpDpiwDtM9Vx/Rgr2uKq33/j/T1X5EfsuqV0q6umYaLG2uJyb
	10bMuXIAPre9fnuDmeETIJu59hBlRGu1L2+LP4/RanhYQPWmQt1w6F25aFPgqfm5
	28gH9VOFTNo2ltapmADQMN8kYmv+xiWh2z+exNc/v6Fjvi9gIaGjn6qVCYsKoWbD
	E1/bmJgKqrDb83iuCKcW+pnkJRS2TkwJ/ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762121486; x=
	1762207886; bh=NvDhFK/yYTOVaaoBd2hDBMT5prCQHSaOxWbz23Jb2Z4=; b=R
	W1mUJcJ1/MQITjePENR8jjMoRMgdy1nbGWgGpC5rXw4Xa+IEubdQJN9oFLQlI/yr
	W3GcmXa0eWx2FSJigMa5zKrfa1FB8q+mZX3Qk85KF6drmWBRMIUn+MN+xq/tpERi
	yiOZiENxywjmRyxQpvz07Z71Qv4kXuS3n8BdR3ycdh4/hWt/RFwE3Dpy3O3wT6EI
	R8MbUDEK8ZXqrRqB9LdslOx1rvWXHv0DE+nsIDJlqk+JgU1ZSN9/OgTVFRbsu20u
	WJF68D/cqxOUh9mfTBIY0Fbi0A8W2Q3QzLZIsm8FkOScvx04cgzcBz0iPEReNLN/
	EPS3qrxjRDqC2hJFL3nqQ==
X-ME-Sender: <xms:DtcHaSkduv1BgvW_WeAkXA4nZ_RpApTeTW7O3P_O8lz_jGzisIntCQ>
    <xme:DtcHacFEC61IVopaZUZD-e1yZcIzLU1wymew18NhZ7U7aYcSYqC6DjkubWda2M3y6
    zQKuQb_n_MJ5rcnTZ9oB1zLs4x5qB1GAo0zFFc_jIb36fHOIQ>
X-ME-Received: <xmr:DtcHaS6IwXhJwhEfBGp72ztRiEaApumFjt2fJFVxUOD96L88JQm6ONiy-bhI3QSoWjUEcAEXht3BQUpEpr8WxyI7J17lctRAvB1IRZ8J5Cwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeigeduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DtcHacm910cCAA2ZVWAUyLzcQ51_kOts7jterOBbG9BEmyHpVI6GdQ>
    <xmx:DtcHafo4X_aionyAQ3OmfGhYFvuiHeCK-sR5Mjk7NIHVB_1A_BmyxQ>
    <xmx:DtcHaTs-gRimv0LR1c7eYam0N4Zk5ya0vKGw1OYYzeyF3gK01nm9EQ>
    <xmx:DtcHacHcLokP8rndQsC7Dz7JbB3GYIDPM_QnBVvwjnU9_PQ0KWq7qQ>
    <xmx:DtcHafZTUirPFMrtCTu42Jp5EAYLfy3ys2PtSGV-KcoXcyiLJ53AwBxN>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 17:11:23 -0500 (EST)
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
In-reply-to: <569083e7-97f3-4edf-9def-f1c526bca91c@oracle.com>
References: <20251030163532.54626-1-okorniev@redhat.com>,
 <bca68f1b-ca56-4e94-abd0-de4c509d3d00@oracle.com>,
 <176195406890.1793333.13442574969390728435@noble.neil.brown.name>,
 <569083e7-97f3-4edf-9def-f1c526bca91c@oracle.com>
Date: Mon, 03 Nov 2025 09:11:15 +1100
Message-id: <176212147550.1793333.5489904322075139060@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 03 Nov 2025, Chuck Lever wrote:
> On 10/31/25 7:41 PM, NeilBrown wrote:
> > On Fri, 31 Oct 2025, Chuck Lever wrote:
> >> On 10/30/25 12:35 PM, Olga Kornievskaia wrote:
> >>> Previously, while trying to create a server instance, if no
> >>> listening sockets were present then default parameter udp
> >>> and tcp listeners were created. It's unclear what purpose
> >>> was of starting these listeners were and how this could have
> >>> been triggered by the userland setup. This patch proposed
> >>> to ensure the reverse that we never end in a situation where
> >>> no listener sockets are created and we are trying to create
> >>> nfsd threads.
> >>>
> >>> The problem it solves is: when nfs.conf only has tcp=3Dn (and
> >>> nothing else for the choice of transports), nfsdctl would
> >>> still start the server and create udp and tcp listeners.
> >>>
> >>
> >> Fixes: ?
> >>
> >> One more below.
> >>
> >>
> >>> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> >>> ---
> >>>  fs/nfsd/nfssvc.c | 28 +++++-----------------------
> >>>  1 file changed, 5 insertions(+), 23 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> >>> index 7057ddd7a0a8..40592b61b04b 100644
> >>> --- a/fs/nfsd/nfssvc.c
> >>> +++ b/fs/nfsd/nfssvc.c
> >>> @@ -249,27 +249,6 @@ int nfsd_nrthreads(struct net *net)
> >>>  	return rv;
> >>>  }
> >>> =20
> >>> -static int nfsd_init_socks(struct net *net, const struct cred *cred)
> >>> -{
> >>> -	int error;
> >>> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >>> -
> >>> -	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> >>> -		return 0;
> >>> -
> >>> -	error =3D svc_xprt_create(nn->nfsd_serv, "udp", net, PF_INET, NFS_POR=
T,
> >>> -				SVC_SOCK_DEFAULTS, cred);
> >>> -	if (error < 0)
> >>> -		return error;
> >>> -
> >>> -	error =3D svc_xprt_create(nn->nfsd_serv, "tcp", net, PF_INET, NFS_POR=
T,
> >>> -				SVC_SOCK_DEFAULTS, cred);
> >>> -	if (error < 0)
> >>> -		return error;
> >>> -
> >>> -	return 0;
> >>> -}
> >>> -
> >>>  static int nfsd_users =3D 0;
> >>> =20
> >>>  static int nfsd_startup_generic(void)
> >>> @@ -377,9 +356,12 @@ static int nfsd_startup_net(struct net *net, const=
 struct cred *cred)
> >>>  	ret =3D nfsd_startup_generic();
> >>>  	if (ret)
> >>>  		return ret;
> >>> -	ret =3D nfsd_init_socks(net, cred);
> >>> -	if (ret)
> >>> +
> >>> +	if (list_empty(&nn->nfsd_serv->sv_permsocks)) {
> >>> +		pr_warn("NFSD: not starting because no listening sockets found\n");
> >>
> >> I know the code refers to sockets, but the term doesn't refer to RDMA
> >> listeners at all, and this warning seems applicable to both socket-based
> >> and RDMA transports. How about:
> >>
> >> NFSD: No available listeners
> >=20
> > "configured" rather than "available" ??
> > "network listeners"?  "network request listeners" ??
> > "ports" rather than "sockets" ??
> >=20
> >  NFSD: No network ports configured for listening
> > ??
> >=20
> > I did consider suggesting that the message isn't needed.
>=20
> I lean towards having a notice that something didn't go as planned.
> My final pitch:
>=20
> NFSD: Failed to start, no listeners configured.

Works for me - good compromise.

NeilBrown

