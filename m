Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FECD45357A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 16:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhKPPTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 10:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237887AbhKPPTC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 10:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637075764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZW29D3OCFyEL5rq6pIzjOKJlWXMvnw1dzp5//sz7vKA=;
        b=OiO9Ld1KoWQzk2NhZZZL24BLioG50d29XzYHqJa3n7hHNWcSWx6BgS5zdp06es2NXfbBR7
        NMGtHdEec61KsJT5TKvQCzXK8o327pgro2bEq/PdX2+tz1K9D7KWA5QyR6i/YdP99h3tgj
        uYIphcw4NEbCHkIx7fptWGp0lDZGZtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-x-Yv85vsPPS1lNauyGA1MA-1; Tue, 16 Nov 2021 10:15:13 -0500
X-MC-Unique: x-Yv85vsPPS1lNauyGA1MA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E0C618125C8;
        Tue, 16 Nov 2021 15:15:12 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F6075BAE5;
        Tue, 16 Nov 2021 15:15:11 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Date:   Tue, 16 Nov 2021 10:15:10 -0500
Message-ID: <DBBD287E-3C18-44A7-AF65-C535717BA5EA@redhat.com>
In-Reply-To: <c5dddaa40131e350fad249c71890ea79df9cef06.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
 <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
 <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
 <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
 <879b0f03b5c3b786568aaefd26bc8c714e1d7aae.camel@hammerspace.com>
 <66EE327D-C8F1-44D0-9364-573CA1208D46@redhat.com>
 <c5dddaa40131e350fad249c71890ea79df9cef06.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2021, at 9:49, Trond Myklebust wrote:

> On Tue, 2021-11-16 at 09:34 -0500, Benjamin Coddington wrote:
>> On 16 Nov 2021, at 9:17, Trond Myklebust wrote:
>>
>>> On Tue, 2021-11-16 at 09:12 -0500, Benjamin Coddington wrote:
>>>> On 16 Nov 2021, at 9:03, Trond Myklebust wrote:
>>>>> No, we really shouldn't need to care what the server thinks or
>>>>> does.
>>>>> The client is authoritative for the change attribute while it
>>>>> holds
>>>>> a
>>>>> delegation, not the server.
>>>>
>>>> My understanding of the intention of the code (which I had to
>>>> sort of
>>>> put
>>>> together from historical patches in this area) is that we want to
>>>> see
>>>> ctime,
>>>> mtime, and block size updates after copy/clone even if we hold a
>>>> delegation,
>>>> but without NFS_INO_INVALID_CHANGE, the client won't update those
>>>> attributes.
>>>>
>>>> If that's not necessary, we can drop this patch.
>>>>
>>>
>>> We will still see the ctime/mtime/block size updates even if
>>> NFS_INO_INVALID_CHANGE is not set. Those attributes' cache status
>>> are
>>> tracked separately through their own NFS_INO_INVALID_* bits.
>>>
>>> That said, there really is no reason why we shouldn't treat the
>>> copy
>>> and clone code exactly the same way we would treat a regular write.
>>> Perhaps we can fix up the arguments of nfs_writeback_update_inode()
>>> so
>>> that it can be called here?
>>
>> I wonder if that just kicks the problem down the road to when we
>> return the
>> delegation, and we'll see cases where ctime/mtime move backward.  And
>> I
>> don't think we can ever be authoritative for space_used, but maybe it
>> doesn't
>> matter if we're within the attribute timeouts.
>>
>
> I don't understand your point. Mine is that we _should_ be setting the
> NFS_INO_INVALID_MTIME, NFS_INO_INVALID_CTIME, NFS_INO_INVALID_BLOCKS...
> flags here, and as far as I can tell, we are indeed doing so in
> nfs42_copy_dest_done().

Yes, -- I misunderstood your suggestion to use nfs_writeback_update_inode()
as a way to fill in our cached attributes with values we'd expect from the
result of the copy.

> At least for clone(), we're then calling nfs_post_op_update_inode(),
> which updates the attributes with whatever was retrieved in the CLONE
> call. That will usually contain new values for mtime, ctime and blocks,
> and so the cache is refreshed.
>
> If the client failed to retrieve attributes as part of the CLONE or
> COPY call, then we are indeed kicking the can of revalidating the
> attributes down the road, but only as far as until the next call to
> nfs_getattr(), or the delegation return, whichever comes first. The
> fact that we do set the NFS_INO_INVALID_MTIME, ... means that we will
> update those cached values before replying to a stat() or statx() call.

Ok, thanks for the looks at this, you've convinced me that this patch is
unnecessary.  I still need the first one, let me know if you want me to
resend it as a stand-alone fix.

Ben

