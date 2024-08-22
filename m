Return-Path: <linux-nfs+bounces-5578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0313595B77B
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339191C23582
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2024 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E01CBE94;
	Thu, 22 Aug 2024 13:50:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74216183088;
	Thu, 22 Aug 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334641; cv=none; b=E2XuSyUadOxa/Y/W62LiS3Yhu/idYL4XGqWS8VP19I7eGc8XML/nHDQ0IhT1wnGZA7JZkIzPwN2aj+CnIvkB077apcDJH2ui00Q1M3d9t6qZcyF79971dWIBCiShoNs1b4qwykxFWofkR3b1pDwr27oXJYKY1mzEfpw1LFWnC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334641; c=relaxed/simple;
	bh=Sp1HFvYAZPCnDGplphIG02DYrocMTGWsQXNuo4CiCaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BdnyVdjf31lpYK/8mYgeFeaZY3D0xbY6EzhstT1d6QmFwtGdsp/fgfxPai0SwN9hgJHzg080dPEwhtdtijNRB8jemri7kqR2mFWgqHdhnTjDeeKLGw6rcWZtdVHFZ3F4TUlCbIWzlQ85VKPAlf/S31PHE5vYAa13unQSxHwbDls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqPgg2fsvzpTBc;
	Thu, 22 Aug 2024 21:49:03 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 6EDF3140590;
	Thu, 22 Aug 2024 21:50:36 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 22 Aug 2024 21:50:35 +0800
Message-ID: <01f3dd36-e4b6-4769-ba10-cdd0856a1076@huawei.com>
Date: Thu, 22 Aug 2024 21:50:34 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] atm: use min() to simplify the code
To: "Dr. David Alan Gilbert" <linux@treblig.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
	<luiz.dentz@gmail.com>, <idryomov@gmail.com>, <xiubli@redhat.com>,
	<dsahern@kernel.org>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<jmaloy@redhat.com>, <ying.xue@windriver.com>, <jacob.e.keller@intel.com>,
	<willemb@google.com>, <kuniyu@amazon.com>, <wuyun.abel@bytedance.com>,
	<quic_abchauha@quicinc.com>, <gouhao@uniontech.com>,
	<netdev@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>
References: <20240822133908.1042240-1-lizetao1@huawei.com>
 <20240822133908.1042240-2-lizetao1@huawei.com> <Zsc_hiWX9uvg_Oep@gallifrey>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <Zsc_hiWX9uvg_Oep@gallifrey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/8/22 21:39, Dr. David Alan Gilbert 写道:
> * Li Zetao (lizetao1@huawei.com) wrote:
>> When copying data to user, it needs to determine the copy length.
>> It is easier to understand using min() here.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   net/atm/addr.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/atm/addr.c b/net/atm/addr.c
>> index 0530b63f509a..6c4c942b2cb9 100644
>> --- a/net/atm/addr.c
>> +++ b/net/atm/addr.c
>> @@ -136,7 +136,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>>   	unsigned long flags;
>>   	struct atm_dev_addr *this;
>>   	struct list_head *head;
>> -	int total = 0, error;
>> +	size_t total = 0, error;
> 
> Aren't you accidentally changing the type of 'error' there, and the function
> returns 'int'.
This is intentionally modified because the input parameter size is of 
type size_t. If total is of type int, the compiler will report an error 
when the min() is called.
> 
> Dav
> 
> 
>>   	struct sockaddr_atmsvc *tmp_buf, *tmp_bufp;
>>   
>>   	spin_lock_irqsave(&dev->lock, flags);
>> @@ -155,7 +155,7 @@ int atm_get_addr(struct atm_dev *dev, struct sockaddr_atmsvc __user * buf,
>>   	    memcpy(tmp_bufp++, &this->addr, sizeof(struct sockaddr_atmsvc));
>>   	spin_unlock_irqrestore(&dev->lock, flags);
>>   	error = total > size ? -E2BIG : total;
>> -	if (copy_to_user(buf, tmp_buf, total < size ? total : size))
>> +	if (copy_to_user(buf, tmp_buf, min(total, size)))
>>   		error = -EFAULT;
>>   	kfree(tmp_buf);
>>   	return error;
>> -- 
>> 2.34.1
>>

Thanks,
Li Zetao.

