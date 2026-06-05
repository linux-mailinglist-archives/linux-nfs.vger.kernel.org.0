Return-Path: <linux-nfs+bounces-22321-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /pq+KtJAI2rumAEAu9opvQ
	(envelope-from <linux-nfs+bounces-22321-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 23:34:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEA664B6C9
	for <lists+linux-nfs@lfdr.de>; Fri, 05 Jun 2026 23:34:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22321-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22321-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D22EA3026E48
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jun 2026 21:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC04D3C1974;
	Fri,  5 Jun 2026 21:33:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A38C41B
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jun 2026 21:33:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695186; cv=none; b=cZMvbCpx0JpSDDzIXDPq3TeVxj2Nk7Jxl8RXD4F0xaBlVVhQgLKrvLwndkvG2xLxE6oB670voJESpBD+xjX4/+57Doe6uPhrXImSR5oBmSjPsXse9pIhghvFV6ey+ffopZLQu7sYV8CcfSkSG3EAvX164xhB0HZf7i7Q8t/GytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695186; c=relaxed/simple;
	bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqVfxUI+tFDaa6P9rIZ5J3M4s1r1M1XHioOgWCfjPh1M1gqVGAcsCnGmZDsh5LvhvPcnViRTeEA6TK3gMyFYHOyLPJ5MVVMi4pIXcEg/SUDtXQyLIFC/SF8GnpA74usamaPcD3gx3FgwMfmfDSIo9aDCOSFNULGeZS33oVpM7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so28781505e9.2
        for <linux-nfs@vger.kernel.org>; Fri, 05 Jun 2026 14:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695184; x=1781299984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yB8i6L7KoJ6YeQ5x5SkEb3TWEe2vEfLFo8gyBr/eSF0=;
        b=CoQIt/OgwhMFWj4oAyLQ87H+ZnJrtnow/A89EBodYt+w3O4VxfHm2hg3IN7xEMq27X
         8ZX/xhgWc0iu+dpQk03Jqkan2amEc79PSGWE1BhQ3fdJEDjdQO0wnSPkqyqJTc2Ep2J8
         9TVHq4Ne0o4gZj/fCB2VuJs8RyljX/zlVfuE6PIeAHIqoesn86Zeh6HtG1orxUIOfXkO
         jSjFdjHR9HysIvB87tNYMRJJbZP/LCWXkpYz6UsWdQS2OgdFfNeC5338Tt7YuvUfay08
         8GmhxxQ8owXlDBuBhiQvyOvPzvqOASeseq2zLJZovDB/oAaHbxdIgsKJ+yB6+/aJiMef
         RTlg==
X-Forwarded-Encrypted: i=1; AFNElJ/RguPP+JFHL23V7DMrPQjy8Ms7K7darIFWP4QhmlImYFKcHtwaCqqK9nfIqvzd6DW9r5nL2c9B2Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeo8DNNKNzH1wlVtQE34yJbNJE9T8ZwU4vNga2ESq3KsGnAatI
	g3rs8vDa5zFmUCYiJlElcF/3qAfcP3SL2kzRIb1zy4bJfG7dwyy4BZz2
X-Gm-Gg: Acq92OFDIWrW2zpFEF6WK5G+YLmkccFuoIp3KiXIS7BCtbVKVaRFSZRy1OskofA5clv
	dYExYEI19UjYKcIRzu4oRStBkYIPVga8dPqtxTEbZ40jOVe+YomzT3MDKaaAVczTh6cSWNWubGU
	21QovTTh90+7NoXFm27GvJH4TvmAzMoESf9NuFhB7myFnMAcamcklV0pGdaUkq9vTJEMFnIdef4
	q1OjeXnsu6LivwLJBtKiDvSJ7En8ccBKXrXREqpIMvjYYNDjKApdlmZMKuDOcs4rTBhC77cT6s+
	aMbxK9BgIdNoTPmvV/kh5xQKXHAPFtBjPwgPkEbgAb0BVMO7YROAHIimXRgbu0iVdogzSPWf4ij
	Dao9rjJuMyMaXf0VerZrLjpLGhSzWeZyVdvxbo9VIml1b6CK2sRTtPTivsceTfLnzWUhK/Q6X8u
	q6xSbAERMKDNnQVKt+V/b1JIq//PctVlErh26B2+1hwjLBTgSh2X4cm2YUG4tg10I=
X-Received: by 2002:a05:600c:8183:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490c25c6625mr78070045e9.25.1780695183438;
        Fri, 05 Jun 2026 14:33:03 -0700 (PDT)
Received: from [10.100.102.74] (89-138-67-1.bb.netvision.net.il. [89.138.67.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d52e5esm48030115e9.2.2026.06.05.14.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:33:01 -0700 (PDT)
Message-ID: <ab767baf-aa94-4ff7-81fb-c19804a7883d@grimberg.me>
Date: Sat, 6 Jun 2026 00:32:59 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Chuck Lever <cel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
 <bb9a872a-d4aa-467a-b4c9-7bca174a6bbc@suse.de>
 <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b38b0983-7a63-4e77-a549-2d8859752cb9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22321-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	FORGED_SENDER(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:hare@suse.de,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:dhowells@redhat.com,m:jarkko@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BEA664B6C9



On 03/06/2026 17:27, Chuck Lever wrote:
> On Tue, Jun 2, 2026, at 6:39 PM, Hannes Reinecke wrote:
>> I am all for making keyrings namespace-aware. Logically I _think_ they
>> should be tagged per user-namespace, as this really is about the
>> filesystem (and as such would warrant to be tagged per mount ns).
>> Tagging it per net-namespace is not a great fit (well, for me, at
>> least), as also block devices might require keys to present the
>> bdev (eg nvme authentication)
> My understanding of the proposal is that there is one keyring on the
> system for .nfs and the keys in it are visible only in the namespace
> where they were created.
>
> Therefore the consumer (say, NFS, or NFSD) is running in a particular
> network namespace. It will create keys on the one .nfs keyring, but
> only the tlshd in that same network namespace will have access to
> those keys.

Can tlshd run in multiple network namesapces today?

>
>
>> I might be okay to have it tagged per net-namespace, though, as all
>> current users are in some shape or form being network related.
>> But I'm not sure if that stays that way, so I am worried if we're
>> not restricting ourselves to much by that choice.
>> As really, the question is: what is the driving the namespace selection?
>> Is it the _requesting_ layer, ie the layer issuing the mount() call?
>> Or is it the _providing_ layer, ie the layer providing the
>> devices/interfaces where the mount() call is operating on?
>> If it's the former, then we need to tag is as
>> net-namespace. If it's the latter, then we need to tag it as a
>> user-namespace / mount-ns.
> tlshd is a network layer service, so it doesn't make sense to bind
> it to a user or mount namespace, IMHO.

I agree with network namespace isolation.


