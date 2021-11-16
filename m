Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1E453384
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbhKPOFg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:05:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237064AbhKPOFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637071332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdhJ5IY9jBznOZrogIwKBM2QT43xtD8k63YtfZEpIRI=;
        b=Yhf2SmaI3ePRmpDI4W4oTcJ8RcEveSK+I83SHuTq7CW+XaEIXxEyg5MH0is4vUnMxwIJGj
        6/BBd0dsikatDaG+HlVMdSLwJjiqWBu9Wbz7trEXf20lMdV1lGqwxkYKXns4rc4mwO6ho6
        B8cm7/JoM7QW+SGZVgBp2FeKt7slhxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-in6SDDedO8KOVrZ1sn99KQ-1; Tue, 16 Nov 2021 09:02:08 -0500
X-MC-Unique: in6SDDedO8KOVrZ1sn99KQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB81B18D6A3B;
        Tue, 16 Nov 2021 14:01:52 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 91EE660BF1;
        Tue, 16 Nov 2021 14:01:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Date:   Tue, 16 Nov 2021 09:01:50 -0500
Message-ID: <EE06FD52-D67E-4792-8512-AEF97E8D8570@redhat.com>
In-Reply-To: <6dbcb2f39dcee7314bf772aaabf4923104ec7aee.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
 <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
 <6dbcb2f39dcee7314bf772aaabf4923104ec7aee.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2021, at 8:57, Trond Myklebust wrote:

> On Tue, 2021-11-16 at 08:49 -0500, Benjamin Coddington wrote:
>> The mechanism in use to allow the client to see the results of
>> COPY/CLONE
>> is to drop those pages from the pagecache.  This forces the client 
>> to
>> read
>> those pages once more from the server.  However,
>> truncate_pagecache_range()
>> zeros out partial pages instead of dropping them.  Let us instead 
>> use
>> invalidate_inode_pages2_range() with full-page offsets to ensure the
>> client
>> properly sees the results of COPY/CLONE operations.
>>
>> Cc: <stable@vger.kernel.org> # v4.7+
>> Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/nfs42proc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>> index a24349512ffe..bbcd4c80c5a6 100644
>> --- a/fs/nfs/nfs42proc.c
>> +++ b/fs/nfs/nfs42proc.c
>> @@ -285,7 +285,10 @@ static void nfs42_copy_dest_done(struct inode
>> *inode, loff_t pos, loff_t len)
>>         loff_t newsize = pos + len;
>>         loff_t end = newsize - 1;
>>  
>> -       truncate_pagecache_range(inode, pos, end);
>> +       int error = 
>> invalidate_inode_pages2_range(inode->i_mapping,
>> +                               pos >> 
>> PAGE_SHIFT, end >>
>> PAGE_SHIFT);
>
> Shouldn't that be "(end + PAGE_SIZE - 1) >> PAGE_SHIFT" in order to
> align to the set of pages that fully contains the byte range from pos
> to end?

It's embarrassing that I've messed that up, I will resend it.

Ben

