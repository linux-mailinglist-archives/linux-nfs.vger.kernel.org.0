Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C244C44A6
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiBYMdu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 07:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbiBYMdu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 07:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235795D5D0
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645792397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KzqsygD6RY1IUHidKX6swoGgR+yVmXeeAVehOekprE=;
        b=GYx3YH+TI5KihjJIF+oNuPe9Im3bfMOid7y07i12B1XDWA0Zl3xxVVZYxxsyzH8bW+N/TD
        Mg7cvC3n9Q49AqTMhELI6HnJYsrbFCT/0UXZ5hvdE00PhgzJdMFlASaNcn4Zo206gEgcod
        SxpRZ9lYHLmcQ+jvHbI+FSykky18RY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-SCY4dooXP2ezXDmTsq4hgw-1; Fri, 25 Feb 2022 07:33:13 -0500
X-MC-Unique: SCY4dooXP2ezXDmTsq4hgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B35A4180FD73;
        Fri, 25 Feb 2022 12:33:12 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5573A105B1E4;
        Fri, 25 Feb 2022 12:33:12 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     neilb@suse.de, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 19/21] NFS: Convert readdir page cache to use a cookie
 based index
Date:   Fri, 25 Feb 2022 07:33:11 -0500
Message-ID: <AA3FF18A-38CE-4F5A-87FE-6C235C6CD9BD@redhat.com>
In-Reply-To: <4f1a9a7b5e3ac59e365c5e40ee146ceb0f4e1429.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
 <20220223211305.296816-11-trondmy@kernel.org>
 <20220223211305.296816-12-trondmy@kernel.org>
 <20220223211305.296816-13-trondmy@kernel.org>
 <20220223211305.296816-14-trondmy@kernel.org>
 <20220223211305.296816-15-trondmy@kernel.org>
 <20220223211305.296816-16-trondmy@kernel.org>
 <20220223211305.296816-17-trondmy@kernel.org>
 <20220223211305.296816-18-trondmy@kernel.org>
 <20220223211305.296816-19-trondmy@kernel.org>
 <20220223211305.296816-20-trondmy@kernel.org>
 <EF67F180-F1D8-4291-92C8-86E5D10D1F25@redhat.com>
 <73e0a536c0467693db87c3966cf02e20ff3d889b.camel@hammerspace.com>
 <164575906990.4638.4113048743095971193@noble.neil.brown.name>
 <4f1a9a7b5e3ac59e365c5e40ee146ceb0f4e1429.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Feb 2022, at 23:25, Trond Myklebust wrote:

> On Fri, 2022-02-25 at 14:17 +1100, NeilBrown wrote:

>> I haven't looked at the code recently so this might not be 100% accurate,
>> but XArray generally assumes that pages are often adjacent.  They don't
>> have to be, but there is a cost.  It uses a multi-level array with 9 bits
>> per level.  At each level there are a whole number of pages for indexes
>> to the next level.
>>
>> If there are two entries, that are 2^45 separate, that is 5 levels of
>> indexing that cannot be shared.  So the path to one entry is 5 pages,
>> each of which contains a single pointer.  The path to the other entry is
>> a separate set of 5 pages.
>>
>> So worst case, the index would be about 64/9 or 7 times the size of the
>> data.  As the number of data pages increases, this would shrink slightly,
>> but I suspect you wouldn't get below a factor of 3 before you fill up all
>> of your memory.

Yikes!

> If the problem is just the range, then that is trivial to fix: we can
> just use xxhash32(), and take the hit of more collisions. However if
> the problem is the access pattern, then I have serious questions about
> the choice of implementation for the page cache. If the cache can't
> support file random access, then we're barking up the wrong tree on the
> wrong continent.

I'm guessing the issue might be "get next", which for an "array" is probably
the operation tested for "perform well".  We're not doing any of that, we're
directly addressing pages with our hashed index.

> Either way, I see avoiding linear searches for cookies as a benefit
> that is worth pursuing.

Me too.  What about just kicking the seekdir users up into the second half
of the index, to use xxhash32() up there.  Everyone else can hang out in the
bottom half with dense indexes and help each other out.

The vast  majority of readdir() use is going to be short listings traversed
in order.  The memory inflation created by a process that needs to walk a
tree and for every two pages of readdir data require 10 pages of indexes
seems pretty extreme.

Ben

