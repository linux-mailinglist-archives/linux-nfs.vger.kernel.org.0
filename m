Return-Path: <linux-nfs+bounces-2461-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11FD88A57D
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 15:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970551F33C59
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC6716D9D8;
	Mon, 25 Mar 2024 12:08:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9F1CADB8
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711367789; cv=none; b=bx9tXVWrv+2eqD2CdsvfF13IU39M8raGJ25o/gA8dBb/d3fJrO1tCtMWGQd9dNt6yCPYW1kL8RnlB8AePocIiA0kmp1bnwiwukrZE+ib7p7Tm7Rqev92NVwaSmA7DNsffsHu+CW2vCQGEfN/thmjP07vaAsv/4OHPxkuiflnEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711367789; c=relaxed/simple;
	bh=+1Z7NzhPQepMkIxp3K6zQ3ZGrPWSZumt6bLZRxF0ci0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XIRgWk3Cho/zzQIVBRxQmQaUB6cZ1gxq+NMbgB2rNbe+FFQ3W4tr1Ag+NcpRdEIn7WqFRGLjG6h+tglZQWUkltO89VfEe/1LKoWw4vmsmP5HQvKaZZ/As8xTRI19FsRwYk8w58yoCXTuRuKEWlqVzkQSHy7k5Zdf/IHF0dbtjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V3BDc5wh2z1xshL;
	Mon, 25 Mar 2024 19:54:24 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F55D1A0172;
	Mon, 25 Mar 2024 19:56:23 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 19:56:22 +0800
Message-ID: <8b402050-2ed8-4b35-96ec-6672aac35f73@huawei.com>
Date: Mon, 25 Mar 2024 19:56:21 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: nfsd: use group allocation/free of per-cpu counters
 API
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Dennis Zhou
	<dennis@kernel.org>
CC: <linux-nfs@vger.kernel.org>
References: <20240325041019.52998-1-wangkefeng.wang@huawei.com>
 <27e0e16b438b67fef765ea03812d6e97646bc1f0.camel@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <27e0e16b438b67fef765ea03812d6e97646bc1f0.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/25 18:52, Jeff Layton wrote:
> On Mon, 2024-03-25 at 12:10 +0800, Kefeng Wang wrote:
>> Use group allocation/free of per-cpu counters api to accelerate
>> nfsd_percpu_counters_init/destroy() and simplify code.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   fs/nfsd/stats.c | 18 ++----------------
>>   1 file changed, 2 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
>> index be52fb1e928e..c7f481d180f8 100644
>> --- a/fs/nfsd/stats.c
>> +++ b/fs/nfsd/stats.c
>> @@ -75,18 +75,7 @@ DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
>>   
>>   int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
>>   {
>> -	int i, err = 0;
>> -
>> -	for (i = 0; !err && i < num; i++)
>> -		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
>> -
>> -	if (!err)
>> -		return 0;
>> -
>> -	for (; i > 0; i--)
>> -		percpu_counter_destroy(&counters[i-1]);
>> -
>> -	return err;
>> +	return percpu_counter_init_many(counters, 0, GFP_KERNEL, num);
>>   }
>>   
>>   void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
>> @@ -99,10 +88,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
>>   
>>   void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
>>   {
>> -	int i;
>> -
>> -	for (i = 0; i < num; i++)
>> -		percpu_counter_destroy(&counters[i]);
>> +	percpu_counter_destroy_many(counters, num);
>>   }
>>   
>>   int nfsd_stat_counters_init(struct nfsd_net *nn)
> 
> I think it would be simpler to eliminate
> nfsd_percpu_counters_init/_destroy altogether and just replace them with
> percpu_counter_*_many calls. Is there any reason not to do that?

OK, will squash init/destroy and reset into the callers.
> 

