Return-Path: <linux-nfs+bounces-9264-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC71A12D08
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D3018893DF
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2025 20:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908D1D9A78;
	Wed, 15 Jan 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQHLsXg4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEB21D88BE
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974438; cv=none; b=Q1UykCtuqLiN7dtHFbFJ8JOjusXlA1z6dwEca1KlX2jgzme2eYl/EZhTjuPxh+uPE3pCVensf10hMxJogEIpyoj6BNCucLUwvmFyg5ihZ3Nd8kOsSsM6bwPHgw45eprSi4mZXTbDXkfilp+fTiyKox/xUgm2KywQp9SU1yl9zcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974438; c=relaxed/simple;
	bh=6XYheyQ435PILcJUE/anXZaKjT8iP+M7/vZNlYd/NiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tm9UcuIDYCKsC6WU0tRu6A/eB1o4NlkT3W2SFwxrek6EUhUiOEfsV31EdWZ1LL7OP6TLtyC65KrYjyeIrI5MsgrJ6hCzXZqsCVhWkbLmnIi8E2RSe+jtB0eEqo4wid5mdhZQy5SYsCCGRiujvTF9ZNbCIyCrWIdDlPgK/8p/634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQHLsXg4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736974435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5yyVfqMXpGd4AIKyV/rglAW9tSUP9VJVWhI4ychDT0=;
	b=DQHLsXg4HHcomFlaooHtbfl3QBX3mMTnV3svdFCHa10ie5a9TE0kzfhUxM1fDTt+yUahVA
	d68AcT65Pp/fOwrk3MMawNrOyM0leXDnalcGFXuCYu9efx0HEy3bZCfpKK78ztTWaz31sX
	K3086+0fPcWn0n8tHaDVPgU+L0etGuw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-l7TO25adMjGLF0XLmKCRjA-1; Wed, 15 Jan 2025 15:53:54 -0500
X-MC-Unique: l7TO25adMjGLF0XLmKCRjA-1
X-Mimecast-MFC-AGG-ID: l7TO25adMjGLF0XLmKCRjA
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166e907b5eso1810395ad.3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jan 2025 12:53:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974433; x=1737579233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5yyVfqMXpGd4AIKyV/rglAW9tSUP9VJVWhI4ychDT0=;
        b=tca/yGhEZAuuFT+9ZLYPlQJIBMgnNPUDGGr+1w9ymAqiVBsrEyH95RSu61869O+vJN
         e9Ey5beQSj0JYFEvfba8P3C/x3JzrK8SP/0ADEk9lj0IKWEdjiXsiYYvYrnNQoKcPsGM
         Yvayfr9t04DJWYrcCFiHf2i7MWF1Vp0t/nG74HkFC4Oc3sR2E8E87i3MVUYF9aN1Z8Vg
         8wxEX8j6tSGgLRf0DrYJeZuApw70j36wSd6CiNuujj81E0ajkJmu3tpknkPnOvVNq3Gh
         fmDQx0pkxw8al6MJz/uLJSre4sQMwmdoPOhA+bGIrG23WKjkGAxsXEaCwsSUYtlWMc5V
         0ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7yDKIas7lD3m7+p0ejaelzsO3JbkWRuQdfvpVx6Q0IdQFYG/6pPwlmYDyR+guocKnqVaKOmwunt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdX0Q+L3eIaWCukF1/ypJBVgbKVDn2TbYVq3B2+q+CnQuuk2f
	7OVcGAvsVs3aPtqP1T1nVAX6xNvtEeQCebh4gFyi7TViOPCrAGq5Ow3FhbUQJZ78TbTyav3YB1e
	6PTtTWz2ZhpwGsNp04jr0NjddFZCmRBX7Pq0A6KO1QCbtbeoWuPofI03HPKDS68X+9w==
X-Gm-Gg: ASbGnctV4Y+RCLXIzXq/WsC7LTSCGZobHz0Wtc89pDhOE5oRuFCb0acJAQYHN9quUN3
	vOPXT6G/xYmXiRK7BtYjGpnMFDXtviaSmVQ7W5DZF1U9i/bAQkITxOFRCJoFkoUG844XQO56cl3
	Sylkc962FmJJINLsEZXelZEgV0WHNxvuRtlpqC05BctIzNxFZftPa673DqG6OSlvN4F7dVcVwtV
	bl6utCgW9NFZBNuoqsSCnXCtl8nn+bqgWGCs9izqzQJbUjMasefqoSX
X-Received: by 2002:a17:902:d2ca:b0:216:56d5:d87 with SMTP id d9443c01a7336-21a83f8ea52mr482578735ad.34.1736974432591;
        Wed, 15 Jan 2025 12:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyXQ3+JQD5u0CtzUvROrfh5mO4WcgrQy/rC2EFzGFjj4j3iGg7/0cTjuY40o5jqGE0/Kg+0Q==
X-Received: by 2002:a17:902:d2ca:b0:216:56d5:d87 with SMTP id d9443c01a7336-21a83f8ea52mr482578345ad.34.1736974432142;
        Wed, 15 Jan 2025 12:53:52 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f839sm86062785ad.15.2025.01.15.12.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 12:53:51 -0800 (PST)
Message-ID: <45246f77-40ce-43c7-bdbf-c8cb2b4dea68@redhat.com>
Date: Wed, 15 Jan 2025 15:53:48 -0500
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
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <a3b6842838d9d32c93879ddf803a1f1cd37fb370.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/25 1:33 PM, Jeff Layton wrote:
> On Wed, 2025-01-15 at 12:47 -0500, Steve Dickson wrote:
>>
>> On 1/15/25 12:35 PM, Jeff Layton wrote:
>>> On Wed, 2025-01-15 at 12:32 -0500, Steve Dickson wrote:
>>>>
>>>> On 1/15/25 12:00 PM, Scott Mayhew wrote:
>>>>> Move read_nfsd_conf() out of autostart_func() and into main().  Remove
>>>>> hard-coded NFSD_FAMILY_NAME in the first error message in
>>>>> netlink_msg_alloc() and make the error messages in netlink_msg_alloc()
>>>>> more descriptive/unique.
>>>>>
>>>>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>>>>> ---
>>>>> SteveD - this would go on top of Jeff's "nfsdctl: add support for new
>>>>> lockd configuration interface" patches.
>>>> Got it...
>>>>
>>>>>
>>>>>     utils/nfsdctl/nfsdctl.c | 8 ++++----
>>>>>     1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
>>>>> index 003daba5..f81c78ae 100644
>>>>> --- a/utils/nfsdctl/nfsdctl.c
>>>>> +++ b/utils/nfsdctl/nfsdctl.c
>>>>> @@ -436,7 +436,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>>>     
>>>>>     	id = genl_ctrl_resolve(sock, family);
>>>>>     	if (id < 0) {
>>>>> -		xlog(L_ERROR, "%s not found", NFSD_FAMILY_NAME);
>>>>> +		xlog(L_ERROR, "failed to resolve %s generic netlink family", family);
>>>>>     		return NULL;
>>>>>     	}
>>>>>     
>>>>> @@ -447,7 +447,7 @@ static struct nl_msg *netlink_msg_alloc(struct nl_sock *sock, const char *family
>>>>>     	}
>>>>>     
>>>>>     	if (!genlmsg_put(msg, 0, 0, id, 0, 0, 0, 0)) {
>>>>> -		xlog(L_ERROR, "failed to allocate netlink message");
>>>>> +		xlog(L_ERROR, "failed to add generic netlink headers to netlink message");
>>>>>     		nlmsg_free(msg);
>>>>>     		return NULL;
>>>>>     	}
>>>>> @@ -1509,8 +1509,6 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
>>>>>     		}
>>>>>     	}
>>>>>     
>>>>> -	read_nfsd_conf();
>>>>> -
>>>>>     	grace = conf_get_num("nfsd", "grace-time", 0);
>>>>>     	ret = lockd_configure(sock, grace);
>>>>>     	if (ret) {
>>>>> @@ -1728,6 +1726,8 @@ int main(int argc, char **argv)
>>>>>     	xlog_syslog(0);
>>>>>     	xlog_stderr(1);
>>>>>     
>>>>> +	read_nfsd_conf();
>>>>> +
>>>>>     	/* Parse the preliminary options */
>>>>>     	while ((opt = getopt_long(argc, argv, "+hdsV", pre_options, NULL)) != -1) {
>>>>>     		switch (opt) {
>>>> Ok... at this point we a prettier error message
>>>> $ nfsdctl nlm
>>>> nfsdctl: failed to resolve lockd generic netlink family
>>>>
>>>> But the point of this argument is:
>>>>
>>>> Get information about NLM (lockd) settings in the current net
>>>> namespace. This subcommand takes no arguments.
>>>>
>>>> How is that giving information from the running lockd?
>>>>
>>>> What am I missing??
>>>>
>>>
>>> You're missing a kernel that has the required netlink interface. To
>>> test this properly, you'll need to patch your kernel, until that patch
>>> makes it upstream.
>> Okay... I figured it was something like that. But doesn't make sense to
>> wait until the patch is in upstream so the argument can be properly
>> tested? Why add an argument that will always fail?
>>
> 
> Why can't it be properly tested? It's just a matter of running a more
> recent kernel that has the right interfaces. That should be in linux-
> next soon (if not already).
I'm doing my testing on a 6.13.0-0.rc6 which will soon be
a 6.14 kernel... its my understanding the needed kernel
patch will be in the 6.15 kernel... Please correct me
if that is not true.

> 
> I think the question is whether we want to wait until the kernel
> interfaces trickle out into downstream distro kernels before we ship
> any userland support in an upstream project (nfs-utils).
Yes! As soon as the kernel support hits the upstream kernel,
we will be good to go. I just don't want to put a feature
in that will fail %100 of the time.

> 
> If you want to wait until it hits Fedora Rawhide kernels, then you're
> looking at about 10-12 weeks from now. If you want to wait until it
> makes it into a stable Fedora release kernel then we're looking at
> about 6 months from now.
nfsdctl is in all current Fedora stable releases, which
is the reason I'm pushing back. I do not want to put something
in that will make it fail. That just does not make sense to me.

> 
> I'll note that that it took 6 months to get the original nfsdctl
> patches merged because of the lag on kernel patches making it into
> distros, and I think that was way too long.
It took that long because there were issues with the command.
In which I was glad to help debug some of the issues...

New technology takes time to develop... I just think this
is one of those cases.

steved.


