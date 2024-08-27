Return-Path: <linux-nfs+bounces-5796-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A63960162
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 08:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3179E2831E9
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2024 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50A6E614;
	Tue, 27 Aug 2024 06:15:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE626AFA;
	Tue, 27 Aug 2024 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724739346; cv=none; b=HO0sbvjM9SaDiqXyjzzYomAGXK/hLybS4yXzOyxkCJMgKE9pWRkzQOuT3MCCdVEvEWsM4mAEjN9DkGDbetzMnLL8UVI5uBj3LRlHcoYKewuZWM13lqC6LpOwe9PlVFthbaupliNE0vm/pWUDmXJRbx7FgnXBt+Vodc/9ddONBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724739346; c=relaxed/simple;
	bh=07FaHc5NOgRiAaU0lfoO8n9Oql1z8fp4hrb6WLrG7UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nP9zQs5DD+7LVpe2cDN3UN8V5pIaDc9msLpdtZwS2Y+mr2ST84IVRvyxKgJV2SqSEcH+bPZtE+1BhIo2kOq8wqvPUf2e7o9Wu0UgrmEf64WXAj6tfNoAwqg6ZmjIlNcq/O2YsKp+qyAzM2wk7yhxcU87ga15sgHRhYPHveE6GhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtHJP1XsDz1HGfr;
	Tue, 27 Aug 2024 14:12:21 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A56771A0188;
	Tue, 27 Aug 2024 14:15:39 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 14:15:39 +0800
Message-ID: <fcc670ec-47fa-4ee3-ab10-b76236711091@huawei.com>
Date: Tue, 27 Aug 2024 14:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 3/3] nfs make use of str_false_true helper
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: <kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<trondmy@kernel.org>, <anna@kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>
References: <20240827024517.914100-1-lihongbo22@huawei.com>
 <20240827024517.914100-4-lihongbo22@huawei.com>
 <Zs1JAfGWQOZMfHKT@casper.infradead.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <Zs1JAfGWQOZMfHKT@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 11:33, Matthew Wilcox wrote:
> On Tue, Aug 27, 2024 at 10:45:17AM +0800, Hongbo Li wrote:
>> The helper str_false_true is introduced to reback "false/true"
>> string literal. We can simplify this format by str_false_true.
> 
> This seems unnecessarily verbose & complex.  How about:
> 
> 	dprintk("%s: link support=%s\n", __func__, strbool(*res != 0));

This just keeps consistency with other string literal helpers such as 
"str_up_down", "str_yes_no" defined in include/linux/string_choices.h.

> 
>> -	dprintk("%s: link support=%s\n", __func__, *res == 0 ? "false" : "true");
>> +	dprintk("%s: link support=%s\n", __func__, str_false_true(*res == 0));
> 
> (do we have a convention for the antonym of kstrtoX?)

No, I haven't found this kind of convention helpers.

Thanks,
Hongbo

> 

