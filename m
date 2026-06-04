Return-Path: <linux-nfs+bounces-22272-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +EjAF8iOIWp4IwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22272-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:42:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C943E640FB3
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 16:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b="C/FbaxZp";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22272-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22272-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAE2830015BF
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954843AFAE6;
	Thu,  4 Jun 2026 14:25:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276FB220687
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 14:25:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583120; cv=none; b=MxqgH6lVQClEhzKscPbgvfZ24P61tLx6dzd0uhwno/gz/rLzG7U0aOeh/eRFEtHBZdtdhBJ3seYO7aFDRqpZlIYKVCLCJT0gPgXltldjveeklW5rrDW9XXMxio36kIVRxUoU6rKyELKmEWeEGRcjzd9yySM97l5XCm9HZezwqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583120; c=relaxed/simple;
	bh=XWUtl2sdGrcnRgWEK7+zZMMoHF3MWBAaT+zNZJUwoEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBr33N8w4L5bDb4iDWILqMF4aeS12bD/EO3Q77OzFgNEBPv2zIgNPCxZKLQf52Jcrt29Ode/Ptt99rp9uq2AqNpOKxVhJb1sHtllCYZIx3Fn9mX/Qro/pJXLeOt6UPur+Dg40L7kBYd0xtJFM51cW6+7WioHK2qfjgLw2eYMbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=C/FbaxZp; arc=none smtp.client-ip=209.85.161.45
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d7aa0ac18so584602eaf.0
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2026 07:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780583118; x=1781187918; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jrACnl3ZPmuFy+9DmO2mrW5wMH8uk5d7e6f8vA6JPMU=;
        b=C/FbaxZpUXR8G/q5r0zTmWEPCVaciwJu/Yv1aKf+S5GkhHQj6RVeGmAeebj3guOf5B
         YmdTf6fXLCuKmAf+mvi+AO67WftMjmbVItQrB7jOKcFBCkCCP6kzHG6jNa5XSPziU/YC
         AfsaSb8tlDLDRi2LCAik3IDXqwUsv5ydnyRDwIjHHesGi4thsyZVqhBf27W1O7jPwfhb
         yMQn0WmEH2+2uPq2ZPykycZY4TvEEdlnPYCdE4T3A+K/+y0U9P7Ev/hn4AbE78kF3Ruj
         ZHWc89HXmQsNLvUeykAXyo+CbV260TEFheat5ZHTpKW985/+u6okqusYIpMaV0IGi/kW
         XchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583118; x=1781187918;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrACnl3ZPmuFy+9DmO2mrW5wMH8uk5d7e6f8vA6JPMU=;
        b=ZUlr+O/pjP057bRMQIlPFwVwOJozd8uWNFcHIb8nxreUBj6MJj3iycezdPzx9CDYhq
         O9bRe1a16oSmI8Wwg61F7JUpoGJrn1OYpqVpLV2eubMSvud6zO8h40CGaZ62z82aLHuK
         hf1AW1LXF14GzB+T+HWQLQkr7JtkwBknvRbtDWaIRw4DmBU3QPXmCVadKpHML73EM3ld
         +Y7NMZHmXHA4BUNlAh52akBfz3LJsG6Lrh6lW31khNvWVokcFiIAi/LjEj4QRPzCg8F3
         dXnu96jE4VvX1OGrBZDFrpzPwLVcEs15s0LIUPO6HkdUwZ/7WmHtMmHEbWMLmOe69COu
         IjAA==
X-Forwarded-Encrypted: i=1; AFNElJ9MB/dTDHrxBGGTRmfEqQY3/b8aPBAp/0cD2x9O9CVaLXIEh7i7lgc9ZFcMHsdcc63kuiaWg7PriwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpAJO8e4uZJVs4gs/2HXL8Bwq8F9z2Kej9zQbZM8ppbSZ3qG6
	Xv7lEeLeTsEPuANGAMZjly5OOmfBUXgAvXf/onGb0wf9noA7tXNlbL+NSIqmDzW5c3U=
X-Gm-Gg: Acq92OEsud9bsHcTpNtqJAdFAeA4QtVkMtidc7YBmmc05FMv83LfXTJj08SMBPIs5YY
	N8ceIa0b15aEI9e6ymk7bc5Y2uROZoDQo9Af/oDhYgmPa63QwGSYhfQ7hBgadu+cmVbexUFqOA2
	3n55o+oMxcd6mChovAihT6j4UfNGnRkfDNMa30C9Ov0rVjfRS/mNi/qFI5GvsUQgwyHUs+dCPlx
	toBtcjgfCt52s/YhXFAhNMQt+uorUjOtUVOBFwh4IvriNAi5tPKyLxThFL+BgcahAcNGb66EROu
	wG4+PqueqV9TwM0ytRLjQjjEnSfLSk1GCgfxDSgvnJjyFol3MXm8xEbwxIaXMmmxblAgCF1ZHu1
	q/ZZqoAdrmn4idAZOxAGCyRsEyWd7lVGUBP8gaiXUHJphBLRRcJLRXaKekvGkFxuRc59x+iozit
	X6w3KoLdnzzYKa8HeHAvV1FGuV5KAeqabWXC+8ia2SkT0owG8xCHO3ug==
X-Received: by 2002:a05:6820:5459:b0:69d:cfb6:4f4a with SMTP id 006d021491bc7-69e47e90abdmr3702597eaf.15.1780583117955;
        Thu, 04 Jun 2026 07:25:17 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm5730392fac.16.2026.06.04.07.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:25:17 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: NeilBrown <neil@brown.name>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, Daire Byrne <daire@brahma.io>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
Date: Thu, 04 Jun 2026 10:25:16 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <9733CABE-73D0-460E-A710-DA9215E2FC17@hammerspace.com>
In-Reply-To: <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
References: <cover.1780498019.git.bcodding@hammerspace.com>
 <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22272-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:ben.coddington@hammerspace.com,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:daire@brahma.io,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,hammerspace.com:mid,hammerspace.com:from_mime,hammerspace.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C943E640FB3

On 3 Jun 2026, at 18:52, NeilBrown wrote:

> On Thu, 04 Jun 2026, Benjamin Coddington wrote:

>>   - Mechanism: a fixed bucket hash under a per-pool spinlock taken only
>>     on the opt-in path, versus a lockless or per-flow structure.
>
> I'm not keen on the hash bucket approach, though I can't clearly say
> why.

I don't like the hash collisions.  Maybe that's your unspoken reason.
Unlucky client means I still get random hand-wavy reports.

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

ah - cool.  I think this is a much better design, the enqueue is lockless
and no bucket sharing.

> So this would be slightly more work than the current (2 dequeues instead
> of 1) but I think that might be acceptable.
>
> clients would be refcounted by xprts and probably rcu-freed.

This is the hard part - the xprt holding ref to client, moving from v3 style
(by ip addr) to v4.1 (by clientid) on session bind means repointing the xprt
to a different client object, which can race if the xprt is enqueued.

I suppose it's a one-time event for each v4.1 xprt, so could just create
another XPRT_ flag for it..

I'll see what I can come up with.

>
>>
>>   - Would a per-client in-flight cap be preferable to proportional fair
>>     queueing?
>
> A per-client cap would only be ok if the admin didn't have to tune it.
> So the client would need to get some sort of feed-back from the server
> so that it knows when it is pushing too hard.  If we were still using
> UDP we could possibly use packet-loss for that feed-back, but we aren't
> and don't want to.
> With v4.1 we can of course use the slot based flow control and I think
> we should if we can agree on a good design.  With v3 I don't think there
> is any way to get the needed feed-back

I need to fairly queue v3 and v4.1 clients at the same time... :/

Appreciate your look at this.

Ben

