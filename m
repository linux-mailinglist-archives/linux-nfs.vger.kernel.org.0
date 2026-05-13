Return-Path: <linux-nfs+bounces-21583-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLLLFRnaA2qR/QEAu9opvQ
	(envelope-from <linux-nfs+bounces-21583-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:55:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826252C17A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 03:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48280302457F
	for <lists+linux-nfs@lfdr.de>; Wed, 13 May 2026 01:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E97A37B416;
	Wed, 13 May 2026 01:55:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283C37F753
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637330; cv=none; b=Ho3Tx0quEYpY9S7GNGsHpeWthNvEExfF6gaB7ED8Ios8aAW+6kT8UVL2eFmzFRa9mKH4WOAaEviasq3MCwcUmj7R6uh4CIrN4Huu5CTsl9WssOdVmRnce8a6tz29sU9dIsI5/JAD/eY4mOA8tDDgJTsgm0Mv9GZzFlfLf4w4WiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637330; c=relaxed/simple;
	bh=QiKLbZkOh++Ra4ljrvKK0N9hFyGBA52BhZh/KVGeLUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMDiDhtpz4OCugnq/iyTfWAWqxZYIBmTG8gaQ1b02J4F9hhlMp5GycQ7y5BI7l8gpLwckvDRp4SwOMnJJGj2KUOHTvzh5s75zMcyk4bo6TJHWvi22S/7laVSmTeT5qx9SXCb8NVaskOJzUsjqjBT564zr9c0ZZ0BGIUgtp5Jh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gFc3G1D4SzYQvH5
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 09:54:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D3F3940574
	for <linux-nfs@vger.kernel.org>; Wed, 13 May 2026 09:55:21 +0800 (CST)
Received: from [10.174.176.240] (unknown [10.174.176.240])
	by APP4 (Coremail) with SMTP id gCh0CgCXX1sF2gNqOrplCA--.9987S3;
	Wed, 13 May 2026 09:55:19 +0800 (CST)
Message-ID: <56174eb9-d074-4f8e-872b-f13b09813b2c@huaweicloud.com>
Date: Wed, 13 May 2026 09:55:17 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "NFSD: Defer sub-object cleanup in export put
 callbacks"
To: Chuck Lever <cel@kernel.org>, yangerkun <yangerkun@huawei.com>,
 Chuck Lever <chuck.lever@oracle.com>, Misbah Anjum N
 <misanjum@linux.ibm.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, yi.zhang@huawei.com,
 Zhihao Cheng <chengzhihao1@huawei.com>, Li Lingfeng <lilingfeng3@huawei.com>
References: <20260512023322.2828939-1-yangerkun@huawei.com>
 <0ce8ae76-da17-4b25-b1f8-6fa955654a57@app.fastmail.com>
 <cd07fc25-8c9d-42af-9bd8-36d1565a80ca@huawei.com>
 <55ec615a-3b80-4608-ac52-1c0215b789a7@app.fastmail.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <55ec615a-3b80-4608-ac52-1c0215b789a7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXX1sF2gNqOrplCA--.9987S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryxAF43XF1fCr45Jr4xWFg_yoW8tw43pF
	WfCF4YkF4DJrn7t3s2vw47Ja4Fvan7Jr1DWw15Kw4Fy3s8XF1xXF4rtwsI9Fy2krs5Ww1a
	9ryjya1vvw1vvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/
X-Rspamd-Queue-Id: 4826252C17A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[yangerkun@huaweicloud.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21583-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action



在 2026/5/13 9:36, Chuck Lever 写道:
> 
> 
> On Tue, May 12, 2026, at 9:27 PM, yangerkun wrote:
>> 在 2026/5/12 21:48, Chuck Lever 写道:
>>>
>>> On Mon, May 11, 2026, at 10:33 PM, Yang Erkun wrote:
> 
>>>> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
>>>> index 665153f1720e..0baa58d1dbfc 100644
>>>> --- a/fs/nfsd/export.c
>>>> +++ b/fs/nfsd/export.c
>>>> @@ -36,30 +36,19 @@
>>>>     * second map contains a reference to the entry in the first map.
>>>>     */
>>>>
>>>> -static struct workqueue_struct *nfsd_export_wq;
>>>> -
>>>
>>> Hi Erkun -
>>>
>>> This patch doesn't apply to the nfsd-testing branch. What's more,
>>> the patch series already in flight removes nfsd_export_wq:
>>
>> Hi Chuck,
>>
>> Apologies, I initially submitted a patch based on the mainline, but I
>> will update it to be based on nfsd-testing later.
>>
>>> https://lore.kernel.org/linux-nfs/98268bb4-2e97-4728-96a6-37b2a4a3ae5d@app.fastmail.com/T/#t
>>>
>>> That patch series replaces the nfsd_export_wq with a WQ that
>>> is managed in sunrpc.ko. Is that incorrect?
>>
>> I'm not sure if I understood you correctly. Do you mean that since this
>> patchset has already removed nfsd_export_wq, I need to adapt more based
>> on this patchset? Or are you saying that replacing nfsd_export_wq with a
>> workqueue in sunrpc.ko might not be sufficient because they are two
>> completely different modules? If you prefer, I can adapt the patch based
>> on this patchset.
> 
> It appears to me our fixes conflict with each other. I’m trying to figure
> out which to apply, or if both need to be applied, which order? We do need
> to consider ease of backporting, and your single patch would be easier to
> fit onto LTS kernels.

Yes, this single patch applied first would be easier to fit onto LTS
kernels.

> 
> But my series continues to use a WQ to defer resource release for all the
> cache-related files in /proc/fs/nfsd. Is that the wrong solution?

Certainly, as long as it doesn't reintroduce the exportfs-ra-umount
issue, it seems acceptable. However, I would rather avoid doing it. In
fact, as I mentioned earlier in a different discussion, I don't believe
deferring auth_domain_put in ip_map_put is necessary, so setting up a
shared workqueue for cache release callbacks seems unnecessary.

> 
> 


