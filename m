Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A009D2AF6CA
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKKQnk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 11:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbgKKQnk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 11:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605113018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gr7geuYODwKlnTHPkZc3PFA0Au6CxBeOURtV4ggeBSA=;
        b=B0vp2C+QiGfb8960QsBSSDvZjSAZB4oHweSv7AzLrIpnjzX+1jqQ8vjI3Zxa5YfKcfaTbD
        on7XZFGz8ekbw2p/FwLJ6Tk8lAyhwyrZ1DmyCswQCz964TxTHrMJmtkKhDBFFxm6byTEJ8
        Nbn6sVJo+bhacrxQ4qY8jRcpOVPDNwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-2vdQS7VjNkuFHgHdsUdHIg-1; Wed, 11 Nov 2020 11:43:36 -0500
X-MC-Unique: 2vdQS7VjNkuFHgHdsUdHIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48BA6809DC0;
        Wed, 11 Nov 2020 16:43:35 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB7319F64;
        Wed, 11 Nov 2020 16:43:34 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Date:   Wed, 11 Nov 2020 11:43:33 -0500
Message-ID: <6D043238-4C98-41B9-A890-B0897E7EFDBA@redhat.com>
In-Reply-To: <d31c1ca31e734d7566f3da6d1c1d651abc4101f7.camel@hammerspace.com>
References: <20201107140325.281678-1-trondmy@kernel.org>
 <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org>
 <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org>
 <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org>
 <20201107140325.281678-8-trondmy@kernel.org>
 <20201107140325.281678-9-trondmy@kernel.org>
 <20201107140325.281678-10-trondmy@kernel.org>
 <20201107140325.281678-11-trondmy@kernel.org>
 <20201107140325.281678-12-trondmy@kernel.org>
 <20201107140325.281678-13-trondmy@kernel.org>
 <20201107140325.281678-14-trondmy@kernel.org>
 <20201107140325.281678-15-trondmy@kernel.org>
 <20201107140325.281678-16-trondmy@kernel.org>
 <20201107140325.281678-17-trondmy@kernel.org>
 <20201107140325.281678-18-trondmy@kernel.org>
 <20201107140325.281678-19-trondmy@kernel.org>
 <20201107140325.281678-20-trondmy@kernel.org>
 <20201107140325.281678-21-trondmy@kernel.org>
 <20201107140325.281678-22-trondmy@kernel.org>
 <86F25343-0860-44A2-BA40-CFB640147D50@redhat.com>
 <d31c1ca31e734d7566f3da6d1c1d651abc4101f7.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9 Nov 2020, at 16:46, Trond Myklebust wrote:

> On Mon, 2020-11-09 at 16:41 -0500, Benjamin Coddington wrote:
>> On 7 Nov 2020, at 9:03, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> If the directory is changing, causing the page cache to get
>>> invalidated
>>> while we are listing the contents, then the NFS client is currently
>>> forced
>>> to read in the entire directory contents from scratch, because it
>>> needs
>>> to perform a linear search for the readdir cookie. While this is
>>> not
>>> an issue for small directories, it does not scale to directories
>>> with
>>> millions of entries.
>>> In order to be able to deal with large directories that are
>>> changing,
>>> add a heuristic to ensure that if the page cache is empty, and we
>>> are
>>> searching for a cookie that is not the zero cookie, we just default
>>> to
>>> performing uncached readdir.
>>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/dir.c | 17 +++++++++++++++++
>>>  1 file changed, 17 insertions(+)
>>>
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index 238872d116f7..d7a9efd31ecd 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -917,11 +917,28 @@ static int find_and_lock_cache_page(struct
>>> nfs_readdir_descriptor *desc)
>>>         return res;
>>>  }
>>>
>>> +static bool nfs_readdir_dont_search_cache(struct
>>> nfs_readdir_descriptor *desc)
>>> +{
>>> +       struct address_space *mapping = desc->file->f_mapping;
>>> +       struct inode *dir = file_inode(desc->file);
>>> +       unsigned int dtsize = NFS_SERVER(dir)->dtsize;
>>> +       loff_t size = i_size_read(dir);
>>> +
>>> +       /*
>>> +        * Default to uncached readdir if the page cache is empty,
>>> and
>>> +        * we're looking for a non-zero cookie in a large
>>> directory.
>>> +        */
>>> +       return desc->dir_cookie != 0 && mapping->nrpages == 0 &&
>>> size >
>>> dtsize;
>>
>> inode size > dtsize is a little hand-wavy.  We have a lot of
>> customers
>> trying to
>> reverse-engineer nfs_readdir() behavior instead of reading the code,
>> this
>> is sure to drive them crazy.
>>
>> That said, in the absence of an easy way to make it tunable, I don't
>> have
>> anything better to suggest.
>>
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
>
> Right. It is a heuristic, but I would expect that the directory size is
> going to be somewhat proportional to the number of RPC calls we need to
> perform to read it. That number again is somewhat proportional to the
> dtsize.
>
> IOW: The general idea is correct.

I can agree with that, but I have another thought:

If the point of the heuristic is to allow a full listing to eventually
complete, it should not be dependent on mapping->nrpages == 0.  Otherwise,
other processes can start filling the cache and we're back to the situation
where filling the cache could take longer than acdirmax, and things
eventually congest to a halt.

Flipping a bit on the context to remain uncached gives a better assurance we
can continue to make forward progress.

It's too bad we're stuck caching entries linearly.  What challenges might
exist if we tried to use an XArray to map directory position to cookie?  I
imagine we could implement this in a single XArray by using both position
and cookie values as indices, and differentiate between them using two of
the three XA marks, and store a structure to represent both.  Also unclear
would be how to handle the lifetime of the XArray, since we'd no longer be
using the VMs pagecache management..

/thoughts
Ben

