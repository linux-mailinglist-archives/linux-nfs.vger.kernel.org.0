Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC465A7582
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 07:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiHaFNv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 01:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaFNh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 01:13:37 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 22:13:36 PDT
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A515379EE4
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 22:13:36 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id TFvMoqKBPGYmzTFvMo9P19; Wed, 31 Aug 2022 07:06:04 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 31 Aug 2022 07:06:04 +0200
X-ME-IP: 90.11.190.129
Message-ID: <aa91faa7-eec8-50c7-9e9f-9c9c83d29766@wanadoo.fr>
Date:   Wed, 31 Aug 2022 07:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] nfsd: Fix a memory leak in an error handling path
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <122a5729fdcd76e23641c7d1853de2a632f6a742.1661509473.git.christophe.jaillet@wanadoo.fr>
 <20220826110808.GE2071@kadam>
 <5AAB19B0-0DAB-4313-AC9A-307E79CE4527@oracle.com>
X-Mozilla-News-Host: news://news.gmane.org
Content-Language: en-US
In-Reply-To: <5AAB19B0-0DAB-4313-AC9A-307E79CE4527@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Le 30/08/2022 à 23:11, Chuck Lever III a écrit :
> 
> 
>> On Aug 26, 2022, at 7:08 AM, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>>
>> On Fri, Aug 26, 2022 at 12:24:54PM +0200, Christophe JAILLET wrote:
>>> If this memdup_user() call fails, the memory allocated in a previous call
>>> a few lines above should be freed. Otherwise it leaks.
>>>
>>> Fixes: 6ee95d1c8991 ("nfsd: add support for upcall version 2")
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
>>> ---
>>> Speculative, untested.
>>> ---
>>> fs/nfsd/nfs4recover.c | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>>> index b29d27eaa8a6..248ff9f4141c 100644
>>> --- a/fs/nfsd/nfs4recover.c
>>> +++ b/fs/nfsd/nfs4recover.c
>>> @@ -815,8 +815,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>>> 				princhash.data = memdup_user(
>>> 						&ci->cc_princhash.cp_data,
>>> 						princhashlen);
>>> -				if (IS_ERR_OR_NULL(princhash.data))
>>> +				if (IS_ERR_OR_NULL(princhash.data)) {
>>> +					kfree(name.data);
>>> 					return -EFAULT;
>>
>> This comment is not directed at you and is not related to your patch.
>> But memdup_user() never returns NULL, only error pointers.  I wrote a
>> fifteen page blog entry about NULL vs error pointers the other week.
>> https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/
>> This should propagate the error code from memdup_user() instead of
>> -EFAULT.
> 
> I take it then that Christophe should redrive this with your suggested
> corrections? I haven't applied this yet because I was waiting for
> follow-up.
> 

Ok, I'll send a small serie of 3 patches...

CJ


> 
> --
> Chuck Lever
> 
> 
> 
> 

