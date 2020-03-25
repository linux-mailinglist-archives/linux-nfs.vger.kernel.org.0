Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2629192BFF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 16:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCYPOj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 11:14:39 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:49877 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727319AbgCYPOj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 11:14:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TtcTuPJ_1585149273;
Received: from Macintosh.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TtcTuPJ_1585149273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Mar 2020 23:14:34 +0800
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@fieldses.org>,
        "neilb@suse.com" <neilb@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <8B2BC124-6911-46C9-9B01-A237AC149F0A@oracle.com>
 <13c45bdcb67d689bfcb4f4b720b631e56c662f2b.camel@hammerspace.com>
 <CCFA2CA8-150C-432C-B939-9085B791FE74@oracle.com>
 <5372f88d-efb7-25a3-789f-53bfa7bb6f26@linux.alibaba.com>
 <6AA6A103-6A9C-40CF-A625-B7A29B0D6BA0@oracle.com>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <eaa72567-a77d-5274-1569-fb3daf2c4162@linux.alibaba.com>
Date:   Wed, 25 Mar 2020 23:14:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6AA6A103-6A9C-40CF-A625-B7A29B0D6BA0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020/3/25 10:24 PM, Chuck Lever wrote:
> 
> 
>> On Mar 25, 2020, at 2:37 AM, Yihao Wu <wuyihao@linux.alibaba.com> wrote:
>>
>> On 2020/3/25 1:46 AM, Chuck Lever wrote:
>>>>>> ---
>>>>>> net/sunrpc/cache.c | 3 +++
>>>>>> 1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
>>>>>> index bd843a81afa0..3e523eefc47f 100644
>>>>>> --- a/net/sunrpc/cache.c
>>>>>> +++ b/net/sunrpc/cache.c
>>>>>> @@ -524,9 +524,11 @@ void cache_purge(struct cache_detail *detail)
>>>>>> 	struct hlist_node *tmp = NULL;
>>>>>> 	int i = 0;
>>>>>>
>>>>>> +	spin_lock(&cache_list_lock);
>>>>>> 	spin_lock(&detail->hash_lock);
>>>>>> 	if (!detail->entries) {
>>>>>> 		spin_unlock(&detail->hash_lock);
>>>>>> +		spin_unlock(&cache_list_lock);
>>>>>> 		return;
>>>>>> 	}
>>>>>>
>>>>>> @@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
>>>>>> 		}
>>>>>> 	}
>>>>>> 	spin_unlock(&detail->hash_lock);
>>>>>> +	spin_unlock(&cache_list_lock);
>>>>>> }
>>>>>> EXPORT_SYMBOL_GPL(cache_purge);
>>>>
>>>> Hmm... Shouldn't this patch be dropping cache_list_lock() when we call
>>>> sunrpc_end_cache_remove_entry()? The latter does call both
>>>> cache_revisit_request() and cache_put(), and while they do not
>>>> explicitly call anything that holds cache_list_lock, some of those cd-
>>>>> cache_put callbacks do look as if there is potential for deadlock.
>>> I see svc_export_put calling dput, eventually, which might_sleep().
>>
>> Wow that's a little strange. If svc_export_put->dput might_sleep, why can we
>> spin_lock(&detail->hash_lock); in cache_purge in the first place?
>>
>> And I agree with Trond those cd->cache_put callbacks are dangerous. I will look
>> into them today.
>>
>> But if we dropping cache_list_lock when we call sunrpc_end_cache_remove_entry,
>> cache_put is not protected, and this patch won't work anymore, right?
> 
> IMHO Neil's proposed solution seems pretty safe, and follows a well-understood
> pattern.
> 
> It would be nice (but not 100% necessary) if the race you found was spelled out
> in the patch description.
> 
> Thanks!
> 
> 
> --
> Chuck Lever
> 
> 

Yeah. I believe Neil's solution must be better. 
But I'm still studying it, so I didn't reply to him yet.
OK. I'll try make it more clearly in the next version patch.

Thanks,
Yihao Wu
