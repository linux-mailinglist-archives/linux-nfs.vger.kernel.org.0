Return-Path: <linux-nfs+bounces-22966-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HWbiIF40R2rtUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22966-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 06:02:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A46FE488
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 06:02:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=J5WQPhV5;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="h JIdWPp";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22966-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22966-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355873038C49
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA68313E15;
	Fri,  3 Jul 2026 04:02:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336FF23E35F;
	Fri,  3 Jul 2026 04:02:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051353; cv=none; b=YUuqn6+GBXq20KqTay69QBjwSFOtHXz00UdrpcVnyEwGT+aONZlZoA15Xy0sz0Gvx11AtD7jrslC8KilcLk9/SMxrPic2rRSVLiTeMGJ+NuN5+wt5QskTF2Uf1Ed0yXkdetQOXoXW0lRogYWOG2MD3gONGPEKthA6kWh+FtEUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051353; c=relaxed/simple;
	bh=BNahqCGFULJ/O3hUNXTVOZ30/ap35/9o2deTK5CHDas=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=BLfR1a0Ka/t70u6yJHoAC5cPHJJDo1AfudyDfmrLgn9BK04OBMhD2z10FT2u5OQXUFXxTF5VTST/HG1Uyv27CY9kHDmhwkwcZgQlYddxMjaSEewyXndZxIFkVPVDrYxbD9duSJdSTE4mGm0I0GANrRqQ6LKvQjPZ46gPkEEFQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=J5WQPhV5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJIdWPp+; arc=none smtp.client-ip=103.168.172.156
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6C711400076;
	Fri,  3 Jul 2026 00:02:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 00:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783051336; x=1783137736; bh=ZjbM7QOvkHlyF0Fi78bX0efVkk1cADBjUsb
	mYdi/Awo=; b=J5WQPhV5tiNDA1P/v93pz53Dku03nIjD8XMPcLFWwNI5d/Azpsk
	0WhOAiO1VC9Q6gmcnK3kJ5osB36bYq03v/4ezXQPgo7MzLTgun7bn733tZp1Aa+7
	Rx3xyYmvMYE/bRDTI+nhA6aK0cui3WAfEMOQNWPIJ0Qc/OU4paVYlJg7K2csXSIA
	D/x1f1pOPuTBuObnqGJMJiPL64xvyZZf2udAJLL8cFLAFLxjyeecqbK8ZUjTipCh
	TDgGaj0BK8PO6DQFdPz4Rn91q4M6e6C7k6mqQVti0knJ3Y1wW4AIcvXweoy6r/Ok
	yQOu1XyGl19Jq5KmZt9rhP3qFfNPrZhpmZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783051336; x=
	1783137736; bh=ZjbM7QOvkHlyF0Fi78bX0efVkk1cADBjUsbmYdi/Awo=; b=h
	JIdWPp+UcLbXRpHU7SEU0Wpbt70RNKxB/omNslDfhcTOy/TYG03VOkuybbNZUCPK
	iQwnPk0gxhpw4bNGvnOmbDmleutAS8YYTIu2mxtMM/YYomV7w5bRFa/Je9GmCy8o
	QhDBXmzQs/zYu6VkxaOxSwNKKXa2QAkGYrh0zSkrXS2PmnIXUCd3WxIX0/aZfmJK
	xqHshSNXPHqzxBsNsECMJQ6xodXIvqogsPGx6kFB6Us2AGaQrkrJoz3GS9h2WrN3
	x4DH0CkUsohMA3neZJQj1K7969LocecgZ2QIhcD7maOPGbW4h22+FsGY/4J8xHdA
	OGWy3DkseAo9DUhbfoGxA==
X-ME-Sender: <xms:SDRHajzAJU5o90FRQmGi9G4PEgMJ6oaNtC4PNCZSFyaFLmQK0RBXeA>
    <xme:SDRHagN3pX22QmNekpo-ZqLiowVn8wCdwcFbT74YqjScfFSYh1S-dVefDme40tsWp
    QOvCuHryXsnOV7-VT4OfQ-VE9oin_4tpi3ZhSoZqn3D3MewaA>
X-ME-Received: <xmr:SDRHahmOpPr2M3GW0ooKPeQzz4ygHS2bKkM43Bw222Cramhws3zmF5ZXEw0-Iz_MPw>
X-ME-Proxy-Cause: dmFkZTElTKdkBaCxqGAd16AwVMm4ei2tb8VIZZtxjMHRQrVP59HTxzbHmlVwyAzTE/ffgG
    e2CySu/8yhHMjnc7lkbqPIcMdML0ngHLb23FyZjQeoE4JwYieu3GoCD4/ikQbDaXqjRxU7
    +/n47Pf9DRZ8QWz9WsADBs3lA6q0ZosDwKAFiHNaLo7vsj4Kd54VATLZjqfZJ59asZ6wdK
    7wATDeLznwrEZ5GVa1Qrx2yj1cWHh3nxMEFpSkuoEqgA69VsqjGJwSgH89nZ0SANS2gQMD
    XWULp8BpsrmuOXvEtyW9wXSOkKCmcbTyO6tdhrvWjRzKDaQJWGH3Gk/s2Cxf3Zhx1GGhU+
    RnpXJuJ8ad3RICuiPnxxxjKxfOMnObW0iWSOAPc7ThJXWVUuEmht59RWq4tltKA5k4c77H
    hryO2IOpmHZaggBud1VdH5yTcIaCaBBdC6sc+s8HPgNC4/4y6hyiU8zFYpDghi9QSD9JMF
    e0dhltfFx0Srov5lYWaHM6qpd27vOdjm34PoWdv8kWbt8k8shKMIsyOCyzMGWcYwNf8KNo
    YvT4FuoFiMkVIpTFwUtE5WgW2cT9xtSmBreVwi5yVJkTzBRHcaf2Te++feu7K4aMgU7BRg
    7VjAEAoDyUByHqUxbkqxVQ7I0fx/rr8wDm/GdA6CvSELuGUysQ3FhrCC7NDg
X-ME-Proxy: <xmx:SDRHatSsaE7wHVFzcIdMWS2-XSaU9TEcUnpmjf-KkcQyX_I2WPGL4g>
    <xmx:SDRHaoUKT2KV_g0mJqiEsvxHJNjV9qSzX4pLS4bPvCNM4m3vxggKWA>
    <xmx:SDRHapLfgl8taK_2k4K7rxr4sr0D3ETUkPgN7LFnvSj0n7PZMSYN7w>
    <xmx:SDRHag2W1Gme7itdPTqUzTMQPA9qXexe4pqjqfCb2MIte9ltXePAkA>
    <xmx:SDRHalzrxrfbjbtC_JiZv0T2ol9xuBhyKpwnOSQCNBakNV4xIhYAIueI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 00:02:13 -0400 (EDT)
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
Subject:
 Re: [PATCH v4 2/4] sunrpc: hardcode pool_mode to pernode, remove other modes
In-reply-to: <9e68f74e262420f0fd914a678af32b91eacc9e1e.camel@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
  <20260701-sunrpc-pool-mode-v4-2-b3d867e4c8f9@kernel.org>
  <178294507023.27465.9215529741495032931@noble.neil.brown.name>
  <9e68f74e262420f0fd914a678af32b91eacc9e1e.camel@kernel.org>
Date: Fri, 03 Jul 2026 14:02:09 +1000
Message-id: <178305132973.27465.1946356721236703804@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22966-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F2A46FE488

On Thu, 02 Jul 2026, Jeff Layton wrote:
> On Thu, 2026-07-02 at 08:31 +1000, NeilBrown wrote:
> > On Thu, 02 Jul 2026, Jeff Layton wrote:
> > > The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> > > was added when NUMA was new and the right default was unclear.  The
> > > default has always been "global" (a single pool for the whole service);
> > > the other modes were only used when an admin explicitly set the
> > > pool_mode parameter or asked for "auto", which then picked a mode from
> > > the host topology.  Today, pernode is the right choice everywhere:
> > >=20
> > > - On multi-NUMA hosts, it gives one pool per node with proper thread
> > >   affinity and NUMA-local memory allocation.
> > > - On single-node hosts, pernode degenerates to exactly one pool,
> > >   identical to the old "global" mode -- svc_pool_for_cpu() short-
> > >   circuits when sv_nrpools <=3D 1, no CPU affinity is set, and memory
> > >   is allocated from the single node.
> > >=20
> > > The percpu mode (one pool per CPU) created excessive pools relative to
> > > the number of threads most deployments run, and was only auto-selected
> > > in a narrow case (single node, >2 CPUs).
> > >=20
> > > Note that this changes the default behaviour on multi-NUMA hosts: a
> > > service that previously ran with a single global pool now gets one pool
> > > per NUMA node by default.  This in turn means a host running fewer
> > > threads than it has NUMA nodes can end up with pools that have no
> > > threads.  svc_pool_for_cpu() already falls back to a populated pool in
> > > that case, so transports are still serviced.
> > >=20
> > > Remove the SVC_POOL_* enum, mode selection heuristic,
> > > svc_pool_map_init_percpu(), and all mode-based switch statements.
> > > Simplify pool map functions to always use the pernode path.  If pool
> > > map allocation fails, svc_pool_map_get() now returns 0 and service
> > > creation fails, rather than silently falling back to a single global
> > > pool.
> > >=20
> > > With the mode check gone, svc_pool_map_get_node() would dereference the
> > > shared pool_to[] for every service that starts a thread.  Only services
> > > created via svc_create_pooled() hold a map reference that keeps that
> > > array allocated, so gate the lookup in svc_new_thread() on sv_is_pooled:
> > > unpooled services (e.g. lockd, the NFS callback) use NUMA_NO_NODE and
> > > never consult the map.  The kmalloc_node() callers in
> > > svc_prepare_thread() already accept NUMA_NO_NODE, but __folio_alloc_nod=
e()
> > > requires a valid node id, so resolve NUMA_NO_NODE to numa_mem_id() for
> > > the scratch folio allocation.
> > >=20
> > > The module parameter and netlink interfaces are preserved for backward
> > > compatibility:
> > > - Writing any of the four documented mode names still succeeds silently
> > > - Reading always returns "pernode"
> > > - Writing to the module parameter emits a deprecation notice
> > >=20
> > > Update Documentation/admin-guide/kernel-parameters.txt to mark the
> > > pool_mode parameter deprecated and describe the new behaviour.
> > >=20
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  20 +-
> > >  net/sunrpc/svc.c                                | 265 ++++++----------=
--------
> > >  2 files changed, 65 insertions(+), 220 deletions(-)
> > >=20
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > > index b5493a7f8f22..441b78867478 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -7441,19 +7441,13 @@ Kernel parameters
> > > =20
> > >  	sunrpc.pool_mode=3D
> > >  			[NFS]
> > > -			Control how the NFS server code allocates CPUs to
> > > -			service thread pools.  Depending on how many NICs
> > > -			you have and where their interrupts are bound, this
> > > -			option will affect which CPUs will do NFS serving.
> > > -			Note: this parameter cannot be changed while the
> > > -			NFS server is running.
> > > -
> > > -			auto	    the server chooses an appropriate mode
> > > -				    automatically using heuristics
> > > -			global	    a single global pool contains all CPUs
> > > -			percpu	    one pool for each CPU
> > > -			pernode	    one pool for each NUMA node (equivalent
> > > -				    to global on non-NUMA machines)
> > > +			Deprecated.  The NFS server now always uses one
> > > +			service thread pool per NUMA node (equivalent to a
> > > +			single global pool on non-NUMA machines).  All of
> > > +			the previously accepted values (auto, global,
> > > +			percpu, pernode) are still accepted for backward
> > > +			compatibility but are ignored: the mode is always
> > > +			pernode, and reads always return "pernode".
> > > =20
> > >  	sunrpc.tcp_slot_table_entries=3D
> > >  	sunrpc.udp_slot_table_entries=3D
> > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > index 82fb7faf563f..c9fba7edaace 100644
> > > --- a/net/sunrpc/svc.c
> > > +++ b/net/sunrpc/svc.c
> > > @@ -38,82 +38,36 @@
> > > =20
> > >  static void svc_unregister(const struct svc_serv *serv, struct net *ne=
t);
> > > =20
> > > -#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
> > > -
> > >  /*
> > > - * Mode for mapping cpus to pools.
> > > - */
> > > -enum {
> > > -	SVC_POOL_AUTO =3D -1,	/* choose one of the others */
> > > -	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
> > > -				 * (legacy & UP mode) */
> > > -	SVC_POOL_PERCPU,	/* one pool per cpu */
> > > -	SVC_POOL_PERNODE	/* one pool per numa node */
> > > -};
> > > -
> > > -/*
> > > - * Structure for mapping cpus to pools and vice versa.
> > > + * Structure for mapping nodes to pools and vice versa.
> > >   * Setup once during sunrpc initialisation.
> > >   */
> > > =20
> > >  struct svc_pool_map {
> > >  	int count;			/* How many svc_servs use us */
> > > -	int mode;			/* Note: int not enum to avoid
> > > -					 * warnings about "enumeration value
> > > -					 * not handled in switch" */
> > >  	unsigned int npools;
> > > -	unsigned int *pool_to;		/* maps pool id to cpu or node */
> > > -	unsigned int *to_pool;		/* maps cpu or node to pool id */
> > > +	unsigned int *pool_to;		/* maps pool id to node */
> > > +	unsigned int *to_pool;		/* maps node to pool id */
> > >  };
> > > =20
> > > -static struct svc_pool_map svc_pool_map =3D {
> > > -	.mode =3D SVC_POOL_DEFAULT
> > > -};
> > > +static struct svc_pool_map svc_pool_map;
> > > =20
> > >  static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count=
 only */
> > > =20
> > > -static int
> > > -__param_set_pool_mode(const char *val, struct svc_pool_map *m)
> > > -{
> > > -	int err, mode;
> > > -
> > > -	mutex_lock(&svc_pool_map_mutex);
> > > -
> > > -	err =3D 0;
> > > -	if (!strncmp(val, "auto", 4))
> > > -		mode =3D SVC_POOL_AUTO;
> > > -	else if (!strncmp(val, "global", 6))
> > > -		mode =3D SVC_POOL_GLOBAL;
> > > -	else if (!strncmp(val, "percpu", 6))
> > > -		mode =3D SVC_POOL_PERCPU;
> > > -	else if (!strncmp(val, "pernode", 7))
> > > -		mode =3D SVC_POOL_PERNODE;
> > > -	else
> > > -		err =3D -EINVAL;
> > > -
> > > -	if (err)
> > > -		goto out;
> > > -
> > > -	if (m->count =3D=3D 0)
> > > -		m->mode =3D mode;
> > > -	else if (mode !=3D m->mode)
> > > -		err =3D -EBUSY;
> > > -out:
> > > -	mutex_unlock(&svc_pool_map_mutex);
> > > -	return err;
> > > -}
> > > -
> > > -static int
> > > -param_set_pool_mode(const char *val, const struct kernel_param *kp)
> > > -{
> > > -	struct svc_pool_map *m =3D kp->arg;
> > > -
> > > -	return __param_set_pool_mode(val, m);
> > > -}
> > > +/*
> > > + * Pool modes that were historically accepted. They no longer select
> > > + * anything: the pool mode is always pernode. The names are retained
> > > + * only so that writing a previously-valid value still succeeds.
> > > + */
> > > +static const char * const pool_mode_names[] =3D {
> > > +	"auto", "global", "percpu", "pernode",
> > > +};
> > > =20
> > >  int sunrpc_set_pool_mode(const char *val)
> > >  {
> > > -	return __param_set_pool_mode(val, &svc_pool_map);
> > > +	int idx =3D sysfs_match_string(pool_mode_names, val);
> > > +
> > > +	return idx < 0 ? idx : 0;
> > >  }
> > >  EXPORT_SYMBOL(sunrpc_set_pool_mode);
> > > =20
> > > @@ -122,84 +76,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
> > >   * @buf: where to write the current pool_mode
> > >   * @size: size of @buf
> > >   *
> > > - * Grab the current pool_mode from the svc_pool_map and write
> > > - * the resulting string to @buf. Returns the number of characters
> > > + * Write the pool_mode string to @buf. Returns the number of characters
> > >   * written to @buf (a'la snprintf()).
> > >   */
> > >  int
> > >  sunrpc_get_pool_mode(char *buf, size_t size)
> > >  {
> > > -	struct svc_pool_map *m =3D &svc_pool_map;
> > > -
> > > -	switch (m->mode)
> > > -	{
> > > -	case SVC_POOL_AUTO:
> > > -		return snprintf(buf, size, "auto");
> > > -	case SVC_POOL_GLOBAL:
> > > -		return snprintf(buf, size, "global");
> > > -	case SVC_POOL_PERCPU:
> > > -		return snprintf(buf, size, "percpu");
> > > -	case SVC_POOL_PERNODE:
> > > -		return snprintf(buf, size, "pernode");
> > > -	default:
> > > -		return snprintf(buf, size, "%d", m->mode);
> > > -	}
> > > +	return snprintf(buf, size, "pernode");
> > >  }
> > >  EXPORT_SYMBOL(sunrpc_get_pool_mode);
> > > =20
> > >  static int
> > > -param_get_pool_mode(char *buf, const struct kernel_param *kp)
> > > +param_set_pool_mode(const char *val, const struct kernel_param *kp)
> > >  {
> > > -	char str[16];
> > > -	int len;
> > > -
> > > -	len =3D sunrpc_get_pool_mode(str, ARRAY_SIZE(str));
> > > -
> > > -	/* Ensure we have room for newline and NUL */
> > > -	len =3D min_t(int, len, ARRAY_SIZE(str) - 2);
> > > -
> > > -	/* tack on the newline */
> > > -	str[len] =3D '\n';
> > > -	str[len + 1] =3D '\0';
> > > -
> > > -	return sysfs_emit(buf, "%s", str);
> > > +	pr_notice_once("sunrpc: the pool_mode module parameter is deprecated =
and no longer has any effect; the pool mode is always 'pernode'\n");
> > > +	return sunrpc_set_pool_mode(val);
> > >  }
> > > =20
> > > -module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> > > -		  &svc_pool_map, 0644);
> > > -
> > > -/*
> > > - * Detect best pool mapping mode heuristically,
> > > - * according to the machine's topology.
> > > - */
> > >  static int
> > > -svc_pool_map_choose_mode(void)
> > > +param_get_pool_mode(char *buf, const struct kernel_param *kp)
> > >  {
> > > -	unsigned int node;
> > > -
> > > -	if (nr_online_nodes > 1) {
> > > -		/*
> > > -		 * Actually have multiple NUMA nodes,
> > > -		 * so split pools on NUMA node boundaries
> > > -		 */
> > > -		return SVC_POOL_PERNODE;
> > > -	}
> > > -
> > > -	node =3D first_online_node;
> > > -	if (nr_cpus_node(node) > 2) {
> > > -		/*
> > > -		 * Non-trivial SMP, or CONFIG_NUMA on
> > > -		 * non-NUMA hardware, e.g. with a generic
> > > -		 * x86_64 kernel on Xeons.  In this case we
> > > -		 * want to divide the pools on cpu boundaries.
> > > -		 */
> > > -		return SVC_POOL_PERCPU;
> > > -	}
> > > -
> > > -	/* default: one global pool */
> > > -	return SVC_POOL_GLOBAL;
> > > +	return sysfs_emit(buf, "pernode\n");
> > >  }
> > > =20
> > > +module_param_call(pool_mode, param_set_pool_mode, param_get_pool_mode,
> > > +		  NULL, 0644);
> > > +
> > >  /*
> > >   * Allocate the to_pool[] and pool_to[] arrays.
> > >   * Returns 0 on success or an errno.
> > > @@ -224,35 +126,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, =
unsigned int maxpools)
> > >  }
> > > =20
> > >  /*
> > > - * Initialise the pool map for SVC_POOL_PERCPU mode.
> > > - * Returns number of pools or <0 on error.
> > > - */
> > > -static int
> > > -svc_pool_map_init_percpu(struct svc_pool_map *m)
> > > -{
> > > -	unsigned int maxpools =3D nr_cpu_ids;
> > > -	unsigned int pidx =3D 0;
> > > -	unsigned int cpu;
> > > -	int err;
> > > -
> > > -	err =3D svc_pool_map_alloc_arrays(m, maxpools);
> > > -	if (err)
> > > -		return err;
> > > -
> > > -	for_each_online_cpu(cpu) {
> > > -		BUG_ON(pidx >=3D maxpools);
> > > -		m->to_pool[cpu] =3D pidx;
> > > -		m->pool_to[pidx] =3D cpu;
> > > -		pidx++;
> > > -	}
> > > -	/* cpus brought online later all get mapped to pool0, sorry */
> > > -
> > > -	return pidx;
> > > -};
> > > -
> > > -
> > > -/*
> > > - * Initialise the pool map for SVC_POOL_PERNODE mode.
> > > + * Initialise the pool map for one pool per NUMA node.
> > >   * Returns number of pools or <0 on error.
> > >   */
> > >  static int
> > > @@ -281,17 +155,16 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
> > > =20
> > > =20
> > >  /*
> > > - * Add a reference to the global map of cpus to pools (and
> > > + * Add a reference to the global map of nodes to pools (and
> > >   * vice versa) if pools are in use.
> > >   * Initialise the map if we're the first user.
> > > - * Returns the number of pools. If this is '1', no reference
> > > - * was taken.
> > > + * Returns the number of pools, or 0 on failure.
> > >   */
> > >  static unsigned int
> > >  svc_pool_map_get(void)
> > >  {
> > >  	struct svc_pool_map *m =3D &svc_pool_map;
> > > -	int npools =3D -1;
> > > +	int npools;
> > > =20
> > >  	mutex_lock(&svc_pool_map_mutex);
> > >  	if (m->count++) {
> > > @@ -299,22 +172,11 @@ svc_pool_map_get(void)
> > >  		return m->npools;
> > >  	}
> > > =20
> > > -	if (m->mode =3D=3D SVC_POOL_AUTO)
> > > -		m->mode =3D svc_pool_map_choose_mode();
> > > -
> > > -	switch (m->mode) {
> > > -	case SVC_POOL_PERCPU:
> > > -		npools =3D svc_pool_map_init_percpu(m);
> > > -		break;
> > > -	case SVC_POOL_PERNODE:
> > > -		npools =3D svc_pool_map_init_pernode(m);
> > > -		break;
> > > -	}
> > > -
> > > +	npools =3D svc_pool_map_init_pernode(m);
> > >  	if (npools <=3D 0) {
> > > -		/* default, or memory allocation failure */
> > > -		npools =3D 1;
> > > -		m->mode =3D SVC_POOL_GLOBAL;
> > > +		m->count =3D 0;
> > > +		mutex_unlock(&svc_pool_map_mutex);
> > > +		return 0;
> > >  	}
> > >  	m->npools =3D npools;
> > >  	mutex_unlock(&svc_pool_map_mutex);
> > > @@ -322,7 +184,7 @@ svc_pool_map_get(void)
> > >  }
> > > =20
> > >  /*
> > > - * Drop a reference to the global map of cpus to pools.
> > > + * Drop a reference to the global map of nodes to pools.
> > >   * When the last reference is dropped, the map data is
> > >   * freed; this allows the sysadmin to change the pool.
> > >   */
> > > @@ -346,14 +208,11 @@ static int svc_pool_map_get_node(unsigned int pid=
x)
> > >  {
> > >  	const struct svc_pool_map *m =3D &svc_pool_map;
> > > =20
> > > -	if (m->count) {
> > > -		if (m->mode =3D=3D SVC_POOL_PERCPU)
> > > -			return cpu_to_node(m->pool_to[pidx]);
> > > -		if (m->mode =3D=3D SVC_POOL_PERNODE)
> > > -			return m->pool_to[pidx];
> > > -	}
> > > +	if (m->count)
> > > +		return m->pool_to[pidx];
> > >  	return numa_mem_id();
> > >  }
> > > +
> > >  /*
> > >   * Set the given thread's cpus_allowed mask so that it
> > >   * will only run on cpus in the given pool.
> > > @@ -372,27 +231,15 @@ svc_pool_map_set_cpumask(struct task_struct *task=
, unsigned int pidx)
> > >  	if (m->count =3D=3D 0)
> > >  		return;
> > > =20
> > > -	switch (m->mode) {
> > > -	case SVC_POOL_PERCPU:
> > > -	{
> > > -		set_cpus_allowed_ptr(task, cpumask_of(node));
> > > -		break;
> > > -	}
> > > -	case SVC_POOL_PERNODE:
> > > -	{
> > > -		set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > > -		break;
> > > -	}
> > > -	}
> > > +	set_cpus_allowed_ptr(task, cpumask_of_node(node));
> > >  }
> > > =20
> > >  /**
> > >   * svc_pool_for_cpu - Select pool to run a thread on this cpu
> > >   * @serv: An RPC service
> > >   *
> > > - * Use the active CPU and the svc_pool_map's mode setting to
> > > - * select the svc thread pool to use. Once initialized, the
> > > - * svc_pool_map does not change.
> > > + * Use the active CPU and the svc_pool_map to select the svc thread
> > > + * pool to use. Once initialized, the svc_pool_map does not change.
> > >   *
> > >   * Return value:
> > >   *   A pointer to an svc_pool
> > > @@ -400,22 +247,12 @@ svc_pool_map_set_cpumask(struct task_struct *task=
, unsigned int pidx)
> > >  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
> > >  {
> > >  	struct svc_pool_map *m =3D &svc_pool_map;
> > > -	int cpu =3D raw_smp_processor_id();
> > > -	unsigned int pidx =3D 0;
> > > -	unsigned int i;
> > > +	unsigned int pidx, i;
> > > =20
> > >  	if (serv->sv_nrpools <=3D 1)
> > >  		return serv->sv_pools;
> > > =20
> > > -	switch (m->mode) {
> > > -	case SVC_POOL_PERCPU:
> > > -		pidx =3D m->to_pool[cpu];
> > > -		break;
> > > -	case SVC_POOL_PERNODE:
> > > -		pidx =3D m->to_pool[cpu_to_node(cpu)];
> > > -		break;
> > > -	}
> > > -	pidx %=3D serv->sv_nrpools;
> > > +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())] % serv->sv_n=
rpools;
> > > =20
> > >  	/*
> > >  	 * Threads are spread evenly across the pools, but when there are
> > > @@ -641,6 +478,9 @@ struct svc_serv *svc_create_pooled(struct svc_progr=
am *prog,
> > >  	struct svc_serv *serv;
> > >  	unsigned int npools =3D svc_pool_map_get();
> > > =20
> > > +	if (!npools)
> > > +		return NULL;
> > > +
> > >  	serv =3D __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
> > >  	if (!serv)
> > >  		goto out_err;
> > > @@ -775,7 +615,10 @@ svc_prepare_thread(struct svc_serv *serv, struct s=
vc_pool *pool, int node)
> > >  	rqstp->rq_server =3D serv;
> > >  	rqstp->rq_pool =3D pool;
> > > =20
> > > -	rqstp->rq_scratch_folio =3D __folio_alloc_node(GFP_KERNEL, 0, node);
> > > +	/* __folio_alloc_node() rejects NUMA_NO_NODE; let it pick for us */
> > > +	rqstp->rq_scratch_folio =3D
> > > +		__folio_alloc_node(GFP_KERNEL, 0,
> > > +				   node =3D=3D NUMA_NO_NODE ? numa_mem_id() : node);
> > >  	if (!rqstp->rq_scratch_folio)
> > >  		goto out_enomem;
> > > =20
> > > @@ -864,7 +707,15 @@ int svc_new_thread(struct svc_serv *serv, struct s=
vc_pool *pool)
> > >  	int node;
> > >  	int err =3D 0;
> > > =20
> > > -	node =3D svc_pool_map_get_node(pool->sp_id);
> > > +	/*
> > > +	 * Only pooled services hold a reference to the pool map, so only they
> > > +	 * may consult it. Unpooled services (e.g. lockd, the NFS callback)
> > > +	 * leave placement to the allocator.
> > > +	 */
> > > +	if (serv->sv_is_pooled)
> > > +		node =3D svc_pool_map_get_node(pool->sp_id);
> > > +	else
> > > +		node =3D NUMA_NO_NODE;
> > > =20
> > >  	rqstp =3D svc_prepare_thread(serv, pool, node);
> > >  	if (!rqstp)
> > >=20
> >=20
> > I think this patch is good, but there is probably room for further
> > simplification which is probably best left to a later patch.
> > In particular, ->sv_nrpools is now either '1' or svc_pool_map.count,
> > and these possibilities match ->sv_is_pooled.  So we only need one of
> > those.
> > I think removing ->sv_nrpools and only using ->sv_is_pooled would
> > simplify/clarify some of the code.
> >
> > Reviewed-by: NeilBrown <neil@brown.name>
>=20
> Thanks. I took a look at that cleanup, but it's not quite the same.
>=20
>   - unpooled service (lockd, NFS callback): sv_is_pooled=3Dfalse, sv_nrpool=
s=3D1
>   - pooled service on a single-node host: sv_is_pooled=3Dtrue, sv_nrpools=
=3D1 (pernode degenerates to one pool)
>   - pooled service on multi-node: sv_is_pooled=3Dtrue, sv_nrpools=3DN>1
>=20
> So you can't derive sv_is_pooled from sv_nrpools because of the
> single-node case.

Agree.  We have to keep sv_is_pooled (it implies a reference to
svc_pool_map).  I'm not convinced that we need sv_nrpools.

>=20
> Worse, it also means that we'd have to create more accessors for the
> svc_pool_map. There are several places that access sv_nrpools that
> would have to be converted to get it from the map. That may have
> performance implications too since the map is accessed during receives.

svc_pool_map is a single global that is read-mostly, so no dereference,
easy to predict.
During receive we need to access svc_pool_map anyway to map CPU to POOL.
So the svc_pool_map.npools will have to be pulled into cache anyway.

But if you don't like it, I won't push it on you.

Thanks,
NeilBrown


>=20
> So this kind of cleanup is doable, but it's a bit messier than it
> sounds at first.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


