Return-Path: <linux-nfs+bounces-22843-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g8SjLZp6PWoy3ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22843-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 20:59:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0056C84D8
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 20:59:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NDD3ESPt;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22843-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22843-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8DCB300D84E
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E73271EA;
	Thu, 25 Jun 2026 18:59:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB925785C
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 18:59:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782413976; cv=none; b=GlgcK6XCfkwRkwpxO5SLfFZ9ixmEvrIBrI9iw9eLMVe4WHEa1oULT2jEP3XvmApA4VWeqOoXIFQB/yGbf6Xjf1cq3AYA0uQ2J/Q+ZziVGr5a5ouHXnXjCrgjbZGaJYoLcnXIA20M5zC+ISbN3xqZpO0CXEjovWZsGo3OJZ6V7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782413976; c=relaxed/simple;
	bh=C2NnYeLtn5hVbXjhlWLGRka8aq6wm5GlJhpnYylhTi0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mWrbllwKJXvoqXYt4A3+jKa3yex+aCv3I/bISeyUjQGZFnpklNHApxNS+tJtlGq0AZnDhH8jjTayU/933jcFXa4pEqwT4rCNRdzyegbOuOOCD+2PFmym244ZPEc7tbCIUe59o4/yMGM3v1e43Q9P0MXGP48RpuAmc/qaKE/Lm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDD3ESPt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656041F000E9;
	Thu, 25 Jun 2026 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782413974;
	bh=WBu3AQjpnToMa9C6xzFcjDP8qbwcEEjFOo1R5Hz2tkQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=NDD3ESPtZSM0MDVjqpliT/ga17fUdhKlpT+g6Rro3Vg+tO1ZLbYogXoKNx3+0heg9
	 AaXQClN5w94EsiF57UiM7FB7vWv9Efa4hWQAqMoW0xXZFmu9vdymKAEmo6BeVOKW+B
	 zuz5HD+8sZBqC09gG43m0WHPejeHc5jjSATBttq3G+0s30dg2xtGf90XfTZ5PDbsTA
	 AmictHana10wYHIcaiJD3ACxpsnRpIEY78ukKLZ3rarrs8P94txoq6A4uTyInavT2F
	 JM48aXbKfwvv4HNADQ2i1bNf6OIBZ55KQ6DARfAD4tO64RIpm7z/0G6mNQbwH59rnU
	 sMr0DtSgrdQ1w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6751F40083;
	Thu, 25 Jun 2026 14:59:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 14:59:33 -0400
X-ME-Sender: <xms:lXo9auwKcU7N3glfI61Hhrd7EBDBp1YpwdN5RA8Y5oSjAhn9viulqw>
    <xme:lXo9alGCEItPpWdwjGfM57QGo-630QT2kmz5vgJ48BLqZ0tO90o3bjhX8T2bIIOwf
    xOr9Cn-VQpxKgbUo9DtJ_pUQT4tB53nb2kfoxQlbSY8vJvbJJvRLw>
X-ME-Proxy-Cause: dmFkZTF9L/bMTjNT0pajOtF7vn/f95FppebJB7Y2LB4TC0UZgKePFRmF0rXpVGIrRTpa5n
    gCXVqfRvk+uYbmeZEQ3xVpnuoKoUCPbu+ZsQJl0YHwmhOzrh20x7p1pZmD33kHbHw3s7EE
    RVbaRTEucUgJh9zY919sU1xqW6MopBYWEt3QBvBTEfIZG8XOAw8NNVbwq+KDsM8KwOERlT
    ocTEAf81yN05V58RX9m0y4ngk4xDVB2VXQ6n9ZE6xRE0aj7mRePJbc4ROd00+FfZ025FmJ
    GfUcUOlVKW+OmIe77c4ljNIkfPQHjoL/U2S9m+TyCRxsTQVBAH8CbTQXZTVwMUTkn7PpI5
    AlNOScGt7ZMRAALQZiiA0cE0/nLSB6B4tUkwFBUgM2NqDdRGYUrcySfSMtlDvTjkXSSmpU
    S7UTEU+dLtMbZfJTqSkJWWVwLd/H2mTQHztjrKBnM7m1AwTyheh6aVIvijafQaUbfS91Mr
    mzOKOqmcZNq4Armb/dIe0hMJZEQDNwCM9sPQ6YoWgHN4WC06syaFB0J2Yn9lhiY5ztbrMs
    XEGnr9plM2mzyXV7294lV9iqsY17b6b1eDtWX/zncrWvO39BZH9hwdS79hoOYfd1QjGVJI
    5jaKulaJ1+B6m2lCA+aggPb44a4jWSjMisRJVpuNMdX1Uuz6/5qp/IcfG66Q
X-ME-Proxy: <xmx:lXo9aqT6eUEBW4ButCyfosfKRsYwclnb39YA14UfRU0O60dzd0tAhA>
    <xmx:lXo9ai0RxO9YhaGk6tHm7g_MXWSf69FuY9oBMDlQ7J5uWHFliuNAUQ>
    <xmx:lXo9aieWg3X5C6IMcEBIC-heD6SlvW_Z9euMFm2bSL5YTGFbY2uOCA>
    <xmx:lXo9aiNw5FjnOqj1Z01yM4y1mM_7H_0HkSKw6c7UhBxEukvVexG85w>
    <xmx:lXo9auWZB2T6Lz-hGxBBPdi9x5U7Q4111zbkcYtjlcoRj6r2MYv43qUs>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 82B16780AB9; Thu, 25 Jun 2026 14:59:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEhg0xB2aOJ7
Date: Thu, 25 Jun 2026 14:59:13 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Daire Byrne" <daire@dneg.com>, linux-nfs@vger.kernel.org
Message-Id: <d8efb4f7-fd91-453e-a6fd-1427bdab1cc0@app.fastmail.com>
In-Reply-To: <cover.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
Subject: Re: [PATCH RFC 0/3] SUNRPC: a latency floor for interactive clients via
 sparse-flow dispatch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[hammerspace.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22843-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F0056C84D8


> an idle->active transport is granted a budget of 64 high-priority
> dispatches [...] refilled only when the transport next idles.
[...]
> Open questions for the list: is the budget (64 here) the right
> shape [...] And does the cooperative framing hold[?]

Before the budget shape, I wanted to pin down the re-arm trigger
itself, since the whole floor rests on it.  Traced through, the grant
is gated on a true zero-crossing: svc_xprt_enqueue() refills the
credit only when atomic_read(&xprt->xpt_nr_rqsts) == 0 at the instant
new data arrives -- i.e. every earlier request on that transport has
already passed svc_xprt_release().  Not a low-watermark; exact zero.

My worry was that a sustained interactive flow (a tree walk holding a
couple of RPCs in flight) never reaches zero, spends its 64 once, and
then rides the normal queue.  The measurements push back on that.  I
put a kprobe on the in-flight depth at each committed enqueue and ran
a cold v4.2 loopback walk of a 7500-file tree (~15.5k server RPCs):

    depth 0 : 25.6%   <- re-arms the 64-credit budget
    depth 1 : 62.3%
    depth 2 : 12.2%
    depth 3 : ~0

So zero recurs about every fourth enqueue.  ~3 credits spent between
refills against a budget of 64 -- the credit never approaches zero and
the flow stays high-priority for the whole walk.  Uncontended, the
"== 0" trigger is far from one-shot.

The catch: this can't reach the case the series exists for.  Loopback
nfsd keeps up, so depth collapses on its own.  The demotion risk is
under pool contention -- aggressor saturating the threads, the
interactive flow's replies delayed, depth staying elevated, the
zero-crossings that refill credits becoming rare.  I couldn't build
that window without your per-op service-time hook.

Could you run the same probe under your aggressor + 10ms hook?  Keyed
by transport it separates the interactive flow from the aggressor in
one histogram:

    T=/sys/kernel/tracing
    echo 'p:svcenq svc_xprt_enqueue depth=+76($arg1):s32 \
        flags=+56($arg1):x64 xprt=$arg1:x64' >> $T/dynamic_events
    echo '!(flags & 1)' > $T/events/kprobes/svcenq/filter
    echo 'hist:keys=xprt,depth:sort=xprt,depth' \
        > $T/events/kprobes/svcenq/trigger
    echo 1 > $T/events/kprobes/svcenq/enable

(+76 = offsetof(svc_xprt, xpt_nr_rqsts), +56 = xpt_flags, x86_64;
unchanged by the series since xpt_hi_credit lands after it.
depth=$arg1->xpt_nr_rqsts.counter:s32 might be a cleaner approach.
 filter !(flags & 1) keeps only committed enqueues -- XPT_BUSY
clear at entry.)

The question that settles it: for the interactive xprt under load,
does the depth==0 fraction hold up, or do you see depth>=1 runs longer
than 64?  If it holds, the trigger is fine and the uncovered tail is
just the N>64 knee you already document.  If it collapses, that's the
argument for a low-watermark refill rather than exact-zero -- and it
belongs in the cover letter, which currently asserts "idle" without
showing an interactive flow reaches it under contention.


-- 
Chuck Lever

