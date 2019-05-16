Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC05200E3
	for <lists+linux-nfs@lfdr.de>; Thu, 16 May 2019 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEPIB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 May 2019 04:01:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35061 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726742AbfEPIBW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 May 2019 04:01:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TRtdOfe_1557993679;
Received: from ali-186590dcce93-2.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TRtdOfe_1557993679)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 May 2019 16:01:19 +0800
Subject: Re: [PATCH v2 0/2] Fix two bugs CB_NOTIFY_LOCK failing to wake a
 water
To:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, caspar@linux.alibaba.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
 <0d422bbcce15e44a4608cced0a569585c75ccd9a.camel@kernel.org>
From:   Yihao Wu <wuyihao@linux.alibaba.com>
Message-ID: <1a3d5e35-50bc-d757-5d30-15b1c8cff9ad@linux.alibaba.com>
Date:   Thu, 16 May 2019 16:01:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0d422bbcce15e44a4608cced0a569585c75ccd9a.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2019/5/13 9:36 PM, Jeff Layton wrote:
> On Mon, 2019-05-13 at 14:49 +0800, Yihao Wu wrote:
>> This patch set fix bugs related to CB_NOTIFY_LOCK. These bugs cause
>> poor performance in locking operation. And this patchset should also fix
>> the failure when running xfstests generic/089 on a NFSv4.1 filesystem.
>>
>> Yihao Wu (2):
>>   NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails to wake a waiter
>>   NFSv4.1: Fix bug only first CB_NOTIFY_LOCK is handled
>>
>>  fs/nfs/nfs4proc.c | 31 ++++++++++++-------------------
>>  1 file changed, 12 insertions(+), 19 deletions(-)
>>
> 
> Looks good to me. Nice catch, btw!
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 

Thank you for your reviewing, Jeff!

And it seems I forgot to CC maintainers of fs/nfs. So I added you to the CC
list, Trond and Anna. Does this patchset need further reviewing?

Sorry to bother you.

Thanks,
Yihao Wu
