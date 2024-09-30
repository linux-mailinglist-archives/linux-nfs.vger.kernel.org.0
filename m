Return-Path: <linux-nfs+bounces-6720-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8A498A98D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 18:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1691C23938
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2024 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4B18E755;
	Mon, 30 Sep 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mm/QKT8f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603D3BB24
	for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727712983; cv=none; b=eo6zkfVvkcw0Zfcsh7qn9so11OvdZXVrlYrVvKp+iYXW52IM1hsG4S5OCfUhex2sXK0NG67YL3kCkmPFzf91oNir+VdR1Yae1ih1LSU4wY+jKBUh+EmDz2jtbXmnRGFzsmn0veq5PKVyxBfP+rF408l3OmOaZJuPUR2/in0li0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727712983; c=relaxed/simple;
	bh=s1DMtYDjyw22Xvn/XEEVQi1e/4FMLs5Y6dtfqAtu1+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ew1PGtm2QyzhzBHo1xEte6JaqdwZ+wggst+uyDSYpPvdrJNASVWzMYm2XCBw7Ff2DcVKoRxY6s9/h4+uzJEEufJT2kOHJijur2NGU594DnaWxFWwSvEYAc+xMHPwtHapJpK370L3w1BQkqqh89dsPbeCVfRRAbEXSTAOBV0iKFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mm/QKT8f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727712980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHHejs9MUTqjUxZpfaooHuEZUpySyFE0Kg7nHcu5khk=;
	b=Mm/QKT8fwb2LULPNzk3exHNZF61veNQkB4508t5tINPke8jIMXN1j52ziGBX7wefQ2VqKY
	GK63s3Dxag4X3/3iGyehSuLgJPMu1bIJLk8yXPSbWh2Ar6909Ye1Z5hDNosNZqeECtU1UX
	qqyklhOnoiP0IyhiGggCfWvIUZsTP+M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-CLq0TIF0N2Ge6mgwgWgoyw-1; Mon, 30 Sep 2024 12:16:18 -0400
X-MC-Unique: CLq0TIF0N2Ge6mgwgWgoyw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7acb1fb3967so815724985a.2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2024 09:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727712978; x=1728317778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHHejs9MUTqjUxZpfaooHuEZUpySyFE0Kg7nHcu5khk=;
        b=FY6OrMtcBL3OZgrz8x6dpBX+E8EXDKD6bPiC7bv5ttTjJwRXk8LXuW7YcxNastG+2M
         SbJgHfVKOO6IIVUHukSGj2k2mKpMINfubzV13DNKAyGJZGnr39R3TgCJbqKSrXHJXQY5
         //s2aSU63SdzOIvv9wu1xM7eSL4QUTO8B53kT84Ytrtu9eKWRLMD+KL6IkJHen7QOS/S
         944j0uvioWHJFEHU2cfdiOPLf+KeVOh2zHIVh6CLi5oNpBKjviN5XTKrZ/VhgLp0adlj
         9eVEwpupVgOTTNThkf3ntgWHA/OnP1VDc+zv0E5J/yGlUVTX0FPv4XFWL5xQ3DXEuZ53
         77TQ==
X-Gm-Message-State: AOJu0Yxv9Mofwpf4znB+1eIEblKa6YsFu4qzMrQ8K+2HFZnANoa9j8Xv
	5jCnoWuupxpDBIAEobpT/t0v1+V9by5V/vcuPhVKV9eJ4JPyd8tZoFEddrfEGef1W0oy2X4TFfU
	7LfbMJ0HjDGTj2JCooPtODt8eDIvQ9u4AsDbmafD8Zp5DqXLlGAZq+zRYIQ==
X-Received: by 2002:a05:620a:2410:b0:7ac:d673:2056 with SMTP id af79cd13be357-7ae3781e1cfmr1694286585a.4.1727712977632;
        Mon, 30 Sep 2024 09:16:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJXQSFpnToCeFhgObBNbDr1QmDbOWMYUXM8NrJnGL4LTN+/NnRFUx7GUZ02uyfvnPg6XBqgg==
X-Received: by 2002:a05:620a:2410:b0:7ac:d673:2056 with SMTP id af79cd13be357-7ae3781e1cfmr1694283785a.4.1727712977250;
        Mon, 30 Sep 2024 09:16:17 -0700 (PDT)
Received: from [10.193.20.143] ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d644sm426875185a.120.2024.09.30.09.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 09:16:16 -0700 (PDT)
Message-ID: <7ba9c281-4f0c-412a-ab86-2bfb3b280c96@redhat.com>
Date: Mon, 30 Sep 2024 12:16:14 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
 <3a2dfa30aa812394021cc582e9303194e9979cbd.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <3a2dfa30aa812394021cc582e9303194e9979cbd.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/30/24 11:52 AM, Jeff Layton wrote:
> On Mon, 2024-07-22 at 13:01 -0400, Jeff Layton wrote:
>> Hi Steve,
>>
>> Here's an squashed version of the nfsdctl patches, that represents
>> the latest changes. Let me know if you run into any other problems,
>> and thanks for helping to test this!
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Changes in v6:
>> - make the default number of threads 16 in autostart
>> - doc updates
>>
>> Changes in v5:
>> - add support for pool-mode setting
>> - fix up the handling of nfsd_netlink.h in autoconf
>> - Link to v4: https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
>>
>> Changes in v4:
>> - add ability to specify an array of pool thread counts in nfs.conf
>> - Link to v3: https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
>>
>> Changes in v3:
>> - split nfsdctl.h so we can include the UAPI header as-is
>> - squash the patches together that added Lorenzo's version and convert
>>    it to the new interface
>> - adapt to latest version of netlink interface changes
>>    + have THREADS_SET/GET report an array of thread counts (one per pool)
>>    + pass scope in as a string to THREADS_SET instead of using unshare() trick
>>
>> Changes in v2:
>> - Adapt to latest kernel netlink interface changes (in particular, send
>>    the leastime and gracetime when they are set in the config).
>> - More help text for different subcommands
>> - New nfsdctl(8) manpage
>> - Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
>> - Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
>>
>> ---
>> Jeff Layton (3):
>>        nfsdctl: add the nfsdctl utility to nfs-utils
>>        nfsdctl: asciidoc source for the manpage
>>        systemd: use nfsdctl to start and stop the nfs server
>>
>>   configure.ac                 |   19 +
>>   systemd/nfs-server.service   |    4 +-
>>   utils/Makefile.am            |    4 +
>>   utils/nfsdctl/Makefile.am    |   13 +
>>   utils/nfsdctl/nfsd_netlink.h |   96 +++
>>   utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>>   utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>>   utils/nfsdctl/nfsdctl.c      | 1570 ++++++++++++++++++++++++++++++++++++++++++
>>   utils/nfsdctl/nfsdctl.h      |   93 +++
>>   9 files changed, 2259 insertions(+), 2 deletions(-)
>> ---
>> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
>> change-id: 20240412-nfsdctl-fa8bd8430cfd
>>
>> Best regards,
> 
> Ping?
I'm keeping my eye on it.... I have the bits on
a private branch... I just don't want to break
v3... when the distros get to 6.11... I'll
make it happen

steved.


