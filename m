Return-Path: <linux-nfs+bounces-22269-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +fYJIO1sIWoEGQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22269-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 14:17:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8363FCB1
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 14:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dneg.com header.s=google header.b="Z2GV/BwJ";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22269-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22269-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=dneg.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFA63038BBC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 12:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FDD3E275F;
	Thu,  4 Jun 2026 12:12:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861543635F
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 12:12:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575135; cv=pass; b=mTuZVWj/6tiUjv3YcWh9UGInCb3sWUtedz499IR/ziiIKbI+V3qSPfU41FFc7rKQIU8AIzh6UnKd7bF+HRRSb+zcbbI5ZN22zQzudPhbSQ5Mp/Sj8Gnibgr20A/FbzGTKRhtDq1iU6RL5hij6qZw52V8okM2A9BiHHA4z8ubAeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575135; c=relaxed/simple;
	bh=SnzdkEH7zFVgzf9xVry5Mb8rnlYV8RNSXe4UyjtPLxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQq1yeHs6N7Zuv9VuHGPztBAvqBUryP1hB/fygio2SSxiNjiplGs5TOojmJfOYPGRrfz50L0KED1pJR/Y9YLRv5x3Ohk6Bt8EU0CHI5ujLitibvsFdmPSrSkdKJBMsthPsALl512bHflNMJv+Nxn4crGv2WlnKng1rp42DOkE/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dneg.com; spf=pass smtp.mailfrom=dneg.com; dkim=pass (2048-bit key) header.d=dneg.com header.i=@dneg.com header.b=Z2GV/BwJ; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so694080a12.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2026 05:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780575132; cv=none;
        d=google.com; s=arc-20240605;
        b=Afss84SdoEB621YckUClRNBEMSUlIEQB9Yt+GnZ+mZoLk1TDf/QwkVkd+G5qGkBfXD
         dUQh3rQLunPTkfcSdmZCGnc2luinchr2bzPZcMzQ3NQdgZR5gN4Bbrnh6V4qUvwmqu5/
         owos40QaENDen+NINQc2xT08iBJPzIibaRIvF2UkzHyMu3otGGnKt6gRp8gYFjbLlHy3
         VO8tu/YaM+c7I7TOSIEW1BzLPQqkYXgLubQSZT/iYkB1Q/6PHWNNaDetNyWy67CsU8gw
         4YMaZJTY7HXOLecMjj1PINOljfVP4S5CSaLg89zPjrxe8n6YjU9MbUrOG02dQ+QpBymT
         GkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BSkelMKgFm2wngM//tVs8iV2VsMtCxC1coxLgK7LGwI=;
        fh=TvKL7JCtTdAYczggJQEIR66hrPURRC7OuVsw7F4iK3o=;
        b=ghJvnvkq4Q21sHXtBliGy9vScQ0TCCAuBuJww0ZfigZkHs8QnEswd6OU+R8w1gYNfE
         OANP7aaxka2n6FNlGd8WmEqGVxnL8MzFdO31fucQPNAdfDAa7V2aqEfm7fNYpFkbuCH3
         x+h9zYoUQq+rYnBCpFh+jyEJHsNYG+wX4tS72pOfV/k6xFSXGLS9uNCUhrd3kNGq4Ybl
         3GFRtmKSjpZYA3IzHQaGGuzwC/Euq6cG4kSffA2OjO5gl6Prjo1ZrKQjFu8DQZYaTkJZ
         1W6u1dhDF+GYUOT6Qu2r0p60GrImsoizXqCv1slPxcOxTLHWz8LLIenL6mMaG+G/aUWS
         QTbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1780575132; x=1781179932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSkelMKgFm2wngM//tVs8iV2VsMtCxC1coxLgK7LGwI=;
        b=Z2GV/BwJmpPXGjTSPrww3/Dp1jQdnldPAg27Y5TNyaco6uxNEnf066rekK2sQErv80
         4hhelfYWqqoqJfnuU4i9A38cW1ODX6NQv/7hFRpvp4C/C1/8rmue1NSVDGa8AsKJroP7
         7G5NIStnu5HnvhlVggBkhLB5/Do9pZogWsCZGbOK1fRlbm92wOVDptAhAEvswzcpjaVA
         7MXrF6HPnq3US8RVtuaY6DtV9qPaIkUS/+A0+A4lQTWgQfGcyepPdg/XcaYq9MWziFac
         D1IFX0LkVbDJ+LI3SKv5kBqDWyuMrQT6lnQrSg7QmXHed7Sj0YPZsdTQn7eQMhd1RJTu
         6bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780575132; x=1781179932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSkelMKgFm2wngM//tVs8iV2VsMtCxC1coxLgK7LGwI=;
        b=BxV3EHrc0qC2Aa+k12QvoAx0HxBgfeNjdGRJ9utexPAr4DqfWT6uR/ZYhr+GACf5UI
         POVqDVVLMLTYAQRhpJ8vhYNnqdDCpbXnZnTC1GnNVDQWWgrtIR36ETR0lTCoNZioQdry
         A4JL9MD8yXAkRHQRM2pc4uTO9nlGHFd8+kRQ+ofgP5fPJJ6hCid1Qe6jQQLsgsfJL58x
         kABLA6LVNhnDr7DDex/PffVtRxD0UQlQ9XOHVLby7o3Ntbe6eVyWJZtvtkZuNANxtsgX
         0P9nWNC1LaATw6XqNPy1t8/qsNsT7ZnA591nyUo0Z7ZgX+3zau+UZq0Lean4KHfnc8Yh
         Xd7A==
X-Forwarded-Encrypted: i=1; AFNElJ9IhsCxfnmMuRldkTcGz4FkDMjaui5ZqoAYuIWKTCn8A6/QVo2JtmtgnDUQsMFUE/RZzBz9SJdi/Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJTekqurEyxYkpqSMq2iX5IqMJS3uHZnENsSqpxkDwVY+oiqXS
	1G9vEu3Q5NNnuQBnPVl90+kEc7kfP9k5EH9rN6ghI86vOc32+bbviw6gPfaH8mBBLNJGkcB4Hqz
	p19TqLRK5mMDPMt1tsYro1Dj261OTyGZGCj1srwxUKA==
X-Gm-Gg: Acq92OE0WVnjud6/EUbU539778mzOtBRPaCpN4iJbX4Jtd3lkal6u8dYeI6te+933MI
	roKUst/ZYzIL1fo9w2ncA8gZGXlIpUFu4gmlN8xxdEzzLDHqxPtJy4jxu2vvNiFbtc8GwzRpVLL
	IPNsuGGqw0Ybv4CdbnXdDqMP5gu/1g9cm2Ixf6P/ojkDJ66MBWR2ttU7ouCnlEyOWeWKktAq6ld
	UbpiK+uBKqzZ0MSHdTEbPGX34LrdvY4Tzk4XVkiF7AtmH8QDNLBq4htiFIt/wxb1U2Hs304CmsG
	X3mcEjLhXt/q3Mip
X-Received: by 2002:a05:6402:26d2:b0:68b:583:fb37 with SMTP id
 4fb4d7f45d1cf-68e70718a8cmr3704828a12.10.1780575131777; Thu, 04 Jun 2026
 05:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780498019.git.bcodding@hammerspace.com> <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
In-Reply-To: <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
From: Daire Byrne <daire@dneg.com>
Date: Thu, 4 Jun 2026 13:11:35 +0100
X-Gm-Features: AVHnY4JnZiarlhBOTCPLFBCc3-TBP7pe5kpAIAVwM4nRX9uQATCg_VHHK34zqzU
Message-ID: <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[dneg.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[dneg.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22269-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daire@dneg.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[dneg.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dneg.com:from_mime,dneg.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DA8363FCB1

I'm quite interested in this functionality - like I said we already
set svc_rpc_per_connection_limit as a way to limit the damage greedy
clients can do to wider service delivery (especially interactive
desktops).

Another thing we do is use the fq qdisc to limit the outbound
bandwidth (maxrate) per stream (client/nconnect).

And finally, we use some qdisc prio stuff to try and "prefer" things
like workstations over the batch render farm (differentiated by
subnet). We also mostly use NFSv3 (for a few different reasons).

I guess anything that can give us better control over these kinds of
"QOS" scenarios we'll happily take.

So for example preferring a subnet of workstations over a subnet of
batch render farm would be nice.

Daire


On Wed, 3 Jun 2026 at 23:52, NeilBrown <neilb@ownmail.net> wrote:
>
> On Thu, 04 Jun 2026, Benjamin Coddington wrote:
> > knfsd dispatches ready transports from a single per-pool FIFO, so a
> > client's share of nfsd service scales with the number of connections it
> > holds rather than being shared per client.  A client that opens many
> > connections (nconnect, or a farm of data movers) starves other clients
> > on the same server purely by out-numbering them in sockets.
> >
> > I measured this with a load generator that pins each request to a fixed
> > service time and does no filesystem work, so that nfsd thread-time is the
> > only scarce resource (8 threads, 10ms/op, ~648 ops/s pool ceiling).  A
> > greedy client opens K connections alongside one single-connection
> > interactive client.
> >
> > NFSv3, dispatch as it is today:
> >
> >   greedy K   greedy share   interactive ops/s
> >      1           50%              241
> >      4           80%              129
> >      8           89%               72
> >     16           94%               38
> >
> > The interactive client's share tracks 1/(K+1) and its throughput falls
> > roughly 6x while it does nothing different.  NFSv4.1 behaves identically
> > (89% greedy at K=8) even when the greedy connections are bound to a
> > single session, because the dispatch decision is below the NFS version.
> >
> > The same NFSv4.1 workload with fair queueing enabled:
> >
> >   greedy K   greedy share   interactive ops/s
> >      8           72%              182
> >     16           73%              177
> >     32           70%              193
> >
> > The greedy client's share no longer climbs with its connection count and
> > the interactive client recovers (72 -> 182 ops/s at K=8).  Aggregate
> > throughput is unchanged: the T/D pool ceiling is the same with fair
> > queueing on and off.  The split does not reach 50/50 because a single
> > interactive connection is bounded by its request window and by XPT_BUSY
> > serialising one transport; with a deeper window it reaches ~59/41.
> >
> > The approach:
> >
> >   - sunrpc grows an opaque per-transport fairness key (patch 1), with a
> >     default derived from the source address (the source port is excluded
> >     so a client's several connections share one key), and an opt-in
> >     per-pool scheduler that buckets ready transports by that key and
> >     dispatches round-robin across keys (patch 2).  When it is disabled,
> >     which is the default, the existing lockless FIFO path is unchanged.
> >
> >   - nfsd gains a "fairq" module parameter to turn it on (patch 3) and
> >     stamps the NFSv4.1 clientid as the key when a connection binds to a
> >     session (patch 4), so all of a client's connections share one key.
> >     NFSv3 uses the source-address default.
> >
> > This is an RFC; a few questions for the list:
> >
> >   - Unit of fairness: clientid (used here) or session?  Earlier
> >     discussion leaned toward exploring per-session.
> >
> >   - Mechanism: a fixed bucket hash under a per-pool spinlock taken only
> >     on the opt-in path, versus a lockless or per-flow structure.
>
> I'm not keen on the hash bucket approach, though I can't clearly say
> why.
> I'm also not keen on the opt-in design.  I don't like asking the admin to
> tune performance.  We should always provide optimal performance.
>
> I imagine creating an object which represents a client - using IP
> address or possibly v4 client id.  These may well be located using a
> hash table (rhashtable?), but that is peripheral to the design.
> Each xprt has an associated client which can be changed at any time
> (nfsd could change to a v4.1-client).
>
> Each client has a lwq of xprts and is part of an lwq of clients.
>
> To enqueue an xprt, we grab the client, enqueue to that, then if
> necessary enqueue the client.
>
> To dequeue next, we dequeue the first client, dequeue the first xprt,
> then optionally enqueue the client again.
>
> So this would be slightly more work than the current (2 dequeues instead
> of 1) but I think that might be acceptable.
>
> clients would be refcounted by xprts and probably rcu-freed.
>
> >
> >   - Would a per-client in-flight cap be preferable to proportional fair
> >     queueing?
>
> A per-client cap would only be ok if the admin didn't have to tune it.
> So the client would need to get some sort of feed-back from the server
> so that it knows when it is pushing too hard.  If we were still using
> UDP we could possibly use packet-loss for that feed-back, but we aren't
> and don't want to.
> With v4.1 we can of course use the slot based flow control and I think
> we should if we can agree on a good design.  With v3 I don't think there
> is any way to get the needed feed-back
>
> Thanks,
> NeilBrown
>
>
> >
> > The measurement used a debug-only filehandle-latency hook that is not
> > part of this series.
> >
> > Benjamin Coddington (4):
> >   sunrpc: add a per-transport fairness key to svc_xprt
> >   sunrpc: dispatch ready transports fairly per client
> >   nfsd: add a fairq module parameter
> >   nfsd: key NFSv4.1 connections by clientid for fair queueing
> >
> >  fs/nfsd/nfs4state.c             |  17 +++
> >  fs/nfsd/nfssvc.c                |  19 +++
> >  include/linux/sunrpc/svc.h      |   5 +
> >  include/linux/sunrpc/svc_xprt.h |  46 ++++++-
> >  net/sunrpc/svc.c                |   2 +
> >  net/sunrpc/svc_xprt.c           | 216 +++++++++++++++++++++++++++++++-
> >  6 files changed, 302 insertions(+), 3 deletions(-)
> >
> >
> > base-commit: e7ca66ba17f1b5e4ecbb29b9c3c4a31aa062bed0
> > --
> > 2.53.0
> >
> >
>

