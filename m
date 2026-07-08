Return-Path: <linux-nfs+bounces-23180-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LvtILYvUTmrWUwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23180-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 00:51:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E290172AF66
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 00:51:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=CQvkwQGD;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="B 0wqJBS";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23180-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23180-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C42C3039887
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909BE3859E3;
	Wed,  8 Jul 2026 22:51:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6E384258;
	Wed,  8 Jul 2026 22:51:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551107; cv=none; b=K2gZM8WzE6AYz2lk6ietZoWLnECHOsOqTSt9+qoIiYFnSkeOFKicHbIDujzOeH0Igs+MuiAFRylb8HtAAtRt40AypchBwyS24SJiKmdkEjpi1va7XYiKFVQ3beafvYlw4j1H4GcJWmPlAmtwMLqVxpwq717Yw3yMGNj1ml5w/kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551107; c=relaxed/simple;
	bh=4zw2gXIPRQpejvwqxUtn/Tc7/Y6oTswDeLBgrcaagWo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=davX7mvviMX3q8CjGkWz8Ve9zmbX4yr77RBbnBiRkItbZmHQFIQIgxKs3cAka7d48/76ic6tpSo5AxpuWCp4fLdBcrXuIfSnzrTWfoybIetE3zc8tCQZIeIPjF6bTDfQ3z+ziS3rHXIKOr8P2Mu0hZUJao/eURJCsB1inbjqlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CQvkwQGD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0wqJBSM; arc=none smtp.client-ip=103.168.172.153
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3332B1400015;
	Wed,  8 Jul 2026 18:51:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 18:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783551104; x=1783637504; bh=fctl5nZ3P+X8jQlJfdCleJ75obagGY7h2lR
	jRVFZGhU=; b=CQvkwQGDD5x9ODeRRCojohJ8bk55p0SzaQLAwc4Rgmb76gc4311
	0Xw11O5jG51k4e2GgHomn/v4gluhYxYzvSkSIwIOx6ZH6skUuCnaqoJaj5xOYGgK
	21aIXbUqbQyUsvjnelqc4/qbmCxdtrj5ys30/Erv5QCsC7pHwvRdw/m0nVRBLiXv
	rsr2+2BLmU+5V85VPW0Isn+TQXxmDv5rghy0pJQHBAvNJcEry/Sd+oakQcmsnt2i
	0iT3gzAq1YCp/J7/di+vp2LOxQdvvH6D9Ivt+WB29Lye7d7gx8klQVGMHldRnwUg
	E6SC9IVYlt8aPPwz4KWI2mha3LoJgywhdjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783551104; x=
	1783637504; bh=fctl5nZ3P+X8jQlJfdCleJ75obagGY7h2lRjRVFZGhU=; b=B
	0wqJBSMRuEgs/9ISLcNa6hdqe5J/Zrb7RiBahX6RFSDq9v/oyWb9SQMp5sRGQ5r+
	T3Zrvqqmr+E91Gs9Iyh8Gym02t4R5EoreXc0Zv4NJUf+nVEFj8mon6u62HX87GCH
	dmmzo9ODHallPWxirYUyv6w+diGsCHrw4+NMl3CX/9j1xeWr10JcHQRufRQawG5k
	c9WjgCWo9a1cj+hwynyjuniV+hIXTwr5xz6JntpbFPWiZjpt49MUTyDuftMCw9RB
	4FtChFHxCXUXRpx1IZ+2X1GUbk8gd7CrhKbGyrQY1hE74+onFUjLCv47h9VwrRqc
	fGBAHqc12Gy/V1fYYwvoA==
X-ME-Sender: <xms:gNROatMN9aSY169Ramzl4vIMtCSHlbaPJQDId0VN7OotKzvQIpmoOQ>
    <xme:gNROak4q0yxIS4S_m0GKyV8ZmnwYtIyaHpP0y04HZdjqFVE3iTJBRimEz1MEDzAKR
    N2FqALcbkiJMauei-YPLMm8aJxZKpdOzbf4AxzSo_ICnZMhrw>
X-ME-Received: <xmr:gNROaghHU_Pb-x_eaejtSnlGdXGlo--Sy8jHeQVs39U9SsTsgY-kvlSqzB88ntp5gCotLCulPgnb0Au4VKZ77S_EPdP0Dh8>
X-ME-Proxy-Cause: dmFkZTFpbxICnNG4zzA7pLPeE06Rcjavb717nddk61snaI/M2D9Rrq3UerMMjRn5lqHunW
    /bqk2IUeWOcB9VLD3y6j2TlcJxvSy3zzaSqIv0f1Q0Mi0dtwRqaiqiMbtebPDiS96efVou
    lH3FQZoEGUF6dV7qNwnRpy2gTETi3jZ3M/LayRH5gc4bgJpBNJhiUj24seTUF4ICstTRfZ
    NTCKJRn8RD/5o+7+8wRztDjGxmMdEEbBF2Xmjsb4a6Z9zTx0r87k3VrVCxaCcdpfzh9pss
    fCApzflO9FCQ08Cmb0WdcKaSAxy7UkBC/bqJf0s/ujGnhAUQvteA3+LXcTly0Z6DLR00FV
    fY6QVilEok9TCS4K+paH7hwrNLmMd/2by5wxGg3a3hDeysQJXnFsxaMhuSg3u5iEzDxUk1
    UKQoirRHvh8YtHS5lknqtTpQQ33irYVlR5YKKzxOOp9qAmh1cmsKAGuRF9wpnZsFSg/7tc
    OmhrvtrEAzxxFfGvJeuvl7N/zYuZ3KzApdSXMWuIX2btWJWkqgcvclzaEPkXJESS1HJ0ab
    E0hw3reMRRXi5paBUxnOdwn4Bb4PooFtn8gs5tsIgG5GoCb9/OdNuvn2aanjG2GkzWt88Z
    zw7bg6ZMcqwhTKcKC2NZxW3pT8HP9Gi8kdYK1N+KxIqXJQLardqhCq1u/Wsw
X-ME-Proxy: <xmx:gNROapckSOkiD35hxe9i-DbCfAp6ySEG3oUF9wKRAs72xhr0QODoBA>
    <xmx:gNROaow60pp7IFjCZtZM7qaYtKqMKsmrvGyepskFKwjQEUXVwg7beg>
    <xmx:gNROao2c-KSVF91QKy8e59ktZiRtqYWESFBR4F7o8mQDW01kdXn2nw>
    <xmx:gNROauyOI6aqdpfX7NR8fCc4EK5gcEOPvL1x0DPHA4gaRziSwrSVGQ>
    <xmx:gNROat-UHeCVx4F83qmvjO6oJDBwmaDEs9RA1f2Z2h5AimleXtq_hl4h>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 18:51:40 -0400 (EDT)
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
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Chuck Lever" <cel@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] sunrpc: derive the pool count instead of caching
 it in sv_nrpools
In-reply-to: <6f703524141a195ad1e4f16b1b1d16ffa2073189.camel@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
  <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
  <178337823128.27465.5531515481696438438@noble.neil.brown.name>
  <3496ed08e534a3e81dfe4168d4b2bc3c325d829a.camel@kernel.org>
  <178348882124.3371781.3092732814258907420@noble.neil.brown.name>
  <6f703524141a195ad1e4f16b1b1d16ffa2073189.camel@kernel.org>
Date: Thu, 09 Jul 2026 08:51:37 +1000
Message-id: <178355109748.3371781.17923928016828009638@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23180-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E290172AF66

On Wed, 08 Jul 2026, Jeff Layton wrote:
> On Wed, 2026-07-08 at 15:33 +1000, NeilBrown wrote:
> > On Tue, 07 Jul 2026, Jeff Layton wrote:
> > > On Tue, 2026-07-07 at 08:50 +1000, NeilBrown wrote:
> > > > On Mon, 06 Jul 2026, Jeff Layton wrote:
> > > > > Now that the pool mode is always pernode, svc_serv.sv_nrpools is
> > > > > redundant with sv_is_pooled: an unpooled service always has a single
> > > > > pool, and a pooled service has svc_pool_map.npools pools (which is =
one on
> > > > > a single-node host). sv_nrpools cannot distinguish an unpooled serv=
ice
> > > > > from a pooled service that happens to have one pool, so it is sv_nr=
pools,
> > > > > not sv_is_pooled, that carries no unique information.
> > > > >=20
> > > > > Replace the cached field with a svc_serv_nrpools() helper that deri=
ves
> > > > > the count from sv_is_pooled and the pool map, and convert all reade=
rs to
> > > > > it. svc_pool_map is file-local to svc.c, so export the helper for t=
he
> > > > > svc_xprt.c and nfsd callers.
> > > > >=20
> > > > > Reading svc_pool_map.npools without svc_pool_map_mutex is safe: the
> > > > > mutex protects only svc_pool_map.count, and npools is already read
> > > > > locklessly in svc_pool_for_cpu().
> > > > >=20
> > > > > A pooled service holds a map reference for its whole lifetime, so n=
pools
> > > > > is stable while any reader could observe it.  The hot path
> > > > > (svc_pool_for_cpu()) already dereferences svc_pool_map for to_pool,=
 and
> > > > > npools shares that cacheline, so there is no new locking or coheren=
ce
> > > > > cost.
> > > > >=20
> > > > > __svc_create() keeps using its local npools argument for the sv_poo=
ls[]
> > > > > allocation, since sv_is_pooled is not set until svc_create_pooled()=
 has
> > > > > returned from it.
> > > > >=20
> > > > > Doing this also removes a modulus operation from svc_pool_for_cpu(),
> > > > > which should make for more efficient RPC queueing.
> > > > >=20
> > > > > Assisted-by: Claude:claude-opus-4-8
> > > > > Suggested-by: NeilBrown <neilb@ownmail.net>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/nfsd/nfsctl.c           |  2 +-
> > > > >  fs/nfsd/nfssvc.c           | 10 ++++-----
> > > > >  include/linux/sunrpc/svc.h |  2 +-
> > > > >  net/sunrpc/svc.c           | 52 ++++++++++++++++++++++++++++++++--=
------------
> > > > >  net/sunrpc/svc_xprt.c      |  6 +++---
> > > > >  5 files changed, 46 insertions(+), 26 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > index bc16fc7ca24f..0543e5bb842f 100644
> > > > > --- a/fs/nfsd/nfsctl.c
> > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > @@ -1526,7 +1526,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_b=
uff *skb,
> > > > > =20
> > > > >  	rcu_read_lock();
> > > > > =20
> > > > > -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > > > > +	for (i =3D 0; i < svc_serv_nrpools(nn->nfsd_serv); i++) {
> > > > >  		struct svc_rqst *rqstp;
> > > > >  		long thread_skip =3D 0;
> > > > > =20
> > > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > > index a8ea4dbfa56b..2edf716ea022 100644
> > > > > --- a/fs/nfsd/nfssvc.c
> > > > > +++ b/fs/nfsd/nfssvc.c
> > > > > @@ -655,7 +655,7 @@ int nfsd_nrpools(struct net *net)
> > > > >  	if (nn->nfsd_serv =3D=3D NULL)
> > > > >  		return 0;
> > > > >  	else
> > > > > -		return nn->nfsd_serv->sv_nrpools;
> > > > > +		return svc_serv_nrpools(nn->nfsd_serv);
> > > > >  }
> > > > > =20
> > > > >  int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
> > > > > @@ -665,7 +665,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, st=
ruct net *net)
> > > > >  	int i;
> > > > > =20
> > > > >  	if (serv)
> > > > > -		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > > > > +		for (i =3D 0; i < svc_serv_nrpools(serv) && i < n; i++)
> > > > >  			nthreads[i] =3D serv->sv_pools[i].sp_nrthrmax;
> > > > >  	return 0;
> > > > >  }
> > > > > @@ -699,8 +699,8 @@ int nfsd_set_nrthreads(int n, int *nthreads, st=
ruct net *net)
> > > > >  	if (n =3D=3D 1)
> > > > >  		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, nthre=
ads[0]);
> > > > > =20
> > > > > -	if (n > nn->nfsd_serv->sv_nrpools)
> > > > > -		n =3D nn->nfsd_serv->sv_nrpools;
> > > > > +	if (n > svc_serv_nrpools(nn->nfsd_serv))
> > > > > +		n =3D svc_serv_nrpools(nn->nfsd_serv);
> > > > > =20
> > > > >  	/* enforce a global maximum number of threads */
> > > > >  	tot =3D 0;
> > > > > @@ -731,7 +731,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, st=
ruct net *net)
> > > > >  	}
> > > > > =20
> > > > >  	/* Anything undefined in array is considered to be 0 */
> > > > > -	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> > > > > +	for (i =3D n; i < svc_serv_nrpools(nn->nfsd_serv); ++i) {
> > > > >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> > > > >  					   &nn->nfsd_serv->sv_pools[i],
> > > > >  					   0, 0);
> > > > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > > > > index 3a0152d926fb..3c885ab6ad41 100644
> > > > > --- a/include/linux/sunrpc/svc.h
> > > > > +++ b/include/linux/sunrpc/svc.h
> > > > > @@ -85,7 +85,6 @@ struct svc_serv {
> > > > > =20
> > > > >  	char *			sv_name;	/* service name */
> > > > > =20
> > > > > -	unsigned int		sv_nrpools;	/* number of thread pools */
> > > > >  	bool			sv_is_pooled;	/* is this a pooled service? */
> > > > >  	struct svc_pool *	sv_pools;	/* array of thread pools */
> > > > >  	int			(*sv_threadfn)(void *data);
> > > > > @@ -480,6 +479,7 @@ void		   svc_wake_up(struct svc_serv *);
> > > > >  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> > > > >  void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
> > > > >  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
> > > > > +unsigned int	   svc_serv_nrpools(const struct svc_serv *serv);
> > > > >  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> > > > >  const char *	   svc_proc_name(const struct svc_rqst *rqstp);
> > > > >  int		   svc_encode_result_payload(struct svc_rqst *rqstp,
> > > > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > > > index ece69cb0138a..800514a14f17 100644
> > > > > --- a/net/sunrpc/svc.c
> > > > > +++ b/net/sunrpc/svc.c
> > > > > @@ -224,7 +224,7 @@ svc_pool_map_set_cpumask(struct task_struct *ta=
sk, unsigned int pidx)
> > > > >  	unsigned int node =3D m->pool_to[pidx];
> > > > > =20
> > > > >  	/*
> > > > > -	 * The caller checks for sv_nrpools > 1, which
> > > > > +	 * The caller checks for more than one pool, which
> > > > >  	 * implies that we've been initialized.
> > > > >  	 */
> > > > >  	WARN_ON_ONCE(m->count =3D=3D 0);
> > > > > @@ -234,6 +234,24 @@ svc_pool_map_set_cpumask(struct task_struct *t=
ask, unsigned int pidx)
> > > > >  	set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > > > >  }
> > > > > =20
> > > > > +/**
> > > > > + * svc_serv_nrpools - number of thread pools backing a service
> > > > > + * @serv: An RPC service
> > > > > + *
> > > > > + * Pooled services all share the global svc_pool_map, so their poo=
l count
> > > > > + * is svc_pool_map.npools. Unpooled services have a single pool. R=
eading
> > > > > + * npools without svc_pool_map_mutex is safe: a pooled service hol=
ds a map
> > > > > + * reference for its whole lifetime, so npools is stable once set.
> > > > > + *
> > > > > + * Return value:
> > > > > + *   The number of pools in @serv
> > > > > + */
> > > > > +unsigned int svc_serv_nrpools(const struct svc_serv *serv)
> > > > > +{
> > > > > +	return serv->sv_is_pooled ? svc_pool_map.npools : 1;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(svc_serv_nrpools);
> > > >=20
> > > > I would make this a static-inline.
> > > >=20
> > >=20
> > > That would mean that we would have to export svc_pool_map, which is
> > > currently private to svc.c.
> >=20
> > Why is exporting svc_pool_map more problematic than exporting svc_serv_nr=
pools?
> > I think it would be good for at least the code in svc_pool_for_cpu() to
> > inline the function.  Maybe it already does?  Or maybe marking it
> > "inline" but still exporting it would work.
> >=20
> > Thanks,
> > NeilBrown
> >=20
>=20
> Doing what you suggest would increase the interface "surface" between
> sunrpc.ko and nfsd.ko.
>=20
> Currently struct svc_pool_map is only defined in net/sunrpc/svc.c, so
> we'd not only need to export the symbol, but also we'd have to make
> that definition public.
>=20
> Why expose so many internal details to other modules when all we need
> is this one accessor? I think keeping this interface small is
> preferable.

In general, yes.  But it is not without cost.  Sometimes the cost
matters.
Interface size has an abstract value.  Code size can have concrete
value.  Comparing them is subjective I guess.
I have no concrete evidence that there is a problem, so I'll stop
objecting.

Thanks,
NeilBrown

