Return-Path: <linux-nfs+bounces-5838-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8588A961B97
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328961F247D1
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335C3BBEF;
	Wed, 28 Aug 2024 01:48:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB68B67A;
	Wed, 28 Aug 2024 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724809714; cv=none; b=q8YyI5pQUvHayc99/gfArYMKG4e+iwrrKEtzjcDDbxHCmZoJrtdShEKtzymRLRvejVdO/X7l9K5lIgXzyU9JIm/pRrOTvBCvGWQ1FLZJEwPLEscvaRD4BvcoGQijoZF4q8jWmctM47Lrj0eflR4t5Df6e04dWnVMsTcqdA2zBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724809714; c=relaxed/simple;
	bh=TQ8O4vpCHfr+3CcQJpPW9JrJQzHXZ5rxi4sVdjuTWoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dmXAXBVN0AIJjHInyop2TT897PWw8VWyA4xqwyvYI5f6obaAKcT70SgFO4xOg5BkQ7bzlhrE9StqmiZkg1Yc39YGzlFrBpeAYvI8wX0/BEGNKnuyt8CLhZWUhPoJvH0sosH//ifESH1Fy6SGewSSV53pMmNzxijiVT92F0ydFMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtnMT3mLBzpTqg;
	Wed, 28 Aug 2024 09:46:45 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id F3DC414035E;
	Wed, 28 Aug 2024 09:48:26 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 09:48:21 +0800
Message-ID: <8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
Date: Wed, 28 Aug 2024 09:48:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
CC: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
	<anna@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-2-lihongbo22@huawei.com>
 <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 7:42, Andrew Morton wrote:
> On Tue, 27 Aug 2024 10:45:15 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>> Add str_true_false()/str_false_true() helper to return "true" or
>> "false" string literal.
>>
>> ...
>>
>> --- a/include/linux/string_choices.h
>> +++ b/include/linux/string_choices.h
>> @@ -48,6 +48,12 @@ static inline const char *str_up_down(bool v)
>>   }
>>   #define str_down_up(v)		str_up_down(!(v))
>>   
>> +static inline const char *str_true_false(bool v)
>> +{
>> +	return v ? "true" : "false";
>> +}
>> +#define str_false_true(v)		str_true_false(!(v))
>> +
>>   /**
>>    * str_plural - Return the simple pluralization based on English counts
>>    * @num: Number used for deciding pluralization
> 
> This might result in copies of the strings "true" and "false" being
> generated for every .c file which uses this function, resulting in
> unnecessary bloat.
> 
> It's possible that the compiler/linker can eliminate this duplication.
> If not, I suggest that every function in string_choices.h be uninlined.
The inline function is in header file, it will cause code expansion. It 
should avoid the the copies of the strings.

Thanks,
Hongbo

