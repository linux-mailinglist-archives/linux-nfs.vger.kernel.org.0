Return-Path: <linux-nfs+bounces-22848-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k1G0AYDgPWry7QgAu9opvQ
	(envelope-from <linux-nfs+bounces-22848-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:14:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBA6C9B3E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 04:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=OSNWbzEP;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="D HqT0po";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22848-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22848-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08C293006146
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2026 02:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792EC2F12AC;
	Fri, 26 Jun 2026 02:14:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77518184;
	Fri, 26 Jun 2026 02:14:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440061; cv=none; b=baIegQk5/MIAB7QPsTDbeU9sKagtMbINs/gBxoKxomCqdfzrqMQotBvcwAACcbWk8Xwodt4W9HU2XdEBg0iGoZaE03ValygBPRnErBcHgZX+MoqCnxvjxK2cgAkxrUkddR8l/isxTmFGnNcBRDATSosQ1dbipQllNy/fHIaeBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440061; c=relaxed/simple;
	bh=3uTR/6Fn3+pzjADz5C5sAMnZ38vbVRBPNAvCxc1PZfI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Fl3li3aHqYAIOSnW9EqBj0ezL2b9K487xpm/wT+zOgTwUrOXnnc1m52xYJqx7MKXRS+jwUOGLyErd5Z68wv6fxk4o4WyePqzr5VZ4nlwCr5ove3xG0xlak7yC/W2OiaEVqyM3C9GXIoB+Lgzwf9SQO7dvrgeMloApg3Hvx9iB8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OSNWbzEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHqT0pog; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 937BD7A0082;
	Thu, 25 Jun 2026 22:14:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 25 Jun 2026 22:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782440058; x=1782526458; bh=yt0Gdotyc4GLJFGd5hvNhQDoJ3vyt6Uq8X+
	0vmRJmQc=; b=OSNWbzEPNH2w7FEN9Z0ZY9l5E7SbUPAA9Qk+oe6oJAwHilcvgSi
	MARz4EpDgsDJbZBPrxNa6fbQE9/Sd61+wRwPqB1OBOTl1OJqgfII3IcRHzqMBdUa
	J5Mpqh28uwYvsgKhNDotbW5f/LG4dZoKegC/cTAOYSwztoGGd7dKmwIr0y5sJVhX
	Hjlwq5Sn5Cz9lUY5kUMl90yUxAt9EXNsHoeqY4qYU2TOB0ujb0ThGixPO71sv05I
	rcEMM6V5DrdhzXmnOBQWz61NMFIC1jG7KRLkwr/euZXzpS4Obv/0dj9UqTaT01e4
	0cm5jZoiqOTBv0epGJjZNtePJKtFd0mCq+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782440058; x=
	1782526458; bh=yt0Gdotyc4GLJFGd5hvNhQDoJ3vyt6Uq8X+0vmRJmQc=; b=D
	HqT0pogbzzIx+nPdzFzdSV423zowWdmwLYJ4WEIqC3x3PNy0eF+ikgjo1JyE3+ku
	0l7+MW2Vi/t2zlhsy/gSde5rqmtrsk9o8PXhj7SCwcoUnMUy7RkmIO4u1LVi6gXD
	jCQ2Bslfoq8Lng/8Q/bz0BrSTTYFWP4D9nRpX+j4p8pkCAmG7fv7PSgno2o4v9Tf
	Gq1dXLYirlaC+LEW/BV+rGxuTZ+pd2IPYbvhQ7tlEqAgH3Zotn6u8GHuSkK+JOlh
	uZ2pOQxNQ+aniDTsyphTRqFA+B4uTi4qpfr8qJsSr2fusHefmdQvl3iOzac6jN9/
	yNfJTt9NN2Q9cS8J90uIw==
X-ME-Sender: <xms:euA9anq3k_HtIFkSE4zhnG2EDmJPTQnOwS2gv1OAXEEaf27nL01Cig>
    <xme:euA9amlwwZDP__RQc2hDm32miDgUeoZLyVNKacpRUkmwDZcs-2a19554UvZSWxHc3
    KF3KAzXhxxgnUrhTqQVlO_GDKliZfkW-4OIELxgc7qmKOk2zg>
X-ME-Received: <xmr:euA9aodip50yK0C0FmJQLQNP2O1dQE0TLKw_0s9kq1UuEqqKlLQ3yAFpJ6XBVpZixH8Tuk8v8sXNAgaGAS_Q09juCPkyZGQ>
X-ME-Proxy-Cause: dmFkZTEXHzzYU9OAuBaVEDiTd6JRr1QOl2Up+tgpJej8Wf8MoL5kxC51L03aHY31sitzth
    F6hu/uqiDCtiCahwkC+bm/Yfo090c0YFStu2DfaOyUuD35dIUYGbXhOnUlj6dMlEF0pZXA
    L+6bxnAQD9E9ZWVzb4yjIaBfdVP3oLPyU2yk+Fpzgdp6YKkLhMUYBA6xz7URvsZuHZDFcw
    7RSE0XNu8DsnNCQalrdv2CMZERRO4a0Gmx0cWQ7698QlY+mmdWmA189wIje/BAlOMcOolf
    FshWMnaq6QjKSMWfO33eHCxSc7JD0kp5mk8iCaxW9x/H1xAoDDIbBJ15xZSvyTsgO7osOD
    5mq8c6UmofOn7+mfLscYdkinuqt2VRtvY3lB9iA5uV1Y933fxjHZs5PwF4lFHkmOfvmQYG
    XqbyQfiQsYpt4hQc0Tf4MxYxPWTjtMXnCveIA7EhLXGJi8+PRbJsSoXhHbtmkIn9Jwbl3T
    IuEX1jzxrZGH/eQnSrnLZUKPoPo6NzI61N2YHQGxSDAyiPsIK8hsCGz6Ld9XErGBM61dy1
    tN0T4ojnXohw/Rh8xqlwWKH6IOtdqlD+2rn+4tlh59AVccXnfCQWZBcRWL8LHnsmV7wgSv
    PHi4g3dtPqrzBHGqI42yPF4Ap5Ix/QfoakXu1qTn8u1GdASfL/sbpgpqd4SQ
X-ME-Proxy: <xmx:euA9aqrz33orB0-zabtiw0uJayJWS8Sw2pC8-ZhTx_gu5WBOkDtRbg>
    <xmx:euA9aqN3BFzXV-Hp2_u3zPmZtuhiaaKfnmeTrgwdPYQKzvpozaJ_CA>
    <xmx:euA9alhJc027-OHoF35YzA0M1hhE13-4UUUTMNvOzhbPvLvDz__RzA>
    <xmx:euA9aluDwe48MKK_yCS7SIdbbzQq_MmRibozWzVCVLviOW-53_bsZw>
    <xmx:euA9arLZ9O6zAI6gMnPNuIg6sdI0WK_AMHGP4sqVxVXAzItVQPPQacG->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 22:14:15 -0400 (EDT)
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
 Re: [PATCH v2] sunrpc: hardcode pool_mode to pernode, remove other modes
In-reply-to: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
References: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
Date: Fri, 26 Jun 2026 12:14:11 +1000
Message-id: <178244005168.27465.2587255049421564152@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22848-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim,brown.name:replyto,ownmail.net:dkim,ownmail.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92DBA6C9B3E

On Fri, 26 Jun 2026, Jeff Layton wrote:
> The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> was added when NUMA was new and the right default was unclear.  Today,
> pernode is the right choice everywhere:
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
> Remove the SVC_POOL_* enum, mode selection heuristic,
> svc_pool_map_init_percpu(), and all mode-based switch statements.
> Simplify pool map functions to always use the pernode path.  If pool
> map allocation fails, svc_pool_map_get() now returns 0 and service
> creation fails, rather than silently falling back to a single global
> pool.
>=20
> The module parameter and netlink interfaces are preserved for backward
> compatibility:
> - Writing any previously-accepted value succeeds silently
> - Reading always returns "pernode"
> - Writing to the module parameter emits a deprecation notice
>=20
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This version is essentially the same as v1, but allows the kernel to
> accept any previously-accepted setting for pool-mode, which should
> alleviate concerns about breakage.
> ---
> Changes in v2:
> - Accept any previously-accepted setting for pool_mode
> - Link to v1: https://lore.kernel.org/r/20260423-sunrpc-pool-mode-v1-1-b7f2=
0e35749b@kernel.org
> ---
>  net/sunrpc/svc.c | 238 +++++++++------------------------------------------=
----
>  1 file changed, 37 insertions(+), 201 deletions(-)
>=20
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index dd80a2eaaa74..6e3d509bf95a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -38,19 +38,6 @@
> =20
>  static void svc_unregister(const struct svc_serv *serv, struct net *net);
> =20
> -#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
> -
> -/*
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
>  /*
>   * Structure for mapping cpus to pools and vice versa.
>   * Setup once during sunrpc initialisation.
> @@ -58,62 +45,23 @@ enum {
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
> -
>  int sunrpc_set_pool_mode(const char *val)
>  {
> -	return __param_set_pool_mode(val, &svc_pool_map);
> +	if (!strncmp(val, "auto", 4) ||
> +	    !strncmp(val, "global", 6) ||
> +	    !strncmp(val, "percpu", 6) ||
> +	    !strncmp(val, "pernode", 7))
> +		return 0;

"!strncmp" is one most disliked constructs....
What would you think of using match_string() or even
sysfs_match_string() ??

> +	return -EINVAL;
>  }
>  EXPORT_SYMBOL(sunrpc_set_pool_mode);
> =20
> @@ -122,84 +70,32 @@ EXPORT_SYMBOL(sunrpc_set_pool_mode);
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
> +	pr_notice("sunrpc: the pool_mode parameter is deprecated and will be remo=
ved in a future release.\n");

Which future release?  How will we remember?

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
> @@ -224,35 +120,7 @@ svc_pool_map_alloc_arrays(struct svc_pool_map *m, unsi=
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
> @@ -284,14 +152,13 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
>   * Add a reference to the global map of cpus to pools (and
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
> @@ -299,22 +166,11 @@ svc_pool_map_get(void)
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
> +		m->count--;

Could we make this
   m->count =3D 0

to make it crystal clear that there are now no references?
It would be nice to rename ->count to ->refcount or similar
so it is obvious what is being counted, but that doesn't need to be part
of this change.

> +		mutex_unlock(&svc_pool_map_mutex);
> +		return 0;
>  	}
>  	m->npools =3D npools;
>  	mutex_unlock(&svc_pool_map_mutex);
> @@ -346,14 +202,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
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

Can this code run if m->count is zero?

>  }
> +
>  /*
>   * Set the given thread's cpus_allowed mask so that it
>   * will only run on cpus in the given pool.
> @@ -372,27 +225,15 @@ svc_pool_map_set_cpumask(struct task_struct *task, un=
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
> @@ -400,20 +241,12 @@ svc_pool_map_set_cpumask(struct task_struct *task, un=
signed int pidx)
>  struct svc_pool *svc_pool_for_cpu(struct svc_serv *serv)
>  {
>  	struct svc_pool_map *m =3D &svc_pool_map;
> -	int cpu =3D raw_smp_processor_id();
> -	unsigned int pidx =3D 0;
> +	unsigned int pidx;
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
> +	pidx =3D m->to_pool[cpu_to_node(raw_smp_processor_id())];
> =20
>  	return &serv->sv_pools[pidx % serv->sv_nrpools];
>  }
> @@ -617,6 +450,9 @@ struct svc_serv *svc_create_pooled(struct svc_program *=
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
>=20

I think this is a good a worthwhile change.
Regarding Chucks comments, I think a minimum of one thread per node,
rather than a minimum of one thread total, is the sensible approach.
Of course if there exist memory-only nodes, they wouldn't need a thread.

Thanks,
NeilBrown

