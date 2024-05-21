Return-Path: <linux-nfs+bounces-3320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D50F58CB1F0
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2472BB2275C
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E721C68C;
	Tue, 21 May 2024 16:09:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262D42D7A8
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307748; cv=none; b=AUlf5dnnrDa1TdFOFYIkuzxxQ7WKA/z98aLR5vESQboHc/fDpv1VQrmOBGWU4T+37h+qD1FqvLHd5fRc+jPlDMysVqT5IqYTeIe+5wVrxaMr8flBW4zg24siQyrJj/WiAfN874D74g4L5d6sj3rURIZF88mZGufrPFtm7FST66Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307748; c=relaxed/simple;
	bh=jh3ldPhffzfx8KBrkqDrrAKaoyzGA3Aj68XfvKdNeMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=He+9GquJgJPzxv0g+yPOkVfTlypCY0i6kRpZQ9qpOkpBw5PoVsUowacmcgBBa2chLDcYkFPKlPQVD82j21AIPEhH6b5kgFOePErw1TqqEoQixQ7dffIRDCH15CfvZ8O0eB8RU3d8vDsl/KDgaWDsaZewRMhVTjmCU2glgxHR8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-354ccdfb014so206884f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 09:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307744; x=1716912544;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkcH0n5iGmejhRVMIMNw6LBUDINwcFE+shaltipre+U=;
        b=NcnkljgUQ40RkCZXGkrJJibWiVa7l3sJoYwvz2kFYMxQ1jFtDtvzYueoFKx4MvAqf3
         zp3E7iMb95lUcMza07LpkXDOYr508HojawHQ7GsUXWDW4TShjhKtrC63ccqGR+ZWpq0V
         5YNIIeF9LToKMzb/SDWTSLY1TZypfOBoS2tI0QO+KB893J+BZFBLBqbtTGnTCbDAPJWk
         a+gZRxVTU22RlxqnlWl1joCsjl6CC3hfXvyq6vfN22fXdG64tx2/fZ3cYlkwrPJOIAgx
         Jcn8QVmAfeNlkVIO1pMrAUlr9niUee5E9luVJ07dtSfx2sKir+LuLshRO+SRQ+YGKUVC
         BOvg==
X-Forwarded-Encrypted: i=1; AJvYcCUs/R78j/bs4ZzLZDV+q6JdXTmGr5hbVgfLuSWWJuQt5qLwTOS05/K28G/OuMKa2i3oeEGTISl1UEYJDgL+tDLuijtYH4CLUfZd
X-Gm-Message-State: AOJu0Yz72AGMn60lKN3bx5jUmOJLKhg5Oqb4eM0xgqWPGOGanIIDEdRy
	IWdRWulYheFFFfwtmnR63K5tdMxqr0B7Fxctz6FhlaQ0LXTBXlyh
X-Google-Smtp-Source: AGHT+IEBc9cIxoH09QxznrWrgOWjKT8vF2o/1SV2JscZQiUua+BOnh3aKJ5dspFMyDHVDeOwsckhWg==
X-Received: by 2002:a05:600c:1c11:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-41feac59cffmr237393885e9.3.1716307743573;
        Tue, 21 May 2024 09:09:03 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42016a511a7sm342091405e9.0.2024.05.21.09.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 09:09:03 -0700 (PDT)
Message-ID: <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
Date: Tue, 21 May 2024 19:09:01 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
 <dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/05/2024 18:13, Trond Myklebust wrote:
> On Tue, 2024-05-21 at 18:05 +0300, Sagi Grimberg wrote:
>>
>> On 21/05/2024 16:22, Jeff Layton wrote:
>>> On Tue, 2024-05-21 at 15:58 +0300, Sagi Grimberg wrote:
>>>> There is an inherent race where a symlink file may have been
>>>> overriden
>>>> (by a different client) between lookup and readlink, resulting in
>>>> a
>>>> spurious EIO error returned to userspace. Fix this by propagating
>>>> back
>>>> ESTALE errors such that the vfs will retry the lookup/get_link
>>>> (similar
>>>> to nfs4_file_open) at least once.
>>>>
>>>> Cc: Dan Aloni <dan.aloni@vastdata.com>
>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>> ---
>>>> Note that with this change the vfs should retry once for
>>>> ESTALE errors. However with an artificial reproducer of high
>>>> frequency symlink overrides, nothing prevents the retry to
>>>> also encounter ESTALE, propagating the error back to userspace.
>>>> The man pages for openat/readlinkat do not list an ESTALE errno.
>>>>
>>>> An alternative attempt (implemented by Dan) was a local retry
>>>> loop
>>>> in nfs_get_link(), if this is an applicable approach, Dan can
>>>> share his patch instead.
>>>>
>>>>    fs/nfs/symlink.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
>>>> index 0e27a2e4e68b..13818129d268 100644
>>>> --- a/fs/nfs/symlink.c
>>>> +++ b/fs/nfs/symlink.c
>>>> @@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file
>>>> *file, struct folio *folio)
>>>>    error:
>>>>    	folio_set_error(folio);
>>>>    	folio_unlock(folio);
>>>> -	return -EIO;
>>>> +	return error;
>>>>    }
>>>>    
>>>>    static const char *nfs_get_link(struct dentry *dentry,
>>> git blame seems to indicate that we've returned -EIO here since the
>>> beginning of the git era (and likely long before that). I see no
>>> reason
>>> for us to cloak the real error there though, especially with
>>> something
>>> like an ESTALE error.
>>>
>>>       Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>
>>> FWIW, I think we shouldn't try to do any retry looping on ESTALE
>>> beyond
>>> what we already do.
>>>
>>> Yes, we can sometimes trigger ESTALE errors to bubble up to
>>> userland if
>>> we really thrash the underlying filesystem when testing, but I
>>> think
>>> that's actually desirable:
>> Returning ESTALE would be an improvement over returning EIO IMO,
>> but it may be surprising for userspace to see an undocumented errno.
>> Maybe the man pages can be amended?
>>
>>> If you have real workloads across multiple machines that are racing
>>> with other that tightly, then you should probably be using some
>>> sort of
>>> locking or other synchronization. If it's clever enough that it
>>> doesn''t need that, then it should be able to deal with the
>>> occasional
>>> ESTALE error by retrying on its own.
>> I tend to agree. FWIW Solaris has a config knob for number of stale
>> retries
>> it does, maybe there is an appetite to have something like that as
>> well?
>>
> Any reason why we couldn't just return ENOENT in the case where the
> filehandle is stale? There will have been an unlink() on the symlink at
> some point in the recent past.
>

No reason that I can see. However given that this was observed in the 
wild, and essentially
a common pattern with symlinks (overwrite a config file for example), I 
think its reasonable
to have the vfs at least do a single retry, by simply returning ESTALE.
However NFS cannot distinguish between first and second retries 
afaict... Perhaps the
vfs can help with a ESTALE->ENOENT conversion?

