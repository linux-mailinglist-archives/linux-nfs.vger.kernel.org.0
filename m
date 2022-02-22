Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD14C02F7
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Feb 2022 21:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiBVUWB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Feb 2022 15:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVUWA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Feb 2022 15:22:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 560FBB87A
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 12:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645561292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhAjhEO1wLK7ChbXALwYGC+yKCzII8fn6OqWqVWBE9Q=;
        b=OGq7Di8Xa29jY0hXzede5MWW+OSNPgwyCI42SVNYCTf3UGud4tQL2EtRsCaqHf1yO/DpK3
        KKMWcx9PQJYpuqBZzKm0h6zcoJb4QqwVlqhZdMO1pbiF8FLAsWNMifYzzh2PVFcgWQvRKo
        1aX0NR0OvONwS1+CR6MacCIeKmHooBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-YGFLA5S2ON62kZBY6oBLoA-1; Tue, 22 Feb 2022 15:21:31 -0500
X-MC-Unique: YGFLA5S2ON62kZBY6oBLoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75BA1854E27;
        Tue, 22 Feb 2022 20:21:29 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 715D55DD6E;
        Tue, 22 Feb 2022 20:21:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 05/13] NFS: Improve algorithm for falling back to
 uncached readdir
Date:   Tue, 22 Feb 2022 15:21:28 -0500
Message-ID: <1C8B1E6A-F4B2-4ED0-8DF1-5E33E07924C5@redhat.com>
In-Reply-To: <4f1963e80028d6c162512465cee403c10fa2ab77.camel@hammerspace.com>
References: <20220221160851.15508-1-trondmy@kernel.org>
 <20220221160851.15508-2-trondmy@kernel.org>
 <20220221160851.15508-3-trondmy@kernel.org>
 <20220221160851.15508-4-trondmy@kernel.org>
 <20220221160851.15508-5-trondmy@kernel.org>
 <20220221160851.15508-6-trondmy@kernel.org>
 <BCE9A6AB-EAA5-477E-BFE7-529AEC443E6A@redhat.com>
 <e01f0373409aaf09dbaf59f3aa7deb421af68980.camel@hammerspace.com>
 <5B222AF7-98A7-428B-81B2-1A1D3FFAD944@redhat.com>
 <b097f18981260e9a2d75f654a5c4f229391bb8bb.camel@hammerspace.com>
 <9DBD587E-C4CA-4674-B47D-92396EEEA082@redhat.com>
 <79a2c935bd5b9044c216c90ebfac3dc2e8e6b888.camel@hammerspace.com>
 <17D70218-EECB-456B-9BCA-E7FC128A4864@redhat.com>
 <4f1963e80028d6c162512465cee403c10fa2ab77.camel@hammerspace.com>
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

On 22 Feb 2022, at 15:11, Trond Myklebust wrote:

> On Tue, 2022-02-22 at 07:50 -0500, Benjamin Coddington wrote:
>> On 21 Feb 2022, at 18:20, Trond Myklebust wrote:
>>
>>> On Mon, 2022-02-21 at 16:10 -0500, Benjamin Coddington wrote:
>>>> On 21 Feb 2022, at 15:55, Trond Myklebust wrote:
>>>>>
>>>>> We will always need the ability to cut over to uncached
>>>>> readdir.
>>>>
>>>> Yes.
>>>>
>>>>> If the cookie is no longer returned by the server because one
>>>>> or more
>>>>> files were deleted then we need to resolve the situation
>>>>> somehow (IOW:
>>>>> the 'rm *' case). The new algorithm _does_ improve performance
>>>>> on those
>>>>> situations, because it no longer requires us to read the entire
>>>>> directory before switching over: we try 5 times, then fail
>>>>> over.
>>>>
>>>> Yes, using per-page validation doesn't remove the need for
>>>> uncached
>>>> readdir.  It does allow a reader to simply resume filling the
>>>> cache where
>>>> it left off.  There's no need to try 5 times and fail over.  And
>>>> there's
>>>> no need to make a trade-off and make the situation worse in
>>>> certain
>>>> scenarios.
>>>>
>>>> I thought I'd point that out and make an offer to re-submit it. 
>>>> Any
>>>> interest?
>>>>
>>>
>>> As I recall, I had concerns about that approach. Can you explain
>>> again
>>> how it will work?
>>
>> Every page of readdir results has the directory's change attr stored
>> on the
>> page.  That, along with the page's index and the first cookie is
>> enough
>> information to determine if the page's data can be used by another
>> process.
>>
>> Which means that when the pagecache is dropped, fillers don't have to
>> restart
>> filling the cache at page index 0, they can continue to fill at
>> whatever
>> index they were at previously.  If another process finds a page that
>> doesn't
>> match its page index, cookie, and the current directory's change
>> attr, the
>> page is dropped and refilled from that process' indexing.
>>
>>> A few of the concerns I have revolve around telldir()/seekdir(). If
>>> the
>>> platform is 32-bit, then we cannot use cookies as the telldir()
>>> output,
>>> and so our only option is to use offsets into the page cache (this
>>> is
>>> why this patch carves out an exception if desc->dir_cookie == 0).
>>> How
>>> would that work with you scheme?
>>
>> For 32-bit seekdir, pages are filled starting at index 0.  This is
>> very
>> unlikely to match other readers (unless they also do the _same_
>> seekdir).
>>
>>> Even in the 64-bit case where are able to use cookies for
>>> telldir()/seekdir(), how do we determine an appropriate page index
>>> after a seekdir()?
>>
>> We don't.  Instead we start filling at index 0.  Again, the pagecache
>> will
>> only be useful to other processes that have done the same llseek.
>>
>> This approach optimizes the pagecache for processes that are doing
>> similar
>> work, and has the added benefit of scaling well for large directory
>> listings
>> under memory pressure.  Also a number of classes of directory
>> modifications
>> (such as renames, or insertions/deletions at locations a reader has
>> moved
>> beyond) are no longer a reason to re-fill the pagecache from scratch.
>>
>
> OK, you've got me more or less sold on it.
>
> I'd still like to figure out how to improve the performance for seekdir
> (since I do have an interest in re-exporting NFS) but I've been playing
> around with a couple of patches that implement your concept and they do
> seem to work well for the common case of a linear read through the
> directory.

Nice.  I have another version from the one I originally posted:
https://lore.kernel.org/linux-nfs/cover.1611160120.git.bcodding@redhat.com/

.. but I don't remember exactly the changes and it needs rebasing.  Should I
rebase it against your testing branch and send the result?

Ben

