Return-Path: <linux-nfs+bounces-7213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C49A1377
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 22:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5B41C2213D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9AF215F6E;
	Wed, 16 Oct 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHUVRSJv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD1216A22
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109412; cv=none; b=Q8ZTEXIPWtC6uxrOv937YIJcx/FEjdv8NPnwmQ0q+5Ps5xSbRjGdVTGfeRdE9y5fv890GKD/kcT+ft4cZ+aRJzCH418mKCe15q+VGO2D/en28pUZ1wlky9Cr5hq9T1HWvvazP9VtJZSEYZrUMDT5F8dMcrUCSuQPPY1h15zc6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109412; c=relaxed/simple;
	bh=y5skwS2qoIDOnhfDs09edsnZR+xjvlaJBWzp6mSdzzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sEE4wQHAV80m8+ItMWrew9UvurN1chQsfVkIOFezqx1YC0PRo05H5MOMrK7yTNmHjd/sj07gusgC06TXP1Pn4F8Xe3L2MJozT/Q3x6CzEML1rtLZYoyXloUM5FPZLNXwOr6LZX7AcOVtugjtDOxYRhtMi0ncW8B7wPIf2f0Ud2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHUVRSJv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729109410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3zcZseeEPSmle5V7tw5zszc0huisT8qkLF8MYRObUs=;
	b=aHUVRSJvSvsLmFY61ybImiDxsyZ0sy02SzDFmBuJuzQ8qKsrK4vLprdvsZuvBc6OEXYt+R
	2xheuWdn9KZ4KmcgnMyOb6x4tQ1OXRzecVn2LBHQfrf82NJFLD6jwDE/rnW9VzIyZwoPHu
	vqoHxnEIGUA+PiCOWDTcIjVXABMnSyI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-7p9se-AZNEGHaVPu20P0Eg-1; Wed, 16 Oct 2024 16:10:09 -0400
X-MC-Unique: 7p9se-AZNEGHaVPu20P0Eg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7b11fec5bbaso38673885a.2
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 13:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109408; x=1729714208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3zcZseeEPSmle5V7tw5zszc0huisT8qkLF8MYRObUs=;
        b=ft/gslUd6/BVxFHPAkfrb77OPtaCPtNTftiDtSysAAfxHLm1h+nL5yZAsJlj0d4lQU
         5zWELUeMNgPj5na5z6AQhm0G/S1MR8VKSMWioNHTFUhAzCnEdlNbezDY+V/mKTra+aqb
         p/ADcGIFSyzB5RPwtuQEg+hRB5CssReq0+qQBEE30lnVmeKgw8plgtPKno/4CLHdRqa1
         9GXJFXe1NZxqJ4AHKpmgJ39EBrvZVXMvS03qLmhsqTN5+drIgmDv0YzBhC5GIU07J2Ix
         ZeR091ZQ8eV+4uzNxswsXr54RWXXPJF6MgwGqqJ9GZ86yekX5gStNDwmaYNwAOXBKEH6
         OTpw==
X-Gm-Message-State: AOJu0YxhTOx0zXXNpWKYad2zb1saQJFC9TPdUrmMiFjueubTWWgT/L2R
	TMU3mZoU73VAvnv87iTpN6ASxQSiklEgAoYzVRfdVOCjtUS0Yn1R6rOPrbc0R3KyJ4Ev3kD7Abn
	bYv0b//9faHYkpajNihya552StsoE1XZ/odp0MHQDaE1B6DqS7fCFfFx/zQ==
X-Received: by 2002:a05:620a:1910:b0:7b1:36e9:a407 with SMTP id af79cd13be357-7b1417ab648mr751180285a.11.1729109408519;
        Wed, 16 Oct 2024 13:10:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAeJvsV5h1ACbZG5po8nkpDCZf5DQQbqebYHTTWkRDKmoWV/jUgM5YxoeQduZ3GE4DLxdRkg==
X-Received: by 2002:a05:620a:1910:b0:7b1:36e9:a407 with SMTP id af79cd13be357-7b1417ab648mr751176585a.11.1729109408109;
        Wed, 16 Oct 2024 13:10:08 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.132.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1363b43cesm220647985a.100.2024.10.16.13.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:10:07 -0700 (PDT)
Message-ID: <ca306766-130a-4786-93b2-86588009d968@redhat.com>
Date: Wed, 16 Oct 2024 16:10:05 -0400
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
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Chuck Lever <chuck.lever@oracle.com>, Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
 <3a2dfa30aa812394021cc582e9303194e9979cbd.camel@kernel.org>
 <7ba9c281-4f0c-412a-ab86-2bfb3b280c96@redhat.com>
 <a407f770289b79d0b7f3f4f9fa9eaccf9a1a26a8.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <a407f770289b79d0b7f3f4f9fa9eaccf9a1a26a8.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 11:02 AM, Jeff Layton wrote:
> On Mon, 2024-09-30 at 12:16 -0400, Steve Dickson wrote:
>>
>> On 9/30/24 11:52 AM, Jeff Layton wrote:
>>> On Mon, 2024-07-22 at 13:01 -0400, Jeff Layton wrote:
>>>> Hi Steve,
>>>>
>>>> Here's an squashed version of the nfsdctl patches, that represents
>>>> the latest changes. Let me know if you run into any other problems,
>>>> and thanks for helping to test this!
>>>>
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> Changes in v6:
>>>> - make the default number of threads 16 in autostart
>>>> - doc updates
>>>>
>>>> Changes in v5:
>>>> - add support for pool-mode setting
>>>> - fix up the handling of nfsd_netlink.h in autoconf
>>>> - Link to v4: https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
>>>>
>>>> Changes in v4:
>>>> - add ability to specify an array of pool thread counts in nfs.conf
>>>> - Link to v3: https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
>>>>
>>>> Changes in v3:
>>>> - split nfsdctl.h so we can include the UAPI header as-is
>>>> - squash the patches together that added Lorenzo's version and convert
>>>>     it to the new interface
>>>> - adapt to latest version of netlink interface changes
>>>>     + have THREADS_SET/GET report an array of thread counts (one per pool)
>>>>     + pass scope in as a string to THREADS_SET instead of using unshare() trick
>>>>
>>>> Changes in v2:
>>>> - Adapt to latest kernel netlink interface changes (in particular, send
>>>>     the leastime and gracetime when they are set in the config).
>>>> - More help text for different subcommands
>>>> - New nfsdctl(8) manpage
>>>> - Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
>>>> - Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
>>>>
>>>> ---
>>>> Jeff Layton (3):
>>>>         nfsdctl: add the nfsdctl utility to nfs-utils
>>>>         nfsdctl: asciidoc source for the manpage
>>>>         systemd: use nfsdctl to start and stop the nfs server
>>>>
>>>>    configure.ac                 |   19 +
>>>>    systemd/nfs-server.service   |    4 +-
>>>>    utils/Makefile.am            |    4 +
>>>>    utils/nfsdctl/Makefile.am    |   13 +
>>>>    utils/nfsdctl/nfsd_netlink.h |   96 +++
>>>>    utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>>>>    utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>>>>    utils/nfsdctl/nfsdctl.c      | 1570 ++++++++++++++++++++++++++++++++++++++++++
>>>>    utils/nfsdctl/nfsdctl.h      |   93 +++
>>>>    9 files changed, 2259 insertions(+), 2 deletions(-)
>>>> ---
>>>> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
>>>> change-id: 20240412-nfsdctl-fa8bd8430cfd
>>>>
>>>> Best regards,
>>>
>>> Ping?
>> I'm keeping my eye on it.... I have the bits on
>> a private branch... I just don't want to break
>> v3... when the distros get to 6.11... I'll
>> make it happen
>>
> 
> Previously, you said you would merge it once rawhide had a sufficient
> kernel, which it has had for months. Fedora 40 is now shipping a v6.11
> kernel. Can we get this in now?
Very true... I did notice just f40 got to v6.11... so
now I can make the release... just in time for Bakeathon.

I just hoping the release will not break V3 (which it will)
on other distros that are not at v6.11.

steved.


