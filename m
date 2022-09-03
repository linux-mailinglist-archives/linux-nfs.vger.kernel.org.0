Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28E5ABBD6
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Sep 2022 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiICAif (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 20:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiICAiX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 20:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6919CCC8
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 17:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662165501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1wOXN+tQxAs2KsuAIcJ+uUk7GdBK3bs0BuBKxt6ReIU=;
        b=GXZzJH0sFttIV7Rl/plKTpM03dIaojto7lumZ1Lul4FnsVb/kyPmGLgznZ5h6rwe6L2H2C
        T09G/O6rc7ZLXbrTKF1UUumWVb2qG1JvlTQRSvfW7KZFCbyeU3DwVCyWk/C1YqX2dfbqky
        atoLrg8ZfBOj/Lu052ZM/Mkj7hGW1Mk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-JTYxkC2kPM6-ZH10woDUHg-1; Fri, 02 Sep 2022 20:38:18 -0400
X-MC-Unique: JTYxkC2kPM6-ZH10woDUHg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCF9580418F;
        Sat,  3 Sep 2022 00:38:17 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38A48492C3B;
        Sat,  3 Sep 2022 00:38:17 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Olga Kornievskaia" <aglo@umich.edu>,
        "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: Is this nfsd kernel oops known?
Date:   Fri, 02 Sep 2022 20:38:15 -0400
Message-ID: <1D65FB47-EC61-45FB-972D-D68832B54C47@redhat.com>
In-Reply-To: <2E6F8E3F-C14C-44C7-8B72-744A5F6E8F7F@oracle.com>
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com>
 <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <6DC1F4DF-8242-480B-813A-5F87D64593A6@redhat.com>
 <2E6F8E3F-C14C-44C7-8B72-744A5F6E8F7F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Sep 2022, at 17:13, Chuck Lever III wrote:

>> On Sep 2, 2022, at 4:58 PM, Benjamin Coddington <bcodding@redhat.com> 
>> wrote:
>>
>> Olga, does this fix it up for you?  I'm testing now, but I think it 
>> might be
>> a little harder for me to hit.
>>
>> Ben
>>
>> 8<------------------------------------------------
>> From 6bea39a887495b1748ff3b179d6e2f3d7e552b61 Mon Sep 17 00:00:00 
>> 2001
>> From: Benjamin Coddington <bcodding@redhat.com>
>> Date: Fri, 2 Sep 2022 16:49:17 -0400
>> Subject: [PATCH] SUNRPC: Fix svc_tcp_sendmsg bvec offset calculation
>>
>> The xdr_buf's bvec member points to an array of struct bio_vec, let's
>> fixup the calculation to the start of the bio_vec for non-zero
>> page_base.
>>
>> Fixes: bad4c6eb5eaa ("SUNRPC: Fix NFS READs that start at 
>> non-page-aligned offsets")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>> net/sunrpc/svcsock.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index 2fc98fea59b4..ecafc9c4bc5c 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -1110,7 +1110,7 @@ static int svc_tcp_sendmsg(struct socket *sock, 
>> struct xdr_buf *xdr,
>>                unsigned int offset, len, remaining;
>>                struct bio_vec *bvec;
>>
>> -               bvec = xdr->bvec + (xdr->page_base >> PAGE_SHIFT);
>> +               bvec = &xdr->bvec[xdr->page_base >> PAGE_SHIFT];
>
> Color me skeptical.
>
> I'm not sure these two expressions are different. This variety
> of pointer arithmetic is used throughout the XDR layer:

Yeah, you know what - it did crash in the same place with this change.

My thinking was that if you have (for example) page_base = 8192, and
xdr->bvec of, say 0xffff4500, then what you want is to set the local 
bvec var
to 0xfff4500 + sizeof(struct bio_vec)*2, but the code looks like it 
would
set the local bvec to 0xffff4502, which is not the same thing..

There must be a hole in my head,  I guess I need to dig out my K&R, 
sorry
for the noise.  I will figure it out.

> net/sunrpc/xdr.c:       pgto = pages + (pgto_base >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       pgto = pages + (pgto_base >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       pgfrom = pages + (pgfrom_base >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       pgto = pages + (pgbase >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       pgfrom = pages + (pgbase >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       page = pages + (pgbase >> PAGE_SHIFT);
> net/sunrpc/xdr.c:       xdr->page_ptr = buf->pages + (new >> 
> PAGE_SHIFT);
> net/sunrpc/xdr.c:               ppages = buf->pages + (base >> 
> PAGE_SHIFT);
> net/sunrpc/xprtrdma/rpc_rdma.c: ppages = buf->pages + (buf->page_base 
> >> PAGE_SHIFT);
> net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdrbuf->pages + 
> (xdrbuf->page_base >> PAGE_SHIFT);
> net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdr->pages + (xdr->page_base 
> >> PAGE_SHIFT);
> net/sunrpc/xprtrdma/rpc_rdma.c: ppages = xdr->pages + (xdr->page_base 
> >> PAGE_SHIFT);

Hmm.. there's clearly something wrong with me.

> Commit bad4c6eb5eaa is from v5.11. Wouldn't this issue have
> shown up in earlier kernels? At the very least, the patch
> description needs to explain why this computation is not a
> problem for kernels 5.11 through 5.19.

I totally agree.  I figured it was rare to have a non-zero page_base, 
and
maybe a client change is now creating that.

Ben

