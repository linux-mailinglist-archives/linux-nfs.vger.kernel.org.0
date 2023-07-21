Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95CA75D101
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 19:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGUR7Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 13:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGUR7P (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 13:59:15 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD0186
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 10:59:12 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MuPEqgy6sztucMuPEqVJOA; Fri, 21 Jul 2023 19:59:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689962350;
        bh=ZJOYGqPX+1sVeveV+yuedvF0OZs+FwchDT6B/R9zhZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JzjzTgornxmtGO4ciBKUE4WThAgmQnOAgrfuZqWVdKLRFsyHppeJhJQySIOdOLrVc
         CrBsEHgANRimdPlr97komSJ9rXcRseUeyP1xyyf0j+msI7bWgepLtwQeZsm+IKE0p9
         MNy3nNkXg1TdeH/wyHSqDaf3XTEkXFTsA0W1cJc+cRvClS40Wk1xOp/Sej4goNRB1r
         1QbpN4lLtKi1/IRgerkqp9O+2x8H6YAJg60eOtJJp86rtqVBsn4c4/kRW7D/uo+CZp
         9+o84YsU5t+6mkn6mhoLwvZpUfVmqJmjqBHDICphkNxONi5Tof/vpf5nZhDcjnOvEV
         uzlJ4doyKlFog==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 19:59:10 +0200
X-ME-IP: 86.243.2.178
Message-ID: <e0e9d80e-0e69-e685-c2d5-a658a173b9ce@wanadoo.fr>
Date:   Fri, 21 Jul 2023 19:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nfs/blocklayout: Use the passed in gfp flags
Content-Language: fr, en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Anna Schumaker <anna@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Jens Axboe <axboe@kernel.dk>, Jack Wang <jinpu.wang@ionos.com>,
        Dave Chinner <dchinner@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        linux-nfs@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <e655db6f-471b-4184-8907-0551e909acbb@moroto.mountain>
 <CAFX2JfmdpaRWbBypM+Xd4omd86mAbMNQ79+=xAtJXNjip95Sag@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAFX2JfmdpaRWbBypM+Xd4omd86mAbMNQ79+=xAtJXNjip95Sag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Le 21/07/2023 à 19:28, Anna Schumaker a écrit :
> Hi Dan,
> 
> On Fri, Jul 21, 2023 at 10:58 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
>>
>> This allocation should use the passed in GFP_ flags instead of
>> GFP_KERNEL.  All the callers that I reviewed passed GFP_KERNEL as the
>> allocation flags so this might not affect runtime, but it's still worth
>> cleaning up.
> 
> If all the callers are passing GFP_KERNEL anyway, then can we instead
> remove the gfp_mask argument from these functions?

Hi,

I won't be able to remind the (verrrrrryyyyy long) call chain, but I 
managed to arrive up to [1].
So, *if I'm right*, 'gfp_mask' is NOT always GFP_KERNEL.

[1]: 
https://elixir.bootlin.com/linux/v6.5-rc1/source/fs/nfs/filelayout/filelayout.c#L904

Just my 2c,

CJ

> 
> Anna
> 
>>
>> Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR parsing")
>> Signed-off-by: Dan Carpenter <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>>   fs/nfs/blocklayout/dev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
>> index 70f5563a8e81..65cbb5607a5f 100644
>> --- a/fs/nfs/blocklayout/dev.c
>> +++ b/fs/nfs/blocklayout/dev.c
>> @@ -404,7 +404,7 @@ bl_parse_concat(struct nfs_server *server, struct pnfs_block_dev *d,
>>          int ret, i;
>>
>>          d->children = kcalloc(v->concat.volumes_count,
>> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
>> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>>          if (!d->children)
>>                  return -ENOMEM;
>>
>> @@ -433,7 +433,7 @@ bl_parse_stripe(struct nfs_server *server, struct pnfs_block_dev *d,
>>          int ret, i;
>>
>>          d->children = kcalloc(v->stripe.volumes_count,
>> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
>> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>>          if (!d->children)
>>                  return -ENOMEM;
>>
>> --
>> 2.39.2
>>
> 

