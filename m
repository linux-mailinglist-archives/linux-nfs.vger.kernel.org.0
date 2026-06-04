Return-Path: <linux-nfs+bounces-22279-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g1olHGelIWpEKgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22279-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 18:18:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E05641C58
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 18:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=HawL03L1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22279-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22279-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCDBE3085646
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F22BD59C;
	Thu,  4 Jun 2026 16:08:18 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980326A08A
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jun 2026 16:08:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589298; cv=none; b=I7PLKrvxhTGf/d5c1i3trie/vKvjGTKZ4/8HXciRSpoSRfhqcSfjctut6Hzucq39zn9Wygg1F0m8aaUaGmi9TQLCnsGDhMFgHT6P//gcR6S+DGOUX9sbcCke5VEAE4L/Pu6yjU/o3rmuneDkVElJ3A/bAQ6KiqE32EAnRayW9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589298; c=relaxed/simple;
	bh=d7AGRE10Csxis7gU3RbVpnKkcZJA4cSvNDM1W2ICDNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U83PPb9lcz1IPPiTmBq/1/Y6IT6aQwOJcnNTBMNVn9PTHBbn7stirUwhJlN0GjbYfWRQE6d3uZDmphQy7ewcXTPrTf4+BfSA8sX4QtpVZU1ul4/NNn+0qOd+q/eBbzRmVvVFTXEC8h9zk31Lwby2bZ+fifsNZfdNzk96dsQOkEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=HawL03L1; arc=none smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6da33a561so682401a34.3
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2026 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1780589295; x=1781194095; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCBTVSiaTmp/7JqZLBBj4iSVDUzJWOq3RccptBAgJGw=;
        b=HawL03L1RSs81l6CNV6SEpc28LPeAfyeZ0ri3LTrIfI/J5PuzaX8TDQmbFnYSHCcNh
         t8HLIw5y28Y4vKRgYuZPMRp6jD1T0tc+yDqBVe961cbKx88buDDBqd6iun4NeORFf0+f
         rs28wIkMAu4MoCjYM0A73ZRUSjnrfMnsrUFKz+DlzitW9FjZwj8G0h7EStcD/8JsSxOx
         n/+sU3gPMdbzL6u1cgMWrBB+uxdR6qofXOdxGTtbr4UUAByEqBwFf0R79qZUyx5b91Nx
         0HnHp70IuHPc3IJBCBemrZsu14o1UCDfAl4bEMnXuHBMO6+zdyQ5rHIHXjVRK0rFOQRT
         bZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780589295; x=1781194095;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCBTVSiaTmp/7JqZLBBj4iSVDUzJWOq3RccptBAgJGw=;
        b=hjEYS7DG//yw/EU+KFmHWNnK6IWjyqPD0WBDmX7N4m//tEbaC6DzPwR91Y/aV6a6Mu
         RJSdOQmJzSthD/d+YZ73kk/FzHmBe3uPBZzlvMPbosR/cKdZVHFdb8jD3jQmzdXKkLiX
         TsUjML9fGLD3COTrQSVMXWNLXAZVYQvl2fSTqNu6nrbgOWQ+S+G8BGw3wgY0WHRXmQsA
         JkN+ZfF9QU+oDYXHz47QqTb53OrqUbrhdFZbaNuIgznRzuFcxkCdD5kzZf9xxHD9NgXT
         v8jnCNkNm1afh3GKKcsyvYHkgu2cB+3GloBb+af7q0W0IUY6f86oh6+7Flig3P7go6t1
         S4LQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ooQs241/wfzGsEZMZKA5lnFAbXLaCady7JlATlvIsIAlEcFZ9pIFZLLgTkTqmnwQDuxlw05HGbP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrb+huSKAyxqfCv7T1BpsbuEtf1Z1+MMrBhdzagQ2lXO7XlWLc
	w83HgOCKLq3M514n03n4xBcLJ03ol8q3fee3K1Hd7HgvxKLVLnXemj3Obj8DdNojDjg=
X-Gm-Gg: Acq92OGJ1I9HfwpzKyyUroOoTm6q3w00tcyAmJUTOlkq4muP7uTl8iobPWQVdOiWqkP
	FWgnpcMytKglF4Op5e/hd7gtx3x2RE7wc7DZ+4RzYgvtVMqk7P9n9dzPyEeARsicJ7MQXiCP5BZ
	fwhyDLSCo2XwmNTfPjijb9vInAhJ0x+vcXRk8yeFaAresuoUvgyaqS5Qzad/L1kahrZOFEGgixD
	b6BCuieM8x0DLvkjcjf9BrFd1JVOWrh2BFU6WwDEBhxyUoGOXv1zQqfsAASTxOEIhRkaG3WV9bC
	ZhnxSEhbwhtOk2fu99CNpwKj19JfcQydMYqjLtkcI4KZLnrpNxnZ+WwsQV06G52nx8aRi3ZRAdX
	BWx0eLG8+IonVzxdq49bK9gB/WbVG3JAWTg+cnaWJ4e/cDn83koj+TJ79Ypl6nBqms3eLNG7k+F
	rPTa6/UMKQblnwof+0Q1Sl2RzxJQF6l38h9kUtqFVFlwJOS3TLBYrCAQ==
X-Received: by 2002:a05:6808:4f6c:b0:46a:d8b7:1101 with SMTP id 5614622812f47-4865ad17d7cmr5355528b6e.41.1780589295259;
        Thu, 04 Jun 2026 09:08:15 -0700 (PDT)
Received: from [192.168.254.51] ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b977c46sm5013137b6e.14.2026.06.04.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:08:14 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Daire Byrne <daire@dneg.com>, NeilBrown <neil@brown.name>
Subject: Re: [PATCH RFC 0/4] nfsd: per-client fair-queue dispatch
Date: Thu, 04 Jun 2026 12:08:13 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C13BCFC6-BEFA-427E-8431-DDAC6076C1B3@hammerspace.com>
In-Reply-To: <89ec5776-1a61-4713-b331-bb4edb9f5b0a@app.fastmail.com>
References: <cover.1780498019.git.bcodding@hammerspace.com>
 <178052714769.2082204.16375565668618050718@noble.neil.brown.name>
 <CAPt2mGPwabhiSCJ-2U1MMnEcMqDNiXG_4LLbN0s1VOGY9oscXA@mail.gmail.com>
 <89ec5776-1a61-4713-b331-bb4edb9f5b0a@app.fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22279-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:ben.coddington@hammerspace.com,m:jlayton@kernel.org,m:linux-nfs@vger.kernel.org,m:daire@dneg.com,m:neil@brown.name,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22E05641C58

On 4 Jun 2026, at 10:54, Chuck Lever wrote:
> - I'm not a fan of adding administrative controls, and these days, a
>   module parameter is outdated and way too global. I'd like to see
>   that removed until we have a clear need (use cases) for tuning

Agreed - I'll drop the module parameter.  With the reframe below the fair
path is cheap enough to be always-on.

> - Having to rely on client identity is going to be difficult to get
>   right. ... fairness-by-client-address means all clients behind a NAT
>   get reduced to a single fairness unit.

Agreed, and avoiding identity entirely is most of the appeal of the
reframe - it also gets NFSv3, NFSv4.0 and LOCALIO for free, which solves
the no-session problem you raised.

> - The observability you proposed ... worth ... making it a part of the
>   patch series

Will do - I'll turn the latency-injection measurement into something that
stays in the series, but it's probably not appropriate for any final
inclusion.

> Instead, we could look at the problem as "preventing starvation of
> any one connection" ...
> fq_codel's success comes less from its fair queueing than from its
> sparse-flow optimization; that is, flows with nothing in flight jump
> the queue and heavy flows share what remains.

I like this - it dissolves the identity question, and xpt_nr_rqsts already
gives us the in-flight signal to classify on.

One wrinkle I'd want to get right first: what a user perceives as
"interactive" is a command, not a single RPC, and a command is a burst of
correlated RPCs - loading a web page whose browser cache is on NFS is a
readdir, then stat/open/read across many files.  Plain sparse-flow grants
priority for one quantum (~one RPC for us), so only the first RPC of the
burst jumps; RPCs 2..N find the connection backlogged, demote to the bulk
tier, and complete at the aggressor's rate.  The leading edge is fast but
the command isn't.

Rough numbers, ~650 ops/s pool, interactive on one connection, aggressor on
16, a 50-RPC command:

  today (per-transport FIFO):     50 * 17 / 650  ~= 1.3 s
  sparse-flow, 1-RPC quantum:     ~= 1.3 s  (only the first RPC saved)
  whole command prioritized:      50 / 650       ~= 0.08 s

So to make the command feel interactive the priority allowance has to cover
the cycle, not one RPC: grant an idle->active connection a budget of ~N RPCs,
re-granted each time it returns to idle, rather than a single jump.  This
stays identity-free and connection-count-proof for the same reason your
version does - a sustained stream never returns to idle, so it collects the
allowance once and is in the bulk tier forever after, however many
connections it opens.  A user-paced connection idles between commands and is
re-granted each time.  (This also naturally covers Daire's
workstations-over-render-farm case: bursty-then-idle vs sustained, no subnet
config.)

That turns the one open parameter into "how many RPCs is an interactive
cycle" (N).  I'd rather not make it an admin knob either:

  - a generous fixed default - over-provisioning costs almost nothing, since
    a sustained stream never idles to collect it, and under-provisioning just
    lets the tail of an unusually large command fall back to bulk;
  - measure it - track per-connection burst size between idle gaps;
  - borrow the v4.1 slot count as a per-connection hint (v3 would need a
    fallback).

Does a burst-sized allowance fit how you were picturing the sparse tier, or
were you thinking the single-RPC jump was enough and the rest should just
share bulk?  That's the main fork I see.

I'll rework the series around this - always-on, no module parameter, no
client identity, sparse/bulk tiers keyed on xpt_nr_rqsts, measurement
included.  I also owe new numbers: my current harness runs every connection
at a fixed window, so the "interactive" client is actually backlogged -
the wrong shape to show any of this.  The metric that matters is
command-completion time versus the aggressor's connection count.

Thanks for the reframe - it's a much better-shaped problem.

Ben

