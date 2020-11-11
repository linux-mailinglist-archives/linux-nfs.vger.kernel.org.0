Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF32AF94F
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKKTxa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Nov 2020 14:53:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgKKTxa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Nov 2020 14:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605124407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cv7Oy6A/hm6Xsurk75laZlqCEJBunCxyOhRxshXm8A4=;
        b=OlAwmssGKLNMqQmo5DM8C44MZ/fq+EAtoDfM+EPMDPjSDH2umfWgFMXselYkDpPO/vIAhW
        bfCCczeAnzjcpDFQBROi9lLVvWz8I6VW2LzIprV7h6qQGyFieS/1Mbryam+0FRxeDtEslW
        IdvfF9E1woMsB1KQz19oJFFy/EqAIxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-DGq0vl2KNWa4AjLGyFV3Xw-1; Wed, 11 Nov 2020 14:53:25 -0500
X-MC-Unique: DGq0vl2KNWa4AjLGyFV3Xw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7BE188C126;
        Wed, 11 Nov 2020 19:53:24 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74E0C19C66;
        Wed, 11 Nov 2020 19:53:24 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Date:   Wed, 11 Nov 2020 14:53:23 -0500
Message-ID: <80F65B51-35C0-4849-A3EB-691CDD8F4B0A@redhat.com>
In-Reply-To: <4e92cc94e4b10b42aee30e198c6474c72564cbaa.camel@hammerspace.com>
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
 <6D043238-4C98-41B9-A890-B0897E7EFDBA@redhat.com>
 <4e92cc94e4b10b42aee30e198c6474c72564cbaa.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11 Nov 2020, at 12:34, Trond Myklebust wrote:

> On Wed, 2020-11-11 at 11:43 -0500, Benjamin Coddington wrote:
>> On 9 Nov 2020, at 16:46, Trond Myklebust wrote:
>>
>>> On Mon, 2020-11-09 at 16:41 -0500, Benjamin Coddington wrote:
>>>> On 7 Nov 2020, at 9:03, trondmy@kernel.org wrote:
>>>>
>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>
>>>>> If the directory is changing, causing the page cache to get
>>>>> invalidated
>>>>> while we are listing the contents, then the NFS client is
>>>>> currently
>>>>> forced
>>>>> to read in the entire directory contents from scratch, because
>>>>> it
>>>>> needs
>>>>> to perform a linear search for the readdir cookie. While this
>>>>> is
>>>>> not
>>>>> an issue for small directories, it does not scale to
>>>>> directories
>>>>> with
>>>>> millions of entries.
>>>>> In order to be able to deal with large directories that are
>>>>> changing,
>>>>> add a heuristic to ensure that if the page cache is empty, and
>>>>> we
>>>>> are
>>>>> searching for a cookie that is not the zero cookie, we just
>>>>> default
>>>>> to
>>>>> performing uncached readdir.
>>>>>
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>>  fs/nfs/dir.c | 17 +++++++++++++++++
>>>>>  1 file changed, 17 insertions(+)
>>>>>
>>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>>> index 238872d116f7..d7a9efd31ecd 100644
>>>>> --- a/fs/nfs/dir.c
>>>>> +++ b/fs/nfs/dir.c
>>>>> @@ -917,11 +917,28 @@ static int
>>>>> find_and_lock_cache_page(struct
>>>>> nfs_readdir_descriptor *desc)
>>>>>         return res;
>>>>>  }
>>>>>
>>>>> +static bool nfs_readdir_dont_search_cache(struct
>>>>> nfs_readdir_descriptor *desc)
>>>>> +{
>>>>> +       struct address_space *mapping = desc->file->f_mapping;
>>>>> +       struct inode *dir = file_inode(desc->file);
>>>>> +       unsigned int dtsize = NFS_SERVER(dir)->dtsize;
>>>>> +       loff_t size = i_size_read(dir);
>>>>> +
>>>>> +       /*
>>>>> +        * Default to uncached readdir if the page cache is
>>>>> empty,
>>>>> and
>>>>> +        * we're looking for a non-zero cookie in a large
>>>>> directory.
>>>>> +        */
>>>>> +       return desc->dir_cookie != 0 && mapping->nrpages == 0
>>>>> &&
>>>>> size >
>>>>> dtsize;
>>>>
>>>> inode size > dtsize is a little hand-wavy.  We have a lot of
>>>> customers
>>>> trying to
>>>> reverse-engineer nfs_readdir() behavior instead of reading the
>>>> code,
>>>> this
>>>> is sure to drive them crazy.
>>>>
>>>> That said, in the absence of an easy way to make it tunable, I
>>>> don't
>>>> have
>>>> anything better to suggest.
>>>>
>>>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>>>
>>>
>>> Right. It is a heuristic, but I would expect that the directory
>>> size is
>>> going to be somewhat proportional to the number of RPC calls we
>>> need to
>>> perform to read it. That number again is somewhat proportional to
>>> the
>>> dtsize.
>>>
>>> IOW: The general idea is correct.
>>
>> I can agree with that, but I have another thought:
>>
>> If the point of the heuristic is to allow a full listing to
>> eventually
>> complete, it should not be dependent on mapping->nrpages == 0. 
>> Otherwise,
>> other processes can start filling the cache and we're back to the
>> situation
>> where filling the cache could take longer than acdirmax, and things
>> eventually congest to a halt.
>>
>> Flipping a bit on the context to remain uncached gives a better
>> assurance we
>> can continue to make forward progress.
>
> I disagree. The point of the page cache is to allow sharing of
> information between processes where possible. If there are multiple
> processes all trying to make progress, and one of them starts filling
> the page cache from scratch, then why should we not use that?

Because the process that starts filling the pagecache from scratch then
enjoins the process that may be nearly finished listing the directory to
start over waiting for the page cache to be filled (or help fill it).

If the time taken to get to a certain offset/cookie exceeds the time to
cache the directory's attributes, we'll drop the pagecache, or if we're
perhaps using READDIRPLUS with many entries, we'll saturate the memory on
the machine and start to reclaim it before we can ever finish.  There are
scenarios where forward progress becomes very slow.

Perhaps the onus is on me to whip up an example - I will do that.

> The alternative is not scaling to multiple processes.

The next process that comes along filling the pagecache will benefit the
next processes, and so on, until a page is evicted or the cache is lost..
etc.  The pagecache is still useful to multiple processes.

>> It's too bad we're stuck caching entries linearly.  What challenges
>> might
>> exist if we tried to use an XArray to map directory position to
>> cookie?  I
>> imagine we could implement this in a single XArray by using both
>> position
>> and cookie values as indices, and differentiate between them using
>> two of
>> the three XA marks, and store a structure to represent both.  Also
>> unclear
>> would be how to handle the lifetime of the XArray, since we'd no
>> longer be
>> using the VMs pagecache management..
>>
>
> You might be able to speed up first cookie lookup by having an Xarray
> that maps from a 64-bit cookie to a nfs_cache_array_entry which
> contains the next cookie to look up. However that would only work on
> 64-bit systems since xarrays take an unsigned long index.

Yes, but I would like to allow processes to cache entries non-linearly.

> Furthermore, you still need a way to map offsets to entries for the
> case where we're not able to use cookies for lseek() purposes. That's a
> linear search through the directory, which would be horrible with an
> xarray of linked cookie values (so you'd probably need a second xarray
> for that?).

There's xa_for_each_marked(), but it may not perform - I haven't looked
at the implementation or tested it.

> Construction and teardown of that structure would be nasty for large
> directories, since you have as many cookies as you have entries in your
> directory. IOW: You'd have to tear down 127 times as many xarray
> entries as we have now.
>
> It is not obvious that we would be able to benefit from starting at an
> arbitrary location and caching that data, since if the directory
> changed, we'd have to read in the new data anyway.

The only case where it seems obvious is for the case where a very long
listing is about to complete, and then the pagecache is invalidated, and
then that plays out over and over again.  This is the pain point for our
customers that are migrating NFS workloads onto slower (more latent)
cloud infrastructure.

> Memory management would need to be implemented somehow. You'd need a
> shrinker for this tree that could intelligently prune it.

nod.. thanks for your thoughts on this.

Ben

