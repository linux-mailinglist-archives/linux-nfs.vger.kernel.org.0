Return-Path: <linux-nfs+bounces-11109-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD63A85F69
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EE41899ACE
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3051DDC28;
	Fri, 11 Apr 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrQgxm8U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D731DD0F2;
	Fri, 11 Apr 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378853; cv=none; b=fs3d1hLrudz50Y/xJ/blaFki8YkSVe19ON6PNzmnMv9Tzb4Bx9a6u0R4Ilw4ZjtVqO5MYZQWgm0NcCLtKBLFrVP7cNxT3reYttayZ1WIIRmVYUa6P97m5duw30vwed//V8Kvl9PzuKfVmCTEEbsMU61dPLo5GKxi/qUN3Rtb9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378853; c=relaxed/simple;
	bh=8oVQGbS0YK6Qa4bpO12HG5nfOcXQp+tw39iQr1sq/Yc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CKrHkW905JMtiLuxMeX6qb+EcGXPdv04mWh7c4PPyQhFVJnCEWitF8tvKCUnpViati+rdgo82oOHmeTcYy3vlyfRxH9+ctJHxuZaD5ZSwof5nzK4hUhOWThOYfQq+uy3/9Tyug32MAZ2xWjlUys0YvEVFWFhgbjgbF3e/ng2PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrQgxm8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE5BC4CEE2;
	Fri, 11 Apr 2025 13:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378853;
	bh=8oVQGbS0YK6Qa4bpO12HG5nfOcXQp+tw39iQr1sq/Yc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CrQgxm8UF4qlWRYAYd6aXHkN2QtZzILmT4itI3D3WfF++dFNCZBkpxt9jC/RrN7ZM
	 EFargtOGKIV/9bEnPsobb7WPeJ9aYFWoX3xY4qSDZOr3rCIvc4GApj/FqW4AeW9A0p
	 gW61NrftyukAQcbTs1gWFQlAl1oft1MbKVwxNBdY0lXymfdEFBjB7MuPL8zXqpoVgn
	 PkH06tMjWVePiGWFsxQpBQe7hMM/lgStF8drV09Xng0pyw6ivOiI9hPGjY5J1GILJz
	 UG3ajTmmPMvY6CMB8CRClnB8GkZrIBqdLzAj275U5xlG2FrJr96BkfUzWAHABKgo0u
	 NPPjWrTzQ1dMA==
Message-ID: <3a0f1d72228621e970307c9d0d49dc12995e2c50.camel@kernel.org>
Subject: Re: [PATCH v2 02/12] sunrpc: add info about xprt queue times to
 svc_xprt_dequeue tracepoint
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 11 Apr 2025 09:40:51 -0400
In-Reply-To: <3d16719d-11f8-4016-a311-6ee8dc11667e@oracle.com>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
	 <20250409-nfsd-tracepoints-v2-2-cf4e084fdd9c@kernel.org>
	 <d18a4caf-45c4-46a8-81af-400d94f51606@oracle.com>
	 <1c99e177b4880f92044b4a37a735081b1f9d6118.camel@kernel.org>
	 <91a99432d2b72ddcb88de0e86dadbfbfbf4590ab.camel@kernel.org>
	 <3d16719d-11f8-4016-a311-6ee8dc11667e@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-11 at 09:24 -0400, Chuck Lever wrote:
> On 4/11/25 9:10 AM, Jeff Layton wrote:
> > On Wed, 2025-04-09 at 11:26 -0400, Jeff Layton wrote:
> > > On Wed, 2025-04-09 at 11:00 -0400, Chuck Lever wrote:
> > > > On 4/9/25 10:32 AM, Jeff Layton wrote:
> > > > > Currently, this tracepoint displays "wakeup-us", which is the tim=
e that
> > > > > the woken thread spent sleeping, before dequeueing the next xprt.=
 Add a
> > > > > new statistic that shows how long the xprt sat on the queue befor=
e being
> > > > > serviced.
> > > >=20
> > > > I don't understand the difference between "waiting on queue" and
> > > > "sleeping". When are those two latency measurements not the same?
> > > >=20
> > >=20
> > > These are measuring two different things:
> > >=20
> > > svc_rqst->rq_qtime represents the time between when thread on the
> > > sp_idle_threads list was woken. This patch adds svc_xprt->xpt_qtime,
> > > which represents the time that the svc_xprt was added to the lwq.
> > >=20
> > > The first tells us how long the interval was between the thread being
> > > woken and the xprt being dequeued. The new statistic tells us how lon=
g
> > > between the xprt being enqueued and dequeued.
> > >=20
> > > They could easily diverge if there were not enough threads available =
to
> > > service all of the queued xprts.
> > >=20
> >=20
> > Hi Chuck! If you're OK with my rationale above, I'd like to expedite
> > merging this patch in particular.
> >=20
> > The reason is that we have clients with the nfs_layout_flexfiles
> > dataserver_timeo module parameter set for 6s. This helps them switch to
> > an alternate mirror when a DS goes down, but we see a lot of RPC
> > timeouts when this is set.
> >=20
> > My theory is that the xprts are getting queued and it's taking a long
> > time for a thread to pick it up. That should show up as a large value
> > in the qtime field in this tracepoint if I'm correct.
> >=20
> > Would you be amenable to that?
>=20
> No objection, repost this one with the beefier rationale.
>=20

Will do.

> But it depends on what you mean by "expedite" -- v6.16 would be the
> next "normal" opportunity, since this change doesn't qualify as a
> bug fix.
>=20

I was hoping for v6.15, as I don't want to wait months to figure this
out. Eventually, I need this in a particular downstream distribution
that is reticent to take patches that aren't already merged.

>=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  include/linux/sunrpc/svc_xprt.h |  1 +
> > > > >  include/trace/events/sunrpc.h   | 13 +++++++------
> > > > >  net/sunrpc/svc_xprt.c           |  1 +
> > > > >  3 files changed, 9 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunr=
pc/svc_xprt.h
> > > > > index 72be609525796792274d5b8cb5ff37f73723fc23..369a89aea18618748=
607ee943247c327bf62c8d5 100644
> > > > > --- a/include/linux/sunrpc/svc_xprt.h
> > > > > +++ b/include/linux/sunrpc/svc_xprt.h
> > > > > @@ -53,6 +53,7 @@ struct svc_xprt {
> > > > >  	struct svc_xprt_class	*xpt_class;
> > > > >  	const struct svc_xprt_ops *xpt_ops;
> > > > >  	struct kref		xpt_ref;
> > > > > +	ktime_t			xpt_qtime;
> > > > >  	struct list_head	xpt_list;
> > > > >  	struct lwq_node		xpt_ready;
> > > > >  	unsigned long		xpt_flags;
> > > > > diff --git a/include/trace/events/sunrpc.h b/include/trace/events=
/sunrpc.h
> > > > > index 5d331383047b79b9f6dcd699c87287453c1a5f49..b5a0f0bc1a3b7cfd9=
0ce0181a8a419db810988bb 100644
> > > > > --- a/include/trace/events/sunrpc.h
> > > > > +++ b/include/trace/events/sunrpc.h
> > > > > @@ -2040,19 +2040,20 @@ TRACE_EVENT(svc_xprt_dequeue,
> > > > > =20
> > > > >  	TP_STRUCT__entry(
> > > > >  		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
> > > > > -
> > > > >  		__field(unsigned long, wakeup)
> > > > > +		__field(unsigned long, qtime)
> > > > >  	),
> > > > > =20
> > > > >  	TP_fast_assign(
> > > > > -		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
> > > > > +		ktime_t ktime =3D ktime_get();
> > > > > =20
> > > > > -		__entry->wakeup =3D ktime_to_us(ktime_sub(ktime_get(),
> > > > > -							rqst->rq_qtime));
> > > > > +		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
> > > > > +		__entry->wakeup =3D ktime_to_us(ktime_sub(ktime, rqst->rq_qtim=
e));
> > > > > +		__entry->qtime =3D ktime_to_us(ktime_sub(ktime, rqst->rq_xprt-=
>xpt_qtime));
> > > > >  	),
> > > > > =20
> > > > > -	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=3D%lu",
> > > > > -		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
> > > > > +	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=3D%lu qtime=3D%l=
u",
> > > > > +		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup, __entry->qtime)
> > > > >  );
> > > > > =20
> > > > >  DECLARE_EVENT_CLASS(svc_xprt_event,
> > > > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > > > index ae25405d8bd22672a361d1fd3adfdcebb403f90f..32018557797b1f683=
d8b7259f5fccd029aebcd71 100644
> > > > > --- a/net/sunrpc/svc_xprt.c
> > > > > +++ b/net/sunrpc/svc_xprt.c
> > > > > @@ -488,6 +488,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
> > > > >  	pool =3D svc_pool_for_cpu(xprt->xpt_server);
> > > > > =20
> > > > >  	percpu_counter_inc(&pool->sp_sockets_queued);
> > > > > +	xprt->xpt_qtime =3D ktime_get();
> > > > >  	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
> > > > > =20
> > > > >  	svc_pool_wake_idle_thread(pool);
> > > > >=20
> > > >=20
> > > >=20
> > >=20
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

