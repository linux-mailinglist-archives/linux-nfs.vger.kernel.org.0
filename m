Return-Path: <linux-nfs+bounces-22964-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ltrRGDUwR2pkUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-22964-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:44:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3A6FE418
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 05:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=crxxZDA+;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="B HOOKCt";
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22964-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22964-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF44301AF5E
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 03:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6155318146;
	Fri,  3 Jul 2026 03:43:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133A5266EE9;
	Fri,  3 Jul 2026 03:42:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783050183; cv=none; b=K3aXW/6dBI9LhQicEzQKEnSr16B5YWb/Z1CK0JC0cIEx90JMLRIiT3q9fbqPOkC5V8/lV3IyDtVRSVvg1HwF8ZX0k679JMfZnzC4qgN67ftlWWo9jluDYVjz9RVAvNCVyedw6JiKOKgOynmRZVMRXDBvDHyR7p2vLLoje9O1ZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783050183; c=relaxed/simple;
	bh=hLP/JvvMNwlYcx1UhqreRxpmnLcXS11wgb4lsJw+aOI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QFDQC3XGSaInlNEYm9PB5VrVAHGeeg8sdjeddwyU4D4xuPVGjirmDeexjRK97+wonP0PIIGsw9+lFy/7tfZFxv4iwDWl6kTzamCtoFQw8iEPdz3b5xm8dy5UKV+LEm5Ir/5QZzEJ7o/U61tsyu0nzR+Cz8Ia9GvyHb7shk6744w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=crxxZDA+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BHOOKCtl; arc=none smtp.client-ip=103.168.172.155
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CC281400071;
	Thu,  2 Jul 2026 23:42:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 23:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783050173; x=1783136573; bh=dVMklWEvZlc9VgTiGP9e4b0XY9DEyVXj+lt
	4lAONHV0=; b=crxxZDA+qxrNsXhatpBqAe7J0KErueLKA3jHqUcq+Jp4VzZ4rsN
	IQYyea7dLaYDnmoi2O3LqmawbIjdAstVr53VsbyeOlQRszoG1YFlgLxOfnCj/Huu
	8/HJrcj0OGGesVyQuZ0UucXy04Pg8aSM4iEXy4e8Zxhv2PZAtjzq3Iw+fizbzqRd
	mgdBdaSg1PFYjjLf+gHgzVBB+EueQWncpdbyafB/915duHU5TogLz27Yzz7DCf9w
	dTE0UUV8u8hZdwe6b410uK2pjF4JO6z0rtv774o5zLrt/GUfYaErnPxv1cot6kuX
	zzenITsgIHgppREd8RNLPJ+7Q72a4tLbJDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783050173; x=
	1783136573; bh=dVMklWEvZlc9VgTiGP9e4b0XY9DEyVXj+lt4lAONHV0=; b=B
	HOOKCtlRolpPJM6yVMEDy+CmLiG7M+dP4abxbH/a6DHzRvFhcc7eVEmS5ClslP4y
	SmDKtO+JvrRHD+UNxSiAL0vGd73bz9QNq6vxiqQfw89CdojeKF4pW8Nxdqiouf+B
	/po8D3F0ejJe/92/5FIJua11LaTE/+lYnW8CqZV+pYWSFiOOFRm5MocvMyCwUfDv
	3ATLqoa52R0B3Rw0eLCaKSJVpgnxiHRY2FhU54l5uywI/yWj+rpzV/Y3CzbHBviS
	WW+K45y/GaZYJ/b3QYwY8C8pr4FJAgsoT/yGfmEMg0oqxXwGGE86XCc2z+HMnho3
	gEganWj2aOhS9H+0HRYTw==
X-ME-Sender: <xms:vS9HamblCWLO2ell7_tFsBZW-ux22ai4owIJxFQnwe7RDjRYWqDuoA>
    <xme:vS9HauUF5Z2mlEryXcRbnOi6zcQTgXCUjEn4cZVB5rvEYCjWpjz7PpFa4CxF9s5oS
    iW5DrCkDvbjoNrZKh6_hEuR91iT9wRS7c3fx6ZZCLpJc7E>
X-ME-Received: <xmr:vS9HalNwa4Sq_5q9dDFW6dL-t1rf0TdEX1lVpqTMVgT6gr6s6z2SS8dne8ygo9jTRN7Z7naR014y-6FutJtUaa8HVMrT18A>
X-ME-Proxy-Cause: dmFkZTGo/kk7lJxMABpcjZ2O02+BLekeUxmecIPsUWV44Y4VTXEzWykJyeOV7dujOrCTP3
    j2P9uG7T4LU6EyEup4qIy31+iZwXc3I8oLtgfn2rlgIRt1sRHKz242OSwKb9NgYGY5qlP6
    9AALPa71yVYZOVj4ACVIEC2tiPj4dkk+wgHrj9fFC2xcfMMoD0FIgleESfQoKkIBmGer+Z
    C7C86CltWWq6kwsj5OT7qXuUeQ9iXgZ3bXy4Acj2ji8rFvoroUZIWx8zQi86helqxrMZga
    rldR330xWQbq7b0ZAhio2twvUjYgFQOIxh/ocrhx1KUM+GEooVI4dCJGY8bSSR+D72Zwgy
    UBSIq/dtwBiqOTbbpsinHMYAGG2biCrA2LuCRfG9ba5lKZuxHFj+NrbeJFXIPzqTgWzGvn
    oUCZFyDTzsYdU7/+lkEeIN5fjU5KrakDuMO1fBbxAzrMnDzKQgz+6UtFCPK5Ph8PJvR6op
    IMw+MNNeOjdYaB4xbRvgHk9mhPuT80ePsYfW4WPUJ0kAXDRVoY4uxybGel4The8VTQ7iI+
    4HbYLL3B1f+BOlqwNzuM5sjc/ccCjjrhjIdKHqT6JMM4bL2IX0HwSp+sw3RiTymfElVDEg
    EVuncr5Iw1DLR6NdEYLdgkU+yfNmJrQYPj80pzpByhmMXZmy0H5CNFRIoyPg
X-ME-Proxy: <xmx:vS9HaoYbz4Bls-O1HGtF-y7vSP2VWLQ7uF3gl5kt7KhyEejD3tjLGw>
    <xmx:vS9Hak8YeEceLF6oJP-JTfNEiiZ-DthM0S2MqzMnmvXQBzE15lZCYg>
    <xmx:vS9HapQ6mbYzPfJIc_gB4L9qsVfRGHzhrJIkEppQJ0yH0NP_DBfepw>
    <xmx:vS9Hauch9TW2edgWuCcAb6zsSJFrS3S1ydKORN6nggLL2yBnPN1XDg>
    <xmx:vS9Hao7sFb9Na7SHft-ksFNNE90XCsXsr4DtSDrsk8gFVYksfIqcaC9F>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 23:42:50 -0400 (EDT)
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
 Re: [PATCH v4 1/4] sunrpc: route to a populated pool in svc_pool_for_cpu()
In-reply-to: <5f5ef0bb961dc0bdd34383d368261aac50509d82.camel@kernel.org>
References: <20260701-sunrpc-pool-mode-v4-0-b3d867e4c8f9@kernel.org>
  <20260701-sunrpc-pool-mode-v4-1-b3d867e4c8f9@kernel.org>
  <178294402742.27465.8893159356805540635@noble.neil.brown.name>
  <ccfad59a086674ef8612d32f72a23c5401a3eacb.camel@kernel.org>
  <5f5ef0bb961dc0bdd34383d368261aac50509d82.camel@kernel.org>
Date: Fri, 03 Jul 2026 13:42:46 +1000
Message-id: <178305016681.27465.3325737287555850173@noble.neil.brown.name>
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
	TAGGED_FROM(0.00)[bounces-22964-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: AEE3A6FE418

On Thu, 02 Jul 2026, Jeff Layton wrote:
> On Thu, 2026-07-02 at 08:17 -0400, Jeff Layton wrote:
> > On Thu, 2026-07-02 at 08:13 +1000, NeilBrown wrote:
> > > On Thu, 02 Jul 2026, Jeff Layton wrote:
> > > > svc_set_num_threads() spreads the requested threads evenly across the
> > > > service's pools (base =3D nrservs / sv_nrpools).  When a service runs
> > > > fewer threads than it has pools -- e.g. an nfsd configured with fewer
> > > > threads than the host has NUMA nodes while running in "pernode" or
> > > > "percpu" mode -- the trailing pools are left with no threads at all.
> > > >=20
> > > > svc_xprt_enqueue() selects a pool from the CPU servicing the transpor=
t,
> > > > queues the transport on that pool's sp_xprts, and only wakes a thread
> > > > from the same pool.  Each thread services exclusively its own pool, s=
o a
> > > > transport that lands on a threadless pool is enqueued on sp_xprts and
> > > > never picked up: the connection hangs indefinitely.
> > > >=20
> > > > Have svc_pool_for_cpu() skip pools that currently have no threads,
> > > > falling back to the next populated pool.  This trades NUMA locality f=
or
> > > > a guarantee that the work is actually serviced.  sp_nrthreads is only
> > > > updated under the service mutex; the lockless read here is a best-eff=
ort
> > > > routing hint, so annotate it with data_race().
> > > >=20
> > > > Fixes: 0f0257eaa5d2 ("svc: Move the xprt independent code to the svc_=
xprt.c file")
> > >=20
> > > Why that commit?  Did this ever work correctly?
> > > It seems more likely that=20
> > > Fixes: 3262c816a3d7 ("[PATCH] knfsd: split svc_serv into pools")
> > > is appropriate.
> > >=20
> >=20
> > Indeed. Good catch.
> >=20
>=20
> I had the LLM run this down. We're both wrong.
>=20
> It briefly worked properly after 3262c816a3d7 ("split svc_serv into
> pools"), but then was broken in the same series in commit bfd241600a3b
> ("knfsd: make rpc threads pools numa aware"). So I think we want:
>=20
> Fixes: bfd241600a3b ("knfsd: make rpc threads pools numa aware")

That is certainly credible - thanks.

>=20
>=20
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  net/sunrpc/svc.c | 26 +++++++++++++++++++++++++-
> > > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > > > index dd80a2eaaa74..82fb7faf563f 100644
> > > > --- a/net/sunrpc/svc.c
> > > > +++ b/net/sunrpc/svc.c
> > > > @@ -402,6 +402,7 @@ struct svc_pool *svc_pool_for_cpu(struct svc_serv=
 *serv)
> > > >  	struct svc_pool_map *m =3D &svc_pool_map;
> > > >  	int cpu =3D raw_smp_processor_id();
> > > >  	unsigned int pidx =3D 0;
> > > > +	unsigned int i;
> > > > =20
> > > >  	if (serv->sv_nrpools <=3D 1)
> > > >  		return serv->sv_pools;
> > > > @@ -414,8 +415,31 @@ struct svc_pool *svc_pool_for_cpu(struct svc_ser=
v *serv)
> > > >  		pidx =3D m->to_pool[cpu_to_node(cpu)];
> > > >  		break;
> > > >  	}
> > > > +	pidx %=3D serv->sv_nrpools;
> > > > +
> > > > +	/*
> > > > +	 * Threads are spread evenly across the pools, but when there are
> > > > +	 * fewer threads than pools some pools can end up with none. A
> > > > +	 * transport enqueued on a threadless pool would never be picked
> > > > +	 * up, since each thread only services its own pool. Fall back to
> > > > +	 * the next populated pool, trading NUMA locality for a guarantee
> > > > +	 * that the transport is serviced.
> > > > +	 */
> > > > +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> > > > +		struct svc_pool *pool =3D &serv->sv_pools[pidx];
> > > > +
> > > > +		/* This is set under the sp_mutex and rarely ever changes. A
> > > > +		 * data race here is harmless.
> > > > +		 */
> > > > +		if (data_race(pool->sp_nrthreads))
> > > > +			return pool;
> > > > +
> > > > +		if (++pidx >=3D serv->sv_nrpools)
> > > > +			pidx =3D 0;
> > > > +	}
> > > > =20
> > > > -	return &serv->sv_pools[pidx % serv->sv_nrpools];
> > > > +	/* No pool has any threads; nothing can service the transport. */
> > >=20
> > > Would a WARN_ON_ONCE() be appropriate here?
> > >=20
> >=20
> > Maybe a pr_notice_once()? A stack trace isn't particularly helpful
> > here, but it would be good to let someone know that this isn't
> > optimally configured. I'll add one for v5.
> >=20
> >=20
>=20
> This is probably not feasible, as there are cases where we legitimately
> queue the call to a pool with no threads.
>=20
> At startup, we create listeners and then threads only get spun up
> later. If we get a RPC on the listener port during that window, the
> message would fire. There's a similar window on shutdown.
>=20
> It might not hurt to add a tracepoint there though.

and a comment explaining when this might happen?

The start-up window makes sense - as long as we start a thread on each
pool it should be safe.  But if we don't (if the admin request zero on
some pools) we can still get stuck.  Is there something simple we can do
about that, or does the admin get to keep both halves?

And on shutdown the threads stop before the sockets are cleaned up - but
they do get cleaned up, so all good.

Thanks,
NeilBrown


>=20
> > > I think this is a sensible defensive-programming approach.
> > >=20
> > > Reviewed-by: NeilBrown <neil@brown.name>
> > >=20
> >=20
> > Thanks!
> >=20
> > > > +	return &serv->sv_pools[pidx];
> > > >  }
> > > > =20
> > > >  static int svc_rpcb_setup(struct svc_serv *serv, struct net *net)
> > > >=20
> > > > --=20
> > > > 2.54.0
> > > >=20
> > > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


