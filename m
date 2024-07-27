Return-Path: <linux-nfs+bounces-5084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F5B93DF27
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 13:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7A11C212E5
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593641746;
	Sat, 27 Jul 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBXF6Flf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EA351016
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 11:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079724; cv=none; b=st1HbY2eXhCSxg3voLBXPO1eZtRwamVlNdKsZC55DwyFuOxZKKYexDhJFJeVw8R+sJMmLSDlVE1WRBgAfwlTJS4hA4dIZb4RzaadZQfVGOH62B4Fy9m+EdOeM/nzeiyg97WU+wS52BXQqDby1yvWTAmYqN65Tot8l8V09hqFjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079724; c=relaxed/simple;
	bh=JlE+2rMuO3/og4BBN5YS8dV0M+GlBykbzcl7N43DrgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmfPJT2RHCUMtG0hY2UKJ1KH0ZTUnkUF02CJUut+4dVv+r7yHN4d6+ojucRpDZbXLPwvs6XqU52cgTEEHSMTmwA9pjgniaxFFv8D2N6c6so2NR3wEdVEwy+SM+Gu15mDPzDY/ZSYgwDtdGhld0EckTgIr6jDffQjzu3xePvkw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBXF6Flf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722079720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6PCoZIO229ZMMZUv9ED5/5lO9KGfOlvjdx+06Lz0/A=;
	b=IBXF6FlfxGGAgapm401iobQFnYe1FF1WRc1G+ZL5gMmTfLKVmvpDmeo6mClWELY/3mH727
	xdicFLx4hL0TM3lQCj2v1dsyheTJTbGVp5YpF/Ayfs5Kf8frbSopWPHenekmts/Zo1wal8
	JdFJ7/xpkxuBUs26hRO+vcTUAjYodaE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-PtyuIucZOZa-8bI9tXOpXw-1; Sat, 27 Jul 2024 07:28:36 -0400
X-MC-Unique: PtyuIucZOZa-8bI9tXOpXw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fed9796aeso1893581cf.1
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 04:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722079716; x=1722684516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6PCoZIO229ZMMZUv9ED5/5lO9KGfOlvjdx+06Lz0/A=;
        b=NwWFeYb2xLaIS6HXDF8g6RW0PBnltJrZbZb7bnNFduI+GEA5udA48bn+eOUdRWGAj3
         eRAhslXGron10WCqNuZPs3nDP1h1qEjRfCO/sDmG7zEH09t/y7ZcLOEi5z/PN3qJ9SpW
         /bXKu85VHoYPhC4IQHGsMXHyJ4tSzzT+T0MBlNQ0zX5jSj6Z20RSFLU7NU6Pb93MeEmH
         2Ycp9f08/XuL20LURFcgB4ha4ug48FZH1OoaLyU8/DtE6ho9VKRpEXXok1aUCM7nVl4V
         vh6/X8GSVnV9nQIdIj/Uwt5oyq78AGfw2JTwK7sOa6dhw2I/0BgarTJ+HeMXXSDy1viK
         A4lQ==
X-Gm-Message-State: AOJu0YxoBYSEtai51YcwE47x2mjXMZHJGImBTNEpfKTLtYX0u4iMjHrH
	f3MBGdz536p9NkAcWSNweRDMYdWfPLMj/xMyyTEIgxCt04J+sfNFO3d6xykjSqgoohGWy+ux4Pf
	eR9uYSeFSHNmgkpRCgO2SHk6jpfpVCjtgCqVm+yQUj2oPPgs4ybmm5qns0Q==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr60912036d6.3.1722079715784;
        Sat, 27 Jul 2024 04:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK38hArYASPUpuQhEdK/uscy/L5ClYr9FbFH+1jwFNB7m3yW3Bxk6pkPLSi3aqXUI+SH96UA==
X-Received: by 2002:a05:6214:2b0a:b0:6b7:7832:2211 with SMTP id 6a1803df08f44-6bb3e2043dbmr60911926d6.3.1722079715342;
        Sat, 27 Jul 2024 04:28:35 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f943352sm27834576d6.73.2024.07.27.04.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 04:28:34 -0700 (PDT)
Message-ID: <cc94ec24-5460-408a-b479-70dc19b62311@redhat.com>
Date: Sat, 27 Jul 2024 07:28:33 -0400
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
 <807d899f-56c2-46d9-81aa-d2ef4c84d3b0@redhat.com>
 <9587ca96fc8cf49852e129857ffebefadff1c436.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <9587ca96fc8cf49852e129857ffebefadff1c436.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/26/24 6:20 PM, Jeff Layton wrote:
> On Fri, 2024-07-26 at 17:59 -0400, Steve Dickson wrote:
>>
>> On 7/26/24 5:32 PM, Jeff Layton wrote:
>>> On Fri, 2024-07-26 at 15:40 -0400, Steve Dickson wrote:
>>>> Hey!
>>>>
>>>> On 7/22/24 1:01 PM, Jeff Layton wrote:
>>>>> Hi Steve,
>>>>>
>>>>> Here's an squashed version of the nfsdctl patches, that represents
>>>>> the latest changes. Let me know if you run into any other problems,
>>>>> and thanks for helping to test this!
>>>>>
>>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>>> ---
>>>>> Changes in v6:
>>>>> - make the default number of threads 16 in autostart
>>>>> - doc updates
>>>>>
>>>>> Changes in v5:
>>>>> - add support for pool-mode setting
>>>>> - fix up the handling of nfsd_netlink.h in autoconf
>>>>> - Link to v4:
>>>>> https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
>>>>>
>>>>> Changes in v4:
>>>>> - add ability to specify an array of pool thread counts in nfs.conf
>>>>> - Link to v3:
>>>>> https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
>>>>>
>>>>> Changes in v3:
>>>>> - split nfsdctl.h so we can include the UAPI header as-is
>>>>> - squash the patches together that added Lorenzo's version and
>>>>> convert
>>>>>      it to the new interface
>>>>> - adapt to latest version of netlink interface changes
>>>>>      + have THREADS_SET/GET report an array of thread counts (one per
>>>>> pool)
>>>>>      + pass scope in as a string to THREADS_SET instead of using
>>>>> unshare() trick
>>>>>
>>>>> Changes in v2:
>>>>> - Adapt to latest kernel netlink interface changes (in particular,
>>>>> send
>>>>>      the leastime and gracetime when they are set in the config).
>>>>> - More help text for different subcommands
>>>>> - New nfsdctl(8) manpage
>>>>> - Patch to make systemd preferentially use nfsdctl instead of
>>>>> rpc.nfsd
>>>>> - Link to v1:
>>>>> https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
>>>>>
>>>>> ---
>>>>> Jeff Layton (3):
>>>>>          nfsdctl: add the nfsdctl utility to nfs-utils
>>>>>          nfsdctl: asciidoc source for the manpage
>>>>>          systemd: use nfsdctl to start and stop the nfs server
>>>>>
>>>>>     configure.ac                 |   19 +
>>>>>     systemd/nfs-server.service   |    4 +-
>>>>>     utils/Makefile.am            |    4 +
>>>>>     utils/nfsdctl/Makefile.am    |   13 +
>>>>>     utils/nfsdctl/nfsd_netlink.h |   96 +++
>>>>>     utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>>>>>     utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>>>>>     utils/nfsdctl/nfsdctl.c      | 1570
>>>>> ++++++++++++++++++++++++++++++++++++++++++
>>>>>     utils/nfsdctl/nfsdctl.h      |   93 +++
>>>>>     9 files changed, 2259 insertions(+), 2 deletions(-)
>>>>> ---
>>>>> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
>>>>> change-id: 20240412-nfsdctl-fa8bd8430cfd
>>>>
>>>> The patches apply very cleaning and thank you
>>>> for squashing them down... but... bring up the
>>>> NFS server with 'nfsdctl autostart' v3 is not
>>>> being registered with rpcbind which means
>>>> v3 mount will not work.
>>>>
>>>> Just curious are you trying support my
>>>> idea of deprecating V3 :-) (That's a joke!)
>>>>
>>>> steved.
>>>>
>>>
>>> You do need a patched kernel for this:
>>>
>>>       https://lore.kernel.org/linux-nfs/Zp5j2DW+2BNaIPif@tissot.1015granger.net/T/#e675642639c59b1c0070f4b19cd03b89cff7983ba
>>>
>>> With a patched kernel, I get this with autostart:
>>>
>>> [kdevops@kdevops-nfsd ~]$ rpcinfo -p
>>>      program vers proto   port  service
>>>       100000    4   tcp    111  portmapper
>>>       100000    3   tcp    111  portmapper
>>>       100000    2   tcp    111  portmapper
>>>       100000    4   udp    111  portmapper
>>>       100000    3   udp    111  portmapper
>>>       100000    2   udp    111  portmapper
>>>       100024    1   udp  42104  status
>>>       100024    1   tcp  40159  status
>>>       100003    3   udp   2049  nfs
>>>       100227    3   udp   2049  nfs_acl
>>>       100003    3   tcp   2049  nfs
>>>       100003    4   tcp   2049  nfs
>>>       100227    3   tcp   2049  nfs_acl
>>>       100021    1   udp  46387  nlockmgr
>>>       100021    3   udp  46387  nlockmgr
>>>       100021    4   udp  46387  nlockmgr
>>>       100021    1   tcp  36565  nlockmgr
>>>       100021    3   tcp  36565  nlockmgr
>>>       100021    4   tcp  36565  nlockmgr
>>>
>>>
>>> Are you seeing different results?
>> Yup
>> uname -r
>> 6.11.0-0.rc0.20240724git786c8248dbd3.12.fc41.x86_64 (rawhide)
>>
> 
> Did you patch that kernel by hand then? AFAICT, that git hash doesn't
> have the necessary fix. I don't think Chuck has sent a PR to Linus for
> it just yet.
No I did not... Due to the fact I can not commit theses
patches until the kernel patch land into the distros.

steved.


