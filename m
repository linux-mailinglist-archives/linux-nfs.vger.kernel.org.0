Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6CB4D6116
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Mar 2022 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbiCKL7V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Mar 2022 06:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348401AbiCKL7V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Mar 2022 06:59:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 709FD2250F
        for <linux-nfs@vger.kernel.org>; Fri, 11 Mar 2022 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646999895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8mD+49DoohZzo6pu1up5pgQTWUjATz3E+QnK1iKIt14=;
        b=YEZXW+8H3whP6KQ38kjL/q9YaEnzAJnXiJfo1/t/MvqUo8/lfGCTt06W+RZB/gNQfsyd8o
        atuXxwpjuMpfjBiNL256npKjHJfFaJ+7FkiiEHhHUpwoSufqHScSdQj/kf9DzxA7DpOqKa
        H2SqzLtIOQk8IrYazg+zkvLnrfQNZbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-kvwBMe4CO5aUGnuyK-TpRw-1; Fri, 11 Mar 2022 06:58:14 -0500
X-MC-Unique: kvwBMe4CO5aUGnuyK-TpRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BAB2824FA7;
        Fri, 11 Mar 2022 11:58:13 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D08110589DE;
        Fri, 11 Mar 2022 11:58:12 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v9 23/27] NFS: Convert readdir page cache to use a cookie
 based index
Date:   Fri, 11 Mar 2022 06:58:11 -0500
Message-ID: <466F8F77-E052-4D06-A016-946FCBD9C9BF@redhat.com>
In-Reply-To: <9099fead49c961a53027c8ed309a8efd2222d679.camel@hammerspace.com>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
 <20220227231227.9038-24-trondmy@kernel.org>
 <A2AAA831-0D58-4FFB-B76C-6D6AF39607EA@redhat.com>
 <9099fead49c961a53027c8ed309a8efd2222d679.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10 Mar 2022, at 16:07, Trond Myklebust wrote:

> On Wed, 2022-03-09 at 15:01 -0500, Benjamin Coddington wrote:
>> On 27 Feb 2022, at 18:12, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> Instead of using a linear index to address the pages, use the
>>> cookie of
>>> the first entry, since that is what we use to match the page
>>> anyway.
>>>
>>> This allows us to avoid re-reading the entire cache on a seekdir()
>>> type
>>> of operation. The latter is very common when re-exporting NFS, and
>>> is a
>>> major performance drain.
>>>
>>> The change does affect our duplicate cookie detection, since we can
>>> no
>>> longer rely on the page index as a linear offset for detecting
>>> whether
>>> we looped backwards. However since we no longer do a linear search
>>> through all the pages on each call to nfs_readdir(), this is less
>>> of a
>>> concern than it was previously.
>>> The other downside is that invalidate_mapping_pages() no longer can
>>> use
>>> the page index to avoid clearing pages that have been read. A
>>> subsequent
>>> patch will restore the functionality this provides to the 'ls -l'
>>> heuristic.
>>
>> I didn't realize the approach was to also hash out the linearly-
>> cached
>> entries.  I thought we'd do something like flag the context for
>> hashed page
>> indexes after a seekdir event, and if there are collisions with the
>> linear
>> entries, they'll get fixed up when found.
>
> Why? What's the point of using 2 models where 1 will do?

I don't think the hashed model is quite as simple and efficient overall, and
may produce impacts to a system beyond NFS.

>>
>> Doesn't that mean that with this approach seekdir() only hits the
>> same pages
>> when the entry offset is page-aligned?  That's 1 in 127 odds.
>
> The point is not to stomp all over the pages that contain aligned data
> when the application does call seekdir().
>
> IOW: we always optimise for the case where we do a linear read of the
> directory, but we support random seekdir() + read too.

And that could be done just by bumping the seekdir users to some constant
offset (index 262144 ?), or something else equally dead-nuts simple.  That
keeps tightly clustered page indexes, so walking the cache is faster.  That
reduces the "buckshot" effect the hashing has of eating up pagecache pages
they'll never use again.  That doesn't cap our caching ability at 33 million
entries.

Its weird to me that we're doing exactly what XArray says not to do, hash
the index, when we don't have to.

>> It also means we're amplifying the pagecache's useage for slightly
>> changing
>> directories - rather than re-using the same pages we're scattering
>> our usage
>> across the index.  Eh, maybe not a big deal if we just expect the
>> page
>> cache's LRU to do the work.
>>
>
> I don't understand your point about 'not reusing'. If the user seeks to
> the same cookie, we reuse the page. However I don't know how you would
> go about setting up a schema that allows you to seek to an arbitrary
> cookie without doing a linear search.

So when I was taking about 'reusing' a page, that's about re-filling the
same pages rather than constantly conjuring new ones, which requires less of
the pagecache's resources in total.  Maybe the pagecache can handle that
without it negatively impacting other users of the cache that /will/ re-use
their cached pages, but I worry it might be irresponsible of us to fill the
pagecache with pages we know we're never going to find again.

Ben

