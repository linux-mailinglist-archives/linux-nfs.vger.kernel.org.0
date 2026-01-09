Return-Path: <linux-nfs+bounces-17673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713C5D06993
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 01:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D50300E168
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 00:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A152E40B;
	Fri,  9 Jan 2026 00:13:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4072745E
	for <linux-nfs@vger.kernel.org>; Fri,  9 Jan 2026 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917614; cv=none; b=uABz24beTFbEPL/jFW7L0+9CDW3hxnge0107AXqWVUm91BgAKg+/vtCU5AJm9SkCib7sUJF+bibBrtQsiAGHAZVfdakujMGR1KrievO78b+p8wGIeCfT7WRHnnLJh/DaCuYTOiyVfVm3bWQ8b9oZNHGYZiTbf7FNW4fyCNBy69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917614; c=relaxed/simple;
	bh=71YrtsBL7WeK9BMDG0OaCJi5dFxcSCQEjaZX8X5aY4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfLcCGNewHchIOLy+iQRS/mSxUwYeDyqD5t3favuV4cRCnXrvwzn5VO8MOBU2Sn/otBjiktXu0sPNE/aukCiA+RjeUmpecoFUADD5gzaBLTJcguycmGtT1a1R9g8c237PhlaqSJJQzm7hC4Rl3M87mQ2vUSCwDctofJYTB8Fs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso12845265e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 08 Jan 2026 16:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767917611; x=1768522411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdID83axpNrwyWX4lo+SKogL6ocNPk8DrePbbs1ACm0=;
        b=MTplI9TZTiSELRPEinzC5w6CvkuDfjmCPSubQgc6ClbDyoiU0CCdyc4KInubyZs7md
         WdtsO3oVNx39YHpRxxKZfBsLJPoef2HOmQYqefPR5rFyK6Lr4D/wHwdQgmpmpFQ5wk7f
         rAa8/eKWESPb1azBBvJgsvkNw244hejWFOTlnoPvg/0nsfjy0VAI51ZvEZPLt+RHOVSa
         JqCk8bjhBw2ezZwQZ3P5PgnARizu3g7/L8kH68i7kjwY74evqyX3SUNQUbd5FpxIcTv1
         WfFLvsB/5AiEJ2MTIBHXRXTLLmNbsHOsRZ8dhTtZML2Jctiwk+V8E5z4EqhSgpjrGGHb
         nT9g==
X-Forwarded-Encrypted: i=1; AJvYcCVMW1o9mHHgmK/GlK+9cMCXmmwRczvjkMyiHjwHJVf/H73EcNQBzgak/+b5f8jLNO0ECieWrjMAs7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyLh6i6V45uaRG9Eo2abwDTZ88esaM8slBry9AMmbtklAmVvfU
	bJEuzRYDtkrGCOAtMDh0bKbHZF6p2LcJvYIUNpl5HpR6nNc+dSXcox1dNAkC7w==
X-Gm-Gg: AY/fxX5yR4isQGSxZzJCHA3CsmUNjEVqb50scs/jzgESaXd30L0kqDIXBxU88x0UDR8
	yb1HhvlGrM0x/OtOTOplIbj1v+jSwgzY0UFvoiRCfR7HQGvuYmudIye0Zrnhi7x/vll87P5Mejt
	V0A+wt9q2k9UcwkyjQV0MxKEps1heuCTbl2yTHfl7MEPozL9M419+VeA/w+hPD2BJQo3EEXdEXY
	srU3QS+L7DnHt1si+KqfNNtHjRFQbAmtFHRT1x28JHOvSZ3Ns06mP4+PBnCT01C0q65k+124foG
	DzfE6AJE6n5OCUo2g7z7kERUWfjasDZZh00azASvBzEUfDFIiSbVv8fau320lJ0S/nRNsIwG77y
	+smEmdRGyOj4pVNGvOxSz43PmYjIvF9FViDO3KLp9ji8wen0x8caMP6vUB3t7W9bz6/eUtbTyp6
	ev6pP9V7/4tjr/TlFfW8KBz2PwNOBy2TN7tOp0jrkp4Ho=
X-Google-Smtp-Source: AGHT+IFNam8PyQWCztrbqpi1SSj3kLsYFSWGdByORHIKo3vqGNeWShmyw1MaLCDkPSXnbJnJ3BMGiQ==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr108792745e9.0.1767917610942;
        Thu, 08 Jan 2026 16:13:30 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c78sm188649195e9.11.2026.01.08.16.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 16:13:30 -0800 (PST)
Message-ID: <12fc95b6-fdda-48fe-834f-120129785cb5@grimberg.me>
Date: Fri, 9 Jan 2026 02:13:29 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: add a LRU for delegations
To: Christoph Hellwig <hch@lst.de>
Cc: Chuck Lever <cel@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20260107072720.1744129-1-hch@lst.de>
 <0b0b21c1-0bfd-4e2e-9deb-f368a66f5e9c@app.fastmail.com>
 <20260107162202.GA23066@lst.de>
 <ea31c230-1ace-4721-872e-2313b497214f@grimberg.me>
 <20260108134635.GA8624@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260108134635.GA8624@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/01/2026 15:46, Christoph Hellwig wrote:
> On Wed, Jan 07, 2026 at 09:22:49PM +0200, Sagi Grimberg wrote:
>> I think that there is merit for tracking file usage frequency and
>> accounting it for deleg return
>> policy, and I don't necessarily think that it would not be worth the
>> overhead (compared to sending rpcs to the server)...
>> but I agree that its a much heavier lift (it can always be done
>> incrementally to this patchset).
> There's a reason the rest of the kernel uses fairly simple LRU (or
> rather modified LRU / clock like) eviction policies like this, in
> that the sampling is quite overboard.   I'm not going to keep you
> from looking into this, but I don't think it's worthwhile.

I understand. Regardless, this patchset is an obvious win IMO.

>
>> And, in genenral, I think that the server is in a much better position to
>> solicit preemptive delegation recalls as opposed
>> to the client voluntarily return delegations when crossing a somewhat
>> arbitrary delegation_watermark.
> Yes.  For that we'd need working RECALL_ANY support, though.  And
> the way that works in the spec where the value is a number to keep
> instead of a number to returns makes it pretty weird unfortunately.

And I see that the client does not pay attention to that keep arg, it 
nukes all the delegs afaict...

