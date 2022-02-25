Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0714C43A7
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239710AbiBYL3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 06:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiBYL3X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 06:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D49FF1BD071
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 03:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645788529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GREEH9lcNdgoZa9+OflTEnvIK5RxiKSFydrc9Uf74Ws=;
        b=KhbIxc9yqKVtQJuRnt+H0iVzkdCelcz4fr0L9CIpJLF8e2u+8EHE+KeRg1/cGUuEYSmLE3
        8o3Vlqi7M1L2giMLf6k/LZua25fjkIR5GpUQ3OGKlPUETRupnthC+rhZQ5n+ipMz/V3k6G
        v0ST6facNx1JgIz3HTzFA/I88R3YvQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-3_KMCs4IP9uQNhV8RziKMg-1; Fri, 25 Feb 2022 06:28:46 -0500
X-MC-Unique: 3_KMCs4IP9uQNhV8RziKMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC5A1854E21;
        Fri, 25 Feb 2022 11:28:44 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CAE87ADAD;
        Fri, 25 Feb 2022 11:28:44 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     trondmy@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Date:   Fri, 25 Feb 2022 06:28:43 -0500
Message-ID: <80E3965C-3338-4C44-99BA-08FB0B5728A8@redhat.com>
In-Reply-To: <e2ee4448d8deff22d3949b4828d5334a72542701.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <EA90387C-B33D-4C81-BB80-8C0AB3251E5E@redhat.com>
 <e2ee4448d8deff22d3949b4828d5334a72542701.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Feb 2022, at 21:11, Trond Myklebust wrote:

> On Thu, 2022-02-24 at 09:15 -0500, Benjamin Coddington wrote:
>> On 23 Feb 2022, at 16:12, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> Instead of relying on counting the page offsets as we walk through
>>> the
>>> page cache, switch to calculating them algorithmically.
>>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/dir.c | 18 +++++++++++++-----
>>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index 8f17aaebcd77..f2258e926df2 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -248,17 +248,20 @@ static const char
>>> *nfs_readdir_copy_name(const
>>> char *name, unsigned int len)
>>>         return ret;
>>>  }
>>>
>>> +static size_t nfs_readdir_array_maxentries(void)
>>> +{
>>> +       return (PAGE_SIZE - sizeof(struct nfs_cache_array)) /
>>> +              sizeof(struct nfs_cache_array_entry);
>>> +}
>>> +
>>
>> Why the choice to use a runtime function call rather than the
>> compiler's
>> calculation?  I suspect that the end result is the same, as the
>> compiler
>> will optimize it away, but I'm curious if there's a good reason for
>> this.
>>
>
> The comparison is more efficient because no pointer arithmetic is
> needed. As you said, the above function always evaluates to a constant,
> and the array->size has been pre-calculated.

Comparisons are more efficient than using something like this?:

static const int nfs_readdir_array_maxentries =
        (PAGE_SIZE - sizeof(struct nfs_cache_array)) /
        sizeof(struct nfs_cache_array_entry);

I don't understand why, I must admit.   I'm not saying it should be changed,
I'm just trying to figure out the reason for the function declaration when
the value is a constant, and I thought there was a hole in my head.

Ben

