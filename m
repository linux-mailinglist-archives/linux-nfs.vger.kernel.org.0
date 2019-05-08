Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E617541
	for <lists+linux-nfs@lfdr.de>; Wed,  8 May 2019 11:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfEHJkW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 May 2019 05:40:22 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40041 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726727AbfEHJkW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 May 2019 05:40:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TRApRN9_1557308396;
Received: from ali-186590dcce93-2.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TRApRN9_1557308396)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 May 2019 17:39:57 +0800
Subject: Re: [PATCH 1/2] NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails
 to wake a waiter
To:     Greg KH <greg@kroah.com>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        caspar@linux.alibaba.com
References: <d0b6fc01-0a73-e4f7-b393-3ecc9aacffb0@linux.alibaba.com>
 <2a1cebca-1efb-1686-475b-a581e50e61b4@linux.alibaba.com>
 <20190508091921.GA1968@kroah.com>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <2697efa4-2da8-ca0f-3ad4-bdcbbdfd334a@linux.alibaba.com>
Date:   Wed, 8 May 2019 17:39:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508091921.GA1968@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019/5/8 5:19 PM, Greg KH wrote:
> On Wed, May 08, 2019 at 05:13:25PM +0800, Yihao Wu wrote:
>> Commit b7dbcc0e433f ""NFSv4.1: Fix a race where CB_NOTIFY_LOCK fails
>> to wake a waiter" found this bug. However it didn't fix it. This can
>> be fixed by adding memory barrier pair.
>>
>> Specifically, if any CB_NOTIFY_LOCK should be handled between unlocking
>> the wait queue and freezable_schedule_timeout, only two cases are
>> possible. So CB_NOTIFY_LOCK will not be dropped unexpectly.
>>
>> 1. The callback thread marks the NFS client as waked. Then NFS client
>> noticed that itself is waked, so it don't goes to sleep. And it cleans
>> its wake mark.
>>
>> 2. The NFS client noticed that itself is not waked yet, so it goes to
>> sleep. No modification will ever happen to the wake mark in between.
>>
>> Fixes: a1d617d ("nfs: allow blocking locks to be awoken by lock callbacks")
>> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
>> ---
>>  fs/nfs/nfs4proc.c | 21 +++++----------------
>>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 

Thanks for your reply! And I'm sorry about that. I will correct this in
patch v2 and read the rules before sending patches.

Thanks,
Yihao Wu
