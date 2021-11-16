Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB907453449
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhKPOiI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Nov 2021 09:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237566AbhKPOhn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Nov 2021 09:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637073285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQvIYwK0v+9sRu8x2Hvjr46jliKJqH2VGU98zz8MLR4=;
        b=IySUpnt5kBajM4pwIb5JIFwQupC07j7HXehZIDEj4c7OyB3u/H1lQ4ZEOugmfewdDLXkck
        F84sC7vOGrOcynff2E6O5eAxjoh6kx6XaDa7CFF1MZV4aDXo8dzuMEs0KsdGHIkhMGYXIh
        WYf8CA0AZDyIzSWtQJ6gmAZMoDQBFMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-jskUDxZOPemPYjru2M3mQg-1; Tue, 16 Nov 2021 09:34:42 -0500
X-MC-Unique: jskUDxZOPemPYjru2M3mQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EC1C804143;
        Tue, 16 Nov 2021 14:34:41 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE89419D9B;
        Tue, 16 Nov 2021 14:34:40 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, anna.schumaker@netapp.com
Subject: Re: [PATCH 2/3] NFSv42: Don't drop NFS_INO_INVALID_CHANGE if we hold
 a delegation
Date:   Tue, 16 Nov 2021 09:34:39 -0500
Message-ID: <66EE327D-C8F1-44D0-9364-573CA1208D46@redhat.com>
In-Reply-To: <879b0f03b5c3b786568aaefd26bc8c714e1d7aae.camel@hammerspace.com>
References: <cover.1637069577.git.bcodding@redhat.com>
 <c91e224b847e697e42b25cdc36cd164a61ad1ade.1637069577.git.bcodding@redhat.com>
 <a06d3d97a865747058c7d1cbcd4f70911c336fce.camel@hammerspace.com>
 <9FE34DCC-0F28-4960-B25C-B006DA6D9A38@redhat.com>
 <879b0f03b5c3b786568aaefd26bc8c714e1d7aae.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 16 Nov 2021, at 9:17, Trond Myklebust wrote:

> On Tue, 2021-11-16 at 09:12 -0500, Benjamin Coddington wrote:
>> On 16 Nov 2021, at 9:03, Trond Myklebust wrote:
>>> No, we really shouldn't need to care what the server thinks or
>>> does.
>>> The client is authoritative for the change attribute while it holds
>>> a
>>> delegation, not the server.
>>
>> My understanding of the intention of the code (which I had to sort of
>> put
>> together from historical patches in this area) is that we want to see
>> ctime,
>> mtime, and block size updates after copy/clone even if we hold a
>> delegation,
>> but without NFS_INO_INVALID_CHANGE, the client won't update those
>> attributes.
>>
>> If that's not necessary, we can drop this patch.
>>
>
> We will still see the ctime/mtime/block size updates even if
> NFS_INO_INVALID_CHANGE is not set. Those attributes' cache status are
> tracked separately through their own NFS_INO_INVALID_* bits.
>
> That said, there really is no reason why we shouldn't treat the copy
> and clone code exactly the same way we would treat a regular write.
> Perhaps we can fix up the arguments of nfs_writeback_update_inode() so
> that it can be called here?

I wonder if that just kicks the problem down the road to when we return the
delegation, and we'll see cases where ctime/mtime move backward.  And I
don't think we can ever be authoritative for space_used, but maybe it doesn't
matter if we're within the attribute timeouts.

