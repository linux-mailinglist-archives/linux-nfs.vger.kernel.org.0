Return-Path: <linux-nfs+bounces-22260-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ttNKqewIGr+6gAAu9opvQ
	(envelope-from <linux-nfs+bounces-22260-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 00:54:31 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDE763BADA
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 00:54:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=UPtyhdwG;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="E cAG+VE";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22260-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22260-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80F133023F82
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 22:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5649251E;
	Wed,  3 Jun 2026 22:52:43 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47F4C0430
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 22:52:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527162; cv=none; b=iTjbaZQciEh70jCNRXWWPBoL2QjqFzeYPm3A3tpefXB8RvcKsrrbJs6n+fcZ0u04QAG4aa4taeQDCjMxnUZ2liGiDsk7veMxqAOWb6UaLIICOnOvqHQPyS+oCLIXREqCckKff4RFAQ7xKdtLdcIzcSTW93D0eRovUU5OHR/BpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527162; c=relaxed/simple;
	bh=n7+G395wGkFrYCEiqaWUJ88J5eP2Ktkhl783WYxpbtA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=e/0tXnx6jkLTcRdnD6fBZtcpL9Gf3qI7935LuMuZBVabkZXSnGfrdUYOtQNFizto3cuNnU8rphfB04ne/0bzNAwMV0onUK8+PtRxwyo6UVS3urCtbHQ1mPbITeo78e3Vn6j90Go90gbUpRLy2QYE8UIZkESgqxI/GMFyxnD6AOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UPtyhdwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EcAG+VEf; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C00E7A008F;
	Wed,  3 Jun 2026 18:52:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 18:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780527153; x=1780613553; bh=kiN4he5OQzIHANsDloakg5M8PtP9FRXdmK3
	J0blGWJQ=; b=UPtyhdwGgMSrUuiCXFgaPZVT68BrvLMw9kwiiRV+Y4Sjfu9LZwI
	q9QPlDlNVfIZy2Xa9xn5H/wXbgMzCgLrQni4L5EqIpQGhjl6iiZFzWmakgyn3uA9
	DJl9OWd3kWgv9wOdl4cNfNerKAKos4zlL2X/YSwBuR8yp0lyhwYqa0vWU9bmCBxf
	afjpBzHBCn8Ca3b2wIzoExRsr2SpvDe7MHvFvruvJFu2ZuaCguRuS5BXBKb1niDx
	d42jmVuuA49RdKeW78YyqbGFRYagH0Pf6okZRw+n6Y0v2z+BqSAFWlFMqmVK0Okt
	QijD6QO0ESvIbQhuIoDz4/0vFcSbwEEkOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780527153; x=
	1780613553; bh=kiN4he5OQzIHANsDloakg5M8PtP9FRXdmK3J0blGWJQ=; b=E
	cAG+VEfvHTnHdF5KhdBqhX+HahKT8v+QgloTbL91Ys7dRFMMksjmbykMFmPwZN5L
	cRdLULldnKQx9Del/iAafviO4d4R2aQ6jhi3ni6mj3662d6hnUc6d6kbssGwu66n
	nioHifV+MFLgBkWEqJSftiJ4BNtgMeEVzvz4wLbQyYoE8IHICE0zRaJDKaqTa8xH
	gwcUHvV827VmTPAqUtNE3Ir1EsT/NuHE1eA+T2+FPnla2JLT7ARTY1PzTZ9tgUe3
	DtjgTNoDT6bdSoLN+eu7Rh5KaLLaF5rVxYeo7UlOpB/YMKlU+YFf6GRWNUfnEoat
	8JMcBI9POzxLRZH7r8zvw==
X-ME-Sender: <xms:MbAgapNMPfAizo0NmfHJoml2JaVDiio1eFFVsvYm5oFDlzUnvrms8w>
    <xme:MbAgai2Tlolt5IaBAyPP3AgVooi7gDMHJgEpQi6RvAUx0hW03MBRuY939XbTjV0ph
    1V4qdblfI9w_U3wRrqJYs1aiWjVunJdbUbY_887-_rKr1ozymY>
X-ME-Received: <xmr:MbAgagmr5TMXWicq3jBCnOyF93LHYyt_0x_-LedlBrAM3kAkReS8kDCgVVbStu_QKC-neFzLzp-g2EXOhjCWUB5inqB6IMc>
X-ME-Proxy-Cause: dmFkZTEjyhk++RgHCZGuxV71Nu2l0GxeefNI2va4i/CAQr8mj5VGYqB5jsQX9gQ9fsuvVs
    J74NdLVanq29Mkfoy+7dEY9qC5BFR9GPh1+7vKU6+DazMqsEAcieevatEt7XLISaTDM0SE
    nzwUKRVrT8eXYLFZfc6UOyvCF1kptS+HOok5Cl6EkaKYVtcybzFEUWXbT1wqXNOIZbZeuY
    OlKfGqySgvP4T5nsBQLJtvltBH9gUR3bYlH6BQ1RJ7n6DWjCkd/4xFPuXF20tRGmINQvcP
    kuH6yuEgg79lxNDearRJz9Ji2JRYkT1qIvjrx7xyKSmocjHcRCn6BKc7miSc1fHcyyWtcm
    3luw24wxj1ULddJgZvJIKT+g+spruFSGP3wj8B2wtuAz/PdiLTtv6JCzdzNIfVjJMbSAbG
    EYfhdBWm/QTMODX/lAP4NQ9clM+KXJCGD6QSbbdPF3OsszTmh1taOpXx8GMC3H+TBSlPVv
    w0S5CwC6+ziRK9S9oI+0NA+ueLjTM2C1hTJQ6M1QIeYHhs7ei1zocL8/H/VEmDx+/V6NIM
    hoQa/CVIkmBJ/VnobLOnrdNKS3WtTFSI6Wn2hYDgpAErXRxKQU7pJ9arLUMm4UTy+vo1DA
    yAD+ZN3WOq3C7YhNIPb1KtPFk7jSfN0ZVZV9wqjHaevha0AD/IsssDK5QwrA
X-ME-Proxy: <xmx:MbAgahUTYXA_KO7sSqwehvJ-Af6q04lgve3025Dq1r2ZelKnG2fftw>
    <xmx:MbAgauu66xIxs5WbnTupVhVLSUG_6xEnYEXIpGm3h_vi0hXj41KT5A>
    <xmx:MbAgasYR7vZhAXoYikk-SaA5Zu6E7xouTbEJF0pmjH0S9m20Dmy0Eg>
    <xmx:MbAgalW9FnTXyEbFuuZwdVF7V2noGD8ur06kTtnwL1NWJIC2p2wYIw>
    <xmx:MbAgajyrVW5zWZqY-UmNrkVu0rrJIgJq1ZFqWA1rov1C85FHyiopIkIv>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:52:31 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Daire Byrne" <daire@brahma.io>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
In-reply-to: <cover.1780498019.git.bcodding@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
Date: Thu, 04 Jun 2026 08:52:27 +1000
Message-id: <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22260-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim,ownmail.net:from_mime,ownmail.net:dkim];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EDE763BADA

On Thu, 04 Jun 2026, Benjamin Coddington wrote:
> knfsd dispatches ready transports from a single per-pool FIFO, so a
> client's share of nfsd service scales with the number of connections it
> holds rather than being shared per client.  A client that opens many
> connections (nconnect, or a farm of data movers) starves other clients
> on the same server purely by out-numbering them in sockets.
> 
> I measured this with a load generator that pins each request to a fixed
> service time and does no filesystem work, so that nfsd thread-time is the
> only scarce resource (8 threads, 10ms/op, ~648 ops/s pool ceiling).  A
> greedy client opens K connections alongside one single-connection
> interactive client.
> 
> NFSv3, dispatch as it is today:
> 
>   greedy K   greedy share   interactive ops/s
>      1           50%              241
>      4           80%              129
>      8           89%               72
>     16           94%               38
> 
> The interactive client's share tracks 1/(K+1) and its throughput falls
> roughly 6x while it does nothing different.  NFSv4.1 behaves identically
> (89% greedy at K=8) even when the greedy connections are bound to a
> single session, because the dispatch decision is below the NFS version.
> 
> The same NFSv4.1 workload with fair queueing enabled:
> 
>   greedy K   greedy share   interactive ops/s
>      8           72%              182
>     16           73%              177
>     32           70%              193
> 
> The greedy client's share no longer climbs with its connection count and
> the interactive client recovers (72 -> 182 ops/s at K=8).  Aggregate
> throughput is unchanged: the T/D pool ceiling is the same with fair
> queueing on and off.  The split does not reach 50/50 because a single
> interactive connection is bounded by its request window and by XPT_BUSY
> serialising one transport; with a deeper window it reaches ~59/41.
> 
> The approach:
> 
>   - sunrpc grows an opaque per-transport fairness key (patch 1), with a
>     default derived from the source address (the source port is excluded
>     so a client's several connections share one key), and an opt-in
>     per-pool scheduler that buckets ready transports by that key and
>     dispatches round-robin across keys (patch 2).  When it is disabled,
>     which is the default, the existing lockless FIFO path is unchanged.
> 
>   - nfsd gains a "fairq" module parameter to turn it on (patch 3) and
>     stamps the NFSv4.1 clientid as the key when a connection binds to a
>     session (patch 4), so all of a client's connections share one key.
>     NFSv3 uses the source-address default.
> 
> This is an RFC; a few questions for the list:
> 
>   - Unit of fairness: clientid (used here) or session?  Earlier
>     discussion leaned toward exploring per-session.
> 
>   - Mechanism: a fixed bucket hash under a per-pool spinlock taken only
>     on the opt-in path, versus a lockless or per-flow structure.

I'm not keen on the hash bucket approach, though I can't clearly say
why.
I'm also not keen on the opt-in design.  I don't like asking the admin to
tune performance.  We should always provide optimal performance.

I imagine creating an object which represents a client - using IP
address or possibly v4 client id.  These may well be located using a
hash table (rhashtable?), but that is peripheral to the design.
Each xprt has an associated client which can be changed at any time
(nfsd could change to a v4.1-client).

Each client has a lwq of xprts and is part of an lwq of clients.

To enqueue an xprt, we grab the client, enqueue to that, then if
necessary enqueue the client.

To dequeue next, we dequeue the first client, dequeue the first xprt,
then optionally enqueue the client again.

So this would be slightly more work than the current (2 dequeues instead
of 1) but I think that might be acceptable.

clients would be refcounted by xprts and probably rcu-freed.

> 
>   - Would a per-client in-flight cap be preferable to proportional fair
>     queueing?

A per-client cap would only be ok if the admin didn't have to tune it.
So the client would need to get some sort of feed-back from the server
so that it knows when it is pushing too hard.  If we were still using
UDP we could possibly use packet-loss for that feed-back, but we aren't
and don't want to.
With v4.1 we can of course use the slot based flow control and I think
we should if we can agree on a good design.  With v3 I don't think there
is any way to get the needed feed-back

Thanks,
NeilBrown


> 
> The measurement used a debug-only filehandle-latency hook that is not
> part of this series.
> 
> Benjamin Coddington (4):
>   sunrpc: add a per-transport fairness key to svc_xprt
>   sunrpc: dispatch ready transports fairly per client
>   nfsd: add a fairq module parameter
>   nfsd: key NFSv4.1 connections by clientid for fair queueing
> 
>  fs/nfsd/nfs4state.c             |  17 +++
>  fs/nfsd/nfssvc.c                |  19 +++
>  include/linux/sunrpc/svc.h      |   5 +
>  include/linux/sunrpc/svc_xprt.h |  46 ++++++-
>  net/sunrpc/svc.c                |   2 +
>  net/sunrpc/svc_xprt.c           | 216 +++++++++++++++++++++++++++++++-
>  6 files changed, 302 insertions(+), 3 deletions(-)
> 
> 
> base-commit: e7ca66ba17f1b5e4ecbb29b9c3c4a31aa062bed0
> -- 
> 2.53.0
> 
> 


