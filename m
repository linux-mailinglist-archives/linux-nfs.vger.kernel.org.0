Return-Path: <linux-nfs+bounces-22844-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YACKE2CCPWof3wgAu9opvQ
	(envelope-from <linux-nfs+bounces-22844-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 21:32:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 648806C85DB
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 21:32:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ncwdqUvG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22844-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22844-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D763035AB1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8638B2F7EF5;
	Thu, 25 Jun 2026 19:32:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A532D77F5
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 19:32:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782415965; cv=none; b=GB/y72csIiIwA89VREnW1vTsJPATExjl8K0vvYmweu0sQpDJ0C1Crji+vRaVOAOI3hbNLc1TmzIWIIhMFDEAquKVBSg9iYKHc9HqVZQagbDaPJoJ5pNTCV+7wyqBajk4UVWGOUMI7ZUHIVA+swci5Rdsony2nrL2zx/+45jo+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782415965; c=relaxed/simple;
	bh=TPtzp0jnzJodeHRwKQDZj4cMHooabhPlZGZ0bpRKwXo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MW6ycOpwQGelSHABEMiDgsB0LS6V3O/sjibIt1e+aP+R2QeYwmRGJ3Gyl3upm8OUqOHhrjNd4UdEzNJW3+6pzm2e6qC2HnP2NRBsGJ3nV5Hh/6MbwrpQACmmy5vvMcWVOTGO2r7wBcUA44qBQ+lBbHplu176ndG5Pb7TSYihTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncwdqUvG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0401F1F00A3D;
	Thu, 25 Jun 2026 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782415964;
	bh=z+d3Rqr8TBl9aAE0AJeZRoccjpGJQ0DyfdaCOK1gNBw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ncwdqUvGYllfSkYRna3EUnIkEGJoxpSiURwC31lR681t6hJKF03fWYjmCwm0RXRd9
	 r/8mrlRugDXm/ITkx3ZMQCccQAP3o3EHliuGQ5t3RgitVLeipyA4HCKL2+ZYi67ZYc
	 pa/CF2G8h+vwpzlbepSMPEuOU+lVSFDA/EalD7uJglg51yUqZvlFpRI2aGIQe0ep9b
	 LjbJeYpmt4gIGERLV1PHVvtpJjj1GHMd+BPWYq7p6a8GRF+mhpg0AH20rZ2hQsU4sL
	 CTH176yvVYiRdD2qEKKzZFg8zWfjCaC7VWc/+jzdWSWQMw9IcOgiZrlc86OntSi2f4
	 bSdc0TtYl6uRA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 144B0F40087;
	Thu, 25 Jun 2026 15:32:43 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 15:32:43 -0400
X-ME-Sender: <xms:WoI9apkxqZi4zsxZgNxejZRkYLGR2EAr9sXNOZ-lOKvrsEyymaAMZQ>
    <xme:WoI9avpnNEXesPpelAkz_f9lfBip89UD9OSpiIJ9VctsW_OvBbpZTrbhRQzPls0uD
    7Ka6jc2lYqSqfsaiuy9Q6b7ZN-4C275g6mFVW0-rwmnAzkRJ55tfQ>
X-ME-Proxy-Cause: dmFkZTGRs0JqEpM6dUaP9y5sujc7/m0DhbnMZl5pb6S6ZyFeWp4P6yWAU2y6Hvx9PaHARy
    MXXM0e1HLYqXkNsatA9hfxg1stRh25P4WB+2x6SdkLHf5iBJZtwyKc3Bb0jOGARzeeFEbJ
    JOPLXmp3oStx59FVs8Scld8d6aaVCl+0SeWqHYy2dbyJjGdNjlGQAU3Qa1+tAnh29rkP8n
    h6zkjeEKhfK2nmSy+VU8PoM4UR8+QotbYOUGwCtKNh+WgSfvSCbaZFMw3psVbj2/SCQygb
    xMJ/MnhkS14W00ARQP0XtplIHjT5jwof/vbwwbSNw2jtVODw/4q67fyyq2E9P/HNtC2PUS
    kn/Dxudc30kfz39e2Dv1SAVD9LC4S/1krseHkVz+5C1t7rkYCIbYthAa3vpNxmdp7/nVAH
    9arKTWuCQb3t7wpYh9Pe0WoYYVvSlrNBtGA/KMr/Eujq9VKnb3YJx9W5yLtYIUU+pD133y
    WthWKaM/W6Lrdph/pYg+8InsPESFtIZE3xqeWfyLrFZ8y0oaCpNK20jYgZQ4BJoPFjRj4J
    sETZZJwtQuofM0vZmDdLqSKsNRj1VYPilB46c2Ptntw7VZMAJKDBLFYB44tgYBiAzIePci
    LCyLh74mCx+51e/TssOalgLLuvhB1piKAnO3WQFw14IN0T6VQUZ0m+W2k6cQ
X-ME-Proxy: <xmx:W4I9ah1Sq8mnR3g6kx0_83k9rXtdMXSmj9Vhzz0ZXkCqeQ99zb8bJQ>
    <xmx:W4I9aoi6FbQRwxmIVnM9wrKjrICDrvahcC0DTu8FpGm4Pldp32DL3w>
    <xmx:W4I9aimYPeEsT8ebFmD3lj-hHDb8uBSMsMMnlJ2Q52vlAdeLv_lRXQ>
    <xmx:W4I9amaGhokljLVVf5nGirOvssQ2ZjFTgcHOYH76MeIouXMDAXVAqQ>
    <xmx:W4I9alEWtTjlCrdHpYzgNG_f-DSzboYCmSjoRwQUPj0gSQw_ox3ajPwj>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E4E1C780ABD; Thu, 25 Jun 2026 15:32:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWid7F4iEUkZ
Date: Thu, 25 Jun 2026 15:32:22 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <d50169fe-8deb-481b-83f4-a082af190ca4@app.fastmail.com>
In-Reply-To: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
References: <20260625-sunrpc-pool-mode-v2-1-4f512b6e1ee8@kernel.org>
Subject: Re: [PATCH v2] sunrpc: hardcode pool_mode to pernode, remove other modes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22844-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 648806C85DB



On Thu, Jun 25, 2026, at 11:59 AM, Jeff Layton wrote:
> The SVC_POOL_AUTO/GLOBAL/PERCPU/PERNODE pool mode selection machinery
> was added when NUMA was new and the right default was unclear.  Today,
> pernode is the right choice everywhere:

> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index dd80a2eaaa74..6e3d509bf95a 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -38,19 +38,6 @@
> 
>  static void svc_unregister(const struct svc_serv *serv, struct net *net);
> 
> -#define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
> -
> -/*
> - * Mode for mapping cpus to pools.
> - */
> -enum {
> -	SVC_POOL_AUTO = -1,	/* choose one of the others */
> -	SVC_POOL_GLOBAL,	/* no mapping, just a single global pool
> -				 * (legacy & UP mode) */
> -	SVC_POOL_PERCPU,	/* one pool per cpu */
> -	SVC_POOL_PERNODE	/* one pool per numa node */
> -};
> -
>  /*
>   * Structure for mapping cpus to pools and vice versa.
>   * Setup once during sunrpc initialisation.

The commit message should call out the change in the default setting.


> @@ -299,22 +166,11 @@ svc_pool_map_get(void)
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

With one pool per node now mandatory, can a server end up with pools
that have no threads?  svc_set_num_threads() spreads nrservs evenly
across the pools:

net/sunrpc/svc.c:svc_set_num_threads() {
	unsigned int base = nrservs / serv->sv_nrpools;
	unsigned int remain = nrservs % serv->sv_nrpools;
	...
}

so when nrservs is smaller than the number of NUMA nodes with CPUs,
base is 0 and the trailing pools get zero threads.

Work is still routed to the per-node pool selected from the running
CPU:

net/sunrpc/svc_xprt.c:svc_xprt_enqueue() {
	pool = svc_pool_for_cpu(xprt->xpt_server);
	...
	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
	svc_pool_wake_idle_thread(pool);
}

and svc_pool_wake_idle_thread() only consults that one pool's idle
list, with no fallback to a sibling pool.  If a connection lands on a
node whose pool has no threads, does its transport sit on sp_xprts and
never get serviced?

The old global default kept a single pool, so this configuration could
not arise without an explicit pernode/percpu selection.  With global
mode removed, is there a way left for an admin to avoid empty pools on
a server that runs fewer threads than it has NUMA nodes, or should the
thread distribution or the enqueue path guarantee work only reaches a
populated pool?

Separately, the pool_mode knob is preserved but every accepted value
now behaves as pernode.  Documentation/admin-guide/kernel-parameters.txt
still presents the four modes as distinct:

	auto	    the server chooses an appropriate mode
		    automatically using heuristics
	global	    a single global pool contains all CPUs
	percpu	    one pool for each CPU
	pernode	    one pool for each NUMA node (equivalent
		    to global on non-NUMA machines)

and states the option "will affect which CPUs will do NFS serving."
The patch should update this documentation.


-- 
Chuck Lever

