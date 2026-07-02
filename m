Return-Path: <linux-nfs+bounces-22943-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m7NsDg1eRmqCRwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22943-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 14:48:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5C06F7DE1
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 14:48:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kAwstJy7;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22943-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22943-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7A21301F4B6
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89F480979;
	Thu,  2 Jul 2026 12:46:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5383138E121;
	Thu,  2 Jul 2026 12:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996383; cv=none; b=U0xmLRMbDrPvfg3GAgNeHvYgwtb9psJZyYoqhxgzBt8wYq1DzSwZMEjy3bBQ8t9pTDXVAtABgfczOwP3h6h6SIBNth6xrq4b05hbeZSx2rF8DiM3sehbXroqGUZBz6o2XFPVQd7UO9pXXlgjDpqgS/3rvV/YOagWDTWZgfY621k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996383; c=relaxed/simple;
	bh=LhD/gBE5qJ0+WeLuOgzsKfyrvT0iv4mDzjuMHLJXntw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwxG1hcgWQLmPTh6A3Bn/opeTXqjtUXk98wkkISzNprIxFsDUdvMIf1qTUrNtGnZs1hS5bXoSsTkgwj0GTWuCJhjaijcbqVhUYqmVQrWzwPhuEz179Yjzwi0wc1SEqa7I3ICm9PBz7QHgtoqEPqXbzIkzglvHN9+k2YyURq6eD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAwstJy7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D51F000E9;
	Thu,  2 Jul 2026 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996381;
	bh=zSqrmsftYTnkFQ/+UONyl1aitFQNsw6U9e2EP2ECa0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kAwstJy7Xz1JlQTwaWflEiUDwL6sxjmIrjFL6XTclUFa+9yhgqW0OicYiHxopIglt
	 Pma6CVo+wjIADs8zAKjiE/Q8Kv77MZOaIB11sgQZ+bGb6Ln2Em7CH8xq8bHckikifG
	 mROXZOj4ktIhpSfQ2Nn/wacB8FaLkCsUpU6RhvD4taBR56yzjFRqOq06D6IbGZ0GI7
	 arDJXHIVEMHgRee/UfuZ6sY96Jy6MiMKaLtpXUAxT/CmDzxubKrhzCE/01V0FEEwQw
	 nhZghLoPviatJcAFjXKMiH5RfQ85KiGy8GH/EDNcxoOjyw/h5TDVYcpWR27QoqbN0s
	 ZX3Fbwze//bFA==
Message-ID: <9e68f74e262420f0fd914a678af32b91eacc9e1e.camel@kernel.org>
Subject: Re: [PATCH v4 2/4] sunrpc: hardcode pool_mode to pernode, remove
 other modes
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Chuck Lever	 <cel@kernel.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 Jul 2026 08:46:18 -0400
In-Reply-To: <178294507023.27465.9215529741495032931@noble.neil.brown.name>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
	  <20260701-sunrpc-pool-mode-v4-2-b3d867e4c8f9@kernel.org>
	 <178294507023.27465.9215529741495032931@noble.neil.brown.name>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22943-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB5C06F7DE1

On Thu, 2026-07-02 at 08:31 +1000, NeilBrown wrote:
> On Thu, 02 Jul 2026, Jeff Layton wrote:
> > The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> > was added when NUMA was new and the right default was unclear.  The
> > default has always been "global" (a single pool for the whole service);
> > the other modes were only used when an admin explicitly set the
> > pool_mode parameter or asked for "auto", which then picked a mode from
> > the host topology.  Today, pernode is the right choice everywhere:
> >=20
> > - On multi-NUMA hosts, it gives one pool per node with proper thread
> >   affinity and NUMA-local memory allocation.
> > - On single-node hosts, pernode degenerates to exactly one pool,
> >   identical to the old "global" mode -- svc_pool_for_cpu() short-
> >   circuits when sv_nrpools <=3D 1, no CPU affinity is set, and memory
> >   is allocated from the single node.
> >=20
> > The percpu mode (one pool per CPU) created excessive pools relative to
> > the number of threads most deployments run, and was only auto-selected
> > in a narrow case (single node, >2 CPUs).
> >=20
> > Note that this changes the default behaviour on multi-NUMA hosts: a
> > service that previously ran with a single global pool now gets one pool
> > per NUMA node by default.  This in turn means a host running fewer
> > threads than it has NUMA nodes can end up with pools that have no
> > threads.  svc_pool_for_cpu() already falls back to a populated pool in
> > that case, so transports are still serviced.
> >=20
> > Remove the SVC_POOL_* enum, mode selection heuristic,
> > svc_pool_map_init_percpu(), and all mode-based switch statements.
> > Simplify pool map functions to always use the pernode path.  If pool
> > map allocation fails, svc_pool_map_get() now returns 0 and service
> > creation fails, rather than silently falling back to a single global
> > pool.
> >=20
> > With the mode check gone, svc_pool_map_get_node() would dereference the
> > shared pool_to[] for every service that starts a thread.  Only services
> > created via svc_create_pooled() hold a map reference that keeps that
> > array allocated, so gate the lookup in svc_new_thread() on sv_is_pooled=
:
> > unpooled services (e.g. lockd, the NFS callback) use NUMA_NO_NODE and
> > never consult the map.  The kmalloc_node() callers in
> > svc_prepare_thread() already accept NUMA_NO_NODE, but __folio_alloc_nod=
e()
> > requires a valid node id, so resolve NUMA_NO_NODE to numa_mem_id() for
> > the scratch folio allocation.
> >=20
> > The module parameter and netlink interfaces are preserved for backward
> > compatibility:
> > - Writing any of the four documented mode names still succeeds silently
> > - Reading always returns "pernode"
> > - Writing to the module parameter emits a deprecation notice
> >=20
> > Update Documentation/admin-guide/kernel-parameters.txt to mark the
> > pool_mode parameter deprecated and describe the new behaviour.
> >=20
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  20 +-
> >  net/sunrpc/svc.c                                | 265 ++++++----------=
--------
> >  2 files changed, 65 insertions(+), 220 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index b5493a7f8f22..441b78867478 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -7441,19 +7441,13 @@ Kernel parameters
> > =20
> >  	sunrpc.pool_mode=3D
> >  			[NFS]
> > -			Control how the NFS server code allocates CPUs to
> > -			service thread pools.  Depending on how many NICs
> > -			you have and where their interrupts are bound, this
> > -			option will affect which CPUs will do NFS serving.
> > -			Note: this parameter cannot be changed while the
> > -			NFS server is running.
> > -
> > -			auto	    the server chooses an appropriate mode
> > -				    automatically using heuristics
> > -			global	    a single global pool contains all CPUs
> > -			percpu	    one pool for each CPU
> > -			pernode	    one pool for each NUMA node (equivalent
> > -				    to global on non-NUMA machines)
> > +			Deprecated.  The NFS server now always uses one
> > +			service thread pool per NUMA node (equivalent to a
> > +			single global pool on non-NUMA machines).  All of
> > +			the previously accepted values (auto, global,
> > +			percpu, pernode) are still accepted for backward
> > +			compatibility but are ignored: the mode is always
> > +			pernode, and reads always return "pernode".
> > =20
> >  	sunrpc.tcp_slot_table_entries=3D
> >  	sunrpc.udp_slot_table_entries=3D
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 82fb7faf563f..c9fba7edaace 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -38,82 +38,36 @@
> > =20
> >  static void svc_unregister(const struct svc_serv *serv, struct net *ne=
t);
> > =20
> > -#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
> > -
> >  /*
> > - * Mode for mapping cpus to pools.
> > - */
> > -enum {
> > -	SVC_POOL_AUTO =3D -1,	/* choose one of the others */
> > -	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
> > -				 * (legacy & UP mode) */
> > -	SVC_POOL_PERCPU,	/* one pool per cpu */
> > -	SVC_POOL_PERNODE	/* one pool per numa node */
> > -};
> > -
> > -/*
> > - * Structure for mapping cpus to pools and vice versa.
> > + * Structure for mapping nodes to pools and vice versa.
> >   * Setup once during sunrpc initialisation.
> >   */
> > =20
> >  struct svc_pool_map {
> >  	int count;			/* How many svc_servs use us */
> > -	int mode;			/* Note: int not enum to avoid
> > -					 * warnings about "enumeration value
> > -					 * not handled in switch" */
> >  	unsigned int npools;
> > -	unsigned int *pool_to;		/* maps pool id to cpu or node */
> > -	unsigned int *to_pool;		/* maps cpu or node to pool id */
> > +	unsigned int *pool_to;		/* maps pool id to node */
> > +	unsigned int *to_pool;		/* maps node to pool id */
> >  };
> > =20
> > -static struct svc_pool_map svc_pool_map =3D {
> > -	.mode =3D SVC_POOL_DEFAULT
> > -};
> > +static struct svc_pool_map svc_pool_map;
> > =20
> >  static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count=
 only */
> > =20
> > -static int
> > -__param_set_pool_mode(const char *val, struct svc_pool_map *m)
> > -{
> > -	int err, mode;
> > -
> > -	mutex_lock(&svc_pool_map_mutex);
> > -
> > -	err =3D 0;
> > -	if (!strncmp(val, "auto", 4))
> > -		mode =3D SVC_POOL_AUTO;
> > -	else if (!strncmp(val, "global", 6))
> > -		mode =3D SVC_POOL_GLOBAL;
> > -	else if (!strncmp(val, "percpu", 6))
> > -		mode =3D SVC_POOL_PERCPU;
> > -	else if (!strncmp(val, "pernode", 7))
> > -		mode =3D SVC_POOL_PERNODE;
> > -	else
> > -		err =3D -EINVAL;
> > -
> > -	if (err)
> > -		goto out;
> > -
> > -	if (m->count =3D=3D 0)
> > -		m->mode =3D mode;
> > -	else if (mode !=3D m->mode)
> > -		err =3D -EBUSY;
> > -out:
> > -	mutex_unlock(&svc_pool_map_mutex);
> > -	return err;
> > -}
> > -
> > -static int
> > -param_set_pool_mode(const char *val, const struct kernel_param *kp)
> > -{
> > -	struct svc_pool_map *m =3D kp->arg;
> > -
> > -	return __param_set_pool_mode(val, m);
> > -}
> > +/*
> > + * Pool modes that were historically accepted. They no longer select
> > + * anything: the pool mode is always pernode. The names are retained
> > + * only so that writing a previously-valid value still succeeds.
> > + */
> > +static const char * const pool_mode_names[] =3D {
> > +	"auto", "global", "percpu", "pernode",
> > +};
> > =20
> >  int sunrpc_set_pool_mode(const char *val)
> >  {
> > -	return __param_set_pool_mode(val, &svc_pool_map);
> > +	int idx =3D sysfs_match_string(pool_mode_names, val);
> > +
> > +	return idx < 0 ? idx : 0;
> >  }
> >  EXPORT_SYMBOL(sunrpc_set_pool_mode);
> > =20
> > @@ -122,84 +76,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
> >   * @buf: where to write the current pool_mode
> >   * @size: size of @buf
> >   *
> > - * Grab the current pool_mode from the svc_pool_map and write
> > - * the resulting string to @buf. Returns the number of characters
> > + * Write the pool_mode string to @buf. Returns the number of character=
s
> >   * written to @buf (a'la snprintf()).
> >   */
> >  int
> >  sunrpc_get_pool_mode(char *buf, size_t size)
> >  {
> > -	struct svc_pool_map *m =3D &svc_pool_map;
> > -
> > -	switch (m->mode)
> > -	{
> > -	case SVC_POOL_AUTO:
> > -		return snprintf(buf, size, "auto");
> > -	case SVC_POOL_GLOBAL:
> > -		return snprintf(buf, size, "global");
> > -	case SVC_POOL_PERCPU:
> > -		return snprintf(buf, size, "percpu");
> > -	case SVC_POOL_PERNODE:
> > -		return snprintf(buf, size, "pernode");
> > -	default:
> > -		return snprintf(buf, size, "%d", m->mode);
> > -	}
> > +	return snprintf(buf, size, "pernode");
> >  }
> >  EXPORT_SYMBOL(sunrpc_get_pool_mode);
> > =20
> >  static int
> > -param_get_pool_mode(char *buf, const struct kernel_param *kp)
> > +param_set_pool_mode(const char *val, const struct kernel_param *kp)
> >  {
> > -	char str[16];
> > -	int len;
> > -
> > -	len =3D sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
> > -
> > -	/* Ensure we have room for newline and NUL */
> > -	len =3D min_t(int, len, ARRAY_SIZE(str) - 2);
> > -
> > -	/* tack on the newline */
> > -	str[len] =3D '\n';
> > -	str[len + 1] =3D '\0';
> > -
> > -	return sysfs_emit(buf, "%s", str);
> > +	pr_notice_once("sunrpc: the pool_mode module parameter is deprecated =
and no longer has any effect; the pool mode is always 'pernode'\n");
> > +	return sunrpc_set_pool_mode(val);
> >  }
> > =20
> > -module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> > -		  &svc_pool_map, 0644);
> > -
> > -/*
> > - * Detect best pool mapping mode heuristically,
> > - * according to the machine's topology.
> > - */
> >  static int
> > -svc_pool_map_choose_mode(void)
> > +param_get_pool_mode(char *buf, const struct kernel_param *kp)
> >  {
> > -	unsigned int node;
> > -
> > -	if (nr_online_nodes > 1) {
> > -		/*
> > -		 * Actually have multiple NUMA nodes,
> > -		 * so split pools on NUMA node boundaries
> > -		 */
> > -		return SVC_POOL_PERNODE;
> > -	}
> > -
> > -	node =3D first_online_node;
> > -	if (nr_cpus_node(node) > 2) {
> > -		/*
> > -		 * Non-trivial SMP, or CONFIG_NUMA on
> > -		 * non-NUMA hardware, e.g. with a generic
> > -		 * x86_64 kernel on Xeons.  In this case we
> > -		 * want to divide the pools on cpu boundaries.
> > -		 */
> > -		return SVC_POOL_PERCPU;
> > -	}
> > -
> > -	/* default: one global pool */
> > -	return SVC_POOL_GLOBAL;
> > +	return sysfs_emit(buf, "pernode\n");
> >  }
> > =20
> > +module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> > +		  NULL, 0644);
> > +
> >  /*
> >   * Allocate the to_pool[] and pool_to[] arrays.
> >   * Returns 0 on success or an errno.
> > @@ -224,35 +126,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, =
unsigned int maxpools)
> >  }
> > =20
> >  /*
> > - * Initialise the pool map for SVC_POOL_PERCPU mode.
> > - * Returns number of pools or <0 on error.
> > - */
> > -static int
> > -svc_pool_map_init_percpu(struct svc_pool_map *m)
> > -{
> > -	unsigned int maxpools =3D nr_cpu_ids;
> > -	unsigned int pidx =3D 0;
> > -	unsigned int cpu;
> > -	int err;
> > -
> > -	err =3D svc_pool_map_alloc_arrays(m, maxpools);
> > -	if (err)
> > -		return err;
> > -
> > -	for_each_online_cpu(cpu) {
> > -		BUG_ON(pidx >=3D maxpools);
> > -		m->to_pool[cpu] =3D pidx;
> > -		m->pool_to[pidx] =3D cpu;
> > -		pidx++;
> > -	}
> > -	/* cpus brought online later all get mapped to pool0, sorry */
> > -
> > -	return pidx;
> > -};
> > -
> > -
> > -/*
> > - * Initialise the pool map for SVC_POOL_PERNODE mode.
> > + * Initialise the pool map for one pool per NUMA node.
> >   * Returns number of pools or <0 on error.
> >   */
> >  static int
> > @@ -281,17 +155,16 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
> > =20
> > =20
> >  /*
> > - * Add a reference to the global map of cpus to pools (and
> > + * Add a reference to the global map of nodes to pools (and
> >   * vice versa) if pools are in use.
> >   * Initialise the map if we're the first user.
> > - * Returns the number of pools. If this is '1', no reference
> > - * was taken.
> > + * Returns the number of pools, or 0 on failure.
> >   */
> >  static unsigned int
> >  svc_pool_map_get(void)
> >  {
> >  	struct svc_pool_map *m =3D &svc_pool_map;
> > -	int npools =3D -1;
> > +	int npools;
> > =20
> >  	mutex_lock(&svc_pool_map_mutex);
> >  	if (m->count++) {
> > @@ -299,22 +172,11 @@ svc_pool_map_get(void)
> >  		return m->npools;
> >  	}
> > =20
> > -	if (m->mode =3D=3D SVC_POOL_AUTO)
> > -		m->mode =3D svc_pool_map_choose_mode();
> > -
> > -	switch (m->mode) {
> > -	case SVC_POOL_PERCPU:
> > -		npools =3D svc_pool_map_init_percpu(m);
> > -		break;
> > -	case SVC_POOL_PERNODE:
> > -		npools =3D svc_pool_map_init_pernode(m);
> > -		break;
> > -	}
> > -
> > +	npools =3D svc_pool_map_init_pernode(m);
> >  	if (npools <=3D 0) {
> > -		/* default, or memory allocation failure */
> > -		npools =3D 1;
> > -		m->mode =3D SVC_POOL_GLOBAL;
> > +		m->count =3D 0;
> > +		mutex_unlock(&svc_pool_map_mutex);
> > +		return 0;
> >  	}
> >  	m->npools =3D npools;
> >  	mutex_unlock(&svc_pool_map_mutex);
> > @@ -322,7 +184,7 @@ svc_pool_map_get(void)
> >  }
> > =20
> >  /*
> > - * Drop a reference to the global map of cpus to pools.
> > + * Drop a reference to the global map of nodes to pools.
> >   * When the last reference is dropped, the map data is
> >   * freed; this allows the sysadmin to change the pool.
> >   */
> > @@ -346,14 +208,11 @@ static int svc_pool_map_get_node(unsigned int pid=
x)
> >  {
> >  	const struct svc_pool_map *m =3D &svc_pool_map;
> > =20
> > -	if (m->count) {
> > -		if (m->mode =3D=3D SVC_POOL_PERCPU)
> > -			return cpu_to_node(m->pool_to[pidx]);
> > -		if (m->mode =3D=3D SVC_POOL_PERNODE)
> > -			return m->pool_to[pidx];
> > -	}
> > +	if (m->count)
> > +		return m->pool_to[pidx];
> >  	return numa_mem_id();
> >  }
> > +
> >  /*
> >   * Set the given thread's cpus_allowed mask so that it
> >   * will only run on cpus in the given pool.
> > @@ -372,27 +231,15 @@ svc_pool_map_set_cpumask(struct task_struct *task=
, unsigned int pidx)
> >  	if (m->count =3D=3D 0)
> >  		return;
> > =20
> > -	switch (m->mode) {
> > -	case SVC_POOL_PERCPU:
> > -	{
> > -		set_cpus_allowed_ptr(task, cpumask_of(node));
> > -		break;
> > -	}
> > -	case SVC_POOL_PERNODE:
> > -	{
> > -		set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > -		break;
> > -	}
> > -	}
> > +	set_cpus_allowed_ptr(task, cpumask_of_node(node));
> >  }
> > =20
> >  /**
> >   * svc_pool_for_cpu - Select pool to run a thread on this cpu
> >   * @serv: An RPC service
> >   *
> > - * Use the active CPU and the svc_pool_map's mode setting to
> > - * select the svc thread pool to use. Once initialized, the
> > - * svc_pool_map does not change.
> > + * Use the active CPU and the svc_pool_map to select the svc thread
> > + * pool to use. Once initialized, the svc_pool_map does not change.
> >   *
> >   * Return value:
> >   *   A pointer to an svc_pool
> > @@ -400,22 +247,12 @@ svc_pool_map_set_cpumask(struct task_struct *task=
, unsigned int pidx)
> >  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
> >  {
> >  	struct svc_pool_map *m =3D &svc_pool_map;
> > -	int cpu =3D raw_smp_processor_id();
> > -	unsigned int pidx =3D 0;
> > -	unsigned int i;
> > +	unsigned int pidx, i;
> > =20
> >  	if (serv->sv_nrpools <=3D 1)
> >  		return serv->sv_pools;
> > =20
> > -	switch (m->mode) {
> > -	case SVC_POOL_PERCPU:
> > -		pidx =3D m->to_pool[cpu];
> > -		break;
> > -	case SVC_POOL_PERNODE:
> > -		pidx =3D m->to_pool[cpu_to_node(cpu)];
> > -		break;
> > -	}
> > -	pidx %=3D serv->sv_nrpools;
> > +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_n=
rpools;
> > =20
> >  	/*
> >  	 * Threads are spread evenly across the pools, but when there are
> > @@ -641,6 +478,9 @@ struct svc_serv *svc_create_pooled(struct svc_progr=
am *prog,
> >  	struct svc_serv *serv;
> >  	unsigned int npools =3D svc_pool_map_get();
> > =20
> > +	if (!npools)
> > +		return NULL;
> > +
> >  	serv =3D __svc_create(prog, nprogs, stats, bufsize, npools, threadfn)=
;
> >  	if (!serv)
> >  		goto out_err;
> > @@ -775,7 +615,10 @@ svc_prepare_thread(struct svc_serv *serv, struct s=
vc_pool *pool, int node)
> >  	rqstp->rq_server =3D serv;
> >  	rqstp->rq_pool =3D pool;
> > =20
> > -	rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
> > +	/* __folio_alloc_node() rejects NUMA_NO_NODE; let it pick for us */
> > +	rqstp->rq_scratch_folio =3D
> > +		__folio_alloc_node(GFP_KERNEL, 0,
> > +				   node =3D=3D NUMA_NO_NODE ? numa_mem_id() : node);
> >  	if (!rqstp->rq_scratch_folio)
> >  		goto out_enomem;
> > =20
> > @@ -864,7 +707,15 @@ int svc_new_thread(struct svc_serv *serv, struct s=
vc_pool *pool)
> >  	int node;
> >  	int err =3D 0;
> > =20
> > -	node =3D svc_pool_map_get_node(pool->sp_id);
> > +	/*
> > +	 * Only pooled services hold a reference to the pool map, so only the=
y
> > +	 * may consult it. Unpooled services (e.g. lockd, the NFS callback)
> > +	 * leave placement to the allocator.
> > +	 */
> > +	if (serv->sv_is_pooled)
> > +		node =3D svc_pool_map_get_node(pool->sp_id);
> > +	else
> > +		node =3D NUMA_NO_NODE;
> > =20
> >  	rqstp =3D svc_prepare_thread(serv, pool, node);
> >  	if (!rqstp)
> >=20
>=20
> I think this patch is good, but there is probably room for further
> simplification which is probably best left to a later patch.
> In particular, ->sv_nrpools is now either '1' or svc_pool_map.count,
> and these possibilities match ->sv_is_pooled.  So we only need one of
> those.
> I think removing ->sv_nrpools and only using ->sv_is_pooled would
> simplify/clarify some of the code.
>
> Reviewed-by: NeilBrown <neil@brown.name>

Thanks. I took a look at that cleanup, but it's not quite the same.

  - unpooled service (lockd, NFS callback): sv_is_pooled=3Dfalse, sv_nrpool=
s=3D1
  - pooled service on a single-node host: sv_is_pooled=3Dtrue, sv_nrpools=
=3D1 (pernode degenerates to one pool)
  - pooled service on multi-node: sv_is_pooled=3Dtrue, sv_nrpools=3DN>1

So you can't derive sv_is_pooled from sv_nrpools because of the
single-node case.

Worse, it also means that we'd have to create more accessors for the
svc_pool_map. There are several places that access sv_nrpools that
would have to be converted to get it from the map. That may have
performance implications too since the map is accessed during receives.

So this kind of cleanup is doable, but it's a bit messier than it
sounds at first.
--=20
Jeff Layton <jlayton@kernel.org>

