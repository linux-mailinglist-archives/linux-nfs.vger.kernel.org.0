Return-Path: <linux-nfs+bounces-22203-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I3KXHaH7Hmq3bgAAu9opvQ
	(envelope-from <linux-nfs+bounces-22203-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 17:49:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0EB62FF66
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 17:49:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=lR5MSXYV;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22203-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22203-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4235B300230E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 15:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7D3EFFC0;
	Tue,  2 Jun 2026 15:46:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06A3EFD35
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jun 2026 15:46:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415179; cv=none; b=hNpcrnfH8+gp+QiDB5Bl8XTp28HIlmhbEylNM/e2W06sA78GHDRR6qQ8EkYh2/3knAAoXSwVW9b7An2H7yGqqvakP7JM4p7N4QotQNJ4MdQJJ1EHvuA96eamdCq/zAaGZvBGE6KLTRMhHjAah08F00yWxmziNcD+5ee4aFwOFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415179; c=relaxed/simple;
	bh=azbKkP2cXT+o67IGfSWHV4WbY5Pgzr6lgvaE9O9S+xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKrUCKvlgp7QWjhL4dxC2vD6Sv6JNUh3fUNUWTsWzlIlITBXdUGh0YoZNe1J03mcWEE98Qn2FftA33L9rvlNSLeLSqrouqJzevfzPs/JjHeDe15mpWGgj6tVmkS8ouv67OzAW515E0SN62HW25EYJQZMm4iUyaAWTByoxSkzZEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=lR5MSXYV; arc=none smtp.client-ip=209.85.210.43
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7e6cfdc8382so943188a34.2
        for <linux-nfs@vger.kernel.org>; Tue, 02 Jun 2026 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780415177; x=1781019977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hs/PYZIUqC0oanJYU795yk/0BFXAa7NT7iolrJU5AuI=;
        b=lR5MSXYVKwkoUFAyAMPSeMyWxHof3/OS6wAIJQZ1R6mEFjpi16mBYu4GlJJOgzBi8K
         KnPawE8d7QAqRH54CcdEkHYf0n0+IxYQdN12iPtg+KJcAII5C7LZ+2Nl18/i7G22VEO0
         4u/iMqjk8ai/0rKfxoSwpdyfZRRtGW44dHdW9ffWOwSojxzB0lwQQnMKOFPXRWVCSG4L
         7VSBPGeduM+KrrpdTdBEwkLxr4ftKGq2QG5EoUd2wvKBcTXQ8wJ77jQk93YtpSCcDPs6
         T+pOFFGKUKWyWn+dnQ41KBt0AUAS/GBFABYAqNjqDI8Ut14zQUSLG+aVnSdKlorTo4OF
         vFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415177; x=1781019977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hs/PYZIUqC0oanJYU795yk/0BFXAa7NT7iolrJU5AuI=;
        b=LAcq7jwyRRTRaF/JJkXSVY59Os4y4CNp4TG9yo+Wtpn+eG9O+LDVsXv57ghb7PfnG0
         YOUdniLo8W9Q3QEtgfBsZQTdVFuEo+CWYs9TGrZH/+BMU/794e9rETNhRrPVNipoasvo
         tIFQrgQBEohte8LAj//EIfgwDXSDcO39n6gE/zeKUwW1tirMv3GCUqiWo6EXAMFFdfqI
         YCjgW74Z3u1EppwkLUUdl9Bd+HTiZLEBtKIOWa32/aU44X+7UEFuhTbsvJ34MSzgoi+6
         bL+dTuIVbr/VqJERPkp6XqotcGQUHTP5NOo10680LFywKPxnwpdgfv2Mi8YSAPq2EqIz
         alRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Dm7B5z07qaWNU+FUx8SCKYqRCd1kRcXZwCtjGrp8vyT9m/o/tQWp1uLRYcPS/7CH+p53dD9aRtwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOPqgIsEV4QgqUKF2xTP2mBnJOkwM1LUrO600viw9cT1w2T4vm
	VpmOL7ZZRJTYF3R/fRS6UiH7aZbb+w/+uEqRONaBUmUx5smicFCdWZ0+Mk8r5UPUEvvVtUMoU9r
	HMIj/
X-Gm-Gg: Acq92OFw7YdAV6+bnJZ5rgEiWwlbPIlulbHWWRheC/a98o79+4EAO1tke56Q6i1hYyW
	DmYA2QRYZI3HIE9yrbmdhCvNBhTlMVK1Co4xuFUbqKJ7gkuF2urEUPT31CGL0wIQaVP1xM2wgQT
	eWrY1IQ1eBPmCpRHoguq88nOcRphYxfk6nE1DLvpcBZhAWRXwNCloTcT+Y4A03RWYxH0GUk4pNw
	dUFqR0dYXdnalKhw2BM4UJInXoHEfPsTd7QuQ8T+FPAMJ4xbG8J7kSJhqgLiGwAiyBJbqmMxcr/
	+FocLe3SNs5Fd2nSZ+k0x882DrrmU5uK+CUE/+zWwN/uCCXpkXGcTbMPpH6lrBsPFlW+uirycbz
	RaTQf/g7ZJuuvhSwnCcRVADjiKf9TFFly+tLXdOeYaTqH7lWSSOV4BqQnojbaXagWI3X1XAojsl
	YVaxY3lp9mdHvv7K3I1fIsJJBMLWobh9aWVYb0iDvJxXIJy7mCeWSBEg==
X-Received: by 2002:a05:6830:1b7c:b0:7e6:cee5:1bbf with SMTP id 46e09a7af769-7e6cee5245cmr2682045a34.12.1780415177153;
        Tue, 02 Jun 2026 08:46:17 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e04fd1ecsm585395a34.2.2026.06.02.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:46:16 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Tue, 02 Jun 2026 11:46:14 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <E903163B-6A5B-47C6-BC91-3894BB9EAD08@hammerspace.com>
In-Reply-To: <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
 <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
 <4c5dbb98-0209-4572-8eac-1578536bbd78@app.fastmail.com>
 <AED22AED-E97D-40E3-9839-BF8307EF8B65@hammerspace.com>
 <1a5c70d8-e7f4-4671-a29a-023be7c107fc@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22203-lists,linux-nfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neilb@suse.de,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F0EB62FF66

On 19 May 2026, at 20:29, Chuck Lever wrote:

> On Tue, May 19, 2026, at 6:02 PM, Benjamin Coddington wrote:
>> On 19 May 2026, at 14:44, Chuck Lever wrote:
>>
>>> On Tue, May 19, 2026, at 5:08 PM, Benjamin Coddington wrote:
>>>> Just to be clear - the issue I'm exploring isn't the same as when all the
>>>> kNFSD threads are slow due to their workload.  This is very much a
>>>> multi-client dynamic where one client (or a group of automated client
>>>> instances) are able to easily starve another simply because they create the
>>>> most connections.
>>>>
>>>> That's different from the other problem that we've discussed a bunch at
>>>> bakeathon and on the list previously.
>>>>
>>>> This is not so much a deadlock issue as it is an issue
>>>> of per-client fairness.  I think this problem is in a different class.
>>>
>>> Does dynamic svc thread creation have any impact?
>>
>> I haven't tested it - I think it would just pin to max-threads for the
>> workload in question.
>
> If the aggregate workload consumes all the threads, then that doesn’t
> sound like xprt scheduling is the bottleneck. But I should look at
> numbers instead of speculating.

Chuck,

Here are the numbers I promised. Short version: under saturation a client's
share of nfsd service tracks its transport count, not its identity -- a
one-connection client gets ~1/(K+1) of the pool when another client drives K
connections.

Method

To measure the dispatch path in isolation I used a small debug patch to nfsd:
a request bearing a "magic" filehandle is answered after a fixed,
caller-specified delay, at the top of fh_verify() before any export/dentry
work -- so the thread is held for a known time D and does zero filesystem
work. With T nfsd threads that fixes the pool ceiling at ~T/D ops/s and makes
nfsd thread-time the only contended resource: no I/O, no caching, no backing
filesystem, just inbound request scheduling.

A userspace load client (single host, loopback) then runs two clients at
once, both offering more than the server can serve:
  - greedy:      K connections
  - interactive: 1 connection
The v3 probe is GETATTR; the v4.1 probe is COMPOUND{SEQUENCE, PUTFH}, with
the greedy client's K connections bound to one session via
BIND_CONN_TO_SESSION. The magic fh carries D in both cases.

Findings

1. Share tracks connection count. NFSv3, 8 nfsd threads, D=10ms, greedy
   connections K swept, interactive fixed at 1:

     K    interactive ops/s   intr share   greedy share
     1         240.6            50.4%         49.6%
     2         216.0            33.8%         66.2%
     4         129.4            20.1%         79.9%
     8          72.2            11.2%         88.8%
    16          38.0             5.9%         94.1%

   interactive is ~1/(K+1), greedy ~K/(K+1). Total stays pinned at the ~648
   ops/s pool ceiling throughout, and every op completes in bounded time --
   nothing is stuck.

2. The interactive client is actively harmed, not just out-numbered. Alone it
   sustains 229 ops/s; with the K=16 greedy client present it gets 38 (6x
   less) and its median latency rises from 16ms to 105ms.

3. Same result for v4.1. With 8 greedy connections bound to a single session,
   the split is 89% / 11%, identical to v3. The session is a clear client
   identity, but the dispatch path ignores it -- the unfairness is in sunrpc,
   below the version.

4. It is structural, not a small-pool artifact. Sweeping the thread count,
   the ratio is unchanged while only the absolute ceiling moves:

     K    share@T=4   share@T=8   share@T=16
     1      50.0%       50.7%       50.5%
     4      20.1%       20.0%       20.2%
    16       5.9%        5.9%        5.9%

   (K=16 total throughput: 321 / 649 / 1299 ops/s at T = 4 / 8 / 16.)

On your earlier point -- "if the aggregate workload consumes all the threads,
that doesn't sound like xprt scheduling is the bottleneck": the pool is
saturated here, that's the precondition. The finding is that the saturated
capacity is divided per-transport, so each client's share is set by how many
sockets it opened. Saturation is the setup; the per-xprt split is the problem.

I kept this to the pure scheduling case -- fixed delay, no filesystem work --
on purpose, because it's the most conservative: a real workload with heavier
ops only saturates the pool sooner and hits the same split at lower connection
counts. pool_stats agrees, with threads-woken collapsing once the pool
saturates.

The harness (synthetic clients plus the debug latency patch) is standalone;
happy to share it or run other configurations -- different fairness units,
per-connection caps, and so on.

Ben

