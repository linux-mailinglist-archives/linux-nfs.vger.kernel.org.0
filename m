Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D721419E53D
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Apr 2020 15:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgDDNyi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Apr 2020 09:54:38 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54965 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgDDNyi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Apr 2020 09:54:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TuaeAVn_1586008401;
Received: from Macintosh.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TuaeAVn_1586008401)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Apr 2020 21:53:22 +0800
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Subject: Re: [PATCH] nfsd: fix race between cache_clean and cache_purge
To:     NeilBrown <neilb@suse.de>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
References: <5eed50660eb13326b0fbf537fb58481ea53c1acb.1585043174.git.wuyihao@linux.alibaba.com>
 <87369x8i8t.fsf@notabene.neil.brown.name>
Message-ID: <9c023160-8226-ac5d-9e7a-0e26ebf703f0@linux.alibaba.com>
Date:   Sat, 4 Apr 2020 21:53:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87369x8i8t.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2020/3/25 7:07 AM, NeilBrown wrote:
>>  
>> @@ -541,6 +543,7 @@ void cache_purge(struct cache_detail *detail)
>>  		}
>>  	}
>>  	spin_unlock(&detail->hash_lock);
>> +	spin_unlock(&cache_list_lock);
>>  }
>>  EXPORT_SYMBOL_GPL(cache_purge);
>>  
>> -- 
>> 2.20.1.2432.ga663e714
> I wonder if this is the best solution.
> This code:
> 
> 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
> 			sunrpc_begin_cache_remove_entry(ch, detail);
> 			spin_unlock(&detail->hash_lock);
> 			sunrpc_end_cache_remove_entry(ch, detail);
> 			spin_lock(&detail->hash_lock);
> 		}
> 
> Looks wrong.
> Dropping a lock while walking a list if only safe if you hold a
> reference to the place-holder - 'tmp' in this case.  but we don't.
> As this is trying to remove everything in the list it would be safer to
> do something like
> 
>  while (!hlist_empty(head)) {
>  	ch = hlist_entry(head->first, struct cache_head, h);
> 	sunrpc_begin_cache_remove_entry(ch, detail);
> 	spin_unlock(&detail->hash_lock);
> 	sunrpc_end_cache_remove_entry(ch, detail);
> 	spin_lock(&detail->hash_lock);
>  }
> 
> I'm guessing that would fix the problem in a more focused.
> But I'm not 100% sure because there is no analysis given of the cause.
> What line is
>   cache_purge+0xce/0x160
> ./scripts/faddr2line can tell you.
> I suspect it is the hlist_for_each_entry_safe() line.
> 
> Can you test the change I suggest and see if it helps?
> 
> Thanks,
> NeilBrown


Sorry for the late. It took me some time to reproduce the bug stably so I
can verify the correctness of the fix.

You definitely pointed out the root cause. And the solution is more elegant.
After applying your solution. The bug doesn't reproduce now.

There's no race condition. hash_lock is designed to protect cache_detail in
fine grain. And it already did its job. And yes, hlist_for_each_entry_safe
is where the bug at. It may walk to a deleted entry(tmp). My v1 solution is
a regression considering this.

So I will modify the patch title in v2 too.

BTW, I checked faddr2line output, it says cache_purge+0xce/0x160 is cache_put.
It make sense too, and doesn't go against your theory.

Here's my reproduce script:

	systemctl enable rpcbind
	systemctl enable nfs
	systemctl start rpcbind
	systemctl start nfs
	mkdir /tmp/x /tmp/y
	
	# Create some collision in hash table
	for i in `seq 256`; do
		mkdir /tmp/x/$i
		mkdir /tmp/y/$i
		exportfs localhost:/tmp/x/$i
	done
	for i in `seq 256`; do
		mount localhost:/tmp/x/$i /tmp/y/$i
	done
	
	END=$(cat /proc/self/net/rpc/nfsd.export/flush)
	NOW=$(date +%s)
	sleep $((END - NOW))

	# Trigger cache_purge
	systemctl stop nfs &
	usleep 20000
	# Trigger cache_clean
	echo > /proc/self/net/rpc/nfsd.export/flush

To speedup the reproducing process, I also added mdelay(500) between acquiring
and releasing hash_lock in cache_purge.

Thank you so much!
Yihao Wu
