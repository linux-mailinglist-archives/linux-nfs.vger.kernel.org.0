Return-Path: <linux-nfs+bounces-21388-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB5hJjWr+Wky+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21388-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 10:32:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BD34C8B2E
	for <lists+linux-nfs@lfdr.de>; Tue, 05 May 2026 10:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5182C3014C0F
	for <lists+linux-nfs@lfdr.de>; Tue,  5 May 2026 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCECA2C08D4;
	Tue,  5 May 2026 08:32:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C46F239E9A
	for <linux-nfs@vger.kernel.org>; Tue,  5 May 2026 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969958; cv=none; b=XifDjhUjlkRdoMZrpvR08s5l5UWCYR3m9CV/p5+b5IgkM+hxPjgHJNFq/idNS+3Kgs+iCtSFJ6vzv8WqIBLP6EAm/EZE4RiVc66l9siKvkjkQk3FvoW325SBhuFt68Z7vjgEhoRi2SPILpq8CLmbJ+ezMJrjhN7Wm7S62W4y7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969958; c=relaxed/simple;
	bh=G1IAbDpD34zFs/zr3HeiJ5rHOg/8nMo4BlbsC8iXbrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksHsr/EIIbwuWsKt6d4PwifS2Nd4O67xBFQVFUXBWriHh8ZxPsVrh58zuHTs/88YPWlUPCZkdYn+WR1F2QrD+AMO9GPnEtp7rCJTt28tdXLaLKJ4xgjT9TEfEVb1OAGSB9/mh2IX8dGKgRNBmmQ09LZsmrFkxtcsQCtX9U4c4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7645adbdso3016636f8f.1
        for <linux-nfs@vger.kernel.org>; Tue, 05 May 2026 01:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777969956; x=1778574756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1IAbDpD34zFs/zr3HeiJ5rHOg/8nMo4BlbsC8iXbrQ=;
        b=AI8FNVN/Jv504R1ETMQpl87Qi7bFtU/z4binH5RH67MPBgquw4MYmEMcdTQom95K5T
         PEbN0WCXxxc/oNw/JN2rRWGTgN/77afGrOmicY5SJXu6hd8Gxr2sIdtqT0YZAIuWhAQl
         GXT1kKhTqLNyvu9SPpvmvHIgi8wmRspG1c7i7VhpK1rZvNubC46YcWhyD9i990eAIJwc
         hRXqrVPf3EADh1tGVZZ5FGQS3UYYPGL6r8h4KsL4xEN0IjeEQqv4x5zA1Em1zzz7rLe6
         xJOTPiEu8CgJ3e+NpiUMBSGbWlna2lEFaeDNXGS12F7lYMh5mEVB3s762u7qwuExigLH
         2RWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QmAduCTUHj4fGmf7hXP/gOdgokL1gzdJvrX6AQOS7awjlnLi7MfovjtyENZUya5fju3vqJKL3+OI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd53rjTPNa+mpfCN3WN3FxX5Gc0y9QZUkav/DQDq8wTlHolsTr
	v23qIVsH6cYZs/PiS2YqJKHoOfHNsj49FdVNmgTt+3ffwdeArui4TTgNBx4hqQ==
X-Gm-Gg: AeBDies4YhRciBgmNY+lHgVPCu1WNBKWKFYbJz9tx9lP0386pvGBHAgS3kBxdjyu1Hn
	yz3+krXeAb2lZ/BY0Cq7no/UO7W9Lvn3n/MOJknursjelaJ4H5R8ALl/kyZ3816KMXLJnEmGJNJ
	MUVZrrwb+rJpF1Xbvk6H/ZL/0mpw0a+9ZOkw9tOUf7L5TesSsBA9sdb9jxGzEnR/WGPgZGE3uWk
	U7Q/L9KiQi/lqtmsnLsOru9nBxEd4k0pCCq4x+vbFIG/ld7Jw3TqykptTSv2DQMpxUSOzyo5v4R
	9DSYeMDNQ/wBitAtkUY5GYqVjQhBb46rK2Yq/i5t13Qxq/cGX9fqjAu3zYBDkXthKJw2eDMOnFY
	j2W++cGqsmoLUlpLEqzEC6ySfdZyZ2ThCwfQ9HZB4/9K7uDJzN7z5BFbXOf0FgAs9MVEqrs3g8o
	ZoLJ9GMm9FOTS+cWv6O3mfTcu/otdJsrcjdnkNjZNyqMYGr30K4ZGnkeSIf8/wRhksTQ0vEhtKm
	A==
X-Received: by 2002:a05:6000:228a:b0:43d:67f4:91aa with SMTP id ffacd0b85a97d-4500670ae2dmr3456562f8f.40.1777969955517;
        Tue, 05 May 2026 01:32:35 -0700 (PDT)
Received: from [10.50.5.21] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm2802418f8f.0.2026.05.05.01.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:32:34 -0700 (PDT)
Message-ID: <f4c22c54-f760-4b60-9acb-dbeb32071285@grimberg.me>
Date: Tue, 5 May 2026 11:32:33 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Breakage in ktls-utils with nfs keyring?
To: Chuck Lever <cel@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 kernel-tls-handshake@lists.linux.dev
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
 <afUKzeUYPhb97DX4@aion>
 <7c6516be-adb9-4d0d-ba7c-fa107fd4a865@app.fastmail.com>
 <e55cd958-6d86-4c6b-abc6-5be83fc53b0b@grimberg.me>
 <98a865cb-94e3-4f57-8b9e-0634c43098b9@app.fastmail.com>
 <2330c9c6-de7e-4cac-b991-3ffcfdc23858@grimberg.me>
 <ce60fc54-5082-44a4-99ae-dccbbb25eb88@app.fastmail.com>
 <4797a5a7-ac88-48a5-8707-b9e33a899da6@app.fastmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4797a5a7-ac88-48a5-8707-b9e33a899da6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3BD34C8B2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21388-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,linux-nfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 05/05/2026 11:15, Chuck Lever wrote:
> On Mon, May 4, 2026, at 8:44 AM, Chuck Lever wrote:
>> What you are asking for, then, is a 1.3.0 dot release for this fix. I
>> still don't feel there is a strong requirement for that, given that
>> distributions apply fixes to packages all the time. But I haven't made
>> a final call on that.
> After auditing the commit history between ktls-utils-1.3.0 and 1.4.0,
> there are enough fixes to bundle together and release a 1.3.1 that
> includes the fix for the keyring-based NFS mount failure. I've created
> a branch ktls-utils-1.3-fixes that can be tagged and released once the
> keyring fix is merged into main.

Thanks Chuck.

