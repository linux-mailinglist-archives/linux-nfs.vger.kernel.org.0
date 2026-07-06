Return-Path: <linux-nfs+bounces-23122-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c6K1FYoxTGo2hgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23122-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 00:51:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C707162B1
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 00:51:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=VcaBisYP;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="f Au8jpZ";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23122-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23122-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62F9303D11A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 22:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA60D364024;
	Mon,  6 Jul 2026 22:50:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7783A1C84AB;
	Mon,  6 Jul 2026 22:50:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378239; cv=none; b=tf+n1QjXYYDjE0FqFXcOTCiDaXiYYlBeVDKmqa1oLV2e7jpw8aREv+VgG5O+ixJEWi2ZOWCekSxI40rQZYqSWusDaMjf6z851M5+lPReTXe3axrixsTMK3mcPGF6/Fy2mCqY77XQNj/ZHNDwosv64YDn003SprYWbbZCazdyaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378239; c=relaxed/simple;
	bh=hYXO5XOEllewQknmXQrBh+rqeS/e10ARjao+PkR/JWs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=igWL6rEi5MQ7Vyb8ooDQMn1jqG5pmkXzVJ3HlEBMJD88bloXbmsSORy8h93tHZBV5PMJxqgy9RlvR/DPTKKRO+p4scJrHsNFirulljPROF9gIwjZvMer52/9T1JtjQO7z/IkP0H/kTZo2MTmZ4HORb7yp1qEsOafZ6ic0l3GCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=VcaBisYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAu8jpZz; arc=none smtp.client-ip=103.168.172.149
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 97B94EC0121;
	Mon,  6 Jul 2026 18:50:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 18:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783378236; x=1783464636; bh=HlbjD8aXOKUsG/o41xFw1vZnR5Ob1It7zDR
	XieDGd08=; b=VcaBisYPINBDLhnh0qbBG2cO9EW1PUrDiBz74/gA2PdGxxeTHpL
	sFOo1FtY4ACn8jfUnqjJDVwuLlPWtbHkHr3cf6h4CDq/d5L3jGzAB+LQ1xYeUN+7
	xMD578M8CYH9RNlH2xdKEaTW38dnln5VpUMn4HKQh4EaJs679FRRxtY46aIxpMVQ
	7FwdAN6x3tVLOUQ/VdBh8IRi89uizKn8l+NMYwvsmiMZpxPSmt9jC2hYpZC6FkqY
	zH9HiRNa2OjGTHBw+HOk4L1xZwUiJg1EdWvcs1MdsT3XsZHSg4oHgbpApDa0Yd7h
	AjTp8WHdztXcar2wyLFWL4Q/jFlEqSOuBEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783378236; x=
	1783464636; bh=HlbjD8aXOKUsG/o41xFw1vZnR5Ob1It7zDRXieDGd08=; b=f
	Au8jpZzn+FCo+0HCpX7UfL3/vpveSBqX9capbCH2v1BDp0t5ZtX/N34A/Ta9bSqt
	DydAxoPZpjXO2UZpun58OQMbofRRN9aZ2bmn3YgOZ/1CeZZ3+Od0UAbO51/d/FI/
	MxmKrktzVG/ME0Vydq3HPnkk12NACcqYhLINnMijsNpO6lci5L8Whcs9j6kE5rIN
	A7X9HJjROQj899ArTVCe7daGsMPkiIPeTHnomDoJh+LCaSvFoDeW8R9kz6b6kGN+
	c0xwdn4lcEYc66QF794m3QGsF3ErWFsBXJfu/DPhkoSCAQVhvKPnTwvZU1RfpOLw
	C+XO6cRpQbKFAOH1KnLHA==
X-ME-Sender: <xms:PDFMam1vYAkaNBqiC29pxuzElx_dUVMz__2eO0YZV3KKLNAmYqvBYA>
    <xme:PDFMauAUNO4LhU7f0t387GeCh5xYAM-B8xNrVkO4VOqGAvcE-sDuVr1QYNdxXA7EC
    g060D0jutMv6HxChgKaBwUP1FR8WxB3lqAiWHWJbrkFxz752g>
X-ME-Received: <xmr:PDFMajJT7jaIajV-rQasu1WprZUjV6FObtVbZjFd8Jfd9E4C2b5hftrANte42WS0XGy1vaIOR4N9P6itOej-mUbH3c4GVc0>
X-ME-Proxy-Cause: dmFkZTGmbrbpbsPz1qdcVoXogLtbcMMDcbuvvCgMBhGwaMfynLtdUhLQOnYbCel2ftSBML
    DRkYABOLFi5p61VkZz+lg0hHWclxKAxQAcygrDnTkCKZ/pWEGJqqjgwHkJU+p9Uh89XthP
    I3ZtE4er2kbPxt1ZmKj+TjhPwQtivfEUTlD9RvJQtlAZIoYSr1JkaXG7K0O6fhSPEShgSo
    +hqaKGfkCn4ecbuzUpFnOgfvKMvaUee1L8BkoDkkiO+v85LsZrCnQkugYtn1FBI43gtnRc
    UhY/M8eZjFsO8e5Hki2hAqVpj3HcQfRKpWBmIXIcCjJ2o0ymns8m/OtTzz4mNGJRdtLXOE
    gZZu998e9ISbtkB9ypVYQSAMhXXGunRbd+543f5i8Jb+HTArE3dkTG79daf0ZQOHqkch/j
    +Hesy/+rTivt76ZMJKrWhLL8h5hP+58pWekxMhSaSpWIwjnszgvkilGMIzP2JoM5WcMjOD
    ikrs48SA24lWih47NHMdUYTm7HE1795TPpjF2kg4iTEAC9ZMi3HlF7V6lpp/4C+p/CC0Xi
    4MEFgzX0FI7IVUKZbffIiymRUOu61nR73aqGeLYWIGNfNG1tC5wWDpnDQ9bv2LVWrrRKHy
    9osR16xY4e6TksqGor/h87+zp4TOivb99AF8gdBNwQovnWzj58Dg7FI9Df5g
X-ME-Proxy: <xmx:PDFMankO8qHEtOgv6wkRQtsLEU0EeKbUMKwL_2WWij8FVG40oXJ4MQ>
    <xmx:PDFMasbbo3uPKhyZNU6bo2xcMHFoCbKHOXoHqN2QvDGL3Fu0klRndw>
    <xmx:PDFMaj9ejKI-dTme_qmuF1bbgc042IeM7cYF8llEa0EGrIdT3mWfzw>
    <xmx:PDFMarbzKkopVnlxEEhu9bFv2LaG51VoklOTbBrtMROk9F7JZ3THDQ>
    <xmx:PDFMakHtd71KajhrmDb5sfRnvPpS0RsSyQdqGs0IUoOXqbScXLD7fO4O>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:50:33 -0400 (EDT)
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
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH v5 5/5] sunrpc: derive the pool count instead of caching
 it in sv_nrpools
In-reply-to: <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
  <20260706-sunrpc-pool-mode-v5-5-6c4ee7cd89aa@kernel.org>
Date: Tue, 07 Jul 2026 08:50:31 +1000
Message-id: <178337823128.27465.5531515481696438438@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23122-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:email,ownmail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,vger.kernel.org:from_smtp,brown.name:replyto,brown.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0C707162B1

On Mon, 06 Jul 2026, Jeff Layton wrote:
> Now that the pool mode is always pernode, svc_serv.sv_nrpools is
> redundant with sv_is_pooled: an unpooled service always has a single
> pool, and a pooled service has svc_pool_map.npools pools (which is one on
> a single-node host). sv_nrpools cannot distinguish an unpooled service
> from a pooled service that happens to have one pool, so it is sv_nrpools,
> not sv_is_pooled, that carries no unique information.
>=20
> Replace the cached field with a svc_serv_nrpools() helper that derives
> the count from sv_is_pooled and the pool map, and convert all readers to
> it. svc_pool_map is file-local to svc.c, so export the helper for the
> svc_xprt.c and nfsd callers.
>=20
> Reading svc_pool_map.npools without svc_pool_map_mutex is safe: the
> mutex protects only svc_pool_map.count, and npools is already read
> locklessly in svc_pool_for_cpu().
>=20
> A pooled service holds a map reference for its whole lifetime, so npools
> is stable while any reader could observe it.  The hot path
> (svc_pool_for_cpu()) already dereferences svc_pool_map for to_pool, and
> npools shares that cacheline, so there is no new locking or coherence
> cost.
>=20
> __svc_create() keeps using its local npools argument for the sv_pools[]
> allocation, since sv_is_pooled is not set until svc_create_pooled() has
> returned from it.
>=20
> Doing this also removes a modulus operation from svc_pool_for_cpu(),
> which should make for more efficient RPC queueing.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Suggested-by: NeilBrown <neilb@ownmail.net>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfsctl.c           |  2 +-
>  fs/nfsd/nfssvc.c           | 10 ++++-----
>  include/linux/sunrpc/svc.h |  2 +-
>  net/sunrpc/svc.c           | 52 ++++++++++++++++++++++++++++++++----------=
----
>  net/sunrpc/svc_xprt.c      |  6 +++---
>  5 files changed, 46 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index bc16fc7ca24f..0543e5bb842f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1526,7 +1526,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> =20
>  	rcu_read_lock();
> =20
> -	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < svc_serv_nrpools(nn->nfsd_serv); i++) {
>  		struct svc_rqst *rqstp;
>  		long thread_skip =3D 0;
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index a8ea4dbfa56b..2edf716ea022 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -655,7 +655,7 @@ int nfsd_nrpools(struct net *net)
>  	if (nn->nfsd_serv =3D=3D NULL)
>  		return 0;
>  	else
> -		return nn->nfsd_serv->sv_nrpools;
> +		return svc_serv_nrpools(nn->nfsd_serv);
>  }
> =20
>  int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
> @@ -665,7 +665,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net=
 *net)
>  	int i;
> =20
>  	if (serv)
> -		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> +		for (i =3D 0; i < svc_serv_nrpools(serv) && i < n; i++)
>  			nthreads[i] =3D serv->sv_pools[i].sp_nrthrmax;
>  	return 0;
>  }
> @@ -699,8 +699,8 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net=
 *net)
>  	if (n =3D=3D 1)
>  		return svc_set_num_threads(nn->nfsd_serv, nn->min_threads, nthreads[0]);
> =20
> -	if (n > nn->nfsd_serv->sv_nrpools)
> -		n =3D nn->nfsd_serv->sv_nrpools;
> +	if (n > svc_serv_nrpools(nn->nfsd_serv))
> +		n =3D svc_serv_nrpools(nn->nfsd_serv);
> =20
>  	/* enforce a global maximum number of threads */
>  	tot =3D 0;
> @@ -731,7 +731,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net=
 *net)
>  	}
> =20
>  	/* Anything undefined in array is considered to be 0 */
> -	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> +	for (i =3D n; i < svc_serv_nrpools(nn->nfsd_serv); ++i) {
>  		err =3D svc_set_pool_threads(nn->nfsd_serv,
>  					   &nn->nfsd_serv->sv_pools[i],
>  					   0, 0);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 3a0152d926fb..3c885ab6ad41 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -85,7 +85,6 @@ struct svc_serv {
> =20
>  	char *			sv_name;	/* service name */
> =20
> -	unsigned int		sv_nrpools;	/* number of thread pools */
>  	bool			sv_is_pooled;	/* is this a pooled service? */
>  	struct svc_pool *	sv_pools;	/* array of thread pools */
>  	int			(*sv_threadfn)(void *data);
> @@ -480,6 +479,7 @@ void		   svc_wake_up(struct svc_serv *);
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
>  void		   svc_pool_wake_idle_thread(struct svc_pool *pool);
>  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
> +unsigned int	   svc_serv_nrpools(const struct svc_serv *serv);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
>  const char *	   svc_proc_name(const struct svc_rqst *rqstp);
>  int		   svc_encode_result_payload(struct svc_rqst *rqstp,
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ece69cb0138a..800514a14f17 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -224,7 +224,7 @@ svc_pool_map_set_cpumask(struct task_struct *task, unsi=
gned int pidx)
>  	unsigned int node =3D m->pool_to[pidx];
> =20
>  	/*
> -	 * The caller checks for sv_nrpools > 1, which
> +	 * The caller checks for more than one pool, which
>  	 * implies that we've been initialized.
>  	 */
>  	WARN_ON_ONCE(m->count =3D=3D 0);
> @@ -234,6 +234,24 @@ svc_pool_map_set_cpumask(struct task_struct *task, uns=
igned int pidx)
>  	set_cpus_allowed_ptr(task, cpumask_of_node(node));
>  }
> =20
> +/**
> + * svc_serv_nrpools - number of thread pools backing a service
> + * @serv: An RPC service
> + *
> + * Pooled services all share the global svc_pool_map, so their pool count
> + * is svc_pool_map.npools. Unpooled services have a single pool. Reading
> + * npools without svc_pool_map_mutex is safe: a pooled service holds a map
> + * reference for its whole lifetime, so npools is stable once set.
> + *
> + * Return value:
> + *   The number of pools in @serv
> + */
> +unsigned int svc_serv_nrpools(const struct svc_serv *serv)
> +{
> +	return serv->sv_is_pooled ? svc_pool_map.npools : 1;
> +}
> +EXPORT_SYMBOL_GPL(svc_serv_nrpools);

I would make this a static-inline.

> +
>  /**
>   * svc_pool_for_cpu - Select pool to run a thread on this cpu
>   * @serv: An RPC service
> @@ -247,12 +265,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, un=
signed int pidx)
>  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  {
>  	struct svc_pool_map *m =3D &svc_pool_map;
> +	unsigned int nrpools =3D svc_serv_nrpools(serv);
>  	unsigned int pidx, i;
> =20
> -	if (serv->sv_nrpools <=3D 1)
> +	if (nrpools <=3D 1)
>  		return serv->sv_pools;
> =20
> -	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpoo=
ls;
> +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())];
> +	if (pidx >=3D nrpools)
> +		pidx =3D 0;

The values stored in svc_pool_map.to_pool are all less than
svc_pool_map.npools.
So that if() condition cannot be true.=20

But those two things don't reduce the correctness of the patch.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks for doing this.
NeilBrown


> =20
>  	/*
>  	 * It's possible to have a pool with no threads. Userland can just set
> @@ -265,7 +286,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  	 * populated pool, trading NUMA locality for a guarantee that the
>  	 * transport is serviced.
>  	 */
> -	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < nrpools; i++) {
>  		struct svc_pool *pool =3D &serv->sv_pools[pidx];
> =20
>  		/* This is set under the sp_mutex and rarely ever changes. A
> @@ -274,7 +295,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  		if (data_race(pool->sp_nrthreads))
>  			return pool;
> =20
> -		if (++pidx >=3D serv->sv_nrpools)
> +		if (++pidx >=3D nrpools)
>  			pidx =3D 0;
>  	}
> =20
> @@ -414,15 +435,13 @@ __svc_create(struct svc_program *prog, int nprogs, st=
ruct svc_stat *stats,
> =20
>  	__svc_init_bc(serv);
> =20
> -	serv->sv_nrpools =3D npools;
> -	serv->sv_pools =3D
> -		kzalloc_objs(struct svc_pool, serv->sv_nrpools);
> +	serv->sv_pools =3D kzalloc_objs(struct svc_pool, npools);
>  	if (!serv->sv_pools) {
>  		kfree(serv);
>  		return NULL;
>  	}
> =20
> -	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < npools; i++) {
>  		struct svc_pool *pool =3D &serv->sv_pools[i];
> =20
>  		dprintk("svc: initialising pool %u for %s\n",
> @@ -520,7 +539,7 @@ svc_destroy(struct svc_serv **servp)
> =20
>  	cache_clean_deferred(serv);
> =20
> -	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < svc_serv_nrpools(serv); i++) {
>  		struct svc_pool *pool =3D &serv->sv_pools[i];
> =20
>  		svc_pool_destroy_counters(pool);
> @@ -732,7 +751,7 @@ int svc_new_thread(struct svc_serv *serv, struct svc_po=
ol *pool)
>  	}
> =20
>  	rqstp->rq_task =3D task;
> -	if (serv->sv_nrpools > 1)
> +	if (svc_serv_nrpools(serv) > 1)
>  		svc_pool_map_set_cpumask(task, pool->sp_id);
> =20
>  	svc_sock_update_bufs(serv);
> @@ -858,8 +877,9 @@ int
>  svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
>  		    unsigned int nrservs)
>  {
> -	unsigned int base =3D nrservs / serv->sv_nrpools;
> -	unsigned int remain =3D nrservs % serv->sv_nrpools;
> +	unsigned int nrpools =3D svc_serv_nrpools(serv);
> +	unsigned int base =3D nrservs / nrpools;
> +	unsigned int remain =3D nrservs % nrpools;
>  	int i, err =3D 0;
> =20
>  	/*
> @@ -870,9 +890,9 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int=
 min_threads,
>  	 * @nrservs.
>  	 */
>  	if (base =3D=3D 0 && nrservs !=3D 0)
> -		remain =3D serv->sv_nrpools;
> +		remain =3D nrpools;
> =20
> -	for (i =3D 0; i < serv->sv_nrpools; ++i) {
> +	for (i =3D 0; i < nrpools; ++i) {
>  		struct svc_pool *pool =3D &serv->sv_pools[i];
>  		int threads =3D base;
> =20
> @@ -906,7 +926,7 @@ unsigned int svc_serv_maxthreads(const struct svc_serv =
*serv)
>  {
>  	unsigned int i, max =3D 0;
> =20
> -	for (i =3D 0; i < serv->sv_nrpools; i++)
> +	for (i =3D 0; i < svc_serv_nrpools(serv); i++)
>  		max +=3D data_race(serv->sv_pools[i].sp_nrthrmax);
>  	return max;
>  }
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 63d1002e63e7..40040af588fb 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1188,7 +1188,7 @@ static void svc_clean_up_xprts(struct svc_serv *serv,=
 struct net *net)
>  	struct svc_xprt *xprt;
>  	int i;
> =20
> -	for (i =3D 0; i < serv->sv_nrpools; i++) {
> +	for (i =3D 0; i < svc_serv_nrpools(serv); i++) {
>  		struct svc_pool *pool =3D &serv->sv_pools[i];
>  		struct llist_node *q, **t1, *t2;
> =20
> @@ -1517,7 +1517,7 @@ static void *svc_pool_stats_start(struct seq_file *m,=
 loff_t *pos)
>  		return SEQ_START_TOKEN;
>  	if (!si->serv)
>  		return NULL;
> -	return pidx > si->serv->sv_nrpools ? NULL
> +	return pidx > svc_serv_nrpools(si->serv) ? NULL
>  		: &si->serv->sv_pools[pidx - 1];
>  }
> =20
> @@ -1535,7 +1535,7 @@ static void *svc_pool_stats_next(struct seq_file *m, =
void *p, loff_t *pos)
>  		pool =3D &serv->sv_pools[0];
>  	} else {
>  		unsigned int pidx =3D (pool - &serv->sv_pools[0]);
> -		if (pidx < serv->sv_nrpools-1)
> +		if (pidx < svc_serv_nrpools(serv) - 1)
>  			pool =3D &serv->sv_pools[pidx+1];
>  		else
>  			pool =3D NULL;
>=20
> --=20
> 2.55.0
>=20
>=20


