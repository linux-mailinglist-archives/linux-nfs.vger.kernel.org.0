Return-Path: <linux-nfs+bounces-22280-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U7gqEtStIWqKLAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22280-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 18:54:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958AB64218B
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 18:54:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DURHXXdp;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22280-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22280-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC9C305F706
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0B47CC85;
	Thu,  4 Jun 2026 16:43:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC653B2FFB
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 16:43:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591408; cv=none; b=XvqQ5glWYGB+107BBKSCc6uUSi2PoHr4RaitjuiM4Vqawn+H8UhtPiy+dKe+EoSZyFrIEqsUz8iDsXy83BIL8eJIZr6OZLHDWK3Q5NgloSYZi79AavJ3ebTdtiPIxMacXKznHA6EEV+7RcxsBHOWJxrgPni1Tw1FKl3xU5PqrQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591408; c=relaxed/simple;
	bh=mA3PSmWcJV7UiBTiHUuROASAODwhm5CExH5rToO3McI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PRpCI7ntKXrI7szpiIJ65kQukE8Tv/KCWPUpdFt3SkCu9nNU/RKmdEJNojICEREwLs0N60LgyZmmudt7kLJgjrftDwP3uM1iulsq3MAULTINzEpIwOjwesWSD9qau/VL2W+tMxSAzNbbE8eXYY4Z7ov8Q5g5ZdRW3MGSy7HckgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DURHXXdp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DC21F00898;
	Thu,  4 Jun 2026 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780591407;
	bh=BX7DZPwVDBgRPk+DaaqDp+7naFIF6ookioeh0sc2YqI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DURHXXdphaQjOypB78muWBhQJwpFRwkiIvlMxFFXqe/87hiVlZAyJY+ZXekTdx6nS
	 lHjUHvj0PTNYDR4ZuMCN+gUVSDEU0MpQrZ9LXhObLVZj2MbVbKRF/yGxo2hliqQsIg
	 Znm6FND30IdwD/CFvIjY1oMbtZSQMHYXNAKLqxcHAR02ZZeVO9DECBITl5PgtKsMni
	 vb8n6DaY1q0Tcqjv4iNdk8gy3LLaJZPNfIoYY/fipyPZgIO4e/sApUFw1Zeq2WMuon
	 929uClaaaLQ7wavskk80HVGp8zOi9YO5h9XJYl6y5sGGzuvGhCAkRV0UMVjIxgtr9K
	 VojzTWRaHdXeA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B6273F4007D;
	Thu,  4 Jun 2026 12:43:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 04 Jun 2026 12:43:26 -0400
X-ME-Sender: <xms:Lqshaq98MGKDqjtvftgHYMAzKkl1fmizoCZFpj7wQyOLn7WZK6BGSg>
    <xme:Lqshalgkje2RfgMej40ov2fQfjiQZaRfKGSbRorKhmv9cPKhpTKwrqjTnTBKDAGk0
    R1n_xDMkV6AlPWgEecMAyx4yosCCNGf75r3V6ARnmTxOPOdSDYCdjo>
X-ME-Proxy-Cause: dmFkZTGm3M+YFZ7mCR3BmAI21nXFlDtnbywOCnieRT5/BQPRHwYjQY4B5dtHayPOI1VFk8
    OAqY3y1+YmXK7Zg85hnxHxwnaWDcXpg5Z+DDGLHbs31cELlASEQRqmvzLohuvLsPua6nfA
    Ygbym/uzk4ZbswkzYMLmDx1CZGrb9rtdAamwCs597YhJMNnBtTsFeuaqYwhvImk61XfeQD
    M12HhqwUrt4OrlSLjHnPOm5HTjdjJUAtnh10sWwyhhDIYXfN/KTLSPVm+u+GeHDk6CrgSU
    dzBjVyPY/qfk2bzTQ5M3LanDmfGdJkRBYRoxTVQ5sUl+JKuFDjqWKQJMgqjUv+Gso3GOQO
    MuQsM4h1SfHFh6sB+9E3K6BlRRvJ7r98/arxrkwnby9mH0CVIpU/zlLSwee9FJe1O6IdZT
    JaWTzak3zGzlQx+N5pwavB3j4+eVjgzYyKca1af7C89DAvQOoWdifrpPf/0C+SAcCis3fp
    fA/a5lvWWqYgiGyD4das6meq7jOgm0ggy+rbfIsM/YKdDGBLjDsUhJ+aPGrRkCBYpYMFnH
    aN3731y6/ZOEFxpxaVsnaYUFTxbpZNHY5fgWzg8g1HGVr0WCKcQeayIqOgEUB+colarmnh
    zP0vf43Bjb0plMnjaxEz/uZ4VPBhJUWD48wckPXQWCEbvsOzu3ySc0mJDrwA
X-ME-Proxy: <xmx:LqshapjlfcJ2E0vi10bsbfUeSm9nvxqBIbxzKS1DEQYmEKM8qAw-Kw>
    <xmx:Lqshavh7oul6rgETyWoMwJEzongzji_f2B9VBhfX-vmC4KvrRfNniA>
    <xmx:LqshapJVRQOiHgIavAvo-BnWORhPzZyPobjVR5zR0-bZsmu9CmI0xA>
    <xmx:LqshauH0-jHOAaZKIHwEOEs8QpGYkzrGVwY-qq1z417wzAR6JfPyuA>
    <xmx:LqshatSxgfPtTVyI-vpFez6BurcxQqYLYlP6h8eMXvZ-w7LuVDyi2L4v>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 93FDF780070; Thu,  4 Jun 2026 12:43:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJGgz9MML8is
Date: Thu, 04 Jun 2026 09:43:06 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <ben.coddington@hammerspace.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Daire Byrne" <daire@dneg.com>, NeilBrown <neil@brown.name>
Message-Id: <66c34ced-abb4-4615-88ea-c048d704f582@app.fastmail.com>
In-Reply-To: <C13BCFC6-BEFA-427E-8431-DDAC6076C1B3@hammerspace.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
 <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
 <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
 <89ec5776-1a61-4713-b331-bb4edb9f5b0a@app.fastmail.com>
 <C13BCFC6-BEFA-427E-8431-DDAC6076C1B3@hammerspace.com>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-22280-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 958AB64218B


On Thu, Jun 4, 2026, at 9:08 AM, Benjamin Coddington wrote:
> That turns the one open parameter into "how many RPCs is an interactive
> cycle" (N).  I'd rather not make it an admin knob either:
>
>   - a generous fixed default - over-provisioning costs almost nothing, since
>     a sustained stream never idles to collect it, and under-provisioning just
>     lets the tail of an unusually large command fall back to bulk;
>   - measure it - track per-connection burst size between idle gaps;
>   - borrow the v4.1 slot count as a per-connection hint (v3 would need a
>     fallback).

If we can get away with a single mechanism rather than an additional
fallback, that will keep things "no more complicated than necessary"
and easier to test.

> Does a burst-sized allowance fit how you were picturing the sparse tier, or
> were you thinking the single-RPC jump was enough and the rest should just
> share bulk?  That's the main fork I see.

It's a good open question. Why not prototype a burst-sized allowance and
then we can examine the behavior using your test harness to see how much
of a difference it makes.


-- 
Chuck Lever

