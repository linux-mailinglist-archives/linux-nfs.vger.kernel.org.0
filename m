Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2A3D9389
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jul 2021 18:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhG1QrH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Jul 2021 12:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231339AbhG1Qq7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Jul 2021 12:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627490816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hMy8tBo4f4IuaBNMDk/qaEoAAX9AoE9GwhmoiF6CaQo=;
        b=ThbyGdkmap2ENOdAmvoyXTE/WcF94r1dg+paJfCG0cG4QbUVeW8lLdL9ybt95PheXfRadE
        UeUTkEQJNlH53jBAWoPXTkZZ4gADwVALD9CehOg/l56xFflkUAkW/+Mlr9FJUNr0/DJ/ew
        iixW9wFAFDP1MGxp9b7TTQtvFagb/2o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-xBr6Kys2NoSC2Agn44aEvg-1; Wed, 28 Jul 2021 12:46:55 -0400
X-MC-Unique: xBr6Kys2NoSC2Agn44aEvg-1
Received: by mail-qv1-f70.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so2284777qvb.14
        for <linux-nfs@vger.kernel.org>; Wed, 28 Jul 2021 09:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMy8tBo4f4IuaBNMDk/qaEoAAX9AoE9GwhmoiF6CaQo=;
        b=EWuM8iio0uJkp/JOXG4xzAVC5iCyBdDE4QuTvlX9PPedlNqlqbfMzuH4eY2aDWpzFZ
         ZqlRQW5rnK0aAo8b7OJ029RuZCDmdspHwCeHWT4snBiosbnt42aRKJuV7IFK8WSECI+w
         ACJreb9esazhrVlszf7Gcj71Gifoc7gwAwGD/rntz0dAPPc+hkBR9wTEUj0njkX3nBgz
         HhJwBjsqMnAOEwl68HtpjR+zZPbS8FAp+PcbSWGpeXmBNi+uSY37Y4OcH8LcKMObrQYE
         J306QKPYTN1fAUzKogEFVZ+z16wAN9QDrImxw5GWM8I/TV5SvOSI2ehQ2Op2YMOVuKSM
         Z6Gg==
X-Gm-Message-State: AOAM531RKwYIe1vCi1QdJZgVG3om9rA7Ga4zTNntatJMf5V1PlRs74i1
        r2litxuM3ri/LslR2cjEF4O7xoVljrMfhndAoJ0vPZ8IdB7qEFTqwUM8TOGneweiOpyOfESK7xL
        TsXunD5RJmEncX/JoQ1o/Is6lCOnq7eVgWzfapaTWuG6N88RC97eMUlT+nOvPTwWJYuFisQ==
X-Received: by 2002:a05:622a:491:: with SMTP id p17mr403226qtx.107.1627490815074;
        Wed, 28 Jul 2021 09:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPgo7u/OEDPEdJzcoz8xNU5drLuwDEKv9JeuN0xb7NJLx5Ciy86F/jYSzlrPpn8IhswTmW4Q==
X-Received: by 2002:a05:622a:491:: with SMTP id p17mr403206qtx.107.1627490814823;
        Wed, 28 Jul 2021 09:46:54 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id g206sm287177qke.13.2021.07.28.09.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 09:46:54 -0700 (PDT)
Subject: Re: [PATCH] nfsdcltrack: Use uint64_t instead of time_t
To:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20210728013608.167759-1-steved@redhat.com>
 <0ba5eaacd17a50b0ab0c6fd9605a7c330935eca8.camel@kernel.org>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <eed93f64-3394-5166-8d51-3075e866c327@redhat.com>
Date:   Wed, 28 Jul 2021 12:46:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0ba5eaacd17a50b0ab0c6fd9605a7c330935eca8.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/28/21 7:15 AM, Jeff Layton wrote:
> On Tue, 2021-07-27 at 21:36 -0400, Steve Dickson wrote:
>> With recent commits (4f2a5b64,5a53426c) that fixed
>> compile errors on x86_64 machines, caused similar
>> errors on i686 machines.
>>
>> The variable type that was being used was a time_t,
>> which changes size between architects, which
>> caused the compile error.
>>
>> Changing the variable to uint64_t fixed the issue.
>>
>> Signed-off-by: Steve Dickson <steved@redhat.com>
>> ---
>>   utils/nfsdcltrack/nfsdcltrack.c | 2 +-
>>   utils/nfsdcltrack/sqlite.c      | 2 +-
>>   utils/nfsdcltrack/sqlite.h      | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/utils/nfsdcltrack/nfsdcltrack.c b/utils/nfsdcltrack/nfsdcltrack.c
>> index 0b37c094..7c1c4bcc 100644
>> --- a/utils/nfsdcltrack/nfsdcltrack.c
>> +++ b/utils/nfsdcltrack/nfsdcltrack.c
>> @@ -508,7 +508,7 @@ cltrack_gracedone(const char *timestr)
>>   {
>>   	int ret;
>>   	char *tail;
>> -	time_t gracetime;
>> +	uint64_t gracetime;
>>   
> 
> Hmm.. time_t is a long:
> 
>      typedef __kernel_long_t __kernel_time_t;
> 
> ...but the kernel is converting this value from a time64_t which is s64.
>   
> Should the above be int64_t instead of being unsigned? The kernel should
> never send down a negative value, but if you're trying to match up types
> then that might be cleaner.
The patch I took to fix the printfs on  64-bits platforms
used the PRIu64 inttype interface so I was just keeping
things constant by using a uint64_t.

The answer to your question is yes... int64 is all that
is needed... but I don't in really matters...

steved.
> 
>>
>>   	ret = sqlite_prepare_dbh(storagedir);
>> diff --git a/utils/nfsdcltrack/sqlite.c b/utils/nfsdcltrack/sqlite.c
>> index cea4a411..cf0c6a45 100644
>> --- a/utils/nfsdcltrack/sqlite.c
>> +++ b/utils/nfsdcltrack/sqlite.c
>> @@ -540,7 +540,7 @@ out_err:
>>    * remove any client records that were not reclaimed since grace_start.
>>    */
>>   int
>> -sqlite_remove_unreclaimed(time_t grace_start)
>> +sqlite_remove_unreclaimed(uint64_t grace_start)
>>   {
>>   	int ret;
>>   	char *err = NULL;
>> diff --git a/utils/nfsdcltrack/sqlite.h b/utils/nfsdcltrack/sqlite.h
>> index 06e7c044..ba8cdfa8 100644
>> --- a/utils/nfsdcltrack/sqlite.h
>> +++ b/utils/nfsdcltrack/sqlite.h
>> @@ -26,7 +26,7 @@ int sqlite_insert_client(const unsigned char *clname, const size_t namelen,
>>   int sqlite_remove_client(const unsigned char *clname, const size_t namelen);
>>   int sqlite_check_client(const unsigned char *clname, const size_t namelen,
>>   				const bool has_session);
>> -int sqlite_remove_unreclaimed(const time_t grace_start);
>> +int sqlite_remove_unreclaimed(const uint64_t grace_start);
>>   int sqlite_query_reclaiming(const time_t grace_start);
>>   
>>   #endif /* _SQLITE_H */
> 

