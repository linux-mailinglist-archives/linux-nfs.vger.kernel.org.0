Return-Path: <linux-nfs+bounces-22294-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRh9ONbqIWozQgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22294-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 23:15:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB1F6438BE
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 23:15:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b="XV/xGg1K";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="f tz6Qy/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22294-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22294-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DDF3024975
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 21:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AFA3E833D;
	Thu,  4 Jun 2026 21:11:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE73D6CD4
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 21:11:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607510; cv=none; b=NSEozBxXVp1RElaLFmQUTEMEkYPBhjRxyEt/DHxT7nTZU5IDjL/vu7lJQR+l8zegzFhc27nIOus3YSkCi+PBE6Xz9aCrr534sGi4KHSGlFqft8rTOyfFnJOkOnia2PVVmKuraJ3GCMlmCHnji0LyYWwymUd/DrnwMezu7j1+cLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607510; c=relaxed/simple;
	bh=9HFeKzjPdJ1GiYWRSF0GuBhrISAGfB336HsRP919P0Y=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Gb7b1masxlUDh9wFVXePhd89o/5J2c+YsKtFl9jwcJBSLRpHW4olJ1An8QoY+UNqGvdmX11Yhgp2i17rhkW2sh4wEut4ifMmmpNiCFxwXRP62wPDpJo6xBQilbQIj329+MpdRumXJY+YoVoYAkOLcbSejwpJoajxxd0fmAUfN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=XV/xGg1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ftz6Qy/q; arc=none smtp.client-ip=202.12.124.154
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4040D7A002D;
	Thu,  4 Jun 2026 17:11:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 17:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780607505; x=1780693905; bh=rLzv6WxC9lwwvDpuc0uXc5FsN5/eUbtFYdo
	Cx3BY21o=; b=XV/xGg1Ky90mUR9ZclVLPuw0KLMPGDeNXcCtEAv4S3pXuwQ5D2O
	LvrWWAqAcLV296ImOBaLFDGBG/1WRNcXT5kjhuMXUX50b7IB0fztrdC0UziM5qyZ
	fw+ifsEJPB6S13KXJ11mmktYHdz5xkNq9xSIZZSa99elzFiRBujoik8oZxysN9YP
	K9NdEvREkKAK7EZSgAuU7zow77+poCprZPhOugJVtFv1Bg9oZA03jXZAFxtB9kiO
	V5cJaG6lgnckTeaNvlyiFIg9qMKWgv2bpNNgPo1k8w6CGgUTxhL8C6p/iNMvjZj+
	xV+DqBwCudfuIzTg8NeecGkNI0EY+f8zMww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780607505; x=
	1780693905; bh=rLzv6WxC9lwwvDpuc0uXc5FsN5/eUbtFYdoCx3BY21o=; b=f
	tz6Qy/qiYmhRuKu9giTzmrPR+uMv3NFIHo3mhKjxrMZLarBWN38D2DuNR4wegOsL
	7eUSUppy4YDrgzCedNJxVjud/mN4QKx4df3o7dP/hrpYIrBSsAQvuXgriiI7jSAc
	j2qXC6E5KXpxuLruvf1roqDbuP0G9wRkHJ0H1/YxayW9WGqcb0cMVrfdVJubaMBI
	tocvDfNi5r9+8HrqA7TFusbSReRci1D8tspbcAh4WIu4SCPaP+s+U2DPbTI8evf7
	OpnonDyAo82uZvjzLsIJ/P1hvuJX3CpwG3bMRNrG5i76Y2sIxshziOauHnqPxW2a
	w6YsJ6hF6KD6rGTfYm/ug==
X-ME-Sender: <xms:EOohal4wfNTjDVkqYm617i9ikJyEvvsomJ6zdLtdP7mHlK76zzExGw>
    <xme:EOohapzyKUKjKnWLsOzCvqpcBSH7Ccc4itmbNEw6Fxyhp14dg-aizCdcRER09IAkJ
    HPCWJiqkDEt8bYjO5GFS9IbKGPyIUaWtCWpFNy6bnRZtxxoEQ>
X-ME-Received: <xmr:EOohakwHt26RqTRgVb9uxLeHgRJooH47ADQ-uI2V06GKPBlNnYl2a7WPsLBwZGWN9yhjY4iNbUqsBX5hJ44Pa3bmqxYV3fw>
X-ME-Proxy-Cause: dmFkZTF1wJaHx+mi+niNCmPW/NaJ7vHvP37V9gq8Y3H1BB+dXLOMyX4+JBe2zFSbXLDUzI
    jnyhKU83Hp5OebsyBJZhNGpzTYmmkgAHn7aLRH8iKU+iIwWvPdwGZY8AEUSPdUvQDw3OfU
    wezOJlHRl57t5DNHMyy0t837Os5fNt5bCL53RSUZxlgj3wsAMGVu7C56nSV5ZTrTO77noq
    TUTF3rNCUPtlaH7ca1rY19s9k7xF8W+XkJu0TSqp2SUVETcPo5lgAgCzdcc8KGejrN7yZL
    +ngq7ERgM9Er4hY4Rpo3iwnDhxD5U9WAnQdlpN8MME4eqvDuLa8dqVBoJr38mbR8zxlnYm
    55hs7Y3n3dLh1y418w05usVSvzZFGXcEAenHjRqCeIKrdLMRYfyWSrSbXG0/daDLPiUhhx
    GI+JOsVM0Y3CJqz2Hnb/zQXMECA5zujzrjunOrwQwf1QvJYeVRjGyVqu1e2/FRo3yMnKFR
    59VDvzlu5NkVYSzMqXeraRn+9BaGLMxk8bDqUOjfO8EIw/Lan6G/dBYhLWtrjlVOyBQfOz
    nHYEXLvqEXh66Ivz//6EWx4E/tJsxJEbv/wfl9RafR/i23DIecV9llImUqfS+xARzOfilH
    fhAdxcl73FitYgrB/E+C62VaSA2Sz9r/ocoshwENVV+/LDpAoF1LRHDW0ceQ
X-ME-Proxy: <xmx:EOohapyNLbyednzSdoZ-SjdeqP_Le-vRPXj55ZHjVYaJhL5yg3RwVw>
    <xmx:EOohamYwhRUWGyD3yMzUBU6XiE8IHKZ02qP7NS1yjDrfHXG3h4d7XQ>
    <xmx:EOohaiWZNen3gzxvARmZdy6Xvdm7tUlmTJK9WBlNs014Mc_XVd_Eig>
    <xmx:EOohasi6vg2fjBtCixKHxdDfwUNBSemWYdnu8-ATIYtH9hPOKdJ6QA>
    <xmx:EeohatNhumbj3fnRVJGG9loOnrtAHXNSgg3jtiXKA1RLiNTil9fL_izO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 17:11:42 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Chuck Lever" <cel@kernel.org>,
 "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Daire Byrne" <daire@dneg.com>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
In-reply-to: <C13BCFC6-BEFA-427E-8431-DDAC6076C1B3@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
  <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
  <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
  <89ec5776-1a61-4713-b331-bb4edb9f5b0a@app.fastmail.com>
  <C13BCFC6-BEFA-427E-8431-DDAC6076C1B3@hammerspace.com>
Date: Fri, 05 Jun 2026 07:11:38 +1000
Message-id: <178060749888.3392745.1825875653073966173@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22294-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:daire@dneg.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEB1F6438BE

On Fri, 05 Jun 2026, Benjamin Coddington wrote:
> On 4 Jun 2026, at 10:54, Chuck Lever wrote:
> > - I'm not a fan of adding administrative controls, and these days, a
> >   module parameter is outdated and way too global. I'd like to see
> >   that removed until we have a clear need (use cases) for tuning
>=20
> Agreed - I'll drop the module parameter.  With the reframe below the fair
> path is cheap enough to be always-on.
>=20
> > - Having to rely on client identity is going to be difficult to get
> >   right. ... fairness-by-client-address means all clients behind a NAT
> >   get reduced to a single fairness unit.
>=20
> Agreed, and avoiding identity entirely is most of the appeal of the
> reframe - it also gets NFSv3, NFSv4.0 and LOCALIO for free, which solves
> the no-session problem you raised.
>=20
> > - The observability you proposed ... worth ... making it a part of the
> >   patch series
>=20
> Will do - I'll turn the latency-injection measurement into something that
> stays in the series, but it's probably not appropriate for any final
> inclusion.
>=20
> > Instead, we could look at the problem as "preventing starvation of
> > any one connection" ...
> > fq_codel's success comes less from its fair queueing than from its
> > sparse-flow optimization; that is, flows with nothing in flight jump
> > the queue and heavy flows share what remains.
>=20
> I like this - it dissolves the identity question, and xpt_nr_rqsts already
> gives us the in-flight signal to classify on.
>=20
> One wrinkle I'd want to get right first: what a user perceives as
> "interactive" is a command, not a single RPC, and a command is a burst of
> correlated RPCs - loading a web page whose browser cache is on NFS is a
> readdir, then stat/open/read across many files.  Plain sparse-flow grants
> priority for one quantum (~one RPC for us), so only the first RPC of the
> burst jumps; RPCs 2..N find the connection backlogged, demote to the bulk
> tier, and complete at the aggressor's rate.  The leading edge is fast but
> the command isn't.
>=20
> Rough numbers, ~650 ops/s pool, interactive on one connection, aggressor on
> 16, a 50-RPC command:
>=20
>   today (per-transport FIFO):     50 * 17 / 650  ~=3D 1.3 s
>   sparse-flow, 1-RPC quantum:     ~=3D 1.3 s  (only the first RPC saved)
>   whole command prioritized:      50 / 650       ~=3D 0.08 s
>=20
> So to make the command feel interactive the priority allowance has to cover
> the cycle, not one RPC: grant an idle->active connection a budget of ~N RPC=
s,
> re-granted each time it returns to idle, rather than a single jump.  This
> stays identity-free and connection-count-proof for the same reason your
> version does - a sustained stream never returns to idle, so it collects the
> allowance once and is in the bulk tier forever after, however many
> connections it opens.  A user-paced connection idles between commands and is
> re-granted each time.  (This also naturally covers Daire's
> workstations-over-render-farm case: bursty-then-idle vs sustained, no subnet
> config.)
>=20
> That turns the one open parameter into "how many RPCs is an interactive
> cycle" (N).  I'd rather not make it an admin knob either:

There is another parameter: how much priority boost do you give
"interactive" tasks.  You cannot let interactive completely dominate
batch, else a sufficiently large number of interactive clients can
starve the batch clients.

>=20
>   - a generous fixed default - over-provisioning costs almost nothing, since
>     a sustained stream never idles to collect it, and under-provisioning ju=
st
>     lets the tail of an unusually large command fall back to bulk;
>   - measure it - track per-connection burst size between idle gaps;
>   - borrow the v4.1 slot count as a per-connection hint (v3 would need a
>     fallback).
>=20
> Does a burst-sized allowance fit how you were picturing the sparse tier, or
> were you thinking the single-RPC jump was enough and the rest should just
> share bulk?  That's the main fork I see.
>=20
> I'll rework the series around this - always-on, no module parameter, no
> client identity, sparse/bulk tiers keyed on xpt_nr_rqsts, measurement
> included.  I also owe new numbers: my current harness runs every connection
> at a fixed window, so the "interactive" client is actually backlogged -
> the wrong shape to show any of this.  The metric that matters is
> command-completion time versus the aggressor's connection count.
>=20
> Thanks for the reframe - it's a much better-shaped problem.

It seems to be a completely different problem, but maybe I misunderstood
your original problem statement.
You seemed to start out focused on nconnect and wanting fairness between
clients with nconnect=3D1 and those with nconnect=3D16.  Is this not what
you really want?

The "interactive" frame can only work for clients that are single-user
or few-users.  A non-trivial multi-user system could easily start
looking like a batch system, at least in bursts, and this could give
users surprising changes in latency.

It might make sense to add an "interactive" export flag so that some
clients get a boost.  Manual configuration is best avoided, but not
always possible (which is why we even have export options).

Ideally the client would determine what is "interactive" and use v4.1
sessions to put "interactive" on a different session to "batch".  Then
it should be easier for interactive sessions to get an appropriate
share.


Thanks,
NeilBrown


>=20
> Ben
>=20


