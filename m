Return-Path: <linux-nfs+bounces-13127-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC09B08776
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937D51AA5CB1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2D279783;
	Thu, 17 Jul 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="g8Rqdbqo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484FB275855
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739309; cv=none; b=aejxduNjjU6tFT4aP0OWduz7CLv+vFD0UwdML+tVQRk8bekFoYbcZoX+PfoUEfMt4pH+woqc+z+75ToIx+VEebxQiybP1y1X3HUKOImfLuJEX35+iclxifn8tX09oF/HgTya9LpiXc3RQ60ajofV2ny22OjeY2rzfwvQIiQOpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739309; c=relaxed/simple;
	bh=EX0JLqaW97+7QjEFikLSLSt3WB6qPidghL7mlihwMF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFOwUa8YLjdedoiSIRPYscAYEkrP1ilsqtlmOuRb3LY+uKPjQ/QF6VBAtWFJ+xGyaWnUPKRFS9wBe+Y3ROkLXTsaGgwk2bZjpO9ui00NQrtZjEWoG1AldHdQ2COYW8uqvhdp1afuzI5UllM2cyboMyjBNlajvI4DbxeM3WET3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=g8Rqdbqo; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-612a8e6f675so575128a12.3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752739304; x=1753344104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AWJAdzMawaoR3d5icv/fALPAW/UAJ2EQkYc3gxuH3Ho=;
        b=g8RqdbqoDIm0K+Wg1a0ROsm9l/3bKbuYFZZCCN9uWuAyAizuuPzhcQnlPD+3dG/Rit
         NsZhuQibwqjdQdA5AlyQ0JF73nRQES4O06OBa+MteAxpglrgo8ORqMQbgQ4Smp/+OU1X
         s69Mwycp9J6VhP8vImNIx0Y7Um/y1WnJFJo/FCb7bGQUyA4xioUwPsBgP+Pi7wbSSqPn
         hRHZAGOiYSWuqoZuCCP/fEb8fyAda/S1QndTQ2czavRsf9sfxibwnQ30qnGZKCI63m2i
         h2K4BumlaYZh7p6QKMXjUllAK/mE+wsm3dW0iGa/Fyu6e5dapM2OtcnN1lYqel6J6va9
         0ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739304; x=1753344104;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWJAdzMawaoR3d5icv/fALPAW/UAJ2EQkYc3gxuH3Ho=;
        b=Pg7FMuh0vQe2zJU51xmoJFCYNFNsXajHedrdYMU7kuG/qCZ/CWyRA7+M4GMwkjzAF3
         VIWsZUOAHa26QT+L8qv33UVS1W8Pg19UNEDoNwELQGD7X+Qo57POwECa04HIqFyYq6k/
         Mzv/TsyHcrMJs4/kZmNVp9LY3+1Krmd0wOeoEtqTZQNEPA6+9/sLQO1RxUv/iAcxOdlz
         oMRvEB4EGW4oGQtBf2Tn9e/L1kM9R/iDOUaX6sibkQGRxRIuiHa+QRwswbHHBTDjKHKF
         GPM1bqLifFb62kEzDbqESHAdE1I5ZYrkMW8oeMgpvo+sUabOWSgass/hjMJk5uMNO+M3
         mW4Q==
X-Gm-Message-State: AOJu0YzOZMKB9nXdF3IfrV3DqTnzK2dEpWZXLyAXczvddAOgXxbBbW7C
	B+0op8ObfQdaLrnmLFGiC0z6u+w8KPeeQwKv1GGBkOloc0iQhEtjlsYf5fHR4ZqjQfI=
X-Gm-Gg: ASbGnctZoDsIKrrd6NTh5SY+nbpOgQnw68IdENQ6uhdkEPsxWB2SPYa9CpCwa9hB/ku
	SOmc4uUO0ZMrlMq319G17MhI0NSWYH0vr2CGMLlR81jd4lWdGCOuL13QQ0TRPDLCvnHHiG5+C/v
	4pYKdbau/RXO+H9PnhaR5By2bvAMnq7V8m+qQPWLJIQi+asvAZhLc0SHZx//w7OgUgFZD8I6OI3
	VJR15piSAV8vuSjQkreDFYeHRWcl/Mze20lzBZtnVyu/Bs8NbsCPcdTFCQjzaopx3QMdKWttRsH
	/wu3RnjaU64hqhdgVXlUPIV9+fkQL8ZGS3CHiL/24vxIEqX3OnDyzJLBJ5sUqie3rqscnspKriv
	UnYAL/LmPS+bpMSNE0i+nroCdVvStrHyfyu/llb6S/+YJw+QqoD446/GvMWdzr/8=
X-Google-Smtp-Source: AGHT+IEf0bFx4kn4ssXN/hnQ65NBcRJTiRLmcpoZBIo2aJlqm71w2SlGI3KttFTzUj4zMowosWFLOg==
X-Received: by 2002:a17:907:aa1:b0:ae3:163a:f69a with SMTP id a640c23a62f3a-ae9ce0bd1bcmr356173066b.33.1752739304160;
        Thu, 17 Jul 2025 01:01:44 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2? ([2001:67c:2fbc:1:5ccb:40e9:b7dc:5cf2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee46cdsm1339631466b.60.2025.07.17.01.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:01:43 -0700 (PDT)
Message-ID: <d9b026f1-6ed3-41ca-8699-914c45b0339b@mandelbit.com>
Date: Thu, 17 Jul 2025 10:01:42 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Sergey Bashirov <sergeybashirov@gmail.com>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Konstantin Evtushenko <koevtushenko@yandex.com>, linux-kernel@vger.kernel.org
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
 <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2025 06:56, Dan Carpenter wrote:
> On Thu, Jul 17, 2025 at 03:27:50AM +0300, Sergey Bashirov wrote:
>> On Wed, Jul 16, 2025 at 04:38:48PM +0200, Antonio Quartulli wrote:
>>> In ext_tree_encode_commit() if no block extent is encoded due to lack
>>> of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
>>> despite it being uninitialized.
>>
>> This static check warning appears to be a false positive. This is an
>> internal static function that is not exported outside the module via
>> an interface or API. Inside the module we always use a buffer size
>> that is a multiple of PAGE_SIZE, so at least one page is provided.
>> The block extent size does not exceed 44 bytes, so we can always
>> encode at least one extent. Thus, we never fail on the first iteration.
>> Either ret is zero, or ret is nonzero and at least one extent is encoded.

Ok. It wasn't clear to me that

657                 buffer_size = NFS_SERVER(arg->inode)->wsize;

would always set buffer_size to something large enough to encode at 
least one block extent.

>>
>>> Fix this behaviour by bailing out right away when no extent is encoded.
>>>
>>> Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
>>> Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
>>> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>>> ---
>>>   fs/nfs/blocklayout/extent_tree.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
>>> index 315949a7e92d..82e19205f425 100644
>>> --- a/fs/nfs/blocklayout/extent_tree.c
>>> +++ b/fs/nfs/blocklayout/extent_tree.c
>>> @@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
>>>   		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
>>>   			(*count)--;
>>>   			ret = -ENOSPC;
>>> +			/* bail out right away if no extent was encoded */
>>> +			if (!*count) {
>>
>> We can't exit here without setting the value of lastbyte, which is one
>> of the function outputs. Please set it to U64_MAX to let upper layer
>> logic handle it properly. Or, see the alternative solution at the end.
>>    +				*lastbyte = U64_MAX;
>>
>>> +				spin_unlock(&bl->bl_ext_lock);
>>> +				return ret;
>>> +			}
>>>   			break;
>>>   		}
>>>
>>
>> If we need to fix this, I'd rather add an early check whether the buffer
>> size is large enough to encode at least one extent at the beginning of
>> the function. Before spinlock is acquired and ext_tree traversed. This
>> looks more natural to me. But I'm not sure if this will satisfy the
>> static checker.
>>
> 
> No, it won't.  I feel like the code is confusing enough that maybe a
> comment is warranted.  /* We always iterate through the loop at least
> once so be_prev is correct. */
> 

I agree a comment would help.

> Another option would be to initialize the be_prev to NULL.  This will
> silence the uninitialized variable warning. 

But will likely trigger a potential NULL-ptr-deref, because the static 
analyzer believes we can get there with count==0.

> And everyone sensible runs
> with CONFIG_INIT_STACK_ALL_ZERO set in production so it doesn't affect
> run time at all.  Btw, we changed our test systems to set
> CONFIG_INIT_STACK_ALL_PATTERN=y a few months ago and immediately ran
> into an uninitialized variable bug.  So I've heard there are a couple
> distros which don't set CONFIG_INIT_STACK_ALL_ZERO which is very daring
> when every single developer is testing with uninitialized variables
> defaulting to zero.
> 

Thanks for the hint about setting CONFIG_INIT_STACK_ALL_PATTERN=y.
I'll add it to our test system as well.

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


