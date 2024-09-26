Return-Path: <linux-nfs+bounces-6666-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A509879ED
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD421F28909
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Sep 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6317BB33;
	Thu, 26 Sep 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU/oCeVh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510C154C0A;
	Thu, 26 Sep 2024 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380781; cv=none; b=fdrq6SlohPNNc3kXRYq9zkMgeZje2QsmrKYYDxp4JIfR2VB/dWWsrhgV6HTdySlyTOzVdl/Nxy5cFR7UYs5GpdiWs3kqqSvoUbRK+u/Jp//8V6pFr3X92+1bwJ8w1RWtq2HQ7O8//XQQx1M7Ka6ucDSbEBJXug3XKv1DgghoMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380781; c=relaxed/simple;
	bh=B7xRmceLqOQECJKIP2YZzwCwsdhIJEa/XuxzZm3L1vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS3yJon4WMtZ+uZOxaFCKvsmkTrRhCf+zhuu1y1Uupxh7eNc5w27k4jkHWRmu5c4P7owE/cZNeDwFX5adCfD4MmlvYLqwFkTvVtBwrcPS8YoheHrnlOdQAL6w4eLNIjZbl7+z1vuT7SeLj/2SB1Ymt44Bixqg1n6pwRbP3lrsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU/oCeVh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so977612f8f.1;
        Thu, 26 Sep 2024 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727380778; x=1727985578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jN7DzpENRViOixLYvsj5FUd1KxtK1F+ddSDlgL0gXR4=;
        b=nU/oCeVhdhkLBZndPxlIct2Wao6Mey2qtUtHAf8upfu9DeFHt35GN1qRB/N0RPhvMo
         VvndYUkO0Ni/ab3rA449HAwKz7Ek4JwIpo8kiJfph+xQtidVxFTR6KgWxa9rFPrQLvsU
         RTSUHlmuI6eXpdFO2qIPg0Mb+zeKJuuTjzLuY2f00r9tOqtdsxIHxpR26CXuWm+yi8Z1
         5dnEeym+PHlhl0HCZHr79twp2dsledCnYD+yw3+pG9OJ4jECCJSi8xoryWtJirUrFJE2
         i/r4g+MJptEf/fVQRyCjaNhAWTbfU08TXvx9O8PKR9Ubqpc5+iQqmsLl6D9s1DGlSoM1
         8vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727380778; x=1727985578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN7DzpENRViOixLYvsj5FUd1KxtK1F+ddSDlgL0gXR4=;
        b=v7vYslLKmpFuq1VuY2x+7amCa/mY5En3/EpAwfUHOkhxc9ODtpCEDyFJgCkLKpT4u5
         ISImzhrYaoTqscBOxFBtNbvxNq55jmyGXwDekMARNV125C0LAvPXu6JX6qSgsSRIJX+V
         tbS3iXG9oESf/wXmHBMs6oZy1zSx6eYGQdXRdcNMwLdlB/QB6LN4YkeZEicipEQFgIik
         9iWWIjXPThd1RmUQjoOLeG5LWGxl6EKMqyNHHfJ05x99bQbu5CPPH2Mwsxu1oHbkB2zZ
         MFruHBvksEB4PWVGfmYthSYAZI7A3oQkt5vvBbt5vGuY3tkcalWcBi4g0K9PWB2JRQje
         kkrA==
X-Forwarded-Encrypted: i=1; AJvYcCV1k/7tyPcsi14eejzPnrwHg6Xaolk/2vmODaKXs/YFJ3wEFU9DpFiQegw/D3KFVB5kz1u3seb2beosaUk=@vger.kernel.org, AJvYcCWPAlXjRzriwEs0D1g/iXQL4XLovU/IKA5V0BwLuacffoTFYYTa+Y+N2NTr2QxJ/AL8xzSGNKqO@vger.kernel.org
X-Gm-Message-State: AOJu0YxvwZOlSP2wAdjgMfX7CBT+lY/dHuDkLQg4J3PN+tyx/IyYzvL7
	0SIz18pu/L82hIPZwZilDw+mZ8K+kUChRBgJmEQYC9+gE4gli5BK/Ze+UA==
X-Google-Smtp-Source: AGHT+IGqxxV43b9AZ83bp6yq01gUav0PxUNVKuBoUxm0BSLUtELWe4bs8vZbrpobZo6Vfnf1D9oleQ==
X-Received: by 2002:a05:6000:1141:b0:378:89d8:822e with SMTP id ffacd0b85a97d-37cd5a99b65mr469450f8f.27.1727380777515;
        Thu, 26 Sep 2024 12:59:37 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-171.xnet.hr. [88.207.43.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299e5bbsm32738466b.215.2024.09.26.12.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 12:59:37 -0700 (PDT)
Message-ID: <40750d1b-ab1f-4ac4-93ad-97f3bd0aa142@gmail.com>
Date: Thu, 26 Sep 2024 21:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] SUNRPC: Make enough room in servername[] for
 AF_UNIX addresses
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <> <1430dbab-0540-448b-b503-e53268f60bfc@gmail.com>
 <172730054387.17050.12447592116066223771@noble.neil.brown.name>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <172730054387.17050.12447592116066223771@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/24 23:42, NeilBrown wrote:
> On Thu, 26 Sep 2024, Mirsad Todorovac wrote:
>> On 9/24/24 12:43, NeilBrown wrote:
>>> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
>>>> Hi, Neil,
>>>>
>>>> Apparently I was duplicating work.
>>>>
>>>> However, using
>>>>
>>>> 	char servername[UNIX_PATH_MAX];
>>>>
>>>> has some advantages when compared to hard-coded integer?
>>>>
>>>> Correct me if I'm wrong.
>>>
>>> I think you are wrong.  I agree that 48 is a poor choice.  I think that
>>> UNIX_PATH_MAX is a poor choice too.  The "servername" string is used for
>>> things other than a UNIX socket path.
>>> Did you read all of the thread that I provided a link for?  I suggest a
>>> more meaningful number in one of the later messages.
>>
>> I see. Thanks for the tip. However, if UNIX_PATH_MAX ever changes in the
>> future, the decl
>>
>>     char servername[108];
>>
>> might be missed when fixing all the changes caused by the change of the
>> macro definition? Am I wrong again?
> 
> Realistically UNIX_PATH_MAX is never going to change, and if it did that
> would not affect the correctness of this code.
> 
>>
>> Making it logically depend on the system limits might save some headache
>> in the future, perhaps.
> 
> Unlikely.  Did you look to see what the failure mode is here?
> servername is only ever used in log messages.  Truncating names in log
> message at 8 bytes can certainly be annoying.  Truncating at 48 bytes is
> much less of a problem.

Well, I agree that in this particular case you are correct, but this is not
about you or me being right or wrong, but that a macro would be more descriptive
than "48" or "108", unless you are used to count the beads while chanting mantras
:-)

>> If really the biggest string that will be copied there is: "/var/run/rpcbind.sock",
>> you are then right - stack space is precious commodity, and allocating
>> via kmalloc() might preempt the caller thread.
> 
> It might.  But the string is always passed to xprt_create_transport()
> which always calls kstrdup() on it.  So maybe that doesn't matter.  (As
> I said, understanding the big picture is important).

Ah. I agree, this is why I consider myself a disciple. While in the old
system it was considered asa breach of teacher's authority, other schools
of thinking encouraged questions and debate. ;-)

>> However, you got to this five weeks earlier - but the patch did not
>> propagate to the main vanilla torvalds tree.
> 
> Actually it has.
> 
> Commit 9090a7f78623 ("SUNRPC: Fix -Wformat-truncation warning")
> 
> $ git show --format=fuller  9090a7f78623 | grep CommitDate
> CommitDate: Mon Sep 23 15:03:13 2024 -0400
> 
> Linus merged it 
> Commit 684a64bf32b6 ("Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs")
> Date:   Tue Sep 24 15:44:18 2024 -0700
> 
> That patch used RPC_MAXNETNAMELEN which is the least-ugly simple fix.

Yes, my build was somewhat before that date:

-rw-r--r-- 1 root root 18977280 Sep 21 15:44 vmlinuz-6.11.0-gc13-x86-64-tmem-07462-g1868f9d0260e

But I whole-heartedly agree with not taking a literal integer. As we build things to last,
in a "design for life", so I believe that self-documenting source isan advantage to the
counting of places where some integers appear, and what each one meant.

As I said before, this is nothing target SUNRPC implementation, it was among the first compiler
warnings with make W=1 in build. I apologise if that sounded personal.

> Thanks for your interest in improving Linux.

You are most welcome. Thank you for your kind remark.

I am glad that you recognise my bug reports as a positive contribution, despite sometimes (or often)
duplicating work. But, please understand, on my level I do not even have enough disk space for all
the trees, let alone building all of them.

Maybe the best I could promise is to test linux-next and net-next trees.

Probably I could give more meaningful contribution with some expert advice, even when this episode
on SUNRPC was not a waste of time, but an opportunity to learn from the best. :-)

Best regards,
Mirsad Todorovac

> NeilBrown
> 
>>
>> Best regards,
>> Mirsad Todorovac
>>
>>> But I really think that the problem here is the warning.  The servername
>>> array is ALWAYS big enough for any string that will actually be copied
>>> into it.  gcc isn't clever enough to detect that, but it tries to be
>>> clever enough to tell you that even though you used snprintf so you know
>>> that the string might in theory overflow, it decides to warn you about
>>> something you already know.
>>>
>>> i.e.  if you want to fix this, I would rather you complain the the
>>> compiler writers.  Or maybe suggest a #pragma to silence the warning in
>>> this case.  Or maybe examine all of the code instead of the one line
>>> that triggers the warning and see if there is a better approach to
>>> providing the functionality that is being provided here.
>>>
>>> NeilBrown
>>>
>>>>
>>>> Best regards,
>>>> Mirsad Todorovac
>>>>
>>>> On 9/23/24 23:24, NeilBrown wrote:
>>>>> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
>>>>>> GCC 13.2.0 reported with W=1 build option the following warning:
>>>>>
>>>>> See
>>>>>   https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.dev/
>>>>>
>>>>> I don't think anyone really cares about this one.
>>>>>
>>>>> NeilBrown
>>>>>
>>>>>
>>>>>>
>>>>>> net/sunrpc/clnt.c: In function ‘rpc_create’:
>>>>>> net/sunrpc/clnt.c:582:75: warning: ‘%s’ directive output may be truncated writing up to 107 bytes into \
>>>>>> 					a region of size 48 [-Wformat-truncation=]
>>>>>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>>>>>       |                                                                           ^~
>>>>>> net/sunrpc/clnt.c:582:33: note: ‘snprintf’ output between 1 and 108 bytes into a destination of size 48
>>>>>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>>>>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>   583 |                                          sun->sun_path);
>>>>>>       |                                          ~~~~~~~~~~~~~~
>>>>>>
>>>>>>    548         };
>>>>>>  → 549         char servername[48];
>>>>>>    550         struct rpc_clnt *clnt;
>>>>>>    551         int i;
>>>>>>    552
>>>>>>    553         if (args->bc_xprt) {
>>>>>>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
>>>>>>    555                 xprt = args->bc_xprt->xpt_bc_xprt;
>>>>>>    556                 if (xprt) {
>>>>>>    557                         xprt_get(xprt);
>>>>>>    558                         return rpc_create_xprt(args, xprt);
>>>>>>    559                 }
>>>>>>    560         }
>>>>>>    561
>>>>>>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
>>>>>>    563                 xprtargs.flags |= XPRT_CREATE_INFINITE_SLOTS;
>>>>>>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
>>>>>>    565                 xprtargs.flags |= XPRT_CREATE_NO_IDLE_TIMEOUT;
>>>>>>    566         /*
>>>>>>    567          * If the caller chooses not to specify a hostname, whip
>>>>>>    568          * up a string representation of the passed-in address.
>>>>>>    569          */
>>>>>>    570         if (xprtargs.servername == NULL) {
>>>>>>    571                 struct sockaddr_un *sun =
>>>>>>    572                                 (struct sockaddr_un *)args->address;
>>>>>>    573                 struct sockaddr_in *sin =
>>>>>>    574                                 (struct sockaddr_in *)args->address;
>>>>>>    575                 struct sockaddr_in6 *sin6 =
>>>>>>    576                                 (struct sockaddr_in6 *)args->address;
>>>>>>    577
>>>>>>    578                 servername[0] = '\0';
>>>>>>    579                 switch (args->address->sa_family) {
>>>>>>  → 580                 case AF_LOCAL:
>>>>>>  → 581                         if (sun->sun_path[0])
>>>>>>  → 582                                 snprintf(servername, sizeof(servername), "%s",
>>>>>>  → 583                                          sun->sun_path);
>>>>>>  → 584                         else
>>>>>>  → 585                                 snprintf(servername, sizeof(servername), "@%s",
>>>>>>  → 586                                          sun->sun_path+1);
>>>>>>  → 587                         break;
>>>>>>    588                 case AF_INET:
>>>>>>    589                         snprintf(servername, sizeof(servername), "%pI4",
>>>>>>    590                                  &sin->sin_addr.s_addr);
>>>>>>    591                         break;
>>>>>>    592                 case AF_INET6:
>>>>>>    593                         snprintf(servername, sizeof(servername), "%pI6",
>>>>>>    594                                  &sin6->sin6_addr);
>>>>>>    595                         break;
>>>>>>    596                 default:
>>>>>>    597                         /* caller wants default server name, but
>>>>>>    598                          * address family isn't recognized. */
>>>>>>    599                         return ERR_PTR(-EINVAL);
>>>>>>    600                 }
>>>>>>    601                 xprtargs.servername = servername;
>>>>>>    602         }
>>>>>>    603
>>>>>>    604         xprt = xprt_create_transport(&xprtargs);
>>>>>>    605         if (IS_ERR(xprt))
>>>>>>    606                 return (struct rpc_clnt *)xprt;
>>>>>>
>>>>>> After the address family AF_LOCAL was added in the commit 176e21ee2ec89, the old hard-coded
>>>>>> size for servername of char servername[48] no longer fits. The maximum AF_UNIX address size
>>>>>> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.h" .
>>>>>>
>>>>>> The lines 580-587 were added later, addressing the leading zero byte '\0', but did not fix
>>>>>> the hard-coded servername limit.
>>>>>>
>>>>>> The AF_UNIX address was truncated to 47 bytes + terminating null byte. This patch will fix the
>>>>>> servername in AF_UNIX family to the maximum permitted by the system:
>>>>>>
>>>>>>    548         };
>>>>>>  → 549         char servername[UNIX_PATH_MAX];
>>>>>>    550         struct rpc_clnt *clnt;
>>>>>>
>>>>>> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
>>>>>> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should support AF_INET6 addresses")
>>>>>> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
>>>>>> Cc: Neil Brown <neilb@suse.de>
>>>>>> Cc: Chuck Lever <chuck.lever@oracle.com>
>>>>>> Cc: Trond Myklebust <trondmy@kernel.org>
>>>>>> Cc: Anna Schumaker <anna@kernel.org>
>>>>>> Cc: Jeff Layton <jlayton@kernel.org>
>>>>>> Cc: Olga Kornievskaia <okorniev@redhat.com>
>>>>>> Cc: Dai Ngo <Dai.Ngo@oracle.com>
>>>>>> Cc: Tom Talpey <tom@talpey.com>
>>>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>>>> Cc: linux-nfs@vger.kernel.org
>>>>>> Cc: netdev@vger.kernel.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>>>>>> ---
>>>>>>  v1:
>>>>>> 	initial version.
>>>>>>
>>>>>>  net/sunrpc/clnt.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>> index 09f29a95f2bc..67099719893e 100644
>>>>>> --- a/net/sunrpc/clnt.c
>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
>>>>>>  		.connect_timeout = args->connect_timeout,
>>>>>>  		.reconnect_timeout = args->reconnect_timeout,
>>>>>>  	};
>>>>>> -	char servername[48];
>>>>>> +	char servername[UNIX_PATH_MAX];
>>>>>>  	struct rpc_clnt *clnt;
>>>>>>  	int i;
>>>>>>  
>>>>>> -- 
>>>>>> 2.43.0
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

