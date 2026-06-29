Return-Path: <linux-nfs+bounces-22884-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xA9TFwrTQmqfDgoAu9opvQ
	(envelope-from <linux-nfs+bounces-22884-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 22:18:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5146DE95C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 22:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Xj7a23sX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22884-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22884-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63FAA300D4C0
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D2A37DAA4;
	Mon, 29 Jun 2026 20:18:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0742E7364
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jun 2026 20:18:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764295; cv=none; b=GFZRRCCsRNX0JJAQjzDZ8ISb/fP0H7AKwUoJ/r1cKftl7u/+tNPaDGzIGfQetGhA2ctl8r1LZ61ZjDIPxk8uyLBG9Ri8jSVirEeMdkDd6yDJbEqrLs8hgjSOLwBN4eQrPiViV7OOJkFvU7ZV6NGDoD+Ae+9bC/Odm3fR2nLzyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764295; c=relaxed/simple;
	bh=MRFnh18RDmM5QE542J9VYF2WLJeWBzwCnFHLFR9DlHA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZvcXvt82RPEQ4y0ApVj48fmiHVeObd4aWRR8T/y4s30tUoWhd2ls0p3qYh/kPJAhYnqgJIr89F7NZHcmy3oPjZTcUZHgxNuVjKZzlOAwveI6jHVRZZSxQ+/a08zr5XznLNQsPAGzT8/EUDWw0LXHvB1dY7AD5eB9Pgp5sDGJ/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj7a23sX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508001F00A3D;
	Mon, 29 Jun 2026 20:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782764293;
	bh=pJIuk86xQ3PMkYYApjILtjuhvrtguRKeEA5zCivWvzc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Xj7a23sXRs6cbxE45rKbkmLak/vXlk/WV4lcB3Ek0ikElV2sK5HRDvYbhM/3tD6gm
	 m1M/ckmCbnDdQ8sANBFvYZBNIuwLyzgAGiQdO+DltTdzJW149n07AIDg1CbNwc+xSE
	 WfAy3CODt9ZhSxmAJqz+OB2xeKTMpU+VABtRbmJy1yNSRSH244ShgPmxfqmkJVQnA6
	 FxRmuhrW0mpMwzBV6jG5SDyTo4JrYz6Dw8FxvCddj2NQher9nmlgFfGG95Ku9i+2fd
	 ejgOif/MR28BNSy+12/fydNOJBhbtBsNQNbsH4V8awsz+5Z8X2abL1+xSrKMNRjSB4
	 4/asKx2SJjy2g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 895A5F4006A;
	Mon, 29 Jun 2026 16:18:12 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 29 Jun 2026 16:18:12 -0400
X-ME-Sender: <xms:BNNCag397MClU90Yhpw-GffEn9Te2qEBCGzuzy8hzk0Nz_Be4vU64w>
    <xme:BNNCal5AzHkFyNwYTraix_hMCEScviiAqk_RnZXvoJGVV5ycAmhl1iwkh2JA6iLDx
    QbC1eWutDKzeFpT5711gtrwHv_pLhdfukdH6jkKYJbIyIHIvMl2ZR4>
X-ME-Proxy-Cause: dmFkZTFmwYO7tHK7ICeGc+r9eclsP8lbAMRjvynvlb6+myr9w+zbH9aJqbPOSMl6jvhMic
    8NA6tB9N2aQg9kRaqVkI1TgPNe00Lmhmf6cxZx838GyzJTYzI6E+/scRYS4CyDMNo27grA
    3c55Svt7bAIx4s4q0MVJTXdqOu94pWyB916N74a9yEDMR0ID550XWv45+DJ4xqkA4nYFU7
    yXDDcBlqQmky+WPczNG10N0qzA34EyojgP+2225OB9on00t/p/FXwz+FKzP1XGf6TMcsrH
    JM1Z1BRfIUNtUADTsY0SkTLBGQEGWSz1+3BGQLQcCHCr0VQxYNDXCc4VYiop9Yfr5hhBnS
    KU3x3QX9C8fxULWnrxaTzjsPwVYGlAo3ALH8hL9+zhBvcV1wsTQHRekLS7O5YgAZVPT+u0
    MBgB/N9zt76SG+dndnifOI3nA89chUhOM1opVUOewEDh4pOXXQMrJ2S7PR6JBVRzhtaort
    l6GEsbl7KWecUsJXmFkIIBUi3/B+dfn9xKxDnZi7FDqCO8Xq8oZDrriAT0aQHh4+j7LmNa
    RUrJzgCZ/Wc2CujsJAy+zdOpfuvPlZ8r9s9zC4QWbI38yyG0VJe9v0/66lrVlj44dmP3sH
    47RI5zmf20f/c0o+9kNpxoaCnKofZ5cvC+NV/uBHuiz4begONlVqcxJhwZHg
X-ME-Proxy: <xmx:BNNCasV1g8I32RwvOfcADnVYD6z42FbUZTuP1l1gOC8UfnRen-MKlw>
    <xmx:BNNCajok2YXTAqevCPsQXK3Fk5OboXBuHk8cqimwGq7RBFSkJ7pDxg>
    <xmx:BNNCarBgliHd8r49Urs6xp-l20OsUyQOFGt6n-K8qylB7DqXFZuUdQ>
    <xmx:BNNCanjCJwO_yZ05XUxvoZLyOF-QQW9Jali_wj1F3yY7_5xqCnk4uQ>
    <xmx:BNNCahYGBvuAkOzHiQib8ry1gHIgu1SPZU1TdvYXumAGUYjNyVPJf78s>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 635BF780AB8; Mon, 29 Jun 2026 16:18:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AEhg0xB2aOJ7
Date: Mon, 29 Jun 2026 16:17:52 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Daire Byrne" <daire@dneg.com>,
 linux-nfs@vger.kernel.org
Message-Id: <864fe01e-a284-4066-bbe9-cbe4ed90f1ed@app.fastmail.com>
In-Reply-To: <69C1992C-2759-46E3-90F6-B9B54012D829@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
 <d8efb4f7-fd91-453e-a6fd-1427bdab1cc0@app.fastmail.com>
 <69C1992C-2759-46E3-90F6-B9B54012D829@hammerspace.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22884-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,dneg.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: EA5146DE95C


On Mon, Jun 29, 2026, at 8:41 AM, Benjamin Coddington wrote:
> So I read this as the argument for the low-watermark refill you floated:
> re-arm when depth drops below a small threshold rather than at exactly 0.
> A watermark of even 2-4 would move the W=1 column's behavior out to cover
> the modestly-pipelined flows, while still excluding a real bulk client
> (which sits far above any sane watermark).  It doesn't reintroduce identity
> and it's a one-line change to the refill condition.
>
> I could spin that as a 4th patch for v1 and re-run this sweep against it --
> I'd expect the protected band to widen from "W<=1" to "W<=watermark".  Does
> a fixed small watermark match your intuition, or were you thinking of
> deriving it (thread count, or the slot-table hint you mentioned)?

Hey Ben,

Thanks for running this, and thanks to the clanker too. Two things fell out
when I put the numbers next to the refill code, and together they push me
past the watermark model and toward letting the credit decay more gracefully.

The first is that the budget resets to a full SVC_XPRT_HI_BURST every time
the transport idles; it doesn't accumulate. So a flow doesn't need a high
depth==0 fraction to stay protected, but rather it only needs to hit zero
once per 64 high-priority dispatches. That reframes the W=2 collapse:

0.4% is below 1/64 (~1.6%), so the flow runs dry between idle moments and
falls to the bulk queue. Your uncontended histogram sat at 25.6%, which is
16x above that line. So the question we care about isn't whether the
depth==0 fraction "holds up", it's whether a real interactive workload
under load stays north of ~1.6%.
  
That's the metric we still don't have. The synthetic victim refills
instantly and idles as rarely as it can, so it answers a question we
already knew the answer to: a flow that never goes idle never re-arms on
idle. Before changing anything I'd want the same depth==0 probe under
load against a real workload: a cold tree walk, git status, a build's
header reads, instead of the fixed-window generator. If those stay above
1.6%, exact-zero is fine and we'd be polishing a non-problem.

The second thing is about the watermark itself. Because the credit resets
to full whenever the trigger fires, the trigger is binary per flow: a flow
either re-arms often enough to live on the high queue forever, or it
spends its 64 once and settles in the bulk queue. Exact-zero puts that
split between W=1 and W=2. A watermark of N doesn't soften the split, it
slides it to between W=N and W=N+1. Anything under the watermark gets near-
permanent residency, anything over it demotes wholesale, same as today. So
fixed vs derived is really just picking where to stand the cliff, not
/whether/ there's a cliff.

If what we actually want is for protection to fade as a flow gets busier
rather than snap off at a line, the budget has to decay instead of reset.
Roughly: spend a credit per high-priority dispatch as it does now, but on
the idle transition add back a fraction of the budget instead of slamming
it to 64. A flow with frequent gaps tops up faster than it spends and
keeps its place. A flow that idles rarely bleeds down and slides into the
bulk queue gradually, in proportion to how backlogged it really is.

I haven't pinned the refill fraction, and that wants the same sweep your
harness already does. If you're up for it, I'd love three lines on your
axes: exact-zero (the RFC), a fixed watermark, and a decaying credit. My
bet is the first two are cliffs in different spots and the third is a
ramp. If the ramp lands where we want the protected band to sit, it
answers the fixed-vs-derived question by making it moot.

Let's get the real-workload depth==0 numbers first, because if they stay
high under load, none of the rest matters.


-- 
Chuck Lever

