Return-Path: <linux-nfs+bounces-22338-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YqKXASQyJGoU4AEAu9opvQ
	(envelope-from <linux-nfs+bounces-22338-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 16:43:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB48264DBCD
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Jun 2026 16:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i29Dzy3m;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22338-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22338-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C12A300A24E
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jun 2026 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC2346E40;
	Sat,  6 Jun 2026 14:43:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF92F4071C3;
	Sat,  6 Jun 2026 14:43:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780757022; cv=none; b=JC4fWbg/ubeaSVzWTHl5yoGzvCDTBM0Hf21g+2/51uj/S8wD8v5zM2CPfo9BNiVLoawXZ9xHu4abRvds7fL3E40HhXaoKHR/dkMwiiNzXmh23a4/Hqw0kQZ8a58IMubq3pb16Z5ZKG7SPUDCdc1vZkx2zLZG71i4Ple8GgvH5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780757022; c=relaxed/simple;
	bh=a+OdDYPpATQec036hI/xaSLFO74hocIsV5vnu7E04iI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=onGQ0Fvx1CiPsBwZBAfLyjbwf0N+p/9Z8m9z6tEEZQK85C3VwU00k9s4dqS1xuwqhFEYOayHeOkLjESuVvifOomK9wEV4bwcYnqR9AwFxQ+B53Y5SA4zQixipnunprtwsiTsGIRzLctS1oMVO25hD3Empj0utluQsYy0GGlkALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i29Dzy3m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B7D1F00898;
	Sat,  6 Jun 2026 14:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780757021;
	bh=j9/rxncOVJQdf3WrC5LokDwMbFsp3+6id0NaDbR7R/o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=i29Dzy3malyvnIMdK68wtOB7VLALHV54K8KO4StF522VMnfYf0tMmN+Y4uVY+gNeX
	 /o88Jud8gJ3gipAndDDv/3sNBv0gPVyR0h4N1ApnDAoANUUBM8krGI6moSzlnPbzyh
	 q7cW54OBIfpBjmRajEyOx9r/FlVrnKuFMalhoB+OOuB7rf/P/DwiD4ARa2dwlSneq3
	 5OgaLn6ndEm0Q5ZoZc3d5N+JAtKT87S+taFY5Mg0SLuL5XRe/algVvH2dqFtvj9moV
	 SZpxjXN8v3NQ/9oiqatYB89vKgT484eH9yaybko3oTtc0NDq/sogLeoAqYqf3ZgVCT
	 i47S6c2cDM34w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 27FD6F40080;
	Sat,  6 Jun 2026 10:43:40 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 06 Jun 2026 10:43:40 -0400
X-ME-Sender: <xms:HDIkatGvC0CdAHf4PwO56HYwiW-1IIKuXN4t4L86pHz2NKBS69UIUQ>
    <xme:HDIkatJ1KvMK2DpSVCHmN6paHnd3AsMUEShk2Kc1jDYjkqhmMvCaopCPtD5f0Sy0r
    gFoOa0XI3JbZxM_OzbMYrAP-yqOewq3V1LvrcN4Aj0tfLntGhfNL0s>
X-ME-Proxy-Cause: dmFkZTEUeB0sMSCB1BLAAfntTLokbcu3We/mJtkfQ3Bhx0+gg34v+F1FZmEmD6OrAdv0jY
    L0ZhnvdXsLckDDVeoCkmavi3Qiu4cRgLVny27TXjhaePcLZ7Qwi6awa0lqlf23y9NIctya
    zKY2gguliLTdmYNqKG5iLkZjE7U4YqBfvCzgM/OMm8CG2VOJfUleRmiXKjQxAmX4IowXkb
    AD8YFZoDcbSHrMQYvt6OIQj5eHxauxVdmFmC/dhLchIZ1EeStLZ1QUtdeKPOAmOLRZDH72
    RvyAAzplNZXzsH24wz4IoHiR4vg8OCdGU3d+ENB4BQk6SBE6ojkulwZiWEdKPkYAR8IxCe
    VWbTYJjVZYVoi/sBg7yPVKXIajigS+oKlphTRa6HpxbIj94r0ADWOx2w95japhq5SCvGL+
    1/FpbJyRS/oDNJcUvPhQZgnvKRqq2kAhbVA+vgFLWeBSTpRr1vFASZ3g4M0Rur001XT03w
    9RmGSpbaYuszI5N+38BqCYHTjjF32p8mKmNl257juV1S7ikiFj846jGd9RxWbJukq2YxQ8
    rv1kyUfg87QwX0LFyvGJSIeF+RLPT01/TSkNywdokuo5wdJ2id+YSZWS2Hlq+6J/G2sQJ0
    2nTP6NFUga4foclm8d4I9ABOXW7/h0Gd7zkWFx67x0Qx4GGwDPqTLrf1cZ/w
X-ME-Proxy: <xmx:HDIkamCz9usGZU82EEi5v3f6WWkZw5KfDzjQC4wVKhNg5zGdHuHVLw>
    <xmx:HDIkapupYwn2q-PXbfIkm-edfTte8JioYg1OS6gnWEFIL15jUzgG1g>
    <xmx:HDIkajtaYkwtk0dTxHBgvs-5GaXRGiKe-h3RqkOcvT1Uq0Y390S02g>
    <xmx:HDIkalrAeHhkZ1lobnWz-33t246a4yQkcQ-uK9NJxtXvV3Ct0pu89Q>
    <xmx:HDIkanOs7QurCSA_QROVWtEm3xNUq3D5o8CaIzmcPITHUKWcxVZ4BShA>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E0E11780070; Sat,  6 Jun 2026 10:43:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Awlu_ohcY-4Z
Date: Sat, 06 Jun 2026 07:43:17 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Donald Hunter" <donald.hunter@gmail.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Sabrina Dubroca" <sd@queasysnail.net>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Sagi Grimberg" <sagi@grimberg.me>, "Chaitanya Kulkarni" <kch@nvidia.com>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Cc: kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <ca63fcf5-8d3d-4ee5-ac62-fd0af937cf87@app.fastmail.com>
In-Reply-To: <cbb8bf9325d5877d8e736b42f2ffde01dc7e2739.camel@kernel.org>
References: <20260605-tls-session-tags-v1-0-47bd1d94d552@oracle.com>
 <cbb8bf9325d5877d8e736b42f2ffde01dc7e2739.camel@kernel.org>
Subject: Re: [PATCH 0/9] Deliver TLS session tags to upper-layer consumers (NFSD)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22338-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,linux-foundation.org,queasysnail.net,kernel.dk,lst.de,grimberg.me,nvidia.com,brown.name,oracle.com,talpey.com];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:akpm@linux-foundation.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB48264DBCD



On Sat, Jun 6, 2026, at 6:26 AM, Jeff Layton wrote:
> On Fri, 2026-06-05 at 13:34 -0400, Chuck Lever wrote:
>> NFSD and similar upper-layer services want access-control decisions
>> based on TLS peer-certificate characteristics, but in-kernel x.509
>> parsing would duplicate work mature userspace libraries already do.
>> This series gives tlshd a way to evaluate certificates against
>> admin-defined policy and report matching policies back to the kernel
>> as opaque string tags. The handshake layer plumbs the tags through to
>> the upper-layer consumer's completion callback; intersection against
>> per-resource tag sets stays the consumer's problem.
>> 
>> Four architectural choices shape the series, only one of which is
>> visible in any single patch.
>> 
>> The tagging vocabulary is opaque to the kernel. tlshd decides what
>> each tag means; the handshake layer and its consumers only test
>> membership. This keeps x.509 out of the kernel and lets policy evolve
>> at userspace speed. Any future attribute the kernel wants to gate on
>> must be expressed as a tag rather than as a new netlink field per
>> attribute.
>> 
>> DONE gains a privilege check (patch 1) as a prerequisite, not as
>> cleanup. Without it, an unprivileged process guessing a sockfd could
>> submit a forged DONE and effectively grant or deny tag membership
>> for a real handshake. Once tags carry authorization weight, that
>> pre-existing gap becomes load-bearing. The fix predates tags in
>> principle and carries a Fixes: tag, but it sits at the head of this
>> series so the rest of the work has a trustworthy foundation.
>> 
>> HANDSHAKE_MAX_SESSIONTAGS is advertised on every ACCEPT reply as
>> HANDSHAKE_A_ACCEPT_MAX_TAGS (patch 6), so tlshd can size its
>> DONE-side tag list against the kernel's runtime limit rather than
>> guessing from header constants. If a daemon overruns anyway, the
>> DONE handler truncates and logs one pr_warn_once rather than
>> returning -E2BIG: tearing down a handshake the operator almost
>> certainly wants to keep is a worse outcome than dropping a few
>> tags. The truncation path is defense-in-depth for a buggy or
>> stale agent, not the primary signal.
>> 
>> The tagset helper (patch 3) is split out as a generic library so
>> NFSD export tagging (patches 8 and 9) can use it without further
>> churn in net/handshake/.
>> 
>> ---
>> Chuck Lever (9):
>>       handshake: Require admin permission for DONE command
>>       handshake: Add tags to "done" downcall
>>       lib: Add a "tagset" data structure
>>       handshake: Pick up session tags passed during the DONE downcall
>>       handshake: Add a kunit test for the completion gate
>>       handshake: advertise the session-tag cap to user space
>>       SUNRPC: Copy the TLS session tags when they are available
>>       NFSD: Implement export tagging
>>       NFSD: Add allow_tags to the netlink export interface
>> 
>>  Documentation/core-api/index.rst           |   1 +
>>  Documentation/core-api/tagset.rst          | 225 +++++++++++++++++++++++++++++
>>  Documentation/netlink/specs/handshake.yaml |  16 ++
>>  Documentation/netlink/specs/nfsd.yaml      |  10 ++
>>  Documentation/networking/tls-handshake.rst |  63 +++++++-
>>  drivers/nvme/host/tcp.c                    |   3 +-
>>  drivers/nvme/target/tcp.c                  |   3 +-
>>  fs/nfsd/export.c                           | 141 +++++++++++++++++-
>>  fs/nfsd/export.h                           |  11 ++
>>  fs/nfsd/netlink.c                          |   4 +-
>>  fs/nfsd/netlink.h                          |   3 +-
>>  fs/nfsd/trace.h                            |  19 +++
>>  include/linux/sunrpc/svc_xprt.h            |   2 +
>>  include/linux/tagset.h                     | 187 ++++++++++++++++++++++++
>>  include/net/handshake.h                    |  30 +++-
>>  include/uapi/linux/handshake.h             |   4 +
>>  include/uapi/linux/nfsd_netlink.h          |   1 +
>>  lib/Makefile                               |   1 +
>>  lib/tagset.c                               | 174 ++++++++++++++++++++++
>>  net/handshake/genl.c                       |   7 +-
>>  net/handshake/handshake-test.c             |  72 +++++++++
>>  net/handshake/handshake.h                  |   6 +
>>  net/handshake/netlink.c                    | 109 +++++++++++++-
>>  net/handshake/request.c                    |  68 ++++++++-
>>  net/handshake/tlshd.c                      |  10 +-
>>  net/sunrpc/svc_xprt.c                      |  11 +-
>>  net/sunrpc/svcauth_unix.c                  |  12 ++
>>  net/sunrpc/svcsock.c                       |  38 ++++-
>>  net/sunrpc/xprtsock.c                      |   5 +-
>>  29 files changed, 1205 insertions(+), 31 deletions(-)
>> ---
>> base-commit: 4d4d6605de5f91a40335729b6a7cc15e83b280f3
>> change-id: 20260512-tls-session-tags-9d0042583f44
>> 
>> Best regards,
>> --  
>> Chuck Lever <chuck.lever@oracle.com>
>
> I was wanting to review this, but I can't seem to get it to apply
> cleanly to any known tree. What tree is this based on?

commit 4d4d6605de5f91a40335729b6a7cc15e83b280f3 (cel/nfsd-testing)
Author:     Chuck Lever <chuck.lever@oracle.com>
AuthorDate: Thu Sep 5 15:25:37 2024 -0400
Commit:     Chuck Lever <chuck.lever@oracle.com>
CommitDate: Thu May 28 11:34:51 2026 -0400

That's some old shit.

I will rebase it before posting it again.


-- 
Chuck Lever

