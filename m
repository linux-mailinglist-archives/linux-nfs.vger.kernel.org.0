Return-Path: <linux-nfs+bounces-6650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6C9865FB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D682C1C24644
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Sep 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70C12CD96;
	Wed, 25 Sep 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWp/No1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853A17547;
	Wed, 25 Sep 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286722; cv=none; b=Y/21A5E2Gc2Rsi7BQKyVTPYQfoZ8lsT4OkoLhaI8NCxzFD1/XpNo0gYsEyHcET3lRj/oysW8U1/sbGkz6d3f4fl2Q9afnZteP/OeFWB6qtoUkChb/+UVTnJ5Ni46tIR5UqfqbRaJZVr2X5CrpGdwjIFM2t578RqxYAMzMnZlwbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286722; c=relaxed/simple;
	bh=alVX68I0f/idIfqF+eNxXFwMvfUI4IX6FVdDUnktgIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFN0XbVd3UIF2V8Wiiq2JB43tp2IRtzOkHJT3UukyVBwZ5EGjMRGfVgr6zxmhpfKbg9z/C5cuu5/KD/PD5cn+6RYsMrQ6WodG9mK9LIEDBJzLeKGcx4QlSV85Bc0AAh+u7Ysi43ryfKBlYRkdDDxuenUh/vcmw45WAY5bQW6Uo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWp/No1C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so12381766b.2;
        Wed, 25 Sep 2024 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727286719; x=1727891519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xFPD2xz4F5D0Kx47udSwooAOPAS4fTiV5ApCct2g7Y=;
        b=PWp/No1CX173laTTCudFNBev4J6p/s8yrqsv1kKvtvPskHkIBxlIK4Jp+UNAkaYMP1
         eVJvl5mjW2Ps2yvYdSjNDA1K0XkWn/hrRc2JsdMVn778KARQyKhizdUFOySQsJphWllf
         2o8ViJHTFTUHBC5SEDHYKljeUiy5k0VQUKnu3l+CGVSBL2oL+cxJ4TvyXwO9fVeEfQVo
         hBfkL5z6rL0m5er8+k/w31/Q34dNMyvdof0Y4BTHM9CHP2WOULQoZnFpxc/+P1VCDnPm
         LShh4NzYf1ncdaWdmeh7XMbYTJ+RWSd6/DitbwnyAyuvAc3Or6KFdiHrGLcAqSEgZmfT
         EFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286719; x=1727891519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xFPD2xz4F5D0Kx47udSwooAOPAS4fTiV5ApCct2g7Y=;
        b=CQ0jqrELXCg2KSeRv4AL0Cog/XENHSj2+VEkm+SI/e9OsnIJwEqglR23ECcVEhLJ9N
         M9HSbjuH3ItTArnfVJZUD7YE61Z13z1SFA/Pp7cy2oMz9AXyAKDYqF9Yb/gdH+oSFQ1j
         gSh22IxfoPZ+AhdwEld7+ikesiKutU6Ux6KDmen68TIND9ey8kI1FTQl0VHNo3KuR4iy
         NM+OELPYgXW+e3DfBaW9ZOGa257w3HjuXNItzjqNlie06UU4L7GFPBKoBpezGYA6whnD
         xNCZXKB9DS7FJaf++CN9xXtgDyZAKBmJ5wGQqSF2WvzFtFAznxwLM0fPsQBjQHkEQsVX
         4kBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc1YIgxn/oWzfOps76H+RBFGSTJRyjzHmmmCF35ir1C0TEXL30VqXA5BGEfTpnmWq8NQ20Yk6E7i7owyI=@vger.kernel.org, AJvYcCX/7ck7nsR4ozrZ1IFWSHiPy/Ro9oSGrXoCB+hhVsJL+H5PqySft6x+G76wWlDgyjftNnz+MMGv@vger.kernel.org
X-Gm-Message-State: AOJu0YxubWan+/qMt99izUdajI30yEDSaro6IBOWmtxIbaj9DjNyOE7i
	V6z2pvA6nf8Ksre9D5GG7FS3j4UYF6bsv2Kpqs2AbWv6YhJYHcA5
X-Google-Smtp-Source: AGHT+IFTzgFb06wex1fc05PYQ7eZMP8PoJbcxB5l9scmuZBgH4Omvl3K6XxbMz5Qsv282dn87dO/dQ==
X-Received: by 2002:a17:907:6d1f:b0:a8d:42c3:5f68 with SMTP id a640c23a62f3a-a93a036abebmr380721066b.23.1727286718749;
        Wed, 25 Sep 2024 10:51:58 -0700 (PDT)
Received: from [192.168.178.20] (dh207-43-171.xnet.hr. [88.207.43.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f4f86dsm235495466b.51.2024.09.25.10.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:51:58 -0700 (PDT)
Message-ID: <1430dbab-0540-448b-b503-e53268f60bfc@gmail.com>
Date: Wed, 25 Sep 2024 19:51:19 +0200
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
References: <> <b4435709-e112-4667-b458-411856a28389@gmail.com>
 <172717463033.17050.14835776993804647247@noble.neil.brown.name>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <172717463033.17050.14835776993804647247@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/24/24 12:43, NeilBrown wrote:
> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
>> Hi, Neil,
>>
>> Apparently I was duplicating work.
>>
>> However, using
>>
>> 	char servername[UNIX_PATH_MAX];
>>
>> has some advantages when compared to hard-coded integer?
>>
>> Correct me if I'm wrong.
> 
> I think you are wrong.  I agree that 48 is a poor choice.  I think that
> UNIX_PATH_MAX is a poor choice too.  The "servername" string is used for
> things other than a UNIX socket path.
> Did you read all of the thread that I provided a link for?  I suggest a
> more meaningful number in one of the later messages.

I see. Thanks for the tip. However, if UNIX_PATH_MAX ever changes in the
future, the decl

    char servername[108];

might be missed when fixing all the changes caused by the change of the
macro definition? Am I wrong again?

Making it logically depend on the system limits might save some headache
in the future, perhaps.

If really the biggest string that will be copied there is: "/var/run/rpcbind.sock",
you are then right - stack space is precious commodity, and allocating
via kmalloc() might preempt the caller thread.

However, you got to this five weeks earlier - but the patch did not
propagate to the main vanilla torvalds tree.

Best regards,
Mirsad Todorovac

> But I really think that the problem here is the warning.  The servername
> array is ALWAYS big enough for any string that will actually be copied
> into it.  gcc isn't clever enough to detect that, but it tries to be
> clever enough to tell you that even though you used snprintf so you know
> that the string might in theory overflow, it decides to warn you about
> something you already know.
> 
> i.e.  if you want to fix this, I would rather you complain the the
> compiler writers.  Or maybe suggest a #pragma to silence the warning in
> this case.  Or maybe examine all of the code instead of the one line
> that triggers the warning and see if there is a better approach to
> providing the functionality that is being provided here.
> 
> NeilBrown
> 
>>
>> Best regards,
>> Mirsad Todorovac
>>
>> On 9/23/24 23:24, NeilBrown wrote:
>>> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
>>>> GCC 13.2.0 reported with W=1 build option the following warning:
>>>
>>> See
>>>   https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.dev/
>>>
>>> I don't think anyone really cares about this one.
>>>
>>> NeilBrown
>>>
>>>
>>>>
>>>> net/sunrpc/clnt.c: In function ‘rpc_create’:
>>>> net/sunrpc/clnt.c:582:75: warning: ‘%s’ directive output may be truncated writing up to 107 bytes into \
>>>> 					a region of size 48 [-Wformat-truncation=]
>>>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>>>       |                                                                           ^~
>>>> net/sunrpc/clnt.c:582:33: note: ‘snprintf’ output between 1 and 108 bytes into a destination of size 48
>>>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>   583 |                                          sun->sun_path);
>>>>       |                                          ~~~~~~~~~~~~~~
>>>>
>>>>    548         };
>>>>  → 549         char servername[48];
>>>>    550         struct rpc_clnt *clnt;
>>>>    551         int i;
>>>>    552
>>>>    553         if (args->bc_xprt) {
>>>>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
>>>>    555                 xprt = args->bc_xprt->xpt_bc_xprt;
>>>>    556                 if (xprt) {
>>>>    557                         xprt_get(xprt);
>>>>    558                         return rpc_create_xprt(args, xprt);
>>>>    559                 }
>>>>    560         }
>>>>    561
>>>>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
>>>>    563                 xprtargs.flags |= XPRT_CREATE_INFINITE_SLOTS;
>>>>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
>>>>    565                 xprtargs.flags |= XPRT_CREATE_NO_IDLE_TIMEOUT;
>>>>    566         /*
>>>>    567          * If the caller chooses not to specify a hostname, whip
>>>>    568          * up a string representation of the passed-in address.
>>>>    569          */
>>>>    570         if (xprtargs.servername == NULL) {
>>>>    571                 struct sockaddr_un *sun =
>>>>    572                                 (struct sockaddr_un *)args->address;
>>>>    573                 struct sockaddr_in *sin =
>>>>    574                                 (struct sockaddr_in *)args->address;
>>>>    575                 struct sockaddr_in6 *sin6 =
>>>>    576                                 (struct sockaddr_in6 *)args->address;
>>>>    577
>>>>    578                 servername[0] = '\0';
>>>>    579                 switch (args->address->sa_family) {
>>>>  → 580                 case AF_LOCAL:
>>>>  → 581                         if (sun->sun_path[0])
>>>>  → 582                                 snprintf(servername, sizeof(servername), "%s",
>>>>  → 583                                          sun->sun_path);
>>>>  → 584                         else
>>>>  → 585                                 snprintf(servername, sizeof(servername), "@%s",
>>>>  → 586                                          sun->sun_path+1);
>>>>  → 587                         break;
>>>>    588                 case AF_INET:
>>>>    589                         snprintf(servername, sizeof(servername), "%pI4",
>>>>    590                                  &sin->sin_addr.s_addr);
>>>>    591                         break;
>>>>    592                 case AF_INET6:
>>>>    593                         snprintf(servername, sizeof(servername), "%pI6",
>>>>    594                                  &sin6->sin6_addr);
>>>>    595                         break;
>>>>    596                 default:
>>>>    597                         /* caller wants default server name, but
>>>>    598                          * address family isn't recognized. */
>>>>    599                         return ERR_PTR(-EINVAL);
>>>>    600                 }
>>>>    601                 xprtargs.servername = servername;
>>>>    602         }
>>>>    603
>>>>    604         xprt = xprt_create_transport(&xprtargs);
>>>>    605         if (IS_ERR(xprt))
>>>>    606                 return (struct rpc_clnt *)xprt;
>>>>
>>>> After the address family AF_LOCAL was added in the commit 176e21ee2ec89, the old hard-coded
>>>> size for servername of char servername[48] no longer fits. The maximum AF_UNIX address size
>>>> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.h" .
>>>>
>>>> The lines 580-587 were added later, addressing the leading zero byte '\0', but did not fix
>>>> the hard-coded servername limit.
>>>>
>>>> The AF_UNIX address was truncated to 47 bytes + terminating null byte. This patch will fix the
>>>> servername in AF_UNIX family to the maximum permitted by the system:
>>>>
>>>>    548         };
>>>>  → 549         char servername[UNIX_PATH_MAX];
>>>>    550         struct rpc_clnt *clnt;
>>>>
>>>> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
>>>> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should support AF_INET6 addresses")
>>>> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
>>>> Cc: Neil Brown <neilb@suse.de>
>>>> Cc: Chuck Lever <chuck.lever@oracle.com>
>>>> Cc: Trond Myklebust <trondmy@kernel.org>
>>>> Cc: Anna Schumaker <anna@kernel.org>
>>>> Cc: Jeff Layton <jlayton@kernel.org>
>>>> Cc: Olga Kornievskaia <okorniev@redhat.com>
>>>> Cc: Dai Ngo <Dai.Ngo@oracle.com>
>>>> Cc: Tom Talpey <tom@talpey.com>
>>>> Cc: "David S. Miller" <davem@davemloft.net>
>>>> Cc: Eric Dumazet <edumazet@google.com>
>>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>>> Cc: linux-nfs@vger.kernel.org
>>>> Cc: netdev@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>>>> ---
>>>>  v1:
>>>> 	initial version.
>>>>
>>>>  net/sunrpc/clnt.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>> index 09f29a95f2bc..67099719893e 100644
>>>> --- a/net/sunrpc/clnt.c
>>>> +++ b/net/sunrpc/clnt.c
>>>> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
>>>>  		.connect_timeout = args->connect_timeout,
>>>>  		.reconnect_timeout = args->reconnect_timeout,
>>>>  	};
>>>> -	char servername[48];
>>>> +	char servername[UNIX_PATH_MAX];
>>>>  	struct rpc_clnt *clnt;
>>>>  	int i;
>>>>  
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>
>>
> 

