Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41FC4533AF
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237131AbhKPOJh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237001AbhKPOJg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637071599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdFGEIz8bOAzWH9op5xTeSNn/VU2v9wek5yerseiCp8=;
        b=Mb3/+HfcPWLfTSqt1hJYm6KFlpHltVvlOYKd0SrWwpoZlhqH6eeqPRYkWY6nHQQxO+y/IQ
        1vzrpOps3lmGil+xubjb6RBOqlrlHRGiTlAIOqiJ2NIIS0H0sIsY03JecDaUGHLQyN4AYV
        4Na7Xgzo4/ZlvQ2LDTSL6PotgU8KI/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-OhU2s5sbMy-mkznSdDbPbQ-1; Tue, 16 Nov 2021 09:06:35 -0500
X-MC-Unique: OhU2s5sbMy-mkznSdDbPbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D317280DDE0;
        Tue, 16 Nov 2021 14:06:34 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C5EE60D30;
        Tue, 16 Nov 2021 14:06:34 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] NFSv42: Fix pagecache invalidation after COPY/CLONE
Date:   Tue, 16 Nov 2021 09:06:32 -0500
Message-ID: <01F85A5B-483C-41B4-8D3E-0CD6209232C6@redhat.com>
In-Reply-To: <EE06FD52-D67E-4792-8512-AEF97E8D8570@redhat.com>
References: <cover.1637069577.git.bcodding@redhat.com>
 <8b8ccdb69af2473eef4a36968894e7aee34d5851.1637069577.git.bcodding@redhat.com>
 <6dbcb2f39dcee7314bf772aaabf4923104ec7aee.camel@hammerspace.com>
 <EE06FD52-D67E-4792-8512-AEF97E8D8570@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2021, at 9:01, Benjamin Coddington wrote:

> On 16 Nov 2021, at 8:57, Trond Myklebust wrote:
>
>> On Tue, 2021-11-16 at 08:49 -0500, Benjamin Coddington wrote:
>>> The mechanism in use to allow the client to see the results of
>>> COPY/CLONE
>>> is to drop those pages from the pagecache.  This forces the client 
>>> to
>>> read
>>> those pages once more from the server.  However,
>>> truncate_pagecache_range()
>>> zeros out partial pages instead of dropping them.  Let us instead 
>>> use
>>> invalidate_inode_pages2_range() with full-page offsets to ensure the
>>> client
>>> properly sees the results of COPY/CLONE operations.
>>>
>>> Cc: <stable@vger.kernel.org> # v4.7+
>>> Fixes: 2e72448b07dc ("NFS: Add COPY nfs operation")
>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>> ---
>>>  fs/nfs/nfs42proc.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
>>> index a24349512ffe..bbcd4c80c5a6 100644
>>> --- a/fs/nfs/nfs42proc.c
>>> +++ b/fs/nfs/nfs42proc.c
>>> @@ -285,7 +285,10 @@ static void nfs42_copy_dest_done(struct inode
>>> *inode, loff_t pos, loff_t len)
>>>         loff_t newsize = pos + len;
>>>         loff_t end = newsize - 1;
>>>  
>>> -       truncate_pagecache_range(inode, pos, end);
>>> +       int error = 
>>> invalidate_inode_pages2_range(inode->i_mapping,
>>> +                               pos 
>>> >> PAGE_SHIFT, end >>
>>> PAGE_SHIFT);
>>
>> Shouldn't that be "(end + PAGE_SIZE - 1) >> PAGE_SHIFT" in order to
>> align to the set of pages that fully contains the byte range from pos
>> to end?
>
> It's embarrassing that I've messed that up, I will resend it.

I've had it sitting around a bit too long -- on a second look no, it 
should
be right because invalidate_inode_pages2_range()'s index arguments are
inclusive.

Ben

