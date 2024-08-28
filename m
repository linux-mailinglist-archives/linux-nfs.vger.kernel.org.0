Return-Path: <linux-nfs+bounces-5842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160D0961D31
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 05:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C807B285A58
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDD6156669;
	Wed, 28 Aug 2024 03:50:03 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF23155A3C;
	Wed, 28 Aug 2024 03:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817003; cv=none; b=e7Wp377bW09TRgle1PIdFFbBPBEGCLkyDXne0+GKWYa4xXErWmi8tVK8VxE5hBiJNQlxw3T/FDCAYfvWWjn0SGrIe/xagiXpNrmGmAzHGp8QFTzpr6m1U8pfl/PkM+NWqjrZnc19Bz5Q4MmrwXJT0DnG/ugFwW1ZnVAL03jqyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817003; c=relaxed/simple;
	bh=jm7xy+AGoi+VAQ4u2cKqfYbNkBRpmU1dCkK7xzWqccQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mGo7FWTTREr0fcuRJWqo17f0JC76hKc0rzl2zQpDrYxkkaAzxVcONtxXSbwwpf6N6VTQkBF/QCq6fFu4+tHe1zPaicX3wMJkpYh1N4b1XvaJHms94vrR1fQ1AheCFVHs4ttQgcbE+IWnpAN3o7FGPBom4xaa4X1874HAZHFpQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wtr1h2qmyz1HHFX;
	Wed, 28 Aug 2024 11:46:32 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id D1CAA140135;
	Wed, 28 Aug 2024 11:49:51 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 11:49:51 +0800
Message-ID: <a6ea03c9-f92b-4faa-b924-8df58484fb13@huawei.com>
Date: Wed, 28 Aug 2024 11:49:51 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/3] lib/string_choices: Add
 str_true_false()/str_false_true() helper
To: Andrew Morton <akpm@linux-foundation.org>
CC: <kees@kernel.org>, <andy@kernel.org>, <trondmy@kernel.org>,
	<anna@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-2-lihongbo22@huawei.com>
 <20240827164218.c45407bf2f2ef828975c1eff@linux-foundation.org>
 <8d19aece-3a33-4667-8bcf-635a3a861d1d@huawei.com>
 <20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240827202204.b76c0510bf44cdfb6d3a74bd@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/28 11:22, Andrew Morton wrote:
> On Wed, 28 Aug 2024 09:48:21 +0800 Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>>> This might result in copies of the strings "true" and "false" being
>>> generated for every .c file which uses this function, resulting in
>>> unnecessary bloat.
>>>
>>> It's possible that the compiler/linker can eliminate this duplication.
>>> If not, I suggest that every function in string_choices.h be uninlined.
>> The inline function is in header file, it will cause code expansion. It
>> should avoid the the copies of the strings.
> 
> Sorry, I don't understand your reply.
> 
I mean this is a inline function (and tiny enough), the compiler will do 
the code expansion and some optimizations.
> Anything which is calling these functions is not performance-sensitive,
> so optimizing for space is preferred.  An out-of-line function which
> returns a const char * will achieve this?
I think this helper can achieve this. Because it is tiny enough, the 
compiler will handle this like #define macro (do the replacement) 
without allocating extra functional stack. On the contrary, if it is 
implemented as a non-inline function, it will cause extra functional 
stack when it was called every time. And it also should be implemented 
in a source file (.c file), not in header file(.h file).

Thanks,
Hongbo

