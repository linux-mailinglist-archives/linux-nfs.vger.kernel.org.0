Return-Path: <linux-nfs+bounces-5081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE793DA7F
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 00:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E280C1C23355
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 22:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD78154C19;
	Fri, 26 Jul 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI2W4j8e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E49155306
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031172; cv=none; b=WKbe04/DrkP7ih1+jV9ctL6NFpwqeqDgMhtNBGFwWRdVn8lazpv68HLI8UDh6IRAGt0zMRZ7YsxSQtb6HGVzUFK7yuKRyJgh5Fx0YMrtuwJjxv5GOcOeSQVUptrzYL5sL1ldM/s6hWrTnwm62sZU3ry67xqdeM/h+1QIhtar+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031172; c=relaxed/simple;
	bh=TPFK2uFflyGmaeo5/8B6baJ8mn/xWRjrdVQWbGO5tsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVC3P82gYyl19x5wj1rSQ/rdgY83mh9fiQhdRJyHE/8Z5NYi9xtOOZcjwhNwNJg90utJu3Q+ZUIL/axIYWz6eZs/oEbic33xKyisQ6er3O98G6mkzgPPjcaEwW7BsJXmW3qcorKwMHfaVHt7mugWFlfE/ruRZrY+8jV5t/ol9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GI2W4j8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722031168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvcwC5LhSw/l1xbO8vSOCzSae+OqET6EwqaqokYGjA8=;
	b=GI2W4j8eatIyE8b0CrrvluYgZnB3nm63JcxPOVzL1CkVGY9vPGe3IeWcDqGVBtslGvCspP
	QqF2Nmm2A7CYFGD5eaO+usY0Ar1XoAZsZw6/LC62dSWb54CbW5O3qXxz/6tESethePo4GK
	8aSS9zKrC3mlE1IGGo5hHE204NhRTuo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-JMr7AHK_M-eM6toggNBT8Q-1; Fri, 26 Jul 2024 17:59:27 -0400
X-MC-Unique: JMr7AHK_M-eM6toggNBT8Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7a5a70cb8so2146866d6.3
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 14:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722031166; x=1722635966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvcwC5LhSw/l1xbO8vSOCzSae+OqET6EwqaqokYGjA8=;
        b=AZa5NaJjkiMX+RDMExdB+9XyGnDiEdUpiXqTSA2vbVzLznfuPy7F/07W/DdMfx8EpI
         0F7xTNrmSqWSxBmrzEIb9kiXQz750amifIs8YLyaKdKySMDmWC2RXxtb8Rdk6iRRWsUm
         YLVxz7UIFy9TkyD5+duz2SukNxlX3tl54xuUnXLtj9E/n4VPKwhz37SyvhGuePF5OR8N
         JFraFjpr5pT4MFtGiZfKvO5f9jnRIjwuSexPXSoneauWPBQZ/mQOn+EjPghd4iLiGe7u
         8r1bliqPLoci052iAHwUMFnktMa/V1s7q/pIdnOuRDkPaBdXkb69QKS8IR6uevSUhK+k
         wHZA==
X-Gm-Message-State: AOJu0YyjiOQ3NJcrcnsThODVzDimiO+cijPz1P/AlMoy+hnA3cZLY4lH
	2XKgck0BOIfiW7cQkaQT3/iZnO7GqVmn/8AYydRCNTghnenlT+6WMFMEwbpGj8AcN6naE/v2Ifk
	8WcuRTu2Jf5E2gI9DF7lWQEyELj5XT1cqpGMBmMF1/vm1m5B0COZMDb8qAw==
X-Received: by 2002:a05:6214:20ac:b0:6bb:3ac9:3274 with SMTP id 6a1803df08f44-6bb3e2e9c86mr48653846d6.4.1722031166449;
        Fri, 26 Jul 2024 14:59:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuU3uLDNfCINvxSq6bFOMwH3I0eGHxHGY+wuTtuS4JDkt5dMkwQhJVKpE/zWpMnjQVamwGqQ==
X-Received: by 2002:a05:6214:20ac:b0:6bb:3ac9:3274 with SMTP id 6a1803df08f44-6bb3e2e9c86mr48653756d6.4.1722031166099;
        Fri, 26 Jul 2024 14:59:26 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3faf32d4sm20280736d6.129.2024.07.26.14.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 14:59:25 -0700 (PDT)
Message-ID: <807d899f-56c2-46d9-81aa-d2ef4c84d3b0@redhat.com>
Date: Fri, 26 Jul 2024 17:59:24 -0400
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
 <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
 <c327208425684c14c788032b56803f05d59f1070.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <c327208425684c14c788032b56803f05d59f1070.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/26/24 5:32 PM, Jeff Layton wrote:
> On Fri, 2024-07-26 at 15:40 -0400, Steve Dickson wrote:
>> Hey!
>>
>> On 7/22/24 1:01 PM, Jeff Layton wrote:
>>> Hi Steve,
>>>
>>> Here's an squashed version of the nfsdctl patches, that represents
>>> the latest changes. Let me know if you run into any other problems,
>>> and thanks for helping to test this!
>>>
>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>> ---
>>> Changes in v6:
>>> - make the default number of threads 16 in autostart
>>> - doc updates
>>>
>>> Changes in v5:
>>> - add support for pool-mode setting
>>> - fix up the handling of nfsd_netlink.h in autoconf
>>> - Link to v4:
>>> https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
>>>
>>> Changes in v4:
>>> - add ability to specify an array of pool thread counts in nfs.conf
>>> - Link to v3:
>>> https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
>>>
>>> Changes in v3:
>>> - split nfsdctl.h so we can include the UAPI header as-is
>>> - squash the patches together that added Lorenzo's version and
>>> convert
>>>     it to the new interface
>>> - adapt to latest version of netlink interface changes
>>>     + have THREADS_SET/GET report an array of thread counts (one per
>>> pool)
>>>     + pass scope in as a string to THREADS_SET instead of using
>>> unshare() trick
>>>
>>> Changes in v2:
>>> - Adapt to latest kernel netlink interface changes (in particular,
>>> send
>>>     the leastime and gracetime when they are set in the config).
>>> - More help text for different subcommands
>>> - New nfsdctl(8) manpage
>>> - Patch to make systemd preferentially use nfsdctl instead of
>>> rpc.nfsd
>>> - Link to v1:
>>> https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
>>>
>>> ---
>>> Jeff Layton (3):
>>>         nfsdctl: add the nfsdctl utility to nfs-utils
>>>         nfsdctl: asciidoc source for the manpage
>>>         systemd: use nfsdctl to start and stop the nfs server
>>>
>>>    configure.ac                 |   19 +
>>>    systemd/nfs-server.service   |    4 +-
>>>    utils/Makefile.am            |    4 +
>>>    utils/nfsdctl/Makefile.am    |   13 +
>>>    utils/nfsdctl/nfsd_netlink.h |   96 +++
>>>    utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>>>    utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>>>    utils/nfsdctl/nfsdctl.c      | 1570
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>    utils/nfsdctl/nfsdctl.h      |   93 +++
>>>    9 files changed, 2259 insertions(+), 2 deletions(-)
>>> ---
>>> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
>>> change-id: 20240412-nfsdctl-fa8bd8430cfd
>>
>> The patches apply very cleaning and thank you
>> for squashing them down... but... bring up the
>> NFS server with 'nfsdctl autostart' v3 is not
>> being registered with rpcbind which means
>> v3 mount will not work.
>>
>> Just curious are you trying support my
>> idea of deprecating V3 :-) (That's a joke!)
>>
>> steved.
>>
> 
> You do need a patched kernel for this:
> 
>      https://lore.kernel.org/linux-nfs/Zp5j2DW+2BNaIPif@tissot.1015granger.net/T/#e675642639c59b1c0070f4b19cd03b89cff7983ba
> 
> With a patched kernel, I get this with autostart:
> 
> [kdevops@kdevops-nfsd ~]$ rpcinfo -p
>     program vers proto   port  service
>      100000    4   tcp    111  portmapper
>      100000    3   tcp    111  portmapper
>      100000    2   tcp    111  portmapper
>      100000    4   udp    111  portmapper
>      100000    3   udp    111  portmapper
>      100000    2   udp    111  portmapper
>      100024    1   udp  42104  status
>      100024    1   tcp  40159  status
>      100003    3   udp   2049  nfs
>      100227    3   udp   2049  nfs_acl
>      100003    3   tcp   2049  nfs
>      100003    4   tcp   2049  nfs
>      100227    3   tcp   2049  nfs_acl
>      100021    1   udp  46387  nlockmgr
>      100021    3   udp  46387  nlockmgr
>      100021    4   udp  46387  nlockmgr
>      100021    1   tcp  36565  nlockmgr
>      100021    3   tcp  36565  nlockmgr
>      100021    4   tcp  36565  nlockmgr
> 
> 
> Are you seeing different results?
Yup
uname -r
6.11.0-0.rc0.20240724git786c8248dbd3.12.fc41.x86_64 (rawhide)

rpcinfo -p
    program vers proto   port  service
     100000    4   tcp    111  portmapper
     100000    3   tcp    111  portmapper
     100000    2   tcp    111  portmapper
     100000    4   udp    111  portmapper
     100000    3   udp    111  portmapper
     100000    2   udp    111  portmapper
     100005    1   udp  20048  mountd
     100005    1   tcp  20048  mountd
     100024    1   udp  38596  status
     100024    1   tcp  60257  status
     100005    2   udp  20048  mountd
     100005    2   tcp  20048  mountd
     100005    3   udp  20048  mountd
     100005    3   tcp  20048  mountd
     100021    1   udp  55966  nlockmgr
     100021    3   udp  55966  nlockmgr
     100021    4   udp  55966  nlockmgr
     100021    1   tcp  40995  nlockmgr
     100021    3   tcp  40995  nlockmgr
     100021    4   tcp  40995  nlockmgr

# mount -o v3 fedora:/home/tmp /mnt/tmp
mount.nfs: requested NFS version or transport protocol is not supported 
for /mnt/tmp

steved.


