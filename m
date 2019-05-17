Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CEA2197D
	for <lists+linux-nfs@lfdr.de>; Fri, 17 May 2019 16:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEQOEm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 May 2019 10:04:42 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42500 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728535AbfEQOEm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 May 2019 10:04:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TS-hbfu_1558101865;
Received: from ali-186590dcce93-2.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TS-hbfu_1558101865)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 May 2019 22:04:26 +0800
Subject: Re: [PATCH v2 1/2] NFSv4.1: Again fix a race where CB_NOTIFY_LOCK
 fails to wake a waiter
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     caspar@linux.alibaba.com
References: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
 <48a9d50b-f7b9-407d-06db-5c9079dfbf24@linux.alibaba.com>
 <07216eb5-7a15-d7b1-e553-58baa0e07282@linux.alibaba.com>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <129d03a2-2bea-2965-d614-e5622e2e828b@linux.alibaba.com>
Date:   Fri, 17 May 2019 22:04:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <07216eb5-7a15-d7b1-e553-58baa0e07282@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019/5/17 5:22 PM, Joseph Qi wrote:
> Hi Yihao,
> 
> On 19/5/13 14:57, Yihao Wu wrote:
>> Commit b7dbcc0e433f "NFSv4.1: Fix a race where CB_NOTIFY_LOCK fails to wake a waiter"
>> found this bug. However it didn't fix it.
>>
>> This commit replaces schedule_timeout() with wait_woken() and
>> default_wake_function() with woken_wake_function() in function
>> nfs4_retry_setlk() and nfs4_wake_lock_waiter(). wait_woken() uses
>> memory barriers in its implementation to avoid potential race condition
>> when putting a process into sleeping state and then waking it up.
>>
>> Fixes: a1d617d8f134 ("nfs: allow blocking locks to be awoken by lock callbacks")
>> Cc: stable@vger.kernel.org #4.9+
>> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
>> ---
>>  fs/nfs/nfs4proc.c | 23 +++++++----------------
>>  1 file changed, 7 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index c29cbef..f9ed6b5 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -6932,7 +6932,6 @@ struct nfs4_lock_waiter {
>>  	struct task_struct	*task;
>>  	struct inode		*inode;
>>  	struct nfs_lowner	*owner;
>> -	bool			notified;
>>  };
>>  
>>  static int
>> @@ -6954,13 +6953,13 @@ struct nfs4_lock_waiter {
>>  		/* Make sure it's for the right inode */
>>  		if (nfs_compare_fh(NFS_FH(waiter->inode), &cbnl->cbnl_fh))
>>  			return 0;
>> -
>> -		waiter->notified = true;
>>  	}
>>  
>>  	/* override "private" so we can use default_wake_function */
>>  	wait->private = waiter->task;
>> -	ret = autoremove_wake_function(wait, mode, flags, key);
>> +	ret = woken_wake_function(wait, mode, flags, key);
>> +	if (ret)
>> +		list_del_init(&wait->entry);
>>  	wait->private = waiter;
>>  	return ret;
>>  }
>> @@ -6979,8 +6978,7 @@ struct nfs4_lock_waiter {
>>  				    .s_dev = server->s_dev };
>>  	struct nfs4_lock_waiter waiter = { .task  = current,
>>  					   .inode = state->inode,
>> -					   .owner = &owner,
>> -					   .notified = false };
>> +					   .owner = &owner};
>>  	wait_queue_entry_t wait;
>>  
>>  	/* Don't bother with waitqueue if we don't expect a callback */
>> @@ -6993,21 +6991,14 @@ struct nfs4_lock_waiter {
>>  	add_wait_queue(q, &wait);
>>  
>>  	while(!signalled()) {
>> -		waiter.notified = false;
>>  		status = nfs4_proc_setlk(state, cmd, request);
>>  		if ((status != -EAGAIN) || IS_SETLK(cmd))
>>  			break;
>>  
>>  		status = -ERESTARTSYS;
>> -		spin_lock_irqsave(&q->lock, flags);
>> -		if (waiter.notified) {
>> -			spin_unlock_irqrestore(&q->lock, flags);
>> -			continue;
>> -		}
>> -		set_current_state(TASK_INTERRUPTIBLE);
>> -		spin_unlock_irqrestore(&q->lock, flags);
>> -
>> -		freezable_schedule_timeout(NFS4_LOCK_MAXTIMEOUT);
>> +		freezer_do_not_count();
>> +		wait_woken(&wait, TASK_INTERRUPTIBLE, NFS4_LOCK_MAXTIMEOUT);
>> +		freezer_count();
> 
> Since now variable 'flags' is not used anymore, we have to delete it as well.
> Otherwise there is a compile warning “unused variable ‘flags’”.
> 
> Thanks,
> Joseph

Thank you Joseph. I'll remove unused 'flags' in PATCH v3.

Thanks,
Yihao Wu

> 
>>  	}
>>  
>>  	finish_wait(q, &wait);
>>

