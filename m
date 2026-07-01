Return-Path: <linux-nfs+bounces-22922-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KXjdIz6VRWotCgsAu9opvQ
	(envelope-from <linux-nfs+bounces-22922-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 00:31:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB66F21B6
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 00:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=PfbtgxOz;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="D D5Bmji";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22922-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22922-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB3803006828
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jul 2026 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4139E9AD;
	Wed,  1 Jul 2026 22:31:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9D3115A5;
	Wed,  1 Jul 2026 22:31:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945080; cv=none; b=bHdq3mxM541tMe2FKvLwVD4FE2/2yo1pBWvFjRKoWygy0Z1B5s/zo0LcsgxOY+mGvPSR+/UJZlhgrjK3DQQXdP3m7xYC1ZAaZlEa/2Gt7DIJMJj3pCrEVmSR8I9pGPPDRgvfeZ8QtKAbGlN/GvFE8aK2SBOsDfyHlmqniwy/4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945080; c=relaxed/simple;
	bh=yIFq/dHgqAv3iqz9lFr8WqurhDr6P/UFgMgUJK3JlS0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uKJ3n/s4xkVeRf7W/AcsiSA/0UA4ZNdxmpgsYcQfh/VXEfFwMoDQI+7Ltqm9sPBznpQRL9Go/OA93no6qudKK6KiKvrMZyiO2VcD4ik21uHD6bcf+te2DDke6q3MheUjABXsMZ3YVFdxBHxWTc15iLHn8beB6ABlV/+n+wIuV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PfbtgxOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DD5Bmjir; arc=none smtp.client-ip=202.12.124.149
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 543781D00027;
	Wed,  1 Jul 2026 18:31:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 01 Jul 2026 18:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782945077; x=1783031477; bh=liGHJQQw/pA+AOe3ndsaYsXuRX3CeUncsYL
	xKZ1SrSI=; b=PfbtgxOz8pUlxd/BgLkphXnH7R53krhkvq63V7m5vqhDWTBKgJu
	W/uMx7LIHxUsWrlqCNHMpW2i3uIadh48WAg1pGpOVRV7JCVdVTBjdlehg2FxJZBL
	XxfLOCDEFRtY8v/mju5W1j1ojfx++ns41ibauAI7vdr4J1+xA3JcbgeYlmXvN2aL
	qmYEVvQTfqLQX4SutDqKNKTkDLxg6Eg0ZrufEdRrsELRzP27hmbJ9qjC88tcPmuu
	VRFemiVPCiDPL9GqQx9GiGZZ2xGCDdLoPF23IB9ExmCPq5aOtzNgt1ox8PLwGvSt
	kjDpFn6ndgZe5+BaT3L5j1YzFE7axN7Hngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782945077; x=
	1783031477; bh=liGHJQQw/pA+AOe3ndsaYsXuRX3CeUncsYLxKZ1SrSI=; b=D
	D5Bmjir++ud5QOR4XGqvjgkYS+xCTio9aZuTFIh/jFUFeeOeBdVj6mm3oIRxsaRB
	x91OzvxBaMI0vxryJNmPKdGPLMn9WqEESR8+gKtoDRGLxImJ8yC5GktAdTv8E09H
	Xg21u9hDmPyCrdY9DPE2SPz81KJAwqkCZc6uA2t4zTCX/OpYSDuSxcpuvaOFPtDw
	rxHlECqC66HgNC2RQAiGmtFk8Aw/6z1X7/0v9T1GVbkutBP4+r3PCdMIHMR936Zi
	u7uJmV6GdPkZNpsL+VanKmz7pcUQnifkyY2e0qzJAY9dljGuseDjknaibxow8vZz
	owFgkxsOiYBzQi8D+e8bQ==
X-ME-Sender: <xms:NJVFavYmZ8u_5r46KhkXiR8XpIBy-RE649y3CgUyJMQjEG5R7i3rZQ>
    <xme:NJVFajVQQZRsE95dP0rbYNSH3X1mDTDoq9NK9NQXkF9XeDyIcJgIAQ7wW8HkkKPQ-
    UVKFMvmwd-HllIXa0PEwicQaoGcEF6ubNJ3KAD1-RRWque2>
X-ME-Received: <xmr:NJVFamP0OjbdLqM3mfzKLJJp73mckahJnyWC-Kf6CjwZ383txJiM6O_u2PSDuQOpqueiuhc7olqhZFyo5F5Zgrbv8yg-LLQ>
X-ME-Proxy-Cause: dmFkZTGeoJ2IVBp8qSvW33FMe6SRJYvgYfGW8Bh+0R7Jayy31Y56lADtivbLYLzTDommiF
    apprkWlgd1u77PuWHtvk594PXpp27odzUdoMIcAR+vTuiprwA8gdZIUQfWuLN+98E3a8oh
    fxGtLcCi3fIlyvtKBqIu3BTC9RcxRNoXLNkwsfJtdzfeAaLffa2kXxBI1cHZi1QemuT5mK
    Z+MCE12iMvFTp0GZdR/JmP2TGkZ72AZNyuUbN4XvJk6frZOz0LDWcAOeo/ABTYJwrsfKhf
    QLM9VU32+6tlCMiBue27IUzYdLhfikEPGP1jSF1tWjxqgmqK/+K/Ae+8v/rkr5G9040Jt1
    7UiAnp1U3ABO5rkQEKT1gdWHvtIioFeUP4JM0D2okNu6Nds1vOR3KlFUBJ7Q9qlo+Pcz5y
    4WwCM1T57ZFxhVrUhqf0jh4EYMT7QHM+Vb4WEo3rOjetowYn3Ml9YialJvOSoj2GBSGQYc
    l1Gpo70W51Uy9uTxB4VyD1FfjZfNscRqLOEWlGZ0huOOlrBjK0uzv0BdLYheiZOj0FQ9ny
    xig7Enq/1l1EeYN23HwncXmr8IWGkpiI2U5NwlwZ3FpW25x3T3KiDayeI3SJkYCOpr++lr
    YTTynZyc2hyBKXTWHUwItCiHbEujId+aBOHYRE8m09a6zQk8T2wy7uqrpULQ
X-ME-Proxy: <xmx:NJVFala2kEWOITNt9yRsCUL71oOtLPeYEhfYJO2WJlEjEYulcaRWOw>
    <xmx:NZVFat_ivRa28Te8VIHOWIiCrS7CZg0_snUzIvtVzckITR10ONR4Bw>
    <xmx:NZVFauTZDUj8f1R91EH-78wiLYEHNSoXYr7L1zH2qYyBsJgPzpbe3w>
    <xmx:NZVFavfWfimwg4A8hVWM3x-RjEf2HRHd2NcvS7D6xpI2cmgmW9wALw>
    <xmx:NZVFal4rB2_M5dua39fbvB_Enk-tCxQKW5GwmDrbC1KIgseYPL1l0v6->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:31:13 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 2/4] sunrpc: hardcode pool_mode to pernode, remove other modes
In-reply-to: <20260701-sunrpc-pool-mode-v4-2-b3d867e4c8f9@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
  <20260701-sunrpc-pool-mode-v4-2-b3d867e4c8f9@kernel.org>
Date: Thu, 02 Jul 2026 08:31:10 +1000
Message-id: <178294507023.27465.9215529741495032931@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22922-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
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
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,brown.name:replyto,brown.name:email,ownmail.net:dkim,ownmail.net:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FAB66F21B6

On Thu, 02 Jul 2026, Jeff Layton wrote:
> The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> was added when NUMA was new and the right default was unclear.  The
> default has always been "global" (a single pool for the whole service);
> the other modes were only used when an admin explicitly set the
> pool_mode parameter or asked for "auto", which then picked a mode from
> the host topology.  Today, pernode is the right choice everywhere:
>=20
> - On multi-NUMA hosts, it gives one pool per node with proper thread
>   affinity and NUMA-local memory allocation.
> - On single-node hosts, pernode degenerates to exactly one pool,
>   identical to the old "global" mode -- svc_pool_for_cpu() short-
>   circuits when sv_nrpools <=3D 1, no CPU affinity is set, and memory
>   is allocated from the single node.
>=20
> The percpu mode (one pool per CPU) created excessive pools relative to
> the number of threads most deployments run, and was only auto-selected
> in a narrow case (single node, >2 CPUs).
>=20
> Note that this changes the default behaviour on multi-NUMA hosts: a
> service that previously ran with a single global pool now gets one pool
> per NUMA node by default.  This in turn means a host running fewer
> threads than it has NUMA nodes can end up with pools that have no
> threads.  svc_pool_for_cpu() already falls back to a populated pool in
> that case, so transports are still serviced.
>=20
> Remove the SVC_POOL_* enum, mode selection heuristic,
> svc_pool_map_init_percpu(), and all mode-based switch statements.
> Simplify pool map functions to always use the pernode path.  If pool
> map allocation fails, svc_pool_map_get() now returns 0 and service
> creation fails, rather than silently falling back to a single global
> pool.
>=20
> With the mode check gone, svc_pool_map_get_node() would dereference the
> shared pool_to[] for every service that starts a thread.  Only services
> created via svc_create_pooled() hold a map reference that keeps that
> array allocated, so gate the lookup in svc_new_thread() on sv_is_pooled:
> unpooled services (e.g. lockd, the NFS callback) use NUMA_NO_NODE and
> never consult the map.  The kmalloc_node() callers in
> svc_prepare_thread() already accept NUMA_NO_NODE, but __folio_alloc_node()
> requires a valid node id, so resolve NUMA_NO_NODE to numa_mem_id() for
> the scratch folio allocation.
>=20
> The module parameter and netlink interfaces are preserved for backward
> compatibility:
> - Writing any of the four documented mode names still succeeds silently
> - Reading always returns "pernode"
> - Writing to the module parameter emits a deprecation notice
>=20
> Update Documentation/admin-guide/kernel-parameters.txt to mark the
> pool_mode parameter deprecated and describe the new behaviour.
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  20 +-
>  net/sunrpc/svc.c                                | 265 ++++++--------------=
----
>  2 files changed, 65 insertions(+), 220 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..441b78867478 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7441,19 +7441,13 @@ Kernel parameters
> =20
>  	sunrpc.pool_mode=3D
>  			[NFS]
> -			Control how the NFS server code allocates CPUs to
> -			service thread pools.  Depending on how many NICs
> -			you have and where their interrupts are bound, this
> -			option will affect which CPUs will do NFS serving.
> -			Note: this parameter cannot be changed while the
> -			NFS server is running.
> -
> -			auto	    the server chooses an appropriate mode
> -				    automatically using heuristics
> -			global	    a single global pool contains all CPUs
> -			percpu	    one pool for each CPU
> -			pernode	    one pool for each NUMA node (equivalent
> -				    to global on non-NUMA machines)
> +			Deprecated.  The NFS server now always uses one
> +			service thread pool per NUMA node (equivalent to a
> +			single global pool on non-NUMA machines).  All of
> +			the previously accepted values (auto, global,
> +			percpu, pernode) are still accepted for backward
> +			compatibility but are ignored: the mode is always
> +			pernode, and reads always return "pernode".
> =20
>  	sunrpc.tcp_slot_table_entries=3D
>  	sunrpc.udp_slot_table_entries=3D
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 82fb7faf563f..c9fba7edaace 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -38,82 +38,36 @@
> =20
>  static void svc_unregister(const struct svc_serv *serv, struct net *net);
> =20
> -#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
> -
>  /*
> - * Mode for mapping cpus to pools.
> - */
> -enum {
> -	SVC_POOL_AUTO =3D -1,	/* choose one of the others */
> -	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
> -				 * (legacy & UP mode) */
> -	SVC_POOL_PERCPU,	/* one pool per cpu */
> -	SVC_POOL_PERNODE	/* one pool per numa node */
> -};
> -
> -/*
> - * Structure for mapping cpus to pools and vice versa.
> + * Structure for mapping nodes to pools and vice versa.
>   * Setup once during sunrpc initialisation.
>   */
> =20
>  struct svc_pool_map {
>  	int count;			/* How many svc_servs use us */
> -	int mode;			/* Note: int not enum to avoid
> -					 * warnings about "enumeration value
> -					 * not handled in switch" */
>  	unsigned int npools;
> -	unsigned int *pool_to;		/* maps pool id to cpu or node */
> -	unsigned int *to_pool;		/* maps cpu or node to pool id */
> +	unsigned int *pool_to;		/* maps pool id to node */
> +	unsigned int *to_pool;		/* maps node to pool id */
>  };
> =20
> -static struct svc_pool_map svc_pool_map =3D {
> -	.mode =3D SVC_POOL_DEFAULT
> -};
> +static struct svc_pool_map svc_pool_map;
> =20
>  static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count onl=
y */
> =20
> -static int
> -__param_set_pool_mode(const char *val, struct svc_pool_map *m)
> -{
> -	int err, mode;
> -
> -	mutex_lock(&svc_pool_map_mutex);
> -
> -	err =3D 0;
> -	if (!strncmp(val, "auto", 4))
> -		mode =3D SVC_POOL_AUTO;
> -	else if (!strncmp(val, "global", 6))
> -		mode =3D SVC_POOL_GLOBAL;
> -	else if (!strncmp(val, "percpu", 6))
> -		mode =3D SVC_POOL_PERCPU;
> -	else if (!strncmp(val, "pernode", 7))
> -		mode =3D SVC_POOL_PERNODE;
> -	else
> -		err =3D -EINVAL;
> -
> -	if (err)
> -		goto out;
> -
> -	if (m->count =3D=3D 0)
> -		m->mode =3D mode;
> -	else if (mode !=3D m->mode)
> -		err =3D -EBUSY;
> -out:
> -	mutex_unlock(&svc_pool_map_mutex);
> -	return err;
> -}
> -
> -static int
> -param_set_pool_mode(const char *val, const struct kernel_param *kp)
> -{
> -	struct svc_pool_map *m =3D kp->arg;
> -
> -	return __param_set_pool_mode(val, m);
> -}
> +/*
> + * Pool modes that were historically accepted. They no longer select
> + * anything: the pool mode is always pernode. The names are retained
> + * only so that writing a previously-valid value still succeeds.
> + */
> +static const char * const pool_mode_names[] =3D {
> +	"auto", "global", "percpu", "pernode",
> +};
> =20
>  int sunrpc_set_pool_mode(const char *val)
>  {
> -	return __param_set_pool_mode(val, &svc_pool_map);
> +	int idx =3D sysfs_match_string(pool_mode_names, val);
> +
> +	return idx < 0 ? idx : 0;
>  }
>  EXPORT_SYMBOL(sunrpc_set_pool_mode);
> =20
> @@ -122,84 +76,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
>   * @buf: where to write the current pool_mode
>   * @size: size of @buf
>   *
> - * Grab the current pool_mode from the svc_pool_map and write
> - * the resulting string to @buf. Returns the number of characters
> + * Write the pool_mode string to @buf. Returns the number of characters
>   * written to @buf (a'la snprintf()).
>   */
>  int
>  sunrpc_get_pool_mode(char *buf, size_t size)
>  {
> -	struct svc_pool_map *m =3D &svc_pool_map;
> -
> -	switch (m->mode)
> -	{
> -	case SVC_POOL_AUTO:
> -		return snprintf(buf, size, "auto");
> -	case SVC_POOL_GLOBAL:
> -		return snprintf(buf, size, "global");
> -	case SVC_POOL_PERCPU:
> -		return snprintf(buf, size, "percpu");
> -	case SVC_POOL_PERNODE:
> -		return snprintf(buf, size, "pernode");
> -	default:
> -		return snprintf(buf, size, "%d", m->mode);
> -	}
> +	return snprintf(buf, size, "pernode");
>  }
>  EXPORT_SYMBOL(sunrpc_get_pool_mode);
> =20
>  static int
> -param_get_pool_mode(char *buf, const struct kernel_param *kp)
> +param_set_pool_mode(const char *val, const struct kernel_param *kp)
>  {
> -	char str[16];
> -	int len;
> -
> -	len =3D sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
> -
> -	/* Ensure we have room for newline and NUL */
> -	len =3D min_t(int, len, ARRAY_SIZE(str) - 2);
> -
> -	/* tack on the newline */
> -	str[len] =3D '\n';
> -	str[len + 1] =3D '\0';
> -
> -	return sysfs_emit(buf, "%s", str);
> +	pr_notice_once("sunrpc: the pool_mode module parameter is deprecated and =
no longer has any effect; the pool mode is always 'pernode'\n");
> +	return sunrpc_set_pool_mode(val);
>  }
> =20
> -module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> -		  &svc_pool_map, 0644);
> -
> -/*
> - * Detect best pool mapping mode heuristically,
> - * according to the machine's topology.
> - */
>  static int
> -svc_pool_map_choose_mode(void)
> +param_get_pool_mode(char *buf, const struct kernel_param *kp)
>  {
> -	unsigned int node;
> -
> -	if (nr_online_nodes > 1) {
> -		/*
> -		 * Actually have multiple NUMA nodes,
> -		 * so split pools on NUMA node boundaries
> -		 */
> -		return SVC_POOL_PERNODE;
> -	}
> -
> -	node =3D first_online_node;
> -	if (nr_cpus_node(node) > 2) {
> -		/*
> -		 * Non-trivial SMP, or CONFIG_NUMA on
> -		 * non-NUMA hardware, e.g. with a generic
> -		 * x86_64 kernel on Xeons.  In this case we
> -		 * want to divide the pools on cpu boundaries.
> -		 */
> -		return SVC_POOL_PERCPU;
> -	}
> -
> -	/* default: one global pool */
> -	return SVC_POOL_GLOBAL;
> +	return sysfs_emit(buf, "pernode\n");
>  }
> =20
> +module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> +		  NULL, 0644);
> +
>  /*
>   * Allocate the to_pool[] and pool_to[] arrays.
>   * Returns 0 on success or an errno.
> @@ -224,35 +126,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsi=
gned int maxpools)
>  }
> =20
>  /*
> - * Initialise the pool map for SVC_POOL_PERCPU mode.
> - * Returns number of pools or <0 on error.
> - */
> -static int
> -svc_pool_map_init_percpu(struct svc_pool_map *m)
> -{
> -	unsigned int maxpools =3D nr_cpu_ids;
> -	unsigned int pidx =3D 0;
> -	unsigned int cpu;
> -	int err;
> -
> -	err =3D svc_pool_map_alloc_arrays(m, maxpools);
> -	if (err)
> -		return err;
> -
> -	for_each_online_cpu(cpu) {
> -		BUG_ON(pidx >=3D maxpools);
> -		m->to_pool[cpu] =3D pidx;
> -		m->pool_to[pidx] =3D cpu;
> -		pidx++;
> -	}
> -	/* cpus brought online later all get mapped to pool0, sorry */
> -
> -	return pidx;
> -};
> -
> -
> -/*
> - * Initialise the pool map for SVC_POOL_PERNODE mode.
> + * Initialise the pool map for one pool per NUMA node.
>   * Returns number of pools or <0 on error.
>   */
>  static int
> @@ -281,17 +155,16 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
> =20
> =20
>  /*
> - * Add a reference to the global map of cpus to pools (and
> + * Add a reference to the global map of nodes to pools (and
>   * vice versa) if pools are in use.
>   * Initialise the map if we're the first user.
> - * Returns the number of pools. If this is '1', no reference
> - * was taken.
> + * Returns the number of pools, or 0 on failure.
>   */
>  static unsigned int
>  svc_pool_map_get(void)
>  {
>  	struct svc_pool_map *m =3D &svc_pool_map;
> -	int npools =3D -1;
> +	int npools;
> =20
>  	mutex_lock(&svc_pool_map_mutex);
>  	if (m->count++) {
> @@ -299,22 +172,11 @@ svc_pool_map_get(void)
>  		return m->npools;
>  	}
> =20
> -	if (m->mode =3D=3D SVC_POOL_AUTO)
> -		m->mode =3D svc_pool_map_choose_mode();
> -
> -	switch (m->mode) {
> -	case SVC_POOL_PERCPU:
> -		npools =3D svc_pool_map_init_percpu(m);
> -		break;
> -	case SVC_POOL_PERNODE:
> -		npools =3D svc_pool_map_init_pernode(m);
> -		break;
> -	}
> -
> +	npools =3D svc_pool_map_init_pernode(m);
>  	if (npools <=3D 0) {
> -		/* default, or memory allocation failure */
> -		npools =3D 1;
> -		m->mode =3D SVC_POOL_GLOBAL;
> +		m->count =3D 0;
> +		mutex_unlock(&svc_pool_map_mutex);
> +		return 0;
>  	}
>  	m->npools =3D npools;
>  	mutex_unlock(&svc_pool_map_mutex);
> @@ -322,7 +184,7 @@ svc_pool_map_get(void)
>  }
> =20
>  /*
> - * Drop a reference to the global map of cpus to pools.
> + * Drop a reference to the global map of nodes to pools.
>   * When the last reference is dropped, the map data is
>   * freed; this allows the sysadmin to change the pool.
>   */
> @@ -346,14 +208,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
>  {
>  	const struct svc_pool_map *m =3D &svc_pool_map;
> =20
> -	if (m->count) {
> -		if (m->mode =3D=3D SVC_POOL_PERCPU)
> -			return cpu_to_node(m->pool_to[pidx]);
> -		if (m->mode =3D=3D SVC_POOL_PERNODE)
> -			return m->pool_to[pidx];
> -	}
> +	if (m->count)
> +		return m->pool_to[pidx];
>  	return numa_mem_id();
>  }
> +
>  /*
>   * Set the given thread's cpus_allowed mask so that it
>   * will only run on cpus in the given pool.
> @@ -372,27 +231,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, un=
signed int pidx)
>  	if (m->count =3D=3D 0)
>  		return;
> =20
> -	switch (m->mode) {
> -	case SVC_POOL_PERCPU:
> -	{
> -		set_cpus_allowed_ptr(task, cpumask_of(node));
> -		break;
> -	}
> -	case SVC_POOL_PERNODE:
> -	{
> -		set_cpus_allowed_ptr(task, cpumask_of_node(node));
> -		break;
> -	}
> -	}
> +	set_cpus_allowed_ptr(task, cpumask_of_node(node));
>  }
> =20
>  /**
>   * svc_pool_for_cpu - Select pool to run a thread on this cpu
>   * @serv: An RPC service
>   *
> - * Use the active CPU and the svc_pool_map's mode setting to
> - * select the svc thread pool to use. Once initialized, the
> - * svc_pool_map does not change.
> + * Use the active CPU and the svc_pool_map to select the svc thread
> + * pool to use. Once initialized, the svc_pool_map does not change.
>   *
>   * Return value:
>   *   A pointer to an svc_pool
> @@ -400,22 +247,12 @@ svc_pool_map_set_cpumask(struct task_struct *task, un=
signed int pidx)
>  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  {
>  	struct svc_pool_map *m =3D &svc_pool_map;
> -	int cpu =3D raw_smp_processor_id();
> -	unsigned int pidx =3D 0;
> -	unsigned int i;
> +	unsigned int pidx, i;
> =20
>  	if (serv->sv_nrpools <=3D 1)
>  		return serv->sv_pools;
> =20
> -	switch (m->mode) {
> -	case SVC_POOL_PERCPU:
> -		pidx =3D m->to_pool[cpu];
> -		break;
> -	case SVC_POOL_PERNODE:
> -		pidx =3D m->to_pool[cpu_to_node(cpu)];
> -		break;
> -	}
> -	pidx %=3D serv->sv_nrpools;
> +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_nrpoo=
ls;
> =20
>  	/*
>  	 * Threads are spread evenly across the pools, but when there are
> @@ -641,6 +478,9 @@ struct svc_serv *svc_create_pooled(struct svc_program *=
prog,
>  	struct svc_serv *serv;
>  	unsigned int npools =3D svc_pool_map_get();
> =20
> +	if (!npools)
> +		return NULL;
> +
>  	serv =3D __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
>  	if (!serv)
>  		goto out_err;
> @@ -775,7 +615,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_p=
ool *pool, int node)
>  	rqstp->rq_server =3D serv;
>  	rqstp->rq_pool =3D pool;
> =20
> -	rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
> +	/* __folio_alloc_node() rejects NUMA_NO_NODE; let it pick for us */
> +	rqstp->rq_scratch_folio =3D
> +		__folio_alloc_node(GFP_KERNEL, 0,
> +				   node =3D=3D NUMA_NO_NODE ? numa_mem_id() : node);
>  	if (!rqstp->rq_scratch_folio)
>  		goto out_enomem;
> =20
> @@ -864,7 +707,15 @@ int svc_new_thread(struct svc_serv *serv, struct svc_p=
ool *pool)
>  	int node;
>  	int err =3D 0;
> =20
> -	node =3D svc_pool_map_get_node(pool->sp_id);
> +	/*
> +	 * Only pooled services hold a reference to the pool map, so only they
> +	 * may consult it. Unpooled services (e.g. lockd, the NFS callback)
> +	 * leave placement to the allocator.
> +	 */
> +	if (serv->sv_is_pooled)
> +		node =3D svc_pool_map_get_node(pool->sp_id);
> +	else
> +		node =3D NUMA_NO_NODE;
> =20
>  	rqstp =3D svc_prepare_thread(serv, pool, node);
>  	if (!rqstp)
>=20

I think this patch is good, but there is probably room for further
simplification which is probably best left to a later patch.
In particular, ->sv_nrpools is now either '1' or svc_pool_map.count,
and these possibilities match ->sv_is_pooled.  So we only need one of
those.
I think removing ->sv_nrpools and only using ->sv_is_pooled would
simplify/clarify some of the code.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

