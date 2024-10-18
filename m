Return-Path: <linux-nfs+bounces-7282-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D43979A4152
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE761F2491E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 14:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D9768E1;
	Fri, 18 Oct 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N71D5jZl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1A1EE026
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262253; cv=none; b=pN2ttXl+Fizo+jdHsKJ1PlqlzS/qzZJeKSA5E5v2FmXPz3QoroqMmOs7NM578TWGcbNZjijDgItun70w/Rz3ECV9yy62ymKMfxconAAGR2oew+hheyXjl+c4Epn0U3ss0lACN8l+mCO3h6DQK48c9w3entYscqAh6mhs+paa8BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262253; c=relaxed/simple;
	bh=worBknz4zm5Zj7sYZrmBFtKpA66v+ov7hM9NMxAiiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJI1VlVIPfNcWUXPWHD0f766mMRdCARmT4YFkzLFLZsbycAnY2fqQU6/sJ1BbnL3g/ub0TSm8UToNOrMsMJIHiClb1M5L6n16G4rBdc3ydYdEaQfYCjdbW5nizji1/fyUYO/BpleCBr3YbbpI8gJ/dnz1Nqe3m+zlYLutO6gGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N71D5jZl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729262250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HeUXw2YfOYyDed1/a/aTUyNEFvv+cQSXsYspjZbYU1c=;
	b=N71D5jZl186BTGnWNflfNO7KJ7hUb5+Fo4GhB74hybAi0qYgiuVEmWCFGROtVnm5qQThKD
	xhE5CshwQHQbc07QTed7nE0AzPsd6jdq3YEJccyX1A0W075L4ATvIJsO97/efNUmkD9A/i
	Q1YYu4SDVUHBwp8JbVlGK9izkaqH8Dg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-At7dMSzbPgSLu3U1SKrDaA-1; Fri, 18 Oct 2024 10:37:29 -0400
X-MC-Unique: At7dMSzbPgSLu3U1SKrDaA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbcedb31b6so30781366d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 07:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729262248; x=1729867048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HeUXw2YfOYyDed1/a/aTUyNEFvv+cQSXsYspjZbYU1c=;
        b=cRgm5kMfN5WttzjjjVxd9w+SGfXZ2hHIk5JEmaV11FGWilpQjjc9639XVW3dy0BCY+
         BhAIi7S1W+DdVk7/wNbPBbPY4trsMQaWKbivi9Jasmdn52UsQDHV9Gwi6GW+J/w/i3Br
         WgyG/eZHI0oMDeqsoVGnUvXnv80BfdnMvOJ6RwYMKpmap6YPaLficXPwxiU9C8ylSl/t
         XcWHM0TsuLFJYekiNUDrfNW2MbGh2gNKRY/s06ZpCVEMROeiaJqt2vFVxARTG3NpHMig
         mJ73epT26fzfqKJnzJxzRjjHfl9dXFNbb05oAhqPEESvOHpbTuQ0s+BH+yvLuSFUBVyB
         jNbw==
X-Forwarded-Encrypted: i=1; AJvYcCU4zcrkqi9J8MAOQu41YWObgEtvdXAA9RF3v5MwhIQFpYzV51TN1/IBaIWuar9GHRpQZjaz+XSzb8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4oEg0vbQ/Xu/FCrX7W7lCgdYWS95GKAuVgoUEtLTK1v+8Yzx
	mo3a5A5cS2m7qq63tG9KHJDQwgO1ligrVrABQMjMO7uVjGEXzOP+NIyOFBidj6klPdiy7FcEQH6
	nXcT9xHFzaaMh7s9ayYkE4AASVv3bZuBgNUSN/JHpsjmfUULaSFgAmw36wrOQkQadug==
X-Received: by 2002:a05:6214:311b:b0:6cb:cda0:df6 with SMTP id 6a1803df08f44-6cde14c002emr29162896d6.3.1729262248231;
        Fri, 18 Oct 2024 07:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5PAzS8Is3M8InP2ABV8i4hy1bJMDoXPxhltJzfO0zhlYrVlskAetP6kuVSdIJ5Dp8lxDkg==
X-Received: by 2002:a05:6214:311b:b0:6cb:cda0:df6 with SMTP id 6a1803df08f44-6cde14c002emr29162636d6.3.1729262247808;
        Fri, 18 Oct 2024 07:37:27 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde111c044sm7505786d6.27.2024.10.18.07.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 07:37:27 -0700 (PDT)
Message-ID: <69ae6f9b-6ad5-48d5-9700-4568044ae980@redhat.com>
Date: Fri, 18 Oct 2024 10:37:25 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check
 for Linux 3.17+
To: Petr Vorel <pvorel@suse.cz>
Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>,
 linux-nfs@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
 <20231026194712.615384-1-pvorel@suse.cz>
 <622276d1-0566-4b6e-90bc-c6ec3e1da47a@redhat.com>
 <20241018134301.GA310040@pevik>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20241018134301.GA310040@pevik>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/18/24 9:43 AM, Petr Vorel wrote:
> Hi Steve, Giulio, Richard,
> 
>> Hello,
> 
>> On 10/26/23 3:47 PM, Petr Vorel wrote:
>>> interesting, I yesterday sent patch [1] solving the same problem (although it
>>> might not be that obvious from the patchset name). Let's see which one will be
>>> taken.
> 
>>> Kind regards,
>>> Petr
> 
>>> [1] https://lore.kernel.org/linux-nfs/20231025205720.GB460410@pevik/T/#m4c02286afae09318f6b95ff837750708d5065cd5
>> There are a number of patches in the above link
>> Could you please post, in the usual format, that
>> fixes the issue.
> 
> @Steve IMHO all build failures on glibc <= 2.24 and Linux 3.17+ has been fixed
> in f92fd6ca ("support/backend_sqlite.c: Add getrandom() fallback") [1].
Perfect! Thank you!

steved.

> 
> I don't see any new issue in the thread which is from 2023.
> Are you just double checking if any patch was left on ML?
> Or do I miss something (it's Friday maybe I'm just tired)?
> 
> @Giulio @Richard feel free to correct me.
> 
> Kind regards,
> Petr
> 
>> tia,
> 
>> steved.
> 
> [1] https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=commit;h=f92fd6ca815025c435dabf45da28472ac0aa04a4
> 


