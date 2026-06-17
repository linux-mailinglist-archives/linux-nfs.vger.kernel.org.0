Return-Path: <linux-nfs+bounces-22655-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v8M0DNWeMmqC2wUAu9opvQ
	(envelope-from <linux-nfs+bounces-22655-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 15:19:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C669A08E
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 15:19:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cfi4KGDj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22655-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22655-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9CBD302A4D0
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2026 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483AD3F54AE;
	Wed, 17 Jun 2026 13:18:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F33BA24F
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 13:18:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702339; cv=none; b=ME7vxKq4C8UcjWdff+5IPhF4xIXu9ObayW9fqdCaPUIPKbPQxNFTv5/Jv7vyXNU2GWQsMm/6u1TU7OGL2+3TGkft77mqPxROsrPhWV7djr3XyUxGA2qBfHkddey7MRJwQWq0atX66YSC1DTvanPPDHQXmsY6z5dkcK7RRaUIzIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702339; c=relaxed/simple;
	bh=MCAypqSEWPXsEFXPz2qoNnRNhvNTfkLMsLZZUXXySf4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OoUoDAPbX04zIo7H5Q7jpM0HUQaQP3edlH+suU+KIdz3bo2fRfR3qOYsdO1j7sZmJxY0lT0SwfXc8Zl+a9Y2GAHJaGZKu5I1PsSQNV+2em5EUOq2LX8rHjqw96KmK/fw48bfEVe59Qz1CgA08xgzLYA1Ru/HuOeMHh2GR+9MwJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfi4KGDj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA09C1F00A3A
	for <linux-nfs@vger.kernel.org>; Wed, 17 Jun 2026 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781702337;
	bh=MVhbRcdA1xDXlsYG/sfXr+FrevoalaWtFswAD9w8/90=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=cfi4KGDjG21HBOArkfImfsPKz+ylxW3yVHEsJ2NCk2grV1hulcHDL5ZUYd/UN+khk
	 0ZqnJzqovOUOWfFuDUdkDssxXSHNAIJRTOoudN5mywVfOu/9ko2XZko9dJANqM4xp1
	 fqCcd5I4RzQ9THi05OKAV3hhZv4eENr7Za6josLzOC7UrHuMhBqxLCw7j1w9QZKSpS
	 4UT1dFjHJlPnW6/GfkZ0Gn2Fv2Ck2UT2CL+6u6RvcKNuLmRHA6ioETmSxUsM2XiCT4
	 JfQHqb6YMhslCd6yKI+LouRH4i+vPZCqaPMoRdSKtKz88z3g5WKFsg8WQsCTEnFKnd
	 QOhloOGU4n7mw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBE3DF4006C;
	Wed, 17 Jun 2026 09:18:56 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 17 Jun 2026 09:18:56 -0400
X-ME-Sender: <xms:wJ4yahmRj1T6wfTflJuu2JhVE-BV4rhi-HuWZhiFcNiWNwyGmc7OXA>
    <xme:wJ4yanoRGEo5EliYVHsX6IU3XWkNTLzfDqG5YN_qK8R4Rq1mg5HiulHvYi_3L0ESE
    OF5Hh-X14bNaZLbHUEoMk7Gaj3yA7vyTP8l-p-MDaerUVs7jzSzlbQ>
X-ME-Proxy-Cause: dmFkZTGqhwF8qMmJc8Pnm7GyfiDyBvTp8NUSsmtxVtJaaP5imxaSlN6PUQFlwhEuQ/Ilnr
    XRzkAiXMZbVCCK98Dpru9I5Z2Rh/GJxNocKYjsG39dkDeS3Hr6ZGZckB76CFAXQegcN34y
    DCdBw00lL5sxvIHtOoS7SjkRT4SYp1xBpzj6KZhcpu5/h8TM3cfskK44uprE2pZo63EXFO
    5UjfRX/3q++MEP4xmnDCeT6c0Nk6LaCug5+thGKo0WnICHnY5bfcn009qs+Ln+cfFy9kXq
    9+5jZlsBa2mICLCeO3GKbydklMj8RmeEf9Ik2djQqrnpEVplz9lflpMLTB1fnNdjyrF3Ye
    NDCOCXKLNS2IZEXCmROXRl2TM12gIcA/iZSQyMbPUh0potckK1nv8ZCAISDIGHliQt0Dm9
    F5DGFlolQx0eCikSd5xoleztpdqQo2BUZNbu3w5Lh8VXBlEIKZ6m4dUgg9J8iernkmOGHS
    +K8oEFFs3eU13KDYatdQrhcpzJT7ydVtQfK/n/pXbhjg6amGfGlnj+7SSJdukJu1Q9VL61
    ORe5X3B+DWc5dcgREz3xLAHgHgae3FrOUkIzGBdMOE0msjBuW6VMduJS48u9sLmFgfQGwu
    jJi4yzMv70J2fea4aEiAW56x/oFrrI6pgStRSpMW5l1XXWT8wYPrJ5l4CtnQ
X-ME-Proxy: <xmx:wJ4yapxdxoRoZAlIzFty1M8UJqSnWfMhSIIJ5wV97Cy_Vo6W1Ly2lA>
    <xmx:wJ4yavR6Yi0xnT0Olo8OO3QrtOUUgNuL8gAgsifUBHqBYiiQDWLCOA>
    <xmx:wJ4yauL6FVK4_TA5_k47JtVkNYJIS1MlNGc5hlxzRxWH71TP3cmWqw>
    <xmx:wJ4yauXujLk9hY8U0Y_mPOfZZZsfIRig94C3-PHDfmfxCIU46HnzHA>
    <xmx:wJ4yaqQ3OvrEARWG1aXULQKYDR4Vacd-PzB3IqnwITqSNQfN09cNDHfN>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B56DC780075; Wed, 17 Jun 2026 09:18:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6cWk2i3Rrw
Date: Wed, 17 Jun 2026 09:18:36 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <c62cacac-dc7e-4203-b83e-000d04f797fb@app.fastmail.com>
In-Reply-To: <657f71a2c6dc1e817be57e40431a6578281ea823.camel@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
 <20260616-exportd-netlink-v4-3-03505aee3883@kernel.org>
 <e55738ec-80a5-4e74-85e3-29c17d4f67c9@app.fastmail.com>
 <657f71a2c6dc1e817be57e40431a6578281ea823.camel@kernel.org>
Subject: Re: [PATCH v4 3/4] nfsd: implement server-stats-get netlink handler
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
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22655-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C40C669A08E



On Wed, Jun 17, 2026, at 7:07 AM, Jeff Layton wrote:
> On Tue, 2026-06-16 at 20:57 -0400, Chuck Lever wrote:
>> Hey Jeff -
>> 
>> On Tue, Jun 16, 2026, at 8:45 AM, Jeff Layton wrote:
>> > Implement nfsd_nl_server_stats_get_dumpit() which exposes the
>> > NFS server statistics currently available via /proc/net/rpc/nfsd
>> > through the nfsd generic netlink family.
>> > 
>> > The handler uses a dump operation to stream statistics across
>> > multiple netlink messages:
>> > 
>> >   - First message: all scalar stats (reply cache, filehandle,
>> >     IO, network, RPC) plus per-version procedure counts
>> >     (proc2/3/4-ops) using per-netns vs_count arrays.
>> > 
>> >   - Subsequent messages: NFSv4 per-operation counts
>> >     (proc4ops-ops), one entry per message, using cb->args[0]
>> >     to track the current operation index across dump calls.
>> > 
>> > This allows nfsstat to retrieve server statistics via netlink
>> > with a procfs fallback for older kernels.
>> > 
>> > Assisted-by: Claude:claude-opus-4-6
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  Documentation/netlink/specs/nfsd.yaml | 105 +++++++++++++++++
>> >  fs/nfsd/netlink.c                     |   5 +
>> >  fs/nfsd/netlink.h                     |   2 +
>> >  fs/nfsd/nfsctl.c                      | 206 ++++++++++++++++++++++++++++++++++
>> >  include/uapi/linux/nfsd_netlink.h     |  35 ++++++
>> >  5 files changed, 353 insertions(+)
>> 
>> The procfs output in nfsd_show() emits one more counter that this dump
>> handler drops: wdeleg_getattr (NFSD_STATS_WDELEG_GETATTR), printed at
>> the end of the CONFIG_NFSD_V4 block in fs/nfsd/stats.c, right after
>> proc4ops. The netlink dump stops after proc4ops-ops and sets
>> cb->args[0] = -1, so the write-delegation GETATTR-conflict counter never
>> goes out on the wire.
>> 
>> There's no schema slot for it either: the server-stats attribute-set
>> ends at proc4ops-ops, so a consumer that prefers netlink and only falls
>> back to procfs on an old kernel loses this counter on every kernel new
>> enough to support server-stats-get.
>> 
>> I Suggest:
>> 
>> - add a wdeleg-getattr (u64) attribute to the server-stats
>>   attribute-set in nfsd.yaml and list it under the dump reply
>>   attributes;
>> 
>> - add NFSD_A_SERVER_STATS_WDELEG_GETATTR to the uapi enum, after
>>   PROC4OPS_OPS and before __NFSD_A_SERVER_STATS_MAX so existing
>>   values don't shift;
>> 
>> - emit it as a single scalar in the start == 0 message, wrapped in
>>   CONFIG_NFSD_V4 to match the procfs side.
>> 
>
> This omission was intentional. The stated purpose of this patchset was
> to convert nfsstat to use netlink. nfsstat does not access or display
> this field today. Without something that consumes this stat, I don't
> see the point of adding it here. We can always add it later when/if it
> becomes useful to userland.

If we were adding a greenfield kernel-userspace API, I would agree.
However, this API is meant to be compatible with the existing
procfs API, so it should match to prevent a regression (I'm not
aware of a consumer, this is only a general guideline).

For future reference: since a missing feature cannot be expressed
in a patch's diff body, your intention to exclude this field could
be mentioned in the commit message.


> Is there something that accesses this today that I'm not aware of? If
> not, is there some future intent to add this to nfsstat?

I think nfsstat should display the wdeleg-getattr field. It has simply
been forgotten.


-- 
Chuck Lever

