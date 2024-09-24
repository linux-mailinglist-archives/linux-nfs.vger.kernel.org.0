Return-Path: <linux-nfs+bounces-6626-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3262D983C6A
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 07:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92960B20EC5
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2024 05:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DCE41C6E;
	Tue, 24 Sep 2024 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpPoBMLG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8FE6EB4A;
	Tue, 24 Sep 2024 05:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727156344; cv=none; b=JZ4DZ2AIieGtz5g7mP2h9annpqiBFqSr2LnLLFLNEaO+xQgTzXkPfzYy/oVYkc5sNNqFALT4JzheOB5KWVBqMHoxKnox5tW6CholDoW8Z6XRId18rG15a7f3gCzv7+IT3O3/smt41ljkC+eO9gJGQgjPikV+OI5HlppqIsMuxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727156344; c=relaxed/simple;
	bh=U5le8ymcpL6fgmjPXr7fdfxNLUKlOZxbg0KwrhlHLIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEAEpvfURzhBkeFGo2pMAQJ1YtQxVeCMgHB1jATbbzXwnU0jzeRtp0Net2t8ndOC+MXzRxvTG9yn0GRIgYm6TMnJ7Z/DG0DA+bMsCi4loSdQ3AmOCUYk+A6gR31C7UTcwLoX5b/nIvJodZjSnjKL0wDyWRi5l15bt+JBCvCNUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpPoBMLG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d100e9ce0so615141566b.2;
        Mon, 23 Sep 2024 22:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727156340; x=1727761140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLVLF61+yFfqKaGatHZnysy4rd6LUhQdcSaCgQaw3yg=;
        b=jpPoBMLG6uuR7LoyO9ceH7MsLgoIVYaQu024K3L6DWL2teFGCEha66DBL7wZEvyNTW
         v44aB4Duw1tmGNMU6aXsxYBpt1KyaQnzYARG7y0OwJGQVoaV1oeKN2GTDDv1hCO2yEhV
         +pRamfpW66NEY4kcMQcoU3rFEwUDK/llhcTvBxVdxI2FhaUuRGQZJYqHX/0+2W0S4JXZ
         WpT/u9DHy2Kjoe8zwNKsbH36AbaFHF8EmXjbXtZGuX8XeNGtFKmNZ6uP1lsDURuas/2Z
         WoVlZ+WsaFcJqIohHUT0AJfVKFJeyrDNPGKC3IBIg3an4ONgG3UzPMC+0SRckvwgDXlA
         EaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727156340; x=1727761140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLVLF61+yFfqKaGatHZnysy4rd6LUhQdcSaCgQaw3yg=;
        b=fZPdMwUPdKCEPiLGIdUtLo6ZD6x0sSUN/aQ/5CSFCTx9BTQNxhdQlF5BPDoUHapsGz
         sUGBtemGIVKcYYBfkHkGaQZOlC4g5pkYz5YqYqNC33t0WpW1Rj9gqBMCTONRJkNh1cst
         hvg/aigqtx/txwsL4yOgL9S3m4C4XnatXb/QDAFtni1LTjCHEIrHowHdp7sRFYNDkRaC
         TeB4c1mLSwZBeQMaKjWpOJ9Y5XhPLCZgRJ8s7Tc8z7ZzjSvGDHZhTcStoqBkmwQmxfGY
         JRmRmOKy9h8BIBcFcLW9IKlUiN4m5JQhhIESamowmp1UM0RHncy8BfZ20E8OtAWWm9DM
         niig==
X-Forwarded-Encrypted: i=1; AJvYcCUU6PaUnskoGXC0hmHssvDG5j7jFb8KnyQ/IfTbRjQkzgO5oQNcSbFijmbqA3uTxlpJdatr8asC@vger.kernel.org, AJvYcCXkCx1T8XKZP0n7xKyofliKw2CVdy3f9ztHv90YMtrU/hORUGl5hSzRgeLaUY52Sj8PV7Oq8p9SWrz/3HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1rLvzLqZOKvhqdIKrvzgwYbG2S8le2fOM6BtxXYFONQljb1OM
	VHVezagY/M8HaJs+4OhFEGKdgbA1TtUkYi2/V4I1Lc5SZNkZwHqP
X-Google-Smtp-Source: AGHT+IEEVrVB7JvXTSAbzvPI/WSVGhioTli8QUWt50oka8/pCKB7t1Bx+1T0FLYGbYp25zoWGupyeQ==
X-Received: by 2002:a17:907:e216:b0:a90:3517:6b1d with SMTP id a640c23a62f3a-a90d577a1famr1312315666b.48.1727156340098;
        Mon, 23 Sep 2024 22:39:00 -0700 (PDT)
Received: from [192.168.178.20] (dh207-41-185.xnet.hr. [88.207.41.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f51e90sm39500466b.73.2024.09.23.22.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 22:38:59 -0700 (PDT)
Message-ID: <b4435709-e112-4667-b458-411856a28389@gmail.com>
Date: Tue, 24 Sep 2024 07:38:21 +0200
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
References: <20240923205545.1488448-2-mtodorovac69@gmail.com>
 <172712665050.17050.14126694149839508223@noble.neil.brown.name>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <172712665050.17050.14126694149839508223@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Neil,

Apparently I was duplicating work.

However, using

	char servername[UNIX_PATH_MAX];

has some advantages when compared to hard-coded integer?

Correct me if I'm wrong.

Best regards,
Mirsad Todorovac

On 9/23/24 23:24, NeilBrown wrote:
> On Tue, 24 Sep 2024, Mirsad Todorovac wrote:
>> GCC 13.2.0 reported with W=1 build option the following warning:
> 
> See
>   https://lore.kernel.org/all/20240814093853.48657-1-kunwu.chan@linux.dev/
> 
> I don't think anyone really cares about this one.
> 
> NeilBrown
> 
> 
>>
>> net/sunrpc/clnt.c: In function ‘rpc_create’:
>> net/sunrpc/clnt.c:582:75: warning: ‘%s’ directive output may be truncated writing up to 107 bytes into \
>> 					a region of size 48 [-Wformat-truncation=]
>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>       |                                                                           ^~
>> net/sunrpc/clnt.c:582:33: note: ‘snprintf’ output between 1 and 108 bytes into a destination of size 48
>>   582 |                                 snprintf(servername, sizeof(servername), "%s",
>>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   583 |                                          sun->sun_path);
>>       |                                          ~~~~~~~~~~~~~~
>>
>>    548         };
>>  → 549         char servername[48];
>>    550         struct rpc_clnt *clnt;
>>    551         int i;
>>    552
>>    553         if (args->bc_xprt) {
>>    554                 WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
>>    555                 xprt = args->bc_xprt->xpt_bc_xprt;
>>    556                 if (xprt) {
>>    557                         xprt_get(xprt);
>>    558                         return rpc_create_xprt(args, xprt);
>>    559                 }
>>    560         }
>>    561
>>    562         if (args->flags & RPC_CLNT_CREATE_INFINITE_SLOTS)
>>    563                 xprtargs.flags |= XPRT_CREATE_INFINITE_SLOTS;
>>    564         if (args->flags & RPC_CLNT_CREATE_NO_IDLE_TIMEOUT)
>>    565                 xprtargs.flags |= XPRT_CREATE_NO_IDLE_TIMEOUT;
>>    566         /*
>>    567          * If the caller chooses not to specify a hostname, whip
>>    568          * up a string representation of the passed-in address.
>>    569          */
>>    570         if (xprtargs.servername == NULL) {
>>    571                 struct sockaddr_un *sun =
>>    572                                 (struct sockaddr_un *)args->address;
>>    573                 struct sockaddr_in *sin =
>>    574                                 (struct sockaddr_in *)args->address;
>>    575                 struct sockaddr_in6 *sin6 =
>>    576                                 (struct sockaddr_in6 *)args->address;
>>    577
>>    578                 servername[0] = '\0';
>>    579                 switch (args->address->sa_family) {
>>  → 580                 case AF_LOCAL:
>>  → 581                         if (sun->sun_path[0])
>>  → 582                                 snprintf(servername, sizeof(servername), "%s",
>>  → 583                                          sun->sun_path);
>>  → 584                         else
>>  → 585                                 snprintf(servername, sizeof(servername), "@%s",
>>  → 586                                          sun->sun_path+1);
>>  → 587                         break;
>>    588                 case AF_INET:
>>    589                         snprintf(servername, sizeof(servername), "%pI4",
>>    590                                  &sin->sin_addr.s_addr);
>>    591                         break;
>>    592                 case AF_INET6:
>>    593                         snprintf(servername, sizeof(servername), "%pI6",
>>    594                                  &sin6->sin6_addr);
>>    595                         break;
>>    596                 default:
>>    597                         /* caller wants default server name, but
>>    598                          * address family isn't recognized. */
>>    599                         return ERR_PTR(-EINVAL);
>>    600                 }
>>    601                 xprtargs.servername = servername;
>>    602         }
>>    603
>>    604         xprt = xprt_create_transport(&xprtargs);
>>    605         if (IS_ERR(xprt))
>>    606                 return (struct rpc_clnt *)xprt;
>>
>> After the address family AF_LOCAL was added in the commit 176e21ee2ec89, the old hard-coded
>> size for servername of char servername[48] no longer fits. The maximum AF_UNIX address size
>> has now grown to UNIX_PATH_MAX defined as 108 in "include/uapi/linux/un.h" .
>>
>> The lines 580-587 were added later, addressing the leading zero byte '\0', but did not fix
>> the hard-coded servername limit.
>>
>> The AF_UNIX address was truncated to 47 bytes + terminating null byte. This patch will fix the
>> servername in AF_UNIX family to the maximum permitted by the system:
>>
>>    548         };
>>  → 549         char servername[UNIX_PATH_MAX];
>>    550         struct rpc_clnt *clnt;
>>
>> Fixes: 4388ce05fa38b ("SUNRPC: support abstract unix socket addresses")
>> Fixes: 510deb0d7035d ("SUNRPC: rpc_create() default hostname should support AF_INET6 addresses")
>> Fixes: 176e21ee2ec89 ("SUNRPC: Support for RPC over AF_LOCAL transports")
>> Cc: Neil Brown <neilb@suse.de>
>> Cc: Chuck Lever <chuck.lever@oracle.com>
>> Cc: Trond Myklebust <trondmy@kernel.org>
>> Cc: Anna Schumaker <anna@kernel.org>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Cc: Olga Kornievskaia <okorniev@redhat.com>
>> Cc: Dai Ngo <Dai.Ngo@oracle.com>
>> Cc: Tom Talpey <tom@talpey.com>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: linux-nfs@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
>> ---
>>  v1:
>> 	initial version.
>>
>>  net/sunrpc/clnt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>> index 09f29a95f2bc..67099719893e 100644
>> --- a/net/sunrpc/clnt.c
>> +++ b/net/sunrpc/clnt.c
>> @@ -546,7 +546,7 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
>>  		.connect_timeout = args->connect_timeout,
>>  		.reconnect_timeout = args->reconnect_timeout,
>>  	};
>> -	char servername[48];
>> +	char servername[UNIX_PATH_MAX];
>>  	struct rpc_clnt *clnt;
>>  	int i;
>>  
>> -- 
>> 2.43.0
>>
>>
> 

