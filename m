Return-Path: <linux-nfs+bounces-22894-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DKiVGJr9Q2rTmwoAu9opvQ
	(envelope-from <linux-nfs+bounces-22894-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 19:32:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E476E6EBA
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 19:32:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Zd6L2h/k";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22894-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22894-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55AB93090B9D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jun 2026 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8DC3DC4D3;
	Tue, 30 Jun 2026 17:25:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ABA3DC4BC
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jun 2026 17:25:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840308; cv=none; b=B0KQmUZ2G9Hx9rnGQvtKDKAWa0bIZxwl/YrJkN/TRZN5RSamQFdn6wV+Y7cN8FFHekQ6i6+4VzdnstRPJS7gIvU1xDjO21BSgaufm1r7ngb0lv80U0/NccpIrfQCYE/RkV6kiTWZZiRoUqN90if35cua1yNB2vHJZvr0z/JPIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840308; c=relaxed/simple;
	bh=7yw2+dO78aavXZOC+i/RPKmqtI4q7IjrSw2RoHbtZlo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Sgpzl6e0ECCZjFi45G7ejVbl3Rr/0Ijmohr+EV/6SOQxWN6YtciNlwkawDN+DFDsiBUTO24LJlgT6Ebki9/D3OFJa0Jkrir/9i8G9HnVDQe+bNV2DoqlLXhmqgyuE9jyxXxh9uACffMYm1FOvvLZesSXm1WZwjJADinMcmg94CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd6L2h/k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E316D1F00A3D;
	Tue, 30 Jun 2026 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782840307;
	bh=tdNkSmpBZRMyQ8rtjsp62LrwsnKfQxOUv+HjLhltlZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Zd6L2h/kiuWn9scKzNhOCggF7xRQTSvoqUF9Xi+hQqVZkZb5lJ1aeM3bUYeBo3SeF
	 4AZfIqrlJFmIA47UyEje9V9yUOPZEzpBnHv+c5hGRvq1pwk4oN/8U/Rx9iGsefB0Di
	 7R0dg5k0MahaOxzslJJeLuoN2tK9V2FVPsYnwtYB5oJqRwt7QZTGC6YJIQuaLIoJnS
	 VWKJL83hZCuz2Q7bfPIonzbwSeYfsWmJnefoAMpkav+9udizOeawkhrOMUd81OXpY7
	 F08ZIrO2XYAjndDExYt9bz4taGBppLnNYy7nWRqoLE7RqXAlMLsLpEtb0al5NbI7P6
	 SucJsD4pe60+A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 015DDF4008C;
	Tue, 30 Jun 2026 13:25:05 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 30 Jun 2026 13:25:06 -0400
X-ME-Sender: <xms:8ftDagehQYEZxNJiGVOvE_0s-rMTtYK2FBlCgMvxkPa_DlDOhmmOFg>
    <xme:8ftDatCtoF_ROTNUESYR62KGTIumDGR8jyGDFZMaTgVziRwPqVj0WdpNx-NLYn6fY
    I-Hr_474ixnvbUboBwsrYWDY7zakf8XHz_6kjoHyuhlAi_7A6JLuLk>
X-ME-Proxy-Cause: dmFkZTEM+w4ofX1fZrAXqxn7jJK4/tq2+rc3Ibm9kW9LvT1U99jybiW+a6jdke/I/UIoe4
    ruXAaLi+SneP+WJkzNiReXtQTN1yoLj2+1x5BwxlxauoSizEw22w1uYRF4i1T390psWoHT
    MYL1OKNb+c6z5+omv+PEeveq9bi3yE179rPv30DV+zcxeaetayeLXqdRUwUi/woVOK4h/+
    kZI3PKbRNCDzXBFeb0A6HwN7cYp71Cw42DPh7KY0fjLXmUCK0xnie7XRr86PQvAi/AB051
    dQLPxkQ7bGGcLXmtqVLJpq4o6cMnJ5w4P3zr9TsgVlKLVzGtwMlwFOl482GF3vtN1sSMFz
    bYkR3nqZuI29hQdLisgpyUsBPh8i4Ta99pgUVZcQTJcN3Ob0lL4i3eA3jq8Zc5MRhuWsnU
    ipm4wBM0XQLQkFGz9qkx9BxtjSKvWtJvuVJfkyUtyjr69IRpRJYUx3HDkm50t9351Mst9p
    lvVg5Tt1Co+5JU7QkwEupzQjw4pkR/YS0K6w49ofcyhI482yn9hfNAQGaHT8Pideq1EHe+
    U5a/TwW5lf+WEX+5HSUMPog45uJ6rVC98y1u+h0s+5ffsLkxDu4DveGsXZqKGrsR+EU54O
    +YV2kkNFs9ZlkvD5Nk/QqhJc++aZYR0Xb7vBIVeCm5EGZ7lzj1RHF6mih6cg
X-ME-Proxy: <xmx:8ftDaqsExns3Xa2xVub4QCvMlct4Wwc_PSsgClbu2Hah2p3pTfSpPQ>
    <xmx:8ftDav5Ux0Q7LMLtRPVZO39hW8bvbMALQhD6g6ywMhPho-pDS26vlw>
    <xmx:8ftDamdgasYobwvgdcWStubuhn-V2yQ3uQSMufZ1fXWBlfD_Xw7JNw>
    <xmx:8ftDasx8p7ZXiDMkvDJsaRIuDuC79qZ46Xedfrjm-WHsZ22w2U-csA>
    <xmx:8ftDar-jJaddGgOVntwYXzggBwnWCi4DXQqXcCaJV9UtlY354Cio0tw1>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA21D780AB5; Tue, 30 Jun 2026 13:25:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A736OQVKTk9g
Date: Tue, 30 Jun 2026 13:24:45 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3f46fdf3-553f-489f-9259-e98e3e1fb9e5@app.fastmail.com>
In-Reply-To: <20260629-sunrpc-pool-mode-v3-2-d92676606dfd@kernel.org>
References: <20260629-sunrpc-pool-mode-v3-0-d92676606dfd@kernel.org>
 <20260629-sunrpc-pool-mode-v3-2-d92676606dfd@kernel.org>
Subject: Re: [PATCH v3 2/4] sunrpc: hardcode pool_mode to pernode, remove other modes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22894-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2E476E6EBA



On Mon, Jun 29, 2026, at 1:48 PM, Jeff Layton wrote:
> The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> was added when NUMA was new and the right default was unclear.  The
> default has always been "global" (a single pool for the whole service);
> the other modes were only used when an admin explicitly set the
> pool_mode parameter or asked for "auto", which then picked a mode from
> the host topology.

> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 82fb7faf563f..2f6938fe28b2 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c

> @@ -58,62 +45,29 @@ enum {
> 
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
> 
> -static struct svc_pool_map svc_pool_map = {
> -	.mode = SVC_POOL_DEFAULT
> -};
> +static struct svc_pool_map svc_pool_map;
> 
>  static DEFINE_MUTEX(svc_pool_map_mutex);/* protects svc_pool_map.count only */
> 
> -static int
> -__param_set_pool_mode(const char *val, struct svc_pool_map *m)
> -{
> -	int err, mode;
> -
> -	mutex_lock(&svc_pool_map_mutex);
> -
> -	err = 0;
> -	if (!strncmp(val, "auto", 4))
> -		mode = SVC_POOL_AUTO;
> -	else if (!strncmp(val, "global", 6))
> -		mode = SVC_POOL_GLOBAL;
> -	else if (!strncmp(val, "percpu", 6))
> -		mode = SVC_POOL_PERCPU;
> -	else if (!strncmp(val, "pernode", 7))
> -		mode = SVC_POOL_PERNODE;
> -	else
> -		err = -EINVAL;
> -
> -	if (err)
> -		goto out;
> -
> -	if (m->count == 0)
> -		m->mode = mode;
> -	else if (mode != m->mode)
> -		err = -EBUSY;
> -out:
> -	mutex_unlock(&svc_pool_map_mutex);
> -	return err;
> -}
> -
> -static int
> -param_set_pool_mode(const char *val, const struct kernel_param *kp)
> -{
> -	struct svc_pool_map *m = kp->arg;
> -
> -	return __param_set_pool_mode(val, m);
> -}
> +/*
> + * Pool modes that were historically accepted. They no longer select
> + * anything: the pool mode is always pernode. The names are retained
> + * only so that writing a previously-valid value still succeeds.
> + */
> +static const char * const pool_mode_names[] = {
> +	"auto", "global", "percpu", "pernode",
> +};
> 
>  int sunrpc_set_pool_mode(const char *val)
>  {
> -	return __param_set_pool_mode(val, &svc_pool_map);
> +	int idx = sysfs_match_string(pool_mode_names, val);
> +
> +	return idx < 0 ? idx : 0;
>  }
>  EXPORT_SYMBOL(sunrpc_set_pool_mode);
> 

sysfs_match_string() compares the whole string, whereas the old
__param_set_pool_mode() matched prefixes (strncmp(val, "global", 6)
and friends). An input like "globalx" that the old code accepted is
now rejected with -EINVAL.

The commit message says:

  Writing any previously-accepted value succeeds silently

The four documented names still succeed, including with a trailing
newline since sysfs_streq() tolerates one, so only prefix-extended
strings change.


> @@ -284,14 +158,13 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
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
>  	struct svc_pool_map *m = &svc_pool_map;
> -	int npools = -1;
> +	int npools;
> 
>  	mutex_lock(&svc_pool_map_mutex);
>  	if (m->count++) {

Regarding the kdoc modification above: with percpu removed the
map is node-to-pool; "cpus to pools" now contradicts the struct
field comments this same patch corrected ("maps pool id to
node" / "maps node to pool id").


> @@ -299,22 +172,11 @@ svc_pool_map_get(void)
>  		return m->npools;
>  	}
> 
> -	if (m->mode == SVC_POOL_AUTO)
> -		m->mode = svc_pool_map_choose_mode();
> -
> -	switch (m->mode) {
> -	case SVC_POOL_PERCPU:
> -		npools = svc_pool_map_init_percpu(m);
> -		break;
> -	case SVC_POOL_PERNODE:
> -		npools = svc_pool_map_init_pernode(m);
> -		break;
> -	}
> -
> +	npools = svc_pool_map_init_pernode(m);
>  	if (npools <= 0) {
> -		/* default, or memory allocation failure */
> -		npools = 1;
> -		m->mode = SVC_POOL_GLOBAL;
> +		m->count = 0;
> +		mutex_unlock(&svc_pool_map_mutex);
> +		return 0;
>  	}
>  	m->npools = npools;
>  	mutex_unlock(&svc_pool_map_mutex);

svc_pool_map_put() frees pool_to[] and sets it back to NULL when the
last pooled reference drops.

Can an unpooled svc_new_thread() running concurrently with an nfsd
start or stop observe m->count != 0 while pool_to is still NULL (the
first get) or already freed (the last put), and dereference it here?
The reads of m->count and m->pool_to are not under the mutex.

The old default global mode returned numa_mem_id() in this case and
never touched pool_to[]; with pernode as the default this path runs
for every server. Would it help to consult pool_to[] only when the
service holds a reference, the way svc_pool_map_set_cpumask() is
already gated in svc_new_thread()?

        if (serv->sv_nrpools > 1)
                svc_pool_map_set_cpumask(task, pool->sp_id);

An unpooled service (sv_nrpools == 1) could then take numa_mem_id()
without reading the shared map.


> @@ -346,14 +208,11 @@ static int svc_pool_map_get_node(unsigned int pidx)
>  {
>  	const struct svc_pool_map *m = &svc_pool_map;
> 
> -	if (m->count) {
> -		if (m->mode == SVC_POOL_PERCPU)
> -			return cpu_to_node(m->pool_to[pidx]);
> -		if (m->mode == SVC_POOL_PERNODE)
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

This path now dereferences pool_to[] whenever m->count is non-zero.

svc_new_thread() calls it for every service, pooled or not, holding
neither svc_pool_map_mutex nor a map reference:

        node = svc_pool_map_get_node(pool->sp_id);

Unpooled services reach this too: lockd and the NFS callback are both
created with svc_create(), which passes npools = 1 and never calls
svc_pool_map_get(), so their m->count is whatever a pooled nfsd has
left set.

svc_pool_map_get() bumps the count before pool_to[] is allocated, and
the whole sequence is serialized only against other map writers:

        mutex_lock(&svc_pool_map_mutex);
        if (m->count++) {
                ...
        }
        npools = svc_pool_map_init_pernode(m);   /* allocates pool_to */


> @@ -372,27 +231,15 @@ svc_pool_map_set_cpumask(struct task_struct 
> *task, unsigned int pidx)
>  	if (m->count == 0)
>  		return;
> 
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

pool_to[pidx] is dereferenced before the m->count == 0 check, so if
count were ever 0 the NULL deref has already happened and the
WARN/return can never fire. The sv_nrpools > 1 gate at the call site
keeps this safe, so the guard is now dead code.

For the series as a whole, let's consider moving 5/4 to the front.
It looks like a fix that might want to be backported.


-- 
Chuck Lever

