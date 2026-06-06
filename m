Return-Path: <linux-nfs+bounces-22337-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wJfBDW4gJGrQ3QEAu9opvQ
	(envelope-from <linux-nfs+bounces-22337-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 15:28:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F9A64DA0F
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 15:28:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="oI13+Lu/";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22337-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22337-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03FBD3035146
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349FC3B14A1;
	Sat,  6 Jun 2026 13:26:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140F3B0AF7;
	Sat,  6 Jun 2026 13:26:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780752376; cv=none; b=hz6+U10/5tnwOJuhpdMwwvv8pGoKFvjgICbIy3PJkD0pvf3JC7y+KMSgSB/A6GI5fSuqJePMZXJYdsvGC06Tz+flYEroUbVEiOfOKiGPGyunHgUxvEWd4z8784N69wA6aWhTMWWSEpGr+wXYbKtAPvVnOb/yrfqS53dtxACAb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780752376; c=relaxed/simple;
	bh=RqQoZ9z1Lym1xYMmFWmRQ0chfBFr+J0rV55uAFb7ZOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iyzk8OH/2CiBzI7fJcSaqHt5HVYP4LmvFl+UQLJjqGNnGSryq7x0cMu2u23xATvLea7PNADkbIZitiGvO0LUrdA2GWA8/V2T3P0gzknPF7ONiaVYu5WgYcIHmzgQBQwSgbVDBDnsiDvOR+LnQ92XL7AjHtPcZ8HFnxKw+3MDQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI13+Lu/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FE61F00899;
	Sat,  6 Jun 2026 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780752374;
	bh=+FqAAnA8dYwt8xLhb1Q8Q4soQE8ybLPwmVGYaNeutXo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oI13+Lu/MKHg/lG3sxd7jnEZHZqAzoszOyELEEThKDmWsNtAiFcuHaufDe32YGHv5
	 a8NAHWqrLMNZQwzVgf+EsScB2SmdSXUuv5lk0mvKHNVwRQ7bqbhyg/5yN/cAuSglfp
	 D+3MxKrHSm+siGjWEQUSL08G0mdlhTeQefQ2U69RKVWIIEYefQxEtTWVH2KBGBqrye
	 oFc26VwRs5je3wvbQxuVDGsK4CTNOzVunXCTkEwUox8XpTuclYDO86mWVEpSOC7M8X
	 BAEt5Tz2W5S5oQnfxb7Fh5EdHun4kaI7Pcg9sMFyWcr2Qs1k569OuPKD6MmL5hQXrX
	 Y0naJFak8ZTMg==
Message-ID: <cbb8bf9325d5877d8e736b42f2ffde01dc7e2739.camel@kernel.org>
Subject: Re: [PATCH 0/9] Deliver TLS session tags to upper-layer consumers
 (NFSD)
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski	 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman	 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan	
 <skhan@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 John Fastabend <john.fastabend@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>, Keith Busch	 <kbusch@kernel.org>, Jens Axboe
 <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,  Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Sat, 06 Jun 2026 09:26:10 -0400
In-Reply-To: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22337-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F9A64DA0F

On Fri, 2026-06-05 at 13:34 -0400, Chuck Lever wrote:
> NFSD and similar upper-layer services want access-control decisions
> based on TLS peer-certificate characteristics, but in-kernel x.509
> parsing would duplicate work mature userspace libraries already do.
> This series gives tlshd a way to evaluate certificates against
> admin-defined policy and report matching policies back to the kernel
> as opaque string tags. The handshake layer plumbs the tags through to
> the upper-layer consumer's completion callback; intersection against
> per-resource tag sets stays the consumer's problem.
>=20
> Four architectural choices shape the series, only one of which is
> visible in any single patch.
>=20
> The tagging vocabulary is opaque to the kernel. tlshd decides what
> each tag means; the handshake layer and its consumers only test
> membership. This keeps x.509 out of the kernel and lets policy evolve
> at userspace speed. Any future attribute the kernel wants to gate on
> must be expressed as a tag rather than as a new netlink field per
> attribute.
>=20
> DONE gains a privilege check (patch 1) as a prerequisite, not as
> cleanup. Without it, an unprivileged process guessing a sockfd could
> submit a forged DONE and effectively grant or deny tag membership
> for a real handshake. Once tags carry authorization weight, that
> pre-existing gap becomes load-bearing. The fix predates tags in
> principle and carries a Fixes: tag, but it sits at the head of this
> series so the rest of the work has a trustworthy foundation.
>=20
> HANDSHAKE_MAX_SESSIONTAGS is advertised on every ACCEPT reply as
> HANDSHAKE_A_ACCEPT_MAX_TAGS (patch 6), so tlshd can size its
> DONE-side tag list against the kernel's runtime limit rather than
> guessing from header constants. If a daemon overruns anyway, the
> DONE handler truncates and logs one pr_warn_once rather than
> returning -E2BIG: tearing down a handshake the operator almost
> certainly wants to keep is a worse outcome than dropping a few
> tags. The truncation path is defense-in-depth for a buggy or
> stale agent, not the primary signal.
>=20
> The tagset helper (patch 3) is split out as a generic library so
> NFSD export tagging (patches 8 and 9) can use it without further
> churn in net/handshake/.
>=20
> ---
> Chuck Lever (9):
>       handshake: Require admin permission for DONE command
>       handshake: Add tags to "done" downcall
>       lib: Add a "tagset" data structure
>       handshake: Pick up session tags passed during the DONE downcall
>       handshake: Add a kunit test for the completion gate
>       handshake: advertise the session-tag cap to user space
>       SUNRPC: Copy the TLS session tags when they are available
>       NFSD: Implement export tagging
>       NFSD: Add allow_tags to the netlink export interface
>=20
>  Documentation/core-api/index.rst           |   1 +
>  Documentation/core-api/tagset.rst          | 225 +++++++++++++++++++++++=
++++++
>  Documentation/netlink/specs/handshake.yaml |  16 ++
>  Documentation/netlink/specs/nfsd.yaml      |  10 ++
>  Documentation/networking/tls-handshake.rst |  63 +++++++-
>  drivers/nvme/host/tcp.c                    |   3 +-
>  drivers/nvme/target/tcp.c                  |   3 +-
>  fs/nfsd/export.c                           | 141 +++++++++++++++++-
>  fs/nfsd/export.h                           |  11 ++
>  fs/nfsd/netlink.c                          |   4 +-
>  fs/nfsd/netlink.h                          |   3 +-
>  fs/nfsd/trace.h                            |  19 +++
>  include/linux/sunrpc/svc_xprt.h            |   2 +
>  include/linux/tagset.h                     | 187 +++++++++++++++++++++++=
+
>  include/net/handshake.h                    |  30 +++-
>  include/uapi/linux/handshake.h             |   4 +
>  include/uapi/linux/nfsd_netlink.h          |   1 +
>  lib/Makefile                               |   1 +
>  lib/tagset.c                               | 174 ++++++++++++++++++++++
>  net/handshake/genl.c                       |   7 +-
>  net/handshake/handshake-test.c             |  72 +++++++++
>  net/handshake/handshake.h                  |   6 +
>  net/handshake/netlink.c                    | 109 +++++++++++++-
>  net/handshake/request.c                    |  68 ++++++++-
>  net/handshake/tlshd.c                      |  10 +-
>  net/sunrpc/svc_xprt.c                      |  11 +-
>  net/sunrpc/svcauth_unix.c                  |  12 ++
>  net/sunrpc/svcsock.c                       |  38 ++++-
>  net/sunrpc/xprtsock.c                      |   5 +-
>  29 files changed, 1205 insertions(+), 31 deletions(-)
> ---
> base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
> change-id: 20260512-tls-session-tags-9d0042583f44
>=20
> Best regards,
> -- =20
> Chuck Lever <chuck.lever@oracle.com>

I was wanting to review this, but I can't seem to get it to apply
cleanly to any known tree. What tree is this based on?
--=20
Jeff Layton <jlayton@kernel.org>

