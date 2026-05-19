Return-Path: <linux-nfs+bounces-21717-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PrkMfrRDGrImQUAu9opvQ
	(envelope-from <linux-nfs+bounces-21717-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:11:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C358503F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1222306D0EB
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 21:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688B13D9DCB;
	Tue, 19 May 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="WsTybdUy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1B3E2ABC
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224932; cv=none; b=WfX5My1kD+t0bHz+RvN5aCmSEk8eXWqEPpQKmVzVu4Dl7mHRYST3kit5KAVOwu/dudp6vqnx+zjtvXsrD2XGkyLpseQBPMWnKolxtNhFYJUImS3LlEWEAJvDIqhNeGgALgPjiiMEvOk3WdgGE1n+baGXBtJvfkuFbjc6bKKFuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224932; c=relaxed/simple;
	bh=4rDdwUfxwxgfFaiDtAnZiRubUpizMRCezZIe4xoE7kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+cefJ4iAv6zF4UU3IjX3toEaIp1P8P5pU+psZFS30xohNH9xe0Z0DGinqnW0uJAiS2gAuUeAtHa9n25zo4UFn+Le4ehVBhAertZos15SAwZjrJ59WGGAIwnOmAkdw/K3JnWkf9Ne48tWB/UqNwZSmd8Bk5YbthOi8fH1Kyx1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=fail smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=WsTybdUy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammerspace.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-48270f099d5so3439218b6e.0
        for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1779224929; x=1779829729; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9i0yGRHbDiOPKv2mLOiUNFrLU1/xes/kTD68smCJXvQ=;
        b=WsTybdUyaspn6CNKg6yExG6CagGkvGYM2WZn2tPy69dutDuQgKb20cz7FzKD/cglvM
         WuyllF7Q6kcnwND/2/6xLaQ3jEpnmm18GQz2xtiWfIk2ZHp2FyTTtlzQj5gPUtuIN2GU
         DcpOmTYwNFS/r7thTokXoG1Hae50b2tffA53YRQqIEbEMxBmv2wV9kP6bmyjbCni5J7o
         XyU9VTkcz3iYHTHsC7famWH/jXM6y7vpNJ48UmzoiT/7Gm/jaTKns6nu7nEerTfUoRaU
         jBixIkZDNf5ESRv+m5gexy3AbdpyuHmNh+1tEyJYYo9EM520SBUO6KkzSeGSnXtoJn5H
         3e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779224929; x=1779829729;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9i0yGRHbDiOPKv2mLOiUNFrLU1/xes/kTD68smCJXvQ=;
        b=ZCeHkkaOzwa3ee+xVu8mlNYG17JXPTQn1zk3+tA45lj/wDBVm7NUtvLFFc58CrWlom
         rQUz7VSx/3hB4jCickKAgwIQ19oYPPQPVn1A3IuXcZiZfIRKGn2KiCSGsHZuYGbYCR/B
         DWYuTrcopiClv67sbofnN1nw7zLIW67XgJa3M72pbrH2FSyUUTYgVv9w4GsWouABcmEJ
         iIB59fbHQesC3dIe7kGIR29nFwtZ79/y5PUgz0tCJetSdsA10L5YEVioC4Td8LWUrKhp
         KjE+o7O7s5Y9sJxwXxHplitmesDcE3l1bC+sUFm9nYrlXFYfKG4tNb+um/nQ3srr10+K
         XacQ==
X-Forwarded-Encrypted: i=1; AFNElJ/syVtRvgEBOzzs3CUrCQ1vxnB5EQOuP4zz/hixd6lAHvnvdAd7076JIolnqxkqtBncHdDSknnk0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuExbFo7R9LHYPeqn+gH9mGH5YLzWE26jtpCy+O92F4SHkeamk
	NCNqN9ZOAlynp0em8DNxgMu+fDRFehWQlB9FnVb/l7joyNzha4aq3DaRJbOzr2hsBlY=
X-Gm-Gg: Acq92OFnNVUhSCn53Ko4FrDlRztMCpKddeR2yv0V4DNYKTeaIJg1WXNfygRdPyZLVGu
	80i/6oQaCuD4CD9fQRW7n8LlQ5Uo/dO0Avaxv+pH9X5rPf/Kgc7XcivXpOuwCPWg9oCpS/XPLky
	1UOKWAa8E2vLa8nvL/EzjInwQaUBeOpLUer5aTISEvxmZy+VEtccDBzEueNv7+VHTu/kikvaP2J
	+oTHWZBqRJ+ofOj6uzH0ugNojoQNu8nu2FuUVGnEAKHXUNrbmBisWPCHnsMnB7r16Q5QYnlhtur
	g0pk4yrELKtY7MBAI7p57o/DEzpM8K8OLpknVdQb7fm6Q/Hg26YvaA2Uu81StPAaYqBT9QXlHjq
	X8feCU1fNrRpQ5NgpJwoF/0FTYc8+WywBTE5X181huKOzMOdIngG3lpfk9vOSsndLGBvDiQKKTs
	glYkqkRCzVLpUNYqidocBNvwP7S1EUgV429/SMVLfYrlbH8w==
X-Received: by 2002:a54:438e:0:b0:467:db7f:ab98 with SMTP id 5614622812f47-482e575a09amr9974191b6e.33.1779224929135;
        Tue, 19 May 2026 14:08:49 -0700 (PDT)
Received: from [192.168.254.51] ([12.117.181.174])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-482ee4fa4a9sm6907611b6e.11.2026.05.19.14.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:08:48 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org
Subject: Re: [RFC] knfsd: per-client fair scheduling to prevent single-client
 starvation
Date: Tue, 19 May 2026 14:08:46 -0700
X-Mailer: MailMate (2.0r6272)
Message-ID: <3AB7EB6A-B207-4B91-A695-66C4704D0E31@hammerspace.com>
In-Reply-To: <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
References: <D33770A1-9098-4F1A-93EF-590E6C0B7638@hammerspace.com>
 <473e337b-fabc-4884-a6c4-0f04b6874d0b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21717-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hammerspace.com:mid,hammerspace.com:dkim]
X-Rspamd-Queue-Id: 0C3C358503F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19 May 2026, at 13:59, Chuck Lever wrote:

> On Tue, May 19, 2026, at 4:45 PM, Benjamin Coddington wrote:
>> We've been chasing a class of starvation problem on knfsd servers and would
>> appreciate feedback before going further.
>>
>> NFS clients that opens many TCP connections (for example with nconnect=N)
>> combined with a large NFSv4.1 slot table can keep enough requests in flight
>> to saturate the entire nfsd thread pool, starving other clients sharing the
>> same server.  In our environment we routinely see one such client push
>> hundreds of nfsd threads into uninterruptible waits, leaving little or no
>> service capacity for everyone else.  Concretely, 8 connections at 128 slots
>> is already ~1000 potentially-concurrent ops from one host against a default
>> 640-thread server.
>>
>> The root cause looks structural to me.  svc_xprt_enqueue() and svc_recv()
>> schedule fairly across xprts, so a client with N sockets gets N times the
>> service share of a client with one socket.  From the server's point of view
>> there is no notion of "client identity" in the dispatch path -- the xprt is
>> the unit of fairness.
>>
>> ISTM the right shape is an opt-in fair-queueing scheduler that groups ready
>> xprts by client identity and round-robins (or deficit-round-robins) across
>> identities rather than across sockets.  The natural identity is the NFSv4
>> clientid where available, with source address as a fallback for NFSv3.
>> Default behavior would be unchanged and the new policy would be selectable
>> per service or per pool.
>>
>> Before we go further I'd like to ask a few things.  Is per-client fairness in
>> knfsd something the community wants, or would you rather see this solved
>> purely on the client side?  What's the right layer for client classification
>> -- sunrpc is clean but identity-blind, and nfsd knows clientid but only later
>> in the path?  Would a simpler per-client concurrency cap be preferable to a
>> true fair-queue scheduler?  And is there prior art I should be aware of -- I'm
>> thinking of interactions with the recent dynamic thread-pool work, but there
>> may be older threads I've missed.
>>
>> I'm happy to share more detail on the workload that surfaced this.
>
> We're very open to discussing this. It's a well-known shortcoming of NFSD,
> currently.
>
> I'm not sure making the client (or, say, the network namespace) the unit of
> fairness is the best approach. A single client is known to encounter the
> same class of deadlock that you describe above, for instance.

Just to be clear - the issue I'm exploring isn't the same as when all the
kNFSD threads are slow due to their workload.  This is very much a
multi-client dynamic where one client (or a group of automated client
instances) are able to easily starve another simply because they create the
most connections.

That's different from the other problem that we've discussed a bunch at
bakeathon and on the list previously.

> The current design assumes that whatever work a thread is given to accomplish
> will complete in milliseconds or less. When the network layer knows this will
> not be the case, the request can be deferred by sunrpc.
>
> But there are problems with this design:
>
> * The network layer is not always privy to what might trigger long delays.
>   For NFSv4, for example, a client that is not responding to a delegation
>   or layout recall will stall the server thread, but that happens well
>   /after/ the network layer has passed control to NFSD. Likewise, this
>   is a problem when I/O is glacially slow, for instance for NFS re-export
>   when an NFS client is partitioned or otherwise unresponsive.
>
> * The send and receive buffers for each request are tightly coupled to
>   the threading model. Once a request has been received, the consumed
>   receive buffer ties up a thread.
>
> So we've been playing whack-a-mole to try to break these deadlocks one at
> time, because resolving the buffer-to-thread coupling issue will be long-
> horizon work.

I understand - what do you think about considering this problem in light of
what I said above?  This is not so much a deadlock issue as it is an issue
of per-client fairness.  I think this problem is in a different class.

Ben

