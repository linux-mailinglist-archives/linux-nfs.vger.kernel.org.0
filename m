Return-Path: <linux-nfs+bounces-3315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912B38CB0F9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 17:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19141C21E48
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2024 15:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082447EEF8;
	Tue, 21 May 2024 15:05:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43525142E9F
	for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303955; cv=none; b=A4jrPkIAAz0Ojb4mzK8bbkX0+ZgtPmuFMDhZRneH6wu8YPZb93hnGfrWLgF6U8IYsQ6xnWkk1gIbJpzLARk3s64IemDueaOU+JoJK+eD6NwKQUeXeP+c2nL1GyBP6D+6+MPYuaFsR2ZzfCUF1JUV4enCn3pNrtBi7joeS2h1WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303955; c=relaxed/simple;
	bh=ejfHtuy5PczIT29ysQMHjy+X4674geFrXlFzfxsynJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIHM+RpeTif+662SORKXve+krgSRxz4pb83YQOC6AKLSxa5VftWhS9GfCdxqBOtL5UxgKKLZYQboGiDQgsESAHvGzzzd753OoqdnJtlfdKUaIW4EICDNPzCpB/cN5k4T337EWj++AB6Qe+M5Qyzjt0jGnT0ZNEBa9Loha2Mt6sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e70f6b22e2so5206771fa.1
        for <linux-nfs@vger.kernel.org>; Tue, 21 May 2024 08:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303952; x=1716908752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drAATRmgW3HtqPPySvP3k8ig0tfEWymWRJ/clcjOH/M=;
        b=N/0ihqnVds5Z4yZT75ROHq8BNe/npmbUHBDK2C6v5DUD7WmKVg/8I1cDH6518TzCor
         d4pW4plGMhqKLdCUBSrfeKALpo1SZg6IaWpLFz9j5FY0z+pmGBfCKQJ5mkMGFUr33Nai
         izS2WuZ70hyMu2wsInJDVcZKNPLRRPsKVOehTnSepXmOpbw7xVUE8kRD/D3yo+jVAvA+
         53u26lN4OZ8szYeDeMvXXmAv7Zs43uz5ocOh1SCAMiqJnglOYgD2CN0QpEGRqnzj+bmv
         /39gI6xKt8klhdR9ztNEceZg9LnoXL82eawBpoVtAm8SmloPmXPW+ts9+8+nwJntbHEB
         e+rw==
X-Forwarded-Encrypted: i=1; AJvYcCWY3x8EB0N3VOOXmLD1a/XEg3lEE7YY56xjleH8X4DMMPozjM4Mceuzerd6lJI5F9P8/9XOHxaXL0AH2OXY38oAoPV2PA472Lmi
X-Gm-Message-State: AOJu0Yy7ES+jno1yciNkXFTTNFvVlp3tr0oe4NvhSm94cie5UFMNlvOV
	HJYnnTcTyKbvM4dttWWJxa+AzzdN7MOh8EvII+WcX+TqE8m2ELby
X-Google-Smtp-Source: AGHT+IHUxjozIzxN57Mw4XdqHwAW8p/DOthUP0Xup/beP3Er3hxldervAfgGm2u7AenyHOKO+5Wcag==
X-Received: by 2002:a05:651c:19ac:b0:2e2:18c2:9c8b with SMTP id 38308e7fff4ca-2e51f262c65mr222807701fa.0.1716303952349;
        Tue, 21 May 2024 08:05:52 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm504049085e9.29.2024.05.21.08.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:05:51 -0700 (PDT)
Message-ID: <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
Date: Tue, 21 May 2024 18:05:50 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
To: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, Dan Aloni <dan.aloni@vastdata.com>,
 Christoph Hellwig <hch@lst.de>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/05/2024 16:22, Jeff Layton wrote:
> On Tue, 2024-05-21 at 15:58 +0300, Sagi Grimberg wrote:
>> There is an inherent race where a symlink file may have been overriden
>> (by a different client) between lookup and readlink, resulting in a
>> spurious EIO error returned to userspace. Fix this by propagating back
>> ESTALE errors such that the vfs will retry the lookup/get_link (similar
>> to nfs4_file_open) at least once.
>>
>> Cc: Dan Aloni <dan.aloni@vastdata.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>> Note that with this change the vfs should retry once for
>> ESTALE errors. However with an artificial reproducer of high
>> frequency symlink overrides, nothing prevents the retry to
>> also encounter ESTALE, propagating the error back to userspace.
>> The man pages for openat/readlinkat do not list an ESTALE errno.
>>
>> An alternative attempt (implemented by Dan) was a local retry loop
>> in nfs_get_link(), if this is an applicable approach, Dan can
>> share his patch instead.
>>
>>   fs/nfs/symlink.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
>> index 0e27a2e4e68b..13818129d268 100644
>> --- a/fs/nfs/symlink.c
>> +++ b/fs/nfs/symlink.c
>> @@ -41,7 +41,7 @@ static int nfs_symlink_filler(struct file *file, struct folio *folio)
>>   error:
>>   	folio_set_error(folio);
>>   	folio_unlock(folio);
>> -	return -EIO;
>> +	return error;
>>   }
>>   
>>   static const char *nfs_get_link(struct dentry *dentry,
> git blame seems to indicate that we've returned -EIO here since the
> beginning of the git era (and likely long before that). I see no reason
> for us to cloak the real error there though, especially with something
> like an ESTALE error.
>
>      Reviewed-by: Jeff Layton <jlayton@kernel.org>
>
> FWIW, I think we shouldn't try to do any retry looping on ESTALE beyond
> what we already do.
>
> Yes, we can sometimes trigger ESTALE errors to bubble up to userland if
> we really thrash the underlying filesystem when testing, but I think
> that's actually desirable:

Returning ESTALE would be an improvement over returning EIO IMO,
but it may be surprising for userspace to see an undocumented errno.
Maybe the man pages can be amended?

>
> If you have real workloads across multiple machines that are racing
> with other that tightly, then you should probably be using some sort of
> locking or other synchronization. If it's clever enough that it
> doesn''t need that, then it should be able to deal with the occasional
> ESTALE error by retrying on its own.

I tend to agree. FWIW Solaris has a config knob for number of stale retries
it does, maybe there is an appetite to have something like that as well?

