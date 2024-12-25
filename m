Return-Path: <linux-nfs+bounces-8770-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB899FC374
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB918842FA
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 03:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B917C8D;
	Wed, 25 Dec 2024 03:22:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF762F56;
	Wed, 25 Dec 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735096929; cv=none; b=JzEU8UVwR5UaR0VG2IGv9QVaYc+8e7AgfC+9i/2emTHnZkaK6mqG+uWF3gkSSIDxQQ98CBvy3WOK1qUvFXpDEBa/bWp5Rx6BdXqRYTnnBNla1oqgRsLLiOWhMuK5I83vyZSd4oOJvgw9FqGwj1lr/u2SJDzffc8wJuYwHbOckTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735096929; c=relaxed/simple;
	bh=P4jzAfVpChnoHSmEL/zXZuykfzIzPxDYDHnBM6njoxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olkH2Hw2cPjO1DKd/GrAR2dzC0g0SxoyHLDbvvzAdDBBeEcgu4uV0WcMUuuscpfYEI4zlZuiMnAyZAHdY8DAuQaUIZKGskgE3Eih1WnxM/yBipTTeoua0ydBhtVFLsk8HV5mWfE7/klUWKhOmImMsqRkj19BQVLLtztRyItbf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YHxr52qn0z4f3jdk;
	Wed, 25 Dec 2024 11:21:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1C61B1A0AE8;
	Wed, 25 Dec 2024 11:22:01 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgDnwoZXemtn_0NBFg--.36175S3;
	Wed, 25 Dec 2024 11:22:00 +0800 (CST)
Message-ID: <e09ef7f8-a878-5fc2-3bc5-c39b1fba0344@huaweicloud.com>
Date: Wed, 25 Dec 2024 11:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] NFSv4.0: Fix the wake up of the next waiter in
 nfs_release_seqid()
To: Li Lingfeng <lilingfeng3@huawei.com>, trondmy@kernel.org,
 Greg KH <gregkh@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, linux-stable <stable@vger.kernel.org>
References: <5527548df9be8ce76ed31ad0ea6520908533b4fe.1731103952.git.trond.myklebust@hammerspace.com>
 <0cf3c4a6-082a-4ee7-91bf-13cb98138879@huawei.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <0cf3c4a6-082a-4ee7-91bf-13cb98138879@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnwoZXemtn_0NBFg--.36175S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xGw45Cr4rAr13Ww1kuFg_yoW8Cw1DpF
	n5JrW5Gay8Zr40gr1jqr4UCryjqr48K3ZrGr1kAF1UAw43Ars0qF4aqr1v9rWUJrs3Xr4U
	Xr1FqFnxur45XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

You need cc stable.

在 2024/12/25 10:50, Li Lingfeng 写道:
> Hi, I noticed that [PATCH 2] has been applied to the stable, but [PATCH 1]
> has not.
> Based on 6.6 where [PATCH 2] was merged, I can still reproduce the
> original issue, and [PATCH 1] needs to be applied as well to resolve it.
> It may be better to push [PATCH 1] to the stable as well.
> Thanks.
> 
> 在 2024/11/9 6:13, trondmy@kernel.org 写道:
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> There is no need to wake up another waiter on the seqid list unless the
>> seqid being removed is at the head of the list, and so is relinquishing
>> control of the sequence counter to the next entry.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>   fs/nfs/nfs4state.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
>> index dafd61186557..9a9f60a2291b 100644
>> --- a/fs/nfs/nfs4state.c
>> +++ b/fs/nfs/nfs4state.c
>> @@ -1083,14 +1083,12 @@ void nfs_release_seqid(struct nfs_seqid *seqid)
>>           return;
>>       sequence = seqid->sequence;
>>       spin_lock(&sequence->lock);
>> -    list_del_init(&seqid->list);
>> -    if (!list_empty(&sequence->list)) {
>> -        struct nfs_seqid *next;
>> -
>> -        next = list_first_entry(&sequence->list,
>> -                struct nfs_seqid, list);
>> +    if (list_is_first(&seqid->list, &sequence->list) &&
>> +        !list_is_singular(&sequence->list)) {
>> +        struct nfs_seqid *next = list_next_entry(seqid, list);
>>           rpc_wake_up_queued_task(&sequence->wait, next->task);
>>       }
>> +    list_del_init(&seqid->list);
>>       spin_unlock(&sequence->lock);
>>   }


