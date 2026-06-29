Return-Path: <linux-nfs+bounces-22877-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fVRoJWVqQmrC6gkAu9opvQ
	(envelope-from <linux-nfs+bounces-22877-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 14:51:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6056DA8F2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 14:51:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=hx4XwxwP;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22877-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22877-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0742531293A6
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jun 2026 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB816367B92;
	Mon, 29 Jun 2026 12:42:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6F400E13
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jun 2026 12:42:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736923; cv=none; b=os9mtF5DUCDY23JeNshKUyGE5gAJWVTZge5SQGrEWgDlxMZEIzKr84Sr/1W+CJOLRzDVR3Q+gwUFgdG3x2cyq1yKM/Cc0E/hx0XIeF7EUIig3V7j1vM7f8hAZ6uR2ojwnAWui2c901I5sB3yBi3YhohBce3Q2cZxP4M/eBBA9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736923; c=relaxed/simple;
	bh=QJtWi+iLXZLgBAyP+8uPg/d0kcdMiamae2KLq3B6xkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osrujdX/7ybo9k/17T5OS6li+btTGrVIo2vSnsncW7H99OxrWWMhQfJH+gYsb3YZUx185gFDPA9oTCe7MVmFYMb28yveuQ+fotHg3f+bt65esva9+QVWcPoRSKYEF9A1Kd6DY2YH90JmzcLgxbr8Ws6Y4uSI5aNSgV0Wgogihzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=hx4XwxwP; arc=none smtp.client-ip=209.85.210.48
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9797ec365so2948200a34.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jun 2026 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782736921; x=1783341721; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4RGd/JjKlKBAUIvifycV2k3x979Sx2I8d+QfYepmwi8=;
        b=hx4XwxwPJLh3XJG2eMzdutGgflJQzpoFLo2B8hDg74F18BubLeayOJyBeQZ7Bv6a4e
         CZG1nTItm/huRawM295cK/6qD9JsHSR2V8kxIFy0qqzeEk1Qwbr0/hqQQOJFDGhx5hhp
         kBj/fqFNX+1V/BF1Yq/mRFF2kzfueuedPrLA8HQnGR9wPhMuoFYE/PKxqed7x/5il7Wq
         QSHVhtr1kp+Py+65nDl/a5ntoakdCuqwPLuj4ngPfzcQAEN9/qDL8WFmgIcHssreyx/1
         74+3MFYPpRicUrEBvGoVo/5cFEwIH1pqU0taMP3UxwYdTV6CABXvT48m/Fi7A+jI1mxF
         tZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736921; x=1783341721;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RGd/JjKlKBAUIvifycV2k3x979Sx2I8d+QfYepmwi8=;
        b=PcXwzVvlhyCxsepwy2UDKhFvMyO0XkUp4HjIus5gL+zOXnKi2iaaelw4mw9Hg7rYYx
         wJH6VstG3c1DG/htA91MNCcIUP4C2m1W/zgXi3Nb4bpV/ZvGdE9elmY7TN1sYa+f0gRg
         jxHNbCS61Y8bqiLBeXKxpvSu3yYBR4oxpk35Jgt1F7OuyRBA7umEbNn4rZRHocJ4YuZw
         VX9a4JxSw4W0n4BXQ+tCcAzOH4GZ40LnmnMfwDwG8Ty27OhK2sEOpLQVmSZVi1tMY+RA
         6Gj5avUXXkZAMo1jVVCjG24L9YXeVMFoS9htKthwRX10euT0nndO2KgR6KHEXkxKCLOX
         MOLg==
X-Forwarded-Encrypted: i=1; AFNElJ/FtkXGDxMtHv8QEO3zPt00i5hbn7/qbFBMqNMejhpdh81GQUqnHrVSPAEKzfH8Vf4kt8e8j2lbWxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNqflDtgQ0g1uiubG1r5dNudIt0SPI/KjBt/ArraWMO+i8Fpm
	5A20KbNWhmvsNj679yi5rWhBH79DLrJnS/TAZzJ91WBCLLXkEN5Md7Tt0KlSRZT38Tk=
X-Gm-Gg: AfdE7cmmXNIkBFSUjAPcyTGaVOgp8S4OXVHFJWl4N5WrBFig8vB/BsYyYvEfcj0WrTf
	o0yIgq9SPiFpa2Wvtd6jdk6GfpxegNYY3yF3vtPEhPU63rEpCSVNLJT5PEQ3FvvXsQOsP+KRGXe
	eBBqxmSITMkQzT+HT+arPBZ6a91iFaRMt6b8crByORzTW+rpmaIxVJXcBxHtzusMgO6bJxBucdo
	WrrMGnpn0eDnQmqi5EA7U25Vo1PLrbwNAF/I5+vqeYMg5ZPdB+zhkup0mAm8l2zKXt03kMJ91cd
	3LbqTf9+VFihp+2RcuVUUztMXEJcpCEnJb0giI38qesSp2Buq1Hzae4YBo0r56WFZSw5d6Roiuu
	ngoFVpb9vYU8jZpIigXDgYhgbxV13vwNClF0vCXjSmCj4NSR2UjOI1axxebK32g63r7sdK3N4+y
	FQcMZPyUqxgs3aRovtU2jxbyXbIPxyntgg
X-Received: by 2002:a05:6830:4882:b0:7e9:bd8f:5137 with SMTP id 46e09a7af769-7e9bd8f835amr6891957a34.6.1782736920852;
        Mon, 29 Jun 2026 05:42:00 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9c48735f9sm5196871a34.2.2026.06.29.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:42:00 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@ownmail.net>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Daire Byrne <daire@dneg.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] SUNRPC: a latency floor for interactive clients
 via sparse-flow dispatch
Date: Mon, 29 Jun 2026 08:41:58 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <69C1992C-2759-46E3-90F6-B9B54012D829@hammerspace.com>
In-Reply-To: <d8efb4f7-fd91-453e-a6fd-1427bdab1cc0@app.fastmail.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
 <d8efb4f7-fd91-453e-a6fd-1427bdab1cc0@app.fastmail.com>
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
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22877-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[hammerspace.com,kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com,dneg.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,hammerspace.com:dkim,hammerspace.com:mid,hammerspace.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF6056DA8F2

On 25 Jun 2026, at 14:59, Chuck Lever wrote:
> My worry was that a sustained interactive flow (a tree walk holding a
> couple of RPCs in flight) never reaches zero, spends its 64 once, and
> then rides the normal queue.
> ...
> Could you run the same probe under your aggressor + 10ms hook?
> ...
> The question that settles it: for the interactive xprt under load,
> does the depth==0 fraction hold up, or do you see depth>=1 runs longer
> than 64?  If it holds, the trigger is fine [...].  If it collapses,
> that's the argument for a low-watermark refill rather than exact-zero.

Hey Chuck - I didn't need to run any tests to be conviced that your re-arm
problem exists, it seems obvious to me.  That said - I did send a clanker
out to run it, here's the response:

"

I ran it, and it collapses -- but as a sharp step, not a gradual fade,
which I think is the useful part of the answer.

Setup: your probe (depth = xpt_nr_rqsts, filtered to committed enqueues,
keyed by xprt) plus xpt_hi_credit, offsets from BTF.  The victim is a
sustained flow holding a fixed window W of RPCs continuously in flight on
one connection -- a deliberately conservative stand-in for the tree walk:
a real walk has dependency gaps that return it to depth 0, mine refills
instantly and so idles as rarely as possible.  Aggressor is the backlogged
worker set from the series; 10ms service hook throughout.  (This is a
different workload from the burst victim in the cover letter, which drains
fully and idles 50ms between bursts -- that one re-arms every cycle and is
not what's at issue here.)

Re-arm rate, committed-enqueue depth==0 fraction, by victim window:

    W=1 (strictly serial)   depth0 = 100%    credit stays 63
    W=2                     depth0 =  0.4%   credit pinned at 0
    W=4                     depth0 =  0.1%   credit pinned at 0
    W=8                     depth0 =  0.2%   credit pinned at 0

So the whole thing hinges on the transport going *completely* empty.  A
strictly serial flow re-arms on every single enqueue and rides the high
queue forever.  The moment a flow keeps even two RPCs continuously in
flight, the exact-zero condition essentially stops occurring: it spends
its 64 within the first ~64 enqueues and then lives in the bulk queue --
depth>=1 runs are not "longer than 64", they're unbounded.

What that costs depends on how deep the bulk queue is.  Victim per-op p50
(ms), vs window W and aggressor connection count K (floor = victim alone;
aggressor p50 ~ the bulk rate: 17 / 27 / 52 ms for K = 4 / 8 / 16):

    W    floor   K=4    K=8    K=16
    1     14      14     16     17     <- serial: protected at every K
    2     26      25     37     26     <- marginal, right on the edge
    3     20      19     24     39
    4     17      17     28     52     <- == aggressor: fully demoted
    6     16      17     42     79
    8     16      19     57    106     <- worse than the aggressor

Under light contention (K=4) bulk is shallow, so even a non-re-arming flow
stays near its floor and the demotion is invisible.  It only bites once the
bulk queue is deep, and then the threshold window shrinks as K grows -- by
K=16 anything holding >=3 in flight is at or past the aggressor's latency.
(W=8 lands *worse* than the aggressor because the demoted victim's own
workers then serialize behind each other in the bulk queue.)

Reconciling with your uncontended histogram (depth 0: 25.6%, 1: 62.3%):
that cold walk idles to zero a quarter of the time, which is plenty -- it
sits up at the W=1 end and would stay protected.  So the exact-zero trigger
is fine for genuinely sparse or gappy flows.  Where it's brittle is the
continuously-pipelined flow with no gaps -- aggressive readahead, an app
doing async I/O, a v4.1 client that keeps its slot table full -- which
demotes wholesale the first time it sustains a couple RPCs under load.

So I read this as the argument for the low-watermark refill you floated:
re-arm when depth drops below a small threshold rather than at exactly 0.
A watermark of even 2-4 would move the W=1 column's behavior out to cover
the modestly-pipelined flows, while still excluding a real bulk client
(which sits far above any sane watermark).  It doesn't reintroduce identity
and it's a one-line change to the refill condition.

I could spin that as a 4th patch for v1 and re-run this sweep against it --
I'd expect the protected band to widen from "W<=1" to "W<=watermark".  Does
a fixed small watermark match your intuition, or were you thinking of
deriving it (thread count, or the slot-table hint you mentioned)?

The probe harness (kprobe sweep + the load generator) is standalone if you
want to reproduce any of this.

"

Ben

