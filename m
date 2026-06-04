Return-Path: <linux-nfs+bounces-22277-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WJIGOsmWIWrpJQEAu9opvQ
	(envelope-from <linux-nfs+bounces-22277-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 17:16:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947F64152B
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 17:16:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dUPeiX8d;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22277-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22277-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7AF3050932
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 14:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100C2F7F1A;
	Thu,  4 Jun 2026 14:54:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A91F1534
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 14:54:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584879; cv=none; b=NVimv/tN5n3YCqYYnlRBmMZz88VvD49/R/E3n4yoeaIy41jhowb7MLY3SM3kH2DUbkZ1ByMfhANkJyka8n1ah/dkQ3aD7v27aOxz/h3A7xC/OIqzYopuiHI3r4iT2LA2eB56HTXzXUQwbQFz7JlWGg2Fuxu40opXXU2j/6ij69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584879; c=relaxed/simple;
	bh=pChFf9bd9+cvWF4uhcHiMUT/4AI9qZFmoLdMDVxAf+M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mzU2KoC1JZnzyF9zm5DJ91I3UPIf70cr1bLM80IxKm8hj+COmXVt9CM124NG5NLaDZjP+vYV2dbfIJ3spShXFDchH/5DEpUBbovP77LCU5z5IHq1GBryZZrTeH6POEEWm25zF09CRTbMak/xuCOLSdvZjibtWf6F8FGSiI09/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUPeiX8d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C5D1F00893;
	Thu,  4 Jun 2026 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584877;
	bh=R+ys7EdBdeJjFtotHvUHF5nHt4nPWzW5+iW67wEY9tw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dUPeiX8d6hJqNRQe/DCKMxyYmln7LRIOjRfWS28z5BwjtNCs4enZpW8wFKIWiTeBT
	 65JsQO3NpGugU4mTaJpuvZ9z5UPUsWy5JO4HNLYlLDJeNpCzGEy5UPiWNKU2kt3TxY
	 1Zy78B8fHzCCa7Uv1cWAPg/2Py2kjS4IgwEYjHUb+MT1mkQtCkJ/vP+CBOv8/UhZqQ
	 JOxYtCWtrCMz7FzilN9OgOB9qiheaj8gf7XnUIkvztFhMRprYUoeV6WXtY6rz88isO
	 t5Ry18x0epYKj2tVqdOn7ikDfqUH+eDPJtyqyiBmXUSS+bvdyjIZ0TIRY5LSUybdef
	 l4SeOllUlNJjg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56C67F4006E;
	Thu,  4 Jun 2026 10:54:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 04 Jun 2026 10:54:36 -0400
X-ME-Sender: <xms:rJEhasd2xUFQ5uXl4VFWg9O4RNvut1jLK373SrbyABD8KpdGy52dbA>
    <xme:rJEhapAwzVbW6B-rYwq75eWmKkLUOuefR3g0bRISjo6oplqk8TVQiJu3ZXx3BnMPu
    Z2n5ZCkbV5KAFJhPMUvfEFSvj1BbY4EYZJ57A3KDADNpGOIfesNQWMz>
X-ME-Proxy-Cause: dmFkZTEN5P5kBmcJydlMXlXWNF8iqnshhMiVS0DQXcft2AOzHBxMtZ3Bp1seoa508pJUaS
    iADeT5RXuG/jd/ygbQpQoNPvCLu0sdVVqg3zYVLJy5QbHmO5Lp6yAkzgI7qyZMN+gDDJ1K
    +g1tdNwD9DN2qlXGrUdS4YCnOvii70Y318UQAymPhpUubp8ix6Cj0SrG51yYr+UC2ZaXDC
    sPT1REpyv2Ivtc1kkaoSnQpvNFFEy2HjxVbTT6PshjdOYUBDZewo2EZWComsC9yIbvspEN
    /b1E8FMeUUNhDQXsSB447uJxMSXa8Mk93K+pMRbxTTa6mvA/au1QhSfoQjf7LDUe3f/RT1
    mD19b/1ZXiMGKY8uLT7ohe27VT4YLMPNn/iQrG0xHxPkypb14BiWM8byRp/W4/K10VPKcm
    OVDT2AwfWcfrGGMjg0O8iJRo/VP9pUj/sHxBSRxJAa+H5BQnvwfLMrcxUmNfMiPhXnYj0O
    q3tdZnpp1AmgL34qtKFThk+M/qdHeL+uWFs78pg9F3SOFZR0JDSK3lIUVhpCl7Jgy1N6l6
    jUqrIRiEV+FrAk+23uxD2WHHp3AhkSqLoAkxIJv15wXk2EQgW/PP42AY/UE/Kt8/WXrBOu
    8+hIoD2ElDqYe/G3oVZ0tt9MDaDxIlJCAflX6I/C0uniZrxTmPXZ75cI71Lw
X-ME-Proxy: <xmx:rJEhanA1ZFaOlDNXIpbCfg6NOsenB7S7S8QiBn6UT7l3-qCD5USGUg>
    <xmx:rJEhavCKjrlp6lzvmYOwiYA3kBS-gtQq1riL28gIKLf1vqOYhP_tAQ>
    <xmx:rJEhaiqF2nziJ_OKKL4XQhUGBlmrfF7Vln0xK9K20EzAQN9TE1UixQ>
    <xmx:rJEhapnIYq9SMDf_vf4mCJT3s_xAK578qc328x-Ukn1C9sIRN0r4-w>
    <xmx:rJEhaiwnjl6_pmyfhNFteguMmUzFMbWvInb2rS881teRn0Je3LArVv7R>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30D6E780070; Thu,  4 Jun 2026 10:54:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJGgz9MML8is
Date: Thu, 04 Jun 2026 07:54:16 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Daire Byrne" <daire@dneg.com>, NeilBrown <neil@brown.name>
Message-Id: <89ec5776-1a61-4713-b331-bb4edb9f5b0a@app.fastmail.com>
In-Reply-To: 
 <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
 <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
 <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:daire@dneg.com,m:neil@brown.name,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22277-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3947F64152B



On Thu, Jun 4, 2026, at 5:11 AM, Daire Byrne wrote:
> I'm quite interested in this functionality - like I said we already
> set svc_rpc_per_connection_limit as a way to limit the damage greedy
> clients can do to wider service delivery (especially interactive
> desktops).
>
> Another thing we do is use the fq qdisc to limit the outbound
> bandwidth (maxrate) per stream (client/nconnect).
>
> And finally, we use some qdisc prio stuff to try and "prefer" things
> like workstations over the batch render farm (differentiated by
> subnet). We also mostly use NFSv3 (for a few different reasons).
>
> I guess anything that can give us better control over these kinds of
> "QOS" scenarios we'll happily take.
>
> So for example preferring a subnet of workstations over a subnet of
> batch render farm would be nice.
>
> Daire
>
>
> On Wed, 3 Jun 2026 at 23:52, NeilBrown <neilb@ownmail.net> wrote:
>>
>> On Thu, 04 Jun 2026, Benjamin Coddington wrote:
>> > knfsd dispatches ready transports from a single per-pool FIFO, so a
>> > client's share of nfsd service scales with the number of connections it
>> > holds rather than being shared per client.  A client that opens many
>> > connections (nconnect, or a farm of data movers) starves other clients
>> > on the same server purely by out-numbering them in sockets.
>> >
>> > I measured this with a load generator that pins each request to a fixed
>> > service time and does no filesystem work, so that nfsd thread-time is the
>> > only scarce resource (8 threads, 10ms/op, ~648 ops/s pool ceiling).  A
>> > greedy client opens K connections alongside one single-connection
>> > interactive client.
>> >
>> > NFSv3, dispatch as it is today:
>> >
>> >   greedy K   greedy share   interactive ops/s
>> >      1           50%              241
>> >      4           80%              129
>> >      8           89%               72
>> >     16           94%               38
>> >
>> > The interactive client's share tracks 1/(K+1) and its throughput falls
>> > roughly 6x while it does nothing different.  NFSv4.1 behaves identically
>> > (89% greedy at K=8) even when the greedy connections are bound to a
>> > single session, because the dispatch decision is below the NFS version.
>> >
>> > The same NFSv4.1 workload with fair queueing enabled:
>> >
>> >   greedy K   greedy share   interactive ops/s
>> >      8           72%              182
>> >     16           73%              177
>> >     32           70%              193
>> >
>> > The greedy client's share no longer climbs with its connection count and
>> > the interactive client recovers (72 -> 182 ops/s at K=8).  Aggregate
>> > throughput is unchanged: the T/D pool ceiling is the same with fair
>> > queueing on and off.  The split does not reach 50/50 because a single
>> > interactive connection is bounded by its request window and by XPT_BUSY
>> > serialising one transport; with a deeper window it reaches ~59/41.
>> >
>> > The approach:
>> >
>> >   - sunrpc grows an opaque per-transport fairness key (patch 1), with a
>> >     default derived from the source address (the source port is excluded
>> >     so a client's several connections share one key), and an opt-in
>> >     per-pool scheduler that buckets ready transports by that key and
>> >     dispatches round-robin across keys (patch 2).  When it is disabled,
>> >     which is the default, the existing lockless FIFO path is unchanged.
>> >
>> >   - nfsd gains a "fairq" module parameter to turn it on (patch 3) and
>> >     stamps the NFSv4.1 clientid as the key when a connection binds to a
>> >     session (patch 4), so all of a client's connections share one key.
>> >     NFSv3 uses the source-address default.
>> >
>> > This is an RFC; a few questions for the list:
>> >
>> >   - Unit of fairness: clientid (used here) or session?  Earlier
>> >     discussion leaned toward exploring per-session.
>> >
>> >   - Mechanism: a fixed bucket hash under a per-pool spinlock taken only
>> >     on the opt-in path, versus a lockless or per-flow structure.
>>
>> I'm not keen on the hash bucket approach, though I can't clearly say
>> why.
>> I'm also not keen on the opt-in design.  I don't like asking the admin to
>> tune performance.  We should always provide optimal performance.
>>
>> I imagine creating an object which represents a client - using IP
>> address or possibly v4 client id.  These may well be located using a
>> hash table (rhashtable?), but that is peripheral to the design.
>> Each xprt has an associated client which can be changed at any time
>> (nfsd could change to a v4.1-client).
>>
>> Each client has a lwq of xprts and is part of an lwq of clients.
>>
>> To enqueue an xprt, we grab the client, enqueue to that, then if
>> necessary enqueue the client.
>>
>> To dequeue next, we dequeue the first client, dequeue the first xprt,
>> then optionally enqueue the client again.
>>
>> So this would be slightly more work than the current (2 dequeues instead
>> of 1) but I think that might be acceptable.
>>
>> clients would be refcounted by xprts and probably rcu-freed.
>>
>> >
>> >   - Would a per-client in-flight cap be preferable to proportional fair
>> >     queueing?
>>
>> A per-client cap would only be ok if the admin didn't have to tune it.
>> So the client would need to get some sort of feed-back from the server
>> so that it knows when it is pushing too hard.  If we were still using
>> UDP we could possibly use packet-loss for that feed-back, but we aren't
>> and don't want to.
>> With v4.1 we can of course use the slot based flow control and I think
>> we should if we can agree on a good design.  With v3 I don't think there
>> is any way to get the needed feed-back
>>
>> Thanks,
>> NeilBrown
>>
>>
>> >
>> > The measurement used a debug-only filehandle-latency hook that is not
>> > part of this series.

[ Daire, we're generally a "bottom post" list. My comments below
are in response to your notes quoted at the top as well as Neil's
and Ben's quoted inline ]

First some general responses to the shape of Ben's patches.

- Thanks for giving us something to start kicking around!

- I'm not a fan of adding administrative controls, and these days, a
  module parameter is outdated and way too global. I'd like to see
  that removed until we have a clear need (use cases) for tuning

- Having to rely on client identity is going to be difficult to get
  right. The scope of the identity, for example, is never going to
  cover all the use cases that we want. For example, fairness-by-
  client-address means all clients behind a NAT get reduced to a
  single fairness unit.

- The observability you proposed for measuring your solution is
  worth some attention. We should consider making it a part of
  the patch series rather than something that was useful only
  while it was being developed.

- Probably the largest challenge will be including NFSv3, NFSv4.0,
  and LOCALIO, none of which have the concept of a "session".

After some thought, IMO the problem as initially stated has some
areas that are going to be challenging and delay a real solution.

Instead, we could look at the problem as "preventing starvation of
any one connection" rather than the more difficult goal of "ensuring
complete scheduling fairness". This changes the problem class
fundamentally.

Strictly speaking, nothing in Ben's data is starved today: the FIFO
transport queue guarantees every backlogged transport one receive
per cycle, and every op gets completed. What degrades is the floor:
the latency and throughput a lightly loaded connection can count on.
It degrades linearly with the aggressor's connection count: with K+1
backlogged transports and pool service rate T/D, the interactive
connection waits ~(K+1) * D/T between services, which is unbounded
as K grows.

The reframed goal is precise: make the service floor of any one
connection independent of how many connections and slots everyone
else holds. That is a much weaker contract than proportional
fairness, but the best part is it dissolves the hardest challenges.

Equal shares require knowing who "everyone" is; a floor does not.
No client identity, no clientid-vs-session-vs-address debate, no
NAT collapse, no client-object lifetime, no per-pool share
fragmentation. And IMO it is what both Ben and Daire actually
asked for: Ben wrote "I would prefer the 'interactive' clients
be prioritized, but I don't control their nconnect." And Daire
described something similar above.

Looking at prior art, networking has solved exactly this reframed
problem (and Daire alludes to that above): fq_codel's success
comes less from its fair queueing than from its sparse-flow
optimization; that is, flows with nothing in flight jump the queue
and heavy flows share what remains.

TLDR; this reframe turns "schedule fairly" into "let request-
response traffic overtake streams," and NFSD already appears to
track the bit of state needed to tell them apart.


-- 
Chuck Lever

