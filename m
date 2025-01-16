Return-Path: <linux-nfs+bounces-9324-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AADA143AB
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 22:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65783A9E79
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7846F099;
	Thu, 16 Jan 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUruokgJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EE154BF5
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061235; cv=none; b=czT7P4ONxgSMH5eLryryjPb+eTUwhHqPyDRMv8G1cbsX4bDux1GDYne7As5JvRE8R4ZOQl1zHYP7DAJnxnbJjjQjWrS0aWIN4kyUDFqeurkTkHjMruOigjHg68M/HfG4MsRupPuhQtpdBO5FUvnxWzFH3lbmvYBOc7PW52r0dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061235; c=relaxed/simple;
	bh=nVbN5CnZv28Cm4/IUed1s+BvqOdKr0F4rangMB7K/Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq427APnzrK0w7xgzDKe/BllHyOHmzlnGkZONAP3JZutsOnupxVrQnB41SKTAJYbT7lVe3GVr7s+6zcRkJXNlvBC77q+da8WKsRCQY0tt4ma0lgTvmpB8ZWT0pOCTunDA7FI42aTX8VajWzN1QMRQLHXMPnZiqSk81KiFd/+W6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUruokgJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737061232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoSK8cU6Y4JGu0iDzjA+vXPoMmwlkp8O9PKKhJ0xD6M=;
	b=dUruokgJUIMvrE3y41hjwNQewqISgE032ibDxCfh+EAnPiZzyddyEDLtnxwhQl+8LS9KVP
	2u7GdntgpLf9hoDcTJQIqJMi1Tq8qchuXrT92tzhIeWTmsAjVhJ7qHX4A1jZLBG3weRM3r
	OfWe8MyYSxPYudSTLj7V7h3KSKp5Xgc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-tUQcvCSLMzWKLS4meAyi-w-1; Thu, 16 Jan 2025 16:00:30 -0500
X-MC-Unique: tUQcvCSLMzWKLS4meAyi-w-1
X-Mimecast-MFC-AGG-ID: tUQcvCSLMzWKLS4meAyi-w
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d92f0737beso24524516d6.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 13:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737061230; x=1737666030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoSK8cU6Y4JGu0iDzjA+vXPoMmwlkp8O9PKKhJ0xD6M=;
        b=d1mB+HHUvOpflgtmGA+CuTtjupVoctHVIKoRcVrybTez5vp5N4Fh56ccW2lnKPJ2kr
         dbv47Uf+1kJNsNUkRiJ+bycu2ve6UTWxJHkvCo1gcQgCj0/VuPiaigpWErjRcb6WpZrl
         6wUjKnVAWWJKwYyanansxPtMI1+ltiO8UUfdtfBiuI7+QWLiaIMFBVGDHUx3s8/Pl4tt
         1SyNXlQnzEpolpSWdoXgn6T88qCQJEOwydZfd7WVdQk3gO7C2+tBasbtlIHlyF7DB3Uo
         ZVXJdpg6yNWCv45y75KDAA/7pHlVey5VnbHO93Ooxb5H/12XjYuvlGGxiOjM2qfJysO1
         9mBg==
X-Forwarded-Encrypted: i=1; AJvYcCXKcXE8Y9NlSmbBWwOgeQlQ6/nL8lzsPHRw9zw9B9JCmQ0VdKwjD1iUxDGjgoBER9E/1asponVCXX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEPH7DJtG4WF7NnY7TdWsvqErnQ+mWQpFdAxcv0BZ32jOxEAtW
	DR8WU/4aMci+Qixds21tSMltC6bAHTojMLya5GiysrvXQe6eeHPAIz4n3nz+1wSYER6rgVjjOU4
	e8rybIe2VXyuPObUj74ZCrWQGjv65U3Wf3eQF/bctLN5ZVIpKWpek229BTQ==
X-Gm-Gg: ASbGncs9nFa4D50FS0OgbCbDkvJT1AyCH0rm7l0A9s5Q6Nw9Qr9WzRvaSk4cjh5J66o
	gBZNseEr9fWE6kSrRy8yu6tFGq6Qmo0Lx8OxSq5VW5ClvzNvHYxumJGS0vJJrVVR6cO2ibX1GT8
	SCvDIojVDkhuCY57ZiiaO7BFYeStvYhWROxJb4q571Y3XD9viT+M8piOFZrkqpc3fzaFOElKt2i
	h/81Z1BTzXyQ4Rq3ieMDBGw7VqpMeA67QdLCN5r1lHBd6MMxGS4aykf
X-Received: by 2002:a05:6214:762:b0:6d8:7ed4:3364 with SMTP id 6a1803df08f44-6e1b2168b97mr4310056d6.3.1737061230024;
        Thu, 16 Jan 2025 13:00:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGWZNqywXX+IDwF9bQT95bdWutHRk9pVpoW79ess4Ns/fb5THy1Fc+OZVQ8T4YfCWy0tDdhA==
X-Received: by 2002:a05:6214:762:b0:6d8:7ed4:3364 with SMTP id 6a1803df08f44-6e1b2168b97mr4309676d6.3.1737061229662;
        Thu, 16 Jan 2025 13:00:29 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4e18sm3866946d6.96.2025.01.16.13.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 13:00:28 -0800 (PST)
Message-ID: <54e55254-c4b7-4d0b-b123-fb1a225fa497@redhat.com>
Date: Thu, 16 Jan 2025 16:00:27 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils PATCH] nfsdctl: debug logging fixups
To: Jeff Layton <jlayton@kernel.org>, Scott Mayhew <smayhew@redhat.com>
Cc: yoyang@redhat.com, linux-nfs@vger.kernel.org
References: <0068c0d811976aca15818b60192a96ca017893f8.camel@kernel.org>
 <20250115170051.8947-1-smayhew@redhat.com>
 <590522bf-77f6-4e31-a2fb-5613f68c87da@redhat.com>
 <d38c1f357704e0b1a5b1ec47d3a84d47f8976d80.camel@kernel.org>
 <00fd29bc-205a-4c02-8c98-3c3876a2d0a7@redhat.com>
 <a3b6842838d9d32c93879ddf803a1f1cd37fb370.camel@kernel.org>
 <45246f77-40ce-43c7-bdbf-c8cb2b4dea68@redhat.com>
 <d44b8886de16ef0455b8f0e7df34f089c0fab288.camel@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <d44b8886de16ef0455b8f0e7df34f089c0fab288.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/16/25 6:50 AM, Jeff Layton wrote:
> On Wed, 2025-01-15 at 15:53 -0500, Steve Dickson wrote:
>>
>> On 1/15/25 1:33 PM, Jeff Layton wrote:
>>> On Wed, 2025-01-15 at 12:47 -0500, Steve Dickson wrote:
>>>>
>>>> On 1/15/25 12:35 PM, Jeff Layton wrote:
>>>>> On Wed, 2025-01-15 at 12:32 -0500, Steve Dickson wrote:
>>>>>>
>>>>>> On 1/15/25 12:00 PM, Scott Mayhew wrote:
>>>>>>> Move read_nfsd_conf() out of autostart_func() and into main().  Remove
>>>>>>> hard-coded NFSD_FAMILY_NAME in the first error message in
>>>>>>> netlink_msg_alloc() and make the error messages in netlink_msg_alloc()
>>>>>>> more descriptive/unique.
>>>>>>>
>>>>>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>>>>>> ---
>>>>>>> SteveD - this would go on top of Jeff's "nfsdctl: add support for new
>>>>>>> lockd configuration interface" patches.
>>>>>> Got it...
>>>>>>
>>>>>>>
>>>>>>>      utils/nfsdctl/nfsdctl.c | 8 ++++----
>>>>>>>      1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>>>>>> index 003daba5..f81c78ae 100644
>>>>>>> --- a/utils/nfsdctl/nfsdctl.c
>>>>>>> +++ b/utils/nfsdctl/nfsdctl.c
>>>>>>> @@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>>>>>      
>>>>>>>      	id = genl_ctrl_resolve(sock, family);
>>>>>>>      	if (id < 0) {
>>>>>>> -		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>>>>>>> +		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
>>>>>>>      		return NULL;
>>>>>>>      	}
>>>>>>>      
>>>>>>> @@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>>>>>      	}
>>>>>>>      
>>>>>>>      	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
>>>>>>> -		xlog(L_ERROR, "failed to allocate netlink message");
>>>>>>> +		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
>>>>>>>      		nlmsg_free(msg);
>>>>>>>      		return NULL;
>>>>>>>      	}
>>>>>>> @@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>>>>>      		}
>>>>>>>      	}
>>>>>>>      
>>>>>>> -	read_nfsd_conf();
>>>>>>> -
>>>>>>>      	grace = conf_get_num("nfsd", "grace-time", 0);
>>>>>>>      	ret = lockd_configure(sock, grace);
>>>>>>>      	if (ret) {
>>>>>>> @@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
>>>>>>>      	xlog_syslog(0);
>>>>>>>      	xlog_stderr(1);
>>>>>>>      
>>>>>>> +	read_nfsd_conf();
>>>>>>> +
>>>>>>>      	/* Parse the preliminary options */
>>>>>>>      	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>>>>>>>      		switch (opt) {
>>>>>> Ok... at this point we a prettier error message
>>>>>> $ nfsdctl nlm
>>>>>> nfsdctl: failed to resolve lockd generic netlink family
>>>>>>
>>>>>> But the point of this argument is:
>>>>>>
>>>>>> Get information about NLM (lockd) settings in the current net
>>>>>> namespace. This subcommand takes no arguments.
>>>>>>
>>>>>> How is that giving information from the running lockd?
>>>>>>
>>>>>> What am I missing??
>>>>>>
>>>>>
>>>>> You're missing a kernel that has the required netlink interface. To
>>>>> test this properly, you'll need to patch your kernel, until that patch
>>>>> makes it upstream.
>>>> Okay... I figured it was something like that. But doesn't make sense to
>>>> wait until the patch is in upstream so the argument can be properly
>>>> tested? Why add an argument that will always fail?
>>>>
>>>
>>> Why can't it be properly tested? It's just a matter of running a more
>>> recent kernel that has the right interfaces. That should be in linux-
>>> next soon (if not already).
>> I'm doing my testing on a 6.13.0-0.rc6 which will soon be
>> a 6.14 kernel... its my understanding the needed kernel
>> patch will be in the 6.15 kernel... Please correct me
>> if that is not true.
>>
>>>
>>> I think the question is whether we want to wait until the kernel
>>> interfaces trickle out into downstream distro kernels before we ship
>>> any userland support in an upstream project (nfs-utils).
>> Yes! As soon as the kernel support hits the upstream kernel,
>> we will be good to go. I just don't want to put a feature
>> in that will fail %100 of the time.
>>
>>>
>>> If you want to wait until it hits Fedora Rawhide kernels, then you're
>>> looking at about 10-12 weeks from now. If you want to wait until it
>>> makes it into a stable Fedora release kernel then we're looking at
>>> about 6 months from now.
>> nfsdctl is in all current Fedora stable releases, which
>> is the reason I'm pushing back. I do not want to put something
>> in that will make it fail. That just does not make sense to me.
>>
>>>
>>> I'll note that that it took 6 months to get the original nfsdctl
>>> patches merged because of the lag on kernel patches making it into
>>> distros, and I think that was way too long.
>> It took that long because there were issues with the command.
>> In which I was glad to help debug some of the issues...
>>
>> New technology takes time to develop... I just think this
>> is one of those cases.
>>
> 
> Ok, your call. To be clear though, that patch is part of my solution
> for this bug.
> 
>      https://issues.redhat.com/browse/RHEL-71698
> 
> If you're going to delay it for several months, then can I trouble you
> to come up with a fix for it that you find acceptable?
How is this a fix when the subcommand will not work
without the kernel patch?

I'm sure the subcommand works with the kernel patch
but without it... what's the point?

steved.


