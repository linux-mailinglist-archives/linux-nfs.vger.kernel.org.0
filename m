Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73728526917
	for <lists+linux-nfs@lfdr.de>; Fri, 13 May 2022 20:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382933AbiEMSQp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 May 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378108AbiEMSQp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 May 2022 14:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78148207920
        for <linux-nfs@vger.kernel.org>; Fri, 13 May 2022 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652465802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OuTmFU0l8hFaMha30QMfj9nisFU7dckr2pldX8QNnoU=;
        b=coOh1nMNNqfmlk56iQNkbTT8qRfPF5L+E0hNQXP0Oag6yU0fOTDdtRXKlEJrdO555ROs8I
        ZP9C849thH4hlr+M7Ul29vSVbOm5KtnR549jr2pqaH499DfwpTlD3T2LaVeUUcBKzNIJa9
        b+rKVB/UOvLrD6flTuToEdOCzJSHDko=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-wStW75DeMICBGy8cFOLSqA-1; Fri, 13 May 2022 14:16:37 -0400
X-MC-Unique: wStW75DeMICBGy8cFOLSqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3FDF29AA3AF;
        Fri, 13 May 2022 18:16:36 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B679140E7F12;
        Fri, 13 May 2022 18:16:36 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna@kernel.org, linux-nfs@vger.kernel.org, smayhew@redhat.com
Subject: Re: [PATCH] NFSv4: Restore nfs4_label into copied nfs_fattr for
 referrals
Date:   Fri, 13 May 2022 14:16:36 -0400
Message-ID: <32BB80FC-7393-40D2-8169-BEB7CEEC55B9@redhat.com>
In-Reply-To: <cd3b333cc9d3a4eb5c1d1f185dbb101a5e59f91e.camel@hammerspace.com>
References: <8ffe993a7aa39881d3e610d5424098ea7ec88180.1652448889.git.bcodding@redhat.com>
 <cd3b333cc9d3a4eb5c1d1f185dbb101a5e59f91e.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 May 2022, at 11:05, Trond Myklebust wrote:

> On Fri, 2022-05-13 at 09:36 -0400, Benjamin Coddington wrote:
>> ..which will fix up trying to free uninitialized nfs4_label:
>>
>> PID: 790    TASK: ffff88811b43c000  CPU: 0   COMMAND: "ls"
>>  #0 [ffffc90000857920] panic at ffffffff81b9bfde
>>  #1 [ffffc900008579c0] do_trap at ffffffff81023a9b
>>  #2 [ffffc90000857a10] do_error_trap at ffffffff81023b78
>>  #3 [ffffc90000857a58] exc_stack_segment at ffffffff81be1f45
>>  #4 [ffffc90000857a80] asm_exc_stack_segment at ffffffff81c009de
>>  #5 [ffffc90000857b08] nfs_lookup at ffffffffa0302322 [nfs]
>>  #6 [ffffc90000857b70] __lookup_slow at ffffffff813a4a5f
>>  #7 [ffffc90000857c60] walk_component at ffffffff813a86c4
>>  #8 [ffffc90000857cb8] path_lookupat at ffffffff813a9553
>>  #9 [ffffc90000857cf0] filename_lookup at ffffffff813ab86b
>>
>> Fixes: 9558a007dbc3 ("NFS: Remove the label from the nfs4_lookup_res
>> struct")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/nfs4proc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>> index a79f66432bd3..4566280e6ff2 100644
>> --- a/fs/nfs/nfs4proc.c
>> +++ b/fs/nfs/nfs4proc.c
>> @@ -4235,6 +4235,7 @@ static int nfs4_get_referral(struct rpc_clnt
>> *client, struct inode *dir,
>>         int status = -ENOMEM;
>>         struct page *page = NULL;
>>         struct nfs4_fs_locations *locations = NULL;
>> +       struct nfs4_label *label = fattr->label;
>>  
>>         page = alloc_page(GFP_KERNEL);
>>         if (page == NULL)
>> @@ -4263,6 +4264,7 @@ static int nfs4_get_referral(struct rpc_clnt
>> *client, struct inode *dir,
>>  
>>         /* replace the lookup nfs_fattr with the locations 
>> nfs_fattr
>> */
>>         memcpy(fattr, &locations->fattr, sizeof(struct 
>> nfs_fattr));
>> +       fattr->label = label;
>>         memset(fhandle, 0, sizeof(struct nfs_fh));
>>  out:
>>         if (page)
>
> Thanks for finding this, but wouldn't it be better just to decode the
> fattr in place instead of decoding it into locations->fattr and then
> doing a memcpy() to get it placed correctly?
>
> i.e. add a level of indirection in struct nfs4_fs_locations so that
> nfs4_xdr_dec_fs_locations() just uses our fattr instead of its own.

Its a much bigger change since we'll end up needing to allocate fattr
everywhere fs_locations is used after changing it to a pointer, but if
that's the way you want it I'll send it along.

Ben

