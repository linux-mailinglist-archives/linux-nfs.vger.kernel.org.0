Return-Path: <linux-nfs+bounces-23181-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tbRnDEffTmqEVwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23181-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 01:37:43 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5972B367
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 01:37:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h+DBeNe0;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23181-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23181-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3478D301436F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2026 23:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416C3914E1;
	Wed,  8 Jul 2026 23:37:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937F390229;
	Wed,  8 Jul 2026 23:37:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553861; cv=none; b=X7WdL3jvgaip+TBe4Rkg1wh1Gf2yYIuTQQVzxNwU6ok5KCtkMmXdNTxgNMB3p/WqBwuHMQOquM0SmO0LWs9UNevAzXx5TmU2LXsoUBrmSz102I6xA2H7vQgtNIofHm4H97zIZIaHsyc6SdSYIQ0JVV+BHdx3F2Qqb8Vys+vjFlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553861; c=relaxed/simple;
	bh=dxUAcrFUmm+bZtduqwrowE/jGK6Gh4L8LiIQl8gDsSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGUC2pejIjzA4eUsf9Lmgb7VwJ+h5q57aT6TRs9Mgo1wsb/rBvHiZQ7peFJoS7WgzqJzL/zz+g6oaAPm0ndLvN8X/ZGgtmXS0OYlESsjuzU+2ts8xqx888BpYLslBBWpTk0/mySKnWfJhIWspln1V14RV1z573Fb710ivUet0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+DBeNe0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7563D1F000E9;
	Wed,  8 Jul 2026 23:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553859;
	bh=godA7roKAFqIy4dp2iHpnLhUNgnPzXUBnLo+/sDTGlY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=h+DBeNe0vtIGG4NKiDXD/ND0vImHvXKNZPxj1F/Cfx1g6aoKAlD/ioOR+WwSygxVr
	 JYtDlw3Snx7MDFaRbEUbUVrhkQxaQ/zggH3C7XIU+NfeMELpYTqRolCrry2VLzHd7j
	 CZYb8YgqqWWJztVBvhbVv3gjvGRuaxs1u0i/axrblJr0gSr4lJ2q1pJ93doPUZHY3o
	 EaRvf5xjXyoJf5ah4O1CEulXU5LzRX9wcW9PqRLES7NG+N/kBiXZMVTJEMa5qovirT
	 LE9KmLUNCUNT5sK977UabpfJugLAo9YK1ex5tqEEr37dwEO8q8B7zKVECv8scBNnjt
	 QLYMIttvu2dpA==
Message-ID: <44491689bfb3340f618829da785a302594f476f4.camel@kernel.org>
Subject: Re: [PATCH v5 5/5] sunrpc: derive the pool count instead of caching
 it in sv_nrpools
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Chuck Lever	 <cel@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 08 Jul 2026 19:37:37 -0400
In-Reply-To: <178355109748.3371781.17923928016828009638@noble.neil.brown.name>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
	  <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
	  <178337823128.27465.5531515481696438438@noble.neil.brown.name>
	  <3496ed08e534a3e81dfe4168d4b2bc3c325d829a.camel@kernel.org>
	  <178348882124.3371781.3092732814258907420@noble.neil.brown.name>
	  <6f703524141a195ad1e4f16b1b1d16ffa2073189.camel@kernel.org>
	 <178355109748.3371781.17923928016828009638@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23181-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDB5972B367

On Thu, 2026-07-09 at 08:51 +1000, NeilBrown wrote:
> On Wed, 08 Jul 2026, Jeff Layton wrote:
> > On Wed, 2026-07-08 at 15:33 +1000, NeilBrown wrote:
> > > On Tue, 07 Jul 2026, Jeff Layton wrote:
> > > > On Tue, 2026-07-07 at 08:50 +1000, NeilBrown wrote:
> > > > > On Mon, 06 Jul 2026, Jeff Layton wrote:
> > > > > > Now that the pool mode is always pernode, svc_serv.sv_nrpools i=
s
> > > > > > redundant with sv_is_pooled: an unpooled service always has a s=
ingle
> > > > > > pool, and a pooled service has svc_pool_map.npools pools (which=
 is one on
> > > > > > a single-node host). sv_nrpools cannot distinguish an unpooled =
service
> > > > > > from a pooled service that happens to have one pool, so it is s=
v_nrpools,
> > > > > > not sv_is_pooled, that carries no unique information.
> > > > > >=20
> > > > > > Replace the cached field with a svc_serv_nrpools() helper that =
derives
> > > > > > the count from sv_is_pooled and the pool map, and convert all r=
eaders to
> > > > > > it. svc_pool_map is file-local to svc.c, so export the helper f=
or the
> > > > > > svc_xprt.c and nfsd callers.
> > > > > >=20
> > > > > > Reading svc_pool_map.npools without svc_pool_map_mutex is safe:=
 the
> > > > > > mutex protects only svc_pool_map.count, and npools is already r=
ead
> > > > > > locklessly in svc_pool_for_cpu().
> > > > > >=20
> > > > > > A pooled service holds a map reference for its whole lifetime, =
so npools
> > > > > > is stable while any reader could observe it.  The hot path
> > > > > > (svc_pool_for_cpu()) already dereferences svc_pool_map for to_p=
ool, and
> > > > > > npools shares that cacheline, so there is no new locking or coh=
erence
> > > > > > cost.
> > > > > >=20
> > > > > > __svc_create() keeps using its local npools argument for the sv=
_pools[]
> > > > > > allocation, since sv_is_pooled is not set until svc_create_pool=
ed() has
> > > > > > returned from it.
> > > > > >=20
> > > > > > Doing this also removes a modulus operation from svc_pool_for_c=
pu(),
> > > > > > which should make for more efficient RPC queueing.
> > > > > >=20
> > > > > > Assisted-by: Claude:claude-opus-4-8
> > > > > > Suggested-by: NeilBrown <neilb@ownmail.net>
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/nfsd/nfsctl.c           |  2 +-
> > > > > >  fs/nfsd/nfssvc.c           | 10 ++++-----
> > > > > >  include/linux/sunrpc/svc.h |  2 +-
> > > > > >  net/sunrpc/svc.c           | 52 ++++++++++++++++++++++++++++++=
++--------------
> > > > > >  net/sunrpc/svc_xprt.c      |  6 +++---
> > > > > >  5 files changed, 46 insertions(+), 26 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > > > index bc16fc7ca24f..0543e5bb842f 100644
> > > > > > --- a/fs/nfsd/nfsctl.c
> > > > > > +++ b/fs/nfsd/nfsctl.c
> > > > > > @@ -1526,7 +1526,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct =
sk_buff *skb,
> > > > > > =20
> > > > > >  	rcu_read_lock();
> > > > > > =20
> > > > > > -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > > > > > +	for (i =3D 0; i < svc_serv_nrpools(nn->nfsd_serv); i++) {
> > > > > >  		struct svc_rqst *rqstp;
> > > > > >  		long thread_skip =3D 0;
> > > > > > =20
> > > > > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > > > > index a8ea4dbfa56b..2edf716ea022 100644
> > > > > > --- a/fs/nfsd/nfssvc.c
> > > > > > +++ b/fs/nfsd/nfssvc.c
> > > > > > @@ -655,7 +655,7 @@ int nfsd_nrpools(struct net *net)
> > > > > >  	if (nn->nfsd_serv =3D=3D NULL)
> > > > > >  		return 0;
> > > > > >  	else
> > > > > > -		return nn->nfsd_serv->sv_nrpools;
> > > > > > +		return svc_serv_nrpools(nn->nfsd_serv);
> > > > > >  }
> > > > > > =20
> > > > > >  int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
> > > > > > @@ -665,7 +665,7 @@ int nfsd_get_nrthreads(int n, int *nthreads=
, struct net *net)
> > > > > >  	int i;
> > > > > > =20
> > > > > >  	if (serv)
> > > > > > -		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > > > > > +		for (i =3D 0; i < svc_serv_nrpools(serv) && i < n; i++)
> > > > > >  			nthreads[i] =3D serv->sv_pools[i].sp_nrthrmax;
> > > > > >  	return 0;
> > > > > >  }
> > > > > > @@ -699,8 +699,8 @@ int nfsd_set_nrthreads(int n, int *nthreads=
, struct net *net)
> > > > > >  	if (n =3D=3D 1)
> > > > > >  		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, n=
threads[0]);
> > > > > > =20
> > > > > > -	if (n > nn->nfsd_serv->sv_nrpools)
> > > > > > -		n =3D nn->nfsd_serv->sv_nrpools;
> > > > > > +	if (n > svc_serv_nrpools(nn->nfsd_serv))
> > > > > > +		n =3D svc_serv_nrpools(nn->nfsd_serv);
> > > > > > =20
> > > > > >  	/* enforce a global maximum number of threads */
> > > > > >  	tot =3D 0;
> > > > > > @@ -731,7 +731,7 @@ int nfsd_set_nrthreads(int n, int *nthreads=
, struct net *net)
> > > > > >  	}
> > > > > > =20
> > > > > >  	/* Anything undefined in array is considered to be 0 */
> > > > > > -	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> > > > > > +	for (i =3D n; i < svc_serv_nrpools(nn->nfsd_serv); ++i) {
> > > > > >  		err =3D svc_set_pool_threads(nn->nfsd_serv,
> > > > > >  					   &nn->nfsd_serv->sv_pools[i],
> > > > > >  					   0, 0);
> > > > > > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/=
svc.h
> > > > > > index 3a0152d926fb..3c885ab6ad41 100644
> > > > > > --- a/include/linux/sunrpc/svc.h
> > > > > > +++ b/include/linux/sunrpc/svc.h
> > > > > > @@ -85,7 +85,6 @@ struct svc_serv {
> > > > > > =20
> > > > > >  	char *			sv_name;	/* service name */
> > > > > > =20
> > > > > > -	unsigned int		sv_nrpools;	/* number of thread pools */
> > > > > >  	bool			sv_is_pooled;	/* is this a pooled service? */
> > > > > >  	struct svc_pool *	sv_pools;	/* array of thread pools */
> > > > > >  	int			(*sv_threadfn)(void *data);
> > > > > > @@ -480,6 +479,7 @@ void		   svc_wake_up(struct svc_serv *);
> > > > > >  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> > > > > >  void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
> > > > > >  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
> > > > > > +unsigned int	   svc_serv_nrpools(const struct svc_serv *serv);
> > > > > >  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> > > > > >  const char *	   svc_proc_name(const struct svc_rqst *rqstp);
> > > > > >  int		   svc_encode_result_payload(struct svc_rqst *rqstp,
> > > > > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > > > > index ece69cb0138a..800514a14f17 100644
> > > > > > --- a/net/sunrpc/svc.c
> > > > > > +++ b/net/sunrpc/svc.c
> > > > > > @@ -224,7 +224,7 @@ svc_pool_map_set_cpumask(struct task_struct=
 *task, unsigned int pidx)
> > > > > >  	unsigned int node =3D m->pool_to[pidx];
> > > > > > =20
> > > > > >  	/*
> > > > > > -	 * The caller checks for sv_nrpools > 1, which
> > > > > > +	 * The caller checks for more than one pool, which
> > > > > >  	 * implies that we've been initialized.
> > > > > >  	 */
> > > > > >  	WARN_ON_ONCE(m->count =3D=3D 0);
> > > > > > @@ -234,6 +234,24 @@ svc_pool_map_set_cpumask(struct task_struc=
t *task, unsigned int pidx)
> > > > > >  	set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > > > > >  }
> > > > > > =20
> > > > > > +/**
> > > > > > + * svc_serv_nrpools - number of thread pools backing a service
> > > > > > + * @serv: An RPC service
> > > > > > + *
> > > > > > + * Pooled services all share the global svc_pool_map, so their=
 pool count
> > > > > > + * is svc_pool_map.npools. Unpooled services have a single poo=
l. Reading
> > > > > > + * npools without svc_pool_map_mutex is safe: a pooled service=
 holds a map
> > > > > > + * reference for its whole lifetime, so npools is stable once =
set.
> > > > > > + *
> > > > > > + * Return value:
> > > > > > + *   The number of pools in @serv
> > > > > > + */
> > > > > > +unsigned int svc_serv_nrpools(const struct svc_serv *serv)
> > > > > > +{
> > > > > > +	return serv->sv_is_pooled ? svc_pool_map.npools : 1;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_GPL(svc_serv_nrpools);
> > > > >=20
> > > > > I would make this a static-inline.
> > > > >=20
> > > >=20
> > > > That would mean that we would have to export svc_pool_map, which is
> > > > currently private to svc.c.
> > >=20
> > > Why is exporting svc_pool_map more problematic than exporting svc_ser=
v_nrpools?
> > > I think it would be good for at least the code in svc_pool_for_cpu() =
to
> > > inline the function.  Maybe it already does?  Or maybe marking it
> > > "inline" but still exporting it would work.
> > >=20
> > > Thanks,
> > > NeilBrown
> > >=20
> >=20
> > Doing what you suggest would increase the interface "surface" between
> > sunrpc.ko and nfsd.ko.
> >=20
> > Currently struct svc_pool_map is only defined in net/sunrpc/svc.c, so
> > we'd not only need to export the symbol, but also we'd have to make
> > that definition public.
> >=20
> > Why expose so many internal details to other modules when all we need
> > is this one accessor? I think keeping this interface small is
> > preferable.
>=20
> In general, yes.  But it is not without cost.  Sometimes the cost
> matters.
> Interface size has an abstract value.  Code size can have concrete
> value.  Comparing them is subjective I guess.
> I have no concrete evidence that there is a problem, so I'll stop
> objecting.
>=20

Your point is certainly valid, and this _is_ a hot path. If we can
demonstrate that this matters, then I'd be happy to revisit the idea. I
don't have the cycles to do so at the moment though.

--=20
Jeff Layton <jlayton@kernel.org>

