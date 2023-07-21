Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC775D136
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjGUSVk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 14:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGUSVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 14:21:39 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 11:21:38 PDT
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86B602D53
        for <linux-nfs@vger.kernel.org>; Fri, 21 Jul 2023 11:21:38 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id MudfqZmp6ZWkDMudgqhi1F; Fri, 21 Jul 2023 20:14:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689963246;
        bh=AmX9+FCopDetAbUWOPTlpLf/McakrrsKFPdMmPS+Vms=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To;
        b=X7qeUmb3/s2w4UVMyR8lShNRHjmRFE2yaveUsCV7E8KpggVNWFpAzJIbKsqT34Lwy
         l/MeclfwgRQytCSLS6P4r2+e3qNaW7nfVL6HH9dYO7fn6dLEW0+JFuFd+m9e96xkI4
         woHYq7KMoUguMhfAq5rETg2n/tiBXNHx00/QB2NfAnKETFQ7KqmWP/td/SHKBHsJYr
         5hapJxSczfrG4iPoB0vyWuzW53iYumUo0y77BGHgvGFvDwP5HyMFZYGJmiPM774d5g
         J6LAKK8MG/fIy7VUUHtqi+LA2m/hW/cMKnEL5FfM6Lp8JpGjueMAgOacNysYWu+n6/
         Xm+QDxVVr0FIA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 Jul 2023 20:14:06 +0200
X-ME-IP: 86.243.2.178
Message-ID: <49ebb356-0a0d-7ec0-3d6a-4fb79272c41f@wanadoo.fr>
Date:   Fri, 21 Jul 2023 20:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nfs/blocklayout: Use the passed in gfp flags
Content-Language: fr
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
 <e0e9d80e-0e69-e685-c2d5-a658a173b9ce@wanadoo.fr>
In-Reply-To: <e0e9d80e-0e69-e685-c2d5-a658a173b9ce@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Le 21/07/2023 à 19:59, Christophe JAILLET a écrit :
> Le 21/07/2023 à 19:28, Anna Schumaker a écrit :
>> Hi Dan,
>>
>> On Fri, Jul 21, 2023 at 10:58 AM Dan Carpenter 
>> <dan.carpenter@linaro.org> wrote:
>>>
>>> This allocation should use the passed in GFP_ flags instead of
>>> GFP_KERNEL.  All the callers that I reviewed passed GFP_KERNEL as the
>>> allocation flags so this might not affect runtime, but it's still worth
>>> cleaning up.
>>
>> If all the callers are passing GFP_KERNEL anyway, then can we instead
>> remove the gfp_mask argument from these functions?
> 
> Hi,
> 
> I won't be able to remind the (verrrrrryyyyy long) call chain, but I 
> managed to arrive up to [1].
> So, *if I'm right*, 'gfp_mask' is NOT always GFP_KERNEL.

I can't remind the call chain myself, but my browser history can.

gfp_mask is propagated in all the below functions:

filelayout_pg_init_write()
--> fl_pnfs_update_layout(..., GFP_NOFS)
--> filelayout_check_deviceid()
--> nfs4_find_get_deviceid()
--> nfs4_get_device_info()
--> alloc_deviceid_node()	function pointer in struct pnfs_layoutdriver_type
--> bl_alloc_deviceid_node()
--> bl_parse_deviceid()
--> bl_parse_slice()  /  bl_parse_concat()

CJ

> 
> [1]: 
> https://elixir.bootlin.com/linux/v6.5-rc1/source/fs/nfs/filelayout/filelayout.c#L904
> 
> Just my 2c,
> 
> CJ
> 
>>
>> Anna
>>
>>>
>>> Fixes: 5c83746a0cf2 ("pnfs/blocklayout: in-kernel GETDEVICEINFO XDR 
>>> parsing")
>>> Signed-off-by: Dan Carpenter 
>>> <dan.carpenter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>>>   fs/nfs/blocklayout/dev.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
>>> index 70f5563a8e81..65cbb5607a5f 100644
>>> --- a/fs/nfs/blocklayout/dev.c
>>> +++ b/fs/nfs/blocklayout/dev.c
>>> @@ -404,7 +404,7 @@ bl_parse_concat(struct nfs_server *server, struct 
>>> pnfs_block_dev *d,
>>>          int ret, i;
>>>
>>>          d->children = kcalloc(v->concat.volumes_count,
>>> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
>>> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>>>          if (!d->children)
>>>                  return -ENOMEM;
>>>
>>> @@ -433,7 +433,7 @@ bl_parse_stripe(struct nfs_server *server, struct 
>>> pnfs_block_dev *d,
>>>          int ret, i;
>>>
>>>          d->children = kcalloc(v->stripe.volumes_count,
>>> -                       sizeof(struct pnfs_block_dev), GFP_KERNEL);
>>> +                       sizeof(struct pnfs_block_dev), gfp_mask);
>>>          if (!d->children)
>>>                  return -ENOMEM;
>>>
>>> -- 
>>> 2.39.2
>>>
>>
> 
> 
